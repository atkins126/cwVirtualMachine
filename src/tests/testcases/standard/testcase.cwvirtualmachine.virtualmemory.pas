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
unit TestCase.cwVirtualMachine.VirtualMemory;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
;

type
  TTest_VirtualMemory = class(TTestCase)
  published
    procedure Resize;
    procedure DataRetentionOnResizeUp;
    procedure DataRetentionOnResizeDown;
    procedure SetAndGetBytesByIndex;
  end;

implementation
uses
  cwTypes
, cwTest.Standard
, cwVirtualMachine
, cwVirtualMachine.Standard
;

procedure TTest_VirtualMemory.Resize;
const
  cTestInitialSize = 128;
  cTestNewSize = 256;
var
  Memory: IVirtualMemory;
begin
  // Arrange:
  Memory := TVirtualMemory.Create(cTestInitialSize);
  // Act:
  Memory.DataSize := cTestNewSize;
  // Assert:
  TTest.Expect( cTestNewSize, Memory.DataSize );
end;

procedure TTest_VirtualMemory.DataRetentionOnResizeUp;
const
  cTestInitialSize = 128;
  cTestNewSize = 256;
var
  TestData: array of uint8;
  Memory: IVirtualMemory;
  idx: uint8;
begin
  // Arrange:
  {$hints off} SetLength(TestData,cTestInitialSize); {$hints on}
  for idx := 0 to pred(Length(TestData)) do begin
    TestData[idx] := idx;
  end;
  Memory := TVirtualMemory.Create(Length(TestData));
  Move( TestData[0], Memory.DataPtr^, Length(TestData) );
  // Act:
  Memory.DataSize := cTestNewSize;
  Move( Memory.DataPtr^, TestData[0], Length(TestData) );
  // Assert:
  TTest.Expect( cTestNewSize, Memory.DataSize );
  for idx := 0 to pred(Length(TestData)) do begin
    TTest.Expect( idx, TestData[idx] );
  end;
end;

procedure TTest_VirtualMemory.DataRetentionOnResizeDown;
const
  cTestInitialSize = 128;
  cTestNewSize = 64;
var
  TestData: array of uint8;
  Memory: IVirtualMemory;
  idx: uint8;
begin
  // Arrange:
  {$hints off} SetLength(TestData,cTestInitialSize); {$hints on}
  for idx := 0 to pred(Length(TestData)) do begin
    TestData[idx] := idx;
  end;
  Memory := TVirtualMemory.Create(Length(TestData));
  Move( TestData[0], Memory.DataPtr^, Length(TestData) );
  FillChar(TestData[0],cTestInitialSize,0);
  SetLength(TestData,cTestNewSize);
  // Act:
  Memory.DataSize := cTestNewSize;
  Move( Memory.DataPtr^, TestData[0], Length(TestData) );
  // Assert:
  TTest.Expect( cTestNewSize, Memory.DataSize );
  for idx := 0 to pred(Length(TestData)) do begin
    TTest.Expect( idx, TestData[idx] );
  end;
end;

procedure TTest_VirtualMemory.SetAndGetBytesByIndex;
const
  cRange = $FF;
var
  Memory: IVirtualMemory;
  idx: uint8;
begin
  // Arrange:
  Memory := TVirtualMemory.Create( cRange );
  // Act:
  for idx := 0 to pred(cRange) do begin
      Memory[idx] := idx;
    end;
  // Assert:
  for idx := 0 to pred(cRange) do begin
    TTest.Expect( idx, Memory[idx] );
  end;
end;


initialization
  TestSuite.RegisterTestCase(TTest_VirtualMemory)

end.



