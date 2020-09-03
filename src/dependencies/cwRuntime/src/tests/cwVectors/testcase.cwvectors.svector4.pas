<<<<<<< HEAD:src/dependencies/cwRuntime/src/tests/cwVectors/testcases/test_cwvectors.svector4.pas
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
unit test_cwvectors.svector4;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwVectors
;

type
  TTestVector4Single = class(TTestCase)
  published

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure AddVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure AddAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure SubtractVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure SubtractAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure MultiplyVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure MultiplyAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure DivideVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure DivideAV;

    ///  <summary>
    ///    Tests the assignment of an array of floats to a vector.
    ///  </summary>
    procedure ArrayAssign;

    ///  <summary>
    ///    Test the addition of one TVector4 to another TVector4
    ///  </summary>
    procedure Add;

    ///  <summary>
    ///    Test the addition of a float to a TVector4 (element-wise)
    ///  </summary>
    procedure AddF;

    ///  <summary>
    ///    Test the subtraction of a TVector4 from another TVector4.
    ///  </summary>
    procedure Subtract;

    ///  <summary>
    ///    Test the subtraction of a float from a TVector4 (element-wise).
    ///  </summary>
    procedure SubtractF;

    ///  <summary>
    ///    Test the multiplication of a TVector4 with another TVector4.
    ///    (Hadamard, element-wise)
    ///  </summary>
    procedure Multiply;

    ///  <summary>
    ///    Test the multiplication of a float with a TVector4
    ///    (element-wise, scale)
    ///  </summary>
    procedure MultiplyF;

    ///  <summary>
    ///    Test the division of a TVector4 by another TVector4.
    ///    (element-wise)
    ///  </summary>
    procedure Divide;

    ///  <summary>
    ///    Test the division of a TVector4 by a float.
    ///    (element-wise)
    ///  </summary>
    procedure DivideF;

    ///  <summary>
    ///    Test the implicit assignment of a TVector3 to a TVector4 where the
    ///    fourth element of the TVector4 is set to 1.0
    ///  </summary>
    procedure ImplicitV3V4;

    ///  <summary>
    ///    Test the explicit assignment of a TVector3 to a TVector4 where the
    ///    fourth element of the TVector4 is set to 1.0
    ///  </summary>
    procedure ExplicitV3V4;

    ///  <summary>
    ///    Test the implicit assignment of a TVector2 to a TVector4 where the
    ///    third element of the TVector4 is set to 0.0 and the fourth is set to
    ///    1.0.
    ///  </summary>
    procedure ImplicitV2V4;

    ///  <summary>
    ///    Test the explicit assignment of a TVector2 to a TVector4 where the
    ///    third element of the TVector4 is set to 0.0 and the fourth is set
    ///    to 1.0.
    ///  </summary>
    procedure ExplicitV2V4;

    ///  <summary>
    ///    Test the implicit assignment of a TVector4 to a TVector3 where the
    ///    fourth element of the TVector4 is dropped.
    ///  </summary>
    procedure ImplicitV4V3;

    ///  <summary>
    ///    Test the explicit assignment of a TVector4 to a TVector3 where the
    ///    fourth element of the TVector4 is dropped.
    ///  </summary>
    procedure ExplicitV4V3;

    ///  <summary>
    ///    Test the implicit assignment of a TVector4 to a TVector2 where the
    ///    third and fourth elements ot the TVector4 are dropped.
    ///  </summary>
    procedure ImplicitV4V2;

    ///  <summary>
    ///    Test the explicit assignment of a TVector4 to a TVector2 where the
    ///    third and fourth elements of the TVector4 are dropped.
    ///  </summary>
    procedure ExplicitV4V2;

    ///  <summary>
    ///    Test the creation of a TVector4 from four discreet float parameters.
    ///  </summary>
    procedure CreateXYZW;

    ///  <summary>
    ///    Test the dot product calculation of a TVector4 with another
    ///    TVector4.
    ///  </summary>
    procedure dot;

    ///  <summary>
    ///    Test the normalized calculation of a TVector4.
    ///  </summary>
    procedure normalized;

    ///  <summary>
    ///    Test the magnitude calculation of a TVector4.
    ///  </summary>
    procedure magnitude;
  end;


implementation
uses
  cwTest.Standard
;

procedure TTestVector4Single.Add;
var
  V1, V2, V3: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  V2 := sVector4.Create( 3, 6, 9, 12 );
  // Act:
  V3 := V1 + V2;
  // Assert:
  TTest.IsTrue((V3.X > 4.99)  and (V3.X < 5.01));
  TTest.IsTrue((V3.Y > 9.99)  and (V3.Y < 10.01));
  TTest.IsTrue((V3.Z > 14.99) and (V3.Z < 15.01));
  TTest.IsTrue((V3.W > 19.99) and (V3.W < 20.01));
end;

procedure TTestVector4Single.AddAV;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 2, 1 ];
  R := R + V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 4.99 ) and (R.X < 5.01)) );
  TTest.IsTrue( ((R.Y > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.Z > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.W > 4.99 ) and (R.W < 5.01)) );
end;

procedure TTestVector4Single.AddF;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V1 + 3;
  // Assert:
  TTest.IsTrue((V2.X > 4.99)  and (V2.X < 5.01));
  TTest.IsTrue((V2.Y > 6.99)  and (V2.Y < 7.01));
  TTest.IsTrue((V2.Z > 8.99)  and (V2.Z < 9.01));
  TTest.IsTrue((V2.W > 10.99) and (V2.W < 11.01));
end;

procedure TTestVector4Single.AddVA;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 2, 1 ];
  R := V + R; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 4.99 ) and (R.X < 5.01)) );
  TTest.IsTrue( ((R.Y > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.Z > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.W > 4.99 ) and (R.W < 5.01)) );
end;

procedure TTestVector4Single.ArrayAssign;
var
  V: sVector4;
begin
  // Arrange:
  // Act:
  V := [1,2,3,4]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((V.X > 0.99 ) and (V.X < 1.01)) );
  TTest.IsTrue( ((V.Y > 1.99 ) and (V.Y < 2.01)) );
  TTest.IsTrue( ((V.Z > 2.99 ) and (V.Y < 3.01)) );
  TTest.IsTrue( ((V.W > 3.99 ) and (V.W < 4.01)) );
end;

procedure TTestVector4Single.CreateXYZW;
var
  V1: sVector4;
begin
  // Arrange:
  // Act:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Assert:
  TTest.IsTrue((V1.X > 1.99) and (V1.X < 2.01));
  TTest.IsTrue((V1.Y > 3.99) and (V1.Y < 4.01));
  TTest.IsTrue((V1.Z > 5.99) and (V1.Z < 6.01));
  TTest.IsTrue((V1.W > 7.99) and (V1.W < 8.01));
end;

procedure TTestVector4Single.Divide;
var
  V1, V2, V3: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 3, 6, 9, 12 );
  V2 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V3 := V1 / V2;
  // Assert:
  TTest.IsTrue((V3.X > 1.49) and (V3.X < 1.51));
  TTest.IsTrue((V3.Y > 1.49) and (V3.Y < 1.51));
  TTest.IsTrue((V3.Z > 1.49) and (V3.Z < 1.51));
  TTest.IsTrue((V3.W > 1.49) and (V3.W < 1.51));
end;

procedure TTestVector4Single.DivideAV;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 2, 1 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R :=  [ 4, 3, 3, 4 ];
  R := R / V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 3.99 ) and (R.X < 4.01)) );
  TTest.IsTrue( ((R.Y > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.Z > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.W > 3.99 ) and (R.W < 4.01)) );
end;

procedure TTestVector4Single.DivideF;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V1 / 2;
  // Assert:
  TTest.IsTrue((V2.X > 0.99) and (V2.X < 1.01));
  TTest.IsTrue((V2.Y > 1.99) and (V2.Y < 2.01));
  TTest.IsTrue((V2.Z > 2.99) and (V2.Z < 3.01));
  TTest.IsTrue((V2.W > 3.99) and (V2.W < 4.01));
end;

procedure TTestVector4Single.DivideVA;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 4, 3, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 1, 2, 2, 1 ];
  R :=  V / R; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 3.99 ) and (R.X < 4.01)) );
  TTest.IsTrue( ((R.Y > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.Z > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.W > 3.99 ) and (R.W < 4.01)) );
end;

procedure TTestVector4Single.dot;
var
  V1, V2: sVector4;
  F: single;
begin
  // Arrange:
  V1 := sVector4.Create(5,6,3,8);
  V2 := sVector4.Create(2,3,5,4);
  // Act:
  F := V1.dot(V2);
  // Assert:
  TTest.IsTrue( ((F > 74.99 ) and (F < 75.01)) );
end;


procedure TTestVector4Single.ExplicitV2V4;
var
  V2: sVector2;
  V4: sVector4;
begin
  // Arrange:
  V2 := sVector2.Create( 2, 8 );
  // Act:
  V4 := sVector4( V2 );
  // Assert:
  TTest.IsTrue( ((V4.X > 1.99 )  and (V4.X < 2.01)) );
  TTest.IsTrue( ((V4.Y > 7.99 )  and (V4.Y < 8.01)) );
  TTest.IsTrue( ((V4.Z > -0.01 ) and (V4.Z < 0.01)) );
  TTest.IsTrue( ((V4.W > 0.99 )  and (V4.W < 1.01)) );
end;

procedure TTestVector4Single.ExplicitV3V4;
var
  V3: sVector3;
  V4: sVector4;
begin
  // Arrange:
  V3 := sVector3.Create( 2, 4, 6 );
  // Act:
  V4 := sVector4( V3 );
  // Assert:
  TTest.IsTrue( ((V4.X > 1.99 ) and (V4.X < 2.01)) );
  TTest.IsTrue( ((V4.Y > 3.99 ) and (V4.Y < 4.01)) );
  TTest.IsTrue( ((V4.Z > 5.99 ) and (V4.Z < 6.01)) );
  TTest.IsTrue( ((V4.W > 0.99 ) and (V4.W < 1.01)) );
end;

procedure TTestVector4Single.ExplicitV4V2;
var
  V4: sVector4;
  V2: sVector2;
begin
  // Arrange:
  V4 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := sVector2( V4 );
  // Assert:
  TTest.IsTrue( ((V2.X > 1.99 ) and (V2.X < 2.01)) );
  TTest.IsTrue( ((V2.Y > 3.99 ) and (V2.Y < 4.01)) );
end;

procedure TTestVector4Single.ExplicitV4V3;
var
  V4: sVector4;
  V3: sVector3;
begin
  // Arrange:
  V4 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V3 := sVector3( V4 );
  // Assert:
  TTest.IsTrue( ((V3.X > 1.99 ) and (V3.X < 2.01)) );
  TTest.IsTrue( ((V3.Y > 3.99 ) and (V3.Y < 4.01)) );
  TTest.IsTrue( ((V3.Z > 5.99 ) and (V3.Z < 6.01)) );
end;

procedure TTestVector4Single.ImplicitV2V4;
var
  V2: sVector2;
  V4: sVector4;
begin
  // Arrange:
  V2 := sVector2.Create( 2, 8 );
  // Act:
  V4 := V2;
  // Assert:
  TTest.IsTrue( ((V4.X > 1.99 )  and (V4.X < 2.01)) );
  TTest.IsTrue( ((V4.Y > 7.99 )  and (V4.Y < 8.01)) );
  TTest.IsTrue( ((V4.Z > -0.01 ) and (V4.Z < 0.01)) );
  TTest.IsTrue( ((V4.W > 0.99 )  and (V4.W < 1.01)) );
end;

procedure TTestVector4Single.ImplicitV3V4;
var
  V3: sVector3;
  V4: sVector4;
begin
  // Arrange:
  V3 := sVector3.Create( 2, 4, 6 );
  // Act:
  V4 := V3;
  // Assert:
  TTest.IsTrue( ((V4.X > 1.99 ) and (V4.X < 2.01)) );
  TTest.IsTrue( ((V4.Y > 3.99 ) and (V4.Y < 4.01)) );
  TTest.IsTrue( ((V4.Z > 5.99 ) and (V4.Z < 6.01)) );
  TTest.IsTrue( ((V4.W > 0.99 ) and (V4.W < 1.01)) );
end;

procedure TTestVector4Single.ImplicitV4V2;
var
  V4: sVector4;
  V2: sVector2;
begin
  // Arrange:
  V4 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V4;
  // Assert:
  TTest.IsTrue( ((V2.X > 1.99 ) and (V2.X < 2.01)) );
  TTest.IsTrue( ((V2.Y > 3.99 ) and (V2.Y < 4.01)) );
end;

procedure TTestVector4Single.ImplicitV4V3;
var
  V4: sVector4;
  V3: sVector3;
begin
  // Arrange:
  V4 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V3 := V4;
  // Assert:
  TTest.IsTrue( ((V3.X > 1.99 ) and (V3.X < 2.01)) );
  TTest.IsTrue( ((V3.Y > 3.99 ) and (V3.Y < 4.01)) );
  TTest.IsTrue( ((V3.Z > 5.99 ) and (V3.Z < 6.01)) );
end;

procedure TTestVector4Single.magnitude;
var
  V1: sVector4;
  F: single;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 9 );
  // Act:
  F := V1.magnitude; // 11.704699910
  // Assert:
  TTest.IsTrue( (F > 11.699 ) and (F < 11.705) );
end;

procedure TTestVector4Single.Multiply;
var
  V1, V2, V3: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  V2 := sVector4.Create( 3, 6, 9, 12 );
  // Act:
  V3 := V1 * V2;
  // Assert:
  TTest.IsTrue((V3.X > 5.99)  and (V3.X < 6.01));
  TTest.IsTrue((V3.Y > 23.99) and (V3.Y < 24.01));
  TTest.IsTrue((V3.Z > 53.99) and (V3.Z < 54.01));
  TTest.IsTrue((V3.W > 95.99) and (V3.W < 96.01));
end;

procedure TTestVector4Single.MultiplyAV;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 2, 1 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 3, 4 ];
  R := R * V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 3.99 ) and (R.X < 4.01)) );
  TTest.IsTrue( ((R.Y > 5.99 ) and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.Z > 5.99 ) and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.W > 3.99 ) and (R.W < 4.01)) );
end;

procedure TTestVector4Single.MultiplyF;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V1 * 3;
  // Assert:
  TTest.IsTrue((V2.X > 5.99)  and (V2.X < 6.01));
  TTest.IsTrue((V2.Y > 11.99) and (V2.Y < 12.01));
  TTest.IsTrue((V2.Z > 17.99) and (V2.Z < 18.01));
  TTest.IsTrue((V2.W > 23.99) and (V2.W < 24.01));
end;

procedure TTestVector4Single.MultiplyVA;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 2, 1 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 3, 4 ];
  R :=  V * R; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 3.99 ) and (R.X < 4.01)) );
  TTest.IsTrue( ((R.Y > 5.99 ) and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.Z > 5.99 ) and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.W > 3.99 ) and (R.W < 4.01)) );
end;


procedure TTestVector4Single.normalized;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 9 );
  // Act:
  V2 := V1.normalized; //- Magnitude = // 11.704699910
  // Assert:
  TTest.IsTrue((V2.X > 0.1707) and (V2.X < 0.1709));
  TTest.IsTrue((V2.Y > 0.3416) and (V2.Y < 0.3418));
  TTest.IsTrue((V2.Z > 0.5125) and (V2.Z < 0.5127));
  TTest.IsTrue((V2.W > 0.7688) and (V2.W < 0.7690));
end;

procedure TTestVector4Single.Subtract;
var
  V1, V2, V3: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 3, 6, 9, 12 );
  V2 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V3 := V1 - V2;
  // Assert:
  TTest.IsTrue((V3.X > 0.99) and (V3.X < 1.01));
  TTest.IsTrue((V3.Y > 1.99) and (V3.Y < 2.01));
  TTest.IsTrue((V3.Z > 2.99) and (V3.Z < 3.01));
  TTest.IsTrue((V3.W > 3.99) and (V3.W < 4.01));
end;

procedure TTestVector4Single.SubtractAV;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 2, 1 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 3, 4 ];
  R := R - V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 2.99 ) and (R.X < 3.01)) );
  TTest.IsTrue( ((R.Y > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.Z > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.W > 2.99 ) and (R.W < 3.01)) );
end;

procedure TTestVector4Single.SubtractF;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V1 - 3;
  // Assert:
  TTest.IsTrue((V2.X > -1.01) and (V2.X < -0.99));
  TTest.IsTrue((V2.Y > 0.99)  and (V2.Y < 1.01));
  TTest.IsTrue((V2.Z > 2.99)  and (V2.Z < 3.01));
  TTest.IsTrue((V2.W > 4.99)  and (V2.W < 5.01));
end;

procedure TTestVector4Single.SubtractVA;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 4, 3, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 1, 2, 2, 1 ];
  R := V - R; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 2.99 ) and (R.X < 3.01)) );
  TTest.IsTrue( ((R.Y > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.Z > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.W > 2.99 ) and (R.W < 3.01)) );
end;

initialization
  TestSuite.RegisterTestCase(TTestVector4Single);

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
unit testcase.cwvectors.svector4;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwVectors
;

type
  TTestVector4Single = class(TTestCase)
  published

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure AddVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure AddAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure SubtractVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure SubtractAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure MultiplyVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure MultiplyAV;

    ///  <summary>
    ///    Tests addition in which the left term is a vector and the right
    ///    term is an array of float. (Returns result as a vector)
    ///  </summary>
    procedure DivideVA;

    ///  <summary>
    ///    Tests addition in which the left term is an array of float and the
    ///    right term is a vector. (Returns result as a vector)
    ///  </summary>
    procedure DivideAV;

    ///  <summary>
    ///    Tests the assignment of an array of floats to a vector.
    ///  </summary>
    procedure ArrayAssign;

    ///  <summary>
    ///    Test the addition of one TVector4 to another TVector4
    ///  </summary>
    procedure Add;

    ///  <summary>
    ///    Test the addition of a float to a TVector4 (element-wise)
    ///  </summary>
    procedure AddF;

    ///  <summary>
    ///    Test the subtraction of a TVector4 from another TVector4.
    ///  </summary>
    procedure Subtract;

    ///  <summary>
    ///    Test the subtraction of a float from a TVector4 (element-wise).
    ///  </summary>
    procedure SubtractF;

    ///  <summary>
    ///    Test the multiplication of a TVector4 with another TVector4.
    ///    (Hadamard, element-wise)
    ///  </summary>
    procedure Multiply;

    ///  <summary>
    ///    Test the multiplication of a float with a TVector4
    ///    (element-wise, scale)
    ///  </summary>
    procedure MultiplyF;

    ///  <summary>
    ///    Test the division of a TVector4 by another TVector4.
    ///    (element-wise)
    ///  </summary>
    procedure Divide;

    ///  <summary>
    ///    Test the division of a TVector4 by a float.
    ///    (element-wise)
    ///  </summary>
    procedure DivideF;

    ///  <summary>
    ///    Test the implicit assignment of a TVector3 to a TVector4 where the
    ///    fourth element of the TVector4 is set to 1.0
    ///  </summary>
    procedure ImplicitV3V4;

    ///  <summary>
    ///    Test the explicit assignment of a TVector3 to a TVector4 where the
    ///    fourth element of the TVector4 is set to 1.0
    ///  </summary>
    procedure ExplicitV3V4;

    ///  <summary>
    ///    Test the implicit assignment of a TVector2 to a TVector4 where the
    ///    third element of the TVector4 is set to 0.0 and the fourth is set to
    ///    1.0.
    ///  </summary>
    procedure ImplicitV2V4;

    ///  <summary>
    ///    Test the explicit assignment of a TVector2 to a TVector4 where the
    ///    third element of the TVector4 is set to 0.0 and the fourth is set
    ///    to 1.0.
    ///  </summary>
    procedure ExplicitV2V4;

    ///  <summary>
    ///    Test the implicit assignment of a TVector4 to a TVector3 where the
    ///    fourth element of the TVector4 is dropped.
    ///  </summary>
    procedure ImplicitV4V3;

    ///  <summary>
    ///    Test the explicit assignment of a TVector4 to a TVector3 where the
    ///    fourth element of the TVector4 is dropped.
    ///  </summary>
    procedure ExplicitV4V3;

    ///  <summary>
    ///    Test the implicit assignment of a TVector4 to a TVector2 where the
    ///    third and fourth elements ot the TVector4 are dropped.
    ///  </summary>
    procedure ImplicitV4V2;

    ///  <summary>
    ///    Test the explicit assignment of a TVector4 to a TVector2 where the
    ///    third and fourth elements of the TVector4 are dropped.
    ///  </summary>
    procedure ExplicitV4V2;

    ///  <summary>
    ///    Test the creation of a TVector4 from four discreet float parameters.
    ///  </summary>
    procedure CreateXYZW;

    ///  <summary>
    ///    Test the dot product calculation of a TVector4 with another
    ///    TVector4.
    ///  </summary>
    procedure dot;

    ///  <summary>
    ///    Test the normalized calculation of a TVector4.
    ///  </summary>
    procedure normalized;

    ///  <summary>
    ///    Test the magnitude calculation of a TVector4.
    ///  </summary>
    procedure magnitude;
  end;


implementation
uses
  cwTest.Standard
;

procedure TTestVector4Single.Add;
var
  V1, V2, V3: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  V2 := sVector4.Create( 3, 6, 9, 12 );
  // Act:
  V3 := V1 + V2;
  // Assert:
  TTest.IsTrue((V3.X > 4.99)  and (V3.X < 5.01));
  TTest.IsTrue((V3.Y > 9.99)  and (V3.Y < 10.01));
  TTest.IsTrue((V3.Z > 14.99) and (V3.Z < 15.01));
  TTest.IsTrue((V3.W > 19.99) and (V3.W < 20.01));
end;

procedure TTestVector4Single.AddAV;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 2, 1 ];
  R := R + V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 4.99 ) and (R.X < 5.01)) );
  TTest.IsTrue( ((R.Y > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.Z > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.W > 4.99 ) and (R.W < 5.01)) );
end;

procedure TTestVector4Single.AddF;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V1 + 3;
  // Assert:
  TTest.IsTrue((V2.X > 4.99)  and (V2.X < 5.01));
  TTest.IsTrue((V2.Y > 6.99)  and (V2.Y < 7.01));
  TTest.IsTrue((V2.Z > 8.99)  and (V2.Z < 9.01));
  TTest.IsTrue((V2.W > 10.99) and (V2.W < 11.01));
end;

procedure TTestVector4Single.AddVA;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 2, 1 ];
  R := V + R; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 4.99 ) and (R.X < 5.01)) );
  TTest.IsTrue( ((R.Y > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.Z > 4.99 ) and (R.Y < 5.01)) );
  TTest.IsTrue( ((R.W > 4.99 ) and (R.W < 5.01)) );
end;

procedure TTestVector4Single.ArrayAssign;
var
  V: sVector4;
begin
  // Arrange:
  // Act:
  V := [1,2,3,4]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((V.X > 0.99 ) and (V.X < 1.01)) );
  TTest.IsTrue( ((V.Y > 1.99 ) and (V.Y < 2.01)) );
  TTest.IsTrue( ((V.Z > 2.99 ) and (V.Y < 3.01)) );
  TTest.IsTrue( ((V.W > 3.99 ) and (V.W < 4.01)) );
end;

procedure TTestVector4Single.CreateXYZW;
var
  V1: sVector4;
begin
  // Arrange:
  // Act:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Assert:
  TTest.IsTrue((V1.X > 1.99) and (V1.X < 2.01));
  TTest.IsTrue((V1.Y > 3.99) and (V1.Y < 4.01));
  TTest.IsTrue((V1.Z > 5.99) and (V1.Z < 6.01));
  TTest.IsTrue((V1.W > 7.99) and (V1.W < 8.01));
end;

procedure TTestVector4Single.Divide;
var
  V1, V2, V3: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 3, 6, 9, 12 );
  V2 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V3 := V1 / V2;
  // Assert:
  TTest.IsTrue((V3.X > 1.49) and (V3.X < 1.51));
  TTest.IsTrue((V3.Y > 1.49) and (V3.Y < 1.51));
  TTest.IsTrue((V3.Z > 1.49) and (V3.Z < 1.51));
  TTest.IsTrue((V3.W > 1.49) and (V3.W < 1.51));
end;

procedure TTestVector4Single.DivideAV;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 2, 1 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R :=  [ 4, 3, 3, 4 ];
  R := R / V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 3.99 ) and (R.X < 4.01)) );
  TTest.IsTrue( ((R.Y > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.Z > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.W > 3.99 ) and (R.W < 4.01)) );
end;

procedure TTestVector4Single.DivideF;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V1 / 2;
  // Assert:
  TTest.IsTrue((V2.X > 0.99) and (V2.X < 1.01));
  TTest.IsTrue((V2.Y > 1.99) and (V2.Y < 2.01));
  TTest.IsTrue((V2.Z > 2.99) and (V2.Z < 3.01));
  TTest.IsTrue((V2.W > 3.99) and (V2.W < 4.01));
end;

procedure TTestVector4Single.DivideVA;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 4, 3, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 1, 2, 2, 1 ];
  R :=  V / R; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 3.99 ) and (R.X < 4.01)) );
  TTest.IsTrue( ((R.Y > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.Z > 1.49 ) and (R.Y < 1.51)) );
  TTest.IsTrue( ((R.W > 3.99 ) and (R.W < 4.01)) );
end;

procedure TTestVector4Single.dot;
var
  V1, V2: sVector4;
  F: single;
begin
  // Arrange:
  V1 := sVector4.Create(5,6,3,8);
  V2 := sVector4.Create(2,3,5,4);
  // Act:
  F := V1.dot(V2);
  // Assert:
  TTest.IsTrue( ((F > 74.99 ) and (F < 75.01)) );
end;


procedure TTestVector4Single.ExplicitV2V4;
var
  V2: sVector2;
  V4: sVector4;
begin
  // Arrange:
  V2 := sVector2.Create( 2, 8 );
  // Act:
  V4 := sVector4( V2 );
  // Assert:
  TTest.IsTrue( ((V4.X > 1.99 )  and (V4.X < 2.01)) );
  TTest.IsTrue( ((V4.Y > 7.99 )  and (V4.Y < 8.01)) );
  TTest.IsTrue( ((V4.Z > -0.01 ) and (V4.Z < 0.01)) );
  TTest.IsTrue( ((V4.W > 0.99 )  and (V4.W < 1.01)) );
end;

procedure TTestVector4Single.ExplicitV3V4;
var
  V3: sVector3;
  V4: sVector4;
begin
  // Arrange:
  V3 := sVector3.Create( 2, 4, 6 );
  // Act:
  V4 := sVector4( V3 );
  // Assert:
  TTest.IsTrue( ((V4.X > 1.99 ) and (V4.X < 2.01)) );
  TTest.IsTrue( ((V4.Y > 3.99 ) and (V4.Y < 4.01)) );
  TTest.IsTrue( ((V4.Z > 5.99 ) and (V4.Z < 6.01)) );
  TTest.IsTrue( ((V4.W > 0.99 ) and (V4.W < 1.01)) );
end;

procedure TTestVector4Single.ExplicitV4V2;
var
  V4: sVector4;
  V2: sVector2;
begin
  // Arrange:
  V4 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := sVector2( V4 );
  // Assert:
  TTest.IsTrue( ((V2.X > 1.99 ) and (V2.X < 2.01)) );
  TTest.IsTrue( ((V2.Y > 3.99 ) and (V2.Y < 4.01)) );
end;

procedure TTestVector4Single.ExplicitV4V3;
var
  V4: sVector4;
  V3: sVector3;
begin
  // Arrange:
  V4 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V3 := sVector3( V4 );
  // Assert:
  TTest.IsTrue( ((V3.X > 1.99 ) and (V3.X < 2.01)) );
  TTest.IsTrue( ((V3.Y > 3.99 ) and (V3.Y < 4.01)) );
  TTest.IsTrue( ((V3.Z > 5.99 ) and (V3.Z < 6.01)) );
end;

procedure TTestVector4Single.ImplicitV2V4;
var
  V2: sVector2;
  V4: sVector4;
begin
  // Arrange:
  V2 := sVector2.Create( 2, 8 );
  // Act:
  V4 := V2;
  // Assert:
  TTest.IsTrue( ((V4.X > 1.99 )  and (V4.X < 2.01)) );
  TTest.IsTrue( ((V4.Y > 7.99 )  and (V4.Y < 8.01)) );
  TTest.IsTrue( ((V4.Z > -0.01 ) and (V4.Z < 0.01)) );
  TTest.IsTrue( ((V4.W > 0.99 )  and (V4.W < 1.01)) );
end;

procedure TTestVector4Single.ImplicitV3V4;
var
  V3: sVector3;
  V4: sVector4;
begin
  // Arrange:
  V3 := sVector3.Create( 2, 4, 6 );
  // Act:
  V4 := V3;
  // Assert:
  TTest.IsTrue( ((V4.X > 1.99 ) and (V4.X < 2.01)) );
  TTest.IsTrue( ((V4.Y > 3.99 ) and (V4.Y < 4.01)) );
  TTest.IsTrue( ((V4.Z > 5.99 ) and (V4.Z < 6.01)) );
  TTest.IsTrue( ((V4.W > 0.99 ) and (V4.W < 1.01)) );
end;

procedure TTestVector4Single.ImplicitV4V2;
var
  V4: sVector4;
  V2: sVector2;
begin
  // Arrange:
  V4 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V4;
  // Assert:
  TTest.IsTrue( ((V2.X > 1.99 ) and (V2.X < 2.01)) );
  TTest.IsTrue( ((V2.Y > 3.99 ) and (V2.Y < 4.01)) );
end;

procedure TTestVector4Single.ImplicitV4V3;
var
  V4: sVector4;
  V3: sVector3;
begin
  // Arrange:
  V4 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V3 := V4;
  // Assert:
  TTest.IsTrue( ((V3.X > 1.99 ) and (V3.X < 2.01)) );
  TTest.IsTrue( ((V3.Y > 3.99 ) and (V3.Y < 4.01)) );
  TTest.IsTrue( ((V3.Z > 5.99 ) and (V3.Z < 6.01)) );
end;

procedure TTestVector4Single.magnitude;
var
  V1: sVector4;
  F: single;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 9 );
  // Act:
  F := V1.magnitude; // 11.704699910
  // Assert:
  TTest.IsTrue( (F > 11.699 ) and (F < 11.705) );
end;

procedure TTestVector4Single.Multiply;
var
  V1, V2, V3: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  V2 := sVector4.Create( 3, 6, 9, 12 );
  // Act:
  V3 := V1 * V2;
  // Assert:
  TTest.IsTrue((V3.X > 5.99)  and (V3.X < 6.01));
  TTest.IsTrue((V3.Y > 23.99) and (V3.Y < 24.01));
  TTest.IsTrue((V3.Z > 53.99) and (V3.Z < 54.01));
  TTest.IsTrue((V3.W > 95.99) and (V3.W < 96.01));
end;

procedure TTestVector4Single.MultiplyAV;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 2, 1 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 3, 4 ];
  R := R * V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 3.99 ) and (R.X < 4.01)) );
  TTest.IsTrue( ((R.Y > 5.99 ) and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.Z > 5.99 ) and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.W > 3.99 ) and (R.W < 4.01)) );
end;

procedure TTestVector4Single.MultiplyF;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V1 * 3;
  // Assert:
  TTest.IsTrue((V2.X > 5.99)  and (V2.X < 6.01));
  TTest.IsTrue((V2.Y > 11.99) and (V2.Y < 12.01));
  TTest.IsTrue((V2.Z > 17.99) and (V2.Z < 18.01));
  TTest.IsTrue((V2.W > 23.99) and (V2.W < 24.01));
end;

procedure TTestVector4Single.MultiplyVA;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 2, 1 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 3, 4 ];
  R :=  V * R; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 3.99 ) and (R.X < 4.01)) );
  TTest.IsTrue( ((R.Y > 5.99 ) and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.Z > 5.99 ) and (R.Y < 6.01)) );
  TTest.IsTrue( ((R.W > 3.99 ) and (R.W < 4.01)) );
end;


procedure TTestVector4Single.normalized;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 9 );
  // Act:
  V2 := V1.normalized; //- Magnitude = // 11.704699910
  // Assert:
  TTest.IsTrue((V2.X > 0.1707) and (V2.X < 0.1709));
  TTest.IsTrue((V2.Y > 0.3416) and (V2.Y < 0.3418));
  TTest.IsTrue((V2.Z > 0.5125) and (V2.Z < 0.5127));
  TTest.IsTrue((V2.W > 0.7688) and (V2.W < 0.7690));
end;

procedure TTestVector4Single.Subtract;
var
  V1, V2, V3: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 3, 6, 9, 12 );
  V2 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V3 := V1 - V2;
  // Assert:
  TTest.IsTrue((V3.X > 0.99) and (V3.X < 1.01));
  TTest.IsTrue((V3.Y > 1.99) and (V3.Y < 2.01));
  TTest.IsTrue((V3.Z > 2.99) and (V3.Z < 3.01));
  TTest.IsTrue((V3.W > 3.99) and (V3.W < 4.01));
end;

procedure TTestVector4Single.SubtractAV;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 1, 2, 2, 1 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 4, 3, 3, 4 ];
  R := R - V; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 2.99 ) and (R.X < 3.01)) );
  TTest.IsTrue( ((R.Y > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.Z > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.W > 2.99 ) and (R.W < 3.01)) );
end;

procedure TTestVector4Single.SubtractF;
var
  V1, V2: sVector4;
begin
  // Arrange:
  V1 := sVector4.Create( 2, 4, 6, 8 );
  // Act:
  V2 := V1 - 3;
  // Assert:
  TTest.IsTrue((V2.X > -1.01) and (V2.X < -0.99));
  TTest.IsTrue((V2.Y > 0.99)  and (V2.Y < 1.01));
  TTest.IsTrue((V2.Z > 2.99)  and (V2.Z < 3.01));
  TTest.IsTrue((V2.W > 4.99)  and (V2.W < 5.01));
end;

procedure TTestVector4Single.SubtractVA;
var
  V: sVector4;
  R: sVector4;
begin
  // Arrange:
  V := [ 4, 3, 3, 4 ]; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Act:
  R := [ 1, 2, 2, 1 ];
  R := V - R; // FPC Bug [0035061] https://bugs.freepascal.org/view.php?id=35061 RESOLVED
  // Assert:
  TTest.IsTrue( ((R.X > 2.99 ) and (R.X < 3.01)) );
  TTest.IsTrue( ((R.Y > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.Z > 0.99 ) and (R.Y < 1.01)) );
  TTest.IsTrue( ((R.W > 2.99 ) and (R.W < 3.01)) );
end;

initialization
  TestSuite.RegisterTestCase(TTestVector4Single);

end.
>>>>>>> 6c4801d2dc5041f543a87f07704a36d49a557ce1:src/dependencies/cwRuntime/src/tests/cwVectors/testcase.cwvectors.svector4.pas
