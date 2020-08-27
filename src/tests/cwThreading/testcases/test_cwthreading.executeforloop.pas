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
unit test_cwThreading.ExecuteForLoop;
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
  TTestExecuteForLoop = class(TTestCase)
  private
    fObjectNotifyDone: boolean;
    fObjectData: array of boolean;
  private
    procedure DoObjectNotify;
    procedure ObjectExecute( const start, stop: nativeuint );
  published
    {$ifndef fpc}
    procedure ExecuteForAnonymousNotify;
    {$endif}
    procedure ExecuteForGlobalExecuteGlobalNotify;
    procedure ExecuteForGlobalExecuteObjectNotify;
    procedure ExecuteForGlobalExecuteNestedNotify;
    procedure ExecuteForGlobalExecuteWait;
    procedure ExecuteForObjectExecuteGlobalNotify;
    procedure ExecuteForObjectExecuteObjectNotify;
    procedure ExecuteForObjectExecuteNestedNotify;
    procedure ExecuteForObjectExecuteWait;
    procedure ExecuteForNestedExecuteGlobalNotify;
    procedure ExecuteForNestedExecuteObjectNotify;
    procedure ExecuteForNestedExecuteNestedNotify;
    procedure ExecuteForNestedExecuteWait;
  end;

implementation
uses
  sysutils // for sleep
, cwThreading
, cwThreading.Standard
;

var
  GlobalNotifyDone: boolean;
  GlobalData: array of boolean;

procedure GlobalNotify;
begin
  GlobalNotifyDone := True;
end;

procedure GlobalExecute( const start, stop: nativeuint );
var
  idx: nativeuint;
begin
  for idx := start to stop do begin
    GlobalData[idx] := not GlobalData[idx];
  end;
end;

procedure TTestExecuteForLoop.DoObjectNotify;
begin
  fObjectNotifyDone := True;
end;

procedure TTestExecuteForLoop.ObjectExecute( const start, stop: nativeuint );
var
  idx: nativeuint;
begin
  for idx := start to stop do begin
    fObjectData[idx] := not fObjectData[idx];
  end;
end;

{$ifndef fpc}
procedure TTestExecuteForLoop.ExecuteForAnonymousNotify;
const
  cLoopCount = 1000;
var
  AnonymousNotifyDone: boolean;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(GlobalData,cLoopCount);
  for idx := 0 to pred(Length(GlobalData)) do begin
    GlobalData[idx] := False;
  end;
  AnonymousNotifyDone := False;
  TaskCounter := 0;
  // Act:
  ThreadSystem.Execute(cLoopCount,
    procedure( const start, stop: nativeuint );
    begin
      GlobalData[idx] := not GlobalData[idx];
    end,
    procedure();
    begin
      AnonymousNotifyDone := True;
    end
  );
  while not AnonymousNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(AnonymousNotifyDone);
  for idx := 0 to pred(Length(GlobalData)) do begin
    TTest.Expect(GlobalData[idx],True);
  end;
end;
{$endif}

procedure TTestExecuteForLoop.ExecuteForGlobalExecuteGlobalNotify;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(GlobalData,cLoopCount);
  for idx := 0 to pred(Length(GlobalData)) do begin
    GlobalData[idx] := False;
  end;
  GlobalNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, GlobalExecute, GlobalNotify);
  while not GlobalNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(GlobalNotifyDone);
  for idx := 0 to pred(Length(GlobalData)) do begin
    TTest.Expect(GlobalData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForGlobalExecuteObjectNotify;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(GlobalData,cLoopCount);
  for idx := 0 to pred(Length(GlobalData)) do begin
    GlobalData[idx] := False;
  end;
  fObjectNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, GlobalExecute, DoObjectNotify);
  while not fObjectNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(fObjectNotifyDone);
  for idx := 0 to pred(Length(GlobalData)) do begin
    TTest.Expect(GlobalData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForGlobalExecuteNestedNotify;
const
  cLoopCount = 1000;
var
  NestedNotifyDone: boolean;
  procedure DoNestedNotify;
  begin
    NestedNotifyDone := True;
  end;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(GlobalData,cLoopCount);
  for idx := 0 to pred(Length(GlobalData)) do begin
    GlobalData[idx] := False;
  end;
  NestedNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, GlobalExecute, DoNestedNotify);
  while not NestedNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(NestedNotifyDone);
  for idx := 0 to pred(Length(GlobalData)) do begin
    TTest.Expect(GlobalData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForGlobalExecuteWait;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(GlobalData,cLoopCount);
  for idx := 0 to pred(Length(GlobalData)) do begin
    GlobalData[idx] := False;
  end;
  // Act:
  ThreadSystem.Execute(cLoopCount, GlobalExecute, TRUE);
  // Assert:
  for idx := 0 to pred(Length(GlobalData)) do begin
    TTest.Expect(GlobalData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForObjectExecuteGlobalNotify;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(fObjectData,cLoopCount);
  for idx := 0 to pred(Length(fObjectData)) do begin
    fObjectData[idx] := False;
  end;
  GlobalNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, ObjectExecute, GlobalNotify);
  while not GlobalNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(GlobalNotifyDone);
  for idx := 0 to pred(Length(fObjectData)) do begin
    TTest.Expect(fObjectData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForObjectExecuteObjectNotify;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(fObjectData,cLoopCount);
  for idx := 0 to pred(Length(fObjectData)) do begin
    fObjectData[idx] := False;
  end;
  fObjectNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, ObjectExecute, DoObjectNotify);
  while not fObjectNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(fObjectNotifyDone);
  for idx := 0 to pred(Length(fObjectData)) do begin
    TTest.Expect(fObjectData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForObjectExecuteNestedNotify;
const
  cLoopCount = 1000;
var
  NestedNotifyDone: boolean;
  procedure DoNestedNotify;
  begin
    NestedNotifyDone := True;
  end;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(fObjectData,cLoopCount);
  for idx := 0 to pred(Length(fObjectData)) do begin
    fObjectData[idx] := False;
  end;
  NestedNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, ObjectExecute, DoNestedNotify);
  while not NestedNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(NestedNotifyDone);
  for idx := 0 to pred(Length(fObjectData)) do begin
    TTest.Expect(fObjectData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForObjectExecuteWait;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
begin
  // Arrange:
  SetLength(fObjectData,cLoopCount);
  for idx := 0 to pred(Length(fObjectData)) do begin
    fObjectData[idx] := False;
  end;
  // Act:
  ThreadSystem.Execute(cLoopCount, ObjectExecute, TRUE);
  // Assert:
  for idx := 0 to pred(Length(fObjectData)) do begin
    TTest.Expect(fObjectData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForNestedExecuteGlobalNotify;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
  NestedData: array of boolean;

  procedure NestedExecute( const start, stop: nativeuint );
  var
    idx: nativeuint;
  begin
    for idx := start to stop do begin
      NestedData[idx] := not NestedData[idx];
    end;
  end;

begin
  // Arrange:
  {$hints off} SetLength(NestedData,cLoopCount); {$hints on}
  for idx := 0 to pred(Length(NestedData)) do begin
    NestedData[idx] := False;
  end;
  GlobalNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, NestedExecute, GlobalNotify);
  while not GlobalNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(GlobalNotifyDone);
  for idx := 0 to pred(Length(NestedData)) do begin
    TTest.Expect(NestedData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForNestedExecuteObjectNotify;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
  NestedData: array of boolean;

  procedure NestedExecute( const start, stop: nativeuint );
  var
    idx: nativeuint;
  begin
    for idx := start to stop do begin
      NestedData[idx] := not NestedData[idx];
    end;
  end;

begin
  // Arrange:
  {$hints off} SetLength(NestedData,cLoopCount); {$hints on}
  for idx := 0 to pred(Length(NestedData)) do begin
    NestedData[idx] := False;
  end;
  fObjectNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, NestedExecute, DoObjectNotify);
  while not fObjectNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(fObjectNotifyDone);
  for idx := 0 to pred(Length(NestedData)) do begin
    TTest.Expect(NestedData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForNestedExecuteNestedNotify;
const
  cLoopCount = 1000;
var
  NestedNotifyDone: boolean;
  NestedData: array of boolean;

  procedure NestedExecute( const start, stop: nativeuint );
  var
    idx: nativeuint;
  begin
    for idx := start to stop do begin
      NestedData[idx] := not NestedData[idx];
    end;
  end;

  procedure DoNestedNotify;
  begin
    NestedNotifyDone := True;
  end;

var
  idx: nativeuint;
begin
  // Arrange:
  {$hints off} SetLength(NestedData,cLoopCount); {$hints on}
  for idx := 0 to pred(Length(NestedData)) do begin
    NestedData[idx] := False;
  end;
  NestedNotifyDone := False;
  // Act:
  ThreadSystem.Execute(cLoopCount, NestedExecute, DoNestedNotify);
  while not NestedNotifyDone do Sleep(1);
  // Assert:
  TTest.IsTrue(NestedNotifyDone);
  for idx := 0 to pred(Length(NestedData)) do begin
    TTest.Expect(NestedData[idx],True);
  end;
end;

procedure TTestExecuteForLoop.ExecuteForNestedExecuteWait;
const
  cLoopCount = 1000;
var
  idx: nativeuint;
  NestedData: array of boolean;

  procedure NestedExecute( const start, stop: nativeuint );
  var
    idx: nativeuint;
  begin
    for idx := start to stop do begin
      NestedData[idx] := not NestedData[idx];
    end;
  end;

begin
  // Arrange:
  {$hints off} SetLength(NestedData,cLoopCount); {$hints on}
  for idx := 0 to pred(Length(NestedData)) do begin
    NestedData[idx] := False;
  end;
  // Act:
  ThreadSystem.Execute(cLoopCount, NestedExecute, TRUE);
  // Assert:
  for idx := 0 to pred(Length(NestedData)) do begin
    TTest.Expect(NestedData[idx],True);
  end;
end;


initialization
  TestSuite.RegisterTestCase(TTestExecuteForLoop);

end.

