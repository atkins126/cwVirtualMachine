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
unit TestCase.cwVirtualMachine.ByteCode.Mos6502;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
;

type
  TTest_6502ByteCode = class(TTestCase)
  published
    procedure ADC_abs_x;
    procedure ADC_abs_y;
    procedure ADC_abs;
    procedure ADC_imm;
    procedure ADC_ind_y;
    procedure ADC_x_ind;
    procedure ADC_zpg_x;
    procedure ADC_zpg;
    procedure AND_abs_x;
    procedure AND_abs_y;
    procedure AND_abs;
    procedure AND_imm;
    procedure AND_ind_y;
    procedure AND_x_ind;
    procedure AND_zpg_x;
    procedure AND_zpg;
    procedure ASL;
    procedure ASL_abs;
    procedure ASL_abs_x;
    procedure ASL_zpg_x;
    procedure ASL_zpg;
    procedure BCC_rel;
    procedure BCS_rel;
    procedure BEQ_rel;
    procedure BIT_abs;
    procedure BIT_zpg;
    procedure BMI_rel;
    procedure BNE_rel;
    procedure BPL_rel;
    procedure BRK;
    procedure BVC_rel;
    procedure BVS_rel;
    procedure CLC;
    procedure CLD;
    procedure CLI;
    procedure CLV;
    procedure CMP_abs_x;
    procedure CMP_abs_y;
    procedure CMP_abs;
    procedure CMP_imm;
    procedure CMP_ind_y;
    procedure CMP_x_ind;
    procedure CMP_zpg_x;
    procedure CMP_zpg;
    procedure CPX_abs;
    procedure CPX_imm;
    procedure CPX_zpg;
    procedure CPY_abs;
    procedure CPY_imm;
    procedure CPY_zpg;
    procedure DEC_abs_x;
    procedure DEC_abs;
    procedure DEC_zpg_x;
    procedure DEC_zpg;
    procedure DEX;
    procedure DEY;
    procedure EOR_abs_x;
    procedure EOR_abs_y;
    procedure EOR_abs;
    procedure EOR_imm;
    procedure EOR_ind_y;
    procedure EOR_X_ind;
    procedure EOR_zpg_x;
    procedure EOR_zpg;
    procedure INC_abs_x;
    procedure INC_abs;
    procedure INC_zpg_x;
    procedure INC_zpg;
    procedure INX;
    procedure INY;
    procedure JMP_abs;
    procedure JMP_ind;
    procedure JSR_abs;
    procedure LDA_abs_x;
    procedure LDA_abs_y;
    procedure LDA_abs;
    procedure LDA_imm;
    procedure LDA_ind_y;
    procedure LDA_x_ind;
    procedure LDA_zpg_x;
    procedure LDA_zpg;
    procedure LDX_zpg;
    procedure LDX_abs_y;
    procedure LDX_abs;
    procedure LDX_imm;
    procedure LDX_zpg_y;
    procedure LDY_abs_x;
    procedure LDY_abs;
    procedure LDY_imm;
    procedure LDY_zpg_x;
    procedure LDY_zpg;
    procedure LSR;
    procedure LSR_abs_x;
    procedure LSR_abs;
    procedure LSR_zpg_x;
    procedure LSR_zpg;
    procedure NOP;
    procedure ORA_abs_x;
    procedure ORA_abs_y;
    procedure ORA_abs;
    procedure ORA_imm;
    procedure ORA_ind_y;
    procedure ORA_x_ind;
    procedure ORA_zpg_x;
    procedure ORA_zpg;
    procedure PHA;
    procedure PHP;
    procedure PLA;
    procedure PLP;
    procedure ROL;
    procedure ROL_abs_x;
    procedure ROL_abs;
    procedure ROL_zpg_x;
    procedure ROL_zpg;
    procedure ROR;
    procedure ROR_abs_x;
    procedure ROR_abs;
    procedure ROR_zpg_x;
    procedure ROR_zpg;
    procedure RTI;
    procedure RTS;
    procedure SBC_abs_y;
    procedure SBC_abs_x;
    procedure SBC_abs;
    procedure SBC_imm;
    procedure SBC_ind_y;
    procedure SBC_x_ind;
    procedure SBC_zpg_x;
    procedure SBC_zpg;
    procedure SEC;
    procedure SED;
    procedure SEI;
    procedure STA_abs_x;
    procedure STA_abs_y;
    procedure STA_abs;
    procedure STA_ind_y;
    procedure STA_x_ind;
    procedure STA_zpg_x;
    procedure STA_zpg;
    procedure STX_abs;
    procedure STX_zpg_y;
    procedure STX_zpg;
    procedure STY_abs;
    procedure STY_zpg_x;
    procedure STY_zpg;
    procedure TAX;
    procedure TAY;
    procedure TSX;
    procedure TXA;
    procedure TXS;
    procedure TYA;
  end;

implementation
uses
  cwTest.Standard
, cwVirtualMachine
, cwVirtualMachine.Mos6502
;

procedure TTest_6502ByteCode.ADC_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ADC_abs_x($FEDE);
  // Assert:
  TTest.Expect( $7D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ADC_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ADC_abs_y($FEDE);
  // Assert:
  TTest.Expect( $79, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ADC_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ADC_abs($FEDE);
  // Assert:
  TTest.Expect( $6D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ADC_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ADC_imm($DE);
  // Assert:
  TTest.Expect( $69, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ADC_ind_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ADC_ind_y($DE);
  // Assert:
  TTest.Expect( $71, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ADC_x_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ADC_x_ind($DE);
  // Assert:
  TTest.Expect( $61, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ADC_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ADC_zpg_x($DE);
  // Assert:
  TTest.Expect( $75, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ADC_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ADC_zpg($DE);
  // Assert:
  TTest.Expect( $65, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.AND_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.AND_abs_x($FEDE);
  // Assert:
  TTest.Expect( $3D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.AND_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.AND_abs_y($FEDE);
  // Assert:
  TTest.Expect( $39, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.AND_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.AND_abs($FEDE);
  // Assert:
  TTest.Expect( $2D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.AND_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.AND_imm($DE);
  // Assert:
  TTest.Expect( $29, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.AND_ind_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.AND_ind_y($DE);
  // Assert:
  TTest.Expect( $31, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.AND_x_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.AND_x_ind($DE);
  // Assert:
  TTest.Expect( $21, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.AND_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.AND_zpg_x($DE);
  // Assert:
  TTest.Expect( $35, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.AND_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.AND_zpg($DE);
  // Assert:
  TTest.Expect( $25, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ASL;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ASL();
  // Assert:
  TTest.Expect( $0A, Memory[0] );
end;

procedure TTest_6502ByteCode.ASL_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ASL_abs($FEDE);
  // Assert:
  TTest.Expect( $0E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ASL_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ASL_abs_x($FEDE);
  // Assert:
  TTest.Expect( $1E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ASL_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ASL_zpg_x($DE);
  // Assert:
  TTest.Expect( $16, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ASL_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ASL_zpg($DE);
  // Assert:
  TTest.Expect( $06, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BCC_rel;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BCC_rel($DE);
  // Assert:
  TTest.Expect( $90, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BCS_rel;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BCS_rel($DE);
  // Assert:
  TTest.Expect( $B0, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BEQ_rel;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BEQ_rel($DE);
  // Assert:
  TTest.Expect( $F0, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BIT_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BIT_abs($FEDE);
  // Assert:
  TTest.Expect( $2C, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.BIT_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BIT_zpg($DE);
  // Assert:
  TTest.Expect( $24, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BMI_rel;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BMI_rel($DE);
  // Assert:
  TTest.Expect( $30, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BNE_rel;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BNE_rel($DE);
  // Assert:
  TTest.Expect( $D0, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BPL_rel;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BPL_rel($DE);
  // Assert:
  TTest.Expect( $10, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BRK;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BRK();
  // Assert:
  TTest.Expect( $00, Memory[0] );
end;

procedure TTest_6502ByteCode.BVC_rel;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BVC_rel($DE);
  // Assert:
  TTest.Expect( $50, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.BVS_rel;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.BVS_rel($DE);
  // Assert:
  TTest.Expect( $70, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CLC;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CLC();
  // Assert:
  TTest.Expect( $18, Memory[0] );
end;

procedure TTest_6502ByteCode.CLD;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CLD();
  // Assert:
  TTest.Expect( $D8, Memory[0] );
end;

procedure TTest_6502ByteCode.CLI;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CLI();
  // Assert:
  TTest.Expect( $58, Memory[0] );
end;

procedure TTest_6502ByteCode.CLV;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CLV();
  // Assert:
  TTest.Expect( $B8, Memory[0] );
end;

procedure TTest_6502ByteCode.CMP_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CMP_abs_x($FEDE);
  // Assert:
  TTest.Expect( $DD, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.CMP_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CMP_abs_y($FEDE);
  // Assert:
  TTest.Expect( $D9, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.CMP_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CMP_abs($FEDE);
  // Assert:
  TTest.Expect( $CD, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.CMP_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CMP_imm($DE);
  // Assert:
  TTest.Expect( $C9, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CMP_ind_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CMP_ind_y($DE);
  // Assert:
  TTest.Expect( $D1, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CMP_x_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CMP_x_ind($DE);
  // Assert:
  TTest.Expect( $C1, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CMP_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CMP_zpg_x($DE);
  // Assert:
  TTest.Expect( $D5, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CMP_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CMP_zpg($DE);
  // Assert:
  TTest.Expect( $C5, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CPX_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CPX_abs($FEDE);
  // Assert:
  TTest.Expect( $EC, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.CPX_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CPX_imm($DE);
  // Assert:
  TTest.Expect( $E0, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CPX_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CPX_zpg($DE);
  // Assert:
  TTest.Expect( $E4, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CPY_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CPY_abs($FEDE);
  // Assert:
  TTest.Expect( $CC, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.CPY_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CPY_imm($DE);
  // Assert:
  TTest.Expect( $C0, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.CPY_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.CPY_zpg($DE);
  // Assert:
  TTest.Expect( $C4, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.DEC_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.DEC_abs_x($FEDE);
  // Assert:
  TTest.Expect( $DE, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.DEC_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.DEC_abs($FEDE);
  // Assert:
  TTest.Expect( $CE, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.DEC_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.DEC_zpg_x($DE);
  // Assert:
  TTest.Expect( $D6, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.DEC_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.DEC_zpg($DE);
  // Assert:
  TTest.Expect( $C6, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.DEX;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.DEX();
  // Assert:
  TTest.Expect( $CA, Memory[0] );
end;

procedure TTest_6502ByteCode.DEY;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.DEY();
  // Assert:
  TTest.Expect( $88, Memory[0] );
end;

procedure TTest_6502ByteCode.EOR_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.EOR_abs_x($FEDE);
  // Assert:
  TTest.Expect( $5D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.EOR_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.EOR_abs_y($FEDE);
  // Assert:
  TTest.Expect( $59, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.EOR_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.EOR_abs($FEDE);
  // Assert:
  TTest.Expect( $4D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.EOR_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.EOR_imm($DE);
  // Assert:
  TTest.Expect( $49, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.EOR_ind_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.EOR_ind_y($DE);
  // Assert:
  TTest.Expect( $51, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.EOR_X_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.EOR_X_ind($DE);
  // Assert:
  TTest.Expect( $41, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.EOR_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.EOR_zpg_x($DE);
  // Assert:
  TTest.Expect( $55, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.EOR_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.EOR_zpg($DE);
  // Assert:
  TTest.Expect( $45, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.INC_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.INC_abs_x($FEDE);
  // Assert:
  TTest.Expect( $FE, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.INC_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.INC_abs($FEDE);
  // Assert:
  TTest.Expect( $EE, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.INC_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.INC_zpg_x($DE);
  // Assert:
  TTest.Expect( $F6, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.INC_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.INC_zpg($DE);
  // Assert:
  TTest.Expect( $E6, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.INX;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.INX();
  // Assert:
  TTest.Expect( $E8, Memory[0] );
end;

procedure TTest_6502ByteCode.INY;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.INY();
  // Assert:
  TTest.Expect( $C8, Memory[0] );
end;

procedure TTest_6502ByteCode.JMP_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.JMP_abs($FEDE);
  // Assert:
  TTest.Expect( $4C, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.JMP_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.JMP_ind($FEDE);
  // Assert:
  TTest.Expect( $6C, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.JSR_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.JSR_abs($FEDE);
  // Assert:
  TTest.Expect( $20, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LDA_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDA_abs_x($FEDE);
  // Assert:
  TTest.Expect( $BD, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LDA_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDA_abs_y($FEDE);
  // Assert:
  TTest.Expect( $B9, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LDA_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDA_abs($FEDE);
  // Assert:
  TTest.Expect( $AD, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LDA_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDA_imm($DE);
  // Assert:
  TTest.Expect( $A9, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDA_ind_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDA_ind_y($DE);
  // Assert:
  TTest.Expect( $B1, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDA_x_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDA_x_ind($DE);
  // Assert:
  TTest.Expect( $A1, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDA_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDA_zpg_x($DE);
  // Assert:
  TTest.Expect( $B5, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDA_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDA_zpg($DE);
  // Assert:
  TTest.Expect( $A5, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDX_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDX_zpg($DE);
  // Assert:
  TTest.Expect( $A6, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDX_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDX_abs_y($FEDE);
  // Assert:
  TTest.Expect( $BE, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LDX_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDX_abs($FEDE);
  // Assert:
  TTest.Expect( $AE, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LDX_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDX_imm($DE);
  // Assert:
  TTest.Expect( $A2, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDX_zpg_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDX_zpg_y($DE);
  // Assert:
  TTest.Expect( $B6, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDY_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDY_abs_x($FEDE);
  // Assert:
  TTest.Expect( $BC, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LDY_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDY_abs($FEDE);
  // Assert:
  TTest.Expect( $AC, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LDY_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDY_imm($DE);
  // Assert:
  TTest.Expect( $A0, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDY_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDY_zpg_x($DE);
  // Assert:
  TTest.Expect( $B4, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LDY_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LDY_zpg($DE);
  // Assert:
  TTest.Expect( $A4, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LSR;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LSR();
  // Assert:
  TTest.Expect( $4A, Memory[0] );
end;

procedure TTest_6502ByteCode.LSR_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LSR_abs_x($FEDE);
  // Assert:
  TTest.Expect( $5E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LSR_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LSR_abs($FEDE);
  // Assert:
  TTest.Expect( $4E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.LSR_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LSR_zpg_x($DE);
  // Assert:
  TTest.Expect( $56, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.LSR_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.LSR_zpg($DE);
  // Assert:
  TTest.Expect( $46, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.NOP;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.NOP();
  // Assert:
  TTest.Expect( $EA, Memory[0] );
end;

procedure TTest_6502ByteCode.ORA_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ORA_abs_x($FEDE);
  // Assert:
  TTest.Expect( $1D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ORA_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ORA_abs_y($FEDE);
  // Assert:
  TTest.Expect( $19, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ORA_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ORA_abs($FEDE);
  // Assert:
  TTest.Expect( $0D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ORA_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ORA_imm($DE);
  // Assert:
  TTest.Expect( $09, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ORA_ind_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ORA_ind_y($DE);
  // Assert:
  TTest.Expect( $11, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ORA_x_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ORA_x_ind($DE);
  // Assert:
  TTest.Expect( $01, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ORA_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ORA_zpg_x($DE);
  // Assert:
  TTest.Expect( $15, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ORA_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ORA_zpg($DE);
  // Assert:
  TTest.Expect( $05, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.PHA;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.PHA();
  // Assert:
  TTest.Expect( $48, Memory[0] );
end;

procedure TTest_6502ByteCode.PHP;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.PHP();
  // Assert:
  TTest.Expect( $08, Memory[0] );
end;

procedure TTest_6502ByteCode.PLA;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.PLA();
  // Assert:
  TTest.Expect( $68, Memory[0] );
end;

procedure TTest_6502ByteCode.PLP;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.PLP();
  // Assert:
  TTest.Expect( $28, Memory[0] );
end;

procedure TTest_6502ByteCode.ROL;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROL();
  // Assert:
  TTest.Expect( $2A, Memory[0] );
end;

procedure TTest_6502ByteCode.ROL_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROL_abs_x($FEDE);
  // Assert:
  TTest.Expect( $3E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ROL_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROL_abs($FEDE);
  // Assert:
  TTest.Expect( $2E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ROL_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROL_zpg_x($DE);
  // Assert:
  TTest.Expect( $36, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ROL_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROL_zpg($DE);
  // Assert:
  TTest.Expect( $26, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ROR;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROR();
  // Assert:
  TTest.Expect( $6A, Memory[0] );
end;

procedure TTest_6502ByteCode.ROR_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROR_abs_x($FEDE);
  // Assert:
  TTest.Expect( $7E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ROR_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROR_abs($FEDE);
  // Assert:
  TTest.Expect( $6E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.ROR_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROR_zpg_x($DE);
  // Assert:
  TTest.Expect( $76, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.ROR_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.ROR_zpg($DE);
  // Assert:
  TTest.Expect( $66, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.RTI;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.RTI();
  // Assert:
  TTest.Expect( $40, Memory[0] );
end;

procedure TTest_6502ByteCode.RTS;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.RTS();
  // Assert:
  TTest.Expect( $60, Memory[0] );
end;

procedure TTest_6502ByteCode.SBC_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SBC_abs_y($FEDE);
  // Assert:
  TTest.Expect( $F9, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.SBC_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SBC_abs_x($FEDE);
  // Assert:
  TTest.Expect( $FD, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.SBC_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SBC_abs($FEDE);
  // Assert:
  TTest.Expect( $ED, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.SBC_imm;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SBC_imm($DE);
  // Assert:
  TTest.Expect( $E9, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.SBC_ind_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SBC_ind_y($DE);
  // Assert:
  TTest.Expect( $F1, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.SBC_x_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SBC_x_ind($DE);
  // Assert:
  TTest.Expect( $E1, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.SBC_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SBC_zpg_x($DE);
  // Assert:
  TTest.Expect( $F5, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.SBC_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SBC_zpg($DE);
  // Assert:
  TTest.Expect( $E5, Memory[0] );
end;

procedure TTest_6502ByteCode.SEC;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SEC;
  // Assert:
  TTest.Expect( $38, Memory[0] );
end;

procedure TTest_6502ByteCode.SED;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SED();
  // Assert:
  TTest.Expect( $F8, Memory[0] );
end;

procedure TTest_6502ByteCode.SEI;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.SEI();
  // Assert:
  TTest.Expect( $78, Memory[0] );
end;

procedure TTest_6502ByteCode.STA_abs_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STA_abs_x($FEDE);
  // Assert:
  TTest.Expect( $9D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.STA_abs_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STA_abs_y($FEDE);
  // Assert:
  TTest.Expect( $99, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.STA_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STA_abs($FEDE);
  // Assert:
  TTest.Expect( $8D, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.STA_ind_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STA_ind_y($DE);
  // Assert:
  TTest.Expect( $91, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.STA_x_ind;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STA_x_ind($DE);
  // Assert:
  TTest.Expect( $81, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.STA_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STA_zpg_x($DE);
  // Assert:
  TTest.Expect( $95, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.STA_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STA_zpg($DE);
  // Assert:
  TTest.Expect( $85, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.STX_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STX_abs($FEDE);
  // Assert:
  TTest.Expect( $8E, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.STX_zpg_y;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STX_zpg_y($DE);
  // Assert:
  TTest.Expect( $96, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.STX_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STX_zpg($DE);
  // Assert:
  TTest.Expect( $86, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.STY_abs;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STY_abs($FEDE);
  // Assert:
  TTest.Expect( $8C, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
  TTest.Expect( $FE, Memory[2] );
end;

procedure TTest_6502ByteCode.STY_zpg_x;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STY_zpg_x($DE);
  // Assert:
  TTest.Expect( $94, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.STY_zpg;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.STY_zpg($DE);
  // Assert:
  TTest.Expect( $84, Memory[0] );
  TTest.Expect( $DE, Memory[1] );
end;

procedure TTest_6502ByteCode.TAX;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.TAX();
  // Assert:
  TTest.Expect( $AA, Memory[0] );
end;

procedure TTest_6502ByteCode.TAY;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.TAY();
  // Assert:
  TTest.Expect( $A8, Memory[0] );
end;

procedure TTest_6502ByteCode.TSX;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.TSX();
  // Assert:
  TTest.Expect( $BA, Memory[0] );
end;

procedure TTest_6502ByteCode.TXA;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.TXA();
  // Assert:
  TTest.Expect( $8A, Memory[0] );
end;

procedure TTest_6502ByteCode.TXS;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.TXS();
  // Assert:
  TTest.Expect( $9A, Memory[0] );
end;

procedure TTest_6502ByteCode.TYA;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  ByteCode := T6502ByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.TYA();
  // Assert:
  TTest.Expect( $98, Memory[0] );
end;

initialization
  TestSuite.RegisterTestCase(TTest_6502ByteCode)

end.



