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
unit cwVirtualMachine.VirtualCPU.Chappie;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwIO
, cwStatus
, cwVirtualMachine
;

{$region ' CPU State '}

type

  // Represents the state of a chappie CPU.
  TChappieState = record
    Running         : boolean;
    BytecodeStart   : nativeuint;
    BytecodeStop    : nativeuint;
    ProgramCounter  : nativeuint;
    Accumulator     : nativeuint;
  end;
  pChappieState = ^TChappieState;

{$endregion}

type
  TChappieCPU = class( TInterfacedObject, IVirtualCPU )
  private
    fState: TChappieState;
  strict private //- IVirtualCPU -//
    procedure Reset( const lpBytecode: pointer; const szBytecode: nativeuint; const StaticData: IBuffer = nil );
    function Clock: boolean;
  public
    constructor Create;
  end;


implementation
uses
  cwTypes
, cwVirtualMachine.Chappie //- MUST remain in implementation section or else cyclic reference.
;


{$region ' Chappie Instruction Handlers'}

procedure HandleNop( var State: TChappieState );
begin
  Writeln('Nop');
end;

procedure HandleHalt( var State: TChappieState );
begin
  Writeln('Setting Running to false (HALT)');
  State.Running := False;
end;

procedure HandleAlert( var State: TChappieState );
begin
  Writeln('Alert!!!!!');
end;

procedure HandleLoad( var State: TChappieState );
begin
  State.Accumulator := nativeuint( pointer(State.ProgramCounter)^ );
  State.ProgramCounter := State.ProgramCounter + Sizeof(nativeuint);
end;

procedure HandleSave( var State: TChappieState );
begin
  nativeuint( pointer(State.ProgramCounter)^ ) := State.Accumulator;
  State.ProgramCounter := State.ProgramCounter + Sizeof(nativeuint);
end;

procedure HandleAdd( var State: TChappieState );
begin
  State.Accumulator := State.Accumulator + nativeuint( pointer(State.ProgramCounter)^ );
  State.ProgramCounter := State.ProgramCounter + Sizeof(nativeuint);
end;

{$endregion}

{$region ' Chappie Instruction Set'}

type
  // A callback function to handle execution of an instruction.
  TVMInstructionHandler = procedure( var State: TChappieState );

const
  //- Our instruction set defined as an array of named handlers.
  cInstructionSet: array[Low(TOpCode)..High(TOpCode)] of TVMInstructionHandler = (
    HandleHalt,
    HandleNop,
    HandleAlert,
    HandleLoad,
    HandleSave,
    HandleAdd
  );

{$endregion}

{$region ' TChappieCPU class implementation'}

function TChappieCPU.Clock: boolean;
type
  pOpCode = ^TOpCode;
var
  Handler: TVMInstructionHandler;
begin

  //- A program is loaded, and has not ended?
  Result := False;
  if not fState.Running then exit;

  //- Do not allow overrun of byte-code
  if fState.ProgramCounter > fState.BytecodeStop then begin
    TStatus( stUnexpectedEndOfBytecode ).Raize;
  end;

  //- Check for valid op-code
  if pOpCode( fState.ProgramCounter.AsPointer )^ > High(TOpCode) then begin
    TStatus( stInvalidOpCode ).Raize;
  end;

  //- Fetch handler
  Handler := cInstructionSet[ pOpCode( fState.ProgramCounter.AsPointer )^ ];

  //- Increment program counter
  fState.ProgramCounter := fState.ProgramCounter + Sizeof(TOpCode);

  //- Execute Instruction;
  Handler(fState);

  //- Let VM know if the program can continue or has ended
  Result := fState.Running;
end;

constructor TChappieCPU.Create;
begin
  inherited Create;
  Reset( nil, 0, nil );
end;

procedure TChappieCPU.Reset( const lpBytecode: pointer; const szBytecode: nativeuint; const StaticData: IBuffer = nil );
begin
  {$hints off}
  fState.BytecodeStart  := nativeuint( lpBytecode );
  {$hints on}
  fState.BytecodeStop   := fState.BytecodeStart + szBytecode;
  fState.ProgramCounter := fState.BytecodeStart;
  fState.Running        := szBytecode>0;
end;

{$endregion}

end.
