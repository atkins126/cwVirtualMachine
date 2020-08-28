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
unit cwThreading.Internal.TaskSetCollection.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwThreading
, cwCollections
, cwThreading.Internal
;

type
  TTaskSetCollection = class( TInterfacedObject, ITaskSetCollection )
  private
    fTaskSets: IList<ITaskSet>;
    fTaskSetsCS: ICriticalSection;
  private
    procedure CleanupTasksets;
  strict private //- ITaskSetCollection -//
    // Adds a taskset to the collection
    procedure AddTaskSet( const TaskSet: ITaskSet );
    function getNextTask: ITaskRecord;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwCollections.Standard
{$ifdef MSWINDOWS}
, cwThreading.CriticalSection.Windows
{$else}
, cwThreading.CriticalSection.Posix
{$endif}
;

procedure TTaskSetCollection.CleanupTasksets;
var
  idx: nativeuint;
begin
  if fTaskSets.Count=0 then exit;
  for idx := pred(fTaskSets.Count) downto 0 do begin
    if fTaskSets[idx].IsComplete then begin
      fTaskSets.RemoveItem(idx);
    end;
  end;
end;

procedure TTaskSetCollection.AddTaskSet( const TaskSet: ITaskSet );
begin
  if not assigned(TaskSet) then exit;
  fTaskSetsCS.Acquire;
  try
    fTaskSets.Add(TaskSet);
  finally
    fTaskSetsCS.Release;
  end;
end;

function TTaskSetCollection.getNextTask: ITaskRecord;
var
  idx: nativeuint;
begin
  Result := nil;
  fTaskSetsCS.Acquire;
  try
    CleanupTasksets;
    if fTaskSets.Count=0 then exit;
    for idx := 0 to pred(fTaskSets.Count) do begin
      Result := fTaskSets[idx].getNextTask;
      if assigned(Result) then exit;
    end;
  finally
    fTaskSetsCS.Release;
  end;
end;

constructor TTaskSetCollection.Create;
begin
  inherited Create;
  fTaskSets := TList<ITaskSet>.Create( 32, TRUE, TRUE );
  fTaskSetsCS := TCriticalSection.Create;
end;

destructor TTaskSetCollection.Destroy;
begin
  fTaskSetsCS := nil;
  fTaskSets := nil;
  inherited Destroy;
end;

end.

