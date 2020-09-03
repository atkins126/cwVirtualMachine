<<<<<<< HEAD:src/dependencies/cwRuntime/src/tests/cwThreading/testcases/test_cwthreading.message.pas
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
unit test_cwThreading.Message;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
, cwThreading
;

type
  TTestMessage = class(TTestCase)
  private
  published
    procedure ImplicitMessageToNativeuint;
    procedure ExplicitMessageToNativeuint;
    procedure ImplicitNativeuintToMessage;
    procedure ExplicitNativeuintToMessage;
    procedure CreateNoParams;
    procedure CreateOneParam;
    procedure CreateTwoParams;
    procedure CreateThreeParams;
    procedure CreateFourParams;
  end;

implementation

const
  MSG_TEST: TMessage = ( Value: 5; A: 1; B: 2; C: 3; D: 4 );
  iMSG_TEST = 5;
  iA = 1;
  iB = 2;
  iC = 3;
  iD = 4;
  cZero = 0;

procedure TTestMessage.ImplicitMessageToNativeuint;
var
  Message: TMessage;
  nInt: nativeuint;
begin
  // Arrange:
  Message := MSG_TEST;
  // Act:
  nInt := Message;
  // Assert:
  TTest.Expect( MSG_TEST.Value, nInt );
end;

procedure TTestMessage.ExplicitMessageToNativeuint;
var
  Message: TMessage;
  nInt: nativeuint;
begin
  // Arrange:
  Message := MSG_TEST;
  // Act:
  nInt := nativeuint( Message );
  // Assert:
  TTest.Expect( MSG_TEST.Value, nInt );
end;

procedure TTestMessage.ImplicitNativeuintToMessage;
var
  Message: TMessage;
  nInt: nativeuint;
begin
  // Arrange:
  nInt := iMSG_TEST;
  // Act:
  Message := nInt;
  // Assert:
  TTest.Expect( iMSG_TEST, MSG_TEST.Value );
end;

procedure TTestMessage.ExplicitNativeuintToMessage;
var
  Message: TMessage;
  nInt: nativeuint;
begin
  // Arrange:
  nInt := iMSG_TEST;
  // Act:
  Message := TMessage( nInt );
  // Assert:
  TTest.Expect( iMSG_TEST, MSG_TEST.Value );
end;


procedure TTestMessage.CreateNoParams;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST );
  // Assert:
  TTest.Expect( iMSG_TEST, Message.value );
  TTest.Expect( cZero, Message.A );
  TTest.Expect( cZero, Message.B );
  TTest.Expect( cZero, Message.C );
  TTest.Expect( cZero, Message.D );
end;

procedure TTestMessage.CreateOneParam;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST, iA );
  // Assert:
  TTest.Expect( iMSG_TEST, Message.value );
  TTest.Expect( iA, Message.A );
  TTest.Expect( cZero, Message.B );
  TTest.Expect( cZero, Message.C );
  TTest.Expect( cZero, Message.D );
end;

procedure TTestMessage.CreateTwoParams;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST, iA, iB );
  // Assert:
  TTest.Expect( iMSG_TEST, Message.value );
  TTest.Expect( iA, Message.A );
  TTest.Expect( iB, Message.B );
  TTest.Expect( cZero, Message.C );
  TTest.Expect( cZero, Message.D );
end;

procedure TTestMessage.CreateThreeParams;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST, iA, iB, iC );
  // Assert:
  TTest.Expect( iMSG_TEST, Message.value );
  TTest.Expect( iA, Message.A );
  TTest.Expect( iB, Message.B );
  TTest.Expect( iC, Message.C );
  TTest.Expect( cZero, Message.D );
end;

procedure TTestMessage.CreateFourParams;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST, iA, iB, iC, iD );
  // Assert:
  TTest.Expect( iMSG_TEST, Message.value );
  TTest.Expect( iA, Message.A );
  TTest.Expect( iB, Message.B );
  TTest.Expect( iC, Message.C );
  TTest.Expect( iD, Message.D );
end;

initialization
  TestSuite.RegisterTestCase(TTestMessage);

end.

=======
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
unit testcase.cwThreading.Message;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
, cwThreading
;

type
  TTestMessage = class(TTestCase)
  private
  published
    procedure ImplicitMessageToNativeuint;
    procedure ExplicitMessageToNativeuint;
    procedure ImplicitNativeuintToMessage;
    procedure ExplicitNativeuintToMessage;
    procedure CreateNoParams;
    procedure CreateOneParam;
    procedure CreateTwoParams;
    procedure CreateThreeParams;
    procedure CreateFourParams;
  end;

implementation

const
  MSG_TEST: TMessage = ( Value: 5; A: 1; B: 2; C: 3; D: 4 );
  iMSG_TEST = 5;
  iA = 1;
  iB = 2;
  iC = 3;
  iD = 4;
  cZero = 0;

procedure TTestMessage.ImplicitMessageToNativeuint;
var
  Message: TMessage;
  nInt: nativeuint;
begin
  // Arrange:
  Message := MSG_TEST;
  // Act:
  nInt := Message;
  // Assert:
  TTest.Expect( MSG_TEST.Value, nInt );
end;

procedure TTestMessage.ExplicitMessageToNativeuint;
var
  Message: TMessage;
  nInt: nativeuint;
begin
  // Arrange:
  Message := MSG_TEST;
  // Act:
  nInt := nativeuint( Message );
  // Assert:
  TTest.Expect( MSG_TEST.Value, nInt );
end;

procedure TTestMessage.ImplicitNativeuintToMessage;
var
  Message: TMessage;
  nInt: nativeuint;
begin
  // Arrange:
  nInt := iMSG_TEST;
  // Act:
  Message := nInt;
  // Assert:
  TTest.Expect( nativeuint(iMSG_TEST), MSG_TEST.Value );
end;

procedure TTestMessage.ExplicitNativeuintToMessage;
var
  Message: TMessage;
  nInt: nativeuint;
begin
  // Arrange:
  nInt := iMSG_TEST;
  // Act:
  Message := TMessage( nInt );
  // Assert:
  TTest.Expect( nativeuint(iMSG_TEST), MSG_TEST.Value );
end;


procedure TTestMessage.CreateNoParams;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST );
  // Assert:
  TTest.Expect( nativeuint(iMSG_TEST), Message.value );
  TTest.Expect( nativeuint(cZero), Message.A );
  TTest.Expect( nativeuint(cZero), Message.B );
  TTest.Expect( nativeuint(cZero), Message.C );
  TTest.Expect( nativeuint(cZero), Message.D );
end;

procedure TTestMessage.CreateOneParam;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST, iA );
  // Assert:
  TTest.Expect( nativeuint(iMSG_TEST), Message.value );
  TTest.Expect( nativeuint(iA), Message.A );
  TTest.Expect( nativeuint(cZero), Message.B );
  TTest.Expect( nativeuint(cZero), Message.C );
  TTest.Expect( nativeuint(cZero), Message.D );
end;

procedure TTestMessage.CreateTwoParams;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST, iA, iB );
  // Assert:
  TTest.Expect( nativeuint(iMSG_TEST), Message.value );
  TTest.Expect( nativeuint(iA), Message.A );
  TTest.Expect( nativeuint(iB), Message.B );
  TTest.Expect( nativeuint(cZero), Message.C );
  TTest.Expect( nativeuint(cZero), Message.D );
end;

procedure TTestMessage.CreateThreeParams;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST, iA, iB, iC );
  // Assert:
  TTest.Expect( nativeuint(iMSG_TEST), Message.value );
  TTest.Expect( nativeuint(iA), Message.A );
  TTest.Expect( nativeuint(iB), Message.B );
  TTest.Expect( nativeuint(iC), Message.C );
  TTest.Expect( nativeuint(cZero), Message.D );
end;

procedure TTestMessage.CreateFourParams;
var
  Message: TMessage;
begin
  // Arramge:
  // Act:
  Message := TMessage.Create( iMSG_TEST, iA, iB, iC, iD );
  // Assert:
  TTest.Expect( nativeuint(iMSG_TEST), Message.value );
  TTest.Expect( nativeuint(iA), Message.A );
  TTest.Expect( nativeuint(iB), Message.B );
  TTest.Expect( nativeuint(iC), Message.C );
  TTest.Expect( nativeuint(iD), Message.D );
end;

initialization
  TestSuite.RegisterTestCase(TTestMessage);

end.

>>>>>>> 6c4801d2dc5041f543a87f07704a36d49a557ce1:src/dependencies/cwRuntime/src/tests/cwThreading/testcase.cwthreading.message.pas
