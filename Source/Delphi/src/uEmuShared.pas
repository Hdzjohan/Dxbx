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
unit uEmuShared;

{$INCLUDE Dxbx.inc}

interface

uses
  // Delphi
  Windows
  , SysUtils // StrCopy
  // Jedi Win32API
  , JwaWinType
{$IFDEF DXBX_USE_JCLDEBUG}
  // Jcl
  , JclDebug
{$ENDIF}
  // Dxbx
  , uTypes
  , uLog
  , uMutex
  , uXbVideo
  , uXBSound
  , uXBController
{$IFDEF DXBX_DLL}
  , uDxbxKrnlUtils // DxbxKrnlCleanup
{$ENDIF}
  ;

const
  DXBX_MAX_PATH = 260;

type EmuShared = object(Mutex)
  // Branch:shogun  Revision:162  Translator:PatrickvL  Done:100
  public
    // Constructor / Deconstructor
    procedure Create;
    procedure Destroy;

    procedure LoadExtraSettings(const szRegistryKey: P_char);
    procedure SaveExtraSettings(const szRegistryKey: P_char);

    procedure Load;
    procedure Save;

    procedure ActivateLogFlags;

    // Each process needs to call this to initialize shared memory
    class function Init(): Boolean;

    // Each process needs to call this to cleanup shared memory
    class procedure Cleanup();

    // Xbox Video Accessors
    procedure GetXBVideo(video: PXBVideo);
    procedure SetXBVideo(const video: PXBVideo);

    // Xbox Sound Accesors
    procedure GetXBSound(sound: PXBSound);
    procedure SetXBSound(const sound: PXBSound);

    // Xbox Controller Accessors
    procedure GetXBController(ctrl: PXBController);
    procedure SetXBController(const ctrl: PXBController);

    // Xbe Path Accessors
    procedure GetXbePath(var Path: string);
    procedure SetXbePath(const Path: AnsiString);
  private
    // Shared configuration
    m_XBController: XBController;
    m_XBVideo: XBVideo;
    m_XBSound: XBSound;
    m_XbePath: array [0..DXBX_MAX_PATH - 1] of _char;
  public
    m_ActiveLogFlags: TLogFlags;
    m_DisabledLogFlags: TLogFlags;
    m_BypassSymbolCache: Boolean;
  end; // size = 7164 (as in Cxbx) + 8 (Dxxb addition)
  PEmuShared = ^EmuShared;

procedure SetXbePath(const Path: PAnsiChar); stdcall;

// Exported Global Shared Memory Pointer
var g_EmuShared: PEmuShared = NULL;
var g_EmuSharedRefCount: int = 0; // extern; ??

implementation

var hMapObject: Handle = HNULL; // Dxbx note : This is not a global, just unit-scope

{$IFNDEF DXBX_DLL}
procedure DxbxKrnlCleanup(const aMessage: string);
begin
  raise Exception.Create(aMessage);
end;
{$ENDIF}

{ EmuShared }

class function EmuShared.Init(): Boolean;
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  // Ensure initialization only occurs once
  Result := true;
  WriteLog('EmuShared.Init');

  // Prevent multiple initializations
  if hMapObject <> HNULL then
    Exit;

{$IFDEF DXBX_USE_JCLDEBUG}
  // Start tracking exceptions using JclDebug
  JclStartExceptionTracking;
{$ENDIF}

  // Create the shared memory "file"
  begin
    hMapObject := CreateFileMapping
    (
      INVALID_HANDLE_VALUE, // Paging file
      NULL, // default security attributes
      PAGE_READWRITE, // read/write access
      0, // size: high 32 bits
      sizeof(EmuShared), // size: low 32 bits
      'Local\EmuShared' // name of map object
      );

    // Dxbx note : Cxbx does this after the hMapObject test, 
    // but that could disturb GetLastError(), so check it here :
    if(GetLastError() = ERROR_ALREADY_EXISTS) then
      Result := false;

    if hMapObject = HNULL then
      DxbxKrnlCleanup('Could not map shared memory!');
  end;

  // Memory map this file
  begin
    g_EmuShared := PEmuShared(MapViewOfFile
    (
      hMapObject, // object to map view of
      FILE_MAP_WRITE, // read/write access
      0, // high offset:  map from
      0, // low offset:   beginning
      0 // default: map entire file
      ));

    if (g_EmuShared = NULL) then
      DxbxKrnlCleanup('Could not map view of shared memory!');
  end;

  // Executed only on first initialization of shared memory
  if(Result) then
  begin
    ZeroMemory(g_EmuShared, SizeOf(EmuShared)); // clear memory
    g_EmuShared.Create; // call constructor
  end;

  g_EmuShared.ActivateLogFlags;

  Inc(g_EmuSharedRefCount);
end; // Init

class procedure EmuShared.Cleanup();
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  WriteLog('EmuShared.Cleanup');
  Dec(g_EmuSharedRefCount);

  if(g_EmuSharedRefCount = 0) then
  begin
    g_EmuShared.Save;

    UnmapViewOfFile(g_EmuShared);
    g_EmuShared := nil;

{$IFDEF DXBX_USE_JCLDEBUG}
    JclStopExceptionTracking;
{$ENDIF}
  end;

  CloseLogs;
end;

procedure EmuShared.Create;
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  inherited {m_Mutex.}Create;
  Load;
end;

procedure EmuShared.Load;
begin
  m_XBController.Load(PAnsiChar('Software\Dxbx\XBController'));
  m_XBVideo.Load(PAnsiChar('Software\Dxbx\XBVideo'));
  m_XBSound.Load(PAnsiChar('Software\Dxbx\XBSound'));
  LoadExtraSettings('Software\Dxbx\Settings');

  // 'load' the default logflags :
  m_ActiveLogFlags := g_DefaultLogFlags_Enabled;
  m_DisabledLogFlags := g_DefaultLogFlags_Disabled;
  // TODO -oDxbx : Use a real persistence mechanism for the logflags (including presets)
end;

procedure EmuShared.LoadExtraSettings(const szRegistryKey: P_char);
var
  dwDisposition, dwType, dwSize: DWORD;
  hKey: Windows.HKEY;
begin
  // Load Configuration from Registry
  try
    if RegCreateKeyExA(HKEY_CURRENT_USER, szRegistryKey, 0, NULL, REG_OPTION_NON_VOLATILE, KEY_QUERY_VALUE, NULL, {var}hKey, @dwDisposition) = ERROR_SUCCESS then
    try
      dwType := REG_DWORD;
      dwSize := sizeof(DWORD);
      RegQueryValueExA(hKey, 'BypassSymbolCache', NULL, @dwType, PBYTE(@m_BypassSymbolCache), @dwSize);
    finally
      RegCloseKey(hKey);
    end;
  except
    raise Exception.Create('LoadExtraSettings raised an exception');
  end;
end;

procedure EmuShared.ActivateLogFlags;
begin
(* Now that we have a configuration interface for these flags,
   we can make them available to MayLog (and thus let them influence the
   logging behaviour) like this : *)
  uLog.SetSpecifiedLogFlags(@m_ActiveLogFlags, @m_DisabledLogFlags);
end;

procedure EmuShared.Save;
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  m_XBController.Save(PAnsiChar('Software\Dxbx\XBController'));
  m_XBVideo.Save(PAnsiChar('Software\Dxbx\XBVideo'));
  M_XBSound.Save(PAnsiChar('Software\Dxbx\XBSound'));
  SaveExtraSettings('Software\Dxbx\Settings');
end;

procedure EmuShared.SaveExtraSettings(const szRegistryKey: P_char);
var
  dwDisposition, dwType, dwSize: DWORD;
  hKey: Windows.HKEY;
begin
  // Save Configuration to Registry
  try
    if RegCreateKeyExA(HKEY_CURRENT_USER, szRegistryKey, 0, NULL, REG_OPTION_NON_VOLATILE, KEY_SET_VALUE, NULL, {var}hKey, @dwDisposition) = ERROR_SUCCESS then
    try
      dwType := REG_DWORD;
      dwSize := sizeof(DWORD);
      RegSetValueExA(hKey, 'BypassSymbolCache', 0, dwType, PBYTE(@m_BypassSymbolCache), dwSize);
    finally
      RegCloseKey(hKey);
    end;
  except
    raise Exception.Create('SaveExtraSettings raised an exception');
  end;
end;

procedure EmuShared.Destroy;
begin
  Save;
end;

// Xbox Video Accessors

procedure EmuShared.GetXBSound(sound: PXBSound);
begin
  Lock();
  sound^ := {shared}m_XBSound;
  Unlock();
end;

procedure EmuShared.GetXBVideo(video: PXBVideo);
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  Lock();
  video^ := {shared}m_XBVideo;
  Unlock();
end;

procedure EmuShared.SetXBSound(const sound: PXBSound);
begin
  Lock();
  {shared}m_XBSound := sound^;
  Unlock();
end;

procedure EmuShared.SetXBVideo(const video: PXBVideo);
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  Lock();
  {shared}m_XBVideo := video^;
  Unlock();
end;

// Xbox Controller Accessors

procedure EmuShared.GetXBController(ctrl: PXBController);
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  Lock();
  ctrl^ := {shared}m_XBController;
  Unlock();
end;

procedure EmuShared.SetXBController(const ctrl: PXBController);
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  Lock();
  {shared}m_XBController := ctrl^;
  Unlock();
end;

procedure EmuShared.GetXbePath(var Path: string);
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  Lock();
  {var}Path := string(AnsiString({shared}m_XbePath)); // explicit cast to silence Unicode warnings
  Unlock();
end;

procedure EmuShared.SetXbePath(const Path: AnsiString);
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  WriteLog('EmuShared.SetXbePath(' + string(Path) + ');');
  Lock();
  CopyMemory(@({shared}m_XbePath[0]), PAnsiChar(Path), Length(Path) + 1);
  Unlock();
end;

procedure SetXbePath(const Path: PAnsiChar); stdcall;
// Branch:shogun  Revision:20100412  Translator:PatrickvL  Done:100
begin
  if Assigned(g_EmuShared) then
    g_EmuShared.SetXbePath(AnsiString(Path));
end;

exports
  SetXbePath name '?SetXbePath@EmuShared@@QAEXPBD@Z';

end.
