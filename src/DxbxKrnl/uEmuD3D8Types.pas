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

unit uEmuD3D8Types;

{$INCLUDE Dxbx.inc}

interface

uses
  // Delphi
  Windows,
  // DirectX
  Direct3D8, // D3DADAPTER_IDENTIFIER8, D3DMULTISAMPLE_TYPE
{$IFDEF DXBX_USE_D3D9}
  Direct3D9,
{$ENDIF}
  // Dxbx
  uTypes;

{$IFDEF DXBX_USE_D3D9}
type
  IDirect3D = IDirect3D9;
  IDirect3DBaseTexture = IDirect3DBaseTexture9;
  IDirect3DCubeTexture = IDirect3DCubeTexture9;
  IDirect3DDevice = IDirect3DDevice9;
  IDirect3DIndexBuffer = IDirect3DIndexBuffer9;
  IDirect3DResource = IDirect3DResource9;
  IDirect3DSurface = IDirect3DSurface9;
  IDirect3DTexture = IDirect3DTexture9;
  IDirect3DVertexBuffer = IDirect3DVertexBuffer9;
  IDirect3DVertexShader = IDirect3DVertexShader9;
  IDirect3DVolume = IDirect3DVolume9;
  IDirect3DVolumeTexture = IDirect3DVolumeTexture9;

  PIDirect3DBaseTexture = PIDirect3DBaseTexture9;
  PIDirect3DCubeTexture = PIDirect3DCubeTexture9;
  PIDirect3DDevice = PIDirect3DDevice9;
  PIDirect3DIndexBuffer = PIDirect3DIndexBuffer9;
  PIDirect3DStateBlock = PIDirect3DStateBlock9;
  PIDirect3DSurface = PIDirect3DSurface9;
  PIDirect3DTexture = PIDirect3DTexture9;
  PIDirect3DVertexBuffer = PIDirect3DVertexBuffer9;
  PIDirect3DVolume = PIDirect3DVolume9;
  PIDirect3DVolumeTexture = PIDirect3DVolumeTexture9;

  PD3DMaterial = PD3DMaterial9;

  D3DADAPTER_IDENTIFIER = D3DADAPTER_IDENTIFIER9;
  D3DCAPS = D3DCAPS9;
  D3DVIEWPORT = D3DVIEWPORT9;

  PD3DCAPS = PD3DCAPS9;
  PD3DVIEWPORT = PD3DVIEWPORT9;
  PD3DLIGHT = PD3DLIGHT9;

  TLockData = Pointer;

  // Missing in Direct3D9, so copied over from Direct3D8 :

  _D3DVSD_TOKENTYPE = (
    D3DVSD_TOKEN_NOP        = 0,    // NOP or extension
    D3DVSD_TOKEN_STREAM,            // stream selector
    D3DVSD_TOKEN_STREAMDATA,        // stream data definition (map to vertex input memory)
    D3DVSD_TOKEN_TESSELLATOR,       // vertex input memory from tessellator
    D3DVSD_TOKEN_CONSTMEM,          // constant memory from shader
    D3DVSD_TOKEN_EXT,               // extension
    D3DVSD_TOKEN_END        = 7     // end-of-array (requires all DWORD bits to be 1)

  );

  TD3DVSDTokenType = _D3DVSD_TOKENTYPE;

const
  D3DVSD_TOKENTYPESHIFT         = 29;
  D3DVSD_TOKENTYPEMASK          = (7 shl D3DVSD_TOKENTYPESHIFT);

  D3DVSD_STREAMNUMBERSHIFT      = 0;
  D3DVSD_STREAMNUMBERMASK       = ($F shl D3DVSD_STREAMNUMBERSHIFT);

//  D3DVSD_DATALOADTYPESHIFT      = 28;
//  D3DVSD_DATALOADTYPEMASK       = ($1 shl D3DVSD_DATALOADTYPESHIFT);

  D3DVSD_DATATYPESHIFT          = 16;
  D3DVSD_DATATYPEMASK           = ($F shl D3DVSD_DATATYPESHIFT);

  D3DVSD_SKIPCOUNTSHIFT         = 16;
  D3DVSD_SKIPCOUNTMASK          = ($F shl D3DVSD_SKIPCOUNTSHIFT);

  D3DVSD_VERTEXREGSHIFT         = 0;
  D3DVSD_VERTEXREGMASK          = ($1F shl D3DVSD_VERTEXREGSHIFT);

  D3DVSD_VERTEXREGINSHIFT       = 20;
  D3DVSD_VERTEXREGINMASK        = ($F shl D3DVSD_VERTEXREGINSHIFT);

  D3DVSD_CONSTCOUNTSHIFT        = 25;
  D3DVSD_CONSTCOUNTMASK         = ($F shl D3DVSD_CONSTCOUNTSHIFT);

  D3DVSD_CONSTADDRESSSHIFT      = 0;
  D3DVSD_CONSTADDRESSMASK       = ($7F shl D3DVSD_CONSTADDRESSSHIFT);

  D3DVSD_CONSTRSSHIFT           = 16;
  D3DVSD_CONSTRSMASK            = ($1FFF shl D3DVSD_CONSTRSSHIFT);

//  D3DVSD_EXTCOUNTSHIFT          = 24;
//  D3DVSD_EXTCOUNTMASK           = ($1F shl D3DVSD_EXTCOUNTSHIFT);
//
//  D3DVSD_EXTINFOSHIFT           = 0;
//  D3DVSD_EXTINFOMASK            = ($FFFFFF shl D3DVSD_EXTINFOSHIFT);


  D3DVSD_STREAMTESSSHIFT        = 28;
  D3DVSD_STREAMTESSMASK         = (1 shl D3DVSD_STREAMTESSSHIFT);

  D3DVSDT_FLOAT1      = D3DDECLTYPE_FLOAT1;    // 1D float expanded to (value; 0.; 0.; 1.)
  D3DVSDT_FLOAT2      = D3DDECLTYPE_FLOAT2;    // 2D float expanded to (value; value; 0.; 1.)
  D3DVSDT_FLOAT3      = D3DDECLTYPE_FLOAT3;    // 3D float expanded to (value; value; value; 1.)
  D3DVSDT_FLOAT4      = D3DDECLTYPE_FLOAT4;    // 4D float
  D3DVSDT_D3DCOLOR    = D3DDECLTYPE_D3DCOLOR;  // 4D packed unsigned bytes mapped to 0. to 1. range
                                               // Input is in D3DCOLOR format (ARGB) expanded to (R; G; B; A)
  D3DVSDT_UBYTE4      = D3DDECLTYPE_UBYTE4;    // 4D unsigned byte
  D3DVSDT_SHORT2      = D3DDECLTYPE_SHORT2;    // 2D signed short expanded to (value; value; 0.; 1.)
  D3DVSDT_SHORT4      = D3DDECLTYPE_SHORT4;    // 4D signed short

  // Xbox extensions that are unsupported in D3D8, but have a mapping to D3D9 (with vertex shaders >= 2.0) :
  D3DVSDT_NORMSHORT2  = D3DDECLTYPE_SHORT2N;   // 2D signed, normalized short expanded to (value, value, 0., 1.)
  D3DVSDT_NORMSHORT4  = D3DDECLTYPE_SHORT4N;   // 4D signed, normalized short expanded to (value, value, value, value)
  D3DVSDT_NONE        = D3DDECLTYPE_UNUSED;    // No stream data

const
  // Dxbx note : Dirty little hack : Map the old D3DVSDE values to new D3DDECLUSAGE values,
  // to ease the implementation of Xb2PCRegisterType (which also determines an index for D3D9)
  // Unless otherwise indicated, these are mapped to index 0 in D3D9
  D3DVSDE_POSITION = D3DDECLUSAGE_POSITION;
  // D3DVSDE_POSITION2 = D3DDECLUSAGE_POSITION; // Mapped to index 1 in D3D9, but unused on Xbox.
  D3DVSDE_BLENDWEIGHT = D3DDECLUSAGE_BLENDWEIGHT;
  D3DVSDE_NORMAL = D3DDECLUSAGE_NORMAL;
  // D3DVSDE_NORMAL2 = D3DDECLUSAGE_NORMAL; // Mapped to index 1 in D3D9, but unused on Xbox.
  D3DVSDE_DIFFUSE = D3DDECLUSAGE_COLOR;
  D3DVSDE_SPECULAR = D3DDECLUSAGE_COLOR; // Mapped to index 1 in D3D9
  D3DVSDE_FOG = D3DDECLUSAGE_FOG; // Doesn't exist in D3D8!
  D3DVSDE_TEXCOORD0 = D3DDECLUSAGE_TEXCOORD; // Mapped to index 0 in D3D9
  D3DVSDE_TEXCOORD1 = D3DDECLUSAGE_TEXCOORD; // Mapped to index 1 in D3D9
  D3DVSDE_TEXCOORD2 = D3DDECLUSAGE_TEXCOORD; // Mapped to index 2 in D3D9
  D3DVSDE_TEXCOORD3 = D3DDECLUSAGE_TEXCOORD; // Mapped to index 3 in D3D9
  // D3DVSDE_TEXCOORD4 = ?; // unused on Xbox.
  // D3DVSDE_TEXCOORD5 = ?; // unused on Xbox.
  // D3DVSDE_TEXCOORD6 = ?; // unused on Xbox.
  // D3DVSDE_TEXCOORD7 = ?; // unused on Xbox.
  // D3DVSDE_BLENDINDICES = ?; // unused on Xbox.
  // D3DVSDE_PSIZE = ?; // unused on Xbox.

  D3DRS_FORCE_DWORD               = $7fffffff;

{$ELSE !DXBX_USE_D3D9}
type
  D3DDECLUSAGE = DWORD;

  IDirect3D = IDirect3D8;
  IDirect3DBaseTexture = IDirect3DBaseTexture8;
  IDirect3DCubeTexture = IDirect3DCubeTexture8;
  IDirect3DDevice = IDirect3DDevice8;
  IDirect3DIndexBuffer = IDirect3DIndexBuffer8;
  IDirect3DResource = IDirect3DResource8;
  IDirect3DSurface = IDirect3DSurface8;
  IDirect3DTexture = IDirect3DTexture8;
  IDirect3DVertexBuffer = IDirect3DVertexBuffer8;
  IDirect3DVolume = IDirect3DVolume8;
  IDirect3DVolumeTexture = IDirect3DVolumeTexture8;

  PIDirect3DBaseTexture = PIDirect3DBaseTexture8;
  PIDirect3DCubeTexture = PIDirect3DCubeTexture8;
  PIDirect3DDevice = PIDirect3DDevice8;
  PIDirect3DIndexBuffer = PIDirect3DIndexBuffer8;
  PIDirect3DSurface = PIDirect3DSurface8;
  PIDirect3DTexture = PIDirect3DTexture8;
  PIDirect3DVertexBuffer = PIDirect3DVertexBuffer8;
  PIDirect3DVolume = PIDirect3DVolume8;
  PIDirect3DVolumeTexture = PIDirect3DVolumeTexture8;

  PD3DMaterial = PD3DMaterial8;

  D3DADAPTER_IDENTIFIER = D3DADAPTER_IDENTIFIER8;
  D3DCAPS = D3DCAPS8;
  D3DVIEWPORT = D3DVIEWPORT8;

  PD3DCAPS = PD3DCAPS8;
  PD3DVIEWPORT = PD3DVIEWPORT8;
  PD3DLIGHT = PD3DLIGHT8;

  TLockData = PByte;

  // Direct3D8 has no SamplerStateType, so map it to TextureStageStateType :
  TD3DSamplerStateType = TD3DTextureStageStateType;

const
  D3DSAMP_ADDRESSU = D3DTSS_ADDRESSU;
  D3DSAMP_ADDRESSV = D3DTSS_ADDRESSV;
  D3DSAMP_ADDRESSW = D3DTSS_ADDRESSW;
  D3DSAMP_BORDERCOLOR = D3DTSS_BORDERCOLOR;
  D3DSAMP_MAGFILTER = D3DTSS_MAGFILTER;
  D3DSAMP_MINFILTER = D3DTSS_MINFILTER;
  D3DSAMP_MIPFILTER = D3DTSS_MIPFILTER;
  D3DSAMP_MIPMAPLODBIAS = D3DTSS_MIPMAPLODBIAS;
  D3DSAMP_MAXMIPLEVEL = D3DTSS_MAXMIPLEVEL;
  D3DSAMP_MAXANISOTROPY = D3DTSS_MAXANISOTROPY;

{$ENDIF}

const
  D3DSAMP_UNSUPPORTED = TD3DSamplerStateType(0);
  D3DDECLUSAGE_UNSUPPORTED = D3DDECLUSAGE(-1);

{$IFNDEF DXBX_USE_D3D9}
const
  D3DVSDE_FOG = D3DDECLUSAGE_UNSUPPORTED; // Doesn't exist in D3D8
{$ENDIF}

{$IFDEF DXBX_USE_D3D9}
type PVertexShaderDeclaration = PD3DVertexElement9;
{$ELSE}
type PVertexShaderDeclaration = PDWORD;
{$ENDIF}
type PPVertexShaderDeclaration = ^PVertexShaderDeclaration;

const
  D3DVSD_MASK_TESSUV = $10000000;
  D3DVSD_MASK_SKIP = $10000000; // Skips (normally) dwords
  D3DVSD_MASK_SKIPBYTES = $08000000; // Skips bytes (no, really?!)

type
  // C++ nearly always works with pointer-to-interface, while Delphi's interfaces are already reference-types.
  // To simulate C++ behaviour, define an empty structure here, so we can declare a normal pointer to that as
  // a base for all the following interface-type declarations :
  CInterface = record end;
  // C++ does no reference-counting on interfaces, so translations to Delphi shouldn't do that either;
  // We realize this by using fake interface-types, all based on 'PInterface' which is just a plain pointer :
  PInterface = ^CInterface;

  LPUNKNOWN = type PInterface;

  // Direct3D interface types :

  XTL_PIDirect3D8 = type PInterface;

  XTL_PID3DXBuffer = type PInterface; // TODO -oDxbx: Review all GetBufferPointer calls (and prevent memory-leaks!)

  XTL_PIDirect3DDevice8 = type PInterface;
  XTL_PPIDirect3DDevice8 = ^XTL_PIDirect3DDevice8;

  XTL_PIDirect3DResource8 = type PInterface;
  XTL_PIDirect3DBaseTexture8 = type PInterface;
  XTL_PIDirect3DTexture8 = type PInterface;
  XTL_PIDirect3DVolumeTexture8 = type PInterface;
  XTL_PIDirect3DCubeTexture8 = type PInterface;
  XTL_PIDirect3DSurface8 = type PInterface;
  XTL_PIDirect3DVolume8 = type PInterface;
  XTL_PIDirect3DVertexBuffer8 = type PInterface;
  XTL_PIDirect3DIndexBuffer8 = type PInterface;

  // DirectDraw interface types :

  XTL_PIDirectDraw7 = type PInterface;

  XTL_PIDirectDrawSurface7 = type PInterface;
  XTL_PIDirectDrawClipper = type PInterface;

  // DirectSound interface types :

  XTL_PIDirectSound8 = type PInterface;
  XTL_PIDirectSoundBuffer = type PInterface;
  XTL_PIDirectSoundListener = type PInterface; // Dxbx addition

  XTL_PIDirectSoundBuffer8 = XTL_PIDirectSoundBuffer;

  // DirectInput interface types :

  XTL_PIDirectInput8 = type PInterface;
  XTL_PIDirectInputDevice8 = type PInterface;

  // Long-Pointer aliases :

  XTL_LPD3DXBUFFER = XTL_PID3DXBuffer;
  XTL_PLPD3DXBUFFER = ^XTL_LPD3DXBUFFER;

  XTL_LPDIRECT3D8 = XTL_PIDirect3D8;
  XTL_PLPDIRECT3D8 = ^XTL_LPDIRECT3D8;
  XTL_LPDIRECTDRAW7 = XTL_PIDirectDraw7;
  XTL_LPDIRECT3DDEVICE8 = XTL_PIDirect3DDevice8;
  XTL_LPDIRECTDRAWSURFACE7 = XTL_PIDirectDrawSurface7;
  XTL_LPDIRECTDRAWCLIPPER = XTL_PIDirectDrawClipper;
  XTL_LPDIRECT3DVERTEXBUFFER8 = XTL_PIDirect3DVertexBuffer8;
  XTL_LPDIRECT3DINDEXBUFFER8 = XTL_PIDirect3DIndexBuffer8;

  XTL_LPDIRECTSOUND8 = XTL_PIDirectSound8;
  XTL_PLPDIRECTSOUND8 = ^XTL_LPDIRECTSOUND8;

  XTL_LPDIRECTSOUNDBUFFER = XTL_PIDirectSoundBuffer;

  XTL_LPDIRECTINPUT8 = XTL_PIDirectInput8;
  XTL_LPDIRECTINPUTDEVICE8 = XTL_PIDirectInputDevice8;


// TODO -oCXBX: fill out these enumeration tables for convienance
// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100

type X_D3DMULTISAMPLE_TYPE = (
    X_D3DMULTISAMPLE_NONE = $0011,
    X_D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_LINEAR = $1021,
    X_D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_QUINCUNX = $1121,
    X_D3DMULTISAMPLE_2_SAMPLES_SUPERSAMPLE_HORIZONTAL_LINEAR = $2021,
    X_D3DMULTISAMPLE_2_SAMPLES_SUPERSAMPLE_VERTICAL_LINEAR = $2012,

    X_D3DMULTISAMPLE_4_SAMPLES_MULTISAMPLE_LINEAR = $1022,
    X_D3DMULTISAMPLE_4_SAMPLES_MULTISAMPLE_GAUSSIAN = $1222,
    X_D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_LINEAR = $2022,
    X_D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_GAUSSIAN = $2222,

    X_D3DMULTISAMPLE_9_SAMPLES_MULTISAMPLE_GAUSSIAN = $1233,
    X_D3DMULTISAMPLE_9_SAMPLES_SUPERSAMPLE_GAUSSIAN = $2233
);
type X_D3DSWAPEFFECT = D3DSWAPEFFECT; // Same as on Windows Direct3D


// Dxbx note : Some Xbox types are identical to the Direct3D8 declarations, here these forwards :

type X_D3DCAPS = D3DCAPS8;
type X_PD3DCAPS = PD3DCAPS8;
type X_D3DADAPTER_IDENTIFIER = D3DADAPTER_IDENTIFIER8;


const
(*
  Xbox1 D3DFORMAT notes
  ---------------------

  The Xbox1 D3DFORMAT type consists of 4 different format categories :
  1. Swizzled (improves data locality, incompatible with native Direct3D)
  2. Compressed (DXT compression, giving 4:1 reduction on 4x4 pixel blocks)
  3. Linear (compatible with native Direct3D)
  4. Depth (Fixed or Floating point, stored Linear or Swizzled)

  Requirements\Format      Swizzled  Compressed  Linear  Depth   Notes

  Power-of-two required?   YES       YES         NO      NO
  Mipmap supported?        YES       YES         NO      YES     Linear has MipmapLevels=1
  CubeMaps supported?      YES       YES         NO      NO      Cubemaps have 6 faces
  Supports volumes?        YES       YES         NO      NO      Volumes have 3 dimensions, Textures have 2
  Can be a rendertarget?   YES       YES         YES     LINEAR  Depth buffers can only be rendered to if stored Linear

  Implications :
  - CubeMaps must be square
  - Volumes cannot be cube mapped and vice versa

  Maximum dimensions :
  2D : 4096x4096 (12 mipmap levels)
  3D : 512x512x512 (9 mipmap levels)

*)
  // Xbox D3DFORMAT types :
  // See http://wiki.beyondunreal.com/Legacy:Texture_Format

  // Swizzled Formats

  X_D3DFMT_L8 = $00;
  X_D3DFMT_AL8 = $01;
  X_D3DFMT_A1R5G5B5 = $02;
  X_D3DFMT_X1R5G5B5 = $03;
  X_D3DFMT_A4R4G4B4 = $04;
  X_D3DFMT_R5G6B5 = $05;
  X_D3DFMT_A8R8G8B8 = $06;
  X_D3DFMT_X8R8G8B8 = $07;
  X_D3DFMT_X8L8V8U8 = $07; // Alias
  X_D3DFMT_P8 = $0B; // 8-bit Palletized
  X_D3DFMT_A8 = $19;
  X_D3DFMT_A8L8 = $1A;
  X_D3DFMT_R6G5B5 = $27;
  X_D3DFMT_L6V5U5 = $27; // Alias
  X_D3DFMT_G8B8 = $28;
  X_D3DFMT_V8U8 = $28; // Alias
  X_D3DFMT_R8B8 = $29;
  X_D3DFMT_D24S8 = $2A;
  X_D3DFMT_F24S8 = $2B;
  X_D3DFMT_D16 = $2C;
  X_D3DFMT_D16_LOCKABLE = $2C; // Alias
  X_D3DFMT_F16 = $2D;
  X_D3DFMT_L16 = $32;
  X_D3DFMT_V16U16 = $33;
  X_D3DFMT_R5G5B5A1 = $38;
  X_D3DFMT_R4G4B4A4 = $39;
  X_D3DFMT_A8B8G8R8 = $3A;
  X_D3DFMT_Q8W8V8U8 = $3A; // Alias
  X_D3DFMT_B8G8R8A8 = $3B;
  X_D3DFMT_R8G8B8A8 = $3C;

  // YUV Formats

  X_D3DFMT_YUY2 = $24;
  X_D3DFMT_UYVY = $25;

  // Compressed Formats

  X_D3DFMT_DXT1 = $0C; // opaque/one-bit alpha
  X_D3DFMT_DXT2 = $0E;
  X_D3DFMT_DXT3 = $0E; // linear alpha
  X_D3DFMT_DXT4 = $0F;
  X_D3DFMT_DXT5 = $0F; // interpolated alpha

  // Linear Formats

  X_D3DFMT_LIN_A1R5G5B5 = $10;
  X_D3DFMT_LIN_R5G6B5 = $11;
  X_D3DFMT_LIN_A8R8G8B8 = $12;
  X_D3DFMT_LIN_L8 = $13;
  X_D3DFMT_LIN_R8B8 = $16;
  X_D3DFMT_LIN_G8B8 = $17;
  X_D3DFMT_LIN_V8U8 = $17; // Alias
  X_D3DFMT_LIN_AL8 = $1B;
  X_D3DFMT_LIN_X1R5G5B5 = $1C;
  X_D3DFMT_LIN_A4R4G4B4 = $1D;
  X_D3DFMT_LIN_X8R8G8B8 = $1E;
  X_D3DFMT_LIN_X8L8V8U8 = $1E; // Alias
  X_D3DFMT_LIN_A8 = $1F;
  X_D3DFMT_LIN_A8L8 = $20;
  X_D3DFMT_LIN_D24S8 = $2E;
  X_D3DFMT_LIN_F24S8 = $2F;
  X_D3DFMT_LIN_D16 = $30;
  X_D3DFMT_LIN_F16 = $31;
  X_D3DFMT_LIN_L16 = $35;
  X_D3DFMT_LIN_V16U16 = $36;
  X_D3DFMT_LIN_R6G5B5 = $37;
  X_D3DFMT_LIN_L6V5U5 = $37; // Alias
  X_D3DFMT_LIN_R5G5B5A1 = $3D;
  X_D3DFMT_LIN_R4G4B4A4 = $3E;
  X_D3DFMT_LIN_A8B8G8R8 = $3F;
  X_D3DFMT_LIN_B8G8R8A8 = $40;
  X_D3DFMT_LIN_R8G8B8A8 = $41;

  X_D3DFMT_VERTEXDATA = $64;

  X_D3DFMT_INDEX16 = DWord(D3DFMT_INDEX16); // Dxbx addition : Not an Xbox format, used internally

  X_D3DFMT_UNKNOWN = $FFFFFFFF-3;  // Unique declaration to make overloads possible

type X_D3DFORMAT = X_D3DFMT_L8..X_D3DFMT_UNKNOWN;
type PX_D3DFORMAT = ^X_D3DFORMAT;

type X_D3DPOOL = D3DPOOL; // alias

type X_D3DSHADEMODE = (
  X_D3DSHADE_FLAT               = $1d00,
  X_D3DSHADE_GOURAUD            = $1d01,
  X_D3DSHADE_FORCE_DWORD        = $7fffffff
);

type X_D3DFILLMODE = (
  X_D3DFILL_POINT              = $1b00,
  X_D3DFILL_WIREFRAME          = $1b01,
  X_D3DFILL_SOLID              = $1b02,
  X_D3DFILL_FORCE_DWORD        = $7fffffff
);

type X_D3DBLEND = (
  X_D3DBLEND_ZERO               = 0,
  X_D3DBLEND_ONE                = 1,
  X_D3DBLEND_SRCCOLOR           = $300,
  X_D3DBLEND_INVSRCCOLOR        = $301,
  X_D3DBLEND_SRCALPHA           = $302,
  X_D3DBLEND_INVSRCALPHA        = $303,
  X_D3DBLEND_DESTALPHA          = $304,
  X_D3DBLEND_INVDESTALPHA       = $305,
  X_D3DBLEND_DESTCOLOR          = $306,
  X_D3DBLEND_INVDESTCOLOR       = $307,
  X_D3DBLEND_SRCALPHASAT        = $308,
  X_D3DBLEND_CONSTANTCOLOR      = $8001,
  X_D3DBLEND_INVCONSTANTCOLOR   = $8002,
  X_D3DBLEND_CONSTANTALPHA      = $8003,
  X_D3DBLEND_INVCONSTANTALPHA   = $8004,
  X_D3DBLEND_FORCE_DWORD        = $7fffffff
);

type X_D3DBLENDOP = (
  X_D3DBLENDOP_ADD              = $8006,
  X_D3DBLENDOP_SUBTRACT         = $800a,
  X_D3DBLENDOP_REVSUBTRACT      = $800b,
  X_D3DBLENDOP_MIN              = $8007,
  X_D3DBLENDOP_MAX              = $8008,
  X_D3DBLENDOP_ADDSIGNED        = $f006,       // Xbox ext.
  X_D3DBLENDOP_REVSUBTRACTSIGNED= $f005,       // Xbox ext.
  X_D3DBLENDOP_FORCE_DWORD      = $7fffffff
);

type X_D3DCULL = (
  X_D3DCULL_NONE                = 0,    // No culling
  X_D3DCULL_CW                  = $900, // Clockwise culling
  X_D3DCULL_CCW                 = $901, // Cull counter clockwise triangles
  X_D3DCULL_FORCE_DWORD         = $7fffffff
);

type X_D3DFRONT = ( // Xbox ext.
  X_D3DFRONT_CW                 = $900,
  X_D3DFRONT_CCW                = $901,
  X_D3DFRONT_FORCE_DWORD        = $7fffffff
);

type X_D3DCMPFUNC = (
  X_D3DCMP_NEVER                = $200,
  X_D3DCMP_LESS                 = $201,
  X_D3DCMP_EQUAL                = $202,
  X_D3DCMP_LESSEQUAL            = $203,
  X_D3DCMP_GREATER              = $204,
  X_D3DCMP_NOTEQUAL             = $205,
  X_D3DCMP_GREATEREQUAL         = $206,
  X_D3DCMP_ALWAYS               = $207,
  X_D3DCMP_FORCE_DWORD          = $7fffffff
);

type X_D3DSTENCILOP = (
  X_D3DSTENCILOP_ZERO           = 0,
  X_D3DSTENCILOP_KEEP           = $1e00,
  X_D3DSTENCILOP_REPLACE        = $1e01,
  X_D3DSTENCILOP_INCRSAT        = $1e02,
  X_D3DSTENCILOP_DECRSAT        = $1e03,
  X_D3DSTENCILOP_INVERT         = $150a,
  X_D3DSTENCILOP_INCR           = $8507,
  X_D3DSTENCILOP_DECR           = $8508,
  X_D3DSTENCILOP_FORCE_DWORD    = $7fffffff
);

type X_D3DSWATHWIDTH = ( // Xbox ext
  X_D3DSWATH_8                  = 0,
  X_D3DSWATH_16                 = 1,
  X_D3DSWATH_32                 = 2,
  X_D3DSWATH_64                 = 3,
  X_D3DSWATH_128                = 4,
  X_D3DSWATH_OFF                = $f,
  X_D3DSWATH_FORCE_DWORD        = $7fffffff
);

type X_D3DFOGMODE = (
  X_D3DFOG_NONE                 = 0,
  X_D3DFOG_EXP                  = 1,
  X_D3DFOG_EXP2                 = 2,
  X_D3DFOG_LINEAR               = 3,
  X_D3DFOG_FORCE_DWORD          = $7fffffff
);

type X_D3DLOGICOP = ( // Xbox ext.
  X_D3DLOGICOP_NONE             = 0,
  X_D3DLOGICOP_CLEAR            = $1500,
  X_D3DLOGICOP_AND              = $1501,
  X_D3DLOGICOP_AND_REVERSE      = $1502,
  X_D3DLOGICOP_COPY             = $1503,
  X_D3DLOGICOP_AND_INVERTED     = $1504,
  X_D3DLOGICOP_NOOP             = $1505,
  X_D3DLOGICOP_XOR              = $1506,
  X_D3DLOGICOP_OR               = $1507,
  X_D3DLOGICOP_NOR              = $1508,
  X_D3DLOGICOP_EQUIV            = $1509,
  X_D3DLOGICOP_INVERT           = $150a,
  X_D3DLOGICOP_OR_REVERSE       = $150b,
  X_D3DLOGICOP_COPY_INVERTED    = $150c,
  X_D3DLOGICOP_OR_INVERTED      = $150d,
  X_D3DLOGICOP_NAND             = $150e,
  X_D3DLOGICOP_SET              = $150f,
  X_D3DLOGICOP_FORCE_DWORD      = $7fffffff
);

type X_D3DTEXTURESTAGESTATETYPE = 0..High(DWORD)-2; // Unique declaration to make overloads possible;
type X_D3DTEXTUREOP = DWORD;
type X_D3DRENDERSTATETYPE = DWORD;
type X_D3DCOLORWRITEENABLE = DWORD;
type X_D3DCALLBACK = PVOID;
type X_NV2AMETHOD = 0..High(DWORD)-1; // Kind of strange declaration, needed to

// Values for material source
type X_D3DMATERIALCOLORSOURCE = (
  X_D3DMCS_MATERIAL         = 0,            // Color from material is used
  X_D3DMCS_COLOR1           = 1,            // Diffuse vertex color is used
  X_D3DMCS_COLOR2           = 2,            // Specular vertex color is used
  X_D3DMCS_FORCE_DWORD      = $7fffffff
);

// Flags for D3DRS_DEPTHCLIPCONTROL renderstate (Xbox ext.)
const X_D3DDCC_CULLPRIMITIVE = $001;
const X_D3DDCC_CLAMP         = $010;
const X_D3DDCC_IGNORE_W_SIGN = $100;

type X_D3DMULTISAMPLEMODE = (
  X_D3DMULTISAMPLEMODE_1X          = 0,
  X_D3DMULTISAMPLEMODE_2X          = 1,
  X_D3DMULTISAMPLEMODE_4X          = 2,
  X_D3DMULTISAMPLEMODE_FORCE_DWORD = $7fffffff
);

const X_D3DSAMPLEALPHA_TOCOVERAGE = $0010;
const X_D3DSAMPLEALPHA_TOONE      = $0100;

const X_D3DVSD_DATATYPESHIFT = 16;

// Primitives supported by draw-primitive API
// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100
type _X_D3DPRIMITIVETYPE =
(
    X_D3DPT_NONE = 0, // Dxbx addition

    X_D3DPT_POINTLIST = 1,
    X_D3DPT_LINELIST = 2,
    X_D3DPT_LINELOOP = 3, // Xbox only
    X_D3DPT_LINESTRIP = 4,
    X_D3DPT_TRIANGLELIST = 5,
    X_D3DPT_TRIANGLESTRIP = 6,
    X_D3DPT_TRIANGLEFAN = 7,
    X_D3DPT_QUADLIST = 8, // Xbox only
    X_D3DPT_QUADSTRIP = 9, // Xbox only
    X_D3DPT_POLYGON = 10, // Xbox only

    X_D3DPT_MAX = 11,
    X_D3DPT_INVALID = $7FFFFFFF
);
X_D3DPRIMITIVETYPE = _X_D3DPRIMITIVETYPE;

type X_D3DTRANSFORMSTATETYPE = (
  X_D3DTS_VIEW          = 0,
  X_D3DTS_PROJECTION    = 1,
  X_D3DTS_TEXTURE0      = 2,
  X_D3DTS_TEXTURE1      = 3,
  X_D3DTS_TEXTURE2      = 4,
  X_D3DTS_TEXTURE3      = 5,
  X_D3DTS_WORLD         = 6,
  X_D3DTS_WORLD1        = 7,
  X_D3DTS_WORLD2        = 8,
  X_D3DTS_WORLD3        = 9,

  X_D3DTS_MAX           = 10, // Unused on Xbox
  X_D3DTS_FORCE_DWORD   = $7fffffff
);

// Branch:shogun  Revision:0.8.1-Pre2  Translator:PatrickvL  Done:100
type _X_D3DRESOURCETYPE =
(
    X_D3DRTYPE_NONE = 0,
    X_D3DRTYPE_SURFACE = 1,       // = D3DRESOURCETYPE.D3DRTYPE_SURFACE
    X_D3DRTYPE_VOLUME = 2,        // = D3DRESOURCETYPE.D3DRTYPE_VOLUME
    X_D3DRTYPE_TEXTURE = 3,       // = D3DRESOURCETYPE.D3DRTYPE_TEXTURE
    X_D3DRTYPE_VOLUMETEXTURE = 4, // = D3DRESOURCETYPE.D3DRTYPE_VOLUMETEXTURE
    X_D3DRTYPE_CUBETEXTURE = 5,   // = D3DRESOURCETYPE.D3DRTYPE_CUBETEXTURE
    X_D3DRTYPE_VERTEXBUFFER = 6,  // = D3DRESOURCETYPE.D3DRTYPE_VERTEXBUFFER
    X_D3DRTYPE_INDEXBUFFER = 7,   // = D3DRESOURCETYPE.D3DRTYPE_INDEXBUFFER
    X_D3DRTYPE_PUSHBUFFER = 8,
    X_D3DRTYPE_PALETTE = 9,
    X_D3DRTYPE_FIXUP = 10,

    X_D3DRTYPE_FORCE_DWORD = $7FFFFFFF
);
X_D3DRESOURCETYPE = _X_D3DRESOURCETYPE;

const X_D3DPRESENTFLAG_LOCKABLE_BACKBUFFER = $00000001;
const X_D3DPRESENTFLAG_INTERLACED          = $00000020;
const X_D3DPRESENTFLAG_FIELD               = $00000080;

// D3DUSAGE values (all but the Xbox extensions match the PC versions) :
const X_D3DUSAGE_RENDERTARGET           = $00000001;
const X_D3DUSAGE_DEPTHSTENCIL           = $00000002;
// for Vertex/Index buffers
const X_D3DUSAGE_WRITEONLY              = $00000008;
const X_D3DUSAGE_POINTS                 = $00000040;
const X_D3DUSAGE_RTPATCHES              = $00000080;
const X_D3DUSAGE_DYNAMIC                = $00000200;
// for CreateVertexShader
const X_D3DUSAGE_PERSISTENTDIFFUSE      = $00000400;   // Xbox ext.
const X_D3DUSAGE_PERSISTENTSPECULAR     = $00000800;   // Xbox ext.
const X_D3DUSAGE_PERSISTENTBACKDIFFUSE  = $00001000;   // Xbox ext.
const X_D3DUSAGE_PERSISTENTBACKSPECULAR = $00002000;   // Xbox ext.
// for CreateTexture/CreateImageSurface
const X_D3DUSAGE_BORDERSOURCE_COLOR     = $00000000;   // Xbox ext.
const X_D3DUSAGE_BORDERSOURCE_TEXTURE   = $00010000;   // Xbox ext.


type X_D3DVERTEXBLENDFLAGS= (
    X_D3DVBF_DISABLE           = 0,     // Disable vertex blending
    X_D3DVBF_1WEIGHTS          = 1,     // 2 matrix blending
    X_D3DVBF_2WEIGHTS2MATRICES = 2,     // Xbox ext. nsp.
    X_D3DVBF_2WEIGHTS          = 3,     // 3 matrix blending
    X_D3DVBF_3WEIGHTS3MATRICES = 4,     // Xbox ext. nsp.
    X_D3DVBF_3WEIGHTS          = 5,     // 4 matrix blending
    X_D3DVBF_4WEIGHTS4MATRICES = 6,     // Xbox ext. nsp.

    X_D3DVBF_MAX               = 7,
    X_D3DVBF_FORCE_DWORD       = $7fffffff
);

type _D3DCOPYRECTCOLORFORMAT = (
    D3DCOPYRECT_COLOR_FORMAT_DEFAULT                 = 0,
    D3DCOPYRECT_COLOR_FORMAT_Y8                      = 1,
    D3DCOPYRECT_COLOR_FORMAT_X1R5G5B5_Z1R5G5B5       = 2,
    D3DCOPYRECT_COLOR_FORMAT_X1R5G5B5_O1R5G5B5       = 3,
    D3DCOPYRECT_COLOR_FORMAT_R5G6B5                  = 4,
    D3DCOPYRECT_COLOR_FORMAT_Y16                     = 5,
    D3DCOPYRECT_COLOR_FORMAT_X8R8G8B8_Z8R8G8B8       = 6,
    D3DCOPYRECT_COLOR_FORMAT_X8R8G8B8_O8R8G8B8       = 7,
    D3DCOPYRECT_COLOR_FORMAT_X1A7R8G8B8_Z1A7R8G8B8   = 8,
    D3DCOPYRECT_COLOR_FORMAT_X1A7R8G8B8_O1A7R8G8B8   = 9,
    D3DCOPYRECT_COLOR_FORMAT_A8R8G8B8                = 10,
    D3DCOPYRECT_COLOR_FORMAT_Y32                     = 11,
    D3DCOPYRECT_COLOR_FORMAT_FORCE_DWORD             = $7fffffff //* force 32-bit size enum */
);
D3DCOPYRECTCOLORFORMAT = _D3DCOPYRECTCOLORFORMAT;
PD3DCOPYRECTCOLORFORMAT = ^D3DCOPYRECTCOLORFORMAT;

type _D3DCOPYRECTOPERATION =
(
    D3DCOPYRECT_SRCCOPY_AND         = 0,
    D3DCOPYRECT_ROP_AND             = 1,
    D3DCOPYRECT_BLEND_AND           = 2,
    D3DCOPYRECT_SRCCOPY             = 3,
    D3DCOPYRECT_SRCCOPY_PREMULT     = 4,
    D3DCOPYRECT_BLEND_PREMULT       = 5,
    D3DCOPYRECT_FORCE_DWORD         = $7fffffff // force 32-bit size enum */
);
D3DCOPYRECTOPERATION = _D3DCOPYRECTOPERATION;
PD3DCOPYRECTOPERATION = ^D3DCOPYRECTOPERATION;

type _D3DCOPYRECTSTATE = record
    ColorFormat: D3DCOPYRECTCOLORFORMAT;
    Operation: D3DCOPYRECTOPERATION;

    ColorKeyEnable: BOOL;
    ColorKeyValue: DWORD;

    // D3DCOPYRECT_BLEND_AND alpha value
    // The VALUE_FRACTION bits (30:21) contain the 10 bit unsigned fraction of the alpha value.
    // The VALUE bits (31:31) contain the 1 bit signed integer of the alpha value.
    BlendAlpha: DWORD;

    // D3DCOPYRECT_*_PREMULT alpha value
    // Contains an alpha value for all four channels.
    PremultAlpha: DWORD;

    // Clipping Rect
    ClippingPoint: DWORD;    // y_x S16_S16
    ClippingSize: DWORD ;     // height_width U16_U16

  end;
  D3DCOPYRECTSTATE = _D3DCOPYRECTSTATE;
  PD3DCOPYRECTSTATE = ^D3DCOPYRECTSTATE;

type _D3DCOPYRECTROPSTATE = record            // Xbox extension
    Rop: DWORD;              // Ternary raster operation.
                            //   DSTINVERT:0x55, SRCCOPY:0xCC,
                            //   SRCPAINT:0xEE, SRCINVERT:0x66,
                            //   ...

    Shape: DWORD;            // 0:8X_8Y, 1:64X_1Y, 2:1X_64Y
    PatternSelect: DWORD;    // 1:monochrome, 2:color

    MonoColor0: DWORD;       // Color to use when bit is "0"
    MonoColor1: DWORD;       // Color to use when bit is "1"

    MonoPattern0: DWORD;     // 8x8 = 64 bit pattern
    MonoPattern1: DWORD;     //

    ColorPattern: PDWORD;       // Color Pattern used if PatternSelect == color
                                // 32-bit: Array of 64 DWORDS
                                // 16-bit: Array of 32 DWORDS
  end;
  D3DCOPYRECTROPSTATE  =_D3DCOPYRECTROPSTATE;
  PD3DCOPYRECTROPSTATE = ^D3DCOPYRECTROPSTATE;

type _X_D3DDISPLAYMODE = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    Width: UINT;
    Height: UINT;
    RefreshRate: UINT;
    Flags: DWORD;
    Format: X_D3DFORMAT;
  end; // size = 20 (as in Cxbx)
  X_D3DDISPLAYMODE = _X_D3DDISPLAYMODE;
  PX_D3DDISPLAYMODE = ^X_D3DDISPLAYMODE;

type _X_D3DSURFACE_DESC = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    Format: X_D3DFORMAT;
    Type_: X_D3DRESOURCETYPE;
    Usage: DWORD;
    Size: UINT;
    MultiSampleType: X_D3DMULTISAMPLE_TYPE;
    Width: UINT;
    Height: UINT;
  end; // size = 28 (as in Cxbx)
  X_D3DSURFACE_DESC = _X_D3DSURFACE_DESC;
  PX_D3DSURFACE_DESC = ^X_D3DSURFACE_DESC;

type _X_D3DVOLUME_DESC = record
    Format: X_D3DFORMAT;
    Type_: X_D3DRESOURCETYPE;
    Usage: DWORD;
    Size: UINT;
    Width: UINT;
    Height: UINT;
    Depth: UINT;
  end;
  X_D3DVOLUME_DESC = _X_D3DVOLUME_DESC;
  PX_D3DVOLUME_DESC = ^X_D3DVOLUME_DESC;

type _X_D3DPRESENT_PARAMETERS = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    BackBufferWidth: UINT;
    BackBufferHeight: UINT;
    BackBufferFormat: X_D3DFORMAT;
    BackBufferCount: UINT;

    MultiSampleType: X_D3DMULTISAMPLE_TYPE;

    SwapEffect: X_D3DSWAPEFFECT;
    hDeviceWindow: HWND;
    Windowed: BOOL_;
    EnableAutoDepthStencil: BOOL;
    AutoDepthStencilFormat: X_D3DFORMAT;
    Flags: DWORD;

    FullScreen_RefreshRateInHz: UINT;
    FullScreen_PresentationInterval: UINT;
    // The Windows DirectX8 variant ends here
    // This check guarantees identical layout, compared to Direct3D8._D3DPRESENT_PARAMETERS_:
    // Assert(Integer(@(PX_D3DPRESENT_PARAMETERS(nil).BufferSurfaces[0])) = SizeOf(_D3DPRESENT_PARAMETERS_));
    BufferSurfaces: array [0..3-1] of XTL_PIDirect3DSurface8;
    DepthStencilSurface: XTL_PIDirect3DSurface8;
  end; // size = 68 (as in Cxbx)
  X_D3DPRESENT_PARAMETERS = _X_D3DPRESENT_PARAMETERS;
  PX_D3DPRESENT_PARAMETERS = ^X_D3DPRESENT_PARAMETERS;

type _X_D3DGAMMARAMP = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    Red: array [0..256-1] of BYTE;
    Green: array [0..256-1] of BYTE;
    Blue: array [0..256-1] of BYTE;
  end; // size = 768 (as in Cxbx)
  X_D3DGAMMARAMP = _X_D3DGAMMARAMP;
  PX_D3DGAMMARAMP = ^X_D3DGAMMARAMP;

const X_PIXELSHADER_FAKE_HANDLE = $DEADBEEF;

type _X_D3DVertexShader = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    {union}case Integer of
     0: ( UnknownA: DWORD);
     1: ( Handle: DWORD;
    UnknownB: DWORD;
    Flags: DWORD;
    UnknownC: array [0..$59-1] of DWORD;
    ); // union
  end; // size = 368 (as in Cxbx)
  X_D3DVertexShader = _X_D3DVertexShader;
  PX_D3DVertexShader = ^X_D3DVertexShader;

const
  D3DVS_XBOX_RESERVEDXYZRHWSLOTS = 12;
  D3DVS_XBOX_NR_ADDRESS_SLOTS = 136;

type _X_D3DPIXELSHADERDEF = record // <- blueshogun 10/1/07
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    {0x000}PSAlphaInputs: array [0..8-1] of DWORD;  // X_D3DRS_PSALPHAINPUTS0..X_D3DRS_PSALPHAINPUTS7 : Alpha inputs for each stage
    {0x020}PSFinalCombinerInputsABCD: DWORD;        // X_D3DRS_PSFINALCOMBINERINPUTSABCD : Final combiner inputs
    {0x024}PSFinalCombinerInputsEFG: DWORD;         // X_D3DRS_PSFINALCOMBINERINPUTSEFG : Final combiner inputs (continued)
    {0x028}PSConstant0: array [0..8-1] of DWORD;    // X_D3DRS_PSCONSTANT0_0..X_D3DRS_PSCONSTANT0_7 : C0 for each stage
    {0x048}PSConstant1: array [0..8-1] of DWORD;    // X_D3DRS_PSCONSTANT1_0..X_D3DRS_PSCONSTANT1_7 : C1 for each stage
    {0x068}PSAlphaOutputs: array [0..8-1] of DWORD; // X_D3DRS_PSALPHAOUTPUTS0..X_D3DRS_PSALPHAOUTPUTS7 : Alpha output for each stage
    {0x088}PSRGBInputs: array [0..8-1] of DWORD;    // X_D3DRS_PSRGBINPUTS0..X_D3DRS_PSRGBINPUTS7 : RGB inputs for each stage
    {0x0A8}PSCompareMode: DWORD;                    // X_D3DRS_PSCOMPAREMODE : Compare modes for clipplane texture mode
    {0x0AC}PSFinalCombinerConstant0: DWORD;         // X_D3DRS_PSFINALCOMBINERCONSTANT0 : C0 in final combiner
    {0x0B0}PSFinalCombinerConstant1: DWORD;         // X_D3DRS_PSFINALCOMBINERCONSTANT1 : C1 in final combiner
    {0x0B4}PSRGBOutputs: array [0..8-1] of DWORD;   // X_D3DRS_PSRGBOUTPUTS0..X_D3DRS_PSRGBOUTPUTS7 : Stage 0-7 RGB outputs
    {0x0D4}PSCombinerCount: DWORD;                  // X_D3DRS_PSCOMBINERCOUNT : Active combiner count (Stages 0-7)
    {0x0D8}PSTextureModes: DWORD;                   // X_D3DRS_PSTEXTUREMODES: Texture addressing modes
    {0x0DC}PSDotMapping: DWORD;                     // X_D3DRS_PSDOTMAPPING : Input mapping for dot product modes
    {0x0E0}PSInputTexture: DWORD;                   // X_D3DRS_PSINPUTTEXTURE : Texture source for some texture modes

    // These last three DWORDs are used to define how Direct3D8 pixel shader constants map to the constant
    // registers in each combiner stage. They are used by the Direct3D run-time software but not by the hardware.
    {0x0E4}PSC0Mapping: DWORD;                      // Mapping of c0 regs to D3D constants
    {0x0E8}PSC1Mapping: DWORD;                      // Mapping of c1 regs to D3D constants
    {0x0EC}PSFinalCombinerConstants: DWORD;         // Final combiner constant mapping
  end; // size = $F0=240 (as in Cxbx)
  X_D3DPIXELSHADERDEF = _X_D3DPIXELSHADERDEF;
  PX_D3DPIXELSHADERDEF = ^X_D3DPIXELSHADERDEF;


type X_D3DPixelShader = record
    RefCount: DWORD;
    Flags: DWORD;
    PshDef: PX_D3DPIXELSHADERDEF;
  end;
  PX_D3DPixelShader = ^X_D3DPixelShader;

type _STREAM_DYNAMIC_PATCH_ = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    NeedPatch: BOOL_;       // This is to know whether it's data which must be patched
    ConvertedStride: DWORD;
    NbrTypes: DWORD;        // Number of the stream data types
    pTypes: PUINTs;         // The stream data types (xbox)
    pSizes: PUINTs;         // The stream data sizes (pc)
  end; // size = 16 (as in Cxbx)
  STREAM_DYNAMIC_PATCH = _STREAM_DYNAMIC_PATCH_;
  PSTREAM_DYNAMIC_PATCH = ^STREAM_DYNAMIC_PATCH;

  TSTREAM_DYNAMIC_PATCHArray = array [0..MaxInt div SizeOf(STREAM_DYNAMIC_PATCH) - 1] of STREAM_DYNAMIC_PATCH;
  PSTREAM_DYNAMIC_PATCHs = ^TSTREAM_DYNAMIC_PATCHArray;

type _VERTEX_DYNAMIC_PATCH_ = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    NbrStreams: UINT; // The number of streams the vertex shader uses
    pStreamPatches: PSTREAM_DYNAMIC_PATCHs;
  end; // size = 8 (as in Cxbx)
  VERTEX_DYNAMIC_PATCH = _VERTEX_DYNAMIC_PATCH_;
  PVERTEX_DYNAMIC_PATCH = ^VERTEX_DYNAMIC_PATCH;

type _VERTEX_SHADER = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    Handle: DWORD;
    // These are the parameters given by the XBE,
    // we save them to be able to return them when necessary.
    Size: UINT;
    pDeclaration: PDWORD;
{$IFDEF DXBX_USE_D3D9}
    hRecompiledDeclaration: DWORD;
{$ENDIF}
    DeclarationSize: DWORD;
    pFunction: PDWORD;
    FunctionSize: DWORD;
    Type_: DWORD;
    Status: DWORD;
    // Needed for dynamic stream patching
    VertexDynamicPatch: VERTEX_DYNAMIC_PATCH;
  end; // size = 40 (as in Cxbx)
  VERTEX_SHADER = _VERTEX_SHADER;
  PVERTEX_SHADER = ^VERTEX_SHADER;

type X_D3DResource = object
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  public
    Common: DWORD;
    Data: DWORD;
    Emu: record {union}case Integer of
    0: (Lock: DWORD);
    1: ({Emu}Resource: XTL_PIDirect3DResource8);
    2: ({Emu}BaseTexture: XTL_PIDirect3DBaseTexture8);
    3: ({Emu}Texture: XTL_PIDirect3DTexture8);
    4: ({Emu}VolumeTexture: XTL_PIDirect3DVolumeTexture8);
    5: ({Emu}CubeTexture: XTL_PIDirect3DCubeTexture8);
    6: ({Emu}Surface: XTL_PIDirect3DSurface8);
    7: ({Emu}VertexBuffer: XTL_PIDirect3DVertexBuffer8);
    8: ({Emu}IndexBuffer: XTL_PIDirect3DIndexBuffer8);
    9: ({Emu}Volume: XTL_PIDirect3DVolume8); // Dxbx addition
    end; // union
  end; // size = 12 (as in Cxbx)
  PX_D3DResource = ^X_D3DResource;

// D3D resource "common" masks
const X_D3DCOMMON_REFCOUNT_MASK      = $0000FFFF;
const X_D3DCOMMON_TYPE_MASK          = $00070000;
const X_D3DCOMMON_TYPE_SHIFT         = 16;
const X_D3DCOMMON_TYPE_VERTEXBUFFER  = $00000000;
const X_D3DCOMMON_TYPE_INDEXBUFFER   = $00010000;
const X_D3DCOMMON_TYPE_PUSHBUFFER    = $00020000;
const X_D3DCOMMON_TYPE_PALETTE       = $00030000;
const X_D3DCOMMON_TYPE_TEXTURE       = $00040000;
const X_D3DCOMMON_TYPE_SURFACE       = $00050000; // Also covers Volume resources
const X_D3DCOMMON_TYPE_FIXUP         = $00060000;
const X_D3DCOMMON_INTREFCOUNT_MASK   = $00780000;
const X_D3DCOMMON_INTREFCOUNT_SHIFT  = 19;
const X_D3DCOMMON_INTREFCOUNT_1      = (1 shl X_D3DCOMMON_INTREFCOUNT_SHIFT); // Dxbx addition
const X_D3DCOMMON_VIDEOMEMORY        = $00800000; // Not used.
const X_D3DCOMMON_D3DCREATED         = $01000000;
const X_D3DCOMMON_ISLOCKED           = $02000000; // Surface is currently locked (potential unswizzle candidate)
const X_D3DCOMMON_UNUSED_MASK        = $FC000000;
const X_D3DCOMMON_UNUSED_SHIFT       = 25;

// Lock flags
const X_D3DLOCK_NOFLUSH  = $00000010; // Xbox extension
const X_D3DLOCK_NOOVERWRITE = $00000020;
const X_D3DLOCK_TILED = $00000040; // Xbox extension
const X_D3DLOCK_READONLY = $00000080;

type X_D3DVertexBuffer = object(X_D3DResource)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  public
  end; // size = 12 (as in Cxbx)
  PX_D3DVertexBuffer = ^X_D3DVertexBuffer;
  PPX_D3DVertexBuffer = ^PX_D3DVertexBuffer;

type X_D3DIndexBuffer = object(X_D3DResource)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  public
  end; // size = 12 (as in Cxbx)
  PX_D3DIndexBuffer = ^X_D3DIndexBuffer;
  PPX_D3DIndexBuffer = ^PX_D3DIndexBuffer;

type X_D3DPushBuffer = object(X_D3DResource)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  public
    Size: ULONG;
    AllocationSize: ULONG;
  end; // size = 20 (as in Cxbx)
  PX_D3DPushBuffer = ^X_D3DPushBuffer;
  PPX_D3DPushBuffer = ^PX_D3DPushBuffer;

type X_D3DFixup = object(X_D3DResource)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  public
    Run: ULONG;
    Next: ULONG;
    Size: ULONG;
  end; // size = 24 (as in Cxbx)
  PX_D3DFixup = ^X_D3DFixup;
  PPX_D3DFixup = ^PX_D3DFixup;

type X_D3DPalette = object(X_D3DResource)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  end; // size = 12 (as in Cxbx)
  PX_D3DPalette = ^X_D3DPalette;
  PPX_D3DPalette = ^PX_D3DPalette;

type _X_D3DPALETTESIZE =
(
    D3DPALETTE_256              = 0,
    D3DPALETTE_128              = 1,
    D3DPALETTE_64               = 2,
    D3DPALETTE_32               = 3,
    D3DPALETTE_MAX              = 4,
    D3DPALETTE_FORCE_DWORD      = $7FFFFFFF
);
X_D3DPALETTESIZE = _X_D3DPALETTESIZE;

type X_D3DPixelContainer = object(X_D3DResource)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  public
    Format: DWORD; // Format information about the texture.
    Size: DWORD; // Size of a non power-of-2 texture, must be zero otherwise
  end; // size = 20 (as in Cxbx)
  PX_D3DPixelContainer = ^X_D3DPixelContainer;
  PPX_D3DPixelContainer = ^PX_D3DPixelContainer;

// pixel container "format" masks
const X_D3DFORMAT_RESERVED1_MASK      = $00000003;      // Must be zero
const X_D3DFORMAT_DMACHANNEL_MASK     = $00000003;
const X_D3DFORMAT_DMACHANNEL_A        = $00000001;      // DMA channel A - the default for all system memory
const X_D3DFORMAT_DMACHANNEL_B        = $00000002;      // DMA channel B - unused
const X_D3DFORMAT_CUBEMAP             = $00000004;      // Set if the texture if a cube map
const X_D3DFORMAT_BORDERSOURCE_COLOR  = $00000008;      // If set, uses D3DTSS_BORDERCOLOR as a border
const X_D3DFORMAT_DIMENSION_MASK      = $000000F0;      // # of dimensions, must be 2 or 3
const X_D3DFORMAT_DIMENSION_SHIFT     = 4;
const X_D3DFORMAT_FORMAT_MASK         = $0000FF00;      // D3DFORMAT - See X_D3DFMT_* above
const X_D3DFORMAT_FORMAT_SHIFT        = 8;
const X_D3DFORMAT_MIPMAP_MASK         = $000F0000;      // # mipmap levels (always 1 for surfaces)
const X_D3DFORMAT_MIPMAP_SHIFT        = 16;
const X_D3DFORMAT_USIZE_MASK          = $00F00000;      // Log2 of the U size of the base texture (only set for swizzled or compressed)
const X_D3DFORMAT_USIZE_SHIFT         = 20;
const X_D3DFORMAT_VSIZE_MASK          = $0F000000;      // Log2 of the V size of the base texture (only set for swizzled or compressed)
const X_D3DFORMAT_VSIZE_SHIFT         = 24;
const X_D3DFORMAT_PSIZE_MASK          = $F0000000;      // Log2 of the P size of the base texture (only set for swizzled or compressed)
const X_D3DFORMAT_PSIZE_SHIFT         = 28;

// pixel container "size" masks
// The layout of the size field, used for non swizzled or compressed textures.
//
// The Size field of a container will be zero if the texture is swizzled or compressed.
// It is guarenteed to be non-zero otherwise because either the height/width will be
// greater than one or the pitch adjust will be nonzero because the minimum texture
// pitch is 8 bytes.
const X_D3DSIZE_WIDTH_MASK   = $00000FFF;   // Width of the texture - 1, in texels
//const X_D3DSIZE_WIDTH_SHIFT = 0;
const X_D3DSIZE_HEIGHT_MASK  = $00FFF000;   // Height of the texture - 1, in texels
const X_D3DSIZE_HEIGHT_SHIFT = 12;
const X_D3DSIZE_PITCH_MASK   = $FF000000;   // Pitch / 64 - 1
const X_D3DSIZE_PITCH_SHIFT  = 24;

const X_D3DTEXTURE_PITCH_ALIGNMENT = 64;

const X_D3DTEXTURE_CUBEFACE_ALIGNMENT = 128;

type X_D3DBaseTexture = object(X_D3DPixelContainer)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  end; // size = 20 (as in Cxbx)
  PX_D3DBaseTexture = ^X_D3DBaseTexture;
  PPX_D3DBaseTexture = ^PX_D3DBaseTexture;

type X_D3DTexture = object(X_D3DBaseTexture)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  end; // size = 20 (as in Cxbx)
  PX_D3DTexture = ^X_D3DTexture;
  PPX_D3DTexture = ^PX_D3DTexture;

type X_D3DVolume = object(X_D3DBaseTexture) // Dxbx addition
// Branch:Dxbx  Translator:PatrickvL  Done:100
  end; // size = 20 (doesn't exist in Cxbx)
  PX_D3DVolume = ^X_D3DVolume;
  PPX_D3DVolume = ^PX_D3DVolume;

type X_D3DVolumeTexture = object(X_D3DBaseTexture)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  end; // size = 20 (as in Cxbx)
  PX_D3DVolumeTexture = ^X_D3DVolumeTexture;
  PPX_D3DVolumeTexture = ^PX_D3DVolumeTexture;

type X_D3DCubeTexture = object(X_D3DBaseTexture)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  end; // size = 20 (as in Cxbx)
  PX_D3DCubeTexture = ^X_D3DCubeTexture;
  PPX_D3DCubeTexture = ^PX_D3DCubeTexture;

type X_D3DSurface = object(X_D3DPixelContainer)
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    Parent: PX_D3DBaseTexture;
  end; // size = 20 (as in Cxbx)
  PX_D3DSurface = ^X_D3DSurface;
  PPX_D3DSurface = ^PX_D3DSurface;

type _X_D3DTILE = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    Flags: DWORD;
    pMemory: PVOID;
    Size: DWORD;
    Pitch: DWORD;
    ZStartTag: DWORD;
    ZOffset: DWORD;
  end; // size = 24 (as in Cxbx)
  X_D3DTILE = _X_D3DTILE;
  PX_D3DTILE = ^X_D3DTILE;

type X_D3DCALLBACKTYPE = ( // blueshogun96 10/1/07
    X_D3DCALLBACK_READ = 0, // Fixed PatrickvL 10/7/22
    X_D3DCALLBACK_WRITE = 1
  );

type X_D3DFIELDTYPE = (
    X_D3DFIELD_ODD = 1,
    X_D3DFIELD_EVEN = 2,
    X_D3DFIELD_PROGRESSIVE = 3,
    X_D3DFIELD_FORCE_DWORD = $7FFFFFFF
  );

type _X_D3DFIELD_STATUS = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    Field: X_D3DFIELDTYPE;
    VBlankCount: UINT;
  end; // size = 8 (as in Cxbx)
  X_D3DFIELD_STATUS = _X_D3DFIELD_STATUS;
  PX_D3DFIELD_STATUS= ^X_D3DFIELD_STATUS;

// VBlank flags
const D3DVBLANK_SWAPDONE   = 1;
const D3DVBLANK_SWAPMISSED = 2;

type _D3DVBLANKDATA = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    VBlankCounter: DWORD;
    SwapCounter: DWORD;
    Flags: DWORD;
  end; // size = 12 (as in Cxbx)
  D3DVBLANKDATA = _D3DVBLANKDATA;
  PD3DVBLANKDATA = ^D3DVBLANKDATA;

// Swap flags
const X_D3DSWAP_DEFAULT    = $00000000;
const X_D3DSWAP_COPY       = $00000001;
const X_D3DSWAP_BYPASSCOPY = $00000002;
const X_D3DSWAP_FINISH     = $00000004;

type _D3DSWAPDATA = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    Swap: DWORD;
    SwapVBlank: DWORD;
    MissedVBlanks: DWORD;
    TimeUntilSwapVBlank: DWORD;
    TimeBetweenSwapVBlanks: DWORD;
  end; // size = 20 (as in Cxbx)
  D3DSWAPDATA = _D3DSWAPDATA;
  PD3DSWAPDATA = ^D3DSWAPDATA;

// D3DVBLANKCALLBACK
type D3DVBLANKCALLBACK = procedure (const pData: PD3DVBLANKDATA); cdecl;

// D3DSWAPCALLBACK
type D3DSWAPCALLBACK = procedure (const pData: PD3DSWAPDATA); cdecl;

const // DWORD Indexes for XTL_D3D__pDevice (aka D3D__pDevice) :
  X_D3DDevice_PixelShader_Put = 0;
  X_D3DDevice_PixelShader_Threshold = 4/4;
  X_D3DDevice_Flags = 8/4; // DWORD; BeginStateBlock or's $20, EndStateBlock and's (not $20)

  // These are derived from XDK 5931. TODO : Investigate other XDK versions :
  X_D3DDevice_Active_PixelShader = 1924/4; // PHandle - read by D3DDevice_GetPixelShader
  X_D3DDevice_Active_FinalCombiner = 1928/4; // LONGBOOL - Correlates with D3DDIRTYFLAG_SPECFOG_COMBINER
  X_D3DDevice_RenderState_PSTextureModes = 1936/4; // DWORD
  X_D3DDevice_Active_VertexShader = 1944/4; // Pointer - read by D3DDevice_GetVertexShader
  X_D3DDevice_Active_Indices = 1952/4; // Pointer

  // These D3DDevice offsets are set via SetPixelShaderConstant (which converts 4 floats into a D3DCOLOR) :
  X_D3DDevice_PixelShaderConstant0 = 2276/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant1 = 2280/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant2 = 2284/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant3 = 2288/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant4 = 2292/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant5 = 2296/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant6 = 2300/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant7 = 2304/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant8 = 2308/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant9 = 2312/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant10 = 2316/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant11 = 2320/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant12 = 2324/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant13 = 2328/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant14 = 2332/4; // D3DCOLOR
  X_D3DDevice_PixelShaderConstant15 = 2336/4; // D3DCOLOR
  // NOTE : SetPixelShaderConstant also tests the constant-mappings of the active pixel shader definition.
  // These are PSC0Mapping, PSC1Mapping and PSFinalCombinerConstants, which map to 18 D3D__RenderState slots.
  // Every mapping that matches the constant number currently being set, recieves the D3DCOLOR value too.
  //
  // This is done by writing the D3DCOLOR value to the corresponding D3D__RenderState offset, plus an
  // accompanying command is writen to the pushbuffer (which recieves the same D3DCOLOR as argument) :
  //
  // For PSC0Mapping:
  //   D3D__RenderState[X_D3DRS_PSCONSTANT0_0] is written, and $40A60 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT0_1] is written, and $40A64 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT0_2] is written, and $40A68 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT0_3] is written, and $40A6C is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT0_4] is written, and $40A70 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT0_5] is written, and $40A74 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT0_6] is written, and $40A78 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT0_7] is written, and $40A7C is pushed
  // For PSC1Mapping:
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_0] is written, and $40A80 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_1] is written, and $40A84 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_2] is written, and $40A88 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_3] is written, and $40A8C is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_4] is written, and $40A90 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_5] is written, and $40A94 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_6] is written, and $40A98 is pushed
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_7] is written, and $40A9C is pushed
  // For PSFinalCombinerConstants:
  //   D3D__RenderState[X_D3DRS_PSFINALCOMBINERCONSTANT0] is written, and $41E20 is pushed
  //   D3D__RenderState[X_D3DRS_PSFINALCOMBINERCONSTANT1] is written, and $41E24 is pushed
  //
  // Example : SetPixelShaderConstant(7,pFloats,8) converts two sets of 4 floats into a D3DCOLOR
  // and writes these to X_D3DDevice_PixelShaderConstant7 and X_D3DDevice_PixelShaderConstant8.
  //
  // If PSC1Mapping contained 0xAFFFFFF9, then the following is done :
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_0] := X_D3DDevice_PixelShaderConstant7 (and a push of $40A80)
  //   D3D__RenderState[X_D3DRS_PSCONSTANT1_7] := X_D3DDevice_PixelShaderConstant8 (and a push of $40A9C)
  // (This also means that if constant 15=$f where to be set, all other X_D3DRS_PSCONSTANT slots would be written and pushed.)

  X_D3DDevice_CurrentPixelShaderResource_Common = 2340/4; // DWORD
  X_D3DDevice_CurrentPixelShaderResource_Data = 2344/4; // DWORD
  X_D3DDevice_CurrentPixelShaderResource_Lock = 2348/4; // PX_D3DPIXELSHADERDEF

  X_D3DDevice_RefCount = 2360/4; // DWORD
  X_D3DDevice_ProjectionViewportMatrix = 2432/4; // $40 bytes = SizeOf(D3DMATRIX)

  X_D3DDevice_ModelView = 2496/4; // $40 bytes = SizeOf(D3DMATRIX) - read by D3DDevice_GetModelView

  X_D3DDevice_Active_VertexShaderHandle = 2816/4; // DWORD - read by D3DDevice_GetVertexShaderInput
  X_D3DDevice_Active_VertexShaderStreamCount = 2820/4; // UINT - read by D3DDevice_GetVertexShaderInput
  X_D3DDevice_Active_VertexShaderStreamInput = 2824/4; // PD3DSTREAM_INPUT - read by D3DDevice_GetVertexShaderInput

  X_D3DDevice_Active_Transform = 3168/4; // $40 bytes = SizeOf(D3DMATRIX)
  X_D3DDevice_Viewport = 3808/4; // 24 bytes = SizeOf(D3DVIEWPORT8
  X_D3DDevice_Active_Material = 3840/4; // $44 bytes = SizeOf(D3DMATERIAL8).
  X_D3DDevice_Active_BackMaterial = 3908/4; // $44 bytes = SizeOf(D3DMATERIAL8).
  X_D3DDevice_Active_Stage0Texture = 3976/4; // PD3DBaseTexture
  X_D3DDevice_Active_Stage1Texture = 3980/4; // PD3DBaseTexture
  X_D3DDevice_Active_Stage2Texture = 3984/4; // PD3DBaseTexture
  X_D3DDevice_Active_Stage3Texture = 3988/4; // PD3DBaseTexture
  X_D3DDevice_Active_Palette = 3992/4; // PD3DPalette
  X_D3DDevice_ShaderConstantMode = 6440/4; // DWORD - read by D3DDevice_GetShaderConstantMode

  // D3DDevice_GetCopyRectsState:
  X_D3DDevice_CopyRectState = 6444/4; // $20 bytes = SizeOf(D3DCOPYRECTSTATE)
  X_D3DDevice_CopyRectRopState = 6476/4; //  $20 bytes = SizeOf(D3DCOPYRECTROPSTATE)

  X_D3DDevice_Stipple = 6524/4; // $80 bytes = SizeOf(?)
  X_D3DDevice_WaitCallback = 6652/4; // Pointer

  X_D3DDevice_Active_RenderTarget = 6660/4; // PX_D3DResource
  X_D3DDevice_Active_DepthStencilSurface = 6664/4; // PX_D3DResource

  X_D3DDevice_BackBufferCount= 6672/4; // Integer
  X_D3DDevice_BackBuffer = 6676/4; // PX_D3DSurface
  X_D3DDevice_FrontBuffer = 6680/4; // PX_D3DSurface
  X_D3DDevice_ZStencilSurface = 6688/4; // PX_D3DSurface

  X_D3DDevice_RegisterBase = 7208/4; // Pointer, returned by D3DPERF_GetRegisterBase

  X_D3DDevice_SwapCallback = 7604/4;
  X_D3DDevice_VerticalBlankCallback = 7608/4;

  X_D3DDevice_MaxIndex = 9376/4; // SizeOf(D3DDevice) = 9376

// X_D3DRENDERSTATETYPE values

// Dxbx note : These declarations are from XDK version 5933, the most recent and complete version.
// Older versions are slightly different (some members are missing), so we use a mapping table to
// cater for the differences (see DxbxBuildRenderStateMappingTable). This enables to ignore these
// version-differences in the rest of our code (unless it matters somehow); We write via indirection :
//   XTL_EmuMappedD3DRenderState[{X_D3DRENDERSTATETYPE}]^ := Value;
//
// And we read via the same mapping (do note, that missing elements all point to the same dummy) :
//   Result := XTL_EmuMappedD3DRenderState[{X_D3DRENDERSTATETYPE}]^;

// Dxbx note : The PS* render states map 1-on-1 to the X_D3DPIXELSHADERDEF record,
// SetPixelShader actually pushes the definition into these render state slots.
// See DxbxUpdateActivePixelShader for how this is employed.

// The set starts out with "pixel-shader" render states (all Xbox extensions) :
const X_D3DRS_PSALPHAINPUTS0              = 0;
const X_D3DRS_PSALPHAINPUTS1              = 1;
const X_D3DRS_PSALPHAINPUTS2              = 2;
const X_D3DRS_PSALPHAINPUTS3              = 3;
const X_D3DRS_PSALPHAINPUTS4              = 4;
const X_D3DRS_PSALPHAINPUTS5              = 5;
const X_D3DRS_PSALPHAINPUTS6              = 6;
const X_D3DRS_PSALPHAINPUTS7              = 7;
const X_D3DRS_PSFINALCOMBINERINPUTSABCD   = 8;
const X_D3DRS_PSFINALCOMBINERINPUTSEFG    = 9;
const X_D3DRS_PSCONSTANT0_0               = 10;
const X_D3DRS_PSCONSTANT0_1               = 11;
const X_D3DRS_PSCONSTANT0_2               = 12;
const X_D3DRS_PSCONSTANT0_3               = 13;
const X_D3DRS_PSCONSTANT0_4               = 14;
const X_D3DRS_PSCONSTANT0_5               = 15;
const X_D3DRS_PSCONSTANT0_6               = 16;
const X_D3DRS_PSCONSTANT0_7               = 17;
const X_D3DRS_PSCONSTANT1_0               = 18;
const X_D3DRS_PSCONSTANT1_1               = 19;
const X_D3DRS_PSCONSTANT1_2               = 20;
const X_D3DRS_PSCONSTANT1_3               = 21;
const X_D3DRS_PSCONSTANT1_4               = 22;
const X_D3DRS_PSCONSTANT1_5               = 23;
const X_D3DRS_PSCONSTANT1_6               = 24;
const X_D3DRS_PSCONSTANT1_7               = 25;
const X_D3DRS_PSALPHAOUTPUTS0             = 26;
const X_D3DRS_PSALPHAOUTPUTS1             = 27;
const X_D3DRS_PSALPHAOUTPUTS2             = 28;
const X_D3DRS_PSALPHAOUTPUTS3             = 29;
const X_D3DRS_PSALPHAOUTPUTS4             = 30;
const X_D3DRS_PSALPHAOUTPUTS5             = 31;
const X_D3DRS_PSALPHAOUTPUTS6             = 32;
const X_D3DRS_PSALPHAOUTPUTS7             = 33;
const X_D3DRS_PSRGBINPUTS0                = 34;
const X_D3DRS_PSRGBINPUTS1                = 35;
const X_D3DRS_PSRGBINPUTS2                = 36;
const X_D3DRS_PSRGBINPUTS3                = 37;
const X_D3DRS_PSRGBINPUTS4                = 38;
const X_D3DRS_PSRGBINPUTS5                = 39;
const X_D3DRS_PSRGBINPUTS6                = 40;
const X_D3DRS_PSRGBINPUTS7                = 41;
const X_D3DRS_PSCOMPAREMODE               = 42;
const X_D3DRS_PSFINALCOMBINERCONSTANT0    = 43;
const X_D3DRS_PSFINALCOMBINERCONSTANT1    = 44;
const X_D3DRS_PSRGBOUTPUTS0               = 45;
const X_D3DRS_PSRGBOUTPUTS1               = 46;
const X_D3DRS_PSRGBOUTPUTS2               = 47;
const X_D3DRS_PSRGBOUTPUTS3               = 48;
const X_D3DRS_PSRGBOUTPUTS4               = 49;
const X_D3DRS_PSRGBOUTPUTS5               = 50;
const X_D3DRS_PSRGBOUTPUTS6               = 51;
const X_D3DRS_PSRGBOUTPUTS7               = 52;
const X_D3DRS_PSCOMBINERCOUNT             = 53;
const X_D3DRS_PS_RESERVED                 = 54; // Dxbx note : This takes the slot of X_D3DPIXELSHADERDEF.PSTextureModes, set by D3DDevice_SetRenderState_LogicOp?
const X_D3DRS_PSDOTMAPPING                = 55;
const X_D3DRS_PSINPUTTEXTURE              = 56;
// End of "pixel-shader" render states, continuing with "simple" render states :
const X_D3DRS_ZFUNC                       = 57; // D3DCMPFUNC
const X_D3DRS_ALPHAFUNC                   = 58; // D3DCMPFUNC
const X_D3DRS_ALPHABLENDENABLE            = 59; // TRUE to enable alpha blending
const X_D3DRS_ALPHATESTENABLE             = 60; // TRUE to enable alpha tests
const X_D3DRS_ALPHAREF                    = 61; // BYTE
const X_D3DRS_SRCBLEND                    = 62; // D3DBLEND
const X_D3DRS_DESTBLEND                   = 63; // D3DBLEND
const X_D3DRS_ZWRITEENABLE                = 64; // TRUE to enable Z writes
const X_D3DRS_DITHERENABLE                = 65; // TRUE to enable dithering
const X_D3DRS_SHADEMODE                   = 66; // D3DSHADEMODE
const X_D3DRS_COLORWRITEENABLE            = 67; // D3DCOLORWRITEENABLE_ALPHA, etc. per-channel write enable
const X_D3DRS_STENCILZFAIL                = 68; // D3DSTENCILOP to do if stencil test passes and Z test fails
const X_D3DRS_STENCILPASS                 = 69; // D3DSTENCILOP to do if both stencil and Z tests pass
const X_D3DRS_STENCILFUNC                 = 70; // D3DCMPFUNC
const X_D3DRS_STENCILREF                  = 71; // BYTE reference value used in stencil test
const X_D3DRS_STENCILMASK                 = 72; // BYTE mask value used in stencil test
const X_D3DRS_STENCILWRITEMASK            = 73; // BYTE write mask applied to values written to stencil buffer
const X_D3DRS_BLENDOP                     = 74; // D3DBLENDOP setting
const X_D3DRS_BLENDCOLOR                  = 75; // D3DCOLOR for D3DBLEND_CONSTANTCOLOR (Xbox ext.)
const X_D3DRS_SWATHWIDTH                  = 76; // D3DSWATHWIDTH (Xbox ext.)
const X_D3DRS_POLYGONOFFSETZSLOPESCALE    = 77; // float Z factor for shadow maps (Xbox ext.)
const X_D3DRS_POLYGONOFFSETZOFFSET        = 78; // Xbox ext.
const X_D3DRS_POINTOFFSETENABLE           = 79; // Xbox ext.
const X_D3DRS_WIREFRAMEOFFSETENABLE       = 80; // Xbox ext.
const X_D3DRS_SOLIDOFFSETENABLE           = 81; // Xbox ext.
const X_D3DRS_DEPTHCLIPCONTROL            = 82; // [4627+] Xbox ext.
const X_D3DRS_STIPPLEENABLE               = 83; // [4627+] Xbox ext.
const X_D3DRS_SIMPLE_UNUSED8              = 84; // [4627+]
const X_D3DRS_SIMPLE_UNUSED7              = 85; // [4627+]
const X_D3DRS_SIMPLE_UNUSED6              = 86; // [4627+]
const X_D3DRS_SIMPLE_UNUSED5              = 87; // [4627+]
const X_D3DRS_SIMPLE_UNUSED4              = 88; // [4627+]
const X_D3DRS_SIMPLE_UNUSED3              = 89; // [4627+]
const X_D3DRS_SIMPLE_UNUSED2              = 90; // [4627+]
const X_D3DRS_SIMPLE_UNUSED1              = 91; // [4627+]
// End of "simple" render states, continuing with "deferred" render states :
const X_D3DRS_FOGENABLE                   = 92;
const X_D3DRS_FOGTABLEMODE                = 93;
const X_D3DRS_FOGSTART                    = 94;
const X_D3DRS_FOGEND                      = 95;
const X_D3DRS_FOGDENSITY                  = 96;
const X_D3DRS_RANGEFOGENABLE              = 97;
const X_D3DRS_WRAP0                       = 98;
const X_D3DRS_WRAP1                       = 99;
const X_D3DRS_WRAP2                       = 100; // Dxbx addition
const X_D3DRS_WRAP3                       = 101; // Dxbx addition
const X_D3DRS_LIGHTING                    = 102;
const X_D3DRS_SPECULARENABLE              = 103;
const X_D3DRS_LOCALVIEWER                 = 104; // Dxbx addition
const X_D3DRS_COLORVERTEX                 = 105;
const X_D3DRS_BACKSPECULARMATERIALSOURCE  = 106; // Xbox ext. nsp.
const X_D3DRS_BACKDIFFUSEMATERIALSOURCE   = 107; // Xbox ext. nsp.
const X_D3DRS_BACKAMBIENTMATERIALSOURCE   = 108; // Xbox ext. nsp.
const X_D3DRS_BACKEMISSIVEMATERIALSOURCE  = 109; // Xbox ext. nsp.
const X_D3DRS_SPECULARMATERIALSOURCE      = 110;
const X_D3DRS_DIFFUSEMATERIALSOURCE       = 111;
const X_D3DRS_AMBIENTMATERIALSOURCE       = 112;
const X_D3DRS_EMISSIVEMATERIALSOURCE      = 113;
const X_D3DRS_BACKAMBIENT                 = 114; // Xbox ext. nsp.
const X_D3DRS_AMBIENT                     = 115;
const X_D3DRS_POINTSIZE                   = 116;
const X_D3DRS_POINTSIZE_MIN               = 117;
const X_D3DRS_POINTSPRITEENABLE           = 118;
const X_D3DRS_POINTSCALEENABLE            = 119;
const X_D3DRS_POINTSCALE_A                = 120;
const X_D3DRS_POINTSCALE_B                = 121;
const X_D3DRS_POINTSCALE_C                = 122;
const X_D3DRS_POINTSIZE_MAX               = 123;
const X_D3DRS_PATCHEDGESTYLE              = 124; // Dxbx addition
const X_D3DRS_PATCHSEGMENTS               = 125;
const X_D3DRS_SWAPFILTER                  = 126; // [4361+] Xbox ext. nsp. D3DTEXF_LINEAR etc. filter to use for Swap
const X_D3DRS_PRESENTATIONINTERVAL        = 127; // [4627+] Xbox ext. nsp.
const X_D3DRS_DEFERRED_UNUSED8            = 128; // [4627+]
const X_D3DRS_DEFERRED_UNUSED7            = 129; // [4627+]
const X_D3DRS_DEFERRED_UNUSED6            = 130; // [4627+]
const X_D3DRS_DEFERRED_UNUSED5            = 131; // [4627+]
const X_D3DRS_DEFERRED_UNUSED4            = 132; // [4627+]
const X_D3DRS_DEFERRED_UNUSED3            = 133; // [4627+]
const X_D3DRS_DEFERRED_UNUSED2            = 134; // [4627+]
const X_D3DRS_DEFERRED_UNUSED1            = 135; // [4627+]
// End of "deferred" render states, continuing with "complex" render states :
const X_D3DRS_PSTEXTUREMODES              = 136; // Xbox ext.
const X_D3DRS_VERTEXBLEND                 = 137;
const X_D3DRS_FOGCOLOR                    = 138;
const X_D3DRS_FILLMODE                    = 139;
const X_D3DRS_BACKFILLMODE                = 140; // Dxbx addition : Xbox ext. nsp.
const X_D3DRS_TWOSIDEDLIGHTING            = 141; // Dxbx addition : Xbox ext. nsp.
const X_D3DRS_NORMALIZENORMALS            = 142;
const X_D3DRS_ZENABLE                     = 143;
const X_D3DRS_STENCILENABLE               = 144;
const X_D3DRS_STENCILFAIL                 = 145;
const X_D3DRS_FRONTFACE                   = 146; // Dxbx addition : Xbox ext. nsp.
const X_D3DRS_CULLMODE                    = 147;
const X_D3DRS_TEXTUREFACTOR               = 148;
const X_D3DRS_ZBIAS                       = 149;
const X_D3DRS_LOGICOP                     = 150; // Xbox ext.
const X_D3DRS_EDGEANTIALIAS               = 151; // Dxbx note : No Xbox ext. (according to Direct3D8) !
const X_D3DRS_MULTISAMPLEANTIALIAS        = 152;
const X_D3DRS_MULTISAMPLEMASK             = 153;
const X_D3DRS_MULTISAMPLETYPE             = 154; // [-3911] Xbox ext. \_ aliasses  D3DMULTISAMPLE_TYPE
const X_D3DRS_MULTISAMPLEMODE             = 154; // [4361+] Xbox ext. /            D3DMULTISAMPLEMODE for the backbuffer
const X_D3DRS_MULTISAMPLERENDERTARGETMODE = 155; // [4361+] Xbox ext.
const X_D3DRS_SHADOWFUNC                  = 156; // D3DCMPFUNC (Xbox extension)
const X_D3DRS_LINEWIDTH                   = 157; // Xbox ext.
const X_D3DRS_SAMPLEALPHA                 = 158; // Xbox ext.
const X_D3DRS_DXT1NOISEENABLE             = 159; // Xbox ext.
const X_D3DRS_YUVENABLE                   = 160; // [3911+] Xbox ext.
const X_D3DRS_OCCLUSIONCULLENABLE         = 161; // [3911+] Xbox ext.
const X_D3DRS_STENCILCULLENABLE           = 162; // [3911+] Xbox ext.
const X_D3DRS_ROPZCMPALWAYSREAD           = 163; // [3911+] Xbox ext.
const X_D3DRS_ROPZREAD                    = 164; // [3911+] Xbox ext.
const X_D3DRS_DONOTCULLUNCOMPRESSED       = 165; // [3911+] Xbox ext.
// End of "complex" render states.

// Render state boundaries :

const X_D3DRS_PS_FIRST = X_D3DRS_PSALPHAINPUTS0;
const X_D3DRS_PS_LAST = X_D3DRS_PSINPUTTEXTURE;

const X_D3DRS_SIMPLE_FIRST = X_D3DRS_ZFUNC;
const X_D3DRS_SIMPLE_LAST = X_D3DRS_SIMPLE_UNUSED1;

const X_D3DRS_DEFERRED_FIRST = X_D3DRS_FOGENABLE;
const X_D3DRS_DEFERRED_LAST = X_D3DRS_DEFERRED_UNUSED1;

const X_D3DRS_COMPLEX_FIRST = X_D3DRS_PSTEXTUREMODES;
const X_D3DRS_COMPLEX_LAST = X_D3DRS_DONOTCULLUNCOMPRESSED;

const X_D3DRS_FIRST = X_D3DRS_PS_FIRST;
const X_D3DRS_LAST = X_D3DRS_COMPLEX_LAST;

// X_D3DWRAP values :
const X_D3DWRAP_U = $00000010;
const X_D3DWRAP_V = $00001000;
const X_D3DWRAP_W = $00100000;

// X_D3DTEXTURESTAGESTATETYPE values :
// Dxbx note : See DxbxFromOldVersion_D3DTSS(), as these might need correction for older SDK versions!
// The set starts out with "deferred" texture states :
const X_D3DTSS_ADDRESSU = 0;
const X_D3DTSS_ADDRESSV = 1;
const X_D3DTSS_ADDRESSW = 2;
const X_D3DTSS_MAGFILTER = 3;
const X_D3DTSS_MINFILTER = 4;
const X_D3DTSS_MIPFILTER = 5;
const X_D3DTSS_MIPMAPLODBIAS = 6;
const X_D3DTSS_MAXMIPLEVEL = 7;
const X_D3DTSS_MAXANISOTROPY = 8;
const X_D3DTSS_COLORKEYOP = 9; // Xbox ext.
const X_D3DTSS_COLORSIGN = 10; // Xbox ext.
const X_D3DTSS_ALPHAKILL = 11; // Xbox ext.
const X_D3DTSS_COLOROP = 12;
const X_D3DTSS_COLORARG0 = 13;
const X_D3DTSS_COLORARG1 = 14;
const X_D3DTSS_COLORARG2 = 15;
const X_D3DTSS_ALPHAOP = 16;
const X_D3DTSS_ALPHAARG0 = 17;
const X_D3DTSS_ALPHAARG1 = 18;
const X_D3DTSS_ALPHAARG2 = 19;
const X_D3DTSS_RESULTARG = 20;
const X_D3DTSS_TEXTURETRANSFORMFLAGS = 21;
// End of "deferred" texture states, continuing with the rest :
const X_D3DTSS_BUMPENVMAT00 = 22;
const X_D3DTSS_BUMPENVMAT01 = 23;
const X_D3DTSS_BUMPENVMAT11 = 24;
const X_D3DTSS_BUMPENVMAT10 = 25;
const X_D3DTSS_BUMPENVLSCALE = 26;
const X_D3DTSS_BUMPENVLOFFSET = 27;
const X_D3DTSS_TEXCOORDINDEX = 28;
const X_D3DTSS_BORDERCOLOR = 29;
const X_D3DTSS_COLORKEYCOLOR = 30; // Xbox ext.
const X_D3DTSS_UNSUPPORTED = 31; // Note : Somehow, this one comes through D3DDevice_SetTextureStageStateNotInline sometimes
// End of texture states.

// Texture state boundaries :

const X_D3DTSS_DEFERRED_FIRST = X_D3DTSS_ADDRESSU;
const X_D3DTSS_DEFERRED_LAST = X_D3DTSS_TEXTURETRANSFORMFLAGS;

const X_D3DTSS_FIRST = X_D3DTSS_ADDRESSU;
const X_D3DTSS_LAST = X_D3DTSS_COLORKEYCOLOR;

const X_D3DTS_STAGECOUNT = 4; // Dxbx addition
const X_D3DTS_STAGESIZE = 32; // Dxbx addition

const X_PSH_COMBINECOUNT = 8; // Dxbx addition
const X_PSH_CONSTANTCOUNT = 8; // Dxbx addition

// X_D3DTEXTUREOP values :
const X_D3DTOP_DISABLE = 1;
const X_D3DTOP_SELECTARG1 = 2;
const X_D3DTOP_SELECTARG2 = 3;
const X_D3DTOP_MODULATE = 4;
const X_D3DTOP_MODULATE2X = 5;
const X_D3DTOP_MODULATE4X = 6;
const X_D3DTOP_ADD = 7;
const X_D3DTOP_ADDSIGNED = 8;
const X_D3DTOP_ADDSIGNED2X = 9;
const X_D3DTOP_SUBTRACT = 10;
const X_D3DTOP_ADDSMOOTH = 11;
const X_D3DTOP_BLENDDIFFUSEALPHA = 12;
const X_D3DTOP_BLENDCURRENTALPHA = 13;
const X_D3DTOP_BLENDTEXTUREALPHA = 14;
const X_D3DTOP_BLENDFACTORALPHA = 15;
const X_D3DTOP_BLENDTEXTUREALPHAPM = 16;
const X_D3DTOP_PREMODULATE = 17;
const X_D3DTOP_MODULATEALPHA_ADDCOLOR = 18;
const X_D3DTOP_MODULATECOLOR_ADDALPHA = 19;
const X_D3DTOP_MODULATEINVALPHA_ADDCOLOR = 20;
const X_D3DTOP_MODULATEINVCOLOR_ADDALPHA = 21;
const X_D3DTOP_DOTPRODUCT3 = 22;
const X_D3DTOP_MULTIPLYADD = 23;
const X_D3DTOP_LERP = 24;
const X_D3DTOP_BUMPENVMAP = 25;
const X_D3DTOP_BUMPENVMAPLUMINANCE = 26;

// X_D3DTEXTUREADDRESS values :
const X_D3DTADDRESS_WRAP = 1;
const X_D3DTADDRESS_MIRROR = 2;
const X_D3DTADDRESS_CLAMP = 3;
const X_D3DTADDRESS_BORDER = 4;
const X_D3DTADDRESS_CLAMPTOEDGE = 5;

// X_D3DCLEAR values :
const X_D3DCLEAR_ZBUFFER = $00000001;
const X_D3DCLEAR_STENCIL = $00000002;
const X_D3DCLEAR_TARGET_R = $00000010;  // Clear target surface R component (Xbox ext.)
const X_D3DCLEAR_TARGET_G = $00000020;  // Clear target surface G component (Xbox ext.)
const X_D3DCLEAR_TARGET_B = $00000040;  // Clear target surface B component (Xbox ext.)
const X_D3DCLEAR_TARGET_A = $00000080;  // Clear target surface A component (Xbox ext.)
const X_D3DCLEAR_TARGET = X_D3DCLEAR_TARGET_R or X_D3DCLEAR_TARGET_G or X_D3DCLEAR_TARGET_B or X_D3DCLEAR_TARGET_A;

// X_D3DCOLORWRITEENABLE values :
const X_D3DCOLORWRITEENABLE_RED   = (1 shl 16);
const X_D3DCOLORWRITEENABLE_GREEN = (1 shl 8);
const X_D3DCOLORWRITEENABLE_BLUE  = (1 shl 0);
const X_D3DCOLORWRITEENABLE_ALPHA = (1 shl 24);
const X_D3DCOLORWRITEENABLE_ALL   = $01010101; // Xbox ext.

// deferred texture stage state "unknown" flag
const X_D3DTSS_UNK = $7fffffff;

type X_VERTEXSHADERCONSTANTMODE = DWORD;

const X_D3DSCM_96CONSTANTS                  = $00; // Enables constants 0..95
const X_D3DSCM_192CONSTANTS                 = $01; // Enables constants -96..-1 on top of 0..95
const X_D3DSCM_192CONSTANTSANDFIXEDPIPELINE = $02; // Unsupported?
const X_D3DSCM_NORESERVEDCONSTANTS          = $10;  // Do not reserve constant -38 and -37

const X_D3DSCM_RESERVED_CONSTANT1 = -38; // Becomes 58 after correction, contains Scale v
const X_D3DSCM_RESERVED_CONSTANT2 = -37; // Becomes 59 after correction, contains Offset

const X_D3DSCM_CORRECTION = 96; // Add 96 to arrive at the range 0..191 (instead of 96..95)
const X_D3DVS_CONSTREG_COUNT = 192;

// Vertex shader types
const X_VST_NORMAL = 1;
const X_VST_READWRITE = 2;
const X_VST_STATE = 3;

// ******************************************************************
// * X_VERTEXSHADERINPUT
// ******************************************************************
type _X_VERTEXSHADERINPUT = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    IndexOfStream: DWORD;
    Offset: DWORD;
    Format: DWORD;
    TesselationType: BYTE;
    TesselationSource: BYTE;
  end; // size = 16 (as in Cxbx)
  X_VERTEXSHADERINPUT = _X_VERTEXSHADERINPUT;

// ******************************************************************
// * X_VERTEXATTRIBUTEFORMAT
// ******************************************************************
type _X_VERTEXATTRIBUTEFORMAT = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    pVertexShaderInput: array [0..15] of X_VERTEXSHADERINPUT;
  end; // size = 256 (as in Cxbx)
  X_VERTEXATTRIBUTEFORMAT = _X_VERTEXATTRIBUTEFORMAT;
  PX_VERTEXATTRIBUTEFORMAT = ^X_VERTEXATTRIBUTEFORMAT;

// ******************************************************************
// * X_STREAMINPUT
// ******************************************************************
type _X_STREAMINPUT = record
// Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
    VertexBuffer: PX_D3DVertexBuffer;
    Stride: UINT;
    Offset: UINT;
  end; // size = 12 (as in Cxbx)
  X_STREAMINPUT = _X_STREAMINPUT;
  PX_STREAMINPUT = ^X_STREAMINPUT;
  PPX_STREAMINPUT = ^PX_STREAMINPUT;

const // vertex shader input registers for fixed function vertex shader
  // Name                  Register number      D3DFVF
  X_D3DVSDE_POSITION     = 0; // Corresponds to D3DFVF_XYZ
  X_D3DVSDE_BLENDWEIGHT  = 1; // Corresponds to D3DFVF_XYZRHW
  X_D3DVSDE_NORMAL       = 2; // Corresponds to D3DFVF_NORMAL
  X_D3DVSDE_DIFFUSE      = 3; // Corresponds to D3DFVF_DIFFUSE
  X_D3DVSDE_SPECULAR     = 4; // Corresponds to D3DFVF_SPECULAR
  X_D3DVSDE_FOG          = 5; // Xbox extension
  X_D3DVSDE_BACKDIFFUSE  = 7; // Xbox extension
  X_D3DVSDE_BACKSPECULAR = 8; // Xbox extension
  X_D3DVSDE_TEXCOORD0    = 9; // "Corresponds to D3DFVF_TEX0" says the docs, but 0 means no textures, so probably D3DFVF_TEX1!
  X_D3DVSDE_TEXCOORD1    = 10; // Corresponds to D3DFVF_TEX{above}+1
  X_D3DVSDE_TEXCOORD2    = 11; // Corresponds to D3DFVF_TEX{above}+2
  X_D3DVSDE_TEXCOORD3    = 12; // Corresponds to D3DFVF_TEX{above}+3
  X_D3DVSDE_VERTEX       = $FFFFFFFF; // Xbox extension for Begin/End drawing (data is a D3DVSDT_FLOAT4)

type X_D3DVSDE = X_D3DVSDE_POSITION..High(DWORD)-2; // Unique declaration to make overloads possible;

const
  // bit declarations for _Type fields
  X_D3DVSDT_FLOAT1      = $12; // 1D float expanded to (value, 0.0, 0.0, 1.0)
  X_D3DVSDT_FLOAT2      = $22; // 2D float expanded to (value, value, 0.0, 1.0)
  X_D3DVSDT_FLOAT3      = $32; // 3D float expanded to (value, value, value, 1.0) In double word format this is ARGB, or in byte ordering it would be B, G, R, A.
  X_D3DVSDT_FLOAT4      = $42; // 4D float
  X_D3DVSDT_D3DCOLOR    = $40; // 4D packed unsigned bytes mapped to 0.0 to 1.0 range
//X_D3DVSDT_UBYTE4      = $05; // 4D unsigned byte   Dxbx note : Not supported on Xbox ?
  X_D3DVSDT_SHORT2      = $25; // 2D signed short expanded to (value, value, 0.0, 1.0)
  X_D3DVSDT_SHORT4      = $45; // 4D signed short

  //  Xbox only declarations :
  X_D3DVSDT_NORMSHORT1  = $11; // xbox ext. 1D signed, normalized short expanded to (value, 0.0, 0.0, 1.0). Signed, normalized shorts map from -1.0 to 1.0.
  X_D3DVSDT_NORMSHORT2  = $21; // xbox ext. 2D signed, normalized short expanded to (value, value, 0.0, 1.0). Signed, normalized shorts map from -1.0 to 1.0.
  X_D3DVSDT_NORMSHORT3  = $31; // xbox ext. 3D signed, normalized short expanded to (value, value, value, 1.0). Signed, normalized shorts map from -1.0 to 1.0.
  X_D3DVSDT_NORMSHORT4  = $41; // xbox ext. 4D signed, normalized short expanded to (value, value, value, value). Signed, normalized shorts map from -1.0 to 1.0.
  X_D3DVSDT_NORMPACKED3 = $16; // xbox ext. Three signed, normalized components packed in 32-bits. (11,11,10). Each component ranges from -1.0 to 1.0. Expanded to (value, value, value, 1.0).
  X_D3DVSDT_SHORT1      = $15; // xbox ext. 1D signed short expanded to (value, 0., 0., 1). Signed shorts map to the range [-32768, 32767].
  X_D3DVSDT_SHORT3      = $35; // xbox ext. 3D signed short expanded to (value, value, value, 1). Signed shorts map to the range [-32768, 32767].
  X_D3DVSDT_PBYTE1      = $14; // xbox ext. 1D packed byte expanded to (value, 0., 0., 1). Packed bytes map to the range [0, 1].
  X_D3DVSDT_PBYTE2      = $24; // xbox ext. 2D packed byte expanded to (value, value, 0., 1). Packed bytes map to the range [0, 1].
  X_D3DVSDT_PBYTE3      = $34; // xbox ext. 3D packed byte expanded to (value, value, value, 1). Packed bytes map to the range [0, 1].
  X_D3DVSDT_PBYTE4      = $44; // xbox ext. 4D packed byte expanded to (value, value, value, value). Packed bytes map to the range [0, 1].
  X_D3DVSDT_FLOAT2H     = $72; // xbox ext. 3D float that expands to (value, value, 0.0, value). Useful for projective texture coordinates.
  X_D3DVSDT_NONE        = $02; // xbox ext. nsp

const MAX_NBR_STREAMS = 16;

implementation

end.

