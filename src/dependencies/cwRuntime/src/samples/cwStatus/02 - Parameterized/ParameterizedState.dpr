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
program ParameterizedState;
{$ifdef fpc}{$mode delphiunicode}{$endif}
uses
  cwStatus
;

resourcestring
  stParameterizedMessage = '{19DE2B6C-7B01-448C-9EEA-09CF72D51CB2} This message has parameters A: (%A%) and B: (%B%)';

function ReturnParameterized: TStatus;
begin
  Result := TStatus(stParameterizedMessage).Return(['X','Y']);
end;

begin
  Writeln('A parameterized message replaces it''s placeholders with the provided parameter strings.');
  Writeln('In this next message, parameters A and B are set to ''2'' and ''5'' respectively.');
  Writeln;
  Writeln(string( TStatus(stParameterizedMessage).Return(['2','5'])));
  Writeln;
  Writeln('Such parameterized status values may also be returned from a function.');
  Writeln('This function returns the same message with A and B set to ''X'' and ''Y'' respectively.');
  Writeln;
  Writeln( string(ReturnParameterized()) );
  Writeln;
  Writeln('Return values may also be ''raized'' to verify the return value of a function.');
  Writeln('Press [RETURN] to raize.');
  Readln;
  Writeln;
  ReturnParameterized().Raize;
  Writeln;
  Readln;
end.

