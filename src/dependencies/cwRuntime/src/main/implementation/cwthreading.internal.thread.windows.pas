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
unit cwThreading.Internal.Thread.Windows;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifdef MSWINDOWS}
uses
  cwThreading
, cwThreading.Internal
;

type
  TThread = class( TInterfacedObject, IThread )
  private
    fHandle: THandle;
    fThreadID: uint32;
    fSleepCS: ISignaledCriticalSection;
    fTerminateFlag: Boolean;
    fRunning: boolean;
    fThreadExecuteMethod: TThreadExecuteMethod;
  protected  //- IThread -//
    function getSleepCS: ISignaledCriticalSection;
    function getTerminateFlag: boolean;
    procedure setTerminateFlag( const value: boolean );
    procedure Acquire;
    procedure Release;
    procedure Sleep;
    procedure Wake;
    function IsRunning: boolean;
  protected
    procedure Execute;
  public
    constructor Create( const ThreadExecuteMethod: TThreadExecuteMethod; const SleepCS: ISignaledCriticalSection ); reintroduce;
    destructor Destroy; override;
  end;

{$endif}
implementation
{$ifdef MSWINDOWS}
uses
  cwStatus
, cwTypes
, cwWin32.Kernel32
;

function InternalHandler( Thread: pointer ): uint32; stdcall;
var
  ThreadRef: TThread;
begin
  Result := 0;
  ThreadRef := TThread(Thread);
  if not assigned(ThreadRef) then exit;
  ThreadRef.Execute;
end;

function TThread.getSleepCS: ISignaledCriticalSection;
begin
  Result := fSleepCS;
end;

function TThread.getTerminateFlag: boolean;
begin
  Result := fTerminateFlag;
end;

procedure TThread.setTerminateFlag(const value: boolean);
begin
  fTerminateFlag := Value;
end;

procedure TThread.Acquire;
begin
  if assigned(fSleepCS) then begin
    fSleepCS.Acquire;
  end;
end;

procedure TThread.Release;
begin
  if assigned(fSleepCS) then begin
    fSleepCS.Release;
  end;
end;

procedure TThread.Sleep;
begin
  if assigned(fSleepCS) then begin
    fSleepCS.Sleep;
  end;
end;

procedure TThread.Wake;
begin
  if assigned(fSleepCS) then begin
    fSleepCS.Wake;
  end;
end;

function TThread.IsRunning: boolean;
begin
  Result := fRunning;
end;

procedure TThread.Execute;
begin
  if fTerminateFlag then exit;
  fRunning := True;
  try
    if assigned(fThreadExecuteMethod) then begin
      fThreadExecuteMethod(Self);
    end;
  finally
    fRunning := False;
  end;
end;

constructor TThread.Create(const ThreadExecuteMethod: TThreadExecuteMethod; const SleepCS: ISignaledCriticalSection);
begin
  inherited Create;
  fRunning := False;
  fTerminateFlag := False;
  fThreadExecuteMethod := ThreadExecuteMethod;
  fSleepCS := SleepCS;
  fHandle := CreateThread(nil,0,@InternalHandler,Self,0,fThreadID);
  if fHandle=0 then begin
    TStatus(stThreadCreateFailed).Raize;
  end;
  //if AffinityMask>0 then begin
  //  SetThreadAffinityMask(fHandle,AffinityMask);
  //end;
end;

destructor TThread.Destroy;
begin
  if fHandle<>0 then begin
    CloseHandle(fHandle);
  end;
  fSleepCS := nil;
  inherited Destroy;
end;

{$endif}
end.

