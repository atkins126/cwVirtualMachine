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
unit cwVirtualMachine.Chappie;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwVirtualMachine
;

type
  TArrayOfByte = array of byte;

  ///  <summary>
  ///    An enumeration of the op-codes available to the chappie CPU.
  ///  </summary>
  ///  Note: {$Z2} directive to set minimum enum size to 2 bytes.
  ///        A check will be performed during initialization to ensure that
  ///        this type does not exceed two bytes, making TOpCode compatible with uint16.
  {$Z2}
  TOpcode = (
    opHalt  = $00,
    opNop   = $01,
    opAlert = $02,
    opLoad  = $03,
    opSave  = $04,
    opAdd   = $05
  );
  {$Z1}

  /// <summary>
  ///   A factory record for instancing virtual CPU's
  /// </summary>
  TChappieCPU = record

    ///  <summary>
    ///    Creates an instance of the 'Chappie' CPU, as developed as part of the
    ///    ChapmanWorld "Lets build a virtual machine" video series.
    ///  </summary>
    class function Create: IVirtualCPU; static;

    ///  <summary>
    ///    Encodes an opcode into an array of bytes for addition to an IBytecode buffer.
    ///  </summary>
    class function Encode( const OpCode: TOpCode; const Operands: array of nativeuint ): TArrayOfByte; static;
  end;


implementation
uses
  sysutils
, cwVirtualMachine.VirtualCPU.Chappie
;

class function TChappieCPU.Create: IVirtualCPU;
begin
  Result := cwVirtualMachine.VirtualCPU.Chappie.TChappieCPU.Create;
end;

class function TChappieCPU.Encode(const OpCode: TOpCode; const Operands: array of nativeuint): TArrayOfByte;
var
  OperandCount: nativeuint;
begin
  SetLength(Result,0);
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
  Move(Operands[1],Result[ sizeof(TOpCode) + sizeof(nativeuint) ],sizeof(nativeuint));
  if OperandCount=2 then exit;
  //- Move operand 2
  Move(Operands[2],Result[ sizeof(TOpCode) + (sizeof(nativeuint)*2) ],sizeof(nativeuint));
end;

initialization
  if sizeof(TOpCode)<>2 then begin
    raise
      Exception.Create('TOpCode size must be two bytes');
  end;

end.
