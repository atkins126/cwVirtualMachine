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
  ///   This interface enables the behavior of IVirtualMachine implementations
  ///   to be altered by providing different virtual CPU implementations. <br />
  /// </summary>
  /// <remarks>
  ///   You should not need to work with this interface directly, except
  ///   whenimplementing your own virtual CPU. Access via theIVirtualMachine
  ///   interface for most use cases. <br />
  /// </remarks>
  IVirtualCPU = interface
    ['{38F2CC5B-60AC-48CE-8F4F-DDDE20E45C08}']

    /// <summary>
    ///   <para>
    ///     Resets the CPU, restoring initial state. <br />Provide a buffer
    ///     containing the byte-code instructions to be executed by the CPU.
    ///   </para>
    ///   <para>
    ///     You may also, optionally provide a buffer to contain static-data
    ///     which may be used by the byte-code program (if the implementation
    ///     supports it). <br />
    ///   </para>
    /// </summary>
    /// <param name="Bytecode">
    ///   A buffer containing the byte-code to be executed by the CPU.
    /// </param>
    /// <param name="StaticData">
    ///   [Optional] A buffer containing static data to be consumed by the
    ///   byte-code program being executed.
    /// </param>
    procedure Reset( const Bytecode: IBuffer ; const StaticData: IBuffer = nil ); overload;

    /// <summary>
    ///   Sends a 'clock' pulse to the CPU, instructing it to execute a single
    ///   instruction cycle. <br />
    /// </summary>
    /// <returns>
    ///   Returns TRUE while there are remaining byte code instructions to run,
    ///   and FALSE when the byte-code program has ended.
    /// </returns>
    /// <exception cref="stUnexpectedEndOfBytecode">
    ///   Raised when the CPU executes to the end of the byte-code buffer
    ///   without first encountering an instruction to halt execution.
    /// </exception>
    /// <exception cref="stInvalidOpCode">
    ///   Raised when an attempt to decode a byte-code instruction fails.
    /// </exception>
    function Clock: boolean;
  end;

  /// <summary>
  ///   Represents a virtual machine.
  /// </summary>
  /// <example>
  ///   <code lang="Delphi">procedure RunBytecode( const ByteCode: IBuffer );
  /// var
  ///   VM: IVirtualMachine;
  /// begin
  ///   VM := TVirtualMachine.Create( TVirtualCPU.CreateChappie );
  ///   VM.LoadBytecode( ByteCode );
  ///   VM.Execute;
  /// end;</code>
  /// </example>
  IVirtualMachine = interface
    ['{14B6A7A4-5C8C-4EE8-83CE-40D0F5A37B70}']

    /// <summary>
    ///   Loads a new byte-code program into the virtual machine. <br /><br />
    ///   Calling LoadByteCode() will cause any currenttly executing byte-code
    ///   program to be halted, and the new byte-code program loaded in it's
    ///   place. <br /><br />Optionally, you may provide a buffer containing
    ///   static data which may be consumed by the byte-code program if the CPU
    ///   implementation supports static data use. <br />
    /// </summary>
    /// <param name="ByteCode">
    ///   A buffer containing the byte-code to be executed by the virtual
    ///   machine.
    /// </param>
    /// <param name="StaticData">
    ///   [Optional] Buffer containing static data to be consumed by the
    ///   byte-code program.
    /// </param>
    procedure LoadBytecode( const ByteCode: IBuffer; const StaticData: IBuffer );

    /// <summary>
    ///   Executes the next instruction in the byte-code and then returns. This
    ///   method is useful for writing a debugger with the ability to break on
    ///   break-points, or sinlge-step through the running program.
    /// </summary>
    /// <exception cref="stUnexpectedEndOfBytecode">
    ///   Raised when the CPU executes to the end of the byte-code buffer
    ///   without first encountering an instruction to halt execution.
    /// </exception>
    /// <exception cref="stInvalidOpCode">
    ///   Raised when an attempt to decode a byte-code instruction fails.
    /// </exception>
    procedure ExecuteStep;

    /// <summary>
    ///   Executes the loaded byte-code program until completion.
    /// </summary>
    /// <exception cref="stUnexpectedEndOfBytecode">
    ///   Raised when the CPU executes to the end of the byte-code buffer
    ///   without first encountering an instruction to halt execution.
    /// </exception>
    /// <exception cref="stInvalidOpCode">
    ///   Raised when an attempt to decode a byte-code instruction fails.
    /// </exception>
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
