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
    fVirtualCPU: IVirtualCPU;
    fGranularity: nativeuint;
    fWritten: nativeuint;
  strict private //- IBytecode -//
    function getSizeBytes: nativeuint;
    function getDataPtr: pointer;
    procedure Clear;
    function AppendInstruction( const Name: string; const Operands: array of TOperand ): TStatus; overload;
    function AppendInstruction( const Name: string ): TStatus; overload;
  public
    constructor Create( const VirtualCPU: IVirtualCPU; const Granularity: nativeuint = 512 ); reintroduce;
    destructor Destroy; override;
  end;


implementation

function TBytecode.AppendInstruction(const Name: string; const Operands: array of TOperand): TStatus;
var
  InstructionSize: nativeuint;
  lpTarget: pointer;
begin
  Result := TStatus.Unknown;
  if not assigned(fVirtualCPU) then exit;
  //- Determine the size of the instruction that we're encoding.
  Result := fVirtualCPU.EncodeInstruction( Name, Operands, nil, InstructionSize );
  if not Result then exit;
  //- Is there space in the buffer for the new instruction?
  if (fWritten+InstructionSize)>=fBuffer.Size then begin
    fBuffer.Size := fBuffer.Size + fGranularity;
  end;
  //- Write the instruction
  {$hints off} lpTarget := pointer( nativeuint( fBuffer.DataPtr ) + fWritten ); {$hints on}
  Result := fVirtualCPU.EncodeInstruction( Name, Operands, lpTarget, InstructionSize );
  if not Result then exit;
  //- Update written and we're done
  fWritten := fWritten + InstructionSize;
  Result := TStatus.Success;
end;

function TBytecode.AppendInstruction(const Name: string): TStatus;
begin
  Result := AppendInstruction( Name, [] );
end;

procedure TBytecode.Clear;
begin
  fBuffer.Size := 0;
  fWritten := 0;
end;

constructor TBytecode.Create(const VirtualCPU: IVirtualCPU; const Granularity: nativeuint);
begin
  inherited Create;
  fVirtualCPU := VirtualCPU;
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
