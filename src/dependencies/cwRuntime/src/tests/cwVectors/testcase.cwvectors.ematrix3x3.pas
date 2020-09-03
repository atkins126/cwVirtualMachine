<<<<<<< HEAD:src/dependencies/cwRuntime/src/tests/cwVectors/testcases/test_cwvectors.ematrix3x3.pas
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
unit test_cwvectors.ematrix3x3;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwVectors
;

type
  TTestMatrixExtended = class(TTestCase)
  published

    ///  <summary>
    ///    Test the element-wise addition of one TMatrix to another.
    ///  </summary>
    procedure Add;

    ///  <summary>
    ///    Test the element-wise addition of a float to a TMatrix.
    ///  </summary>
    procedure AddF;

    ///  <summary>
    ///    Test the element-wise subtraction of a TMatrix from another TMatrix.
    ///  </summary>
    procedure Subtract;

    ///  <summary>
    ///    Test the element-wise subtraction of a float from a TMatrix.
    ///  </summary>
    procedure SubtractF;

    ///  <summary>
    ///    Test the element-wise multiplication of one TMatrix with another.
    ///  </summary>
    procedure Multiply;

    ///  <summary>
    ///    Test the element-wise addition of a float to a TMatrix.
    ///  </summary>
    procedure MultiplyF;

    ///  <summary>
    ///    Test the element-wise division of a TMatrix by another.
    ///  </summary>
    procedure Divide;

    ///  <summary>
    ///    Test the element-wise division of a TMatrix by a float.
    ///  </summary>
    procedure DivideF;

    ///  <summary>
    ///    Test the creation of a TMatrix from 16 discreet floats.
    ///  </summary>
    procedure CreateParameterized;

    ///  <summary>
    ///    Test the calculation of the dot product of a TMatrix with another
    ///    TMatrix.
    ///  </summary>
    procedure dotMM;

    ///  <summary>
    ///    Test the calculation of the dot product of a TVector3 with a TMatrix.
    ///  </summary>
    procedure dotVM;

    ///  <summary>
    ///    Test the calculation of a transposed TMatrix.
    ///  </summary>
    procedure transpose;

    ///  <summary>
    ///    Test the creation of a TMatrix representing the identity matrix.
    ///  </summary>
    procedure identity;

    ///  <summary>
    ///    Test the creation of a TMatrix for translating vectors.
    ///  </summary>
    procedure translation;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around X.
    ///  </summary>
    procedure rotationX;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around Y.
    ///  </summary>
    procedure rotationY;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around Z.
    ///  </summary>
    procedure rotationZ;

    ///  <summary>
    ///    Test the creation of a TMatrix for scaling vectors.
    ///  </summary>
    procedure scale;

    ///  <summary>
    ///    Test the determinant of the matrix.
    ///  </summary>
    procedure determinant;

    ///  <summary>
    ///    Test calculation of cofactor matrix.
    ///  </summary>
    procedure cofactor;

    ///  <summary>
    ///    Test calculation of adjugate matrix.
    ///  </summary>
    procedure adjugate;

    ///  <summary>
    ///    Test the inverse of the matrix.
    ///  </summary>
    procedure inverse;
  end;


implementation
uses
  cwTest.Standard
;

function CheckMatrix( M: eMatrix3x3; m00, m10, m20, m01, m11, m21, m02, m12, m22: extended ): boolean;
begin
  Result := True;
  Result := Result and (M.m00 > (m00-0.01)) and (M.m00 < (m00+0.01));
  Result := Result and (M.m01 > (m01-0.01)) and (M.m01 < (m01+0.01));
  Result := Result and (M.m02 > (m02-0.01)) and (M.m02 < (m02+0.01));
  Result := Result and (M.m10 > (m10-0.01)) and (M.m10 < (m10+0.01));
  Result := Result and (M.m11 > (m11-0.01)) and (M.m11 < (m11+0.01));
  Result := Result and (M.m12 > (m12-0.01)) and (M.m12 < (m12+0.01));
  Result := Result and (M.m20 > (m20-0.01)) and (M.m20 < (m20+0.01));
  Result := Result and (M.m21 > (m21-0.01)) and (M.m21 < (m21+0.01));
  Result := Result and (M.m22 > (m22-0.01)) and (M.m22 < (m22+0.01));
end;

procedure TTestMatrixExtended.Add;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    0, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1 + M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2+0, 4+2, 6+4,
    1+3, 3+5, 5+7,
    8+6, 4+4, 6+2
  ));
end;

procedure TTestMatrixExtended.AddF;
var
  M1, M2: eMatrix3x3;
  F: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );
  F := 5;

  // Act:
  M2 := M1 + F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2+F, 4+F, 6+F,
    1+F, 3+F, 5+F,
    8+F, 4+F, 6+F
  ));
end;

procedure TTestMatrixExtended.adjugate;
var
  M: eMatrix3x3;
begin
  // Arrange:
  M := eMatrix3x3.Create(
    -1, -2,  2,
     2,  1,  1,
     3,  4,  5
  );
  // Act:
  M := M.adjugate;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
      1,  18, -4,
     -7, -11,  5,
      5,  -2,  3
  ));
end;


procedure TTestMatrixExtended.cofactor;
var
  M: eMatrix3x3;
begin
  // Arrange:
  M := eMatrix3x3.Create(
    -1, -2,  2,
     2,  1,  1,
     3,  4,  5
  );
  // Act:
  M := M.cofactor;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
     1,  -7,  5,
    18, -11, -2,
    -4,   5,  3
  ));
end;


procedure TTestMatrixExtended.CreateParameterized;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.Create(
    01, 02, 03,
    05, 06, 07,
    09, 10, 11
  );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 02, 03,
    05, 06, 07,
    09, 10, 11
  ));
end;

procedure TTestMatrixExtended.determinant;
var
  M1: eMatrix3x3;
  M2: eMatrix3x3;
  F1: extended;
  F2: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
   4, -3,  0,
   2, -1, 2,
   1, 5,  7
  );
  M2 := eMatrix3x3.Create(
     4, -1, 1,
     4,  5, 3,
    -2,  0, 0
  );
  // Act:
  F1 := M1.determinant;
  F2 := M2.determinant;
  // Assert:
  TTest.IsTrue( (F1>-32.01) and (F1<-31.99) );
  TTest.IsTrue( (F2>15.99) and (F2<16.01) );
end;

procedure TTestMatrixExtended.Divide;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    1, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1 / M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2/1, 4/2, 6/4,
    1/3, 3/5, 5/7,
    8/6, 4/4, 6/2
  ));
end;

procedure TTestMatrixExtended.DivideF;
var
  M1, M2: eMatrix3x3;
  F: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );
  F := 5;

  // Act:
  M2 := M1 / F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2/F, 4/F, 6/F,
    1/F, 3/F, 5/F,
    8/F, 4/F, 6/F
  ));
end;

procedure TTestMatrixExtended.dotMM;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    1, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1.dot(M2);
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    50, 48, 48,
    40, 37, 35,
    56, 60, 72
  ));
end;

procedure TTestMatrixExtended.dotVM;
var
  M1: eMatrix3x3;
  V1,V2: eVector3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    -03, 00,  03,
     01, 07, -01,
    -03, 00,  03
  );
  V1 := eVector3.Create( 2, -3, 4 );
  // Act:
  V2 := M1.dot(V1);
  // Assert:
  TTest.IsTrue((V2.X > 5.99)   and (V2.X < 6.01));
  TTest.IsTrue((V2.Y > -23.01) and (V2.Y < -22.99));
  TTest.IsTrue((V2.Z > 5.99)   and (V2.Z < 6.01));
end;

procedure TTestMatrixExtended.identity;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.Identity;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
  ));
end;

procedure TTestMatrixExtended.inverse;
var
  M: eMatrix3x3;
  M1: eMatrix3x3;
  M2: eMatrix3x3;
begin
  // Arrange:
  M := eMatrix3x3.Create(
    0, 0,  1,
    2, -1, 3,
    1,  1, 4
  );
  // Act:
  M1 := M.inverse;
  M2 := M1.dot(M);
  // Assert:
  TTest.IsTrue( CheckMatrix( M1,
    -7/3,  1/3, 1/3,
    -5/3, -1/3, 2/3,
       1,    0,   0
  ));
  //- Any matrix multiplied by it's own inverse should be identity.
  TTest.IsTrue( CheckMatrix( M2,
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
  ));
end;


procedure TTestMatrixExtended.Multiply;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    0, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1 * M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2*0, 4*2, 6*4,
    1*3, 3*5, 5*7,
    8*6, 4*4, 6*2
  ));
end;

procedure TTestMatrixExtended.MultiplyF;
var
  M1, M2: eMatrix3x3;
  F: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );
  F := 5;

  // Act:
  M2 := M1 * F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2*F, 4*F, 6*F,
    1*F, 3*F, 5*F,
    8*F, 4*F, 6*F
  ));
end;

procedure TTestMatrixExtended.rotationX;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.rotationX(30);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    1,     0,     0,
    0, 0.866,  -0.5,
    0,   0.5, 0.866
  ));
end;

procedure TTestMatrixExtended.rotationY;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.rotationY(45);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    0.7071,  0,  0.7071,
         0,  1,       0,
   -0.7071,  0,  0.7071
  ));
end;

procedure TTestMatrixExtended.rotationZ;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.rotationZ(53.1);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    0.6, -0.8, 0,
    0.8,  0.6, 0,
    0,      0, 1
  ));
end;

procedure TTestMatrixExtended.scale;
var
  V: eVector3;
  M: eMatrix3x3;
begin
  // Arrange:
  V := eVector3.Create( 2, 3, 4 );
  // Act:
  M := eMatrix3x3.scale( V );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    V.X,   0,   0,
      0, V.Y,   0,
      0,   0, V.Z
  ));
end;

procedure TTestMatrixExtended.Subtract;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    0, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1 - M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2-0, 4-2, 6-4,
    1-3, 3-5, 5-7,
    8-6, 4-4, 6-2
  ));
end;

procedure TTestMatrixExtended.SubtractF;
var
  M1, M2: eMatrix3x3;
  F: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );
  F := 5;

  // Act:
  M2 := M1 - F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2-F, 4-F, 6-F,
    1-F, 3-F, 5-F,
    8-F, 4-F, 6-F
  ));
end;

procedure TTestMatrixExtended.translation;
var
  V: eVector3;
  M: eMatrix3x3;
begin
  // Arrange:
  V := eVector3.Create( 2, 3, 4 );
  // Act:
  M := eMatrix3x3.translation( V );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
      1,   0,   V.X,
      0,   1,   V.Y,
      0,   0,   V.Z
  ));
end;

procedure TTestMatrixExtended.transpose;
var
  M: eMatrix3x3;
begin
  // Arrange:
  M := eMatrix3x3.Create(
    01, 02, 03,
    05, 06, 07,
    09, 10, 11
  );
  // Act:
  M := M.transpose;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 05, 09,
    02, 06, 10,
    03, 07, 11
  ));
end;

initialization
  TestSuite.RegisterTestCase(TTestMatrixExtended);

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
unit testcase.cwvectors.ematrix3x3;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwVectors
;

type
  TTestMatrixExtended = class(TTestCase)
  published

    ///  <summary>
    ///    Test the element-wise addition of one TMatrix to another.
    ///  </summary>
    procedure Add;

    ///  <summary>
    ///    Test the element-wise addition of a float to a TMatrix.
    ///  </summary>
    procedure AddF;

    ///  <summary>
    ///    Test the element-wise subtraction of a TMatrix from another TMatrix.
    ///  </summary>
    procedure Subtract;

    ///  <summary>
    ///    Test the element-wise subtraction of a float from a TMatrix.
    ///  </summary>
    procedure SubtractF;

    ///  <summary>
    ///    Test the element-wise multiplication of one TMatrix with another.
    ///  </summary>
    procedure Multiply;

    ///  <summary>
    ///    Test the element-wise addition of a float to a TMatrix.
    ///  </summary>
    procedure MultiplyF;

    ///  <summary>
    ///    Test the element-wise division of a TMatrix by another.
    ///  </summary>
    procedure Divide;

    ///  <summary>
    ///    Test the element-wise division of a TMatrix by a float.
    ///  </summary>
    procedure DivideF;

    ///  <summary>
    ///    Test the creation of a TMatrix from 16 discreet floats.
    ///  </summary>
    procedure CreateParameterized;

    ///  <summary>
    ///    Test the calculation of the dot product of a TMatrix with another
    ///    TMatrix.
    ///  </summary>
    procedure dotMM;

    ///  <summary>
    ///    Test the calculation of the dot product of a TVector3 with a TMatrix.
    ///  </summary>
    procedure dotVM;

    ///  <summary>
    ///    Test the calculation of a transposed TMatrix.
    ///  </summary>
    procedure transpose;

    ///  <summary>
    ///    Test the creation of a TMatrix representing the identity matrix.
    ///  </summary>
    procedure identity;

    ///  <summary>
    ///    Test the creation of a TMatrix for translating vectors.
    ///  </summary>
    procedure translation;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around X.
    ///  </summary>
    procedure rotationX;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around Y.
    ///  </summary>
    procedure rotationY;

    ///  <summary>
    ///    Test the creation of a TMatrix for rotating vectors around Z.
    ///  </summary>
    procedure rotationZ;

    ///  <summary>
    ///    Test the creation of a TMatrix for scaling vectors.
    ///  </summary>
    procedure scale;

    ///  <summary>
    ///    Test the determinant of the matrix.
    ///  </summary>
    procedure determinant;

    ///  <summary>
    ///    Test calculation of cofactor matrix.
    ///  </summary>
    procedure cofactor;

    ///  <summary>
    ///    Test calculation of adjugate matrix.
    ///  </summary>
    procedure adjugate;

    ///  <summary>
    ///    Test the inverse of the matrix.
    ///  </summary>
    procedure inverse;
  end;


implementation
uses
  cwTest.Standard
;

function CheckMatrix( M: eMatrix3x3; m00, m10, m20, m01, m11, m21, m02, m12, m22: extended ): boolean;
begin
  Result := True;
  Result := Result and (M.m00 > (m00-0.01)) and (M.m00 < (m00+0.01));
  Result := Result and (M.m01 > (m01-0.01)) and (M.m01 < (m01+0.01));
  Result := Result and (M.m02 > (m02-0.01)) and (M.m02 < (m02+0.01));
  Result := Result and (M.m10 > (m10-0.01)) and (M.m10 < (m10+0.01));
  Result := Result and (M.m11 > (m11-0.01)) and (M.m11 < (m11+0.01));
  Result := Result and (M.m12 > (m12-0.01)) and (M.m12 < (m12+0.01));
  Result := Result and (M.m20 > (m20-0.01)) and (M.m20 < (m20+0.01));
  Result := Result and (M.m21 > (m21-0.01)) and (M.m21 < (m21+0.01));
  Result := Result and (M.m22 > (m22-0.01)) and (M.m22 < (m22+0.01));
end;

procedure TTestMatrixExtended.Add;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    0, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1 + M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2+0, 4+2, 6+4,
    1+3, 3+5, 5+7,
    8+6, 4+4, 6+2
  ));
end;

procedure TTestMatrixExtended.AddF;
var
  M1, M2: eMatrix3x3;
  F: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );
  F := 5;

  // Act:
  M2 := M1 + F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2+F, 4+F, 6+F,
    1+F, 3+F, 5+F,
    8+F, 4+F, 6+F
  ));
end;

procedure TTestMatrixExtended.adjugate;
var
  M: eMatrix3x3;
begin
  // Arrange:
  M := eMatrix3x3.Create(
    -1, -2,  2,
     2,  1,  1,
     3,  4,  5
  );
  // Act:
  M := M.adjugate;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
      1,  18, -4,
     -7, -11,  5,
      5,  -2,  3
  ));
end;


procedure TTestMatrixExtended.cofactor;
var
  M: eMatrix3x3;
begin
  // Arrange:
  M := eMatrix3x3.Create(
    -1, -2,  2,
     2,  1,  1,
     3,  4,  5
  );
  // Act:
  M := M.cofactor;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
     1,  -7,  5,
    18, -11, -2,
    -4,   5,  3
  ));
end;


procedure TTestMatrixExtended.CreateParameterized;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.Create(
    01, 02, 03,
    05, 06, 07,
    09, 10, 11
  );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 02, 03,
    05, 06, 07,
    09, 10, 11
  ));
end;

procedure TTestMatrixExtended.determinant;
var
  M1: eMatrix3x3;
  M2: eMatrix3x3;
  F1: extended;
  F2: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
   4, -3,  0,
   2, -1, 2,
   1, 5,  7
  );
  M2 := eMatrix3x3.Create(
     4, -1, 1,
     4,  5, 3,
    -2,  0, 0
  );
  // Act:
  F1 := M1.determinant;
  F2 := M2.determinant;
  // Assert:
  TTest.IsTrue( (F1>-32.01) and (F1<-31.99) );
  TTest.IsTrue( (F2>15.99) and (F2<16.01) );
end;

procedure TTestMatrixExtended.Divide;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    1, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1 / M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2/1, 4/2, 6/4,
    1/3, 3/5, 5/7,
    8/6, 4/4, 6/2
  ));
end;

procedure TTestMatrixExtended.DivideF;
var
  M1, M2: eMatrix3x3;
  F: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );
  F := 5;

  // Act:
  M2 := M1 / F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2/F, 4/F, 6/F,
    1/F, 3/F, 5/F,
    8/F, 4/F, 6/F
  ));
end;

procedure TTestMatrixExtended.dotMM;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    1, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1.dot(M2);
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    50, 48, 48,
    40, 37, 35,
    56, 60, 72
  ));
end;

procedure TTestMatrixExtended.dotVM;
var
  M1: eMatrix3x3;
  V1,V2: eVector3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    -03, 00,  03,
     01, 07, -01,
    -03, 00,  03
  );
  V1 := eVector3.Create( 2, -3, 4 );
  // Act:
  V2 := M1.dot(V1);
  // Assert:
  TTest.IsTrue((V2.X > 5.99)   and (V2.X < 6.01));
  TTest.IsTrue((V2.Y > -23.01) and (V2.Y < -22.99));
  TTest.IsTrue((V2.Z > 5.99)   and (V2.Z < 6.01));
end;

procedure TTestMatrixExtended.identity;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.Identity;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
  ));
end;

procedure TTestMatrixExtended.inverse;
var
  M: eMatrix3x3;
  M1: eMatrix3x3;
  M2: eMatrix3x3;
begin
  // Arrange:
  M := eMatrix3x3.Create(
    0, 0,  1,
    2, -1, 3,
    1,  1, 4
  );
  // Act:
  M1 := M.inverse;
  M2 := M1.dot(M);
  // Assert:
  TTest.IsTrue( CheckMatrix( M1,
    -7/3,  1/3, 1/3,
    -5/3, -1/3, 2/3,
       1,    0,   0
  ));
  //- Any matrix multiplied by it's own inverse should be identity.
  TTest.IsTrue( CheckMatrix( M2,
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
  ));
end;


procedure TTestMatrixExtended.Multiply;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    0, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1 * M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2*0, 4*2, 6*4,
    1*3, 3*5, 5*7,
    8*6, 4*4, 6*2
  ));
end;

procedure TTestMatrixExtended.MultiplyF;
var
  M1, M2: eMatrix3x3;
  F: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );
  F := 5;

  // Act:
  M2 := M1 * F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2*F, 4*F, 6*F,
    1*F, 3*F, 5*F,
    8*F, 4*F, 6*F
  ));
end;

procedure TTestMatrixExtended.rotationX;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.rotationX(30);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    1,     0,     0,
    0, 0.866,  -0.5,
    0,   0.5, 0.866
  ));
end;

procedure TTestMatrixExtended.rotationY;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.rotationY(45);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    0.7071,  0,  0.7071,
         0,  1,       0,
   -0.7071,  0,  0.7071
  ));
end;

procedure TTestMatrixExtended.rotationZ;
var
  M: eMatrix3x3;
begin
  // Arrange:
  // Act:
  M := eMatrix3x3.rotationZ(53.1);
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    0.6, -0.8, 0,
    0.8,  0.6, 0,
    0,      0, 1
  ));
end;

procedure TTestMatrixExtended.scale;
var
  V: eVector3;
  M: eMatrix3x3;
begin
  // Arrange:
  V := eVector3.Create( 2, 3, 4 );
  // Act:
  M := eMatrix3x3.scale( V );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    V.X,   0,   0,
      0, V.Y,   0,
      0,   0, V.Z
  ));
end;

procedure TTestMatrixExtended.Subtract;
var
  M1, M2, M3: eMatrix3x3;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );

  M2 := eMatrix3x3.Create(
    0, 2, 4,
    3, 5, 7,
    6, 4, 2
  );

  // Act:
  M3 := M1 - M2;
  // Assert:
  TTest.IsTrue( CheckMatrix( M3,
    2-0, 4-2, 6-4,
    1-3, 3-5, 5-7,
    8-6, 4-4, 6-2
  ));
end;

procedure TTestMatrixExtended.SubtractF;
var
  M1, M2: eMatrix3x3;
  F: extended;
begin
  // Arrange:
  M1 := eMatrix3x3.Create(
    2, 4, 6,
    1, 3, 5,
    8, 4, 6
  );
  F := 5;

  // Act:
  M2 := M1 - F;

  // Assert:
  TTest.IsTrue( CheckMatrix( M2,
    2-F, 4-F, 6-F,
    1-F, 3-F, 5-F,
    8-F, 4-F, 6-F
  ));
end;

procedure TTestMatrixExtended.translation;
var
  V: eVector3;
  M: eMatrix3x3;
begin
  // Arrange:
  V := eVector3.Create( 2, 3, 4 );
  // Act:
  M := eMatrix3x3.translation( V );
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
      1,   0,   V.X,
      0,   1,   V.Y,
      0,   0,   V.Z
  ));
end;

procedure TTestMatrixExtended.transpose;
var
  M: eMatrix3x3;
begin
  // Arrange:
  M := eMatrix3x3.Create(
    01, 02, 03,
    05, 06, 07,
    09, 10, 11
  );
  // Act:
  M := M.transpose;
  // Assert:
  TTest.IsTrue( CheckMatrix( M,
    01, 05, 09,
    02, 06, 10,
    03, 07, 11
  ));
end;

initialization
  TestSuite.RegisterTestCase(TTestMatrixExtended);

end.

>>>>>>> 6c4801d2dc5041f543a87f07704a36d49a557ce1:src/dependencies/cwRuntime/src/tests/cwVectors/testcase.cwvectors.ematrix3x3.pas
