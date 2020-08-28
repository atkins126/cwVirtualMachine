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
program SimpleSample;
{$ifdef fpc}{$mode delphiunicode}{$endif}
uses
  cwStatus
;

resourcestring
  stStatus0    = '{A1D3A876-1045-479F-A9E3-B68A8CE45692} Status 0';
  stStatus1    = '{390E68E5-05D5-41FF-9BFF-ACFB4076038F} Status 1';
  stStatus2    = '{6C744216-1DBF-4F8B-B68C-78228CE2F030} Status 2';
  stException1 = '{28A8D56D-2C42-4EE6-8C48-5DEE5C6B98C8} Exception 1';
  stException2 = '{4DD958D5-0183-4436-9BF7-C6800D642562} Exception 2';

function WillSucceed: TStatus;
begin
  Result := TStatus.Success;
end;

function WillUnknown: TStatus;
begin
  Result := TStatus.Unknown;
end;

function ReturnTest(const idx: uint8): TStatus;
begin
  Result := TStatus.Unknown;
  case idx of
    0: Result := stStatus0;
    1: Result := stStatus1;
    2: Result := stStatus2;
  end;
end;

function ReturnException1: TStatus;
begin
  Result := stException1;
end;

var
  idx: uint8;
  retVal: TStatus;

begin
  {$region ' Delphi registration, optional for fpc, typically done in unit initialization.'}
  TStatus.Register(stStatus0);
  TStatus.Register(stStatus1);
  TStatus.Register(stStatus2);
  TStatus.Register(stException1);
  TStatus.Register(stException2);
  {$endregion}

  //- Demonstrates that TStatus can be used as a simple boolean return type.
  if WillSucceed then begin
    Writeln('WillSucceed() was a success');
  end;
  if not WillUnknown then begin
    Writeln('WillUnknown() did not return success');
  end;

  //- Write guids for TStatus.Success and TStatus.Unknown
  Writeln('Success: ',string(TStatus.Success));
  Writeln('Unknown: ',string(TStatus.Unknown));

  //- Demonstrates handling different return status.
  //- NOTE: Breakpoint after assigning retVal and inspect as pchar(retVal)
  for idx := 0 to 2 do begin
    retVal := ReturnTest(idx);
    if retVal = stStatus0 then Writeln('Status 0: '+string(retVal));
    if retVal = stStatus1 then Writeln('Status 1: '+string(retVal));
    if retVal = stStatus2 then Writeln('Status 2: '+string(retVal));
  end;

  //- Demonstrate raise on status.
  try
    ReturnException1().Raize;
  except
    on E: EStatus do begin
      Writeln('Exception: '+e.message);
    end;
  end;

  //- Demonstrate raise on status - direct
  try
    TStatus(stException2).Raize;
  except
    on E: EStatus do begin
      Writeln('Exception: '+e.message);
    end;
  end;

  Readln;
end.

