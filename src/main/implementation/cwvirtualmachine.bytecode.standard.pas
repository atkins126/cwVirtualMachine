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
unit cwVirtualMachine.ByteCode.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwIO
, cwStatus
, cwIO.Standard
, cwVirtualMachine
;

type
  TBytecode = class( TInterfacedObject, IBytecode )
  private
    fBuffer: IBuffer;
    fGranularity: nativeuint;
    fWritten: nativeuint;
  strict private //- IBytecode -//
    function getSizeBytes: nativeuint;
    function getDataPtr: pointer;
    procedure Clear;
    procedure Append( const Bytes: array of uint8 );
  public
    constructor Create( const Granularity: nativeuint = 512 ); reintroduce;
    destructor Destroy; override;
  end;


implementation
uses
  cwTypes
;

procedure TBytecode.Append( const Bytes: array of uint8 );
type
  pByte = ^uint8;
var
  lpTarget: nativeuint;
  ByteCount: nativeuint;
begin
  ByteCount := Length(Bytes);
  if ByteCount<=0 then exit;
  //- Is there space in the buffer for the new instruction?
  if (fWritten + ByteCount) >= fBuffer.Size then begin
    fBuffer.Size := fBuffer.Size + fGranularity;
  end;
  //- Write the instruction
  lpTarget := fBuffer.DataPtr.AsNativeUInt + fWritten;
  Move( Bytes[0], pbyte(lpTarget)^, ByteCount );
  //- Update written and we're done
  fWritten := fWritten + ByteCount;
end;

procedure TBytecode.Clear;
begin
  fBuffer.Size := 0;
  fWritten := 0;
end;

constructor TBytecode.Create(const Granularity: nativeuint);
begin
  inherited Create;
  fGranularity := Granularity;
  fWritten := 0;
  fBuffer := TBuffer.Create(0);
end;

destructor TBytecode.Destroy;
begin
  fBuffer := nil;
  inherited Destroy;
end;

function TBytecode.getDataPtr: pointer;
begin
  Result := fBuffer.DataPtr;
end;

function TBytecode.getSizeBytes: nativeuint;
begin
  Result := fWritten;
end;

end.
