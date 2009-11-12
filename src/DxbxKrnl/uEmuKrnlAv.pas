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
unit uEmuKrnlAv;

{$INCLUDE Dxbx.inc}

interface

uses
  // Delphi
  SysUtils,
  // Jedi
  JwaWinType,
  JwaWinBase,
  JwaWinNT,
  JwaNative,
  JwaNTStatus,
  // OpenXDK
  XboxKrnl,
  // Dxbx
  uLog,
  uEmuFS,
  uEmuFile,
  uEmuXapi,
  uEmuKrnl,
  uDxbxKrnl;

function {001} xboxkrnl_AvGetSavedDataAddress(
  ): PVOID; stdcall; // Source: OpenXDK
procedure {002} xboxkrnl_AvSendTVEncoderOption(
  RegisterBase: PVOID;
  Option: ULONG;
  Param: ULONG;
  Result: PULONG // OUT
  ); stdcall; // Source: OpenXDK
function {003} xboxkrnl_AvSetDisplayMode(
  RegisterBase: PVOID;
  Step: ULONG;
  Mode: ULONG;
  Format: ULONG;
  Pitch: ULONG;
  FrameBuffer: ULONG
  ): ULONG; stdcall; // Source: OpenXDK
procedure {004} xboxkrnl_AvSetSavedDataAddress(
  Address: PVOID
  ); stdcall; // Source: OpenXDK

implementation

function {001} xboxkrnl_AvGetSavedDataAddress(
  ): PVOID; stdcall; // Source: OpenXDK
// Branch:shogun  Revision:2  Translator:PatrickvL  Done:100
begin
  EmuSwapFS(fsWindows);

  DbgPrintf('EmuKrnl : AvGetSavedDataAddress();');

  // Cxbx TODO: We might want to return something sometime...

  EmuSwapFS(fsXbox);

  Result := PVOID($F0040000); // Dxbx TODO : Take shogun's NULL ?
end;

procedure {002} xboxkrnl_AvSendTVEncoderOption(
  RegisterBase: PVOID;
  Option: ULONG;
  Param: ULONG;
  Result: PULONG // OUT
  ); stdcall; // Source: OpenXDK
begin
  EmuSwapFS(fsWindows);
  Unimplemented('AvSendTVEncoderOption');
  EmuSwapFS(fsXbox);
end;

function {003} xboxkrnl_AvSetDisplayMode(
  RegisterBase: PVOID;
  Step: ULONG;
  Mode: ULONG;
  Format: ULONG;
  Pitch: ULONG;
  FrameBuffer: ULONG
  ): ULONG; stdcall; // Source: OpenXDK
begin
  EmuSwapFS(fsWindows);
  Result := Unimplemented('AvSetDisplayMode');
  EmuSwapFS(fsXbox);
end;

procedure {004} xboxkrnl_AvSetSavedDataAddress(
  Address: PVOID
  ); stdcall; // Source: OpenXDK
begin
  EmuSwapFS(fsWindows);
  Unimplemented('AvSetSavedDataAddress');
  EmuSwapFS(fsXbox);
end;

end.
