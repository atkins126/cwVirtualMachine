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
unit TestCase.cwVirtualMachine.VirtualCPU.Mos6502;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
;

type
  TTest_Mos6502CPU = class(TTestCase)
  published
    procedure Reset;
    procedure Clock;

    {$region ' ADC '}
    procedure ADC_abs_x_WithCarry;
    procedure ADC_abs_y_WithCarry;
    procedure ADC_abs_WithCarry;
    procedure ADC_imm_WithCarry;
    procedure ADC_ind_y_WithCarry;
    procedure ADC_x_ind_WithCarry;
    procedure ADC_zpg_x_WithCarry;
    procedure ADC_zpg_WithCarry;

    procedure ADC_abs_x_WithoutCarry;
    procedure ADC_abs_y_WithoutCarry;
    procedure ADC_abs_WithoutCarry;
    procedure ADC_imm_WithoutCarry;
    procedure ADC_ind_y_WithoutCarry;
    procedure ADC_x_ind_WithoutCarry;
    procedure ADC_zpg_x_WithoutCarry;
    procedure ADC_zpg_WithoutCarry;
    {$endregion}
    {$region ' AND '}
    procedure AND_abs_x;
    procedure AND_abs_y;
    procedure AND_abs;
    procedure AND_imm;
    procedure AND_ind_y;
    procedure AND_x_ind;
    procedure AND_zpg_x;
    procedure AND_zpg;
    {$endregion}
    {$region ' ASL '}
    procedure ASL;
    procedure ASL_abs;
    procedure ASL_abs_x;
    procedure ASL_zpg_x;
    procedure ASL_zpg;
    {$endregion}
    {$region ' BCC '}
    procedure BCC_rel;
    {$endregion}
    {$region ' BCS '}
    procedure BCS_rel;
    {$endregion}
    {$region ' BEQ '}
    procedure BEQ_rel;
    {$endregion}
    {$region ' BIT '}
    procedure BIT_abs;
    procedure BIT_zpg;
    {$endregion}
    {$region ' BMI '}
    procedure BMI_rel;
    {$endregion}
    {$region ' BNE '}
    procedure BNE_rel;
    {$endregion}
    {$region ' BPL '}
    procedure BPL_rel;
    {$endregion}
    {$region ' BRK '}
    procedure BRK;
    {$endregion}
    {$region ' BVC '}
    procedure BVC_rel;
    {$endregion}
    {$region ' BVS '}
    procedure BVS_rel;
    {$endregion}
    {$region ' CLC '}
    procedure CLC;
    {$endregion}
    {$region ' CLD '}
    procedure CLD;
    {$endregion}
    {$region ' CLI '}
    procedure CLI;
    {$endregion}
    {$region ' CLV '}
    procedure CLV;
    {$endregion}
    {$region ' CMP '}
    procedure CMP_abs_x;
    procedure CMP_abs_y;
    procedure CMP_abs;
    procedure CMP_imm;
    procedure CMP_ind_y;
    procedure CMP_x_ind;
    procedure CMP_zpg_x;
    procedure CMP_zpg;
    {$endregion}
    {$region ' CPX '}
    procedure CPX_abs;
    procedure CPX_imm;
    procedure CPX_zpg;
    {$endregion}
    {$region ' CPY '}
    procedure CPY_abs;
    procedure CPY_imm;
    procedure CPY_zpg;
    {$endregion}
    {$region ' DEC '}
    procedure DEC_abs_x;
    procedure DEC_abs;
    procedure DEC_zpg_x;
    procedure DEC_zpg;
    {$endregion}
    {$region ' DEX '}
    procedure DEX;
    {$endregion}
    {$region ' DEY '}
    procedure DEY;
    {$endregion}
    {$region ' EOR '}
    procedure EOR_abs_x;
    procedure EOR_abs_y;
    procedure EOR_abs;
    procedure EOR_imm;
    procedure EOR_ind_y;
    procedure EOR_X_ind;
    procedure EOR_zpg_x;
    procedure EOR_zpg;
    {$endregion}
    {$region ' INC '}
    procedure INC_abs_x;
    procedure INC_abs;
    procedure INC_zpg_x;
    procedure INC_zpg;
    {$endregion}
    {$region ' INX '}
    procedure INX;
    {$endregion}
    {$region ' INY '}
    procedure INY;
    {$endregion}
    {$region ' JMP '}
    procedure JMP_abs;
    procedure JMP_ind;
    {$endregion}
    {$region ' JSR '}
    procedure JSR_abs;
    {$endregion}
    {$region ' LDA '}
    procedure LDA_abs_x;
    procedure LDA_abs_y;
    procedure LDA_abs;
    procedure LDA_imm;
    procedure LDA_ind_y;
    procedure LDA_x_ind;
    procedure LDA_zpg_x;
    procedure LDA_zpg;
    {$endregion}
    {$region ' LDX '}
    procedure LDX_zpg;
    procedure LDX_abs_y;
    procedure LDX_abs;
    procedure LDX_imm;
    procedure LDX_zpg_y;
    {$endregion}
    {$region ' LDY '}
    procedure LDY_abs_x;
    procedure LDY_abs;
    procedure LDY_imm;
    procedure LDY_zpg_x;
    procedure LDY_zpg;
    {$endregion}
    {$region ' LSR '}
    procedure LSR;
    procedure LSR_abs_x;
    procedure LSR_abs;
    procedure LSR_zpg_x;
    procedure LSR_zpg;
    {$endregion}
    {$region ' NOP '}
    procedure NOP;
    {$endregion}
    {$region ' ORA '}
    procedure ORA_abs_x;
    procedure ORA_abs_y;
    procedure ORA_abs;
    procedure ORA_imm;
    procedure ORA_ind_y;
    procedure ORA_x_ind;
    procedure ORA_zpg_x;
    procedure ORA_zpg;
    {$endregion}
    {$region ' PHA '}
    procedure PHA;
    {$endregion}
    {$region ' PHP '}
    procedure PHP;
    {$endregion}
    {$region ' PLA '}
    procedure PLA;
    {$endregion}
    {$region ' PLP '}
    procedure PLP;
    {$endregion}
    {$region ' ROL '}
    procedure ROL;
    procedure ROL_abs_x;
    procedure ROL_abs;
    procedure ROL_zpg_x;
    procedure ROL_zpg;
    {$endregion}
    {$region ' ROR '}
    procedure ROR;
    procedure ROR_abs_x;
    procedure ROR_abs;
    procedure ROR_zpg_x;
    procedure ROR_zpg;
    {$endregion}
    {$region ' RTI '}
    procedure RTI;
    {$endregion}
    {$region ' RTS '}
    procedure RTS;
    {$endregion}
    {$region ' SBC '}
    procedure SBC_abs_y;
    procedure SBC_abs_x;
    procedure SBC_abs;
    procedure SBC_imm;
    procedure SBC_ind_y;
    procedure SBC_x_ind;
    procedure SBC_zpg_x;
    procedure SBC_zpg;
    procedure SEC;
    {$endregion}
    {$region ' SED '}
    procedure SED;
    {$endregion}
    {$region ' SEI '}
    procedure SEI;
    {$endregion}
    {$region ' STA '}
    procedure STA_abs_x;
    procedure STA_abs_y;
    procedure STA_abs;
    procedure STA_ind_y;
    procedure STA_x_ind;
    procedure STA_zpg_x;
    procedure STA_zpg;
    {$endregion}
    {$region ' STX '}
    procedure STX_abs;
    procedure STX_zpg_y;
    procedure STX_zpg;
    {$endregion}
    {$region ' STY '}
    procedure STY_abs;
    procedure STY_zpg_x;
    procedure STY_zpg;
    {$endregion}
    {$region ' TAX '}
    procedure TAX;
    {$endregion}
    {$region ' TAY '}
    procedure TAY;
    {$endregion}
    {$region ' TSX '}
    procedure TSX;
    {$endregion}
    {$region ' TXA '}
    procedure TXA;
    {$endregion}
    {$region ' TXS '}
    procedure TXS;
    {$endregion}
    {$region ' TYA '}
    procedure TYA;
    {$endregion}

  end;

implementation
uses
  cwTest.Standard
, cwVirtualMachine
, cwVirtualMachine.Standard
, cwVirtualMachine.Mos6502
;

procedure TTest_Mos6502CPU.Reset;
begin

end;

procedure TTest_Mos6502CPU.Clock;
begin

end;

{$region ' ADC '}

procedure TTest_Mos6502CPU.ADC_abs_x_WithCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  Memory[$0A00] := $02;
  ByteCode.LDA_imm( $CC );
  ByteCode.LDX_imm( $01 );
  ByteCode.CLC;
  ByteCode.ADC_abs_x( $09FF );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_WithCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_abs_y( $02 );
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_WithCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_abs( $02 );
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_WithCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_imm( $02 );
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_WithCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_ind_y( $02 );
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_WithCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_x_ind( $02 );
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_WithCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_zpg_x( $02 );
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_WithCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_zpg( $02 );
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_WithoutCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_abs_x( $02 );
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_WithoutCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_abs_y( $02 );
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_WithoutCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_abs( $02 );
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_WithoutCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_imm( $02 );
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_WithoutCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_ind_y( $02 );
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_WithoutCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_x_ind( $02 );
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_WithoutCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_zpg_x( $02 );
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_WithoutCarry;
var
  Memory: I6502VirtualMemory;
  ByteCode: I6502ByteCode;
  CPU: I6502CPU;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  CPU := T6502CPU.Create( Memory );
  ByteCode := T6502ByteCode.Create( Memory );
  // Act:
  CPU.CarryFlag := FALSE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_zpg( $02 );
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

{$endregion}

{$region ' AND '}
procedure TTest_Mos6502CPU.AND_abs_x;
begin

end;

procedure TTest_Mos6502CPU.AND_abs_y;
begin

end;

procedure TTest_Mos6502CPU.AND_abs;
begin

end;

procedure TTest_Mos6502CPU.AND_imm;
begin

end;

procedure TTest_Mos6502CPU.AND_ind_y;
begin

end;

procedure TTest_Mos6502CPU.AND_x_ind;
begin

end;

procedure TTest_Mos6502CPU.AND_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.AND_zpg;
begin

end;

{$endregion}

{$region ' ASL '}

procedure TTest_Mos6502CPU.ASL;
begin

end;

procedure TTest_Mos6502CPU.ASL_abs;
begin

end;

procedure TTest_Mos6502CPU.ASL_abs_x;
begin

end;

procedure TTest_Mos6502CPU.ASL_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.ASL_zpg;
begin

end;


{$endregion}

{$region ' BCC '}

procedure TTest_Mos6502CPU.BCC_rel;
begin

end;

{$endregion}

{$region ' BCS '}

procedure TTest_Mos6502CPU.BCS_rel;
begin

end;

{$endregion}

{$region ' BEQ '}

procedure TTest_Mos6502CPU.BEQ_rel;
begin

end;

{$endregion}

{$region ' BIT '}

procedure TTest_Mos6502CPU.BIT_abs;
begin

end;

procedure TTest_Mos6502CPU.BIT_zpg;
begin

end;


{$endregion}

{$region ' BMI '}

procedure TTest_Mos6502CPU.BMI_rel;
begin

end;

{$endregion}

{$region ' BNE '}

procedure TTest_Mos6502CPU.BNE_rel;
begin

end;

{$endregion}

{$region ' BPL '}

procedure TTest_Mos6502CPU.BPL_rel;
begin

end;

{$endregion}

{$region ' BRK '}

procedure TTest_Mos6502CPU.BRK;
begin

end;

{$endregion}

{$region ' BVC '}

procedure TTest_Mos6502CPU.BVC_rel;
begin

end;

{$endregion}

{$region ' BVS '}

procedure TTest_Mos6502CPU.BVS_rel;
begin

end;

{$endregion}

{$region ' CLC '}

procedure TTest_Mos6502CPU.CLC;
begin

end;

{$endregion}

{$region ' CLD '}

procedure TTest_Mos6502CPU.CLD;
begin

end;

{$endregion}

{$region ' CLI '}

procedure TTest_Mos6502CPU.CLI;
begin

end;

{$endregion}

{$region ' CLV '}

procedure TTest_Mos6502CPU.CLV;
begin

end;

{$endregion}

{$region ' CMP '}

procedure TTest_Mos6502CPU.CMP_abs_x;
begin

end;

procedure TTest_Mos6502CPU.CMP_abs_y;
begin

end;

procedure TTest_Mos6502CPU.CMP_abs;
begin

end;

procedure TTest_Mos6502CPU.CMP_imm;
begin

end;

procedure TTest_Mos6502CPU.CMP_ind_y;
begin

end;

procedure TTest_Mos6502CPU.CMP_x_ind;
begin

end;

procedure TTest_Mos6502CPU.CMP_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.CMP_zpg;
begin

end;

{$endregion}

{$region ' CPX '}

procedure TTest_Mos6502CPU.CPX_abs;
begin

end;

procedure TTest_Mos6502CPU.CPX_imm;
begin

end;

procedure TTest_Mos6502CPU.CPX_zpg;
begin

end;

{$endregion}

{$region ' CPY '}

procedure TTest_Mos6502CPU.CPY_abs;
begin

end;

procedure TTest_Mos6502CPU.CPY_imm;
begin

end;

procedure TTest_Mos6502CPU.CPY_zpg;
begin

end;


{$endregion}

{$region ' DEC '}

procedure TTest_Mos6502CPU.DEC_abs_x;
begin

end;

procedure TTest_Mos6502CPU.DEC_abs;
begin

end;

procedure TTest_Mos6502CPU.DEC_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.DEC_zpg;
begin

end;

{$endregion}

{$region ' DEX '}

procedure TTest_Mos6502CPU.DEX;
begin

end;

{$endregion}

{$region ' DEY '}

procedure TTest_Mos6502CPU.DEY;
begin

end;

{$endregion}

{$region ' EOR '}

procedure TTest_Mos6502CPU.EOR_abs_x;
begin

end;

procedure TTest_Mos6502CPU.EOR_abs_y;
begin

end;

procedure TTest_Mos6502CPU.EOR_abs;
begin

end;

procedure TTest_Mos6502CPU.EOR_imm;
begin

end;

procedure TTest_Mos6502CPU.EOR_ind_y;
begin

end;

procedure TTest_Mos6502CPU.EOR_X_ind;
begin

end;

procedure TTest_Mos6502CPU.EOR_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.EOR_zpg;
begin

end;

{$endregion}

{$region ' INC '}

procedure TTest_Mos6502CPU.INC_abs_x;
begin

end;

procedure TTest_Mos6502CPU.INC_abs;
begin

end;

procedure TTest_Mos6502CPU.INC_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.INC_zpg;
begin

end;

{$endregion}

{$region ' INX '}

procedure TTest_Mos6502CPU.INX;
begin

end;

{$endregion}

{$region ' INY '}

procedure TTest_Mos6502CPU.INY;
begin

end;

{$endregion}

{$region ' JMP '}

procedure TTest_Mos6502CPU.JMP_abs;
begin

end;

procedure TTest_Mos6502CPU.JMP_ind;
begin

end;

{$endregion}

{$region ' JSR '}

procedure TTest_Mos6502CPU.JSR_abs;
begin

end;

{$endregion}

{$region ' LDA '}

procedure TTest_Mos6502CPU.LDA_abs_x;
begin

end;

procedure TTest_Mos6502CPU.LDA_abs_y;
begin

end;

procedure TTest_Mos6502CPU.LDA_abs;
begin

end;

procedure TTest_Mos6502CPU.LDA_imm;
begin

end;

procedure TTest_Mos6502CPU.LDA_ind_y;
begin

end;

procedure TTest_Mos6502CPU.LDA_x_ind;
begin

end;

procedure TTest_Mos6502CPU.LDA_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.LDA_zpg;
begin

end;

{$endregion}

{$region ' LDX '}

procedure TTest_Mos6502CPU.LDX_zpg;
begin

end;

procedure TTest_Mos6502CPU.LDX_abs_y;
begin

end;

procedure TTest_Mos6502CPU.LDX_abs;
begin

end;

procedure TTest_Mos6502CPU.LDX_imm;
begin

end;

procedure TTest_Mos6502CPU.LDX_zpg_y;
begin

end;

{$endregion}

{$region ' LDY '}

procedure TTest_Mos6502CPU.LDY_abs_x;
begin

end;

procedure TTest_Mos6502CPU.LDY_abs;
begin

end;

procedure TTest_Mos6502CPU.LDY_imm;
begin

end;

procedure TTest_Mos6502CPU.LDY_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.LDY_zpg;
begin

end;

{$endregion}

{$region ' LSR '}

procedure TTest_Mos6502CPU.LSR;
begin

end;

procedure TTest_Mos6502CPU.LSR_abs_x;
begin

end;

procedure TTest_Mos6502CPU.LSR_abs;
begin

end;

procedure TTest_Mos6502CPU.LSR_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.LSR_zpg;
begin

end;

{$endregion}

{$region ' NOP '}

procedure TTest_Mos6502CPU.NOP;
begin

end;

{$endregion}

{$region ' ORA '}

procedure TTest_Mos6502CPU.ORA_abs_x;
begin

end;

procedure TTest_Mos6502CPU.ORA_abs_y;
begin

end;

procedure TTest_Mos6502CPU.ORA_abs;
begin

end;

procedure TTest_Mos6502CPU.ORA_imm;
begin

end;

procedure TTest_Mos6502CPU.ORA_ind_y;
begin

end;

procedure TTest_Mos6502CPU.ORA_x_ind;
begin

end;

procedure TTest_Mos6502CPU.ORA_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.ORA_zpg;
begin

end;

{$endregion}

{$region ' PHA '}

procedure TTest_Mos6502CPU.PHA;
begin

end;

{$endregion}

{$region ' PHP '}

procedure TTest_Mos6502CPU.PHP;
begin

end;

{$endregion}

{$region ' PLA '}

procedure TTest_Mos6502CPU.PLA;
begin

end;


{$endregion}

{$region ' PLP '}

procedure TTest_Mos6502CPU.PLP;
begin

end;

{$endregion}

{$region ' ROL '}

procedure TTest_Mos6502CPU.ROL;
begin

end;

procedure TTest_Mos6502CPU.ROL_abs_x;
begin

end;

procedure TTest_Mos6502CPU.ROL_abs;
begin

end;

procedure TTest_Mos6502CPU.ROL_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.ROL_zpg;
begin

end;

{$endregion}

{$region ' ROR '}

procedure TTest_Mos6502CPU.ROR;
begin

end;

procedure TTest_Mos6502CPU.ROR_abs_x;
begin

end;

procedure TTest_Mos6502CPU.ROR_abs;
begin

end;

procedure TTest_Mos6502CPU.ROR_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.ROR_zpg;
begin

end;

{$endregion}

{$region ' RTI '}

procedure TTest_Mos6502CPU.RTI;
begin

end;


{$endregion}

{$region ' RTS '}

procedure TTest_Mos6502CPU.RTS;
begin

end;


{$endregion}

{$region ' SBC '}

procedure TTest_Mos6502CPU.SBC_abs_y;
begin

end;

procedure TTest_Mos6502CPU.SBC_abs_x;
begin

end;

procedure TTest_Mos6502CPU.SBC_abs;
begin

end;

procedure TTest_Mos6502CPU.SBC_imm;
begin

end;

procedure TTest_Mos6502CPU.SBC_ind_y;
begin

end;

procedure TTest_Mos6502CPU.SBC_x_ind;
begin

end;

procedure TTest_Mos6502CPU.SBC_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.SBC_zpg;
begin

end;

{$endregion}

{$region ' SEC '}

procedure TTest_Mos6502CPU.SEC;
begin

end;

{$endregion}

{$region ' SED '}

procedure TTest_Mos6502CPU.SED;
begin

end;

{$endregion}

{$region ' SEI '}

procedure TTest_Mos6502CPU.SEI;
begin

end;

{$endregion}

{$region ' STA '}

procedure TTest_Mos6502CPU.STA_abs_x;
begin

end;

procedure TTest_Mos6502CPU.STA_abs_y;
begin

end;

procedure TTest_Mos6502CPU.STA_abs;
begin

end;

procedure TTest_Mos6502CPU.STA_ind_y;
begin

end;

procedure TTest_Mos6502CPU.STA_x_ind;
begin

end;

procedure TTest_Mos6502CPU.STA_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.STA_zpg;
begin

end;


{$endregion}

{$region ' STX '}

procedure TTest_Mos6502CPU.STX_abs;
begin

end;

procedure TTest_Mos6502CPU.STX_zpg_y;
begin

end;

procedure TTest_Mos6502CPU.STX_zpg;
begin

end;


{$endregion}

{$region ' STY '}

procedure TTest_Mos6502CPU.STY_abs;
begin

end;

procedure TTest_Mos6502CPU.STY_zpg_x;
begin

end;

procedure TTest_Mos6502CPU.STY_zpg;
begin

end;

{$endregion}

{$region ' TAX '}

procedure TTest_Mos6502CPU.TAX;
begin

end;

{$endregion}

{$region ' TAY '}

procedure TTest_Mos6502CPU.TAY;
begin

end;

{$endregion}

{$region ' TSX '}

procedure TTest_Mos6502CPU.TSX;
begin

end;

{$endregion}

{$region ' TXA '}

procedure TTest_Mos6502CPU.TXA;
begin

end;


{$endregion}

{$region ' TXS '}

procedure TTest_Mos6502CPU.TXS;
begin

end;

{$endregion}

{$region ' TYA '}

procedure TTest_Mos6502CPU.TYA;
begin

end;

{$endregion}


initialization
  TestSuite.RegisterTestCase(TTest_Mos6502CPU)

end.



