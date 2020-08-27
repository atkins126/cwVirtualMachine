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
unit cwCollections.StringList.Standard;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch nestedprocvars}
{$endif}

interface
uses
  cwIO
, cwCollections
;

type
  TStandardStringList = class( TInterfacedObject, IReadOnlyStringList, IStringList )
  private
    fStrings: IList<string>;
  strict private //- IReadOnlyStringList -//
    {$ifdef fpc}
    procedure ForEach( const Enumerate: TEnumerateMethodGlobal<string> ); overload;
    procedure ForEach( const Enumerate: TEnumerateMethodOfObject<string> ); overload;
    procedure ForEach( const Enumerate: TEnumerateMethodIsNested<string> ); overload;
    {$else}
    procedure ForEach( const Enumerate: TEnumerateMethod<string> ); overload;
    {$endif}
    function getCount: nativeuint;
    function getString( const idx: nativeuint ): string;
    function getAsReadOnly: IReadOnlyStringList;
    function Contains( const Search: string; const CaseInsensitive: boolean = FALSE ): boolean;
    procedure SaveToStream( const Stream: IUnicodeStream; const Format: TUnicodeFormat );
    procedure LoadFromStream( const Stream: IUnicodeStream; const Format: TUnicodeFormat );

  strict private //- IStringList -//
    procedure Clear;
    procedure Add( const value: string );
    procedure setString( const idx: nativeuint; const value: string );
    function RemoveString( const idx: nativeuint ): boolean;
  public
    constructor Create( const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwTypes
, cwStatus
, cwCollections.Standard
;

constructor TStandardStringList.Create(const Granularity: nativeuint; const isOrdered: boolean; const isPruned: boolean);
begin
  inherited Create;
  fStrings := TList<string>.Create( Granularity, isOrdered, isPruned );
end;

procedure TStandardStringList.Add(const value: string);
var
  Exploded: TArrayOfString;
  idx: nativeuint;
begin
  if Value.Trim='' then begin
    fStrings.Add(CR+LF);
    exit;
  end;
  Exploded := Value.Explode(LF);
  if Length(Exploded)>0 then begin
    for idx := 0 to pred(Length(Exploded)) do begin
      fStrings.Add(Exploded[idx]);
    end;
  end else begin
    fStrings.Add(value);
  end;
end;

procedure TStandardStringList.Clear;
begin
  fStrings.Clear;
end;

function TStandardStringList.Contains(const Search: string; const CaseInsensitive: boolean): boolean;
var
  idx: nativeuint;
  SearchTerm: string;
  TestItem: string;
begin
  Result := False;
  if fStrings.Count=0 then begin
    exit;
  end;
  SearchTerm := Search;
  if CaseInsensitive then begin
    SearchTerm := SearchTerm.Uppercase;
  end;
  for idx := 0 to pred(fStrings.Count) do begin
     TestItem := fStrings[idx];
     if CaseInsensitive then begin
       TestItem := TestItem.Uppercase;
     end;
     if TestItem = SearchTerm then begin
       Result := True;
       exit;
     end;
  end;
end;

procedure TStandardStringList.SaveToStream(const Stream: IUnicodeStream; const Format: TUnicodeFormat);
var
  idx: nativeuint;
begin
  if Format=TUnicodeFormat.utfUnknown then begin
    TStatus(stCannotEncodeUnknownUnicodeFormat).Raize;
  end;
  Stream.WriteBOM(Format);
  if getCount()=0 then begin
    exit;
  end;
  for idx := 0 to pred(getCount()) do begin
    Stream.WriteString( fStrings[idx]+LF, Format );
  end;
end;

procedure TStandardStringList.LoadFromStream(const Stream: IUnicodeStream; const Format: TUnicodeFormat);
var
  ActualFormat: TUnicodeFormat;
  Exploded: TArrayOfString;
  idx: nativeuint;
  S: string;
begin
  ActualFormat := Format;
  if ActualFormat=TUnicodeFormat.utfUnknown then begin
    ActualFormat := Stream.DetermineUnicodeFormat;
  end;
  if ActualFormat=TUnicodeFormat.utfUnknown then begin
    TStatus(stUnableToDetermineUnicodeFormat).Raize;
  end;
  Self.Clear;
  while not Stream.getEndOfStream do begin
    S := Stream.ReadString(ActualFormat,True);
    if S.Trim='' then continue;
    Exploded := S.Explode(LF);
    try
      if Length(Exploded)>0 then begin
        for idx := 0 to pred(Length(Exploded)) do begin
          Self.Add(Exploded[idx]);
        end;
      end else begin
        Self.Add(S);
      end;
    finally
      SetLength(Exploded,0);
    end;
  end;
end;

destructor TStandardStringList.Destroy;
begin
  fStrings := nil;
  inherited Destroy;
end;

{$ifdef fpc}
procedure TStandardStringList.ForEach(const Enumerate: TEnumerateMethodGlobal<string>);
begin
  fStrings.ForEach(Enumerate);
end;
{$endif}

{$ifdef fpc}
procedure TStandardStringList.ForEach(const Enumerate: TEnumerateMethodOfObject<string>);
begin
  fStrings.ForEach(Enumerate);
end;
{$endif}

{$ifdef fpc}
procedure TStandardStringList.ForEach(const Enumerate: TEnumerateMethodIsNested<string>);
begin
  fStrings.ForEach(Enumerate);
end;
{$endif}

{$ifndef fpc}
procedure TStandardStringList.ForEach(const Enumerate: TEnumerateMethod<string>);
begin
  fStrings.ForEach(Enumerate);
end;
{$endif}

function TStandardStringList.getAsReadOnly: IReadOnlyStringList;
begin
  Result := Self as IReadOnlyStringList;
end;

function TStandardStringList.getCount: nativeuint;
begin
  Result := fStrings.Count;
end;

function TStandardStringList.getString(const idx: nativeuint): string;
begin
  Result := fStrings[idx];
end;

function TStandardStringList.RemoveString(const idx: nativeuint): boolean;
begin
  Result := fStrings.RemoveItem(idx);
end;

procedure TStandardStringList.setString(const idx: nativeuint; const value: string);
begin
  fStrings[idx] := Value;
end;

end.
