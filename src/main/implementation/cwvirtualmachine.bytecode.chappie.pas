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
unit cwVirtualMachine.Bytecode.Chappie;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwVirtualMachine
, cwVirtualMachine.Chappie
, cwVirtualMachine.Bytecode.Custom
, cwVirtualMachine.VirtualCPU.Chappie.Opcodes
;

type
  TChappieByteCode = class( TCustomBytecode, IBytecode, IChappieBytecode )
  private
    function Encode(const OpCode: TOpCode; const Operands: array of uint32): TArrayOfByte;
  strict private //- IChappieBytecode -//
    procedure opHalt;
    procedure OpNop;
    procedure OpAlert;
    procedure OpLoad( const value: nativeuint );
    procedure OpAdd( const value: nativeuint );
    procedure OpSave;
  end;

implementation

function TChappieByteCode.Encode(const OpCode: TOpCode; const Operands: array of uint32): TArrayOfByte;
var
  OperandCount: nativeuint;
begin
  {$warnings off} SetLength(Result,0); {$warnings on}
  OperandCount := Length(Operands);
  if OperandCount>3 then exit;
  //- Set size of target array
  SetLength(Result,Sizeof(TOpCode)+(OperandCount*sizeof(nativeuint)));
  //- Move opcode
  Move(Opcode,Result[0],sizeof(TOpCode));
  if OperandCount=0 then exit;
  //- Move operand 0
  Move(Operands[0],Result[sizeof(TOpCode)],sizeof(nativeuint));
  if OperandCount=1 then exit;
  //- Move operand 1
  Move(Operands[1],Result[ sizeof(TOpCode) + sizeof(uint32) ],sizeof(uint32));
  if OperandCount=2 then exit;
  //- Move operand 2
  Move(Operands[2],Result[ sizeof(TOpCode) + (sizeof(uint32)*2) ],sizeof(uint32));
end;

procedure TChappieByteCode.opHalt;
begin
  inherited Append(Encode(TOpCode.opHalt,[]));
end;

procedure TChappieByteCode.OpNop;
begin
  inherited Append(Encode(TOpCode.opNop,[]));
end;

procedure TChappieByteCode.OpAlert;
begin
  inherited Append(Encode(TOpCode.opAlert,[]));
end;

procedure TChappieByteCode.OpLoad(const value: nativeuint);
begin
  inherited Append(Encode(TOpCode.opLoad,[value]));
end;

procedure TChappieByteCode.OpAdd(const value: nativeuint);
begin
  inherited Append(Encode(TOpCode.opAdd,[value]));
end;

procedure TChappieByteCode.OpSave;
begin
  inherited Append(Encode(TOpCode.opSave,[0]));
end;

end.

