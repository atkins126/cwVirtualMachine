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
unit test_cwThreading.Internal.TaskRecord;
{$ifdef fpc} {$mode delphiunicode} {$endif}
{$M+}

interface
uses
  cwTest
, cwTest.Standard
;

type
  TTestTaskRecord = class(TTestCase)
  published
    procedure TaskRecordExecuteAndSetBool;
    procedure TaskRecordLockIsLocked;
  end;

implementation
uses
  cwThreading
, cwThreading.Internal
, cwThreading.Internal.TaskRecord.Standard
;

{$region ' A dummy task for testing'}
type
  (* A dummy task which sets the boolean,
     pointed to by PtrBoolean in the constructor, to TRUE *)
  pBoolean = ^Boolean;
  TTestTask = class( TInterfacedObject, ITask )
  private
    fPtrBoolean: pBoolean;
  strict private //- ITask -//
    procedure Execute;
  public
    constructor Create( const PtrBoolean: pBoolean ); reintroduce;
  end;

procedure TTestTask.Execute;
begin
  fPtrBoolean^ := True;
end;

constructor TTestTask.Create(const PtrBoolean: pBoolean);
begin
  inherited Create;
  fPtrBoolean := PtrBoolean;
  fPtrBoolean^ := False;
end;

{$endregion}

procedure TTestTaskRecord.TaskRecordExecuteAndSetBool;
var
  ExecuteBool: boolean;
  TaskRecord: ITaskRecord;
begin
  // Arrange:
  ExecuteBool := False;
  TaskRecord := TTaskRecord.Create( TTestTask.Create( @ExecuteBool ) );
  // Act:
  TaskRecord.Execute;
  // Assert:
  TTest.Expect(TRUE,ExecuteBool);
end;

procedure TTestTaskRecord.TaskRecordLockIsLocked;
var
  PreLock: boolean;
  PostLock: boolean;
  TaskRecord: ITaskRecord;
begin
  // Arrange:
  PreLock := True;
  PostLock := False;
  TaskRecord := TTaskRecord.Create( nil );
  // Act:
  PreLock := TaskRecord.IsLocked;
  TaskRecord.Lock;
  PostLock := TaskRecord.IsLocked;
  // Assert:
  TTest.Expect(False,PreLock);
  TTest.Expect(TRUE,PostLock);
end;

initialization
  TestSuite.RegisterTestCase(TTestTaskRecord);

end.

