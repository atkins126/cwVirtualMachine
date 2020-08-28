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
unit cwWin32.GDI32;

interface
{$ifdef MSWINDOWS}
uses
  cwWin32.Types
;

const
  cLibName = 'gdi32.dll';

function AbortDoc(DC: THDC): Integer; stdcall; external cLibName name 'AbortDoc';
function AbortPath(DC: THDC): BOOL; stdcall; external cLibName name 'AbortPath';
function AddFontMemResourceEx(p1: Pointer; p2: DWORD; p3: PDesignVector; p4: LPDWORD): THandle; stdcall; external cLibName name 'AddFontMemResourceEx';
function AddFontResource(p1: PAnsiChar): Integer; stdcall; external cLibName name 'AddFontResourceA';
function AddFontResourceEx(p1: PAnsiChar; p2: DWORD; p3: PDesignVector): Integer; stdcall; external cLibName name 'AddFontResourceExA';
function AddFontResourceExW(p1: PAnsiChar; p2: DWORD; p3: PDesignVector): Integer; stdcall; external cLibName name 'AddFontResourceExW';
function AddFontResourceW(p1: PWideChar): Integer; stdcall; external cLibName name 'AddFontResourceW';
function AngleArc(DC: THDC; p2, p3: Integer; p4: DWORD; p5, p6: Single): BOOL; stdcall; external cLibName name 'AngleArc';
function AnimatePalette(p1: THPALETTE; p2, p3: UINT; p4: PPaletteEntry): BOOL; stdcall; external cLibName name 'AnimatePalette';
function Arc(hDC: THDC; left, top, right, bottom, startX, startY, endX, endY: Integer): BOOL; stdcall; external cLibName name 'Arc';
function ArcTo(DC: THDC; RLeft, RTop, RRight, RBottom: Integer; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external cLibName name 'ArcTo';
function BeginPath(DC: THDC): BOOL; stdcall; external cLibName name 'BeginPath';
function BitBlt(DestDC: THDC; X, Y, Width, Height: Integer; SrcDC: THDC; XSrc, YSrc: Integer; Rop: DWORD): BOOL; stdcall; external cLibName name 'BitBlt';
function CancelDC(DC: THDC): BOOL; stdcall; external cLibName name 'CancelDC';
function CheckColorsInGamut(DC: THDC; var RGBQuads, Results; Count: DWORD): BOOL; stdcall; external cLibName name 'CheckColorsInGamut';
function ChoosePixelFormat(DC: THDC; p2: PPixelFormatDescriptor): Integer; stdcall; external cLibName name 'ChoosePixelFormat';
function Chord(DC: THDC; X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer): BOOL; stdcall; external cLibName name 'Chord';
function CloseEnhMetaFile(DC: THDC): THENHMETAFILE; stdcall; external cLibName name 'CloseEnhMetaFile';
function CloseFigure(DC: THDC): BOOL; stdcall; external cLibName name 'CloseFigure';
function CloseMetaFile(DC: THDC): THMETAFILE; stdcall; external cLibName name 'CloseMetaFile';
function ColorCorrectPalette(DC: THDC; p2: THPALETTE; p3, p4: DWORD): BOOL; stdcall; external cLibName name 'ColorCorrectPalette';
function ColorMatchToTarget(DC: THDC; Target: THDC; Action: DWORD): BOOL; stdcall; external cLibName name 'ColorMatchToTarget';
function CombineRgn(p1, p2, p3: THRGN; p4: Integer): Integer; stdcall; external cLibName name 'CombineRgn';
function CombineTransform(var p1: TXForm; const p2, p3: TXForm): BOOL; stdcall; external cLibName name 'CombineTransform';
function CopyEnhMetaFile(p1: THENHMETAFILE; p2: PAnsiChar): THENHMETAFILE; stdcall; external cLibName name 'CopyEnhMetaFileA';
function CopyEnhMetaFileW(p1: THENHMETAFILE; p2: PWideChar): THENHMETAFILE; stdcall; external cLibName name 'CopyEnhMetaFileW';
function CopyMetaFile(p1: THMETAFILE; p2: PAnsiChar): THMETAFILE; stdcall; external cLibName name 'CopyMetaFileA';
function CopyMetaFileW(p1: THMETAFILE; p2: PWideChar): THMETAFILE; stdcall; external cLibName name 'CopyMetaFileW';
function CreateBitmap(Width, Height: Integer; Planes, BitCount: Longint; Bits: Pointer): THBITMAP; stdcall; external cLibName name 'CreateBitmap';
function CreateBitmapIndirect(const p1: TBitmap): THBITMAP; stdcall; external cLibName name 'CreateBitmapIndirect';
function CreateBrushIndirect(const p1: TLogBrush): THBRUSH; stdcall; external cLibName name 'CreateBrushIndirect';
function CreateColorSpace(var ColorSpace: TLogColorSpaceA): THCOLORSPACE; stdcall; external cLibName name 'CreateColorSpaceA';
function CreateColorSpaceW(var ColorSpace: TLogColorSpaceW): THCOLORSPACE; stdcall; external cLibName name 'CreateColorSpaceW';
function CreateCompatibleBitmap(DC: THDC; Width, Height: Integer): THBITMAP; stdcall; external cLibName name 'CreateCompatibleBitmap';
function CreateCompatibleDC(DC: THDC): THDC; stdcall; external cLibName name 'CreateCompatibleDC';
function CreateDC(lpszDriver, lpszDevice, lpszOutput: PAnsiChar; lpdvmInit: PDeviceModeA): THDC; stdcall; external cLibName name 'CreateDCA';
function CreateDCW(lpszDriver, lpszDevice, lpszOutput: PWideChar; lpdvmInit: PDeviceModeW): THDC; stdcall; external cLibName name 'CreateDCW';
function CreateDIBPatternBrush(p1: HGLOBAL; p2: UINT): THBRUSH; stdcall; external cLibName name 'CreateDIBPatternBrush';
function CreateDIBPatternBrushPt(const p1: Pointer; p2: UINT): THBRUSH; stdcall; external cLibName name 'CreateDIBPatternBrushPt';
function CreateDIBSection(DC: THDC; const p2: TBitmapInfo; p3: UINT; var p4: Pointer; p5: THandle; p6: DWORD): THBITMAP; stdcall; external cLibName name 'CreateDIBSection';
function CreateDIBitmap(DC: THDC; var InfoHeader: TBitmapInfoHeader; dwUsage: DWORD; InitBits: PChar; var InitInfo: TBitmapInfo; wUsage: UINT): THBITMAP; stdcall; external cLibName name 'CreateDIBitmap';
function CreateDiscardableBitmap(DC: THDC; p2, p3: Integer): THBITMAP; stdcall; external cLibName name 'CreateDiscardableBitmap';
function CreateEllipticRgn(p1, p2, p3, p4: Integer): THRGN; stdcall; external cLibName name 'CreateEllipticRgn';
function CreateEllipticRgnIndirect(const p1: TRect): THRGN; stdcall; external cLibName name 'CreateEllipticRgnIndirect';
function CreateEnhMetaFile(DC: THDC; p2: PAnsiChar; p3: PRect; p4: PAnsiChar): THDC; stdcall; external cLibName name 'CreateEnhMetaFileA';
function CreateEnhMetaFileW(DC: THDC; p2: PWideChar; p3: PRect; p4: PWideChar): THDC; stdcall; external cLibName name 'CreateEnhMetaFileW';
function CreateFont(nHeight, nWidth, nEscapement, nOrientaion, fnWeight: Integer; fdwItalic, fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision, fdwClipPrecision, fdwQuality, fdwPitchAndFamily: DWORD; lpszFace: PAnsiChar): THFONT; stdcall; external cLibName name 'CreateFontA';
function CreateFontIndirect(const p1: TLogFontA): THFONT; stdcall; external cLibName name 'CreateFontIndirectA';
function CreateFontIndirectEx(const p1: PEnumLogFontExDVA): THFONT; stdcall; external cLibName name 'CreateFontIndirectExA';
function CreateFontIndirectExW(const p1: PEnumLogFontExDVW): THFONT; stdcall; external cLibName name 'CreateFontIndirectExW';
function CreateFontIndirectW(const p1: TLogFontW): THFONT; stdcall; external cLibName name 'CreateFontIndirectW';
function CreateFontW(nHeight, nWidth, nEscapement, nOrientaion, fnWeight: Integer; fdwItalic, fdwUnderline, fdwStrikeOut, fdwCharSet, fdwOutputPrecision, fdwClipPrecision, fdwQuality, fdwPitchAndFamily: DWORD; lpszFace: PWideChar): THFONT; stdcall; external cLibName name 'CreateFontW';
function CreateHalftonePalette(DC: THDC): THPALETTE; stdcall; external cLibName name 'CreateHalftonePalette';
function CreateHatchBrush(p1: Integer; p2: COLORREF): THBRUSH; stdcall; external cLibName name 'CreateHatchBrush';
function CreateIC(lpszDriver, lpszDevice, lpszOutput: PAnsiChar; lpdvmInit: PDeviceModeA): THDC; stdcall; external cLibName name 'CreateICA';
function CreateICW(lpszDriver, lpszDevice, lpszOutput: PWideChar; lpdvmInit: PDeviceModeW): THDC; stdcall; external cLibName name 'CreateICW';
function CreateMetaFile(p1: PAnsiChar): THDC; stdcall; external cLibName name 'CreateMetaFileA';
function CreateMetaFileW(p1: PWideChar): THDC; stdcall; external cLibName name 'CreateMetaFileW';
function CreatePalette(const LogPalette: TLogPalette): THPALETTE; stdcall; external cLibName name 'CreatePalette';
function CreatePatternBrush(Bitmap: THBITMAP): THBRUSH; stdcall; external cLibName name 'CreatePatternBrush';
function CreatePen(Style, Width: Integer; Color: COLORREF): THPEN; stdcall; external cLibName name 'CreatePen';
function CreatePenIndirect(const LogPen: TLogPen): THPEN; stdcall; external cLibName name 'CreatePenIndirect';
function CreatePolyPolygonRgn(const pPtStructs; const pIntArray; p3, p4: Integer): THRGN; stdcall; external cLibName name 'CreatePolyPolygonRgn';
function CreatePolygonRgn(const Points; Count, FillMode: Integer): THRGN; stdcall; external cLibName name 'CreatePolygonRgn';
function CreateRectRgn(p1, p2, p3, p4: Integer): THRGN; stdcall; external cLibName name 'CreateRectRgn';
function CreateRectRgnIndirect(const p1: TRect): THRGN; stdcall; external cLibName name 'CreateRectRgnIndirect';
function CreateRoundRectRgn(p1, p2, p3, p4, p5, p6: Integer): THRGN; stdcall; external cLibName name 'CreateRoundRectRgn';
function CreateScalableFontResource(p1: DWORD; p2, p3, p4: PAnsiChar): BOOL; stdcall; external cLibName name 'CreateScalableFontResourceA';
function CreateScalableFontResourceW(p1: DWORD; p2, p3, p4: PWideChar): BOOL; stdcall; external cLibName name 'CreateScalableFontResourceW';
function CreateSolidBrush(p1: COLORREF): THBRUSH; stdcall; external cLibName name 'CreateSolidBrush';
function DPtoLP(DC: THDC; var Points; Count: Integer): BOOL; stdcall; external cLibName name 'DPtoLP';
function DeleteColorSpace(ColorSpace: THCOLORSPACE): BOOL; stdcall; external cLibName name 'DeleteColorSpace';
function DeleteDC(DC: THDC): BOOL; stdcall; external cLibName name 'DeleteDC';
function DeleteEnhMetaFile(p1: THENHMETAFILE): BOOL; stdcall; external cLibName name 'DeleteEnhMetaFile';
function DeleteMetaFile(p1: THMETAFILE): BOOL; stdcall; external cLibName name 'DeleteMetaFile';
function DeleteObject(p1: THGDIOBJ): BOOL; stdcall; external cLibName name 'DeleteObject';
function DescribePixelFormat(DC: THDC; p2: Integer; p3: UINT; var p4: TPixelFormatDescriptor): BOOL; stdcall; external cLibName name 'DescribePixelFormat';
function DrawEscape(DC: THDC; p2, p3: Integer; p4: LPCSTR): BOOL; stdcall; external cLibName name 'DrawEscape';
function Ellipse(DC: THDC; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external cLibName name 'Ellipse';
function EndDoc(DC: THDC): Integer; stdcall; external cLibName name 'EndDoc';
function EndPage(DC: THDC): Integer; stdcall; external cLibName name 'EndPage';
function EndPath(DC: THDC): BOOL; stdcall; external cLibName name 'EndPath';
function EnumEnhMetaFile(DC: THDC; p2: THENHMETAFILE; p3: TEnhMetaFileProc; p4: Pointer; const p5: TRect): BOOL; stdcall; external cLibName name 'EnumEnhMetaFile';
function EnumFontFamilies(DC: THDC; p2: PAnsiChar; p3: TEnumFontsProcA; p4: TLPARAM): BOOL; stdcall; external cLibName name 'EnumFontFamiliesA';
function EnumFontFamiliesW(DC: THDC; p2: PWideChar; p3: TEnumFontsProcW; p4: TLPARAM): BOOL; stdcall; external cLibName name 'EnumFontFamiliesW';
function EnumFontFamiliesEx(DC: THDC; var p2: TLogFontA; p3: TEnumFontsProcA; p4: TLPARAM; p5: DWORD): BOOL; stdcall; external cLibName name 'EnumFontFamiliesExA';
function EnumFontFamiliesExW(DC: THDC; var p2: TLogFontW; p3: TEnumFontsProcW; p4: TLPARAM; p5: DWORD): BOOL; stdcall; external cLibName name 'EnumFontFamiliesExW';
function EnumFonts(DC: THDC; lpszFace: PAnsiChar; fntenmprc: TEnumFontsProcA; lpszData: PChar): Integer; stdcall; external cLibName name 'EnumFontsA';
function EnumFontsW(DC: THDC; lpszFace: PWideChar; fntenmprc: TEnumFontsProcW; lpszData: PChar): Integer; stdcall; external cLibName name 'EnumFontsW';
function EnumICMProfiles(DC: THDC; ICMProc: TICMEnumProcA; p3: TLPARAM): Integer; stdcall; external cLibName name 'EnumICMProfilesA';
function EnumICMProfilesW(DC: THDC; ICMProc: TICMEnumProcW; p3: TLPARAM): Integer; stdcall; external cLibName name 'EnumICMProfilesW';
function EnumMetaFile(DC: THDC; p2: THMETAFILE; p3: TEnumMetaFileProc; p4: TLPARAM): BOOL; stdcall; external cLibName name 'EnumMetaFile';
function EnumObjects(DC: THDC; p2: Integer; p3: TEnumObjectsProc; p4: TLPARAM): Integer; stdcall; external cLibName name 'EnumObjects';
function EqualRgn(p1, p2: THRGN): BOOL; stdcall; external cLibName name 'EqualRgn';
function Escape(DC: THDC; p2, p3: Integer; p4: LPCSTR; p5: Pointer): Integer; stdcall; external cLibName name 'Escape';
function ExcludeClipRect(DC: THDC; p2, p3, p4, p5: Integer): Integer; stdcall; external cLibName name 'ExcludeClipRect';
function ExtCreatePen(PenStyle, Width: DWORD; const Brush: TLogBrush; StyleCount: DWORD; Style: Pointer): THPEN; stdcall; external cLibName name 'ExtCreatePen';
function ExtCreateRegion(p1: PXForm; p2: DWORD; const p3: TRgnData): THRGN; stdcall; external cLibName name 'ExtCreateRegion';
function ExtEscape(DC: THDC; p2, p3: Integer; const p4: LPCSTR; p5: Integer; p6: LPSTR): Integer; stdcall; external cLibName name 'ExtEscape';
function ExtFloodFill(DC: THDC; X, Y: Integer; Color: COLORREF; FillType: UINT): BOOL; stdcall; external cLibName name 'ExtFloodFill';
function ExtSelectClipRgn(DC: THDC; p2: THRGN; p3: Integer): Integer; stdcall; external cLibName name 'ExtSelectClipRgn';
function ExtTextOut(DC: THDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PAnsiChar; Count: Longint; Dx: PInteger): BOOL; stdcall; external cLibName name 'ExtTextOutA';
function ExtTextOutW(DC: THDC; X, Y: Integer; Options: Longint; Rect: PRect; Str: PWideChar; Count: Longint; Dx: PInteger): BOOL; stdcall; external cLibName name 'ExtTextOutW';
function FillPath(DC: THDC): BOOL; stdcall; external cLibName name 'FillPath';
function FillRgn(DC: THDC; p2: THRGN; p3: THBRUSH): BOOL; stdcall; external cLibName name 'FillRgn';
function FlattenPath(DC: THDC): BOOL; stdcall; external cLibName name 'FlattenPath';
function FloodFill(DC: THDC; nXStart, nYStart: Integer; crFill: COLORREF): BOOL; stdcall; external cLibName name 'FloodFill';
function FrameRgn(DC: THDC; p2: THRGN; p3: THBRUSH; p4, p5: Integer): BOOL; stdcall; external cLibName name 'FrameRgn';
function GdiComment(DC: THDC; p2: UINT; p3: PChar): BOOL; stdcall; external cLibName name 'GdiComment';
function GdiFlush: BOOL; stdcall; external cLibName name 'GdiFlush';
function GdiGetBatchLimit: DWORD; stdcall; external cLibName name 'GdiGetBatchLimit';
function GdiSetBatchLimit(Limit: DWORD): DWORD; stdcall; external cLibName name 'GdiSetBatchLimit';
function GetArcDirection(DC: THDC): Integer; stdcall; external cLibName name 'GetArcDirection';
function GetAspectRatioFilterEx(DC: THDC; var p2: TSize): BOOL; stdcall; external cLibName name 'GetAspectRatioFilterEx';
function GetBitmapBits(Bitmap: THBITMAP; Count: Longint; Bits: Pointer): Longint; stdcall; external cLibName name 'GetBitmapBits';
function GetBitmapDimensionEx(p1: THBITMAP; var p2: TSize): BOOL; stdcall; external cLibName name 'GetBitmapDimensionEx';
function GetBkColor(hDC: THDC): COLORREF; stdcall; external cLibName name 'GetBkColor';
function GetBkMode(hDC: THDC): Integer; stdcall; external cLibName name 'GetBkMode';
function GetBoundsRect(DC: THDC; var p2: TRect; p3: UINT): UINT; stdcall; external cLibName name 'GetBoundsRect';
function GetBrushOrgEx(DC: THDC; var p2: TPoint): BOOL; stdcall; external cLibName name 'GetBrushOrgEx';
function GetCharABCWidths(DC: THDC; p2, p3: UINT; const ABCStructs): BOOL; stdcall; external cLibName name 'GetCharABCWidthsA';
function GetCharABCWidthsFloat(DC: THDC; p2, p3: UINT; const ABCFloatSturcts): BOOL; stdcall; external cLibName name 'GetCharABCWidthsFloatA';
function GetCharABCWidthsFloatW(DC: THDC; p2, p3: UINT; const ABCFloatSturcts): BOOL; stdcall; external cLibName name 'GetCharABCWidthsFloatW';
function GetCharABCWidthsI(DC: THDC; p2, p3: UINT; p4: PWORD; const Widths): BOOL; stdcall; external cLibName name 'GetCharABCWidthsI';
function GetCharABCWidthsW(DC: THDC; p2, p3: UINT; const ABCStructs): BOOL; stdcall; external cLibName name 'GetCharABCWidthsW';
function GetCharWidth32(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidth32A';
function GetCharWidth32W(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidth32W';
function GetCharWidth(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthA';
function GetCharWidthFloat(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthFloatA';
function GetCharWidthFloatW(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthFloatW';
function GetCharWidthI(DC: THDC; p2, p3: UINT; p4: PWORD; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthI';
function GetCharWidthW(DC: THDC; p2, p3: UINT; const Widths): BOOL; stdcall; external cLibName name 'GetCharWidthW';
function GetCharacterPlacement(DC: THDC; p2: PAnsiChar; p3, p4: BOOL; var p5: TGCP_ResultsA; p6: DWORD): DWORD; stdcall; external cLibName name 'GetCharacterPlacementA';
function GetCharacterPlacementW(DC: THDC; p2: PWideChar; p3, p4: BOOL; var p5: TGCP_ResultsW; p6: DWORD): DWORD; stdcall; external cLibName name 'GetCharacterPlacementW';
function GetClipBox(DC: THDC; var Rect: TRect): Integer; stdcall; external cLibName name 'GetClipBox';
function GetClipRgn(DC: THDC; rgn: THRGN): Integer; stdcall; external cLibName name 'GetClipRgn';
function GetColorAdjustment(DC: THDC; var p2: TColorAdjustment): BOOL; stdcall; external cLibName name 'GetColorAdjustment';
function GetColorSpace(DC: THDC): THandle; stdcall; external cLibName name 'GetColorSpace';
function GetCurrentObject(DC: THDC; p2: UINT): THGDIOBJ; stdcall; external cLibName name 'GetCurrentObject';
function GetCurrentPositionEx(DC: THDC; Point: PPoint): BOOL; stdcall; external cLibName name 'GetCurrentPositionEx';
function GetDCBrushColor(DC: THDC): COLORREF; stdcall; external cLibName name 'GetDCBrushColor';
function GetDCOrgEx(DC: THDC; var Origin: TPoint): BOOL; stdcall; external cLibName name 'GetDCOrgEx';
function GetDCPenColor(DC: THDC): COLORREF; stdcall; external cLibName name 'GetDCPenColor';
function GetDIBColorTable(DC: THDC; p2, p3: UINT; var RGBQuadStructs): UINT; stdcall; external cLibName name 'GetDIBColorTable';
function GetDIBits(DC: THDC; Bitmap: THBITMAP; StartScan, NumScans: UINT; Bits: Pointer; var BitInfo: TBitmapInfo; Usage: UINT): Integer; stdcall; external cLibName name 'GetDIBits';
function GetDeviceCaps(DC: THDC; Index: Integer): Integer; stdcall; external cLibName name 'GetDeviceCaps';
function GetDeviceGammaRamp(DC: THDC; var Ramp): BOOL; stdcall; external cLibName name 'GetDeviceGammaRamp';
function GetEnhMetaFile(p1: PAnsiChar): THENHMETAFILE; stdcall; external cLibName name 'GetEnhMetaFileA';
function GetEnhMetaFileBits(p1: THENHMETAFILE; p2: UINT; p3: PByte): UINT; stdcall; external cLibName name 'GetEnhMetaFileBits';
function GetEnhMetaFileDescription(p1: THENHMETAFILE; p2: UINT; p3: PAnsiChar): UINT; stdcall; external cLibName name 'GetEnhMetaFileDescriptionA';
function GetEnhMetaFileDescriptionW(p1: THENHMETAFILE; p2: UINT; p3: PWideChar): UINT; stdcall; external cLibName name 'GetEnhMetaFileDescriptionW';
function GetEnhMetaFileHeader(p1: THENHMETAFILE; p2: UINT; p3: PEnhMetaHeader): UINT; stdcall; external cLibName name 'GetEnhMetaFileHeader';
function GetEnhMetaFilePaletteEntries(p1: THENHMETAFILE; p2: UINT; p3: Pointer): UINT; stdcall; external cLibName name 'GetEnhMetaFilePaletteEntries';
function GetEnhMetaFilePixelFormat(p1: THENHMETAFILE; p2: Cardinal; var p3: TPixelFormatDescriptor): UINT; stdcall; external cLibName name 'GetEnhMetaFilePixelFormat';
function GetEnhMetaFileW(p1: PWideChar): THENHMETAFILE; stdcall; external cLibName name 'GetEnhMetaFileW';
function GetFontData(DC: THDC; p2, p3: DWORD; p4: Pointer; p5: DWORD): DWORD; stdcall; external cLibName name 'GetFontData';
function GetFontLanguageInfo(DC: THDC): DWORD; stdcall; external cLibName name 'GetFontLanguageInfo';
function GetFontUnicodeRanges(DC: THDC; lpgs: PGlyphSet): DWORD; stdcall; external cLibName name 'GetFontUnicodeRanges';
function GetGlyphIndices(DC: THDC; p2: PAnsiChar; p3: Integer; p4: PWORD; p5: DWORD): DWORD; stdcall; external cLibName name 'GetGlyphIndicesA';
function GetGlyphIndicesW(DC: THDC; p2: PAnsiChar; p3: Integer; p4: PWORD; p5: DWORD): DWORD; stdcall; external cLibName name 'GetGlyphIndicesW';
function GetGlyphOutline(DC: THDC; p2, p3: UINT; const p4: TGlyphMetrics; p5: DWORD; p6: Pointer; const p7: TMat2): DWORD; stdcall; external cLibName name 'GetGlyphOutlineA';
function GetGlyphOutlineW(DC: THDC; p2, p3: UINT; const p4: TGlyphMetrics; p5: DWORD; p6: Pointer; const p7: TMat2): DWORD; stdcall; external cLibName name 'GetGlyphOutlineW';
function GetGraphicsMode(DC: THDC): Integer; stdcall; external cLibName name 'GetGraphicsMode';
function GetICMProfile(DC: THDC; var Size: DWORD; Name: PAnsiChar): BOOL; stdcall; external cLibName name 'GetICMProfileA';
function GetICMProfileW(DC: THDC; var Size: DWORD; Name: PWideChar): BOOL; stdcall; external cLibName name 'GetICMProfileW';
function GetKerningPairs(DC: THDC; Count: DWORD; var KerningPairs): DWORD; stdcall; external cLibName name 'GetKerningPairs';
function GetLogColorSpace(p1: THCOLORSPACE; var ColorSpace: TLogColorSpaceA; Size: DWORD): BOOL; stdcall; external cLibName name 'GetLogColorSpaceA';
function GetLogColorSpaceW(p1: THCOLORSPACE; var ColorSpace: TLogColorSpaceW; Size: DWORD): BOOL; stdcall; external cLibName name 'GetLogColorSpaceW';
function GetMapMode(DC: THDC): Integer; stdcall; external cLibName name 'GetMapMode';
function GetMetaFile(p1: PAnsiChar): THMETAFILE; stdcall; external cLibName name 'GetMetaFileA';
function GetMetaFileBitsEx(p1: THMETAFILE; p2: UINT; p3: Pointer): UINT; stdcall; external cLibName name 'GetMetaFileBitsEx';
function GetMetaFileW(p1: PWideChar): THMETAFILE; stdcall; external cLibName name 'GetMetaFileW';
function GetMetaRgn(DC: THDC; rgn: THRGN): Integer; stdcall; external cLibName name 'GetMetaRgn';
function GetMiterLimit(DC: THDC; var Limit: Single): BOOL; stdcall; external cLibName name 'GetMiterLimit';
function GetNearestColor(DC: THDC; p2: COLORREF): COLORREF; stdcall; external cLibName name 'GetNearestColor';
function GetNearestPaletteIndex(p1: THPALETTE; p2: COLORREF): UINT; stdcall; external cLibName name 'GetNearestPaletteIndex';
function GetObject(p1: THGDIOBJ; p2: Integer; p3: Pointer): Integer; stdcall; external cLibName name 'GetObjectA';
function GetObjectType(h: THGDIOBJ): DWORD; stdcall; external cLibName name 'GetObjectType';
function GetObjectW(p1: THGDIOBJ; p2: Integer; p3: Pointer): Integer; stdcall; external cLibName name 'GetObjectW';
function GetOutlineTextMetrics(DC: THDC; p2: UINT; OTMetricStructs: Pointer): UINT; stdcall; external cLibName name 'GetOutlineTextMetricsA';
function GetOutlineTextMetricsW(DC: THDC; p2: UINT; OTMetricStructs: Pointer): UINT; stdcall; external cLibName name 'GetOutlineTextMetricsW';
function GetPaletteEntries(Palette: THPALETTE; StartIndex, NumEntries: UINT; var PaletteEntries): UINT; stdcall; external cLibName name 'GetPaletteEntries';
function GetPath(DC: THDC; var Points, Types; nSize: Integer): Integer; stdcall; external cLibName name 'GetPath';
function GetPixel(DC: THDC; X, Y: Integer): COLORREF; stdcall; external cLibName name 'GetPixel';
function GetPixelFormat(DC: THDC): Integer; stdcall; external cLibName name 'GetPixelFormat';
function GetPolyFillMode(DC: THDC): Integer; stdcall; external cLibName name 'GetPolyFillMode';
function GetROP2(DC: THDC): Integer; stdcall; external cLibName name 'GetROP2';
function GetRasterizerCaps(var p1: TRasterizerStatus; p2: UINT): BOOL; stdcall; external cLibName name 'GetRasterizerCaps';
function GetRegionData(RGN: THRGN; p2: DWORD; p3: PRgnData): DWORD; stdcall; external cLibName name 'GetRegionData';
function GetRgnBox(RGN: THRGN; var p2: TRect): Integer; stdcall; external cLibName name 'GetRgnBox';
function GetStockObject(Index: Integer): THGDIOBJ; stdcall; external cLibName name 'GetStockObject';
function GetStretchBltMode(DC: THDC): Integer; stdcall; external cLibName name 'GetStretchBltMode';
function GetSystemPaletteEntries(DC: THDC; StartIndex, NumEntries: UINT; var PaletteEntries): UINT; stdcall; external cLibName name 'GetSystemPaletteEntries';
function GetSystemPaletteUse(DC: THDC): UINT; stdcall; external cLibName name 'GetSystemPaletteUse';
function GetTextAlign(DC: THDC): UINT; stdcall; external cLibName name 'GetTextAlign';
function GetTextCharacterExtra(DC: THDC): Integer; stdcall; external cLibName name 'GetTextCharacterExtra';
function GetTextCharset(hdc: THDC): Integer; stdcall; external cLibName name 'GetTextCharset';
function GetTextCharsetInfo(hdc: THDC; lpSig: PFontSignature; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'GetTextCharsetInfo';
function GetTextColor(DC: THDC): COLORREF; stdcall; external cLibName name 'GetTextColor';
function GetTextExtentExPoint(DC: THDC; p2: PAnsiChar; p3, p4: Integer; p5, p6: PInteger; var p7: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentExPointA';
function GetTextExtentExPointI(DC: THDC; p2: PWORD; p3, p4: Integer; p5, p6: PINT; var p7: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentExPointI';
function GetTextExtentExPointW(DC: THDC; p2: PWideChar; p3, p4: Integer; p5, p6: PInteger; var p7: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentExPointW';
function GetTextExtentPoint32(DC: THDC; Str: PAnsiChar; Count: Integer; var Size: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPoint32A';
function GetTextExtentPoint32W(DC: THDC; Str: PWideChar; Count: Integer; var Size: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPoint32W';
function GetTextExtentPoint(DC: THDC; Str: PAnsiChar; Count: Integer; var Size: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPointA';
function GetTextExtentPointI(DC: THDC; p2: PWORD; p3: Integer; var p4: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPointI';
function GetTextExtentPointW(DC: THDC; Str: PWideChar; Count: Integer; var Size: TSize): BOOL; stdcall; external cLibName name 'GetTextExtentPointW';
function GetTextFace(DC: THDC; Count: Integer; Buffer: PAnsiChar): Integer; stdcall; external cLibName name 'GetTextFaceA';
function GetTextFaceW(DC: THDC; Count: Integer; Buffer: PWideChar): Integer; stdcall; external cLibName name 'GetTextFaceW';
function GetTextMetrics(DC: THDC; var TM: TTextMetricA): BOOL; stdcall; external cLibName name 'GetTextMetricsA';
function GetTextMetricsW(DC: THDC; var TM: TTextMetricW): BOOL; stdcall; external cLibName name 'GetTextMetricsW';
function GetViewportExtEx(DC: THDC; var Size: TSize): BOOL; stdcall; external cLibName name 'GetViewportExtEx';
function GetViewportOrgEx(DC: THDC; var Point: TPoint): BOOL; stdcall; external cLibName name 'GetViewportOrgEx';
function GetWinMetaFileBits(p1: THENHMETAFILE; p2: UINT; p3: PByte; p4: Integer; p5: THDC): UINT; stdcall; external cLibName name 'GetWinMetaFileBits';
function GetWindowExtEx(DC: THDC; var Size: TSize): BOOL; stdcall; external cLibName name 'GetWindowExtEx';
function GetWindowOrgEx(DC: THDC; var Point: TPoint): BOOL; stdcall; external cLibName name 'GetWindowOrgEx';
function GetWorldTransform(DC: THDC; var p2: TXForm): BOOL; stdcall; external cLibName name 'GetWorldTransform';
function IntersectClipRect(DC: THDC; X1, Y1, X2, Y2: Integer): Integer; stdcall; external cLibName name 'IntersectClipRect';
function InvertRgn(DC: THDC; p2: THRGN): BOOL; stdcall; external cLibName name 'InvertRgn';
function LPtoDP(DC: THDC; var Points; Count: Integer): BOOL; stdcall; external cLibName name 'LPtoDP';
function LineDDA(p1, p2, p3, p4: Integer; p5: TLineDDAProc; p6: TLPARAM): BOOL; stdcall; external cLibName name 'LineDDA';
function LineTo(DC: THDC; X, Y: Integer): BOOL; stdcall; external cLibName name 'LineTo';
function MaskBlt(DC: THDC; p2, p3, p4, p5: Integer; p6: THDC; p7, p8: Integer; p9: THBITMAP; p10, p11: Integer; p12: DWORD): BOOL; stdcall; external cLibName name 'MaskBlt';
function ModifyWorldTransform(DC: THDC; const p2: TXForm; p3: DWORD): BOOL; stdcall; external cLibName name 'ModifyWorldTransform';
function MoveToEx(DC: THDC; p2, p3: Integer; p4: PPoint): BOOL; stdcall; external cLibName name 'MoveToEx';
function OffsetClipRgn(DC: THDC; p2, p3: Integer): Integer; stdcall; external cLibName name 'OffsetClipRgn';
function OffsetRgn(RGN: THRGN; p2, p3: Integer): Integer; stdcall; external cLibName name 'OffsetRgn';
function OffsetViewportOrgEx(DC: THDC; X, Y: Integer; var Points): BOOL; stdcall; external cLibName name 'OffsetViewportOrgEx';
function OffsetWindowOrgEx(DC: THDC; X, Y: Integer; var Points): BOOL; stdcall; external cLibName name 'OffsetWindowOrgEx';
function PaintRgn(DC: THDC; RGN: THRGN): BOOL; stdcall; external cLibName name 'PaintRgn';
function PatBlt(DC: THDC; X, Y, Width, Height: Integer; Rop: DWORD): BOOL; stdcall; external cLibName name 'PatBlt';
function PathToRegion(DC: THDC): THRGN; stdcall; external cLibName name 'PathToRegion';
function Pie(DC: THDC; X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer): BOOL; stdcall; external cLibName name 'Pie';
function PlayEnhMetaFile(DC: THDC; p2: THENHMETAFILE; const p3: TRect): BOOL; stdcall; external cLibName name 'PlayEnhMetaFile';
function PlayEnhMetaFileRecord(DC: THDC; var p2: THandleTable; const p3: TEnhMetaRecord; p4: UINT): BOOL; stdcall; external cLibName name 'PlayEnhMetaFileRecord';
function PlayMetaFile(DC: THDC; MF: THMETAFILE): BOOL; stdcall; external cLibName name 'PlayMetaFile';
function PlayMetaFileRecord(DC: THDC; const p2: THandleTable; const p3: TMetaRecord; p4: UINT): BOOL; stdcall; external cLibName name 'PlayMetaFileRecord';
function PlgBlt(DC: THDC; const PointsArray; p3: THDC; p4, p5, p6, p7: Integer; p8: THBITMAP; p9, p10: Integer): BOOL; stdcall; external cLibName name 'PlgBlt';
function PolyBezier(DC: THDC; const Points; Count: DWORD): BOOL; stdcall; external cLibName name 'PolyBezier';
function PolyBezierTo(DC: THDC; const Points; Count: DWORD): BOOL; stdcall; external cLibName name 'PolyBezierTo';
function PolyDraw(DC: THDC; const Points, Types; cCount: Integer): BOOL; stdcall; external cLibName name 'PolyDraw';
function PolyPolygon(DC: THDC; var Points; var nPoints; p4: Integer): BOOL; stdcall; external cLibName name 'PolyPolygon';
function PolyPolyline(DC: THDC; const PointStructs; const Points; p4: DWORD): BOOL; stdcall; external cLibName name 'PolyPolyline';
function PolyTextOut(DC: THDC; const PolyTextArray: PPolyTextA; Strings: Integer): BOOL; stdcall; external cLibName name 'PolyTextOutA';
function PolyTextOutW(DC: THDC; const PolyTextArray: PPolyTextW; Strings: Integer): BOOL; stdcall; external cLibName name 'PolyTextOutW';
function Polygon(DC: THDC; var Points; Count: Integer): BOOL; stdcall; external cLibName name 'Polygon';
function Polyline(DC: THDC; var Points; Count: Integer): BOOL; stdcall; external cLibName name 'Polyline';
function PolylineTo(DC: THDC; const Points; Count: DWORD): BOOL; stdcall; external cLibName name 'PolylineTo';
function PtInRegion(RGN: THRGN; p2, p3: Integer): BOOL; stdcall; external cLibName name 'PtInRegion';
function PtVisible(DC: THDC; p2, p3: Integer): BOOL; stdcall; external cLibName name 'PtVisible';
function RealizePalette(DC: THDC): UINT; stdcall; external cLibName name 'RealizePalette';
function RectInRegion(RGN: THRGN; const p2: TRect): BOOL; stdcall; external cLibName name 'RectInRegion';
function RectVisible(DC: THDC; const Rect: TRect): BOOL; stdcall; external cLibName name 'RectVisible';
function Rectangle(DC: THDC; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external cLibName name 'Rectangle';
function RemoveFontMemResourceEx(p1: THandle): BOOL; stdcall; external cLibName name 'RemoveFontMemResourceEx';
function RemoveFontResource(p1: PAnsiChar): BOOL; stdcall; external cLibName name 'RemoveFontResourceA';
function RemoveFontResourceEx(p1: PAnsiChar; p2: DWORD; p3: PDesignVector): BOOL; stdcall; external cLibName name 'RemoveFontResourceExA';
function RemoveFontResourceExW(p1: PAnsiChar; p2: DWORD; p3: PDesignVector): BOOL; stdcall; external cLibName name 'RemoveFontResourceExW';
function RemoveFontResourceW(p1: PWideChar): BOOL; stdcall; external cLibName name 'RemoveFontResourceW';
function ResetDC(DC: THDC; const p2: TDeviceModeA): THDC; stdcall; external cLibName name 'ResetDCA';
function ResetDCW(DC: THDC; const p2: TDeviceModeW): THDC; stdcall; external cLibName name 'ResetDCW';
function ResizePalette(p1: THPALETTE; p2: UINT): BOOL; stdcall; external cLibName name 'ResizePalette';
function RestoreDC(DC: THDC; SavedDC: Integer): BOOL; stdcall; external cLibName name 'RestoreDC';
function RoundRect(DC: THDC; X1, Y1, X2, Y2, X3, Y3: Integer): BOOL; stdcall; external cLibName name 'RoundRect';
function SaveDC(DC: THDC): Integer; stdcall; external cLibName name 'SaveDC';
function ScaleViewportExtEx(DC: THDC; XM, XD, YM, YD: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'ScaleViewportExtEx';
function ScaleWindowExtEx(DC: THDC; XM, XD, YM, YD: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'ScaleWindowExtEx';
function SelectClipPath(DC: THDC; Mode: Integer): BOOL; stdcall; external cLibName name 'SelectClipPath';
function SelectClipRgn(DC: THDC; p2: THRGN): Integer; stdcall; external cLibName name 'SelectClipRgn';
function SelectObject(DC: THDC; p2: THGDIOBJ): THGDIOBJ; stdcall; external cLibName name 'SelectObject';
function SelectPalette(DC: THDC; Palette: THPALETTE; ForceBackground: Bool): THPALETTE; stdcall; external cLibName name 'SelectPalette';
function SetAbortProc(DC: THDC; lpAbortProc: TAbortProc): Integer; stdcall; external cLibName name 'SetAbortProc';
function SetArcDirection(DC: THDC; Direction: Integer): Integer; stdcall; external cLibName name 'SetArcDirection';
function SetBitmapBits(p1: THBITMAP; p2: DWORD; bits: Pointer): Longint; stdcall; external cLibName name 'SetBitmapBits';
function SetBitmapDimensionEx(hBitmap: THBITMAP; Width, Height: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'SetBitmapDimensionEx';
function SetBkColor(DC: THDC; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetBkColor';
function SetBkMode(DC: THDC; BkMode: Integer): Integer; stdcall; external cLibName name 'SetBkMode';
function SetBoundsRect(DC: THDC; p2: PRect; p3: UINT): UINT; stdcall; external cLibName name 'SetBoundsRect';
function SetBrushOrgEx(DC: THDC; X, Y: Integer; PrevPt: PPoint): BOOL; stdcall; external cLibName name 'SetBrushOrgEx';
function SetColorAdjustment(DC: THDC; const p2: TColorAdjustment): BOOL; stdcall; external cLibName name 'SetColorAdjustment';
function SetColorSpace(DC: THDC; ColorSpace: THCOLORSPACE): BOOL; stdcall; external cLibName name 'SetColorSpace';
function SetDCBrushColor(DC: THDC; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetDCBrushColor';
function SetDCPenColor(DC: THDC; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetDCPenColor';
function SetDIBColorTable(DC: THDC; p2, p3: UINT; var RGBQuadSTructs): UINT; stdcall; external cLibName name 'SetDIBColorTable';
function SetDIBits(DC: THDC; Bitmap: THBITMAP; StartScan, NumScans: UINT; Bits: Pointer; var BitsInfo: TBitmapInfo; Usage: UINT): Integer; stdcall; external cLibName name 'SetDIBits';
function SetDIBitsToDevice(DC: THDC; DestX, DestY: Integer; Width, Height: DWORD; SrcX, SrcY: Integer; nStartScan, NumScans: UINT; Bits: Pointer; var BitsInfo: TBitmapInfo; Usage: UINT): Integer; stdcall; external cLibName name 'SetDIBitsToDevice';
function SetDeviceGammaRamp(DC: THDC; var Ramp): BOOL; stdcall; external cLibName name 'SetDeviceGammaRamp';
function SetEnhMetaFileBits(p1: UINT; p2: PChar): THENHMETAFILE; stdcall; external cLibName name 'SetEnhMetaFileBits';
function SetGraphicsMode(hdc: THDC; iMode: Integer): Integer; stdcall; external cLibName name 'SetGraphicsMode';
function SetICMMode(DC: THDC; Mode: Integer): Integer; stdcall; external cLibName name 'SetICMMode';
function SetICMProfile(DC: THDC; Name: PAnsiChar): BOOL; stdcall; external cLibName name 'SetICMProfileA';
function SetICMProfileW(DC: THDC; Name: PWideChar): BOOL; stdcall; external cLibName name 'SetICMProfileW';
function SetMapMode(DC: THDC; p2: Integer): Integer; stdcall; external cLibName name 'SetMapMode';
function SetMapperFlags(DC: THDC; Flag: DWORD): DWORD; stdcall; external cLibName name 'SetMapperFlags';
function SetMetaFileBitsEx(p1: UINT; const p2: PChar): THMETAFILE; stdcall; external cLibName name 'SetMetaFileBitsEx';
function SetMetaRgn(DC: THDC): Integer; stdcall; external cLibName name 'SetMetaRgn';
function SetMiterLimit(DC: THDC; NewLimit: Single; OldLimit: PSingle): BOOL; stdcall; external cLibName name 'SetMiterLimit';
function SetPaletteEntries(Palette: THPALETTE; StartIndex, NumEntries: UINT; var PaletteEntries): UINT; stdcall; external cLibName name 'SetPaletteEntries';
function SetPixel(DC: THDC; X, Y: Integer; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetPixel';
function SetPixelFormat(DC: THDC; p2: Integer; p3: PPixelFormatDescriptor): BOOL; stdcall; external cLibName name 'SetPixelFormat';
function SetPixelV(DC: THDC; X, Y: Integer; Color: COLORREF): BOOL; stdcall; external cLibName name 'SetPixelV';
function SetPolyFillMode(DC: THDC; PolyFillMode: Integer): Integer; stdcall; external cLibName name 'SetPolyFillMode';
function SetROP2(DC: THDC; p2: Integer): Integer; stdcall; external cLibName name 'SetROP2';
function SetRectRgn(Rgn: THRGN; X1, Y1, X2, Y2: Integer): BOOL; stdcall; external cLibName name 'SetRectRgn';
function SetStretchBltMode(DC: THDC; p2: Integer): Integer; stdcall; external cLibName name 'SetStretchBltMode';
function SetSystemPaletteUse(DC: THDC; p2: UINT): UINT; stdcall; external cLibName name 'SetSystemPaletteUse';
function SetTextAlign(DC: THDC; Flags: UINT): UINT; stdcall; external cLibName name 'SetTextAlign';
function SetTextCharacterExtra(DC: THDC; CharExtra: Integer): Integer; stdcall; external cLibName name 'SetTextCharacterExtra';
function SetTextColor(DC: THDC; Color: COLORREF): COLORREF; stdcall; external cLibName name 'SetTextColor';
function SetTextJustification(DC: THDC; BreakExtra, BreakCount: Integer): Integer; stdcall; external cLibName name 'SetTextJustification';
function SetViewportExtEx(DC: THDC; XExt, YExt: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'SetViewportExtEx';
function SetViewportOrgEx(DC: THDC; X, Y: Integer; Point: PPoint): BOOL; stdcall; external cLibName name 'SetViewportOrgEx';
function SetWinMetaFileBits(p1: UINT; p2: PChar; p3: THDC; const p4: TMetaFilePict): THENHMETAFILE; stdcall; external cLibName name 'SetWinMetaFileBits';
function SetWindowExtEx(DC: THDC; XExt, YExt: Integer; Size: PSize): BOOL; stdcall; external cLibName name 'SetWindowExtEx';
function SetWindowOrgEx(DC: THDC; X, Y: Integer; Point: PPoint): BOOL; stdcall; external cLibName name 'SetWindowOrgEx';
function SetWorldTransform(DC: THDC; const p2: TXForm): BOOL; stdcall; external cLibName name 'SetWorldTransform';
function StartDoc(DC: THDC; const p2: TDocInfoA): Integer; stdcall; external cLibName name 'StartDocA';
function StartDocW(DC: THDC; const p2: TDocInfoW): Integer; stdcall; external cLibName name 'StartDocW';
function StartPage(DC: THDC): Integer; stdcall; external cLibName name 'StartPage';
function StretchBlt(DestDC: THDC; X, Y, Width, Height: Integer; SrcDC: THDC; XSrc, YSrc, SrcWidth, SrcHeight: Integer; Rop: DWORD): BOOL; stdcall; external cLibName name 'StretchBlt';
function StretchDIBits(DC: THDC; DestX, DestY, DestWidth, DestHegiht, SrcX, SrcY, SrcWidth, SrcHeight: Integer; Bits: Pointer; var BitsInfo: TBitmapInfo; Usage: UINT; Rop: DWORD): Integer; stdcall; external cLibName name 'StretchDIBits';
function StrokeAndFillPath(DC: THDC): BOOL; stdcall; external cLibName name 'StrokeAndFillPath';
function StrokePath(DC: THDC): BOOL; stdcall; external cLibName name 'StrokePath';
function SwapBuffers(DC: THDC): BOOL; stdcall; external cLibName name 'SwapBuffers';
function TextOut(DC: THDC; X, Y: Integer; Str: PAnsiChar; Count: Integer): BOOL; stdcall; external cLibName name 'TextOutA';
function TextOutW(DC: THDC; X, Y: Integer; Str: PWideChar; Count: Integer): BOOL; stdcall; external cLibName name 'TextOutW';
function TranslateCharsetInfo(var lpSrc: DWORD; var lpCs: TCharsetInfo; dwFlags: DWORD): BOOL; stdcall; external cLibName name 'TranslateCharsetInfo';
function UnrealizeObject(hGDIObj: THGDIOBJ): BOOL; stdcall; external cLibName name 'UnrealizeObject';
function UpdateColors(DC: THDC): BOOL; stdcall; external cLibName name 'UpdateColors';
function UpdateICMRegKey(p1: DWORD; p2, p3: PAnsiChar; p4: UINT): BOOL; stdcall; external cLibName name 'UpdateICMRegKeyA';
function UpdateICMRegKeyW(p1: DWORD; p2, p3: PWideChar; p4: UINT): BOOL; stdcall; external cLibName name 'UpdateICMRegKeyW';
function WidenPath(DC: THDC): BOOL; stdcall; external cLibName name 'WidenPath';

{$endif}
implementation

end.
