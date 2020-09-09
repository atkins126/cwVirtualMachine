{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be
     used to endorse or promote products derived from this software without specific prior
     written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
  IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
{$endif}
unit cwThreading.ThreadSystem.Standard;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch nestedprocvars}
{$endif}

interface
uses
  cwCollections
, cwThreading
, cwThreading.Internal
;

type
  TTaskArray = array of ITask;

type
  TThreadSystem = class( TInterfacedObject, IThreadingSystem )
  private
    fTaskPool: ITaskPool;
    fMainThreadSleepCS: ISignaledCriticalSection;
    fLongPool: IList<ILongThreadMatcher>;
    fLongPoolCS: ICriticalSection;
    fMessagedPool: IDictionary<string,IMessagedThreadHandler>;
    fMessagedPoolCS: ICriticalSection;
  private
    procedure TerminateLongThreads;
    procedure TerminateMessagedThreads;
  private
    {$ifndef fpc}
    function DivideWorkload(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecute): TTaskArray;
    {$endif}
    {$ifdef fpc}
    function DivideWorkloadGlobal(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal): TTaskArray;
    function DivideWorkloadOfObject(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject): TTaskArray;
    function DivideWorkloadNested(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested): TTaskArray;
    {$endif}
  strict private //- IThreadingSystem (Task Execution) -//
    {$ifndef fpc}
    procedure Execute( const Tasks: array of ITask; const WhenDone: TOnComplete ); overload;
    {$endif}
    {$ifdef fpc}
    procedure Execute( const Tasks: array of ITask; const WhenDone: TOnCompleteGlobal ); overload;
    procedure Execute( const Tasks: array of ITask; const WhenDone: TOnCompleteOfObject ); overload;
    procedure Execute( const Tasks: array of ITask; const WhenDone: TOnCompleteNested ); overload;
    {$endif}
    procedure Execute( const Tasks: array of ITask; const WaitFor: boolean = False ); overload;

  strict private //- IThreadingSystem (For Loop Execution) -//
    {$ifndef fpc}
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecute; const WhenDone: TOnComplete ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecute; const WaitFor: boolean = False ); overload;
    {$endif}
    {$ifdef fpc}
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WaitFor: boolean = False ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WaitFor: boolean = False ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WaitFor: boolean = False ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteGlobal ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteGlobal ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteGlobal ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteOfObject ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteOfObject ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteOfObject ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteNested ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteNested ); overload;
    procedure Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteNested ); overload;
    {$endif}

  strict private //- IThreadingSystem (LongThread execution) -//
    procedure Execute( const Threads: array of ILongThread ); overload;

  strict private //- IThreadingSystem (MessagedThread execution) -//
    procedure Execute( const ThreadName: string; const MessagedThread: IMessagedThread ); overload;
    function getMessageChannel( const ThreadName: string ): IMessageChannel;

  strict private //- IThreadingSystem (Remaining) -//
    procedure Remove( const Thread: ILongThread ); overload;
    procedure Remove( const ThreadName: string ); overload;
    procedure Remove( const MessagedThread: IMessagedThread ); overload;

  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwStatus
, cwCollections.Standard
, cwThreading.Internal.TaskPool.Standard
, cwThreading.Internal.ForLoopTask.Standard
, cwThreading.Internal.Thread.LongThread
, cwThreading.Internal.Thread.MessagedThread
{$ifndef fpc}
, SysUtils // for CPUCount
{$endif}
{$ifdef MSWINDOWS}
, cwWin32.Kernel32
, cwThreading.CriticalSection.Windows
, cwThreading.SignaledCriticalSection.Windows
{$else}
, BaseUnix
, cwThreading.CriticalSection.Posix
, cwThreading.SignaledCriticalSection.Posix
{$endif}
;

{$region ' Task Execution'}

{$ifndef fpc}
procedure TThreadSystem.Execute(const Tasks: array of ITask; const WhenDone: TOnComplete );
begin
  if Length(Tasks)=0 then exit;
  fTaskPool.AddTaskSet(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const Tasks: array of ITask; const WhenDone: TOnCompleteGlobal );
begin
  if Length(Tasks)=0 then exit;
  fTaskPool.AddTaskSet(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const Tasks: array of ITask; const WhenDone: TOnCompleteOfObject );
begin
  if Length(Tasks)=0 then exit;
  fTaskPool.AddTaskSet(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const Tasks: array of ITask; const WhenDone: TOnCompleteNested );
begin
  if Length(Tasks)=0 then exit;
  fTaskPool.AddTaskSet(Tasks,WhenDone);
end;
{$endif}

procedure TThreadSystem.Execute(const Tasks: array of ITask; const WaitFor: boolean = FALSE);
var
  Complete: boolean;

  {$ifdef fpc}
  procedure DoOnComplete;
  begin
    Complete := True;
    fMainThreadSleepCS.Wake;
  end;
  {$endif}

begin
  if Length(Tasks)=0 then exit;
  Complete := False;

  {$ifdef fpc}
  fTaskPool.AddTaskSet(Tasks,doOnComplete);
  {$else}
  fTaskPool.AddTaskSet(Tasks,
    procedure()
    begin
      Complete := True;
      fMainThreadSleepCS.Wake;
    end
  );
  {$endif}

  if WaitFor then begin
    fMainThreadSleepCS.Acquire;
    try
      repeat
        if Complete then exit;
        fMainThreadSleepCS.Sleep;
      until False;
    finally
      fMainThreadSleepCS.Release;
    end;
  end;
end;

{$endregion}

{$region ' For loop execution'}

{$ifndef fpc}
function TThreadSystem.DivideWorkload(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecute): TTaskArray;
var
  idx: nativeuint;
  ThreadCount: nativeuint;
  Partitions: nativeuint;
  Remainder: nativeuint;
begin
  ThreadCount := fTaskPool.getThreadCount;
  if TotalWorkItems<ThreadCount then begin
    {$warnings off} SetLength(Result,TotalWorkItems); {$warnings on}
    for idx := 0 to pred(TotalWorkItems) do begin
      Result[idx] := TForLoopTask.Create( idx, idx, OnExecuteAction );
    end;
  end else begin
    Partitions := TotalWorkItems div ThreadCount;
    Remainder := TotalWorkItems - (Partitions*ThreadCount);
    {$warnings off} SetLength(Result,Partitions+Remainder); {$warnings on}
    for idx := 0 to pred(Partitions) do begin
      Result[idx] := TForLoopTask.Create( (idx*ThreadCount), pred((succ(idx)*ThreadCount)), OnExecuteAction );
    end;
    for idx := 0 to pred(Remainder) do begin
      Result[ Partitions + idx ] := TForLoopTask.Create( ((Partitions*ThreadCount)+Idx), ((Partitions*ThreadCount)+Idx), OnExecuteAction );
    end;
  end;
end;
{$endif}

{$ifdef fpc}
function TThreadSystem.DivideWorkloadGlobal(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal): TTaskArray;
var
  idx: nativeuint;
  ThreadCount: nativeuint;
  Partitions: nativeuint;
  Remainder: nativeuint;
begin
  ThreadCount := fTaskPool.getThreadCount;
  if TotalWorkItems<ThreadCount then begin
    {$warnings off} SetLength(Result,TotalWorkItems); {$warnings on}
    for idx := 0 to pred(TotalWorkItems) do begin
      Result[idx] := TForLoopTask.Create( idx, idx, OnExecuteAction );
    end;
  end else begin
    Partitions := TotalWorkItems div ThreadCount;
    Remainder := TotalWorkItems - (Partitions*ThreadCount);
    {$warnings off} SetLength(Result,Partitions+Remainder); {$warnings on}
    for idx := 0 to pred(Partitions) do begin
      Result[idx] := TForLoopTask.Create( (idx*ThreadCount), pred((succ(idx)*ThreadCount)), OnExecuteAction );
    end;
    for idx := 0 to pred(Remainder) do begin
      Result[ Partitions + idx ] := TForLoopTask.Create( ((Partitions*ThreadCount)+Idx), ((Partitions*ThreadCount)+Idx), OnExecuteAction );
    end;
  end;
end;
{$endif}

{$ifdef fpc}
function TThreadSystem.DivideWorkloadOfObject(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject): TTaskArray;
var
  idx: nativeuint;
  ThreadCount: nativeuint;
  Partitions: nativeuint;
  Remainder: nativeuint;
begin
  ThreadCount := fTaskPool.getThreadCount;
  if TotalWorkItems<ThreadCount then begin
    {$warnings off} SetLength(Result,TotalWorkItems); {$warnings on}
    for idx := 0 to pred(TotalWorkItems) do begin
      Result[idx] := TForLoopTask.Create( idx, idx, OnExecuteAction );
    end;
  end else begin
    Partitions := TotalWorkItems div ThreadCount;
    Remainder := TotalWorkItems - (Partitions*ThreadCount);
    {$warnings off} SetLength(Result,Partitions+Remainder); {$warnings on}
    for idx := 0 to pred(Partitions) do begin
      Result[idx] := TForLoopTask.Create( (idx*ThreadCount), pred((succ(idx)*ThreadCount)), OnExecuteAction );
    end;
    for idx := 0 to pred(Remainder) do begin
      Result[ Partitions + idx ] := TForLoopTask.Create( ((Partitions*ThreadCount)+Idx), ((Partitions*ThreadCount)+Idx), OnExecuteAction );
    end;
  end;
end;
{$endif}

{$ifdef fpc}
function TThreadSystem.DivideWorkloadNested(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested): TTaskArray;
var
  idx: nativeuint;
  ThreadCount: nativeuint;
  Partitions: nativeuint;
  Remainder: nativeuint;
begin
  ThreadCount := fTaskPool.getThreadCount;
  if TotalWorkItems<ThreadCount then begin
    {$warnings off} SetLength(Result,TotalWorkItems); {$warnings on}
    for idx := 0 to pred(TotalWorkItems) do begin
      Result[idx] := TForLoopTask.Create( idx, idx, OnExecuteAction );
    end;
  end else begin
    Partitions := TotalWorkItems div ThreadCount;
    Remainder := TotalWorkItems - (Partitions*ThreadCount);
    {$warnings off} SetLength(Result,Partitions+Remainder); {$warnings on}
    for idx := 0 to pred(Partitions) do begin
      Result[idx] := TForLoopTask.Create( (idx*ThreadCount), pred((succ(idx)*ThreadCount)), OnExecuteAction );
    end;
    for idx := 0 to pred(Remainder) do begin
      Result[ Partitions + idx ] := TForLoopTask.Create( ((Partitions*ThreadCount)+Idx), ((Partitions*ThreadCount)+Idx), OnExecuteAction );
    end;
  end;
end;
{$endif}

{$ifndef fpc}
procedure TThreadSystem.Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecute; const WhenDone: TOnComplete );
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkload(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifndef fpc}
procedure TThreadSystem.Execute( const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecute; const WaitFor: boolean = False );
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    exit;
  end;
  Tasks := DivideWorkload(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WaitFor);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WaitFor: boolean);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    exit;
  end;
  Tasks := DivideWorkloadGlobal(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WaitFor);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WaitFor: boolean);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    exit;
  end;
  Tasks := DivideWorkloadOfObject(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WaitFor);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WaitFor: boolean);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    exit;
  end;
  Tasks := DivideWorkloadNested(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WaitFor);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteGlobal);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadGlobal(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteGlobal);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadOfObject(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteGlobal);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadNested(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteOfObject);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadGlobal(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteOfObject);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadOfObject(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteOfObject);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadNested(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteGlobal; const WhenDone: TOnCompleteNested);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadGlobal(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteOfObject; const WhenDone: TOnCompleteNested);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadOfObject(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$ifdef fpc}
procedure TThreadSystem.Execute(const TotalWorkItems: nativeuint; const OnExecuteAction: TOnExecuteNested; const WhenDone: TOnCompleteNested);
var
  Tasks: TTaskArray;
begin
  if TotalWorkItems=0 then begin
    if assigned(WhenDone) then WhenDone();
    exit;
  end;
  Tasks := DivideWorkloadNested(TotalWorkItems,OnExecuteAction);
  Execute(Tasks,WhenDone);
end;
{$endif}

{$endregion}

{$region ' Long thread execution '}

procedure TThreadSystem.Execute(const Threads: array of ILongThread);
var
  NewThread: ILongThreadMatcher;
  idx: nativeuint;

  procedure RemoveDeadThreads;
  var
    idx: nativeuint;
  begin
    if fLongPool.Count = 0 then exit;
    for idx := pred(fLongPool.Count) downto 0 do begin
      if not fLongPool[idx].IsRunning then begin
        fLongPool.RemoveItem(idx);
      end;
    end;
  end;

begin
  fLongPoolCS.Acquire;
  try
    RemoveDeadThreads;
    for idx := 0 to pred(Length(Threads)) do begin
      NewThread := TLongThread.Create( Threads[idx] );
      fLongPool.Add(NewThread);
    end;
  finally
    fLongPoolCS.Release;
  end;
end;

procedure TThreadSystem.TerminateLongThreads;
const
  cShutdownTimeoutMS = 200;
var
  idx: nativeuint;
  ShutdownMSRemaining: nativeuint;
begin
  fLongPoolCS.Acquire;
  try
    if fLongPool.Count = 0 then exit;
    for idx := 0 to pred(fLongPool.Count) do begin
      if not fLongPool[idx].IsRunning then continue;
      fLongPool[idx].setTerminateFlag(TRUE);
      ShutdownMSRemaining := cShutdownTimeoutMS;
      while (fLongPool[idx].IsRunning) and (ShutdownMSRemaining>0) do begin
        {$ifdef MSWINDOWS}
        Sleep(1);
        {$else}
        fpSleep(1);
        {$endif}
        dec(ShutdownMSRemaining);
      end;
      if (fLongPool[idx].IsRunning) then begin
        TStatus(stThreadTerminteFailed).Raize;
      end;
    end;
  finally
    fLongPoolCS.Release;
  end;
end;
{$endregion}

{$region ' Message thread execution '}

procedure TThreadSystem.Execute(const ThreadName: string; const MessagedThread: IMessagedThread);
begin
  fMessagedPoolCS.Acquire;
  try
    if fMessagedPool.KeyExists[ThreadName] then begin
      TStatus(stMessagedThreadUniqueName).Raize([ThreadName]);
    end;
    fMessagedPool[ThreadName] := TMessagedThread.Create( MessagedThread, TSignaledCriticalSection.Create );
  finally
    fMessagedPoolCS.Release;
  end;
end;

function TThreadSystem.getMessageChannel(const ThreadName: string): IMessageChannel;
begin
  Result := nil;
  fMessagedPoolCS.Acquire;
  try
    Result := fMessagedPool[ThreadName].getMessageChannel;
  finally
    fMessagedPoolCS.Release;
  end;
end;

procedure TThreadSystem.TerminateMessagedThreads;
const
  cShutdownTimeoutMS = 200;
var
  idx: nativeuint;
  ShutdownMSRemaining: nativeuint;
  Handler: IMessagedThreadHandler;
begin
  if fMessagedPool.Count = 0 then exit;
  fMessagedPoolCS.Acquire;
  try
    for idx := 0 to pred(fMessagedPool.Count) do begin
      Handler := fMessagedPool.GetValueByIndex(idx);
      if not assigned(Handler) then continue;
      if not Handler.IsRunning then continue;
      Handler.setTerminateFlag(TRUE);
      Handler.Wake;
      ShutdownMSRemaining := cShutdownTimeoutMS;
      while (Handler.IsRunning) and (ShutdownMSRemaining>0) do begin
        {$ifdef MSWINDOWS}
        Sleep(1);
        {$else}
        fpSleep(1);
        {$endif}
        dec(ShutdownMSRemaining);
        Handler.Wake;
      end;
      if (Handler.IsRunning) then begin
        TStatus(stThreadTerminteFailed).Raize;
      end;
    end;
  finally
    fMessagedPoolCS.Release;
  end;
end;

{$endregion}

procedure TThreadSystem.Remove(const MessagedThread: IMessagedThread);
var
  idx: nativeuint;
begin
  fMessagedPoolCS.Acquire;
  try
    for idx := pred(fMessagedPool.Count) downto 0 do begin
      if fMessagedPool.GetValueByIndex(idx).IsMatch(MessagedThread) then begin
        fMessagedPool.removeByIndex(idx);
      end;
    end;
  finally
    fMessagedPoolCS.Release;
  end;
end;

procedure TThreadSystem.Remove(const ThreadName: string);
var
  MessagedThread: IMessagedThread;
begin
  fMessagedPoolCS.Acquire;
  try
    MessagedThread := fMessagedPool[ThreadName].getMessagedThread;
  finally
    fMessagedPoolCS.Release;
  end;
  if assigned(MessagedThread) then begin
    Remove(MessagedThread);
  end;
end;

procedure TThreadSystem.Remove( const Thread: ILongThread );
var
  idx: nativeuint;
begin
  fLongPoolCS.Acquire;
  try
    for idx := pred(fLongPool.Count) downto 0 do begin
      if fLongPool[idx].IsMatch(Thread) then begin
        fLongPool.RemoveItem(idx);
      end;
    end;
  finally
    fLongPoolCS.Release;
  end;
end;

constructor TThreadSystem.Create;
begin
  inherited Create;
  fMainThreadSleepCS := TSignaledCriticalSection.Create;
  {$ifndef fpc}
  fTaskPool := TTaskPool.Create( CPUCount * 2 );
  {$else}
  fTaskPool := TTaskPool.Create( GetCPUCount * 2 );
  {$endif}
  fLongPoolCS := TCriticalSection.Create;
  fLongPool := TList<ILongThreadMatcher>.Create;
  fMessagedPool := TDictionary<string,IMessagedThreadHandler>.Create({$ifdef fpc}@{$endif}TCompare.CompareStrings);
  fMessagedPoolCS := TCriticalSection.Create;
end;

destructor TThreadSystem.Destroy;
begin
  TerminateLongThreads;
  TerminateMessagedThreads;
  fTaskPool := nil;
  fMainThreadSleepCS := nil;
  fLongPool := nil;
  fLongPoolCS := nil;
  fMessagedPool := nil;
  fMessagedPoolCS := nil;
  inherited Destroy;
end;

end.

