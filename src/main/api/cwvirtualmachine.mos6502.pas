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
unit cwVirtualMachine.Mos6502;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwVirtualMachine
;

const
  c66KB = 10000;

type

  ///  <summary>
  ///    The 6502 CPU only has a 16-bit address bus, and therefore a
  ///    maximum of 64KB of addressable memory. Early home, and business
  ///    computers, got around this limitation using a device called a
  ///    latch. A latch is hard-wired to the CPU between it and the
  ///    memory devices, so that it can switch 'banks' of physical
  ///    memory in to, and out of the CPU address space. <br/>
  ///    For example, the Commodore64 was so named because it had 64KB
  ///    of RAM, but it also had 20KB of ROM and could be expanded with
  ///    more of each via the expansion port. Similarly the Commodore128
  ///    was almost the same system, but with 128KB of RAM. <br/>
  ///    These Commodore systems used a latch called the PLA
  ///    (programmable logic array) which was hard coded to addresses
  ///    $0000 and $0001. Writing values to these addresses instructed
  ///    the PLA to swap pieces of RAM and ROM into and out of the CPU
  ///    address bus, giving the CPU access to more memory. <br/>
  ///    The I6502VirtualMemory implementation allows for any
  ///    amount of memory, from 64KB (minimum) to that permitted by
  ///    the host system costraints, to be allocated for the virtual
  ///    CPU to access. Providing access to large amounts of memory
  ///    is done by setting up an array of 'banks'. <br/>
  ///    A bank, in this case, is simply an offset
  ///    into the virtual memory buffer, which represents an addressable
  ///    256 bytes. With 256 banks available, this allows all 64KB of the
  ///    CPU address space to be populated by 256-byte chunks of the virtual
  ///    memory buffer. <br/>
  ///    The CPU implements a latch mechanism similar to the PLA from
  ///    Commodore systems, in that, when setting any value at address
  ///    $0001, an event handler is called and is passed a reference to
  ///    an I6502VirtualMemory instance in order to alter the memory
  ///    banking arrangement. <br/>
  ///    Note that the initial state of the banks will map 1:1 onto
  ///    the first 64KB of the virtual memory buffer, which has 64KB
  ///    as its minimum allocation.
  ///    Any attempt to set the size of virtual memory to less than
  ///    64KB will silently fail.
  ///  </summary>
  I6502VirtualMemory = interface( IVirtualMemory )
    ['{A029893B-AB25-4D3C-AD98-A20E3B6677B0}']

    ///  <summary>
    ///    Returns the offset of the memory bank as specified by index. <br/>
    ///    Getter for banks property.
    ///  </summary>
    function getBank( const idx: uint8 ): nativeuint;

    ///  <summary>
    ///    Sets the offset of the memory bank as specified by index. <br/>
    ///    Note: Any attempt to set a memory bank to a value outside the
    ///    range of the virtual memory allocated, will result in a silent
    ///    failure of the bank reassignment.
    ///    Setter for banks property.
    ///  </summary>
    procedure setBank( const idx: uint8; const value: nativeuint );

    ///  <summary>
    ///    Get or Set the offset within the virtual memory buffer of
    ///    a bank of memory for the 6502 CPU. <br/>
    ///    Note: Any attempt to set a memory bank to a value outside the
    ///    range of the virtual memory allocated, will result in a silent
    ///    failure of the bank reassignment.
    ///  </summary>
    property Banks[ const idx: uint8 ]: nativeuint read getBank write setBank;

  end;

  ///  <summary>
  ///    Provides methods for writing instruction code into a virtual memory
  ///    buffer. Note: The bank-switching mechanism of the I6502VirtualMemory
  ///    is ignored by I6502ByteCode. Instructions will be written to a cursor
  ///    directly within the virtual memory buffer. Banks should therefore be
  ///    configured accordingly.
  ///  </summary>
  I6502ByteCode = interface( IBytecode )
    ['{05BBBF78-A55F-458D-BE89-B500A615B33B}']
    procedure ADC_abs_x ( const Address: uint16  );
    procedure ADC_abs_y ( const Address: uint16  );
    procedure ADC_abs   ( const Address: uint16  );
    procedure ADC_imm   ( const value: uint8     );
    procedure ADC_ind_y ( const Offset: uint8    );
    procedure ADC_x_ind ( const Offset: uint8    );
    procedure ADC_zpg_x ( const zpgOffset: uint8 );
    procedure ADC_zpg   ( const zpgOffset: uint8 );
    procedure AND_abs_x ( const Address: uint16  );
    procedure AND_abs_y ( const Address: uint16  );
    procedure AND_abs   ( const Address: uint16  );
    procedure AND_imm   ( const value: uint8     );
    procedure AND_ind_y ( const Offset: uint8    );
    procedure AND_x_ind ( const Offset: uint8    );
    procedure AND_zpg_x ( const zpgOffset: uint8 );
    procedure AND_zpg   ( const zpgOffset: uint8 );
    procedure ASL;
    procedure ASL_abs   ( const Address: uint16  );
    procedure ASL_abs_x ( const Address: uint16  );
    procedure ASL_zpg_x ( const zpgOffset: uint8 );
    procedure ASL_zpg   ( const zpgOffset: uint8 );
    procedure BCC_rel   ( const relative: uint8  );
    procedure BCS_rel   ( const relative: uint8  );
    procedure BEQ_rel   ( const relative: uint8  );
    procedure BIT_abs   ( const Address: uint16  );
    procedure BIT_zpg   ( const zpgOffset: uint8 );
    procedure BMI_rel   ( const relative: uint8  );
    procedure BNE_rel   ( const relative: uint8  );
    procedure BPL_rel   ( const relative: uint8  );
    procedure BRK;
    procedure BVC_rel   ( const relative: uint8  );
    procedure BVS_rel   ( const relative: uint8  );
    procedure CLC;
    procedure CLD;
    procedure CLI;
    procedure CLV;
    procedure CMP_abs_x ( const Address: uint16  );
    procedure CMP_abs_y ( const Address: uint16  );
    procedure CMP_abs   ( const Address: uint16  );
    procedure CMP_imm   ( const value: uint8     );
    procedure CMP_ind_y ( const Offset: uint8    );
    procedure CMP_x_ind ( const Offset: uint8    );
    procedure CMP_zpg_x ( const zpgOffset: uint8 );
    procedure CMP_zpg   ( const zpgOffset: uint8 );
    procedure CPX_abs   ( const Address: uint16  );
    procedure CPX_imm   ( const value: uint8     );
    procedure CPX_zpg   ( const zpgOffset: uint8 );
    procedure CPY_abs   ( const Address: uint16  );
    procedure CPY_imm   ( const value: uint8     );
    procedure CPY_zpg   ( const zpgOffset: uint8 );
    procedure DEC_abs_x ( const Address: uint16  );
    procedure DEC_abs   ( const Address: uint16  );
    procedure DEC_zpg_x ( const zpgOffset: uint8 );
    procedure DEC_zpg   ( const zpgOffset: uint8 );
    procedure DEX;
    procedure DEY;
    procedure EOR_abs_x ( const Address: uint16  );
    procedure EOR_abs_y ( const Address: uint16  );
    procedure EOR_abs   ( const Address: uint16  );
    procedure EOR_imm   ( const value: uint8     );
    procedure EOR_ind_y ( const Offset: uint8    );
    procedure EOR_X_ind ( const Offset: uint8    );
    procedure EOR_zpg_x ( const zpgOffset: uint8 );
    procedure EOR_zpg   ( const zpgOffset: uint8 );
    procedure INC_abs_x ( const Address: uint16  );
    procedure INC_abs   ( const Address: uint16  );
    procedure INC_zpg_x ( const zpgOffset: uint8 );
    procedure INC_zpg   ( const zpgOffset: uint8 );
    procedure INX;
    procedure INY;
    procedure JMP_abs   ( const Address: uint16  );
    procedure JMP_ind   ( const Address: uint16  );
    procedure JSR_abs   ( const Address: uint16  );
    procedure LDA_abs_x ( const Address: uint16  );
    procedure LDA_abs_y ( const Address: uint16  );
    procedure LDA_abs   ( const Address: uint16  );
    procedure LDA_imm   ( const value: uint8     );
    procedure LDA_ind_y ( const Offset: uint8    );
    procedure LDA_x_ind ( const Offset: uint8    );
    procedure LDA_zpg_x ( const zpgOffset: uint8 );
    procedure LDA_zpg   ( const zpgOffset: uint8 );
    procedure LDX_zpg   ( const zpgOffset: uint8 );
    procedure LDX_abs_y ( const Address: uint16  );
    procedure LDX_abs   ( const Address: uint16  );
    procedure LDX_imm   ( const value: uint8     );
    procedure LDX_zpg_y ( const zpgOffset: uint8 );
    procedure LDY_abs_x ( const Address: uint16  );
    procedure LDY_abs   ( const Address: uint16  );
    procedure LDY_imm   ( const value: uint8     );
    procedure LDY_zpg_x ( const zpgOffset: uint8 );
    procedure LDY_zpg   ( const zpgOffset: uint8 );
    procedure LSR;
    procedure LSR_abs_x ( const Address: uint16  );
    procedure LSR_abs   ( const Address: uint16  );
    procedure LSR_zpg_x ( const zpgOffset: uint8 );
    procedure LSR_zpg   ( const zpgOffset: uint8 );
    procedure NOP;
    procedure ORA_abs_x ( const Address: uint16  );
    procedure ORA_abs_y ( const Address: uint16  );
    procedure ORA_abs   ( const Address: uint16  );
    procedure ORA_imm   ( const value: uint8     );
    procedure ORA_ind_y ( const Offset: uint8    );
    procedure ORA_x_ind ( const Offset: uint8    );
    procedure ORA_zpg_x ( const zpgOffset: uint8 );
    procedure ORA_zpg   ( const zpgOffset: uint8 );
    procedure PHA;
    procedure PHP;
    procedure PLA;
    procedure PLP;
    procedure ROL;
    procedure ROL_abs_x ( const Address: uint16  );
    procedure ROL_abs   ( const Address: uint16  );
    procedure ROL_zpg_x ( const zpgOffset: uint8 );
    procedure ROL_zpg   ( const zpgOffset: uint8 );
    procedure ROR;
    procedure ROR_abs_x ( const Address: uint16  );
    procedure ROR_abs   ( const Address: uint16  );
    procedure ROR_zpg_x ( const zpgOffset: uint8 );
    procedure ROR_zpg   ( const zpgOffset: uint8 );
    procedure RTI;
    procedure RTS;
    procedure SBC_abs_y ( const Address: uint16  );
    procedure SBC_abs_x ( const Address: uint16  );
    procedure SBC_abs   ( const Address: uint16  );
    procedure SBC_imm   ( const value: uint8     );
    procedure SBC_ind_y ( const Offset: uint8    );
    procedure SBC_x_ind ( const Offset: uint8    );
    procedure SBC_zpg_x ( const zpgOffset: uint8 );
    procedure SBC_zpg   ( const zpgOffset: uint8 );
    procedure SEC;
    procedure SED;
    procedure SEI;
    procedure STA_abs_x ( const Address: uint16  );
    procedure STA_abs_y ( const Address: uint16  );
    procedure STA_abs   ( const Address: uint16  );
    procedure STA_ind_y ( const Offset: uint8    );
    procedure STA_x_ind ( const Offset: uint8    );
    procedure STA_zpg_x ( const zpgOffset: uint8 );
    procedure STA_zpg   ( const zpgOffset: uint8 );
    procedure STX_abs   ( const Address: uint16  );
    procedure STX_zpg_y ( const zpgOffset: uint8 );
    procedure STX_zpg   ( const zpgOffset: uint8 );
    procedure STY_abs   ( const Address: uint16  );
    procedure STY_zpg_x ( const zpgOffset: uint8 );
    procedure STY_zpg   ( const zpgOffset: uint8 );
    procedure TAX;
    procedure TAY;
    procedure TSX;
    procedure TXA;
    procedure TXS;
    procedure TYA;
  end;

  ///  <summary>
  ///    Callback type for I6502CPU OnLatch event.
  ///  </summary>
  {$ifndef fpc}
  TLatchEvent = reference to procedure( const LatchValue: uint8; const Memory: I6502VirtualMemory );
  {$else}
  TLatchEvent = procedure( const LatchValue: uint8; const Memory: I6502VirtualMemory ) of object;
  {$endif}

  ///  <summary>
  ///    An implementation of I6502CPU provides an Emulation of
  ///    a Mos6502 8-bit microprocessor. This interface provides
  ///    for the hardware specific features of that CPU.
  ///  </summary>
  I6502CPU = interface( IVirtualCPU )
    ['{BE394947-7D76-4F86-851C-AB70A76ECA7A}']

    /// <summary>
    ///   Returns the contents of the 6502 program counter (PC) register. <br/>
    ///   Getter for the PC property.
    /// </summary>
    function getPC : uint16;

    /// <summary>
    ///   Sets the contents of the 6502 program counter (PC) register. <br/>
    ///   Setter for the PC property.
    /// </summary>
    procedure setPC( const value: uint16 );

    /// <summary>
    ///   Returns the contents of the 6502 accumulator (A) register. <br/>
    ///   Getter for the A property.
    /// </summary>
    function getA : uint8;

    /// <summary>
    ///   Sets the contents of the 6502 accumulator (A) register. <br/>
    ///   Setter for the A property.
    /// </summary>
    procedure setA( const value: uint8 );

    /// <summary>
    ///   Returns the contents of the 6502 x-index (X) register. <br/>
    ///   Getter for the X property.
    /// </summary>
    function getX : uint8;

    /// <summary>
    ///   Sets the contents of the 6502 x-index (X) register. <br/>
    ///   Setter for the X property.
    /// </summary>
    procedure setX( const value: uint8 );

    /// <summary>
    ///   Returns the contents of the 6502 y-index (Y) register. <br/>
    ///   Getter for the Y property.
    /// </summary>
    function getY : uint8;

    /// <summary>
    ///   Sets the contents of the 6502 y-index (Y) register. <br/>
    ///   Setter for the Y property.
    /// </summary>
    procedure setY( const value: uint8 );

    /// <summary>
    ///   Returns the contents of the 6502 stack pointer (SP) register. <br/>
    ///   Getter for the SP property.
    /// </summary>
    function getSP : uint8;

    /// <summary>
    ///   Sets the contents of the 6502 stack pointer (SP) register. <br/>
    ///   Setter for the SP property.
    /// </summary>
    procedure setSP( const value: uint8 );

    /// <summary>
    ///   Returns the contents of the 6502 status (SR) register. <br/>
    ///   Getter for the SP property.
    /// </summary>
    function getSR : uint8;

    /// <summary>
    ///   Sets the contents of the 6502 status (SR) register. <br/>
    ///   Setter for the SP property.
    /// </summary>
    procedure setSR( const value: uint8 );

    /// <summary>
    ///   A utility to return the carry flag from the (SR) status register as a boolean. <br/>
    ///   Getter for the CarryFlag property.
    /// </summary>
    function getCarryFlag: boolean;

    /// <summary>
    ///   A utility to set the carry flag of the (SR) status register as a boolean. <br/>
    ///   Setter for the CarryFlag property.
    /// </summary>
    procedure setCarryFlag( const value: boolean );

    /// <summary>
    ///   A utility to return the zero flag from the (SR) status register as a boolean. <br/>
    ///   Getter for the ZeroFlag property.
    /// </summary>
    function getZeroFlag: boolean;

    /// <summary>
    ///   A utility to set the zero flag of the (SR) status register as a boolean. <br/>
    ///   Setter for the ZeroFlag property.
    /// </summary>
    procedure setZeroFlag( const value: boolean );

    /// <summary>
    ///   A utility to return the IRQ Disable flag from the (SR) status register as a boolean. <br/>
    ///   Getter for the IRQDisableFlag property.
    /// </summary>
    function getIRQDisableFlag: boolean;

    /// <summary>
    ///   A utility to set the IRQ Disable flag of the (SR) status register as a boolean. <br/>
    ///   Setter for the IRQDisableFlag property.
    /// </summary>
    procedure setIRQDisableFlag( const value: boolean );

    /// <summary>
    ///   A utility to return the Decimal Mode flag from the (SR) status register as a boolean. <br/>
    ///   Getter for the DecimalModeFlag property.
    /// </summary>
    function getDecimalModeFlag: boolean;

    /// <summary>
    ///   A utility to set the Decimal Mode flag of the (SR) status register as a boolean. <br/>
    ///   Setter for the DecimalModeFlag property.
    /// </summary>
    procedure setDecimalModeFlag( const value: boolean );

    /// <summary>
    ///   A utility to return the break flag from the (SR) status register as a boolean. <br/>
    ///   Getter for the BreakFlag property.
    /// </summary>
    function getBreakFlag: boolean;

    /// <summary>
    ///   A utility to set the break flag of the (SR) status register as a boolean. <br/>
    ///   Setter for the BreakFlag property.
    /// </summary>
    procedure setBreakFlag( const value: boolean );

    /// <summary>
    ///   A utility to return the Overflow flag from the (SR) status register as a boolean. <br/>
    ///   Getter for the OverflowFlag property.
    /// </summary>
    function getOverflowFlag: boolean;

    /// <summary>
    ///   A utility to set the Overflow flag of the (SR) status register as a boolean. <br/>
    ///   Setter for the OverflowFlag property.
    /// </summary>
    procedure setOverflowFlag( const value: boolean );

    /// <summary>
    ///   A utility to return the negative flag from the (SR) status register as a boolean. <br/>
    ///   Getter for the NegativeFlag property.
    /// </summary>
    function getNegativeFlag: boolean;

    /// <summary>
    ///   A utility to set the negative flag of the (SR) status register as a boolean. <br/>
    ///   Setter for the NegativeFlag property.
    /// </summary>
    procedure setNegativeFlag( const value: boolean );

    ///  <summary>
    ///    Returns a reference to an event handler to be
    ///    called when the CPU alters the value at the latch
    ///    address. (see I6502VirtualMemory for more information). <br/>
    ///  </summary>
    function getOnLatch: TLatchEvent;

    ///  <summary>
    ///    Sets a reference to an event handler to be
    ///    called when the CPU alters the value at the latch
    ///    address. (see I6502VirtualMemory for more information). <br/>
    ///  </summary>
    procedure setOnLatch( const value: TLatchEvent );

    ///  <summary>
    ///   Get or Set an event handler to be called when the CPU
    ///   alters the value at the latch address.
    ///   (see I6502VirtualMemory for more information).
    ///  </summary>
    property OnLatch: TLatchEvent read getOnLatch write setOnLatch;

    /// <summary>
    ///   Get/Set the contents of the 6502 accumulator (A) register. <br/>
    /// </summary>
    property PC: uint16 read getPC write setPC;

    /// <summary>
    ///   Get/Set the contents of the 6502 accumulator (A) register. <br/>
    /// </summary>
    property A: uint8 read getA write setA;

    /// <summary>
    ///   Get/Set the contents of the 6502 x-index (X) register. <br/>
    /// </summary>
    property X: uint8 read getX write setX;

    /// <summary>
    ///   Get/Set the contents of the 6502 y-index (Y) register. <br/>
    /// </summary>
    property Y: uint8 read getY write setY;

    /// <summary>
    ///   Get/Set the contents of the 6502 stack pointer (SP) register. <br/>
    /// </summary>
    property SP: uint8 read getSP write setSP;

    /// <summary>
    ///   Get/Set the contents of the 6502 status (SR) register. <br/>
    /// </summary>
    property SR: uint8 read getSR write setSR;

    /// <summary>
    ///   Get/Set the carry flag of the (SR) status register as a boolean.
    /// </summary>
    property CarryFlag: boolean read getCarryFlag write setCarryFlag;

    /// <summary>
    ///   Get/Set the zero flag of the (SR) status register as a boolean.
    /// </summary>
    property ZeroFlag: boolean read getZeroFlag write setZeroFlag;

    /// <summary>
    ///   Get/Set the IRQ Disable flag of the (SR) status register as a boolean.
    /// </summary>
    property IRQDisableFlag: boolean read getIRQDisableFlag write setIRQDisableFlag;

    /// <summary>
    ///   Get/Set the Decimal Mode flag of the (SR) status register as a boolean.
    /// </summary>
    property DecimalModeFlag: boolean read getDecimalModeFlag write setDecimalModeFlag;

    /// <summary>
    ///   Get/Set the break flag of the (SR) status register as a boolean.
    /// </summary>
    property BreakFlag: boolean read getBreakFlag write setBreakFlag;

    /// <summary>
    ///   Get/Set the Overflow flag of the (SR) status register as a boolean.
    /// </summary>
    property OverflowFlag: boolean read getOverflowFlag write setOverflowFlag;

    /// <summary>
    ///   Get/Set the negative flag of the (SR) status register as a boolean.
    /// </summary>
    property NegativeFlag: boolean read getNegativeFlag write setNegativeFlag;
  end;

  /// <summary>
  ///   A factory record for instancing the 6502 virtual CPU.
  /// </summary>
  T6502CPU = record

    ///  <summary>
    ///    Returns an instance of the 6502 CPU virtual CPU.
    ///  </summary>
    class function Create( const Memory: I6502VirtualMemory ): I6502CPU; static;
  end;

  ///  <summary>
  ///    A factory record for instancing the 6502 byte code writer.
  ///  </summary>
  T6502ByteCode = record

    ///  <summary>
    ///    Returns an instance of the I6502ByteCode implementation.
    ///  </summary>
    class function Create( const Memory: I6502VirtualMemory ): I6502ByteCode; static;
  end;

  ///  <summary>
  ///    A factory record for instancing the 6502 virtual memory system.
  ///  </summary>
  T6502VirtualMemory = record
    class function Create( const InitialSize: nativeuint = c66KB ): I6502VirtualMemory; static;
  end;

implementation
uses
  cwVirtualMachine.VirtualMemory.Mos6502
, cwVirtualMachine.VirtualCPU.Mos6502
, cwVirtualMachine.ByteCode.Mos6502
;

class function T6502VirtualMemory.Create(const InitialSize: nativeuint): I6502VirtualMemory;
begin
  Result := cwVirtualMachine.VirtualMemory.Mos6502.T6502VirtualMemory.Create(InitialSize);
end;

class function T6502ByteCode.Create(const Memory: I6502VirtualMemory): I6502ByteCode;
begin
  Result := cwVirtualMachine.ByteCode.Mos6502.T6502ByteCode.Create( Memory, $100 );
end;

class function T6502CPU.Create(const Memory: I6502VirtualMemory): I6502CPU;
begin
  Result := cwVirtualMachine.VirtualCPU.Mos6502.T6502CPU.Create( Memory );
end;



end.
