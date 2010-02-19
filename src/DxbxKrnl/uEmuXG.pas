(*
    This file is part of Dxbx - a XBox emulator written in Delphi (ported over from cxbx)
    Copyright (C) 2007 PatrickvL and other members of the development team.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*)

unit uEmuXG;

{$INCLUDE Dxbx.inc}

interface

uses
  // Jedi Win32API
  JwaWinType,
  // DirectX
  Direct3D8, // D3DFORMAT
  // Dxbx
  uTypes,
  uLog,
  uEmu,
  uEmuFS,
  uDxbxKrnlUtils;

// From EmuXG.h :

// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100
type _XGPOINT3D = packed record
    u: DWORD;
    v: DWORD;
    w: DWORD;
end;
XGPOINT3D = _XGPOINT3D;
PXGPOINT3D = ^XGPOINT3D;

procedure XTL_EmuXGUnswizzleRect
(
    pSrcBuff: PVOID;
    dwWidth: DWORD;
    dwHeight: DWORD;
    dwDepth: DWORD;
    pDstBuff: PVOID;
    dwPitch: DWORD;
    rSrc: TRECT;
    poDst: TPOINT;
    dwBPP: DWORD
) ; stdcall;

implementation

// From EmuXG.cpp :

function XTL_EmuXGIsSwizzledFormat
(
    Format: D3DFORMAT
): PVOID; stdcall;
// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100
begin
{$IFDEF _DEBUG_TRACE}
  EmuSwapFS(fsWindows);
  DbgPrintf('EmuXapi: EmuXGIsSwizzledFormat' +
     #13#10+'(' +
     #13#10+'   Format              : 0x%.08X' +
     #13#10+')',
     [Ord(Format)]);
  EmuSwapFS(fsXbox);
{$ENDIF}

  Result := nil;
end;

procedure XTL_EmuXGSwizzleRect
(
    pSource: LPCVOID;
    Pitch: DWORD;
    pRect: LPCRECT;
    pDest: LPVOID;
    Width: DWORD;
    Height: DWORD;
    CONST pPoint: LPPOINT;
    BytesPerPixel: DWORD
); stdcall;
// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100
var
  dwMaxY: DWORD;
  dwChunkSize: DWORD;
  pSrc: Puint08;
  pDst: Puint08;
  y: DWORD;
begin
  EmuSwapFS(fsWindows);

{$IFDEF DEBUG}
  DbgPrintf('EmuXapi : EmuXGSwizzleRect' +
     #13#10'(' +
     #13#10'   pSource             : 0x%.08X' +
     #13#10'   Pitch               : 0x%.08X' +
     #13#10'   pRect               : 0x%.08X' +
     #13#10'   pDest               : 0x%.08X' +
     #13#10'   Width               : 0x%.08X' +
     #13#10'   Height              : 0x%.08X' +
     #13#10'   pPoint              : 0x%.08X' +
     #13#10'   BytesPerPixel       : 0x%.08X' +
     #13#10');',
     [pSource, Pitch, pRect, pDest, Width, Height,
      pPoint, BytesPerPixel]);
{$ENDIF}

  if (pRect = NULL) and (pPoint = NULL) and (Pitch = 0) then
  begin
    memcpy(pDest, pSource, Width*Height*BytesPerPixel);
  end
  else
  begin
    if Assigned(pPoint) and ((pPoint.x <> 0) or (pPoint.y <> 0)) then
      CxbxKrnlCleanup('Temporarily unsupported swizzle (very easy fix)');

    dwMaxY := Height;
    dwChunkSize := Width;

    pSrc := Puint08(pSource);
    pDst := Puint08(pDest);

    if Assigned(pRect) then
    begin
      Inc(pSrc, DWORD(pRect.top)*Pitch);
      Inc(pSrc, pRect.left);

      dwMaxY := pRect.bottom - pRect.top;
      dwChunkSize := pRect.right - pRect.left;
    end;

    for y := 0 to dwMaxY - 1 do
    begin
      memcpy(pSrc, pDst, dwChunkSize);
      Inc(pSrc, Pitch);
      Inc(pDst, Pitch);
    end;
  end;

  EmuSwapFS(fsXbox);
end;


procedure XTL_EmuXGSwizzleBox
(
    pSource: LPCVOID;
    RowPitch: DWORD;
    SlicePitch: DWORD;
    CONST pBox: PD3DBOX;
    pDest: LPVOID;
    Width: DWORD;
    Height: DWORD;
    Depth: DWORD;
    CONST pPoint: PXGPOINT3D;
    BytesPerPixel: DWORD
); stdcall;
// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100
var
  dwMaxY: DWORD;
  // dwMaxZ: DWORD;
  dwChunkSize: DWORD;
  pSrc: Puint08;
  pDst: Puint08;
  y: DWORD;
begin
  EmuSwapFS(fsWindows);

{$IFDEF DEBUG}
  DbgPrintf('EmuXapi : EmuXGSwizzleBox' +
      #13#10'(' +
      #13#10'   pSource             : 0x%.08X' +
      #13#10'   RowPitch            : 0x%.08X' +
      #13#10'   SlicePitch          : 0x%.08X' +
      #13#10'   pBox                : 0x%.08X' +
      #13#10'   pDest               : 0x%.08X' +
      #13#10'   Width               : 0x%.08X' +
      #13#10'   Height              : 0x%.08X' +
      #13#10'   Depth               : 0x%.08X' +
      #13#10'   pPoint              : 0x%.08X' +
      #13#10'   BytesPerPixel       : 0x%.08X' +
      #13#10');',
      [pSource, RowPitch, SlicePitch, pBox, pDest, Width, Height,
       Depth, pPoint, BytesPerPixel]);
{$ENDIF}

  if (pDest <> LPVOID($80000000)) then
  begin
    if (pBox = NULL) and (pPoint = NULL) and (RowPitch = 0) and (SlicePitch = 0) then
    begin
      memcpy(pDest, pSource, Width*Height*Depth*BytesPerPixel);
    end
    else
    begin
      if (pPoint <> NULL) and ((pPoint.u <> 0) or (pPoint.u <> 0) or (pPoint.w <> 0)) then
        CxbxKrnlCleanup('Temporarily unsupported swizzle (easy fix)');

      dwMaxY := Height;
      // dwMaxZ := Depth;
      dwChunkSize := Width;

      pSrc := Puint08(pSource);
      pDst := Puint08(pDest);

      if (pBox <> nil) then
      begin
        Inc(pSrc, pBox.Top*RowPitch);
        Inc(pSrc, pBox.Left);

        dwMaxY := pBox.Bottom - pBox.Top;
        dwChunkSize := pBox.Right - pBox.Left;
      end;

      for y := 0 to dwMaxY - 1 do
      begin
        memcpy(pSrc, pDst, dwChunkSize);
        Inc(pSrc, RowPitch);
        Inc(pDst, RowPitch);
      end;
    end;
  end;

  EmuSwapFS(fsXbox);
end;

procedure XTL_EmuXGUnswizzleRect
(
    pSrcBuff: PVOID;
    dwWidth: DWORD;
    dwHeight: DWORD;
    dwDepth: DWORD;
    pDstBuff: PVOID;
    dwPitch: DWORD;
    rSrc: TRECT;
    poDst: TPOINT;
    dwBPP: DWORD
); stdcall;
// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100
var
  dwOffsetU: DWORD;
  dwMaskU: DWORD;
  dwOffsetV: DWORD;
  dwMaskV: DWORD;
  dwOffsetW: DWORD;
  dwMaskW: DWORD;
  i: DWORD;
  j: DWORD;
  dwSU: DWORD;
  dwSV: DWORD;
  dwSW: DWORD;
  dwMaskMax: DWORD;
  dwW: DWORD;
  dwV: DWORD;
  dwU: DWORD;
  z: DWORD;
  y: DWORD;
  x: DWORD;
begin
  dwOffsetU := 0; dwMaskU := 0;
  dwOffsetV := 0; dwMaskV := 0;
  dwOffsetW := 0; dwMaskW := 0;

  i := 1;
  j := 1;

//  MARKED OUT CXBX:
// while ((i >= dwWidth) or (i >= dwHeight) or (i >= dwDepth)) do

  while ((i <= dwWidth) or (i <= dwHeight) or (i <= dwDepth)) do
  begin

    if (i < dwWidth) then
    begin
      dwMaskU := dwMaskU or j;
      j := j shl 1;
    end;

    if (i < dwHeight) then
    begin
      dwMaskV := dwMaskV or j;
      j := j shl 1;
    end;

    if (i < dwDepth) then
    begin
      dwMaskW := dwMaskW or j;
      j := j shl 1;
    end;

    i := i shl 1;
  end;

  dwSU := 0;
  dwSV := 0;
  dwSW := 0;
  // dwMaskMax := 0;

  // get the biggest mask
  if (dwMaskU > dwMaskV) then
    dwMaskMax := dwMaskU
  else
    dwMaskMax := dwMaskV;
  if (dwMaskW > dwMaskMax) then
    dwMaskMax := dwMaskW;

  i := 1; while i <= dwMaskMax do
  begin
    if (i <= dwMaskU) then
    begin
      if (dwMaskU and i) > 0 then dwSU := dwSU or (dwOffsetU and i)
      else                       dwOffsetU := dwOffsetU shl 1;
    end;

    if (i <= dwMaskV) then
    begin
      if (dwMaskV and i) > 0 then dwSV := dwSV or (dwOffsetV and i)
      else                        dwOffsetV := dwOffsetV shl 1;
    end;

    if (i <= dwMaskW) then
    begin
      if (dwMaskW and i) > 0 then dwSW := dwSW or (dwOffsetW and i)
      else                        dwOffsetW := dwOffsetW shl 1;
    end;
    i := i shl 1;
  end;

  dwW := dwSW;
  // dwV := dwSV;
  // dwU := dwSU;

  for z := 0 to dwDepth - 1 do
  begin
    dwV := dwSV;

    for y := 0 to dwHeight - 1 do
    begin
      dwU := dwSU;

      for x := 0 to dwWidth - 1 do
      begin
        memcpy(pDstBuff, @(PByte(pSrcBuff)[(dwU or dwV or dwW)*dwBPP]), dwBPP);
        pDstBuff := PVOID(DWORD(pDstBuff)+dwBPP);

        dwU := (dwU - dwMaskU) and dwMaskU;
      end;
      pDstBuff := PVOID(DWORD(pDstBuff)+(dwPitch-dwWidth*dwBPP));
      dwV := (dwV - dwMaskV) and dwMaskV;
    end;
    dwW := (dwW - dwMaskW) and dwMaskW;
  end;
end;

function XTL_EmuXGWriteSurfaceOrTextureToXPR
(
  pResource: LPVOID;
  const cPath: PAnsiChar;
  bWriteSurfaceAsTexture: BOOL
): HRESULT; stdcall;
// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100
begin
  EmuSwapFS(fsWindows);

  DbgPrintf('EmuXapi : EmuXGWriteSurfaceOrTextureToXPR' +
      #13#10'(' +
      #13#10'   pResource              : 0x%.08X' +
      #13#10'   cPath                  : 0x%.08X' +
      #13#10'   bWriteSurfaceAsTexture : 0x%.08X' +
      #13#10');',
      [pResource, cPath, bWriteSurfaceAsTexture]);

  // TODO: If necessary, either reverse the .xbx and .xpr file formats
  // and write the surface/texture to a file, or output a generic .xbx
  // file and be done with it.

  EmuWarning('(Temporarily) ignoring EmuXGWriteSurfaceOrTextureToXPR. Need file specs.');

  EmuSwapFS(fsXbox);

  Result := S_OK;
end;

exports
  XTL_EmuXGIsSwizzledFormat,
  XTL_EmuXGSwizzleBox,
  XTL_EmuXGSwizzleRect,
  XTL_EmuXGUnswizzleRect,
  XTL_EmuXGWriteSurfaceOrTextureToXPR;

end.
