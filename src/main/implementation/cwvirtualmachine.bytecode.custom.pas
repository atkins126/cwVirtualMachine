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
unit cwVirtualMachine.ByteCode.Custom;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwIO
, cwStatus
, cwIO.Standard
, cwVirtualMachine
;

const
  cDefaultBytecodeGranularity = 512;

type
  TCustomBytecode = class( TInterfacedObject, IBytecode )
  private
    fMemory: IVirtualMemory;
    fGranularity: nativeuint;
    fCursor: nativeuint;
  protected //- IBytecode -//
    function getVirtualMemory: IVirtualMemory;
    function getCursor: nativeuint;
    procedure setCursor( const value: nativeuint );
    function Write( const Bytes: array of uint8; const Offset: nativeuint ): nativeuint;
    procedure Append( const Bytes: array of uint8 );
  public
    constructor Create( const VirtualMemory: IVirtualMemory; const Granularity: nativeuint = cDefaultBytecodeGranularity ); reintroduce;
    destructor Destroy; override;
  end;


implementation
uses
  cwTypes
;

function TCustomBytecode.getVirtualMemory: IVirtualMemory;
begin
  Result := fMemory;
end;

function TCustomBytecode.getCursor: nativeuint;
begin
  Result := fCursor;
end;

procedure TCustomBytecode.setCursor(const value: nativeuint);
begin
  if not assigned(fMemory) then begin
    fCursor := 0;
    exit;
  end;
  if Value>=fMemory.DataSize then begin
    if fMemory.DataSize=0 then begin
      fCursor := 0;
      exit;
    end;
    fCursor := pred(fMemory.DataSize);
    exit;
  end;
  fCursor := Value;
end;

function TCustomBytecode.Write(const Bytes: array of uint8; const Offset: nativeuint): nativeuint;
var
  L: nativeuint;
  BytesToWrite: nativeuint;
  TargetPtr: pointer;
begin
  Result := 0;
  if not assigned(fMemory) then begin
    TStatus(stVirtualMemoryUnassigned).Raize;
  end;
  //- Test for sufficient memory for new bytes.
  L := Length(Bytes);
  if L=0 then exit;
  if (fCursor+L)>=fMemory.DataSize then begin
    BytesToWrite := fMemory.DataSize - L;
  end else begin
    BytesToWrite := L;
  end;
  if BytesToWrite=0 then exit;
  //- Write the bytes.
  TargetPtr := (fMemory.DataPtr.AsNativeUInt + fCursor).AsPointer;
  Move( Bytes[0], TargetPtr^, BytesToWrite );
  inc(fCursor,BytesToWrite);
  Result := BytesToWrite;
end;

procedure TCustomBytecode.Append(const Bytes: array of uint8);
var
  L: nativeuint;
  TargetSize: nativeuint;
  Allocations: nativeuint;
  TargetPtr: pointer;
begin
  if not assigned(fMemory) then begin
    TStatus(stVirtualMemoryUnassigned).Raize;
  end;
  //- Ensure sufficient memory to add new bytes.
  L := Length(Bytes);
  if L=0 then exit;
  if (fCursor+L)>=fMemory.DataSize then begin
    TargetSize := fMemory.DataSize + L;
    Allocations := TargetSize div fGranularity;
    if (TargetSize mod fGranularity)>0 then inc(Allocations);
    fMemory.setDataSize( Allocations * fGranularity );
  end;
  //- Write the bytes.
  TargetPtr := (fMemory.DataPtr.AsNativeUInt + fCursor).AsPointer;
  Move( Bytes[0], TargetPtr^, L );
  inc(fCursor,L);
end;

constructor TCustomBytecode.Create( const VirtualMemory: IVirtualMemory; const Granularity: nativeuint = cDefaultBytecodeGranularity );
begin
  inherited Create;
  fMemory := VirtualMemory;
  fGranularity := Granularity;
  if fGranularity = 0 then begin
    fGranularity := cDefaultBytecodeGranularity;
  end;
  setCursor(0);
end;

destructor TCustomBytecode.Destroy;
begin
  fMemory := nil;
  inherited Destroy;
end;

end.
