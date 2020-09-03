<<<<<<< HEAD:src/dependencies/cwRuntime/src/tests/cwThreading/testcases/test_cwthreading.messageparameter.pas
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
unit test_cwThreading.MessageParameter;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
, cwThreading
;

type
  TTestMessageParameter = class(TTestCase)
  private
  published
    procedure ImplicitParameterToNativeuint;
    procedure ExplicitParameterToNativeuint;
    procedure ImplicitParameterToPointer;
    procedure ExplicitParameterToPointer;
    procedure ImplicitNativeuintToParameter;
    procedure ExplicitNativeuintToParameter;
    procedure ImplicitPointerToParameter;
    procedure ExplicitPointerToParameter;
    procedure EqualNativeuintAndParameter;
    procedure EqualParameterAndNativeuint;
    procedure NotEqualNativeuintAndParameter;
    procedure NotEqualParameterAndNativeuint;
    procedure EqualPointerAndParameter;
    procedure EqualParameterAndPointer;
    procedure NotEqualPointerAndParameter;
    procedure NotEqualParameterAndPointer;
    procedure EqualParameterAndParameter;
    procedure NotEqualParameterAndParameter;
  end;

implementation

const
  cTestNativeuintValue       = 5;
  cTestPointerValue: pointer = pointer($00FF);

{ TTestMessageParameter }

procedure TTestMessageParameter.ImplicitParameterToNativeuint;
var
  param: TMessageParameter;
  nInt: nativeuint;
begin
  // Arrange:
  param.Param := cTestNativeuintValue;
  // Act:
  nInt := param;
  // Assert:
  TTest.Expect(cTestNativeuintValue,nInt);
end;

procedure TTestMessageParameter.ExplicitParameterToNativeuint;
var
  param: TMessageParameter;
  nInt: nativeuint;
begin
  // Arrange:
  param.Param := cTestNativeuintValue;
  // Act:
  nInt := nativeuint(param);
  // Assert:
  TTest.Expect(cTestNativeuintValue,nInt);
end;

procedure TTestMessageParameter.ImplicitParameterToPointer;
var
  param: TMessageParameter;
  ptr: pointer;
begin
  // Arrange:
  param.Param := nativeuint( cTestPointerValue );
  // Act:
  ptr := param;
  // Assert:
  TTest.Expect(nativeuint(cTestPointerValue),nativeuint(ptr));
end;

procedure TTestMessageParameter.ExplicitParameterToPointer;
var
  param: TMessageParameter;
  ptr: pointer;
begin
  // Arrange:
  param.Param := nativeuint( cTestPointerValue );
  // Act:
  ptr := pointer( param );
  // Assert:
  TTest.Expect(nativeuint(cTestPointerValue),nativeuint(ptr));
end;

procedure TTestMessageParameter.ImplicitNativeuintToParameter;
var
  nInt: nativeuint;
  param: TMessageParameter;
begin
  // Arrange:
  nInt := cTestNativeuintValue;
  // Act:
  param := nInt;
  // Assert:
  TTest.Expect(cTestNativeuintValue,param.Param);
end;

procedure TTestMessageParameter.ExplicitNativeuintToParameter;
var
  nInt: nativeuint;
  param: TMessageParameter;
begin
  // Arrange:
  nInt := cTestNativeuintValue;
  // Act:
  param := TMessageParameter( nInt );
  // Assert:
  TTest.Expect(cTestNativeuintValue,param.Param);
end;


procedure TTestMessageParameter.ImplicitPointerToParameter;
var
  ptr: pointer;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  // Act:
  param := ptr;
  // Assert:
  TTest.Expect(nativeuint(cTestPointerValue),param.Param);
end;

procedure TTestMessageParameter.ExplicitPointerToParameter;
var
  ptr: pointer;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  // Act:
  param := TMessageParameter( ptr );
  // Assert:
  TTest.Expect(nativeuint(cTestPointerValue),param.Param);
end;


procedure TTestMessageParameter.EqualNativeuintAndParameter;
var
  srcnInt: nativeuint;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  srcnInt := cTestNativeuintValue;
  param := srcnInt;
  // Act:
  b := srcnInt = param;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.EqualParameterAndNativeuint;
var
  srcnInt: nativeuint;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  srcnInt := cTestNativeuintValue;
  param := srcnInt;
  // Act:
  b := param = srcnInt;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualNativeuintAndParameter;
var
  srcnInt: nativeuint;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  srcnInt := succ(cTestNativeuintValue);
  param := cTestNativeuintValue;
  // Act:
  b := srcnInt <> param;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualParameterAndNativeuint;
var
  srcnInt: nativeuint;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  srcnInt := succ(cTestNativeuintValue);
  param := cTestNativeuintValue;
  // Act:
  b := param <> srcnInt;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.EqualPointerAndParameter;
var
  ptr: pointer;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  param := cTestPointerValue;
  // Act:
  b := ptr = param;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.EqualParameterAndPointer;
var
  ptr: pointer;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  param := cTestPointerValue;
  // Act:
  b := param = ptr;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualPointerAndParameter;
var
  ptr: pointer;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  inc(ptr);
  param := cTestPointerValue;
  // Act:
  b := ptr <> param;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualParameterAndPointer;
var
  ptr: pointer;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  inc(ptr);
  param := cTestPointerValue;
  // Act:
  b := param <> ptr;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.EqualParameterAndParameter;
var
  b: boolean;
  paramA: TMessageParameter;
  paramB: TMessageParameter;
begin
  // Arrange:
  paramA := cTestPointerValue;
  paramB := cTestPointerValue;
  // Act:
  b := paramA = ParamB;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualParameterAndParameter;
var
  b: boolean;
  paramA: TMessageParameter;
  paramB: TMessageParameter;
begin
  // Arrange:
  paramA := succ(cTestNativeuintValue);
  paramB := cTestPointerValue;
  // Act:
  b := paramA <> ParamB;
  // Assert:
  TTest.IsTrue(b);
end;

initialization
  TestSuite.RegisterTestCase(TTestMessageParameter);

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
unit testcase.cwThreading.MessageParameter;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
, cwThreading
;

type
  TTestMessageParameter = class(TTestCase)
  private
  published
    procedure ImplicitParameterToNativeuint;
    procedure ExplicitParameterToNativeuint;
    procedure ImplicitParameterToPointer;
    procedure ExplicitParameterToPointer;
    procedure ImplicitNativeuintToParameter;
    procedure ExplicitNativeuintToParameter;
    procedure ImplicitPointerToParameter;
    procedure ExplicitPointerToParameter;
    procedure EqualNativeuintAndParameter;
    procedure EqualParameterAndNativeuint;
    procedure NotEqualNativeuintAndParameter;
    procedure NotEqualParameterAndNativeuint;
    procedure EqualPointerAndParameter;
    procedure EqualParameterAndPointer;
    procedure NotEqualPointerAndParameter;
    procedure NotEqualParameterAndPointer;
    procedure EqualParameterAndParameter;
    procedure NotEqualParameterAndParameter;
  end;

implementation

const
  cTestNativeuintValue       = 5;
  cTestPointerValue: pointer = pointer($00FF);

{ TTestMessageParameter }

procedure TTestMessageParameter.ImplicitParameterToNativeuint;
var
  param: TMessageParameter;
  nInt: nativeuint;
begin
  // Arrange:
  param.Param := cTestNativeuintValue;
  // Act:
  nInt := param;
  // Assert:
  TTest.Expect(nativeuint(cTestNativeuintValue),nInt);
end;

procedure TTestMessageParameter.ExplicitParameterToNativeuint;
var
  param: TMessageParameter;
  nInt: nativeuint;
begin
  // Arrange:
  param.Param := cTestNativeuintValue;
  // Act:
  nInt := nativeuint(param);
  // Assert:
  TTest.Expect(nativeuint(cTestNativeuintValue),nInt);
end;

procedure TTestMessageParameter.ImplicitParameterToPointer;
var
  param: TMessageParameter;
  ptr: pointer;
begin
  // Arrange:
  param.Param := nativeuint( cTestPointerValue );
  // Act:
  ptr := param;
  // Assert:
  TTest.Expect(nativeuint(cTestPointerValue),nativeuint(ptr));
end;

procedure TTestMessageParameter.ExplicitParameterToPointer;
var
  param: TMessageParameter;
  ptr: pointer;
begin
  // Arrange:
  param.Param := nativeuint( cTestPointerValue );
  // Act:
  ptr := pointer( param );
  // Assert:
  TTest.Expect(nativeuint(cTestPointerValue),nativeuint(ptr));
end;

procedure TTestMessageParameter.ImplicitNativeuintToParameter;
var
  nInt: nativeuint;
  param: TMessageParameter;
begin
  // Arrange:
  nInt := cTestNativeuintValue;
  // Act:
  param := nInt;
  // Assert:
  TTest.Expect(nativeuint(cTestNativeuintValue),param.Param);
end;

procedure TTestMessageParameter.ExplicitNativeuintToParameter;
var
  nInt: nativeuint;
  param: TMessageParameter;
begin
  // Arrange:
  nInt := cTestNativeuintValue;
  // Act:
  param := TMessageParameter( nInt );
  // Assert:
  TTest.Expect(nativeuint(cTestNativeuintValue),param.Param);
end;


procedure TTestMessageParameter.ImplicitPointerToParameter;
var
  ptr: pointer;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  // Act:
  param := ptr;
  // Assert:
  TTest.Expect(nativeuint(cTestPointerValue),param.Param);
end;

procedure TTestMessageParameter.ExplicitPointerToParameter;
var
  ptr: pointer;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  // Act:
  param := TMessageParameter( ptr );
  // Assert:
  TTest.Expect(nativeuint(cTestPointerValue),param.Param);
end;


procedure TTestMessageParameter.EqualNativeuintAndParameter;
var
  srcnInt: nativeuint;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  srcnInt := cTestNativeuintValue;
  param := srcnInt;
  // Act:
  b := srcnInt = param;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.EqualParameterAndNativeuint;
var
  srcnInt: nativeuint;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  srcnInt := cTestNativeuintValue;
  param := srcnInt;
  // Act:
  b := param = srcnInt;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualNativeuintAndParameter;
var
  srcnInt: nativeuint;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  srcnInt := succ(cTestNativeuintValue);
  param := cTestNativeuintValue;
  // Act:
  b := srcnInt <> param;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualParameterAndNativeuint;
var
  srcnInt: nativeuint;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  srcnInt := succ(cTestNativeuintValue);
  param := cTestNativeuintValue;
  // Act:
  b := param <> srcnInt;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.EqualPointerAndParameter;
var
  ptr: pointer;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  param := cTestPointerValue;
  // Act:
  b := ptr = param;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.EqualParameterAndPointer;
var
  ptr: pointer;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  param := cTestPointerValue;
  // Act:
  b := param = ptr;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualPointerAndParameter;
var
  ptr: pointer;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  inc(ptr);
  param := cTestPointerValue;
  // Act:
  b := ptr <> param;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualParameterAndPointer;
var
  ptr: pointer;
  b: boolean;
  param: TMessageParameter;
begin
  // Arrange:
  ptr := cTestPointerValue;
  inc(ptr);
  param := cTestPointerValue;
  // Act:
  b := param <> ptr;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.EqualParameterAndParameter;
var
  b: boolean;
  paramA: TMessageParameter;
  paramB: TMessageParameter;
begin
  // Arrange:
  paramA := cTestPointerValue;
  paramB := cTestPointerValue;
  // Act:
  b := paramA = ParamB;
  // Assert:
  TTest.IsTrue(b);
end;

procedure TTestMessageParameter.NotEqualParameterAndParameter;
var
  b: boolean;
  paramA: TMessageParameter;
  paramB: TMessageParameter;
begin
  // Arrange:
  paramA := succ(cTestNativeuintValue);
  paramB := cTestPointerValue;
  // Act:
  b := paramA <> ParamB;
  // Assert:
  TTest.IsTrue(b);
end;

initialization
  TestSuite.RegisterTestCase(TTestMessageParameter);

end.

>>>>>>> 6c4801d2dc5041f543a87f07704a36d49a557ce1:src/dependencies/cwRuntime/src/tests/cwThreading/testcase.cwthreading.messageparameter.pas
