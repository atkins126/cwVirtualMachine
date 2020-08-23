program VirtualMachine1;

const
  opNop   = 00;
  opHalt  = 01;
  opAlert = 02;

type
  TVMInstruction = uint16;
  ptrVMInstruction = ^TVMInstruction;

  TVMInstructionHandler = procedure;
  TInstructionSet = array[0..2] of TVMInstructionHandler;

const
  cTestProgram: array[0..2] of TVMInstruction = (
    opNop,
    opAlert,
    opHalt
  );

var //- State data
  Running: boolean;
  ProgramCounter: ptrVMInstruction;

procedure NopHandler;
begin
  Writeln('Nop');
end;

procedure HaltHandler;
begin
  Writeln('Setting Running to false (HALT)');
  Running := False;
end;

procedure AlertHandler;
begin
  Writeln('Alert!!!!!');
end;

var //- Machinery of VM
  CurrentInstruction: TVMInstructionHandler;
  InstructionSet: TInstructionSet;

begin
  // Initialization
  InstructionSet[opNop] := @NopHandler;
  InstructionSet[opHalt] := @HaltHandler;
  InstructionSet[opAlert] := @AlertHandler;
  Running := True;
  ProgramCounter := @cTestProgram[0];

  // Clock Cycle
  Writeln('Starting virtual program');
  repeat
    // Fetch
    CurrentInstruction := InstructionSet[ProgramCounter^];

    // Execute
    CurrentInstruction();

    // Update program counter
    {$hints off} ProgramCounter := pointer(nativeuint(ProgramCounter)+sizeof(TVMInstruction)); {$hints on}
  until not Running;
  Writeln('Ending virtual program');

  Readln;
end.

