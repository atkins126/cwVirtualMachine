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
unit cwVirtualMachine.VirtualMachine.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwIO
, cwVirtualMachine
, cwVirtualMachine.Internal
;

type
  TVirtualMachine = class( TInterfacedObject, IVirtualMachine )
  private
    fCPU: IVirtualCPU;
    fBytecode: IBuffer;
  strict private //- IVirtualMachine -//
    procedure LoadBytecode( const ByteCode: IBuffer );
    procedure ExecuteStep;
    procedure Execute;
  public
    constructor Create( const CPU: IVirtualCPU ); reintroduce;
    destructor Destroy; override;
  end;

implementation
uses
  cwStatus
;

constructor TVirtualMachine.Create(const CPU: IVirtualCPU);
begin
  inherited Create;
  fCPU := CPU;
end;

destructor TVirtualMachine.Destroy;
begin
  fCPU := nil;
  inherited Destroy;
end;

procedure TVirtualMachine.Execute;
begin
  if not assigned(fCPU) then exit;
  while fCPU.Clock do;
end;

procedure TVirtualMachine.ExecuteStep;
begin
  if not assigned(fCPU) then exit;
  fCPU.Clock;
end;

procedure TVirtualMachine.LoadBytecode(const ByteCode: IBuffer);
begin
  fBytecode := Bytecode;
  fCPU.Reset( fBytecode.DataPtr, fBytecode.Size );
end;

end.
