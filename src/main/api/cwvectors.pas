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
///  <summary>
///    Library for handling vector/matrix operations in cpu.
///  </summary>
unit cwVectors;
{$ifdef fpc}
  {$mode delphiunicode}
//- Delphi insists on parsing the following conditional, despite {$ifdef fpc} above.
//- So had to comment the conditional, will cause warning for earlier FPC versions which
//- do not support modeswitch arrayoperators.
//  {$if (FPC_VERSION>=3) and (FPC_RELEASE>=2)}
    {$modeswitch arrayoperators-}
//  {$endif}
{$endif}

interface
uses
  cwTypes
;

const
  stInvalidArrayForVector = '{2A1282A4-320C-4905-97E8-0E1E5FD85285} The provided array was not the correct size for the vecotr.';

type

{$region ' sVector2'}

  /// <summary>
  ///   Represents a single-precision vector with 2 elements (X,Y / U,V)
  /// </summary>
  sVector2 = record

    /// <summary>
    ///   Assigns an array of two single precision floats to an sVector2.
    ///   <code lang="Delphi"> MyVector := [ 3.5, 4.5 ]; </code>
    /// </summary>
    /// <param name="a">
    ///   An array of two single-precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   two, a logged exception is raised with status stInvalidArrayForVector
    ///   (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (two elements)
    /// </remarks>
    class operator Explicit( const a: array of single ): sVector2;

    /// <summary>
    ///   Assigns an array of two single precision floats to an sVector2. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two single-precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   two, a logged exception is raised with status stInvalidArrayForVector
    ///   (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (two elements)
    /// </remarks>
    class operator Implicit( const a: array of single ): sVector2;

    /// <summary>
    ///   Adds an array of two single precision floating point values to an
    ///   sVector2 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of two single-precision floats to be added to the the vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: sVector2; const b: array of single ): sVector2; overload;

    /// <summary>
    ///   Adds an sVector2 to an array of two single precision floats for
    ///   assignment to an sVector2 in an element wise addition operation. <br /><br /><code lang="Delphi">MyVectorA := [ 1.2, 1.3 ] + MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two single-precision floats to which the vector 'b' will
    ///   be added.
    /// </param>
    /// <param name="b">
    ///   The sVector2 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of single; const b: sVector2 ): sVector2; overload;

    /// <summary>
    ///   Subtracts an array of two single precision floats from an sVector2
    ///   for assignment to an sVector2 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - [ 1.2, 1.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of two single-precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: sVector2; const b: array of single ): sVector2;

    /// <summary>
    ///   Subtracts an sVector2 from an array of two single precision floats
    ///   for assignment to an sVector2 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 1.2, 1.3 ] - MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two single-precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The sVector2 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the subtraction of vector
    ///   'b' from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of single; const b: sVector2 ): sVector2;

    /// <summary>
    ///   Multiplies an sVector2 by an array of two single precision floats for
    ///   assignment to an sVector2, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.0 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector2 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of two single precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: sVector2; const b: array of single ): sVector2;

    /// <summary>
    ///   Multiplies an array of two single precision floats by an sVector2 for
    ///   assignment to an sVector2, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.0 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two single precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector2 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of single; const b: sVector2 ): sVector2;

    /// <summary>
    ///   Divides an sVector2 by an array of two single precision floats for
    ///   assignment to an sVector2, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.0 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector2 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of two single precision floats by which the vector 'a' will
    ///   be divided.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the division of vector 'a'
    ///   by the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: sVector2; const b: array of single ): sVector2;

    /// <summary>
    ///   Divides an array of two single precision floats by an sVector2 for
    ///   assignment to an sVector2, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.0 ] / MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two single precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector2 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the division of the array
    ///   'a' by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of single; const b: sVector2 ): sVector2;

    /// <summary>
    ///   Adds an sVector2 to another sVector2 for assignment to an sVector2,
    ///   in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An sVector2 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the addition of vector 'b'
    ///   to vector 'a'.
    /// </returns>
    class operator Add( const a: sVector2; const b: sVector2 ): sVector2;

    /// <summary>
    ///   Adds a single precision float to each element of a vector for
    ///   assignment to an sVector2. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 to which the single 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A single precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the addition of single 'b'
    ///   to the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: sVector2; const b: single ): sVector2;

    /// <summary>
    ///   Subtracts an sVector2 from another sVector2 for assignment to an
    ///   sVector2, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   An sVector2 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the subtraction of vector
    ///   'b' from vector 'a'.
    /// </returns>
    class operator Subtract( const a: sVector2; const b: sVector2 ): sVector2;

    /// <summary>
    ///   Subtracts a single precision float from each element of a vector for
    ///   assignment to an sVector2. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 from which the single 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A single precision float to be subtracted from the elements of vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the subtraction of single
    ///   'b' from the elements of vector 'a'.
    /// </returns>
    class operator Subtract(const a: sVector2; const b: single ): sVector2;

    /// <summary>
    ///   Multiplies an sVector2 by an sVector2 for assignment to an sVector2
    ///   in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector2 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: sVector2; const b: sVector2 ): sVector2;

    /// <summary>
    ///   Multiplies an sVector2 by a single precision float for assignment to
    ///   an sVector2 in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 which will be multiplied by the the single 'b'.
    /// </param>
    /// <param name="b">
    ///   A single precision float by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the multiplication of vector
    ///   'a' by single 'b'.
    /// </returns>
    class operator Multiply( const a: sVector2; const b: single ): sVector2;

    /// <summary>
    ///   Divides an sVector2 by an sVector2 for assignment to an sVector2 in
    ///   an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector2 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the division of vector 'a'
    ///   by vector 'b'.
    /// </returns>
    class operator Divide( const a: sVector2; const b: sVector2 ): sVector2;

    /// <summary>
    ///   Divides an sVector2 by a single precision float for assignment to an
    ///   sVector2 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector2 which will be divided by the the single 'b'.
    /// </param>
    /// <param name="b">
    ///   A single precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector2 which contains the result of the division of vector 'a'
    ///   by single 'b'.
    /// </returns>
    class operator Divide( const a: sVector2; const b: single ): sVector2;

    /// <summary>
    ///   Returns an sVector2 containing the parameter values X and Y, in that
    ///   order. <br /><br /><code lang="Delphi">MyVector := sVector2.Create( 1.0, 2.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   An sVector2 containing the two values supplied as parameters.
    /// </returns>
    class function Create( const X: single; const Y: single ): sVector2; overload; static;

    /// <summary>
    ///   Returns the dot product of this sVector2 with another sVector2. <br /><br /><code lang="Delphi">S := VectorA.Dot( VectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector2 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A single precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: sVector2 ): single;

    /// <summary>
    ///   Returns the Normal vector of this vector. <br /><code lang="Delphi">NormalVector := SomeVector.Normalized;</code>
    /// </summary>
    /// <returns>
    ///   An sVector2 containing the normal of this vector.
    /// </returns>
    function Normalized: sVector2;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   An sVector2 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: sVector2;

    /// <summary>
    ///   <para>
    ///     Returns the magnitude of the vector.
    ///   </para>
    ///   <para>
    ///     M := VectorA.Magnitude;
    ///   </para>
    /// </summary>
    function Magnitude: single;

    case uint8 of
      0: (
        X: single;
        Y: single;
      );
      1: (
        U: single;
        V: single;
      );
      2: (
        S: single;
        T: single;
      );
  end;
{$endregion}

{$region ' dVector2'}

  /// <summary>
  ///   Represents a double-precision vector with 2 elements (X,Y / U,V)
  /// </summary>
  dVector2 = record

    /// <summary>
    ///   Assigns an array of two double precision floats to a dVector2.
    ///   <code lang="Delphi">MyVector := [ 3.5, 4.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two double precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   two, a logged exception is raised with status stInvalidArrayForVector
    ///   (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (two elements)
    /// </remarks>
    class operator Explicit( const a: array of double ): dVector2;

    /// <summary>
    ///   Assigns an array of two double precision floats to a dVector2. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two double precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   two, a logged exception is raised with status stInvalidArrayForVector
    ///   (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (two elements)
    /// </remarks>
    class operator Implicit( const a: array of double ): dVector2;

    /// <summary>
    ///   Adds an array of two double precision floating point values to a
    ///   dVector2 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of two double precision floats to be added to the the vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: dVector2; const b: array of double ): dVector2; overload;

    /// <summary>
    ///   Adds a dVector2 to an array of two double precision floats for
    ///   assignment to a dVector2 in an element wise addition operation. <br /><br /><code lang="Delphi">MyVectorA := [ 1.2, 1.3 ] - MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two double precision floats to which the vector 'b' will
    ///   be added.
    /// </param>
    /// <param name="b">
    ///   The dVector2 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of double; const b: dVector2 ): dVector2; overload;

    /// <summary>
    ///   Subtracts an array of two double precision floats from a dVector2 for
    ///   assignment to a dVector2 in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - [ 1.2, 1.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of two double precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: dVector2; const b: array of double ): dVector2;

    /// <summary>
    ///   Subtracts a dVector2 from an array of two double precision floats for
    ///   assignment to a dVector2 in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := [ 1.2, 1.3 ] - MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two double precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The dVector2 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the subtraction of vector 'b'
    ///   from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of double; const b: dVector2 ): dVector2;

    /// <summary>
    ///   Multiplies a dVector2 by an array of two double precision floats for
    ///   assignment to a dVector2, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.0 ];</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector2 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of two double precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: dVector2; const b: array of double ): dVector2;

    /// <summary>
    ///   Multiplies an array of two double precision floats by a dVector2 for
    ///   assignment to a dVector2, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.0 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two double precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector2 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of double; const b: dVector2 ): dVector2;

    /// <summary>
    ///   Divides a dVector2 by an array of two double precision floats for
    ///   assignment to a dVector2, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.0 ];</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector2 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of two double precision floats by which the vector 'a' will
    ///   be divided.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the division of vector 'a' by
    ///   the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: dVector2; const b: array of double ): dVector2;

    /// <summary>
    ///   Divides an array of two double precision floats by a dVector2 for
    ///   assignment to a dVector2, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.0 ] / MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two double precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector2 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the division of the array 'a'
    ///   by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of double; const b: dVector2 ): dVector2;

    /// <summary>
    ///   Adds a dVector2 to another dVector2 for assignment to a dVector2, in
    ///   an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A dVector2 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the addition of vector 'b' to
    ///   vector 'a'.
    /// </returns>
    class operator Add( const a: dVector2; const b: dVector2 ): dVector2;

    /// <summary>
    ///   Adds a double precision float to each element of a vector for
    ///   assignment to a dVector2. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 to which the double 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A double precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the addition of double 'b' to
    ///   the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: dVector2; const b: double ): dVector2;

    /// <summary>
    ///   Subtracts a dVector2 from another dVector2 for assignment to a
    ///   dVector2, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A dVector2 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the subtraction of vector 'b'
    ///   from vector 'a'.
    /// </returns>
    class operator Subtract( const a: dVector2; const b: dVector2 ): dVector2;

    /// <summary>
    ///   Subtracts a double precision float from each element of a vector for
    ///   assignment to a dVector2. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 from which the double 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A double precision float to be subtracted from the elements of vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the subtraction of double 'b'
    ///   from the elements of vector 'a'.
    /// </returns>
    class operator Subtract(const a: dVector2; const b: double ): dVector2;

    /// <summary>
    ///   Multiplies an dVector2 by a dVector2 for assignment to a dVector2 in
    ///   an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector2 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: dVector2; const b: dVector2 ): dVector2;

    /// <summary>
    ///   Multiplies a dVector2 by a double precision float for assignment to a
    ///   dVector2 in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 which will be multiplied by the the double 'b'.
    /// </param>
    /// <param name="b">
    ///   A double precision float by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the multiplication of vector
    ///   'a' by double 'b'.
    /// </returns>
    class operator Multiply( const a: dVector2; const b: double ): dVector2;

    /// <summary>
    ///   Divides a dVector2 by a dVector2 for assignment to a dVector2 in an
    ///   element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector2 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the division of vector 'a' by
    ///   vector 'b'.
    /// </returns>
    class operator Divide( const a: dVector2; const b: dVector2 ): dVector2;

    /// <summary>
    ///   Divides a dVector2 by a double precision float for assignment to a
    ///   dVector2 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector2 which will be divided by the the double 'b'.
    /// </param>
    /// <param name="b">
    ///   A double precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector2 which contains the result of the division of vector 'a' by
    ///   double 'b'.
    /// </returns>
    class operator Divide( const a: dVector2; const b: double ): dVector2;

    /// <summary>
    ///   Returns an dVector2 containing the parameter values X and Y, in that
    ///   order. <br /><br /><br /><code lang="Delphi">MyVector := dVector2.Create( 1.0, 2.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   A dVector2 containing the two values supplied as parameters.
    /// </returns>
    class function Create( const X: double; const Y: double ): dVector2; overload; static;

    /// <summary>
    ///   Returns the dot product of this dVector2 with another dVector2.
    ///   <code lang="Delphi">D := VectorA.Dot( VectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector2 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A double precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: dVector2 ): double;

    /// <summary>
    ///   Returns the Normal vector of this vector.
    ///   <code lang="Delphi">NormalVector := SomeVector.Normalize;</code>
    /// </summary>
    /// <returns>
    ///   A dVector2 containing the normal of this vector.
    /// </returns>
    function Normalized: dVector2;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   A dVector2 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: dVector2;

    /// <summary>
    ///   Returns the magnitude of the vector.
    ///   <code lang="Delphi">M := SomeVector.Magnitude;</code>
    /// </summary>
    function Magnitude: double;

    case uint8 of
      0: (
        X: double;
        Y: double;
      );
      1: (
        U: double;
        V: double;
      );
      2: (
        S: double;
        T: double;
      );
  end;
{$endregion}

{$region ' eVector2'}

  /// <summary>
  ///   Represents a extended precision vector with 2 elements (X,Y / U,V)
  /// </summary>
  eVector2 = record

    /// <summary>
    ///   Assigns an array of two extended precision floats to an eVector2.
    ///   <code lang="Delphi">MyVector := [ 3.5, 4.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two extended-precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   two, a logged exception is raised with status stInvalidArrayForVector
    ///   (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (two elements)
    /// </remarks>
    class operator Explicit( const a: array of extended ): eVector2;

    /// <summary>
    ///   Assigns an array of two extended precision floats to an eVector2. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two extended-precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   two, a logged exception is raised with status stInvalidArrayForVector
    ///   (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (two elements)
    /// </remarks>
    class operator Implicit( const a: array of extended ): eVector2;

    /// <summary>
    ///   Adds an array of two extended precision floating point values to an
    ///   eVector2 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of two extended-precision floats to be added to the the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: eVector2; const b: array of extended ): eVector2; overload;

    /// <summary>
    ///   Adds an eVector2 to an array of two extended precision floats for
    ///   assignment to an eVector2 in an element wise addition operation. <br /><br /><code lang="Delphi">MyVectorA := [ 1.2, 1.3 ] + MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two extended-precision floats to which the vector 'b'
    ///   will be added.
    /// </param>
    /// <param name="b">
    ///   The eVector2 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of extended; const b: eVector2 ): eVector2; overload;

    /// <summary>
    ///   Subtracts an array of two extended precision floats from an eVector2
    ///   for assignment to an eVector2 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - [ 1.2, 1.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of two extended-precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: eVector2; const b: array of extended ): eVector2;

    /// <summary>
    ///   Subtracts an eVector2 from an array of two extended precision floats
    ///   for assignment to an eVector2 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 1.2, 1.3 ] - MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two extended-precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The eVector2 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the subtraction of vector
    ///   'b' from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of extended; const b: eVector2 ): eVector2;

    /// <summary>
    ///   Multiplies an eVector2 by an array of two extended precision floats
    ///   for assignment to an eVector2, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.0 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector2 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of two extended precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: eVector2; const b: array of extended ): eVector2;

    /// <summary>
    ///   Multiplies an array of two extended precision floats by an eVector2
    ///   for assignment to an eVector2, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.0 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two extended precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector2 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of extended; const b: eVector2 ): eVector2;

    /// <summary>
    ///   Divides an eVector2 by an array of two extended precision floats for
    ///   assignment to an eVector2, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.0 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector2 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of two extended precision floats by which the vector 'a'
    ///   will be divided.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the division of vector 'a'
    ///   by the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: eVector2; const b: array of extended ): eVector2;

    /// <summary>
    ///   Divides an array of two extended precision floats by an eVector2 for
    ///   assignment to an eVector2, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.0 ] / MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of two extended precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector2 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the division of the array
    ///   'a' by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of two, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of extended; const b: eVector2 ): eVector2;

    /// <summary>
    ///   Adds an eVector2 to another eVector2 for assignment to an eVector2,
    ///   in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An eVector2 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the addition of vector 'b'
    ///   to vector 'a'.
    /// </returns>
    class operator Add( const a: eVector2; const b: eVector2 ): eVector2;

    /// <summary>
    ///   Adds a extended precision float to each element of a vector for
    ///   assignment to an eVector2. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 to which the extended 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A extended precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the addition of extended 'b'
    ///   to the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: eVector2; const b: extended ): eVector2;

    /// <summary>
    ///   Subtracts an eVector2 from another eVector2 for assignment to an
    ///   eVector2, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   An eVector2 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the subtraction of vector
    ///   'b' from vector 'a'.
    /// </returns>
    class operator Subtract( const a: eVector2; const b: eVector2 ): eVector2;

    /// <summary>
    ///   Subtracts a extended precision float from each element of a vector
    ///   for assignment to an eVector2. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 from which the extended 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A extended precision float to be subtracted from the elements of
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the subtraction of extended
    ///   'b' from the elements of vector 'a'.
    /// </returns>
    class operator Subtract(const a: eVector2; const b: extended ): eVector2;

    /// <summary>
    ///   Multiplies an eVector2 by an eVector2 for assignment to an eVector2
    ///   in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector2 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: eVector2; const b: eVector2 ): eVector2;

    /// <summary>
    ///   Multiplies an eVector2 by a extended precision float for assignment
    ///   to an eVector2 in an element wise (hadamard) multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 which will be multiplied by the the extended 'b'.
    /// </param>
    /// <param name="b">
    ///   A extended precision float by which the vector 'a' will be
    ///   multiplied.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the multiplication of vector
    ///   'a' by extended 'b'.
    /// </returns>
    class operator Multiply( const a: eVector2; const b: extended ): eVector2;

    /// <summary>
    ///   Divides an eVector2 by an eVector2 for assignment to an eVector2 in
    ///   an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector2 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the division of vector 'a'
    ///   by vector 'b'.
    /// </returns>
    class operator Divide( const a: eVector2; const b: eVector2 ): eVector2;

    /// <summary>
    ///   Divides an eVector2 by a extended precision float for assignment to
    ///   an eVector2 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector2 which will be divided by the the extended 'b'.
    /// </param>
    /// <param name="b">
    ///   A extended precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector2 which contains the result of the division of vector 'a'
    ///   by extended 'b'.
    /// </returns>
    class operator Divide( const a: eVector2; const b: extended ): eVector2;

    /// <summary>
    ///   Returns an eVector2 containing the parameter values X and Y, in that
    ///   order. <br /><br /><br /><code lang="Delphi">MyVector := eVector2.Create( 1.0, 2.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   An eVector2 containing the two values supplied as parameters.
    /// </returns>
    class function Create( const X: extended; const Y: extended ): eVector2; overload; static;

    /// <summary>
    ///   Returns the dot product of this eVector2 with another eVector2.
    ///   <code lang="Delphi">E := MyVectorA.Dot( MyVectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector2 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A extended precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: eVector2 ): extended;

    /// <summary>
    ///   Returns the Normal vector of this vector.
    ///   <code lang="Delphi">NormalVector := SomeVector.Normalized;</code>
    /// </summary>
    /// <returns>
    ///   An eVector2 containing the normal of this vector.
    /// </returns>
    function Normalized: eVector2;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   An eVector2 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: eVector2;

    /// <summary>
    ///   Returns the magnitude of the vector.
    ///   <code lang="Delphi">M := SomeVector.Magnitude;</code>
    /// </summary>
    function Magnitude: extended;

    case uint8 of
      0: (
        X: extended;
        Y: extended;
      );
      1: (
        U: extended;
        V: extended;
      );
      2: (
        S: extended;
        T: extended;
      );
  end;
{$endregion}

{$region ' sVector3'}


  /// <summary>
  ///   Represents a single precision vector with three elements (X,Y,Z / R,G,B)
  /// </summary>
  sVector3 = record

    /// <summary>
    ///   Assigns an array of three single precision floats to an sVector3.
    ///   <code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three single precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   three, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (three elements)
    /// </remarks>
    class operator Implicit( const a: array of single ): sVector3;

    /// <summary>
    ///   Assigns an array of three single precision floats to an sVector3. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three single precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   three, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (three elements)
    /// </remarks>
    class operator Explicit( const a: array of single ): sVector3;

    /// <summary>
    ///   Adds an array of three single precision floating point values to an
    ///   sVector3 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3, 1.4 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of three single precision floats to be added to the the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: sVector3; const b: array of single ): sVector3;

    /// <summary>
    ///   Adds an sVector3 to an array of three single precision floats for
    ///   assignment to an sVector3 in an element wise addition operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4 ] + MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three single precision floats to which the vector 'b'
    ///   will be added.
    /// </param>
    /// <param name="b">
    ///   The sVector3 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of single; const b: sVector3 ): sVector3;

    /// <summary>
    ///   Subtracts an array of three single precision floats from an sVector3
    ///   for assignment to an sVector3 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := MyVector - [ 1.2, 1.3, 1.4 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of three single-precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: sVector3; const b: array of single ): sVector3;

    /// <summary>
    ///   Subtracts an sVector3 from an array of three single precision floats
    ///   for assignment to an sVector3 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4 ] - MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three single-precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The sVector3 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the subtraction of vector
    ///   'b' from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of single; const b: sVector3 ): sVector3;

    /// <summary>
    ///   Multiplies an sVector3 by an array of three single precision floats
    ///   for assignment to an sVector3, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.1, 2.2 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector3 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of three single precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: sVector3; const b: array of single ): sVector3;

    /// <summary>
    ///   Multiplies an array of three single precision floats by an sVector3
    ///   for assignment to an sVector3, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three single precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector3 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of single; const b: sVector3 ): sVector3;

    /// <summary>
    ///   Divides an sVector3 by an array of three single precision floats for
    ///   assignment to an sVector3, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.1, 2.2 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector3 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of three single precision floats by which the vector 'a'
    ///   will be divided.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the division of vector 'a'
    ///   by the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: sVector3; const b: array of single ): sVector3;

    /// <summary>
    ///   Divides an array of three single precision floats by an sVector3 for
    ///   assignment to an sVector3, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2 ] / MyVectorA;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three single precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector3 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the division of the array
    ///   'a' by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of single; const b: sVector3 ): sVector3;

    /// <summary>
    ///   Adds an sVector3 to another sVector3 for assignment to an sVector3,
    ///   in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An sVector3 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the addition of vector 'b'
    ///   to vector 'a'.
    /// </returns>
    class operator Add( const a: sVector3; const b: sVector3 ): sVector3;

    /// <summary>
    ///   Adds a single precision float to each element of a vector for
    ///   assignment to an sVector3. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 to which the single 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A single precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the addition of single 'b'
    ///   to the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: sVector3; const b: single ): sVector3;

    /// <summary>
    ///   Subtracts an sVector3 from another sVector3 for assignment to an
    ///   sVector3, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   An sVector3 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the subtraction of vector
    ///   'b' from vector 'a'.
    /// </returns>
    class operator Subtract( const a: sVector3; const b: sVector3 ): sVector3;

    /// <summary>
    ///   Subtracts a single precision float from each element of a vector for
    ///   assignment to an sVector3. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 from which the single 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A single precision float to be subtracted from the elements of vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the subtraction of single
    ///   'b' from the elements of vector 'a'.
    /// </returns>
    class operator Subtract( const a: sVector3; const b: single ): sVector3;

    /// <summary>
    ///   Multiplies an sVector3 by an sVector3 for assignment to an sVector3
    ///   in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector3 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: sVector3; const b: sVector3 ): sVector3;

    /// <summary>
    ///   Multiplies an sVector3 by a single precision float for assignment to
    ///   an sVector3 in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 which will be multiplied by the the single 'b'.
    /// </param>
    /// <param name="b">
    ///   A single precision float by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the multiplication of vector
    ///   'a' by single 'b'.
    /// </returns>
    class operator Multiply( const a: sVector3; const b: single ): sVector3;

    /// <summary>
    ///   Divides an sVector3 by an sVector3 for assignment to an sVector3 in
    ///   an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector3 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the division of vector 'a'
    ///   by vector 'b'.
    /// </returns>
    class operator Divide( const a: sVector3; const b: sVector3 ): sVector3;

    /// <summary>
    ///   Divides an sVector3 by a single precision float for assignment to an
    ///   sVector3 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector3 which will be divided by the the single 'b'.
    /// </param>
    /// <param name="b">
    ///   A single precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector3 which contains the result of the division of vector 'a'
    ///   by single 'b'.
    /// </returns>
    class operator Divide( const a: sVector3; const b: single ): sVector3;

    /// <summary>
    ///   Assigns an sVector3 from an sVector2 while setting the Z element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector3;
    ///   VectorB: sVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: sVector2 ): sVector3;

    /// <summary>
    ///   Assigns an sVector3 from an sVector2 while setting the Z element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector3;
    ///   VectorB: sVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: sVector2 ): sVector3;

    /// <summary>
    ///   Assigns an sVector2 from an sVector3, dropping the Z value.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector2;
    ///   VectorB: sVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: sVector3 ): sVector2;

    /// <summary>
    ///   Assigns an sVector2 from an sVector3, dropping the Z value.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector2;
    ///   VectorB: sVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: sVector3 ): sVector2;

    /// <summary>
    ///   Returns an sVector3 containing the parameter values X and Y, in that
    ///   order.
    ///   <code lang="Delphi">MyVectorA := sVector3.Create( 1.0, 2.0, 3.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   An sVector3 containing the three values supplied as parameters.
    /// </returns>
    class function Create( const X: single; const Y: single; const Z: single ): sVector3; overload; static;

    /// <summary>
    ///   Returns the dot product of this sVector3 with another sVector3.
    ///   <code lang="Delphi">S := VectorA.Dot( VectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector3 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A single precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: sVector3 ): single;

    /// <summary>
    ///   Returns the cross product of this vector with another and returns an
    ///   sVector3 for assignment.
    ///   <code lang="Delphi">CrossVector := MyVectorA.Cross( MyVectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   The vector providing the right hand side of a dot product operation.
    /// </param>
    /// <returns>
    ///   A vector containing the result of cross product computation between
    ///   'this' vector and the 'a' vector.
    /// </returns>
    function Cross( const a: sVector3 ): sVector3;

    /// <summary>
    ///   Returns the Normal vector of this vector.
    ///   <code lang="Delphi">NormalVector := SomeVector.Normalized;</code>
    /// </summary>
    /// <returns>
    ///   An sVector3 containing the normal of this vector.
    /// </returns>
    function Normalized: sVector3;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   An sVector3 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: sVector3;

    /// <summary>
    ///   Returns the magnitude of the vector.
    ///   <code lang="Delphi">M := SomeVector.Magnitude;</code>
    /// </summary>
    function Magnitude: single;

      case uint8 of
      0: (
          X: single;
          Y: single;
          Z: single;
      );
      1: (
          R: single;
          G: single;
          B: single;
      );
  end;

  ///  <summary>
  ///    An alias of sVector3 which represents a point in 3d space.
  ///   (Single Precision Vertex)
  ///  </summary>
  sVertex = sVector3;
{$endregion}

{$region ' dVector3'}

  /// <summary>
  ///   Represents a double precision vector with three elements (X,Y,Z / R,G,B)
  /// </summary>
  dVector3 = record

    /// <summary>
    ///   Assigns an array of three double precision floats to a dVector3.
    ///   <code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three double precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   three, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (three elements)
    /// </remarks>
    class operator Implicit( const a: array of double ): dVector3;

    /// <summary>
    ///   Assigns an array of three double precision floats to a dVector3. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three double precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   three, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (three elements)
    /// </remarks>
    class operator Explicit( const a: array of double ): dVector3;

    /// <summary>
    ///   Adds an array of three double precision floating point values to an
    ///   dVector3 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3, 1.4 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of three double precision floats to be added to the the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: dVector3; const b: array of double ): dVector3;

    /// <summary>
    ///   Adds a dVector3 to an array of three double precision floats for
    ///   assignment to a dVector3 in an element wise addition operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4 ] + MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three double precision floats to which the vector 'b'
    ///   will be added.
    /// </param>
    /// <param name="b">
    ///   The dVector3 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of double; const b: dVector3 ): dVector3;

    /// <summary>
    ///   Subtracts an array of three double precision floats from a dVector3
    ///   for assignment to a dVector3 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := MyVector - [ 1.2, 1.3, 1.4 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of three double-precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: dVector3; const b: array of double ): dVector3;

    /// <summary>
    ///   Subtracts a dVector3 from an array of three double precision floats
    ///   for assignment to a dVector3 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4 ] - MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three double-precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The dVector3 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the subtraction of vector
    ///   'b' from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of double; const b: dVector3 ): dVector3;

    /// <summary>
    ///   Multiplies a dVector3 by an array of three double precision floats
    ///   for assignment to a dVector3, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.1, 2.2 ];</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector3 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of three double precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: dVector3; const b: array of double ): dVector3;

    /// <summary>
    ///   Multiplies an array of three double precision floats by a dVector3
    ///   for assignment to a dVector3, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three double precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector3 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of double; const b: dVector3 ): dVector3;

    /// <summary>
    ///   Divides A dVector3 by an array of three double precision floats for
    ///   assignment to a dVector3, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.1, 2.2 ];</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector3 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of three double precision floats by which the vector 'a'
    ///   will be divided.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the division of vector 'a'
    ///   by the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: dVector3; const b: array of double ): dVector3;

    /// <summary>
    ///   Divides an array of three double precision floats by a dVector3 for
    ///   assignment to a dVector3, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2 ] / MyVectorA;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three double precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector3 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the division of the array
    ///   'a' by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of double; const b: dVector3 ): dVector3;

    /// <summary>
    ///   Adds a dVector3 to another dVector3 for assignment to a dVector3,
    ///   in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A dVector3 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the addition of vector 'b'
    ///   to vector 'a'.
    /// </returns>
    class operator Add( const a: dVector3; const b: dVector3 ): dVector3;

    /// <summary>
    ///   Adds a double precision float to each element of a vector for
    ///   assignment to a dVector3. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 to which the double 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A double precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the addition of double 'b'
    ///   to the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: dVector3; const b: double ): dVector3;

    /// <summary>
    ///   Subtracts a dVector3 from another dVector3 for assignment to an
    ///   dVector3, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A dVector3 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the subtraction of vector
    ///   'b' from vector 'a'.
    /// </returns>
    class operator Subtract( const a: dVector3; const b: dVector3 ): dVector3;

    /// <summary>
    ///   Subtracts a double precision float from each element of a vector for
    ///   assignment to a dVector3. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 from which the double 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A double precision float to be subtracted from the elements of vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the subtraction of double
    ///   'b' from the elements of vector 'a'.
    /// </returns>
    class operator Subtract( const a: dVector3; const b: double ): dVector3;

    /// <summary>
    ///   Multiplies a dVector3 by a dVector3 for assignment to a dVector3
    ///   in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector3 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: dVector3; const b: dVector3 ): dVector3;

    /// <summary>
    ///   Multiplies a dVector3 by a double precision float for assignment to
    ///   a dVector3 in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 which will be multiplied by the the double 'b'.
    /// </param>
    /// <param name="b">
    ///   A double precision float by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the multiplication of vector
    ///   'a' by double 'b'.
    /// </returns>
    class operator Multiply( const a: dVector3; const b: double ): dVector3;

    /// <summary>
    ///   Divides a dVector3 by a dVector3 for assignment to a dVector3 in
    ///   an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector3 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the division of vector 'a'
    ///   by vector 'b'.
    /// </returns>
    class operator Divide( const a: dVector3; const b: dVector3 ): dVector3;

    /// <summary>
    ///   Divides a dVector3 by a double precision float for assignment to an
    ///   dVector3 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector3 which will be divided by the the double 'b'.
    /// </param>
    /// <param name="b">
    ///   A double precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector3 which contains the result of the division of vector 'a'
    ///   by double 'b'.
    /// </returns>
    class operator Divide( const a: dVector3; const b: double ): dVector3;

    /// <summary>
    ///   Assigns a dVector3 from an dVector2 while setting the Z element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector3;
    ///   VectorB: dVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: dVector2 ): dVector3;

    /// <summary>
    ///   Assigns a dVector3 from an dVector2 while setting the Z element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector3;
    ///   VectorB: dVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: dVector2 ): dVector3;

    /// <summary>
    ///   Assigns an dVector2 from a dVector3, dropping the Z value.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector2;
    ///   VectorB: dVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: dVector3 ): dVector2;

    /// <summary>
    ///   Assigns an dVector2 from a dVector3, dropping the Z value.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector2;
    ///   VectorB: dVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: dVector3 ): dVector2;

    /// <summary>
    ///   Returns a dVector3 containing the parameter values X and Y, in that
    ///   order.
    ///   <code lang="Delphi">MyVectorA := dVector3.Create( 1.0, 2.0, 3.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   A dVector3 containing the three values supplied as parameters.
    /// </returns>
    class function Create( const X: double; const Y: double; const Z: double ): dVector3; overload; static;

    /// <summary>
    ///   Returns the dot product of this dVector3 with another dVector3.
    ///   <code lang="Delphi">S := VectorA.Dot( VectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector3 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A double precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: dVector3 ): double;

    /// <summary>
    ///   Returns the cross product of this vector with another and returns an
    ///   dVector3 for assignment.
    ///   <code lang="Delphi">CrossVector := MyVectorA.Cross( MyVectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   The vector providing the right hand side of a dot product operation.
    /// </param>
    /// <returns>
    ///   A vector containing the result of cross product computation between
    ///   'this' vector and the 'a' vector.
    /// </returns>
    function Cross( const a: dVector3 ): dVector3;

    /// <summary>
    ///   Returns the Normal vector of this vector.
    ///   <code lang="Delphi">NormalVector := SomeVector.Normalized;</code>
    /// </summary>
    /// <returns>
    ///   A dVector3 containing the normal of this vector.
    /// </returns>
    function Normalized: dVector3;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   A dVector3 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: dVector3;

    /// <summary>
    ///   Returns the magnitude of the vector.
    ///   <code lang="Delphi">M := SomeVector.Magnitude;</code>
    /// </summary>
    function Magnitude: double;

      case uint8 of
      0: (
          X: double;
          Y: double;
          Z: double;
      );
      1: (
          R: double;
          G: double;
          B: double;
      );
  end;

  ///  <summary>
  ///    An alias of dVector3 which represents a point in 3d space.
  ///   (Double Precision Vertex)
  ///  </summary>
  dVertex = dVector3;
{$endregion}

{$region ' eVector3'}

  /// <summary>
  ///   Represents a extended precision vector with three elements (X,Y,Z / R,G,B)
  /// </summary>
  eVector3 = record

    /// <summary>
    ///   Assigns an array of three extended precision floats to an eVector3.
    ///   <code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three extended precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   three, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (three elements)
    /// </remarks>
    class operator Implicit( const a: array of extended ): eVector3;

    /// <summary>
    ///   Assigns an array of three extended precision floats to an eVector3. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three extended precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   three, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (three elements)
    /// </remarks>
    class operator Explicit( const a: array of extended ): eVector3;

    /// <summary>
    ///   Adds an array of three extended precision floating point values to an
    ///   eVector3 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3, 1.4 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of three extended precision floats to be added to the the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: eVector3; const b: array of extended ): eVector3;

    /// <summary>
    ///   Adds an eVector3 to an array of three extended precision floats for
    ///   assignment to an eVector3 in an element wise addition operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4 ] + MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three extended precision floats to which the vector 'b'
    ///   will be added.
    /// </param>
    /// <param name="b">
    ///   The eVector3 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of extended; const b: eVector3 ): eVector3;

    /// <summary>
    ///   Subtracts an array of three extended precision floats from an eVector3
    ///   for assignment to an eVector3 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := MyVector - [ 1.2, 1.3, 1.4 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of three extended-precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: eVector3; const b: array of extended ): eVector3;

    /// <summary>
    ///   Subtracts an eVector3 from an array of three extended precision floats
    ///   for assignment to an eVector3 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4 ] - MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three extended-precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The eVector3 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the subtraction of vector
    ///   'b' from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of extended; const b: eVector3 ): eVector3;

    /// <summary>
    ///   Multiplies an eVector3 by an array of three extended precision floats
    ///   for assignment to an eVector3, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.1, 2.2 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector3 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of three extended precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: eVector3; const b: array of extended ): eVector3;

    /// <summary>
    ///   Multiplies an array of three extended precision floats by an eVector3
    ///   for assignment to an eVector3, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three extended precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector3 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of extended; const b: eVector3 ): eVector3;

    /// <summary>
    ///   Divides an eVector3 by an array of three extended precision floats for
    ///   assignment to an eVector3, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.1, 2.2 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector3 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of three extended precision floats by which the vector 'a'
    ///   will be divided.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the division of vector 'a'
    ///   by the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: eVector3; const b: array of extended ): eVector3;

    /// <summary>
    ///   Divides an array of three extended precision floats by an eVector3 for
    ///   assignment to an eVector3, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2 ] / MyVectorA;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of three extended precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector3 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the division of the array
    ///   'a' by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of three, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of extended; const b: eVector3 ): eVector3;

    /// <summary>
    ///   Adds an eVector3 to another eVector3 for assignment to an eVector3,
    ///   in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An eVector3 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the addition of vector 'b'
    ///   to vector 'a'.
    /// </returns>
    class operator Add( const a: eVector3; const b: eVector3 ): eVector3;

    /// <summary>
    ///   Adds a extended precision float to each element of a vector for
    ///   assignment to an eVector3. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 to which the extended 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A extended precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the addition of extended 'b'
    ///   to the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: eVector3; const b: extended ): eVector3;

    /// <summary>
    ///   Subtracts an eVector3 from another eVector3 for assignment to an
    ///   eVector3, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   An eVector3 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the subtraction of vector
    ///   'b' from vector 'a'.
    /// </returns>
    class operator Subtract( const a: eVector3; const b: eVector3 ): eVector3;

    /// <summary>
    ///   Subtracts a extended precision float from each element of a vector for
    ///   assignment to an eVector3. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 from which the extended 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A extended precision float to be subtracted from the elements of vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the subtraction of extended
    ///   'b' from the elements of vector 'a'.
    /// </returns>
    class operator Subtract( const a: eVector3; const b: extended ): eVector3;

    /// <summary>
    ///   Multiplies an eVector3 by an eVector3 for assignment to an eVector3
    ///   in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector3 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: eVector3; const b: eVector3 ): eVector3;

    /// <summary>
    ///   Multiplies an eVector3 by a extended precision float for assignment to
    ///   an eVector3 in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 which will be multiplied by the the extended 'b'.
    /// </param>
    /// <param name="b">
    ///   A extended precision float by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the multiplication of vector
    ///   'a' by extended 'b'.
    /// </returns>
    class operator Multiply( const a: eVector3; const b: extended ): eVector3;

    /// <summary>
    ///   Divides an eVector3 by an eVector3 for assignment to an eVector3 in
    ///   an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector3 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the division of vector 'a'
    ///   by vector 'b'.
    /// </returns>
    class operator Divide( const a: eVector3; const b: eVector3 ): eVector3;

    /// <summary>
    ///   Divides an eVector3 by a extended precision float for assignment to an
    ///   eVector3 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector3 which will be divided by the the extended 'b'.
    /// </param>
    /// <param name="b">
    ///   A extended precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector3 which contains the result of the division of vector 'a'
    ///   by extended 'b'.
    /// </returns>
    class operator Divide( const a: eVector3; const b: extended ): eVector3;

    /// <summary>
    ///   Assigns an eVector3 from an eVector2 while setting the Z element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector3;
    ///   VectorB: eVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: eVector2 ): eVector3;

    /// <summary>
    ///   Assigns an eVector3 from an eVector2 while setting the Z element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector3;
    ///   VectorB: eVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: eVector2 ): eVector3;

    /// <summary>
    ///   Assigns an eVector2 from an eVector3, dropping the Z value.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector2;
    ///   VectorB: eVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: eVector3 ): eVector2;

    /// <summary>
    ///   Assigns an eVector2 from an eVector3, dropping the Z value.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector2;
    ///   VectorB: eVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: eVector3 ): eVector2;

    /// <summary>
    ///   Returns an eVector3 containing the parameter values X and Y, in that
    ///   order.
    ///   <code lang="Delphi">MyVectorA := eVector3.Create( 1.0, 2.0, 3.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   An eVector3 containing the three values supplied as parameters.
    /// </returns>
    class function Create( const X: extended; const Y: extended; const Z: extended ): eVector3; overload; static;

    /// <summary>
    ///   Returns the dot product of this eVector3 with another eVector3.
    ///   <code lang="Delphi">S := VectorA.Dot( VectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector3 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A extended precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: eVector3 ): extended;

    /// <summary>
    ///   Returns the cross product of this vector with another and returns an
    ///   eVector3 for assignment.
    ///   <code lang="Delphi">CrossVector := MyVectorA.Cross( MyVectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   The vector providing the right hand side of a dot product operation.
    /// </param>
    /// <returns>
    ///   A vector containing the result of cross product computation between
    ///   'this' vector and the 'a' vector.
    /// </returns>
    function Cross( const a: eVector3 ): eVector3;

    /// <summary>
    ///   Returns the Normal vector of this vector.
    ///   <code lang="Delphi">NormalVector := SomeVector.Normalized;</code>
    /// </summary>
    /// <returns>
    ///   An eVector3 containing the normal of this vector.
    /// </returns>
    function Normalized: eVector3;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   An eVector3 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: eVector3;

    /// <summary>
    ///   Returns the magnitude of the vector.
    ///   <code lang="Delphi">M := SomeVector.Magnitude;</code>
    /// </summary>
    function Magnitude: extended;

      case uint8 of
      0: (
          X: extended;
          Y: extended;
          Z: extended;
      );
      1: (
          R: extended;
          G: extended;
          B: extended;
      );
  end;

  ///  <summary>
  ///    An alias of eVector3 which represents a point in 3d space.
  ///   (Extended Precision Vertex)
  ///  </summary>
  eVertex = eVector3;
{$endregion}

{$region ' sVector4'}
  /// <summary>
  ///   Represents a single precision vector with four elements (X,Y,Z,W or R,G,B,A or U1,V1,U2,V2)
  /// </summary>
  sVector4 = record

    /// <summary>
    ///   Assigns an array of four single precision floats to an sVector4.
    ///   <code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5, 6.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four single precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   four, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (four elements)
    /// </remarks>
    class operator Implicit( const a: array of single ): sVector4;

    /// <summary>
    ///   Assigns an array of four single precision floats to an sVector4. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5, 6.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four single precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   four, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (four elements)
    /// </remarks>
    class operator Explicit( const a: array of single ): sVector4;

    /// <summary>
    ///   Adds an array of four single precision floating point values to an
    ///   sVector4 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3, 1.4, 1.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of four single precision floats to be added to the the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: sVector4; const b: array of single ): sVector4;

    /// <summary>
    ///   Adds an sVector4 to an array of four single precision floats for
    ///   assignment to an sVector4 in an element wise addition operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4, 1.5 ] + MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four single precision floats to which the vector 'b' will
    ///   be added.
    /// </param>
    /// <param name="b">
    ///   The sVector4 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of single; const b: sVector4 ): sVector4;

    /// <summary>
    ///   Subtracts an array of four single precision floats from an sVector4
    ///   for assignment to an sVector4 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := MyVector - [ 1.2, 1.3, 1.4, 1.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of four single-precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: sVector4; const b: array of single ): sVector4;

    /// <summary>
    ///   Subtracts an sVector4 from an array of four single precision floats
    ///   for assignment to an sVector4 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4, 1.5 ] - MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four single-precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The sVector4 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the subtraction of vector
    ///   'b' from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of single; const b: sVector4 ): sVector4;

    /// <summary>
    ///   Multiplies an sVector4 by an array of four single precision floats
    ///   for assignment to an sVector4, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.1, 2.2, 2.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector4 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of four single precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: sVector4; const b: array of single ): sVector4;

    /// <summary>
    ///   Multiplies an array of four single precision floats by an sVector4
    ///   for assignment to an sVector4, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2, 2.3 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four single precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector4 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of single; const b: sVector4 ): sVector4;

    /// <summary>
    ///   Divides an sVector4 by an array of four single precision floats for
    ///   assignment to an sVector4, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.1, 2.2, 2.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector4 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of four single precision floats by which the vector 'a' will
    ///   be divided.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the division of vector 'a'
    ///   by the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: sVector4; const b: array of single ): sVector4;

    /// <summary>
    ///   Divides an array of four single precision floats by an sVector4 for
    ///   assignment to an sVector4, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2, 2.3 ] / MyVectorA;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four single precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector4 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the division of the array
    ///   'a' by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of single; const b: sVector4 ): sVector4;

    /// <summary>
    ///   Adds an sVector4 to another sVector4 for assignment to an sVector4,
    ///   in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An sVector4 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the addition of vector 'b'
    ///   to vector 'a'.
    /// </returns>
    class operator Add( const a: sVector4; const b: sVector4 ): sVector4;

    /// <summary>
    ///   Adds a single precision float to each element of a vector for
    ///   assignment to an sVector4. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 to which the single 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A single precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the addition of single 'b'
    ///   to the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: sVector4; const b: single ): sVector4;

    /// <summary>
    ///   Subtracts an sVector4 from another sVector4 for assignment to an
    ///   sVector4, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   An sVector4 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the subtraction of vector
    ///   'b' from vector 'a'.
    /// </returns>
    class operator Subtract( const a: sVector4; const b: sVector4 ): sVector4;

    /// <summary>
    ///   Subtracts a single precision float from each element of a vector for
    ///   assignment to an sVector4. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 from which the single 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A single precision float to be subtracted from the elements of vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the subtraction of single
    ///   'b' from the elements of vector 'a'.
    /// </returns>
    class operator Subtract( const a: sVector4; const b: single ): sVector4;

    /// <summary>
    ///   Multiplies an sVector4 by an sVector4 for assignment to an sVector4
    ///   in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector4 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: sVector4; const b: sVector4 ): sVector4;

    /// <summary>
    ///   Multiplies an sVector4 by a single precision float for assignment to
    ///   an sVector4 in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 which will be multiplied by the the single 'b'.
    /// </param>
    /// <param name="b">
    ///   A single precision float by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the multiplication of vector
    ///   'a' by single 'b'.
    /// </returns>
    class operator Multiply( const a: sVector4; const b: single ): sVector4;

    /// <summary>
    ///   Divides an sVector4 by an sVector4 for assignment to an sVector4 in
    ///   an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An sVector4 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the division of vector 'a'
    ///   by vector 'b'.
    /// </returns>
    class operator Divide( const a: sVector4; const b: sVector4 ): sVector4;

    /// <summary>
    ///   Divides an sVector4 by a single precision float for assignment to an
    ///   sVector4 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The sVector4 which will be divided by the the single 'b'.
    /// </param>
    /// <param name="b">
    ///   A single precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An sVector4 which contains the result of the division of vector 'a'
    ///   by single 'b'.
    /// </returns>
    class operator Divide( const a: sVector4; const b: single ): sVector4;

    /// <summary>
    ///   Assigns an sVector4 from an sVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector4;
    ///   VectorB: sVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: sVector3 ): sVector4;

    /// <summary>
    ///   Assigns an sVector4 from an sVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector4;
    ///   VectorB: sVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: sVector3 ): sVector4;

    /// <summary>
    ///   Assigns an sVector4 from an sVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector4;
    ///   VectorB: sVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: sVector2 ): sVector4;

    /// <summary>
    ///   Assigns an sVector4 from an sVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector4;
    ///   VectorB: sVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: sVector2 ): sVector4;

    /// <summary>
    ///   Assigns an sVector3 from an sVector4 dropping the W element.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector4;
    ///   VectorB: sVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: sVector4 ): sVector3;

    /// <summary>
    ///   Assigns an sVector3 from an sVector4 dropping the W element.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector4;
    ///   VectorB: sVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: sVector4 ): sVector3;

    /// <summary>
    ///   Assigns an sVector2 from an sVector4 dropping the Z and W elements.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector4;
    ///   VectorB: sVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: sVector4 ): sVector2;

    /// <summary>
    ///   Assigns an sVector2 from an sVector4 dropping the Z and W elements.
    ///   <code lang="Delphi">var
    ///   VectorA: sVector4;
    ///   VectorB: sVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: sVector4 ): sVector2;

    /// <summary>
    ///   Returns an sVector4 containing the parameter values X and Y, in that
    ///   order.
    ///   <code lang="Delphi">MyVectorA := sVector4.Create( 1.0, 2.0, 3.0, 4.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   An sVector4 containing the four values supplied as parameters.
    /// </returns>
    class function Create( const X: single; const Y: single; const Z: single; const W: single ): sVector4; overload; static;

    /// <summary>
    ///   Returns the dot product of this sVector4 with another sVector4.
    ///   <code lang="Delphi">S := VectorA.Dot( VectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   An sVector4 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A single precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: sVector4 ): single;

    /// <summary>
    ///   Returns the Normal vector of this vector.
    ///   <code lang="Delphi">NormalVector := SomeVector.Normalized;</code>
    /// </summary>
    /// <returns>
    ///   An sVector4 containing the normal of this vector.
    /// </returns>
    function Normalized: sVector4;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   An sVector4 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: sVector4;

    /// <summary>
    ///   Returns the Magnitude of the vector.
    ///   <code lang="Delphi">M := SomeVector.Magnitude;</code>
    /// </summary>
    function Magnitude: single;

      case uint8 of
      0: (
          X: single;
          Y: single;
          Z: single;
          W: single;
      );
      1: (
          R: single;
          G: single;
          B: single;
          A: single;
      );
      2: (
          U1: single;
          V1: single;
          U2: single;
          V2: single;
      );
  end;

{$endregion}

{$region ' dVector4'}
  /// <summary>
  ///   Represents a double precision vector with four elements (X,Y,Z,W or R,G,B,A or U1,V1,U2,V2)
  /// </summary>
  dVector4 = record

    /// <summary>
    ///   Assigns an array of four double precision floats to a dVector4.
    ///   <code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5, 6.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four double precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   four, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (four elements)
    /// </remarks>
    class operator Implicit( const a: array of double ): dVector4;

    /// <summary>
    ///   Assigns an array of four double precision floats to a dVector4. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5, 6.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four double precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   four, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (four elements)
    /// </remarks>
    class operator Explicit( const a: array of double ): dVector4;

    /// <summary>
    ///   Adds an array of four double precision floating point values to an
    ///   dVector4 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3, 1.4, 1.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of four double precision floats to be added to the the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: dVector4; const b: array of double ): dVector4;

    /// <summary>
    ///   Adds a dVector4 to an array of four double precision floats for
    ///   assignment to a dVector4 in an element wise addition operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4, 1.5 ] + MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four double precision floats to which the vector 'b' will
    ///   be added.
    /// </param>
    /// <param name="b">
    ///   The dVector4 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of double; const b: dVector4 ): dVector4;

    /// <summary>
    ///   Subtracts an array of four double precision floats from a dVector4
    ///   for assignment to a dVector4 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := MyVector - [ 1.2, 1.3, 1.4, 1.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of four double-precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: dVector4; const b: array of double ): dVector4;

    /// <summary>
    ///   Subtracts a dVector4 from an array of four double precision floats
    ///   for assignment to a dVector4 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4, 1.5 ] - MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four double-precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The dVector4 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the subtraction of vector
    ///   'b' from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of double; const b: dVector4 ): dVector4;

    /// <summary>
    ///   Multiplies a dVector4 by an array of four double precision floats
    ///   for assignment to a dVector4, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.1, 2.2, 2.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector4 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of four double precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: dVector4; const b: array of double ): dVector4;

    /// <summary>
    ///   Multiplies an array of four double precision floats by a dVector4
    ///   for assignment to a dVector4, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2, 2.3 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four double precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector4 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of double; const b: dVector4 ): dVector4;

    /// <summary>
    ///   Divides a dVector4 by an array of four double precision floats for
    ///   assignment to a dVector4, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.1, 2.2, 2.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector4 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of four double precision floats by which the vector 'a' will
    ///   be divided.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the division of vector 'a'
    ///   by the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: dVector4; const b: array of double ): dVector4;

    /// <summary>
    ///   Divides an array of four double precision floats by a dVector4 for
    ///   assignment to a dVector4, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2, 2.3 ] / MyVectorA;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four double precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector4 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the division of the array
    ///   'a' by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of double; const b: dVector4 ): dVector4;

    /// <summary>
    ///   Adds a dVector4 to another dVector4 for assignment to a dVector4,
    ///   in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A dVector4 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the addition of vector 'b'
    ///   to vector 'a'.
    /// </returns>
    class operator Add( const a: dVector4; const b: dVector4 ): dVector4;

    /// <summary>
    ///   Adds a double precision float to each element of a vector for
    ///   assignment to a dVector4. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 to which the double 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A double precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the addition of double 'b'
    ///   to the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: dVector4; const b: double ): dVector4;

    /// <summary>
    ///   Subtracts a dVector4 from another dVector4 for assignment to an
    ///   dVector4, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A dVector4 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the subtraction of vector
    ///   'b' from vector 'a'.
    /// </returns>
    class operator Subtract( const a: dVector4; const b: dVector4 ): dVector4;

    /// <summary>
    ///   Subtracts a double precision float from each element of a vector for
    ///   assignment to a dVector4. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 from which the double 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A double precision float to be subtracted from the elements of vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the subtraction of double
    ///   'b' from the elements of vector 'a'.
    /// </returns>
    class operator Subtract( const a: dVector4; const b: double ): dVector4;

    /// <summary>
    ///   Multiplies a dVector4 by a dVector4 for assignment to a dVector4
    ///   in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector4 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: dVector4; const b: dVector4 ): dVector4;

    /// <summary>
    ///   Multiplies a dVector4 by a double precision float for assignment to
    ///   a dVector4 in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 which will be multiplied by the the double 'b'.
    /// </param>
    /// <param name="b">
    ///   A double precision float by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the multiplication of vector
    ///   'a' by double 'b'.
    /// </returns>
    class operator Multiply( const a: dVector4; const b: double ): dVector4;

    /// <summary>
    ///   Divides a dVector4 by a dVector4 for assignment to a dVector4 in
    ///   an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   A dVector4 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the division of vector 'a'
    ///   by vector 'b'.
    /// </returns>
    class operator Divide( const a: dVector4; const b: dVector4 ): dVector4;

    /// <summary>
    ///   Divides a dVector4 by a double precision float for assignment to an
    ///   dVector4 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The dVector4 which will be divided by the the double 'b'.
    /// </param>
    /// <param name="b">
    ///   A double precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   A dVector4 which contains the result of the division of vector 'a'
    ///   by double 'b'.
    /// </returns>
    class operator Divide( const a: dVector4; const b: double ): dVector4;

    /// <summary>
    ///   Assigns a dVector4 from a dVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector4;
    ///   VectorB: dVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: dVector3 ): dVector4;

    /// <summary>
    ///   Assigns a dVector4 from a dVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector4;
    ///   VectorB: dVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: dVector3 ): dVector4;

    /// <summary>
    ///   Assigns a dVector4 from a dVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector4;
    ///   VectorB: dVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: dVector2 ): dVector4;

    /// <summary>
    ///   Assigns a dVector4 from a dVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector4;
    ///   VectorB: dVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: dVector2 ): dVector4;

    /// <summary>
    ///   Assigns a dVector3 from a dVector4 dropping the W element.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector4;
    ///   VectorB: dVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: dVector4 ): dVector3;

    /// <summary>
    ///   Assigns a dVector3 from a dVector4 dropping the W element.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector4;
    ///   VectorB: dVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: dVector4 ): dVector3;

    /// <summary>
    ///   Assigns a dVector2 from a dVector4 dropping the Z and W elements.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector4;
    ///   VectorB: dVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: dVector4 ): dVector2;

    /// <summary>
    ///   Assigns a dVector2 from a dVector4 dropping the Z and W elements.
    ///   <code lang="Delphi">var
    ///   VectorA: dVector4;
    ///   VectorB: dVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: dVector4 ): dVector2;

    /// <summary>
    ///   Returns a dVector4 containing the parameter values X and Y, in that
    ///   order.
    ///   <code lang="Delphi">MyVectorA := dVector4.Create( 1.0, 2.0, 3.0, 4.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   A dVector4 containing the four values supplied as parameters.
    /// </returns>
    class function Create( const X: double; const Y: double; const Z: double; const W: double ): dVector4; overload; static;

    /// <summary>
    ///   Returns the dot product of this dVector4 with another dVector4.
    ///   <code lang="Delphi">S := VectorA.Dot( VectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   A dVector4 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A double precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: dVector4 ): double;

    /// <summary>
    ///   Returns the Normal vector of this vector.
    ///   <code lang="Delphi">NormalVector := SomeVector.Normalized;</code>
    /// </summary>
    /// <returns>
    ///   A dVector4 containing the normal of this vector.
    /// </returns>
    function normalized: dVector4;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   A dVector4 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: dVector4;

    /// <summary>
    ///   Returns the Magnitude of the vector.
    ///   <code lang="Delphi">M := SomeVector.Magnitude;</code>
    /// </summary>
    function magnitude: double;

      case uint8 of
      0: (
          X: double;
          Y: double;
          Z: double;
          W: double;
      );
      1: (
          R: double;
          G: double;
          B: double;
          A: double;
      );
      2: (
          U1: double;
          V1: double;
          U2: double;
          V2: double;
      );
  end;

{$endregion}

{$region ' eVector4'}
  /// <summary>
  ///   Represents a extended precision vector with four elements (X,Y,Z,W or R,G,B,A or U1,V1,U2,V2)
  /// </summary>
  eVector4 = record

    /// <summary>
    ///   Assigns an array of four extended precision floats to an eVector4.
    ///   <code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5, 6.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four extended precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   four, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (four elements)
    /// </remarks>
    class operator Implicit( const a: array of extended ): eVector4;

    /// <summary>
    ///   Assigns an array of four extended precision floats to an eVector4. <br /><code lang="Delphi">MyVector := [ 3.5, 4.5, 5.5, 6.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four extended precision floating point values to assign to
    ///   the vector.
    /// </param>
    /// <returns>
    ///   The vector is returned with it's elements set to those provided in
    ///   the array.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   When the array of floats to be assigned does not have a length of
    ///   four, a logged exception is raised with status
    ///   stInvalidArrayForVector (Invalid array for vector).
    /// </exception>
    /// <remarks>
    ///   The length of the array must match size of vector (four elements)
    /// </remarks>
    class operator Explicit( const a: array of extended ): eVector4;

    /// <summary>
    ///   Adds an array of four extended precision floating point values to an
    ///   eVector4 in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + [ 1.2, 1.3, 1.4, 1.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 to which the values of the array 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An array of four extended precision floats to be added to the the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of addition of the array 'b' to
    ///   the vector 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: eVector4; const b: array of extended ): eVector4;

    /// <summary>
    ///   Adds an eVector4 to an array of four extended precision floats for
    ///   assignment to an eVector4 in an element wise addition operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4, 1.5 ] + MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four extended precision floats to which the vector 'b' will
    ///   be added.
    /// </param>
    /// <param name="b">
    ///   The eVector4 which will be added to the array 'b'.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the addition of the vector
    ///   'b' to the array 'a'. <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Add( const a: array of extended; const b: eVector4 ): eVector4;

    /// <summary>
    ///   Subtracts an array of four extended precision floats from an eVector4
    ///   for assignment to an eVector4 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := MyVector - [ 1.2, 1.3, 1.4, 1.5 ];</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 from which the values of the array 'b' will be
    ///   subtracted.
    /// </param>
    /// <param name="b">
    ///   An array of four extended-precision floats to be subtracted from the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the subtraction of the array
    ///   'b' from the vector 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: eVector4; const b: array of extended ): eVector4;

    /// <summary>
    ///   Subtracts an eVector4 from an array of four extended precision floats
    ///   for assignment to an eVector4 in an element wise subtraction
    ///   operation. <br /><code lang="Delphi">MyVector := [ 1.2, 1.3, 1.4, 1.5 ] - MyVector;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four extended-precision floats from which the vector 'b'
    ///   will be subtracted.
    /// </param>
    /// <param name="b">
    ///   The eVector4 which will be subtracted from the array 'a'.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the subtraction of vector
    ///   'b' from the array 'a'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Subtract( const a: array of extended; const b: eVector4 ): eVector4;

    /// <summary>
    ///   Multiplies an eVector4 by an array of four extended precision floats
    ///   for assignment to an eVector4, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * [ 2.0, 2.1, 2.2, 2.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector4 which will be multiplied by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of four extended precision floats to be multiplied with the
    ///   vector 'a'.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the multiplication of the
    ///   vector 'a' with the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: eVector4; const b: array of extended ): eVector4;

    /// <summary>
    ///   Multiplies an array of four extended precision floats by an eVector4
    ///   for assignment to an eVector4, in an element wise multiplication
    ///   operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2, 2.3 ] * MyVectorB;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four extended precision floats to be multiplied with the
    ///   vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector4 which will be multiplied by the array 'b'.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the multiplication of the
    ///   array 'a' with the vector 'b' <br />
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Multiply( const a: array of extended; const b: eVector4 ): eVector4;

    /// <summary>
    ///   Divides an eVector4 by an array of four extended precision floats for
    ///   assignment to an eVector4, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / [ 2.0, 2.1, 2.2, 2.3 ];</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector4 which will be divided by the array 'b'.
    /// </param>
    /// <param name="b">
    ///   An array of four extended precision floats by which the vector 'a' will
    ///   be divided.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the division of vector 'a'
    ///   by the array 'b'
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: eVector4; const b: array of extended ): eVector4;

    /// <summary>
    ///   Divides an array of four extended precision floats by an eVector4 for
    ///   assignment to an eVector4, in an element wise division operation. <br /><code lang="Delphi">MyVectorA := [ 2.0, 2.1, 2.2, 2.3 ] / MyVectorA;</code>
    /// </summary>
    /// <param name="a">
    ///   An array of four extended precision floats to be divided by the vector
    ///   'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector4 by which the array 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the division of the array
    ///   'a' by the vector 'b'.
    /// </returns>
    /// <exception cref="TLoggedException">
    ///   If the array of floats does not have a length of four, a logged
    ///   exception is raised with status stInvalidArrayForVector (Invalid
    ///   array for vector).
    /// </exception>
    class operator Divide( const a: array of extended; const b: eVector4 ): eVector4;

    /// <summary>
    ///   Adds an eVector4 to another eVector4 for assignment to an eVector4,
    ///   in an element wise addition operation. <br /><code lang="Delphi">MyVectorA := MyVectorB + MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 to which the vector 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   An eVector4 for addition to the vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the addition of vector 'b'
    ///   to vector 'a'.
    /// </returns>
    class operator Add( const a: eVector4; const b: eVector4 ): eVector4;

    /// <summary>
    ///   Adds a extended precision float to each element of a vector for
    ///   assignment to an eVector4. <br /><code lang="Delphi">MyVectorA := MyVectorB + 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 to which the extended 'b' will be added.
    /// </param>
    /// <param name="b">
    ///   A extended precision float to be added to the elements of vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the addition of extended 'b'
    ///   to the elements of vector 'a'.
    /// </returns>
    class operator Add( const a: eVector4; const b: extended ): eVector4;

    /// <summary>
    ///   Subtracts an eVector4 from another eVector4 for assignment to an
    ///   eVector4, in an element wise subtraction operation. <br /><code lang="Delphi">MyVectorA := MyVectorB - MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 from which the vector 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   An eVector4 for subtraction from the vector 'a'
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the subtraction of vector
    ///   'b' from vector 'a'.
    /// </returns>
    class operator Subtract( const a: eVector4; const b: eVector4 ): eVector4;

    /// <summary>
    ///   Subtracts a extended precision float from each element of a vector for
    ///   assignment to an eVector4. <br /><code lang="Delphi">MyVectorA := MyVectorB - 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 from which the extended 'b' will be subtracted.
    /// </param>
    /// <param name="b">
    ///   A extended precision float to be subtracted from the elements of vector
    ///   'a'.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the subtraction of extended
    ///   'b' from the elements of vector 'a'.
    /// </returns>
    class operator Subtract( const a: eVector4; const b: extended ): eVector4;

    /// <summary>
    ///   Multiplies an eVector4 by an eVector4 for assignment to an eVector4
    ///   in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 which will be multiplied by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector4 by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the multiplication of vector
    ///   'a' by vector 'b'.
    /// </returns>
    class operator Multiply( const a: eVector4; const b: eVector4 ): eVector4;

    /// <summary>
    ///   Multiplies an eVector4 by a extended precision float for assignment to
    ///   an eVector4 in an element wise (hadamard) multiplication operation. <br /><code lang="Delphi">MyVectorA := MyVectorB * 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 which will be multiplied by the the extended 'b'.
    /// </param>
    /// <param name="b">
    ///   A extended precision float by which the vector 'a' will be multiplied.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the multiplication of vector
    ///   'a' by extended 'b'.
    /// </returns>
    class operator Multiply( const a: eVector4; const b: extended ): eVector4;

    /// <summary>
    ///   Divides an eVector4 by an eVector4 for assignment to an eVector4 in
    ///   an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / MyVectorC;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 which will be divided by the the vector 'b'.
    /// </param>
    /// <param name="b">
    ///   An eVector4 by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the division of vector 'a'
    ///   by vector 'b'.
    /// </returns>
    class operator Divide( const a: eVector4; const b: eVector4 ): eVector4;

    /// <summary>
    ///   Divides an eVector4 by a extended precision float for assignment to an
    ///   eVector4 in an element wise division operation. <br /><code lang="Delphi">MyVectorA := MyVectorB / 6.2;</code>
    /// </summary>
    /// <param name="a">
    ///   The eVector4 which will be divided by the the extended 'b'.
    /// </param>
    /// <param name="b">
    ///   A extended precision float by which the vector 'a' will be divided.
    /// </param>
    /// <returns>
    ///   An eVector4 which contains the result of the division of vector 'a'
    ///   by extended 'b'.
    /// </returns>
    class operator Divide( const a: eVector4; const b: extended ): eVector4;

    /// <summary>
    ///   Assigns an eVector4 from an eVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector4;
    ///   VectorB: eVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: eVector3 ): eVector4;

    /// <summary>
    ///   Assigns an eVector4 from an eVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector4;
    ///   VectorB: eVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: eVector3 ): eVector4;

    /// <summary>
    ///   Assigns an eVector4 from an eVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector4;
    ///   VectorB: eVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: eVector2 ): eVector4;

    /// <summary>
    ///   Assigns an eVector4 from an eVector3 while setting the W element to
    ///   zero.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector4;
    ///   VectorB: eVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 0.0, 0.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: eVector2 ): eVector4;

    /// <summary>
    ///   Assigns an eVector3 from an eVector4 dropping the W element.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector4;
    ///   VectorB: eVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: eVector4 ): eVector3;

    /// <summary>
    ///   Assigns an eVector3 from an eVector4 dropping the W element.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector4;
    ///   VectorB: eVector3;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0, 3.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: eVector4 ): eVector3;

    /// <summary>
    ///   Assigns an eVector2 from an eVector4 dropping the Z and W elements.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector4;
    ///   VectorB: eVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Implicit( const a: eVector4 ): eVector2;

    /// <summary>
    ///   Assigns an eVector2 from an eVector4 dropping the Z and W elements.
    ///   <code lang="Delphi">var
    ///   VectorA: eVector4;
    ///   VectorB: eVector2;
    /// begin
    ///   VectorB := [ 1.0, 2.0, 3.0, 4.0 ];
    ///   VectorA := VectorB;
    ///   //- At this point, VectorA = 1.0, 2.0
    /// end;</code>
    /// </summary>
    class operator Explicit( const a: eVector4 ): eVector2;

    /// <summary>
    ///   Returns an eVector4 containing the parameter values X and Y, in that
    ///   order.
    ///   <code lang="Delphi">MyVectorA := eVector4.Create( 1.0, 2.0, 3.0, 4.0 );</code>
    /// </summary>
    /// <param name="X">
    ///   Value for the first element of the vector.
    /// </param>
    /// <param name="Y">
    ///   Value for the second element of the vector.
    /// </param>
    /// <returns>
    ///   An eVector4 containing the four values supplied as parameters.
    /// </returns>
    class function Create( const X: extended; const Y: extended; const Z: extended; const W: extended ): eVector4; overload; static;

    /// <summary>
    ///   Returns the dot product of this eVector4 with another eVector4.
    ///   <code lang="Delphi">S := VectorA.Dot( VectorB );</code>
    /// </summary>
    /// <param name="a">
    ///   An eVector4 with which to compute the dot product of this vector.
    /// </param>
    /// <returns>
    ///   A extended precision floating point result of the dot product of this
    ///   vector with another.
    /// </returns>
    function Dot( const a: eVector4 ): extended;

    /// <summary>
    ///   Returns the Normal vector of this vector.
    ///   <code lang="Delphi">NormalVector := SomeVector.Normalized;</code>
    /// </summary>
    /// <returns>
    ///   An eVector4 containing the normal of this vector.
    /// </returns>
    function Normalized: eVector4;

    /// <summary>
    ///   Returns the unit vector of this vector.
    ///   <code lang="Delphi">UnitVector := SomeVector.UnitVector;</code>
    /// </summary>
    /// <returns>
    ///   An eVector4 containing this vector scaled to the normal 1.
    /// </returns>
    function UnitVector: eVector4;

    /// <summary>
    ///   Returns the Magnitude of the vector.
    ///   <code lang="Delphi">M := SomeVector.Magnitude;</code>
    /// </summary>
    function Magnitude: extended;

      case uint8 of
      0: (
          X: extended;
          Y: extended;
          Z: extended;
          W: extended;
      );
      1: (
          R: extended;
          G: extended;
          B: extended;
          A: extended;
      );
      2: (
          U1: extended;
          V1: extended;
          U2: extended;
          V2: extended;
      );
  end;

{$endregion}

{$region ' sMatrix2x2'}

  ///  <summary>
  ///    Represents a 2x2 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  sMatrix2x2 = record

    m00, m10,
    m01, m11: single;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: sMatrix2x2; const b: sMatrix2x2 ): sMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add(const a: sMatrix2x2; const b: single ): sMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: sMatrix2x2; const b: sMatrix2x2 ): sMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: sMatrix2x2; const b: single ): sMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: sMatrix2x2; const b: sMatrix2x2 ): sMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: sMatrix2x2; const b: single ): sMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: sMatrix2x2; const b: sMatrix2x2 ): sMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: sMatrix2x2; const b: single ): sMatrix2x2;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: single; const _m10: single; const _m01: single; const _m11: single ): sMatrix2x2; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: sMatrix2x2 ): sMatrix2x2; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: sVector2 ): sVector2; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: sMatrix2x2;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: sMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: sVector2 ): sMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation (around z) to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotation( const degrees: single ): sMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: sVector2 ): sMatrix2x2; static;

    ///  <summary>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: single;

    ///  <summary>
    ///    Returns the cofactor of the matrix.
    ///  </summary>
    function cofactor: sMatrix2x2;

    ///  <summary>
    ///    Returns the adjugate of the matrix.
    ///  </summary>
    function adjugate: sMatrix2x2;

    ///  <summary>
    ///    Returns the inverse of the matrix.
    ///  </summary>
    function inverse: sMatrix2x2;

  end;

{$endregion}

{$region ' dMatrix2x2'}

  ///  <summary>
  ///    Represents a 2x2 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  dMatrix2x2 = record

    m00, m10,
    m01, m11: double;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: dMatrix2x2; const b: dMatrix2x2 ): dMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add(const a: dMatrix2x2; const b: double ): dMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: dMatrix2x2; const b: dMatrix2x2 ): dMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: dMatrix2x2; const b: double ): dMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: dMatrix2x2; const b: dMatrix2x2 ): dMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: dMatrix2x2; const b: double ): dMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: dMatrix2x2; const b: dMatrix2x2 ): dMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: dMatrix2x2; const b: double ): dMatrix2x2;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: double; const _m10: double; const _m01: double; const _m11: double ): dMatrix2x2; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: dMatrix2x2 ): dMatrix2x2; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: dVector2 ): dVector2; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: dMatrix2x2;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: dMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: dVector2 ): dMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation (around z) to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotation( const degrees: double ): dMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: dVector2 ): dMatrix2x2; static;

    ///  <summary>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: double;

    ///  <summary>
    ///    Returns the cofactor of the matrix.
    ///  </summary>
    function cofactor: dMatrix2x2;

    ///  <summary>
    ///    Returns the adjugate of the matrix.
    ///  </summary>
    function adjugate: dMatrix2x2;

    ///  <summary>
    ///    Returns the inverse of the matrix.
    ///  </summary>
    function inverse: dMatrix2x2;

  end;

{$endregion}

{$region ' eMatrix2x2'}

  ///  <summary>
  ///    Represents a 2x2 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  eMatrix2x2 = record

    m00, m10,
    m01, m11: extended;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: eMatrix2x2; const b: eMatrix2x2 ): eMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add(const a: eMatrix2x2; const b: extended ): eMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: eMatrix2x2; const b: eMatrix2x2 ): eMatrix2x2;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: eMatrix2x2; const b: extended ): eMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: eMatrix2x2; const b: eMatrix2x2 ): eMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: eMatrix2x2; const b: extended ): eMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: eMatrix2x2; const b: eMatrix2x2 ): eMatrix2x2;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: eMatrix2x2; const b: extended ): eMatrix2x2;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: extended; const _m10: extended; const _m01: extended; const _m11: extended ): eMatrix2x2; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: eMatrix2x2 ): eMatrix2x2; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: eVector2 ): eVector2; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: eMatrix2x2;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: eMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: eVector2 ): eMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation (around z) to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotation( const degrees: extended ): eMatrix2x2; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: eVector2 ): eMatrix2x2; static;

    ///  <summary>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: extended;

    ///  <summary>
    ///    Returns the cofactor of the matrix.
    ///  </summary>
    function cofactor: eMatrix2x2;

    ///  <summary>
    ///    Returns the adjugate of the matrix.
    ///  </summary>
    function adjugate: eMatrix2x2;

    ///  <summary>
    ///    Returns the inverse of the matrix.
    ///  </summary>
    function inverse: eMatrix2x2;

  end;

{$endregion}

{$region ' sMatrix3x3'}

  ///  <summary>
  ///    Represents a 3x3 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  sMatrix3x3 = record

    m00, m10, m20,
    m01, m11, m21,
    m02, m12, m22: single;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: sMatrix3x3; const b: sMatrix3x3 ): sMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add( const a: sMatrix3x3; const b: single ): sMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: sMatrix3x3; const b: sMatrix3x3 ): sMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: sMatrix3x3; const b: single ): sMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: sMatrix3x3; const b: sMatrix3x3 ): sMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: sMatrix3x3; const b: single ): sMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: sMatrix3x3; const b: sMatrix3x3 ): sMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: sMatrix3x3; const b: single ): sMatrix3x3;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: single; const _m10: single; const _m20: single; const _m01: single; const _m11: single; const _m21: single; const _m02: single; const _m12: single; const _m22: single ): sMatrix3x3; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: sMatrix3x3 ): sMatrix3x3; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: sVector3 ): sVector3; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: sMatrix3x3;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: sMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: sVector3 ): sMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around x to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationX( const degrees: single ): sMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around y to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationY( const degrees: single ): sMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around z to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationZ( const degrees: single ): sMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: sVector3 ): sMatrix3x3; static;

    ///  <summary>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: single;

    ///  <summary>
    ///    Returns the cofactor of this matrix.
    ///  </summary>
    function cofactor: sMatrix3x3;

    ///  <summary>
    ///    Returns the adjugate of this matrix.
    ///  </summary>
    function adjugate: sMatrix3x3;

    ///  <summary>
    ///    Returns the inverse of this matrix.
    ///  </summary>
    function inverse: sMatrix3x3;

  end;

{$endregion}

{$region ' dMatrix3x3'}

  ///  <summary>
  ///    Represents a 3x3 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  dMatrix3x3 = record

    m00, m10, m20,
    m01, m11, m21,
    m02, m12, m22: double;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: dMatrix3x3; const b: dMatrix3x3 ): dMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add( const a: dMatrix3x3; const b: double ): dMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: dMatrix3x3; const b: dMatrix3x3 ): dMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: dMatrix3x3; const b: double ): dMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: dMatrix3x3; const b: dMatrix3x3 ): dMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: dMatrix3x3; const b: double ): dMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: dMatrix3x3; const b: dMatrix3x3 ): dMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: dMatrix3x3; const b: double ): dMatrix3x3;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: double; const _m10: double; const _m20: double; const _m01: double; const _m11: double; const _m21: double; const _m02: double; const _m12: double; const _m22: double ): dMatrix3x3; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: dMatrix3x3 ): dMatrix3x3; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: dVector3 ): dVector3; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: dMatrix3x3;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: dMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: dVector3 ): dMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around x to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationX( const degrees: double ): dMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around y to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationY( const degrees: double ): dMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around z to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationZ( const degrees: double ): dMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: dVector3 ): dMatrix3x3; static;

    ///  <summary>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: double;

    ///  <summary>
    ///    Returns the cofactor of this matrix.
    ///  </summary>
    function cofactor: dMatrix3x3;

    ///  <summary>
    ///    Returns the adjugate of this matrix.
    ///  </summary>
    function adjugate: dMatrix3x3;

    ///  <summary>
    ///    Returns the inverse of this matrix.
    ///  </summary>
    function inverse: dMatrix3x3;

  end;

{$endregion}

{$region ' eMatrix3x3'}

  ///  <summary>
  ///    Represents a 3x3 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  eMatrix3x3 = record

    m00, m10, m20,
    m01, m11, m21,
    m02, m12, m22: extended;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: eMatrix3x3; const b: eMatrix3x3 ): eMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add( const a: eMatrix3x3; const b: extended ): eMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: eMatrix3x3; const b: eMatrix3x3 ): eMatrix3x3;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: eMatrix3x3; const b: extended ): eMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: eMatrix3x3; const b: eMatrix3x3 ): eMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: eMatrix3x3; const b: extended ): eMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: eMatrix3x3; const b: eMatrix3x3 ): eMatrix3x3;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: eMatrix3x3; const b: extended ): eMatrix3x3;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: extended; const _m10: extended; const _m20: extended; const _m01: extended; const _m11: extended; const _m21: extended; const _m02: extended; const _m12: extended; const _m22: extended ): eMatrix3x3; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: eMatrix3x3 ): eMatrix3x3; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: eVector3 ): eVector3; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: eMatrix3x3;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: eMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: eVector3 ): eMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around x to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationX( const degrees: extended ): eMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around y to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationY( const degrees: extended ): eMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around z to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationZ( const degrees: extended ): eMatrix3x3; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: eVector3 ): eMatrix3x3; static;

    ///  <summary>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: extended;

    ///  <summary>
    ///    Returns the cofactor of this matrix.
    ///  </summary>
    function cofactor: eMatrix3x3;

    ///  <summary>
    ///    Returns the adjugate of this matrix.
    ///  </summary>
    function adjugate: eMatrix3x3;

    ///  <summary>
    ///    Returns the inverse of this matrix.
    ///  </summary>
    function inverse: eMatrix3x3;

  end;

{$endregion}

{$region ' sMatrix4x4'}

  ///  <summary>
  ///    Represents a 4x4 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  sMatrix4x4 = record

    m00, m10, m20, m30,
    m01, m11, m21, m31,
    m02, m12, m22, m32,
    m03, m13, m23, m33: single;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: sMatrix4x4; const b: sMatrix4x4 ): sMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add( const a: sMatrix4x4; const b: single ): sMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: sMatrix4x4; const b: sMatrix4x4 ): sMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: sMatrix4x4; const b: single ): sMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: sMatrix4x4; const b: sMatrix4x4 ): sMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: sMatrix4x4; const b: single ): sMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: sMatrix4x4; const b: sMatrix4x4 ): sMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: sMatrix4x4; const b: single ): sMatrix4x4;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: single; const _m10: single; const _m20: single; const _m30: single; const _m01: single; const _m11: single; const _m21: single; const _m31: single; const _m02: single; const _m12: single; const _m22: single; const _m32: single; const _m03: single; const _m13: single; const _m23: single; const _m33: single ): sMatrix4x4; overload; static;

    ///  <summary>
    ///    Creates a new matrix from four row vectors of length 3.
    ///    Remaining space is filled with identity.
    ///  </summary>
    class function Create( const Row0: sVector3; const Row1: sVector3; const Row2: sVector3; const Row3: sVector3 ): sMatrix4x4; overload; static;

    ///  <summary>
    ///    Creates a new matrix from four row vectors.
    ///  </summary>
    class function Create( const Row0: sVector4; const Row1: sVector4; const Row2: sVector4; const Row3: sVector4 ): sMatrix4x4; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: sMatrix4x4 ): sMatrix4x4; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: sVector4 ): sVector4; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: sMatrix4x4;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: sMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: sVector3 ): sMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around x to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationX( const degrees: single ): sMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around y to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationY( const degrees: single ): sMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around z to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationZ( const degrees: single ): sMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: sVector3 ): sMatrix4x4; static;

    ///  <summary>
    ///    Returns the adjugate of this matrix.
    ///  </summary>
    function adjugate: sMatrix4x4;

    ///  <summary>
    ///    Returns the cofactor of this matrix.
    ///  </summary>
    function cofactor: sMatrix4x4;

    ///  <sumamry>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: single;

    ///  <summary>
    ///    Returns the inverse of this matrix.
    ///  </summary>
    function inverse: sMatrix4x4;

    ///  <summary>
    ///    Creates a view matrix based on the eye position, target(look-at) and
    ///    the up-direction for the coordinate space.
    ///  </summary>
    class function CreateView( const eye: sVector3; const target: sVector3; const Up: sVector3 ): sMatrix4x4; static;

    ///  <summary>
    ///    Creates a perspective matrix based on the viewing angle, aspect ratio,
    ///    near and far clipping planes.
    ///  </summary>
    class function CreatePerspective( const angleDeg: single; const ratio: single; const _near: single; const _far: single ): sMatrix4x4; static;

  end;

{$endregion}

{$region ' dMatrix4x4'}

  ///  <summary>
  ///    Represents a 4x4 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  dMatrix4x4 = record

    m00, m10, m20, m30,
    m01, m11, m21, m31,
    m02, m12, m22, m32,
    m03, m13, m23, m33: double;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: dMatrix4x4; const b: dMatrix4x4 ): dMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add( const a: dMatrix4x4; const b: double ): dMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: dMatrix4x4; const b: dMatrix4x4 ): dMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: dMatrix4x4; const b: double ): dMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: dMatrix4x4; const b: dMatrix4x4 ): dMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: dMatrix4x4; const b: double ): dMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: dMatrix4x4; const b: dMatrix4x4 ): dMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: dMatrix4x4; const b: double ): dMatrix4x4;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: double; const _m10: double; const _m20: double; const _m30: double; const _m01: double; const _m11: double; const _m21: double; const _m31: double; const _m02: double; const _m12: double; const _m22: double; const _m32: double; const _m03: double; const _m13: double; const _m23: double; const _m33: double ): dMatrix4x4; overload; static;

    ///  <summary>
    ///    Creates a new matrix from four row vectors of length 3.
    ///    Remaining space is filled with identity.
    ///  </summary>
    class function Create( const Row0: dVector3; const Row1: dVector3; const Row2: dVector3; const Row3: dVector3 ): dMatrix4x4; overload; static;

    ///  <summary>
    ///    Creates a new matrix from four row vectors.
    ///  </summary>
    class function Create( const Row0: dVector4; const Row1: dVector4; const Row2: dVector4; const Row3: dVector4 ): dMatrix4x4; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: dMatrix4x4 ): dMatrix4x4; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: dVector4 ): dVector4; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: dMatrix4x4;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: dMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: dVector3 ): dMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around x to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationX( const degrees: double ): dMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around y to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationY( const degrees: double ): dMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around z to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationZ( const degrees: double ): dMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: dVector3 ): dMatrix4x4; static;

    ///  <summary>
    ///    Returns the adjugate of this matrix.
    ///  </summary>
    function adjugate: dMatrix4x4;

    ///  <summary>
    ///    Returns the cofactor of this matrix.
    ///  </summary>
    function cofactor: dMatrix4x4;

    ///  <sumamry>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: double;

    ///  <summary>
    ///    Returns the inverse of this matrix.
    ///  </summary>
    function inverse: dMatrix4x4;

    ///  <summary>
    ///    Creates a view matrix based on the eye position, target(look-at) and
    ///    the up-direction for the coordinate space.
    ///  </summary>
    class function CreateView( const eye: dVector3; const target: dVector3; const Up: dVector3 ): dMatrix4x4; static;

    ///  <summary>
    ///    Creates a perspective matrix based on the viewing angle, aspect ratio,
    ///    near and far clipping planes.
    ///  </summary>
    class function CreatePerspective( const angleDeg: double; const ratio: double; const _near: double; const _far: double ): dMatrix4x4; static;

  end;

{$endregion}

{$region ' eMatrix4x4'}

  ///  <summary>
  ///    Represents a 4x4 matrix.
  ///    Addressed as xy (m21 = m.x=2 m.y=1)
  ///  </summary>
  eMatrix4x4 = record

    m00, m10, m20, m30,
    m01, m11, m21, m31,
    m02, m12, m22, m32,
    m03, m13, m23, m33: extended;

    ///  <summary>
    ///    Operator overload provides for addition of one Matrix to another.
    ///  </summary>
    class operator Add( const a: eMatrix4x4; const b: eMatrix4x4 ): eMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for addition of a float to a Matrix.
    ///  </summary>
    class operator Add( const a: eMatrix4x4; const b: extended ): eMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for subtraction of one Matrix from
    ///    another.
    ///  </summary>
    class operator Subtract( const a: eMatrix4x4; const b: eMatrix4x4 ): eMatrix4x4;

    ///  <summary>
    ///    Operator overload provides for subtraction of a float from
    //     a Matrix.
    ///  </summary>
    class operator Subtract( const a: eMatrix4x4; const b: extended ): eMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of one Matrix by
    ///    another (hadamard multiplication/scale).
    ///  </summary>
    class operator Multiply( const a: eMatrix4x4; const b: eMatrix4x4 ): eMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for multiplication of a Matrix by
    ///    a float. (scale)
    ///  </summary>
    class operator Multiply( const a: eMatrix4x4; const b: extended ): eMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for division of one Matrix by
    ///    another.
    ///  </summary>
    class operator Divide( const a: eMatrix4x4; const b: eMatrix4x4 ): eMatrix4x4;

    ///  <summary>
    ///    Operator overload to provide for division of a Matrix by a
    ///    float.
    ///  </summary>
    class operator Divide( const a: eMatrix4x4; const b: extended ): eMatrix4x4;

    ///  <summary>
    ///    Creates a new matrix based on the 16 floating point values provided.
    ///    Matrix addressed XxY
    ///  </summary>
    class function Create( const _m00: extended; const _m10: extended; const _m20: extended; const _m30: extended; const _m01: extended; const _m11: extended; const _m21: extended; const _m31: extended; const _m02: extended; const _m12: extended; const _m22: extended; const _m32: extended; const _m03: extended; const _m13: extended; const _m23: extended; const _m33: extended ): eMatrix4x4; overload; static;

    ///  <summary>
    ///    Creates a new matrix from four row vectors of length 3.
    ///    Remaining space is filled with identity.
    ///  </summary>
    class function Create( const Row0: eVector3; const Row1: eVector3; const Row2: eVector3; const Row3: eVector3 ): eMatrix4x4; overload; static;

    ///  <summary>
    ///    Creates a new matrix from four row vectors.
    ///  </summary>
    class function Create( const Row0: eVector4; const Row1: eVector4; const Row2: eVector4; const Row3: eVector4 ): eMatrix4x4; overload; static;

    ///  <summary>
    ///    The dot product of another matrix with this one.
    ///  </summary>
    function dot( const a: eMatrix4x4 ): eMatrix4x4; overload;

    ///  <summary>
    ///    Provides the dot product of a vector with this matrix.
    ///  </summary>
    function dot( const a: eVector4 ): eVector4; overload;

    ///  <summary>
    ///    Returns a matrix which is the transpose of this one.
    ///  </summary>
    function transpose: eMatrix4x4;

    ///  <summary>
    ///    Returns the identity matrix.
    ///  </summary>
    class function identity: eMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform translation based on the vector t.
    ///  </summary>
    class function translation( const t: eVector3 ): eMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around x to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationX( const degrees: extended ): eMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around y to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationY( const degrees: extended ): eMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform rotation around z to a specified number
    ///    of degrees.
    ///  </summary>
    class function rotationZ( const degrees: extended ): eMatrix4x4; static;

    ///  <summary>
    ///    Returns a matrix to perform scaling in three dimensions based on
    ///    the vector s.
    ///  </summary>
    class function scale( const s: eVector3 ): eMatrix4x4; static;

    ///  <summary>
    ///    Returns the adjugate of this matrix.
    ///  </summary>
    function adjugate: eMatrix4x4;

    ///  <summary>
    ///    Returns the cofactor of this matrix.
    ///  </summary>
    function cofactor: eMatrix4x4;

    ///  <sumamry>
    ///    Returns the determinant of the matrix.
    ///  </summary>
    function determinant: extended;

    ///  <summary>
    ///    Returns the inverse of this matrix.
    ///  </summary>
    function inverse: eMatrix4x4;

    ///  <summary>
    ///    Creates a view matrix based on the eye position, target(look-at) and
    ///    the up-direction for the coordinate space.
    ///  </summary>
    class function CreateView( const eye: eVector3; const target: eVector3; const Up: eVector3 ): eMatrix4x4; static;

    ///  <summary>
    ///    Creates a perspective matrix based on the viewing angle, aspect ratio,
    ///    near and far clipping planes.
    ///  </summary>
    class function CreatePerspective( const angleDeg: extended; const ratio: extended; const _near: extended; const _far: extended ): eMatrix4x4; static;

  end;

{$endregion}

{$region ' sRay'}

  /// <summary>
  ///   Represents a ray in 3D space as a single precision origin vector, a
  ///   single precision direction vector, and a single precision length value.
  /// </summary>
  sRay = record
  private
    fDirection: sVector3;
  private
    procedure setDirection(const Value: sVector3);
  public
    ///  <summary>
    ///    A vertex representing the initial point of the ray in 3d space.
    ///  </summary>
    Origin: sVertex;

    ///  <summary>
    ///    The length of the ray.
    ///  </summary>
    Length: single;

    ///  <summary>
    ///    A unit vector representing the direction that the ray is cast
    ///    away from the origin.
    ///  </summary>
    property Direction: sVector3 read fDirection write setDirection;

    /// <summary>
    ///   Returns an sRay between two sVertex vertices as origin and
    ///   destination points.
    /// </summary>
    /// <param name="aOrigin">
    ///   The origin of the ray represented as a vertex.
    /// </param>
    /// <param name="aDestination">
    ///   The destination (end) of the ray represented as a vertex.
    /// </param>
    /// <returns>
    ///   An sRay containing the origin, direction and length calculated from
    ///   the origin and destination vertices.
    /// </returns>
    class function Create( const aOrigin: sVertex; const aDestination: sVertex ): sRay; overload; static;

    /// <summary>
    ///   Returns an sRay based on the provided origin vertex, direction vector
    ///   and length value.
    /// </summary>
    /// <param name="aOrigin">
    ///   The origin of the ray in 3d space.
    /// </param>
    /// <param name="aDirection">
    ///   The direction of the ray as a 3d vector.
    /// </param>
    /// <param name="aLength">
    ///   The length of the ray in units matching the origin vertex.
    /// </param>
    /// <returns>
    ///   An sRay containing the values provided in the parameters.
    /// </returns>
    class function Create( const aOrigin: sVertex; const aDirection: sVector3; const aLength: single ): sRay; overload; static;

    /// <summary>
    ///   Returns the terminating vertex for this ray calculated as: <br />
    ///   Performs Origin + (Direction * Length).
    /// </summary>
    /// <remarks>
    ///   This will raise an exception if Length is either INF (infinity) or
    ///   NAN (not-a-number).
    /// </remarks>
    function Destination: sVertex;
  end;

{$endregion}

{$region ' dRay'}

  /// <summary>
  ///   Represents a ray in 3D space as a double precision origin vector, a
  ///   double precision direction vector, and a double precision length value.
  /// </summary>
  dRay = record
  private
    fDirection: dVector3;
  private
    procedure setDirection(const Value: dVector3);
  public
    ///  <summary>
    ///    A vertex representing the initial point of the ray in 3d space.
    ///  </summary>
    Origin: dVertex;

    ///  <summary>
    ///    The length of the ray.
    ///  </summmary>
    Length: double;

    ///  <summary>
    ///    A unit vector representing the direction that the ray is cast
    ///    away from the origin.
    ///  </summary>
    property Direction: dVector3 read fDirection write setDirection;

    /// <summary>
    ///   Returns a dRay between two dVertex vertices as origin and destination
    ///   points.
    /// </summary>
    /// <param name="aOrigin">
    ///   The origin of the ray represented as a vertex.
    /// </param>
    /// <param name="aDestination">
    ///   The destination (end) of the ray represented as a vertex.
    /// </param>
    /// <returns>
    ///   A dRay containing the origin, direction and length calculated from
    ///   the origin and destination vertices.
    /// </returns>
    class function Create( const aOrigin: dVertex; const aDestination: dVertex ): dRay; overload; static;

    /// <summary>
    ///   Returns a dRay based on the provided origin vertex, direction vector
    ///   and length value.
    /// </summary>
    /// <param name="aOrigin">
    ///   The origin of the ray in 3d space.
    /// </param>
    /// <param name="aDirection">
    ///   The direction of the ray as a 3d vector.
    /// </param>
    /// <param name="aLength">
    ///   The length of the ray in units matching the origin vertex.
    /// </param>
    /// <returns>
    ///   A dRay containing the values provided in the parameters.
    /// </returns>
    class function Create( const aOrigin: dVertex; const aDirection: dVector3; const aLength: double ): dRay; overload; static;

    /// <summary>
    ///   Returns the terminating vertex for this ray calculated as: <br />
    ///   Performs Origin + (Direction * Length).
    /// </summary>
    /// <remarks>
    ///   This will raise an exception if Length is either INF (infinity) or
    ///   NAN (not-a-number).
    /// </remarks>
    function Destination: dVertex;
  end;

{$endregion}

{$region ' eRay'}

  /// <summary>
  ///   Represents a ray in 3D space as an extended precision origin vector, an
  ///   extended precision direction vector, and an extended precision length
  ///   value.
  /// </summary>
  eRay = record
  private
    fDirection: eVector3;
  private
    procedure setDirection(const Value: eVector3);
  public
    ///  <summary>
    ///    A vertex representing the initial point of the ray in 3d space.
    ///  </summary>
    Origin: eVertex;

    ///  <summary>
    ///    The length of the ray.
    ///  </summmary>
    Length: extended;

    ///  <summary>
    ///    A unit vector representing the direction that the ray is cast
    ///    away from the origin.
    ///  </summary>
    property Direction: eVector3 read fDirection write setDirection;

    /// <summary>
    ///   Returns an eRay between two eVertex vertices as origin and
    ///   destination points.
    /// </summary>
    /// <param name="aOrigin">
    ///   The origin of the ray represented as a vertex.
    /// </param>
    /// <param name="aDestination">
    ///   The destination (end) of the ray represented as a vertex.
    /// </param>
    /// <returns>
    ///   An eRay containing the origin, direction and length calculated from
    ///   the origin and destination vertices.
    /// </returns>
    class function Create( const aOrigin: eVertex; const aDestination: eVertex ): eRay; overload; static;

    /// <summary>
    ///   Returns an eRay based on the provided origin vertex, direction vector
    ///   and length value.
    /// </summary>
    /// <param name="aOrigin">
    ///   The origin of the ray in 3d space.
    /// </param>
    /// <param name="aDirection">
    ///   The direction of the ray as a 3d vector.
    /// </param>
    /// <param name="aLength">
    ///   The length of the ray in units matching the origin vertex.
    /// </param>
    /// <returns>
    ///   An eRay containing the values provided in the parameters.
    /// </returns>
    class function Create( const aOrigin: eVertex; const aDirection: eVector3; const aLength: extended ): eRay; overload; static;

    /// <summary>
    ///   Returns the terminating vertex for this ray calculated as: <br />
    ///   Performs Origin + (Direction * Length).
    /// </summary>
    /// <remarks>
    ///   This will raise an exception if Length is either INF (infinity) or
    ///   NAN (not-a-number).
    /// </remarks>
    function Destination: eVertex;
  end;

{$endregion}

{$region ' sPlane'}

  ///  <summary>
  ///    Represents a plane in 3D space as a pair of unit vectors.
  ///  </summary>
  sPlane = record
  private
    fNormal: sVector3;
  private
    procedure setNormal( const Value: sVector3 );
  public
    Origin: sVertex;
    property Normal: sVector3 read fNormal write setNormal;
  public
    ///  <summary>
    ///    Creates a plane when given an origin and a normal.
    ///  </summary>
    class function Create( const aOrigin: sVertex; const aNormal: sVector3 ): sPlane; static;

    ///  <summary>
    ///    Returns the distance of vertex P from the plane.
    ///  </summary>
//    function distance( P: Vertex ): float;

    ///  <summary>
    ///    Returns true if the provided ray intersects with this plane.
    ///  </summary>
    function Intersect( const aRay: sRay ): boolean;

    ///  <summary>
    ///    Returns a vertex which represents the intersection of a ray
    ///    with this plane.
    ///  </summary>
    function Intersection( const aRay: sRay ): sVertex;
  end;

{$endregion}

{$region ' dPlane'}

  ///  <summary>
  ///    Represents a plane in 3D space as a pair of unit vectors.
  ///  </summary>
  dPlane = record
  private
    fNormal: dVector3;
  private
    procedure setNormal( const Value: dVector3 );
  public
    Origin: dVertex;
    property Normal: dVector3 read fNormal write setNormal;
  public
    ///  <summary>
    ///    Creates a plane when given an origin and a normal.
    ///  </summary>
    class function Create( const aOrigin: dVertex; const aNormal: dVector3 ): dPlane; static;

    ///  <summary>
    ///    Returns the distance of vertex P from the plane.
    ///  </summary>
//    function distance( P: Vertex ): float;

    ///  <summary>
    ///    Returns true if the provided ray intersects with this plane.
    ///  </summary>
    function Intersect( const aRay: dRay ): boolean;

    ///  <summary>
    ///    Returns a vertex which represents the intersection of a ray
    ///    with this plane.
    ///  </summary>
    function Intersection( const aRay: dRay ): dVertex;
  end;

{$endregion}

{$region ' ePlane'}

  ///  <summary>
  ///    Represents a plane in 3D space as a pair of unit vectors.
  ///  </summary>
  ePlane = record
  private
    fNormal: eVector3;
  private
    procedure setNormal( const Value: eVector3 );
  public
    Origin: eVertex;
    property Normal: eVector3 read fNormal write setNormal;
  public
    ///  <summary>
    ///    Creates a plane when given an origin and a normal.
    ///  </summary>
    class function Create( const aOrigin: eVertex; const aNormal: eVector3 ): ePlane; static;

    ///  <summary>
    ///    Returns the distance of vertex P from the plane.
    ///  </summary>
//    function distance( P: Vertex ): float;

    ///  <summary>
    ///    Returns true if the provided ray intersects with this plane.
    ///  </summary>
    function Intersect( const aRay: eRay ): boolean;

    ///  <summary>
    ///    Returns a vertex which represents the intersection of a ray
    ///    with this plane.
    ///  </summary>
    function Intersection( const aRay: eRay ): eVertex;
  end;

{$endregion}

{$region ' sSphere'}

  ///  <summary>
  ///    Represents a sphere as a vertex (as it's origin) and a radius.
  ///  </summary>
  sSphere = record

    ///  <summary>
    ///    A Vertex representing the location of the sphere.
    ///  </summary>
    Origin: sVertex;

    ///  <summary>
    ///    Represents the radius of the sphere about the origin.
    ///  </summary>
    Radius: single;

    ///  <summary>
    ///    Returns true of the provided ray intersects with this sphere.
    ///  </summary>
//    function Intersect( const aRay: Ray ): boolean;

    ///  <summary>
    ///    Returns a vertex which represents the intersection of a ray with
    ///    this sphere.
    ///  </summary>
//    function Intersection( const aRay: Ray ): Vertex;
  end;

{$endregion}

{$region ' dSphere'}

  ///  <summary>
  ///    Represents a sphere as a vertex (as it's origin) and a radius.
  ///  </summary>
  dSphere = record

    ///  <summary>
    ///    A Vertex representing the location of the sphere.
    ///  </summary>
    Origin: dVertex;

    ///  <summary>
    ///    Represents the radius of the sphere about the origin.
    ///  </summary>
    Radius: double;

    ///  <summary>
    ///    Returns true of the provided ray intersects with this sphere.
    ///  </summary>
//    function Intersect( const aRay: Ray ): boolean;

    ///  <summary>
    ///    Returns a vertex which represents the intersection of a ray with
    ///    this sphere.
    ///  </summary>
//    function Intersection( const aRay: Ray ): Vertex;
  end;

{$endregion}

{$region ' eSphere'}

  ///  <summary>
  ///    Represents a sphere as a vertex (as it's origin) and a radius.
  ///  </summary>
  eSphere = record

    ///  <summary>
    ///    A Vertex representing the location of the sphere.
    ///  </summary>
    Origin: eVertex;

    ///  <summary>
    ///    Represents the radius of the sphere about the origin.
    ///  </summary>
    Radius: extended;

    ///  <summary>
    ///    Returns true of the provided ray intersects with this sphere.
    ///  </summary>
//    function Intersect( const aRay: Ray ): boolean;

    ///  <summary>
    ///    Returns a vertex which represents the intersection of a ray with
    ///    this sphere.
    ///  </summary>
//    function Intersection( const aRay: Ray ): Vertex;
  end;

{$endregion}

{$region ' Aliases'}

type
  Vector2   = sVector2;
  Vector3   = sVector3;
  Vector4   = sVector4;
  Vertex    = sVertex;
  Matrix2x2 = sMatrix2x2;
  Matrix3x3 = sMatrix3x3;
  Matrix4x4 = sMatrix4x4;
  Ray       = sRay;
  Plane     = sPlane;
  Spehere   = sSphere;

{$endregion}

implementation
uses
  cwStatus
, math
, sysutils
;

type
  TArrayOfHalf = array of half;

function ArrayOfSingleToArrayOfHalf( const a: array of single ): TArrayOfHalf;
var
  idx: nativeuint;
begin
  {$warnings off} SetLength(Result,Length(a)); {$warnings on} // fpc warns not initialized, this is initialization
  if Length(Result)=0 then begin
    exit;
  end;
  for idx := 0 to pred(Length(Result)) do begin
    Result[idx] := a[idx];
  end;
end;

{$region ' sVector2'}

class operator sVector2.Add( const a: sVector2; const b: sVector2 ): sVector2;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
end;

class operator sVector2.Add( const a: sVector2; const b: single ): sVector2;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
end;

class operator sVector2.Add( const a: sVector2; const b: array of single ): sVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
end;

class operator sVector2.Add( const a: array of single; const b: sVector2 ): sVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := b.X + a[0];
  Result.Y := b.Y + a[1];
end;

class function sVector2.Create( const X: single; const Y: single ): sVector2;
begin
  Result.X := X;
  Result.Y := Y;
end;

class operator sVector2.Divide( const a: sVector2; const b: sVector2 ): sVector2;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
end;

class operator sVector2.Divide( const a: sVector2; const b: single ): sVector2;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
end;

class operator sVector2.Divide( const a: sVector2; const b: array of single ): sVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
end;

class operator sVector2.Divide( const a: array of single; const b: sVector2 ): sVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
end;

function sVector2.dot( const a: sVector2 ): single;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y);
end;

class operator sVector2.Explicit(const a: array of single): sVector2;
var
  L: uint32;
begin
  L := Length(a);
  if (L>2) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(single)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector2.Implicit( const a: array of single ): sVector2;
var
  L: uint32;
begin
  L := Length(a);
  if (L>2) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(single)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

function sVector2.magnitude: single;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y) );
end;

class operator sVector2.Multiply( const a: sVector2; const b: sVector2 ): sVector2;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
end;

class operator sVector2.Multiply( const a: sVector2; const b: single ): sVector2;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
end;

class operator sVector2.Multiply( const a: sVector2; const b: array of single ): sVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
end;

class operator sVector2.Multiply( const a: array of single; const b: sVector2 ): sVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
end;

function sVector2.normalized: sVector2;
var
  M: single;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
end;

class operator sVector2.Subtract( const a: sVector2; const b: array of single ): sVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
end;

class operator sVector2.Subtract( const a: array of single; const b: sVector2 ): sVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
end;

class operator sVector2.Subtract( const a: sVector2; const b: single ): sVector2;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
end;

function sVector2.UnitVector: sVector2;
var
  fMagnitude: single;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
end;

class operator sVector2.Subtract( const a: sVector2; const b: sVector2 ): sVector2;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
end;

{$endregion}

{$region ' dVector2'}

class operator dVector2.Add( const a: dVector2; const b: dVector2 ): dVector2;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
end;

class operator dVector2.Add( const a: dVector2; const b: double ): dVector2;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
end;

class operator dVector2.Add( const a: dVector2; const b: array of double ): dVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
end;

class operator dVector2.Add( const a: array of double; const b: dVector2 ): dVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := b.X + a[0];
  Result.Y := b.Y + a[1];
end;

class function dVector2.Create( const X: double; const Y: double ): dVector2;
begin
  Result.X := X;
  Result.Y := Y;
end;

class operator dVector2.Divide( const a: dVector2; const b: dVector2 ): dVector2;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
end;

class operator dVector2.Divide( const a: dVector2; const b: double ): dVector2;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
end;

class operator dVector2.Divide( const a: dVector2; const b: array of double ): dVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
end;

class operator dVector2.Divide( const a: array of double; const b: dVector2 ): dVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
end;

function dVector2.dot( const a: dVector2 ): double;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y);
end;

class operator dVector2.Explicit(const a: array of double): dVector2;
var
  L: uint32;
begin
  L := Length(a);
  if (L>2) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(double)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector2.Implicit( const a: array of double ): dVector2;
var
  L: uint32;
begin
  L := Length(a);
  if (L>2) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(double)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

function dVector2.magnitude: double;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y) );
end;

class operator dVector2.Multiply( const a: dVector2; const b: dVector2 ): dVector2;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
end;

class operator dVector2.Multiply( const a: dVector2; const b: double ): dVector2;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
end;

class operator dVector2.Multiply( const a: dVector2; const b: array of double ): dVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
end;

class operator dVector2.Multiply( const a: array of double; const b: dVector2 ): dVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
end;

function dVector2.normalized: dVector2;
var
  M: double;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
end;

class operator dVector2.Subtract( const a: dVector2; const b: array of double ): dVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
end;

class operator dVector2.Subtract( const a: array of double; const b: dVector2 ): dVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
end;

class operator dVector2.Subtract( const a: dVector2; const b: double ): dVector2;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
end;

function dVector2.UnitVector: dVector2;
var
  fMagnitude: double;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
end;

class operator dVector2.Subtract( const a: dVector2; const b: dVector2 ): dVector2;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
end;

{$endregion}

{$region ' eVector2'}

class operator eVector2.Add( const a: eVector2; const b: eVector2 ): eVector2;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
end;

class operator eVector2.Add( const a: eVector2; const b: extended ): eVector2;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
end;

class operator eVector2.Add( const a: eVector2; const b: array of extended ): eVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
end;

class operator eVector2.Add( const a: array of extended; const b: eVector2 ): eVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := b.X + a[0];
  Result.Y := b.Y + a[1];
end;

class function eVector2.Create( const X: extended; const Y: extended ): eVector2;
begin
  Result.X := X;
  Result.Y := Y;
end;

class operator eVector2.Divide( const a: eVector2; const b: eVector2 ): eVector2;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
end;

class operator eVector2.Divide( const a: eVector2; const b: extended ): eVector2;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
end;

class operator eVector2.Divide( const a: eVector2; const b: array of extended ): eVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
end;

class operator eVector2.Divide( const a: array of extended; const b: eVector2 ): eVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
end;

function eVector2.dot( const a: eVector2 ): extended;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y);
end;

class operator eVector2.Explicit(const a: array of extended): eVector2;
var
  L: uint32;
begin
  L := Length(a);
  if (L>2) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(extended)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator eVector2.Implicit( const a: array of extended ): eVector2;
var
  L: uint32;
begin
  L := Length(a);
  if (L>2) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := A[0];
  Result.Y := A[1];
end;

function eVector2.magnitude: extended;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y) );
end;

class operator eVector2.Multiply( const a: eVector2; const b: eVector2 ): eVector2;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
end;

class operator eVector2.Multiply( const a: eVector2; const b: extended ): eVector2;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
end;

class operator eVector2.Multiply( const a: eVector2; const b: array of extended ): eVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
end;

class operator eVector2.Multiply( const a: array of extended; const b: eVector2 ): eVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
end;

function eVector2.normalized: eVector2;
var
  M: extended;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
end;

class operator eVector2.Subtract( const a: eVector2; const b: array of extended ): eVector2;
begin
  if length(b)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
end;

class operator eVector2.Subtract( const a: array of extended; const b: eVector2 ): eVector2;
begin
  if length(a)<>2 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
end;

class operator eVector2.Subtract( const a: eVector2; const b: extended ): eVector2;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
end;

function eVector2.UnitVector: eVector2;
var
  fMagnitude: extended;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
end;

class operator eVector2.Subtract( const a: eVector2; const b: eVector2 ): eVector2;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
end;

{$endregion}

{$region ' sVector3'}

class operator sVector3.Add( const a: sVector3; const b: sVector3 ): sVector3;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
end;

class operator sVector3.Add( const a: sVector3; const b: single ): sVector3;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
end;

class operator sVector3.Add( const a: sVector3; const b: array of single ): sVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
  Result.Z := a.Z + b[2];
end;

class operator sVector3.Add( const a: array of single; const b: sVector3 ): sVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] + b.X;
  Result.Y := a[1] + b.Y;
  Result.Z := a[2] + b.Z;
end;

class function sVector3.Create( const X: single; const Y: single; const Z: single ): sVector3;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;

function sVector3.cross( const a: sVector3 ): sVector3;
begin
  Result.X := (Self.Y * A.Z) - (Self.Z * A.Y);
  Result.Y := (Self.Z * A.X) - (Self.X * A.Z);
  Result.Z := (Self.X * A.Y) - (Self.Y * A.X);
end;

class operator sVector3.Divide( const a: sVector3; const b: sVector3 ): sVector3;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
end;

class operator sVector3.Divide( const a: sVector3; const b: single ): sVector3;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
end;

class operator sVector3.Divide( const a: sVector3; const b: array of single ): sVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
  Result.Z := a.Z / b[2];
end;

class operator sVector3.Divide( const a: array of single; const b: sVector3 ): sVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
  Result.Z := a[2] / b.Z;
end;

function sVector3.dot( const a: sVector3 ): single;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y) + (Self.Z * A.Z);
end;

class operator sVector3.Explicit( const a: sVector2 ): sVector3;
begin
  {$hints off} Move(a,Result,sizeof(sVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
end;

class operator sVector3.Explicit( const a: sVector3 ): sVector2;
begin
  {$hints off} Move(a,Result,sizeof(sVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector3.Implicit( const a: sVector2 ): sVector3;
begin
  {$hints off} Move(a,Result,sizeof(sVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
end;

class operator sVector3.Implicit( const a: sVector3 ): sVector2;
begin
  {$hints off} Move(a,Result,sizeof(sVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector3.Implicit( const a: array of single ): sVector3;
var
  L: uint32;
begin
  L := Length(a);
  if (L>3) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(single)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector3.Explicit( const a: array of single ): sVector3;
var
  L: uint32;
begin
  L := Length(a);
  if (L>3) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(single)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

function sVector3.magnitude: single;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y)+(Z*Z) );
end;

class operator sVector3.Multiply( const a: sVector3; const b: array of single ): sVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
  Result.Z := a.Z * b[2];
end;

class operator sVector3.Multiply( const a: array of single; const b: sVector3 ): sVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
  Result.Z := a[2] * b.Z;
end;

class operator sVector3.Multiply( const a: sVector3; const b: sVector3 ): sVector3;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
end;

class operator sVector3.Multiply( const a: sVector3; const b: single ): sVector3;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
end;

function sVector3.normalized: sVector3;
var
  M: single;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
  Result.Z := Z / M;
end;

class operator sVector3.Subtract( const a: sVector3; const b: array of single ): sVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
  Result.Z := a.Z - b[2];
end;

class operator sVector3.Subtract( const a: array of single; const b: sVector3 ): sVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
  Result.Z := a[2] - b.Z;
end;

class operator sVector3.Subtract( const a: sVector3; const b: single ): sVector3;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
end;

function sVector3.UnitVector: sVector3;
var
   fMagnitude: single;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y)+(Z*Z) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
  Result.Z := Z / fMagnitude;
end;

class operator sVector3.Subtract( const a: sVector3; const b: sVector3 ): sVector3;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
end;

{$endregion}

{$region ' dVector3'}

class operator dVector3.Add( const a: dVector3; const b: dVector3 ): dVector3;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
end;

class operator dVector3.Add( const a: dVector3; const b: double ): dVector3;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
end;

class operator dVector3.Add( const a: dVector3; const b: array of double ): dVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
  Result.Z := a.Z + b[2];
end;

class operator dVector3.Add( const a: array of double; const b: dVector3 ): dVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] + b.X;
  Result.Y := a[1] + b.Y;
  Result.Z := a[2] + b.Z;
end;

class function dVector3.Create( const X: double; const Y: double; const Z: double ): dVector3;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;

function dVector3.cross( const a: dVector3 ): dVector3;
begin
  Result.X := (Self.Y * A.Z) - (Self.Z * A.Y);
  Result.Y := (Self.Z * A.X) - (Self.X * A.Z);
  Result.Z := (Self.X * A.Y) - (Self.Y * A.X);
end;

class operator dVector3.Divide( const a: dVector3; const b: dVector3 ): dVector3;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
end;

class operator dVector3.Divide( const a: dVector3; const b: double ): dVector3;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
end;

class operator dVector3.Divide( const a: dVector3; const b: array of double ): dVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
  Result.Z := a.Z / b[2];
end;

class operator dVector3.Divide( const a: array of double; const b: dVector3 ): dVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
  Result.Z := a[2] / b.Z;
end;

function dVector3.dot( const a: dVector3 ): double;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y) + (Self.Z * A.Z);
end;

class operator dVector3.Explicit( const a: dVector2 ): dVector3;
begin
  {$hints off} Move(a,Result,sizeof(dVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
end;

class operator dVector3.Explicit( const a: dVector3 ): dVector2;
begin
  {$hints off} Move(a,Result,sizeof(dVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector3.Implicit( const a: dVector2 ): dVector3;
begin
  {$hints off} Move(a,Result,sizeof(dVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
end;

class operator dVector3.Implicit( const a: dVector3 ): dVector2;
begin
  {$hints off} Move(a,Result,sizeof(dVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector3.Implicit( const a: array of double ): dVector3;
var
  L: uint32;
begin
  L := Length(a);
  if (L>3) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(double)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector3.Explicit( const a: array of double ): dVector3;
var
  L: uint32;
begin
  L := Length(a);
  if (L>3) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(double)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

function dVector3.magnitude: double;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y)+(Z*Z) );
end;

class operator dVector3.Multiply( const a: dVector3; const b: array of double ): dVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
  Result.Z := a.Z * b[2];
end;

class operator dVector3.Multiply( const a: array of double; const b: dVector3 ): dVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
  Result.Z := a[2] * b.Z;
end;

class operator dVector3.Multiply( const a: dVector3; const b: dVector3 ): dVector3;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
end;

class operator dVector3.Multiply( const a: dVector3; const b: double ): dVector3;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
end;

function dVector3.normalized: dVector3;
var
  M: double;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
  Result.Z := Z / M;
end;

class operator dVector3.Subtract( const a: dVector3; const b: array of double ): dVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
  Result.Z := a.Z - b[2];
end;

class operator dVector3.Subtract( const a: array of double; const b: dVector3 ): dVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
  Result.Z := a[2] - b.Z;
end;

class operator dVector3.Subtract( const a: dVector3; const b: double ): dVector3;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
end;

function dVector3.UnitVector: dVector3;
var
   fMagnitude: double;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y)+(Z*Z) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
  Result.Z := Z / fMagnitude;
end;

class operator dVector3.Subtract( const a: dVector3; const b: dVector3 ): dVector3;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
end;

{$endregion}

{$region ' eVector3'}

class operator eVector3.Add( const a: eVector3; const b: eVector3 ): eVector3;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
end;

class operator eVector3.Add( const a: eVector3; const b: extended ): eVector3;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
end;

class operator eVector3.Add( const a: eVector3; const b: array of extended ): eVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
  Result.Z := a.Z + b[2];
end;

class operator eVector3.Add( const a: array of extended; const b: eVector3 ): eVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] + b.X;
  Result.Y := a[1] + b.Y;
  Result.Z := a[2] + b.Z;
end;

class function eVector3.Create( const X: extended; const Y: extended; const Z: extended ): eVector3;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;

function eVector3.cross( const a: eVector3 ): eVector3;
begin
  Result.X := (Self.Y * A.Z) - (Self.Z * A.Y);
  Result.Y := (Self.Z * A.X) - (Self.X * A.Z);
  Result.Z := (Self.X * A.Y) - (Self.Y * A.X);
end;

class operator eVector3.Divide( const a: eVector3; const b: eVector3 ): eVector3;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
end;

class operator eVector3.Divide( const a: eVector3; const b: extended ): eVector3;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
end;

class operator eVector3.Divide( const a: eVector3; const b: array of extended ): eVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
  Result.Z := a.Z / b[2];
end;

class operator eVector3.Divide( const a: array of extended; const b: eVector3 ): eVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
  Result.Z := a[2] / b.Z;
end;

function eVector3.dot( const a: eVector3 ): extended;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y) + (Self.Z * A.Z);
end;

class operator eVector3.Explicit( const a: eVector2 ): eVector3;
begin
  {$hints off} Move(a,Result,sizeof(eVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
end;

class operator eVector3.Explicit( const a: eVector3 ): eVector2;
begin
  {$hints off} Move(a,Result,sizeof(eVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator eVector3.Implicit( const a: eVector2 ): eVector3;
begin
  {$hints off} Move(a,Result,sizeof(eVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
end;

class operator eVector3.Implicit( const a: eVector3 ): eVector2;
begin
  {$hints off} Move(a,Result,sizeof(eVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator eVector3.Implicit( const a: array of extended ): eVector3;
var
  L: uint32;
begin
  L := Length(a);
  if (L>3) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := A[0];
  Result.Y := A[1];
  Result.Z := A[2];
end;

class operator eVector3.Explicit( const a: array of extended ): eVector3;
var
  L: uint32;
begin
  L := Length(a);
  if (L>3) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(extended)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

function eVector3.magnitude: extended;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y)+(Z*Z) );
end;

class operator eVector3.Multiply( const a: eVector3; const b: array of extended ): eVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
  Result.Z := a.Z * b[2];
end;

class operator eVector3.Multiply( const a: array of extended; const b: eVector3 ): eVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
  Result.Z := a[2] * b.Z;
end;

class operator eVector3.Multiply( const a: eVector3; const b: eVector3 ): eVector3;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
end;

class operator eVector3.Multiply( const a: eVector3; const b: extended ): eVector3;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
end;

function eVector3.normalized: eVector3;
var
  M: extended;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
  Result.Z := Z / M;
end;

class operator eVector3.Subtract( const a: eVector3; const b: array of extended ): eVector3;
begin
  if length(b)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
  Result.Z := a.Z - b[2];
end;

class operator eVector3.Subtract( const a: array of extended; const b: eVector3 ): eVector3;
begin
  if length(a)<>3 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
  Result.Z := a[2] - b.Z;
end;

class operator eVector3.Subtract( const a: eVector3; const b: extended ): eVector3;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
end;

function eVector3.UnitVector: eVector3;
var
   fMagnitude: extended;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y)+(Z*Z) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
  Result.Z := Z / fMagnitude;
end;

class operator eVector3.Subtract( const a: eVector3; const b: eVector3 ): eVector3;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
end;

{$endregion}

{$region ' sVector4'}

class operator sVector4.Add( const a: sVector4; const b: sVector4 ): sVector4;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
  Result.W := A.W + B.W;
end;

class operator sVector4.Add( const a: sVector4; const b: single ): sVector4;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
  Result.W := A.W + B;
end;

class operator sVector4.Add( const a: sVector4; const b: array of single ): sVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
  Result.Z := a.Z + b[2];
  Result.W := a.W + b[3];
end;

class operator sVector4.Add( const a: array of single; const b: sVector4 ): sVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] + b.X;
  Result.Y := a[1] + b.Y;
  Result.Z := a[2] + b.Z;
  Result.W := a[3] + b.W;
end;

class function sVector4.Create( const X: single; const Y: single; const Z: single; const W: single ): sVector4;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
  Result.W := W;
end;

class operator sVector4.Divide( const a: sVector4; const b: sVector4 ): sVector4;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
  Result.W := A.W / B.W;
end;

class operator sVector4.Divide( const a: sVector4; const b: single ): sVector4;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
  Result.W := A.W / B;
end;

class operator sVector4.Divide( const a: sVector4; const b: array of single ): sVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
  Result.Z := a.Z / b[2];
  Result.W := a.W / b[3];
end;

class operator sVector4.Divide( const a: array of single; const b: sVector4 ): sVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
  Result.Z := a[2] / b.Z;
  Result.W := a[3] / b.W;
end;

function sVector4.dot( const a: sVector4 ): single;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y) + (Self.Z * A.Z) + (Self.W * A.W);
end;

function sVector4.magnitude: single;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y)+(Z*Z)+(W*W) );
end;

class operator sVector4.Multiply( const a: sVector4; const b: array of single ): sVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
  Result.Z := a.Z * b[2];
  Result.W := a.W * b[3];
end;

class operator sVector4.Multiply( const a: array of single; const b: sVector4 ): sVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
  Result.Z := a[2] * b.Z;
  Result.W := a[3] * b.W;
end;

class operator sVector4.Multiply( const a: sVector4; const b: sVector4 ): sVector4;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
  Result.W := A.W * B.W;
end;

class operator sVector4.Multiply( const a: sVector4; const b: single ): sVector4;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
  Result.W := A.W * B;
end;

function sVector4.normalized: sVector4;
var
  M: single;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
  Result.Z := Z / M;
  Result.W := W / M;
end;

class operator sVector4.Subtract( const a: sVector4; const b: array of single ): sVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
  Result.Z := a.Z - b[2];
  Result.W := a.W - b[3];
end;

class operator sVector4.Subtract( const a: array of single; const b: sVector4 ): sVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
  Result.Z := a[2] - b.Z;
  Result.W := a[3] - b.W;
end;

class operator sVector4.Subtract( const a: sVector4; const b: single ): sVector4;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
  Result.W := A.W - B;
end;

function sVector4.UnitVector: sVector4;
var
   fMagnitude: single;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y)+(Z*Z)+(W*W) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
  Result.Z := Z / fMagnitude;
  Result.W := W / fMagnitude;
end;

class operator sVector4.Subtract( const a: sVector4; const b: sVector4 ): sVector4;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
  Result.W := A.W - B.W;
end;

class operator sVector4.Explicit( const a: sVector3 ): sVector4;
begin
  {$hints off} Move(a,Result,sizeof(sVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.W := 1;
end;

class operator sVector4.Explicit( const a: sVector2 ): sVector4;
begin
  {$hints off} Move(a,Result,Sizeof(sVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
  Result.W := 1;
end;

class operator sVector4.Implicit( const a: sVector3 ): sVector4;
begin
  {$hints off} Move(a,Result,sizeof(sVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.W := 1;
end;

class operator sVector4.Implicit( const a: sVector2 ): sVector4;
begin
  {$hints off} Move(a,Result,sizeof(sVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
  Result.W := 1;
end;

class operator sVector4.Explicit( const a: sVector4 ): sVector3;
begin
  {$hints off} Move(a,Result,sizeof(sVector3)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector4.Explicit( const a: sVector4 ): sVector2;
begin
  {$hints off} Move(a,Result,sizeof(sVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector4.Implicit( const a: sVector4 ): sVector3;
begin
  {$hints off} Move(a,Result,sizeof(sVector3)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector4.Implicit( const a: sVector4 ): sVector2;
begin
  {$hints off} Move(a,Result,sizeof(sVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector4.Implicit( const a: array of single ): sVector4;
var
  L: uint32;
begin
  L := Length(a);
  if (L>4) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(single)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator sVector4.Explicit( const a: array of single ): sVector4;
var
  L: uint32;
begin
  L := Length(a);
  if (L>4) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(single)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

{$endregion}

{$region ' dVector4'}

class operator dVector4.Add( const a: dVector4; const b: dVector4 ): dVector4;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
  Result.W := A.W + B.W;
end;

class operator dVector4.Add( const a: dVector4; const b: double ): dVector4;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
  Result.W := A.W + B;
end;

class operator dVector4.Add( const a: dVector4; const b: array of double ): dVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
  Result.Z := a.Z + b[2];
  Result.W := a.W + b[3];
end;

class operator dVector4.Add( const a: array of double; const b: dVector4 ): dVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] + b.X;
  Result.Y := a[1] + b.Y;
  Result.Z := a[2] + b.Z;
  Result.W := a[3] + b.W;
end;

class function dVector4.Create( const X: double; const Y: double; const Z: double; const W: double ): dVector4;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
  Result.W := W;
end;

class operator dVector4.Divide( const a: dVector4; const b: dVector4 ): dVector4;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
  Result.W := A.W / B.W;
end;

class operator dVector4.Divide( const a: dVector4; const b: double ): dVector4;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
  Result.W := A.W / B;
end;

class operator dVector4.Divide( const a: dVector4; const b: array of double ): dVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
  Result.Z := a.Z / b[2];
  Result.W := a.W / b[3];
end;

class operator dVector4.Divide( const a: array of double; const b: dVector4 ): dVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
  Result.Z := a[2] / b.Z;
  Result.W := a[3] / b.W;
end;

function dVector4.dot( const a: dVector4 ): double;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y) + (Self.Z * A.Z) + (Self.W * A.W);
end;

function dVector4.magnitude: double;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y)+(Z*Z)+(W*W) );
end;

class operator dVector4.Multiply( const a: dVector4; const b: array of double ): dVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
  Result.Z := a.Z * b[2];
  Result.W := a.W * b[3];
end;

class operator dVector4.Multiply( const a: array of double; const b: dVector4 ): dVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
  Result.Z := a[2] * b.Z;
  Result.W := a[3] * b.W;
end;

class operator dVector4.Multiply( const a: dVector4; const b: dVector4 ): dVector4;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
  Result.W := A.W * B.W;
end;

class operator dVector4.Multiply( const a: dVector4; const b: double ): dVector4;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
  Result.W := A.W * B;
end;

function dVector4.normalized: dVector4;
var
  M: double;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
  Result.Z := Z / M;
  Result.W := W / M;
end;

class operator dVector4.Subtract( const a: dVector4; const b: array of double ): dVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
  Result.Z := a.Z - b[2];
  Result.W := a.W - b[3];
end;

class operator dVector4.Subtract( const a: array of double; const b: dVector4 ): dVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
  Result.Z := a[2] - b.Z;
  Result.W := a[3] - b.W;
end;

class operator dVector4.Subtract( const a: dVector4; const b: double ): dVector4;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
  Result.W := A.W - B;
end;

function dVector4.UnitVector: dVector4;
var
   fMagnitude: double;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y)+(Z*Z)+(W*W) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
  Result.Z := Z / fMagnitude;
  Result.W := W / fMagnitude;
end;

class operator dVector4.Subtract( const a: dVector4; const b: dVector4 ): dVector4;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
  Result.W := A.W - B.W;
end;

class operator dVector4.Explicit( const a: dVector3 ): dVector4;
begin
  {$hints off} Move(a,Result,sizeof(dVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.W := 1;
end;

class operator dVector4.Explicit( const a: dVector2 ): dVector4;
begin
  {$hints off} Move(a,Result,Sizeof(dVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
  Result.W := 1;
end;

class operator dVector4.Implicit( const a: dVector3 ): dVector4;
begin
  {$hints off} Move(a,Result,sizeof(dVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.W := 1;
end;

class operator dVector4.Implicit( const a: dVector2 ): dVector4;
begin
  {$hints off} Move(a,Result,sizeof(dVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
  Result.W := 1;
end;

class operator dVector4.Explicit( const a: dVector4 ): dVector3;
begin
  {$hints off} Move(a,Result,sizeof(dVector3)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector4.Explicit( const a: dVector4 ): dVector2;
begin
  {$hints off} Move(a,Result,sizeof(dVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector4.Implicit( const a: dVector4 ): dVector3;
begin
  {$hints off} Move(a,Result,sizeof(dVector3)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector4.Implicit( const a: dVector4 ): dVector2;
begin
  {$hints off} Move(a,Result,sizeof(dVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector4.Implicit( const a: array of double ): dVector4;
var
  L: uint32;
begin
  L := Length(a);
  if (L>4) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(double)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator dVector4.Explicit( const a: array of double ): dVector4;
var
  L: uint32;
begin
  L := Length(a);
  if (L>4) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(double)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

{$endregion}

{$region ' eVector4'}

class operator eVector4.Add( const a: eVector4; const b: eVector4 ): eVector4;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
  Result.W := A.W + B.W;
end;

class operator eVector4.Add( const a: eVector4; const b: extended ): eVector4;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
  Result.W := A.W + B;
end;

class operator eVector4.Add( const a: eVector4; const b: array of extended ): eVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X + b[0];
  Result.Y := a.Y + b[1];
  Result.Z := a.Z + b[2];
  Result.W := a.W + b[3];
end;

class operator eVector4.Add( const a: array of extended; const b: eVector4 ): eVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] + b.X;
  Result.Y := a[1] + b.Y;
  Result.Z := a[2] + b.Z;
  Result.W := a[3] + b.W;
end;

class function eVector4.Create( const X: extended; const Y: extended; const Z: extended; const W: extended ): eVector4;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
  Result.W := W;
end;

class operator eVector4.Divide( const a: eVector4; const b: eVector4 ): eVector4;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
  Result.W := A.W / B.W;
end;

class operator eVector4.Divide( const a: eVector4; const b: extended ): eVector4;
begin
  Result.X := A.X / B;
  Result.Y := A.Y / B;
  Result.Z := A.Z / B;
  Result.W := A.W / B;
end;

class operator eVector4.Divide( const a: eVector4; const b: array of extended ): eVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X / b[0];
  Result.Y := a.Y / b[1];
  Result.Z := a.Z / b[2];
  Result.W := a.W / b[3];
end;

class operator eVector4.Divide( const a: array of extended; const b: eVector4 ): eVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] / b.X;
  Result.Y := a[1] / b.Y;
  Result.Z := a[2] / b.Z;
  Result.W := a[3] / b.W;
end;

function eVector4.dot( const a: eVector4 ): extended;
begin
  Result := (Self.X * A.X) + (Self.Y * A.Y) + (Self.Z * A.Z) + (Self.W * A.W);
end;

function eVector4.magnitude: extended;
begin
  // = Sqrt of vector dot product with self.
  Result := Sqrt( (X*X)+(Y*Y)+(Z*Z)+(W*W) );
end;

class operator eVector4.Multiply( const a: eVector4; const b: array of extended ): eVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X * b[0];
  Result.Y := a.Y * b[1];
  Result.Z := a.Z * b[2];
  Result.W := a.W * b[3];
end;

class operator eVector4.Multiply( const a: array of extended; const b: eVector4 ): eVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] * b.X;
  Result.Y := a[1] * b.Y;
  Result.Z := a[2] * b.Z;
  Result.W := a[3] * b.W;
end;

class operator eVector4.Multiply( const a: eVector4; const b: eVector4 ): eVector4;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
  Result.W := A.W * B.W;
end;

class operator eVector4.Multiply( const a: eVector4; const b: extended ): eVector4;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
  Result.W := A.W * B;
end;

function eVector4.normalized: eVector4;
var
  M: extended;
begin
  M := Self.magnitude;
  Result.X := X / M;
  Result.Y := Y / M;
  Result.Z := Z / M;
  Result.W := W / M;
end;

class operator eVector4.Subtract( const a: eVector4; const b: array of extended ): eVector4;
begin
  if length(b)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a.X - b[0];
  Result.Y := a.Y - b[1];
  Result.Z := a.Z - b[2];
  Result.W := a.W - b[3];
end;

class operator eVector4.Subtract( const a: array of extended; const b: eVector4 ): eVector4;
begin
  if length(a)<>4 then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := a[0] - b.X;
  Result.Y := a[1] - b.Y;
  Result.Z := a[2] - b.Z;
  Result.W := a[3] - b.W;
end;

class operator eVector4.Subtract( const a: eVector4; const b: extended ): eVector4;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
  Result.W := A.W - B;
end;

function eVector4.UnitVector: eVector4;
var
   fMagnitude: extended;
begin
  fMagnitude := Sqrt( (X*X)+(Y*Y)+(Z*Z)+(W*W) );
  Result.X := X / fMagnitude;
  Result.Y := Y / fMagnitude;
  Result.Z := Z / fMagnitude;
  Result.W := W / fMagnitude;
end;

class operator eVector4.Subtract( const a: eVector4; const b: eVector4 ): eVector4;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
  Result.W := A.W - B.W;
end;

class operator eVector4.Explicit( const a: eVector3 ): eVector4;
begin
  {$hints off} Move(a,Result,sizeof(eVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.W := 1;
end;

class operator eVector4.Explicit( const a: eVector2 ): eVector4;
begin
  {$hints off} Move(a,Result,Sizeof(eVector2)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
  Result.W := 1;
end;

class operator eVector4.Implicit( const a: eVector3 ): eVector4;
begin
  {$hints off} Move(a,Result,sizeof(eVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.W := 1;
end;

class operator eVector4.Implicit( const a: eVector2 ): eVector4;
begin
  {$hints off} Move(a,Result,sizeof(eVector3)); {$hints on} //- FPC, Result not initialized (it is)
  Result.Z := 0;
  Result.W := 1;
end;

class operator eVector4.Explicit( const a: eVector4 ): eVector3;
begin
  {$hints off} Move(a,Result,sizeof(eVector3)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator eVector4.Explicit( const a: eVector4 ): eVector2;
begin
  {$hints off} Move(a,Result,sizeof(eVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator eVector4.Implicit( const a: eVector4 ): eVector3;
begin
  {$hints off} Move(a,Result,sizeof(eVector3)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator eVector4.Implicit( const a: eVector4 ): eVector2;
begin
  {$hints off} Move(a,Result,sizeof(eVector2)); {$hints on} //- FPC, Result not initialized (it is)
end;

class operator eVector4.Implicit( const a: array of extended ): eVector4;
var
  L: uint32;
begin
  L := Length(a);
  if (L>4) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  Result.X := A[0];
  Result.Y := A[1];
  Result.Z := A[2];
  Result.W := A[3];
end;

class operator eVector4.Explicit( const a: array of extended ): eVector4;
var
  L: uint32;
begin
  L := Length(a);
  if (L>4) or (L=0) then begin
    TStatus(stInvalidArrayForVector).Raize;
  end;
  {$hints off} Move(A[0],Result,sizeof(extended)*L); {$hints on} //- FPC, Result not initialized (it is)
end;

{$endregion}

{$region ' sMatrix2x2'}

class operator sMatrix2x2.Add( const a: sMatrix2x2; const b: sMatrix2x2 ): sMatrix2x2;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
end;

class operator sMatrix2x2.Add( const a: sMatrix2x2; const b: single ): sMatrix2x2;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
end;

function sMatrix2x2.adjugate: sMatrix2x2;
begin
  Result.m00 := m11;
  Result.m01 := 0-m01;
  Result.m10 := 0-m10;
  Result.m11 := m00;
end;

function sMatrix2x2.cofactor: sMatrix2x2;
begin
  Result.m00 := m11;
  Result.m10 := 0-m01;
  Result.m01 := 0-m10;
  Result.m11 := m00;
end;

class function sMatrix2x2.Create( const _m00: single; const _m10: single; const _m01: single; const _m11: single ): sMatrix2x2;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m01 := _m01;
  Result.m11 := _m11;
end;

function sMatrix2x2.determinant: single;
begin
  Result := (m00 * m11) - (m01 * m10);
end;

class operator sMatrix2x2.Divide( const a: sMatrix2x2; const b: single ): sMatrix2x2;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
end;

class operator sMatrix2x2.Divide( const a: sMatrix2x2; const b: sMatrix2x2 ): sMatrix2x2;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
end;

function sMatrix2x2.dot( const a: sMatrix2x2 ): sMatrix2x2;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11);
end;

function sMatrix2x2.dot( const a: sVector2 ): sVector2;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y);
  Result.Y := (m01 * A.X) + (m11 * A.Y);
end;

class function sMatrix2x2.identity: sMatrix2x2;
begin
  Result := sMatrix2x2.Create
  (
     1, 0,
     0, 1
  );
end;

function sMatrix2x2.inverse: sMatrix2x2;
var
  D: single;
begin
  // Get determinant.
  D := 1 / ((m00 * m11) - (m01 * m10));
  // Adjugate and inverse.
  Result.m00 := m11*D;
  Result.m01 := 0-m01*D;
  Result.m10 := 0-m10*D;
  Result.m11 := m00*D;
end;

class operator sMatrix2x2.Multiply( const a: sMatrix2x2; const b: sMatrix2x2 ): sMatrix2x2;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
end;

class operator sMatrix2x2.Multiply( const a: sMatrix2x2; const b: single ): sMatrix2x2;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
end;

class function sMatrix2x2.rotation( const degrees: single ): sMatrix2x2;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := sMatrix2x2.Create(
    cos(d), -sin(d),
    sin(d), cos(d)
  );
end;

class function sMatrix2x2.scale( const s: sVector2 ): sMatrix2x2;
begin
  Result := sMatrix2x2.Create(
   s.X, 0,
   0,   s.Y
  );
end;

class operator sMatrix2x2.Subtract( const a: sMatrix2x2; const b: single ): sMatrix2x2;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
end;

class function sMatrix2x2.translation( const t: sVector2 ): sMatrix2x2;
begin
  Result := sMatrix2x2.Create(
    1, t.X,
    0, t.Y
  );
end;

function sMatrix2x2.transpose: sMatrix2x2;
begin
  Result := sMatrix2x2.Create(
   m00, m01,
   m10, m11
  );
end;

class operator sMatrix2x2.Subtract( const a: sMatrix2x2; const b: sMatrix2x2 ): sMatrix2x2;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
end;

{$endregion}

{$region ' dMatrix2x2'}

class operator dMatrix2x2.Add( const a: dMatrix2x2; const b: dMatrix2x2 ): dMatrix2x2;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
end;

class operator dMatrix2x2.Add( const a: dMatrix2x2; const b: double ): dMatrix2x2;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
end;

function dMatrix2x2.adjugate: dMatrix2x2;
begin
  Result.m00 := m11;
  Result.m01 := 0-m01;
  Result.m10 := 0-m10;
  Result.m11 := m00;
end;

function dMatrix2x2.cofactor: dMatrix2x2;
begin
  Result.m00 := m11;
  Result.m10 := 0-m01;
  Result.m01 := 0-m10;
  Result.m11 := m00;
end;

class function dMatrix2x2.Create( const _m00: double; const _m10: double; const _m01: double; const _m11: double ): dMatrix2x2;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m01 := _m01;
  Result.m11 := _m11;
end;

function dMatrix2x2.determinant: double;
begin
  Result := (m00 * m11) - (m01 * m10);
end;

class operator dMatrix2x2.Divide( const a: dMatrix2x2; const b: double ): dMatrix2x2;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
end;

class operator dMatrix2x2.Divide( const a: dMatrix2x2; const b: dMatrix2x2 ): dMatrix2x2;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
end;

function dMatrix2x2.dot( const a: dMatrix2x2 ): dMatrix2x2;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11);
end;

function dMatrix2x2.dot( const a: dVector2 ): dVector2;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y);
  Result.Y := (m01 * A.X) + (m11 * A.Y);
end;

class function dMatrix2x2.identity: dMatrix2x2;
begin
  Result := dMatrix2x2.Create
  (
     1, 0,
     0, 1
  );
end;

function dMatrix2x2.inverse: dMatrix2x2;
var
  D: double;
begin
  // Get determinant.
  D := 1 / ((m00 * m11) - (m01 * m10));
  // Adjugate and inverse.
  Result.m00 := m11*D;
  Result.m01 := 0-m01*D;
  Result.m10 := 0-m10*D;
  Result.m11 := m00*D;
end;

class operator dMatrix2x2.Multiply( const a: dMatrix2x2; const b: dMatrix2x2 ): dMatrix2x2;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
end;

class operator dMatrix2x2.Multiply( const a: dMatrix2x2; const b: double ): dMatrix2x2;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
end;

class function dMatrix2x2.rotation( const degrees: double ): dMatrix2x2;
var
  d: double;
begin
  d := degrees*Pi/180;
  Result := dMatrix2x2.Create(
    cos(d), -sin(d),
    sin(d), cos(d)
  );
end;

class function dMatrix2x2.scale( const s: dVector2 ): dMatrix2x2;
begin
  Result := dMatrix2x2.Create(
   s.X, 0,
   0,   s.Y
  );
end;

class operator dMatrix2x2.Subtract( const a: dMatrix2x2; const b: double ): dMatrix2x2;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
end;

class function dMatrix2x2.translation( const t: dVector2 ): dMatrix2x2;
begin
  Result := dMatrix2x2.Create(
    1, t.X,
    0, t.Y
  );
end;

function dMatrix2x2.transpose: dMatrix2x2;
begin
  Result := dMatrix2x2.Create(
   m00, m01,
   m10, m11
  );
end;

class operator dMatrix2x2.Subtract( const a: dMatrix2x2; const b: dMatrix2x2 ): dMatrix2x2;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
end;

{$endregion}

{$region ' eMatrix2x2'}

class operator eMatrix2x2.Add( const a: eMatrix2x2; const b: eMatrix2x2 ): eMatrix2x2;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
end;

class operator eMatrix2x2.Add( const a: eMatrix2x2; const b: extended ): eMatrix2x2;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
end;

function eMatrix2x2.adjugate: eMatrix2x2;
begin
  Result.m00 := m11;
  Result.m01 := 0-m01;
  Result.m10 := 0-m10;
  Result.m11 := m00;
end;

function eMatrix2x2.cofactor: eMatrix2x2;
begin
  Result.m00 := m11;
  Result.m10 := 0-m01;
  Result.m01 := 0-m10;
  Result.m11 := m00;
end;

class function eMatrix2x2.Create( const _m00: extended; const _m10: extended; const _m01: extended; const _m11: extended ): eMatrix2x2;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m01 := _m01;
  Result.m11 := _m11;
end;

function eMatrix2x2.determinant: extended;
begin
  Result := (m00 * m11) - (m01 * m10);
end;

class operator eMatrix2x2.Divide( const a: eMatrix2x2; const b: extended ): eMatrix2x2;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
end;

class operator eMatrix2x2.Divide( const a: eMatrix2x2; const b: eMatrix2x2 ): eMatrix2x2;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
end;

function eMatrix2x2.dot( const a: eMatrix2x2 ): eMatrix2x2;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11);
end;

function eMatrix2x2.dot( const a: eVector2 ): eVector2;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y);
  Result.Y := (m01 * A.X) + (m11 * A.Y);
end;

class function eMatrix2x2.identity: eMatrix2x2;
begin
  Result := eMatrix2x2.Create
  (
     1, 0,
     0, 1
  );
end;

function eMatrix2x2.inverse: eMatrix2x2;
var
  D: extended;
begin
  // Get determinant.
  D := 1 / ((m00 * m11) - (m01 * m10));
  // Adjugate and inverse.
  Result.m00 := m11*D;
  Result.m01 := 0-m01*D;
  Result.m10 := 0-m10*D;
  Result.m11 := m00*D;
end;

class operator eMatrix2x2.Multiply( const a: eMatrix2x2; const b: eMatrix2x2 ): eMatrix2x2;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
end;

class operator eMatrix2x2.Multiply( const a: eMatrix2x2; const b: extended ): eMatrix2x2;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
end;

class function eMatrix2x2.rotation( const degrees: extended ): eMatrix2x2;
var
  d: extended;
begin
  d := degrees*Pi/180;
  Result := eMatrix2x2.Create(
    cos(d), -sin(d),
    sin(d), cos(d)
  );
end;

class function eMatrix2x2.scale( const s: eVector2 ): eMatrix2x2;
begin
  Result := eMatrix2x2.Create(
   s.X, 0,
   0,   s.Y
  );
end;

class operator eMatrix2x2.Subtract( const a: eMatrix2x2; const b: extended ): eMatrix2x2;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
end;

class function eMatrix2x2.translation( const t: eVector2 ): eMatrix2x2;
begin
  Result := eMatrix2x2.Create(
    1, t.X,
    0, t.Y
  );
end;

function eMatrix2x2.transpose: eMatrix2x2;
begin
  Result := eMatrix2x2.Create(
   m00, m01,
   m10, m11
  );
end;

class operator eMatrix2x2.Subtract( const a: eMatrix2x2; const b: eMatrix2x2 ): eMatrix2x2;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
end;

{$endregion}

{$region ' sMatrix3x3'}

class operator sMatrix3x3.Add( const a: sMatrix3x3; const b: sMatrix3x3 ): sMatrix3x3;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m20 := a.m20 + b.m20;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
  Result.m21 := a.m21 + b.m21;
  Result.m02 := a.m02 + b.m02;
  Result.m12 := a.m12 + b.m12;
  Result.m22 := a.m22 + b.m22;
end;

class operator sMatrix3x3.Add( const a: sMatrix3x3; const b: single ): sMatrix3x3;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m20 := a.m20 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
  Result.m21 := a.m21 + b;
  Result.m02 := a.m02 + b;
  Result.m12 := a.m12 + b;
  Result.m22 := a.m22 + b;
end;

function sMatrix3x3.adjugate: sMatrix3x3;
begin
  //- Calculate matrix of minors and co-factor and transpose.
  Result.m00 := ((m11*m22) - (m12*m21));
  Result.m01 := (0 - ((m01*m22) - (m21*m02)));
  Result.m02 := ((m01*m12) - (m11*m02));
  Result.m10 := (0 - ((m10*m22) - (m20*m12)));
  Result.m11 := ((m00*m22) - (m20*m02));
  Result.m12 := (0 - ((m00*m12) - (m10*m02)));
  Result.m20 := ((m10*m21) - (m20*m11));
  Result.m21 := (0 - ((m00*m21) - (m20*m01)));
  Result.m22 := ((m00*m11) - (m10*m01));
end;

function sMatrix3x3.cofactor: sMatrix3x3;
begin
  //- Calculate matrix of minors and co-factor.
  Result.m00 := ((m11*m22) - (m12*m21));
  Result.m10 := (0 - ((m01*m22) - (m21*m02)));
  Result.m20 := ((m01*m12) - (m11*m02));
  Result.m01 := (0 - ((m10*m22) - (m20*m12)));
  Result.m11 := ((m00*m22) - (m20*m02));
  Result.m21 := (0 - ((m00*m12) - (m10*m02)));
  Result.m02 := ((m10*m21) - (m20*m11));
  Result.m12 := (0 - ((m00*m21) - (m20*m01)));
  Result.m22 := ((m00*m11) - (m10*m01));
end;

class function sMatrix3x3.Create( const _m00: single; const _m10: single; const _m20: single; const _m01: single; const _m11: single; const _m21: single; const _m02: single; const _m12: single; const _m22: single ): sMatrix3x3;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m20 := _m20;
  Result.m01 := _m01;
  Result.m11 := _m11;
  Result.m21 := _m21;
  Result.m02 := _m02;
  Result.m12 := _m12;
  Result.m22 := _m22;
end;

function sMatrix3x3.determinant: single;
begin
  Result := ((m00*m11*m22) + (m10*m21*m02) + (m20*m01*m12)) -
            ((m02*m11*m20) + (m12*m21*m00) + (m22*m01*m10));
end;

class operator sMatrix3x3.Divide( const a: sMatrix3x3; const b: single ): sMatrix3x3;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m20 := a.m20 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
  Result.m21 := a.m21 / b;
  Result.m02 := a.m02 / b;
  Result.m12 := a.m12 / b;
  Result.m22 := a.m22 / b;
end;

class operator sMatrix3x3.Divide( const a: sMatrix3x3; const b: sMatrix3x3 ): sMatrix3x3;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m20 := a.m20 / b.m20;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
  Result.m21 := a.m21 / b.m21;
  Result.m02 := a.m02 / b.m02;
  Result.m12 := a.m12 / b.m12;
  Result.m22 := a.m22 / b.m22;
end;

function sMatrix3x3.dot( const a: sMatrix3x3 ): sMatrix3x3;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01) + (m20 * A.m02);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11) + (m20 * A.m12);
  Result.m20 := (m00 * A.m20) + (m10 * A.m21) + (m20 * A.m22);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01) + (m21 * A.m02);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11) + (m21 * A.m12);
  Result.m21 := (m01 * A.m20) + (m11 * A.m21) + (m21 * A.m22);
  Result.m02 := (m02 * A.m00) + (m12 * A.m01) + (m22 * A.m02);
  Result.m12 := (m02 * A.m10) + (m12 * A.m11) + (m22 * A.m12);
  Result.m22 := (m02 * A.m20) + (m12 * A.m21) + (m22 * A.m22);
end;

function sMatrix3x3.dot( const a: sVector3 ): sVector3;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y) + (m20 * A.Z);
  Result.Y := (m01 * A.X) + (m11 * A.Y) + (m21 * A.Z);
  Result.Z := (m02 * A.X) + (m12 * A.Y) + (m22 * A.Z);
end;

class function sMatrix3x3.identity: sMatrix3x3;
begin
  Result := sMatrix3x3.Create
  (
     1, 0, 0,
     0, 1, 0,
     0, 0, 1
  );
end;

function sMatrix3x3.inverse: sMatrix3x3;
var
  D: single;
begin
  //- Calculate determinant
  D := 1 / (((m00 * m11 * m22)    +
             (m10 * m21 * m02)    +
             ( m20 * m01 * m12 )) -
             ((m02 * m11 * m20)   +
             ( m12 * m21 * m00 )  +
             ( m22 * m01 * m10 )));
  //- Calculate matrix of minors and co-factor, transpose for adjugate, and
  //- multiply 1/determinant
  Result.m00 := ((m11*m22) - (m12*m21)) * D;
  Result.m01 := (0 - ((m01*m22) - (m21*m02))) * D;
  Result.m02 := ((m01*m12) - (m11*m02)) * D;
  Result.m10 := (0 - ((m10*m22) - (m20*m12))) * D;
  Result.m11 := ((m00*m22) - (m20*m02)) * D;
  Result.m12 := (0 - ((m00*m12) - (m10*m02))) * D;
  Result.m20 := ((m10*m21) - (m20*m11)) * D;
  Result.m21 := (0 - ((m00*m21) - (m20*m01))) * D;
  Result.m22 := ((m00*m11) - (m10*m01)) * D;
end;

class operator sMatrix3x3.Multiply( const a: sMatrix3x3; const b: sMatrix3x3 ): sMatrix3x3;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m20 := a.m20 * b.m20;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
  Result.m21 := a.m21 * b.m21;
  Result.m02 := a.m02 * b.m02;
  Result.m12 := a.m12 * b.m12;
  Result.m22 := a.m22 * b.m22;
end;

class operator sMatrix3x3.Multiply( const a: sMatrix3x3; const b: single ): sMatrix3x3;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m20 := a.m20 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
  Result.m21 := a.m21 * b;
  Result.m02 := a.m02 * b;
  Result.m12 := a.m12 * b;
  Result.m22 := a.m22 * b;
end;

class function sMatrix3x3.rotationX( const degrees: single ): sMatrix3x3;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := sMatrix3x3.Create(
    1,  0,             0,
    0,  cos(d),  -sin(d),
    0,  sin(d),   cos(d)
  );
end;

class function sMatrix3x3.rotationY( const degrees: single ): sMatrix3x3;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := sMatrix3x3.Create(
    cos(d),   0,  sin(d),
    0,        1,       0,
    -sin(d),  0,  cos(d)
  );
end;

class function sMatrix3x3.rotationZ( const degrees: single ): sMatrix3x3;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := sMatrix3x3.Create(
    cos(d), -sin(d),  0,
    sin(d), cos(d),   0,
    0,            0,  1
  );
end;

class function sMatrix3x3.scale( const s: sVector3 ): sMatrix3x3;
begin
  Result := sMatrix3x3.Create(
   s.X, 0,   0,
   0,   s.Y, 0,
   0,   0,   s.Z
  );
end;

class operator sMatrix3x3.Subtract( const a: sMatrix3x3; const b: single ): sMatrix3x3;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m20 := a.m20 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
  Result.m21 := a.m21 - b;
  Result.m02 := a.m02 - b;
  Result.m12 := a.m12 - b;
  Result.m22 := a.m22 - b;
end;

class function sMatrix3x3.translation( const t: sVector3 ): sMatrix3x3;
begin
  Result := sMatrix3x3.Create(
    1, 0, t.X,
    0, 1, t.Y,
    0, 0, t.Z
  );
end;

function sMatrix3x3.transpose: sMatrix3x3;
begin
  Result := sMatrix3x3.Create(
   m00, m01, m02,
   m10, m11, m12,
   m20, m21, m22
  );
end;

class operator sMatrix3x3.Subtract( const a: sMatrix3x3; const b: sMatrix3x3 ): sMatrix3x3;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m20 := a.m20 - b.m20;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
  Result.m21 := a.m21 - b.m21;
  Result.m02 := a.m02 - b.m02;
  Result.m12 := a.m12 - b.m12;
  Result.m22 := a.m22 - b.m22;
end;


{$endregion}

{$region ' dMatrix3x3'}

class operator dMatrix3x3.Add( const a: dMatrix3x3; const b: dMatrix3x3 ): dMatrix3x3;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m20 := a.m20 + b.m20;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
  Result.m21 := a.m21 + b.m21;
  Result.m02 := a.m02 + b.m02;
  Result.m12 := a.m12 + b.m12;
  Result.m22 := a.m22 + b.m22;
end;

class operator dMatrix3x3.Add( const a: dMatrix3x3; const b: double ): dMatrix3x3;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m20 := a.m20 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
  Result.m21 := a.m21 + b;
  Result.m02 := a.m02 + b;
  Result.m12 := a.m12 + b;
  Result.m22 := a.m22 + b;
end;

function dMatrix3x3.adjugate: dMatrix3x3;
begin
  //- Calculate matrix of minors and co-factor and transpose.
  Result.m00 := ((m11*m22) - (m12*m21));
  Result.m01 := (0 - ((m01*m22) - (m21*m02)));
  Result.m02 := ((m01*m12) - (m11*m02));
  Result.m10 := (0 - ((m10*m22) - (m20*m12)));
  Result.m11 := ((m00*m22) - (m20*m02));
  Result.m12 := (0 - ((m00*m12) - (m10*m02)));
  Result.m20 := ((m10*m21) - (m20*m11));
  Result.m21 := (0 - ((m00*m21) - (m20*m01)));
  Result.m22 := ((m00*m11) - (m10*m01));
end;

function dMatrix3x3.cofactor: dMatrix3x3;
begin
  //- Calculate matrix of minors and co-factor.
  Result.m00 := ((m11*m22) - (m12*m21));
  Result.m10 := (0 - ((m01*m22) - (m21*m02)));
  Result.m20 := ((m01*m12) - (m11*m02));
  Result.m01 := (0 - ((m10*m22) - (m20*m12)));
  Result.m11 := ((m00*m22) - (m20*m02));
  Result.m21 := (0 - ((m00*m12) - (m10*m02)));
  Result.m02 := ((m10*m21) - (m20*m11));
  Result.m12 := (0 - ((m00*m21) - (m20*m01)));
  Result.m22 := ((m00*m11) - (m10*m01));
end;

class function dMatrix3x3.Create( const _m00: double; const _m10: double; const _m20: double; const _m01: double; const _m11: double; const _m21: double; const _m02: double; const _m12: double; const _m22: double ): dMatrix3x3;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m20 := _m20;
  Result.m01 := _m01;
  Result.m11 := _m11;
  Result.m21 := _m21;
  Result.m02 := _m02;
  Result.m12 := _m12;
  Result.m22 := _m22;
end;

function dMatrix3x3.determinant: double;
begin
  Result := ((m00*m11*m22) + (m10*m21*m02) + (m20*m01*m12)) -
            ((m02*m11*m20) + (m12*m21*m00) + (m22*m01*m10));
end;

class operator dMatrix3x3.Divide( const a: dMatrix3x3; const b: double ): dMatrix3x3;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m20 := a.m20 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
  Result.m21 := a.m21 / b;
  Result.m02 := a.m02 / b;
  Result.m12 := a.m12 / b;
  Result.m22 := a.m22 / b;
end;

class operator dMatrix3x3.Divide( const a: dMatrix3x3; const b: dMatrix3x3 ): dMatrix3x3;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m20 := a.m20 / b.m20;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
  Result.m21 := a.m21 / b.m21;
  Result.m02 := a.m02 / b.m02;
  Result.m12 := a.m12 / b.m12;
  Result.m22 := a.m22 / b.m22;
end;

function dMatrix3x3.dot( const a: dMatrix3x3 ): dMatrix3x3;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01) + (m20 * A.m02);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11) + (m20 * A.m12);
  Result.m20 := (m00 * A.m20) + (m10 * A.m21) + (m20 * A.m22);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01) + (m21 * A.m02);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11) + (m21 * A.m12);
  Result.m21 := (m01 * A.m20) + (m11 * A.m21) + (m21 * A.m22);
  Result.m02 := (m02 * A.m00) + (m12 * A.m01) + (m22 * A.m02);
  Result.m12 := (m02 * A.m10) + (m12 * A.m11) + (m22 * A.m12);
  Result.m22 := (m02 * A.m20) + (m12 * A.m21) + (m22 * A.m22);
end;

function dMatrix3x3.dot( const a: dVector3 ): dVector3;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y) + (m20 * A.Z);
  Result.Y := (m01 * A.X) + (m11 * A.Y) + (m21 * A.Z);
  Result.Z := (m02 * A.X) + (m12 * A.Y) + (m22 * A.Z);
end;

class function dMatrix3x3.identity: dMatrix3x3;
begin
  Result := dMatrix3x3.Create
  (
     1, 0, 0,
     0, 1, 0,
     0, 0, 1
  );
end;

function dMatrix3x3.inverse: dMatrix3x3;
var
  D: double;
begin
  //- Calculate determinant
  D := 1 / (((m00 * m11 * m22)    +
             (m10 * m21 * m02)    +
             ( m20 * m01 * m12 )) -
             ((m02 * m11 * m20)   +
             ( m12 * m21 * m00 )  +
             ( m22 * m01 * m10 )));
  //- Calculate matrix of minors and co-factor, transpose for adjugate, and
  //- multiply 1/determinant
  Result.m00 := ((m11*m22) - (m12*m21)) * D;
  Result.m01 := (0 - ((m01*m22) - (m21*m02))) * D;
  Result.m02 := ((m01*m12) - (m11*m02)) * D;
  Result.m10 := (0 - ((m10*m22) - (m20*m12))) * D;
  Result.m11 := ((m00*m22) - (m20*m02)) * D;
  Result.m12 := (0 - ((m00*m12) - (m10*m02))) * D;
  Result.m20 := ((m10*m21) - (m20*m11)) * D;
  Result.m21 := (0 - ((m00*m21) - (m20*m01))) * D;
  Result.m22 := ((m00*m11) - (m10*m01)) * D;
end;

class operator dMatrix3x3.Multiply( const a: dMatrix3x3; const b: dMatrix3x3 ): dMatrix3x3;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m20 := a.m20 * b.m20;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
  Result.m21 := a.m21 * b.m21;
  Result.m02 := a.m02 * b.m02;
  Result.m12 := a.m12 * b.m12;
  Result.m22 := a.m22 * b.m22;
end;

class operator dMatrix3x3.Multiply( const a: dMatrix3x3; const b: double ): dMatrix3x3;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m20 := a.m20 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
  Result.m21 := a.m21 * b;
  Result.m02 := a.m02 * b;
  Result.m12 := a.m12 * b;
  Result.m22 := a.m22 * b;
end;

class function dMatrix3x3.rotationX( const degrees: double ): dMatrix3x3;
var
  d: double;
begin
  d := degrees*Pi/180;
  Result := dMatrix3x3.Create(
    1,  0,             0,
    0,  cos(d),  -sin(d),
    0,  sin(d),   cos(d)
  );
end;

class function dMatrix3x3.rotationY( const degrees: double ): dMatrix3x3;
var
  d: double;
begin
  d := degrees*Pi/180;
  Result := dMatrix3x3.Create(
    cos(d),   0,  sin(d),
    0,        1,       0,
    -sin(d),  0,  cos(d)
  );
end;

class function dMatrix3x3.rotationZ( const degrees: double ): dMatrix3x3;
var
  d: double;
begin
  d := degrees*Pi/180;
  Result := dMatrix3x3.Create(
    cos(d), -sin(d),  0,
    sin(d), cos(d),   0,
    0,            0,  1
  );
end;

class function dMatrix3x3.scale( const s: dVector3 ): dMatrix3x3;
begin
  Result := dMatrix3x3.Create(
   s.X, 0,   0,
   0,   s.Y, 0,
   0,   0,   s.Z
  );
end;

class operator dMatrix3x3.Subtract( const a: dMatrix3x3; const b: double ): dMatrix3x3;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m20 := a.m20 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
  Result.m21 := a.m21 - b;
  Result.m02 := a.m02 - b;
  Result.m12 := a.m12 - b;
  Result.m22 := a.m22 - b;
end;

class function dMatrix3x3.translation( const t: dVector3 ): dMatrix3x3;
begin
  Result := dMatrix3x3.Create(
    1, 0, t.X,
    0, 1, t.Y,
    0, 0, t.Z
  );
end;

function dMatrix3x3.transpose: dMatrix3x3;
begin
  Result := dMatrix3x3.Create(
   m00, m01, m02,
   m10, m11, m12,
   m20, m21, m22
  );
end;

class operator dMatrix3x3.Subtract( const a: dMatrix3x3; const b: dMatrix3x3 ): dMatrix3x3;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m20 := a.m20 - b.m20;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
  Result.m21 := a.m21 - b.m21;
  Result.m02 := a.m02 - b.m02;
  Result.m12 := a.m12 - b.m12;
  Result.m22 := a.m22 - b.m22;
end;


{$endregion}

{$region ' eMatrix3x3'}

class operator eMatrix3x3.Add( const a: eMatrix3x3; const b: eMatrix3x3 ): eMatrix3x3;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m20 := a.m20 + b.m20;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
  Result.m21 := a.m21 + b.m21;
  Result.m02 := a.m02 + b.m02;
  Result.m12 := a.m12 + b.m12;
  Result.m22 := a.m22 + b.m22;
end;

class operator eMatrix3x3.Add( const a: eMatrix3x3; const b: extended ): eMatrix3x3;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m20 := a.m20 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
  Result.m21 := a.m21 + b;
  Result.m02 := a.m02 + b;
  Result.m12 := a.m12 + b;
  Result.m22 := a.m22 + b;
end;

function eMatrix3x3.adjugate: eMatrix3x3;
begin
  //- Calculate matrix of minors and co-factor and transpose.
  Result.m00 := ((m11*m22) - (m12*m21));
  Result.m01 := (0 - ((m01*m22) - (m21*m02)));
  Result.m02 := ((m01*m12) - (m11*m02));
  Result.m10 := (0 - ((m10*m22) - (m20*m12)));
  Result.m11 := ((m00*m22) - (m20*m02));
  Result.m12 := (0 - ((m00*m12) - (m10*m02)));
  Result.m20 := ((m10*m21) - (m20*m11));
  Result.m21 := (0 - ((m00*m21) - (m20*m01)));
  Result.m22 := ((m00*m11) - (m10*m01));
end;

function eMatrix3x3.cofactor: eMatrix3x3;
begin
  //- Calculate matrix of minors and co-factor.
  Result.m00 := ((m11*m22) - (m12*m21));
  Result.m10 := (0 - ((m01*m22) - (m21*m02)));
  Result.m20 := ((m01*m12) - (m11*m02));
  Result.m01 := (0 - ((m10*m22) - (m20*m12)));
  Result.m11 := ((m00*m22) - (m20*m02));
  Result.m21 := (0 - ((m00*m12) - (m10*m02)));
  Result.m02 := ((m10*m21) - (m20*m11));
  Result.m12 := (0 - ((m00*m21) - (m20*m01)));
  Result.m22 := ((m00*m11) - (m10*m01));
end;

class function eMatrix3x3.Create( const _m00: extended; const _m10: extended; const _m20: extended; const _m01: extended; const _m11: extended; const _m21: extended; const _m02: extended; const _m12: extended; const _m22: extended ): eMatrix3x3;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m20 := _m20;
  Result.m01 := _m01;
  Result.m11 := _m11;
  Result.m21 := _m21;
  Result.m02 := _m02;
  Result.m12 := _m12;
  Result.m22 := _m22;
end;

function eMatrix3x3.determinant: extended;
begin
  Result := ((m00*m11*m22) + (m10*m21*m02) + (m20*m01*m12)) -
            ((m02*m11*m20) + (m12*m21*m00) + (m22*m01*m10));
end;

class operator eMatrix3x3.Divide( const a: eMatrix3x3; const b: extended ): eMatrix3x3;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m20 := a.m20 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
  Result.m21 := a.m21 / b;
  Result.m02 := a.m02 / b;
  Result.m12 := a.m12 / b;
  Result.m22 := a.m22 / b;
end;

class operator eMatrix3x3.Divide( const a: eMatrix3x3; const b: eMatrix3x3 ): eMatrix3x3;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m20 := a.m20 / b.m20;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
  Result.m21 := a.m21 / b.m21;
  Result.m02 := a.m02 / b.m02;
  Result.m12 := a.m12 / b.m12;
  Result.m22 := a.m22 / b.m22;
end;

function eMatrix3x3.dot( const a: eMatrix3x3 ): eMatrix3x3;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01) + (m20 * A.m02);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11) + (m20 * A.m12);
  Result.m20 := (m00 * A.m20) + (m10 * A.m21) + (m20 * A.m22);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01) + (m21 * A.m02);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11) + (m21 * A.m12);
  Result.m21 := (m01 * A.m20) + (m11 * A.m21) + (m21 * A.m22);
  Result.m02 := (m02 * A.m00) + (m12 * A.m01) + (m22 * A.m02);
  Result.m12 := (m02 * A.m10) + (m12 * A.m11) + (m22 * A.m12);
  Result.m22 := (m02 * A.m20) + (m12 * A.m21) + (m22 * A.m22);
end;

function eMatrix3x3.dot( const a: eVector3 ): eVector3;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y) + (m20 * A.Z);
  Result.Y := (m01 * A.X) + (m11 * A.Y) + (m21 * A.Z);
  Result.Z := (m02 * A.X) + (m12 * A.Y) + (m22 * A.Z);
end;

class function eMatrix3x3.identity: eMatrix3x3;
begin
  Result := eMatrix3x3.Create
  (
     1, 0, 0,
     0, 1, 0,
     0, 0, 1
  );
end;

function eMatrix3x3.inverse: eMatrix3x3;
var
  D: extended;
begin
  //- Calculate determinant
  D := 1 / (((m00 * m11 * m22)    +
             (m10 * m21 * m02)    +
             ( m20 * m01 * m12 )) -
             ((m02 * m11 * m20)   +
             ( m12 * m21 * m00 )  +
             ( m22 * m01 * m10 )));
  //- Calculate matrix of minors and co-factor, transpose for adjugate, and
  //- multiply 1/determinant
  Result.m00 := ((m11*m22) - (m12*m21)) * D;
  Result.m01 := (0 - ((m01*m22) - (m21*m02))) * D;
  Result.m02 := ((m01*m12) - (m11*m02)) * D;
  Result.m10 := (0 - ((m10*m22) - (m20*m12))) * D;
  Result.m11 := ((m00*m22) - (m20*m02)) * D;
  Result.m12 := (0 - ((m00*m12) - (m10*m02))) * D;
  Result.m20 := ((m10*m21) - (m20*m11)) * D;
  Result.m21 := (0 - ((m00*m21) - (m20*m01))) * D;
  Result.m22 := ((m00*m11) - (m10*m01)) * D;
end;

class operator eMatrix3x3.Multiply( const a: eMatrix3x3; const b: eMatrix3x3 ): eMatrix3x3;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m20 := a.m20 * b.m20;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
  Result.m21 := a.m21 * b.m21;
  Result.m02 := a.m02 * b.m02;
  Result.m12 := a.m12 * b.m12;
  Result.m22 := a.m22 * b.m22;
end;

class operator eMatrix3x3.Multiply( const a: eMatrix3x3; const b: extended ): eMatrix3x3;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m20 := a.m20 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
  Result.m21 := a.m21 * b;
  Result.m02 := a.m02 * b;
  Result.m12 := a.m12 * b;
  Result.m22 := a.m22 * b;
end;

class function eMatrix3x3.rotationX( const degrees: extended ): eMatrix3x3;
var
  d: extended;
begin
  d := degrees*Pi/180;
  Result := eMatrix3x3.Create(
    1,  0,             0,
    0,  cos(d),  -sin(d),
    0,  sin(d),   cos(d)
  );
end;

class function eMatrix3x3.rotationY( const degrees: extended ): eMatrix3x3;
var
  d: extended;
begin
  d := degrees*Pi/180;
  Result := eMatrix3x3.Create(
    cos(d),   0,  sin(d),
    0,        1,       0,
    -sin(d),  0,  cos(d)
  );
end;

class function eMatrix3x3.rotationZ( const degrees: extended ): eMatrix3x3;
var
  d: extended;
begin
  d := degrees*Pi/180;
  Result := eMatrix3x3.Create(
    cos(d), -sin(d),  0,
    sin(d), cos(d),   0,
    0,            0,  1
  );
end;

class function eMatrix3x3.scale( const s: eVector3 ): eMatrix3x3;
begin
  Result := eMatrix3x3.Create(
   s.X, 0,   0,
   0,   s.Y, 0,
   0,   0,   s.Z
  );
end;

class operator eMatrix3x3.Subtract( const a: eMatrix3x3; const b: extended ): eMatrix3x3;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m20 := a.m20 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
  Result.m21 := a.m21 - b;
  Result.m02 := a.m02 - b;
  Result.m12 := a.m12 - b;
  Result.m22 := a.m22 - b;
end;

class function eMatrix3x3.translation( const t: eVector3 ): eMatrix3x3;
begin
  Result := eMatrix3x3.Create(
    1, 0, t.X,
    0, 1, t.Y,
    0, 0, t.Z
  );
end;

function eMatrix3x3.transpose: eMatrix3x3;
begin
  Result := eMatrix3x3.Create(
   m00, m01, m02,
   m10, m11, m12,
   m20, m21, m22
  );
end;

class operator eMatrix3x3.Subtract( const a: eMatrix3x3; const b: eMatrix3x3 ): eMatrix3x3;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m20 := a.m20 - b.m20;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
  Result.m21 := a.m21 - b.m21;
  Result.m02 := a.m02 - b.m02;
  Result.m12 := a.m12 - b.m12;
  Result.m22 := a.m22 - b.m22;
end;


{$endregion}

{$region ' sMatrix4x4'}

class operator sMatrix4x4.Add( const a: sMatrix4x4; const b: sMatrix4x4 ): sMatrix4x4;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m20 := a.m20 + b.m20;
  Result.m30 := a.m30 + b.m30;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
  Result.m21 := a.m21 + b.m21;
  Result.m31 := a.m31 + b.m31;
  Result.m02 := a.m02 + b.m02;
  Result.m12 := a.m12 + b.m12;
  Result.m22 := a.m22 + b.m22;
  Result.m32 := a.m32 + b.m32;
  Result.m03 := a.m03 + b.m03;
  Result.m13 := a.m13 + b.m13;
  Result.m23 := a.m23 + b.m23;
  Result.m33 := a.m33 + b.m33;
end;

class operator sMatrix4x4.Add( const a: sMatrix4x4; const b: single ): sMatrix4x4;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m20 := a.m20 + b;
  Result.m30 := a.m30 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
  Result.m21 := a.m21 + b;
  Result.m31 := a.m31 + b;
  Result.m02 := a.m02 + b;
  Result.m12 := a.m12 + b;
  Result.m22 := a.m22 + b;
  Result.m32 := a.m32 + b;
  Result.m03 := a.m03 + b;
  Result.m13 := a.m13 + b;
  Result.m23 := a.m23 + b;
  Result.m33 := a.m33 + b;
end;

function sMatrix4x4.adjugate: sMatrix4x4;
begin
  //- Calculate matrix of minors and co-factor and transpose
  Result.m00 :=   (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21)));
  Result.m01 := 0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21)));
  Result.m02 :=   (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11)));
  Result.m03 := 0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)));
  Result.m10 := 0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30)+(m23*m32*m10)+(m33*m12*m20)));
  Result.m11 :=   (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30)+(m23*m32*m00)+(m33*m02*m20)));
  Result.m12 := 0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30)+(m13*m32*m00)+(m33*m02*m10)));
  Result.m13 :=   (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20)+(m13*m22*m00)+(m23*m02*m10)));
  Result.m20 :=   (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30)+(m23*m31*m10)+(m33*m11*m20)));
  Result.m21 := 0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30)+(m23*m31*m00)+(m33*m01*m20)));
  Result.m22 :=   (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30)+(m13*m31*m00)+(m33*m01*m10)));
  Result.m23 := 0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20)+(m13*m21*m00)+(m23*m01*m10)));
  Result.m30 := 0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30)+(m22*m31*m10)+(m32*m11*m20)));
  Result.m31 :=   (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30)+(m22*m31*m00)+(m32*m01*m20)));
  Result.m32 := 0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30)+(m13*m31*m00)+(m32*m01*m10)));
  Result.m33 :=   (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20)+(m12*m21*m00)+(m22*m01*m10)));
end;

function sMatrix4x4.cofactor: sMatrix4x4;
begin
  //- Calculate matrix of minors and co-factor.
  Result.m00 :=   (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21)));
  Result.m10 := 0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21)));
  Result.m20 :=   (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11)));
  Result.m30 := 0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)));
  Result.m01 := 0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30)+(m23*m32*m10)+(m33*m12*m20)));
  Result.m11 :=   (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30)+(m23*m32*m00)+(m33*m02*m20)));
  Result.m21 := 0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30)+(m13*m32*m00)+(m33*m02*m10)));
  Result.m31 :=   (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20)+(m13*m22*m00)+(m23*m02*m10)));
  Result.m02 :=   (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30)+(m23*m31*m10)+(m33*m11*m20)));
  Result.m12 := 0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30)+(m23*m31*m00)+(m33*m01*m20)));
  Result.m22 :=   (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30)+(m13*m31*m00)+(m33*m01*m10)));
  Result.m32 := 0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20)+(m13*m21*m00)+(m23*m01*m10)));
  Result.m03 := 0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30)+(m22*m31*m10)+(m32*m11*m20)));
  Result.m13 :=   (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30)+(m22*m31*m00)+(m32*m01*m20)));
  Result.m23 := 0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30)+(m13*m31*m00)+(m32*m01*m10)));
  Result.m33 :=   (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20)+(m12*m21*m00)+(m22*m01*m10)));
end;

class function sMatrix4x4.Create( const _m00: single; const _m10: single; const _m20: single; const _m30: single; const _m01: single; const _m11: single; const _m21: single; const _m31: single; const _m02: single; const _m12: single; const _m22: single; const _m32: single; const _m03: single; const _m13: single; const _m23: single; const _m33: single ): sMatrix4x4;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m20 := _m20;
  Result.m30 := _m30;
  Result.m01 := _m01;
  Result.m11 := _m11;
  Result.m21 := _m21;
  Result.m31 := _m31;
  Result.m02 := _m02;
  Result.m12 := _m12;
  Result.m22 := _m22;
  Result.m32 := _m32;
  Result.m03 := _m03;
  Result.m13 := _m13;
  Result.m23 := _m23;
  Result.m33 := _m33;
end;

class function sMatrix4x4.Create( const Row0: sVector4; const Row1: sVector4; const Row2: sVector4; const Row3: sVector4 ): sMatrix4x4;
begin
  {$hints off} Move(Row0,Result.m00,sizeof(single)*4); {$hints on} //- FPC, Result not initialized (it is)
  Move(Row1,Result.m01,sizeof(single)*4);
  Move(Row2,Result.m02,sizeof(single)*4);
  Move(Row3,Result.m03,sizeof(single)*4);
end;

class function sMatrix4x4.CreatePerspective( const angleDeg: single; const ratio: single; const _near: single; const _far: single ): sMatrix4x4;
var
  tan_half_angle: single;
begin
  tan_half_angle := tan(degtorad(angleDeg)/2);
  Result.m00 := 1 / (ratio*tan_half_angle);
  Result.m10 := 0;
  Result.m20 := 0;
  Result.m30 := 0;
  Result.m01 := 0;
  Result.m11 := 1 / tan_half_angle;
  Result.m21 := 0;
  Result.m31 := 0;
  Result.m02 := 0;
  Result.m12 := 0;
  Result.m22 := (_near+_far)/(_near-_far);
  Result.m32 := (2*_near-_far)/(_near-_far);
  Result.m03 := 0;
  Result.m13 := 0;
  Result.m23 := -1;
  Result.m33 := 0;
end;

class function sMatrix4x4.Create( const Row0: sVector3; const Row1: sVector3; const Row2: sVector3; const Row3: sVector3 ): sMatrix4x4;
begin
  {$hints off} Move(Row0,Result.m00,sizeof(single)*3); {$hints on} //- FPC, Result not initialized (it is)
  Move(Row1,Result.m01,sizeof(single)*3);
  Move(Row2,Result.m02,sizeof(single)*3);
  Move(Row3,Result.m03,sizeof(single)*3);
  Result.m30 := 0;
  Result.m31 := 0;
  Result.m32 := 0;
  Result.m33 := 1;
end;

class function sMatrix4x4.CreateView( const eye: sVector3; const target: sVector3; const Up: sVector3 ): sMatrix4x4;
var
  vz: sVector3;
  vx: sVector3;
  vy: sVector3;
begin
  vz := (eye-target).normalized;
  vx := up.cross(vz).normalized;
  vy := vz.cross(vx);
  Result := sMatrix4x4.Create(
              vx.X,           VY.X,           vZ.X, 0,
              vx.Y,           VY.y,           VZ.y, 0,
              vx.Z,           VY.Z,           VZ.Z, 0,
    -(vx.dot(eye)), -(vy.dot(eye)), -(vz.dot(eye)), 1 ).transpose;
end;

function sMatrix4x4.determinant: single;
begin
  Result :=
  (m00 *    (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21))))  +
  (m10 * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21))))) +
  (m20 *    (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11))))  +
  (m30 * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)))));
end;

class operator sMatrix4x4.Divide( const a: sMatrix4x4; const b: single ): sMatrix4x4;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m20 := a.m20 / b;
  Result.m30 := a.m30 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
  Result.m21 := a.m21 / b;
  Result.m31 := a.m31 / b;
  Result.m02 := a.m02 / b;
  Result.m12 := a.m12 / b;
  Result.m22 := a.m22 / b;
  Result.m32 := a.m32 / b;
  Result.m03 := a.m03 / b;
  Result.m13 := a.m13 / b;
  Result.m23 := a.m23 / b;
  Result.m33 := a.m33 / b;
end;

class operator sMatrix4x4.Divide( const a: sMatrix4x4; const b: sMatrix4x4 ): sMatrix4x4;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m20 := a.m20 / b.m20;
  Result.m30 := a.m30 / b.m30;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
  Result.m21 := a.m21 / b.m21;
  Result.m31 := a.m31 / b.m31;
  Result.m02 := a.m02 / b.m02;
  Result.m12 := a.m12 / b.m12;
  Result.m22 := a.m22 / b.m22;
  Result.m32 := a.m32 / b.m32;
  Result.m03 := a.m03 / b.m03;
  Result.m13 := a.m13 / b.m13;
  Result.m23 := a.m23 / b.m23;
  Result.m33 := a.m33 / b.m33;
end;

function sMatrix4x4.dot( const a: sMatrix4x4 ): sMatrix4x4;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01) + (m20 * A.m02) + (m30 * A.m03);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11) + (m20 * A.m12) + (m30 * A.m13);
  Result.m20 := (m00 * A.m20) + (m10 * A.m21) + (m20 * A.m22) + (m30 * A.m23);
  Result.m30 := (m00 * A.m30) + (m10 * A.m31) + (m20 * A.m32) + (m30 * A.m33);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01) + (m21 * A.m02) + (m31 * A.m03);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11) + (m21 * A.m12) + (m31 * A.m13);
  Result.m21 := (m01 * A.m20) + (m11 * A.m21) + (m21 * A.m22) + (m31 * A.m23);
  Result.m31 := (m01 * A.m30) + (m11 * A.m31) + (m21 * A.m32) + (m31 * A.m33);
  Result.m02 := (m02 * A.m00) + (m12 * A.m01) + (m22 * A.m02) + (m32 * A.m03);
  Result.m12 := (m02 * A.m10) + (m12 * A.m11) + (m22 * A.m12) + (m32 * A.m13);
  Result.m22 := (m02 * A.m20) + (m12 * A.m21) + (m22 * A.m22) + (m32 * A.m23);
  Result.m32 := (m02 * A.m30) + (m12 * A.m31) + (m22 * A.m32) + (m32 * A.m33);
  Result.m03 := (m03 * A.m00) + (m13 * A.m01) + (m23 * A.m02) + (m33 * A.m03);
  Result.m13 := (m03 * A.m10) + (m13 * A.m11) + (m23 * A.m12) + (m33 * A.m13);
  Result.m23 := (m03 * A.m20) + (m13 * A.m21) + (m23 * A.m22) + (m33 * A.m23);
  Result.m33 := (m03 * A.m30) + (m13 * A.m31) + (m23 * A.m32) + (m33 * A.m33);
end;

function sMatrix4x4.dot( const a: sVector4 ): sVector4;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y) + (m20 * A.Z) + (m30 * A.W);
  Result.Y := (m01 * A.X) + (m11 * A.Y) + (m21 * A.Z) + (m31 * A.W);
  Result.Z := (m02 * A.X) + (m12 * A.Y) + (m22 * A.Z) + (m32 * A.W);
  Result.W := (m03 * A.X) + (m13 * A.Y) + (m23 * A.Z) + (m33 * A.W);
end;

class function sMatrix4x4.identity: sMatrix4x4;
begin
  Result := sMatrix4x4.Create
  (
     1, 0, 0, 0,
     0, 1, 0, 0,
     0, 0, 1, 0,
     0, 0, 0, 1
  );
end;

function sMatrix4x4.inverse: sMatrix4x4;
var
  D: single;
begin
  D := (
    (m00 *    (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31) + (m23*m32*m11)+(m33*m12*m21))))  +
    (m10 * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31) + (m23*m32*m01)+(m33*m02*m21))))) +
    (m20 *    (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31) + (m13*m32*m01)+(m33*m02*m11))))  +
    (m30 * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21) + (m13*m22*m01)+(m23*m02*m11)))))
  );
  if (D=0) then begin
    exit;    // ought not be necessary, but... life isn't always fair.
  end;
  D := 1/D;
  //- Calculate matrix of minors and co-factor, transpose for adjugate, and
  //- multiply 1/determinant
  //- Calculate matrix of minors and co-factor and transpose
  Result.m00 := D * (  (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31) + (m23*m32*m11)+(m33*m12*m21))));
  Result.m01 := D * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31) + (m23*m32*m01)+(m33*m02*m21))));
  Result.m02 := D * (  (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31) + (m13*m32*m01)+(m33*m02*m11))));
  Result.m03 := D * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21) + (m13*m22*m01)+(m23*m02*m11))));
  Result.m10 := D * (0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30) + (m23*m32*m10)+(m33*m12*m20))));
  Result.m11 := D * (  (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30) + (m23*m32*m00)+(m33*m02*m20))));
  Result.m12 := D * (0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30) + (m13*m32*m00)+(m33*m02*m10))));
  Result.m13 := D * (  (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20) + (m13*m22*m00)+(m23*m02*m10))));
  Result.m20 := D * (  (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30) + (m23*m31*m10)+(m33*m11*m20))));
  Result.m21 := D * (0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30) + (m23*m31*m00)+(m33*m01*m20))));
  Result.m22 := D * (  (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30) + (m13*m31*m00)+(m33*m01*m10))));
  Result.m23 := D * (0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20) + (m13*m21*m00)+(m23*m01*m10))));
  Result.m30 := D * (0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30) + (m22*m31*m10)+(m32*m11*m20))));
  Result.m31 := D * (  (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30) + (m22*m31*m00)+(m32*m01*m20))));
  Result.m32 := D * (0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30) + (m13*m31*m00)+(m32*m01*m10))));
  Result.m33 := D * (  (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20) + (m12*m21*m00)+(m22*m01*m10))));
end;

class operator sMatrix4x4.Multiply( const a: sMatrix4x4; const b: sMatrix4x4 ): sMatrix4x4;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m20 := a.m20 * b.m20;
  Result.m30 := a.m30 * b.m30;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
  Result.m21 := a.m21 * b.m21;
  Result.m31 := a.m31 * b.m31;
  Result.m02 := a.m02 * b.m02;
  Result.m12 := a.m12 * b.m12;
  Result.m22 := a.m22 * b.m22;
  Result.m32 := a.m32 * b.m32;
  Result.m03 := a.m03 * b.m03;
  Result.m13 := a.m13 * b.m13;
  Result.m23 := a.m23 * b.m23;
  Result.m33 := a.m33 * b.m33;
end;

class operator sMatrix4x4.Multiply( const a: sMatrix4x4; const b: single ): sMatrix4x4;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m20 := a.m20 * b;
  Result.m30 := a.m30 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
  Result.m21 := a.m21 * b;
  Result.m31 := a.m31 * b;
  Result.m02 := a.m02 * b;
  Result.m12 := a.m12 * b;
  Result.m22 := a.m22 * b;
  Result.m32 := a.m32 * b;
  Result.m03 := a.m03 * b;
  Result.m13 := a.m13 * b;
  Result.m23 := a.m23 * b;
  Result.m33 := a.m33 * b;
end;

class function sMatrix4x4.rotationX( const degrees: single ): sMatrix4x4;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := sMatrix4x4.Create(
    1,  0,             0,  0,
    0,  cos(d),  -sin(d),  0,
    0,  sin(d),   cos(d),  0,
    0,  0,             0,  1
  );
end;

class function sMatrix4x4.rotationY( const degrees: single ): sMatrix4x4;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := sMatrix4x4.Create(
    cos(d),   0,  sin(d),  0,
    0,        1,       0,  0,
    -sin(d),  0,  cos(d),  0,
    0,        0,       0,  1
  );
end;

class function sMatrix4x4.rotationZ( const degrees: single ): sMatrix4x4;
var
  d: single;
begin
  d := degrees*Pi/180;
  Result := sMatrix4x4.Create(
    cos(d), -sin(d),  0,  0,
    sin(d), cos(d),   0,  0,
    0,            0,  1,  0,
    0,            0,  0,  1
  );
end;

class function sMatrix4x4.scale( const s: sVector3 ): sMatrix4x4;
begin
  Result := sMatrix4x4.Create(
   s.X, 0,   0,   0,
   0,   s.Y, 0,   0,
   0,   0,   s.Z, 0,
   0,   0,   0,   1
  );
end;

class operator sMatrix4x4.Subtract( const a: sMatrix4x4; const b: single ): sMatrix4x4;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m20 := a.m20 - b;
  Result.m30 := a.m30 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
  Result.m21 := a.m21 - b;
  Result.m31 := a.m31 - b;
  Result.m02 := a.m02 - b;
  Result.m12 := a.m12 - b;
  Result.m22 := a.m22 - b;
  Result.m32 := a.m32 - b;
  Result.m03 := a.m03 - b;
  Result.m13 := a.m13 - b;
  Result.m23 := a.m23 - b;
  Result.m33 := a.m33 - b;
end;

class function sMatrix4x4.translation( const t: sVector3 ): sMatrix4x4;
begin
  Result := sMatrix4x4.Create(
    1, 0, 0, t.X,
    0, 1, 0, t.Y,
    0, 0, 1, t.Z,
    0, 0, 0, 1
  );
end;

function sMatrix4x4.transpose: sMatrix4x4;
begin
  Result := sMatrix4x4.Create(
   m00, m01, m02, m03,
   m10, m11, m12, m13,
   m20, m21, m22, m23,
   m30, m31, m32, m33
  );
end;

class operator sMatrix4x4.Subtract( const a: sMatrix4x4; const b: sMatrix4x4 ): sMatrix4x4;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m20 := a.m20 - b.m20;
  Result.m30 := a.m30 - b.m30;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
  Result.m21 := a.m21 - b.m21;
  Result.m31 := a.m31 - b.m31;
  Result.m02 := a.m02 - b.m02;
  Result.m12 := a.m12 - b.m12;
  Result.m22 := a.m22 - b.m22;
  Result.m32 := a.m32 - b.m32;
  Result.m03 := a.m03 - b.m03;
  Result.m13 := a.m13 - b.m13;
  Result.m23 := a.m23 - b.m23;
  Result.m33 := a.m33 - b.m33;
end;

{$endregion}

{$region ' dMatrix4x4'}

class operator dMatrix4x4.Add( const a: dMatrix4x4; const b: dMatrix4x4 ): dMatrix4x4;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m20 := a.m20 + b.m20;
  Result.m30 := a.m30 + b.m30;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
  Result.m21 := a.m21 + b.m21;
  Result.m31 := a.m31 + b.m31;
  Result.m02 := a.m02 + b.m02;
  Result.m12 := a.m12 + b.m12;
  Result.m22 := a.m22 + b.m22;
  Result.m32 := a.m32 + b.m32;
  Result.m03 := a.m03 + b.m03;
  Result.m13 := a.m13 + b.m13;
  Result.m23 := a.m23 + b.m23;
  Result.m33 := a.m33 + b.m33;
end;

class operator dMatrix4x4.Add( const a: dMatrix4x4; const b: double ): dMatrix4x4;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m20 := a.m20 + b;
  Result.m30 := a.m30 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
  Result.m21 := a.m21 + b;
  Result.m31 := a.m31 + b;
  Result.m02 := a.m02 + b;
  Result.m12 := a.m12 + b;
  Result.m22 := a.m22 + b;
  Result.m32 := a.m32 + b;
  Result.m03 := a.m03 + b;
  Result.m13 := a.m13 + b;
  Result.m23 := a.m23 + b;
  Result.m33 := a.m33 + b;
end;

function dMatrix4x4.adjugate: dMatrix4x4;
begin
  //- Calculate matrix of minors and co-factor and transpose
  Result.m00 :=   (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21)));
  Result.m01 := 0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21)));
  Result.m02 :=   (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11)));
  Result.m03 := 0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)));
  Result.m10 := 0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30)+(m23*m32*m10)+(m33*m12*m20)));
  Result.m11 :=   (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30)+(m23*m32*m00)+(m33*m02*m20)));
  Result.m12 := 0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30)+(m13*m32*m00)+(m33*m02*m10)));
  Result.m13 :=   (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20)+(m13*m22*m00)+(m23*m02*m10)));
  Result.m20 :=   (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30)+(m23*m31*m10)+(m33*m11*m20)));
  Result.m21 := 0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30)+(m23*m31*m00)+(m33*m01*m20)));
  Result.m22 :=   (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30)+(m13*m31*m00)+(m33*m01*m10)));
  Result.m23 := 0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20)+(m13*m21*m00)+(m23*m01*m10)));
  Result.m30 := 0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30)+(m22*m31*m10)+(m32*m11*m20)));
  Result.m31 :=   (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30)+(m22*m31*m00)+(m32*m01*m20)));
  Result.m32 := 0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30)+(m13*m31*m00)+(m32*m01*m10)));
  Result.m33 :=   (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20)+(m12*m21*m00)+(m22*m01*m10)));
end;

function dMatrix4x4.cofactor: dMatrix4x4;
begin
  //- Calculate matrix of minors and co-factor.
  Result.m00 :=   (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21)));
  Result.m10 := 0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21)));
  Result.m20 :=   (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11)));
  Result.m30 := 0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)));
  Result.m01 := 0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30)+(m23*m32*m10)+(m33*m12*m20)));
  Result.m11 :=   (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30)+(m23*m32*m00)+(m33*m02*m20)));
  Result.m21 := 0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30)+(m13*m32*m00)+(m33*m02*m10)));
  Result.m31 :=   (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20)+(m13*m22*m00)+(m23*m02*m10)));
  Result.m02 :=   (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30)+(m23*m31*m10)+(m33*m11*m20)));
  Result.m12 := 0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30)+(m23*m31*m00)+(m33*m01*m20)));
  Result.m22 :=   (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30)+(m13*m31*m00)+(m33*m01*m10)));
  Result.m32 := 0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20)+(m13*m21*m00)+(m23*m01*m10)));
  Result.m03 := 0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30)+(m22*m31*m10)+(m32*m11*m20)));
  Result.m13 :=   (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30)+(m22*m31*m00)+(m32*m01*m20)));
  Result.m23 := 0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30)+(m13*m31*m00)+(m32*m01*m10)));
  Result.m33 :=   (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20)+(m12*m21*m00)+(m22*m01*m10)));
end;

class function dMatrix4x4.Create( const _m00: double; const _m10: double; const _m20: double; const _m30: double; const _m01: double; const _m11: double; const _m21: double; const _m31: double; const _m02: double; const _m12: double; const _m22: double; const _m32: double; const _m03: double; const _m13: double; const _m23: double; const _m33: double ): dMatrix4x4;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m20 := _m20;
  Result.m30 := _m30;
  Result.m01 := _m01;
  Result.m11 := _m11;
  Result.m21 := _m21;
  Result.m31 := _m31;
  Result.m02 := _m02;
  Result.m12 := _m12;
  Result.m22 := _m22;
  Result.m32 := _m32;
  Result.m03 := _m03;
  Result.m13 := _m13;
  Result.m23 := _m23;
  Result.m33 := _m33;
end;

class function dMatrix4x4.Create( const Row0: dVector4; const Row1: dVector4; const Row2: dVector4; const Row3: dVector4 ): dMatrix4x4;
begin
  {$hints off} Move(Row0,Result.m00,sizeof(double)*4); {$hints on} //- FPC, Result not initialized (it is)
  Move(Row1,Result.m01,sizeof(double)*4);
  Move(Row2,Result.m02,sizeof(double)*4);
  Move(Row3,Result.m03,sizeof(double)*4);
end;

class function dMatrix4x4.CreatePerspective( const angleDeg: double; const ratio: double; const _near: double; const _far: double ): dMatrix4x4;
var
  tan_half_angle: double;
begin
  tan_half_angle := tan(degtorad(angleDeg)/2);
  Result.m00 := 1 / (ratio*tan_half_angle);
  Result.m10 := 0;
  Result.m20 := 0;
  Result.m30 := 0;
  Result.m01 := 0;
  Result.m11 := 1 / tan_half_angle;
  Result.m21 := 0;
  Result.m31 := 0;
  Result.m02 := 0;
  Result.m12 := 0;
  Result.m22 := (_near+_far)/(_near-_far);
  Result.m32 := (2*_near-_far)/(_near-_far);
  Result.m03 := 0;
  Result.m13 := 0;
  Result.m23 := -1;
  Result.m33 := 0;
end;

class function dMatrix4x4.Create( const Row0: dVector3; const Row1: dVector3; const Row2: dVector3; const Row3: dVector3 ): dMatrix4x4;
begin
  {$hints off} Move(Row0,Result.m00,sizeof(double)*3); {$hints on} //- FPC, Result not initialized (it is)
  Move(Row1,Result.m01,sizeof(double)*3);
  Move(Row2,Result.m02,sizeof(double)*3);
  Move(Row3,Result.m03,sizeof(double)*3);
  Result.m30 := 0;
  Result.m31 := 0;
  Result.m32 := 0;
  Result.m33 := 1;
end;

class function dMatrix4x4.CreateView( const eye: dVector3; const target: dVector3; const Up: dVector3 ): dMatrix4x4;
var
  vz: dVector3;
  vx: dVector3;
  vy: dVector3;
begin
  vz := (eye-target).normalized;
  vx := up.cross(vz).normalized;
  vy := vz.cross(vx);
  Result := dMatrix4x4.Create(
              vx.X,           VY.X,           vZ.X, 0,
              vx.Y,           VY.y,           VZ.y, 0,
              vx.Z,           VY.Z,           VZ.Z, 0,
    -(vx.dot(eye)), -(vy.dot(eye)), -(vz.dot(eye)), 1 ).transpose;
end;

function dMatrix4x4.determinant: double;
begin
  Result :=
  (m00 *    (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21))))  +
  (m10 * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21))))) +
  (m20 *    (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11))))  +
  (m30 * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)))));
end;

class operator dMatrix4x4.Divide( const a: dMatrix4x4; const b: double ): dMatrix4x4;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m20 := a.m20 / b;
  Result.m30 := a.m30 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
  Result.m21 := a.m21 / b;
  Result.m31 := a.m31 / b;
  Result.m02 := a.m02 / b;
  Result.m12 := a.m12 / b;
  Result.m22 := a.m22 / b;
  Result.m32 := a.m32 / b;
  Result.m03 := a.m03 / b;
  Result.m13 := a.m13 / b;
  Result.m23 := a.m23 / b;
  Result.m33 := a.m33 / b;
end;

class operator dMatrix4x4.Divide( const a: dMatrix4x4; const b: dMatrix4x4 ): dMatrix4x4;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m20 := a.m20 / b.m20;
  Result.m30 := a.m30 / b.m30;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
  Result.m21 := a.m21 / b.m21;
  Result.m31 := a.m31 / b.m31;
  Result.m02 := a.m02 / b.m02;
  Result.m12 := a.m12 / b.m12;
  Result.m22 := a.m22 / b.m22;
  Result.m32 := a.m32 / b.m32;
  Result.m03 := a.m03 / b.m03;
  Result.m13 := a.m13 / b.m13;
  Result.m23 := a.m23 / b.m23;
  Result.m33 := a.m33 / b.m33;
end;

function dMatrix4x4.dot( const a: dMatrix4x4 ): dMatrix4x4;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01) + (m20 * A.m02) + (m30 * A.m03);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11) + (m20 * A.m12) + (m30 * A.m13);
  Result.m20 := (m00 * A.m20) + (m10 * A.m21) + (m20 * A.m22) + (m30 * A.m23);
  Result.m30 := (m00 * A.m30) + (m10 * A.m31) + (m20 * A.m32) + (m30 * A.m33);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01) + (m21 * A.m02) + (m31 * A.m03);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11) + (m21 * A.m12) + (m31 * A.m13);
  Result.m21 := (m01 * A.m20) + (m11 * A.m21) + (m21 * A.m22) + (m31 * A.m23);
  Result.m31 := (m01 * A.m30) + (m11 * A.m31) + (m21 * A.m32) + (m31 * A.m33);
  Result.m02 := (m02 * A.m00) + (m12 * A.m01) + (m22 * A.m02) + (m32 * A.m03);
  Result.m12 := (m02 * A.m10) + (m12 * A.m11) + (m22 * A.m12) + (m32 * A.m13);
  Result.m22 := (m02 * A.m20) + (m12 * A.m21) + (m22 * A.m22) + (m32 * A.m23);
  Result.m32 := (m02 * A.m30) + (m12 * A.m31) + (m22 * A.m32) + (m32 * A.m33);
  Result.m03 := (m03 * A.m00) + (m13 * A.m01) + (m23 * A.m02) + (m33 * A.m03);
  Result.m13 := (m03 * A.m10) + (m13 * A.m11) + (m23 * A.m12) + (m33 * A.m13);
  Result.m23 := (m03 * A.m20) + (m13 * A.m21) + (m23 * A.m22) + (m33 * A.m23);
  Result.m33 := (m03 * A.m30) + (m13 * A.m31) + (m23 * A.m32) + (m33 * A.m33);
end;

function dMatrix4x4.dot( const a: dVector4 ): dVector4;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y) + (m20 * A.Z) + (m30 * A.W);
  Result.Y := (m01 * A.X) + (m11 * A.Y) + (m21 * A.Z) + (m31 * A.W);
  Result.Z := (m02 * A.X) + (m12 * A.Y) + (m22 * A.Z) + (m32 * A.W);
  Result.W := (m03 * A.X) + (m13 * A.Y) + (m23 * A.Z) + (m33 * A.W);
end;

class function dMatrix4x4.identity: dMatrix4x4;
begin
  Result := dMatrix4x4.Create
  (
     1, 0, 0, 0,
     0, 1, 0, 0,
     0, 0, 1, 0,
     0, 0, 0, 1
  );
end;

function dMatrix4x4.inverse: dMatrix4x4;
var
  D: double;
begin
  D := (
    (m00 *    (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31) + (m23*m32*m11)+(m33*m12*m21))))  +
    (m10 * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31) + (m23*m32*m01)+(m33*m02*m21))))) +
    (m20 *    (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31) + (m13*m32*m01)+(m33*m02*m11))))  +
    (m30 * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21) + (m13*m22*m01)+(m23*m02*m11)))))
  );
  if (D=0) then begin
    exit;    // ought not be necessary, but... life isn't always fair.
  end;
  D := 1/D;
  //- Calculate matrix of minors and co-factor, transpose for adjugate, and
  //- multiply 1/determinant
  //- Calculate matrix of minors and co-factor and transpose
  Result.m00 := D * (  (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31) + (m23*m32*m11)+(m33*m12*m21))));
  Result.m01 := D * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31) + (m23*m32*m01)+(m33*m02*m21))));
  Result.m02 := D * (  (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31) + (m13*m32*m01)+(m33*m02*m11))));
  Result.m03 := D * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21) + (m13*m22*m01)+(m23*m02*m11))));
  Result.m10 := D * (0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30) + (m23*m32*m10)+(m33*m12*m20))));
  Result.m11 := D * (  (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30) + (m23*m32*m00)+(m33*m02*m20))));
  Result.m12 := D * (0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30) + (m13*m32*m00)+(m33*m02*m10))));
  Result.m13 := D * (  (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20) + (m13*m22*m00)+(m23*m02*m10))));
  Result.m20 := D * (  (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30) + (m23*m31*m10)+(m33*m11*m20))));
  Result.m21 := D * (0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30) + (m23*m31*m00)+(m33*m01*m20))));
  Result.m22 := D * (  (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30) + (m13*m31*m00)+(m33*m01*m10))));
  Result.m23 := D * (0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20) + (m13*m21*m00)+(m23*m01*m10))));
  Result.m30 := D * (0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30) + (m22*m31*m10)+(m32*m11*m20))));
  Result.m31 := D * (  (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30) + (m22*m31*m00)+(m32*m01*m20))));
  Result.m32 := D * (0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30) + (m13*m31*m00)+(m32*m01*m10))));
  Result.m33 := D * (  (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20) + (m12*m21*m00)+(m22*m01*m10))));
end;

class operator dMatrix4x4.Multiply( const a: dMatrix4x4; const b: dMatrix4x4 ): dMatrix4x4;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m20 := a.m20 * b.m20;
  Result.m30 := a.m30 * b.m30;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
  Result.m21 := a.m21 * b.m21;
  Result.m31 := a.m31 * b.m31;
  Result.m02 := a.m02 * b.m02;
  Result.m12 := a.m12 * b.m12;
  Result.m22 := a.m22 * b.m22;
  Result.m32 := a.m32 * b.m32;
  Result.m03 := a.m03 * b.m03;
  Result.m13 := a.m13 * b.m13;
  Result.m23 := a.m23 * b.m23;
  Result.m33 := a.m33 * b.m33;
end;

class operator dMatrix4x4.Multiply( const a: dMatrix4x4; const b: double ): dMatrix4x4;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m20 := a.m20 * b;
  Result.m30 := a.m30 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
  Result.m21 := a.m21 * b;
  Result.m31 := a.m31 * b;
  Result.m02 := a.m02 * b;
  Result.m12 := a.m12 * b;
  Result.m22 := a.m22 * b;
  Result.m32 := a.m32 * b;
  Result.m03 := a.m03 * b;
  Result.m13 := a.m13 * b;
  Result.m23 := a.m23 * b;
  Result.m33 := a.m33 * b;
end;

class function dMatrix4x4.rotationX( const degrees: double ): dMatrix4x4;
var
  d: double;
begin
  d := degrees*Pi/180;
  Result := dMatrix4x4.Create(
    1,  0,             0,  0,
    0,  cos(d),  -sin(d),  0,
    0,  sin(d),   cos(d),  0,
    0,  0,             0,  1
  );
end;

class function dMatrix4x4.rotationY( const degrees: double ): dMatrix4x4;
var
  d: double;
begin
  d := degrees*Pi/180;
  Result := dMatrix4x4.Create(
    cos(d),   0,  sin(d),  0,
    0,        1,       0,  0,
    -sin(d),  0,  cos(d),  0,
    0,        0,       0,  1
  );
end;

class function dMatrix4x4.rotationZ( const degrees: double ): dMatrix4x4;
var
  d: double;
begin
  d := degrees*Pi/180;
  Result := dMatrix4x4.Create(
    cos(d), -sin(d),  0,  0,
    sin(d), cos(d),   0,  0,
    0,            0,  1,  0,
    0,            0,  0,  1
  );
end;

class function dMatrix4x4.scale( const s: dVector3 ): dMatrix4x4;
begin
  Result := dMatrix4x4.Create(
   s.X, 0,   0,   0,
   0,   s.Y, 0,   0,
   0,   0,   s.Z, 0,
   0,   0,   0,   1
  );
end;

class operator dMatrix4x4.Subtract( const a: dMatrix4x4; const b: double ): dMatrix4x4;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m20 := a.m20 - b;
  Result.m30 := a.m30 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
  Result.m21 := a.m21 - b;
  Result.m31 := a.m31 - b;
  Result.m02 := a.m02 - b;
  Result.m12 := a.m12 - b;
  Result.m22 := a.m22 - b;
  Result.m32 := a.m32 - b;
  Result.m03 := a.m03 - b;
  Result.m13 := a.m13 - b;
  Result.m23 := a.m23 - b;
  Result.m33 := a.m33 - b;
end;

class function dMatrix4x4.translation( const t: dVector3 ): dMatrix4x4;
begin
  Result := dMatrix4x4.Create(
    1, 0, 0, t.X,
    0, 1, 0, t.Y,
    0, 0, 1, t.Z,
    0, 0, 0, 1
  );
end;

function dMatrix4x4.transpose: dMatrix4x4;
begin
  Result := dMatrix4x4.Create(
   m00, m01, m02, m03,
   m10, m11, m12, m13,
   m20, m21, m22, m23,
   m30, m31, m32, m33
  );
end;

class operator dMatrix4x4.Subtract( const a: dMatrix4x4; const b: dMatrix4x4 ): dMatrix4x4;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m20 := a.m20 - b.m20;
  Result.m30 := a.m30 - b.m30;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
  Result.m21 := a.m21 - b.m21;
  Result.m31 := a.m31 - b.m31;
  Result.m02 := a.m02 - b.m02;
  Result.m12 := a.m12 - b.m12;
  Result.m22 := a.m22 - b.m22;
  Result.m32 := a.m32 - b.m32;
  Result.m03 := a.m03 - b.m03;
  Result.m13 := a.m13 - b.m13;
  Result.m23 := a.m23 - b.m23;
  Result.m33 := a.m33 - b.m33;
end;

{$endregion}

{$region ' eMatrix4x4'}

class operator eMatrix4x4.Add( const a: eMatrix4x4; const b: eMatrix4x4 ): eMatrix4x4;
begin
  Result.m00 := a.m00 + b.m00;
  Result.m10 := a.m10 + b.m10;
  Result.m20 := a.m20 + b.m20;
  Result.m30 := a.m30 + b.m30;
  Result.m01 := a.m01 + b.m01;
  Result.m11 := a.m11 + b.m11;
  Result.m21 := a.m21 + b.m21;
  Result.m31 := a.m31 + b.m31;
  Result.m02 := a.m02 + b.m02;
  Result.m12 := a.m12 + b.m12;
  Result.m22 := a.m22 + b.m22;
  Result.m32 := a.m32 + b.m32;
  Result.m03 := a.m03 + b.m03;
  Result.m13 := a.m13 + b.m13;
  Result.m23 := a.m23 + b.m23;
  Result.m33 := a.m33 + b.m33;
end;

class operator eMatrix4x4.Add( const a: eMatrix4x4; const b: extended ): eMatrix4x4;
begin
  Result.m00 := a.m00 + b;
  Result.m10 := a.m10 + b;
  Result.m20 := a.m20 + b;
  Result.m30 := a.m30 + b;
  Result.m01 := a.m01 + b;
  Result.m11 := a.m11 + b;
  Result.m21 := a.m21 + b;
  Result.m31 := a.m31 + b;
  Result.m02 := a.m02 + b;
  Result.m12 := a.m12 + b;
  Result.m22 := a.m22 + b;
  Result.m32 := a.m32 + b;
  Result.m03 := a.m03 + b;
  Result.m13 := a.m13 + b;
  Result.m23 := a.m23 + b;
  Result.m33 := a.m33 + b;
end;

function eMatrix4x4.adjugate: eMatrix4x4;
begin
  //- Calculate matrix of minors and co-factor and transpose
  Result.m00 :=   (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21)));
  Result.m01 := 0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21)));
  Result.m02 :=   (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11)));
  Result.m03 := 0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)));
  Result.m10 := 0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30)+(m23*m32*m10)+(m33*m12*m20)));
  Result.m11 :=   (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30)+(m23*m32*m00)+(m33*m02*m20)));
  Result.m12 := 0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30)+(m13*m32*m00)+(m33*m02*m10)));
  Result.m13 :=   (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20)+(m13*m22*m00)+(m23*m02*m10)));
  Result.m20 :=   (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30)+(m23*m31*m10)+(m33*m11*m20)));
  Result.m21 := 0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30)+(m23*m31*m00)+(m33*m01*m20)));
  Result.m22 :=   (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30)+(m13*m31*m00)+(m33*m01*m10)));
  Result.m23 := 0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20)+(m13*m21*m00)+(m23*m01*m10)));
  Result.m30 := 0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30)+(m22*m31*m10)+(m32*m11*m20)));
  Result.m31 :=   (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30)+(m22*m31*m00)+(m32*m01*m20)));
  Result.m32 := 0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30)+(m13*m31*m00)+(m32*m01*m10)));
  Result.m33 :=   (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20)+(m12*m21*m00)+(m22*m01*m10)));
end;

function eMatrix4x4.cofactor: eMatrix4x4;
begin
  //- Calculate matrix of minors and co-factor.
  Result.m00 :=   (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21)));
  Result.m10 := 0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21)));
  Result.m20 :=   (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11)));
  Result.m30 := 0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)));
  Result.m01 := 0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30)+(m23*m32*m10)+(m33*m12*m20)));
  Result.m11 :=   (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30)+(m23*m32*m00)+(m33*m02*m20)));
  Result.m21 := 0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30)+(m13*m32*m00)+(m33*m02*m10)));
  Result.m31 :=   (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20)+(m13*m22*m00)+(m23*m02*m10)));
  Result.m02 :=   (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30)+(m23*m31*m10)+(m33*m11*m20)));
  Result.m12 := 0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30)+(m23*m31*m00)+(m33*m01*m20)));
  Result.m22 :=   (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30)+(m13*m31*m00)+(m33*m01*m10)));
  Result.m32 := 0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20)+(m13*m21*m00)+(m23*m01*m10)));
  Result.m03 := 0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30)+(m22*m31*m10)+(m32*m11*m20)));
  Result.m13 :=   (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30)+(m22*m31*m00)+(m32*m01*m20)));
  Result.m23 := 0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30)+(m13*m31*m00)+(m32*m01*m10)));
  Result.m33 :=   (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20)+(m12*m21*m00)+(m22*m01*m10)));
end;

class function eMatrix4x4.Create( const _m00: extended; const _m10: extended; const _m20: extended; const _m30: extended; const _m01: extended; const _m11: extended; const _m21: extended; const _m31: extended; const _m02: extended; const _m12: extended; const _m22: extended; const _m32: extended; const _m03: extended; const _m13: extended; const _m23: extended; const _m33: extended ): eMatrix4x4;
begin
  Result.m00 := _m00;
  Result.m10 := _m10;
  Result.m20 := _m20;
  Result.m30 := _m30;
  Result.m01 := _m01;
  Result.m11 := _m11;
  Result.m21 := _m21;
  Result.m31 := _m31;
  Result.m02 := _m02;
  Result.m12 := _m12;
  Result.m22 := _m22;
  Result.m32 := _m32;
  Result.m03 := _m03;
  Result.m13 := _m13;
  Result.m23 := _m23;
  Result.m33 := _m33;
end;

class function eMatrix4x4.Create( const Row0: eVector4; const Row1: eVector4; const Row2: eVector4; const Row3: eVector4 ): eMatrix4x4;
begin
  Result.m00 := Row0.X;
  Result.m01 := Row1.X;
  Result.m02 := Row2.X;
  Result.m03 := Row3.X;
  Result.m10 := Row0.Y;
  Result.m11 := Row1.Y;
  Result.m12 := Row2.Y;
  Result.m13 := Row3.Y;
  Result.m20 := Row0.Z;
  Result.m21 := Row1.Z;
  Result.m22 := Row2.Z;
  Result.m23 := Row3.Z;
  Result.m30 := Row0.W;
  Result.m31 := Row1.W;
  Result.m32 := Row2.W;
  Result.m33 := Row3.W;
end;

class function eMatrix4x4.CreatePerspective( const angleDeg: extended; const ratio: extended; const _near: extended; const _far: extended ): eMatrix4x4;
var
  tan_extended_angle: extended;
begin
  tan_extended_angle := tan(degtorad(angleDeg)/2);
  Result.m00 := 1 / (ratio*tan_extended_angle);
  Result.m10 := 0;
  Result.m20 := 0;
  Result.m30 := 0;
  Result.m01 := 0;
  Result.m11 := 1 / tan_extended_angle;
  Result.m21 := 0;
  Result.m31 := 0;
  Result.m02 := 0;
  Result.m12 := 0;
  Result.m22 := (_near+_far)/(_near-_far);
  Result.m32 := (2*_near-_far)/(_near-_far);
  Result.m03 := 0;
  Result.m13 := 0;
  Result.m23 := -1;
  Result.m33 := 0;
end;

class function eMatrix4x4.Create( const Row0: eVector3; const Row1: eVector3; const Row2: eVector3; const Row3: eVector3 ): eMatrix4x4;
begin
  Result.m00 := Row0.X;
  Result.m01 := Row1.X;
  Result.m02 := Row2.X;
  Result.m03 := Row3.X;
  Result.m10 := Row0.Y;
  Result.m11 := Row1.Y;
  Result.m12 := Row2.Y;
  Result.m13 := Row3.Y;
  Result.m20 := Row0.Z;
  Result.m21 := Row1.Z;
  Result.m22 := Row2.Z;
  Result.m23 := Row3.Z;
  Result.m30 := 0;
  Result.m31 := 0;
  Result.m32 := 0;
  Result.m33 := 1;
end;

class function eMatrix4x4.CreateView( const eye: eVector3; const target: eVector3; const Up: eVector3 ): eMatrix4x4;
var
  vz: eVector3;
  vx: eVector3;
  vy: eVector3;
begin
  vz := (eye-target).normalized;
  vx := up.cross(vz).normalized;
  vy := vz.cross(vx);
  Result := eMatrix4x4.Create(
              vx.X,           VY.X,           vZ.X, 0,
              vx.Y,           VY.y,           VZ.y, 0,
              vx.Z,           VY.Z,           VZ.Z, 0,
    -(vx.dot(eye)), -(vy.dot(eye)), -(vz.dot(eye)), 1 ).transpose;
end;

function eMatrix4x4.determinant: extended;
begin
  Result :=
  (m00 *    (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31)+(m23*m32*m11)+(m33*m12*m21))))  +
  (m10 * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31)+(m23*m32*m01)+(m33*m02*m21))))) +
  (m20 *    (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31)+(m13*m32*m01)+(m33*m02*m11))))  +
  (m30 * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21)+(m13*m22*m01)+(m23*m02*m11)))));
end;

class operator eMatrix4x4.Divide( const a: eMatrix4x4; const b: extended ): eMatrix4x4;
begin
  Result.m00 := a.m00 / b;
  Result.m10 := a.m10 / b;
  Result.m20 := a.m20 / b;
  Result.m30 := a.m30 / b;
  Result.m01 := a.m01 / b;
  Result.m11 := a.m11 / b;
  Result.m21 := a.m21 / b;
  Result.m31 := a.m31 / b;
  Result.m02 := a.m02 / b;
  Result.m12 := a.m12 / b;
  Result.m22 := a.m22 / b;
  Result.m32 := a.m32 / b;
  Result.m03 := a.m03 / b;
  Result.m13 := a.m13 / b;
  Result.m23 := a.m23 / b;
  Result.m33 := a.m33 / b;
end;

class operator eMatrix4x4.Divide( const a: eMatrix4x4; const b: eMatrix4x4 ): eMatrix4x4;
begin
  Result.m00 := a.m00 / b.m00;
  Result.m10 := a.m10 / b.m10;
  Result.m20 := a.m20 / b.m20;
  Result.m30 := a.m30 / b.m30;
  Result.m01 := a.m01 / b.m01;
  Result.m11 := a.m11 / b.m11;
  Result.m21 := a.m21 / b.m21;
  Result.m31 := a.m31 / b.m31;
  Result.m02 := a.m02 / b.m02;
  Result.m12 := a.m12 / b.m12;
  Result.m22 := a.m22 / b.m22;
  Result.m32 := a.m32 / b.m32;
  Result.m03 := a.m03 / b.m03;
  Result.m13 := a.m13 / b.m13;
  Result.m23 := a.m23 / b.m23;
  Result.m33 := a.m33 / b.m33;
end;

function eMatrix4x4.dot( const a: eMatrix4x4 ): eMatrix4x4;
begin
  Result.m00 := (m00 * A.m00) + (m10 * A.m01) + (m20 * A.m02) + (m30 * A.m03);
  Result.m10 := (m00 * A.m10) + (m10 * A.m11) + (m20 * A.m12) + (m30 * A.m13);
  Result.m20 := (m00 * A.m20) + (m10 * A.m21) + (m20 * A.m22) + (m30 * A.m23);
  Result.m30 := (m00 * A.m30) + (m10 * A.m31) + (m20 * A.m32) + (m30 * A.m33);
  Result.m01 := (m01 * A.m00) + (m11 * A.m01) + (m21 * A.m02) + (m31 * A.m03);
  Result.m11 := (m01 * A.m10) + (m11 * A.m11) + (m21 * A.m12) + (m31 * A.m13);
  Result.m21 := (m01 * A.m20) + (m11 * A.m21) + (m21 * A.m22) + (m31 * A.m23);
  Result.m31 := (m01 * A.m30) + (m11 * A.m31) + (m21 * A.m32) + (m31 * A.m33);
  Result.m02 := (m02 * A.m00) + (m12 * A.m01) + (m22 * A.m02) + (m32 * A.m03);
  Result.m12 := (m02 * A.m10) + (m12 * A.m11) + (m22 * A.m12) + (m32 * A.m13);
  Result.m22 := (m02 * A.m20) + (m12 * A.m21) + (m22 * A.m22) + (m32 * A.m23);
  Result.m32 := (m02 * A.m30) + (m12 * A.m31) + (m22 * A.m32) + (m32 * A.m33);
  Result.m03 := (m03 * A.m00) + (m13 * A.m01) + (m23 * A.m02) + (m33 * A.m03);
  Result.m13 := (m03 * A.m10) + (m13 * A.m11) + (m23 * A.m12) + (m33 * A.m13);
  Result.m23 := (m03 * A.m20) + (m13 * A.m21) + (m23 * A.m22) + (m33 * A.m23);
  Result.m33 := (m03 * A.m30) + (m13 * A.m31) + (m23 * A.m32) + (m33 * A.m33);
end;

function eMatrix4x4.dot( const a: eVector4 ): eVector4;
begin
  Result.X := (m00 * A.X) + (m10 * A.Y) + (m20 * A.Z) + (m30 * A.W);
  Result.Y := (m01 * A.X) + (m11 * A.Y) + (m21 * A.Z) + (m31 * A.W);
  Result.Z := (m02 * A.X) + (m12 * A.Y) + (m22 * A.Z) + (m32 * A.W);
  Result.W := (m03 * A.X) + (m13 * A.Y) + (m23 * A.Z) + (m33 * A.W);
end;

class function eMatrix4x4.identity: eMatrix4x4;
begin
  Result := eMatrix4x4.Create
  (
     1, 0, 0, 0,
     0, 1, 0, 0,
     0, 0, 1, 0,
     0, 0, 0, 1
  );
end;

function eMatrix4x4.inverse: eMatrix4x4;
var
  D: extended;
begin
  D := (
    (m00 *    (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31) + (m23*m32*m11)+(m33*m12*m21))))  +
    (m10 * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31) + (m23*m32*m01)+(m33*m02*m21))))) +
    (m20 *    (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31) + (m13*m32*m01)+(m33*m02*m11))))  +
    (m30 * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21) + (m13*m22*m01)+(m23*m02*m11)))))
  );
  if (D=0) then begin
    exit;    // ought not be necessary, but... life isn't always fair.
  end;
  D := 1/D;
  //- Calculate matrix of minors and co-factor, transpose for adjugate, and
  //- multiply 1/determinant
  //- Calculate matrix of minors and co-factor and transpose
  Result.m00 := D * (  (((m11*m22*m33)+(m21*m32*m13)+(m31*m12*m23)) - ((m13*m22*m31) + (m23*m32*m11)+(m33*m12*m21))));
  Result.m01 := D * (0-(((m01*m22*m33)+(m21*m32*m03)+(m31*m02*m23)) - ((m03*m22*m31) + (m23*m32*m01)+(m33*m02*m21))));
  Result.m02 := D * (  (((m01*m12*m33)+(m11*m32*m03)+(m31*m02*m13)) - ((m03*m12*m31) + (m13*m32*m01)+(m33*m02*m11))));
  Result.m03 := D * (0-(((m01*m12*m23)+(m11*m22*m03)+(m21*m02*m13)) - ((m03*m12*m21) + (m13*m22*m01)+(m23*m02*m11))));
  Result.m10 := D * (0-(((m10*m22*m33)+(m20*m32*m13)+(m30*m12*m23)) - ((m13*m22*m30) + (m23*m32*m10)+(m33*m12*m20))));
  Result.m11 := D * (  (((m00*m22*m33)+(m20*m32*m03)+(m30*m02*m23)) - ((m03*m22*m30) + (m23*m32*m00)+(m33*m02*m20))));
  Result.m12 := D * (0-(((m00*m12*m33)+(m10*m32*m03)+(m30*m02*m13)) - ((m03*m12*m30) + (m13*m32*m00)+(m33*m02*m10))));
  Result.m13 := D * (  (((m00*m12*m23)+(m10*m22*m03)+(m20*m02*m13)) - ((m03*m12*m20) + (m13*m22*m00)+(m23*m02*m10))));
  Result.m20 := D * (  (((m10*m21*m33)+(m20*m31*m13)+(m30*m11*m23)) - ((m13*m21*m30) + (m23*m31*m10)+(m33*m11*m20))));
  Result.m21 := D * (0-(((m00*m21*m33)+(m20*m31*m03)+(m30*m01*m23)) - ((m03*m21*m30) + (m23*m31*m00)+(m33*m01*m20))));
  Result.m22 := D * (  (((m00*m11*m33)+(m10*m31*m03)+(m30*m01*m13)) - ((m03*m11*m30) + (m13*m31*m00)+(m33*m01*m10))));
  Result.m23 := D * (0-(((m00*m11*m23)+(m10*m21*m03)+(m20*m01*m13)) - ((m03*m11*m20) + (m13*m21*m00)+(m23*m01*m10))));
  Result.m30 := D * (0-(((m10*m21*m32)+(m20*m31*m12)+(m30*m11*m22)) - ((m12*m21*m30) + (m22*m31*m10)+(m32*m11*m20))));
  Result.m31 := D * (  (((m00*m21*m32)+(m20*m31*m02)+(m30*m01*m22)) - ((m02*m21*m30) + (m22*m31*m00)+(m32*m01*m20))));
  Result.m32 := D * (0-(((m00*m11*m32)+(m10*m31*m02)+(m30*m01*m13)) - ((m02*m11*m30) + (m13*m31*m00)+(m32*m01*m10))));
  Result.m33 := D * (  (((m00*m11*m22)+(m10*m21*m02)+(m20*m01*m12)) - ((m02*m11*m20) + (m12*m21*m00)+(m22*m01*m10))));
end;

class operator eMatrix4x4.Multiply( const a: eMatrix4x4; const b: eMatrix4x4 ): eMatrix4x4;
begin
  Result.m00 := a.m00 * b.m00;
  Result.m10 := a.m10 * b.m10;
  Result.m20 := a.m20 * b.m20;
  Result.m30 := a.m30 * b.m30;
  Result.m01 := a.m01 * b.m01;
  Result.m11 := a.m11 * b.m11;
  Result.m21 := a.m21 * b.m21;
  Result.m31 := a.m31 * b.m31;
  Result.m02 := a.m02 * b.m02;
  Result.m12 := a.m12 * b.m12;
  Result.m22 := a.m22 * b.m22;
  Result.m32 := a.m32 * b.m32;
  Result.m03 := a.m03 * b.m03;
  Result.m13 := a.m13 * b.m13;
  Result.m23 := a.m23 * b.m23;
  Result.m33 := a.m33 * b.m33;
end;

class operator eMatrix4x4.Multiply( const a: eMatrix4x4; const b: extended ): eMatrix4x4;
begin
  Result.m00 := a.m00 * b;
  Result.m10 := a.m10 * b;
  Result.m20 := a.m20 * b;
  Result.m30 := a.m30 * b;
  Result.m01 := a.m01 * b;
  Result.m11 := a.m11 * b;
  Result.m21 := a.m21 * b;
  Result.m31 := a.m31 * b;
  Result.m02 := a.m02 * b;
  Result.m12 := a.m12 * b;
  Result.m22 := a.m22 * b;
  Result.m32 := a.m32 * b;
  Result.m03 := a.m03 * b;
  Result.m13 := a.m13 * b;
  Result.m23 := a.m23 * b;
  Result.m33 := a.m33 * b;
end;

class function eMatrix4x4.rotationX( const degrees: extended ): eMatrix4x4;
var
  d: extended;
begin
  d := degrees*Pi/180;
  Result := eMatrix4x4.Create(
    1,  0,             0,  0,
    0,  cos(d),  -sin(d),  0,
    0,  sin(d),   cos(d),  0,
    0,  0,             0,  1
  );
end;

class function eMatrix4x4.rotationY( const degrees: extended ): eMatrix4x4;
var
  d: extended;
begin
  d := degrees*Pi/180;
  Result := eMatrix4x4.Create(
    cos(d),   0,  sin(d),  0,
    0,        1,       0,  0,
    -sin(d),  0,  cos(d),  0,
    0,        0,       0,  1
  );
end;

class function eMatrix4x4.rotationZ( const degrees: extended ): eMatrix4x4;
var
  d: extended;
begin
  d := degrees*Pi/180;
  Result := eMatrix4x4.Create(
    cos(d), -sin(d),  0,  0,
    sin(d), cos(d),   0,  0,
    0,            0,  1,  0,
    0,            0,  0,  1
  );
end;

class function eMatrix4x4.scale( const s: eVector3 ): eMatrix4x4;
begin
  Result := eMatrix4x4.Create(
   s.X, 0,   0,   0,
   0,   s.Y, 0,   0,
   0,   0,   s.Z, 0,
   0,   0,   0,   1
  );
end;

class operator eMatrix4x4.Subtract( const a: eMatrix4x4; const b: extended ): eMatrix4x4;
begin
  Result.m00 := a.m00 - b;
  Result.m10 := a.m10 - b;
  Result.m20 := a.m20 - b;
  Result.m30 := a.m30 - b;
  Result.m01 := a.m01 - b;
  Result.m11 := a.m11 - b;
  Result.m21 := a.m21 - b;
  Result.m31 := a.m31 - b;
  Result.m02 := a.m02 - b;
  Result.m12 := a.m12 - b;
  Result.m22 := a.m22 - b;
  Result.m32 := a.m32 - b;
  Result.m03 := a.m03 - b;
  Result.m13 := a.m13 - b;
  Result.m23 := a.m23 - b;
  Result.m33 := a.m33 - b;
end;

class function eMatrix4x4.translation( const t: eVector3 ): eMatrix4x4;
begin
  Result := eMatrix4x4.Create(
    1, 0, 0, t.X,
    0, 1, 0, t.Y,
    0, 0, 1, t.Z,
    0, 0, 0, 1
  );
end;

function eMatrix4x4.transpose: eMatrix4x4;
begin
  Result := eMatrix4x4.Create(
   m00, m01, m02, m03,
   m10, m11, m12, m13,
   m20, m21, m22, m23,
   m30, m31, m32, m33
  );
end;

class operator eMatrix4x4.Subtract( const a: eMatrix4x4; const b: eMatrix4x4 ): eMatrix4x4;
begin
  Result.m00 := a.m00 - b.m00;
  Result.m10 := a.m10 - b.m10;
  Result.m20 := a.m20 - b.m20;
  Result.m30 := a.m30 - b.m30;
  Result.m01 := a.m01 - b.m01;
  Result.m11 := a.m11 - b.m11;
  Result.m21 := a.m21 - b.m21;
  Result.m31 := a.m31 - b.m31;
  Result.m02 := a.m02 - b.m02;
  Result.m12 := a.m12 - b.m12;
  Result.m22 := a.m22 - b.m22;
  Result.m32 := a.m32 - b.m32;
  Result.m03 := a.m03 - b.m03;
  Result.m13 := a.m13 - b.m13;
  Result.m23 := a.m23 - b.m23;
  Result.m33 := a.m33 - b.m33;
end;

{$endregion}

{$region ' sRay'}

class function sRay.Create( const aOrigin: sVertex; const aDirection: sVector3; const aLength: single ): sRay;
begin
  Result.Origin := aOrigin;
  Result.Direction := aDirection.UnitVector;
  Result.Length := aLength;
end;

class function sRay.Create( const aOrigin: sVertex; const aDestination: sVertex ): sRay;
var
  V: sVector3;
begin
  Result.Origin := aOrigin;
  V := aDestination - aOrigin;
  Result.Direction := V;
  Result.Length := V.magnitude;
end;

function sRay.Destination: sVertex;
begin
  Result := Origin + (sVector3(Direction) * Length);
end;

procedure sRay.setDirection( const Value: sVector3 );
begin
  fDirection := Value.UnitVector;
end;

{$endregion}

{$region ' dRay'}

class function dRay.Create( const aOrigin: dVertex; const aDirection: dVector3; const aLength: double ): dRay;
begin
  Result.Origin := aOrigin;
  Result.Direction := aDirection.UnitVector;
  Result.Length := aLength;
end;

class function dRay.Create( const aOrigin: dVertex; const aDestination: dVertex ): dRay;
var
  V: dVector3;
begin
  Result.Origin := aOrigin;
  V := aDestination - aOrigin;
  Result.Direction := V;
  Result.Length := V.magnitude;
end;

function dRay.Destination: dVertex;
begin
  Result := Origin + (dVector3(Direction) * Length);
end;

procedure dRay.setDirection( const Value: dVector3 );
begin
  fDirection := Value.UnitVector;
end;

{$endregion}

{$region ' eRay'}

class function eRay.Create( const aOrigin: eVertex; const aDirection: eVector3; const aLength: extended ): eRay;
begin
  Result.Origin := aOrigin;
  Result.Direction := aDirection.UnitVector;
  Result.Length := aLength;
end;

class function eRay.Create( const aOrigin: eVertex; const aDestination: eVertex ): eRay;
var
  V: eVector3;
begin
  Result.Origin := aOrigin;
  V := aDestination - aOrigin;
  Result.Direction := V;
  Result.Length := V.magnitude;
end;

function eRay.Destination: eVertex;
begin
  Result := Origin + (eVector3(Direction) * Length);
end;

procedure eRay.setDirection( const Value: eVector3 );
begin
  fDirection := Value.UnitVector;
end;

{$endregion}

{$region ' sPlane'}

class function sPlane.Create( const aOrigin: sVertex; const aNormal: sVector3 ): sPlane;
begin
  Result.Origin := aOrigin;
  Result.fNormal := aNormal.normalized;
end;


function sPlane.Intersect( const aRay: sRay ): boolean;
var
  k: single;
  v: sVector3;
  w: sVector3;
begin
  v := aRay.Destination;
  w := Origin - aRay.Origin;
  k := (w.dot(fNormal)/v.dot(fNormal));
  Result := (k>=0) and (k<=1);
end;

function sPlane.Intersection( const aRay: sRay ): sVertex;
var
  k: single;
  v: sVector3;
  w: sVector3;
begin
  v := aRay.Destination;
  w := Origin - aRay.Origin;
  k := (w.dot(fNormal)/v.dot(fNormal));
  Result := aRay.Origin + (v * k);
end;

procedure sPlane.setNormal( const Value: sVector3 );
begin
  fNormal := Value.normalized;
end;

{$endregion}

{$region ' dPlane'}

class function dPlane.Create( const aOrigin: dVertex; const aNormal: dVector3 ): dPlane;
begin
  Result.Origin := aOrigin;
  Result.fNormal := aNormal.normalized;
end;


function dPlane.Intersect( const aRay: dRay ): boolean;
var
  k: double;
  v: dVector3;
  w: dVector3;
begin
  v := aRay.Destination;
  w := Origin - aRay.Origin;
  k := (w.dot(fNormal)/v.dot(fNormal));
  Result := (k>=0) and (k<=1);
end;

function dPlane.Intersection( const aRay: dRay ): dVertex;
var
  k: double;
  v: dVector3;
  w: dVector3;
begin
  v := aRay.Destination;
  w := Origin - aRay.Origin;
  k := (w.dot(fNormal)/v.dot(fNormal));
  Result := aRay.Origin + (v * k);
end;

procedure dPlane.setNormal( const Value: dVector3 );
begin
  fNormal := Value.normalized;
end;

{$endregion}

{$region ' ePlane'}

class function ePlane.Create( const aOrigin: eVertex; const aNormal: eVector3 ): ePlane;
begin
  Result.Origin := aOrigin;
  Result.fNormal := aNormal.normalized;
end;


function ePlane.Intersect( const aRay: eRay ): boolean;
var
  k: extended;
  v: eVector3;
  w: eVector3;
begin
  v := aRay.Destination;
  w := Origin - aRay.Origin;
  k := (w.dot(fNormal)/v.dot(fNormal));
  Result := (k>=0) and (k<=1);
end;

function ePlane.Intersection( const aRay: eRay ): eVertex;
var
  k: extended;
  v: eVector3;
  w: eVector3;
begin
  v := aRay.Destination;
  w := Origin - aRay.Origin;
  k := (w.dot(fNormal)/v.dot(fNormal));
  Result := aRay.Origin + (v * k);
end;

procedure ePlane.setNormal( const Value: eVector3 );
begin
  fNormal := Value.normalized;
end;

{$endregion}

initialization
  TStatus.Register(stInvalidArrayForVector);

end.
