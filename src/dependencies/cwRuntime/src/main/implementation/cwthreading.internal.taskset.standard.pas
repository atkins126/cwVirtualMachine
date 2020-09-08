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
unit cwThreading.Internal.TaskSet.Standard;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch nestedprocvars}
{$endif}

interface
uses
  cwCollections
, cwThreading
, cwThreading.Internal
;

type
  TTaskSet = class( TInterfacedObject, ITaskSet )
  private
    fTaskRecords: IList<ITaskRecord>;
    {$ifndef fpc}
    fWhenDone: TOnComplete;
    {$else}
    fWhenDoneG: TOnCompleteGlobal;
    fWhenDoneO: TOnCompleteOfObject;
    fWhenDoneN: TOnCompleteNested;
    {$endif}
  private
    procedure Init(const Tasks: array of ITask);
    procedure AssignTaskRecords(const Tasks: array of ITask);
  strict private //- ITaskSet -//
    function getNextTask: ITaskRecord;
    function IsComplete: boolean;
  public
    constructor Create( const Tasks: array of ITask ); reintroduce; overload;
    {$ifndef fpc}
    constructor Create( const Tasks: array of ITask; const WhenDone: TOnComplete ); reintroduce; overload;
    {$else}
    constructor Create( const Tasks: array of ITask; const WhenDone: TOnCompleteGlobal ); reintroduce; overload;
    constructor Create( const Tasks: array of ITask; const WhenDone: TOnCompleteOfObject ); reintroduce; overload;
    constructor Create( const Tasks: array of ITask; const WhenDone: TOnCompleteNested ); reintroduce; overload;
    {$endif}
    destructor Destroy; override;
  end;

implementation
uses
  cwCollections.Standard
, cwThreading.Internal.TaskRecord.Standard
;

function TTaskSet.getNextTask: ITaskRecord;
var
  idx: nativeuint;
begin
  Result := nil;
  for idx := 0 to pred(fTaskRecords.Count) do begin
    if fTaskRecords[idx].IsComplete then continue;
    if fTaskRecords[idx].IsLocked then continue;
    if fTaskRecords[idx].Lock then begin
      Result := fTaskRecords[idx];
      exit;
    end;
  end;
end;

function TTaskSet.IsComplete: boolean;
var
  idx: nativeuint;
begin
  Result := False;
  for idx := 0 to pred(fTaskRecords.Count) do begin
    if assigned(fTaskRecords[idx]) then begin
      if not fTaskRecords[idx].IsComplete then exit;
    end;
  end;
  Result := True;
end;

procedure TTaskSet.AssignTaskRecords( const Tasks: array of ITask );
var
  idx: nativeuint;
begin
  if Length(Tasks)=0 then exit;
  for idx := 0 to pred(Length(Tasks)) do begin
    if assigned(Tasks[idx]) then begin
      fTaskRecords.Add(TTaskRecord.Create(Tasks[idx]));
    end;
  end;
end;

procedure TTaskSet.Init(const Tasks: array of ITask);
begin
  fTaskRecords := TList<ITaskRecord>.Create;
  AssignTaskRecords( Tasks );
end;

constructor TTaskSet.Create(const Tasks: array of ITask);
begin
  inherited Create;
  {$ifndef fpc}
  fWhenDone := nil;
  {$else}
  fWhenDoneG := nil;
  fWhenDoneO := nil;
  fWhenDoneN := nil;
  {$endif}
  Init(Tasks);
end;

{$ifndef fpc}
constructor TTaskSet.Create(const Tasks: array of ITask; const WhenDone: TOnComplete);
begin
  inherited Create;
  fWhenDone := WhenDone;
  Init(Tasks);
end;
{$endif}

{$ifdef fpc}
constructor TTaskSet.Create(const Tasks: array of ITask; const WhenDone: TOnCompleteGlobal);
begin
  inherited Create;
  fWhenDoneG := WhenDone;
  fWhenDoneO := nil;
  fWhenDoneN := nil;
  Init(Tasks);
end;
{$endif}

{$ifdef fpc}
constructor TTaskSet.Create(const Tasks: array of ITask; const WhenDone: TOnCompleteOfObject);
begin
  inherited Create;
  fWhenDoneG := nil;
  fWhenDoneO := WhenDone;
  fWhenDoneN := nil;
  Init(Tasks);
end;
{$endif}

{$ifdef fpc}
constructor TTaskSet.Create(const Tasks: array of ITask; const WhenDone: TOnCompleteNested);
begin
  inherited Create;
  fWhenDoneG := nil;
  fWhenDoneO := nil;
  fWhenDoneN := WhenDone;
  Init(Tasks);
end;
{$endif}

destructor TTaskSet.Destroy;
begin
  {$ifndef fpc}
  if assigned(fWhenDone) then fWhenDone;
  {$else}
  if assigned(fWhenDoneG) then fWhenDoneG else
  if assigned(fWhenDoneO) then fWhenDoneO else
  if assigned(fWhenDoneN) then fWhenDoneN;
  {$endif}
  fTaskRecords := nil;
  inherited Destroy;
end;

end.

