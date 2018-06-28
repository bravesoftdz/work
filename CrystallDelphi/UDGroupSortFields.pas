unit UDGroupSortFields;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeGroupSortFieldsDlg = class(TForm)
    pnlGroupSortFields: TPanel;
    lblFieldName: TLabel;
    lblNumber: TLabel;
    editFieldName: TEdit;
    rgDirection: TRadioGroup;
    lbNumbers: TListBox;
    btnEdit: TButton;
    btnOk: TButton;
    btnClear: TButton;
    btnAdd: TButton;
    btnDelete: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    procedure lbNumbersClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure rgDirectionClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure UpdateGroupSortFields;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editFieldNameExit(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr      : TCrpe;
    GSIndex : smallint;
  end;

var
  CrpeGroupSortFieldsDlg: TCrpeGroupSortFieldsDlg;
  bGroupSortFields      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDSortFieldBuild;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.FormCreate(Sender: TObject);
begin
  bGroupSortFields := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnAdd.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.FormShow(Sender: TObject);
begin
  UpdateGroupSortFields;
end;
{------------------------------------------------------------------------------}
{ UpdateGroupSortFields procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.UpdateGroupSortFields;
var
  OnOff : boolean;
  i     : integer;
begin
  GSIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
  begin
    OnOff := False;
    btnAdd.Enabled := False;
  end
  else
  begin
    OnOff := (Cr.GroupSortFields.Count > 0);
    btnAdd.Enabled := True;
    {Get GroupSortFields Index}
    if OnOff then
    begin
      if Cr.GroupSortFields.ItemIndex > -1 then
        GSIndex := Cr.GroupSortFields.ItemIndex
      else
        GSIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Numbers ListBox}
    for i := 0 to Cr.GroupSortFields.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.GroupSortFields.Count);
    lbNumbers.ItemIndex := GSIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.InitializeControls(OnOff: boolean);
var
  i      : integer;
  xEvent : TNotifyEvent;
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
      if Components[i] is TEdit then
      begin
        xEvent := TEdit(Components[i]).OnChange;
        TEdit(Components[i]).OnChange := nil;
        TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
        TEdit(Components[i]).OnChange := xEvent;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbGSNumbersClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.lbNumbersClick(Sender: TObject);
begin
  Cr.GroupSortFields[lbNumbers.ItemIndex];
  editFieldName.Text := Cr.GroupSortFields.Item.FieldName;
  rgDirection.ItemIndex := Ord(Cr.GroupSortFields.Item.Direction);
end;
{------------------------------------------------------------------------------}
{ editFieldExit procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.editFieldNameExit(Sender: TObject);
begin
  Cr.GroupSortFields.Item.FieldName := editFieldName.Text;
  UpdateGroupSortFields;
end;
{------------------------------------------------------------------------------}
{ rgGSDirectionClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.rgDirectionClick(Sender: TObject);
begin
  Cr.GroupSortFields.Item.Direction := TCrSortDirection(rgDirection.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ btnAddGSFieldClick procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.btnAddClick(Sender: TObject);
begin
  CrpeBuildSortFieldDlg := TCrpeBuildSortFieldDlg.Create(Application);
  CrpeBuildSortFieldDlg.Cr := Cr;
  CrpeBuildSortFieldDlg.Caption := 'Add GroupSortField';
  CrpeBuildSortFieldDlg.ShowModal;
  if CrpeBuildSortFieldDlg.ModalResult = mrOk then
  begin
     Cr.GroupSortFields.Add(CrpeBuildSortFieldDlg.rField);
     UpdateGroupSortFields;
  end;
end;
{------------------------------------------------------------------------------}
{ btnRemoveGSFieldClick procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.btnDeleteClick(Sender: TObject);
var
  nIndex : integer;
begin
  nIndex := lbNumbers.ItemIndex;
  {Delete SortField from VCL}
  Cr.GroupSortFields.Delete(nIndex);
  UpdateGroupSortFields;
  {Reset ItemIndex}
  if lbNumbers.Items.Count > 0 then
  begin
    if (nIndex > (lbNumbers.Items.Count - 1)) or (nIndex < 0) then
      nIndex := (lbNumbers.Items.Count - 1);
    lbNumbers.ItemIndex := nIndex;
    lbNumbersClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.btnClearClick(Sender: TObject);
begin
  Cr.GroupSortFields.Clear;
  UpdateGroupSortFields;
end;
{------------------------------------------------------------------------------}
{ btnBuildGSFieldClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.btnEditClick(Sender: TObject);
begin
  CrpeBuildSortFieldDlg := TCrpeBuildSortFieldDlg.Create(Application);
  CrpeBuildSortFieldDlg.Caption := 'Edit GroupSortField';
  CrpeBuildSortFieldDlg.Cr := Cr;
  CrpeBuildSortFieldDlg.ShowModal;
  if CrpeBuildSortFieldDlg.ModalResult = mrOk then
    editFieldName.Text := CrpeBuildSortFieldDlg.rField;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.btnOkClick(Sender: TObject);
begin
  if not IsStrEmpty(Cr.ReportName) then
    editFieldNameExit(Self);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeGroupSortFieldsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bGroupSortFields := False;
  Release;
end;


end.
