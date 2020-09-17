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
  cwStatus
;

{$region ' Error states'}

const
  stUnknownInstructionName  = '{2235FF5B-B830-4E23-A764-3EB81B8878EE} Instruction not found by name while encoding byte-code.';
  stUnexpectedEndOfBytecode = '{B5BBDE1E-3231-4078-8906-042D75FFF4BC} The cpu reached the end of the byte-code unexpectedly.';
  stInvalidOpCode           = '{6CEA0E42-2235-46E6-984E-CCEF915592F3} Invalid instruction error.';
  stInvalidOperand          = '{67E25CF7-C8E0-4A86-A967-B88CD3AC7E42} Invalid operand encountered while encoding instruction.';
  stVirtualMemoryUnassigned = '{EBD14231-EFEE-431F-987B-6D10A18C8B9E} Cannot read/write to virtual memory as it is unassigned.';

{$endregion}

type
  /// <summary>
  ///   Data-type for returning arrays of bytes which is compatible
  ///   with dynamic array of bytes parameters.
  /// <summary>
  TArrayOfByte = array of byte;

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
    ///     Resets the CPU, restoring initial state. <br />
    ///     Entrypoint should be set to a position within the
    ///     virutal memory buffer at which the cpu should begin
    ///     executing byte-code instructions.
    ///   </para>
    /// </summary>
    procedure Reset( const EntryPoint: nativeuint );

    /// <summary>
    ///   Sends a 'clock' pulse to the CPU, instructing it to execute a single
    ///   instruction cycle. <br />
    /// </summary>
    /// <returns>
    ///   Returns TRUE unless the program counter (execution pointer) exceeds
    ///   the top of the virtual memory, or the CPU provides some HALT/BREAK
    ///   instruction.
    /// </returns>
    /// <exception cref="stInvalidOpCode">
    ///   Raised when an attempt to decode a byte-code instruction fails.
    /// </exception>
    function Clock: boolean;
  end;

  ///  <summary>
  ///    An implementation of IVirtualMemory represents the memory space
  ///    for use with a virtual CPU.
  ///    Each implementation of IVirtualMemory will differ depending on
  ///    the requirements of the virtual CPU implementation. <br/>
  ///  </summary>
  IVirtualMemory = interface
    ['{6066523F-9DAB-419B-8787-0F316F6D8DEE}']

    ///  <summary>
    ///    Returns a byte value from within the memory buffer by index/offset. <br/>
    ///    Getter for Bytes property.
    ///  </summary>
    function getByte( const idx: nativeuint ): uint8;

    ///  <summary>
    ///    Sets a byte value within the memory buffer by index/offset. <br/>
    ///    Setter for Bytes property.
    ///  </summary>
    procedure setByte( const idx: nativeuint; const value: uint8 );

    ///  <summary>
    ///    Returns a vanilla pointer to the memory buffer. <br/>
    ///    Getter for DataPtr property.
    ///  </summary>
    function getDataPtr: pointer;

    ///  <summary>
    ///    Returns the size, in bytes, of the virtual memory buffer. <br/>
    ///    Getter for DataSize property.
    ///  </summary>
    function getDataSize: nativeuint;

    ///  <summary>
    ///    Alter the size of allocated memory. <br/>
    ///    Caution: This method may be destructive - see DataSize property. <br/>
    ///    Setter for DataSize property.
    ///  </summary>
    procedure setDataSize( const Value: nativeuint );

    ///  <summary>
    ///    A pointer to the virtual memory buffer.
    ///  </summary>
    property DataPtr: pointer read getDataPtr;

    ///  <summary>
    ///    Get or Set the size of the virtual memory buffer in bytes. <br/>
    ///    When setting, the standard implementation attempts to retain any
    ///    existing data in the buffer, up-to the new size in bytes. This may
    ///    vary with non-standard implementations. Check the implementation
    ///    documentation / comments to see if altering the size of the buffer
    ///    is destructive.
    ///  </summary>
    property DataSize: nativeuint read getDataSize write setDataSize;

    ///  <summary>
    ///    Read/Write individual bytes within the buffer by index.
    ///  </summary>
    property Bytes[ const idx: nativeuint ]: uint8 read getByte write setByte; default;
  end;

  ///  <summary>
  ///    An implementation of IBytecode represnts a window into an IVirtualMemory
  ///    instance in order to edit byte-code instructions. <br/>
  ///  </summary>
  IBytecode = interface
    ['{0BC9900E-9BE3-4283-BEC1-C7FEF757AEBF}']

    ///  <summary>
    ///    Returns a reference to the virtual memory being edited
    ///    through this byte-code window. <br/>
    ///    Getter for VirtualMemory property.
    ///  </summary>
    function getVirtualMemory: IVirtualMemory;

    ///  <summary>
    ///    Returns the location of the byte-code window as an offset within
    ///    virtual memory. <br/>
    ///    Getter for the Cursor property.
    ///  </summary>
    function getCursor: nativeuint;

    ///  <summary>
    ///    Sets the location of the byte-code window as an offset within
    ///    virtual memory. <br/>
    ///    If an attempt is made to position the cursor outside the
    ///    virutal memory space, the cursor will simply be positioned
    ///    at the last byte of virtual memory. <br/>
    ///    Setter for the Cursor property.
    ///  </summary>
    procedure setCursor( const value: nativeuint );

    ///  <summary>
    ///    Writes a number of bytes to virtual memory buffer at the location
    ///    specified by the cursor property. <br/>
    ///    If the top of the virtual memory buffer is reached while there
    ///    are still bytes remaining to be written, writing will simply
    ///    stop to prevent buffer overrun, and this method will return
    ///    the number of bytes actually written to the buffer.
    ///  </summary>
    function Write( const Bytes: array of uint8 ): nativeuint;

    ///  <summary>
    ///    Appends the bytes provided in the bytes array to the
    ///    byte-code buffer at the location specified by the cursor
    ///    property, and progresses the cursor beyond the written bytes. <br/>
    ///    This method will expand the virutal buffer size if required.
    ///  </summary>
    procedure Append( const Bytes: array of uint8 );

    ///  <summary>
    ///    A reference to the virtual memory assigned to this byte-code window. <br/>
    ///  </summary>
    property VirtualMemory: IVirtualMemory read getVirtualMemory;

    ///  <summary>
    ///    Get/Set the cursor offset within the IVirtualMemory buffer. <br/>
    ///    When setting the cursor beyond the bounds of the virtual memory buffer,
    ///    the property will simply be set to point at the last byte in the buffer.
    ///    Care must be taken to check that the cursor was actually set to the
    ///    intended location if this can not be assured before setting.
    ///  </summary>
    property Cursor: nativeuint read getCursor write setCursor;

  end;


implementation


initialization
  TStatus.Register(stUnexpectedEndOfBytecode);
  TStatus.Register(stInvalidOpCode);
  TStatus.Register(stUnknownInstructionName);
  TStatus.Register(stInvalidOperand);
  TStatus.Register(stVirtualMemoryUnassigned);

end.
