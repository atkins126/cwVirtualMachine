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
///   A high-precision timer interface.
/// </summary>
unit cwTiming;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface

const
  stNoHighPrecisionTimer = '{FCF855A5-694F-48D1-994E-D9D60E365930} Could not find a high precision timer on this system.';

const
  ///  <summary>
  ///    Constant representing the number of milliseconds per second.
  ///  </summary>
  cMillisecondsPerSecond = 1000;

  ///  <summary>
  ///    Constant representing the number of nanoseconds per second.
  ///  </summary>
  cNanosecondsPerSecond  = 1000000000;

type
  ///  <summary>
  ///    TTickInteger a large integer for conveying the nanoseconds or
  ///    milliseconds passed in a delta period of a timer.
  ///  </summary>
  TTickInteger = int64;

  ///  <summary>
  ///    ITimer implementations provide a high precision timer which
  ///    begins the first time you call getDeltaTicks from it.
  ///    Each subsequent call will return the delta time that has passed in
  ///    ticks. You can translate the ticks back to actual time using the
  ///    getTicksPerSecond function, which provides an indication of the
  ///    resolution of the timer.
  ///  </summary>
  ITimer = interface
    ['{C3A210E8-EEA8-4880-863D-8D0AB9529CE8}']

    ///  <summary>
    ///    Resets delta to zero for stop-watch style timing.
    ///  </summary>
    procedure Clear;

    ///  <summary>
    ///    Returns the time that has passed between the previous read of
    ///    getDeltaSeconds and this one.
    ///  </summary>
    function getDeltaSeconds: double;

    ///  <summary>
    ///    Number of ticks that have occurred since last calling getDeltaTicks.
    ///  </summary>
    function getDeltaTicks: TTickInteger;

    ///  <summary>
    ///    The number of ticks per second by this timer (gives resolution)
    ///  </summary>
    function getTicksPerSecond: TTickInteger;

    ///  <summary>
    ///    Returns the time that has passed between the previous read of
    ///    DeltaSeconds and this one.
    ///  </summary>
    property DeltaSeconds: double read getDeltaSeconds;

    ///  <summary>
    ///    Number of ticks that have occurred since last reading DeltaTicks;
    ///  </summary>
    property DeltaTicks: TTickInteger read getDeltaTicks;

    ///  <summary>
    ///    The number of ticks per second by this timer (gives resolution)
    ///  </summary>
    property TicksPerSecond: TTickInteger read getTicksPerSecond;
  end;

implementation
uses
  cwStatus
;

initialization
  TStatus.Register(stNoHighPrecisionTimer);

end.

