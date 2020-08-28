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
unit cwThreading.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwThreading
;

type
  ///  <summary>
  ///    Factory record for instancing ICriticalSection
  ///  </summary>
  TCriticalSection = record
    class function Create: ICriticalSection; static;
  end;

  ///  <summary>
  ///    Factory record for instancing ISignaledCriticalSection
  ///  </summary>
  TSignaledCriticalSection = record
    class function Create: ISignaledCriticalSection; static;
  end;

function ThreadSystem: IThreadingSystem;

implementation
uses
  cwThreading.ThreadSystem.Standard
  {$ifdef MSWINDOWS}
, cwThreading.CriticalSection.Windows
, cwThreading.SignaledCriticalSection.Windows
  {$else}
, cwThreading.CriticalSection.Posix
, cwThreading.SignaledCriticalSection.Posix
  {$endif}
;

var
  SingletonThreadSystem: IThreadingSystem = nil;

function ThreadSystem: IThreadingSystem;
begin
  if not assigned(SingletonThreadSystem) then begin
    SingletonThreadSystem := cwThreading.ThreadSystem.Standard.TThreadSystem.Create;
  end;
  Result := SingletonThreadSystem;
end;

class function TSignaledCriticalSection.Create: ISignaledCriticalSection;
begin
  {$ifdef MSWINDOWS}
  Result := cwThreading.SignaledCriticalSection.Windows.TSignaledCriticalSection.Create;
  {$else}
  Result := cwThreading.SignaledCriticalSection.Posix.TSignaledCriticalSection.Create;
  {$endif}
end;

class function TCriticalSection.Create: ICriticalSection;
begin
  {$ifdef MSWINDOWS}
  Result := cwThreading.CriticalSection.Windows.TCriticalSection.Create;
  {$else}
  Result := cwThreading.CriticalSection.Posix.TCriticalSection.Create;
  {$endif}
end;

initialization
  SingletonThreadSystem := nil;

finalization
  SingletonThreadSystem := nil;

end.

