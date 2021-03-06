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
unit testcase.cwTypes.BooleanHelper;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
, cwTypes
;

type
  TTestBooleanHelper = class(TTestCase)
  private
  published
    procedure AsString;
  end;

implementation

procedure TTestBooleanHelper.AsString;
var
  B1: boolean;
  B2: boolean;
  B3: boolean;
  B4: boolean;
  B5: boolean;
  B6: boolean;
begin
  // Arrange:
  B1 := True;
  B2 := False;
  // Act:
  {$warnings off} B3.AsString := 'True'; {$warnings on} // Warns that B3 is not initialized, this is initialization
  {$warnings off} B4.AsString := 'False';{$warnings on} // Warns that B4 is not initialized, this is initialization
  {$warnings off} B5.AsString := 'TRUE'; {$warnings on} // Warns that B5 is not initialized, this is initialization
  {$warnings off} B6.AsString := 'XYZ';  {$warnings on} // Warns that B6 is not initialized, this is initialization
  // Assert:
  TTest.Expect('TRUE',B1.AsString);
  TTest.Expect('FALSE',B2.AsString);
  TTest.Expect(TRUE,B3);
  TTest.Expect(FALSE,B4);
  TTest.Expect(TRUE,B5);
  TTest.Expect(FALSE,B6);
end;

initialization
  TestSuite.RegisterTestCase(TTestBooleanHelper);

end.
