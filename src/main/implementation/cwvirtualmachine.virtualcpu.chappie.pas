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
unit cwvirtualmachine.virtualcpu.chappie;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwStatus
, cwVirtualMachine
;

type
  TChappieState = record
    Running: boolean;
    BytecodeStart: nativeuint;
    BytecodeStop: nativeuint;
    ProgramCounter: nativeuint;
  end;

type
  TChappieCPU = class( TInterfacedObject, IVirtualCPU )
  private
    fState: TChappieState;
  private //- Instruction Handlers -//
    class procedure AlertHandler( var State: TChappieState ); static;
    class procedure HaltHandler( var State: TChappieState ); static;
    class procedure NopHandler( var State: TChappieState ); static;
  strict private //- IVirtualCPU -//
    procedure Reset( const lpBytecode: pointer; const szByteCode: nativeuint );
    function Clock: boolean;
  public
    constructor Create;
  end;

implementation
uses
  cwTypes
;

{$region ' Custom CPU state record for the chappie line of CPU'}

type
  TVMInstruction = uint16;
  pVMInstruction = ^TVMInstruction;
  TVMInstructionHandler = procedure( var State: TChappieState );
var
  InstructionSet: array[0..2] of TVMInstructionHandler;

{$endregion}


class procedure TChappieCPU.NopHandler( var State: TChappieState );
begin
  Writeln('Nop');
end;

class procedure TChappieCPU.HaltHandler( var State: TChappieState );
begin
  Writeln('Setting Running to false (HALT)');
  State.Running := False;
end;

class procedure TChappieCPU.AlertHandler( var State: TChappieState );
begin
  Writeln('Alert!!!!!');
end;

function TChappieCPU.Clock: boolean;
begin

  //- A program is loaded, and has not ended?
  Result := False;
  if not fState.Running then exit;

  //- Do not allow overrun of byte-code
  if fState.ProgramCounter=fState.BytecodeStop then begin
    TStatus( stUnexpectedEndOfBytecode ).Raize;
  end;

  //- Check for valid op-code
  {$hints off}
  if pVMInstruction( fState.ProgramCounter )^>Length(InstructionSet) then begin
  {$hints on}
    TStatus( stInvalidOpCode ).Raize;
  end;

  //- Execute instruction.
  {$hints off}
  InstructionSet[pVMInstruction(fState.ProgramCounter)^](fState);
  {$hints on}

  //- Increment program counter
  fState.ProgramCounter := fState.ProgramCounter + Sizeof(TVMInstruction);

  //- Let VM know if the program can continue or has ended
  Result := fState.Running;
end;

constructor TChappieCPU.Create;
begin
  inherited Create;
  fState.Running        := False;
  fState.BytecodeStart  := 0;
  fState.BytecodeStop   := 0;
  fState.ProgramCounter := 0;
end;

procedure TChappieCPU.Reset( const lpBytecode: pointer; const szByteCode: nativeuint );
begin
  {$hints off}
  fState.BytecodeStart  := nativeuint( lpBytecode );
  {$hints on}
  fState.BytecodeStop   := fState.BytecodeStart + szByteCode;
  fState.ProgramCounter := fState.BytecodeStart;
  fState.Running        := True;
end;


initialization
  InstructionSet[0] := TChappieCPU.NopHandler;
  InstructionSet[1] := TChappieCPU.HaltHandler;
  InstructionSet[2] := TChappieCPU.AlertHandler;

end.
