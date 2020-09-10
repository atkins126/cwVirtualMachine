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
unit cwVirtualMachine.Chappie;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwVirtualMachine
;

type
  ///  <summary>
  ///    IChappieBytecode expands on the IBytecode interface to
  ///    provide methods for encoding chappie CPU byte-code
  ///    instructions.
  ///  </summary>
  IChappieBytecode = interface( IByteCode )
    ['{FF2DF098-0D2D-4881-A443-097F056896ED}']

    ///  <summary>
    ///    The HALT instruction terminates any running program by setting the CPU
    ///    running state to FALSE. Calls to the CPU clock method will also return
    ///    false.
    ///  </summary>
    procedure opHalt;

    ///  <summary>
    ///    The NOP instruction does literally nothing but use up an instruction
    ///    cycle. It exists for demonstration purposes only.
    ///  </summary>
    procedure OpNop;

    ///  <summary>
    ///    The ALERT instruction uses writeln to output a simple message reading
    ///    'ALERT' to the standard output.
    ///  </summmary>
    procedure OpAlert;

    ///  <summary>
    ///    The LOAD instruction loads an immediate value into
    ///    the accumulator register of the CPU.
    ///  </summary>
    procedure OpLoad( const value: nativeuint );

    ///  <summary>
    ///    The ADD instruction performs the addition of the
    ///    immediate value with the value in the accumulator
    ///    register, and leaves the result in the accumulator
    ///    register.
    ///  </summary>
    procedure OpAdd( const value: nativeuint );

    ///  <summary>
    ///    The SAVE instruction saves the value currently in
    ///    the accumulator to the immediate next location in
    ///    virtual memory. For this reason, it is encoded as
    ///    the op-code and a zero-padding to provide space
    ///    for the value written to memory.
    ///  </summary>
    procedure OpSave;
  end;


  /// <summary>
  ///   A factory record for instancing virtual CPU's
  /// </summary>
  TChappieCPU = record
    ///  <summary>
    ///    Creates an instance of the 'Chappie' CPU, as developed as part of the
    ///    ChapmanWorld "Lets build a virtual machine" video series at
    ///    https://youtube.com/ChapmanWorldOnTube
    ///  </summary>
    class function Create( const Memory: IVirtualMemory ): IVirtualCPU; static;
  end;

  ///  <summary>
  ///    A factory record for instancing byte-code writers for the
  ///    chappie CPU.
  ///  </summary>
  TChappieByteCode = record
    class function Create( const VirtualMemory: IVirtualMemory; const Granularity: nativeuint = 0 ): IChappieBytecode; static;
  end;


implementation
uses
  sysutils
, cwVirtualMachine.VirtualCPU.Chappie
, cwVirtualMachine.Bytecode.Chappie
;

class function TChappieByteCode.Create( const VirtualMemory: IVirtualMemory; const Granularity: nativeuint  ): IChappieBytecode;
begin
  Result := cwVirtualMachine.Bytecode.Chappie.TChappieByteCode.Create( VirtualMemory, Granularity );
end;

class function TChappieCPU.Create( const Memory: IVirtualMemory ): IVirtualCPU;
begin
  Result := cwVirtualMachine.VirtualCPU.Chappie.TChappieCPU.Create( Memory );
end;

initialization


end.
