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
unit cwVirtualMachine.VirtualCPU.Mos6502;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwStatus
, cwVirtualMachine
, cwVirtualMachine.Mos6502
;


{$region ' CPU State '}

type
  // Represents the state of a chappie CPU.
  T6502State = record
    Memory          : I6502VirtualMemory;
    MemoryMap       : array[0..$FF] of nativeuint;
    //- registers
    PC              : uint16; // program counter
    A               : uint8;  // Accumulator
    X               : uint8;  // Index X register
    Y               : uint8;  // Idnex Y register
    SP              : uint8;  // Stack Pointer
    SR              : uint8;  // Status Register
  end;
  p6502State = ^T6502State;

{$endregion}

type
  T6502CPU = class( TInterfacedObject, IVirtualCPU, I6502CPU )
  private
    fLatchValue: uint8;
    fOnLatch: TLatchEvent;
    fState: T6502State;
  private
    procedure CopyMemoryMap;
    procedure SetLatchValue;
    function GetLatchValue: uint8;
  strict private //- IVirtualCPU -//
    procedure Reset( const EntryPoint: nativeuint );
    function Clock: boolean;
  strict private //- I6502CPU -//
    function getPC : uint16;
    procedure setPC( const value: uint16 );
    function getA : uint8;
    procedure setA( const value: uint8 );
    function getX : uint8;
    procedure setX( const value: uint8 );
    function getY : uint8;
    procedure setY( const value: uint8 );
    function getSP : uint8;
    procedure setSP( const value: uint8 );
    function getSR : uint8;
    procedure setSR( const value: uint8 );
    function getCarryFlag: boolean;
    procedure setCarryFlag( const value: boolean );
    function getZeroFlag: boolean;
    procedure setZeroFlag( const value: boolean );
    function getIRQDisableFlag: boolean;
    procedure setIRQDisableFlag( const value: boolean );
    function getDecimalModeFlag: boolean;
    procedure setDecimalModeFlag( const value: boolean );
    function getBreakFlag: boolean;
    procedure setBreakFlag( const value: boolean );
    function getOverflowFlag: boolean;
    procedure setOverflowFlag( const value: boolean );
    function getNegativeFlag: boolean;
    procedure setNegativeFlag( const value: boolean );
    function getOnLatch: TLatchEvent;
    procedure setOnLatch( const value: TLatchEvent );
  public
    constructor Create( const VirtualMemory: I6502VirtualMemory ); reintroduce;
    destructor Destroy; override;
  end;


implementation
uses
  cwTypes
;

const
  cLatchAddress = $0001;

const //- flag masks for processor status register.
  cCarryFlag    = $01;       // bit 0
  cZeroFlag     = $01 shl 1; // bit 1
  cIRQDisable   = $01 shl 2; // bit 2
  cDecimalMode  = $01 shl 3; // bit 3
  cBreakCommand = $01 shl 4; // bit 4
  cOverflowFlag = $01 shl 6; // bit 6
  cNegativeFlag = $01 shl 7; // bit 7

const
  cBit7 = $01 shl 7;
  cBit6 = $01 shl 6;
  cBit5 = $01 shl 5;
  cBit4 = $01 shl 4;
  cBit3 = $01 shl 3;
  cBit2 = $01 shl 2;
  cBit1 = $01 shl 1;
  cBit0 = $01;

{$region ' Addressing modes retruned as real pointer to target'}

function realpointer( const State: T6502State; const Address: uint16 ): pointer; inline;
begin
  {$hints off}
    Result := pointer(State.MemoryMap[(Address shr $08)]+(Address and $00FF));
  {$hints on}
end;

function ptr_A( const State: T6502State ): pointer; inline;
begin
  Result := @State.A;
end;

function ptr_abs( const State: T6502State ): pointer; inline;
var
  pEffectiveAddress: ^uint16;
begin
  pEffectiveAddress := RealPointer( State, State.PC );
  pEffectiveAddress := RealPointer( State, pEffectiveAddress^ );
  Result := pEffectiveAddress;
end;

function ptr_abs_x( const State: T6502State ): pointer; inline;
var
  pEffectiveAddress: ^uint16;
begin
  pEffectiveAddress := RealPointer( State, State.PC );
  pEffectiveAddress := RealPointer( State, pEffectiveAddress^+State.X );
  Result := pEffectiveAddress;
end;

function ptr_abs_y( const State: T6502State ): pointer; inline;
var
  pEffectiveAddress: ^uint16;
begin
  pEffectiveAddress := RealPointer( State, State.PC );
  pEffectiveAddress := RealPointer( State, pEffectiveAddress^+State.Y );
  Result := pEffectiveAddress;
end;

function ptr_imm( const State: T6502State ): pointer; inline;
begin
  Result := RealPointer( State, State.PC );
end;

function ptr_ind( const State: T6502State ): pointer; inline;
var
  pEffectiveAddress: ^uint16;
begin
  pEffectiveAddress := RealPointer( State, State.PC );
  pEffectiveAddress := RealPointer( State, pEffectiveAddress^ );
  pEffectiveAddress := RealPointer( State, pEffectiveAddress^ );
  Result := pEffectiveAddress;
end;

function ptr_x_ind( const State: T6502State ): pointer; inline;
var
  pByte: ^uint8;
  W: uint16;
begin
  pByte := RealPointer( State, State.PC );
  W := pByte^;
  W := W and $FF;
  W := uint16(RealPointer( State, W + State.X )^);
  Result := RealPointer( State, W  );
end;

function ptr_ind_y( const State: T6502State ): pointer; inline;
var
  pByte: ^uint8;
  W: uint16;
begin
  pByte := RealPointer( State, State.PC );
  W := pByte^;
  W := W and $FF;
  W := uint16(RealPointer( State, W )^);
  Result := RealPointer( State, W + State.Y );
end;


function ptr_rel( const State: T6502State ): pointer; inline;
var
  pByte: ^int8;
begin
  pByte := RealPointer( State, State.PC );
  Result := RealPointer( State, State.PC + pByte^ );
end;

function ptr_zpg( const State: T6502State ): pointer; inline;
var
  pByte: ^uint8;
  W: uint16;
begin
  pByte := RealPointer( State, State.PC );
  W := pByte^;
  W := W and $FF;
  Result := RealPointer( State, W );
end;

function ptr_zpg_x( const State: T6502State ): pointer; inline;
var
  pByte: ^uint8;
  W: uint16;
begin
  pByte := RealPointer( State, State.PC );
  W := pByte^;
  W := W + State.X;
  W := W and $FF;
  Result := RealPointer( State, W );
end;

function ptr_zpg_y( const State: T6502State ): pointer; inline;
var
  pByte: ^uint8;
  W: uint16;
begin
  pByte := RealPointer( State, State.PC );
  W := pByte^;
  W := W + State.Y;
  W := W and $FF;
  Result := RealPointer( State, W );
end;

{$endregion}

{$region ' Increments of program counter based on addressing mode'}

procedure inc_abs( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint16);
end;

procedure inc_abs_x( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint16);
end;

procedure inc_abs_y( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint16);
end;

procedure inc_imm( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint8);
end;

procedure inc_ind( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint16);
end;

procedure inc_ind_y( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint8);
end;

procedure inc_x_ind( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint8);
end;

procedure inc_zpg( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint8);
end;

procedure inc_zpg_x( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint8);
end;

procedure inc_zpg_y( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint8);
end;

procedure inc_rel( var State: T6502State ); inline;
begin
  State.PC := State.PC + sizeof(uint8);
end;

{$endregion}

{$region ' Arithmetic operations - Addition and Subtraction with Carry/Borrow'}

function negate( const value: uint8 ): uint8; inline;
begin
  Result := not value;
  inc(Result);
end;

procedure instr_ADC( var State: T6502State; const l, r: pByte; const saveProduct: boolean = TRUE ); inline;
var
  cf: boolean;
  lowNibbleR: uint8;
  highNibbleR: uint8;
  lowNibbleA: uint8;
  highNibbleA: uint8;
  lowNibbleP: uint8;
  highNibbleP: uint8;
  product: uint8;
begin
  //- Store cf for later and clear.
  cf := (State.SR and cCarryFlag) = cCarryFlag;
  State.SR := State.SR and (not cCarryFlag);

  //- Get low and high nibble of each piece of the addition.
  lowNibbleR := r^ and $0F;
  highNibbleR := r^ shr 4;
  lowNibbleA := l^ and $0F;
  highNibbleA := l^ shr 4;

  //- Perform nibble-wize addition
  lowNibbleP := lowNibbleA + lowNibbleR;
  highNibbleP := highNibbleA + highNibbleR;

  //- If low nibble carried, add it to the high nibble.
  if lowNibbleP>$F then begin
    highNibbleP := highNibbleP + 1;
    lowNibbleP := lowNibbleP xor $10;
  end;

  //- Did high nibble carry?
  if highNibbleP>$F then begin
    State.SR := State.SR or cCarryFlag;
    highNibbleP := highNibbleP xor $10;
  end;

  //- Reassemble
  highNibbleP := highNibbleP shl 4;
  Product := highNibbleP or lowNibbleP;

  //- if cf carried in, increment result.
  if cf then begin
    inc(Product);
    if (Product)=$00 then begin
      State.SR := State.SR or cCarryFlag;
    end;
  end;

  // ADC does not necessarily alter 'A', sometimes just the flags are needed :-)
  if saveProduct then begin
    l^ := Product;
  end;
end;

procedure instr_SBC( var State: T6502State; const l, r: pByte; const saveProduct: boolean = TRUE ); inline;
var
  nr: uint8;
begin
  nr := negate( r^ );
  instr_ADC( State, l, @nr, saveProduct );
end;

{$endregion}

{$region ' Stack operations '}

procedure pushbyte( var State: T6502State; const v: pByte ); inline;
var
  pStack: ^uint8;
begin
  pStack := RealPointer( State, ($01 and State.SP) );
  pStack^ := v^;
  dec(State.SP);
end;

procedure pushword( var State: T6502State; const v: pWord ); inline;
var
  pStack: ^uint16;
begin
  pStack := RealPointer( State, ($01 and State.SP) );
  pStack^ := v^;
  dec(State.SP,2);
end;

procedure popbyte( var State: T6502State; const v: pByte ); inline;
var
  pStack: ^uint8;
begin
  inc(State.SP);
  pStack := RealPointer( State, ($01 and State.SP) );
  v^ := pStack^;
end;

procedure popword( var State: T6502State; const v: pWord ); inline;
var
  pStack: ^uint16;
begin
  inc(State.SP);
  pStack := RealPointer( State, ($01 and State.SP) );
  v^ := pStack^;
end;

{$endregion}

{$region ' Roll operations '}

procedure rol( var State: T6502State; const v: pbyte ); inline;
var
  cf: boolean;
begin
  cf := (State.SR and cCarryFlag) = cCarryFlag;
  State.SR := State.SR and (not cCarryFlag);
  if (v^ and cBit7) = cBit7 then begin
    State.SR := State.SR or 1;
  end;
  v^ := v^ shl 1;
  if cf then begin
    v^ := v^ or 1;
  end;
end;

procedure ror( var State: T6502State; const v: pbyte ); inline;
var
  cf: boolean;
begin
  cf := (State.SR and cCarryFlag) = cCarryFlag;
  State.SR := State.SR and (not cCarryFlag);
  if (v^ and cBit0) = cBit0 then begin
    State.SR := State.SR or 1;
  end;
  v^ := v^ shr 1;
  if cf then begin
    v^ := v^ or cBit7;
  end;
end;

{$endregion}

{$region ' 6502 Instruction Handlers'}
  //- 54 instructions
  //- 151 variations.

  {$region 'ADC'}
  procedure HandleADC_abs_x( var State: T6502State );
  begin
    instr_ADC( State, @State.A, ptr_abs_x(State) );
    inc_abs_x(State);
  end;

  procedure HandleADC_abs_y( var State: T6502State );
  begin
    instr_ADC( State, @State.A, ptr_abs_y(State) );
    inc_abs_y(State);
  end;

  procedure HandleADC_abs( var State: T6502State );
  begin
    instr_ADC( State, @State.A, ptr_abs(State) );
    inc_abs(State);
  end;

  procedure HandleADC_imm( var State: T6502State );
  begin
    instr_ADC( State, @State.A, ptr_imm(State) );
    inc_imm(State);
  end;

  procedure HandleADC_ind_y( var State: T6502State );
  begin
    instr_ADC( State, @State.A, ptr_ind_y(State) );
    inc_ind_y(State);
  end;

  procedure HandleADC_x_ind( var State: T6502State );
  begin
    instr_ADC( State, @State.A, ptr_x_ind(State) );
    inc_x_ind(State);
  end;

  procedure HandleADC_zpg_x( var State: T6502State );
  begin
    instr_ADC( State, @State.A, ptr_zpg_x(State) );
    inc_zpg_x(State);
  end;

  procedure HandleADC_zpg( var State: T6502State );
  begin
    instr_ADC( State, @State.A, ptr_zpg(State) );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'AND'}
  procedure HandleAND_abs_x( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_abs_x(State);
    State.A := State.A and b^;
    inc_abs_x(State);
  end;

  procedure HandleAND_abs_y( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_abs_y(State);
    State.A := State.A and b^;
    inc_abs_y(State);
  end;

  procedure HandleAND_abs( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_abs(State);
    State.A := State.A and b^;
    inc_abs(State);
  end;

  procedure HandleAND_imm( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_imm(State);
    State.A := State.A and b^;
    inc_imm(State);
  end;

  procedure HandleAND_ind_y( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_ind_y(State);
    State.A := State.A and b^;
    inc_ind_y(State);
  end;

  procedure HandleAND_x_ind( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_x_ind(State);
    State.A := State.A and b^;
    inc_x_ind(State);
  end;

  procedure HandleAND_zpg_x( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_zpg_x(State);
    State.A := State.A and b^;
    inc_zpg_x(State);
  end;

  procedure HandleAND_zpg( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_zpg(State);
    State.A := State.A and b^;
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'ASL'}
  procedure HandleASL_a( var State: T6502State );
  begin
    State.SR := State.SR and (not cCarryFlag);
    State.SR := State.SR or ((State.A and cBit7) shr 7);
    State.A := State.A shl 1;
  end;

  procedure HandleASL_abs_x( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_abs_x(State);
    State.SR := State.SR and (not cCarryFlag);
    State.SR := ((b^ and cBit7) shr 7);
    b^ := b^ shl 1;
    inc_abs_x(State);
  end;

  procedure HandleASL_abs( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_abs(State);
    State.SR := State.SR and (not cCarryFlag);
    State.SR := ((b^ and cBit7) shr 7);
    b^ := b^ shl 1;
    inc_abs(State);
  end;

  procedure HandleASL_zpg_x( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_zpg_x(State);
    State.SR := State.SR and (not cCarryFlag);
    State.SR := ((b^ and cBit7) shr 7);
    b^ := b^ shl 1;
    inc_zpg_x(State);
  end;

  procedure HandleASL_zpg( var State: T6502State );
  var
    b: pByte;
  begin
    b := ptr_zpg_x(State);
    State.SR := State.SR and (not cCarryFlag);
    State.SR := ((b^ and cBit7) shr 7);
    b^ := b^ shl 1;
    inc_zpg_x(State);
  end;
  {$endregion}

  {$region 'BCC'}
  procedure HandleBCC_rel( var State: T6502State );
  var
    p: ^int8;
  begin
    p := ptr_rel(State);
    inc_rel(State);
    if (State.SR and cCarryFlag)<>cCarryFlag then begin
      State.PC := State.PC + p^;
    end;
  end;
  {$endregion}

  {$region 'BCS'}
  procedure HandleBCS_rel( var State: T6502State );
  var
    p: ^int8;
  begin
    p := ptr_rel(State);
    inc_rel(State);
    if (State.SR and cCarryFlag)=cCarryFlag then begin
      State.PC := State.PC + p^;
    end;
  end;
  {$endregion}

  {$region 'BEQ'}
  procedure HandleBEQ_rel( var State: T6502State );
  var
    p: ^int8;
  begin
    p := ptr_rel(State);
    inc_rel(State);
    if (State.SR and cZeroFlag)=cZeroFlag then begin
      State.PC := State.PC + p^;
    end;
  end;
  {$endregion}

  {$region 'BIT'}
  procedure HandleBIT_abs( var State: T6502State );
  var
    pOperand: ^int8;
  begin
    // BIT  Test Bits in Memory with Accumulator
    // bits 7 and 6 of operand are transfered to bit 7 and 6 of SR (N,V);
    // the zeroflag is set to the result of operand AND accumulator.
    pOperand := ptr_abs(State);
    inc_abs(State);
    if (pOperand^ AND State.A)=0 then begin
      State.SR := State.SR and (not cZeroFlag);
    end else begin
      State.SR := State.SR or cZeroFlag;
    end;
    State.SR := State.SR and $3F;
    State.SR := State.SR or (pOperand^ and $C0);
  end;

  procedure HandleBIT_zpg( var State: T6502State );
  var
    pOperand: ^int8;
  begin
    // BIT  Test Bits in Memory with Accumulator
    // bits 7 and 6 of operand are transfered to bit 7 and 6 of SR (N,V);
    // the zeroflag is set to the result of operand AND accumulator.
    pOperand := ptr_zpg(State);
    inc_zpg(State);
    if (pOperand^ AND State.A)=0 then begin
      State.SR := State.SR and (not cZeroFlag);
    end else begin
      State.SR := State.SR or cZeroFlag;
    end;
    State.SR := State.SR and $3F;
    State.SR := State.SR or (pOperand^ and $C0);
  end;

  {$endregion}

  {$region 'BMI'}
  procedure HandleBMI_rel( var State: T6502State );
  var
    p: ^int8;
  begin
    p := ptr_rel(State);
    inc_rel(State);
    if (State.SR and cNegativeFlag)=cNegativeFlag then begin
      State.PC := State.PC + p^;
    end;
  end;
  {$endregion}

  {$region 'BNE'}
  procedure HandleBNE_rel( var State: T6502State );
  var
    p: ^int8;
  begin
    p := ptr_rel(State);
    inc_rel(State);
    if (State.SR and cZeroFlag)<>cZeroFlag then begin
      State.PC := State.PC + p^;
    end;
  end;
  {$endregion}

  {$region 'BPL'}
  procedure HandleBPL_rel( var State: T6502State );
  var
    p: ^int8;
  begin
    p := ptr_rel(State);
    inc_rel(State);
    if (State.SR and cNegativeFlag)<>cNegativeFlag then begin
      State.PC := State.PC + p^;
    end;
  end;
  {$endregion}

  {$region 'BRK'}
  procedure HandleBRK( var State: T6502State );
  begin
    State.SR := State.SR or cBreakCommand;
  end;
  {$endregion}

  {$region 'BVC'}
  procedure HandleBVC_rel( var State: T6502State );
  var
    p: ^int8;
  begin
    p := ptr_rel(State);
    inc_rel(State);
    if (State.SR and cOverflowFlag)<>cOverflowFlag then begin
      State.PC := State.PC + p^;
    end;
  end;
  {$endregion}

  {$region 'BVS'}
  procedure HandleBVS_rel( var State: T6502State );
  var
    p: ^int8;
  begin
    p := ptr_rel(State);
    inc_rel(State);
    if (State.SR and cOverflowFlag)=cOverflowFlag then begin
      State.PC := State.PC + p^;
    end;
  end;
  {$endregion}

  {$region 'CLC'}
  procedure HandleCLC( var State: T6502State );
  begin
    State.SR := State.SR and (not cCarryFlag);
  end;
  {$endregion}

  {$region 'CLD'}
  procedure HandleCLD( var State: T6502State );
  begin
    State.SR := State.SR and (not cDecimalMode);
  end;
  {$endregion}

  {$region 'CLI'}
  procedure HandleCLI( var State: T6502State );
  begin
    State.SR := State.SR and (not cIRQDisable);
  end;
  {$endregion}

  {$region 'CLV'}
  procedure HandleCLV( var State: T6502State );
  begin
    State.SR := State.SR and (not cOverflowFlag);
  end;
  {$endregion}

  {$region 'CMP'}
  procedure HandleCMP_abs_x( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_abs_x(State), FALSE );
    inc_abs_x(State);
  end;

  procedure HandleCMP_abs_y( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_abs_y(State), FALSE );
    inc_abs_y(State);
  end;

  procedure HandleCMP_abs( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_abs(State), FALSE );
    inc_abs(State);
  end;

  procedure HandleCMP_imm( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_imm(State), FALSE );
    inc_imm(State);
  end;

  procedure HandleCMP_ind_y( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_ind_y(State), FALSE );
    inc_ind_y(State);
  end;

  procedure HandleCMP_x_ind( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_x_ind(State), FALSE );
    inc_x_ind(State);
  end;

  procedure HandleCMP_zpg_x( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_zpg_x(State), FALSE );
    inc_zpg_x(State);
  end;

  procedure HandleCMP_zpg( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_zpg(State), FALSE );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'CPX'}
  procedure HandleCPX_abs( var State: T6502State );
  begin
    instr_SBC( State, @State.X, ptr_abs(State), FALSE );
    inc_abs(State);
  end;

  procedure HandleCPX_imm( var State: T6502State );
  begin
    instr_SBC( State, @State.X, ptr_imm(State), FALSE );
    inc_imm(State);
  end;

  procedure HandleCPX_zpg( var State: T6502State );
  begin
    instr_SBC( State, @State.X, ptr_zpg(State), FALSE );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'CPY'}
  procedure HandleCPY_abs( var State: T6502State );
  begin
    instr_SBC( State, @State.Y, ptr_abs(State), FALSE );
    inc_abs(State);
  end;

  procedure HandleCPY_imm( var State: T6502State );
  begin
    instr_SBC( State, @State.Y, ptr_imm(State), FALSE );
    inc_imm(State);
  end;

  procedure HandleCPY_zpg( var State: T6502State );
  begin
    instr_SBC( State, @State.Y, ptr_zpg(State), FALSE );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'DEC'}
  procedure HandleDEC_abs_x( var State: T6502State );
  begin
    dec( uint8(ptr_abs_x(State)^) );
    inc_abs_x(State);
  end;

  procedure HandleDEC_abs( var State: T6502State );
  begin
    dec( uint8(ptr_abs(State)^) );
    inc_abs(State);
  end;

  procedure HandleDEC_zpg_x( var State: T6502State );
  begin
    dec( uint8(ptr_zpg_x(State)^) );
    inc_zpg_x(State);
  end;

  procedure HandleDEC_zpg( var State: T6502State );
  begin
    dec( uint8(ptr_zpg(State)^) );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'DEX'}
  procedure HandleDEX( var State: T6502State );
  begin
    dec(State.X);
  end;
  {$endregion}

  {$region 'DEY'}
  procedure HandleDEY( var State: T6502State );
  begin
    dec(State.Y);
  end;
  {$endregion}

  {$region 'EOR'}
  procedure HandleEOR_abs_X( var State: T6502State );
  begin
    State.A := State.A xor uint8( ptr_abs_x(State)^ );
    inc_abs_x(State);
  end;

  procedure HandleEOR_abs_y( var State: T6502State );
  begin
    State.A := State.A xor uint8( ptr_abs_y(State)^ );
    inc_abs_y(State);
  end;

  procedure HandleEOR_abs( var State: T6502State );
  begin
    State.A := State.A xor uint8( ptr_abs(State)^ );
    inc_abs(State);
  end;

  procedure HandleEOR_imm( var State: T6502State );
  begin
    State.A := State.A xor uint8( ptr_imm(State)^ );
    inc_imm(State);
  end;

  procedure HandleEOR_ind_y( var State: T6502State );
  begin
    State.A := State.A xor uint8( ptr_ind_y(State)^ );
    inc_ind_y(State);
  end;

  procedure HandleEOR_x_ind( var State: T6502State );
  begin
    State.A := State.A xor uint8( ptr_ind(State)^ );
    inc_ind(State);
  end;

  procedure HandleEOR_zpg_x( var State: T6502State );
  begin
    State.A := State.A xor uint8( ptr_zpg_x(State)^ );
    inc_zpg_x(State);
  end;

  procedure HandleEOR_zpg( var State: T6502State );
  begin
    State.A := State.A xor uint8( ptr_zpg_x(State)^ );
    inc_zpg_x(State);
  end;
  {$endregion}

  {$region 'INC'}
  procedure HandleINC_abs_X( var State: T6502State );
  begin
    inc( uint8(ptr_abs_x(State)^) );
    inc_abs_x(State);
  end;

  procedure HandleINC_abs( var State: T6502State );
  begin
    inc( uint8(ptr_abs(State)^) );
    inc_abs(State);
  end;

  procedure HandleINC_zpg_x( var State: T6502State );
  begin
    inc( uint8(ptr_zpg_x(State)^) );
    inc_zpg_x(State);
  end;

  procedure HandleINC_zpg( var State: T6502State );
  begin
    inc( uint8(ptr_zpg(State)^) );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'INX'}
  procedure HandleINX( var State: T6502State );
  begin
    inc( State.X );
  end;
  {$endregion}

  {$region 'INY'}
  procedure HandleINY( var State: T6502State );
  begin
    inc( State.Y );
  end;
  {$endregion}

  {$region 'JMP'}
  procedure HandleJMP_abs( var State: T6502State );
  begin
    State.PC := uint16(ptr_abs(State)^);
  end;

  procedure HandleJMP_ind( var State: T6502State );
  begin
    State.PC := uint16(ptr_ind(State)^);
  end;
  {$endregion}

  {$region 'JSR'}
  procedure HandleJSR_abs( var State: T6502State );
  begin
    pushword(State, @State.PC);
    State.PC := uint16(ptr_abs(State)^);
  end;
  {$endregion}

  {$region 'LDA'}
  procedure HandleLDA_abs_x( var State: T6502State );
  begin
    State.A := uint8(ptr_abs_x(State)^);
    inc_abs_x(State);
  end;

  procedure HandleLDA_abs_y( var State: T6502State );
  begin
    State.A := uint8(ptr_abs_y(State)^);
    inc_abs_y(State);
  end;

  procedure HandleLDA_abs( var State: T6502State );
  begin
    State.A := uint8(ptr_abs(State)^);
    inc_abs(State);
  end;

  procedure HandleLDA_imm( var State: T6502State );
  begin
    State.A := uint8(ptr_imm(State)^);
    inc_imm(State);
  end;

  procedure HandleLDA_ind_y( var State: T6502State );
  begin
    State.A := uint8(ptr_ind_y(State)^);
    inc_ind_y(State);
  end;

  procedure HandleLDA_x_ind( var State: T6502State );
  begin
    State.A := uint8(ptr_x_ind(State)^);
    inc_x_ind(State);
  end;

  procedure HandleLDA_zpg_x( var State: T6502State );
  begin
    State.A := uint8(ptr_zpg_x(State)^);
    inc_zpg_x(State);
  end;

  procedure HandleLDA_zpg( var State: T6502State );
  begin
    State.A := uint8(ptr_zpg(State)^);
    inc_zpg_x(State);
  end;
  {$endregion}

  {$region 'LDX'}
  procedure HandleLDX_zpg( var State: T6502State );
  begin
    State.X := uint8(ptr_zpg(State)^);
    inc_zpg(State);
  end;

  procedure HandleLDX_abs_y( var State: T6502State );
  begin
    State.X := uint8(ptr_abs_y(State)^);
    inc_abs_y(State);
  end;

  procedure HandleLDX_abs( var State: T6502State );
  begin
    State.X := uint8(ptr_abs(State)^);
    inc_abs(State);
  end;

  procedure HandleLDX_imm( var State: T6502State );
  begin
    State.X := uint8(ptr_imm(State)^);
    inc_imm(State);
  end;

  procedure HandleLDX_zpg_y( var State: T6502State );
  begin
    State.X := uint8(ptr_zpg_y(State)^);
    inc_zpg_y(State);
  end;
  {$endregion}

  {$region 'LDY'}
  procedure HandleLDY_abs_x( var State: T6502State );
  begin
    State.Y := uint8(ptr_abs_x(State)^);
    inc_abs_x(State);
  end;

  procedure HandleLDY_abs( var State: T6502State );
  begin
    State.Y := uint8(ptr_abs(State)^);
    inc_abs(State);
  end;

  procedure HandleLDY_imm( var State: T6502State );
  begin
    State.Y := uint8(ptr_imm(State)^);
    inc_imm(State);
  end;

  procedure HandleLDY_zpg_x( var State: T6502State );
  begin
    State.Y := uint8(ptr_zpg_x(State)^);
    inc_zpg_x(State);
  end;

  procedure HandleLDY_zpg( var State: T6502State );
  begin
    State.Y := uint8(ptr_zpg(State)^);
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'LSR'}
  procedure HandleLSR_a( var State: T6502State );
  begin
  end;

  procedure HandleLSR_abs_X( var State: T6502State );
  begin
    State.PC := State.PC + sizeof(uint16);
  end;

  procedure HandleLSR_abs( var State: T6502State );
  begin
    State.PC := State.PC + sizeof(uint16);
  end;

  procedure HandleLSR_zpg_x( var State: T6502State );
  begin
    State.PC := State.PC + sizeof(uint8);
  end;

  procedure HandleLSR_zpg( var State: T6502State );
  begin
    State.PC := State.PC + sizeof(uint8);
  end;
  {$endregion}

  {$region 'NOP'}
  procedure HandleNOP( var State: T6502State );
  begin
  end;
  {$endregion}

  {$region 'ORA'}
  procedure HandleORA_abs_x( var State: T6502State );
  begin
    State.A := State.A or uint8( ptr_abs_x(State)^ );
    inc_abs_x(State);
  end;

  procedure HandleORA_abs_y( var State: T6502State );
  begin
    State.A := State.A or uint8( ptr_abs_y(State)^ );
    inc_abs_y(State);
  end;

  procedure HandleORA_abs( var State: T6502State );
  begin
    State.A := State.A or uint8( ptr_abs(State)^ );
    inc_abs(State);
  end;

  procedure HandleORA_imm( var State: T6502State );
  begin
    State.A := State.A or uint8( ptr_imm(State)^ );
    inc_imm(State);
  end;

  procedure HandleORA_ind_y( var State: T6502State );
  begin
    State.A := State.A or uint8( ptr_ind_y(State)^ );
    inc_ind_y(State);
  end;

  procedure HandleORA_x_ind( var State: T6502State );
  begin
    State.A := State.A or uint8( ptr_x_ind(State)^ );
    inc_x_ind(State);
  end;

  procedure HandleORA_zpg_x( var State: T6502State );
  begin
    State.A := State.A or uint8( ptr_zpg_x(State)^ );
    inc_zpg_y(State);
  end;

  procedure HandleORA_zpg( var State: T6502State );
  begin
    State.A := State.A or uint8( ptr_zpg(State)^ );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'PHA'}
  procedure HandlePHA( var State: T6502State );
  begin
    pushbyte(State, @State.A);
  end;
  {$endregion}

  {$region 'PHP'}
  procedure HandlePHP( var State: T6502State );
  begin
    pushbyte(State, @State.SR);
  end;
  {$endregion}

  {$region 'PLA'}
  procedure HandlePLA( var State: T6502State );
  begin
    popbyte(State, @State.A);
  end;
  {$endregion}

  {$region 'PLP'}
  procedure HandlePLP( var State: T6502State );
  begin
    popbyte(State, @State.SR);
  end;
  {$endregion}

  {$region 'ROL'}
  procedure HandleROL_A( var State: T6502State );
  begin
    rol(State, @State.A);
  end;

  procedure HandleROL_abs_x( var State: T6502State );
  begin
    rol( State, ptr_abs_x(State) );
    inc_abs_x(State);
  end;

  procedure HandleROL_abs( var State: T6502State );
  begin
    rol( State, ptr_abs(State) );
    inc_abs(State);
  end;

  procedure HandleROL_zpg_x( var State: T6502State );
  begin
    rol( State, ptr_zpg_x(State) );
    inc_zpg_x(State);
  end;

  procedure HandleROL_zpg( var State: T6502State );
  begin
    rol( State, ptr_zpg(State) );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'ROR'}
  procedure HandleROR_a( var State: T6502State );
  begin
    ror( State, @State.A );
  end;

  procedure HandleROR_abs_x( var State: T6502State );
  begin
    ror( State, ptr_abs_x(State) );
    inc_abs_x(State);
  end;

  procedure HandleROR_abs( var State: T6502State );
  begin
    ror( State, ptr_abs(State) );
    inc_abs(State);
  end;

  procedure HandleROR_zpg_x( var State: T6502State );
  begin
    ror( State, ptr_zpg_x(State) );
    inc_zpg_x(State);
  end;

  procedure HandleROR_zpg( var State: T6502State );
  begin
    ror( State, ptr_zpg(State) );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'RTI'}
  procedure HandleRTI( var State: T6502State );
  begin
    popbyte( State, @State.SR );
    popword( State, @State.PC );
  end;
  {$endregion}

  {$region 'RTS'}
  procedure HandleRTS( var State: T6502State );
  begin
    popword( State, @State.PC );
  end;
  {$endregion}

  {$region 'SBC'}
  procedure HandleSBC_abs_x( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_abs_x(State) );
    inc_abs_x(State);
  end;

  procedure HandleSBC_abs_y( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_abs(State) );
    inc_abs(State);
  end;

  procedure HandleSBC_abs( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_abs(State) );
    inc_abs(State);
  end;

  procedure HandleSBC_imm( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_imm(State) );
    inc_imm(State);
  end;

  procedure HandleSBC_ind_y( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_ind_y(State) );
    inc_ind_y(State);
  end;

  procedure HandleSBC_x_ind( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_x_ind(State) );
    inc_x_ind(State);
  end;

  procedure HandleSBC_zpg_x( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_zpg_x(State) );
    inc_zpg_x(State);
  end;

  procedure HandleSBC_zpg( var State: T6502State );
  begin
    instr_SBC( State, @State.A, ptr_zpg(State) );
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'SEC'}
  procedure HandleSEC( var State: T6502State );
  begin
    State.SR := State.SR and cCarryFlag;
  end;
  {$endregion}

  {$region 'SED'}
  procedure HandleSED( var State: T6502State );
  begin
    State.SR := State.SR and cDecimalMode;
  end;
  {$endregion}

  {$region 'SEI'}
  procedure HandleSEI( var State: T6502State );
  begin
    State.SR := State.SR and cIRQDisable
  end;
  {$endregion}

  {$region 'STA'}
  procedure HandleSTA_abs_x( var State: T6502State );
  begin
    uint8(ptr_abs_x(State)^) := State.A;
    inc_abs_x(State);
  end;

  procedure HandleSTA_abs_y( var State: T6502State );
  begin
    uint8(ptr_abs_y(State)^) := State.A;
    inc_abs_y(State);
  end;

  procedure HandleSTA_abs( var State: T6502State );
  begin
    uint8(ptr_abs(State)^) := State.A;
    inc_abs(State);
  end;

  procedure HandleSTA_ind_y( var State: T6502State );
  begin
    uint8(ptr_ind_y(State)^) := State.A;
    inc_ind_y(State);
  end;

  procedure HandleSTA_x_ind( var State: T6502State );
  begin
    uint8(ptr_x_ind(State)^) := State.A;
    inc_x_ind(State);
  end;

  procedure HandleSTA_zpg_x( var State: T6502State );
  begin
    uint8(ptr_zpg_x(State)^) := State.A;
    inc_zpg_x(State);
  end;

  procedure HandleSTA_zpg( var State: T6502State );
  begin
    uint8(ptr_zpg(State)^) := State.A;
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'STX'}
  procedure HandleSTX_abs( var State: T6502State );
  begin
    uint8(ptr_abs(State)^) := State.X;
    inc_abs(State);
  end;

  procedure HandleSTX_zpg_y( var State: T6502State );
  begin
    uint8(ptr_zpg_y(State)^) := State.X;
    inc_zpg_y(State);
  end;

  procedure HandleSTX_zpg( var State: T6502State );
  begin
    uint8(ptr_zpg(State)^) := State.X;
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'STY'}
  procedure HandleSTY_abs( var State: T6502State );
  begin
    uint8(ptr_abs(State)^) := State.Y;
    inc_abs(State);
  end;

  procedure HandleSTY_zpg_x( var State: T6502State );
  begin
    uint8(ptr_zpg_x(State)^) := State.Y;
    inc_zpg_x(State);
  end;

  procedure HandleSTY_zpg( var State: T6502State );
  begin
    uint8(ptr_zpg(State)^) := State.Y;
    inc_zpg(State);
  end;
  {$endregion}

  {$region 'TAX'}
  procedure HandleTAX( var State: T6502State );
  begin
    State.X := State.A;
  end;
  {$endregion}

  {$region 'TAY'}
  procedure HandleTAY( var State: T6502State );
  begin
    State.Y := State.A;
  end;
  {$endregion}

  {$region 'TSX'}
  procedure HandleTSX( var State: T6502State );
  begin
    State.X := State.SP;
  end;
  {$endregion}

  {$region 'TXA'}
  procedure HandleTXA( var State: T6502State );
  begin
    State.A := State.X;
  end;
  {$endregion}

  {$region 'TXS'}
  procedure HandleTXS( var State: T6502State );
  begin
    State.SP := State.X;
  end;
  {$endregion}

  {$region 'TYA'}
  procedure HandleTYA( var State: T6502State );
  begin
    State.A := State.Y;
  end;
  {$endregion}

{$endregion}

{$region ' 6502 Instruction Set'}

type
  // 6502 instructions are all one byte
  TOpCode = uint8;
  pOpCode = ^TOpCode;

  // A callback function to handle execution of an instruction.
  TVMInstructionHandler = procedure( var State: T6502State );

const
  //- Our instruction set defined as an array of named handlers.
  cInstructionSet: array[0..255] of TVMInstructionHandler = (
    HandleBRK,       HandleORA_x_ind,  nil,           nil, nil,             HandleORA_zpg,   HandleASL_zpg,   nil,
    HandlePHP,       HandleORA_imm,    HandleASL_a,   nil, nil,             HandleORA_abs,   HandleASL_abs,   nil,
    HandleBPL_rel,   HandleORA_ind_y,  nil,           nil, nil,             HandleORA_zpg_x, HandleASL_zpg_x, nil,
    HandleCLC,       HandleORA_abs_y,  nil,           nil, nil,             HandleORA_abs_x, HandleASL_abs_x, nil,
    HandleJSR_abs,   HandleAND_x_ind,  nil,           nil, HandleBIT_zpg,   HandleAND_zpg,   HandleROL_zpg,   nil,
    HandlePLP,       HandleAND_imm,    HandleROL_A,   nil, HandleBIT_abs,   HandleAND_abs,   HandleROL_abs,   nil,
    HandleBMI_rel,   HandleAND_ind_y,  nil,           nil, nil,             HandleAND_zpg_x, HandleROL_zpg_x, nil,
    HandleSEC,       HandleAND_abs_Y,  nil,           nil, nil,             HandleAND_abs_x, HandleROL_abs_x, nil,
    HandleRTI,       HandleEOR_X_ind,  nil,           nil, nil,             HandleEOR_zpg,   HandleLSR_zpg,   nil,
    HandlePHA,       HandleEOR_imm,    HandleLSR_a,   nil, HandleJMP_abs,   HandleEOR_abs,   HandleLSR_abs,   nil,
    HandleBVC_rel,   HandleEOR_ind_Y,  nil,           nil, nil,             HandleEOR_zpg_x, HandleLSR_zpg_x, nil,
    HandleCLI,       HandleEOR_abs_y,  nil,           nil, nil,             HandleEOR_abs_X, HandleLSR_abs_X, nil,
    HandleRTS,       HandleADC_x_ind,  nil,           nil, nil,             HandleADC_zpg,   HandleROR_zpg,   nil,
    HandlePLA,       HandleADC_imm,    HandleROR_a,   nil, HandleJMP_ind,   HandleADC_abs,   HandleROR_abs,   nil,
    HandleBVS_rel,   HandleADC_ind_y,  nil,           nil, nil,             HandleADC_zpg_x, HandleROR_zpg_x, nil,
    HandleSEI,       HandleADC_abs_y,  nil,           nil, nil,             HandleADC_abs_x, HandleROR_abs_x, nil,
    nil,             HandleSTA_x_ind,  nil,           nil, HandleSTY_zpg,   HandleSTA_zpg,   HandleSTX_zpg,   nil,
    HandleDEY,       nil,              HandleTXA,     nil, HandleSTY_abs,   HandleSTA_abs,   HandleSTX_abs,   nil,
    HandleBCC_rel,   HandleSTA_ind_y,  nil,           nil, HandleSTY_zpg_x, HandleSTA_zpg_x, HandleSTX_zpg_Y, nil,
    HandleTYA,       HandleSTA_abs_y,  HandleTXS,     nil, nil,             HandleSTA_abs_x, nil,             nil,
    HandleLDY_imm,   HandleLDA_x_ind,  HandleLDX_imm, nil, HandleLDY_zpg,   HandleLDA_zpg,   HandleLDX_zpg,   nil,
    HandleTAY,       HandleLDA_imm,    HandleTAX,     nil, HandleLDY_abs,   HandleLDA_abs,   HandleLDX_abs,   nil,
    HandleBCS_rel,   HandleLDA_ind_y,  nil,           nil, HandleLDY_zpg_x, HandleLDA_zpg_X, HandleLDX_zpg_y, nil,
    HandleCLV,       HandleLDA_abs_y,  HandleTSX,     nil, HandleLDY_abs_x, HandleLDA_abs_x, HandleLDX_abs_y, nil,
    HandleCPY_imm,   HandleCMP_x_ind,  nil,           nil, HandleCPY_zpg,   HandleCMP_zpg,   HandleDEC_zpg,   nil,
    HandleINY,       HandleCMP_imm,    HandleDEX,     nil, HandleCPY_abs,   HandleCMP_abs,   HandleDEC_abs,   nil,
    HandleBNE_rel,   HandleCMP_ind_y,  nil,           nil, nil,             HandleCMP_zpg_x, HandleDEC_zpg_x, nil,
    HandleCLD,       HandleCMP_abs_y,  nil,           nil, nil,             HandleCMP_abs_x, HandleDEC_abs_X, nil,
    HandleCPX_imm,   HandleSBC_x_ind,  nil,           nil, HandleCPX_zpg,   HandleSBC_zpg,   HandleINC_zpg,   nil,
    HandleINX,       HandleSBC_imm,    HandleNOP,     nil, HandleCPX_abs,   HandleSBC_abs,   HandleINC_abs,   nil,
    HandleBEQ_rel,   HandleSBC_ind_y,  nil,           nil, nil,             HandleSBC_zpg_x, HandleINC_zpg_x, nil,
    HandleSED,       HandleSBC_abs_y,  nil,           nil, nil,             HandleSBC_abs_x, HandleINC_abs_X, nil
  );

{$endregion}

{$region ' T6502 class implementation'}

function T6502CPU.Clock: boolean;
var
  Handler: TVMInstructionHandler;
  OpCodePtr: pOpCode;
begin
  //- Do not allow overrun of byte-code
  if fState.PC > fState.Memory.DataSize then begin
    TStatus( stUnexpectedEndOfBytecode ).Raize;
  end;

  //- Fetch handler
  OpCodePtr := RealPointer(fState,fState.PC);
  Handler := cInstructionSet[ OpCodePtr^ ];
  //- Check for valid op-code
  if not assigned(Handler) then begin
    TStatus( stInvalidOpCode ).Raize;
  end;

  //- Increment program counter
  fState.PC := fState.PC + Sizeof(TOpCode);

  //- Execute Instruction;
  Handler(fState);

  //- Check for latch
  if assigned(fOnLatch) then begin
    if fLatchValue <> getLatchValue then begin
      try
        fOnLatch(getLatchValue,fState.Memory);
      finally
        SetLatchValue;
      end;
    end;
  end;

  //- Let VM know if the program can continue or has ended
  Result := TRUE;
end;

function T6502CPU.getPC: uint16;
begin
  Result := fState.PC;
end;

procedure T6502CPU.setPC(const value: uint16);
begin
  fState.PC := value;
end;

function T6502CPU.getA: uint8;
begin
  Result := fState.A;
end;

procedure T6502CPU.setA(const value: uint8);
begin
  fState.A := value;
end;

function T6502CPU.getX: uint8;
begin
  Result := fState.X;
end;

procedure T6502CPU.setX(const value: uint8);
begin
  fState.X := Value;
end;

function T6502CPU.getY: uint8;
begin
  Result := fState.Y;
end;

procedure T6502CPU.setY(const value: uint8);
begin
  fState.Y := Value;
end;

function T6502CPU.getSP: uint8;
begin
  Result := fState.SP;
end;

procedure T6502CPU.setSP(const value: uint8);
begin
  fState.SP := value;
end;

function T6502CPU.getSR: uint8;
begin
  Result := fState.SR;
end;

procedure T6502CPU.setSR(const value: uint8);
begin
  fState.SR := value;
end;

function T6502CPU.getCarryFlag: boolean;
begin
  Result := (fState.SR AND cCarryFlag)=cCarryFlag;
end;

procedure T6502CPU.setCarryFlag(const value: boolean);
begin
  if Value then begin
    fState.SR := fState.SR or cCarryFlag;
  end else begin
    fState.SR := fState.SR and (not cCarryFlag);
  end;
end;

function T6502CPU.getZeroFlag: boolean;
begin
  Result := (fState.SR AND cZeroFlag)=cZeroFlag;
end;

procedure T6502CPU.setZeroFlag(const value: boolean);
begin
  if value then begin
    fState.SR := fState.SR or cZeroFlag;
  end else begin
    fState.SR := fState.SR and (not cZeroFlag);
  end;
end;

function T6502CPU.getIRQDisableFlag: boolean;
begin
  Result := (fState.SR AND cIRQDisable)=cIRQDisable;
end;

procedure T6502CPU.setIRQDisableFlag(const value: boolean);
begin
  if value then begin
    fState.SR := fState.SR or cIRQDisable;
  end else begin
    fState.SR := fState.SR and (not cIRQDisable);
  end;
end;

function T6502CPU.getDecimalModeFlag: boolean;
begin
    Result := (fState.SR AND cDecimalMode)=cDecimalMode;
end;

procedure T6502CPU.setDecimalModeFlag(const value: boolean);
begin
  if value then begin
    fState.SR := fState.SR or cDecimalMode;
  end else begin
    fState.SR := fState.SR and (not cDecimalMode);
  end;
end;

function T6502CPU.getBreakFlag: boolean;
begin
  Result := (fState.SR AND cBreakCommand)=cBreakCommand;
end;

procedure T6502CPU.setBreakFlag(const value: boolean);
begin
  if value then begin
    fState.SR := fState.SR or cBreakCommand;
  end else begin
    fState.SR := fState.SR and (not cBreakCommand);
  end;
end;

function T6502CPU.getOverflowFlag: boolean;
begin
  Result := (fState.SR AND cOverflowFlag)=cOverflowFlag;
end;

procedure T6502CPU.setOverflowFlag(const value: boolean);
begin
  if value then begin
    fState.SR := fState.SR or cOverflowFlag;
  end else begin
    fState.SR := fState.SR and (not cOverflowFlag);
  end;
end;

function T6502CPU.getNegativeFlag: boolean;
begin
  Result := (fState.SR AND cNegativeFlag)=cNegativeFlag;
end;

procedure T6502CPU.setNegativeFlag(const value: boolean);
begin
  if value then begin
    fState.SR := fState.SR or cNegativeFlag;
  end else begin
    fState.SR := fState.SR and (not cNegativeFlag);
  end;
end;

function T6502CPU.getOnLatch: TLatchEvent;
begin
  Result := fOnLatch;
end;

procedure T6502CPU.setOnLatch(const value: TLatchEvent);
begin
  fOnLatch := value;
end;

constructor T6502CPU.Create(const VirtualMemory: I6502VirtualMemory);
begin
  inherited Create;
  fOnLatch := nil;
  fState.Memory := VirtualMemory;
  if not assigned(fState.Memory) then begin
    TStatus(stVirtualMemoryUnassigned).Raize;
  end;
  SetLatchValue;
  Reset( 0 );
end;

destructor T6502CPU.Destroy;
begin
  inherited Destroy;
end;

procedure T6502CPU.CopyMemoryMap;
var
  idx: nativeuint;
begin
  for idx := 0 to $FF do begin
    fState.MemoryMap[idx] := (fState.Memory.getDataPtr.AsNativeUInt + fState.Memory.Banks[idx]);
  end;
end;

procedure T6502CPU.SetLatchValue;
begin
  CopyMemoryMap;
  fLatchValue := uint16(RealPointer( fState, cLatchAddress )^);
end;

function T6502CPU.GetLatchValue;
begin
  Result := uint8(RealPointer( fState, cLatchAddress )^)
end;

procedure T6502CPU.Reset(const EntryPoint: nativeuint);
begin
  fState.A  := 0;
  fState.X  := 0;
  fState.Y  := 0;
  fState.SP := $FF;
  fState.SR := 0;
  fState.PC := 0;
  if EntryPoint>=fState.Memory.DataSize then exit;
  fState.PC := EntryPoint;
end;

{$endregion}

end.
