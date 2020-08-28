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
unit cwWin32.AdvAPI32;

interface
{$ifdef MSWINDOWS}
uses
  cwWin32.Types
;

const
  cLibName = 'advapi32.dll';

function AbortSystemShutdown(lpMachineName: LPSTR): Boolean; stdcall; external cLibName name 'AbortSystemShutdownA';
function AbortSystemShutdownW(lpMachineName: LPWSTR): Boolean; stdcall; external cLibName name 'AbortSystemShutdownW';
function AccessCheck(pSecurityDescriptor: PSecurityDescriptor; ClientToken: THandle; DesiredAccess: uint32; const GenericMapping: TGenericMapping; var PrivilegeSet: TPrivilegeSet; var PrivilegeSetLength: uint32; var GrantedAccess: uint32; var AccessStatus: Boolean): Boolean; stdcall; external cLibName name 'AccessCheck';
function AccessCheckAndAuditAlarm(SubsystemName: LPSTR; HandleId: Pointer; ObjectTypeName, ObjectName: PAnsiChar; SecurityDescriptor: PSecurityDescriptor; DesiredAccess: uint32; const GenericMapping: TGenericMapping;  ObjectCreation: Boolean; var GrantedAccess: uint32; var AccessStatus, pfGenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'AccessCheckAndAuditAlarmA';
function AccessCheckAndAuditAlarmW(SubsystemName: LPWSTR; HandleId: Pointer; ObjectTypeName, ObjectName: PWideChar; SecurityDescriptor: PSecurityDescriptor; DesiredAccess: uint32; const GenericMapping: TGenericMapping;  ObjectCreation: Boolean; var GrantedAccess: uint32; var AccessStatus, pfGenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'AccessCheckAndAuditAlarmW';
function AccessCheckByType(pSecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID; ClientToken: THandle; DesiredAccess: uint32; ObjectTypeList: PObjectTypeList; const GenericMapping: TGenericMapping; ObjectTypeListLength: uint32; var PrivilegeSet: TPrivilegeSet; var PrivilegeSetLength: uint32; var GrantedAccess: uint32; var AccessStatus: Boolean): Boolean; stdcall; external cLibName name 'AccessCheckByType';
function AccessCheckByTypeAndAuditAlarm(SubsystemName: LPSTR; HandleId: Pointer; ObjectTypeName, ObjectName: PAnsiChar; SecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID; DesiredAccess: uint32; AuditType: TAUDIT_EVENT_TYPE; Flags: uint32; ObjectTypeList: PObjectTypeList; ObjectTypeListLength: uint32; const GenericMapping: TGenericMapping;  ObjectCreation: Boolean; var GrantedAccess: uint32; var AccessStatus, pfGenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'AccessCheckByTypeAndAuditAlarmA';
function AccessCheckByTypeAndAuditAlarmW(SubsystemName: LPWSTR; HandleId: Pointer; ObjectTypeName, ObjectName: PWideChar; SecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID; DesiredAccess: uint32; AuditType: TAUDIT_EVENT_TYPE; Flags: uint32; ObjectTypeList: PObjectTypeList; ObjectTypeListLength: uint32; const GenericMapping: TGenericMapping;  ObjectCreation: Boolean; var GrantedAccess: uint32; var AccessStatus, pfGenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'AccessCheckByTypeAndAuditAlarmW';
function AccessCheckByTypeResultList(pSecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID; ClientToken: THandle; DesiredAccess: uint32; ObjectTypeList: PObjectTypeList; const GenericMapping: TGenericMapping; ObjectTypeListLength: uint32; var PrivilegeSet: TPrivilegeSet; var PrivilegeSetLength: uint32; var GrantedAccess: uint32; var AccessStatusList: uint32): Boolean; stdcall; external cLibName name 'AccessCheckByTypeResultList';
function AccessCheckByTypeResultListAndAuditAlarm(SubsystemName: PAnsiChar; HandleId: Pointer; ObjectTypeName, ObjectName: PAnsiChar; SecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID; DesiredAccess: uint32; AuditType: TAUDIT_EVENT_TYPE; Flags: uint32; ObjectTypeList: PObjectTypeList; ObjectTypeListLength: uint32; const GenericMapping: TGenericMapping;  ObjectCreation: Boolean; var GrantedAccess: uint32; var AccessStatusList: uint32; var pfGenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'AccessCheckByTypeResultListAndAuditAlarmA';
function AccessCheckByTypeResultListAndAuditAlarmW(SubsystemName: PWideChar; HandleId: Pointer; ObjectTypeName, ObjectName: PWideChar; SecurityDescriptor: PSecurityDescriptor; PrincipalSelfSid: PSID; DesiredAccess: uint32; AuditType: TAUDIT_EVENT_TYPE; Flags: uint32; ObjectTypeList: PObjectTypeList; ObjectTypeListLength: uint32; const GenericMapping: TGenericMapping;  ObjectCreation: Boolean; var GrantedAccess: uint32; var AccessStatusList: uint32; var pfGenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'AccessCheckByTypeResultListAndAuditAlarmW';
function AddAccessAllowedAce(var pAcl: TACL; dwAceRevision: uint32; AccessMask: uint32; pSid: PSID): Boolean; stdcall; external cLibName name 'AddAccessAllowedAce';
function AddAccessAllowedAceEx(var pAcl: TACL; dwAceRevision: uint32; AceFlags: uint32; AccessMask: uint32; pSid: PSID): Boolean; stdcall; external cLibName name 'AddAccessAllowedAceEx';
function AddAccessAllowedObjectAce(var pAcl: TACL; dwAceRevision: uint32; AceFlags: uint32; AccessMask: uint32; ObjectTypeGuid, InheritedObjectTypeGuid: PGuid; pSid: Pointer): Boolean; stdcall; external cLibName name 'AddAccessAllowedObjectAce';
function AddAccessDeniedAce(var pAcl: TACL; dwAceRevision: uint32; AccessMask: uint32; pSid: PSID): Boolean; stdcall; external cLibName name 'AddAccessDeniedAce';
function AddAccessDeniedAceEx(var pAcl: TACL; dwAceRevision: uint32; ACEFlags: uint32; AccessMask: uint32; pSid: PSID): Boolean; stdcall; external cLibName name 'AddAccessDeniedAceEx';
function AddAccessDeniedObjectAce(var pAcl: TACL; dwAceRevision: uint32; AceFlags: uint32; AccessMask: uint32; ObjectTypeGuid, InheritedObjectTypeGuid: PGuid; pSid: Pointer): Boolean; stdcall; external cLibName name 'AddAccessDeniedObjectAce';
function AddAce(var pAcl: TACL; dwAceRevision, dwStartingAceIndex: uint32; pAceList: Pointer; nAceListLength: uint32): Boolean; stdcall; external cLibName name 'AddAce';
function AddAuditAccessAce(var pAcl: TACL; dwAceRevision: uint32; dwAccessMask: uint32; pSid: Pointer; bAuditSuccess, bAuditFailure: Boolean): Boolean; stdcall; external cLibName name 'AddAuditAccessAce';
function AddAuditAccessAceEx(var pAcl: TACL; dwAceRevision: uint32; AceFlags: uint32; dwAccessMask: uint32; pSid: Pointer; bAuditSuccess, bAuditFailure: Boolean): Boolean; stdcall; external cLibName name 'AddAuditAccessAceEx';
function AddAuditAccessObjectAce(var pAcl: TACL; dwAceRevision: uint32; AceFlags: uint32; AccessMask: uint32; ObjectTypeGuid, InheritedObjectTypeGuid: PGuid; pSid: Pointer; bAuditSuccess, bAuditFailure: Boolean): Boolean; stdcall; external cLibName name 'AddAuditAccessObjectAce';
function AdjustTokenGroups(TokenHandle: THandle; ResetToDefault: Boolean; const NewState: TTokenGroups; BufferLength: uint32; var PreviousState: TTokenGroups; var ReturnLength: uint32): Boolean; stdcall; external cLibName name 'AdjustTokenGroups';
function AdjustTokenPrivileges(TokenHandle: THandle; DisableAllPrivileges: Boolean; const NewState: TTokenPrivileges; BufferLength: uint32; var PreviousState: TTokenPrivileges; var ReturnLength: uint32): Boolean; stdcall; external cLibName name 'AdjustTokenPrivileges';
function AllocateAndInitializeSid(const pIdentifierAuthority: TSIDIdentifierAuthority; nSubAuthorityCount: Byte; nSubAuthority0, nSubAuthority1: uint32; nSubAuthority2, nSubAuthority3, nSubAuthority4: uint32; nSubAuthority5, nSubAuthority6, nSubAuthority7: uint32; var pSid: Pointer): Boolean; stdcall; external cLibName name 'AllocateAndInitializeSid';
function AllocateLocallyUniqueId(var Luid: TLargeInteger): Boolean; stdcall; external cLibName name 'AllocateLocallyUniqueId';
function AreAllAccessesGranted(GrantedAccess, DesiredAccess: uint32): Boolean; stdcall; external cLibName name 'AreAllAccessesGranted';
function AreAnyAccessesGranted(GrantedAccess, DesiredAccess: uint32): Boolean; stdcall; external cLibName name 'AreAnyAccessesGranted';
function BackupEventLog(hEventLog: THandle; lpBackupFileName: PAnsiChar): Boolean; stdcall; external cLibName name 'BackupEventLogA';
function BackupEventLogW(hEventLog: THandle; lpBackupFileName: PWideChar): Boolean; stdcall; external cLibName name 'BackupEventLogW';
function ChangeServiceConfig(hService: TSC_HANDLE; dwServiceType, dwStartType, dwErrorControl: uint32; lpBinaryPathName, lpLoadOrderGroup: PAnsiChar; lpdwTagId: LPuint32; lpDependencies, lpServiceStartName, lpPassword, lpDisplayName: PAnsiChar): Boolean; stdcall; external cLibName name 'ChangeServiceConfigA';
function ChangeServiceConfigW(hService: TSC_HANDLE; dwServiceType, dwStartType, dwErrorControl: uint32; lpBinaryPathName, lpLoadOrderGroup: PWideChar; lpdwTagId: LPuint32; lpDependencies, lpServiceStartName, lpPassword, lpDisplayName: PWideChar): Boolean; stdcall; external cLibName name 'ChangeServiceConfigW';
function ClearEventLog(hEventLog: THandle; lpBackupFileName: PAnsiChar): Boolean; stdcall; external cLibName name 'ClearEventLogA';
function ClearEventLogW(hEventLog: THandle; lpBackupFileName: PWideChar): Boolean; stdcall; external cLibName name 'ClearEventLogW';
function CloseEventLog(hEventLog: THandle): Boolean; stdcall; external cLibName name 'CloseEventLog';
function CloseServiceHandle(hSCObject: TSC_HANDLE): Boolean; stdcall; external cLibName name 'CloseServiceHandle';
function ControlService(hService: TSC_HANDLE; dwControl: uint32; var lpServiceStatus: TServiceStatus): Boolean; stdcall; external cLibName name 'ControlService';
function ConvertToAutoInheritPrivateObjectSecurity(ParentDescriptor, CurrentSecurityDescriptor: PSecurityDescriptor; var NewDescriptor: PSecurityDescriptor; ObjectType: PGUID; IsDirectoryObject: Boolean; const GenericMapping: TGenericMapping): Boolean; stdcall; external cLibName name 'ConvertToAutoInheritPrivateObjectSecurity';
function CopySid(nDestinationSidLength: uint32; pDestinationSid, pSourceSid: Pointer): Boolean; stdcall; external cLibName name 'CopySid';
function CreatePrivateObjectSecurity(ParentDescriptor, CreatorDescriptor: PSecurityDescriptor; var NewDescriptor: PSecurityDescriptor; IsDirectoryObject: Boolean; Token: THandle; const GenericMapping: TGenericMapping): Boolean; stdcall; external cLibName name 'CreatePrivateObjectSecurity';
function CreatePrivateObjectSecurityEx(ParentDescriptor, CreatorDescriptor: PSecurityDescriptor; var NewDescriptor: PSecurityDescriptor; ObjectType: PGUID; IsContainerObject: Boolean; AutoInheritFlags: uint32; Token: THandle; const GenericMapping: TGenericMapping): Boolean; stdcall; external cLibName name 'CreatePrivateObjectSecurityEx';
function CreateProcessAsUser(hToken: THandle; lpApplicationName: PAnsiChar; lpCommandLine: PAnsiChar; lpProcessAttributes: PSecurityAttributes; lpThreadAttributes: PSecurityAttributes; bInheritHandles: Boolean; dwCreationFlags: uint32; lpEnvironment: Pointer; lpCurrentDirectory: PAnsiChar; const lpStartupInfo: TStartupInfoA; var lpProcessInformation: TProcessInformation): Boolean; stdcall; external cLibName name 'CreateProcessAsUserA';
function CreateProcessAsUserW(hToken: THandle; lpApplicationName: PWideChar; lpCommandLine: PWideChar; lpProcessAttributes: PSecurityAttributes; lpThreadAttributes: PSecurityAttributes; bInheritHandles: Boolean; dwCreationFlags: uint32; lpEnvironment: Pointer; lpCurrentDirectory: PWideChar; const lpStartupInfo: TStartupInfoW; var lpProcessInformation: TProcessInformation): Boolean; stdcall; external cLibName name 'CreateProcessAsUserW';
function CreateService(hSCManager: TSC_HANDLE; lpServiceName, lpDisplayName: PAnsiChar; dwDesiredAccess, dwServiceType, dwStartType, dwErrorControl: uint32; lpBinaryPathName, lpLoadOrderGroup: PAnsiChar; lpdwTagId: LPuint32; lpDependencies, lpServiceStartName, lpPassword: PAnsiChar): TSC_HANDLE; stdcall; external cLibName name 'CreateServiceA';
function CreateServiceW(hSCManager: TSC_HANDLE; lpServiceName, lpDisplayName: PWideChar; dwDesiredAccess, dwServiceType, dwStartType, dwErrorControl: uint32; lpBinaryPathName, lpLoadOrderGroup: PWideChar; lpdwTagId: LPuint32; lpDependencies, lpServiceStartName, lpPassword: PWideChar): TSC_HANDLE; stdcall; external cLibName name 'CreateServiceW';
function DeleteAce(var pAcl: TACL; dwAceIndex: uint32): Boolean; stdcall; external cLibName name 'DeleteAce';
function DeleteService(hService: TSC_HANDLE): Boolean; stdcall; external cLibName name 'DeleteService';
function DeregisterEventSource(hEventLog: THandle): Boolean; stdcall; external cLibName name 'DeregisterEventSource';
function DestroyPrivateObjectSecurity(var ObjectDescriptor: PSecurityDescriptor): Boolean; stdcall; external cLibName name 'DestroyPrivateObjectSecurity';
function DuplicateToken(ExistingTokenHandle: THandle; ImpersonationLevel: TSECURITY_IMPERSONATION_LEVEL; DuplicateTokenHandle: PHandle): Boolean; stdcall; external cLibName name 'DuplicateToken';
function DuplicateTokenEx(hExistingToken: THandle; dwDesiredAccess: uint32; lpTokenAttributes: PSecurityAttributes; ImpersonationLevel: TSECURITY_IMPERSONATION_LEVEL; TokenType: TTokenType; var phNewToken: THandle): Boolean; stdcall; external cLibName name 'DuplicateTokenEx';
function EnumDependentServices(hService: TSC_HANDLE; dwServiceState: uint32; var lpServices: TEnumServiceStatusA; cbBufSize: uint32; var pcbBytesNeeded, lpServicesReturned : uint32): Boolean; stdcall; external cLibName name 'EnumDependentServicesA';
function EnumDependentServicesW(hService: TSC_HANDLE; dwServiceState: uint32; var lpServices: TEnumServiceStatusW; cbBufSize: uint32; var pcbBytesNeeded, lpServicesReturned : uint32): Boolean; stdcall; external cLibName name 'EnumDependentServicesW';
function EnumServicesStatus(hSCManager: TSC_HANDLE; dwServiceType, dwServiceState: uint32; var lpServices: TEnumServiceStatusA; cbBufSize: uint32; var pcbBytesNeeded, lpServicesReturned, lpResumeHandle: uint32): Boolean; stdcall; external cLibName name 'EnumServicesStatusA';
function EnumServicesStatusW(hSCManager: TSC_HANDLE; dwServiceType, dwServiceState: uint32; var lpServices: TEnumServiceStatusW; cbBufSize: uint32; var pcbBytesNeeded, lpServicesReturned, lpResumeHandle: uint32): Boolean; stdcall; external cLibName name 'EnumServicesStatusW';
function EqualPrefixSid(pSid1, pSid2: Pointer): Boolean; stdcall; external cLibName name 'EqualPrefixSid';
function EqualSid(pSid1, pSid2: Pointer): Boolean; stdcall; external cLibName name 'EqualSid';
function FindFirstFreeAce(var pAcl: TACL; var pAce: Pointer): Boolean; stdcall; external cLibName name 'FindFirstFreeAce';
function FreeSid(pSid: Pointer): Pointer; stdcall; external cLibName name 'FreeSid';
function GetAce(const pAcl: TACL; dwAceIndex: uint32; var pAce: Pointer): Boolean; stdcall; external cLibName name 'GetAce';
function GetAclInformation(const pAcl: TACL; pAclInformation: Pointer; nAclInformationLength: uint32; dwAclInformationClass: TAclInformationClass): Boolean; stdcall; external cLibName name 'GetAclInformation';
function GetCurrentHwProfile(var lpHwProfileInfo: THWProfileInfoA): Boolean; stdcall; external cLibName name 'GetCurrentHwProfileA';
function GetCurrentHwProfileW(var lpHwProfileInfo: THWProfileInfoW): Boolean; stdcall; external cLibName name 'GetCurrentHwProfileW';
function GetFileSecurity(lpFileName: PAnsiChar; RequestedInformation: TSECURITY_INFORMATION; pSecurityDescriptor: PSecurityDescriptor; nLength: uint32; var lpnLengthNeeded: uint32): Boolean; stdcall; external cLibName name 'GetFileSecurityA';
function GetFileSecurityW(lpFileName: PWideChar; RequestedInformation: TSECURITY_INFORMATION; pSecurityDescriptor: PSecurityDescriptor; nLength: uint32; var lpnLengthNeeded: uint32): Boolean; stdcall; external cLibName name 'GetFileSecurityW';
function GetKernelObjectSecurity(Handle: THandle; RequestedInformation: TSECURITY_INFORMATION; pSecurityDescriptor: PSecurityDescriptor; nLength: uint32; var lpnLengthNeeded: uint32): Boolean; stdcall; external cLibName name 'GetKernelObjectSecurity';
function GetLengthSid(pSid: Pointer): uint32; stdcall; external cLibName name 'GetLengthSid';
function GetNumberOfEventLogRecords(hEventLog: THandle; var NumberOfRecords: uint32): Boolean; stdcall; external cLibName name 'GetNumberOfEventLogRecords';
function GetOldestEventLogRecord(hEventLog: THandle; var OldestRecord: uint32): Boolean; stdcall; external cLibName name 'GetOldestEventLogRecord';
function GetPrivateObjectSecurity(ObjectDescriptor: PSecurityDescriptor; SecurityInformation: TSECURITY_INFORMATION; ResultantDescriptor: PSecurityDescriptor; DescriptorLength: uint32; var ReturnLength: uint32): Boolean; stdcall; external cLibName name 'GetPrivateObjectSecurity';
function GetSecurityDescriptorControl(pSecurityDescriptor: PSecurityDescriptor; var pControl: SECURITY_DESCRIPTOR_CONTROL; var lpdwRevision: uint32): Boolean; stdcall; external cLibName name 'GetSecurityDescriptorControl';
function GetSecurityDescriptorDacl(pSecurityDescriptor: PSecurityDescriptor; var lpbDaclPresent: Boolean; var pDacl: PACL; var lpbDaclDefaulted: Boolean): Boolean; stdcall; external cLibName name 'GetSecurityDescriptorDacl';
function GetSecurityDescriptorGroup(pSecurityDescriptor: PSecurityDescriptor; var pGroup: PSID; var lpbGroupDefaulted: Boolean): Boolean; stdcall; external cLibName name 'GetSecurityDescriptorGroup';
function GetSecurityDescriptorLength(pSecurityDescriptor: PSecurityDescriptor): uint32; stdcall; external cLibName name 'GetSecurityDescriptorLength';
function GetSecurityDescriptorOwner(pSecurityDescriptor: PSecurityDescriptor; var pOwner: PSID; var lpbOwnerDefaulted: Boolean): Boolean; stdcall; external cLibName name 'GetSecurityDescriptorOwner';
function GetSecurityDescriptorSacl(pSecurityDescriptor: PSecurityDescriptor; var lpbSaclPresent: Boolean; var pSacl: PACL; var lpbSaclDefaulted: Boolean): Boolean; stdcall; external cLibName name 'GetSecurityDescriptorSacl';
function GetServiceDisplayName(hSCManager: TSC_HANDLE; lpServiceName, lpDisplayName: PAnsiChar; var lpcchBuffer: uint32): Boolean; stdcall; external cLibName name 'GetServiceDisplayNameA';
function GetServiceDisplayNameW(hSCManager: TSC_HANDLE; lpServiceName, lpDisplayName: PWideChar; var lpcchBuffer: uint32): Boolean; stdcall; external cLibName name 'GetServiceDisplayNameW';
function GetServiceKeyName(hSCManager: TSC_HANDLE; lpDisplayName, lpServiceName: PAnsiChar; var lpcchBuffer: uint32): Boolean; stdcall; external cLibName name 'GetServiceKeyNameA';
function GetServiceKeyNameW(hSCManager: TSC_HANDLE; lpDisplayName, lpServiceName: PWideChar; var lpcchBuffer: uint32): Boolean; stdcall; external cLibName name 'GetServiceKeyNameW';
function GetSidIdentifierAuthority(pSid: Pointer): PSIDIdentifierAuthority; stdcall; external cLibName name 'GetSidIdentifierAuthority';
function GetSidLengthRequired(nSubAuthorityCount: uint8): uint32; stdcall; external cLibName name 'GetSidLengthRequired';
function GetSidSubAuthority(pSid: Pointer; nSubAuthority: uint32): puint32; stdcall; external cLibName name 'GetSidSubAuthority';
function GetSidSubAuthorityCount(pSid: Pointer): puint8; stdcall; external cLibName name 'GetSidSubAuthorityCount';
function GetTokenInformation(TokenHandle: THandle; TokenInformationClass: TTokenInformationClass; TokenInformation: Pointer; TokenInformationLength: uint32; var ReturnLength: uint32): Boolean; stdcall; external cLibName name 'GetTokenInformation';
function GetUserName(lpBuffer: PAnsiChar; var nSize: uint32): Boolean; stdcall; external cLibName name 'GetUserNameA';
function GetUserNameW(lpBuffer: PWideChar; var nSize: uint32): Boolean; stdcall; external cLibName name 'GetUserNameW';
function ImpersonateLoggedOnUser(hToken: THandle): Boolean; stdcall; external cLibName name 'ImpersonateLoggedOnUser';
function ImpersonateNamedPipeClient(hNamedPipe: THandle): Boolean; stdcall; external cLibName name 'ImpersonateNamedPipeClient';
function ImpersonateSelf(ImpersonationLevel: TSECURITY_IMPERSONATION_LEVEL): Boolean; stdcall; external cLibName name 'ImpersonateSelf';
function InitializeAcl(var pAcl: TACL; nAclLength, dwAclRevision: uint32): Boolean; stdcall; external cLibName name 'InitializeAcl';
function InitializeSecurityDescriptor(pSecurityDescriptor: PSecurityDescriptor; dwRevision: uint32): Boolean; stdcall; external cLibName name 'InitializeSecurityDescriptor';
function InitializeSid(Sid: Pointer; const pIdentifierAuthority: TSIDIdentifierAuthority; nSubAuthorityCount: Byte): Boolean; stdcall; external cLibName name 'InitializeSid';
function InitiateSystemShutdown(lpMachineName, lpMessage: PAnsiChar; dwTimeout: uint32; bForceAppsClosed, bRebootAfterShutdown: Boolean): Boolean; stdcall; external cLibName name 'InitiateSystemShutdownA';
function InitiateSystemShutdownW(lpMachineName, lpMessage: PWideChar; dwTimeout: uint32; bForceAppsClosed, bRebootAfterShutdown: Boolean): Boolean; stdcall; external cLibName name 'InitiateSystemShutdownW';
function IsTextUnicode(lpBuffer: Pointer; cb: Integer; lpi: PINT): Boolean; stdcall; external cLibName name 'IsTextUnicode';
function IsValidAcl(const pAcl: TACL): Boolean; stdcall; external cLibName name 'IsValidAcl';
function IsValidSecurityDescriptor(pSecurityDescriptor: PSecurityDescriptor): Boolean; stdcall; external cLibName name 'IsValidSecurityDescriptor';
function IsValidSid(pSid: Pointer): Boolean; stdcall; external cLibName name 'IsValidSid';
function LockServiceDatabase(hSCManager: TSC_HANDLE): SC_LOCK; stdcall; external cLibName name 'LockServiceDatabase';
function LogonUser(lpszUsername, lpszDomain, lpszPassword: PAnsiChar; dwLogonType, dwLogonProvider: uint32; var phToken: THandle): Boolean; stdcall; external cLibName name 'LogonUserA';
function LogonUserW(lpszUsername, lpszDomain, lpszPassword: PWideChar; dwLogonType, dwLogonProvider: uint32; var phToken: THandle): Boolean; stdcall; external cLibName name 'LogonUserW';
function LookupAccountName(lpSystemName, lpAccountName: PAnsiChar; Sid: PSID; var cbSid: uint32; ReferencedDomainName: PAnsiChar; var cbReferencedDomainName: uint32; var peUse: SID_NAME_USE): Boolean; stdcall; external cLibName name 'LookupAccountNameA';
function LookupAccountNameW(lpSystemName, lpAccountName: PWideChar; Sid: PSID; var cbSid: uint32; ReferencedDomainName: PWideChar; var cbReferencedDomainName: uint32; var peUse: SID_NAME_USE): Boolean; stdcall; external cLibName name 'LookupAccountNameW';
function LookupAccountSid(lpSystemName: PAnsiChar; Sid: PSID; Name: PAnsiChar; var cbName: uint32; ReferencedDomainName: PAnsiChar; var cbReferencedDomainName: uint32; var peUse: SID_NAME_USE): Boolean; stdcall; external cLibName name 'LookupAccountSidA';
function LookupAccountSidW(lpSystemName: PWideChar; Sid: PSID; Name: PWideChar; var cbName: uint32; ReferencedDomainName: PWideChar; var cbReferencedDomainName: uint32; var peUse: SID_NAME_USE): Boolean; stdcall; external cLibName name 'LookupAccountSidW';
function LookupPrivilegeDisplayName(lpSystemName, lpName: PAnsiChar; lpDisplayName: PAnsiChar; var cbDisplayName, lpLanguageId: uint32): Boolean; stdcall; external cLibName name 'LookupPrivilegeDisplayNameA';
function LookupPrivilegeDisplayNameW(lpSystemName, lpName: PAnsiChar; lpDisplayName: PWideChar; var cbDisplayName, lpLanguageId: uint32): Boolean; stdcall; external cLibName name 'LookupPrivilegeDisplayNameW';
function LookupPrivilegeName(lpSystemName: PAnsiChar; var lpLuid: TLargeInteger; lpName: PAnsiChar; var cbName: uint32): Boolean; stdcall; external cLibName name 'LookupPrivilegeNameA';
function LookupPrivilegeNameW(lpSystemName: PWideChar; var lpLuid: TLargeInteger; lpName: PWideChar; var cbName: uint32): Boolean; stdcall; external cLibName name 'LookupPrivilegeNameW';
function LookupPrivilegeValue(lpSystemName, lpName: PAnsiChar; var lpLuid: TLargeInteger): Boolean; stdcall; external cLibName name 'LookupPrivilegeValueA';
function LookupPrivilegeValueW(lpSystemName, lpName: PWideChar; var lpLuid: TLargeInteger): Boolean; stdcall; external cLibName name 'LookupPrivilegeValueW';
function MakeAbsoluteSD(pSelfRelativeSecurityDescriptor: PSecurityDescriptor; pAbsoluteSecurityDescriptor: PSecurityDescriptor; var lpdwAbsoluteSecurityDescriptorSi: uint32; var pDacl: TACL; var lpdwDaclSize: uint32; var pSacl: TACL; var lpdwSaclSize: uint32; pOwner: PSID; var lpdwOwnerSize: uint32; pPrimaryGroup: Pointer; var lpdwPrimaryGroupSize: uint32): Boolean; stdcall; external cLibName name 'MakeAbsoluteSD';
function MakeSelfRelativeSD(pAbsoluteSecurityDescriptor: PSecurityDescriptor; pSelfRelativeSecurityDescriptor: PSecurityDescriptor; var lpdwBufferLength: uint32): Boolean; stdcall; external cLibName name 'MakeSelfRelativeSD';
procedure MapGenericMask(var AccessMask: uint32; const GenericMapping: TGenericMapping); stdcall; external cLibName name 'MapGenericMask';
function NotifyBootConfigStatus(BootAcceptable: Boolean): Boolean; stdcall; external cLibName name 'NotifyBootConfigStatus';
function NotifyChangeEventLog(hEventLog, hEvent: THandle): Boolean; stdcall; external cLibName name 'NotifyChangeEventLog';
function ObjectCloseAuditAlarm(SubsystemName: PAnsiChar; HandleId: Pointer; GenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'ObjectCloseAuditAlarmA';
function ObjectCloseAuditAlarmW(SubsystemName: PWideChar; HandleId: Pointer; GenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'ObjectCloseAuditAlarmW';
function ObjectDeleteAuditAlarm(SubsystemName: PAnsiChar; HandleId: Pointer; GenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'ObjectDeleteAuditAlarmA';
function ObjectDeleteAuditAlarmW(SubsystemName: PWideChar; HandleId: Pointer; GenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'ObjectDeleteAuditAlarmW';
function ObjectOpenAuditAlarm(SubsystemName: PAnsiChar; HandleId: Pointer; ObjectTypeName: PAnsiChar; ObjectName: PAnsiChar; pSecurityDescriptor: PSecurityDescriptor; ClientToken: THandle; DesiredAccess, GrantedAccess: uint32; var Privileges: TPrivilegeSet; ObjectCreation, AccessGranted: Boolean; var GenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'ObjectOpenAuditAlarmA';
function ObjectOpenAuditAlarmW(SubsystemName: PWideChar; HandleId: Pointer; ObjectTypeName: PWideChar; ObjectName: PWideChar; pSecurityDescriptor: PSecurityDescriptor; ClientToken: THandle; DesiredAccess, GrantedAccess: uint32; var Privileges: TPrivilegeSet; ObjectCreation, AccessGranted: Boolean; var GenerateOnClose: Boolean): Boolean; stdcall; external cLibName name 'ObjectOpenAuditAlarmW';
function ObjectPrivilegeAuditAlarm(SubsystemName: PAnsiChar; HandleId: Pointer; ClientToken: THandle; DesiredAccess: uint32; var Privileges: TPrivilegeSet; AccessGranted: Boolean): Boolean; stdcall; external cLibName name 'ObjectPrivilegeAuditAlarmA';
function ObjectPrivilegeAuditAlarmW(SubsystemName: PWideChar; HandleId: Pointer; ClientToken: THandle; DesiredAccess: uint32; var Privileges: TPrivilegeSet; AccessGranted: Boolean): Boolean; stdcall; external cLibName name 'ObjectPrivilegeAuditAlarmW';
function OpenBackupEventLog(lpUNCServerName, lpFileName: PAnsiChar): THandle; stdcall; external cLibName name 'OpenBackupEventLogA';
function OpenBackupEventLogW(lpUNCServerName, lpFileName: PWideChar): THandle; stdcall; external cLibName name 'OpenBackupEventLogW';
function OpenEventLog(lpUNCServerName, lpSourceName: PAnsiChar): THandle; stdcall; external cLibName name 'OpenEventLogA';
function OpenEventLogW(lpUNCServerName, lpSourceName: PWideChar): THandle; stdcall; external cLibName name 'OpenEventLogW';
function OpenProcessToken(ProcessHandle: THandle; DesiredAccess: uint32; var TokenHandle: THandle): Boolean; stdcall; external cLibName name 'OpenProcessToken';
function OpenSCManager(lpMachineName, lpDatabaseName: PAnsiChar; dwDesiredAccess: uint32): TSC_HANDLE; stdcall; external cLibName name 'OpenSCManagerA';
function OpenSCManagerW(lpMachineName, lpDatabaseName: PWideChar; dwDesiredAccess: uint32): TSC_HANDLE; stdcall; external cLibName name 'OpenSCManagerW';
function OpenService(hSCManager: TSC_HANDLE; lpServiceName: PAnsiChar; dwDesiredAccess: uint32): TSC_HANDLE; stdcall; external cLibName name 'OpenServiceA';
function OpenServiceW(hSCManager: TSC_HANDLE; lpServiceName: PWideChar; dwDesiredAccess: uint32): TSC_HANDLE; stdcall; external cLibName name 'OpenServiceW';
function OpenThreadToken(ThreadHandle: THandle; DesiredAccess: uint32; OpenAsSelf: Boolean; var TokenHandle: THandle): Boolean; stdcall; external cLibName name 'OpenThreadToken';
function PrivilegeCheck(ClientToken: THandle; const RequiredPrivileges: TPrivilegeSet; var pfResult: Boolean): Boolean; stdcall; external cLibName name 'PrivilegeCheck';
function PrivilegedServiceAuditAlarm(SubsystemName, ServiceName: PAnsiChar; ClientToken: THandle; var Privileges: TPrivilegeSet; AccessGranted: Boolean): Boolean; stdcall; external cLibName name 'PrivilegedServiceAuditAlarmA';
function PrivilegedServiceAuditAlarmW(SubsystemName, ServiceName: PWideChar; ClientToken: THandle; var Privileges: TPrivilegeSet; AccessGranted: Boolean): Boolean; stdcall; external cLibName name 'PrivilegedServiceAuditAlarmW';
function QueryServiceConfig(hService: TSC_HANDLE; lpServiceConfig: PQueryServiceConfigA; cbBufSize: uint32; var pcbBytesNeeded: uint32): Boolean; stdcall; external cLibName name 'QueryServiceConfigA';
function QueryServiceConfigW(hService: TSC_HANDLE; lpServiceConfig: PQueryServiceConfigW; cbBufSize: uint32; var pcbBytesNeeded: uint32): Boolean; stdcall; external cLibName name 'QueryServiceConfigW';
function QueryServiceLockStatus(hSCManager: TSC_HANDLE; var lpLockStatus: TQueryServiceLockStatusA; cbBufSize: uint32; var pcbBytesNeeded: uint32): Boolean; stdcall; external cLibName name 'QueryServiceLockStatusA';
function QueryServiceLockStatusW(hSCManager: TSC_HANDLE; var lpLockStatus: TQueryServiceLockStatusW; cbBufSize: uint32; var pcbBytesNeeded: uint32): Boolean; stdcall; external cLibName name 'QueryServiceLockStatusW';
function QueryServiceObjectSecurity(hService: TSC_HANDLE; dwSecurityInformation: TSECURITY_INFORMATION; lpSecurityDescriptor: PSECURITY_DESCRIPTOR; cbBufSize: uint32; var pcbBytesNeeded: uint32): Boolean; stdcall; external cLibName name 'QueryServiceObjectSecurity';
function QueryServiceStatus(hService: TSC_HANDLE; var lpServiceStatus: TServiceStatus): Boolean; stdcall; external cLibName name 'QueryServiceStatus';
function ReadEventLog(hEventLog: THandle; dwReadFlags, dwRecordOffset: uint32; lpBuffer: Pointer; nNumberOfBytesToRead: uint32; var pnBytesRead, pnMinNumberOfBytesNeeded: uint32): Boolean; stdcall; external cLibName name 'ReadEventLogA';
function ReadEventLogW(hEventLog: THandle; dwReadFlags, dwRecordOffset: uint32; lpBuffer: Pointer; nNumberOfBytesToRead: uint32; var pnBytesRead, pnMinNumberOfBytesNeeded: uint32): Boolean; stdcall; external cLibName name 'ReadEventLogW';
function RegCloseKey(hKey: HKEY): Longint; stdcall; external cLibName name 'RegCloseKey';
function RegConnectRegistry(lpMachineName: PAnsiChar; hKey: HKEY; var phkResult: HKEY): Longint; stdcall; external cLibName name 'RegConnectRegistryA';
function RegConnectRegistryW(lpMachineName: PWideChar; hKey: HKEY; var phkResult: HKEY): Longint; stdcall; external cLibName name 'RegConnectRegistryW';
function RegCreateKey(hKey: HKEY; lpSubKey: PAnsiChar; var phkResult: HKEY): Longint; stdcall; external cLibName name 'RegCreateKeyA';
function RegCreateKeyEx(hKey: HKEY; lpSubKey: PAnsiChar; Reserved: uint32; lpClass: PAnsiChar; dwOptions: uint32; samDesired: REGSAM; lpSecurityAttributes: PSecurityAttributes; var phkResult: HKEY; lpdwDisposition: Puint32): Longint; stdcall; external cLibName name 'RegCreateKeyExA';
function RegCreateKeyExW(hKey: HKEY; lpSubKey: PWideChar; Reserved: uint32; lpClass: PWideChar; dwOptions: uint32; samDesired: REGSAM; lpSecurityAttributes: PSecurityAttributes; var phkResult: HKEY; lpdwDisposition: Puint32): Longint; stdcall; external cLibName name 'RegCreateKeyExW';
function RegCreateKeyW(hKey: HKEY; lpSubKey: PWideChar; var phkResult: HKEY): Longint; stdcall; external cLibName name 'RegCreateKeyW';
function RegDeleteKey(hKey: HKEY; lpSubKey: PAnsiChar): Longint; stdcall; external cLibName name 'RegDeleteKeyA';
function RegDeleteKeyW(hKey: HKEY; lpSubKey: PWideChar): Longint; stdcall; external cLibName name 'RegDeleteKeyW';
function RegDeleteValue(hKey: HKEY; lpValueName: PAnsiChar): Longint; stdcall; external cLibName name 'RegDeleteValueA';
function RegDeleteValueW(hKey: HKEY; lpValueName: PWideChar): Longint; stdcall; external cLibName name 'RegDeleteValueW';
function RegEnumKey(hKey: HKEY; dwIndex: uint32; lpName: PAnsiChar; cbName: uint32): Longint; stdcall; external cLibName name 'RegEnumKeyA';
function RegEnumKeyEx(hKey: HKEY; dwIndex: uint32; lpName: PAnsiChar; var lpcbName: uint32; lpReserved: Pointer; lpClass: PAnsiChar; lpcbClass: Puint32; lpftLastWriteTime: PFileTime): Longint; stdcall; external cLibName name 'RegEnumKeyExA';
function RegEnumKeyExW(hKey: HKEY; dwIndex: uint32; lpName: PWideChar; var lpcbName: uint32; lpReserved: Pointer; lpClass: PWideChar; lpcbClass: Puint32; lpftLastWriteTime: PFileTime): Longint; stdcall; external cLibName name 'RegEnumKeyExW';
function RegEnumKeyW(hKey: HKEY; dwIndex: uint32; lpName: PWideChar; cbName: uint32): Longint; stdcall; external cLibName name 'RegEnumKeyW';
function RegEnumValue(hKey: HKEY; dwIndex: uint32; lpValueName: LPWStr; var lpcbValueName: uint32; lpReserved: Pointer; lpType: Puint32; lpData: PByte; lpcbData: Puint32): Longint; stdcall; external cLibName name 'RegEnumValueA';
function RegEnumValueW(hKey: HKEY; dwIndex: uint32; lpValueName: LPWStr; var lpcbValueName: uint32; lpReserved: Pointer; lpType: Puint32; lpData: PByte; lpcbData: Puint32): Longint; stdcall; external cLibName name 'RegEnumValueW';
function RegFlushKey(hKey: HKEY): Longint; stdcall; external cLibName name 'RegFlushKey';
function RegGetKeySecurity(hKey: HKEY; SecurityInformation: TSECURITY_INFORMATION; pSecurityDescriptor: PSecurityDescriptor; var lpcbSecurityDescriptor: uint32): Longint; stdcall; external cLibName name 'RegGetKeySecurity';
function RegLoadKey(hKey: HKEY; lpSubKey, lpFile: PAnsiChar): Longint; stdcall; external cLibName name 'RegLoadKeyA';
function RegLoadKeyW(hKey: HKEY; lpSubKey, lpFile: PWideChar): Longint; stdcall; external cLibName name 'RegLoadKeyW';
function RegNotifyChangeKeyValue(hKey: HKEY; bWatchSubtree: Boolean; dwNotifyFilter: uint32; hEvent: THandle; fAsynchronus: Boolean): Longint; stdcall; external cLibName name 'RegNotifyChangeKeyValue';
function RegOpenKey(hKey: HKEY; lpSubKey: PAnsiChar; var phkResult: HKEY): Longint; stdcall; external cLibName name 'RegOpenKeyA';
function RegOpenKeyEx(hKey: HKEY; lpSubKey: PAnsiChar; ulOptions: uint32; samDesired: REGSAM; var phkResult: HKEY): Longint; stdcall; external cLibName name 'RegOpenKeyExA';
function RegOpenKeyExW(hKey: HKEY; lpSubKey: PWideChar; ulOptions: uint32; samDesired: REGSAM; var phkResult: HKEY): Longint; stdcall; external cLibName name 'RegOpenKeyExW';
function RegOpenKeyW(hKey: HKEY; lpSubKey: PWideChar; var phkResult: HKEY): Longint; stdcall; external cLibName name 'RegOpenKeyW';
function RegQueryInfoKey(hKey: HKEY; lpClass: LPWStr; lpcbClass: Puint32; lpReserved: Pointer; lpcSubKeys, lpcbMaxSubKeyLen, lpcbMaxClassLen, lpcValues, lpcbMaxValueNameLen, lpcbMaxValueLen, lpcbSecurityDescriptor: Puint32; lpftLastWriteTime: PFileTime): Longint; stdcall; external cLibName name 'RegQueryInfoKeyA';
function RegQueryInfoKeyW(hKey: HKEY; lpClass: LPWStr; lpcbClass: Puint32; lpReserved: Pointer; lpcSubKeys, lpcbMaxSubKeyLen, lpcbMaxClassLen, lpcValues, lpcbMaxValueNameLen, lpcbMaxValueLen, lpcbSecurityDescriptor: Puint32; lpftLastWriteTime: PFileTime): Longint; stdcall; external cLibName name 'RegQueryInfoKeyW';
function RegQueryMultipleValues(hKey: HKEY; var ValList; NumVals: uint32; lpValueBuf: PAnsiChar; var ldwTotsize: uint32): Longint; stdcall; external cLibName name 'RegQueryMultipleValuesA';
function RegQueryMultipleValuesW(hKey: HKEY; var ValList; NumVals: uint32; lpValueBuf: PWideChar; var ldwTotsize: uint32): Longint; stdcall; external cLibName name 'RegQueryMultipleValuesW';
function RegQueryValue(hKey: HKEY; lpSubKey: PAnsiChar; lpValue: PAnsiChar; var lpcbValue: Longint): Longint; stdcall; external cLibName name 'RegQueryValueA';
function RegQueryValueEx(hKey: HKEY; lpValueName: PAnsiChar; lpReserved: Pointer; lpType: Puint32; lpData: PByte; lpcbData: Puint32): Longint; stdcall; external cLibName name 'RegQueryValueExA';
function RegQueryValueExW(hKey: HKEY; lpValueName: PWideChar; lpReserved: Pointer; lpType: Puint32; lpData: PByte; lpcbData: Puint32): Longint; stdcall; external cLibName name 'RegQueryValueExW';
function RegQueryValueW(hKey: HKEY; lpSubKey: PWideChar; lpValue: PWideChar; var lpcbValue: Longint): Longint; stdcall; external cLibName name 'RegQueryValueW';
function RegReplaceKey(hKey: HKEY; lpSubKey: PAnsiChar; lpNewFile: PAnsiChar; lpOldFile: PAnsiChar): Longint; stdcall; external cLibName name 'RegReplaceKeyA';
function RegReplaceKeyW(hKey: HKEY; lpSubKey: PWideChar; lpNewFile: PWideChar; lpOldFile: PWideChar): Longint; stdcall; external cLibName name 'RegReplaceKeyW';
function RegRestoreKey(hKey: HKEY; lpFile: PAnsiChar; dwFlags: uint32): Longint; stdcall; external cLibName name 'RegRestoreKeyA';
function RegRestoreKeyW(hKey: HKEY; lpFile: PWideChar; dwFlags: uint32): Longint; stdcall; external cLibName name 'RegRestoreKeyW';
function RegSaveKey(hKey: HKEY; lpFile: PAnsiChar; lpSecurityAttributes: PSecurityAttributes): Longint; stdcall; external cLibName name 'RegSaveKeyA';
function RegSaveKeyW(hKey: HKEY; lpFile: PWideChar; lpSecurityAttributes: PSecurityAttributes): Longint; stdcall; external cLibName name 'RegSaveKeyW';
function RegSetKeySecurity(hKey: HKEY; SecurityInformation: TSECURITY_INFORMATION; pSecurityDescriptor: PSECURITY_DESCRIPTOR): Longint; stdcall; external cLibName name 'RegSetKeySecurity';
function RegSetValue(hKey: HKEY; lpSubKey: PAnsiChar; dwType: uint32; lpData: PAnsiChar; cbData: uint32): Longint; stdcall; external cLibName name 'RegSetValueA';
function RegSetValueEx(hKey: HKEY; lpValueName: PAnsiChar; Reserved: uint32; dwType: uint32; lpData: Pointer; cbData: uint32): Longint; stdcall; external cLibName name 'RegSetValueExA';
function RegSetValueExW(hKey: HKEY; lpValueName: PWideChar; Reserved: uint32; dwType: uint32; lpData: Pointer; cbData: uint32): Longint; stdcall; external cLibName name 'RegSetValueExW';
function RegSetValueW(hKey: HKEY; lpSubKey: PWideChar; dwType: uint32; lpData: PWideChar; cbData: uint32): Longint; stdcall; external cLibName name 'RegSetValueW';
function RegUnLoadKey(hKey: HKEY; lpSubKey: PAnsiChar): Longint; stdcall; external cLibName name 'RegUnLoadKeyA';
function RegUnLoadKeyW(hKey: HKEY; lpSubKey: PWideChar): Longint; stdcall; external cLibName name 'RegUnLoadKeyW';
function RegisterEventSource(lpUNCServerName, lpSourceName: PAnsiChar): THandle; stdcall; external cLibName name 'RegisterEventSourceA';
function RegisterEventSourceW(lpUNCServerName, lpSourceName: PWideChar): THandle; stdcall; external cLibName name 'RegisterEventSourceW';
function RegisterServiceCtrlHandler(lpServiceName: PAnsiChar; lpHandlerProc: ThandlerFunction): TServiceStatusHandle; stdcall; external cLibName name 'RegisterServiceCtrlHandlerA';
function RegisterServiceCtrlHandlerW(lpServiceName: PWideChar; lpHandlerProc: ThandlerFunction): TServiceStatusHandle; stdcall; external cLibName name 'RegisterServiceCtrlHandlerW';
function ReportEvent(hEventLog: THandle; wType, wCategory: Word; dwEventID: uint32; lpUserSid: Pointer; wNumStrings: Word; dwDataSize: uint32; lpStrings, lpRawData: Pointer): Boolean; stdcall; external cLibName name 'ReportEventA';
function ReportEventW(hEventLog: THandle; wType, wCategory: Word; dwEventID: uint32; lpUserSid: Pointer; wNumStrings: Word; dwDataSize: uint32; lpStrings, lpRawData: Pointer): Boolean; stdcall; external cLibName name 'ReportEventW';
function RevertToSelf: Boolean; stdcall; external cLibName name 'RevertToSelf';
function SetAclInformation(var pAcl: TACL; pAclInformation: Pointer; nAclInformationLength: uint32; dwAclInformationClass: TAclInformationClass): Boolean; stdcall; external cLibName name 'SetAclInformation';
function SetFileSecurity(lpFileName: PAnsiChar; SecurityInformation: TSECURITY_INFORMATION; pSecurityDescriptor: PSecurityDescriptor): Boolean; stdcall; external cLibName name 'SetFileSecurityA';
function SetFileSecurityW(lpFileName: PWideChar; SecurityInformation: TSECURITY_INFORMATION; pSecurityDescriptor: PSecurityDescriptor): Boolean; stdcall; external cLibName name 'SetFileSecurityW';
function SetKernelObjectSecurity(Handle: THandle; SecurityInformation: TSECURITY_INFORMATION; SecurityDescriptor: PSecurityDescriptor): Boolean; stdcall; external cLibName name 'SetKernelObjectSecurity';
function SetPrivateObjectSecurity(SecurityInformation: TSECURITY_INFORMATION; ModificationDescriptor: PSecurityDescriptor; var ObjectsSecurityDescriptor: PSecurityDescriptor; const GenericMapping: TGenericMapping; Token: THandle): Boolean; stdcall; external cLibName name 'SetPrivateObjectSecurity';
function SetPrivateObjectSecurityEx(SecurityInformation: TSECURITY_INFORMATION; ModificationDescriptor: PSecurityDescriptor; var ObjectsSecurityDescriptor: PSecurityDescriptor; AutoInheritFlags: uint32; const GenericMapping: TGenericMapping; Token: THandle): Boolean; stdcall; external cLibName name 'SetPrivateObjectSecurityEx';
function SetSecurityDescriptorControl(pSecurityDescriptor: PSecurityDescriptor; ControlBitsOfInterest, ControlBitsToSet: SECURITY_DESCRIPTOR_CONTROL): Boolean; stdcall; external cLibName name 'SetSecurityDescriptorControl';
function SetSecurityDescriptorDacl(pSecurityDescriptor: PSecurityDescriptor; bDaclPresent: Boolean; pDacl: PACL; bDaclDefaulted: Boolean): Boolean; stdcall; external cLibName name 'SetSecurityDescriptorDacl';
function SetSecurityDescriptorGroup(pSecurityDescriptor: PSecurityDescriptor; pGroup: PSID; bGroupDefaulted: Boolean): Boolean; stdcall; external cLibName name 'SetSecurityDescriptorGroup';
function SetSecurityDescriptorOwner(pSecurityDescriptor: PSecurityDescriptor; pOwner: PSID; bOwnerDefaulted: Boolean): Boolean; stdcall; external cLibName name 'SetSecurityDescriptorOwner';
function SetSecurityDescriptorSacl(pSecurityDescriptor: PSecurityDescriptor; bSaclPresent: Boolean; pSacl: PACL; bSaclDefaulted: Boolean): Boolean; stdcall; external cLibName name 'SetSecurityDescriptorSacl';
function SetServiceObjectSecurity(hService: TSC_HANDLE; dwSecurityInformation: TSECURITY_INFORMATION; lpSecurityDescriptor: PSECURITY_DESCRIPTOR): Boolean; stdcall; external cLibName name 'SetServiceObjectSecurity';
function SetServiceStatus(hServiceStatus: TServiceStatusHandle; var lpServiceStatus: TServiceStatus): Boolean; stdcall; external cLibName name 'SetServiceStatus';
function SetThreadToken(Thread: PHandle; Token: THandle): Boolean; stdcall; external cLibName name 'SetThreadToken';
function SetTokenInformation(TokenHandle: THandle; TokenInformationClass: TTokenInformationClass; TokenInformation: Pointer; TokenInformationLength: uint32): Boolean; stdcall; external cLibName name 'SetTokenInformation';
function StartService(hService: TSC_HANDLE; dwNumServiceArgs: uint32; var lpServiceArgVectors: PAnsiChar): Boolean; stdcall; external cLibName name 'StartServiceA';
function StartServiceCtrlDispatcher(lpServiceStartTable: PServiceTableEntryA): Boolean; stdcall; external cLibName name 'StartServiceCtrlDispatcherA';
function StartServiceCtrlDispatcherW(lpServiceStartTable: PServiceTableEntryW): Boolean; stdcall; external cLibName name 'StartServiceCtrlDispatcherW';
function StartServiceW(hService: TSC_HANDLE; dwNumServiceArgs: uint32; var lpServiceArgVectors: PWideChar): Boolean; stdcall; external cLibName name 'StartServiceW';
function UnlockServiceDatabase(ScLock: SC_LOCK): Boolean; stdcall; external cLibName name 'UnlockServiceDatabase';
function RegisterServiceCtrlHandlerExA(lpServiceName: LPCSTR; lpHandlerProc: THandlerEx; lpContext: LPVOID): TServiceStatusHandle; stdcall; external cLibName name 'RegisterServiceCtrlHandlerExA';
function RegisterServiceCtrlHandlerExW(lpServiceName: LPCWSTR; lpHandlerProc: THandlerEx; lpContext: LPVOID): TServiceStatusHandle; stdcall; external cLibName name 'RegisterServiceCtrlHandlerExW';


{$endif}
implementation

end.
