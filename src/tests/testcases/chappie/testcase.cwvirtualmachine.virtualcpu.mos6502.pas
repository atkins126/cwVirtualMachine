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
, cwVirtualMachine
, cwVirtualMachine.Mos6502
;

type
  TTest_Mos6502CPU = class(TTestCase)
  private
    fMemory: I6502VirtualMemory;
    fByteCode: I6502ByteCode;
    fCPU: I6502CPU;
  published
    procedure Setup;
    procedure Teardown;
  published

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
    procedure BIT_abs_NonZeroTF;
    procedure BIT_zpg_NonZeroTF;
    procedure BIT_abs_NonZeroFT;
    procedure BIT_zpg_NonZeroFT;
    procedure BIT_abs_ZeroFF;
    procedure BIT_zpg_ZeroFF;
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
    procedure CMP_abs_x_Negative;
    procedure CMP_abs_y_Negative;
    procedure CMP_abs_Negative;
    procedure CMP_imm_Negative;
    procedure CMP_ind_y_Negative;
    procedure CMP_x_ind_Negative;
    procedure CMP_zpg_x_Negative;
    procedure CMP_zpg_Negative;

    procedure CMP_abs_x_Zero;
    procedure CMP_abs_y_Zero;
    procedure CMP_abs_Zero;
    procedure CMP_imm_Zero;
    procedure CMP_ind_y_Zero;
    procedure CMP_x_ind_Zero;
    procedure CMP_zpg_x_Zero;
    procedure CMP_zpg_Zero;

    procedure CMP_abs_x_Carry;
    procedure CMP_abs_y_Carry;
    procedure CMP_abs_Carry;
    procedure CMP_imm_Carry;
    procedure CMP_ind_y_Carry;
    procedure CMP_x_ind_Carry;
    procedure CMP_zpg_x_Carry;
    procedure CMP_zpg_Carry;
    {$endregion}
    {$region ' CPX '}
    procedure CPX_abs_Negative;
    procedure CPX_imm_Negative;
    procedure CPX_zpg_Negative;

    procedure CPX_abs_Zero;
    procedure CPX_imm_Zero;
    procedure CPX_zpg_Zero;

    procedure CPX_abs_Carry;
    procedure CPX_imm_Carry;
    procedure CPX_zpg_Carry;
    {$endregion}
    {$region ' CPY '}
    procedure CPY_abs_Negative;
    procedure CPY_imm_Negative;
    procedure CPY_zpg_Negative;

    procedure CPY_abs_Zero;
    procedure CPY_imm_Zero;
    procedure CPY_zpg_Zero;

    procedure CPY_abs_Carry;
    procedure CPY_imm_Carry;
    procedure CPY_zpg_Carry;
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
;

procedure TTest_Mos6502CPU.Setup;
begin
  fMemory := T6502VirtualMemory.Create;
  fCPU := T6502CPU.Create( fMemory );
  fByteCode := T6502ByteCode.Create( fMemory );
end;

procedure TTest_Mos6502CPU.Teardown;
begin
  fMemory := nil;
  fCPU := nil;
  fByteCode := nil;
end;

{$region ' ADC '}

procedure TTest_Mos6502CPU.ADC_abs_x_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDX_imm( $01 );
  fByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDY_imm( $01 );
  fByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_NoOverflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_NoOverflow;
const
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_imm( cRight );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_NoOverflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_NoOverflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_NoOverflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDX_imm( $01 );
  fByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
  fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDY_imm( $01 );
  fByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
  fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_Overflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
  fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_Overflow;
const
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_imm( cRight );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
  fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
  fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_Overflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
  fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_Overflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
  fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_Overflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
  fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_NoCarry;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDX_imm( $01 );
  fByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_NoCarry;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDY_imm( $01 );
  fByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_NoCarry;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_NoCarry;
const
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_imm( cRight );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_NoCarry;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_NoCarry;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult: uint8 = cLeft + cRight;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_NoCarry;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_NoCarry;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryIn;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDX_imm( $01 );
  fByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryIn;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDY_imm( $01 );
  fByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryIn;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryIn;
const
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_imm( cRight );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryIn;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cLeft;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cRight );
  fByteCode.ADC_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryIn;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cLeft;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cRight );
  fByteCode.ADC_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryIn;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryIn;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $CC;
  cRight = $02;
  cResult = cLeft + cRight + 1;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDX_imm( $01 );
  fByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDY_imm( $01 );
  fByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryOut;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryOut;
const
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fByteCode.LDA_imm( cRight );
  fByteCode.ADC_imm( cLeft );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryOut;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryOut;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryOut;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_x_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDX_imm( $01 );
  fByteCode.ADC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_y_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDY_imm( $01 );
  fByteCode.ADC_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_abs_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_imm_CarryInAndOut;
const
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fByteCode.LDA_imm( cRight );
  fByteCode.ADC_imm( cLeft );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_ind_y_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_x_ind_CarryInAndOut;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_x_CarryInAndOut;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cREsult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ADC_zpg_CarryInAndOut;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $FE;
  cRight = $02;
  cResult = $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.ADC_zpg( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cResult, fCPU.A )
end;

{$endregion}

{$region ' AND '}
procedure TTest_Mos6502CPU.AND_abs_x;
begin
  // Arrange:
  fMemory[$0A01] := $AA;       // right
  fByteCode.LDA_imm( $AA );    // left
  fByteCode.LDX_imm( $01 );
  fByteCode.AND_abs_x( $0A00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, fCPU.A )
end;

procedure TTest_Mos6502CPU.AND_abs_y;
begin
  // Arrange:
  fMemory[$0A01] := $AA;       // right
  fByteCode.LDA_imm( $AA );    // left
  fByteCode.LDY_imm( $01 );
  fByteCode.AND_abs_y( $0A00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, fCPU.A )
end;

procedure TTest_Mos6502CPU.AND_abs;
begin
  // Arrange:
  fMemory[$0A00] := $AA;       // right
  fByteCode.LDA_imm( $AA );    // left
  fByteCode.AND_abs( $0A00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, fCPU.A )
end;

procedure TTest_Mos6502CPU.AND_imm;
begin
  // Arrange:
  fByteCode.LDA_imm( $AA );    // left
  fByteCode.AND_imm( $AA );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, fCPU.A )
end;

procedure TTest_Mos6502CPU.AND_ind_y;
begin
  // Arrange:
  fMemory[$0A01] := $AA;      // right
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( $AA );   // left
  fByteCode.AND_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, fCPU.A )
end;

procedure TTest_Mos6502CPU.AND_x_ind;
begin
  // Arrange:
  fMemory[$0A00] := $AA;      // right
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( $AA );
  fByteCode.AND_x_ind( $00 );  // left
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( $AA, fCPU.A )
end;

procedure TTest_Mos6502CPU.AND_zpg_x;
begin
  // Arrange:
  fMemory[$00BB] := $AA; // right
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( $AA ); // left
  fByteCode.AND_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( $AA, fCPU.A )
end;

procedure TTest_Mos6502CPU.AND_zpg;
begin
  // Arrange:
  fMemory[$00BB] := $AA; // right
  fByteCode.LDA_imm( $AA ); // left
  fByteCode.AND_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( $AA, fCPU.A )
end;

{$endregion}

{$region ' ASL '}

procedure TTest_Mos6502CPU.ASL;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fByteCode.LDA_imm( $AA ); // value
  fByteCode.ASL;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( $54, fCPU.A )
end;

procedure TTest_Mos6502CPU.ASL_abs;
const
  cByteUnderTest = $0A00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cByteUnderTest] := $AA;
  fByteCode.ASL_abs( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( $54, fMemory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.ASL_abs_x;
const
  cByteUnderTest = $0A00;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[succ(cByteUnderTest)] := $AA;
  fByteCode.LDX_imm( $01 );
  fByteCode.ASL_abs_x( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( $54, fMemory[succ(cByteUnderTest)] )
end;

procedure TTest_Mos6502CPU.ASL_zpg_x;
const
  cByteUnderTest = $00BB;
  cByteOffset = $02;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cByteUnderTest] := $AA;
  fByteCode.LDX_imm( cByteUnderTest-cByteOffset );
  fByteCode.ASL_zpg_x( cByteOffset );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( $54, fMemory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.ASL_zpg;
const
  cByteUnderTest = $BB;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cByteUnderTest] := $AA;
  fByteCode.ASL_zpg( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( $54, fMemory[cByteUnderTest] )
end;

{$endregion}

{$region ' BCC '}

procedure TTest_Mos6502CPU.BCC_rel_TRUE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fCPU.CarryFlag := FALSE;
  fByteCode.BCC_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.BCC_rel_FALSE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $00;
  fCPU.CarryFlag := TRUE;
  fByteCode.BCC_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

{$region ' BCS '}

procedure TTest_Mos6502CPU.BCS_rel_TRUE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fCPU.CarryFlag := TRUE;
  fByteCode.BCS_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.BCS_rel_FALSE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $00;
  fCPU.CarryFlag := FALSE;
  fByteCode.BCS_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

{$region ' BEQ '}

procedure TTest_Mos6502CPU.BEQ_rel_TRUE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fCPU.ZeroFlag := TRUE;
  fByteCode.BEQ_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.BEQ_rel_FALSE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $00;
  fCPU.ZeroFlag := FALSE;
  fByteCode.BEQ_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

{$region ' BIT '}

procedure TTest_Mos6502CPU.BIT_abs_NonZeroTF;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $FF;
  cTestAnd = $B0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAnd;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.BIT_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.ZeroFlag );
  TTest.Expect( TRUE,  fCPU.NegativeFlag );
  TTest.Expect( FALSE, fCPU.OverflowFlag );
end;

procedure TTest_Mos6502CPU.BIT_zpg_NonZeroTF;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $FF;
  cTestAnd = $B0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAnd;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.BIT_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.ZeroFlag );
  TTest.Expect( TRUE,  fCPU.NegativeFlag );
  TTest.Expect( FALSE, fCPU.OverflowFlag );
end;

procedure TTest_Mos6502CPU.BIT_abs_NonZeroFT;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $FF;
  cTestAnd = $70;
 begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAnd;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.BIT_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.ZeroFlag );
  TTest.Expect( FALSE, fCPU.NegativeFlag );
  TTest.Expect( TRUE,  fCPU.OverflowFlag );
end;

procedure TTest_Mos6502CPU.BIT_zpg_NonZeroFT;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $FF;
  cTestAnd = $70;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAnd;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.BIT_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.ZeroFLag );
  TTest.Expect( FALSE, fCPU.NegativeFlag );
  TTest.Expect( TRUE,  fCPU.OverflowFlag );
end;

procedure TTest_Mos6502CPU.BIT_abs_ZeroFF;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $FF;
  cTestAnd = $30;
 begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAnd;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.BIT_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.ZeroFlag );
  TTest.Expect( FALSE, fCPU.NegativeFlag );
  TTest.Expect( FALSE, fCPU.OverflowFlag );
end;

procedure TTest_Mos6502CPU.BIT_zpg_ZeroFF;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $FF;
  cTestAnd = $30;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAnd;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.BIT_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.ZeroFlag );
  TTest.Expect( FALSE, fCPU.NegativeFlag );
  TTest.Expect( FALSE, fCPU.OverflowFlag );
end;

{$endregion}

{$region ' BMI '}

procedure TTest_Mos6502CPU.BMI_rel_TRUE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fCPU.NegativeFlag := TRUE;
  fByteCode.BMI_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.BMI_rel_FALSE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $00;
  fCPU.NegativeFlag := FALSE;
  fByteCode.BMI_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

{$region ' BNE '}

procedure TTest_Mos6502CPU.BNE_rel_TRUE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fCPU.ZeroFlag := FALSE;
  fByteCode.BNE_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.BNE_rel_FALSE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $00;
  fCPU.ZeroFlag := TRUE;
  fByteCode.BNE_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

{$region ' BPL '}

procedure TTest_Mos6502CPU.BPL_rel_TRUE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fCPU.NegativeFlag := FALSE;
  fByteCode.BPL_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.BPL_rel_FALSE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $00;
  fCPU.NegativeFlag := TRUE;
  fByteCode.BPL_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

{$region ' BVC '}

procedure TTest_Mos6502CPU.BVC_rel_TRUE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fCPU.OverflowFlag := FALSE;
  fByteCode.BVC_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.BVC_rel_FALSE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $00;
  fCPU.OverflowFlag := TRUE;
  fByteCode.BVC_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

{$region ' BVS '}

procedure TTest_Mos6502CPU.BVS_rel_TRUE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fCPU.OverflowFlag := TRUE;
  fByteCode.BVS_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.BVS_rel_FALSE;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $00;
  fCPU.OverflowFlag := FALSE;
  fByteCode.BVS_rel( $02 );     //- Jump over LDA_imm($00);
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

{$region ' CLC '}

procedure TTest_Mos6502CPU.CLC;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fByteCode.CLC;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
end;

{$endregion}

{$region ' CLD '}

procedure TTest_Mos6502CPU.CLD;
begin
  // Arrange:
  fCPU.DecimalModeFlag := TRUE;
  fByteCode.CLD;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.DecimalModeFlag );
end;

{$endregion}

{$region ' CLI '}

procedure TTest_Mos6502CPU.CLI;
begin
  // Arrange:
  fCPU.IRQDisableFlag := TRUE;
  fByteCode.CLI;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.IRQDisableFlag );
end;


{$endregion}

{$region ' CLV '}

procedure TTest_Mos6502CPU.CLV;
begin
  // Arrange:
  fCPU.OverflowFlag := TRUE;
  fByteCode.CLV;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
end;


{$endregion}

{$region ' CMP '}

procedure TTest_Mos6502CPU.CMP_abs_x_Negative;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CMP_abs_y_Negative;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CMP_abs_Negative;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CMP_imm_Negative;
const
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_imm( cSub );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CMP_ind_y_Negative;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_ind_y( $BB );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CMP_x_ind_Negative;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_x_ind( $00 );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CMP_zpg_x_Negative;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_zpg_x( $02 );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CMP_zpg_Negative;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_zpg( $BB );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CMP_abs_x_Zero;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CMP_abs_y_Zero;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CMP_abs_Zero;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CMP_imm_Zero;
const
  cTestAcc = $55;
begin
  // Arrange:
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_imm( cTestAcc );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CMP_ind_y_Zero;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_ind_y( $BB );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CMP_x_ind_Zero;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_x_ind( $00 );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CMP_zpg_x_Zero;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_zpg_x( $02 );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CMP_zpg_Zero;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_zpg( $BB );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CMP_abs_x_Carry;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CMP_abs_y_Carry;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CMP_abs_Carry;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CMP_imm_Carry;
const
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_imm( cSub );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CMP_ind_y_Carry;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_ind_y( $BB );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CMP_x_ind_Carry;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_x_ind( $00 );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CMP_zpg_x_Carry;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_zpg_x( $02 );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CMP_zpg_Carry;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.CMP_zpg( $BB );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

{$endregion}

{$region ' CPX '}

procedure TTest_Mos6502CPU.CPX_abs_Negative;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CPX_imm_Negative;
const
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_imm( cSub );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CPX_zpg_Negative;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_zpg( $BB );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CPX_abs_Zero;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CPX_imm_Zero;
const
  cTestAcc = $55;
begin
  // Arrange:
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_imm( cTestAcc );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CPX_zpg_Zero;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_zpg( $BB );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CPX_abs_Carry;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CPX_imm_Carry;
const
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_imm( cSub );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CPX_zpg_Carry;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDX_imm( cTestAcc );
  fByteCode.CPX_zpg( $BB );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

{$endregion}

{$region ' CPY '}

procedure TTest_Mos6502CPU.CPY_abs_Negative;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CPY_imm_Negative;
const
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_imm( cSub );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CPY_zpg_Negative;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $55;
  cSub     = $57;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_zpg( $BB );
  fByteCode.BRK;
  fCPU.NegativeFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.NegativeFlag );
end;

procedure TTest_Mos6502CPU.CPY_abs_Zero;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CPY_imm_Zero;
const
  cTestAcc = $55;
begin
  // Arrange:
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_imm( cTestAcc );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CPY_zpg_Zero;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestAcc;
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_zpg( $BB );
  fByteCode.BRK;
  fCPU.ZeroFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.ZeroFlag );
end;

procedure TTest_Mos6502CPU.CPY_abs_Carry;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CPY_imm_Carry;
const
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_imm( cSub );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

procedure TTest_Mos6502CPU.CPY_zpg_Carry;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $F0;
  cSub = $F0;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cSub;
  fByteCode.LDY_imm( cTestAcc );
  fByteCode.CPY_zpg( $BB );
  fByteCode.BRK;
  fCPU.CarryFlag := False;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

{$endregion}

{$region ' DEC '}

procedure TTest_Mos6502CPU.DEC_abs_x;
const
  cMemoryLocationUnderTest = $0A00;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestValue;
  fByteCode.LDX_imm( $01 );
  fByteCode.DEC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), fMemory[cMemoryLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.DEC_abs;
const
  cMemoryLocationUnderTest = $0A00;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestValue;
  fByteCode.DEC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), fMemory[cMemoryLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.DEC_zpg_x;
const
  cMemoryLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestValue;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( $01 );
  fByteCode.DEC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), fMemory[cMemoryLocationUnderTest] );
end;

procedure TTest_Mos6502CPU.DEC_zpg;
const
  cMemoryLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestValue;
  fByteCode.DEC_zpg( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), fMemory[cMemoryLocationUnderTest] );
end;

{$endregion}

{$region ' DEX '}

procedure TTest_Mos6502CPU.DEX;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.X := cTestValue;
  fByteCode.DEX;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), fCPU.X );
end;

{$endregion}

{$region ' DEY '}

procedure TTest_Mos6502CPU.DEY;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.Y := cTestValue;
  fByteCode.DEY;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( pred(cTestValue), fCPU.Y );
end;

{$endregion}

{$region ' EOR '}

procedure TTest_Mos6502CPU.EOR_abs_x;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.EOR_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.EOR_abs_y;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.EOR_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.EOR_abs;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.EOR_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.EOR_imm;
const
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
begin
  // Arrange:
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.EOR_imm( cInverter );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.EOR_ind_y;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.EOR_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.EOR_x_ind;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.EOR_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.EOR_zpg_x;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.EOR_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestREs, fCPU.A )
end;

procedure TTest_Mos6502CPU.EOR_zpg;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $AA;
  cTestRes = $55;
  cInverter = $FF;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.EOR_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

{$endregion}

{$region ' INC '}

procedure TTest_Mos6502CPU.INC_abs_x;
const
  cMemoryLocationUnderTest = $0A00;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestValue;
  fByteCode.LDX_imm( $01 );
  fByteCode.INC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), fMemory[cMemoryLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.INC_abs;
const
  cMemoryLocationUnderTest = $0A00;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestValue;
  fByteCode.INC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), fMemory[cMemoryLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.INC_zpg_x;
const
  cMemoryLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestValue;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( $01 );
  fByteCode.INC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), fMemory[cMemoryLocationUnderTest] );
end;

procedure TTest_Mos6502CPU.INC_zpg;
const
  cMemoryLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cTestValue;
  fByteCode.INC_zpg( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), fMemory[cMemoryLocationUnderTest] );
end;

{$endregion}

{$region ' INX '}

procedure TTest_Mos6502CPU.INX;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.X := cTestValue;
  fByteCode.INX;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), fCPU.X );
end;

{$endregion}

{$region ' INY '}

procedure TTest_Mos6502CPU.INY;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.Y := cTestValue;
  fByteCode.INY;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( succ(cTestValue), fCPU.Y );
end;

{$endregion}

{$region ' JMP '}

procedure TTest_Mos6502CPU.JMP_abs;
const
  cDummyVal = $DD;
  cTestVal = $CC;
  cSRAddress = $0A00;
begin
  // Arrange:
  fByteCode.LDA_imm( cDummyVal );
  fByteCode.JMP_abs( cSRAddress );
  fByteCode.BRK;
  fByteCode.Cursor := cSRAddress;
  fBytecode.LDA_imm( cTestVal );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestVal, fCPU.A );
end;

procedure TTest_Mos6502CPU.JMP_ind;
const
  cDummyVal = $DD;
  cTestVal = $CC;
  cVectorLocation = $0B00;
  cVectorTarget = $0A00;
  cVectorTargetH = $0A;
  cVectorTargetL = $00;
begin
  // Arrange:
  fMemory[cVectorLocation] := cVectorTargetH;
  fMemory[succ(cVectorLocation)] := cVectorTargetL;
  fByteCode.LDA_imm( cDummyVal );
  fByteCode.JMP_ind( cVectorLocation );
  fByteCode.BRK;
  fByteCode.Cursor := cVectorTarget;
  fBytecode.LDA_imm( cTestVal );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestVal, fCPU.A );
end;

{$endregion}

{$region ' JSR '}

procedure TTest_Mos6502CPU.JSR_abs;
const
  cDummyVal = $DD;
  cTestVal = $CC;
  cSRAddress = $0A00;
begin
  // Arrange:
  fByteCode.LDA_imm( cDummyVal );
  fByteCode.JSR_abs( cSRAddress );
  fByteCode.BRK;
  fByteCode.Cursor := cSRAddress;
  fBytecode.LDA_imm( cTestVal );
  fByteCode.RTS;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestVal, fCPU.A );
end;

{$endregion}

{$region ' LDA '}

procedure TTest_Mos6502CPU.LDA_abs_x;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocation] := cTestValue;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDA_abs_x( pred(cMemoryLocation) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A )
end;

procedure TTest_Mos6502CPU.LDA_abs_y;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocation] := cTestValue;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_abs_y( pred(cMemoryLocation) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A )
end;

procedure TTest_Mos6502CPU.LDA_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocation] := cTestValue;
  fByteCode.LDA_abs( cMemoryLocation );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A )
end;

procedure TTest_Mos6502CPU.LDA_imm;
const
  cTestValue = $CC;
begin
  // Arrange:
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A );
end;

procedure TTest_Mos6502CPU.LDA_ind_y;
const
  cLocationUnderTest = $0A00;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cLocationUnderTest] := cTestValue;
  fMemory[$00BB] := $FF;
  fMemory[$00BC] := $09;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A )
end;

procedure TTest_Mos6502CPU.LDA_x_ind;
const
  cLocationUnderTest = $0A00;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cLocationUnderTest] := cTestValue;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BA );
  fByteCode.LDA_x_ind( $01 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A )
end;

procedure TTest_Mos6502CPU.LDA_zpg_x;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cLocationUnderTest] := $CC;
  fByteCode.LDX_imm( pred(pred(cLocationUnderTest)) );
  fByteCode.LDA_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A )
end;

procedure TTest_Mos6502CPU.LDA_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cLocationUnderTest] := $CC;
  fByteCode.LDA_zpg_x( cLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A )
end;

{$endregion}

{$region ' LDX '}

procedure TTest_Mos6502CPU.LDX_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cLocationUnderTest] := $CC;
  fByteCode.LDX_zpg( cLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.X )
end;

procedure TTest_Mos6502CPU.LDX_abs_y;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocation] := cTestValue;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDX_abs_y( pred(cMemoryLocation) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.X )
end;

procedure TTest_Mos6502CPU.LDX_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocation] := cTestValue;
  fByteCode.LDX_abs( cMemoryLocation );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.X );
end;

procedure TTest_Mos6502CPU.LDX_imm;
const
  cTestValue = $CC;
begin
  // Arrange:
  fByteCode.LDX_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.X );
end;

procedure TTest_Mos6502CPU.LDX_zpg_y;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cLocationUnderTest] := $CC;
  fByteCode.LDY_imm( pred(pred(cLocationUnderTest)) );
  fByteCode.LDX_zpg_y( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.X )
end;

{$endregion}

{$region ' LDY '}

procedure TTest_Mos6502CPU.LDY_abs_x;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocation] := cTestValue;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDY_abs_x( pred(cMemoryLocation) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.Y )
end;

procedure TTest_Mos6502CPU.LDY_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cMemoryLocation] := cTestValue;
  fByteCode.LDY_abs( cMemoryLocation );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.Y );
end;

procedure TTest_Mos6502CPU.LDY_imm;
const
  cTestValue = $CC;
begin
  // Arrange:
  fByteCode.LDY_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.Y );
end;

procedure TTest_Mos6502CPU.LDY_zpg_x;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cLocationUnderTest] := $CC;
  fByteCode.LDX_imm( pred(pred(cLocationUnderTest)) );
  fByteCode.LDY_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.Y )
end;

procedure TTest_Mos6502CPU.LDY_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fMemory[cLocationUnderTest] := $CC;
  fByteCode.LDY_zpg( cLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.Y )
end;

{$endregion}

{$region ' LSR '}

procedure TTest_Mos6502CPU.LSR;
const
  cTestValue = $55;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fByteCode.LDA_imm( cTestValue );
  fByteCode.LSR;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, fCPU.A )
end;

procedure TTest_Mos6502CPU.LSR_abs_x;
const
  cByteUnderTest = $0A00;
  cTestValue = $55;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[succ(cByteUnderTest)] := cTestValue;
  fByteCode.LDX_imm( $01 );
  fByteCode.LSR_abs_x( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, fMemory[succ(cByteUnderTest)] )
end;

procedure TTest_Mos6502CPU.LSR_abs;
const
  cByteUnderTest = $0A00;
  cTestValue = $55;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.LSR_abs( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, fMemory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.LSR_zpg_x;
const
  cByteUnderTest = $00BB;
  cByteOffset = $02;
  cTestValue = $55;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.LDX_imm( cByteUnderTest-cByteOffset );
  fByteCode.LSR_zpg_x( cByteOffset );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, fMemory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.LSR_zpg;
const
  cByteUnderTest = $BB;
  cTestValue = $55;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.LSR_zpg( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
  TTest.Expect( cTestValue shr 1, fMemory[cByteUnderTest] )
end;

{$endregion}

{$region ' ORA '}

procedure TTest_Mos6502CPU.ORA_abs_x;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.ORA_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.ORA_abs_y;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.ORA_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.ORA_abs;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.ORA_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.ORA_imm;
const
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
begin
  // Arrange:
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.ORA_imm( cInverter );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.ORA_ind_y;
const
  cMemoryLocationUnderTest = $0A01;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.ORA_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.ORA_x_ind;
const
  cMemoryLocationUnderTest = $0A00;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.ORA_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

procedure TTest_Mos6502CPU.ORA_zpg_x;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.ORA_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestREs, fCPU.A )
end;

procedure TTest_Mos6502CPU.ORA_zpg;
const
  cMemoryLocationUnderTest = $00BB;
  cTestAcc = $AA;
  cTestRes = $FF;
  cInverter = $55;
begin
  // Arrange:
  fMemory[cMemoryLocationUnderTest] := cInverter;
  fByteCode.LDA_imm( cTestAcc );
  fByteCode.ORA_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestRes, fCPU.A )
end;

{$endregion}

{$region ' PHA '}

procedure TTest_Mos6502CPU.PHA;
const
  cTestVal = $AA;
  cStackAddr = $01FF;
  cStackPtr = $FE;
begin
  // Arrange:
  fByteCode.LDA_imm( cTestVal );
  fByteCode.PHA;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestVal, fMemory[cStackAddr] );
  TTest.Expect( cStackPtr, fCPU.SP );
end;

{$endregion}

{$region ' PHP '}

procedure TTest_Mos6502CPU.PHP;
const
  cTestVal = $AA;
  cStackAddr = $01FF;
  cStackPtr = $FE;
begin
  // Arrange:
  fCPU.SR := cTestVal;
  fByteCode.PHP;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestVal, fMemory[cStackAddr] );
  TTest.Expect( cStackPtr, fCPU.SP );
end;

{$endregion}

{$region ' PLA '}

procedure TTest_Mos6502CPU.PLA;
const
  cTestVal = $AA;
  cStackAddr = $01FF;
  cStackPtr = $FF;
begin
  // Arrange:
  fMemory[cStackAddr] := cTestVal;
  fCPU.SP := pred(cStackPtr);
  fByteCode.PLA;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestVal, fCPU.A );
  TTest.Expect( cStackPtr, fCPU.SP );
end;

{$endregion}

{$region ' PLP '}

procedure TTest_Mos6502CPU.PLP;
const
  cTestVal = $AA;
  cStackAddr = $01FF;
  cStackPtr = $FE;
begin
  // Arrange:
  fMemory[cStackAddr] := cTestVal;
  fCPU.SP := cStackPtr;
  fByteCode.PLP;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  // - NOTE: SP will get the break flag set after PLP, so here we or ($01 shl 4) to add the break command to test val.
  TTest.Expect( cTestVal or ($01 shl 4), fCPU.SR );
  TTest.Expect( succ(cStackPtr), fCPU.SP );
end;

{$endregion}

{$region ' ROL '}

procedure TTest_Mos6502CPU.ROL;
const
  cTestValue = $54;
  cExpectedResult = (cTestValue shl 1) or $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fByteCode.LDA_imm( cTestValue );
  fByteCode.ROL;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ROL_abs_x;
const
  cByteUnderTest = $0A00;
  cTestValue = $54;
  cExpectedResult = (cTestValue shl 1) or $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[succ(cByteUnderTest)] := cTestValue;
  fByteCode.LDX_imm( $01 );
  fByteCode.ROL_abs_x( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fMemory[succ(cByteUnderTest)] )
end;

procedure TTest_Mos6502CPU.ROL_abs;
const
  cByteUnderTest = $0A00;
  cTestValue = $54;
  cExpectedResult = (cTestValue shl 1) or $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.ROL_abs( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fMemory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.ROL_zpg_x;
const
  cByteUnderTest = $00BB;
  cByteOffset = $02;
  cTestValue = $54;
  cExpectedResult = (cTestValue shl 1) or $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.LDX_imm( cByteUnderTest-cByteOffset );
  fByteCode.ROL_zpg_x( cByteOffset );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fMemory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.ROL_zpg;
const
  cByteUnderTest = $BB;
  cTestValue = $54;
  cExpectedResult = (cTestValue shl 1) or $01;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.ROL_zpg( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fMemory[cByteUnderTest] )
end;

{$endregion}

{$region ' ROR '}

procedure TTest_Mos6502CPU.ROR;
const
  cTestValue = $54;
  cExpectedResult = (cTestValue shr 1) or $80;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fByteCode.LDA_imm( cTestValue );
  fByteCode.ROR;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fCPU.A )
end;

procedure TTest_Mos6502CPU.ROR_abs_x;
const
  cByteUnderTest = $0A00;
  cTestValue = $54;
  cExpectedResult = (cTestValue shr 1) or $80;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[succ(cByteUnderTest)] := cTestValue;
  fByteCode.LDX_imm( $01 );
  fByteCode.ROR_abs_x( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fMemory[succ(cByteUnderTest)] )
end;

procedure TTest_Mos6502CPU.ROR_abs;
const
  cByteUnderTest = $0A00;
  cTestValue = $54;
  cExpectedResult = (cTestValue shr 1) or $80;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.ROR_abs( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fMemory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.ROR_zpg_x;
const
  cByteUnderTest = $00BB;
  cByteOffset = $02;
  cTestValue = $54;
  cExpectedResult = (cTestValue shr 1) or $80;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.LDX_imm( cByteUnderTest-cByteOffset );
  fByteCode.ROR_zpg_x( cByteOffset );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fMemory[cByteUnderTest] )
end;

procedure TTest_Mos6502CPU.ROR_zpg;
const
  cByteUnderTest = $BB;
  cTestValue = $54;
  cExpectedResult = (cTestValue shr 1) or $80;
begin
  // Arrange:
  fCPU.CarryFlag := TRUE;
  fMemory[cByteUnderTest] := cTestValue;
  fByteCode.ROR_zpg( cByteUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( FALSE, fCPU.CarryFlag );
  TTest.Expect( cExpectedResult, fMemory[cByteUnderTest] )
end;

{$endregion}

{$region ' RTI '}

procedure TTest_Mos6502CPU.RTI;
const
  cTestAddrHigh = $0A;
  cTestAddrLow = $00;
  cTestAddr = (cTestAddrHigh shl 8) or (cTestAddrLow);
  cTestValue = $CC;
  cStackAddr = $01FD;
  cStackPtr = $FC;
var
  SetupStack: uint16;
begin
  // Arrange:
  SetupStack := cStackAddr;
  fMemory[SetupStack] := cTestValue;
  inc(SetupStack);
  fMemory[SetupStack] := cTestAddrHigh;
  inc(SetupStack);
  fMemory[SetupStack] := cTestAddrLow;
  fCPU.SP := cStackPtr;
  fByteCode.LDA_imm( $FF );
  fByteCode.RTI;
  fByteCode.BRK;
  //- Insert test peg
  fByteCode.Cursor := cTestAddr;
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  // - NOTE: SP will get the break flag set after RTI, so here we or ($01 shl 4) to add the break command to test val.
  TTest.Expect( cTestValue or ($01 shl 4), fCPU.SR );
  TTest.Expect( cTestValue, fCPU.A );
  TTest.Expect( cStackPtr+sizeof(uint16)+sizeof(uint8), fCPU.SP );
end;

{$endregion}

{$region ' RTS '}

procedure TTest_Mos6502CPU.RTS;
const
  cTestAddrHigh = $0A;
  cTestAddrLow = $00;
  cTestAddr = (cTestAddrHigh shl 8) or (cTestAddrLow);
  cTestValue = $CC;
  cStackAddr = $01FE;
  cStackPtr = $FD;
begin
  // Arrange:
  fMemory[cStackAddr] := cTestAddrHigh;
  fMemory[succ(cStackAddr)] := cTestAddrLow;
  fCPU.SP := cStackPtr;
  fByteCode.LDA_imm( $FF );
  fByteCode.RTS;
  fByteCode.BRK;
  //- Insert test peg
  fByteCode.Cursor := cTestAddr;
  fByteCode.LDA_imm( cTestValue );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fCPU.A );
  TTest.Expect( cStackPtr+sizeof(uint16), fCPU.SP );
end;

{$endregion}

{$region ' SBC '}

procedure TTest_Mos6502CPU.SBC_abs_y_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cRes, fCPU.A );
end;

procedure TTest_Mos6502CPU.SBC_abs_x_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cRes, fCPU.A );
end;

procedure TTest_Mos6502CPU.SBC_abs_NoOverflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cRes, fCPU.A );
end;

procedure TTest_Mos6502CPU.SBC_imm_NoOverflow;
const
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_imm( cRight );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cRes, fCPU.A );
end;

procedure TTest_Mos6502CPU.SBC_ind_y_NoOverflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDY_imm( $01 );
  fByteCode.SBC_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cRes, fCPU.A );
end;

procedure TTest_Mos6502CPU.SBC_x_ind_NoOverflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cRes, fCPU.A );
end;

procedure TTest_Mos6502CPU.SBC_zpg_x_NoOverflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cRes, fCPU.A );
end;

procedure TTest_Mos6502CPU.SBC_zpg_NoOverflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $7F;
  cRight = $6F;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( FALSE, fCPU.OverflowFlag );
  TTest.Expect( cRes, fCPU.A );
end;

procedure TTest_Mos6502CPU.SBC_abs_y_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $FF;
  cRes: int8 = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDY_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_abs_y( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cRes, int8(fCPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_abs_x_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $01 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_abs_x( pred(cMemoryLocationUnderTest) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cRes, int8(fCPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_abs_Overflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_abs( cMemoryLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cRes, int8(fCPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_imm_Overflow;
const
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_imm( cRight );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cRes, int8(fCPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_ind_y_Overflow;
const
  cMemoryLocationUnderTest = $0A01;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDA_imm( cLeft );
  fByteCode.LDY_imm( $01 );
  fByteCode.SBC_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cRes, int8(fCPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_x_ind_Overflow;
const
  cMemoryLocationUnderTest = $0A00;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BB );
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_x_ind( $00 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cRes, int8(fCPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_zpg_x_Overflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDX_imm( $B9 );
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cRes, int8(fCPU.A) );
end;

procedure TTest_Mos6502CPU.SBC_zpg_Overflow;
const
  cMemoryLocationUnderTest = $00BB;
  cLeft = $7F;
  cRight = $FF;
  cRes = cLeft-cRight;
begin
  // Arrange:
  fCPU.OverflowFlag := FALSE;
  fMemory[cMemoryLocationUnderTest] := cRight;
  fByteCode.LDA_imm( cLeft );
  fByteCode.SBC_zpg( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( TRUE, fCPU.OverflowFlag );
  TTest.Expect( cRes, int8(fCPU.A) );
end;

{$endregion}

{$region ' SEC '}

procedure TTest_Mos6502CPU.SEC;
begin
  // Arrange:
  fCPU.CarryFlag := FALSE;
  fByteCode.SEC;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.CarryFlag );
end;

{$endregion}

{$region ' SED '}

procedure TTest_Mos6502CPU.SED;
begin
  // Arrange:
  fCPU.DecimalModeFlag := FALSE;
  fByteCode.SED;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.DecimalModeFlag );
end;

{$endregion}

{$region ' SEI '}

procedure TTest_Mos6502CPU.SEI;
begin
  // Arrange:
  fCPU.IRQDisableFlag := FALSE;
  fByteCode.SEI;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( TRUE, fCPU.IRQDisableFlag );
end;

{$endregion}

{$region ' STA '}

procedure TTest_Mos6502CPU.STA_abs_x;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fByteCode.LDX_imm( $01 );
  fByteCode.STA_abs_x( pred(cMemoryLocation) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cMemoryLocation] )
end;

procedure TTest_Mos6502CPU.STA_abs_y;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fByteCode.LDY_imm( $01 );
  fByteCode.STA_abs_y( pred(cMemoryLocation) );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cMemoryLocation] )
end;

procedure TTest_Mos6502CPU.STA_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fByteCode.STA_abs( cMemoryLocation );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cMemoryLocation] )
end;

procedure TTest_Mos6502CPU.STA_ind_y;
const
  cLocationUnderTest = $0A00;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fMemory[$00BB] := $FF;
  fMemory[$00BC] := $09;
  fByteCode.LDY_imm( $01 );
  fByteCode.STA_ind_y( $BB );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.STA_x_ind;
const
  cLocationUnderTest = $0A00;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fMemory[$00BB] := $00;
  fMemory[$00BC] := $0A;
  fByteCode.LDX_imm( $BA );
  fByteCode.STA_x_ind( $01 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.STA_zpg_x;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $CC;
  fByteCode.LDX_imm( pred(pred(cLocationUnderTest)) );
  fByteCode.STA_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.STA_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := $CC;
  fByteCode.STA_zpg( cLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cLocationUnderTest] )
end;

{$endregion}

{$region ' STX '}

procedure TTest_Mos6502CPU.STX_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.X := cTestValue;
  fByteCode.STX_abs( cMemoryLocation );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cMemoryLocation] );
end;

procedure TTest_Mos6502CPU.STX_zpg_y;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.X := $CC;
  fByteCode.LDY_imm( pred(pred(cLocationUnderTest)) );
  fByteCode.STX_zpg_y( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cLocationUnderTest] );
end;

procedure TTest_Mos6502CPU.STX_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.X := $CC;
  fByteCode.STX_zpg( cLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cLocationUnderTest] )
end;

{$endregion}

{$region ' STY '}

procedure TTest_Mos6502CPU.STY_abs;
const
  cMemoryLocation = $BE;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.Y := cTestValue;
  fByteCode.STY_abs( cMemoryLocation );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cMemoryLocation] );
end;

procedure TTest_Mos6502CPU.STY_zpg_x;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.Y := $CC;
  fByteCode.LDX_imm( pred(pred(cLocationUnderTest)) );
  fByteCode.STY_zpg_x( $02 );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cLocationUnderTest] )
end;

procedure TTest_Mos6502CPU.STY_zpg;
const
  cLocationUnderTest = $00BB;
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.Y := $CC;
  fByteCode.STY_zpg( cLocationUnderTest );
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Asert:
  TTest.Expect( cTestValue, fMemory[cLocationUnderTest] )
end;

{$endregion}

{$region ' TAX '}

procedure TTest_Mos6502CPU.TAX;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fByteCode.TAX;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.X );
end;

{$endregion}

{$region ' TAY '}

procedure TTest_Mos6502CPU.TAY;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.A := cTestValue;
  fByteCode.TAY;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.Y );
end;

{$endregion}

{$region ' TSX '}

procedure TTest_Mos6502CPU.TSX;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.SP := cTestValue;
  fByteCode.TSX;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.X );
end;

{$endregion}

{$region ' TXA '}

procedure TTest_Mos6502CPU.TXA;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.X := cTestValue;
  fByteCode.TXA;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;


{$endregion}

{$region ' TXS '}

procedure TTest_Mos6502CPU.TXS;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.X := cTestValue;
  fByteCode.TXS;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.SP );
end;

{$endregion}

{$region ' TYA '}

procedure TTest_Mos6502CPU.TYA;
const
  cTestValue = $CC;
begin
  // Arrange:
  fCPU.Y := cTestValue;
  fByteCode.TYA;
  fByteCode.BRK;
  // Act:
  while not fCPU.BreakFlag do begin
    fCPU.Clock;
  end;
  // Assert:
  TTest.Expect( cTestValue, fCPU.A );
end;

{$endregion}

initialization
  TestSuite.RegisterTestCase(TTest_Mos6502CPU);

end.



