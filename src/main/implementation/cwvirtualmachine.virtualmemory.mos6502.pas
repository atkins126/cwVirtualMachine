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
unit cwVirtualMachine.VirtualMemory.Mos6502;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwVirtualMachine
, cwVirtualMachine.Mos6502
, cwVirtualMachine.VirtualMemory.Custom
;

const
  c1KB = 256;
  c64KB = $10000;

type
  T6502VirtualMemory = class( TCustomVirtualMemory, IVirtualMemory, I6502VirtualMemory )
  private
    fMemoryMap: array[0..$FF] of nativeuint;
  private
    procedure PrearrangeBanks;
  strict private //- I6502VirtualMemory --//
    function getBank( const idx: uint8 ): nativeuint;
    procedure setBank( const idx: uint8; const value: nativeuint );
  protected
    procedure setDataSize( const Value: nativeuint ); override;
  public
    constructor Create( const InitialSize: nativeuint = c64KB ); reintroduce;
  end;


implementation

procedure T6502VirtualMemory.PrearrangeBanks;
var
  TargetOffset: nativeuint;
  idx: uint8;
begin
  TargetOffset := 0;
  for idx := 0 to $FF do begin
    fMemoryMap[idx] := TargetOffset;
    inc(TargetOffset,c1KB);
  end;
end;

function T6502VirtualMemory.getBank(const idx: uint8): nativeuint;
begin
  Result := fMemoryMap[idx];
end;

procedure T6502VirtualMemory.setBank(const idx: uint8; const value: nativeuint);
begin
  if (Value+$FF)>getDataSize() then exit;
  fMemoryMap[idx] := Value;
end;

procedure T6502VirtualMemory.setDataSize(const Value: nativeuint);
begin
  if Value<c64KB then exit;
  inherited setDataSize(Value);
end;

constructor T6502VirtualMemory.Create( const InitialSize: nativeuint );
var
  DataSize: nativeuint;
begin
  DataSize := InitialSize;
  if DataSize<c64KB then begin
    DataSize := c64KB;
  end;
  inherited Create( DataSize );
  PreArrangeBanks;
end;

end.

