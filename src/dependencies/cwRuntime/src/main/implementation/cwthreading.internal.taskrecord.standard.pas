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
unit cwThreading.Internal.TaskRecord.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwThreading
, cwThreading.Internal
;

type
  pNativeuint = ^nativeuint;

  TTaskRecord = class( TInterfacedObject, ITaskRecord )
  private
    fTask: ITask;
    fTaskThread: TThreadID;
    fComplete: boolean;
  strict private //- ITaskRecord -//
    procedure Execute;
    function IsComplete: boolean;
    function IsLocked: boolean;
    function Lock: boolean;
  public
    constructor Create( const Task: ITask ); reintroduce;
    destructor Destroy; override;
  end;

implementation
{$ifdef MSWINDOWS}
uses
  cwWin32.Kernel32
;
{$endif}

procedure TTaskRecord.Execute;
begin
  if assigned(fTask) then begin
    fTask.Execute;
    fComplete := True;
  end;
end;

function TTaskRecord.IsComplete: boolean;
begin
  Result := fComplete;
end;

function TTaskRecord.IsLocked: boolean;
begin
  Result := fTaskThread<>0;
end;

function TTaskRecord.Lock: boolean;
var
  CurrentThreadID: TThreadID;
begin
  Result := False;
  if fTaskThread<>0 then exit;
  CurrentThreadID := getCurrentThreadID;
  fTaskThread := CurrentThreadID;
  Result := fTaskThread = CurrentThreadID;
end;

constructor TTaskRecord.Create(const Task: ITask);
begin
  inherited Create;
  fComplete := False;
  fTaskThread := 0;
  fTask := Task;
end;

destructor TTaskRecord.Destroy;
begin
  fTask := nil;
  inherited Destroy;
end;

end.

