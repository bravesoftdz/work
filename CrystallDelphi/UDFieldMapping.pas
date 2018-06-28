unit UDFieldMapping;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeFieldMappingDlg = class(TForm)
    pnlMapFields: TPanel;
    lbReportFields: TListBox;
    lblUnmappedFields: TLabel;
    cbDatabaseFields: TComboBox;
    lblDatabaseFields: TLabel;
    btnMap: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    editFieldType: TEdit;
    lblFieldType: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbReportFieldsClick(Sender: TObject);
    procedure btnMapClick(Sender: TObject);
    procedure cbDatabaseFieldsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ReportFields1   : TList;
    DataBaseFields1 : TList;
  end;

var
  CrpeFieldMappingDlg: TCrpeFieldMappingDlg;
  RptFields   : TCrFieldMappingInfo;
  DBFields    : TCrFieldMappingInfo;
  slRptFields : TStringList;
  slDBFields  : TStringList;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFieldMappingDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFieldMappingDlg.FormShow(Sender: TObject);
var
  cnt: integer;
begin
  slRptFields := TStringList.Create;
  slDBFields := TStringList.Create;
  for cnt := 0 to ReportFields1.Count - 1 do
  begin
    RptFields := TCrFieldMappingInfo(ReportFields1[cnt]);
    if RptFields.MapTo = -1 then
    begin
      slRptFields.Add(RptFields.TableName + '.' + RptFields.FieldName);
      slRptFields.Objects[slRptFields.Count - 1] := ReportFields1[cnt];
    end;
  end;
 lbReportFields.Items.AddStrings(slRptFields);
  for cnt := 0 to DatabaseFields1.Count - 1 do
  begin
    DBFields := TCrFieldMappingInfo(DatabaseFields1[cnt]);
    if DBFields.MapTo = -1 then
    begin
      slDBFields.Add(DBFields.TableName + '.' + DBFields.FieldName);
      slDBFields.Objects[slDBFields.Count - 1] := DatabaseFields1[cnt];
      DBFields.MapTo := cnt;
    end;
  end;
  cbDatabaseFields.Items.AddStrings(slDBFields);
  btnMap.Enabled := False;
  lbReportFields.ItemIndex := 0;
  lbReportFieldsClick(lbReportFields);
end;
{------------------------------------------------------------------------------}
{ lbReportFieldsClick                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFieldMappingDlg.lbReportFieldsClick(Sender: TObject);
begin
  RptFields := TCrFieldMappingInfo(slRptFields.Objects[lbReportFields.ItemIndex]);
  editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
        Ord(RptFields.FieldType));
end;
{------------------------------------------------------------------------------}
{ btnMapClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeFieldMappingDlg.btnMapClick(Sender: TObject);
begin
  if (lbReportFields.ItemIndex > -1) and
     (cbDatabaseFields.ItemIndex > -1) then
  begin
    {Assign the pointers}
    RptFields := TCrFieldMappingInfo(slRptFields.Objects[lbReportFields.ItemIndex]);
    DBFields := TCrFieldMappingInfo(slDBFields.Objects[cbDatabaseFields.ItemIndex]);
    {Set the MapTo number to the Database field item number}
    RptFields.MapTo := DBFields.MapTo;
    {Delete the two fields from the listbox and combobox}
    lbReportFields.Items.Delete(lbReportFields.ItemIndex);
    cbDatabaseFields.Items.Delete(cbDatabaseFields.ItemIndex);
  end;
  btnMap.Enabled := (lbReportFields.Items.Count > 0);
  btnMap.Enabled := (cbDatabaseFields.ItemIndex > -1);
end;
{------------------------------------------------------------------------------}
{ cbDatabaseFieldsChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeFieldMappingDlg.cbDatabaseFieldsChange(Sender: TObject);
begin
  btnMap.Enabled := (cbDatabaseFields.ItemIndex > -1);
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFieldMappingDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFieldMappingDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFieldMappingDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  slRptFields.Free;
  slDBFields.Free;
  Release;
end;


end.
