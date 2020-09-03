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
unit testcase.cwThreading.ExecuteTasks;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch nestedprocvars}
{$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
;

type
  TTestExecuteTasks = class(TTestCase)
  private
    fObjectNotifyDone: boolean;
  private
    procedure DoObjectNotify;
  published
    {$ifndef fpc}
    procedure ExecuteTasksAnonymousNotify;
    {$endif}
    procedure ExecuteTasksGlobalNotify;
    procedure ExecuteTasksObjectNotify;
    procedure ExecuteTasksNestedNotify;
    procedure ExecuteTasksWait;
  end;

implementation
uses
  sysutils // for sleep
, cwThreading
, cwThreading.Standard
;

{$region ' A dummy task for testing'}
type
  (* A dummy task which sets the boolean,
     pointed to by PtrBoolean in the constructor, to TRUE *)
  pNativeuint = ^Nativeuint;
  TTestTask = class( TInterfacedObject, ITask )
  private
    fPtrNativeuint: pNativeuint;
  strict private //- ITask -//
    procedure Execute;
  public
    constructor Create( const PtrNativeuint: pNativeuint ); reintroduce;
  end;

procedure TTestTask.Execute;
begin
  inc(fPtrNativeuint^);
end;

constructor TTestTask.Create(const PtrNativeuint: pNativeuint);
begin
  inherited Create;
  fPtrNativeuint := PtrNativeuint;
end;

{$endregion}

var
  GlobalNotifyDone: boolean;

procedure GlobalNotify;
begin
  GlobalNotifyDone := True;
end;

procedure TTestExecuteTasks.DoObjectNotify;
begin
  fObjectNotifyDone := True;
end;

{$ifndef fpc}
procedure TTestExecuteTasks.ExecuteTasksAnonymousNotify;
const
  cTaskCount = 1000;
var
  AnonymousNotifyDone: boolean;
var
  Tasks: array[0..cTaskCount-1] of ITask;
  TaskCounter: nativeuint;
  idx: nativeuint;
begin
  // Arrange:
  for idx := 0 to pred(Length(Tasks)) do begin
    Tasks[idx] := TTestTask.Create(@TaskCounter);
  end;
  AnonymousNotifyDone := False;
  TaskCounter := 0;
  // Act:
  ThreadSystem.Execute(Tasks,
    procedure();
    begin
      AnonymousNotifyDone := True;
    end
  );
  while not AnonymousNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(AnonymousNotifyDone);
  TTest.Expect(cTaskCount,TaskCounter);
end;
{$endif}

procedure TTestExecuteTasks.ExecuteTasksGlobalNotify;
const
  cTaskCount = 1000;
var
  Tasks: array[0..cTaskCount-1] of ITask;
  TaskCounter: nativeuint;
  idx: nativeuint;
begin
  // Arrange:
  for idx := 0 to pred(Length(Tasks)) do begin
    Tasks[idx] := TTestTask.Create(@TaskCounter);
  end;
  GlobalNotifyDone := False;
  TaskCounter := 0;
  // Act:
  ThreadSystem.Execute(Tasks,GlobalNotify);
  while not GlobalNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(GlobalNotifyDone);
  TTest.Expect(nativeuint(cTaskCount),TaskCounter);
end;

procedure TTestExecuteTasks.ExecuteTasksObjectNotify;
const
  cTaskCount = 1000;
var
  Tasks: array[0..cTaskCount-1] of ITask;
  TaskCounter: nativeuint;
  idx: nativeuint;
begin
  // Arrange:
  for idx := 0 to pred(Length(Tasks)) do begin
    Tasks[idx] := TTestTask.Create(@TaskCounter);
  end;
  fObjectNotifyDone := False;
  TaskCounter := 0;
  // Act:
  ThreadSystem.Execute(Tasks,DoObjectNotify);
  while not fObjectNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(fObjectNotifyDone);
  TTest.Expect(nativeuint(cTaskCount),TaskCounter);
end;

procedure TTestExecuteTasks.ExecuteTasksNestedNotify;
const
  cTaskCount = 1000;
var
  NestedNotifyDone: boolean;
  procedure DoNestedNotify;
  begin
    NestedNotifyDone := True;
  end;
var
  Tasks: array[0..cTaskCount-1] of ITask;
  TaskCounter: nativeuint;
  idx: nativeuint;
begin
  // Arrange:
  for idx := 0 to pred(Length(Tasks)) do begin
    Tasks[idx] := TTestTask.Create(@TaskCounter);
  end;
  NestedNotifyDone := False;
  TaskCounter := 0;
  // Act:
  ThreadSystem.Execute(Tasks,DoNestedNotify);
  while not NestedNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(NestedNotifyDone);
  TTest.Expect(nativeuint(cTaskCount),TaskCounter);
end;

procedure TTestExecuteTasks.ExecuteTasksWait;
const
  cTaskCount = 1000;
var
  Tasks: array[0..cTaskCount-1] of ITask;
  TaskCounter: nativeuint;
  idx: nativeuint;
begin
  // Arrange:
  for idx := 0 to pred(Length(Tasks)) do begin
    Tasks[idx] := TTestTask.Create(@TaskCounter);
  end;
  TaskCounter := 0;
  // Act:
  ThreadSystem.Execute(Tasks,TRUE);
  // Assert:
  TTest.Expect(nativeuint(cTaskCount),TaskCounter);
end;

initialization
  TestSuite.RegisterTestCase(TTestExecuteTasks);

end.

