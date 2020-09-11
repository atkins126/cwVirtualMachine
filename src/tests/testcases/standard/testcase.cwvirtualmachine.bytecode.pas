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
unit TestCase.cwVirtualMachine.ByteCode;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
;

type
  TTest_ByteCode = class(TTestCase)
  published
    procedure RefVirtualMemory;
    procedure SetCursorWithinRange;
    procedure SetCursorBeyondRange;
    procedure WriteWithinRange;
    procedure WriteBeyondRange;
    procedure AppendData;
  end;

implementation
uses
  cwTest.Standard
, cwVirtualMachine
, cwVirtualMachine.Standard
;

procedure TTest_ByteCode.RefVirtualMemory;
var
  Memory: IVirtualMemory;
  RefMemory: IVirtualMemory;
  ByteCode: IByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create;
  ByteCode := TByteCode.Create( Memory );
  // Act:
  RefMemory := ByteCode.VirtualMemory;
  // Assert:
  TTest.IsTrue( Memory = RefMemory, 'Memory references don''t match.');
end;

procedure TTest_ByteCode.SetCursorWithinRange;
const
  cRange = $FF;
var
  Memory: IVirtualMemory;
  ByteCode: IByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create(cRange);
  ByteCode := TByteCode.Create( Memory );
  // Act:
  ByteCode.Cursor := pred(cRange);
  // Assert:
  TTest.Expect( pred(cRange), ByteCode.Cursor );
end;

procedure TTest_ByteCode.SetCursorBeyondRange;
const
  cRange = $FF;
var
  Memory: IVirtualMemory;
  ByteCode: IByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create(cRange);
  ByteCode := TByteCode.Create( Memory );
  // Act:
  ByteCode.Cursor := cRange;
  // Assert:
  TTest.Expect( pred(cRange), ByteCode.Cursor );
end;

procedure TTest_ByteCode.WriteWithinRange;
const
  cRange = $FF;
  cSampleValue = $CC;
var
  Memory: IVirtualMemory;
  ByteCode: IByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create(cRange);
  ByteCode := TByteCode.Create( Memory );
  // Act:
  ByteCode.Cursor := pred(cRange);
  ByteCode.Write([cSampleValue]);
  // Assert:
  TTest.Expect( cSampleValue, Memory[pred(cRange)] );
  TTest.Expect( pred(cRange), ByteCode.Cursor );
end;

procedure TTest_ByteCode.WriteBeyondRange;
const
  cRange = $FF;
  cSampleValue = $CC;
var
  Memory: IVirtualMemory;
  ByteCode: IByteCode;
begin
  // Arrange:
  Memory := TVirtualMemory.Create(cRange);
  ByteCode := TByteCode.Create( Memory );
  // Act:
  ByteCode.Cursor := cRange;
  ByteCode.Write([cSampleValue]);
  // Assert:
  TTest.Expect( cSampleValue, Memory[pred(cRange)] );
  TTest.Expect( pred(cRange), ByteCode.Cursor );
end;

procedure TTest_ByteCode.AppendData;
const
  cRange = $FF;
var
  Memory: IVirtualMemory;
  ByteCode: IByteCode;
  AppendArray: array[0..cRange-1] of uint8;
  idx: uint8;
begin
  // Arrange:
  Memory := TVirtualMemory.Create( cRange );
  ByteCode := TByteCode.Create( Memory, cRange );
  for idx := 0 to pred(cRange) do AppendArray[idx] := idx;
  // Act:
  ByteCode.Append(AppendArray);
  ByteCode.Append(AppendArray);
  // Assert:
  for idx := 0 to pred(cRange) do begin
    TTest.Expect( Memory[idx], AppendArray[idx] );
    TTest.Expect( Memory[idx+cRange], AppendArray[idx] );
  end;
end;



initialization
  TestSuite.RegisterTestCase(TTest_ByteCode)

end.



