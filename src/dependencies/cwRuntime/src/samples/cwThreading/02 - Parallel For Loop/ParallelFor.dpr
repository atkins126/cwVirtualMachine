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
program ParallelFor;
uses
  cwThreading
, cwThreading.Standard
;

var
  idx: nativeuint;
  ArrayOfBoolean: array of boolean;

procedure Toggle( const start, stop: nativeuint );
var
  idx: nativeuint;
begin
  for idx := Start to Stop do begin
    ArrayOfBoolean[idx] := not ArrayOfBoolean[idx];
  end;
end;

begin
  SetLength(ArrayOfBoolean,1000);
  //- Set array to false.
  for idx := 0 to pred(length(ArrayOfBoolean)) do begin
    ArrayOfBoolean[idx] := False;
  end;
  //- Parallel set array to true
  ThreadSystem.Execute( Length(ArrayOfBoolean), {$ifdef fpc}@{$endif}Toggle, TRUE );
  //- Confirm array is now true
  for idx := 0 to pred(length(ArrayOfBoolean)) do begin
    if not ArrayOfBoolean[idx] then Writeln('Error!');
  end;
  Writeln('Complete');
  Readln;
end.

