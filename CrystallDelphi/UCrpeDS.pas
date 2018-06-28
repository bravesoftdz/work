(*
-----------------------------------------------------------
 Name:               $File: //depot/Reporting/Mainline/sdk/VCL/Delphi/UCrpeDS.pas $
 Version:            $Revision: #7 $
 Last Modified Date: $Date: 2004/02/10 $

 Copyright (c) 2001-2003 Crystal Decisions, Inc.
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

Crystal Reports DataSource Component
============================================
Version  : 10
Supports : Delphi 7 / C++ Builder 6
*)
unit UCrpeDS;

{$I UCRPEDEF.INC}

interface

uses Classes, Windows, Db, UCrDataSource;

type
  TCrpeDSFieldCountEvent = procedure(Sender: TObject; DataSet: TDataSet;
    var FieldCount: Smallint) of object;
  TCrpeDSRecordCountEvent = procedure(Sender: TObject; DataSet: TDataSet;
    var RecordCount: Integer) of object;
  TCrpeDSFieldNameEvent = procedure(Sender: TObject; DataSet: TDataSet;
    FieldIndex: Smallint; var FieldName: WideString) of object;
  TCrpeDSFieldTypeEvent = procedure(Sender: TObject; DataSet: TDataSet;
    FieldIndex: Smallint; var FieldType: Smallint) of object;
  TCrpeDSBlobFieldValueEvent = procedure(Sender: TObject; DataSet: TDataSet;
    FieldIndex: Smallint; var BlobFieldValue: TMemoryStream) of object;
  TCrpeDSFieldValueEvent = procedure(Sender: TObject; DataSet: TDataSet;
    FieldIndex: Smallint; var FieldValue: OleVariant) of object;
  TCrpeDSMoveFirstEvent = procedure(Sender: TObject; DataSet: TDataSet) of object;
  TCrpeDSMoveNextEvent = procedure(Sender: TObject; DataSet: TDataSet) of object;
  TCrpeDSGetBookmarkEvent = procedure(Sender: TObject; DataSet: TDataSet;
    var Bookmark: OleVariant) of object;
  TCrpeDSSetBookmarkEvent = procedure(Sender: TObject; DataSet: TDataSet;
    var Bookmark: OleVariant) of object;
  TCrpeDSGetEOFEvent = procedure(Sender: TObject; DataSet: TDataSet;
    var EndOfFile: Boolean) of object;

  TCrDataSource = class(TInterfacedObject, ICRDataSource)
  private
    FComponent        : TComponent;
    FDataSet          : TDataSet;
    FOnFieldCount     : TCrpeDSFieldCountEvent;
    FOnRecordCount    : TCrpeDSRecordCountEvent;
    FOnFieldName      : TCrpeDSFieldNameEvent;
    FOnFieldType      : TCrpeDSFieldTypeEvent;
    FOnBlobFieldValue : TCrpeDSBlobFieldValueEvent;
    FOnFieldValue     : TCrpeDSFieldValueEvent;
    FOnMoveFirst      : TCrpeDSMoveFirstEvent;
    FOnMoveNext       : TCrpeDSMoveNextEvent;
    FOnGetBookmark    : TCrpeDSGetBookmarkEvent;
    FOnSetBookmark    : TCrpeDSSetBookmarkEvent;
    FOnGetEOF         : TCrpeDSGetEOFEvent;
  published
  public
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
    procedure SetDataSet(xDataSet: TDataSet);
  end;

  TCrDSAbout = string;

  TCrpeDS = class(TComponent)
  private
    FCrDataSource     : TCrDataSource;
    FInterface        : ICRDataSource;
    FAbout            : string;
    FOnFieldCount     : TCrpeDSFieldCountEvent;
    FOnRecordCount    : TCrpeDSRecordCountEvent;
    FOnFieldName      : TCrpeDSFieldNameEvent;
    FOnFieldType      : TCrpeDSFieldTypeEvent;
    FOnBlobFieldValue : TCrpeDSBlobFieldValueEvent;
    FOnFieldValue     : TCrpeDSFieldValueEvent;
    FOnMoveFirst      : TCrpeDSMoveFirstEvent;
    FOnMoveNext       : TCrpeDSMoveNextEvent;
    FOnGetBookmark    : TCrpeDSGetBookmarkEvent;
    FOnSetBookmark    : TCrpeDSSetBookmarkEvent;
    FOnGetEOF         : TCrpeDSGetEOFEvent;
  protected
    function  GetDataSet : TDataSet;
    procedure SetDataSet(xDataSet: TDataSet);
  published
    property About : TCrDSAbout
        read FAbout
       write FAbout;
    property DataSet : TDataSet
        read GetDataSet
       write SetDataSet;
    property OnGetFieldCount : TCrpeDSFieldCountEvent
        read FOnFieldCount
       write FOnFieldCount;
    property OnGetRecordCount : TCrpeDSRecordCountEvent
        read FOnRecordCount
       write FOnRecordCount;
    property OnGetFieldName : TCrpeDSFieldNameEvent
        read FOnFieldName
       write FOnFieldName;
    property OnGetFieldType : TCrpeDSFieldTypeEvent
        read FOnFieldType
       write FOnFieldType;
    property OnGetBlobFieldValue : TCrpeDSBlobFieldValueEvent
        read FOnBlobFieldValue
       write FOnBlobFieldValue;
    property OnGetFieldValue : TCrpeDSFieldValueEvent
        read FOnFieldValue
       write FOnFieldValue;
    property OnMoveFirst : TCrpeDSMoveFirstEvent
        read FOnMoveFirst
       write FOnMoveFirst;
    property OnMoveNext : TCrpeDSMoveNextEvent
        read FOnMoveNext
       write FOnMoveNext;
    property OnGetBookmark : TCrpeDSGetBookmarkEvent
        read FOnGetBookmark
       write FOnGetBookmark;
    property OnSetBookmark : TCrpeDSSetBookmarkEvent
        read FOnSetBookmark
       write FOnSetBookmark;
    property OnEOF : TCrpeDSGetEOFEvent
        read FOnGetEOF
       write FOnGetEOF;
  public
    function DataPointer: Pointer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses Variants;

{******************************************************************************}
{ TCrpeDS                                                                      }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ Create                                                                       }
{------------------------------------------------------------------------------}
constructor TCrpeDS.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAbout         := 'Version and Credits...';
  FInterface     := nil;
  FCrDataSource  := TCrDataSource.Create;
  FCrDataSource._AddRef;
  FCrDataSource.FComponent := Self;
end;
{------------------------------------------------------------------------------}
{ Destroy                                                                      }
{------------------------------------------------------------------------------}
destructor TCrpeDS.Destroy;
begin
  FInterface := nil;
  FCrDataSource.SetDataSet(nil);
  FCrDataSource._Release;
  inherited Destroy;
end;
{------------------------------------------------------------------------------}
{ GetDataSet                                                                   }
{------------------------------------------------------------------------------}
function TCrpeDS.GetDataSet: TDataSet;
begin
  Result := FCrDataSource.FDataSet;
end;
{------------------------------------------------------------------------------}
{ SetDataSet                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeDS.SetDataSet(xDataSet: TDataSet);
begin
  FCrDataSource.FDataSet := xDataSet;
end;
{------------------------------------------------------------------------------}
{ DataPointer                                                                  }
{------------------------------------------------------------------------------}
function TCrpeDS.DataPointer: Pointer;
begin
  FInterface := FCrDataSource;
  Result := Addr(FInterface);
end;


{******************************************************************************}
{ TCrDataSource                                                                }
{******************************************************************************}
{------------------------------------------------------------------------------}
{ SetDataSet                                                                   }
{------------------------------------------------------------------------------}
procedure TCrDataSource.SetDataSet(xDataSet: TDataSet);
begin
  FDataSet := xDataSet;
end;
{------------------------------------------------------------------------------}
{ Get_FieldCount                                                               }
{------------------------------------------------------------------------------}
function TCrDataSource.Get_FieldCount(out pVal: Smallint): HResult; stdcall;
begin
  pVal := 0;
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    pVal := FDataSet.FieldCount;
  end;
  if Assigned(FComponent) then
    FOnFieldCount := TCrpeDS(FComponent).FOnFieldCount;
  if Assigned(FOnFieldCount) then
    FOnFieldCount(FComponent, FDataSet, pVal);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ Get_RecordCount                                                              }
{------------------------------------------------------------------------------}
function TCrDataSource.Get_RecordCount(out pVal: Integer): HResult; stdcall;
begin
  pVal := 0;
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    pVal := FDataSet.RecordCount;
  end;
  if Assigned(FComponent) then
    FOnRecordCount := TCrpeDS(FComponent).FOnRecordCount;
  if Assigned(FOnRecordCount) then
    FOnRecordCount(FComponent, FDataSet, pVal);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ Get_FieldName                                                                }
{------------------------------------------------------------------------------}
function TCrDataSource.Get_FieldName(FieldIndex: Smallint;
  out pVal: WideString): HResult; stdcall;
begin
  pVal := '';
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    pVal := FDataSet.Fields[FieldIndex].FieldName;
  end;
  if Assigned(FComponent) then
    FOnFieldName := TCrpeDS(FComponent).FOnFieldName;
  if Assigned(FOnRecordCount) then
    FOnFieldName(FComponent, FDataSet, FieldIndex, pVal);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ Get_FieldType                                                                }
{------------------------------------------------------------------------------}
function TCrDataSource.Get_FieldType(FieldIndex: Smallint;
  out pVal: Smallint): HResult; stdcall;
begin
  pVal := varEmpty;
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    case FDataSet.Fields[FieldIndex].DataType of
      ftUnknown     : pVal := varUnknown;               //not supported.
      ftString      : pVal := varOleStr;
      ftSmallint    : pVal := varSmallint;
      ftInteger     : pVal := varInteger;
      ftWord        : pVal := varInteger;
      ftBoolean     : pVal := varBoolean;
      ftFloat       : pVal := varDouble;
      ftCurrency    : pVal := varCurrency;
      ftBCD         : pVal := varDouble;
      ftDate        : pVal := varDate;
      ftTime        : pVal := varDate;
      ftDateTime    : pVal := varDate;
      ftBytes       : pVal := varByte;
      ftVarBytes    : pVal := varByte;
      ftAutoInc     : pVal := varInteger;
      ftBlob        : pVal := varArray or varByte;
      ftMemo        : pVal := varOleStr;
      ftGraphic     : pVal := varArray or varByte;
      ftFmtMemo     : pVal := varOleStr;                //not tested
      ftParadoxOle  : pVal := varArray or varByte;      //not tested.
      ftDBaseOle    : pVal := varArray or varByte;      //not tested.
      ftTypedBinary : pVal := varArray or varByte;
      ftCursor      : pVal := varArray or varByte;      //not tested.
      ftFixedChar   : pVal := varOleStr;                //not tested.
      ftWideString  : pVal := varOleStr;
      ftLargeint    : pVal := varInteger;
      ftADT         : pVal := varArray or varByte;      //not tested.
      ftArray       : pVal := varArray or varByte;      //not tested.
      ftReference   : pVal := varArray or varByte;      //not tested.
      ftDataSet     : pVal := varArray or varByte;      //not tested.
      ftOraBlob     : pVal := varArray or varByte;
      ftOraClob     : pVal := varOleStr;
      ftVariant     : pVal := varArray or varByte;      //not tested.
      ftInterface   : pVal := varArray or varByte;      //not tested.
      ftIDispatch   : pVal := varArray or varByte;      //not tested.
      ftGuid        : pVal := varOleStr;
    end;
  end;
  if Assigned(FComponent) then
    FOnFieldType := TCrpeDS(FComponent).FOnFieldType;
  if Assigned(FOnFieldType) then
    FOnFieldType(FComponent, FDataSet, FieldIndex, pVal);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ Get_FieldValue                                                               }
{------------------------------------------------------------------------------}
function TCrDataSource.Get_FieldValue(FieldIndex: Smallint;
  out pVal: OleVariant): HResult; stdcall;
var
  b   : TStream;
  m   : TMemoryStream;
  v   : Variant;
  i,j : integer;
  bx  : byte;
begin
  pVal := '';
  m := TMemoryStream.Create;
  {Connect the Event}
  if Assigned(FComponent) then
  begin
    FOnBlobFieldValue := TCrpeDS(FComponent).FOnBlobFieldValue;
    FOnFieldValue := TCrpeDS(FComponent).FOnFieldValue;
  end;
  {Check the DataSet}
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    case FDataSet.Fields[FieldIndex].DataType of
      ftBlob,
      ftGraphic,
      ftOraBlob :
        begin
          b := FDataSet.CreateBlobStream(FDataSet.Fields[FieldIndex], bmRead);
          m.LoadFromStream(b);
          i := m.Size;
          v := VarArrayCreate([0,i], varByte);
          m.Position := 0;
          for j := 0 to i do
          begin
            m.Read(bx, 1);
            v[j] := bx;
          end;
          pVal := v;
          b.Free;
        end;
      else
      begin
        pVal := FDataSet.Fields[FieldIndex].Value;
        if Assigned(FOnFieldValue) then
          FOnFieldValue(FComponent, FDataSet, FieldIndex, pVal);
      end;
    end;
  end;
  if Assigned(FOnBlobFieldValue) then
  begin
    m.Position := 0;
    FOnBlobFieldValue(FComponent, FDataSet, FieldIndex, m);
    i := m.Size;
    if (i > 0) and (m.Position > 0) then
    begin
      v := VarArrayCreate([0,i], varByte);
      m.Position := 0;
      for j := 0 to i do
      begin
        m.Read(bx, 1);
        v[j] := bx;
      end;
      pVal := v;
    end;
  end;
  m.Free;
  if Assigned(FOnFieldValue) then
    FOnFieldValue(FComponent, FDataSet, FieldIndex, pVal);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ MoveFirst                                                                    }
{------------------------------------------------------------------------------}
function TCrDataSource.MoveFirst: HResult; stdcall;
begin
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    FDataSet.First;
  end;
  if Assigned(FComponent) then
    FOnMoveFirst := TCrpeDS(FComponent).FOnMoveFirst;
  if Assigned(FOnMoveFirst) then
    FOnMoveFirst(FComponent, FDataSet);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ MoveNext                                                                     }
{------------------------------------------------------------------------------}
function TCrDataSource.MoveNext: HResult; stdcall;
begin
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    FDataSet.Next;
  end;
  if Assigned(FComponent) then
    FOnMoveNext := TCrpeDS(FComponent).FOnMoveNext;
  if Assigned(FOnMoveNext) then
    FOnMoveNext(FComponent, FDataSet);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ Get_Bookmark                                                                 }
{------------------------------------------------------------------------------}
function TCrDataSource.Get_Bookmark(out pVal: OleVariant): HResult; stdcall;
begin
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    pVal := Integer(FDataSet.Bookmark);
  end;
  if Assigned(FComponent) then
    FOnGetBookmark := TCrpeDS(FComponent).FOnGetBookmark;
  if Assigned(FOnGetBookmark) then
    FOnGetBookmark(FComponent, FDataSet, pVal);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ Set_Bookmark                                                                 }
{------------------------------------------------------------------------------}
function TCrDataSource.Set_Bookmark(pVal: OleVariant): HResult; stdcall;
begin
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    FDataSet.GotoBookmark(Pointer(Integer(pVal)));
  end;
  if Assigned(FComponent) then
    FOnSetBookmark := TCrpeDS(FComponent).FOnSetBookmark;
  if Assigned(FOnSetBookmark) then
    FOnSetBookmark(FComponent, FDataSet, pVal);
  Result := 0;
end;
{------------------------------------------------------------------------------}
{ Get_EOF                                                                      }
{------------------------------------------------------------------------------}
function TCrDataSource.Get_EOF(out pVal: WordBool): HResult; stdcall;
var
  b : Boolean;
begin
  if FDataSet <> nil then
  begin
    FDataSet.Active := True;
    pVal := FDataSet.EOF;
  end;
  if Assigned(FComponent) then
    FOnGetEOF := TCrpeDS(FComponent).FOnGetEOF;
  if Assigned(FOnGetEOF) then
  begin
    b := pVal;
    FOnGetEOF(FComponent, FDataSet, b);
    if b <> pVal then pVal := b;
  end;
  Result := 0;
end;


end.
