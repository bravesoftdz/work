(*-----------------------------------------------------------
 Name:               $File: //depot/Reporting/Mainline/sdk/VCL/Delphi/UCrDataSource.pas $
 Version:            $Revision: #3 $
 Last Modified Date: $Date: 2003/07/15 $

 Copyright (c) 2002-2003 Crystal Decisions, Inc.
 895 Emerson St., Palo Alto, California, USA 94301.

 All rights reserved.

 This file contains confidential, proprietary information, trade secrets and copyrighted expressions
 that are the property of Crystal Decisions, Inc., 895 Emerson St., Palo Alto, California, USA 94301.

 Any disclosure, reproduction, sale or license of all or any part of the information or expression
 contained in this file is prohibited by California law and the United States copyright law, and may
 be subject to criminal penalties.

 If you are not an employee of Crystal Decisions or otherwise authorized in writing by Crystal Decisions
 to possess this file, please contact Crystal Decisions immediately at the address listed above.
-----------------------------------------------------------
*)

unit UCrDataSource;

// ************************************************************************ //
// WARNING                                                                  //
// -------                                                                  //
// The types declared in this file were generated from data read from a     //
// Type Library. If this type library is explicitly or indirectly (via      //
// another type library referring to this type library) re-imported, or the //
// 'Refresh' command of the Type Library Editor activated while editing the //
// Type Library, the contents of this file will be regenerated and all      //
// manual modifications will be lost.                                       //
// ************************************************************************ //

// PASTLWTR : $Revision: #3 $
// File generated on 7-5-00 22:42:59 from Type Library described below.

// ************************************************************************ //
// Type Lib: C:\Program Files\Crystal Decisions\Report Designer Component\crsource.tlb
// IID\LCID: {F4ED51C3-E0D5-11D1-92B3-00A0C92765B4}\0
// Helpfile: 
// HelpString: CRDataSource 1.0 Type Library
// Version:    1.0
// ************************************************************************ //

interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:      //
//   Type Libraries     : LIBID_xxxx                                    //
//   CoClasses          : CLASS_xxxx                                    //
//   DISPInterfaces     : DIID_xxxx                                     //
//   Non-DISP interfaces: IID_xxxx                                      //
// *********************************************************************//
const
  LIBID_CRDataSourceLib: TGUID = '{F4ED51C3-E0D5-11D1-92B3-00A0C92765B4}';
  IID_ICRDataSource: TGUID = '{F4ED51D0-E0D5-11D1-92B3-00A0C92765B4}';
  CLASS_CRDataSource: TGUID = '{F4ED51D1-E0D5-11D1-92B3-00A0C92765B4}';
type

// *********************************************************************//
// Forward declaration of interfaces defined in Type Library            //
// *********************************************************************//
  ICRDataSource = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                     //
// (NOTE: Here we map each CoClass to its Default Interface)            //
// *********************************************************************//
  CRDataSource = ICRDataSource;


// *********************************************************************//
// Interface: ICRDataSource
// Flags:     (0)
// GUID:      {F4ED51D0-E0D5-11D1-92B3-00A0C92765B4}
// *********************************************************************//
  ICRDataSource = interface(IUnknown)
    ['{F4ED51D0-E0D5-11D1-92B3-00A0C92765B4}']
    function Get_FieldCount(out pVal: Smallint): HResult; stdcall;
    function Get_RecordCount(out pVal: Integer): HResult; stdcall;
    function Get_FieldName(FieldIndex: Smallint; out pVal: WideString): HResult; stdcall;
    function Get_FieldType(FieldIndex: Smallint; out pVal: Smallint): HResult; stdcall;
    function Get_FieldValue(FieldIndex: Smallint; out pVal: OleVariant): HResult; stdcall;
    function MoveFirst: HResult; stdcall;
    function MoveNext: HResult; stdcall;
    function Get_Bookmark(out pVal: OleVariant): HResult; stdcall;
    function Set_Bookmark(pVal: OleVariant): HResult; stdcall;
    function Get_EOF(out pVal: WordBool): HResult; stdcall;
  end;

  CoCRDataSource = class
    class function Create: ICRDataSource;
    class function CreateRemote(const MachineName: string): ICRDataSource;
  end;

implementation

uses ComObj;

class function CoCRDataSource.Create: ICRDataSource;
begin
  Result := CreateComObject(CLASS_CRDataSource) as ICRDataSource;
end;

class function CoCRDataSource.CreateRemote(const MachineName: string): ICRDataSource;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CRDataSource) as ICRDataSource;
end;


end.

