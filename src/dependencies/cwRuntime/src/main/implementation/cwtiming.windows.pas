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
unit cwTiming.windows;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
{$ifdef MSWINDOWS}
uses
  cwStatus
, cwTiming
;

type
  TTimer = class( TInterfacedObject, ITimer )
  private
    fPreviousTicks: TTickInteger;
    fTicksPerSecond: TTickInteger;
  strict private //- ITimer -//
    procedure Clear;
    function getDeltaSeconds: double;
    function getDeltaTicks: TTickInteger;
    function getTicksPerSecond: TTickInteger;
  private
    procedure internalGetResolution;
    function internalGetTicks: TTickInteger;
  public
    constructor Create;
    destructor Destroy; override;
  end;
{$endif}
implementation
{$ifdef MSWINDOWS}
uses
  cwWin32.Kernel32
;

constructor TTimer.Create;
begin
  inherited Create;
  internalGetResolution;
  fPreviousTicks := internalGetTicks;
end;

destructor TTimer.Destroy;
begin
  inherited Destroy;
end;

procedure TTimer.internalGetResolution;
begin
  if not QueryPerformanceFrequency(fTicksPerSecond) then begin
    TStatus(stNoHighPrecisionTimer).Raize;
  end;
end;

procedure TTimer.Clear;
begin
  getDeltaTicks;
end;

function TTimer.getDeltaSeconds: double;
begin
  Result := getDeltaTicks / fTicksPerSecond;
end;

function TTimer.getDeltaTicks: TTickInteger;
var
  fCurrentTicks: TTickInteger;
begin
  fCurrentTicks := internalGetTicks;
  // Trap wrap around on timer, just in case.
  if fCurrentTicks<fPreviousTicks then begin
    Result := (High(Int64)-fPreviousTicks)+fCurrentTicks;
  end else begin
    Result := fCurrentTicks - fPreviousTicks;
  end;
  fPreviousTicks := fCurrentTicks;
end;

function TTimer.getTicksPerSecond: TTickInteger;
begin
  Result := fTicksPerSecond;
end;

function TTimer.internalGetTicks: TTickInteger;
begin
  Result := 0;
  QueryPerformanceCounter(Result);
end;

{$endif}
end.

