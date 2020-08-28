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

program EchoClient;
{$ifdef fpc}{$mode delphiunicode}{$else}{$APPTYPE CONSOLE}{$endif}
uses
  cwIO
, cwIO.Standard
, cwSockets
, cwSockets.Standard
;

const
  // I'm using IPv6 for most targets because on some targets it is depricated,
  // however, for some reason at this time my older mac (el capitan) will not
  // create an IPv6 socket, so using IPv4 on mac until I can determine why.
  {$ifdef MACOS}
  cIPAddress = '127.0.0.1';
  cSocketDomain: TSocketDomain = sdIPv4;
  {$else}
  cIPAddress = '0000:0000:0000:0000:0000:0000:0000:0001';
  cSocketDomain: TSocketDomain = sdIPv6;
  {$endif}
  cPort = 55443;
  cMaxBuffer = 511;

var
  ClientSocket: ISocket = nil;
  MessageText: string;
  RecvBuffer: IUnicodeBuffer;
  SendBuffer: IUnicodeBuffer;

begin
  //- Start by creating a new socket for our client to connect through.
  //- Because this sample is intended to run on multiple target platforms, we
  //- select IPv6 (because some platforms have depricated IPv4).
  ClientSocket := TSocket.Create( cSocketDomain );
  if not ClientSocket.Initialize then begin
    Writeln('Failed to create socket.');
    exit;
  end;

  try
    //- Connect our client to the server.
    if not ClientSocket.Connect( TNetworkAddress.Create(cIPAddress,cPort) ) then begin
      Writeln('Unable to connect to server.');
      exit;
    end;

    SendBuffer := TBuffer.Create;
    RecvBuffer := TBuffer.Create;
    try
      repeat
        //- Wait for something to send to the server.
        Write('Message: ');
        Readln(MessageText);
        if Length(MessageText)>cMaxBuffer then begin
          Writeln('Keep it short please!');
          continue;
        end;

        //- Create a buffer to send our message
        SendBuffer.WriteString(MessageText,TUnicodeFormat.utf8,True);
        if not ClientSocket.Send(SendBuffer) then begin
          Writeln('Connection to server lost.');
          break;
        end;

        //- If Recv returns any non success code, the client has disconnected.
        //- We could check the status returned from Recv() to see if the
        //- disconnection was graceful or not, however, for this example we
        //- simply state that the client socket disconected, and break the
        //- loop.
        RecvBuffer.Size := 512;
        if not ClientSocket.Recv(RecvBuffer) then begin
          Writeln('The client socket was disconnected.');
          break;
        end;

        //- If the socket is non-blocking, we may receive zero bytes of data,
        //- in which case, do nothing more, start the loop over and attempt
        //- recv again
        if RecvBuffer.Size=0 then begin
          continue;
        end;

        //- If we got here, there is data in the recv buffer. Write this
        //- to the console.
        Writeln( RecvBuffer.ReadString( TUnicodeFormat.utf8, FALSE ) );

      until False;
    finally
      SendBuffer := nil;
      RecvBuffer := nil;
    end;
  finally
    ClientSocket := nil;
  end;
  Readln;
end.
