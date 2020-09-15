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
    procedure ADC_abs_x_NoCarry;
    procedure ADC_abs_y_NoCarry;
    procedure ADC_abs_NoCarry;
    procedure ADC_imm_NoCarry;
    procedure ADC_ind_y_NoCarry;
    procedure ADC_x_ind_NoCarry;
    procedure ADC_zpg_x_NoCarry;
    procedure ADC_zpg_NoCarry;

    procedure ADC_abs_x_CarryIn;
    procedure ADC_abs_y_CarryIn;
    procedure ADC_abs_CarryIn;
    procedure ADC_imm_CarryIn;
    procedure ADC_ind_y_CarryIn;
    procedure ADC_x_ind_CarryIn;
    procedure ADC_zpg_x_CarryIn;
    procedure ADC_zpg_CarryIn;

    procedure ADC_abs_x_CarryOut;
    procedure ADC_abs_y_CarryOut;
    procedure ADC_abs_CarryOut;
    procedure ADC_imm_CarryOut;
    procedure ADC_ind_y_CarryOut;
    procedure ADC_x_ind_CarryOut;
    procedure ADC_zpg_x_CarryOut;
    procedure ADC_zpg_CarryOut;

    procedure ADC_abs_x_CarryInAndOut;
    procedure ADC_abs_y_CarryInAndOut;
    procedure ADC_abs_CarryInAndOut;
    procedure ADC_imm_CarryInAndOut;
    procedure ADC_ind_y_CarryInAndOut;
    procedure ADC_x_ind_CarryInAndOut;
    procedure ADC_zpg_x_CarryInAndOut;
    procedure ADC_zpg_CarryInAndOut;
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
, cwVirtualMachine.Mos6502
;

procedure TTest_Mos6502CPU.Reset;
begin

end;

procedure TTest_Mos6502CPU.Clock;
begin

end;

{$region ' ADC '}

procedure TTest_Mos6502CPU.ADC_abs_x_NoCarry;
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
  Memory[$0A01] := $02;
  ByteCode.LDA_imm( $CC );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_NoCarry;
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
  Memory[$0A01] := $02;
  ByteCode.LDA_imm( $CC );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_NoCarry;
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
  ByteCode.ADC_abs( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_NoCarry;
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
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_NoCarry;
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
  Memory[$0A01] := $CC;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( $01 );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CD, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_NoCarry;
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
  Memory[$0A00] := $CC;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( $01 );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CD, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_NoCarry;
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
  Memory[$00BB] := $CC;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( $01 );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CD, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_NoCarry;
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
  Memory[$00BB] := $CC;
  ByteCode.LDA_imm( $01 );
  ByteCode.ADC_zpg_x( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CD, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryIn;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A01] := $02;
  ByteCode.LDA_imm( $CC );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CF, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryIn;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A01] := $02;
  ByteCode.LDA_imm( $CC );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CF, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryIn;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A00] := $02;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_abs( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CF, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryIn;
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
  CPU.CarryFlag := TRUE;
  ByteCode.LDA_imm( $CC );
  ByteCode.ADC_imm( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CF, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryIn;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A01] := $CC;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( $01 );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryIn;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A00] := $CC;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( $01 );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryIn;
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
  CPU.CarryFlag := TRUE;
  Memory[$00BB] := $CC;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( $01 );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryIn;
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
  CPU.CarryFlag := TRUE;
  Memory[$00BB] := $CC;
  ByteCode.LDA_imm( $01 );
  ByteCode.ADC_zpg_x( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( $CE, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryOut;
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
  Memory[$0A01] := $02;
  ByteCode.LDA_imm( $FE );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $00, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryOut;
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
  Memory[$0A01] := $02;
  ByteCode.LDA_imm( $FE );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $00, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryOut;
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
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_abs( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $00, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryOut;
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
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $00, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryOut;
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
  Memory[$0A01] := $FE;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( $02 );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $00, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryOut;
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
  Memory[$0A00] := $FE;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( $02 );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $00, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryOut;
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
  Memory[$00BB] := $FE;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( $02 );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $00, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryOut;
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
  Memory[$00BB] := $FE;
  ByteCode.LDA_imm( $02 );
  ByteCode.ADC_zpg_x( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $00, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryInAndOut;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A01] := $02;
  ByteCode.LDA_imm( $FE );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryInAndOut;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A01] := $02;
  ByteCode.LDA_imm( $FE );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryInAndOut;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A00] := $02;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_abs( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryInAndOut;
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
  CPU.CarryFlag := TRUE;
  ByteCode.LDA_imm( $FE );
  ByteCode.ADC_imm( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryInAndOut;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A01] := $FE;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( $02 );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryInAndOut;
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
  CPU.CarryFlag := TRUE;
  Memory[$0A00] := $FE;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( $02 );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryInAndOut;
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
  CPU.CarryFlag := TRUE;
  Memory[$00BB] := $FE;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( $02 );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryInAndOut;
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
  CPU.CarryFlag := TRUE;
  Memory[$00BB] := $FE;
  ByteCode.LDA_imm( $02 );
  ByteCode.ADC_zpg_x( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $01, CPU.A )
end;

{$endregion}

{$region ' AND '}
procedure TTest_Mos6502CPU.AND_abs_x;
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
  Memory[$0A01] := $AA;       // right
  ByteCode.LDA_imm( $AA );    // left
  ByteCode.LDX_imm( $01 );
  ByteCode.AND_abs_x( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, CPU.A )
end;

procedure TTest_Mos6502CPU.AND_abs_y;
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
  Memory[$0A01] := $AA;       // right
  ByteCode.LDA_imm( $AA );    // left
  ByteCode.LDY_imm( $01 );
  ByteCode.AND_abs_y( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, CPU.A )
end;

procedure TTest_Mos6502CPU.AND_abs;
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
  Memory[$0A00] := $AA;       // right
  ByteCode.LDA_imm( $AA );    // left
  ByteCode.AND_abs( $0A00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, CPU.A )
end;

procedure TTest_Mos6502CPU.AND_imm;
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
  ByteCode.LDA_imm( $AA );    // left
  ByteCode.AND_imm( $AA );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, CPU.A )
end;

procedure TTest_Mos6502CPU.AND_ind_y;
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
  Memory[$0A01] := $AA;      // right
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( $AA );   // left
  ByteCode.AND_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, CPU.A )
end;

procedure TTest_Mos6502CPU.AND_x_ind;
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
  Memory[$0A00] := $AA;      // right
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( $AA );
  ByteCode.AND_x_ind( $00 );  // left
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, CPU.A )
end;

procedure TTest_Mos6502CPU.AND_zpg_x;
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
  Memory[$00BB] := $AA; // right
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( $AA ); // left
  ByteCode.AND_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( $AA, CPU.A )
end;

procedure TTest_Mos6502CPU.AND_zpg;
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
  Memory[$00BB] := $AA; // right
  ByteCode.LDA_imm( $AA ); // left
  ByteCode.AND_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( $AA, CPU.A )
end;

{$endregion}

{$region ' ASL '}

procedure TTest_Mos6502CPU.ASL;
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
  ByteCode.LDA_imm( $AA ); // value
  ByteCode.ASL;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $54, CPU.A )
end;

procedure TTest_Mos6502CPU.ASL_abs;
const
  cByteUnderTest = $0A00;
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
  Memory[cByteUnderTest] := $AA;
  ByteCode.ASL_abs( cByteUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $54, Memory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.ASL_abs_x;
const
  cByteUnderTest = $0A00;
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
  Memory[succ(cByteUnderTest)] := $AA;
  ByteCode.LDX_imm( $01 );
  ByteCode.ASL_abs_x( cByteUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $54, Memory[succ(cByteUnderTest)] )
end;

procedure TTest_Mos6502CPU.ASL_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ASL_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BCC '}

procedure TTest_Mos6502CPU.BCC_rel;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BCS '}

procedure TTest_Mos6502CPU.BCS_rel;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BEQ '}

procedure TTest_Mos6502CPU.BEQ_rel;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BIT '}

procedure TTest_Mos6502CPU.BIT_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.BIT_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BMI '}

procedure TTest_Mos6502CPU.BMI_rel;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BNE '}

procedure TTest_Mos6502CPU.BNE_rel;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BPL '}

procedure TTest_Mos6502CPU.BPL_rel;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BRK '}

procedure TTest_Mos6502CPU.BRK;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BVC '}

procedure TTest_Mos6502CPU.BVC_rel;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' BVS '}

procedure TTest_Mos6502CPU.BVS_rel;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' CLC '}

procedure TTest_Mos6502CPU.CLC;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' CLD '}

procedure TTest_Mos6502CPU.CLD;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' CLI '}

procedure TTest_Mos6502CPU.CLI;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' CLV '}

procedure TTest_Mos6502CPU.CLV;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' CMP '}

procedure TTest_Mos6502CPU.CMP_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CMP_abs_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CMP_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CMP_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CMP_ind_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CMP_x_ind;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CMP_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CMP_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' CPX '}

procedure TTest_Mos6502CPU.CPX_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CPX_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CPX_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' CPY '}

procedure TTest_Mos6502CPU.CPY_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CPY_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.CPY_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' DEC '}

procedure TTest_Mos6502CPU.DEC_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.DEC_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.DEC_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.DEC_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' DEX '}

procedure TTest_Mos6502CPU.DEX;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' DEY '}

procedure TTest_Mos6502CPU.DEY;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' EOR '}

procedure TTest_Mos6502CPU.EOR_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.EOR_abs_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.EOR_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.EOR_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.EOR_ind_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.EOR_X_ind;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.EOR_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.EOR_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' INC '}

procedure TTest_Mos6502CPU.INC_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.INC_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.INC_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.INC_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' INX '}

procedure TTest_Mos6502CPU.INX;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' INY '}

procedure TTest_Mos6502CPU.INY;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' JMP '}

procedure TTest_Mos6502CPU.JMP_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.JMP_ind;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' JSR '}

procedure TTest_Mos6502CPU.JSR_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' LDA '}

procedure TTest_Mos6502CPU.LDA_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDA_abs_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDA_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDA_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDA_ind_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDA_x_ind;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDA_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDA_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' LDX '}

procedure TTest_Mos6502CPU.LDX_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDX_abs_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDX_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDX_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDX_zpg_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' LDY '}

procedure TTest_Mos6502CPU.LDY_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDY_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDY_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDY_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LDY_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' LSR '}

procedure TTest_Mos6502CPU.LSR;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LSR_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LSR_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LSR_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.LSR_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' NOP '}

procedure TTest_Mos6502CPU.NOP;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' ORA '}

procedure TTest_Mos6502CPU.ORA_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ORA_abs_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ORA_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ORA_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ORA_ind_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ORA_x_ind;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ORA_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ORA_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' PHA '}

procedure TTest_Mos6502CPU.PHA;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' PHP '}

procedure TTest_Mos6502CPU.PHP;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' PLA '}

procedure TTest_Mos6502CPU.PLA;
begin
  // Arrange:
  // Act:
  // Assert:
end;


{$endregion}

{$region ' PLP '}

procedure TTest_Mos6502CPU.PLP;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' ROL '}

procedure TTest_Mos6502CPU.ROL;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ROL_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ROL_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ROL_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ROL_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' ROR '}

procedure TTest_Mos6502CPU.ROR;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ROR_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ROR_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ROR_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.ROR_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' RTI '}

procedure TTest_Mos6502CPU.RTI;
begin
  // Arrange:
  // Act:
  // Assert:
end;


{$endregion}

{$region ' RTS '}

procedure TTest_Mos6502CPU.RTS;
begin
  // Arrange:
  // Act:
  // Assert:
end;


{$endregion}

{$region ' SBC '}

procedure TTest_Mos6502CPU.SBC_abs_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.SBC_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.SBC_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.SBC_imm;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.SBC_ind_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.SBC_x_ind;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.SBC_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.SBC_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' SEC '}

procedure TTest_Mos6502CPU.SEC;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' SED '}

procedure TTest_Mos6502CPU.SED;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' SEI '}

procedure TTest_Mos6502CPU.SEI;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' STA '}

procedure TTest_Mos6502CPU.STA_abs_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STA_abs_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STA_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STA_ind_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STA_x_ind;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STA_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STA_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;


{$endregion}

{$region ' STX '}

procedure TTest_Mos6502CPU.STX_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STX_zpg_y;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STX_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' STY '}

procedure TTest_Mos6502CPU.STY_abs;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STY_zpg_x;
begin
  // Arrange:
  // Act:
  // Assert:
end;

procedure TTest_Mos6502CPU.STY_zpg;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' TAX '}

procedure TTest_Mos6502CPU.TAX;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' TAY '}

procedure TTest_Mos6502CPU.TAY;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' TSX '}

procedure TTest_Mos6502CPU.TSX;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' TXA '}

procedure TTest_Mos6502CPU.TXA;
begin
  // Arrange:
  // Act:
  // Assert:
end;


{$endregion}

{$region ' TXS '}

procedure TTest_Mos6502CPU.TXS;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

{$region ' TYA '}

procedure TTest_Mos6502CPU.TYA;
begin
  // Arrange:
  // Act:
  // Assert:
end;

{$endregion}

initialization
  TestSuite.RegisterTestCase(TTest_Mos6502CPU)

end.



