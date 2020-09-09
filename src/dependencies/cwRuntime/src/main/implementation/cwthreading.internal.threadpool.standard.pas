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
unit cwThreading.Internal.ThreadPool.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwCollections
, cwThreading
, cwThreading.Internal
;

type
  TThreadPool = class( TInterfacedObject, IThreadPool )
  private
    fThreads: IList<IThread>;
    fThreadCS: ICriticalSection;
    fSleepCS: ISignaledCriticalSection;
  strict private //- IThreadPool -//
    procedure AddThreads( const Count: nativeuint; const ThreadExecuteMethod: TThreadExecuteMethod );
    procedure Terminate;
    procedure SpreadThreadAffinity;
    procedure ClearThreadAffinity;
    procedure Wake;
    function getThreadCount: nativeuint;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwStatus
, cwCollections.Standard
{$ifdef MSWINDOWS}
, cwWin32.Kernel32
, cwThreading.CriticalSection.Windows
, cwThreading.SignaledCriticalSection.Windows
, cwThreading.Internal.Thread.Windows
{$else}
, BaseUnix
, cwThreading.CriticalSection.Posix
, cwThreading.SignaledCriticalSection.Posix
, cwThreading.Internal.Thread.Posix
{$endif}
;

procedure TThreadPool.AddThreads(const Count: nativeuint; const ThreadExecuteMethod: TThreadExecuteMethod);
const
  cStartupTimeoutMS = 200;
var
  idx: nativeuint;
  StartupMSRemaining: nativeuint;
  NewThread: IThread;
begin
  if count=0 then exit;
  fThreadCS.Acquire;
  try
    for idx := 0 to pred(Count) do begin
      NewThread := TThread.Create(ThreadExecuteMethod, fSleepCS);
      //- Test that the thread starts.
      StartupMSRemaining := cStartupTimeoutMS;
      while (not NewThread.IsRunning) and (StartupMSRemaining>0) do begin
        {$ifdef MSWINDOWS}
        Sleep(1);
        {$else}
        fpSleep(1);
        {$endif}
        dec(StartupMSRemaining);
      end;
      if not NewThread.IsRunning then begin
        TStatus(stThreadStartupFailed).Raize;
      end;
      fThreads.Add( NewThread );
    end;
  finally
    fThreadCS.Release;
  end;
end;

procedure TThreadPool.Terminate;
const
  cShutdownTimeoutMS = 200;
var
  idx: nativeuint;
  ShutdownMSRemaining: nativeuint;
begin
  if not assigned(fThreads) then exit;
  if fThreads.Count=0 then exit;
  ShutdownMSRemaining := cShutdownTimeoutMS;
  for idx := 0 to pred(fThreads.Count) do begin
    fThreads[idx].setTerminateFlag(TRUE);
    if assigned(fSleepCS) then begin
      fSleepCS.Wake;
    end;
    while (fThreads[idx].IsRunning) and (ShutdownMSRemaining>0) do begin
      {$ifdef MSWINDOWS}
      Sleep(1);
      {$else}
      fpSleep(1);
      {$endif}
      dec(ShutdownMSRemaining);
      if assigned(fSleepCS) then begin
        fSleepCS.Wake;
      end;
    end;
    if (fThreads[idx].IsRunning) then begin
      TStatus(stThreadTerminteFailed).Raize;
    end;
  end;
end;

procedure TThreadPool.SpreadThreadAffinity;
begin

end;

procedure TThreadPool.ClearThreadAffinity;
begin

end;

procedure TThreadPool.Wake;
begin
  fSleepCS.Wake;
end;

function TThreadPool.getThreadCount: nativeuint;
begin
  Result := fThreads.count;
end;

constructor TThreadPool.Create;
begin
  inherited Create;
  fThreads := TList<IThread>.Create;
  fThreadCS := TCriticalSection.Create;
  fSleepCS := TSignaledCriticalSection.Create;
end;

destructor TThreadPool.Destroy;
begin
  Terminate;
  fThreads := nil;
  fSleepCS := nil;
  fThreadCS := nil;
  inherited Destroy;
end;

end.

