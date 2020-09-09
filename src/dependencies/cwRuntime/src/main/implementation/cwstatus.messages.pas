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
unit cwStatus.Messages;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface

(*
   This unit provides a dictionary of status messages with a GUID key.
   The TStatus record will use this dictionary to look up the meaning of
   statuses when the textual form is needed. The cwLog system
   will use the same dictionary when providing logging with translation.
   This behavior differs between Delphi and FreePascal.

   Under FreePascal, because statuses are defined as resource strings, the
   cwStatus system will enumerate those resource strings to pre-populate this
   dictionary. The logging system will then be able to generate a translation
   file which may be translated and loaded back into the dictionary.

   Under Delphi, there is no feature to enumerate resource strings, and so the
   translation file must be generated manually. This would involve scanning
   the source code for the required resource strings to ensure they are
   added to translation files. *Note a resource browser may also be used*
*)

type
  TMessageDictionary = record

    ///  <summary>
    ///    Registers a new message with the dictionary.
    ///    If this is called on an existing GUID, the existing status text
    ///    will be replaced.
    ///  </summary>
    class procedure RegisterEntry( const GUID: TGUID; const StatusText: string ); static;

    ///  <summary>
    ///    Attempts to locate an entry and return its text representation in
    ///    the MessageText parameter. Returns TRUE if successful, else returns
    ///    FALSE.
    ///  </summary>
    class function FindEntry( const GUID: TGUID; out MessageText: string ): boolean; static;

    ///  <summary>
    ///    A utility function which is able to parse an ansistrig to
    ///    split it into a GUID and message text.
    ///  </summary>
    class function SplitStatusText( const srcStr: ansistring; out GUID: TGUID; out MessageText: string ): boolean; static;

    ///  <summary>
    ///    A utility function which is able to parse an ansistrig to
    ///    a GUID. Parsing stops at the end of the GUID and so any
    ///    message text which succeeds the GUID is ignored.
    ///  </summary>
    class function ReadGUID(const srcStr: ansistring; out GUID: TGUID): boolean; static;
  end;

implementation
uses
  sysutils //- For guid matching
{$ifndef fpc}{$ifdef MSWINDOWS}
 , cwWin32.Kernel32
{$endif}{$endif}
;

const
  cGranularity = 16;
var
  LockPtr: nativeuint = 0;
  GUIDS: array of TGUID;
  Texts: array of string;
  Count: nativeuint = 0;

// *** Lock uses the fact that writes to pointer sized variables on
// Intel and ARM targets is an atomic operation. This may not be true of other
// targets.
// If translation to other targets is required, this code will need to be
// altered!
procedure Lock;
var
  ThreadID: TThreadID;
begin
  repeat
    ThreadID := GetCurrentThreadID;
    while LockPtr>0 do sleep(0); //- Hold until unlocked.
    LockPtr := ThreadID; // Set lock to threadID.
  until LockPtr=ThreadID; //- If we failed to set the lock ptr, another thread beat us to it.
end;

procedure Unlock;
begin
  if LockPtr<>GetCurrentThreadID then exit;
  LockPtr := 0;
end;

function FindEntryIndex( const GUID: TGUID; out FoundIdx: nativeuint ): boolean;
var
  idx: nativeuint;
begin
  Result := False;
  if Count=0 then exit;
  for idx := 0 to pred(Count) do begin
    if IsEqualGUID(GUIDS[idx],GUID) then begin
      FoundIdx := idx;
      Result := True;
      exit;
    end;
  end;
end;

class procedure TMessageDictionary.RegisterEntry(const GUID: TGUID; const StatusText: string);
var
  FoundIdx: nativeuint;
begin
  Lock;
  try
    //- If GUID already exists, update the text.
    if FindEntryIndex(GUID,FoundIdx) then begin
      Texts[FoundIdx] := StatusText;
      exit;
    end;
    //- Add entry (first ensure capacity)
    if Count=Length(GUIDS) then begin
      SetLength(GUIDS,Length(GUIDS)+cGranularity);
      SetLength(Texts,Length(Texts)+cGranularity);
    end;
    GUIDS[Count] := GUID;
    Texts[Count] := StatusText;
    inc(Count);
  finally
    Unlock;
  end;
end;

class function TMessageDictionary.FindEntry(const GUID: TGUID; out MessageText: string): boolean;
var
  FoundIdx: nativeuint;
begin
  Result := False;
  MessageText := '';
  Lock;
  try
    if not FindEntryIndex(GUID,FoundIdx) then begin
      exit;
    end;
    MessageText := Texts[FoundIdx];
    Result := True;
  finally
    Unlock;
  end;
end;

class function TMessageDictionary.ReadGUID(const srcStr: ansistring; out GUID: TGUID ): boolean;
const
  cGUIDSize = 38;
var
  idx: nativeuint;
  idy: nativeuint;
  idz: nativeuint;
  Source: string;
  GuidStr: string;
begin
  Result := False;
  Source := string(srcStr);
  GuidStr := '';
  //- Strings index from 1 except for Delphi under NEXTGEN compilers...
  idx := 1;
  {$ifndef fpc}{$ifdef NEXTGEN}
    idx := 0;
  {$endif}{$endif}
  //- Check for at least a guid.
  if Length(Source)<cGUIDSize then exit;
  if Source[idx]<>'{' then exit;
  GuidStr := GUIDStr + '{';
  inc(idx);
  //- Read off eight alpha-numerics
  for idy := 0 to 7 do begin
    if not CharInSet(Source[idx],['0'..'9','A'..'Z','a'..'z']) then exit;
    GUIDStr := GuidStr + Source[idx];
    inc(idx);
  end;
  //- Read off hyphen
  if Source[idx]<>'-' then exit;
  GUIDStr := GUIDStr + '-';
  inc(idx);
  //- Read of four alpha-numerics, each followed by a hyphen, three times.
  for idz := 0 to 2 do begin
    for idy := 0 to 3 do begin
      if not CharInSet(Source[idx],['0'..'9','A'..'Z','a'..'z']) then exit;
      GUIDStr := GuidStr + Source[idx];
      inc(idx);
    end;
    if Source[idx]<>'-' then exit;
    GUIDStr := GUIDStr + '-';
    inc(idx);
  end;
  //- Read off twelve alpha-numerics
  for idy := 0 to 11 do begin
    if not CharInSet(Source[idx],['0'..'9','A'..'Z','a'..'z']) then exit;
    GUIDStr := GuidStr + Source[idx];
    inc(idx);
  end;
  //- Read off closing brace
  if Source[idx]<>'}' then exit;
  GUIDStr := GUIDStr + '}';
  {$ifdef fpc}
  GUID := StringToGUID(ansistring(GuidStr));
  {$else}
  GUID := StringToGUID(GuidStr);
  {$endif}
  Result := True;
end;


class function TMessageDictionary.SplitStatusText(const srcStr: ansistring; out GUID: TGUID; out MessageText: string): boolean;
const
  cGUIDSize = 38;
var
  idx: nativeuint;
  idy: nativeuint;
  idz: nativeuint;
  top: nativeuint;
  Source: string;
  GuidStr: string;
  MessageStr: string;
begin
  Result := False;
  Source := string(srcStr);
  GuidStr := '';
  MessageStr := '';
  //- Strings index from 1 except for Delphi under NEXTGEN compilers...
  idx := 1;
  top := Length(Source);
  {$ifndef fpc}{$ifdef NEXTGEN}
    idx := 0;
    top := pred(Length(Source));
  {$endif}{$endif}
  //- Check for at least a guid.
  if Length(Source)<cGUIDSize then exit;
  if Source[idx]<>'{' then exit;
  GuidStr := GUIDStr + '{';
  inc(idx);
  //- Read off eight alpha-numerics
  for idy := 0 to 7 do begin
    if not CharInSet(Source[idx],['0'..'9','A'..'Z','a'..'z']) then exit;
    GUIDStr := GuidStr + Source[idx];
    inc(idx);
  end;
  //- Read off hyphen
  if Source[idx]<>'-' then exit;
  GUIDStr := GUIDStr + '-';
  inc(idx);
  //- Read of four alpha-numerics, each followed by a hyphen, three times.
  for idz := 0 to 2 do begin
    for idy := 0 to 3 do begin
      if not CharInSet(Source[idx],['0'..'9','A'..'Z','a'..'z']) then exit;
      GUIDStr := GuidStr + Source[idx];
      inc(idx);
    end;
    if Source[idx]<>'-' then exit;
    GUIDStr := GUIDStr + '-';
    inc(idx);
  end;
  //- Read off twelve alpha-numerics
  for idy := 0 to 11 do begin
    if not CharInSet(Source[idx],['0'..'9','A'..'Z','a'..'z']) then exit;
    GUIDStr := GuidStr + Source[idx];
    inc(idx);
  end;
  //- Read off closing brace
  if Source[idx]<>'}' then exit;
  GUIDStr := GUIDStr + '}';
  inc(idx);
  {$ifdef fpc}
  GUID := StringToGUID(ansistring(GuidStr));
  {$else}
  GUID := StringToGUID(GuidStr);
  {$endif}
  //- Now read off message text in race to finish!
  while idx<=top do begin
    MessageStr := MessageStr + Source[idx];
    inc(idx);
  end;
  MessageText := Trim(MessageStr);
  Result := True;
end;

{$ifdef fpc} {$hints off}
function IterateResourceStrings(Name: ansistring; Value: ansistring; Hash: Longint; arg:pointer): ansistring;
var
  GUID: TGUID;
  StatusText: string;
begin
  Result := value;
  try
    if not TMessageDictionary.SplitStatusText(value,GUID,StatusText) then exit;
  except
    on E: Exception do exit;
    else exit;
  end;
  TMessageDictionary.RegisterEntry(GUID,StatusText);
end;
{$hints on}{$endif}

{$ifdef fpc}
initialization
  objpas.SetResourceStrings(IterateResourceStrings,nil);
{$endif}

end.

