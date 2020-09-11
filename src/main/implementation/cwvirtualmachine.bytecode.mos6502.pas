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
unit cwVirtualMachine.ByteCode.Mos6502;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwVirtualMachine
, cwVirtualMachine.Mos6502
, cwVirtualMachine.Bytecode.Custom
;

type
  T6502ByteCode = class( TCustomBytecode, IBytecode, I6502Bytecode )
  strict private //- I6502Bytecode -//
    procedure ADC_abs_x ( const Address: uint16  );
    procedure ADC_abs_y ( const Address: uint16  );
    procedure ADC_abs   ( const Address: uint16  );
    procedure ADC_imm   ( const value: uint8     );
    procedure ADC_ind_y ( const Offset: uint8    );
    procedure ADC_x_ind ( const Offset: uint8    );
    procedure ADC_zpg_x ( const zpgOffset: uint8 );
    procedure ADC_zpg   ( const zpgOffset: uint8 );
    procedure AND_abs_x ( const Address: uint16  );
    procedure AND_abs_y ( const Address: uint16  );
    procedure AND_abs   ( const Address: uint16  );
    procedure AND_imm   ( const value: uint8     );
    procedure AND_ind_y ( const Offset: uint8    );
    procedure AND_x_ind ( const Offset: uint8    );
    procedure AND_zpg_x ( const zpgOffset: uint8 );
    procedure AND_zpg   ( const zpgOffset: uint8 );
    procedure ASL;
    procedure ASL_abs   ( const Address: uint16  );
    procedure ASL_abs_x ( const Address: uint16  );
    procedure ASL_zpg_x ( const zpgOffset: uint8 );
    procedure ASL_zpg   ( const zpgOffset: uint8 );
    procedure BCC_rel   ( const relative: uint8  );
    procedure BCS_rel   ( const relative: uint8  );
    procedure BEQ_rel   ( const relative: uint8  );
    procedure BIT_abs   ( const Address: uint16  );
    procedure BIT_zpg   ( const zpgOffset: uint8 );
    procedure BMI_rel   ( const relative: uint8  );
    procedure BNE_rel   ( const relative: uint8  );
    procedure BPL_rel   ( const relative: uint8  );
    procedure BRK;
    procedure BVC_rel   ( const relative: uint8  );
    procedure BVS_rel   ( const relative: uint8  );
    procedure CLC;
    procedure CLD;
    procedure CLI;
    procedure CLV;
    procedure CMP_abs_x ( const Address: uint16  );
    procedure CMP_abs_y ( const Address: uint16  );
    procedure CMP_abs   ( const Address: uint16  );
    procedure CMP_imm   ( const value: uint8     );
    procedure CMP_ind_y ( const Offset: uint8    );
    procedure CMP_x_ind ( const Offset: uint8    );
    procedure CMP_zpg_x ( const zpgOffset: uint8 );
    procedure CMP_zpg   ( const zpgOffset: uint8 );
    procedure CPX_abs   ( const Address: uint16  );
    procedure CPX_imm   ( const value: uint8     );
    procedure CPX_zpg   ( const zpgOffset: uint8 );
    procedure CPY_abs   ( const Address: uint16  );
    procedure CPY_imm   ( const value: uint8     );
    procedure CPY_zpg   ( const zpgOffset: uint8 );
    procedure DEC_abs_x ( const Address: uint16  );
    procedure DEC_abs   ( const Address: uint16  );
    procedure DEC_zpg_x ( const zpgOffset: uint8 );
    procedure DEC_zpg   ( const zpgOffset: uint8 );
    procedure DEX;
    procedure DEY;
    procedure EOR_abs_x ( const Address: uint16  );
    procedure EOR_abs_y ( const Address: uint16  );
    procedure EOR_abs   ( const Address: uint16  );
    procedure EOR_imm   ( const value: uint8     );
    procedure EOR_ind_y ( const Offset: uint8    );
    procedure EOR_X_ind ( const Offset: uint8    );
    procedure EOR_zpg_x ( const zpgOffset: uint8 );
    procedure EOR_zpg   ( const zpgOffset: uint8 );
    procedure INC_abs_x ( const Address: uint16  );
    procedure INC_abs   ( const Address: uint16  );
    procedure INC_zpg_x ( const zpgOffset: uint8 );
    procedure INC_zpg   ( const zpgOffset: uint8 );
    procedure INX;
    procedure INY;
    procedure JMP_abs   ( const Address: uint16  );
    procedure JMP_ind   ( const Address: uint16  );
    procedure JSR_abs   ( const Address: uint16  );
    procedure LDA_abs_x ( const Address: uint16  );
    procedure LDA_abs_y ( const Address: uint16  );
    procedure LDA_abs   ( const Address: uint16  );
    procedure LDA_imm   ( const value: uint8     );
    procedure LDA_ind_y ( const Offset: uint8    );
    procedure LDA_x_ind ( const Offset: uint8    );
    procedure LDA_zpg_x ( const zpgOffset: uint8 );
    procedure LDA_zpg   ( const zpgOffset: uint8 );
    procedure LDX_zpg   ( const zpgOffset: uint8 );
    procedure LDX_abs_y ( const Address: uint16  );
    procedure LDX_abs   ( const Address: uint16  );
    procedure LDX_imm   ( const value: uint8     );
    procedure LDX_zpg_y ( const zpgOffset: uint8 );
    procedure LDY_abs_x ( const Address: uint16  );
    procedure LDY_abs   ( const Address: uint16  );
    procedure LDY_imm   ( const value: uint8     );
    procedure LDY_zpg_x ( const zpgOffset: uint8 );
    procedure LDY_zpg   ( const zpgOffset: uint8 );
    procedure LSR;
    procedure LSR_abs_x ( const Address: uint16  );
    procedure LSR_abs   ( const Address: uint16  );
    procedure LSR_zpg_x ( const zpgOffset: uint8 );
    procedure LSR_zpg   ( const zpgOffset: uint8 );
    procedure NOP;
    procedure ORA_abs_x ( const Address: uint16  );
    procedure ORA_abs_y ( const Address: uint16  );
    procedure ORA_abs   ( const Address: uint16  );
    procedure ORA_imm   ( const value: uint8     );
    procedure ORA_ind_y ( const Offset: uint8    );
    procedure ORA_x_ind ( const Offset: uint8    );
    procedure ORA_zpg_x ( const zpgOffset: uint8 );
    procedure ORA_zpg   ( const zpgOffset: uint8 );
    procedure PHA;
    procedure PHP;
    procedure PLA;
    procedure PLP;
    procedure ROL;
    procedure ROL_abs_x ( const Address: uint16  );
    procedure ROL_abs   ( const Address: uint16  );
    procedure ROL_zpg_x ( const zpgOffset: uint8 );
    procedure ROL_zpg   ( const zpgOffset: uint8 );
    procedure ROR;
    procedure ROR_abs_x ( const Address: uint16  );
    procedure ROR_abs   ( const Address: uint16  );
    procedure ROR_zpg_x ( const zpgOffset: uint8 );
    procedure ROR_zpg   ( const zpgOffset: uint8 );
    procedure RTI;
    procedure RTS;
    procedure SBC_abs_y ( const Address: uint16  );
    procedure SBC_abs_x ( const Address: uint16  );
    procedure SBC_abs   ( const Address: uint16  );
    procedure SBC_imm   ( const value: uint8     );
    procedure SBC_ind_y ( const Offset: uint8    );
    procedure SBC_x_ind ( const Offset: uint8    );
    procedure SBC_zpg_x ( const zpgOffset: uint8 );
    procedure SBC_zpg   ( const zpgOffset: uint8 );
    procedure SEC;
    procedure SED;
    procedure SEI;
    procedure STA_abs_x ( const Address: uint16  );
    procedure STA_abs_y ( const Address: uint16  );
    procedure STA_abs   ( const Address: uint16  );
    procedure STA_ind_y ( const Offset: uint8    );
    procedure STA_x_ind ( const Offset: uint8    );
    procedure STA_zpg_x ( const zpgOffset: uint8 );
    procedure STA_zpg   ( const zpgOffset: uint8 );
    procedure STX_abs   ( const Address: uint16  );
    procedure STX_zpg_y ( const zpgOffset: uint8 );
    procedure STX_zpg   ( const zpgOffset: uint8 );
    procedure STY_abs   ( const Address: uint16  );
    procedure STY_zpg_x ( const zpgOffset: uint8 );
    procedure STY_zpg   ( const zpgOffset: uint8 );
    procedure TAX;
    procedure TAY;
    procedure TSX;
    procedure TXA;
    procedure TXS;
    procedure TYA;
  end;

implementation

{$region ' Opcode value constants'}

const
  copBRK       = $00;
  copORA_x_ind = $01;
  copORA_zpg   = $05;
  copASL_zpg   = $06;
  copPHP       = $08;
  copORA_imm   = $09;
  copASL_a     = $0A;
  copORA_abs   = $0D;
  copASL_abs   = $0E;
  copBPL_rel   = $10;
  copORA_ind_y = $11;
  copORA_zpg_x = $15;
  copASL_zpg_x = $16;
  copCLC       = $18;
  copORA_abs_y = $19;
  copORA_abs_x = $1D;
  copASL_abs_x = $1E;
  copJSR_abs   = $20;
  copAND_x_ind = $21;
  copBIT_zpg   = $24;
  copAND_zpg   = $25;
  copROL_zpg   = $26;
  copPLP       = $28;
  copAND_imm   = $29;
  copROL_A     = $2A;
  copBIT_abs   = $2C;
  copAND_abs   = $2D;
  copROL_abs   = $2E;
  copBMI_rel   = $30;
  copAND_ind_y = $31;
  copAND_zpg_x = $35;
  copROL_zpg_x = $36;
  copSEC       = $38;
  copAND_abs_Y = $39;
  copAND_abs_x = $3D;
  copROL_abs_x = $3E;
  copRTI       = $40;
  copEOR_X_ind = $41;
  copEOR_zpg   = $45;
  copLSR_zpg   = $46;
  copPHA       = $48;
  copEOR_imm   = $49;
  copLSR_a     = $4A;
  copJMP_abs   = $4C;
  copEOR_abs   = $4D;
  copLSR_abs   = $4E;
  copBVC_rel   = $50;
  copEOR_ind_y = $51;
  copEOR_zpg_x = $55;
  copLSR_zpg_x = $56;
  copCLI       = $58;
  copEOR_abs_y = $59;
  copEOR_abs_X = $5D;
  copLSR_abs_X = $5E;
  copRTS       = $60;
  copADC_x_ind = $61;
  copADC_zpg   = $65;
  copROR_zpg   = $66;
  copPLA       = $68;
  copADC_imm   = $69;
  copROR_a     = $6A;
  copJMP_ind   = $6C;
  copADC_abs   = $6D;
  copROR_abs   = $6E;
  copBVS_rel   = $70;
  copADC_ind_y = $71;
  copADC_zpg_x = $75;
  copROR_zpg_x = $76;
  copSEI       = $78;
  copADC_abs_y = $79;
  copADC_abs_x = $7D;
  copROR_abs_x = $7E;
  copSTA_x_ind = $81;
  copSTY_zpg   = $84;
  copSTA_zpg   = $85;
  copSTX_zpg   = $86;
  copDEY       = $88;
  copTXA       = $8A;
  copSTY_abs   = $8C;
  copSTA_abs   = $8D;
  copSTX_abs   = $8E;
  copBCC_rel   = $90;
  copSTA_ind_y = $91;
  copSTY_zpg_x = $94;
  copSTA_zpg_x = $95;
  copSTX_zpg_Y = $96;
  copTYA       = $98;
  copSTA_abs_y = $99;
  copTXS       = $9A;
  copSTA_abs_x = $9D;
  copLDY_imm   = $A0;
  copLDA_x_ind = $A1;
  copLDX_imm   = $A2;
  copLDY_zpg   = $A4;
  copLDA_zpg   = $A5;
  copLDX_zpg   = $A6;
  copTAY       = $A8;
  copLDA_imm   = $A9;
  copTAX       = $AA;
  copLDY_abs   = $AC;
  copLDA_abs   = $AD;
  copLDX_abs   = $AE;
  copBCS_rel   = $B0;
  copLDA_ind_y = $B1;
  copLDY_zpg_x = $B4;
  copLDA_zpg_X = $B5;
  copLDX_zpg_y = $B6;
  copCLV       = $B8;
  copLDA_abs_y = $B9;
  copTSX       = $BA;
  copLDY_abs_x = $BC;
  copLDA_abs_x = $BD;
  copLDX_abs_y = $BE;
  copCPY_imm   = $C0;
  copCMP_x_ind = $C1;
  copCPY_zpg   = $C4;
  copCMP_zpg   = $C5;
  copDEC_zpg   = $C6;
  copINY       = $C8;
  copCMP_imm   = $C9;
  copDEX       = $CA;
  copCPY_abs   = $CC;
  copCMP_abs   = $CD;
  copDEC_abs   = $CE;
  copBNE_rel   = $D0;
  copCMP_ind_y = $D1;
  copCMP_zpg_x = $D5;
  copDEC_zpg_x = $D6;
  copCLD       = $D8;
  copCMP_abs_y = $D9;
  copCMP_abs_x = $DD;
  copDEC_abs_X = $DE;
  copCPX_imm   = $E0;
  copSBC_x_ind = $E1;
  copCPX_zpg   = $E4;
  copSBC_zpg   = $E5;
  copINC_zpg   = $E6;
  copINX       = $E8;
  copSBC_imm   = $E9;
  copNOP       = $EA;
  copCPX_abs   = $EC;
  copSBC_abs   = $ED;
  copINC_abs   = $EE;
  copBEQ_rel   = $F0;
  copSBC_ind_y = $F1;
  copSBC_zpg_x = $F5;
  copINC_zpg_x = $F6;
  copSED       = $F8;
  copSBC_abs_y = $F9;
  copSBC_abs_x = $FD;
  copINC_abs_x = $FE;

{$endregion}

{$region ' Encoder assist - INLINE'}

function EncodeOneByte( const opCode: uint8 ): TArrayOfByte; inline;
begin
  {$warnings off} SetLength(Result,1); {$warnings on}
  Result[0] := opCode;
end;

function EncodeTwoBytes( const opCode: uint8; const value: uint8 ): TArrayOfByte; inline;
begin
  {$warnings off} SetLength(Result,2); {$warnings on}
  Result[0] := opCode;
  Result[1] := value;
end;

function EncodeThreeBytes( const opCode: uint8; const HighVal: uint8; const LowVal: uint8 ): TArrayOfByte; inline;
begin
  {$warnings off} SetLength(Result,3); {$warnings on}
  Result[0] := opCode;
  Result[1] := LowVal;
  Result[2] := HighVal;
end;

function HighByte( const word: uint16 ): uint8; inline;
begin
  Result := (word shr 8);
end;

function LowByte( const word: uint16 ): uint8; inline;
begin
  Result := (word and $FF);
end;

{$endregion}

{$region ' Instruction encoders '}

procedure T6502ByteCode.ADC_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copADC_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ADC_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copADC_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ADC_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copADC_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ADC_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copADC_imm, value ));
end;

procedure T6502ByteCode.ADC_ind_y(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copADC_ind_y, Offset ));
end;

procedure T6502ByteCode.ADC_x_ind(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copADC_x_ind, Offset ));
end;

procedure T6502ByteCode.ADC_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copADC_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.ADC_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copADC_zpg, zpgOffset ));
end;

procedure T6502ByteCode.AND_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copAND_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.AND_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copAND_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.AND_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copAND_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.AND_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copAND_imm, value ));
end;

procedure T6502ByteCode.AND_ind_y(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copAND_ind_y, Offset ));
end;

procedure T6502ByteCode.AND_x_ind(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copAND_x_ind, Offset ));
end;

procedure T6502ByteCode.AND_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copAND_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.AND_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copAND_zpg, zpgOffset ));
end;

procedure T6502ByteCode.ASL;
begin
  inherited Write(EncodeOneByte( copASL_a ));
end;

procedure T6502ByteCode.ASL_abs( const Address: uint16  );
begin
  inherited Write(EncodeThreeBytes( copASL_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ASL_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copASL_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ASL_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copASL_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.ASL_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copASL_zpg, zpgOffset ));
end;

procedure T6502ByteCode.BCC_rel(const relative: uint8);
begin
  inherited Write(EncodeTwoBytes( copBCC_rel, relative ));
end;

procedure T6502ByteCode.BCS_rel(const relative: uint8);
begin
  inherited Write(EncodeTwoBytes( copBCS_rel, relative ));
end;

procedure T6502ByteCode.BEQ_rel(const relative: uint8);
begin
  inherited Write(EncodeTwoBytes( copBEQ_rel, relative ));
end;

procedure T6502ByteCode.BIT_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copBIT_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.BIT_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copBIT_zpg, zpgOffset ));
end;

procedure T6502ByteCode.BMI_rel(const relative: uint8);
begin
  inherited Write(EncodeTwoBytes( copBMI_rel, relative ));
end;

procedure T6502ByteCode.BNE_rel(const relative: uint8);
begin
  inherited Write(EncodeTwoBytes( copBNE_rel, relative ));
end;

procedure T6502ByteCode.BPL_rel(const relative: uint8);
begin
  inherited Write(EncodeTwoBytes( copBPL_rel, relative ));
end;

procedure T6502ByteCode.BRK;
begin
  inherited Write(EncodeOneByte( copBRK ));
end;

procedure T6502ByteCode.BVC_rel(const relative: uint8);
begin
  inherited Write(EncodeTwoBytes( copBVC_rel, relative ));
end;

procedure T6502ByteCode.BVS_rel(const relative: uint8);
begin
  inherited Write(EncodeTwoBytes( copBVS_rel, relative ));
end;

procedure T6502ByteCode.CLC;
begin
  inherited Write(EncodeOneByte( copCLC ));
end;

procedure T6502ByteCode.CLD;
begin
  inherited Write(EncodeOneByte( copCLD ));
end;

procedure T6502ByteCode.CLI;
begin
  inherited Write(EncodeOneByte( copCLI ));
end;

procedure T6502ByteCode.CLV;
begin
  inherited Write(EncodeOneByte( copCLV ));
end;

procedure T6502ByteCode.CMP_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copCMP_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.CMP_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copCMP_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.CMP_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copCMP_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.CMP_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copCMP_imm, value ));
end;

procedure T6502ByteCode.CMP_ind_y(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copCMP_ind_y, Offset ));
end;

procedure T6502ByteCode.CMP_x_ind(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copCMP_x_ind, Offset ));
end;

procedure T6502ByteCode.CMP_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copCMP_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.CMP_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copCMP_zpg, zpgOffset ));
end;

procedure T6502ByteCode.CPX_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copCPX_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.CPX_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copCPX_imm, value ));
end;

procedure T6502ByteCode.CPX_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copCPX_zpg, zpgOffset ));
end;

procedure T6502ByteCode.CPY_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copCPY_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.CPY_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copCPY_imm, value ));
end;

procedure T6502ByteCode.CPY_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copCPY_zpg, zpgOffset ));
end;

procedure T6502ByteCode.DEC_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copDEC_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.DEC_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copDEC_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.DEC_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copDEC_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.DEC_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copDEC_zpg, zpgOffset ));
end;

procedure T6502ByteCode.DEX;
begin
  inherited Write(EncodeOneByte( copDEX ));
end;

procedure T6502ByteCode.DEY;
begin
  inherited Write(EncodeOneByte( copDEY ));
end;

procedure T6502ByteCode.EOR_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copEOR_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.EOR_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copEOR_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.EOR_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copEOR_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.EOR_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copEOR_imm, value ));
end;

procedure T6502ByteCode.EOR_ind_y(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copEOR_ind_y, Offset ));
end;

procedure T6502ByteCode.EOR_x_ind(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copEOR_X_ind, Offset ));
end;

procedure T6502ByteCode.EOR_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copEOR_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.EOR_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copEOR_zpg, zpgOffset ));
end;

procedure T6502ByteCode.INC_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copINC_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.INC_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copINC_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.INC_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copINC_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.INC_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copINC_zpg, zpgOffset ));
end;

procedure T6502ByteCode.INX;
begin
  inherited Write(EncodeOneByte( copINX ));
end;

procedure T6502ByteCode.INY;
begin
  inherited Write(EncodeOneByte( copINY ));
end;

procedure T6502ByteCode.JMP_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copJMP_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.JMP_ind(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copJMP_ind, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.JSR_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copJSR_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LDA_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLDA_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LDA_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLDA_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LDA_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLDA_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LDA_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDA_imm, value ));
end;

procedure T6502ByteCode.LDA_ind_y(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDA_ind_y, Offset ));
end;

procedure T6502ByteCode.LDA_x_ind(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDA_x_ind, Offset ));
end;

procedure T6502ByteCode.LDA_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDA_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.LDA_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDA_zpg, zpgOffset ));
end;

procedure T6502ByteCode.LDX_zpg( const zpgOffset: uint8 );
begin
  inherited Write(EncodeTwoBytes( copLDX_zpg, zpgOffset ));
end;

procedure T6502ByteCode.LDX_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLDX_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LDX_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLDX_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LDX_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDX_imm, value ));
end;

procedure T6502ByteCode.LDX_zpg_y(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDX_zpg_y, zpgOffset ));
end;

procedure T6502ByteCode.LDY_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLDY_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LDY_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLDY_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LDY_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDY_imm, value ));
end;

procedure T6502ByteCode.LDY_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDY_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.LDY_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLDY_zpg, zpgOffset ));
end;

procedure T6502ByteCode.LSR;
begin
  inherited Write(EncodeOneByte( copLSR_a ));
end;

procedure T6502ByteCode.LSR_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLSR_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LSR_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copLSR_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.LSR_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLSR_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.LSR_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copLSR_zpg, zpgOffset ));
end;

procedure T6502ByteCode.NOP;
begin
  inherited Write(EncodeOneByte( copNOP ));
end;

procedure T6502ByteCode.ORA_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copORA_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ORA_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copORA_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ORA_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copORA_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ORA_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copORA_imm, value ));
end;

procedure T6502ByteCode.ORA_ind_y(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copORA_ind_y, Offset ));
end;

procedure T6502ByteCode.ORA_x_ind(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copORA_x_ind, Offset ));
end;

procedure T6502ByteCode.ORA_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copORA_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.ORA_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copORA_zpg, zpgOffset ));
end;

procedure T6502ByteCode.PHA;
begin
  inherited Write(EncodeOneByte( copPHA ));
end;

procedure T6502ByteCode.PHP;
begin
  inherited Write(EncodeOneByte( copPHP ));
end;

procedure T6502ByteCode.PLA;
begin
  inherited Write(EncodeOneByte( copPLA ));
end;

procedure T6502ByteCode.PLP;
begin
  inherited Write(EncodeOneByte( copPLP ));
end;

procedure T6502ByteCode.ROL;
begin
  inherited Write(EncodeOneByte( copROL_a ));
end;

procedure T6502ByteCode.ROL_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copROL_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ROL_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copROL_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ROL_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copROL_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.ROL_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copROL_zpg, zpgOffset ));
end;

procedure T6502ByteCode.ROR;
begin
  inherited Write(EncodeOneByte( copROR_a ));
end;

procedure T6502ByteCode.ROR_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copROR_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ROR_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copROR_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.ROR_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copROR_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.ROR_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copROR_zpg, zpgOffset ));
end;

procedure T6502ByteCode.RTI;
begin
  inherited Write(EncodeOneByte( copRTI ));
end;

procedure T6502ByteCode.RTS;
begin
  inherited Write(EncodeOneByte( copRTS ));
end;

procedure T6502ByteCode.SBC_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copSBC_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.SBC_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copSBC_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.SBC_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copSBC_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.SBC_imm(const value: uint8);
begin
  inherited Write(EncodeTwoBytes( copSBC_imm, value ));
end;

procedure T6502ByteCode.SBC_ind_y(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSBC_ind_y, Offset ));
end;

procedure T6502ByteCode.SBC_x_ind(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSBC_x_ind, Offset ));
end;

procedure T6502ByteCode.SBC_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSBC_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.SBC_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSBC_zpg, zpgOffset ));
end;

procedure T6502ByteCode.SEC;
begin
  inherited Write(EncodeOneByte( copSEC ));
end;

procedure T6502ByteCode.SED;
begin
  inherited Write(EncodeOneByte( copSED ));
end;

procedure T6502ByteCode.SEI;
begin
  inherited Write(EncodeOneByte( copSEI ));
end;

procedure T6502ByteCode.STA_abs_x(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copSTA_abs_x, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.STA_abs_y(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copSTA_abs_y, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.STA_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copSTA_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.STA_ind_y(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSTA_ind_y, Offset ));
end;

procedure T6502ByteCode.STA_x_ind(const Offset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSTA_x_ind, Offset ));
end;

procedure T6502ByteCode.STA_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSTA_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.STA_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSTA_zpg, zpgOffset ));
end;

procedure T6502ByteCode.STX_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copSTX_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.STX_zpg_y(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSTX_zpg_y, zpgOffset ));
end;

procedure T6502ByteCode.STX_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSTX_zpg, zpgOffset ));
end;

procedure T6502ByteCode.STY_abs(const Address: uint16);
begin
  inherited Write(EncodeThreeBytes( copSTY_abs, HighByte(Address), LowByte(Address) ));
end;

procedure T6502ByteCode.STY_zpg_x(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSTY_zpg_x, zpgOffset ));
end;

procedure T6502ByteCode.STY_zpg(const zpgOffset: uint8);
begin
  inherited Write(EncodeTwoBytes( copSTY_zpg, zpgOffset ));
end;

procedure T6502ByteCode.TAX;
begin
  inherited Write(EncodeOneByte( copTAX ));
end;

procedure T6502ByteCode.TAY;
begin
  inherited Write(EncodeOneByte( copTAY ));
end;

procedure T6502ByteCode.TSX;
begin
  inherited Write(EncodeOneByte( copTSX ));
end;

procedure T6502ByteCode.TXA;
begin
  inherited Write(EncodeOneByte( copTXA ));
end;

procedure T6502ByteCode.TXS;
begin
  inherited Write(EncodeOneByte( copTXS ));
end;

procedure T6502ByteCode.TYA;
begin
  inherited Write(EncodeOneByte( copTYA ));
end;

{$endregion}


end.

