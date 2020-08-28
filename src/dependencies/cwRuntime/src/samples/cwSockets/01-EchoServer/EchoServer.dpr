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
{
  This is a sample echo server which is able to support a single client.
    1) Waits for the client to connect.
    2) Waits for text data from the client (utf8)
    3) Prints the data recieved from the client.
    4) Sends the data back to the client as received.
    5) Repeats at step 2 until client disconnects.
    6) Server shuts down.
}
program EchoServer;
{$ifdef fpc}{$mode delphiunicode}{$endif}
{$APPTYPE CONSOLE}
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

var
  ServerSocket: ISocket = nil;
  ClientSocket: ISocket = nil;
  RecvBuffer: IUnicodeBuffer;
  Accepted: boolean;
  QueryResponse: string;

begin
  //- Start by creating a new socket for our server to run on.
  //- Because this sample is intended to run on multiple target platforms, we
  //- select IPv6 (because some platforms have depricated IPv4).
  ServerSocket := TSocket.Create( cSocketDomain );
  if not ServerSocket.Initialize then begin
    Writeln('Failed to create a socket');
    exit;
  end;

  try
    //- We have created a server socket, but it's currently not configured.
    //- We'll start by binding the socket to a network address and port, which
    //- in turn will bind it to one or more network interfaces (to which the
    //- network address belongs).
    if not ServerSocket.Bind( TNetworkAddress.Create(cIPAddress, cPort) ) then begin
      Writeln('The socket failed to bind to the loopback address.');
      exit;
    end;

    //- Now that the server socket is bound to a network address, we tell it
    //- that it should begin listening for incoming connections from clients.
    if not ServerSocket.Listen then begin
      Writeln('The socket failed to enter listening state.');
      exit;
    end;

    //- We now determine if the socket should operate in blocking or
    //- non-blocking mode. If the server socket is blocking (the default mode)
    //- then calls to accept new incoming connections will block execution
    //- until a connection is accepted. In non-blocking mode, cals to
    //- accept a new connection will return immediately, however, there may
    //- not be a new connection made, in which case we must test to see if
    //- a connection is made and if not, we attempt to accept an incoming
    //- connection again.
    Writeln('Would you like the server to operate as a non-blocking socket? (Y/N)');
    Readln(QueryResponse);
    if (QueryResponse='y') or (QueryResponse='Y') then begin
      if not ServerSocket.setBlocking(False) then begin
        Writeln('The socket failed to enter non-blocking mode.');
        exit;
      end;
    end;

    //- Now that we are listening for new connections and have set our
    //- blocking option, we attempt to accept a client connection.
    //- We perform this operation within a loop to be performed
    //- repeately in the case of non-blocking operation. If the server
    //- is blocking, our first attempt is garunteed to have a connection
    //- and the loop will exit on the first pass.
    Writeln('The socket is now listening for connection from client.');
    Accepted := False;
    repeat
      //- Attempt to accept incomming connection (if blocking, will block here until connection is made)
      if ServerSocket.Accept( ClientSocket ) then begin
        //- If the socket is blocking, we now have a new socket which is connected to the client.
        //- If the socket is non-blocking the new connection may be nil, we should try to accept again.
        //- Note: The new socket will be in the same blocking mode as the server socket, which becomes
        //- important later when calling Recv() on the client socket.
        if (ServerSocket.getBlocking) or
           (not ServerSocket.getBlocking) and (assigned(ClientSocket)) then begin
          Writeln('Client connected, a new client socket has been created.');
          Accepted := True;
        end;
      end;
    until Accepted;

    //- We now attempt to receive data from the client socket. We'll do this
    //- repeatedly until the client disconnects.
    Writeln('Now waiting for data from the client socket.');
    RecvBuffer := TBuffer.Create;
    try
      repeat
        RecvBuffer.Size := 512;

        //- If Recv returns any non success code, the client has disconnected.
        //- We could check the status returned from Recv() to see if the
        //- disconnection was graceful or not, however, for this example we
        //- simply state that the client socket disconected, and break the
        //- loop.
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
        Write( RecvBuffer.ReadString( TUnicodeFormat.utf8, FALSE ) );

        //- We now send the recieved data back to the client.
        //- If sending fails for any reason, the client has disconnected.
        //- We could check the status returned from Send() to see if the
        //- disconnection was graceful or not, however, for this example we
        //- simply state that the client socket disconected and break the loop.
        if not ClientSocket.Send(RecvBuffer) then begin
          Writeln('The client socket was disconnected.');
          break;
        end;

      until False;
    finally
      RecvBuffer := nil;
    end;

  finally
    ClientSocket := nil;
    //- Closing the socket is optional in this case, we could simply
    //- set ServerSocket := nil; However, when setting the ServerSocket
    //- nil it may not be reused. Using Close() we could stop the socket
    //- listening, and then later tell the socket to listen again.
    ServerSocket.Close;
    ServerSocket := nil;
    Writeln('Shutting down..');
    Readln;
  end;

end.
