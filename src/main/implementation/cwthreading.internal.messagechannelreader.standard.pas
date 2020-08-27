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
unit cwThreading.Internal.MessageChannelReader.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}


interface
uses
  cwStatus
, cwCollections
, cwThreading
, cwThreading.Internal
;

type
  TMessageChannelReader = class( TInterfacedObject, IMessageChannel, IMessageChannelReader )
  private
    fMessagesPending: IRingBuffer<TMessage>;
    fThreadID: TThreadID; //- The ID of the thread permitted to send/post.
    fSleepCS: ISignaledCriticalSection;
  strict private //- IMessageChannel -//
    function PostMessage( const Message: TMessage ): TStatus;
    function SendMessage( const Message: TMessage ): TStatus;
  strict private //- IMessageChannelReader -//
    function getPermittedThreadID: TThreadID;
    function getMessagesPending: boolean;
    function getNextMessage( out Message: TMessage ): boolean;
  public
    constructor Create( const SleepCS: ISignaledCriticalSection ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwCollections.Standard
{$ifdef MSWINDOWS}
, cwWin32.Kernel32
{$endif}
;

function TMessageChannelReader.PostMessage(const Message: TMessage): TStatus;
begin
  Result := TStatus.Unknown;
  if GetCurrentThreadID<>fThreadID then begin
    TStatus(stPostMessageDeniedToThread).Raize;
  end;
  if not fMessagesPending.Push(Message) then begin
    Result := stThreadMessageChannelFull;
  end;
  fSleepCS.Wake;
  Result := TStatus.Success;
end;

function TMessageChannelReader.SendMessage(const Message: TMessage): TStatus;
begin
  Result := TStatus.Unknown;
  if GetCurrentThreadID<>fThreadID then begin
    TStatus(stPostMessageDeniedToThread).Raize;
  end;
  if not fMessagesPending.Push(Message) then begin
    Result := stThreadMessageChannelFull;
  end;
  fSleepCS.Wake;
  Result := TStatus.Success;
end;

function TMessageChannelReader.getPermittedThreadID: TThreadID;
begin
  Result := fThreadID;
end;

function TMessageChannelReader.getMessagesPending: boolean;
begin
  Result := not fMessagesPending.IsEmpty;
end;

function TMessageChannelReader.getNextMessage(out Message: TMessage): boolean;
begin
  Result := False;
  //- If message channel is empty, we'll silent fail because the
  //- IMessagedThread implementation is expected to check getMessagesPending().
  if fMessagesPending.IsEmpty then exit;
  Result := fMessagesPending.Pull(Message);
end;

constructor TMessageChannelReader.Create( const SleepCS: ISignaledCriticalSection );
begin
  inherited Create;
  fSleepCS := SleepCS;
  fMessagesPending := TRingBuffer<TMessage>.Create;
  fThreadID := GetCurrentThreadID;
end;

destructor TMessageChannelReader.Destroy;
begin
  fMessagesPending := nil;
  fSleepCS := nil;
  inherited Destroy;
end;

end.

