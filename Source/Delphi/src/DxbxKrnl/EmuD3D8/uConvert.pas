(*
    This file is part of Dxbx - a XBox emulator written in Delphi (ported over from cxbx)
    Copyright (C) 2007 Shadow_tj and other members of the development team.

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
unit uConvert;

{$INCLUDE Dxbx.inc}

interface

uses
  // Delphi
  Windows
  , SysUtils
  // Jedi Win32API
  , JwaWinType
  // DirectX
{$IFDEF DXBX_USE_D3D9}
  , Direct3D9
{$ELSE}
  , Direct3D8
{$ENDIF}
  // Dxbx
  , uTypes
  , uDxbxUtils // BOOL2String
  , uDxbxKrnlUtils
  , uNV2A
  , uEmuD3D8Types
  , uEmuD3D8Utils
  , uEmu;


// Caps to string :
function DxbxLineCapsToString(const LineCaps: DWORD): string; // LineCaps
function DxbxRasterCapsToString(const RasterCaps: DWORD): string; // RasterCaps
function DxbxCmpCapsToString(const CmpCaps: DWORD): string; // ZCmpCaps, AlphaCmpCaps
function DxbxBlendCapsToString(const BlendCaps: DWORD): string; // SourceBlendCaps, DestBlendCaps
function DxbxShadeCapsToString(const ShadeCaps: DWORD): string; // ShadeCaps
function DxbxTextureCapsToString(const TextureCaps: DWORD): string; // TextureCaps
function DxbxTextureFilterCapsToString(const TextureFilterCaps: DWORD): string; // TextureFilterCaps
function DxbxTextureAddressCapsToString(const TextureAddressCaps: DWORD): string; // TextureAddressCaps
function DxbxStencilCapsToString(const StencilCaps: DWORD): string; // StencilCaps
function DxbxTextureOpCapsToString(const TextureOpCaps: DWORD): string; // TextureOpCaps
function DxbxFVFCapsToString(const FVFCaps: DWORD): string; // FVFCaps
function DxbxVertexProcessingCapsToString(const VertexProcessingCaps: DWORD): string; // VertexProcessingCaps

function DxbxD3DUsageToString(const dwUsage: DWORD): string;
function DxbxD3DPoolToString(const Pool: D3DPOOL): string;

procedure EmuXB2PC_D3DSURFACE_DESC(const SurfaceDesc: PX_D3DSURFACE_DESC; const pDesc: PD3DSURFACE_DESC; const CallerName: string);

function EmuPC2XB_D3DFormat(aFormat: D3DFORMAT): X_D3DFORMAT;

function EmuXB2PC_D3DBLEND(Value: X_D3DBLEND): D3DBLEND;
function EmuXB2PC_D3DBLENDOP(Value: X_D3DBLENDOP): D3DBLENDOP;
function EmuXB2PC_D3DCLEAR_FLAGS(Value: DWORD): DWORD;
function EmuXB2PC_D3DCMPFUNC(Value: X_D3DCMPFUNC): D3DCMPFUNC;
function EmuXB2PC_D3DCOLORWRITEENABLE(Value: X_D3DCOLORWRITEENABLE): DWORD;
function EmuXB2PC_D3DCULL(Value: X_D3DCULL): D3DCULL;
function EmuXB2PC_D3DFILLMODE(Value: X_D3DFILLMODE): D3DFILLMODE;
function EmuXB2PC_D3DFormat(aFormat: X_D3DFORMAT): D3DFORMAT;
function EmuXB2PC_D3DLock(Flags: DWORD): DWORD;
function EmuXB2PC_D3DMULTISAMPLE_TYPE(aType: X_D3DMULTISAMPLE_TYPE): D3DMULTISAMPLE_TYPE;
function EmuXB2PC_D3DPrimitiveType(PrimitiveType: X_D3DPRIMITIVETYPE): D3DPRIMITIVETYPE;
function EmuXB2PC_D3DSHADEMODE(Value: X_D3DSHADEMODE): D3DSHADEMODE;
function EmuXB2PC_D3DSTENCILOP(Value: X_D3DSTENCILOP): D3DSTENCILOP;
function EmuXB2PC_D3DTEXTUREADDRESS(Value: DWORD): DWORD;
function EmuXB2PC_D3DTEXTUREFILTERTYPE(Value: DWORD): DWORD;
function EmuXB2PC_D3DTEXTUREOP(Value: X_D3DTEXTUREOP): DWORD;
function EmuXB2PC_D3DTS(State: X_D3DTRANSFORMSTATETYPE): D3DTRANSFORMSTATETYPE;
function EmuXB2PC_D3DTSS(Value: X_D3DTEXTURESTAGESTATETYPE): TD3DSamplerStateType;//=D3DSAMPLERSTATETYPE
function EmuXB2PC_D3DVERTEXBLENDFLAGS(Value: X_D3DVERTEXBLENDFLAGS): D3DVERTEXBLENDFLAGS;
function EmuXB2PC_D3DWRAP(Value: DWORD): DWORD;

function EmuD3DVertex2PrimitiveCount(PrimitiveType: X_D3DPRIMITIVETYPE; VertexCount: int): INT;
function EmuD3DPrimitive2VertexCount(PrimitiveType: X_D3DPRIMITIVETYPE; PrimitiveCount: int): int;

procedure EmuUnswizzleRect
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
); {NOPATCH}

// Code translated from Convert.cpp :

const
// lookup table for converting vertex count to primitive count
EmuD3DVertexToPrimitive: array [0..Ord(X_D3DPT_POLYGON)] of array [0..2-1] of {U}INT = (
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    (0, 0), // NULL
    (1, 0), // X_D3DPT_POINTLIST
    (2, 0), // X_D3DPT_LINELIST
    (1, 1), // X_D3DPT_LINELOOP
    (1, 1), // X_D3DPT_LINESTRIP
    (3, 0), // X_D3DPT_TRIANGLELIST
    (1, 2), // X_D3DPT_TRIANGLESTRIP
    (1, 2), // X_D3DPT_TRIANGLEFAN
    (4, 0), // X_D3DPT_QUADLIST
    (2, 2), // X_D3DPT_QUADSTRIP
    (1, 0)  // X_D3DPT_POLYGON
);

const
// conversion table for xbox->pc primitive types
EmuPrimitiveTypeLookup: array [0..Ord(X_D3DPT_POLYGON)] of D3DPRIMITIVETYPE = (
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    D3DPRIMITIVETYPE(0),   // NULL                   = 0
    D3DPT_POINTLIST,       // X_D3DPT_POINTLIST      = 1,
    D3DPT_LINELIST,        // X_D3DPT_LINELIST       = 2,
    D3DPT_LINESTRIP,       // X_D3DPT_LINELOOP       = 3,  Xbox, closes the line by drawing 1 lie from last to first vertex
    D3DPT_LINESTRIP,       // X_D3DPT_LINESTRIP      = 4,
    D3DPT_TRIANGLELIST,    // X_D3DPT_TRIANGLELIST   = 5,
    D3DPT_TRIANGLESTRIP,   // X_D3DPT_TRIANGLESTRIP  = 6,
    D3DPT_TRIANGLEFAN,     // X_D3DPT_TRIANGLEFAN    = 7,
    D3DPT_TRIANGLELIST,    // X_D3DPT_QUADLIST       = 8,  Xbox
    D3DPT_TRIANGLESTRIP,   // X_D3DPT_QUADSTRIP      = 9,  Xbox
    D3DPT_TRIANGLEFAN      // X_D3DPT_POLYGON        = 10, Xbox
);

function DxbxXB2PC_NOP(Value: DWORD): DWORD;

function DWFloat2String(aValue: DWORD): string;
function X_D3DBLEND2String(aValue: DWORD): string;
function X_D3DBLENDOP2String(aValue: DWORD): string;
function X_D3DCLEAR2String(aValue: DWORD): string;
function X_D3DCMPFUNC2String(aValue: DWORD): string;
function X_D3DCOLORWRITEENABLE2String(aValue: DWORD): string;
function X_D3DCUBEMAP_FACES2String(aValue: DWORD): string;
function X_D3DCULL2String(aValue: DWORD): string;
function X_D3DDCC2String(aValue: DWORD): string;
function X_D3DFOGMODE2String(aValue: DWORD): string;
function X_D3DFRONT2String(aValue: DWORD): string;
function X_D3DFILLMODE2String(aValue: DWORD): string;
function X_D3DLOGICOP2String(aValue: DWORD): string;
function X_D3DMCS2String(aValue: DWORD): string;
function X_D3DMULTISAMPLE_TYPE2String(aValue: DWORD): string;
function X_D3DMULTISAMPLEMODE2String(aValue: DWORD): string;
function X_D3DPRIMITIVETYPE2String(const aValue: X_D3DPRIMITIVETYPE): string;
function X_D3DRESOURCETYPE2String(const aValue: X_D3DRESOURCETYPE): string;
function X_D3DSAMPLEALPHA2String(aValue: DWORD): string;
function X_D3DSHADEMODE2String(aValue: DWORD): string;
function X_D3DSTENCILOP2String(aValue: DWORD): string;
function X_D3DSWATH2String(aValue: DWORD): string;
function X_D3DTEXTUREADDRESS2String(aValue: DWORD): string;
function X_D3DTEXTUREOP2String(aValue: DWORD): string;
function X_D3DTEXTURESTAGESTATETYPE2String(aValue: DWORD): string;
function X_D3DTRANSFORMSTATETYPE2String(aValue: DWORD): string;
function X_D3DVERTEXBLENDFLAGS2String(aValue: DWORD): string;
function X_D3DVSDE2String(aValue: DWORD): string;
function X_D3DWRAP2String(aValue: DWORD): string;

type
  TXB2PCFunc = function(Value: DWORD): DWORD;
  TXB2StringFunc = function(Value: DWORD): string;

  TXBType = (
    xt_Unknown = 0, // Defined as zero, to coincide with default value of DxbxRenderStateInfo.T and DxbxTextureStageStateInfo.T

    xtBOOL,
    xtBYTE,
    xtD3DBLEND,
    xtD3DBLENDOP,
    xtD3DCLEAR,
    xtD3DCMPFUNC,
    xtD3DCOLOR,
    xtD3DCOLORWRITEENABLE,
    xtD3DCUBEMAP_FACES,
    xtD3DCULL,
    xtD3DDCC,
    xtD3DFILLMODE,
    xtD3DFOGMODE,
    xtD3DFORMAT,
    xtD3DFRONT,
    xtD3DLOGICOP,
    xtD3DMCS,
    xtD3DMULTISAMPLE_TYPE,
    xtD3DMULTISAMPLEMODE,
    xtD3DPRIMITIVETYPE,
    xtD3DRESOURCETYPE,
    xtD3DSAMPLEALPHA,
    xtD3DSHADEMODE,
    xtD3DSTENCILOP,
    xtD3DSWATH,
    xtD3DTEXTUREADDRESS, // Used for TextureStageState X_D3DTSS_ADDRESSU, X_D3DTSS_ADDRESSV and X_D3DTSS_ADDRESSW
    xtD3DTEXTUREFILTERTYPE, // Used for TextureStageState X_D3DTSS_MAGFILTER, X_D3DTSS_MINFILTER and X_D3DTSS_MIPFILTER
    xtD3DTEXTUREOP, // Used for TextureStageState X_D3DTSS_COLOROP and X_D3DTSS_ALPHAOP
    xtD3DTEXTURESTAGESTATETYPE,
    xtD3DTRANSFORMSTATETYPE,
    xtD3DVERTEXBLENDFLAGS,
    xtD3DVSDE,
    xtD3DWRAP,
    xtDWORD,
    xtFloat,
    xtLONG);

  function DxbxTypedValueToString(const aType: TXBType; const aValue: DWORD): string;

type
  XBTypeInfo = record
    S: string;
    F: Pointer; // = TXB2PCFunc, but declared as pointer because of different argument & return types in the callbacks
    R: Pointer; // = TXB2StringFunc, which can be used to render state blocks in a generic way(!)
    X: Boolean;
  end;

const
  // Table of Xbox-to-PC and Value-to-String converters for all registered types :
  DxbxXBTypeInfo: array [TXBType] of XBTypeInfo = (
    (S:'Unknown';                  F:@DxbxXB2PC_NOP),

    (S:'BOOL';                     F:@DxbxXB2PC_NOP;                R:@BOOL2String),                  // Xbox = PC
    (S:'BYTE';                     F:@DxbxXB2PC_NOP),                                                 // Xbox = PC
    (S:'D3DBLEND';                 F:@EmuXB2PC_D3DBLEND;            R:@X_D3DBLEND2String),
    (S:'D3DBLENDOP';               F:@EmuXB2PC_D3DBLENDOP;          R:@X_D3DBLENDOP2String),
    (S:'D3DCLEAR';                 F:@EmuXB2PC_D3DCLEAR_FLAGS;      R:@X_D3DCLEAR2String),
    (S:'D3DCMPFUNC';               F:@EmuXB2PC_D3DCMPFUNC;          R:@X_D3DCMPFUNC2String),
    (S:'D3DCOLOR';                 F:@DxbxXB2PC_NOP),                                                 // Xbox = PC
    (S:'D3DCOLORWRITEENABLE';      F:@EmuXB2PC_D3DCOLORWRITEENABLE; R:@X_D3DCOLORWRITEENABLE2String),
    (S:'D3DCUBEMAP_FACES';         F:@DxbxXB2PC_NOP;                R:@X_D3DCUBEMAP_FACES2String),
    (S:'D3DCULL';                  F:@EmuXB2PC_D3DCULL;             R:@X_D3DCULL2String),
    (S:'D3DDCC';                   F:@DxbxXB2PC_NOP;                R:@X_D3DDCC2String;               X:True),
    (S:'D3DFILLMODE';              F:@EmuXB2PC_D3DFILLMODE;         R:@X_D3DFILLMODE2String),
    (S:'D3DFOGMODE';               F:@DxbxXB2PC_NOP;                R:@X_D3DFOGMODE2String),          // Xbox = PC
    (S:'D3DFORMAT';                F:@EmuXB2PC_D3DFormat;           R:@X_D3DFORMAT2String),
    (S:'D3DFRONT';                 F:@DxbxXB2PC_NOP;                R:@X_D3DFRONT2String;             X:True),
    (S:'D3DLOGICOP';               F:@DxbxXB2PC_NOP;                R:@X_D3DLOGICOP2String;           X:True),
    (S:'D3DMCS';                   F:@DxbxXB2PC_NOP;                R:@X_D3DMCS2String),              // Xbox = PC
    (S:'D3DMULTISAMPLE_TYPE';      F:@EmuXB2PC_D3DMULTISAMPLE_TYPE; R:@X_D3DMULTISAMPLE_TYPE2String),
    (S:'D3DMULTISAMPLEMODE';       F:@DxbxXB2PC_NOP;                R:@X_D3DMULTISAMPLEMODE2String;   X:True),
    (S:'D3DPRIMITIVETYPE';         F:@EmuXB2PC_D3DPrimitiveType;    R:@X_D3DPRIMITIVETYPE2String),
    (S:'D3DRESOURCETYPE';          F:@DxbxXB2PC_NOP;                R:@X_D3DRESOURCETYPE2String),
    (S:'D3DSAMPLEALPHA';           F:@DxbxXB2PC_NOP;                R:@X_D3DSAMPLEALPHA2String;       X:True),
    (S:'D3DSHADEMODE';             F:@EmuXB2PC_D3DSHADEMODE;        R:@X_D3DSHADEMODE2String),
    (S:'D3DSTENCILOP';             F:@EmuXB2PC_D3DSTENCILOP;        R:@X_D3DSTENCILOP2String),
    (S:'D3DSWATH';                 F:@DxbxXB2PC_NOP;                R:@X_D3DSWATH2String;             X:True),
    (S:'D3DTEXTUREADDRESS';        F:@EmuXB2PC_D3DTEXTUREADDRESS;   R:@X_D3DTEXTUREADDRESS2String),
    (S:'D3DTEXTUREFILTERTYPE';     F:@EmuXB2PC_D3DTEXTUREFILTERTYPE),
    (S:'D3DTEXTUREOP';             F:@EmuXB2PC_D3DTEXTUREOP;        R:@X_D3DTEXTUREOP2String),
    (S:'D3DTEXTURESTAGESTATETYPE'; F:@EmuXB2PC_D3DTSS;              R:@X_D3DTEXTURESTAGESTATETYPE2String),
    (S:'D3DTRANSFORMSTATETYPE';    F:@EmuXB2PC_D3DTS;               R:@X_D3DTRANSFORMSTATETYPE2String),
    (S:'D3DVERTEXBLENDFLAGS';      F:@EmuXB2PC_D3DVERTEXBLENDFLAGS; R:@X_D3DVERTEXBLENDFLAGS2String),
    (S:'D3DVSDE';                  F:@DxbxXB2PC_NOP;                R:@X_D3DVSDE2String),
    (S:'D3DWRAP';                  F:@EmuXB2PC_D3DWRAP;             R:@X_D3DWRAP2String),
    (S:'DWORD';                    F:@DxbxXB2PC_NOP),                                                 // Xbox = PC
    (S:'Float';                    F:@DxbxXB2PC_NOP;                R:@DWFloat2String),               // Xbox = PC
    (S:'LONG';                     F:@DxbxXB2PC_NOP)                                                  // Xbox = PC
  );

type
  RenderStateInfo = record
    S: string;  // String representation.
    V: Word;    // The XDK version since which a render state was introduced (using the 5911 declarations as a base).
    T: TXBType; // The Xbox data type. Defaults to xt_Unknown.
    M: DWORD;   // The related push buffer method. Not always a 1-to-1 mapping. Needs push-buffer interpretation & conversion code.
    PC:D3DRENDERSTATETYPE; // Map XBox to PC render state. Defaults to D3DRS_UNSUPPORTED.
    N: string;  // XDK notes. Defaults to ''.
  end;

const
  DxbxRenderStateInfo: array [X_D3DRS_FIRST..X_D3DRS_LAST] of RenderStateInfo = (
    //  String                                Ord   Version Type                     Method Native
    (S:'D3DRS_PSALPHAINPUTS0'              {=   0}; V:3424; T:xtDWORD;               M:NV2A_RC_IN_ALPHA__0),
    (S:'D3DRS_PSALPHAINPUTS1'              {=   1}; V:3424; T:xtDWORD;               M:NV2A_RC_IN_ALPHA__1),
    (S:'D3DRS_PSALPHAINPUTS2'              {=   2}; V:3424; T:xtDWORD;               M:NV2A_RC_IN_ALPHA__2),
    (S:'D3DRS_PSALPHAINPUTS3'              {=   3}; V:3424; T:xtDWORD;               M:NV2A_RC_IN_ALPHA__3),
    (S:'D3DRS_PSALPHAINPUTS4'              {=   4}; V:3424; T:xtDWORD;               M:NV2A_RC_IN_ALPHA__4),
    (S:'D3DRS_PSALPHAINPUTS5'              {=   5}; V:3424; T:xtDWORD;               M:NV2A_RC_IN_ALPHA__5),
    (S:'D3DRS_PSALPHAINPUTS6'              {=   6}; V:3424; T:xtDWORD;               M:NV2A_RC_IN_ALPHA__6),
    (S:'D3DRS_PSALPHAINPUTS7'              {=   7}; V:3424; T:xtDWORD;               M:NV2A_RC_IN_ALPHA__7),
    (S:'D3DRS_PSFINALCOMBINERINPUTSABCD'   {=   8}; V:3424; T:xtDWORD;               M:NV2A_RC_FINAL0),
    (S:'D3DRS_PSFINALCOMBINERINPUTSEFG'    {=   9}; V:3424; T:xtDWORD;               M:NV2A_RC_FINAL1),
    (S:'D3DRS_PSCONSTANT0_0'               {=  10}; V:3424; T:xtD3DCOLOR;            M:NV2A_RC_CONSTANT_COLOR0__0),
    (S:'D3DRS_PSCONSTANT0_1'               {=  11}; V:3424; T:xtD3DCOLOR;            M:$00000a64),
    (S:'D3DRS_PSCONSTANT0_2'               {=  12}; V:3424; T:xtD3DCOLOR;            M:$00000a68),
    (S:'D3DRS_PSCONSTANT0_3'               {=  13}; V:3424; T:xtD3DCOLOR;            M:$00000a6c),
    (S:'D3DRS_PSCONSTANT0_4'               {=  14}; V:3424; T:xtD3DCOLOR;            M:$00000a70),
    (S:'D3DRS_PSCONSTANT0_5'               {=  15}; V:3424; T:xtD3DCOLOR;            M:$00000a74),
    (S:'D3DRS_PSCONSTANT0_6'               {=  16}; V:3424; T:xtD3DCOLOR;            M:$00000a78),
    (S:'D3DRS_PSCONSTANT0_7'               {=  17}; V:3424; T:xtD3DCOLOR;            M:$00000a7c),
    (S:'D3DRS_PSCONSTANT1_0'               {=  18}; V:3424; T:xtD3DCOLOR;            M:$00000a80),
    (S:'D3DRS_PSCONSTANT1_1'               {=  19}; V:3424; T:xtD3DCOLOR;            M:$00000a84),
    (S:'D3DRS_PSCONSTANT1_2'               {=  20}; V:3424; T:xtD3DCOLOR;            M:$00000a88),
    (S:'D3DRS_PSCONSTANT1_3'               {=  21}; V:3424; T:xtD3DCOLOR;            M:$00000a8c),
    (S:'D3DRS_PSCONSTANT1_4'               {=  22}; V:3424; T:xtD3DCOLOR;            M:$00000a90),
    (S:'D3DRS_PSCONSTANT1_5'               {=  23}; V:3424; T:xtD3DCOLOR;            M:$00000a94),
    (S:'D3DRS_PSCONSTANT1_6'               {=  24}; V:3424; T:xtD3DCOLOR;            M:$00000a98),
    (S:'D3DRS_PSCONSTANT1_7'               {=  25}; V:3424; T:xtD3DCOLOR;            M:$00000a9c),
    (S:'D3DRS_PSALPHAOUTPUTS0'             {=  26}; V:3424; T:xtDWORD;               M:$00000aa0),
    (S:'D3DRS_PSALPHAOUTPUTS1'             {=  27}; V:3424; T:xtDWORD;               M:$00000aa4),
    (S:'D3DRS_PSALPHAOUTPUTS2'             {=  28}; V:3424; T:xtDWORD;               M:$00000aa8),
    (S:'D3DRS_PSALPHAOUTPUTS3'             {=  29}; V:3424; T:xtDWORD;               M:$00000aac),
    (S:'D3DRS_PSALPHAOUTPUTS4'             {=  30}; V:3424; T:xtDWORD;               M:$00000ab0),
    (S:'D3DRS_PSALPHAOUTPUTS5'             {=  31}; V:3424; T:xtDWORD;               M:$00000ab4),
    (S:'D3DRS_PSALPHAOUTPUTS6'             {=  32}; V:3424; T:xtDWORD;               M:$00000ab8),
    (S:'D3DRS_PSALPHAOUTPUTS7'             {=  33}; V:3424; T:xtDWORD;               M:$00000abc),
    (S:'D3DRS_PSRGBINPUTS0'                {=  34}; V:3424; T:xtDWORD;               M:$00000ac0),
    (S:'D3DRS_PSRGBINPUTS1'                {=  35}; V:3424; T:xtDWORD;               M:$00000ac4),
    (S:'D3DRS_PSRGBINPUTS2'                {=  36}; V:3424; T:xtDWORD;               M:$00000ac8),
    (S:'D3DRS_PSRGBINPUTS3'                {=  37}; V:3424; T:xtDWORD;               M:$00000acc),
    (S:'D3DRS_PSRGBINPUTS4'                {=  38}; V:3424; T:xtDWORD;               M:$00000ad0),
    (S:'D3DRS_PSRGBINPUTS5'                {=  39}; V:3424; T:xtDWORD;               M:$00000ad4),
    (S:'D3DRS_PSRGBINPUTS6'                {=  40}; V:3424; T:xtDWORD;               M:$00000ad8),
    (S:'D3DRS_PSRGBINPUTS7'                {=  41}; V:3424; T:xtDWORD;               M:$00000adc),
    (S:'D3DRS_PSCOMPAREMODE'               {=  42}; V:3424; T:xtDWORD;               M:NV2A_TX_SHADER_CULL_MODE),
    (S:'D3DRS_PSFINALCOMBINERCONSTANT0'    {=  43}; V:3424; T:xtDWORD;               M:NV2A_RC_COLOR0),
    (S:'D3DRS_PSFINALCOMBINERCONSTANT1'    {=  44}; V:3424; T:xtDWORD;               M:NV2A_RC_COLOR1),
    (S:'D3DRS_PSRGBOUTPUTS0'               {=  45}; V:3424; T:xtDWORD;               M:$00001e40),
    (S:'D3DRS_PSRGBOUTPUTS1'               {=  46}; V:3424; T:xtDWORD;               M:$00001e44),
    (S:'D3DRS_PSRGBOUTPUTS2'               {=  47}; V:3424; T:xtDWORD;               M:$00001e48),
    (S:'D3DRS_PSRGBOUTPUTS3'               {=  48}; V:3424; T:xtDWORD;               M:$00001e4c),
    (S:'D3DRS_PSRGBOUTPUTS4'               {=  49}; V:3424; T:xtDWORD;               M:$00001e50),
    (S:'D3DRS_PSRGBOUTPUTS5'               {=  50}; V:3424; T:xtDWORD;               M:$00001e54),
    (S:'D3DRS_PSRGBOUTPUTS6'               {=  51}; V:3424; T:xtDWORD;               M:$00001e58),
    (S:'D3DRS_PSRGBOUTPUTS7'               {=  52}; V:3424; T:xtDWORD;               M:$00001e5c),
    (S:'D3DRS_PSCOMBINERCOUNT'             {=  53}; V:3424; T:xtDWORD;               M:NV2A_RC_ENABLE),
    (S:'D3DRS_PS_RESERVED'                 {=  54}; V:3424; T:xtDWORD;               M:NV2A_NOP), // Dxbx note : This takes the slot of X_D3DPIXELSHADERDEF.PSTextureModes, set by D3DDevice_SetRenderState_LogicOp?
    (S:'D3DRS_PSDOTMAPPING'                {=  55}; V:3424; T:xtDWORD;               M:NV2A_TX_SHADER_DOTMAPPING),
    (S:'D3DRS_PSINPUTTEXTURE'              {=  56}; V:3424; T:xtDWORD;               M:NV2A_TX_SHADER_PREVIOUS),
    // End of "pixel-shader" render states, continuing with "simple" render states :
    (S:'D3DRS_ZFUNC'                       {=  57}; V:3424; T:xtD3DCMPFUNC;          M:NV2A_DEPTH_FUNC; PC:D3DRS_ZFUNC),
    (S:'D3DRS_ALPHAFUNC'                   {=  58}; V:3424; T:xtD3DCMPFUNC;          M:NV2A_ALPHA_FUNC_FUNC; PC:D3DRS_ALPHAFUNC),
    (S:'D3DRS_ALPHABLENDENABLE'            {=  59}; V:3424; T:xtBOOL;                M:NV2A_BLEND_FUNC_ENABLE; PC:D3DRS_ALPHABLENDENABLE; N:'TRUE to enable alpha blending'),
    (S:'D3DRS_ALPHATESTENABLE'             {=  60}; V:3424; T:xtBOOL;                M:NV2A_ALPHA_FUNC_ENABLE; PC:D3DRS_ALPHATESTENABLE; N:'TRUE to enable alpha tests'),
    (S:'D3DRS_ALPHAREF'                    {=  61}; V:3424; T:xtBYTE;                M:NV2A_ALPHA_FUNC_REF; PC:D3DRS_ALPHAREF),
    (S:'D3DRS_SRCBLEND'                    {=  62}; V:3424; T:xtD3DBLEND;            M:NV2A_BLEND_FUNC_SRC; PC:D3DRS_SRCBLEND),
    (S:'D3DRS_DESTBLEND'                   {=  63}; V:3424; T:xtD3DBLEND;            M:NV2A_BLEND_FUNC_DST; PC:D3DRS_DESTBLEND),
    (S:'D3DRS_ZWRITEENABLE'                {=  64}; V:3424; T:xtBOOL;                M:NV2A_DEPTH_WRITE_ENABLE; PC:D3DRS_ZWRITEENABLE; N:'TRUE to enable Z writes'),
    (S:'D3DRS_DITHERENABLE'                {=  65}; V:3424; T:xtBOOL;                M:NV2A_DITHER_ENABLE; PC:D3DRS_DITHERENABLE; N:'TRUE to enable dithering'),
    (S:'D3DRS_SHADEMODE'                   {=  66}; V:3424; T:xtD3DSHADEMODE;        M:NV2A_SHADE_MODEL; PC:D3DRS_SHADEMODE),
    (S:'D3DRS_COLORWRITEENABLE'            {=  67}; V:3424; T:xtD3DCOLORWRITEENABLE; M:NV2A_COLOR_MASK; PC:D3DRS_COLORWRITEENABLE), // *_ALPHA, etc. per-channel write enable
    (S:'D3DRS_STENCILZFAIL'                {=  68}; V:3424; T:xtD3DSTENCILOP;        M:NV2A_STENCIL_OP_ZFAIL; PC:D3DRS_STENCILZFAIL; N:'Operation to do if stencil test passes and Z test fails'),
    (S:'D3DRS_STENCILPASS'                 {=  69}; V:3424; T:xtD3DSTENCILOP;        M:NV2A_STENCIL_OP_ZPASS; PC:D3DRS_STENCILPASS; N:'Operation to do if both stencil and Z tests pass'),
    (S:'D3DRS_STENCILFUNC'                 {=  70}; V:3424; T:xtD3DCMPFUNC;          M:NV2A_STENCIL_FUNC_FUNC; PC:D3DRS_STENCILFUNC),
    (S:'D3DRS_STENCILREF'                  {=  71}; V:3424; T:xtBYTE;                M:NV2A_STENCIL_FUNC_REF; PC:D3DRS_STENCILREF; N:'BYTE reference value used in stencil test'),
    (S:'D3DRS_STENCILMASK'                 {=  72}; V:3424; T:xtBYTE;                M:NV2A_STENCIL_FUNC_MASK; PC:D3DRS_STENCILMASK; N:'BYTE mask value used in stencil test'),
    (S:'D3DRS_STENCILWRITEMASK'            {=  73}; V:3424; T:xtBYTE;                M:NV2A_STENCIL_MASK; PC:D3DRS_STENCILWRITEMASK; N:'BYTE write mask applied to values written to stencil buffer'),
    (S:'D3DRS_BLENDOP'                     {=  74}; V:3424; T:xtD3DBLENDOP;          M:NV2A_BLEND_EQUATION; PC:D3DRS_BLENDOP),
    (S:'D3DRS_BLENDCOLOR'                  {=  75}; V:3424; T:xtD3DCOLOR;            M:NV2A_BLEND_COLOR {$IFDEF DXBX_USE_D3D9}; PC:D3DRS_BLENDFACTOR{$ENDIF}; N:'D3DCOLOR for D3DBLEND_CONSTANTCOLOR'),
    // D3D9 D3DRS_BLENDFACTOR : D3DCOLOR used for a constant blend factor during alpha blending for devices that support D3DPBLENDCAPS_BLENDFACTOR
    (S:'D3DRS_SWATHWIDTH'                  {=  76}; V:3424; T:xtD3DSWATH;            M:NV2A_SWATH_WIDTH),
    (S:'D3DRS_POLYGONOFFSETZSLOPESCALE'    {=  77}; V:3424; T:xtFloat;               M:NV2A_POLYGON_OFFSET_FACTOR;  N:'float Z factor for shadow maps'),
    (S:'D3DRS_POLYGONOFFSETZOFFSET'        {=  78}; V:3424; T:xtFloat;               M:NV2A_POLYGON_OFFSET_UNITS),
    (S:'D3DRS_POINTOFFSETENABLE'           {=  79}; V:3424; T:xtBOOL;                M:NV2A_POLYGON_OFFSET_POINT_ENABLE),
    (S:'D3DRS_WIREFRAMEOFFSETENABLE'       {=  80}; V:3424; T:xtBOOL;                M:NV2A_POLYGON_OFFSET_LINE_ENABLE),
    (S:'D3DRS_SOLIDOFFSETENABLE'           {=  81}; V:3424; T:xtBOOL;                M:NV2A_POLYGON_OFFSET_FILL_ENABLE),
    (S:'D3DRS_DEPTHCLIPCONTROL'            {=  82}; V:4627; T:xtD3DDCC;              M:NV2A_DEPTHCLIPCONTROL),
    (S:'D3DRS_STIPPLEENABLE'               {=  83}; V:4627; T:xtBOOL;                M:NV2A_POLYGON_STIPPLE_ENABLE),
    (S:'D3DRS_SIMPLE_UNUSED8'              {=  84}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_SIMPLE_UNUSED7'              {=  85}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_SIMPLE_UNUSED6'              {=  86}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_SIMPLE_UNUSED5'              {=  87}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_SIMPLE_UNUSED4'              {=  88}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_SIMPLE_UNUSED3'              {=  89}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_SIMPLE_UNUSED2'              {=  90}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_SIMPLE_UNUSED1'              {=  91}; V:4627; T:xtDWORD;               M:0),
    // End of "simple" render states, continuing with "deferred" render states :
    (S:'D3DRS_FOGENABLE'                   {=  92}; V:3424; T:xtBOOL;                M:NV2A_FOG_ENABLE; PC:D3DRS_FOGENABLE),
    (S:'D3DRS_FOGTABLEMODE'                {=  93}; V:3424; T:xtD3DFOGMODE;          M:NV2A_FOG_MODE; PC:D3DRS_FOGTABLEMODE),
    (S:'D3DRS_FOGSTART'                    {=  94}; V:3424; T:xtFloat;               M:NV2A_FOG_COORD; PC:D3DRS_FOGSTART),
    (S:'D3DRS_FOGEND'                      {=  95}; V:3424; T:xtFloat;               M:NV2A_FOG_MODE; PC:D3DRS_FOGEND),
    (S:'D3DRS_FOGDENSITY'                  {=  96}; V:3424; T:xtFloat;               M:NV2A_FOG_EQUATION_CONSTANT; PC:D3DRS_FOGDENSITY), // + NV2A_FOG_EQUATION_LINEAR + NV2A_FOG_EQUATION_QUADRATIC
    (S:'D3DRS_RANGEFOGENABLE'              {=  97}; V:3424; T:xtBOOL;                M:NV2A_FOG_COORD; PC:D3DRS_RANGEFOGENABLE),
    (S:'D3DRS_WRAP0'                       {=  98}; V:3424; T:xtD3DWRAP;             M:NV2A_TX_WRAP__0; PC:D3DRS_WRAP0),
    (S:'D3DRS_WRAP1'                       {=  99}; V:3424; T:xtD3DWRAP;             M:NV2A_TX_WRAP__1; PC:D3DRS_WRAP1),
    (S:'D3DRS_WRAP2'                       {= 100}; V:3424; T:xtD3DWRAP;             M:NV2A_TX_WRAP__2; PC:D3DRS_WRAP2),
    (S:'D3DRS_WRAP3'                       {= 101}; V:3424; T:xtD3DWRAP;             M:NV2A_TX_WRAP__3; PC:D3DRS_WRAP3),
    (S:'D3DRS_LIGHTING'                    {= 102}; V:3424; T:xtBOOL;                M:NV2A_LIGHT_MODEL; PC:D3DRS_LIGHTING), // TODO : Needs push-buffer data conversion
    (S:'D3DRS_SPECULARENABLE'              {= 103}; V:3424; T:xtBOOL;                M:NV2A_RC_FINAL0; PC:D3DRS_SPECULARENABLE),
    (S:'D3DRS_LOCALVIEWER'                 {= 104}; V:3424; T:xtBOOL;                M:0; PC:D3DRS_LOCALVIEWER),
    (S:'D3DRS_COLORVERTEX'                 {= 105}; V:3424; T:xtBOOL;                M:0; PC:D3DRS_COLORVERTEX),
    (S:'D3DRS_BACKSPECULARMATERIALSOURCE'  {= 106}; V:3424; T:xtD3DMCS;              M:0), // nsp.
    (S:'D3DRS_BACKDIFFUSEMATERIALSOURCE'   {= 107}; V:3424; T:xtD3DMCS;              M:0), // nsp.
    (S:'D3DRS_BACKAMBIENTMATERIALSOURCE'   {= 108}; V:3424; T:xtD3DMCS;              M:0), // nsp.
    (S:'D3DRS_BACKEMISSIVEMATERIALSOURCE'  {= 109}; V:3424; T:xtD3DMCS;              M:0), // nsp.
    (S:'D3DRS_SPECULARMATERIALSOURCE'      {= 110}; V:3424; T:xtD3DMCS;              M:NV2A_COLOR_MATERIAL; PC:D3DRS_SPECULARMATERIALSOURCE),
    (S:'D3DRS_DIFFUSEMATERIALSOURCE'       {= 111}; V:3424; T:xtD3DMCS;              M:0; PC:D3DRS_DIFFUSEMATERIALSOURCE),
    (S:'D3DRS_AMBIENTMATERIALSOURCE'       {= 112}; V:3424; T:xtD3DMCS;              M:0; PC:D3DRS_AMBIENTMATERIALSOURCE),
    (S:'D3DRS_EMISSIVEMATERIALSOURCE'      {= 113}; V:3424; T:xtD3DMCS;              M:0; PC:D3DRS_EMISSIVEMATERIALSOURCE),
    (S:'D3DRS_BACKAMBIENT'                 {= 114}; V:3424; T:xtD3DCOLOR;            M:NV2A_LIGHT_MODEL_BACK_AMBIENT_R), // ..NV2A_MATERIAL_FACTOR_BACK_B nsp.
    (S:'D3DRS_AMBIENT'                     {= 115}; V:3424; T:xtD3DCOLOR;            M:NV2A_LIGHT_MODEL_FRONT_AMBIENT_R; PC:D3DRS_AMBIENT), // ..NV2A_LIGHT_MODEL_FRONT_AMBIENT_B + NV2A_MATERIAL_FACTOR_FRONT_R..NV2A_MATERIAL_FACTOR_FRONT_A
    (S:'D3DRS_POINTSIZE'                   {= 116}; V:3424; T:xtFloat;               M:NV2A_POINT_PARAMETER__0; PC:D3DRS_POINTSIZE),
    (S:'D3DRS_POINTSIZE_MIN'               {= 117}; V:3424; T:xtFloat;               M:0; PC:D3DRS_POINTSIZE_MIN),
    (S:'D3DRS_POINTSPRITEENABLE'           {= 118}; V:3424; T:xtBOOL;                M:NV2A_POINT_SMOOTH_ENABLE; PC:D3DRS_POINTSPRITEENABLE),
    (S:'D3DRS_POINTSCALEENABLE'            {= 119}; V:3424; T:xtBOOL;                M:NV2A_POINT_PARAMETERS_ENABLE; PC:D3DRS_POINTSCALEENABLE),
    (S:'D3DRS_POINTSCALE_A'                {= 120}; V:3424; T:xtFloat;               M:0; PC:D3DRS_POINTSCALE_A),
    (S:'D3DRS_POINTSCALE_B'                {= 121}; V:3424; T:xtFloat;               M:0; PC:D3DRS_POINTSCALE_B),
    (S:'D3DRS_POINTSCALE_C'                {= 122}; V:3424; T:xtFloat;               M:0; PC:D3DRS_POINTSCALE_C),
    (S:'D3DRS_POINTSIZE_MAX'               {= 123}; V:3424; T:xtFloat;               M:0; PC:D3DRS_POINTSIZE_MAX),
    (S:'D3DRS_PATCHEDGESTYLE'              {= 124}; V:3424; T:xtDWORD;               M:0; PC:D3DRS_PATCHEDGESTYLE), // D3DPATCHEDGESTYLE?
    (S:'D3DRS_PATCHSEGMENTS'               {= 125}; V:3424; T:xtDWORD;               M:0; PC:D3DRS_PATCHSEGMENTS),
    // TODO -oDxbx : Is X_D3DRS_SWAPFILTER really a xtD3DMULTISAMPLE_TYPE?
    (S:'D3DRS_SWAPFILTER'                  {= 126}; V:4361; T:xtD3DMULTISAMPLE_TYPE; M:0;  N:'D3DTEXF_LINEAR etc. filter to use for Swap'), // nsp.
    (S:'D3DRS_PRESENTATIONINTERVAL'        {= 127}; V:4627; T:xtDWORD;               M:0), // nsp.
    (S:'D3DRS_DEFERRED_UNUSED8'            {= 128}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_DEFERRED_UNUSED7'            {= 129}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_DEFERRED_UNUSED6'            {= 130}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_DEFERRED_UNUSED5'            {= 131}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_DEFERRED_UNUSED4'            {= 132}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_DEFERRED_UNUSED3'            {= 133}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_DEFERRED_UNUSED2'            {= 134}; V:4627; T:xtDWORD;               M:0),
    (S:'D3DRS_DEFERRED_UNUSED1'            {= 135}; V:4627; T:xtDWORD;               M:0),
    // End of "deferred" render states, continuing with "complex" render states :
    (S:'D3DRS_PSTEXTUREMODES'              {= 136}; V:3424; T:xtDWORD;               M:0),
    (S:'D3DRS_VERTEXBLEND'                 {= 137}; V:3424; T:xtD3DVERTEXBLENDFLAGS; M:NV2A_SKIN_MODE; PC:D3DRS_VERTEXBLEND),
    (S:'D3DRS_FOGCOLOR'                    {= 138}; V:3424; T:xtD3DCOLOR;            M:NV2A_FOG_COLOR; PC:D3DRS_FOGCOLOR), // SwapRgb
    (S:'D3DRS_FILLMODE'                    {= 139}; V:3424; T:xtD3DFILLMODE;         M:NV2A_POLYGON_MODE_FRONT; PC:D3DRS_FILLMODE),
    (S:'D3DRS_BACKFILLMODE'                {= 140}; V:3424; T:xtD3DFILLMODE;         M:0), // nsp.
    (S:'D3DRS_TWOSIDEDLIGHTING'            {= 141}; V:3424; T:xtBOOL;                M:NV2A_POLYGON_MODE_BACK), // nsp.
    (S:'D3DRS_NORMALIZENORMALS'            {= 142}; V:3424; T:xtBOOL;                M:NV2A_NORMALIZE_ENABLE; PC:D3DRS_NORMALIZENORMALS),
    (S:'D3DRS_ZENABLE'                     {= 143}; V:3424; T:xtBOOL;                M:NV2A_DEPTH_TEST_ENABLE; PC:D3DRS_ZENABLE), // D3DZBUFFERTYPE?
    (S:'D3DRS_STENCILENABLE'               {= 144}; V:3424; T:xtBOOL;                M:NV2A_STENCIL_ENABLE; PC:D3DRS_STENCILENABLE),
    (S:'D3DRS_STENCILFAIL'                 {= 145}; V:3424; T:xtD3DSTENCILOP;        M:NV2A_STENCIL_OP_FAIL; PC:D3DRS_STENCILFAIL),
    (S:'D3DRS_FRONTFACE'                   {= 146}; V:3424; T:xtD3DFRONT;            M:NV2A_FRONT_FACE), // nsp.
    (S:'D3DRS_CULLMODE'                    {= 147}; V:3424; T:xtD3DCULL;             M:NV2A_CULL_FACE; PC:D3DRS_CULLMODE),
    (S:'D3DRS_TEXTUREFACTOR'               {= 148}; V:3424; T:xtD3DCOLOR;            M:NV2A_RC_CONSTANT_COLOR0__0; PC:D3DRS_TEXTUREFACTOR),
    (S:'D3DRS_ZBIAS'                       {= 149}; V:3424; T:xtLONG;                M:0; PC:{$IFDEF DXBX_USE_D3D9}D3DRS_DEPTHBIAS{$ELSE}D3DRS_ZBIAS{$ENDIF}),
    (S:'D3DRS_LOGICOP'                     {= 150}; V:3424; T:xtD3DLOGICOP;          M:NV2A_COLOR_LOGIC_OP_OP), // nsp.
    (S:'D3DRS_EDGEANTIALIAS'               {= 151}; V:3424; T:xtBOOL;                M:NV2A_LINE_SMOOTH_ENABLE; PC:{$IFDEF DXBX_USE_D3D9}D3DRS_ANTIALIASEDLINEENABLE{$ELSE}D3DRS_EDGEANTIALIAS{$ENDIF}), // Dxbx note : No Xbox ext. (according to Direct3D8) !
    (S:'D3DRS_MULTISAMPLEANTIALIAS'        {= 152}; V:3424; T:xtBOOL;                M:NV2A_MULTISAMPLE_CONTROL; PC:D3DRS_MULTISAMPLEANTIALIAS),
    (S:'D3DRS_MULTISAMPLEMASK'             {= 153}; V:3424; T:xtDWORD;               M:NV2A_MULTISAMPLE_CONTROL; PC:D3DRS_MULTISAMPLEMASK),
//  (S:'D3DRS_MULTISAMPLETYPE'             {= 154}; V:3424; T:xtD3DMULTISAMPLE_TYPE; M:0), // [-3911] \_ aliasses  D3DMULTISAMPLE_TYPE
    (S:'D3DRS_MULTISAMPLEMODE'             {= 154}; V:4361; T:xtD3DMULTISAMPLEMODE;  M:0), // [4361+] /            D3DMULTISAMPLEMODE for the backbuffer
    (S:'D3DRS_MULTISAMPLERENDERTARGETMODE' {= 155}; V:4242; T:xtD3DMULTISAMPLEMODE;  M:NV2A_RT_FORMAT),
    (S:'D3DRS_SHADOWFUNC'                  {= 156}; V:3424; T:xtD3DCMPFUNC;          M:NV2A_TX_RCOMP),
    (S:'D3DRS_LINEWIDTH'                   {= 157}; V:3424; T:xtFloat;               M:NV2A_LINE_WIDTH),
    (S:'D3DRS_SAMPLEALPHA'                 {= 158}; V:4627; T:xtD3DSAMPLEALPHA;      M:0), // TODO : Later than 3424, but earlier then 4627?
    (S:'D3DRS_DXT1NOISEENABLE'             {= 159}; V:3424; T:xtBOOL;                M:NV2A_CLEAR_DEPTH_VALUE),
    (S:'D3DRS_YUVENABLE'                   {= 160}; V:3911; T:xtBOOL;                M:NV2A_CONTROL0),
    (S:'D3DRS_OCCLUSIONCULLENABLE'         {= 161}; V:3911; T:xtBOOL;                M:NV2A_OCCLUDE_ZSTENCIL_EN),
    (S:'D3DRS_STENCILCULLENABLE'           {= 162}; V:3911; T:xtBOOL;                M:NV2A_OCCLUDE_ZSTENCIL_EN),
    (S:'D3DRS_ROPZCMPALWAYSREAD'           {= 163}; V:3911; T:xtBOOL;                M:0),
    (S:'D3DRS_ROPZREAD'                    {= 164}; V:3911; T:xtBOOL;                M:0),
    (S:'D3DRS_DONOTCULLUNCOMPRESSED'       {= 165}; V:3911; T:xtBOOL;                M:0)
  );
(* Direct3D8 states unused :
    D3DRS_LINEPATTERN
    D3DRS_LASTPIXEL
    D3DRS_ZVISIBLE
    D3DRS_WRAP4
    D3DRS_WRAP5
    D3DRS_WRAP6
    D3DRS_WRAP7
    D3DRS_CLIPPING
    D3DRS_FOGVERTEXMODE
    D3DRS_CLIPPLANEENABLE
    D3DRS_SOFTWAREVERTEXPROCESSING
    D3DRS_DEBUGMONITORTOKEN
    D3DRS_INDEXEDVERTEXBLENDENABLE
    D3DRS_TWEENFACTOR
    D3DRS_POSITIONORDER
    D3DRS_NORMALORDER

 Direct3D9 states unused :
    D3DRS_SCISSORTESTENABLE         = 174,
    D3DRS_SLOPESCALEDEPTHBIAS       = 175,
    D3DRS_ANTIALIASEDLINEENABLE     = 176,
    D3DRS_MINTESSELLATIONLEVEL      = 178,
    D3DRS_MAXTESSELLATIONLEVEL      = 179,
    D3DRS_ADAPTIVETESS_X            = 180,
    D3DRS_ADAPTIVETESS_Y            = 181,
    D3DRS_ADAPTIVETESS_Z            = 182,
    D3DRS_ADAPTIVETESS_W            = 183,
    D3DRS_ENABLEADAPTIVETESSELLATION = 184,
    D3DRS_TWOSIDEDSTENCILMODE       = 185,   // BOOL enable/disable 2 sided stenciling
    D3DRS_CCW_STENCILFAIL           = 186,   // D3DSTENCILOP to do if ccw stencil test fails
    D3DRS_CCW_STENCILZFAIL          = 187,   // D3DSTENCILOP to do if ccw stencil test passes and Z test fails
    D3DRS_CCW_STENCILPASS           = 188,   // D3DSTENCILOP to do if both ccw stencil and Z tests pass
    D3DRS_CCW_STENCILFUNC           = 189,   // D3DCMPFUNC fn.  ccw Stencil Test passes if ((ref & mask) stencilfn (stencil & mask)) is true
    D3DRS_COLORWRITEENABLE1         = 190,   // Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS
    D3DRS_COLORWRITEENABLE2         = 191,   // Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS
    D3DRS_COLORWRITEENABLE3         = 192,   // Additional ColorWriteEnables for the devices that support D3DPMISCCAPS_INDEPENDENTWRITEMASKS
    D3DRS_SRGBWRITEENABLE           = 194,   // Enable rendertarget writes to be DE-linearized to SRGB (for formats that expose D3DUSAGE_QUERY_SRGBWRITE)
    D3DRS_DEPTHBIAS                 = 195,
    D3DRS_WRAP8                     = 198,   // Additional wrap states for vs_3_0+ attributes with D3DDECLUSAGE_TEXCOORD
    D3DRS_WRAP9                     = 199,
    D3DRS_WRAP10                    = 200,
    D3DRS_WRAP11                    = 201,
    D3DRS_WRAP12                    = 202,
    D3DRS_WRAP13                    = 203,
    D3DRS_WRAP14                    = 204,
    D3DRS_WRAP15                    = 205,
    D3DRS_SEPARATEALPHABLENDENABLE  = 206,  // TRUE to enable a separate blending function for the alpha channel
    D3DRS_SRCBLENDALPHA             = 207,  // SRC blend factor for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE
    D3DRS_DESTBLENDALPHA            = 208,  // DST blend factor for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE
    D3DRS_BLENDOPALPHA              = 209   // Blending operation for the alpha channel when D3DRS_SEPARATEDESTALPHAENABLE is TRUE
*)

type
  TextureStageStateInfo = record
    S: string;  // String representation.
    T: TXBType; // The Xbox data type. Defaults to xt_Unknown.
    X: Boolean; // True when a texture stage state is an xbox-extension (compared to native Direct3D8). Defaults to False.
    PC:TD3DSamplerStateType; // Map XBox to PC texture stage state. Defaults to D3DSAMP_UNSUPPORTED.
  end;

const
  DxbxTextureStageStateInfo: array [X_D3DTSS_FIRST..X_D3DTSS_UNSUPPORTED] of TextureStageStateInfo = (
    //  String                         Ord   Type                            XboxExt? Native
    (S:'D3DTSS_ADDRESSU'              {= 0}; T:xtD3DTEXTUREADDRESS;          X:False; PC:D3DSAMP_ADDRESSU),
    (S:'D3DTSS_ADDRESSV'              {= 1}; T:xtD3DTEXTUREADDRESS;          X:False; PC:D3DSAMP_ADDRESSV),
    (S:'D3DTSS_ADDRESSW'              {= 2}; T:xtD3DTEXTUREADDRESS;          X:False; PC:D3DSAMP_ADDRESSW),
    (S:'D3DTSS_MAGFILTER'             {= 3}; T:xtD3DTEXTUREFILTERTYPE;       X:False; PC:D3DSAMP_MAGFILTER),
    (S:'D3DTSS_MINFILTER'             {= 4}; T:xtD3DTEXTUREFILTERTYPE;       X:False; PC:D3DSAMP_MINFILTER),
    (S:'D3DTSS_MIPFILTER'             {= 5}; T:xtD3DTEXTUREFILTERTYPE;       X:False; PC:D3DSAMP_MIPFILTER),
    (S:'D3DTSS_MIPMAPLODBIAS'         {= 6}; T:xtFloat;                      X:False; PC:D3DSAMP_MIPMAPLODBIAS),
    (S:'D3DTSS_MAXMIPLEVEL'           {= 7}; T:xtDWORD;                      X:False; PC:D3DSAMP_MAXMIPLEVEL),
    (S:'D3DTSS_MAXANISOTROPY'         {= 8}; T:xtDWORD;                      X:False; PC:D3DSAMP_MAXANISOTROPY),
    (S:'D3DTSS_COLORKEYOP'            {= 9}; {T:xtD3DTEXTURECOLORKEYOP;}     X:True),
    (S:'D3DTSS_COLORSIGN'             {=10}; {T:xtD3DTSIGN;}                 X:True),
    (S:'D3DTSS_ALPHAKILL'             {=11}; {T:xtD3DTEXTUREALPHAKILL;}      X:True),
    (S:'D3DTSS_COLOROP'               {=12}; T:xtD3DTEXTUREOP;               X:False; PC:TD3DSamplerStateType(D3DTSS_COLOROP)),
    (S:'D3DTSS_COLORARG0'             {=13}; {T:xtD3DTA;}                    X:False; PC:TD3DSamplerStateType(D3DTSS_COLORARG0)),
    (S:'D3DTSS_COLORARG1'             {=14}; {T:xtD3DTA;}                    X:False; PC:TD3DSamplerStateType(D3DTSS_COLORARG1)),
    (S:'D3DTSS_COLORARG2'             {=15}; {T:xtD3DTA;}                    X:False; PC:TD3DSamplerStateType(D3DTSS_COLORARG2)),
    (S:'D3DTSS_ALPHAOP'               {=16}; T:xtD3DTEXTUREOP;               X:False; PC:TD3DSamplerStateType(D3DTSS_ALPHAOP)),
    (S:'D3DTSS_ALPHAARG0'             {=17}; {T:xtD3DTA;}                    X:False; PC:TD3DSamplerStateType(D3DTSS_ALPHAARG0)),
    (S:'D3DTSS_ALPHAARG1'             {=18}; {T:xtD3DTA;}                    X:False; PC:TD3DSamplerStateType(D3DTSS_ALPHAARG1)),
    (S:'D3DTSS_ALPHAARG2'             {=19}; {T:xtD3DTA;}                    X:False; PC:TD3DSamplerStateType(D3DTSS_ALPHAARG2)),
    (S:'D3DTSS_RESULTARG'             {=20}; {T:xtD3DTA;}                    X:False; PC:TD3DSamplerStateType(D3DTSS_RESULTARG)),
    (S:'D3DTSS_TEXTURETRANSFORMFLAGS' {=21}; {T:xtD3DTEXTURETRANSFORMFLAGS;} X:False; PC:TD3DSamplerStateType(D3DTSS_TEXTURETRANSFORMFLAGS)),
    // End of "deferred" texture states, continuing with the rest :
    (S:'D3DTSS_BUMPENVMAT00'          {=22}; T:xtFloat;                      X:False; PC:TD3DSamplerStateType(D3DTSS_BUMPENVMAT00)),
    (S:'D3DTSS_BUMPENVMAT01'          {=23}; T:xtFloat;                      X:False; PC:TD3DSamplerStateType(D3DTSS_BUMPENVMAT01)),
    (S:'D3DTSS_BUMPENVMAT11'          {=24}; T:xtFloat;                      X:False; PC:TD3DSamplerStateType(D3DTSS_BUMPENVMAT10)),
    (S:'D3DTSS_BUMPENVMAT10'          {=25}; T:xtFloat;                      X:False; PC:TD3DSamplerStateType(D3DTSS_BUMPENVMAT11)),
    (S:'D3DTSS_BUMPENVLSCALE'         {=26}; T:xtFloat;                      X:False; PC:TD3DSamplerStateType(D3DTSS_BUMPENVLSCALE)),
    (S:'D3DTSS_BUMPENVLOFFSET'        {=27}; T:xtFloat;                      X:False; PC:TD3DSamplerStateType(D3DTSS_BUMPENVLOFFSET)),
    (S:'D3DTSS_TEXCOORDINDEX'         {=28}; {T:xtD3DTSS_TCI;}               X:False; PC:TD3DSamplerStateType(D3DTSS_TEXCOORDINDEX)),
    (S:'D3DTSS_BORDERCOLOR'           {=29}; T:xtD3DCOLOR;                   X:False; PC:D3DSAMP_BORDERCOLOR),
    (S:'D3DTSS_COLORKEYCOLOR'         {=30}; T:xtD3DCOLOR;                   X:True),
    (S:'unsupported'                  {=31}; T:xtDWORD;                      X:True)
  );

implementation

// TODO : Add DxbxDevCapsToString(D3DDEVCAPS) // DevCaps

// TODO : Add DxbxPrimitiveMiscCapsToString(D3DPMISCCAPS) // PrimitiveMiscCaps

function DxbxLineCapsToString(const LineCaps: DWORD): string; // LineCaps
begin
  if LineCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DLINECAPS';
  if (LineCaps and D3DLINECAPS_TEXTURE) > 0 then Result := Result + '.TEXTURE';
  if (LineCaps and D3DLINECAPS_ZTEST) > 0 then Result := Result + '.ZTEST';
  if (LineCaps and D3DLINECAPS_BLEND) > 0 then Result := Result + '.BLEND';
  if (LineCaps and D3DLINECAPS_ALPHACMP) > 0 then Result := Result + '.ALPHACMP';
  if (LineCaps and D3DLINECAPS_FOG) > 0 then Result := Result + '.FOG';
{$IFDEF DXBX_USE_D3D9}
  if (LineCaps and D3DLINECAPS_ANTIALIAS) > 0 then Result := Result + '.ANTIALIAS';
{$ENDIF}
end;

function DxbxRasterCapsToString(const RasterCaps: DWORD): string; // RasterCaps
begin
  if RasterCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DPRASTERCAPS';
  if (RasterCaps and D3DPRASTERCAPS_DITHER) > 0 then Result := Result + '.DITHER';
  if (RasterCaps and D3DPRASTERCAPS_ZTEST) > 0 then Result := Result + '.ZTEST';
  if (RasterCaps and D3DPRASTERCAPS_FOGVERTEX) > 0 then Result := Result + '.FOGVERTEX';
  if (RasterCaps and D3DPRASTERCAPS_FOGTABLE) > 0 then Result := Result + '.FOGTABLE';
  if (RasterCaps and D3DPRASTERCAPS_MIPMAPLODBIAS) > 0 then Result := Result + '.MIPMAPLODBIAS';
  if (RasterCaps and D3DPRASTERCAPS_ZBUFFERLESSHSR) > 0 then Result := Result + '.ZBUFFERLESSHSR';
  if (RasterCaps and D3DPRASTERCAPS_FOGRANGE) > 0 then Result := Result + '.FOGRANGE';
  if (RasterCaps and D3DPRASTERCAPS_ANISOTROPY) > 0 then Result := Result + '.ANISOTROPY';
  if (RasterCaps and D3DPRASTERCAPS_WBUFFER) > 0 then Result := Result + '.WBUFFER';
  if (RasterCaps and D3DPRASTERCAPS_WFOG) > 0 then Result := Result + '.WFOG';
  if (RasterCaps and D3DPRASTERCAPS_ZFOG) > 0 then Result := Result + '.ZFOG';
  if (RasterCaps and D3DPRASTERCAPS_COLORPERSPECTIVE) > 0 then Result := Result + '.COLORPERSPECTIVE';
{$IFNDEF DXBX_USE_D3D9}
  if (RasterCaps and D3DPRASTERCAPS_PAT) > 0 then Result := Result + '.PAT';
  if (RasterCaps and D3DPRASTERCAPS_ANTIALIASEDGES) > 0 then Result := Result + '.ANTIALIASEDGES';
  if (RasterCaps and D3DPRASTERCAPS_ZBIAS) > 0 then Result := Result + '.ZBIAS';
  if (RasterCaps and D3DPRASTERCAPS_STRETCHBLTMULTISAMPLE) > 0 then Result := Result + '.STRETCHBLTMULTISAMPLE';
{$ELSE}
  if (RasterCaps and D3DPRASTERCAPS_SCISSORTEST) > 0 then Result := Result + '.SCISSORTEST';
  if (RasterCaps and D3DPRASTERCAPS_SLOPESCALEDEPTHBIAS) > 0 then Result := Result + '.SLOPESCALEDEPTHBIAS';
  if (RasterCaps and D3DPRASTERCAPS_DEPTHBIAS) > 0 then Result := Result + '.DEPTHBIAS';
  if (RasterCaps and D3DPRASTERCAPS_MULTISAMPLE_TOGGLE) > 0 then Result := Result + '.MULTISAMPLE_TOGGLE';
{$ENDIF}
end;

function DxbxCmpCapsToString(const CmpCaps: DWORD): string; // ZCmpCaps, AlphaCmpCaps
begin
  if CmpCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DPCMPCAPS';
  if (CmpCaps and D3DPCMPCAPS_NEVER) > 0 then Result := Result + '.NEVER';
  if (CmpCaps and D3DPCMPCAPS_LESS) > 0 then Result := Result + '.LESS';
  if (CmpCaps and D3DPCMPCAPS_EQUAL) > 0 then Result := Result + '.EQUAL';
  if (CmpCaps and D3DPCMPCAPS_LESSEQUAL) > 0 then Result := Result + '.LESSEQUAL';
  if (CmpCaps and D3DPCMPCAPS_GREATER) > 0 then Result := Result + '.GREATER';
  if (CmpCaps and D3DPCMPCAPS_NOTEQUAL) > 0 then Result := Result + '.NOTEQUAL';
  if (CmpCaps and D3DPCMPCAPS_GREATEREQUAL) > 0 then Result := Result + '.GREATEREQUAL';
  if (CmpCaps and D3DPCMPCAPS_ALWAYS) > 0 then Result := Result + '.ALWAYS';
end;

function DxbxBlendCapsToString(const BlendCaps: DWORD): string; // SourceBlendCaps, DestBlendCaps
begin
  if BlendCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DPBLENDCAPS';
  if (BlendCaps and D3DPBLENDCAPS_ZERO) > 0 then Result := Result + '.ZERO';
  if (BlendCaps and D3DPBLENDCAPS_ONE) > 0 then Result := Result + '.ONE';
  if (BlendCaps and D3DPBLENDCAPS_SRCCOLOR) > 0 then Result := Result + '.SRCCOLOR';
  if (BlendCaps and D3DPBLENDCAPS_INVSRCCOLOR) > 0 then Result := Result + '.INVSRCCOLOR';
  if (BlendCaps and D3DPBLENDCAPS_SRCALPHA) > 0 then Result := Result + '.SRCALPHA';
  if (BlendCaps and D3DPBLENDCAPS_INVSRCALPHA) > 0 then Result := Result + '.INVSRCALPHA';
  if (BlendCaps and D3DPBLENDCAPS_DESTALPHA) > 0 then Result := Result + '.DESTALPHA';
  if (BlendCaps and D3DPBLENDCAPS_INVDESTALPHA) > 0 then Result := Result + '.INVDESTALPHA';
  if (BlendCaps and D3DPBLENDCAPS_DESTCOLOR) > 0 then Result := Result + '.DESTCOLOR';
  if (BlendCaps and D3DPBLENDCAPS_INVDESTCOLOR) > 0 then Result := Result + '.INVDESTCOLOR';
  if (BlendCaps and D3DPBLENDCAPS_SRCALPHASAT) > 0 then Result := Result + '.SRCALPHASAT';
  if (BlendCaps and D3DPBLENDCAPS_BOTHSRCALPHA) > 0 then Result := Result + '.BOTHSRCALPHA';
  if (BlendCaps and D3DPBLENDCAPS_BOTHINVSRCALPHA) > 0 then Result := Result + '.BOTHINVSRCALPHA';
{$IFDEF DXBX_USE_D3D9}
  if (BlendCaps and D3DPBLENDCAPS_BLENDFACTOR) > 0 then Result := Result + '.BLENDFACTOR';
{$ENDIF}
end;

function DxbxShadeCapsToString(const ShadeCaps: DWORD): string; // ShadeCaps
begin
  if ShadeCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DPSHADECAPS';
  if (ShadeCaps and D3DPSHADECAPS_COLORGOURAUDRGB) > 0 then Result := Result + '.COLORGOURAUDRGB';
  if (ShadeCaps and D3DPSHADECAPS_SPECULARGOURAUDRGB) > 0 then Result := Result + '.SPECULARGOURAUDRGB';
  if (ShadeCaps and D3DPSHADECAPS_ALPHAGOURAUDBLEND) > 0 then Result := Result + '.ALPHAGOURAUDBLEND';
  if (ShadeCaps and D3DPSHADECAPS_FOGGOURAUD) > 0 then Result := Result + '.FOGGOURAUD';
end;

function DxbxTextureCapsToString(const TextureCaps: DWORD): string; // TextureCaps
begin
  if TextureCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DPTEXTURECAPS';
  if (TextureCaps and D3DPTEXTURECAPS_PERSPECTIVE) > 0 then Result := Result + '.PERSPECTIVE';
  if (TextureCaps and D3DPTEXTURECAPS_POW2) > 0 then Result := Result + '.POW2';
  if (TextureCaps and D3DPTEXTURECAPS_ALPHA) > 0 then Result := Result + '.ALPHA';
  if (TextureCaps and D3DPTEXTURECAPS_SQUAREONLY) > 0 then Result := Result + '.SQUAREONLY';
  if (TextureCaps and D3DPTEXTURECAPS_TEXREPEATNOTSCALEDBYSIZE) > 0 then Result := Result + '.TEXREPEATNOTSCALEDBYSIZE';
  if (TextureCaps and D3DPTEXTURECAPS_ALPHAPALETTE) > 0 then Result := Result + '.ALPHAPALETTE';
  if (TextureCaps and D3DPTEXTURECAPS_NONPOW2CONDITIONAL) > 0 then Result := Result + '.NONPOW2CONDITIONAL';
  if (TextureCaps and D3DPTEXTURECAPS_PROJECTED) > 0 then Result := Result + '.PROJECTED';
  if (TextureCaps and D3DPTEXTURECAPS_CUBEMAP) > 0 then Result := Result + '.CUBEMAP';
  if (TextureCaps and D3DPTEXTURECAPS_VOLUMEMAP) > 0 then Result := Result + '.VOLUMEMAP';
  if (TextureCaps and D3DPTEXTURECAPS_MIPMAP) > 0 then Result := Result + '.MIPMAP';
  if (TextureCaps and D3DPTEXTURECAPS_MIPVOLUMEMAP) > 0 then Result := Result + '.MIPVOLUMEMAP';
  if (TextureCaps and D3DPTEXTURECAPS_MIPCUBEMAP) > 0 then Result := Result + '.MIPCUBEMAP';
  if (TextureCaps and D3DPTEXTURECAPS_CUBEMAP_POW2) > 0 then Result := Result + '.CUBEMAP_POW2';
  if (TextureCaps and D3DPTEXTURECAPS_VOLUMEMAP_POW2) > 0 then Result := Result + '.VOLUMEMAP_POW2';
{$IFDEF DXBX_USE_D3D9}
  if (TextureCaps and D3DPTEXTURECAPS_NOPROJECTEDBUMPENV) > 0 then Result := Result + '.NOPROJECTEDBUMPENV';
{$ENDIF}
end;

function DxbxTextureFilterCapsToString(const TextureFilterCaps: DWORD): string; // TextureFilterCaps
begin
  if TextureFilterCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DPTFILTERCAPS';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MINFPOINT) > 0 then Result := Result + '.MINFPOINT';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MINFLINEAR) > 0 then Result := Result + '.MINFLINEAR';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MINFANISOTROPIC) > 0 then Result := Result + '.MINFANISOTROPIC';
{$IFDEF DXBX_USE_D3D9}
  if (TextureFilterCaps and D3DPTFILTERCAPS_MINFPYRAMIDALQUAD) > 0 then Result := Result + '.MINFPYRAMIDALQUAD';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MINFGAUSSIANQUAD) > 0 then Result := Result + '.MINFGAUSSIANQUAD';
{$ENDIF}
  if (TextureFilterCaps and D3DPTFILTERCAPS_MIPFPOINT) > 0 then Result := Result + '.MIPFPOINT';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MIPFLINEAR) > 0 then Result := Result + '.MIPFLINEAR';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MAGFPOINT) > 0 then Result := Result + '.MAGFPOINT';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MAGFLINEAR) > 0 then Result := Result + '.MAGFLINEAR';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MAGFANISOTROPIC) > 0 then Result := Result + '.MAGFANISOTROPIC';
{$IFNDEF DXBX_USE_D3D9}
  if (TextureFilterCaps and D3DPTFILTERCAPS_MAGFAFLATCUBIC) > 0 then Result := Result + '.MAGFAFLATCUBIC';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MAGFGAUSSIANCUBIC) > 0 then Result := Result + '.MAGFGAUSSIANCUBIC';
{$ELSE}
  if (TextureFilterCaps and D3DPTFILTERCAPS_MAGFPYRAMIDALQUAD) > 0 then Result := Result + '.MAGFPYRAMIDALQUAD';
  if (TextureFilterCaps and D3DPTFILTERCAPS_MAGFGAUSSIANQUAD) > 0 then Result := Result + '.MAGFGAUSSIANQUAD';
{$ENDIF}
end;

function DxbxTextureAddressCapsToString(const TextureAddressCaps: DWORD): string; // TextureAddressCaps
begin
  if TextureAddressCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DPTADDRESSCAPS';
  if (TextureAddressCaps and D3DPTADDRESSCAPS_WRAP) > 0 then Result := Result + '.WRAP';
  if (TextureAddressCaps and D3DPTADDRESSCAPS_MIRROR) > 0 then Result := Result + '.MIRROR';
  if (TextureAddressCaps and D3DPTADDRESSCAPS_CLAMP) > 0 then Result := Result + '.CLAMP';
  if (TextureAddressCaps and D3DPTADDRESSCAPS_BORDER) > 0 then Result := Result + '.BORDER';
  if (TextureAddressCaps and D3DPTADDRESSCAPS_INDEPENDENTUV) > 0 then Result := Result + '.INDEPENDENTUV';
  if (TextureAddressCaps and D3DPTADDRESSCAPS_MIRRORONCE) > 0 then Result := Result + '.MIRRORONCE';
end;

function DxbxStencilCapsToString(const StencilCaps: DWORD): string; // StencilCaps
begin
  if StencilCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DSTENCILCAPS';
  if (StencilCaps and D3DSTENCILCAPS_KEEP) > 0 then Result := Result + '.KEEP';
  if (StencilCaps and D3DSTENCILCAPS_ZERO) > 0 then Result := Result + '.ZERO';
  if (StencilCaps and D3DSTENCILCAPS_REPLACE) > 0 then Result := Result + '.REPLACE';
  if (StencilCaps and D3DSTENCILCAPS_INCRSAT) > 0 then Result := Result + '.INCRSAT';
  if (StencilCaps and D3DSTENCILCAPS_DECRSAT) > 0 then Result := Result + '.DECRSAT';
  if (StencilCaps and D3DSTENCILCAPS_INVERT) > 0 then Result := Result + '.INVERT';
  if (StencilCaps and D3DSTENCILCAPS_INCR) > 0 then Result := Result + '.INCR';
  if (StencilCaps and D3DSTENCILCAPS_DECR) > 0 then Result := Result + '.DECR';
{$IFDEF DXBX_USE_D3D9}
  if (StencilCaps and D3DSTENCILCAPS_TWOSIDED) > 0 then Result := Result + '.TWOSIDED';
{$ENDIF}
end;

function DxbxTextureOpCapsToString(const TextureOpCaps: DWORD): string; // TextureOpCaps
begin
  if TextureOpCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DSTENCILCAPS';
  if (TextureOpCaps and D3DTEXOPCAPS_DISABLE) > 0 then Result := Result + '.DISABLE';
  if (TextureOpCaps and D3DTEXOPCAPS_SELECTARG1) > 0 then Result := Result + '.SELECTARG1';
  if (TextureOpCaps and D3DTEXOPCAPS_SELECTARG2) > 0 then Result := Result + '.SELECTARG2';
  if (TextureOpCaps and D3DTEXOPCAPS_MODULATE) > 0 then Result := Result + '.MODULATE';
  if (TextureOpCaps and D3DTEXOPCAPS_MODULATE2X) > 0 then Result := Result + '.MODULATE2X';
  if (TextureOpCaps and D3DTEXOPCAPS_MODULATE4X) > 0 then Result := Result + '.MODULATE4X';
  if (TextureOpCaps and D3DTEXOPCAPS_ADD) > 0 then Result := Result + '.ADD';
  if (TextureOpCaps and D3DTEXOPCAPS_ADDSIGNED) > 0 then Result := Result + '.ADDSIGNED';
  if (TextureOpCaps and D3DTEXOPCAPS_ADDSIGNED2X) > 0 then Result := Result + '.ADDSIGNED2X';
  if (TextureOpCaps and D3DTEXOPCAPS_SUBTRACT) > 0 then Result := Result + '.SUBTRACT';
  if (TextureOpCaps and D3DTEXOPCAPS_ADDSMOOTH) > 0 then Result := Result + '.ADDSMOOTH';
  if (TextureOpCaps and D3DTEXOPCAPS_BLENDDIFFUSEALPHA) > 0 then Result := Result + '.BLENDDIFFUSEALPHA';
  if (TextureOpCaps and D3DTEXOPCAPS_BLENDTEXTUREALPHA) > 0 then Result := Result + '.BLENDTEXTUREALPHA';
  if (TextureOpCaps and D3DTEXOPCAPS_BLENDFACTORALPHA) > 0 then Result := Result + '.BLENDFACTORALPHA';
  if (TextureOpCaps and D3DTEXOPCAPS_BLENDTEXTUREALPHAPM) > 0 then Result := Result + '.BLENDTEXTUREALPHAPM';
  if (TextureOpCaps and D3DTEXOPCAPS_BLENDCURRENTALPHA) > 0 then Result := Result + '.BLENDCURRENTALPHA';
  if (TextureOpCaps and D3DTEXOPCAPS_PREMODULATE) > 0 then Result := Result + '.PREMODULATE';
  if (TextureOpCaps and D3DTEXOPCAPS_MODULATEALPHA_ADDCOLOR) > 0 then Result := Result + '.MODULATEALPHA_ADDCOLOR';
  if (TextureOpCaps and D3DTEXOPCAPS_MODULATECOLOR_ADDALPHA) > 0 then Result := Result + '.MODULATECOLOR_ADDALPHA';
  if (TextureOpCaps and D3DTEXOPCAPS_MODULATEINVALPHA_ADDCOLOR) > 0 then Result := Result + '.MODULATEINVALPHA_ADDCOLOR';
  if (TextureOpCaps and D3DTEXOPCAPS_MODULATEINVCOLOR_ADDALPHA) > 0 then Result := Result + '.MODULATEINVCOLOR_ADDALPHA';
  if (TextureOpCaps and D3DTEXOPCAPS_BUMPENVMAP) > 0 then Result := Result + '.BUMPENVMAP';
  if (TextureOpCaps and D3DTEXOPCAPS_BUMPENVMAPLUMINANCE) > 0 then Result := Result + '.BUMPENVMAPLUMINANCE';
  if (TextureOpCaps and D3DTEXOPCAPS_DOTPRODUCT3) > 0 then Result := Result + '.DOTPRODUCT3';
  if (TextureOpCaps and D3DTEXOPCAPS_MULTIPLYADD) > 0 then Result := Result + '.MULTIPLYADD';
  if (TextureOpCaps and D3DTEXOPCAPS_LERP) > 0 then Result := Result + '.LERP';
end;

function DxbxFVFCapsToString(const FVFCaps: DWORD): string; // FVFCaps
begin
  Result := 'D3DFVFCAPS_TEXCOORDCOUNT=' + IntToStr(FVFCaps and D3DFVFCAPS_TEXCOORDCOUNTMASK);
  if (FVFCaps and D3DFVFCAPS_DONOTSTRIPELEMENTS) > 0 then Result := Result + ' D3DFVFCAPS_DONOTSTRIPELEMENTS';
  if (FVFCaps and D3DFVFCAPS_PSIZE) > 0 then Result := Result + ' D3DFVFCAPS_PSIZE';
end;

function DxbxVertexProcessingCapsToString(const VertexProcessingCaps: DWORD): string; // VertexProcessingCaps
begin
  if VertexProcessingCaps = 0 then
  begin
    Result := '';
    Exit;
  end;

  Result := 'D3DVTXPCAPS';
  if (VertexProcessingCaps and D3DVTXPCAPS_TEXGEN) > 0 then Result := Result + '.TEXGEN';
  if (VertexProcessingCaps and D3DVTXPCAPS_MATERIALSOURCE7) > 0 then Result := Result + '.MATERIALSOURCE7';
  if (VertexProcessingCaps and D3DVTXPCAPS_DIRECTIONALLIGHTS) > 0 then Result := Result + '.DIRECTIONALLIGHTS';
  if (VertexProcessingCaps and D3DVTXPCAPS_POSITIONALLIGHTS) > 0 then Result := Result + '.POSITIONALLIGHTS';
  if (VertexProcessingCaps and D3DVTXPCAPS_LOCALVIEWER) > 0 then Result := Result + '.LOCALVIEWER';
  if (VertexProcessingCaps and D3DVTXPCAPS_TWEENING) > 0 then Result := Result + '.TWEENING';
{$IFNDEF DXBX_USE_D3D9}
  if (VertexProcessingCaps and D3DVTXPCAPS_NO_VSDT_UBYTE4) > 0 then Result := Result + '.NO_VSDT_UBYTE4';
{$ELSE}
  if (VertexProcessingCaps and D3DVTXPCAPS_TEXGEN_SPHEREMAP) > 0 then Result := Result + '.TEXGEN_SPHEREMAP';
  if (VertexProcessingCaps and D3DVTXPCAPS_NO_TEXGEN_NONLOCALVIEWER) > 0 then Result := Result + '.NO_TEXGEN_NONLOCALVIEWER';
{$ENDIF}
end;


function DxbxD3DUsageToString(const dwUsage: DWORD): string;
begin
  if dwUsage = 0 then
  begin
    Result := '0';
    Exit;
  end;

  Result := 'D3DUSAGE';
  if (dwUsage and D3DUSAGE_RENDERTARGET) > 0 then Result := Result + '.RENDERTARGET';
  if (dwUsage and D3DUSAGE_DEPTHSTENCIL) > 0 then Result := Result + '.DEPTHSTENCIL';
  if (dwUsage and D3DUSAGE_WRITEONLY) > 0 then Result := Result + '.WRITEONLY';
  if (dwUsage and D3DUSAGE_SOFTWAREPROCESSING) > 0 then Result := Result + '.SOFTWAREPROCESSING';
  if (dwUsage and D3DUSAGE_DONOTCLIP) > 0 then Result := Result + '.DONOTCLIP';
  if (dwUsage and D3DUSAGE_POINTS) > 0 then Result := Result + '.POINTS';
  if (dwUsage and D3DUSAGE_RTPATCHES) > 0 then Result := Result + '.RTPATCHES';
  if (dwUsage and D3DUSAGE_NPATCHES) > 0 then Result := Result + '.NPATCHES';
  if (dwUsage and D3DUSAGE_DYNAMIC) > 0 then Result := Result + '.DYNAMIC';
end;

function DxbxD3DPoolToString(const Pool: D3DPOOL): string;
begin
  case Pool of
    D3DPOOL_DEFAULT: Result := 'D3DPOOL_DEFAULT';
    D3DPOOL_MANAGED: Result := 'D3DPOOL_MANAGED';
    D3DPOOL_SYSTEMMEM: Result := 'D3DPOOL_SYSTEMMEM';
    D3DPOOL_SCRATCH: Result := 'D3DPOOL_SCRATCH';
  else
    Result := '';
  end;
end;

function DxbxXB2PC_NOP(Value: DWORD): DWORD;
begin
  Result := Value;
end;

function DxbxTypedValueToString(const aType: TXBType; const aValue: DWORD): string;
begin
  if Assigned(DxbxXBTypeInfo[aType].R) then
    Result := TXB2StringFunc(DxbxXBTypeInfo[aType].R)(aValue)
  else
    Result := '';
end;

function X_D3DTEXTURESTAGESTATETYPE2String(aValue: DWORD): string;
begin
  if aValue in [X_D3DTSS_FIRST..X_D3DTSS_LAST] then
    Result := DxbxTextureStageStateInfo[aValue].S
  else
    Result := '';
end;

function X_D3DTRANSFORMSTATETYPE2String(aValue: DWORD): string;
begin
  case X_D3DTRANSFORMSTATETYPE(aValue) of
    X_D3DTS_VIEW: Result := 'D3DTS_VIEW';
    X_D3DTS_PROJECTION: Result := 'D3DTS_PROJECTION';
    X_D3DTS_TEXTURE0: Result := 'D3DTS_TEXTURE0';
    X_D3DTS_TEXTURE1: Result := 'D3DTS_TEXTURE1';
    X_D3DTS_TEXTURE2: Result := 'D3DTS_TEXTURE2';
    X_D3DTS_TEXTURE3: Result := 'D3DTS_TEXTURE3';
    X_D3DTS_WORLD: Result := 'D3DTS_WORLD';
    X_D3DTS_WORLD1: Result := 'D3DTS_WORLD1';
    X_D3DTS_WORLD2: Result := 'D3DTS_WORLD2';
    X_D3DTS_WORLD3: Result := 'D3DTS_WORLD3';
    X_D3DTS_MAX: Result := 'D3DTS_MAX';
    X_D3DTS_FORCE_DWORD: Result := 'D3DTS_FORCE_DWORD';
  else Result := '';
  end;
end;

function X_D3DVERTEXBLENDFLAGS2String(aValue: DWORD): string;
begin
  case X_D3DVERTEXBLENDFLAGS(aValue) of
    X_D3DVBF_DISABLE           : Result := 'D3DVBF_DISABLE';
    X_D3DVBF_1WEIGHTS          : Result := 'D3DVBF_1WEIGHTS';
    X_D3DVBF_2WEIGHTS2MATRICES : Result := 'D3DVBF_2WEIGHTS2MATRICES';
    X_D3DVBF_2WEIGHTS          : Result := 'D3DVBF_2WEIGHTS';
    X_D3DVBF_3WEIGHTS3MATRICES : Result := 'D3DVBF_3WEIGHTS3MATRICES';
    X_D3DVBF_3WEIGHTS          : Result := 'D3DVBF_3WEIGHTS';
    X_D3DVBF_4WEIGHTS4MATRICES : Result := 'D3DVBF_4WEIGHTS4MATRICES';
  else Result := '';
  end;
end;

function X_D3DMULTISAMPLE_TYPE2String(aValue: DWORD): string;
begin
  case X_D3DMULTISAMPLE_TYPE(aValue) of
    X_D3DMULTISAMPLE_NONE:
      Result := 'D3DMULTISAMPLE_NONE';
    X_D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_LINEAR:
      Result := 'D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_LINEAR';
    X_D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_QUINCUNX:
      Result := 'D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_QUINCUNX';
    X_D3DMULTISAMPLE_2_SAMPLES_SUPERSAMPLE_HORIZONTAL_LINEAR:
      Result := 'D3DMULTISAMPLE_2_SAMPLES_SUPERSAMPLE_HORIZONTAL_LINEAR';
    X_D3DMULTISAMPLE_2_SAMPLES_SUPERSAMPLE_VERTICAL_LINEAR:
      Result := 'D3DMULTISAMPLE_2_SAMPLES_SUPERSAMPLE_VERTICAL_LINEAR';
    X_D3DMULTISAMPLE_4_SAMPLES_MULTISAMPLE_LINEAR:
      Result := 'D3DMULTISAMPLE_4_SAMPLES_MULTISAMPLE_LINEAR';
    X_D3DMULTISAMPLE_4_SAMPLES_MULTISAMPLE_GAUSSIAN:
      Result := 'D3DMULTISAMPLE_4_SAMPLES_MULTISAMPLE_GAUSSIAN';
    X_D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_LINEAR:
      Result := 'D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_LINEAR';
    X_D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_GAUSSIAN:
      Result := 'D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_GAUSSIAN';
    X_D3DMULTISAMPLE_9_SAMPLES_MULTISAMPLE_GAUSSIAN:
      Result := 'D3DMULTISAMPLE_9_SAMPLES_MULTISAMPLE_GAUSSIAN';
    X_D3DMULTISAMPLE_9_SAMPLES_SUPERSAMPLE_GAUSSIAN:
      Result := 'D3DMULTISAMPLE_9_SAMPLES_SUPERSAMPLE_GAUSSIAN';
  else Result := '';
  end;
end;

function X_D3DMULTISAMPLEMODE2String(aValue: DWORD): string;
begin
  case X_D3DMULTISAMPLEMODE(aValue) of
    X_D3DMULTISAMPLEMODE_1X: Result := 'D3DMULTISAMPLEMODE_1X';
    X_D3DMULTISAMPLEMODE_2X: Result := 'D3DMULTISAMPLEMODE_2X';
    X_D3DMULTISAMPLEMODE_4X: Result := 'D3DMULTISAMPLEMODE_4X';
  else Result := '';
  end;
end;

// TODO : Move to appropriate unit :
procedure EmuXB2PC_D3DSURFACE_DESC(const SurfaceDesc: PX_D3DSURFACE_DESC; const pDesc: PD3DSURFACE_DESC; const CallerName: string);
begin
  // Convert Format (Xbox->PC)
  pDesc.Format := EmuXB2PC_D3DFormat(SurfaceDesc.Format);
  pDesc._Type := D3DRESOURCETYPE(SurfaceDesc.Type_);

//  if (Ord(pDesc.Type_) > 7) then
//    DxbxKrnlCleanup(CallerName + ': pDesc->Type > 7');

  pDesc.Usage := SurfaceDesc.Usage;
{$IFNDEF DXBX_USE_D3D9}
  pDesc.Size := GetSurfaceSize(@SurfaceDesc);
{$ENDIF}
  pDesc.MultiSampleType := EmuXB2PC_D3DMULTISAMPLE_TYPE(SurfaceDesc.MultiSampleType);
  pDesc.Width  := SurfaceDesc.Width;
  pDesc.Height := SurfaceDesc.Height;
end;

// convert from xbox to pc color formats
function EmuXB2PC_D3DFormat(aFormat: X_D3DFORMAT): D3DFORMAT;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  if aFormat in [X_D3DFMT_L8..X_D3DFMT_INDEX16] then
  begin
    Result := D3DFMT_INFO[aFormat].PC;

    if (D3DFMT_INFO[aFormat].Flags and FMFL_APROX) > 0 then
      EmuWarning(D3DFMT_INFO[aFormat].Name + ' -> ' + D3DFORMAT2String(Result));
  end
  else
  begin
    if aFormat = X_D3DFMT_UNKNOWN then
      Result := D3DFMT_UNKNOWN // TODO -oCXBX: Not sure if this counts as swizzled or not...
    else
    begin
      DxbxKrnlCleanup('EmuXB2PC_D3DFormat: Unknown Format (0x%.08X)', [aFormat]);
      Result := D3DFORMAT(aFormat);
    end;
  end;
end;

// convert from pc to xbox color formats
function EmuPC2XB_D3DFormat(aFormat: D3DFORMAT): X_D3DFORMAT;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  // TODO -oDxbx: Complete this, and add a switch to prefer swizzled over linear formats (could be relevant)
  case aFormat of
    // D3DFMT_R8G8B8               = 20,
    D3DFMT_A8R8G8B8:
      // Result := X_D3DFMT_LIN_A8R8G8B8; // Linear
      Result := X_D3DFMT_A8R8G8B8;
    D3DFMT_X8R8G8B8:
      Result := X_D3DFMT_LIN_X8R8G8B8; // Linear
      // Result := X_D3DFMT_X8R8G8B8; // Swizzled
    D3DFMT_R5G6B5:
      Result := X_D3DFMT_LIN_R5G6B5; // Linear
      // Result := X_D3DFMT_R5G6B5; // Swizzled
    D3DFMT_X1R5G5B5:
      Result := X_D3DFMT_X1R5G5B5; // Swizzled
    D3DFMT_A1R5G5B5:
      Result := X_D3DFMT_LIN_A1R5G5B5; // Linear
    D3DFMT_A4R4G4B4:
      Result := X_D3DFMT_LIN_A4R4G4B4; // Linear
      // Result := X_D3DFMT_A4R4G4B4; // Swizzled
    // D3DFMT_R3G3B2               = 27,
    D3DFMT_A8:
      Result := X_D3DFMT_A8;
    // D3DFMT_A8R3G3B2             = 29,
    // D3DFMT_X4R4G4B4             = 30,
    // D3DFMT_A2B10G10R10          = 31,
    // D3DFMT_G16R16               = 34,
    // D3DFMT_A8P8                 = 40,
    D3DFMT_P8:
      Result := X_D3DFMT_P8;
    D3DFMT_L8:
      Result := X_D3DFMT_LIN_L8; // Linear
      // Result := X_D3DFMT_L8; // Swizzled
    D3DFMT_A8L8:
      Result := X_D3DFMT_A8L8; // Swizzled
    // D3DFMT_A4L4                 = 52,
    D3DFMT_V8U8:
      Result := X_D3DFMT_V8U8; // Swizzled
    D3DFMT_L6V5U5:
      Result := X_D3DFMT_L6V5U5; // Swizzled
    // D3DFMT_X8L8V8U8             = 62,
    // D3DFMT_Q8W8V8U8             = 63,
    D3DFMT_V16U16:
      Result := X_D3DFMT_V16U16; // Swizzled
    // D3DFMT_W11V11U10            = 65,
    // D3DFMT_A2W10V10U10          = 67,
    D3DFMT_UYVY:
      Result := X_D3DFMT_UYVY;
    D3DFMT_YUY2:
      Result := X_D3DFMT_YUY2;
    D3DFMT_DXT1:
      Result := X_D3DFMT_DXT1; // Compressed
    D3DFMT_DXT2:
      Result := X_D3DFMT_DXT2;
    D3DFMT_DXT3:
      Result := X_D3DFMT_DXT3; // Compressed
    D3DFMT_DXT4:
      Result := X_D3DFMT_DXT4;
    D3DFMT_DXT5:
      Result := X_D3DFMT_DXT5; // Compressed
    D3DFMT_D16_LOCKABLE:
      Result := X_D3DFMT_D16_LOCKABLE; // Swizzled
    // D3DFMT_D32                  = 71,
    // D3DFMT_D15S1                = 73,
    D3DFMT_D24S8:
      Result := X_D3DFMT_D24S8; // Swizzled
    D3DFMT_D16:
      Result := X_D3DFMT_D16_LOCKABLE; // Swizzled
    // D3DFMT_D24X8                = 77,
    // D3DFMT_D24X4S4              = 79,
    D3DFMT_VERTEXDATA:
      Result := X_D3DFMT_VERTEXDATA;
    D3DFMT_INDEX16:
      Result := X_D3DFMT_INDEX16;
    // D3DFMT_INDEX32              =102,
    D3DFMT_UNKNOWN:
      Result := X_D3DFMT_UNKNOWN;
  else
    DxbxKrnlCleanup('EmuPC2XB_D3DFormat: Unknown Format (0x%.08X)', [Ord(aFormat)]);
    Result := X_D3DFORMAT(aFormat);
  end;
end;

// convert from xbox to pc d3d lock flags
function EmuXB2PC_D3DLock(Flags: DWORD): DWORD;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
var
  NewFlags: DWORD;
begin
  NewFlags := 0;

  // Need to convert the flags,
  //TODO -oCXBX: fix the xbox extensions
  // Dxbx note : Cxbx uses XOR here, that can't be right! We'll be using OR.
  if (Flags and X_D3DLOCK_NOFLUSH) > 0 then
    EmuWarning('D3DLOCK_NOFLUSH ignored!');

  if (Flags and X_D3DLOCK_NOOVERWRITE) > 0 then
    NewFlags := NewFlags or D3DLOCK_NOOVERWRITE;

  if (Flags and X_D3DLOCK_TILED) > 0 then
    EmuWarning('D3DLOCK_TILED ignored!');

  if (Flags and X_D3DLOCK_READONLY) > 0 then
    NewFlags := NewFlags or D3DLOCK_READONLY;

  Result := NewFlags;
end;

// Code translated from Convert.h :

// convert from xbox to pc multisample formats
function EmuXB2PC_D3DMULTISAMPLE_TYPE(aType: X_D3DMULTISAMPLE_TYPE): D3DMULTISAMPLE_TYPE;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  case aType {and $FFFF} of
    X_D3DMULTISAMPLE_NONE:
      Result := D3DMULTISAMPLE_NONE;

    X_D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_LINEAR,
    X_D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_QUINCUNX,
    X_D3DMULTISAMPLE_2_SAMPLES_SUPERSAMPLE_HORIZONTAL_LINEAR,
    X_D3DMULTISAMPLE_2_SAMPLES_SUPERSAMPLE_VERTICAL_LINEAR:
      Result := D3DMULTISAMPLE_2_SAMPLES;

    X_D3DMULTISAMPLE_4_SAMPLES_MULTISAMPLE_LINEAR,
    X_D3DMULTISAMPLE_4_SAMPLES_MULTISAMPLE_GAUSSIAN,
    X_D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_LINEAR,
    X_D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_GAUSSIAN:
      Result := D3DMULTISAMPLE_4_SAMPLES;

    X_D3DMULTISAMPLE_9_SAMPLES_MULTISAMPLE_GAUSSIAN,
    X_D3DMULTISAMPLE_9_SAMPLES_SUPERSAMPLE_GAUSSIAN:
      Result := D3DMULTISAMPLE_9_SAMPLES;
  else
    EmuWarning('Unknown Multisample Type (0x%X)!'#13#10 +
               'If this value is greater than 0xFFFF contact blueshogun!', [Ord(aType)] );

    Result := D3DMULTISAMPLE_NONE;
  end;
end;

// convert from xbox to pc texture transform state types
function EmuXB2PC_D3DTS(State: X_D3DTRANSFORMSTATETYPE): D3DTRANSFORMSTATETYPE;
// Branch:Dxxb  Translator:PatrickvL  Done:100
begin
  case State of
    X_D3DTS_VIEW:
      Result := D3DTS_VIEW;
    X_D3DTS_PROJECTION:
      Result := D3DTS_PROJECTION;
    X_D3DTS_TEXTURE0:
      Result := D3DTS_TEXTURE0;
    X_D3DTS_TEXTURE1:
      Result := D3DTS_TEXTURE1;
    X_D3DTS_TEXTURE2:
      Result := D3DTS_TEXTURE2;
    X_D3DTS_TEXTURE3:
      Result := D3DTS_TEXTURE3;
    X_D3DTS_WORLD:
      Result := D3DTS_WORLD;
    X_D3DTS_WORLD1:
      Result := D3DTS_WORLD1;
    X_D3DTS_WORLD2:
      Result := D3DTS_WORLD2;
    X_D3DTS_WORLD3:
      Result := D3DTS_WORLD3;
  else
    if State = X_D3DTS_MAX then
      EmuWarning('Ignored D3DTS_MAX')
    else
      DxbxKrnlCleanup('Unknown Transform State Type (%d)', [Ord(State)]);

    Result := Low(Result); // Never reached
  end;
end;

// convert from xbox to pc texture stage state
function EmuXB2PC_D3DTSS(Value: X_D3DTEXTURESTAGESTATETYPE): TD3DSamplerStateType;
// Branch:Dxbx  Translator:PatrickvL  Done:100
begin
  if Value in [X_D3DTSS_FIRST..X_D3DTSS_LAST] then
    Result := DxbxTextureStageStateInfo[Value].PC
  else
    Result := D3DSAMP_UNSUPPORTED;
end;

// convert from xbox to pc blend ops
function EmuXB2PC_D3DBLENDOP(Value: X_D3DBLENDOP): D3DBLENDOP;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  case(Value) of
    X_D3DBLENDOP_ADD:
      Result := D3DBLENDOP_ADD;
    X_D3DBLENDOP_SUBTRACT:
      Result := D3DBLENDOP_SUBTRACT;
    X_D3DBLENDOP_REVSUBTRACT:
      Result := D3DBLENDOP_REVSUBTRACT;
    X_D3DBLENDOP_MIN:
      Result := D3DBLENDOP_MIN;
    X_D3DBLENDOP_MAX:
      Result := D3DBLENDOP_MAX;
    X_D3DBLENDOP_ADDSIGNED:
    begin
      EmuWarning('Unsupported Xbox D3DBLENDOP : D3DBLENDOP_ADDSIGNED. Used approximation.');
      Result := D3DBLENDOP_ADD;
    end;
    X_D3DBLENDOP_REVSUBTRACTSIGNED:
    begin
      EmuWarning('Unsupported Xbox D3DBLENDOP : D3DBLENDOP_REVSUBTRACTSIGNED. Used approximation.');
      Result := D3DBLENDOP_REVSUBTRACT;
    end;
  else
    DxbxKrnlCleanup('Unknown Xbox D3DBLENDOP (0x%.08X)', [Ord(Value)]);

    Result := D3DBLENDOP(Value);
  end;
end;

// Convert from xbox to pc blend types
function EmuXB2PC_D3DBLEND(Value: X_D3DBLEND): D3DBLEND;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  case Value of
    X_D3DBLEND_ZERO               : Result := D3DBLEND_ZERO;
    X_D3DBLEND_ONE                : Result := D3DBLEND_ONE;
    X_D3DBLEND_SRCCOLOR           : Result := D3DBLEND_SRCCOLOR;
    X_D3DBLEND_INVSRCCOLOR        : Result := D3DBLEND_INVSRCCOLOR;
    X_D3DBLEND_SRCALPHA           : Result := D3DBLEND_SRCALPHA;
    X_D3DBLEND_INVSRCALPHA        : Result := D3DBLEND_INVSRCALPHA;
    X_D3DBLEND_DESTALPHA          : Result := D3DBLEND_DESTALPHA;
    X_D3DBLEND_INVDESTALPHA       : Result := D3DBLEND_INVDESTALPHA;
    X_D3DBLEND_DESTCOLOR          : Result := D3DBLEND_DESTCOLOR;
    X_D3DBLEND_INVDESTCOLOR       : Result := D3DBLEND_INVDESTCOLOR;
    X_D3DBLEND_SRCALPHASAT        : Result := D3DBLEND_SRCALPHASAT;
{$IFDEF DXBX_USE_D3D9}
    // Xbox extensions not supported by D3D8, but available in D3D9 :
    X_D3DBLEND_CONSTANTCOLOR      : Result := D3DBLEND_BLENDFACTOR;
    X_D3DBLEND_INVCONSTANTCOLOR   : Result := D3DBLEND_INVBLENDFACTOR;
{$ENDIF}
  else
    // Xbox extensions that have to be approximated :
    case Value of
{$IFNDEF DXBX_USE_D3D9}
      // Not supported by D3D8 :
      X_D3DBLEND_CONSTANTCOLOR    : Result := D3DBLEND_SRCCOLOR;
      X_D3DBLEND_INVCONSTANTCOLOR : Result := D3DBLEND_INVSRCCOLOR;
{$ENDIF}
      X_D3DBLEND_CONSTANTALPHA    : Result := D3DBLEND_SRCALPHA;
      X_D3DBLEND_INVCONSTANTALPHA : Result := D3DBLEND_INVSRCALPHA;
      // Note : Xbox doesn't support D3DBLEND_BOTHSRCALPHA and D3DBLEND_BOTHINVSRCALPHA
    else
      DxbxKrnlCleanup('Unknown Xbox D3DBLEND Extension (0x%.08X)', [Ord(Value)]);
      Result := D3DBLEND_SRCCOLOR;
    end;

    EmuWarning('Unsupported Xbox D3DBLEND Extension (0x%.08X). Used approximation.', [Ord(Value)]);
  end;
end;

// convert from xbox to pc comparison functions
function EmuXB2PC_D3DCMPFUNC(Value: X_D3DCMPFUNC): D3DCMPFUNC;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  Result := D3DCMPFUNC((Ord(Value) and $F) + 1);
end;

// convert from xbox to pc fill modes
function EmuXB2PC_D3DFILLMODE(Value: X_D3DFILLMODE): D3DFILLMODE;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  case Value of
    X_D3DFILL_POINT:
      Result := D3DFILL_POINT;
    X_D3DFILL_WIREFRAME:
      Result := D3DFILL_WIREFRAME;
  else // X_D3DFILL_SOLID:
    Result := D3DFILL_SOLID;
  end;
end;

// convert from xbox to pc shade modes
function EmuXB2PC_D3DSHADEMODE(Value: X_D3DSHADEMODE): D3DSHADEMODE;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  Result := D3DSHADEMODE((Ord(Value) and $3) + 1);
end;

// convert from xbox to pc stencilop modes
function EmuXB2PC_D3DSTENCILOP(Value: X_D3DSTENCILOP): D3DSTENCILOP;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  case(Value)of
    X_D3DSTENCILOP_KEEP:
      Result := D3DSTENCILOP_KEEP;
    X_D3DSTENCILOP_ZERO:
      Result := D3DSTENCILOP_ZERO;
    X_D3DSTENCILOP_REPLACE:
      Result := D3DSTENCILOP_REPLACE;
    X_D3DSTENCILOP_INCRSAT:
      Result := D3DSTENCILOP_INCRSAT;
    X_D3DSTENCILOP_DECRSAT:
      Result := D3DSTENCILOP_DECRSAT;
    X_D3DSTENCILOP_INVERT:
      Result := D3DSTENCILOP_INVERT;
    X_D3DSTENCILOP_INCR:
      Result := D3DSTENCILOP_INCR;
    X_D3DSTENCILOP_DECR:
      Result := D3DSTENCILOP_DECR;

  else //default:
    DxbxKrnlCleanup('Unknown D3DSTENCILOP (0x%.08X)', [Ord(Value)]);
    Result := D3DSTENCILOP(Value);
  end;
end;

function EmuXB2PC_D3DTEXTUREADDRESS(Value: DWORD): DWORD;
begin
  if (Value = X_D3DTADDRESS_CLAMPTOEDGE) then
    // Note : PC has D3DTADDRESS_MIRRORONCE in it's place
    EmuWarning('ClampToEdge is unsupported (temporarily)');

  Result := Value;
end;

function EmuXB2PC_D3DTEXTUREFILTERTYPE(Value: DWORD): DWORD;
begin
  if (Value = 4) then
    DxbxKrnlCleanup('QuinCunx is unsupported (temporarily)');

  Result := Value;
end;

// convert from Xbox direct3d to PC direct3d enumeration
function EmuXB2PC_D3DVERTEXBLENDFLAGS(Value: X_D3DVERTEXBLENDFLAGS): D3DVERTEXBLENDFLAGS;
// Branch:Dxbx  Translator:PatrickvL  Done:100
begin
  case(Value)of
    X_D3DVBF_DISABLE           : Result := D3DVBF_DISABLE;
    X_D3DVBF_1WEIGHTS          : Result := D3DVBF_1WEIGHTS;
    X_D3DVBF_2WEIGHTS          : Result := D3DVBF_2WEIGHTS;
    X_D3DVBF_3WEIGHTS          : Result := D3DVBF_3WEIGHTS;
(* Xbox only :
    X_D3DVBF_2WEIGHTS2MATRICES : Result := ;
    X_D3DVBF_3WEIGHTS3MATRICES : Result := ;
    X_D3DVBF_4WEIGHTS4MATRICES : Result := ;
   Xbox doesn't support :
    D3DVBF_TWEENING = 255,
    D3DVBF_0WEIGHTS = 256
*)
  else //default:
    DxbxKrnlCleanup('Unsupported D3DVERTEXBLENDFLAGS (%d)', [Ord(Value)]);
    Result := D3DVERTEXBLENDFLAGS(Value);
  end;
end;

function EmuXB2PC_D3DCOLORWRITEENABLE(Value: X_D3DCOLORWRITEENABLE): DWORD;
// Branch:Dxbx  Translator:PatrickvL  Done:100
begin
  Result := 0;
  if (Value and X_D3DCOLORWRITEENABLE_RED) > 0 then
    Result := Result or D3DCOLORWRITEENABLE_RED;
  if (Value and X_D3DCOLORWRITEENABLE_GREEN) > 0 then
    Result := Result or D3DCOLORWRITEENABLE_GREEN;
  if (Value and X_D3DCOLORWRITEENABLE_BLUE) > 0 then
    Result := Result or D3DCOLORWRITEENABLE_BLUE;
  if (Value and X_D3DCOLORWRITEENABLE_ALPHA) > 0 then
    Result := Result or D3DCOLORWRITEENABLE_ALPHA;
end;

function EmuXB2PC_D3DTEXTUREOP(Value: X_D3DTEXTUREOP): DWORD;
// Branch:Dxbx  Translator:PatrickvL  Done:100
begin
  case Value of
    X_D3DTOP_DISABLE: Result := D3DTOP_DISABLE;
    X_D3DTOP_SELECTARG1: Result := D3DTOP_SELECTARG1;
    X_D3DTOP_SELECTARG2: Result := D3DTOP_SELECTARG2;
    X_D3DTOP_MODULATE: Result := D3DTOP_MODULATE;
    X_D3DTOP_MODULATE2X: Result := D3DTOP_MODULATE2X;
    X_D3DTOP_MODULATE4X: Result := D3DTOP_MODULATE4X;
    X_D3DTOP_ADD: Result := D3DTOP_ADD;
    X_D3DTOP_ADDSIGNED: Result := D3DTOP_ADDSIGNED;
    X_D3DTOP_ADDSIGNED2X: Result := D3DTOP_ADDSIGNED2X;
    X_D3DTOP_SUBTRACT: Result := D3DTOP_SUBTRACT;
    X_D3DTOP_ADDSMOOTH: Result := D3DTOP_ADDSMOOTH;

    // Linear alpha blend: Arg1*(Alpha) + Arg2*(1-Alpha)
    X_D3DTOP_BLENDDIFFUSEALPHA: Result := D3DTOP_BLENDDIFFUSEALPHA;// iterated alpha
    X_D3DTOP_BLENDTEXTUREALPHA: Result := D3DTOP_BLENDTEXTUREALPHA; // texture alpha
    X_D3DTOP_BLENDFACTORALPHA: Result := D3DTOP_BLENDFACTORALPHA; // alpha from D3DRS_TEXTUREFACTOR
    // Linear alpha blend with pre-multiplied arg1 input: Arg1 + Arg2*(1-Alpha)
    X_D3DTOP_BLENDCURRENTALPHA: Result := D3DTOP_BLENDCURRENTALPHA; // by alpha of current color
    X_D3DTOP_BLENDTEXTUREALPHAPM: Result := D3DTOP_BLENDTEXTUREALPHAPM; // texture alpha

    X_D3DTOP_PREMODULATE: Result := D3DTOP_PREMODULATE;
    X_D3DTOP_MODULATEALPHA_ADDCOLOR: Result := D3DTOP_MODULATEALPHA_ADDCOLOR;
    X_D3DTOP_MODULATECOLOR_ADDALPHA: Result := D3DTOP_MODULATECOLOR_ADDALPHA;
    X_D3DTOP_MODULATEINVALPHA_ADDCOLOR: Result := D3DTOP_MODULATEINVALPHA_ADDCOLOR;
    X_D3DTOP_MODULATEINVCOLOR_ADDALPHA: Result := D3DTOP_MODULATEINVCOLOR_ADDALPHA;
    X_D3DTOP_DOTPRODUCT3: Result := D3DTOP_DOTPRODUCT3;
    X_D3DTOP_MULTIPLYADD: Result := D3DTOP_MULTIPLYADD;
    X_D3DTOP_LERP: Result := D3DTOP_LERP;
    X_D3DTOP_BUMPENVMAP: Result := D3DTOP_BUMPENVMAP;
    X_D3DTOP_BUMPENVMAPLUMINANCE: Result := D3DTOP_BUMPENVMAPLUMINANCE;
  else
    Result := 0;
  end;
end;

function DWFloat2String(aValue: DWORD): string;
begin
  Result := FormatFloat('0.0', PFloat(@aValue)^); // TODO : Speed this up by avoiding Single>Extended cast & generic render code.
end;

function X_D3DBLEND2String(aValue: DWORD): string;
begin
  case X_D3DBLEND(aValue) of
    X_D3DBLEND_ZERO             : Result := 'D3DBLEND_ZERO';
    X_D3DBLEND_ONE              : Result := 'D3DBLEND_ONE';
    X_D3DBLEND_SRCCOLOR         : Result := 'D3DBLEND_SRCCOLOR';
    X_D3DBLEND_INVSRCCOLOR      : Result := 'D3DBLEND_INVSRCCOLOR';
    X_D3DBLEND_SRCALPHA         : Result := 'D3DBLEND_SRCALPHA';
    X_D3DBLEND_INVSRCALPHA      : Result := 'D3DBLEND_INVSRCALPHA';
    X_D3DBLEND_DESTALPHA        : Result := 'D3DBLEND_DESTALPHA';
    X_D3DBLEND_INVDESTALPHA     : Result := 'D3DBLEND_INVDESTALPHA';
    X_D3DBLEND_DESTCOLOR        : Result := 'D3DBLEND_DESTCOLOR';
    X_D3DBLEND_INVDESTCOLOR     : Result := 'D3DBLEND_INVDESTCOLOR';
    X_D3DBLEND_SRCALPHASAT      : Result := 'D3DBLEND_SRCALPHASAT';
    X_D3DBLEND_CONSTANTCOLOR    : Result := 'D3DBLEND_CONSTANTCOLOR';
    X_D3DBLEND_INVCONSTANTCOLOR : Result := 'D3DBLEND_INVCONSTANTCOLOR';
    X_D3DBLEND_CONSTANTALPHA    : Result := 'D3DBLEND_CONSTANTALPHA';
    X_D3DBLEND_INVCONSTANTALPHA : Result := 'D3DBLEND_INVCONSTANTALPHA';
  else Result := '';
  end;
end;

function X_D3DBLENDOP2String(aValue: DWORD): string;
begin
  case X_D3DBLENDOP(aValue) of
    X_D3DBLENDOP_ADD:               Result := 'D3DBLENDOP_ADD';
    X_D3DBLENDOP_SUBTRACT:          Result := 'D3DBLENDOP_SUBTRACT';
    X_D3DBLENDOP_REVSUBTRACT:       Result := 'D3DBLENDOP_REVSUBTRACT';
    X_D3DBLENDOP_MIN:               Result := 'D3DBLENDOP_MIN';
    X_D3DBLENDOP_MAX:               Result := 'D3DBLENDOP_MAX';
    X_D3DBLENDOP_ADDSIGNED:         Result := 'D3DBLENDOP_ADDSIGNED';
    X_D3DBLENDOP_REVSUBTRACTSIGNED: Result := 'D3DBLENDOP_REVSUBTRACTSIGNED';
  else Result := '';
  end;
end;

function X_D3DCLEAR2String(aValue: DWORD): string;
begin
  Result := '';
  if (aValue and X_D3DCLEAR_ZBUFFER) > 0 then Result := Result + '|D3DCLEAR_ZBUFFER';
  if (aValue and X_D3DCLEAR_STENCIL) > 0 then Result := Result + '|D3DCLEAR_STENCIL';
  if (aValue and X_D3DCLEAR_TARGET_R) > 0 then Result := Result + '|D3DCLEAR_TARGET_R';
  if (aValue and X_D3DCLEAR_TARGET_G) > 0 then Result := Result + '|D3DCLEAR_TARGET_G';
  if (aValue and X_D3DCLEAR_TARGET_B) > 0 then Result := Result + '|D3DCLEAR_TARGET_B';
  if (aValue and X_D3DCLEAR_TARGET_A) > 0 then Result := Result + '|D3DCLEAR_TARGET_A';
  if Result <> '' then System.Delete(Result, 1, 1);
end;

function X_D3DCMPFUNC2String(aValue: DWORD): string;
begin
  case X_D3DCMPFUNC(aValue) of
    X_D3DCMP_NEVER       : Result := 'D3DCMP_NEVER';
    X_D3DCMP_LESS        : Result := 'D3DCMP_LESS';
    X_D3DCMP_EQUAL       : Result := 'D3DCMP_EQUAL';
    X_D3DCMP_LESSEQUAL   : Result := 'D3DCMP_LESSEQUAL';
    X_D3DCMP_GREATER     : Result := 'D3DCMP_GREATER';
    X_D3DCMP_NOTEQUAL    : Result := 'D3DCMP_NOTEQUAL';
    X_D3DCMP_GREATEREQUAL: Result := 'D3DCMP_GREATEREQUAL';
    X_D3DCMP_ALWAYS      : Result := 'D3DCMP_ALWAYS';
  else Result := '';
  end;
end;

function X_D3DCOLORWRITEENABLE2String(aValue: DWORD): string;
begin
  if aValue = X_D3DCOLORWRITEENABLE_ALL then
    Result := 'D3DCOLORWRITEENABLE_ALL'
  else
  begin
    Result := '';
    if (aValue and X_D3DCOLORWRITEENABLE_RED) > 0 then Result := Result + '|D3DCOLORWRITEENABLE_RED';
    if (aValue and X_D3DCOLORWRITEENABLE_GREEN) > 0 then Result := Result + '|D3DCOLORWRITEENABLE_GREEN';
    if (aValue and X_D3DCOLORWRITEENABLE_BLUE) > 0 then Result := Result + '|D3DCOLORWRITEENABLE_BLUE';
    if (aValue and X_D3DCOLORWRITEENABLE_ALPHA) > 0 then Result := Result + '|D3DCOLORWRITEENABLE_ALPHA';
    if Result <> '' then System.Delete(Result, 1, 1);
  end;
end;


function X_D3DCUBEMAP_FACES2String(aValue: DWORD): string;
begin
  case D3DCUBEMAP_FACES(aValue) of
    D3DCUBEMAP_FACE_POSITIVE_X: Result := 'D3DCUBEMAP_FACE_POSITIVE_X';
    D3DCUBEMAP_FACE_NEGATIVE_X: Result := 'D3DCUBEMAP_FACE_NEGATIVE_X';
    D3DCUBEMAP_FACE_POSITIVE_Y: Result := 'D3DCUBEMAP_FACE_POSITIVE_Y';
    D3DCUBEMAP_FACE_NEGATIVE_Y: Result := 'D3DCUBEMAP_FACE_NEGATIVE_Y';
    D3DCUBEMAP_FACE_POSITIVE_Z: Result := 'D3DCUBEMAP_FACE_POSITIVE_Z';
    D3DCUBEMAP_FACE_NEGATIVE_Z: Result := 'D3DCUBEMAP_FACE_NEGATIVE_Z';
  else Result := '';
  end;
end;

function X_D3DCULL2String(aValue: DWORD): string;
begin
  case X_D3DCULL(aValue) of
    X_D3DCULL_NONE: Result := 'D3DCULL_NONE';
    X_D3DCULL_CW:   Result := 'D3DCULL_CW';
    X_D3DCULL_CCW:  Result := 'D3DCULL_CCW';
  else Result := '';
  end;
end;

function X_D3DDCC2String(aValue: DWORD): string;
begin
  Result := '';
  if (aValue and X_D3DDCC_CULLPRIMITIVE) > 0 then Result := Result + '|D3DDCC_CULLPRIMITIVE';
  if (aValue and X_D3DDCC_CLAMP) > 0 then Result := Result + '|D3DDCC_CLAMP';
  if (aValue and X_D3DDCC_IGNORE_W_SIGN) > 0 then Result := Result + '|D3DDCC_IGNORE_W_SIGN';
  if Result <> '' then System.Delete(Result, 1, 1);
end;

function X_D3DFILLMODE2String(aValue: DWORD): string;
begin
  case X_D3DFILLMODE(aValue) of
    X_D3DFILL_POINT: Result := 'D3DFILL_POINT';
    X_D3DFILL_WIREFRAME: Result := 'D3DFILL_WIREFRAME';
    X_D3DFILL_SOLID: Result := 'D3DFILL_SOLID';
  else
    Result := '';
  end;
end;

function X_D3DFOGMODE2String(aValue: DWORD): string;
begin
  case X_D3DFOGMODE(aValue) of
    X_D3DFOG_NONE: Result := 'D3DFOG_NONE';
    X_D3DFOG_EXP: Result := 'D3DFOG_EXP';
    X_D3DFOG_EXP2: Result := 'D3DFOG_EXP2';
    X_D3DFOG_LINEAR: Result := 'D3DFOG_LINEAR';
  else
    Result := '';
  end;
end;

function X_D3DFRONT2String(aValue: DWORD): string;
begin
  case X_D3DFRONT(aValue) of
    X_D3DFRONT_CW:  Result := 'D3DFRONT_CW';
    X_D3DFRONT_CCW: Result := 'D3DFRONT_CCW';
  else Result := '';
  end;
end;

function X_D3DLOGICOP2String(aValue: DWORD): string;
begin
  case X_D3DLOGICOP(aValue) of
    X_D3DLOGICOP_NONE             : Result := 'D3DLOGICOP_NONE';
    X_D3DLOGICOP_CLEAR            : Result := 'D3DLOGICOP_CLEAR';
    X_D3DLOGICOP_AND              : Result := 'D3DLOGICOP_AND';
    X_D3DLOGICOP_AND_REVERSE      : Result := 'D3DLOGICOP_AND_REVERSE';
    X_D3DLOGICOP_COPY             : Result := 'D3DLOGICOP_COPY';
    X_D3DLOGICOP_AND_INVERTED     : Result := 'D3DLOGICOP_AND_INVERTED';
    X_D3DLOGICOP_NOOP             : Result := 'D3DLOGICOP_NOOP';
    X_D3DLOGICOP_XOR              : Result := 'D3DLOGICOP_XOR';
    X_D3DLOGICOP_OR               : Result := 'D3DLOGICOP_OR';
    X_D3DLOGICOP_NOR              : Result := 'D3DLOGICOP_NOR';
    X_D3DLOGICOP_EQUIV            : Result := 'D3DLOGICOP_EQUIV';
    X_D3DLOGICOP_INVERT           : Result := 'D3DLOGICOP_INVERT';
    X_D3DLOGICOP_OR_REVERSE       : Result := 'D3DLOGICOP_OR_REVERSE';
    X_D3DLOGICOP_COPY_INVERTED    : Result := 'D3DLOGICOP_COPY_INVERTED';
    X_D3DLOGICOP_OR_INVERTED      : Result := 'D3DLOGICOP_OR_INVERTED';
    X_D3DLOGICOP_NAND             : Result := 'D3DLOGICOP_NAND';
    X_D3DLOGICOP_SET              : Result := 'D3DLOGICOP_SET';
  else Result := '';
  end;
end;

function X_D3DMCS2String(aValue: DWORD): string;
begin
  case X_D3DMATERIALCOLORSOURCE(aValue) of
    X_D3DMCS_MATERIAL: Result := 'D3DMCS_MATERIAL';
    X_D3DMCS_COLOR1  : Result := 'D3DMCS_COLOR1';
    X_D3DMCS_COLOR2  : Result := 'D3DMCS_COLOR2';
  else Result := '';
  end;
end;

function X_D3DPRIMITIVETYPE2String(const aValue: X_D3DPRIMITIVETYPE): string;
begin
  case aValue of
    X_D3DPT_NONE: Result := ''; // Dxbx addition
    X_D3DPT_POINTLIST: Result := 'D3DPT_POINTLIST';
    X_D3DPT_LINELIST: Result := 'D3DPT_LINELIST';
    X_D3DPT_LINELOOP: Result := 'D3DPT_LINELOOP';
    X_D3DPT_LINESTRIP: Result := 'D3DPT_LINESTRIP';
    X_D3DPT_TRIANGLELIST: Result := 'D3DPT_TRIANGLELIST';
    X_D3DPT_TRIANGLESTRIP: Result := 'D3DPT_TRIANGLESTRIP';
    X_D3DPT_TRIANGLEFAN: Result := 'D3DPT_TRIANGLEFAN';
    X_D3DPT_QUADLIST: Result := 'D3DPT_QUADLIST';
    X_D3DPT_QUADSTRIP: Result := 'D3DPT_QUADSTRIP';
    X_D3DPT_POLYGON: Result := 'D3DPT_POLYGON';
    X_D3DPT_MAX: Result := 'D3DPT_MAX';
    X_D3DPT_INVALID: Result := 'D3DPT_INVALID';
  else Result := '';
  end;
end;

function X_D3DRESOURCETYPE2String(const aValue: X_D3DRESOURCETYPE): string;
begin
  case aValue of
    X_D3DRTYPE_NONE: Result := 'D3DRTYPE_NONE';
    X_D3DRTYPE_SURFACE: Result := 'D3DRTYPE_SURFACE';
    X_D3DRTYPE_VOLUME: Result := 'D3DRTYPE_VOLUME';
    X_D3DRTYPE_TEXTURE: Result := 'D3DRTYPE_TEXTURE';
    X_D3DRTYPE_VOLUMETEXTURE: Result := 'D3DRTYPE_VOLUMETEXTURE';
    X_D3DRTYPE_CUBETEXTURE: Result := 'D3DRTYPE_CUBETEXTURE';
    X_D3DRTYPE_VERTEXBUFFER: Result := 'D3DRTYPE_VERTEXBUFFER';
    X_D3DRTYPE_INDEXBUFFER: Result := 'D3DRTYPE_INDEXBUFFER';
    X_D3DRTYPE_PUSHBUFFER: Result := 'D3DRTYPE_PUSHBUFFER';
    X_D3DRTYPE_PALETTE: Result := 'D3DRTYPE_PALETTE';
    X_D3DRTYPE_FIXUP: Result := 'D3DRTYPE_FIXUP';
  else Result := '';
  end;
end;

function X_D3DSAMPLEALPHA2String(aValue: DWORD): string;
begin
  Result := '';
  if (aValue and X_D3DSAMPLEALPHA_TOCOVERAGE) > 0 then Result := Result + '|D3DSAMPLEALPHA_TOCOVERAGE';
  if (aValue and X_D3DSAMPLEALPHA_TOONE) > 0 then Result := Result + '|D3DSAMPLEALPHA_TOONE';
  if Result <> '' then System.Delete(Result, 1, 1);
end;

function X_D3DSHADEMODE2String(aValue: DWORD): string;
begin
  case X_D3DSHADEMODE(aValue) of
    X_D3DSHADE_FLAT   : Result := 'D3DSHADE_FLAT';
    X_D3DSHADE_GOURAUD: Result := 'D3DSHADE_GOURAUD';
  else Result := '';
  end;
end;

function X_D3DSTENCILOP2String(aValue: DWORD): string;
begin
  case X_D3DSTENCILOP(aValue) of
    X_D3DSTENCILOP_ZERO   : Result := 'D3DSTENCILOP_ZERO';
    X_D3DSTENCILOP_KEEP   : Result := 'D3DSTENCILOP_KEEP';
    X_D3DSTENCILOP_REPLACE: Result := 'D3DSTENCILOP_REPLACE';
    X_D3DSTENCILOP_INCRSAT: Result := 'D3DSTENCILOP_INCRSAT';
    X_D3DSTENCILOP_DECRSAT: Result := 'D3DSTENCILOP_DECRSAT';
    X_D3DSTENCILOP_INVERT : Result := 'D3DSTENCILOP_INVERT';
    X_D3DSTENCILOP_INCR   : Result := 'D3DSTENCILOP_INCR';
    X_D3DSTENCILOP_DECR   : Result := 'D3DSTENCILOP_DECR';
  else Result := '';
  end;
end;

function X_D3DSWATH2String(aValue: DWORD): string;
begin
  case X_D3DSWATHWIDTH(aValue) of
    X_D3DSWATH_8: Result := 'D3DSWATH_8';
    X_D3DSWATH_16: Result := 'D3DSWATH_16';
    X_D3DSWATH_32: Result := 'D3DSWATH_32';
    X_D3DSWATH_64: Result := 'D3DSWATH_64';
    X_D3DSWATH_128: Result := 'D3DSWATH_128';
    X_D3DSWATH_OFF: Result := 'D3DSWATH_OFF';
  else Result := '';
  end;
end;

function X_D3DTEXTUREADDRESS2String(aValue: DWORD): string;
begin
  case aValue of
    X_D3DTADDRESS_WRAP: Result := 'D3DTADDRESS_WRAP';
    X_D3DTADDRESS_MIRROR: Result := 'D3DTADDRESS_MIRROR';
    X_D3DTADDRESS_CLAMP: Result := 'D3DTADDRESS_CLAMP';
    X_D3DTADDRESS_BORDER: Result := 'D3DTADDRESS_BORDER';
    X_D3DTADDRESS_CLAMPTOEDGE: Result := 'D3DTADDRESS_CLAMPTOEDGE';
  else Result := '';
  end;
end;

function X_D3DTEXTUREOP2String(aValue: DWORD): string;
begin
  case X_D3DTEXTUREOP(aValue) of
    X_D3DTOP_DISABLE: Result := 'D3DTOP_DISABLE';
    X_D3DTOP_SELECTARG1: Result := 'D3DTOP_SELECTARG1';
    X_D3DTOP_SELECTARG2: Result := 'D3DTOP_SELECTARG2';
    X_D3DTOP_MODULATE: Result := 'D3DTOP_MODULATE';
    X_D3DTOP_MODULATE2X: Result := 'D3DTOP_MODULATE2X';
    X_D3DTOP_MODULATE4X: Result := 'D3DTOP_MODULATE4X';
    X_D3DTOP_ADD: Result := 'D3DTOP_ADD';
    X_D3DTOP_ADDSIGNED: Result := 'D3DTOP_ADDSIGNED';
    X_D3DTOP_ADDSIGNED2X: Result := 'D3DTOP_ADDSIGNED2X';
    X_D3DTOP_SUBTRACT: Result := 'D3DTOP_SUBTRACT';
    X_D3DTOP_ADDSMOOTH: Result := 'D3DTOP_ADDSMOOTH';
    X_D3DTOP_BLENDDIFFUSEALPHA: Result := 'D3DTOP_BLENDDIFFUSEALPHA';
    X_D3DTOP_BLENDCURRENTALPHA: Result := 'D3DTOP_BLENDCURRENTALPHA';
    X_D3DTOP_BLENDTEXTUREALPHA: Result := 'D3DTOP_BLENDTEXTUREALPHA';
    X_D3DTOP_BLENDFACTORALPHA: Result := 'D3DTOP_BLENDFACTORALPHA';
    X_D3DTOP_BLENDTEXTUREALPHAPM: Result := 'D3DTOP_BLENDTEXTUREALPHAPM';
    X_D3DTOP_PREMODULATE: Result := 'D3DTOP_PREMODULATE';
    X_D3DTOP_MODULATEALPHA_ADDCOLOR: Result := 'D3DTOP_MODULATEALPHA_ADDCOLOR';
    X_D3DTOP_MODULATECOLOR_ADDALPHA: Result := 'D3DTOP_MODULATECOLOR_ADDALPHA';
    X_D3DTOP_MODULATEINVALPHA_ADDCOLOR: Result := 'D3DTOP_MODULATEINVALPHA_ADDCOLOR';
    X_D3DTOP_MODULATEINVCOLOR_ADDALPHA: Result := 'D3DTOP_MODULATEINVCOLOR_ADDALPHA';
    X_D3DTOP_DOTPRODUCT3: Result := 'D3DTOP_DOTPRODUCT3';
    X_D3DTOP_MULTIPLYADD: Result := 'D3DTOP_MULTIPLYADD';
    X_D3DTOP_LERP: Result := 'D3DTOP_LERP';
    X_D3DTOP_BUMPENVMAP: Result := 'D3DTOP_BUMPENVMAP';
    X_D3DTOP_BUMPENVMAPLUMINANCE: Result := 'D3DTOP_BUMPENVMAPLUMINANCE';
  else Result := '';
  end;
end;

function X_D3DVSDE2String(aValue: DWORD): string;
begin
  case {X_D3DVSDE}(aValue) of
    X_D3DVSDE_POSITION     : Result := 'D3DVSDE_POSITION';
    X_D3DVSDE_BLENDWEIGHT  : Result := 'D3DVSDE_BLENDWEIGHT';
    X_D3DVSDE_NORMAL       : Result := 'D3DVSDE_NORMAL';
    X_D3DVSDE_DIFFUSE      : Result := 'D3DVSDE_DIFFUSE';
    X_D3DVSDE_SPECULAR     : Result := 'D3DVSDE_SPECULAR';
    X_D3DVSDE_FOG          : Result := 'D3DVSDE_FOG';
    X_D3DVSDE_POINTSIZE    : Result := 'D3DVSDE_POINTSIZE'; // Dxbx addition
    X_D3DVSDE_BACKDIFFUSE  : Result := 'D3DVSDE_BACKDIFFUSE';
    X_D3DVSDE_BACKSPECULAR : Result := 'D3DVSDE_BACKSPECULAR';
    X_D3DVSDE_TEXCOORD0    : Result := 'D3DVSDE_TEXCOORD0';
    X_D3DVSDE_TEXCOORD1    : Result := 'D3DVSDE_TEXCOORD1';
    X_D3DVSDE_TEXCOORD2    : Result := 'D3DVSDE_TEXCOORD2';
    X_D3DVSDE_TEXCOORD3    : Result := 'D3DVSDE_TEXCOORD3';
    X_D3DVSDE_VERTEX       : Result := 'D3DVSDE_VERTEX';
  else Result := '';
  end;
end;

function X_D3DWRAP2String(aValue: DWORD): string;
begin
  Result := '';
  if (aValue and X_D3DWRAP_U) > 0 then Result := Result + '|D3DWRAP_U';
  if (aValue and X_D3DWRAP_V) > 0 then Result := Result + '|D3DWRAP_V';
  if (aValue and X_D3DWRAP_W) > 0 then Result := Result + '|D3DWRAP_W';
  if Result <> '' then System.Delete(Result, 1, 1);
end;

function EmuXB2PC_D3DCLEAR_FLAGS(Value: DWORD): DWORD;
// Branch:Dxbx  Translator:PatrickvL  Done:100
begin
  Result := 0;

  // Dxbx note : Xbox can clear A,R,G and B independently, but PC has to clear them all :
  if (Value and X_D3DCLEAR_TARGET) > 0 then Result := Result or D3DCLEAR_TARGET;
  if (Value and X_D3DCLEAR_ZBUFFER) > 0 then Result := Result or D3DCLEAR_ZBUFFER;
  if (Value and X_D3DCLEAR_STENCIL) > 0 then Result := Result or D3DCLEAR_STENCIL;
end;

function EmuXB2PC_D3DWRAP(Value: DWORD): DWORD;
// Branch:Dxbx  Translator:PatrickvL  Done:100
begin
  Result := 0;
  if (Value and X_D3DWRAP_U) > 0 then Result := Result or D3DWRAP_U;
  if (Value and X_D3DWRAP_V) > 0 then Result := Result or D3DWRAP_V;
  if (Value and X_D3DWRAP_W) > 0 then Result := Result or D3DWRAP_W;
end;

function EmuXB2PC_D3DCULL(Value: X_D3DCULL): D3DCULL;
// Branch:Dxbx  Translator:PatrickvL  Done:100
begin
  case (Value) of
    X_D3DCULL_NONE: // 0
      Result := D3DCULL_NONE;
    X_D3DCULL_CW: // $900
      Result := D3DCULL_CW;
    X_D3DCULL_CCW: // $901
      Result := D3DCULL_CCW;
  else
    DxbxKrnlCleanup('Unknown Cullmode (%d)', [Ord(Value)]);
    Result := D3DCULL(Value);
  end;
end;

// convert from vertex count to primitive count (Xbox)
function EmuD3DVertex2PrimitiveCount(PrimitiveType: X_D3DPRIMITIVETYPE; VertexCount: int): INT;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  Result := ((VertexCount - EmuD3DVertexToPrimitive[Ord(PrimitiveType)][1]) div EmuD3DVertexToPrimitive[Ord(PrimitiveType)][0]);
end;

// convert from primitive count to vertex count (Xbox)
function EmuD3DPrimitive2VertexCount(PrimitiveType: X_D3DPRIMITIVETYPE; PrimitiveCount: int): int;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  Result := (((PrimitiveCount)*EmuD3DVertexToPrimitive[Ord(PrimitiveType)][0]) + EmuD3DVertexToPrimitive[Ord(PrimitiveType)][1]);
end;

// convert xbox->pc primitive type
function EmuXB2PC_D3DPrimitiveType(PrimitiveType: X_D3DPRIMITIVETYPE): D3DPRIMITIVETYPE;
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
begin
  if DWORD(PrimitiveType) >= Ord(X_D3DPT_MAX) then
    Result := D3DPRIMITIVETYPE($7FFFFFFF)
  else
    Result := EmuPrimitiveTypeLookup[Ord(PrimitiveType)];
end;

procedure EmuUnswizzleRect
(
    pSrcBuff: PVOID;
    dwWidth: DWORD;
    dwHeight: DWORD;
    dwDepth: DWORD;
    pDstBuff: PVOID;
    dwPitch: DWORD;
    rSrc: TRECT;
    poDst: TPOINT;
    dwBPP: DWORD // expressed in Bytes Per Pixel
); {NOPATCH}
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

  // Dxbx note : Translated 'for' to 'while', because counter is shifted instead of incremented :
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

  if dwDepth > 0 then // Dxbx addition, to prevent underflow
  for z := 0 to dwDepth - 1 do
  begin
    dwV := dwSV;

    if dwHeight > 0 then // Dxbx addition, to prevent underflow
    for y := 0 to dwHeight - 1 do
    begin
      dwU := dwSU;

      if dwWidth > 0 then // Dxbx addition, to prevent underflow
      for x := 0 to dwWidth - 1 do
      begin
        memcpy(pDstBuff, @(PByte(pSrcBuff)[(dwU or dwV or dwW)*dwBPP]), dwBPP);
        pDstBuff := PVOID(DWORD(pDstBuff)+dwBPP);

        dwU := (dwU - dwMaskU) and dwMaskU;
      end;
      pDstBuff := PVOID(DWORD(pDstBuff)+(dwPitch-(dwWidth*dwBPP)));
      dwV := (dwV - dwMaskV) and dwMaskV;
    end;
    dwW := (dwW - dwMaskW) and dwMaskW;
  end;
end; // EmuUnswizzleRect NOPATCH

end.

