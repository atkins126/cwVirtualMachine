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
unit cwVirtualMachine.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwVirtualMachine
;

type
  TVirtualMemory = record
    class function Create( const InitialSize: nativeuint = 0 ): IVirtualMemory; static;
  end;

  TByteCode = record
    ///  <summary>
    ///    Creates an instance of IByteCode for writing byte code to an
    ///    instance of IVirtualMemory. The instance of IVirtualMemory is
    ///    passed as a parameter to the constructor. <br/>
    ///    An optional parameter, Granularity, determines the number of
    ///    bytes to be allocated at any time that more memory is required
    ///    in the virtual memory buffer. If omitted (or set zero) the
    ///    granularity will be set to a default as determined by the
    ///    bytecode implementation. (typically 512 bytes).
    ///  </summary>
    class function Create( const VirtualMemory: IVirtualMemory; const Granularity: nativeuint = 0 ): IBytecode; static;
  end;

implementation
uses
  cwVirtualMachine.VirtualMemory.Custom
, cwVirtualMachine.ByteCode.Custom
;

class function TBytecode.Create( const VirtualMemory: IVirtualMemory; const Granularity: nativeuint ): IBytecode;
begin
  Result := cwVirtualMachine.ByteCode.Custom.TCustomBytecode.Create( VirtualMemory, Granularity );
end;

class function TVirtualMemory.Create(const InitialSize: nativeuint): IVirtualMemory;
begin
  Result := cwVirtualMachine.VirtualMemory.Custom.TCustomVirtualMemory.Create( InitialSize );
end;

end.
