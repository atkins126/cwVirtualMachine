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
unit cwThreading.Internal.ForLoopTask.Standard;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch nestedprocvars}
{$endif}


interface
uses
  cwThreading
;

type
  TForLoopTask = class(TInterfacedObject, ITask)
  private
    fStart: nativeuint;
    fStop: nativeuint;
    {$ifndef fpc}
    fOnExecute: TOnExecute;
    {$endif}
    {$ifdef fpc}
    fOnExecuteG: TOnExecuteGlobal;
    fOnExecuteO: TOnExecuteOfObject;
    fOnExecuteN: TOnExecuteNested;
    {$endif}
  strict private //- ITask -//
    procedure Execute;
  public
    {$ifndef fpc}
    constructor Create( const Start, Stop: nativeuint; const OnExecute: TOnExecute ); reintroduce; overload;
    {$endif}
    {$ifdef fpc}
    constructor Create( const Start, Stop: nativeuint; const OnExecute: TOnExecuteGlobal ); reintroduce; overload;
    constructor Create( const Start, Stop: nativeuint; const OnExecute: TOnExecuteOfObject ); reintroduce; overload;
    constructor Create( const Start, Stop: nativeuint; const OnExecute: TOnExecuteNested ); reintroduce; overload;
    {$endif}
  end;

implementation

procedure TForLoopTask.Execute;
begin
  {$ifndef fpc}
  if assigned(fOnExecute) then fOnExecute( fStart, fStop );
  {$endif}
  {$ifdef fpc}
  if assigned(fOnExecuteG) then fOnExecuteG( fStart, fStop );
  if assigned(fOnExecuteO) then fOnExecuteO( fStart, fStop );
  if assigned(fOnExecuteN) then fOnExecuteN( fStart, fStop );
  {$endif}
end;

{$ifndef fpc}
constructor TForLoopTask.Create(const Start, Stop: nativeuint; const OnExecute: TOnExecute);
begin
  inherited Create;
  fOnExecute := OnExecute;
end;
{$endif}

{$ifdef fpc}
constructor TForLoopTask.Create(const Start, Stop: nativeuint; const OnExecute: TOnExecuteGlobal);
begin
  inherited Create;
  fOnExecuteG := OnExecute;
  fOnExecuteO := nil;
  fOnExecuteN := nil;
  fStart := Start;
  fStop := Stop;
end;
{$endif}

{$ifdef fpc}
constructor TForLoopTask.Create(const Start, Stop: nativeuint; const OnExecute: TOnExecuteOfObject);
begin
  inherited Create;
  fOnExecuteG := nil;
  fOnExecuteO := OnExecute;
  fOnExecuteN := nil;
  fStart := Start;
  fStop := Stop;
end;
{$endif}

{$ifdef fpc}
constructor TForLoopTask.Create(const Start, Stop: nativeuint; const OnExecute: TOnExecuteNested);
begin
  inherited Create;
  fOnExecuteG := nil;
  fOnExecuteO := nil;
  fOnExecuteN := OnExecute;
  fStart := Start;
  fStop := Stop;
end;
{$endif}

end.

