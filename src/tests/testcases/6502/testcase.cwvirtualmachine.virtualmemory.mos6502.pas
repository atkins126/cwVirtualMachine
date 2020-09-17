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
unit testcase.cwVirtualMachine.VirtualMemory.Mos6502;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
;

type
  TTest_6502VirtualMemory = class(TTestCase)
  published
    procedure InitialBanksAlignment;
    procedure InitialSize64KB;
    procedure InitialSize64KBWhenSetLower;
    procedure SizeChangeBelow64KB;
  end;

implementation
uses
  cwTest.Standard
, cwVirtualMachine
, cwVirtualMachine.Mos6502
;

procedure TTest_6502VirtualMemory.InitialBanksAlignment;
var
  Memory: I6502VirtualMemory;
  idx: uint8;
begin
  // Arrange:
  // Act:
  Memory := T6502VirtualMemory.Create;
  // Assert:
  for idx := 0 to $FF do begin
    TTest.Expect( idx*256, Memory.Banks[idx] );
  end;
end;

procedure TTest_6502VirtualMemory.InitialSize64KB;
var
  Memory: I6502VirtualMemory;
begin
  // Arrange:
  // Act:
  Memory := T6502VirtualMemory.Create;
  // Assert:
  TTest.Expect( $10000, Memory.DataSize );
end;

procedure TTest_6502VirtualMemory.InitialSize64KBWhenSetLower;
var
  Memory: I6502VirtualMemory;
begin
  // Arrange:
  // Act:
  Memory := T6502VirtualMemory.Create( $FFFF );
  // Assert:
  TTest.Expect( $10000, Memory.DataSize );
end;

procedure TTest_6502VirtualMemory.SizeChangeBelow64KB;
var
  Memory: I6502VirtualMemory;
begin
  // Arrange:
  Memory := T6502VirtualMemory.Create;
  // Act:
  Memory.DataSize := $FFFF;
  // Assert:
  TTest.Expect( $10000, Memory.DataSize );
end;


initialization
  TestSuite.RegisterTestCase(TTest_6502VirtualMemory)

end.



