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
program test_cwRuntime;
{$ifdef fpc}{$mode delphiunicode}{$H+}{$endif}

uses
  cwTest
, cwTest.Standard
{$ifdef fpc}
, testcase.cwvectors.dvector4
, testcase.cwvectors.ematrix2x2
, testcase.cwvectors.ematrix3x3
, testcase.cwvectors.ematrix4x4
, testcase.cwvectors.eray
, testcase.cwvectors.evector2
, testcase.cwvectors.evector3
, testcase.cwvectors.evector4
, testcase.cwvectors.smatrix2x2
, testcase.cwvectors.smatrix3x3
, testcase.cwvectors.smatrix4x4
, testcase.cwvectors.sray
, testcase.cwvectors.svector2
, testcase.cwvectors.svector3
, testcase.cwvectors.svector4
, testcase.cwvectors.dmatrix2x2
, testcase.cwvectors.dmatrix3x3
, testcase.cwvectors.dmatrix4x4
, testcase.cwvectors.dray
, testcase.cwvectors.dvector2
, testcase.cwvectors.dvector3
{$else}
, testcase.cwvectors.dvector4
, testcase.cwvectors.ematrix2x2
, testcase.cwvectors.ematrix3x3
, testcase.cwvectors.ematrix4x4
, testcase.cwvectors.eray
, testcase.cwvectors.evector2
, testcase.cwvectors.evector3
, testcase.cwvectors.evector4
, testcase.cwvectors.smatrix2x2
, testcase.cwvectors.smatrix3x3
, testcase.cwvectors.smatrix4x4
, testcase.cwvectors.sray
, testcase.cwvectors.svector2
, testcase.cwvectors.svector3
, testcase.cwvectors.svector4
, testcase.cwvectors.dmatrix2x2
, testcase.cwvectors.dmatrix3x3
, testcase.cwvectors.dmatrix4x4
, testcase.cwvectors.dray
, testcase.cwvectors.dvector2
, testcase.cwvectors.dvector3
{$endif}
, testcase.cwunicode.unicodestring.standard
, testcase.cwunicode.codec.standard
, testcase.cwtypes.int64helper
, testcase.cwtypes.nativeuinthelper
, testcase.cwtypes.pointerhelper
, testcase.cwtypes.singlehelper
, testcase.cwtypes.stringhelper
, testcase.cwtypes.uint8helper
, testcase.cwtypes.uint16helper
, testcase.cwtypes.uint32helper
, testcase.cwtypes.uint64helper
, testcase.cwtypes.booleanhelper
, testcase.cwtypes.charhelper
, testcase.cwtypes.datetimehelper
, testcase.cwtypes.doublehelper
, testcase.cwtypes.extendedhelper
, testcase.cwtypes.int8helper
, testcase.cwtypes.int16helper
, testcase.cwtypes.int32helper
, testcase.cwthreading.internal.taskset
, testcase.cwthreading.internal.tasksetcollection
, testcase.cwthreading.message
, testcase.cwthreading.messageparameter
, testcase.cwthreading.executeforloop
, testcase.cwthreading.executetasks
, testcase.cwthreading.internal.taskrecord
, testcase.cwtest.setupfails
, testcase.cwtest.teardownfails
, testcase.cwtest.sampletest
, testcase.cwio.streams
, testcase.cwio.unicodebuffers
, testcase.cwio.unicodestreams
, testcase.cwio.buffers
, testcase.cwio.cyclicbuffers
, testcase.cwcollections.list
, testcase.cwcollections.ringbuffer
, testcase.cwcollections.stack
, testcase.cwcollections.dictionary
;

var
  R: nativeuint;

begin
  R := TestSuite.Run( 'test_cwRuntime', [TConsoleReport.Create] );
  if ParamStr(1)='ide' then begin
    Readln;
  end;
  System.ExitCode := R;
end.
