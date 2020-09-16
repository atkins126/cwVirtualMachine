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
    procedure ADC_abs_x_NoOverflow;
    procedure ADC_abs_y_NoOverflow;
    procedure ADC_abs_NoOverflow;
    procedure ADC_imm_NoOverflow;
    procedure ADC_ind_y_NoOverflow;
    procedure ADC_x_ind_NoOverflow;
    procedure ADC_zpg_x_NoOverflow;
    procedure ADC_zpg_NoOverflow;

    procedure ADC_abs_x_Overflow;
    procedure ADC_abs_y_Overflow;
    procedure ADC_abs_Overflow;
    procedure ADC_imm_Overflow;
    procedure ADC_ind_y_Overflow;
    procedure ADC_x_ind_Overflow;
    procedure ADC_zpg_x_Overflow;
    procedure ADC_zpg_Overflow;

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
    procedure BCC_rel_TRUE;
    procedure BCC_rel_FALSE;
    {$endregion}
    {$region ' BCS '}
    procedure BCS_rel_TRUE;
    procedure BCS_rel_FALSE;
    {$endregion}
    {$region ' BEQ '}
    procedure BEQ_rel_TRUE;
    procedure BEQ_rel_FALSE;
    {$endregion}
    {$region ' BIT '}
    procedure BIT_abs;
    procedure BIT_zpg;
    {$endregion}
    {$region ' BMI '}
    procedure BMI_rel_TRUE;
    procedure BMI_rel_FALSE;
    {$endregion}
    {$region ' BNE '}
    procedure BNE_rel_TRUE;
    procedure BNE_rel_FALSE;
    {$endregion}
    {$region ' BPL '}
    procedure BPL_rel_TRUE;
    procedure BPL_rel_FALSE;
    {$endregion}
    {$region ' BVC '}
    procedure BVC_rel_TRUE;
    procedure BVC_rel_FALSE;
    {$endregion}
    {$region ' BVS '}
    procedure BVS_rel_TRUE;
    procedure BVS_rel_FALSE;
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
    procedure EOR_x_ind;
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
    procedure SBC_abs_y_NoOverflow;
    procedure SBC_abs_x_NoOverflow;
    procedure SBC_abs_NoOverflow;
    procedure SBC_imm_NoOverflow;
    procedure SBC_ind_y_NoOverflow;
    procedure SBC_x_ind_NoOverflow;
    procedure SBC_zpg_x_NoOverflow;
    procedure SBC_zpg_NoOverflow;

    procedure SBC_abs_y_Overflow;
    procedure SBC_abs_x_Overflow;
    procedure SBC_abs_Overflow;
    procedure SBC_imm_Overflow;
    procedure SBC_ind_y_Overflow;
    procedure SBC_x_ind_Overflow;
    procedure SBC_zpg_x_Overflow;
    procedure SBC_zpg_Overflow;
    {$endregion}
    {$region ' SEC '}
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

procedure TTest_Mos6502CPU.ADC_abs_x_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_NoOverflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_NoOverflow;
const
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  CPU.OverflowFlag := FALSE;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_imm( cRight );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_NoOverflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_NoOverflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_NoOverflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
  CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
  CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_Overflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
  CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_Overflow;
const
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  CPU.OverflowFlag := FALSE;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_imm( cRight );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
  CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
  CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_Overflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
  CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_Overflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
  CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_Overflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
  CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_NoCarry;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_NoCarry;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_NoCarry;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_NoCarry;
const
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_imm( cRight );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_NoCarry;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_NoCarry;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_NoCarry;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_NoCarry;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryIn;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryIn;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryIn;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryIn;
const
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
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
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_imm( cRight );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryIn;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
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
  Memory[cMemoryLocationUnderTest] := cLeft;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cRight );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryIn;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
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
  Memory[cMemoryLocationUnderTest] := cLeft;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cRight );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryIn;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryIn;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryOut;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryOut;
const
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  ByteCode.LDA_imm( cRight );
  ByteCode.ADC_imm( cLeft );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryOut;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryOut;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryOut;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDX_imm( $01 );
  ByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDY_imm( $01 );
  ByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryInAndOut;
const
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
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
  ByteCode.LDA_imm( cRight );
  ByteCode.ADC_imm( cLeft );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryInAndOut;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cREsult, CPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryInAndOut;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
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
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.ADC_zpg( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cResult, CPU.A )
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
const
  cByteUnderTest = $00BB;
  cByteOffset = $02;
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
  ByteCode.LDX_imm( cByteUnderTest-cByteOffset );
  ByteCode.ASL_zpg_x( cByteOffset );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $54, Memory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.ASL_zpg;
const
  cByteUnderTest = $BB;
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
  ByteCode.ASL_zpg( cByteUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( $54, Memory[cByteUnderTest] )
end;

{$endregion}

{$region ' BCC '}

procedure TTest_Mos6502CPU.BCC_rel_TRUE;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  CPU.CarryFlag := FALSE;
  ByteCode.BCC_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.BCC_rel_FALSE;
const
  cTestValue = $CC;
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
  CPU.A := $00;
  CPU.CarryFlag := TRUE;
  ByteCode.BCC_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

{$endregion}

{$region ' BCS '}

procedure TTest_Mos6502CPU.BCS_rel_TRUE;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  CPU.CarryFlag := TRUE;
  ByteCode.BCS_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.BCS_rel_FALSE;
const
  cTestValue = $CC;
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
  CPU.A := $00;
  CPU.CarryFlag := FALSE;
  ByteCode.BCS_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

{$endregion}

{$region ' BEQ '}

procedure TTest_Mos6502CPU.BEQ_rel_TRUE;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  CPU.ZeroFlag := TRUE;
  ByteCode.BEQ_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.BEQ_rel_FALSE;
const
  cTestValue = $CC;
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
  CPU.A := $00;
  CPU.ZeroFlag := FALSE;
  ByteCode.BEQ_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
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

procedure TTest_Mos6502CPU.BMI_rel_TRUE;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  CPU.NegativeFlag := TRUE;
  ByteCode.BMI_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.BMI_rel_FALSE;
const
  cTestValue = $CC;
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
  CPU.A := $00;
  CPU.NegativeFlag := FALSE;
  ByteCode.BMI_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

{$endregion}

{$region ' BNE '}

procedure TTest_Mos6502CPU.BNE_rel_TRUE;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  CPU.ZeroFlag := FALSE;
  ByteCode.BNE_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.BNE_rel_FALSE;
const
  cTestValue = $CC;
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
  CPU.A := $00;
  CPU.ZeroFlag := TRUE;
  ByteCode.BNE_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

{$endregion}

{$region ' BPL '}

procedure TTest_Mos6502CPU.BPL_rel_TRUE;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  CPU.NegativeFlag := FALSE;
  ByteCode.BPL_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.BPL_rel_FALSE;
const
  cTestValue = $CC;
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
  CPU.A := $00;
  CPU.NegativeFlag := TRUE;
  ByteCode.BPL_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

{$endregion}

{$region ' BVC '}

procedure TTest_Mos6502CPU.BVC_rel_TRUE;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  CPU.OverflowFlag := FALSE;
  ByteCode.BVC_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.BVC_rel_FALSE;
const
  cTestValue = $CC;
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
  CPU.A := $00;
  CPU.OverflowFlag := TRUE;
  ByteCode.BVC_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

{$endregion}

{$region ' BVS '}

procedure TTest_Mos6502CPU.BVS_rel_TRUE;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  CPU.OverflowFlag := TRUE;
  ByteCode.BVS_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.BVS_rel_FALSE;
const
  cTestValue = $CC;
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
  CPU.A := $00;
  CPU.OverflowFlag := FALSE;
  ByteCode.BVS_rel( $02 );     //- Jump over LDA_imm($00);
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

{$endregion}

{$region ' CLC '}

procedure TTest_Mos6502CPU.CLC;
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
  ByteCode.CLC;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, CPU.CarryFlag );
end;

{$endregion}

{$region ' CLD '}

procedure TTest_Mos6502CPU.CLD;
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
  CPU.DecimalModeFlag := TRUE;
  ByteCode.CLD;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, CPU.DecimalModeFlag );
end;

{$endregion}

{$region ' CLI '}

procedure TTest_Mos6502CPU.CLI;
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
  CPU.IRQDisableFlag := TRUE;
  ByteCode.CLI;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, CPU.IRQDisableFlag );
end;


{$endregion}

{$region ' CLV '}

procedure TTest_Mos6502CPU.CLV;
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
  CPU.OverflowFlag := TRUE;
  ByteCode.CLV;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
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
const
  cMemoryLocationUnderTest = $0A00;
  cTestValue = $CC;
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
  Memory[cMemoryLocationUnderTest] := cTestValue;
  ByteCode.LDX_imm( $01 );
  ByteCode.DEC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), Memory[cMemoryLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.DEC_abs;
const
  cMemoryLocationUnderTest = $0A00;
  cTestValue = $CC;
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
  Memory[cMemoryLocationUnderTest] := cTestValue;
  ByteCode.DEC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), Memory[cMemoryLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.DEC_zpg_x;
const
  cMemoryLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cMemoryLocationUnderTest] := cTestValue;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( $01 );
  ByteCode.DEC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), Memory[cMemoryLocationUnderTest] );
end;

procedure TTest_Mos6502CPU.DEC_zpg;
const
  cMemoryLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cMemoryLocationUnderTest] := cTestValue;
  ByteCode.DEC_zpg( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), Memory[cMemoryLocationUnderTest] );
end;

{$endregion}

{$region ' DEX '}

procedure TTest_Mos6502CPU.DEX;
const
  cTestValue = $CC;
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
  CPU.X := cTestValue;
  ByteCode.DEX;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), CPU.X );
end;

{$endregion}

{$region ' DEY '}

procedure TTest_Mos6502CPU.DEY;
const
  cTestValue = $CC;
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
  CPU.Y := cTestValue;
  ByteCode.DEY;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), CPU.Y );
end;

{$endregion}

{$region ' EOR '}

procedure TTest_Mos6502CPU.EOR_abs_x;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDX_imm( $01 );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.EOR_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.EOR_abs_y;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.EOR_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.EOR_abs;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.EOR_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.EOR_imm;
const
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
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
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.EOR_imm( cInverter );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.EOR_ind_y;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.EOR_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.EOR_x_ind;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.EOR_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.EOR_zpg_x;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.EOR_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestREs, CPU.A )
end;

procedure TTest_Mos6502CPU.EOR_zpg;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.EOR_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

{$endregion}

{$region ' INC '}

procedure TTest_Mos6502CPU.INC_abs_x;
const
  cMemoryLocationUnderTest = $0A00;
  cTestValue = $CC;
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
  Memory[cMemoryLocationUnderTest] := cTestValue;
  ByteCode.LDX_imm( $01 );
  ByteCode.INC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), Memory[cMemoryLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.INC_abs;
const
  cMemoryLocationUnderTest = $0A00;
  cTestValue = $CC;
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
  Memory[cMemoryLocationUnderTest] := cTestValue;
  ByteCode.INC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), Memory[cMemoryLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.INC_zpg_x;
const
  cMemoryLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cMemoryLocationUnderTest] := cTestValue;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( $01 );
  ByteCode.INC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), Memory[cMemoryLocationUnderTest] );
end;

procedure TTest_Mos6502CPU.INC_zpg;
const
  cMemoryLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cMemoryLocationUnderTest] := cTestValue;
  ByteCode.INC_zpg( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), Memory[cMemoryLocationUnderTest] );
end;

{$endregion}

{$region ' INX '}

procedure TTest_Mos6502CPU.INX;
const
  cTestValue = $CC;
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
  CPU.X := cTestValue;
  ByteCode.INX;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), CPU.X );
end;

{$endregion}

{$region ' INY '}

procedure TTest_Mos6502CPU.INY;
const
  cTestValue = $CC;
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
  CPU.Y := cTestValue;
  ByteCode.INY;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), CPU.Y );
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
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  Memory[cMemoryLocation] := cTestValue;
  ByteCode.LDX_imm( $01 );
  ByteCode.LDA_abs_x( pred(cMemoryLocation) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.A )
end;

procedure TTest_Mos6502CPU.LDA_abs_y;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  Memory[cMemoryLocation] := cTestValue;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_abs_y( pred(cMemoryLocation) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.A )
end;

procedure TTest_Mos6502CPU.LDA_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  Memory[cMemoryLocation] := cTestValue;
  ByteCode.LDA_abs( cMemoryLocation );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.A )
end;

procedure TTest_Mos6502CPU.LDA_imm;
const
  cTestValue = $CC;
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
  ByteCode.LDA_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.A );
end;

procedure TTest_Mos6502CPU.LDA_ind_y;
const
  cLocationUnderTest = $0A00;
  cTestValue = $CC;
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
  Memory[cLocationUnderTest] := cTestValue;
  Memory[$00BB] := $FF;
  Memory[$00BC] := $09;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.A )
end;

procedure TTest_Mos6502CPU.LDA_x_ind;
const
  cLocationUnderTest = $0A00;
  cTestValue = $CC;
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
  Memory[cLocationUnderTest] := cTestValue;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BA );
  ByteCode.LDA_x_ind( $01 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.A )
end;

procedure TTest_Mos6502CPU.LDA_zpg_x;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cLocationUnderTest] := $CC;
  ByteCode.LDX_imm( pred(pred(cLocationUnderTest)) );
  ByteCode.LDA_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.A )
end;

procedure TTest_Mos6502CPU.LDA_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cLocationUnderTest] := $CC;
  ByteCode.LDA_zpg_x( cLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.A )
end;

{$endregion}

{$region ' LDX '}

procedure TTest_Mos6502CPU.LDX_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cLocationUnderTest] := $CC;
  ByteCode.LDX_zpg( cLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.X )
end;

procedure TTest_Mos6502CPU.LDX_abs_y;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  Memory[cMemoryLocation] := cTestValue;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDX_abs_y( pred(cMemoryLocation) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.X )
end;

procedure TTest_Mos6502CPU.LDX_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  Memory[cMemoryLocation] := cTestValue;
  ByteCode.LDX_abs( cMemoryLocation );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.X );
end;

procedure TTest_Mos6502CPU.LDX_imm;
const
  cTestValue = $CC;
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
  ByteCode.LDX_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.X );
end;

procedure TTest_Mos6502CPU.LDX_zpg_y;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cLocationUnderTest] := $CC;
  ByteCode.LDY_imm( pred(pred(cLocationUnderTest)) );
  ByteCode.LDX_zpg_y( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.X )
end;

{$endregion}

{$region ' LDY '}

procedure TTest_Mos6502CPU.LDY_abs_x;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  Memory[cMemoryLocation] := cTestValue;
  ByteCode.LDX_imm( $01 );
  ByteCode.LDY_abs_x( pred(cMemoryLocation) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.Y )
end;

procedure TTest_Mos6502CPU.LDY_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  Memory[cMemoryLocation] := cTestValue;
  ByteCode.LDY_abs( cMemoryLocation );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.Y );
end;

procedure TTest_Mos6502CPU.LDY_imm;
const
  cTestValue = $CC;
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
  ByteCode.LDY_imm( cTestValue );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.Y );
end;

procedure TTest_Mos6502CPU.LDY_zpg_x;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cLocationUnderTest] := $CC;
  ByteCode.LDX_imm( pred(pred(cLocationUnderTest)) );
  ByteCode.LDY_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.Y )
end;

procedure TTest_Mos6502CPU.LDY_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  Memory[cLocationUnderTest] := $CC;
  ByteCode.LDY_zpg( cLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, CPU.Y )
end;

{$endregion}

{$region ' LSR '}

procedure TTest_Mos6502CPU.LSR;
const
  cTestValue = $55;
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
  ByteCode.LDA_imm( cTestValue );
  ByteCode.LSR;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, CPU.A )
end;

procedure TTest_Mos6502CPU.LSR_abs_x;
const
  cByteUnderTest = $0A00;
  cTestValue = $55;
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
  Memory[succ(cByteUnderTest)] := cTestValue;
  ByteCode.LDX_imm( $01 );
  ByteCode.LSR_abs_x( cByteUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, Memory[succ(cByteUnderTest)] )
end;

procedure TTest_Mos6502CPU.LSR_abs;
const
  cByteUnderTest = $0A00;
  cTestValue = $55;
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
  Memory[cByteUnderTest] := cTestValue;
  ByteCode.LSR_abs( cByteUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, Memory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.LSR_zpg_x;
const
  cByteUnderTest = $00BB;
  cByteOffset = $02;
  cTestValue = $55;
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
  Memory[cByteUnderTest] := cTestValue;
  ByteCode.LDX_imm( cByteUnderTest-cByteOffset );
  ByteCode.LSR_zpg_x( cByteOffset );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, Memory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.LSR_zpg;
const
  cByteUnderTest = $BB;
  cTestValue = $55;
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
  Memory[cByteUnderTest] := cTestValue;
  ByteCode.LSR_zpg( cByteUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, Memory[cByteUnderTest] )
end;

{$endregion}

{$region ' ORA '}

procedure TTest_Mos6502CPU.ORA_abs_x;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDX_imm( $01 );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.ORA_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.ORA_abs_y;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.ORA_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.ORA_abs;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.ORA_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.ORA_imm;
const
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
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
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.ORA_imm( cInverter );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.ORA_ind_y;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.ORA_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.ORA_x_ind;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.ORA_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

procedure TTest_Mos6502CPU.ORA_zpg_x;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.ORA_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestREs, CPU.A )
end;

procedure TTest_Mos6502CPU.ORA_zpg;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
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
  Memory[cMemoryLocationUnderTest] := cInverter;
  ByteCode.LDA_imm( cTestAcc );
  ByteCode.ORA_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, CPU.A )
end;

{$endregion}

{$region ' PHA '}

procedure TTest_Mos6502CPU.PHA;
const
  cTestVal = $AA;
  cStackAddr = $01FF;
  cStackPtr = $FE;
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
  ByteCode.LDA_imm( cTestVal );
  ByteCode.PHA;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestVal, Memory[cStackAddr] );
  TTest.Expect( cStackPtr, CPU.SP );
end;

{$endregion}

{$region ' PHP '}

procedure TTest_Mos6502CPU.PHP;
const
  cTestVal = $AA;
  cStackAddr = $01FF;
  cStackPtr = $FE;
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
  CPU.SR := cTestVal;
  ByteCode.PHP;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestVal, Memory[cStackAddr] );
  TTest.Expect( cStackPtr, CPU.SP );
end;

{$endregion}

{$region ' PLA '}

procedure TTest_Mos6502CPU.PLA;
const
  cTestVal = $AA;
  cStackAddr = $01FF;
  cStackPtr = $FF;
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
  Memory[cStackAddr] := cTestVal;
  CPU.SP := pred(cStackPtr);
  ByteCode.PLA;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestVal, CPU.A );
  TTest.Expect( cStackPtr, CPU.SP );
end;

{$endregion}

{$region ' PLP '}

procedure TTest_Mos6502CPU.PLP;
const
  cTestVal = $AA;
  cStackAddr = $01FF;
  cStackPtr = $FE;
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
  Memory[cStackAddr] := cTestVal;
  CPU.SP := cStackPtr;
  ByteCode.PLP;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  // - NOTE: SP will get the break flag set after PLP, so here we or ($01 shl 4) to add the break command to test val.
  TTest.Expect( cTestVal or ($01 shl 4), CPU.SR );
  TTest.Expect( succ(cStackPtr), CPU.SP );
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

procedure TTest_Mos6502CPU.SBC_abs_y_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cRes, CPU.A );
end;

procedure TTest_Mos6502CPU.SBC_abs_x_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cRes, CPU.A );
end;

procedure TTest_Mos6502CPU.SBC_abs_NoOverflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cRes, CPU.A );
end;

procedure TTest_Mos6502CPU.SBC_imm_NoOverflow;
const
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_imm( cRight );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cRes, CPU.A );
end;

procedure TTest_Mos6502CPU.SBC_ind_y_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDY_imm( $01 );
  ByteCode.SBC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cRes, CPU.A );
end;

procedure TTest_Mos6502CPU.SBC_x_ind_NoOverflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cRes, CPU.A );
end;

procedure TTest_Mos6502CPU.SBC_zpg_x_NoOverflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cRes, CPU.A );
end;

procedure TTest_Mos6502CPU.SBC_zpg_NoOverflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, CPU.OverflowFlag );
  TTest.Expect( cRes, CPU.A );
end;

procedure TTest_Mos6502CPU.SBC_abs_y_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $FF;
  cRes: int8 = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDY_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_abs_y( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cRes, int8(CPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_abs_x_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $01 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_abs_x( pred(cMemoryLocationUnderTest) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cRes, int8(CPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_abs_Overflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_abs( cMemoryLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cRes, int8(CPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_imm_Overflow;
const
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_imm( cRight );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cRes, int8(CPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_ind_y_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDA_imm( cLeft );
  ByteCode.LDY_imm( $01 );
  ByteCode.SBC_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cRes, int8(CPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_x_ind_Overflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BB );
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_x_ind( $00 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cRes, int8(CPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_zpg_x_Overflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDX_imm( $B9 );
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cRes, int8(CPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_zpg_Overflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
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
  CPU.OverflowFlag := FALSE;
  Memory[cMemoryLocationUnderTest] := cRight;
  ByteCode.LDA_imm( cLeft );
  ByteCode.SBC_zpg( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, CPU.OverflowFlag );
  TTest.Expect( cRes, int8(CPU.A) );
end;

{$endregion}

{$region ' SEC '}

procedure TTest_Mos6502CPU.SEC;
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
  ByteCode.SEC;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.CarryFlag );
end;

{$endregion}

{$region ' SED '}

procedure TTest_Mos6502CPU.SED;
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
  CPU.DecimalModeFlag := FALSE;
  ByteCode.SED;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.DecimalModeFlag );
end;

{$endregion}

{$region ' SEI '}

procedure TTest_Mos6502CPU.SEI;
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
  CPU.IRQDisableFlag := FALSE;
  ByteCode.SEI;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, CPU.IRQDisableFlag );
end;

{$endregion}

{$region ' STA '}

procedure TTest_Mos6502CPU.STA_abs_x;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  ByteCode.LDX_imm( $01 );
  ByteCode.STA_abs_x( pred(cMemoryLocation) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cMemoryLocation] )
end;

procedure TTest_Mos6502CPU.STA_abs_y;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  ByteCode.LDY_imm( $01 );
  ByteCode.STA_abs_y( pred(cMemoryLocation) );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cMemoryLocation] )
end;

procedure TTest_Mos6502CPU.STA_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  ByteCode.STA_abs( cMemoryLocation );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cMemoryLocation] )
end;

procedure TTest_Mos6502CPU.STA_ind_y;
const
  cLocationUnderTest = $0A00;
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  Memory[$00BB] := $FF;
  Memory[$00BC] := $09;
  ByteCode.LDY_imm( $01 );
  ByteCode.STA_ind_y( $BB );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.STA_x_ind;
const
  cLocationUnderTest = $0A00;
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  Memory[$00BB] := $00;
  Memory[$00BC] := $0A;
  ByteCode.LDX_imm( $BA );
  ByteCode.STA_x_ind( $01 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.STA_zpg_x;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  CPU.A := $CC;
  ByteCode.LDX_imm( pred(pred(cLocationUnderTest)) );
  ByteCode.STA_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.STA_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  CPU.A := $CC;
  ByteCode.STA_zpg( cLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cLocationUnderTest] )
end;

{$endregion}

{$region ' STX '}

procedure TTest_Mos6502CPU.STX_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  CPU.X := cTestValue;
  ByteCode.STX_abs( cMemoryLocation );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cMemoryLocation] );
end;

procedure TTest_Mos6502CPU.STX_zpg_y;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  CPU.X := $CC;
  ByteCode.LDY_imm( pred(pred(cLocationUnderTest)) );
  ByteCode.STX_zpg_y( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cLocationUnderTest] );
end;

procedure TTest_Mos6502CPU.STX_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  CPU.X := $CC;
  ByteCode.STX_zpg( cLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cLocationUnderTest] )
end;

{$endregion}

{$region ' STY '}

procedure TTest_Mos6502CPU.STY_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
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
  CPU.Y := cTestValue;
  ByteCode.STY_abs( cMemoryLocation );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cMemoryLocation] );
end;

procedure TTest_Mos6502CPU.STY_zpg_x;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  CPU.Y := $CC;
  ByteCode.LDX_imm( pred(pred(cLocationUnderTest)) );
  ByteCode.STY_zpg_x( $02 );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.STY_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
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
  CPU.Y := $CC;
  ByteCode.STY_zpg( cLocationUnderTest );
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, Memory[cLocationUnderTest] )
end;

{$endregion}

{$region ' TAX '}

procedure TTest_Mos6502CPU.TAX;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  ByteCode.TAX;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.X );
end;

{$endregion}

{$region ' TAY '}

procedure TTest_Mos6502CPU.TAY;
const
  cTestValue = $CC;
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
  CPU.A := cTestValue;
  ByteCode.TAY;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.Y );
end;

{$endregion}

{$region ' TSX '}

procedure TTest_Mos6502CPU.TSX;
const
  cTestValue = $CC;
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
  CPU.SP := cTestValue;
  ByteCode.TSX;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.X );
end;

{$endregion}

{$region ' TXA '}

procedure TTest_Mos6502CPU.TXA;
const
  cTestValue = $CC;
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
  CPU.X := cTestValue;
  ByteCode.TXA;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;


{$endregion}

{$region ' TXS '}

procedure TTest_Mos6502CPU.TXS;
const
  cTestValue = $CC;
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
  CPU.X := cTestValue;
  ByteCode.TXS;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.SP );
end;

{$endregion}

{$region ' TYA '}

procedure TTest_Mos6502CPU.TYA;
const
  cTestValue = $CC;
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
  CPU.Y := cTestValue;
  ByteCode.TYA;
  ByteCode.BRK;
  while not CPU.BreakFlag do begin
    CPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, CPU.A );
end;

{$endregion}

initialization
  TestSuite.RegisterTestCase(TTest_Mos6502CPU)

end.



