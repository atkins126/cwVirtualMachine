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
unit TestCase.cwVirtualMachine.ByteCode.Chappie;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
;

type
  TTest_ChappieByteCode = class(TTestCase)
  published
    procedure opHalt;
    procedure OpNop;
    procedure OpAlert;
    procedure OpLoad;
    procedure OpAdd;
    procedure OpSave;
  end;

implementation
uses
  cwTest.Standard
, cwVirtualMachine
, cwVirtualMachine.Standard
, cwVirtualMachine.Chappie
;

procedure TTest_ChappieByteCode.opHalt;
var
  Memory: IVirtualMemory;
  ByteCode: IChappieByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create;
  ByteCode := TChappieByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.opHalt;
  // Assert:
  TTest.Expect( $00, Memory[0] );
  TTest.Expect( $00, Memory[1] );
  TTest.Expect( $00, Memory[2] );
  TTest.Expect( $00, Memory[3] );
end;

procedure TTest_ChappieByteCode.OpNop;
var
  Memory: IVirtualMemory;
  ByteCode: IChappieByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create;
  ByteCode := TChappieByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.opNop;
  // Assert:
  TTest.Expect( $01, Memory[0] );
  TTest.Expect( $00, Memory[1] );
  TTest.Expect( $00, Memory[2] );
  TTest.Expect( $00, Memory[3] );
end;

procedure TTest_ChappieByteCode.OpAlert;
var
  Memory: IVirtualMemory;
  ByteCode: IChappieByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create;
  ByteCode := TChappieByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.opAlert;
  // Assert:
  TTest.Expect( $02, Memory[0] );
  TTest.Expect( $00, Memory[1] );
  TTest.Expect( $00, Memory[2] );
  TTest.Expect( $00, Memory[3] );
end;

procedure TTest_ChappieByteCode.OpLoad;
var
  Memory: IVirtualMemory;
  ByteCode: IChappieByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create;
  ByteCode := TChappieByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.opLoad( $DE );
  // Assert:
  TTest.Expect( $03, Memory[0] );
  TTest.Expect( $00, Memory[1] );
  TTest.Expect( $00, Memory[2] );
  TTest.Expect( $00, Memory[3] );
  TTest.Expect( $DE, Memory[4] );
  TTest.Expect( $00, Memory[5] );
  TTest.Expect( $00, Memory[6] );
  TTest.Expect( $00, Memory[7] );
end;

procedure TTest_ChappieByteCode.OpAdd;
var
  Memory: IVirtualMemory;
  ByteCode: IChappieByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create;
  ByteCode := TChappieByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.opAdd( $DE );
  // Assert:
  TTest.Expect( $05, Memory[0] );
  TTest.Expect( $00, Memory[1] );
  TTest.Expect( $00, Memory[2] );
  TTest.Expect( $00, Memory[3] );
  TTest.Expect( $DE, Memory[4] );
  TTest.Expect( $00, Memory[5] );
  TTest.Expect( $00, Memory[6] );
  TTest.Expect( $00, Memory[7] );
end;

procedure TTest_ChappieByteCode.OpSave;
var
  Memory: IVirtualMemory;
  ByteCode: IChappieByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create;
  ByteCode := TChappieByteCode.Create( Memory );
  ByteCode.Cursor := $00;
  // Act:
  ByteCode.opSave();
  // Assert:
  TTest.Expect( $04, Memory[0] );
  TTest.Expect( $00, Memory[1] );
  TTest.Expect( $00, Memory[2] );
  TTest.Expect( $00, Memory[3] );
  TTest.Expect( $00, Memory[4] );
  TTest.Expect( $00, Memory[5] );
  TTest.Expect( $00, Memory[6] );
  TTest.Expect( $00, Memory[7] );
end;

initialization
  TestSuite.RegisterTestCase(TTest_ChappieByteCode)

end.



