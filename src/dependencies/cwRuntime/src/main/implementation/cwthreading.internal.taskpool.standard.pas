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
unit cwThreading.Internal.TaskPool.Standard;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch nestedprocvars}
{$endif}

interface
uses
  cwThreading
, cwThreading.Internal
;

type
  TTaskPool = class( TInterfacedObject, ITaskPool )
  private
    fThreadPool: IThreadPool;
    fTaskSets: ITaskSetCollection;
  protected
    procedure ThreadHandler( const Thread: IThread );
  strict private //- IThreadPool -//
    {$ifndef fpc}
    procedure AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnComplete ); overload;
    {$else}
    procedure AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteGlobal ); overload;
    procedure AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteOfObject ); overload;
    procedure AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteNested ); overload;
    {$endif}
    function getThreadCount: nativeuint;
    procedure AddTaskSet( const Tasks: array of ITask ); overload;
  public
    constructor Create( const ThreadCount: nativeuint ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwThreading.Internal.TaskSet.Standard
, cwThreading.Internal.TaskSetCollection.Standard
, cwThreading.Internal.ThreadPool.Standard
;

procedure TTaskPool.ThreadHandler( const Thread: IThread );
var
  Task: ITaskRecord;
begin
  Task := nil;
  repeat
    Thread.Acquire;
    try
      Task := fTaskSets.getNextTask;
      if not assigned(Task) then begin
        Thread.Sleep;
      end;
      if Thread.TerminateFlag then exit;
    finally
      Thread.Release;
    end;
    Thread.Wake;
    if assigned(Task) then begin
      Task.Execute;
    end;
  until False;
end;

{$ifndef fpc}
procedure TTaskPool.AddTaskSet(const Tasks: array of ITask; const WhenDone: TOnComplete);
begin
  fTasksets.AddTaskSet( TTaskSet.Create( Tasks, WhenDone) );
  fThreadPool.Wake;
end;
{$endif}

{$ifdef fpc}
procedure TTaskPool.AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteGlobal ); overload;
begin
  fTasksets.AddTaskSet( TTaskSet.Create( Tasks, WhenDone ) );
  fThreadPool.Wake;
end;
{$endif}

{$ifdef fpc}
procedure TTaskPool.AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteOfObject ); overload;
begin
  fTasksets.AddTaskSet( TTaskSet.Create( Tasks, WhenDone) );
  fThreadPool.Wake;
end;
{$endif}

{$ifdef fpc}
procedure TTaskPool.AddTaskSet( const Tasks: array of ITask; const WhenDone: TOnCompleteNested ); overload;
begin
  fTasksets.AddTaskSet( TTaskSet.Create( Tasks, WhenDone ) );
  fThreadPool.Wake;
end;
{$endif}

function TTaskPool.getThreadCount: nativeuint;
begin
  Result := fThreadPool.getThreadCount;
end;

procedure TTaskPool.AddTaskSet( const Tasks: array of ITask );
begin
  fTasksets.AddTaskSet( TTaskSet.Create( Tasks ) );
  fThreadPool.Wake;
end;

constructor TTaskPool.Create( const ThreadCount: nativeuint );
begin
  inherited Create;
  fTaskSets := TTaskSetCollection.Create;
  fThreadPool := TThreadPool.Create;
  fThreadPool.AddThreads( ThreadCount, ThreadHandler );
end;

destructor TTaskPool.Destroy;
begin
  fThreadPool.Terminate;
  fThreadPool := nil;
  fTaskSets := nil;
  inherited Destroy;
end;

end.

