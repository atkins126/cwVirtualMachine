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
unit cwStatus.Placeholders;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface

type
  TPlaceholders = record
  private
    class function PlaceholderExists(const Placeholders: array of string; const PlaceholderCount: nativeuint; const Placeholder: string): boolean; static;
  public
    class function ParameterizeString( const srcStr: string; const Parameters: array of string ): string; static;
  end;

implementation
uses
  sysutils //- for uppercase
, strutils //- For StringReplace.
;

const
  cPlaceholderGranularity = 8;

class function TPlaceholders.PlaceholderExists( const Placeholders: array of string; const PlaceholderCount: nativeuint; const Placeholder: string ): boolean;
var
  idx: nativeuint;
  utPlaceholder: string;
begin
  Result := False;
  if PlaceholderCount=0 then exit;
  utPlaceholder := Uppercase(Trim(Placeholder));
  for idx := 0 to pred(PlaceholderCount) do begin
    if Placeholders[idx]=utPlaceholder then begin
      Result := True;
      exit;
    end;
  end;
end;

class function TPlaceholders.ParameterizeString(const srcStr: string; const Parameters: array of string): string;
var
  s: string;
  idx: nativeuint;
  top: nativeuint;
  Placeholders: array of string;
  PlaceholderCount: nativeuint;
  CurrentPlaceholder: string;
  OpenPlaceholder: boolean;
begin
  // Initialize
  Result := '';
  PlaceholderCount := 0;
  if Length(srcStr)=0 then exit;
  OpenPlaceholder := False;
  CurrentPlaceholder := '';

  {$hints off} SetLength(Placeholders,cPlaceholderGranularity); {$hints on}
  try

    {$region ' Parse for placeholders'}
    idx := 1;
    top := Length(srcStr);
    {$ifndef FPC}{$ifdef NEXTGEN} dec(idx); dec(top); {$endif}{$endif}

    while (idx<=top) do begin
      // If we don't already have an open placeholder, look to see if one
      // is coming.
      if not OpenPlaceholder then begin
        if (srcStr[idx] = '(') and (idx<top) and (srcStr[idx+1]='%') then begin
          OpenPlaceholder := True;
          inc(idx);
          inc(idx);
          continue;
        end;
      end;

      //- If we have a placeholder open, is the end coming?
      if OpenPlaceholder then begin
        if (srcStr[idx]='%') and (idx<top) and (srcStr[idx+1]=')') then begin
          OpenPlaceholder := False;
          //- Add the current placeholder so long as it does not already exist.
          if not PlaceholderExists( Placeholders, PlaceholderCount, CurrentPlaceholder ) then begin
            if Placeholdercount>Length(Placeholders) then begin
              SetLength(Placeholders,Length(Placeholders)+cPlaceholderGranularity);
            end;
            Placeholders[PlaceholderCount] := CurrentPlaceholder;
            CurrentPlaceholder := '';
            inc(PlaceholderCount);
          end;
        end else begin
          CurrentPlaceholder := CurrentPlaceholder + srcStr[idx];
        end;
      end;
      inc(idx);
    end;
    {$endregion}

    {$region ' Reparse source string while replacing placeholders.'}
    if (PlaceholderCount=0) or (Length(Parameters) <> PlaceholderCount) then begin
      Result := srcStr;
      exit;
    end;
    S := srcStr;
    for idx := 0 to pred(PlaceholderCount) do begin
      S := StringReplace(S,'(%'+Placeholders[idx]+'%)',Parameters[idx],[rfReplaceAll, rfIgnoreCase]);
    end;
    Result := S;
    {$endregion}

  finally
    SetLength(Placeholders,0);
  end;
end;

end.

