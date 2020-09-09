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
, cwStatus
;

{$region ' Error states'}

const
  stUnknownInstructionName  = '{2235FF5B-B830-4E23-A764-3EB81B8878EE} Instruction not found by name while encoding byte-code.';
  stUnexpectedEndOfBytecode = '{B5BBDE1E-3231-4078-8906-042D75FFF4BC} The cpu reached the end of the byte-code unexpectedly.';
  stInvalidOpCode           = '{6CEA0E42-2235-46E6-984E-CCEF915592F3} Invalid instruction error.';
  stInvalidOperand          = '{67E25CF7-C8E0-4A86-A967-B88CD3AC7E42} Invalid operand encountered while encoding instruction.';

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
    procedure Reset( const lpBytecode: pointer; const szBytecode: nativeuint; const StaticData: IBuffer = nil );

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

  ///  <summary>
  ///    A simple byte-buffer with utility methods for encoding instructions for
  ///    a virtual CPU.
  ///  </summary>
  IBytecode = interface
    ['{0BC9900E-9BE3-4283-BEC1-C7FEF757AEBF}']

    ///  <summary>
    ///    Returns the number of bytes allocated within the bytecode buffer. <br/>
    ///    Getter for SizeBytes property.
    ///  </summary>
    function getSizeBytes: nativeuint;

    ///  <summary>
    ///    Returns a pointer to the memory allocated for the byte-code buffer. <br/>
    ///    Getter for DataPtr property.
    ///  </summary>
    function getDataPtr: pointer;

    ///  <summary>
    ///    Clears the buffer and releases all allocated memory resources.
    ///  </summary>
    procedure Clear;

    ///  <summary>
    ///    Appends the bytes provided in the bytes array to the
    ///    byte-code buffer.
    ///  </summary>
    procedure Append( const Bytes: array of uint8 );

    ///  <summary>
    ///    A pointer to the byte-code data.
    ///  </summary>
    property DataPtr: pointer read getDataPtr;

    ///  <summary>
    ///    The size (in bytes) of the data in the byte-code buffer.
    ///  </summary>
    property SizeBytes: nativeuint read getSizeBytes;
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

    ///  <summary>
    ///    Returns a reference to the byte-code buffer which will be executed
    ///    by the virtual machine. <br/>
    ///    Getter for Bytecode property.
    ///    <remarks>
    ///      This property may return nil if the virtual machine is already running,
    ///      to prevent aleration of the byte-code at runtiume.
    ///    </remarks>
    ///  </summary>
    function getBytecode: IBytecode;

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

    ///  <summary>
    ///    A reference to the byte-code buffer for this virtual machine instance.
    ///  </summary>
    property ByteCode: IByteCode read getByteCode;
  end;

implementation


initialization
  TStatus.Register(stUnexpectedEndOfBytecode);
  TStatus.Register(stInvalidOpCode);
  TStatus.Register(stUnknownInstructionName);
  TStatus.Register(stInvalidOperand);

end.
