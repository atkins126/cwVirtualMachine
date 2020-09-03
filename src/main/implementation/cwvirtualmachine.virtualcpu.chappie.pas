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
  cwIO
, cwStatus
, cwVirtualMachine
;

type
  {$region ' Custom CPU state record for the chappie line of CPU'}

  TChappieState = record
    Running         : boolean;
    BytecodeStart   : nativeuint;
    BytecodeStop    : nativeuint;
    ProgramCounter  : nativeuint;
  end;

  {$endregion}

type
  TChappieCPU = class( TInterfacedObject, IVirtualCPU )
  private
    fState: TChappieState;
  strict private //- IVirtualCPU -//
    function EncodeInstruction( const Name: string; const Operands: array of TOperand; const lpInstruction: pointer; out szInstruction: nativeuint ): TStatus;
    procedure Reset( const lpBytecode: pointer; const szBytecode: nativeuint; const StaticData: IBuffer = nil );
    function Clock: boolean;
  public
    constructor Create;
  end;

implementation
uses
  cwTypes
;

{$region ' Instruction-Set types'}

type
  TVMOpCode = uint16;
  pVMOpCode = ^TVMOpCode;
  TVMInstructionHandler = procedure( var State: TChappieState );
  TVMInstructionEncoder = function( const OpCode: TVMOpCode; const Operands: array of TOperand; const lpInstruction: pointer; out szInstruction: nativeuint ): TStatus;
  TVMInstructionRecord = record
    Name: string;
    Handler: TVMInstructionHandler;
    Encoder: TVMInstructionEncoder;
  end;

{$endregion}

{$region 'NOP Instruction'}

procedure HandleNop( var State: TChappieState );
begin
  Writeln('Nop');
end;

function EncodeNop( const OpCode: TVMOpCode; const Operands: array of TOperand; const lpInstruction: pointer; out szInstruction: nativeuint ): TStatus;
begin
  Result := TStatus.Success;
  szInstruction := sizeof(TVMOpCode);
  if assigned(lpInstruction) then begin
    pVMOpCode(lpInstruction)^ := OpCode;
  end;
end;

{$endregion}

{$region 'HALT Instruction'}

procedure HandleHalt( var State: TChappieState );
begin
  Writeln('Setting Running to false (HALT)');
  State.Running := False;
end;

function  EncodeHalt( const OpCode: TVMOpCode; const Operands: array of TOperand; const lpInstruction: pointer; out szInstruction: nativeuint ): TStatus;
begin
  Result := TStatus.Success;
  szInstruction := sizeof(TVMOpCode);
  if assigned(lpInstruction) then begin
    pVMOpCode(lpInstruction)^ := OpCode;
  end;
end;

{$endregion}

{$region 'ALERT Instruction'}

procedure HandleAlert( var State: TChappieState );
begin
  Writeln('Alert!!!!!');
end;

function  EncodeAlert( const OpCode: TVMOpCode; const Operands: array of TOperand; const lpInstruction: pointer; out szInstruction: nativeuint ): TStatus;
begin
  Result := TStatus.Success;
  szInstruction := sizeof(TVMOpCode);
  if assigned(lpInstruction) then begin
    pVMOpCode(lpInstruction)^ := OpCode;
  end;
end;

{$endregion}

{$region ' Instruction set constant array'}

const
  cInstructionSet: array[0..2] of TVMInstructionRecord = (
    ( Name: 'HALT';   Handler: HandleHalt;  Encoder: EncodeHalt   ),
    ( Name: 'NOP';    Handler: HandleNop;   Encoder: EncodeNop    ),
    ( Name: 'ALERT';  Handler: HandleAlert; Encoder: EncodeAlert  )
  );

{$endregion}

function TChappieCPU.Clock: boolean;
begin

  //- A program is loaded, and has not ended?
  Result := False;
  if not fState.Running then exit;

  //- Do not allow overrun of byte-code
  if fState.ProgramCounter>=fState.BytecodeStop then begin
    TStatus( stUnexpectedEndOfBytecode ).Raize;
  end;

  //- Check for valid op-code
  {$hints off}
  if pVMOpCode( fState.ProgramCounter )^>Length(cInstructionSet) then begin
  {$hints on}
    TStatus( stInvalidOpCode ).Raize;
  end;

  //- Execute instruction.
  {$hints off}
  cInstructionSet[pVMOpCode(fState.ProgramCounter)^].Handler(fState);
  {$hints on}

  //- Increment program counter
  fState.ProgramCounter := fState.ProgramCounter + Sizeof(TVMOpCode);

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

function TChappieCPU.EncodeInstruction(const Name: string; const Operands: array of TOperand; const lpInstruction: pointer; out szInstruction: nativeuint): TStatus;

  function FindInstructionByName(const utName: string; out Foundidx: TVMOpCode): TStatus;
  var
    idx: TVMOpCode;
  begin
    Result := TStatus.Unknown;
    if Length(cInstructionSet)=0 then Result.Raize; //- There should always be an instruction set!
    Result := TStatus(stUnknownInstructionName);
    for idx := 0 to pred(Length(cInstructionSet)) do begin
      if cInstructionSet[idx].Name=utName then begin
        FoundIdx := idx;
        Result := TStatus.Success;
        exit;
      end;
    end;
  end;

var
  FoundIdx: TVMOpCode;
begin
  //- locate the instruction by name in our instruction set.
  szInstruction := 0;
  Result := FindInstructionByName(Name.UppercaseTrim, Foundidx);
  if not Result then Result.Raize;
  //- Call the instruction encoder
  cInstructionSet[FoundIdx].Encoder(FoundIdx,Operands,lpInstruction,szInstruction);
end;

procedure TChappieCPU.Reset( const lpBytecode: pointer; const szBytecode: nativeuint; const StaticData: IBuffer = nil );
begin
  {$hints off}
  fState.BytecodeStart  := nativeuint( lpBytecode );
  {$hints on}
  fState.BytecodeStop   := fState.BytecodeStart + szBytecode;
  fState.ProgramCounter := fState.BytecodeStart;
  fState.Running        := True;
end;


end.
