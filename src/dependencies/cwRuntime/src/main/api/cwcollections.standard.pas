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
///   Standard implementation for cwCollections.
/// </summary>
unit cwCollections.Standard;
{$ifdef fpc}
  {$mode delphiunicode}
  {$modeswitch nestedprocvars}
{$endif}
interface
uses
  cwCollections
;

type
  ///  <summary>
  ///    Namespace of pre-defined comparison functions for use
  ///    with dictionary / list.remove().
  ///  </summary>
  TCompare = record
    class function ComparePointers( const AValue: pointer; const BValue: pointer ): TComparisonResult; static;
    class function CompareStrings( const AValue: string; const BValue: string ): TComparisonResult; static;
    class function CompareGUIDS( const AValue: TGUID; const BValue: TGUID ): TComparisonResult; static;
  end;

  ///  <summary>
  ///    Factory record for instancing IList<T>
  ///  </summary>
  TList<T> = record
    class function Create( const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IList<T>; static;
  end;

  ///  <summary>
  ///    Factory record for instancing IRingBuffer<T>
  ///  </summary>
  TRingBuffer<T> = record
    class function Create( ItemCount: nativeuint = 128 ): IRingBuffer<T>; static;
  end;

  ///  <summary>
  ///    Factory record for instancing IStack<T>
  ///  </summary>
  TStack<T> = record
    class function Create( const Granularity: nativeuint = 0; const IsPruned: boolean = false ): IStack<T>; static;
  end;

  ///  <summary>
  ///    Factory record for instancing IDictionary<K,V>
  ///  </summary>
  TDictionary<K,V> = record
    {$ifdef fpc}
    class function Create( const KeyCompare: TCompareGlobal<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; overload; static;
    class function Create( const KeyCompare: TCompareOfObject<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; overload; static;
    class function Create( const KeyCompare: TCompareNested<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; overload; static;
    {$else}
    class function Create( const KeyCompare: TCompare<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>; overload; static;
    {$endif}

  end;

  ///  <summary>
  ///    Factory record for instancing IStringList
  ///  </summary>
  TStringList = record
    class function Create( const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IStringList; static;
  end;

implementation
uses
  sysutils
, cwTypes
, cwCollections.List.Standard
, cwCollections.RingBuffer.Standard
, cwCollections.Stack.Standard
, cwCollections.Dictionary.Standard
, cwCollections.StringList.Standard
;

class function TList<T>.Create(const Granularity: nativeuint; const isOrdered: boolean; const isPruned: boolean): IList<T>;
begin
  Result := TStandardList<T>.Create( Granularity, isOrdered, isPruned );
end;

class function TRingBuffer<T>.Create(ItemCount: nativeuint): IRingBuffer<T>;
begin
  Result := TStandardRingBuffer<T>.Create( ItemCount );
end;

class function TStack<T>.Create(const Granularity: nativeuint; const IsPruned: boolean): IStack<T>;
begin
  Result := TStandardStack<T>.Create( Granularity, IsPruned );
end;

{$ifdef fpc}
class function TDictionary<K,V>.Create(const KeyCompare: TCompareGlobal<K>; const Granularity: nativeuint; const isOrdered: boolean; const isPruned: boolean): IDictionary<K, V>;
begin
  Result := TStandardDictionary<K,V>.Create( KeyCompare, Granularity, isOrdered, isPruned );
end;
{$endif}

{$ifdef fpc}
class function TDictionary<K,V>.Create(const KeyCompare: TCompareNested<K>; const Granularity: nativeuint; const isOrdered: boolean; const isPruned: boolean): IDictionary<K, V>;
begin
  Result := TStandardDictionary<K,V>.Create( KeyCompare, Granularity, isOrdered, isPruned );
end;
{$endif}

{$ifdef fpc}
class function TDictionary<K,V>.Create(const KeyCompare: TCompareOfObject<K>; const Granularity: nativeuint; const isOrdered: boolean; const isPruned: boolean): IDictionary<K, V>;
begin
  Result := TStandardDictionary<K,V>.Create( KeyCompare, Granularity, isOrdered, isPruned );
end;
{$endif}

{$ifndef fpc}
class function TDictionary<K,V>.Create( const KeyCompare: TCompare<K>; const Granularity: nativeuint = 32; const isOrdered: boolean = false; const isPruned: boolean = false ): IDictionary<K,V>;
begin
  Result := TStandardDictionary<K,V>.Create( KeyCompare, Granularity, isOrdered, isPruned );
end;
{$endif}

class function TStringList.Create(const Granularity: nativeuint; const isOrdered: boolean; const isPruned: boolean): IStringList;
begin
  Result := TStandardStringList.Create( Granularity, isOrdered, isPruned );
end;

class function TCompare.ComparePointers(const AValue: pointer; const BValue: pointer): TComparisonResult;
begin
  if AValue=BValue then begin
    Result := TComparisonResult.crAEqualToB;
  {$hints off} end else if nativeuint(AValue)>nativeuint(BValue) then begin {$hints on} // fpc warns not portable, actually it is.
    Result := TComparisonResult.crAGreaterThanB;
  end else begin
    Result := TComparisonResult.crBGreaterThanA;
  end;
end;

class function TCompare.CompareStrings(const AValue: string; const BValue: string): TComparisonResult;
begin
  if AValue=BValue then begin
    Result := TComparisonResult.crAEqualToB;
  end else if AValue>BValue then begin
    Result := TComparisonResult.crAGreaterThanB;
  end else begin
    Result := TComparisonResult.crBGreaterThanA;
  end;
end;

class function TCompare.CompareGUIDS(const AValue: TGUID; const BValue: TGUID): TComparisonResult;
begin
  if IsEqualGUID(AValue,BValue) then begin
    Result := TComparisonResult.crAEqualToB;
  end else begin
    Result := TComparisonResult.crAGreaterThanB;
  end;
end;

end.
