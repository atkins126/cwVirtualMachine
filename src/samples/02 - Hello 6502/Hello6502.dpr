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
program Hello6502;
{$ifdef fpc}{$mode delphiunicode}{$H+}{$endif}
uses
  cwTypes
, cwVirtualMachine
, cwVirtualMachine.Standard
, cwVirtualMachine.Mos6502
;

var
  Memory: I6502VirtualMemory;
  ByteCode: I6502Bytecode;
  CPU: I6502CPU;

procedure WriteRegisters;
begin
  Writeln( '   PC  SR AC XR YT SP - ChapmanWorld Rocks!');
  Writeln( '; '+
           CPU.PC.AsHex(4)+' '+
           CPU.SR.AsHex(2)+' '+
           CPU.A.AsHex(2)+' '+
           CPU.X.AsHex(2)+' '+
           CPU.Y.AsHex(2)+' '+
           CPU.SP.AsHex(2) );
end;

begin
  //- Create some memory for our virtual machine to work with.
  //- Defaults to the minimum of 64KB
  Memory := T6502VirtualMemory.Create;

  //- Create an instruction code window into memory, specific to the 6502
  ByteCode := T6502Bytecode.Create( Memory );
  ByteCode.Cursor := 0;

  //- Write some instructions.
  ByteCode.BRK;
  ByteCode.BRK;
  ByteCode.BRK;

  //- Create an instance of the 6502 to do the work.
  CPU := T6502CPU.Create( Memory );

  //- Work!
  while CPU.Clock do begin
    if CPU.BreakFlag then begin
      WriteRegisters;
      Readln;
      CPU.BreakFlag := False;
    end;
  end;

  //- We're done here.
  Readln;
end.

