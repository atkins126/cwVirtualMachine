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
unit cwStatus.Parameterized;
{$ifdef fpc}{$mode delphiunicode}{$endif}

(* TStatus is a simple record with no storage management, however, interfaces
   are garunteed to be initialized nil by the compiler, and finalized when the
   record goes out of scope. Therefore, in order to return a perameterized
   message from TStatus, we can use an interface on the record. This unit
   provides the interface for that storage. *)
interface

type
  IStatusParameterizedMessage = interface
  ['{45C7BED7-8F34-47D5-A170-A7860298CE3A}']
    procedure setMessage( const value: string );
    function getMessage: string;

    property Message: string read getMessage write setMessage;
  end;

  TStatusParameterizedMessage = class( TInterfacedObject, IStatusParameterizedMessage )
  private
    fMessage: string;
  strict private //- IStatusParameterizedMessage -//
    procedure setMessage( const value: string );
    function getMessage: string;
  public
    constructor Create; reintroduce;
  end;

implementation

procedure TStatusParameterizedMessage.setMessage(const value: string);
begin
  fMessage := value;
end;

function TStatusParameterizedMessage.getMessage: string;
begin
  Result := fMessage;
end;

constructor TStatusParameterizedMessage.Create;
begin
  inherited Create;
  fMessage := '';
end;

end.

