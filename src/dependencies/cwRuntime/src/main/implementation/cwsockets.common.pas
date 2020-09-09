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
unit cwsockets.common;

interface
uses
  cwSockets;

{$region ' Library names'}

{$ifdef MACOS}
const
  cLibCName = '/usr/lib/libSystem.dylib';
  cLibName = cLibCName;
  {$ifdef CPU32BITS}
  cPrefix = '_';
  {$else}
  cPrefix = '';
  {$endif}
{$endif}

{$ifdef LINUX}
const
  cLibCName = 'libc.so';
  cLibName = cLibCName;
  cPrefix = '';
{$endif}

{$ifdef MSWINDOWS}
const
  cLibName = 'ws2_32.dll';
  cPrefix = '';
{$endif}

{$endregion}


{$region ' IP Protocols '}
const //- IP Protocols
  IPPROTO_UNSPEC   = 0;   // Unspecified, let the system handle it.
  IPPROTO_IP       = IPPROTO_UNSPEC;
  IPPROTO_HOPOPTS  = IPPROTO_UNSPEC;
  IPPROTO_ICMP     = 1;   // From MSDN - The Internet Control Message Protocol (ICMP). This is a possible value when the af parameter is AF_UNSPEC, AF_INET, or AF_INET6 and the type parameter is SOCK_RAW or unspecified. This protocol value is supported on Windows XP and later.
  IPPROTO_IGMP     = 2;   // From MSDN - The Internet Group Management Protocol (IGMP). This is a possible value when the af parameter is AF_UNSPEC, AF_INET, or AF_INET6 and the type parameter is SOCK_RAW or unspecified. This protocol value is supported on Windows XP and later.
  BTHPROTO_RFCOMM  = 3;   // From MSDN - The Bluetooth Radio Frequency Communications (Bluetooth RFCOMM) protocol. This is a possible value when the af parameter is AF_BTH and the type parameter is SOCK_STREAM. This protocol value is supported on Windows XP with SP2 or later.
  IPPROTO_IPIP     = 4;
  IPPROTO_TCP      = 6;   // From MSDN - The Transmission Control Protocol (TCP). This is a possible value when the af parameter is AF_INET or AF_INET6 and the type parameter is SOCK_STREAM.
  IPPROTO_EGP      = 8;
  IPPROTO_PUP      = 12;
  IPPROTO_UDP      = 17;  // From MSDN - The User Datagram Protocol (UDP). This is a possible value when the af parameter is AF_INET or AF_INET6 and the type parameter is SOCK_DGRAM.
  IPPROTO_IDP      = 22;
  IPPROTO_TP       = 29;
  IPPROTO_IPV6     = 41;
  IPPROTO_ROUTING  = 43;
  IPPROTO_FRAGMENT = 44;
  IPPROTO_RSVP     = 46;
  IPPROTO_GRE      = 47;
  IPPROTO_ESP      = 50;
  IPPROTO_AH       = 51;
  IPPROTO_ICMPV6   = 58;  // From MSDN - The Internet Control Message Protocol Version 6 (ICMPv6). This is a possible value when the af parameter is AF_UNSPEC, AF_INET, or AF_INET6 and the type parameter is SOCK_RAW or unspecified. This protocol value is supported on Windows XP and later.
  IPPROTO_NONE     = 59;
  IPPROTO_DSTOPTS  = 60;
  IPPROTO_MTP      = 92;
  IPPROTO_ENCAP    = 98;
  IPPROTO_PIM      = 103;
  IPPROTO_COMP     = 108;
  IPPROTO_RM       = 113; // From MSDN - The PGM protocol for reliable multicast. This is a possible value when the af parameter is AF_INET and the type parameter is SOCK_RDM. On the Windows SDK released for Windows Vista and later, this protocol is also called IPPROTO_PGM. This protocol value is only supported
  IPPROTO_SCTP     = 132;
  IPPROTO_RAW      = 255;
  IPPROTO_MAX      = 255;
{$endregion}

{$region ' Socket types '}

const //- Socket types
 {$if defined(cpumips) and defined(linux)}}
   SOCK_DGRAM      = 1;
   SOCK_STREAM     = 2;
   SOCK_RAW        = 3;
   SOCK_RDM        = 4;
   SOCK_SEQPACKET  = 5;
 {$else}
   {$if defined(sunos)}
   SOCK_DGRAM      = 1;
   SOCK_STREAM     = 2;
   SOCK_RAW        = 4;
   SOCK_RDM        = 5;
   SOCK_SEQPACKET  = 6;
   {$else}
   SOCK_STREAM     = 1; // From MSDN - A socket type that provides sequenced, reliable, two-way, connection-based byte streams with an OOB data transmission mechanism. This socket type uses the Transmission Control Protocol (TCP) for the Internet address family (AF_INET or AF_INET6).
   SOCK_DGRAM      = 2; // From MSDN - A socket type that supports datagrams, which are connectionless, unreliable buffers of a fixed (typically small) maximum length. This socket type uses the User Datagram Protocol (UDP) for the Internet address family (AF_INET or AF_INET6).
   SOCK_RAW        = 3; // From MSDN - A socket type that provides a raw socket that allows an application to manipulate the next upper-layer protocol header. To manipulate the IPv4 header, the IP_HDRINCL socket option must be set on the socket. To manipulate the IPv6 header, the IPV6_HDRINCL socket option must be set on the socket.
   SOCK_RDM        = 4; // From MSDN - A socket type that provides a reliable message datagram. An example of this type is the Pragmatic General Multicast (PGM) multicast protocol implementation in Windows, often referred to as reliable multicast programming. This type value is only supported if the Reliable Multicast Protocol is installed.
   SOCK_SEQPACKET  = 5; // From MSDN - A socket type that provides a pseudo-stream packet based on datagrams.
   {$endif}
 {$endif}

{$endregion}

{$region ' Address family / domain '}
const //- Address Family
  AF_UNSPEC     = 0;  // From MSDN - The address family is unspecified.
  AF_UNIX       = 1;
  AF_LOCAL      = 1;
  AF_INET       = 2;  // From MSDN - The Internet Protocol version 4 (IPv4) address family.
  AF_AX25       = 3;
  AF_NETROM     = 6;
  AF_BRIDGE     = 7;
  AF_ATMPVC     = 8;
  AF_X25        = 9;
  AF_ROSE       = 11;
  AF_DECnet     = 12;
  AF_NETBEUI    = 13;
  AF_SECURITY   = 14;
  AF_KEY        = 15;
  AF_NETLINK    = 16;
  AF_ROUTE      = 16;
  AF_NETBIOS    = 17;         // From MSDN - The NetBIOS address family. This address family is only supported if the Windows Sockets provider for NetBIOS is installed. The Windows Sockets provider for NetBIOS is supported on 32-bit versions of Windows. This provider is installed by default on 32-bit versions of Windows. The Windows Sockets provider for NetBIOS is not supported on 64-bit versions of windows including Windows 7, Windows Server 2008, Windows Vista, Windows Server 2003, or Windows XP. The Windows Sockets provider for NetBIOS only supports sockets where the type parameter is set to SOCK_DGRAM. The Windows Sockets provider for NetBIOS is not directly related to the NetBIOS programming interface. The NetBIOS programming interface is not supported on Windows Vista, Windows Server 2008, and later.
  AF_PACKET     = 17;
  AF_ASH        = 18;
  AF_ECONET     = 19;
  AF_ATMSVC     = 20;
  AF_SNA        = 22;
  AF_PPPOX	= 24;
  AF_WANPIPE    = 25;
  AF_LLC        = 26;
  AF_TIPC       = 30;
  AF_BLUETOOTH  = 31;
  AF_BTH        = 32;         // From MSDN - The Bluetooth address family. This address family is supported on Windows XP with SP2 or later if the computer has a Bluetooth adapter and driver installed.
  {$ifndef MSWINDOWS}
  AF_IPX        = 4;
  AF_APPLETALK  = 5;
  AF_INET6      = 10;
  AF_IRDA       = 23;
  {$else}
  AF_IPX        = 6;          // From MSDN - The IPX/SPX address family. This address family is only supported if the NWLink IPX/SPX NetBIOS Compatible Transport protocol is installed. This address family is not supported on Windows Vista and later.
  AF_APPLETALK  = 16;         // From MSDN - The AppleTalk address family. This address family is only supported if the AppleTalk protocol is installed. This address family is not supported on Windows Vista and later.
  AF_INET6      = 23;         // From MSDN - The Internet Protocol version 6 (IPv6) address family.
  AF_IRDA       = 26;         // From MSDN - The Infrared Data Association (IrDA) address family. This address family is only supported if the computer has an infrared port and driver installed.
  {$endif}
{$endregion}

{$region ' Common constants'}

const
  INVALID_SOCKET  = -1;
  SOCKET_ERROR    = -1;
  SOMAXCONN       = $7fffffff;

  {$ifdef MSWINDOWS}
  FIONBIO         = int32($8004667E);
  FIONREAD        = int32($4004667F);
  {$else}
  FIONBIO         = $5421;
  FIONREAD        = $541B;
  {$endif}

const
  SD_RECEIVE = 0;
  SD_SEND    = 1;
  SD_BOTH    = 2;

{$endregion}

{$region ' Winsock Constants'}

const
  WSA_INVALID_HANDLE         = 6;
  WSA_NOT_ENOUGH_MEMORY      = 8;
  WSA_INVALID_PARAMETER      = 87;
  WSA_OPERATION_ABORTED      = 995;
  WSA_IO_INCOMPLETE          = 996;
  WSA_IO_PENDING             = 997;
  WSAEINTR                   = 10004;
  WSAEBADF                   = 10009;
  WSAEACCES                  = 10013;
  WSAEFAULT                  = 10014;
  WSAEINVAL                  = 10022;
  WSAEMFILE                  = 10024;
  WSAEWOULDBLOCK             = 10035;
  WSAEINPROGRESS             = 10036;
  WSAEALREADY                = 10037;
  WSAENOTSOCK                = 10038;
  WSAEDESTADDRREQ            = 10039;
  WSAEMSGSIZE                = 10040;
  WSAEPROTOTYPE              = 10041;
  WSAENOPROTOOPT             = 10042;
  WSAEPROTONOSUPPORT         = 10043;
  WSAESOCKTNOSUPPORT         = 10044;
  WSAEOPNOTSUPP              = 10045;
  WSAEPFNOSUPPORT            = 10046;
  WSAEAFNOSUPPORT            = 10047;
  WSAEADDRINUSE              = 10048;
  WSAEADDRNOTAVAIL           = 10049;
  WSAENETDOWN                = 10050;
  WSAENETUNREACH             = 10051;
  WSAENETRESET               = 10052;
  WSAECONNABORTED            = 10053;
  WSAECONNRESET              = 10054;
  WSAENOBUFS                 = 10055;
  WSAEISCONN                 = 10056;
  WSAENOTCONN                = 10057;
  WSAESHUTDOWN               = 10058;
  WSAETOOMANYREFS            = 10059;
  WSAETIMEDOUT               = 10060;
  WSAECONNREFUSED            = 10061;
  WSAELOOP                   = 10062;
  WSAENAMETOOLONG            = 10063;
  WSAEHOSTDOWN               = 10064;
  WSAEHOSTUNREACH            = 10065;
  WSAENOTEMPTY               = 10066;
  WSAEPROCLIM                = 10067;
  WSAEUSERS                  = 10068;
  WSAEDQUOT                  = 10069;
  WSAESTALE                  = 10070;
  WSAEREMOTE                 = 10071;
  WSASYSNOTREADY             = 10091;
  WSAVERNOTSUPPORTED         = 10092;
  WSANOTINITIALISED          = 10093;
  WSAEDISCON                 = 10101;
  WSAENOMORE                 = 10102;
  WSAECANCELLED              = 10103;
  WSAEINVALIDPROCTABLE       = 10104;
  WSAEINVALIDPROVIDER        = 10105;
  WSAEPROVIDERFAILEDINIT     = 10106;
  WSASYSCALLFAILURE          = 10107;
  WSASERVICE_NOT_FOUND       = 10108;
  WSATYPE_NOT_FOUND          = 10109;
  WSA_E_NO_MORE              = 10110;
  WSA_E_CANCELLED            = 10111;
  WSAEREFUSED                = 10112;
  WSAHOST_NOT_FOUND          = 11001;
  WSATRY_AGAIN               = 11002;
  WSANO_RECOVERY             = 11003;
  WSANO_DATA                 = 11004;
  WSA_QOS_RECEIVERS          = 11005;
  WSA_QOS_SENDERS            = 11006;
  WSA_QOS_NO_SENDERS         = 11007;
  WSA_QOS_NO_RECEIVERS       = 11008;
  WSA_QOS_REQUEST_CONFIRMED  = 11009;
  WSA_QOS_ADMISSION_FAILURE  = 11010;
  WSA_QOS_POLICY_FAILURE     = 11011;
  WSA_QOS_BAD_STYLE          = 11012;
  WSA_QOS_BAD_OBJECT         = 11013;
  WSA_QOS_TRAFFIC_CTRL_ERROR = 11014;
  WSA_QOS_GENERIC_ERROR      = 11015;
  WSA_QOS_ESERVICETYPE       = 11016;
  WSA_QOS_EFLOWSPEC          = 11017;
  WSA_QOS_EPROVSPECBUF       = 11018;
  WSA_QOS_EFILTERSTYLE       = 11019;
  WSA_QOS_EFILTERTYPE        = 11020;
  WSA_QOS_EFILTERCOUNT       = 11021;
  WSA_QOS_EOBJLENGTH         = 11022;
  WSA_QOS_EFLOWCOUNT         = 11023;
  WSA_QOS_EUNKOWNPSOBJ       = 11024;
  WSA_QOS_EPOLICYOBJ         = 11025;
  WSA_QOS_EFLOWDESC          = 11026;
  WSA_QOS_EPSFLOWSPEC        = 11027;
  WSA_QOS_EPSFILTERSPEC      = 11028;
  WSA_QOS_ESDMODEOBJ         = 11029;
  WSA_QOS_ESHAPERATEOBJ      = 11030;
  WSA_QOS_RESERVED_PETYPE    = 11031;

{$endregion}

{$region ' Posix constants '}
const
  EPERM           = 1;
  ENOENT          = 2;
  ESRCH           = 3;
  EINTR           = 4;
  EIO             = 5;
  ENXIO           = 6;
  E2BIG           = 7;
  ENOEXEC         = 8;
  EBADF           = 9;
  ECHILD          = 10;
  EAGAIN          = 11;
  ENOMEM          = 12;
  EACCESS         = 13;
  EFAULT          = 14;
  ENOTBLK         = 15;
  EBUSY           = 16;
  EEXIST          = 17;
  EXDEV           = 18;
  ENODEV          = 19;
  ENOTDIR         = 20;
  EISDIR          = 21;
  EINVAL          = 22;
  ENFILE          = 23;
  EMFILE          = 24;
  ENOTTY          = 25;
  ETXTBSY         = 26;
  EFBIG           = 27;
  ENOSPC          = 28;
  ESPIPE          = 29;
  EROFS           = 30;
  EMLINK          = 31;
  EPIPE           = 32;
  EDOM            = 33;
  ERANGE          = 34;
  EDEADLK         = 35;
  ENAMETOOLONG    = 36;
  ENOLCK          = 37;
  ENOSYS          = 38;
  ENOTEMPTY       = 39;
  ELOOP           = 40;
  EWOULDBLOCK     = EAGAIN;
  ENOMSG          = 42;
  EIDRM           = 43;
  ECHRNG          = 44;
  EL2NSYNC        = 45;
  EL3HLT          = 46;
  EL3RST          = 47;
  ELNRNG          = 48;
  EUNATCH         = 49;
  ENOCSI          = 50;
  EL2HLT          = 51;
  EBADE           = 52;
  EBADR           = 53;
  EXFULL          = 54;
  ENOANO          = 55;
  EBADRQC         = 56;
  EBADSLT         = 57;
  EDEADLOCK       = EDEADLK;
  EBFONT          = 59;
  ENOSTR          = 60;
  ENODATA         = 61;
  ETIME           = 62;
  ENOSR           = 63;
  ENONET          = 64;
  ENOPKG          = 65;
  EREMOTE         = 66;
  ENOLINK         = 67;
  EADV            = 68;
  ESRMNT          = 69;
  ECOMM           = 70;
  EPROTO          = 71;
  EMULTIHOP       = 72;
  EDOTDOT         = 73;
  EBADMSG         = 74;
  EOVERFLOW       = 75;
  ENOTUNIQ        = 76;
  EBADFD          = 77;
  EREMCHG         = 78;
  ELIBACC         = 79;
  ELIBBAD         = 80;
  ELIBSCN         = 81;
  ELIBMAX         = 82;
  ELIBEXEC        = 83;
  EILSEQ          = 84;
  ERESTART        = 85;
  ESTRPIPE        = 86;
  EUSERS          = 87;
  ENOTSOCK        = 88;
  EDESTADDRREQ    = 89;
  EMSGSIZE        = 90;
  EPROTOTYPE      = 91;
  ENOPROTOOPT     = 92;
  EPROTONOSUPPORT = 93;
  ESOCKTNOSUPPORT = 94;
  EOPNOTSUPP      = 95;
  EPFNOSUPPORT    = 96;
  EAFNOSUPPORT    = 97;
  EADDRINUSE      = 98;
  EADDRNOTAVAIL   = 99;
  ENETDOWN        = 100;
  ENETUNREACH     = 101;
  ENETRESET       = 102;
  ECONNABORTED    = 103;
  ECONNRESET      = 104;
  ENOBUFS         = 105;
  EISCONN         = 106;
  ENOTCONN        = 107;
  ESHUTDOWN       = 108;
  ETOOMANYREFS    = 109;
  ETIMEDOUT       = 110;
  ECONNREFUSED    = 111;
  EHOSTDOWN       = 112;
  EHOSTUNREACH    = 113;
  EALREADY        = 114;
  EINPROGRESS     = 115;
  ESTALE          = 116;
  EUCLEAN         = 117;
  ENOTNAM         = 118;
  ENAVAIL         = 119;
  EISNAM          = 120;
  EREMOTEIO       = 121;
  EDQUOT          = 122;
  ENOMEDIUM       = 123;
  EMEDIUMTYPE     = 124;
{$endregion}

{$region ' Supporting Types '}

type
  {$ifdef MSWINDOWS}
  TSockLen = int32;
  TIntAddr = uint32;
  {$else}
  TSockLen = uint32;
  TIntAddr = int32;
  {$endif}

{$endregion}

{$region ' Address structure for accepting new socket.'}
type
  TSockAddr = record
    sa_family: uint16;
    sa_data: array [0..13] of uint8;
    padding: array[0..15] of uint8;
  end;
  pTSockAddr = ^TSockAddr;
{$endregion}

{$region ' IPv4 Address structure '}
type
  TInAddr = record
    b1: uint8;
    b2: uint8;
    b3: uint8;
    b4: uint8;
  end;

  TSockAddrIn = record
    sin_family: int16;
      sin_port: uint16;
      sin_addr: TInAddr;
      sin_zero: array [0..7] of uint8; // ansichars
  end;

{$endregion}

{$region ' IPv6 Address structure '}
  TInAddr6 = record
    case integer of
      1: ( addr8: array [0..15] of uint8);
      2: (addr16: array [0..7]  of uint16);
      3: (addr32: array [0..3]  of int32);
  end;

  TSockAddrIn6 = record
      sin_family: int16;
        sin_port: uint16;
    sin_flowinfo: uint16;
        sin_addr: TInAddr6;
    sin_scope_id: uint32;
  end;
{$endregion}

{$region ' Socket functions'}
function sktSocket( const Domain: int32; const kind: int32; const protocol: int32 ): TSocketHandle;                 {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'socket';
function sktBind( const Socket: TSocketHandle; const Addr: pointer; const Addrlen: TSockLen ): int32;               {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'bind';
function sktInetAddr( const lpszAddress: pointer ): TIntAddr;                                                       {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'inet_addr';
function sktHtoNS( const Host: uint16 ): uint16;                                                                    {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'htons';
function sktListen( const Socket: TSocketHandle; const BackLog: int32 ): int32;                                     {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'listen';
function sktAccept( const Socket: TSocketHandle; const lpAddr: pTSockAddr; var AddrLen: int32): TSocketHandle;      {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'accept';
function sktConnect( const Socket: TSocketHandle; const lpAddr: pTSockAddr; const AddrLen: int32): int32;           {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'connect';
function sktCloseSocket( const Socket: TSocketHandle ): int32;                                                      {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name {$ifdef MSWINDOWS} cPrefix + 'closesocket' {$else} 'close' {$endif};
function sktSend( const Socket: TSocketHandle; const lpData: pointer; const len: int32; const flags: int32): int32; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'send';
function sktRecv( const Socket: TSocketHandle; const lpData: pointer; const len: int32; const flags: int32): int32; {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'recv';
function sktShutdown( const Socket: TSocketHandle; const Method: uint32 ): int32;                                   {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external cLibName name cPrefix + 'shutdown';
function ioctl( Socket: TSocketHandle; const cmd: int32; var argp: uint32 ): int32;                                 {$ifdef MSWINDOWS} stdcall; {$else} cdecl; {$endif} external {$ifdef MSWINDOWS} cLibName name cPrefix + 'ioctlsocket' {$else} cLibCName name cPrefix + 'ioctl' {$endif};
{$endregion}

{$region ' Windows specific startup / cleanup '}
{$ifdef MSWINDOWS}
const
  cDescriptionLen = 256;
  cSysStatusLen  = 128;

type
  TWSAData = record
    wVersion: uint16;
    wHighVersoin: uint16;
    szDescription: array[0..cDescriptionLen] of uint8;
    szSystemStatus: array[0..cSysStatusLen] of uint8;
    iMaxSockets: uint16;
    iMaxUdpDg: uint16;
    lpVendorInfo: pansichar;
  end;
  pTWSAData = ^TWSAData;

function cwGetLastError: int32; stdcall; external cLibName name 'WSAGetLastError';
function cwStartup( wVersionRequested: uint16; lpWSAData: pTWSAData ): int32; stdcall; external cLibName name 'WSAStartup';
function cwCleanup(): int32; stdcall; external cLibName name 'WSACleanup';
{$endif}
{$endregion}

///  <summary>
///    Returns the most recent error raised within the platform API for the
///    given thread.
///  </summary>
function GetLastError: int32;

implementation

{$ifndef MSWINDOWS}
type
  ErrNo = ^int32;
  {$ifdef LINUX}
  function ext_errno: pointer; cdecl; external cLibCName name cPrefix + '__errno_location';
  {$endif}
  {$ifdef MACOS}
  function ext_errno: pointer; cdecl; external cLibCName name cPrefix + '__error';
  {$endif}
  {$ifdef ANDROID}
  function ext_errno: pointer; cdecl; external cLibCName name cPrefix + '__errno';
  {$endif}
{$endif}

function GetLastError: int32;
begin
  {$ifdef MSWINDOWS}
  Result := cwGetLastError();
  {$else}
  Result := ErrNo(ext_errno)^;
  {$endif}
end;


end.

