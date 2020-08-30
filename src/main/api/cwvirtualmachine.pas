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
unit cwVirtualMachine;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwIO
;

{$region ' Error states'}

resourcestring
  stUnexpectedEndOfBytecode = '{B5BBDE1E-3231-4078-8906-042D75FFF4BC} The cpu reached the end of the byte-code unexpectedly.';
  stInvalidOpCode           = '{6CEA0E42-2235-46E6-984E-CCEF915592F3} Invalid instruction error.';

{$endregion}

type
  /// <summary>
  ///   <para>
  ///     This interface enables the behavior of IVirtualMachine
  ///     implementations to be altered by providing different virtual CPU
  ///     implementations.
  ///   </para>
  ///   <para>
  ///     This interface is a reference to be derived by a CPU
  ///     implementation, which must also implement the internal
  ///     IVirtualCPUState interface.
  ///   </para>
  /// </summary>
  IVirtualCPU = interface
    ['{38F2CC5B-60AC-48CE-8F4F-DDDE20E45C08}']

    ///  <summary>
    ///    Resets the CPU, restoring initial state. <br/>
    ///  </summary>
    procedure Reset( const lpBytecode: pointer; const szByteCode: nativeuint );

    ///  <summary>
    ///    Sends a 'clock' pulse to the CPU, instructing it to execute a
    ///    single instruction cycle. <br/>
    ///    Returns TRUE while there are remaining byte code instructions to
    ///    run, and FALSE when the byte-code program has ended.
    ///  </summary>
    function Clock: boolean;
  end;

  /// <summary>
  ///   Represents a virtual machine.
  /// </summary>
  IVirtualMachine = interface
    ['{14B6A7A4-5C8C-4EE8-83CE-40D0F5A37B70}']

    /// <summary>
    ///   Loads a new byte-code program into the virtual machine. This is
    ///   destructive in that any existing byte-code in the virtual machine
    ///   will be disposed.
    /// </summary>
    procedure LoadBytecode( const ByteCode: IBuffer );

    /// <summary>
    ///   Executes the next instruction in the byte-code and then returns. This
    ///   method is useful for writing a debugger with the ability to break on
    ///   break-points, or sinlge-step through the running program.
    /// </summary>
    procedure ExecuteStep;

    /// <summary>
    ///   Executes the loaded byte-code program until completion.
    /// </summary>
    procedure Execute;
  end;

implementation
{$ifndef fpc}
uses
  cwStatus
;
{$endif}

initialization
  {$ifndef fpc}
  TStatus.Register(stUnexpectedEndOfBytecode);
  TStatus.Register(stInvalidOpCode);
  {$endif}

end.
