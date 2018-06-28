unit UDTableFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCrpe32, Grids;

type
  TCrpeTableFieldsDlg = class(TForm)
    btnOk: TButton;
    sgFields: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpdateFields;
    procedure sgFieldsClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr         : TCrpe;
    FieldIndex : smallint;
  end;

var
  CrpeTableFieldsDlg: TCrpeTableFieldsDlg;
  bTableFields      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDTables, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeTableFieldsDlg.FormCreate(Sender: TObject);
begin
  bTableFields := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTableFieldsDlg.FormShow(Sender: TObject);
begin
  sgFields.RowCount := 2;
  {Grid Titles}
  sgFields.ColWidths[0] := 45;
  sgFields.ColWidths[1] := 150;
  sgFields.ColWidths[2] := 90;
  sgFields.ColWidths[3] := 45;
  sgFields.Cells[0,0] := 'Number';
  sgFields.Cells[1,0] := 'Name';
  sgFields.Cells[2,0] := 'FieldType';
  sgFields.Cells[3,0] := 'NBytes';
  UpdateFields;
end;
{------------------------------------------------------------------------------}
{ UpdateFields procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeTableFieldsDlg.UpdateFields;
var
  i     : smallint;
  OnOff : boolean;
begin
  if Cr.Tables.Item.Fields.ItemIndex > -1 then
    FieldIndex := Cr.Tables.Item.Fields.ItemIndex
  else
    FieldIndex := 0;

  {Enable/Disable controls}
  OnOff := (Cr.Tables.Item.Fields.Count > 0);
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TStringGrid then
      begin
        TStringGrid(Components[i]).Color := ColorState(OnOff);
        TStringGrid(Components[i]).Enabled := OnOff;
      end;
    end;
  end;

  {Update list box}
  if OnOff = True then
  begin
    {Field}
    for i := 0 to (Cr.Tables.Item.Fields.Count - 1) do
    begin
      sgFields.Cells[0,i+1] := IntToStr(i);
      sgFields.Cells[1,i+1] := Cr.Tables.Item.Fields[i].FieldName;
      sgFields.Cells[2,i+1] := GetEnumName(TypeInfo(TCrFieldValueType),Ord(Cr.Tables.Item.Fields[i].FieldType));
      sgFields.Cells[3,i+1] := IntToStr(Cr.Tables.Item.Fields[i].FieldLength);
      if i <> (Cr.Tables.Item.Fields.Count - 1) then
        sgFields.RowCount := sgFields.RowCount + 1;
    end;
    sgFields.Row := FieldIndex + 1;
    sgFieldsClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ sgFieldsClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeTableFieldsDlg.sgFieldsClick(Sender: TObject);
begin
  FieldIndex := sgFields.Row - 1;
  Cr.Tables.Item.Fields[FieldIndex];
//  editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
//    Ord(Cr.Tables.Item.Fields.Item.FieldType));
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeTableFieldsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeTableFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bTableFields := False;
  Release;
end;


end.
