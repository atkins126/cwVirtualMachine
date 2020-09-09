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
///   Windows specific IHeap implementation.
/// </summary>
unit cwHeap.Heap.Windows;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwHeap
;

type
  THeap = class( TInterfacedObject, IHeap )
  strict private //- IHeap -//
    function Allocate( const Size: nativeuint ): pointer;
    function Deallocate( const P: pointer ): boolean;
  end;

implementation

const
  cLibName = 'kernel32.dll';

const
  /// <summary>
  ///   FROM MSDN: Serialized access will not be used. For more information, see Remarks. <br />
  ///   To ensure that serialized access is disabled for all calls to this
  ///   function, specify HEAP_NO_SERIALIZE in the call to HeapCreate. In this
  ///   case, it is not necessary to additionally specify HEAP_NO_SERIALIZE in
  ///   this function call. <br />Do not specify this value when accessing the
  ///   process heap. The system may create additional threads within the
  ///   application's process, such as a CTRL+C handler, that simultaneously
  ///   access the process heap.
  /// </summary>
//  HEAP_NO_SERIALIZE         = $00000001;

  /// <summary>
  ///   FROM MSDN: The system will raise an exception to indicate a function failure, such
  ///   as an out-of-memory condition, instead of returning NULL. <br />To
  ///   ensure that exceptions are generated for all calls to this function,
  ///   specify HEAP_GENERATE_EXCEPTIONS in the call to HeapCreate. In this
  ///   case, it is not necessary to additionally specify
  ///   HEAP_GENERATE_EXCEPTIONS in this function call.
  /// </summary>
  HEAP_GENERATE_EXCEPTIONS  = $00000004;

  /// <summary>
  ///   FROM MSDN: The allocated memory will be initialized to zero. Otherwise, the memory
  ///   is not initialized to zero.
  /// </summary>
//  HEAP_ZERO_MEMORY          = $00000008;

function GetProcessHeap: THandle; stdcall; external cLibName name 'GetProcessHeap';
function HeapAlloc( const hHeap: THandle; const dwFlags: uint32; const dwBytes: nativeuint ): Pointer; stdcall; external cLibName name 'HeapAlloc';
function HeapFree( const hHeap: THandle; const dwFlags: uint32; const lpMem: Pointer ): Boolean; stdcall; external cLibName name 'HeapFree';

function THeap.Allocate( const Size: NativeUint  ): pointer;
begin
  Result := HeapAlloc( GetProcessHeap, HEAP_GENERATE_EXCEPTIONS, Size );
end;

function THeap.Deallocate( const P: pointer ): boolean;
begin
  Result := HeapFree(GetProcessHeap,0,p);
end;

end.

