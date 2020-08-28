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
unit cwVirtualMachine.Internal;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwIO
, cwStatus
;

type
  //- Represents the state of the CPU.
  //- Custom CPU implementations may create their own 'derrived' state record
  //- types by using a TVMState record as their first field.
  //- For example, to add a register named EAX to the CPU, create
  //-   TMyCPUState = record default: TVMState; EAX: nativeuint; end;
  //- It may also be beneficial to create a pointer type to the new derrived
  //- CPU for ease of addressing.
  TVMState = record
    Bytecode: IBuffer;             //- A buffer containing the byte-code being executed.
    Running: boolean;              //- Running flag to indicate that the program is running. (Initialized true by CPU)
    lpInstructionPointer: pointer; //- The program counter register, pointer to next byte-code instruction

  end;

  //- A pointer to a vitual machine state record.
  pVMState = ^TVMState;

  //- A function call-back (delegate) which handles the execution of a byte-code
  //- instruction. This function will be passed a TVMState record which it may
  //- use to determine where the program counter is, and where the parameters
  //- come from. Depending on the CPU implementation it may update the
  //- program counter after fetching instructions. (Stack based VM's update
  //- the program counter on fetch, register based on execution typically.)
  TVMInstructionHandler = function( const VMState: pVMState ): TStatus;

  //- cwRuntime library internal representation of a virtual CPU, allowing
  //- IVirtualMachine's implementation to work with the CPU state.
  IVirtualCPUState = interface
    ['{6C2F5841-668E-4926-8135-75CE877810C0}']

    //- Reset() allows the virtual machine implementation to reset the CPU
    //- registers to a default state, including the program counter.
    //- The CPU is also provided with a byte-code buffer (ByteCode param) which
    //- contains a byte-code program to be executed.
    //- Reset is expected to return a pointer to it's internal state record,
    //- which may be a derrived state-record type (see TVMState).
    function Reset( const ByteCode: IBuffer ): pVMState;

    //- Uses the internal state record to read the next instruction from
    //- the byte-code buffer, to be executed by the virtual machine
    //- implementation.
    function FetchInstruction( out Handler: TVMInstructionHandler ): TStatus;
  end;

implementation

end.
