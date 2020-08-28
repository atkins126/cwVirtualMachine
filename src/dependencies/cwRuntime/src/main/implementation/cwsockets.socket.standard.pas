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
/// <summary>
///   Provides a target agnostic implementation of ISocket.
/// </summary>
unit cwSockets.Socket.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwStatus
, cwIO
, cwSockets
;

type
  TSocket = class( TInterfacedObject, ISocket )
  private
    fHandle: TSocketHandle;
    fDomain: TSocketDomain;
    fKind: TSocketKind;
    fProtocol: TPacketProtocol;
    fAddress: string;
    fPort: uint32;
    fBlocking: boolean;
  private //- common -//
    function DecodeAddress(const Address: pointer): TStatus;
    function CreateSocket: TStatus;
  private //- enum conversion -//
    function SocketKindToInt(const Kind: TSocketKind): int32;
    function PacketProtocolToInt(const Protocol: TPacketProtocol): int32;
    function SocketDomainToInt(const Domain: TSocketDomain): int32;
    function IntToSocketDomain(const AddrFamily: uint16): TSocketDomain;
    function AddressBuffer(const Domain: TSocketDomain; out Buffer: IBuffer): TStatus;
  private //- IPv4 -//
    function IPv4AddressBuffer: IBuffer;
    function PrepareAddressIPv4(const NetworkAddress: TNetworkAddress): IBuffer;
    procedure DecodeIPv4Address(const Address: pointer);
  private //- IPv6 -//
    function IPv6AddressBuffer: IBuffer;
    function PrepareAddressIPv6(const NetworkAddress: TNetworkAddress): IBuffer;
    procedure DecodeIPv6Address(const Address: pointer);
  strict private //- ISocket -//
    function Initialize: TStatus;
    function Bind(const NetworkAddress: TNetworkAddress): TStatus;
    function Listen: TStatus;
    function Accept(out NewSocket: ISocket): TStatus;
    function Connect(const NetworkAddress: TNetworkAddress): TStatus;
    function Shutdown(const Options: TShutdownOptions): TStatus;
    function Close: TStatus;
    function Send(const Data: IBuffer): TStatus;
    function Recv(const Data: IBuffer): TStatus;
    function setBlocking(const value: boolean): TStatus;
    function getBlocking: boolean;
    function getNetworkAddress: TNetworkAddress;
  protected
    {$warnings off} // fpc warns constructor should be public, this constructor is intentionally protected.
    constructor CreateWithHandle(const Handle: TSocketHandle; const Address: pointer; const Blocking: boolean; out Status: TStatus);
    {$warnings on}
  public
    constructor Create(const Domain: TSocketDomain; const Kind: TSocketKind; const Protocol: TPacketProtocol); reintroduce;
  end;

implementation
uses
  sysutils
, cwTypes
, cwIO.Standard
, cwSockets.Common
;

{$ifdef MSWINDOWS}
var
  wsdata: TWSAData;
{$endif}

function TSocket.SocketKindToInt( const Kind: TSocketKind ): int32;
begin
  Result := 0;
  case Kind of
    skDatagram:  Result := SOCK_DGRAM;
    skStream:    Result := SOCK_STREAM;
    skRaw:       Result := SOCK_RAW;
    skRDM:       Result := SOCK_RDM;
    skSeqPacket: Result := SOCK_SEQPACKET;
  end;
end;

function TSocket.PacketProtocolToInt( const Protocol: TPacketProtocol ): int32;
begin
  Result := 0;
  case Protocol of
    ppUnSpec:   Result := IPPROTO_UNSPEC;
    ppICMP:     Result := IPPROTO_ICMP;
    ppIGMP:     Result := IPPROTO_IGMP;
    ppRFCOMM:   Result := BTHPROTO_RFCOMM;
    ppTCP:      Result := IPPROTO_TCP;
    ppUDP:      Result := IPPROTO_UDP;
    ppICMPV6:   Result := IPPROTO_ICMPV6;
    ppRM:       Result := IPPROTO_RM;
    ppAH:       Result := IPPROTO_AH;
    ppCOMP:     Result := IPPROTO_COMP;
    ppDSTOPTS:  Result := IPPROTO_DSTOPTS;
    ppEGP:      Result := IPPROTO_EGP;
    ppENCAP:    Result := IPPROTO_ENCAP;
    ppESP:      Result := IPPROTO_ESP;
    ppFRAGMENT: Result := IPPROTO_FRAGMENT;
    ppGRE:      Result := IPPROTO_GRE;
    ppHOPOPTS:  Result := IPPROTO_HOPOPTS;
    ppIDP:      Result := IPPROTO_IDP;
    ppIPIP:     Result := IPPROTO_IPIP;
    ppIPV6:     Result := IPPROTO_IPV6;
    ppMTP:      Result := IPPROTO_MTP;
    ppNONE:     Result := IPPROTO_NONE;
    ppPIM:      Result := IPPROTO_PIM;
    ppPUP:      Result := IPPROTO_PUP;
    ppRAW:      Result := IPPROTO_RAW;
    ppROUTING:  Result := IPPROTO_ROUTING;
    ppRSVP:     Result := IPPROTO_RSVP;
    ppSCTP:     Result := IPPROTO_SCTP;
    ppTP:       Result := IPPROTO_TP;
  end;
end;

function TSocket.SocketDomainToInt( const Domain: TSocketDomain ): int32;
begin
  Result := 0;
  case Domain of
    sdUnspecified: Result := AF_UNSPEC;
    sdIPv4:        Result := AF_INET;
    sdIPv6:        Result := AF_INET6;
    sdInfrared:    Result := AF_IRDA;
    sdBluetooth:   Result := AF_BLUETOOTH;
    sdAppleTalk:   Result := AF_APPLETALK;
    sdNetBios:     Result := AF_NETBIOS;
    sdIPX:         Result := AF_IPX;
    sdASH:         Result := AF_ASH;
    sdATMPVC:      Result := AF_ATMPVC;
    sdATMSVC:      Result := AF_ATMSVC;
    sdAX25:        Result := AF_AX25;
    sdBRIDGE:      Result := AF_BRIDGE;
    sdDECnet:      Result := AF_DECnet;
    sdAECONET:     Result := AF_ECONET;
    sdKEY:         Result := AF_KEY;
    sdLLC:         Result := AF_LLC;
    sdLOCAL:       Result := AF_LOCAL;
    sdNETBEUI:     Result := AF_NETBEUI;
    sdNETLINK:     Result := AF_NETLINK;
    sdNETROM:      Result := AF_NETROM;
    sdPACKET:      Result := AF_PACKET;
    sdPPPOX:       Result := AF_PPPOX;
    sdROSE:        Result := AF_ROSE;
    sdROUTE:       Result := AF_ROUTE;
    sdSECURITY:    Result := AF_SECURITY;
    sdSNA:         Result := AF_SNA;
    sdTIPC:        Result := AF_TIPC;
    sdUNIX:        Result := AF_UNIX;
    sdWANPIPE:     Result := AF_WANPIPE;
    sdX25:         Result := AF_X25;
  end;
end;

function TSocket.CreateSocket: TStatus;
begin
  Result := TStatus.Unknown;
  fHandle := sktSocket( SocketDomainToInt(fDomain), SocketKindToInt(fKind), PacketProtocolToInt(fProtocol) );
  if fHandle=INVALID_SOCKET then begin
    Result := TStatus(stSocketError).Return(['create socket',GetLastError().AsString]);
    exit;
  end;
  Result := TStatus.Success;
end;

function TSocket.PrepareAddressIPv4( const NetworkAddress: TNetworkAddress ): IBuffer;
var
  AddrPtr: ^TSockAddrIn;
  IPArray: TArrayOfString;
begin
  //- Create a buffer to contain the resulting address structure, clear it,
  //- and set the AddrPtr for convenient access to the structure members.
  Result := IPv4AddressBuffer;
  AddrPtr := Result.DataPtr;

  //- Set the socket domain
  AddrPtr^.sin_family := SocketDomainToInt(fDomain);

  //- Convert the IP address from string
  IPArray := NetworkAddress.IPAddress.Explode('.');
  if Length(IPArray)<>4 then begin
    Result := nil;
    exit;
  end;
  AddrPtr^.sin_addr.b1 := IPArray[0].AsUInt8;
  AddrPtr^.sin_addr.b2 := IPArray[1].AsUInt8;
  AddrPtr^.sin_addr.b3 := IPArray[2].AsUInt8;
  AddrPtr^.sin_addr.b4 := IPArray[3].AsUInt8;

  //- Set the port number.
  AddrPtr^.sin_port := sktHtoNS(NetworkAddress.Port);
end;

function TSocket.PrepareAddressIPv6( const NetworkAddress: TNetworkAddress ): IBuffer;
var
  AddrPtr: ^TSockAddrIn6;
  IPArray: TArrayOfString;
  idx: nativeuint;
  S: string;
begin
  //- Create a buffer to contain the resulting address structure, clear it,
  //- and set the AddrPtr for convenient access to the structure members.
  Result := IPv6AddressBuffer;
  AddrPtr := Result.DataPtr;

  //- Set the socket domain
  AddrPtr^.sin_family := SocketDomainToInt(fDomain);

  //- Convert the IP address from string
  IPArray := NetworkAddress.IPAddress.Explode(':');
  if Length(IPArray)<>8 then begin
    Result := nil;
    exit;
  end;
  for idx := 0 to pred(Length(IPArray)) do begin
    S := '$'+IPArray[idx];
    S := S.Uppercase;
    S := S.Trim;
    AddrPtr^.sin_addr.addr16[idx] := sktHtoNS(S.AsUInt16);
  end;

  //- Set the port number.
  AddrPtr^.sin_port := sktHtoNS(NetworkAddress.Port);
end;

function TSocket.Bind(const NetworkAddress: TNetworkAddress): TStatus;
var
  retCode: int32;
  Address: IBuffer;
begin
  Result := TStatus.Unknown;
  if fHandle=INVALID_SOCKET then begin
    Result := stInvalidSocketForBind;
    exit;
  end;
  //- Configure the address record for the domain (address family)
  case fDomain of
    sdIPv4: Address := PrepareAddressIPv4( NetworkAddress );
    sdIPv6: Address := PrepareAddressIPv6( NetworkAddress );
    else begin
      Result := stBindNotSupportedOnDomain;
      exit;
    end;
  end;
  if not assigned(Address) then begin
    Result := stFailedToConvertNetworkAddress;
    exit;
  end;
  try
    //- Bind
    retCode := sktBind( fHandle, Address.DataPtr, Address.Size );
    if retCode<>0 then begin
      Result := TStatus(stSocketError).Return(['bind',retCode.AsString]);
      exit;
    end;
    fAddress := NetworkAddress.IPAddress;
    fPort := NetworkAddress.Port;
    Result := TStatus.Success;
  finally
    Address := nil;
  end;
end;

function TSocket.Listen: TStatus;
var
  retCode: int32;
begin
  if fHandle=INVALID_SOCKET then begin
    Result := stInvalidSocketForListen;
  end;
  retCode := sktListen(fHandle,SOMAXCONN);
  if retCode<>0 then begin
    Result := stSocketListenError;
    exit;
  end;
  Result := TStatus.Success;
end;

function TSocket.Accept(out NewSocket: ISocket): TStatus;
var
  Address: IBuffer;
  AddrSize: int32;
  NewHandle: TSocketHandle;
  retCode: int32;
begin
  if fHandle=INVALID_SOCKET then begin
    Result := stInvalidSocketForAccept;
    exit;
  end;
  //- Accept socket
  Result := AddressBuffer(fDomain,Address);
  if not Result then exit;
  try
    AddrSize := Address.Size;
    NewHandle := sktAccept(fHandle,Address.DataPtr,AddrSize);
    if NewHandle=INVALID_SOCKET then begin
      retCode := GetLastError();
      {$ifdef MSWINDOWS}
      if retCode=WSAEWOULDBLOCK then begin
      {$else}
      if (retCode=EAGAIN) or (retCode=EWOULDBLOCK) then begin
      {$endif}
        NewSocket := nil;
        Result := TStatus.Success;
        exit;
      end else begin
        Result := stSocketAcceptError;
        exit;
      end;
    end;
    //- If we got here, we have a new socket
    NewSocket := TSocket.CreateWithHandle(NewHandle,Address.DataPtr,fBlocking,Result);
    if not Result then begin
      NewSocket := nil;
    end;
  finally
    Address := nil;
  end;
end;

function TSocket.Connect(const NetworkAddress: TNetworkAddress): TStatus;
var
  retCode: int32;
  Address: IBuffer;
  AddrSize: int32;
begin
  Result := TStatus.Unknown;
  if fHandle=INVALID_SOCKET then begin
    Result := stInvalidSocketForConnect;
    exit;
  end;
  //- Configure the address record for the domain (address family)
  case fDomain of
    sdIPv4: Address := PrepareAddressIPv4( NetworkAddress );
    sdIPv6: Address := PrepareAddressIPv6( NetworkAddress );
    else begin
      Result := stBindNotSupportedOnDomain;
      exit;
    end;
  end;
  if not assigned(Address) then begin
    Result := stFailedToConvertNetworkAddress;
    exit;
  end;
  try
    //- Connect
    AddrSize := Address.Size;
    retCode := sktConnect( fHandle, Address.DataPtr, AddrSize );
    if retCode<>0 then begin
        Result := TStatus(stSocketError).Return([GetLastError().AsString]);
      exit;
    end;
    fAddress := NetworkAddress.IPAddress;
    fPort := NetworkAddress.Port;
    Result := TStatus.Success;
  finally
    Address := nil;
  end;
end;

function TSocket.Shutdown(const Options: TShutdownOptions): TStatus;
var
  Opts: uint32;
  retCode: int32;
begin
  Result := TStatus.Unknown;
  Opts := 0;
  case Options of
         soBoth: Opts := SD_BOTH;
      soSending: Opts := SD_SEND;
    soReceiving: Opts := SD_RECEIVE;
  end;
  retCode := sktShutdown(fHandle,Opts);
  if retCode<>0 then begin
    Result := TStatus(stSocketError).Return(['shutdown socket',retCode.AsString]);
    exit;
  end;
  Result := TStatus.Success;
end;

function TSocket.Close: TStatus;
var
  retCode: int32;
begin
  retCode := sktCloseSocket(fHandle);
  if retCode<>0 then begin
    Result := TStatus(stSocketError).Return([retCode.AsString]);
    exit;
  end;
  fHandle := INVALID_SOCKET;
  Result := TStatus.Success;
end;

function TSocket.Send(const Data: IBuffer): TStatus;
var
  Sent: int32;
  TotalSent: int32;
  DataPtr: pointer;
  DataSize: int32;
begin
  if fHandle=INVALID_SOCKET then begin
    Result := stInvalidSocketForSend;
    exit;
  end;
  if not assigned(Data) then begin
    Result := stBufferNotAssigned;
    exit;
  end;
  if Data.Size=0 then begin
    Result := TStatus.Success;
    exit;
  end;
  //- Repeatedly attempt to send more data until the buffer has been sent.
  TotalSent := 0;
  while (TotalSent<Data.Size) do begin
      if TotalSent>0 then begin
        DataPtr := {$warnings off}{$hints off} pointer( nativeuint(Data.DataPtr) + pred(TotalSent) ); {$hints on}{$warnings on} // nativeuint is ptr sized.
      end else begin
        DataPtr := {$hints off} pointer( nativeuint(Data.DataPtr) ); {$hints on} // nativeuint is ptr sized.
      end;
      DataSize := {$warnings off} Data.Size - TotalSent; {$warnings on} //- Delphi signed/unsigned warning W1073
      Sent := sktSend(fHandle,DataPtr,DataSize,0); // todo - correct flags
      if Sent = SOCKET_ERROR then begin
        Result := TStatus(stSocketError).Return([GetLastError().AsString]);
        exit;
      end;
      TotalSent := TotalSent + Sent;
  end;
  Result := TStatus.Success;
end;

function TSocket.Recv(const Data: IBuffer): TStatus;
var
  Recvd: int32;
  retCode: int32;
begin
  if fHandle=INVALID_SOCKET then begin
    Result := stInvalidSocketForRecieve;
    exit;
  end;
  if not assigned(Data) then begin
    Result := stBufferNotAssigned;
    exit;
  end;
  if Data.Size=0 then begin
    Result := TStatus.Success;
    exit;
  end;
  Recvd := sktRecv(fHandle,Data.DataPtr,Data.Size,0); // todo - correct flags
  if (Recvd=0) and (not fBlocking) then begin
    Result := stSocketClosed;
    exit;
  end;
  if Recvd = SOCKET_ERROR then begin
    retCode := GetLastError();
    {$ifdef MSWINDOWS}
    if retCode=WSAEWOULDBLOCK then begin
    {$else}
    if (retCode=EAGAIN) or (retCode=EWOULDBLOCK) then begin
    {$endif}
      Data.Size := 0;
      Result := TStatus.Success;
      exit;
    end;
    Result := TStatus(stSocketError).Return([retCode.AsString]);
    exit;
  end;
  Data.Size := Recvd;
  Result := TStatus.Success;
end;

function TSocket.setBlocking(const value: boolean): TStatus;
const
  cBlockingEnabled  = 0;
  cBlockingDisabled = 1;
var
  Option: uint32;
begin
  if fBlocking=Value then begin
    Result := TStatus.Success;
    exit;
  end;
  if value then begin
    Option := cBlockingEnabled;
  end else begin
    Option := cBlockingDisabled;
  end;
  if ioctl(fHandle, FIONBIO, Option)=SOCKET_ERROR then begin
    Result := TStatus(stSocketError).Return([GetLastError().AsString]);
    exit;
  end;
  fBlocking := Value;
  Result := TStatus.Success;
end;

function TSocket.getBlocking: boolean;
begin
  Result := fBlocking;
end;

function TSocket.getNetworkAddress: TNetworkAddress;
begin
  Result.IPAddress := fAddress;
  Result.Port := fPort;
end;

function TSocket.Initialize: TStatus;
begin
  if fHandle<>INVALID_SOCKET then begin
    Result := TStatus.Success;
    exit;
  end;
  Result := CreateSocket;
end;

function TSocket.IntToSocketDomain( const AddrFamily: uint16 ): TSocketDomain;
begin
  Result := TSocketDomain.sdUnspecified;  //<- Just to avoid Delphi may be undefined warning).
  case AddrFamily of
    AF_UNSPEC:    Result := TSocketDomain.sdUnspecified;
    AF_UNIX:      Result := TSocketDomain.sdUNIX;
    AF_INET:      Result := TSocketDomain.sdIPv4;
    AF_AX25:      Result := TSocketDomain.sdAX25;
    AF_NETROM:    Result := TSocketDomain.sdNetRom;
    AF_BRIDGE:    Result := TSocketDomain.sdBridge;
    AF_ATMPVC:    Result := TSocketDomain.sdATMPVC;
    AF_X25:       Result := TSocketDomain.sdX25;
    AF_ROSE:      Result := TSocketDomain.sdRose;
    AF_DECnet:    Result := TSocketDomain.sdDECnet;
    AF_NETBEUI:   Result := TSocketDomain.sdNetBEUI;
    AF_SECURITY:  Result := TSocketDomain.sdSecurity;
    AF_KEY:       Result := TSocketDomain.sdKey;
    AF_NETLINK:   Result := TSocketDomain.sdNetLink;
    AF_NETBIOS:   Result := TSocketDomain.sdNetBIOS;
    AF_ASH:       Result := TSocketDomain.sdASH;
    AF_ECONET:    Result := TSocketDomain.sdAECONET;
    AF_ATMSVC:    Result := TSocketDomain.sdATMSVC;
    AF_SNA:       Result := TSocketDomain.sdSNA;
    AF_PPPOX:     Result := TSocketDomain.sdPPPOX;
    AF_WANPIPE:   Result := TSocketDomain.sdWANPIPE;
    AF_LLC:       Result := TSocketDomain.sdLLC;
    AF_TIPC:      Result := TSocketDomain.sdTIPC;
    AF_BLUETOOTH: Result := TSocketDomain.sdBlueTooth;
    AF_INET6:     Result := TSocketDomain.sdIPv6;
  end;
end;

function TSocket.AddressBuffer(const Domain: TSocketDomain; out Buffer: IBuffer): TStatus;
begin
  Result := TStatus.Unknown;
  case Domain of
    sdIPv4: Buffer := IPv4AddressBuffer;
    sdIPv6: Buffer := IPv6AddressBuffer;
    else begin
      Result := stUnsupportedAddressFormat;
      exit;
    end;
  end;
  Result := TStatus.Success;
end;

function TSocket.IPv4AddressBuffer: IBuffer;
begin
  Result := TBuffer.Create(sizeof(TSockAddrIn));
  Result.FillMem(0);
end;

procedure TSocket.DecodeIPv4Address(const Address: pointer);
var
  AddrPtr: ^TSockAddrIn;
begin
  AddrPtr := Address;
//  fPort := NSToH(AddrPtr^.sin_port);
  fPort := AddrPtr^.sin_port;
  fAddress :=
    AddrPtr^.sin_addr.b1.AsString+'.'+
    AddrPtr^.sin_addr.b2.AsString+'.'+
    AddrPtr^.sin_addr.b3.AsString+'.'+
    AddrPtr^.sin_addr.b4.AsString;
end;

function TSocket.IPv6AddressBuffer: IBuffer;
begin
  Result := TBuffer.Create(sizeof(TSockAddrIn6));
  Result.FillMem(0);
end;

procedure TSocket.DecodeIPv6Address(const Address: pointer);
var
  AddrPtr: ^TSockAddrIn6;
begin
  AddrPtr := Address;
//  fPort := NSToH(AddrPtr^.sin_port);
  fPort := AddrPtr^.sin_port;
  fAddress :=
    AddrPtr^.sin_addr.addr16[0].AsString+':'+
    AddrPtr^.sin_addr.addr16[1].AsString+':'+
    AddrPtr^.sin_addr.addr16[2].AsString+':'+
    AddrPtr^.sin_addr.addr16[3].AsString+':'+
    AddrPtr^.sin_addr.addr16[4].AsString+':'+
    AddrPtr^.sin_addr.addr16[5].AsString+':'+
    AddrPtr^.sin_addr.addr16[6].AsString+':'+
    AddrPtr^.sin_addr.addr16[7].AsString;
end;

function TSocket.DecodeAddress(const Address: pointer): TStatus;
var
  AddressPtr: ^TSockAddr;
begin
  AddressPtr := Address;
  fDomain := IntToSocketDomain(AddressPtr^.sa_family);
  //- Configure the address record for the domain (address family)
  case fDomain of
    sdIPv4: DecodeIPv4Address( Address );
    sdIPv6: DecodeIPv6Address( Address );
    else begin
      Result := stUnknownSocketDomain;
      exit;
    end;
  end;
  Result := TStatus.Success;
end;

constructor TSocket.CreateWithHandle(const Handle: TSocketHandle; const Address: pointer; const Blocking: boolean; out Status: TStatus);
begin
  inherited Create;
  fHandle := Handle;
  fBlocking := Blocking;
  Status := DecodeAddress( Address );
end;

constructor TSocket.Create( const Domain: TSocketDomain; const Kind: TSocketKind; const Protocol: TPacketProtocol );
begin
  inherited Create;
  fBlocking := True;
  fHandle   := INVALID_SOCKET;
  fKind     := Kind;
  fDomain   := Domain;
  fProtocol := Protocol;
  fAddress  := '';
  fPort     := 0;
end;


initialization
  {$ifdef MSWINDOWS}
  cwStartup($0002 {version 2}, @wsdata);
  {$endif}

finalization
  {$ifdef MSWINDOWS}
  cwCleanup;
  {$endif}

end.

