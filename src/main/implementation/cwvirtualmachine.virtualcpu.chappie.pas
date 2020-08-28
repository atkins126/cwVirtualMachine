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

interface
uses
  cwIO
, cwStatus
, cwVirtualMachine
, cwVirtualMachine.Internal
;

type
  TChappieCPU = class( TInterfacedObject, IVirtualCPU, IVirtualCPUState )
  private
    fVMState: pVMState;
  private
    procedure DisposeState;
  strict private //- IVirtualCPU -//
    function Reset( const ByteCode: IBuffer ): pVMState;
    function FetchInstruction( out Handler: TVMInstructionHandler ): TStatus;
  strict private //- IVirtualCPUState -//
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation
uses
  cwTypes
, cwVirtualMachine.Chappie //- okay in implementation section only!
;

{$region ' Custom CPU state record for the chappie line of CPU'}
type
  TVMInstruction = uint16;
  pVMInstruction = ^TVMInstruction;

  TChappieState = record
    Default: TVMState;
  end;
  pChappieState = ^TChappieState;

{$endregion}

{$region ' Chappie CPU instruction set handlers'}

var
  InstructionSet: array[0..2] of TVMInstructionHandler;

function NopHandler( const State: pVMState ): TStatus;
begin
  Writeln('Nop');
end;

function HaltHandler( const State: pVMState ): TStatus;
begin
  Writeln('Setting Running to false (HALT)');
  State^.Running := False;
end;

function AlertHandler( const State: pVMState ): TStatus;
begin
  Writeln('Alert!!!!!');
end;

{$endregion}

constructor TChappieCPU.Create;
begin
  inherited Create;
  fVMState := nil;
end;

function TChappieCPU.FetchInstruction(out Handler: TVMInstructionHandler): TStatus;
var
  InstructionIndex: TVMInstruction;
begin
  Result := stVMNoState;
  if not assigned(fVMState) then exit;
  InstructionIndex := pVMInstruction( pChappieState(fVMState)^.Default.lpInstructionPointer )^;
  if InstructionIndex>=Length(InstructionSet) then begin
    Result := TStatus(stIndexOutOfBounds).Return( [ InstructionIndex.AsString ] );
    exit;
  end;
  Handler := InstructionSet[ InstructionIndex ];

  //- inc program counter.
  pChappieState(fVMState)^.Default.lpInstructionPointer := pointer(
    nativeuint( pChappieState(fVMState)^.Default.lpInstructionPointer ) + sizeof(TVMInstruction)
  );

  Result := TStatus.Success;
end;

destructor TChappieCPU.Destroy;
begin
  DisposeState;
  inherited Destroy;
end;

procedure TChappieCPU.DisposeState;
begin
  if not assigned(fVMState) then exit;
  Dispose(pChappieState(fVMState));
  fVMState := nil;
end;

function TChappieCPU.Reset( const ByteCode: IBuffer ): pVMState;
begin
  DisposeState;
  pChappieState(fVMState) := new(pChappieState);
  pChappieState(fVMState)^.Default.Bytecode := Bytecode;
  pChappieState(fVMState)^.Default.Running := True;
  pChappieState(fVMState)^.Default.lpInstructionPointer := ByteCode.DataPtr;
  Result := fVMState;
end;

initialization
  InstructionSet[uint16(TChappieInstructions.opNop)]   := @NopHandler;
  InstructionSet[uint16(TChappieInstructions.opHalt)]  := @HaltHandler;
  InstructionSet[uint16(TChappieInstructions.opAlert)] := @AlertHandler;

end.