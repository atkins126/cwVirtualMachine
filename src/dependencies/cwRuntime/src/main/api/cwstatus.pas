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
unit cwStatus;
{$ifdef fpc}
  {$mode delphiunicode}
  {$MODESWITCH ADVANCEDRECORDS}
  {$MODESWITCH TYPEHELPERS}
{$endif}

interface
uses
  sysutils  // for Exception & TGUID
, cwStatus.Parameterized
;

{$region ' Exceptions which may be raised by cwStatus'}

type
  /// <summary>
  ///   Exception raised when the TStatus.Raize method is called.
  /// </summary>
  EStatus = class(Exception)
  private
    function getMessage: string;
    procedure setMessage( const value: string );
  public
    property Message: string read getMessage write setMessage;
  end;

  /// <summary>
  ///  This exception is raised if an attempt is made to set a status
  ///  using an ansi-string which does not contain a valid guid.
  /// </summary>
  EInvalidStatusGUID = class(Exception);

{$endregion}

{$region ' The TStatus data type.'}
type
  /// <summary>
  /// </summary>
  TStatus = record
  private
    GUID: TGUID;
    Parameterized: IStatusParameterizedMessage;
  private
    procedure ParameterizeMessage(const Parameters: array of string);
    function GetText: string; overload;
  public
    class operator Implicit(const a: TStatus): string;
    class operator Explicit(const a: TStatus): string;
    class operator Implicit(const a: ansistring): TStatus;
    class operator Explicit(const a: ansistring): TStatus;
    class operator Implicit(const a: string): TStatus;
    class operator Explicit(const a: string): TStatus;

    class operator Implicit(const a: TStatus): Boolean;
    class operator Explicit(const a: TStatus): Boolean;
    class operator LogicalNot(const a: TStatus): Boolean;
    class operator Equal( const a: TStatus; const b: TStatus ): boolean;
    class operator NotEqual( const a: TStatus; const b: TStatus ): boolean;

    class operator Equal( const a: TStatus; const b: ansistring ): boolean;
    class operator NotEqual( const a: TStatus; const b: ansistring ): boolean;
    class operator Equal( const a: ansistring; const b: TStatus ): boolean;
    class operator NotEqual( const a: ansistring; const b: TStatus ): boolean;

    class function Unknown: TStatus; static;
    class function Success: TStatus; static;
    procedure Raize; overload;
    procedure Raize( const Parameters: array of string ); overload;
    function Return: TStatus; overload;
    function Return( const Parameters: array of string ): TStatus; overload;
    {$ifdef fpc}
    class procedure Register(const a: ansistring); static;
    {$else}
    class procedure Register(const a: string); static;
    {$endif}
  end;

{$endregion}

implementation
uses
  cwStatus.Messages
, cwStatus.Placeholders
;

resourcestring
  {$hints off} stSuccess = '{00000000-0000-0000-0000-000000000000} SUCCESS'; {$hints on}
  {$hints off} stUnknown = '{01010101-0101-0101-0101-010101010101} UNKNOWN'; {$hints on}

const
  cSuccess : TGUID = '{00000000-0000-0000-0000-000000000000}';
  cUnknown : TGUID = '{01010101-0101-0101-0101-010101010101}';


function EStatus.getMessage: string;
begin
  Result := string(inherited Message);
end;

procedure EStatus.setMessage(const value: string);
begin
  {$ifdef fpc}
  inherited Message := ansistring(value);
  {$else}
  inherited Message := value;
  {$endif}
end;

class operator TStatus.Implicit(const a: TStatus): string;
begin
  Result := a.GetText;
end;

class operator TStatus.Explicit(const a: TStatus): string;
begin
  Result := a.GetText;
end;

class operator TStatus.Implicit(const a: ansistring): TStatus;
begin
  if not TMessageDictionary.ReadGUID(a,Result.GUID) then begin
  {$ifdef fpc}
    raise
      EInvalidStatusGUID.Create(a);
  {$else}
    raise
      EInvalidStatusGUID.Create(string(a));
  {$endif}
  end;
end;

class operator TStatus.Explicit(const a: ansistring): TStatus;
begin
  if not TMessageDictionary.ReadGUID(a,Result.GUID) then begin
  {$ifdef fpc}
    raise
      EInvalidStatusGUID.Create(a);
  {$else}
    raise
      EInvalidStatusGUID.Create(string(a));
  {$endif}
  end;
end;

class operator TStatus.Implicit(const a: TStatus): Boolean;
begin
  Result := IsEqualGUID(cSuccess,a.GUID);
end;

class operator TStatus.Implicit(const a: string): TStatus;
begin
  if not TMessageDictionary.ReadGUID(ansistring(a),Result.GUID) then begin
    {$ifdef fpc}
    raise
      EInvalidStatusGUID.Create(ansistring(a));
    {$else}
    raise
      EInvalidStatusGUID.Create(a);
    {$endif}
  end;
end;

class operator TStatus.Explicit(const a: TStatus): Boolean;
begin
  Result := IsEqualGUID(cSuccess,a.GUID);
end;

class operator TStatus.Explicit(const a: string): TStatus;
begin
  if not TMessageDictionary.ReadGUID(ansistring(a),Result.GUID) then begin
    {$ifdef fpc}
    raise
      EInvalidStatusGUID.Create(ansistring(a));
    {$else}
    raise
      EInvalidStatusGUID.Create(a);
    {$endif}
  end;
end;

class operator TStatus.LogicalNot(const a: TStatus): Boolean;
begin
  Result := not IsEqualGUID(a.GUID,cSuccess);
end;

class operator TStatus.Equal(const a: TStatus; const b: TStatus): boolean;
begin
  Result := IsEqualGUID(a.GUID,b.GUID);
end;

class operator TStatus.NotEqual(const a: TStatus; const b: TStatus): boolean;
begin
  Result := not IsEqualGUID(a.GUID,b.GUID);
end;

class operator TStatus.Equal(const a: TStatus; const b: ansistring): boolean;
var
  bGUID: TGUID;
begin
  if not TMessageDictionary.ReadGUID(b,bGUID) then begin
    {$ifdef fpc}
    raise
      EInvalidStatusGUID.Create(b);
    {$else}
    raise
      EInvalidStatusGUID.Create(string(b));
    {$endif}
  end;
  Result := IsEqualGUID(a.GUID,bGUID);
end;

class operator TStatus.NotEqual(const a: TStatus; const b: ansistring): boolean;
var
  bGUID: TGUID;
begin
  if not TMessageDictionary.ReadGUID(b,bGUID) then begin
    {$ifdef fpc}
    raise
      EInvalidStatusGUID.Create(b);
    {$else}
    raise
      EInvalidStatusGUID.Create(string(b));
    {$endif}
  end;
  Result := not IsEqualGUID(a.GUID,bGUID);
end;

class operator TStatus.Equal(const a: ansistring; const b: TStatus): boolean;
var
  aGUID: TGUID;
begin
  if not TMessageDictionary.ReadGUID(a,aGUID) then begin
    {$ifdef fpc}
    raise
      EInvalidStatusGUID.Create(a);
    {$else}
    raise
      EInvalidStatusGUID.Create(string(a));
    {$endif}
  end;
  Result := IsEqualGUID(aGUID,b.GUID);
end;

class operator TStatus.NotEqual(const a: ansistring; const b: TStatus): boolean;
var
  aGUID: TGUID;
begin
  if not TMessageDictionary.ReadGUID(a,aGUID) then begin
    {$ifdef fpc}
    raise
      EInvalidStatusGUID.Create(a);
    {$else}
    raise
      EInvalidStatusGUID.Create(string(a));
    {$endif}
  end;
  Result := not IsEqualGUID(aGUID,b.GUID);
end;

class function TStatus.Unknown: TStatus;
begin
  Result.GUID := cUnknown;
end;

class function TStatus.Success: TStatus;
begin
  Result.GUID := cSuccess;
end;

procedure TStatus.ParameterizeMessage(const Parameters: array of string);
var
  S: string;
begin
  //- Get the text to be parameterized.
  Parameterized := nil;
  S := GetText;
  Parameterized := TStatusParameterizedMessage.Create;
  Parameterized.Message := S;
  Parameterized.Message := TPlaceholders.ParameterizeString(Parameterized.Message,Parameters);
end;

function TStatus.Return(const Parameters: array of string): TStatus;
begin
  ParameterizeMessage( Parameters );
  Result := Self;
end;

function TStatus.Return: TStatus;
begin
  Result := Return([]);
end;

function TStatus.GetText: string;
begin
  if assigned(Parameterized) then begin
    Result := Parameterized.Message;
    exit;
  end;
  if not TMessageDictionary.FindEntry(GUID,Result) then begin
    Result := string(GUIDToString(GUID));
  end;
end;

procedure TStatus.Raize(const Parameters: array of string);
begin
  {$hints off} if IsEqualGUID(GUID,cSuccess) then exit; {$hints on}
  if Length(Parameters)<>0 then begin
    ParameterizeMessage( Parameters );
  end;
  {$ifdef fpc}
  raise
    EStatus.Create(ansistring(GetText()));
  {$else}
  raise
    EStatus.Create(GetText());
  {$endif}
end;

procedure TStatus.Raize;
begin
  Raize([]);
end;

{$ifdef fpc}
class procedure TStatus.Register(const a: ansistring);
{$else}
class procedure TStatus.Register(const a: string);
{$endif}
var
  GUID: TGUID;
  StatusText: string;
begin
  try
    {$ifdef fpc}
    if not TMessageDictionary.SplitStatusText(a,GUID,StatusText) then exit;
    {$else}
    if not TMessageDictionary.SplitStatusText(ansistring(a),GUID,StatusText) then exit;
    {$endif}
  except
    on E: Exception do exit;
    else exit;
  end;
  TMessageDictionary.RegisterEntry(GUID,StatusText);
end;

initialization
  TStatus.Register(stSuccess);
  TStatus.Register(stUnknown);

end.

