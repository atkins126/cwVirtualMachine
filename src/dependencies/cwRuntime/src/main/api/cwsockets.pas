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
///   Chapmanworld Sockets Wrapper.
/// </summary>
unit cwSockets;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwStatus
, cwIO
;

resourcestring
  stSocketError                   = '{25ABA9CE-4D63-4159-BD96-A75200DCF95A} Socket error occurred while performing action: (%action%) with message: (%message%).';
  stInvalidSocket                 = '{A775B8AE-2429-47F3-B2FF-448520988600} Invalid socket handle.';
  stInvalidSocketForBind          = '{E39CB945-466B-4892-9290-F6986F0FFA5E} Invalid socket handle for bind.';
  stInvalidSocketForListen        = '{00E27681-C57A-4569-8E5B-B857CCF8A9CC} Invalid socket handle for listen.';
  stInvalidSocketForAccept        = '{536BBC85-E05D-410C-96E9-904C73671AC6} Invalid socket handle for accept.';
  stInvalidSocketForConnect       = '{4AC425C2-B987-4C16-832C-24FE3F17B4DA} Invalid socket handle for connect.';
  stInvalidSocketForSend          = '{EBA7528D-123F-4928-9A80-0EC6463D4E83} Invalid socket handle for send.';
  stInvalidSocketForRecieve       = '{80F4A432-A642-42D3-B051-C832DF65CA5F} Invalid socket handle for recieve.';
  stBindNotSupportedOnDomain      = '{AF5CF513-0CC3-4C86-A806-E554A289E4EB} Bind operation is not supported on this domain.';
  stFailedToConvertNetworkAddress = '{0870D86F-EEC7-433A-9492-5D77D3169FAF} Network address translation failed.';
  stSocketListenError             = '{800DAF37-23C7-441B-AB51-EB975046BB5C} Error occurred while listening on socket.';
  stSocketAcceptError             = '{B866CE66-9992-4A97-99C2-D9D56969CAC8} Error occurred while accepting on socket.';
  stBufferNotAssigned             = '{BECB47BC-9E38-4C36-9A26-3254FDAAD946} Attempt to send/recv failed due to unassigned buffer.';
  stSocketClosed                  = '{1052CB2A-A5AC-4ECB-9132-E790AA3E0C35} The socket is closed.';
  stUnsupportedAddressFormat      = '{777B3376-BA5F-454C-8D8C-0A07BE39D5C0} Unsupported address format.';
  stUnknownSocketDomain           = '{5731F97C-9273-463B-BB2E-27BDD61B3385} Unknown socket domain.';


type
  ///  <summary>
  ///    Represents a socket handle.
  ///  </summary>
  {$ifdef mswindows}
    TSocketHandle = nativeint;
  {$else}
    TSocketHandle = int32;
  {$endif}

  /// <summary>
  ///   The socket domain indicates the type of address being used to initiate
  ///   a socket.
  /// </summary>
  TSocketDomain = (

      /// <summary>
      ///   The address family is unspecified.
      /// </summary>
      sdUnspecified,

      /// <summary>
      ///   The Internet Protocol version 4 (IPv4) address family.
      /// </summary>
      sdIPv4,

      /// <summary>
      ///   The Internet Protocol version 6 (IPv6) address family.
      /// </summary>
      sdIPv6,

      /// <summary>
      ///   The Infrared Data Association (IrDA) address family. This address
      ///   family is only supported if the computer has an infrared port and
      ///   driver installed.
      /// </summary>
      sdInfrared,

      /// <summary>
      ///   The Bluetooth address family. This address family is if the computer
      ///   has a Bluetooth adapter and driver installed.
      /// </summary>
      sdBluetooth,

      /// <summary>
      ///   Address family Appletalk DDP
      /// </summary>
      sdAppleTalk,

      /// <summary>
      ///   <para>
      ///     From MSDN: <br /><br />The NetBIOS address family. This address
      ///     family is only supported if the Windows Sockets provider for
      ///     NetBIOS is installed.
      ///   </para>
      ///   <para>
      ///     <br />The Windows Sockets provider for NetBIOS is supported on
      ///     32-bit <br />versions of Windows. This provider is installed by
      ///     default on 32-bit versions of Windows.
      ///   </para>
      ///   <para>
      ///     The Windows Sockets provider for NetBIOS is not supported on
      ///     64-bit versions of windows including Windows 7, Windows Server
      ///     2008, Windows Vista, Windows Server 2003, or Windows XP.
      ///   </para>
      ///   <para>
      ///     The Windows Sockets provider for NetBIOS only supports sockets
      ///     where the type parameter is set to SOCK_DGRAM.
      ///   </para>
      ///   <para>
      ///     The Windows Sockets provider for NetBIOS is not directly related
      ///     to the NetBIOS programming interface. The NetBIOS programming
      ///     interface is not supported on Windows Vista, Windows Server 2008,
      ///     and later.
      ///   </para>
      /// </summary>
      sdNetBios,

      /// <summary>
      ///   <para>
      ///     From MSDN:
      ///   </para>
      ///   <para>
      ///     <br />The IPX/SPX address family. This address family is only
      ///     supported if the NWLink IPX/SPX NetBIOS Compatible Transport
      ///     protocol is installed. <br /><br />This address family is not
      ///     supported on Windows Vista and later.
      ///   </para>
      /// </summary>
      sdIPX,

      /// <summary>
      ///   Ash
      /// </summary>
      sdASH,

      /// <summary>
      ///   ATM PVCs
      /// </summary>
      sdATMPVC,

      /// <summary>
      ///   ATM SVCs
      /// </summary>
      sdATMSVC,

      /// <summary>
      ///   Amateur Radio AX.25
      /// </summary>
      sdAX25,

      /// <summary>
      ///   Multiprotocol bridge
      /// </summary>
      sdBRIDGE,

      /// <summary>
      ///   Reserved for DECnet project.
      /// </summary>
      sdDECnet,

      /// <summary>
      ///   Acorn Econet
      /// </summary>
      sdAECONET,

      /// <summary>
      ///   PF_KEY key management API
      /// </summary>
      sdKEY,

      /// <summary>
      ///   Linux LLC
      /// </summary>
      sdLLC,

      /// <summary>
      ///   Unix socket
      /// </summary>
      sdLOCAL,

      /// <summary>
      ///   Reserved for 802.2LLC project
      /// </summary>
      sdNETBEUI,
      sdNETLINK,

      /// <summary>
      ///   Amateur radio NetROM
      /// </summary>
      sdNETROM,

      /// <summary>
      ///   Packet family
      /// </summary>
      sdPACKET,

      /// <summary>
      ///   PPPoX sockets
      /// </summary>
      sdPPPOX,

      /// <summary>
      ///   Amateur Radio X.25 PLP
      /// </summary>
      sdROSE,

      /// <summary>
      ///   Alias to emulate 4.4BSD.
      /// </summary>
      sdROUTE,

      /// <summary>
      ///   Security callback pseudo AF
      /// </summary>
      sdSECURITY,

      /// <summary>
      ///   Linux SNA project
      /// </summary>
      sdSNA,

      /// <summary>
      ///   TIPC sockets
      /// </summary>
      sdTIPC,

      /// <summary>
      ///   Unix domain sockets
      /// </summary>
      sdUNIX,

      /// <summary>
      ///   Wanpipe API Sockets
      /// </summary>
      sdWANPIPE,

      /// <summary>
      ///   Reserved for X.25 project
      /// </summary>
      sdX25
    );

  /// <summary>
  ///   The type 'kind' of socket to create.
  /// </summary>
  TSocketKind = (

    /// <summary>
    ///   Datagram (connectionless) socket (UDP)
    /// </summary>
    skDatagram,

    /// <summary>
    ///   Stream (connection) type socket (TCP)
    /// </summary>
    skStream,

    /// <summary>
    ///   Raw socket
    /// </summary>
    skRaw,

    /// <summary>
    ///   Reliably-delivered message
    /// </summary>
    skRDM,

    /// <summary>
    ///   Sequential packet socket
    /// </summary>
    skSeqPacket
  );


  /// <summary>
  ///   Enumeration representing a socket protocol.
  /// </summary>
  TPacketProtocol =
    (

      /// <summary>
      ///   Unspecified, let the system handle it.
      /// </summary>
      ppUnSpec,

      /// <summary>
      ///   <para>
      ///     Internet Control Message Protocol. <br /><br />From MSDN <br /><br />
      ///     The Internet Control Message Protocol (ICMP). This is a possible
      ///     value when the af parameter is AF_UNSPEC, AF_INET, or AF_INET6 and
      ///     the type parameter is SOCK_RAW or unspecified.
      ///   </para>
      ///   <para>
      ///     This protocol value is supported on Windows XP and later.
      ///   </para>
      /// </summary>
      ppICMP,

      /// <summary>
      ///   <para>
      ///     From MSDN
      ///   </para>
      ///   <para>
      ///     <br />The Internet Group Management Protocol (IGMP). This is a
      ///     possible value when the af parameter is AF_UNSPEC, AF_INET, or
      ///     AF_INET6 and the type parameter is SOCK_RAW or unspecified. This
      ///     protocol value is supported on Windows XP and later. <br />
      ///   </para>
      /// </summary>
      ppIGMP,

      /// <summary>
      ///   From MSDN <br /><br />The Bluetooth Radio Frequency Communications
      ///   (Bluetooth RFCOMM) <br />protocol. This is a possible value when the
      ///   af parameter is AF_BTH and the type parameter is SOCK_STREAM. This
      ///   protocol value is supported on Windows XP with SP2 or later.s <br />
      /// </summary>
      ppRFCOMM,

      /// <summary>
      ///   From MSDN <br /><br />The Transmission Control Protocol (TCP). This is
      ///   a possible value when the af parameter is AF_INET or AF_INET6 and the
      ///   type parameter is SOCK_STREAM.
      /// </summary>
      ppTCP,

      /// <summary>
      ///   <para>
      ///     From MSDN:
      ///   </para>
      ///   <para>
      ///     The User Datagram Protocol (UDP). This is a possible value when
      ///     the af parameter is AF_INET or AF_INET6 and the type parameter is
      ///     SOCK_DGRAM..
      ///   </para>
      /// </summary>
      ppUDP,

      /// <summary>
      ///   <para>
      ///     From MSDN <br /><br />The Internet Control Message Protocol
      ///     Version 6 (ICMPv6). <br /><br />
      ///   </para>
      ///   <para>
      ///     This is a possible value when the af parameter is AF_UNSPEC,
      ///     AF_INET, or AF_INET6 and the type parameter is SOCK_RAW or
      ///     unspecified. This protocol value is supported on Windows XP and
      ///     later.
      ///   </para>
      /// </summary>
      ppICMPV6,

      /// <summary>
      ///   <para>
      ///     From MSDN <br /><br />
      ///   </para>
      ///   <para>
      ///     The PGM protocol for reliable multicast. This is a possible value
      ///     when the af parameter is AF_INET and the type parameter is
      ///     SOCK_RDM. <br /><br />On the Windows SDK released for Windows
      ///     Vista and later, this protocol is also called IPPROTO_PGM. This
      ///     protocol value is only supported.
      ///   </para>
      /// </summary>
      ppRM,

      /// <summary>
      ///   Authentication header.
      /// </summary>
      ppAH,

      /// <summary>
      ///   Compression Header Protocol.
      /// </summary>
      ppCOMP,

      /// <summary>
      ///   IPv6 destination options.
      /// </summary>
      ppDSTOPTS,

      /// <summary>
      ///   Exterior Gateway Protocol.
      /// </summary>
      ppEGP,

      /// <summary>
      ///   Encapsulation Header.
      /// </summary>
      ppENCAP,

      /// <summary>
      ///   Encapsulating security payload.
      /// </summary>
      ppESP,

      /// <summary>
      ///   IPv6 fragmentation header.
      /// </summary>
      ppFRAGMENT,

      /// <summary>
      ///   General Routing Encapsulation.
      /// </summary>
      ppGRE,

      /// <summary>
      ///   IPv6 Hop-by-Hop options.
      /// </summary>
      ppHOPOPTS,

      /// <summary>
      ///   XNS IDP protocol.
      /// </summary>
      ppIDP,

      /// <summary>
      ///   IPIP tunnels (older KA9Q tunnels use 94).
      /// </summary>
      ppIPIP,

      /// <summary>
      ///   IPv6 header.
      /// </summary>
      ppIPV6,

      /// <summary>
      ///   Multicast Transport Protocol.
      /// </summary>
      ppMTP,

      /// <summary>
      ///   IPv6 no next header.
      /// </summary>
      ppNONE,

      /// <summary>
      ///   Protocol Independent Multicast.
      /// </summary>
      ppPIM,

      /// <summary>
      ///   PUP protocol.
      /// </summary>
      ppPUP,

      /// <summary>
      ///   Raw IP packets.
      /// </summary>
      ppRAW,

      /// <summary>
      ///   IPv6 routing header.
      /// </summary>
      ppROUTING,

      /// <summary>
      ///   Reservation Protocol.
      /// </summary>
      ppRSVP,

      /// <summary>
      ///   Stream Control Transmission Protocol.
      /// </summary>
      ppSCTP,

      /// <summary>
      ///   SO Transport Protocol Class 4.
      /// </summary>
      ppTP
    );

    /// <summary>
    ///   Represents an IP address.
    /// </summary>
    TNetworkAddress = record

      /// <summary>
      ///   The actual IP Address as a string for translation
      /// </summary>
      IPAddress: string;

      /// <summary>
      ///   The port number being used.
      /// </summary>
      Port: uint32;

      class function Create( const IPAddress: string; const Port: uint32 ): TNetworkAddress; static;
    end;

    /// <summary>
    ///   Used to specify options to the Shutdown() method, which is able to
    ///   shutdown sending data, receiving data, or both. This is usually called
    ///   before Close() when ending a socket.
    /// </summary>
    TShutdownOptions = (

    /// <summary>
    ///   soSending Shutdown sending.
    ///  </summary>
    soSending,

    /// <summary>
    ///   soReceiving Shutdown receiving.
    ///  </summary>
    soReceiving,

    /// <summary>
    ///   soBoth Shutdown both sending and receiving.
    ///  </summary>
    soBoth
  );

  ///  <summary>
  ///    Represents a network socket.
  ///  </summary>
  ISocket = interface
    ['{55D4BA20-6942-4DD5-9068-5D9C91FD8C4E}']

    ///  <summary>
    ///    Initializes a socket for use. (CreateSocket() call)
    ///  </summary>
    function Initialize: TStatus;

    ///  <summary>
    ///    Binds the socket to an address, such that it may accept new
    ///    connections to that address.
    ///  </summary>
    function Bind( const NetworkAddress: TNetworkAddress ): TStatus;

    ///  <summary>
    ///    Sets the socket into listening state awaiting new connections.
    ///    The socket must be bound to an address using the Bind() method
    ///    before calling listen.
    ///  </summary>
    function Listen: TStatus;

    ///  <summary>
    ///    Accepts a new connection, if present, on a listening socket.
    ///    Note: When the socket is in blocking mode, this is a blocking
    ///    call and will wait for a new connection to be made. When the socket
    ///    is in non-blocking mode, accept will return immediately even when
    ///    a new connection has not been made. If Accept() returns while in
    ///    non-blocking mode, and without a new connection, the return status
    ///    will indicate a successful call, however, the NewSocket parameter
    ///    will be nil. You must check for this condition.
    ///  </summary>
    function Accept( out NewSocket: ISocket ): TStatus;

    ///  <summary>
    ///    Forms a connection between this socket, and a remote socket
    ///    identified by the network address.
    ///  </summary>
    function Connect( const NetworkAddress: TNetworkAddress ): TStatus;


    ///  <summary>
    ///    Disables sends or recieves (or both) on a socket.
    ///  </summary>
    function Shutdown(const Options: TShutdownOptions): TStatus;

    ///  <summary>
    ///    Closes the socket (disconnects from remote, or stops listening)
    ///  </summary>
    function Close: TStatus;

    ///  <summary>
    ///    Sends the data provided by the buffer to the other end of the
    ///    socket connection (assuming connected or accepted).
    ///  </summary>
    function Send( const Data: IBuffer ): TStatus;

    ///  <summary>
    ///    Receives data from the other end of the socket connection into
    ///    the buffer. The buffer should be pre-allocated to have sufficient
    ///    space for the data to be recieved. (i.e. set to a max buffer size).
    ///    After the call, the buffer will be resized to match the amount of
    ///    data that was actually recieved.
    ///  </summary>
    function Recv( const Data: IBuffer ): TStatus;

    ///  <summary>
    ///    Sets the socket into either blocking or non-blocking mode depending
    ///    upon the value. (True=Blocking).
    ///  <summary>
    function setBlocking( const value: boolean ): TStatus;

    ///  <summary>
    ///    Returns true if this socket is a blocking socket, else returns
    ///    false.
    ///  </summary>
    function getBlocking: boolean;

    ///  <summary>
    ///    If the socket is bound or connected, returns the network
    ///    address information, otherwise returns a network address with
    ///    a null-string and zero port number.
    ///  </summary>
    function getNetworkAddress: TNetworkAddress;

  end;


implementation

class function TNetworkAddress.Create(const IPAddress: string; const Port: uint32): TNetworkAddress;
begin
  Result.IPAddress := IPAddress;
  Result.Port := Port;
end;

end.

