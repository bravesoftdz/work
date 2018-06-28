unit UDEmbeddedFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeEmbeddedFieldsDlg = class(TForm)
    pnlEmbeddedFields: TPanel;
    lblNames: TLabel;
    lblFieldName: TLabel;
    lblFieldType: TLabel;
    lblTextStart: TLabel;
    lblCount: TLabel;
    lbNumbers: TListBox;
    editFieldName: TEdit;
    editFieldType: TEdit;
    editTextStart: TEdit;
    btnBorder: TButton;
    btnFormat: TButton;
    editCount: TEdit;
    btnOk: TButton;
    btnClear: TButton;
    btnInsert: TButton;
    btnDelete: TButton;
    Label1: TLabel;
    editFieldObjectType: TEdit;
    lblTextEnd: TLabel;
    editTextEnd: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InitializeControls(OnOff: boolean);
    procedure UpdateEmbeddedFields;
  private
    { Private declarations }
  public
    { Public declarations }
    Cr        : TCrpe;
    FIndex    : integer;
    CursorPos : integer;
  end;

var
  CrpeEmbeddedFieldsDlg: TCrpeEmbeddedFieldsDlg;
  bEmbeddedFields      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat, UDFieldSelect, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnInsert.Tag := 1;
  FIndex := -1;
  bEmbeddedFields := True;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateEmbeddedFields;
end;
{------------------------------------------------------------------------------}
{ UpdateTextObjects                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.UpdateEmbeddedFields;
var
  OnOff : boolean;
  i     : integer;
begin
  FIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
  begin
    OnOff := False;
    btnInsert.Enabled := False;
  end
  else
  begin
    OnOff := (Cr.TextObjects.Item.EmbeddedFields.Count > 0);
    btnInsert.Enabled := True;
    {Get EmbeddedFields Index}
    if OnOff then
    begin
      if Cr.TextObjects.Item.EmbeddedFields.ItemIndex > -1 then
        FIndex := Cr.TextObjects.Item.EmbeddedFields.ItemIndex
      else
        FIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Numbers ListBox}
    for i := 0 to Cr.TextObjects.Item.EmbeddedFields.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.TextObjects.Item.EmbeddedFields.Count);
    lbNumbers.ItemIndex := FIndex;
    lbNumbersClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.InitializeControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    if TComponent(Components[i]).Tag = 0 then
    begin
      if Components[i] is TButton then
        TButton(Components[i]).Enabled := OnOff;
      if Components[i] is TRadioGroup then
        TRadioGroup(Components[i]).Enabled := OnOff;
      if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).Color := ColorState(OnOff);
        TComboBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TListBox then
      begin
        TListBox(Components[i]).Clear;
        TListBox(Components[i]).Color := ColorState(OnOff);
        TListBox(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TMemo then
      begin
        TMemo(Components[i]).Clear;
        TMemo(Components[i]).Color := ColorState(OnOff);
        TMemo(Components[i]).Enabled := OnOff;
      end;
      if Components[i] is TEdit then
      begin
        TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.lbNumbersClick(Sender: TObject);
begin
  FIndex := lbNumbers.ItemIndex;
  editFieldName.Text := Cr.TextObjects.Item.EmbeddedFields[FIndex].FieldName;
  editFieldObjectType.Text := GetEnumName(TypeInfo(TCrFieldObjectType),
    Ord(Cr.TextObjects.Item.EmbeddedFields.Item.FieldObjectType));
  editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
    Ord(Cr.TextObjects.Item.EmbeddedFields.Item.FieldType));
  editTextStart.Text := IntToStr(Cr.TextObjects.Item.EmbeddedFields.Item.TextStart);
  editTextEnd.Text := IntToStr(Cr.TextObjects.Item.EmbeddedFields.Item.TextEnd);
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.TextObjects.Item.EmbeddedFields.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.TextObjects.Item.EmbeddedFields.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnInsertClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.btnInsertClick(Sender: TObject);
begin
  CrpeFieldSelectDlg := TCrpeFieldSelectDlg.Create(Application);
  CrpeFieldSelectDlg.Cr := Cr;
  CrpeFieldSelectDlg.EFSelect := True;
  CrpeFieldSelectDlg.ShowModal;
  if CrpeFieldSelectDlg.ModalResult = mrOk then
  begin
    Cr.TextObjects.Item.EmbeddedFields.Insert(Cr.Tables.Item.Fields.Item.FullName,
      CursorPos);
  end;
  UpdateEmbeddedFields;
end;
{------------------------------------------------------------------------------}
{ btnDeleteClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.btnDeleteClick(Sender: TObject);
begin
  Cr.TextObjects.Item.EmbeddedFields.Delete(FIndex);
  UpdateEmbeddedFields;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.btnClearClick(Sender: TObject);
begin
  Cr.TextObjects.Item.EmbeddedFields.Clear;
  UpdateEmbeddedFields;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeEmbeddedFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bEmbeddedFields := False;
  Release;
end;


end.
