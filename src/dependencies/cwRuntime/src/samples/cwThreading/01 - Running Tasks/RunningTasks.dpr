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
program RunningTasks;
uses
  sysutils
, cwTypes
, cwThreading
, cwThreading.Standard
;

type
  TSingleArray = array[0..999999] of single;
  pSingleArray = ^TSingleArray;

var
  AddArrayLeft: TSingleArray;
  AddArrayRight: TSingleArray;
  TotalsArray: TSingleArray;
  TasksCompleteFlag: boolean;
  TaskArray: array of ITask;
  idx: nativeuint;

type
  TAdditionTask = class( TInterfacedObject, ITask )
  private
    ftgtArray: pSingleArray;
    fsrcAArray: pSingleArray;
    fsrcBArray: pSingleArray;
    fStart: nativeuint;
    fStop: nativeuint;
  strict private //- ITask -//
    procedure Execute;
  public
    constructor Create( const tgtArray, srcAArray, srcBArray: TSingleArray; const Start,Stop: nativeuint ); reintroduce;
  end;

procedure TAdditionTask.Execute;
var
  idx: nativeuint;
begin
  for idx := fStart to fStop do begin
    ftgtArray^[idx] := fsrcAArray^[idx] + fsrcBArray^[idx];
  end;
end;

constructor TAdditionTask.Create(const tgtArray, srcAArray, srcBArray: TSingleArray; const Start, Stop: nativeuint);
begin
  inherited Create;
  ftgtArray := @tgtArray;
  fsrcAArray := @srcAArray;
  fsrcBArray := @srcBArray;
  fStart := Start;
  fStop := Stop;
end;

procedure TasksComplete;
begin
  TasksCompleteFlag := True;
end;

var
  S: string;

begin
  //- Initialize srcA and srcB arrays with random data.
  for idx := 0 to pred(Length(AddArrayLeft)) do begin
    AddArrayLeft[idx] := (Random(100)/100);
    AddArrayRight[idx] := (Random(100)/100);
  end;

  //- Arrange some tasks to perform the computation.
  SetLength(TaskArray,Length(AddArrayLeft) div 10);
  for idx := 0 to pred(Length(TaskArray)) do begin
    TaskArray[idx] := TAdditionTask.Create( TotalsArray, AddArrayLeft, AddArrayRight, idx*10, succ(idx)*10 );
  end;

  //- Have the thread system perform the work
  TasksCompleteFlag := False;
  Writeln('Working ... ');
  ThreadSystem.Execute(TaskArray,TRUE);

  //- Spit all of the results out in a big string, just as confirmation that
  //- the work is done.
  for idx := 0 to pred(Length(TotalsArray)) do begin
    Str(TotalsArray[idx],S);
    Writeln(S);
  end;

  Writeln('[DONE]');
  Readln;
end.

