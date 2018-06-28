unit UDTables;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeTablesDlg = class(TForm)
    btnOk: TButton;
    btnClear: TButton;
    pnlTables: TPanel;
    lblNumber: TLabel;
    lblName: TLabel;
    lblPath: TLabel;
    lblPassword: TLabel;
    lblTableType: TLabel;
    lblDLLName: TLabel;
    lblServerType: TLabel;
    lblSubName: TLabel;
    lblConnectBuffer: TLabel;
    lbNumbers: TListBox;
    editName: TEdit;
    btnName: TButton;
    editPath: TEdit;
    btnPath: TButton;
    cbPropagate: TCheckBox;
    editPassword: TEdit;
    editTableType: TEdit;
    editDLLName: TEdit;
    editServerType: TEdit;
    btnCheckDifferences: TButton;
    editSubName: TEdit;
    editConnectBuffer: TEdit;
    btnTest: TButton;
    OpenDialog1: TOpenDialog;
    btnVerify: TButton;
    cbVerifyFix: TCheckBox;
    lblFieldMapping: TLabel;
    cbFieldMapping: TComboBox;
    lblAliasName: TLabel;
    editAliasName: TEdit;
    btnFields: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    btnConvertDriver: TButton;
    procedure btnNameClick(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure UpdateTables;
    procedure lbNumbersClick(Sender: TObject);
    procedure editNameChange(Sender: TObject);
    procedure editPasswordChange(Sender: TObject);
    procedure cbPropagateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure editSubNameChange(Sender: TObject);
    procedure editConnectBufferChange(Sender: TObject);
    procedure btnCheckDifferencesClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbFieldMappingChange(Sender: TObject);
    procedure cbVerifyFixClick(Sender: TObject);
    procedure btnVerifyClick(Sender: TObject);
    procedure editAliasNameChange(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure btnConvertDriverClick(Sender: TObject);
    procedure btnFieldsClick(Sender: TObject);
    procedure editServerTypeChange(Sender: TObject);
    procedure editPathExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr         : TCrpe;
    TableIndex : smallint;
    procedure OpenFieldsDlg;
  end;

var
  CrpeTablesDlg: TCrpeTablesDlg;
  bTables      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDPathEdit, UDTableFields;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.FormCreate(Sender: TObject);
begin
  bTables := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  TableIndex := -1;
  {FieldMapping}
  cbFieldMapping.Clear;
  cbFieldMapping.Items.Add('fmAuto');
  cbFieldMapping.Items.Add('fmPrompt');
  cbFieldMapping.Items.Add('fmEvent');
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.FormShow(Sender: TObject);
begin
  UpdateTables;
end;
{------------------------------------------------------------------------------}
{ UpdateTables procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.UpdateTables;
var
  OnOff  : boolean;
  Ver7   : Boolean;
  i      : integer;
begin
  TableIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Tables.Count > 0);
    {Get Tables Index}
    if OnOff then
    begin
      if Cr.Tables.ItemIndex > -1 then
        TableIndex := Cr.Tables.ItemIndex
      else
        TableIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    {Check for CRW 7+ features}
    Ver7 := (Cr.Version.Crpe.Major > 6);
    cbFieldMapping.Enabled := Ver7;
    btnVerify.Enabled := Ver7;
    cbVerifyFix.Enabled := Ver7;
    cbFieldMapping.ItemIndex := Ord(Cr.Tables.FieldMapping);
    lbNumbers.Clear;
    for i := 0 to (Cr.Tables.Count - 1) do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.Tables.Count);
    lbNumbers.ItemIndex := TableIndex;
    lbNumbersClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
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
        if not OnOff then
          TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  {Disable events}
  cbPropagate.OnClick := nil;
  {Update components}
  TableIndex := lbNumbers.ItemIndex;
  editName.Text := Cr.Tables[TableIndex].Name;
  editSubName.Text := Cr.Tables.Item.SubName;
  editConnectBuffer.Text := Cr.Tables.Item.ConnectBuffer;
  editPath.Text := Cr.Tables.Item.Path;
  editAliasName.Text := Cr.Tables.Item.AliasName;
  cbPropagate.Checked := Cr.Tables.Propagate;
  {Check for SQL}
  case Ord(Cr.Tables.Item.TableType) of
    0: editTableType.Text := 'ttUnknown';
    1: editTableType.Text := 'ttStandard';
    2: editTableType.Text := 'ttSQL';
  end;
  btnName.Enabled := (Cr.Tables.Item.TableType <> ttSQL);
  btnPath.Enabled := (Cr.Tables.Item.TableType <> ttSQL);
  editPath.Enabled := (Cr.Tables.Item.TableType <> ttSQL);
  editPath.Color := ColorState(editPath.Enabled);
  {Check Propagate}
  if Cr.Subreports.ItemIndex = 0 then
    OnOff := True
  else
    OnOff := (Cr.Subreports.ItemIndex > 0) and not (cbPropagate.Checked);
  editPath.Enabled := OnOff;
  editPath.Color := ColorState(OnOff);
  {Get Read-Only values}
  editDLLName.Text := Cr.Tables.Item.DLLName;
  editServerType.Text := Cr.Tables.Item.ServerType;
  {Enable events}
  cbPropagate.OnClick := cbPropagateClick;
end;
{------------------------------------------------------------------------------}
{ editNameChange procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.editNameChange(Sender: TObject);
begin
  Cr.Tables.Item.Name := editName.Text;
end;
{------------------------------------------------------------------------------}
{ editSubNameChange procedure                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.editSubNameChange(Sender: TObject);
begin
  Cr.Tables.Item.SubName := editSubName.Text;
end;
{------------------------------------------------------------------------------}
{ editConnectBufferChange procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.editConnectBufferChange(Sender: TObject);
begin
  Cr.Tables.Item.ConnectBuffer := editConnectBuffer.Text;
end;
{------------------------------------------------------------------------------}
{ editPathExit procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.editPathExit(Sender: TObject);
begin
  Cr.Tables.Item.Path := editPath.Text;
end;
{------------------------------------------------------------------------------}
{ editTablePasswordChange procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.editPasswordChange(Sender: TObject);
begin
  Cr.Tables.Item.Password := editPassword.Text;
end;
{------------------------------------------------------------------------------}
{ editAliasNameChange procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.editAliasNameChange(Sender: TObject);
begin
  Cr.Tables.Item.AliasName := editAliasName.Text;
end;
{------------------------------------------------------------------------------}
{ editServerTypeChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.editServerTypeChange(Sender: TObject);
begin
  Cr.Tables.Item.ServerType := editServerType.Text;
end;
{------------------------------------------------------------------------------}
{ cbPropagateClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.cbPropagateClick(Sender: TObject);
begin
  Cr.Tables.Propagate := cbPropagate.Checked;
  UpdateTables;
end;
{------------------------------------------------------------------------------}
{ btnSetNameClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnNameClick(Sender: TObject);
begin
  {Set the dialog default filename, filter and title}
  OpenDialog1.FileName := '*' + ExtractFileExt(editName.Text);
  OpenDialog1.Filter := 'Database Files (*' + UpperCase(OpenDialog1.FileName)
     + ')|*' + OpenDialog1.FileName + '|' + 'All files (*.*)|*.*';
  OpenDialog1.Title := 'Choose New Table...';
  OpenDialog1.InitialDir := editPath.Text;
  if OpenDialog1.Execute then
  begin
    Refresh;
    editName.Text := ExtractFileName(OpenDialog1.FileName);
    editPath.Text := ExtractFilePath(OpenDialog1.FileName);
  end;
end;
{------------------------------------------------------------------------------}
{ btnPathClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnPathClick(Sender: TObject);
begin
  CrpePathDlg := TCrpePathDlg.Create(Application);
  CrpePathDlg.Caption := 'Select Table Path...';
  CrpePathDlg.rPath := editPath.Text;
  CrpePathDlg.ShowModal;
  if CrpePathDlg.ModalResult = mrOk then
    editPath.Text := CrpePathDlg.rPath;
end;
{------------------------------------------------------------------------------}
{ btnCheckDifferencesClick procedure                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnCheckDifferencesClick(Sender: TObject);
var
  slNums,
  slStrings : TStringList;
  i         : integer;
begin
  slNums := TStringList.Create;
  slStrings := TStringList.Create;
  if not Cr.Tables.Item.CheckDifferences(slNums, slStrings) then
    MessageDlg('Check Failed.', mtError, [mbOk], 0)
  else
  begin
    for i := 0 to slNums.Count - 1 do
      MessageDlg(slNums[i] + ': ' + slStrings[i], mtInformation, [mbOk], 0);
  end;
  slNums.Free;
  slStrings.Free;
end;
{------------------------------------------------------------------------------}
{ btnTestClick procedure                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnTestClick(Sender: TObject);
begin
  if Cr.Tables.Item.Test then
    MessageDlg('Table is Good!' , mtInformation, [mbOk], 0)
  else
  begin
    MessageDlg('Table has a Problem.' + chr(10) +
      'Error Number: ' + IntToStr(Cr.LastErrorNumber) + chr(10) +
      Cr.LastErrorString, mtError, [mbOk], 0);
  end;
end;
{------------------------------------------------------------------------------}
{ cbFieldMappingChange procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.cbFieldMappingChange(Sender: TObject);
begin
  Cr.Tables.FieldMapping := TCrFieldMappingType(cbFieldMapping.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ cbVerifyFixClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.cbVerifyFixClick(Sender: TObject);
begin
  Cr.Tables.VerifyFix := cbVerifyFix.Checked;
end;
{------------------------------------------------------------------------------}
{ btnVerifyClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnVerifyClick(Sender: TObject);
begin
  if Cr.Tables.Verify then
    MessageDlg('The Database is up to date.', mtInformation, [mbOk], 0)
  else
    MessageDlg('An Error occured during Verify.', mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnConvertDriverClick procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnConvertDriverClick(Sender: TObject);
var
  s1 : string;
begin
  if InputQuery('Tables.ConvertDriver', 'Specify New Database DLL Name: ', s1) then
  begin
    Cr.Tables.ConvertDriver(s1);
    UpdateTables;
  end;
end;
{------------------------------------------------------------------------------}
{ btnFieldsClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnFieldsClick(Sender: TObject);
begin
  if not bTableFields then
  begin
    CrpeTableFieldsDlg := TCrpeTableFieldsDlg.Create(Application);
    CrpeTableFieldsDlg.Cr := Cr;
  end;
  CrpeTableFieldsDlg.Show;
end;
{------------------------------------------------------------------------------}
{ OpenFieldsDlg                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.OpenFieldsDlg;
begin
  btnFieldsClick(Self);
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnClearClick(Sender: TObject);
begin
  Cr.Tables.Clear;
  UpdateTables;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.btnOkClick(Sender: TObject);
begin
  if (not IsStrEmpty(Cr.ReportName)) and (TableIndex > -1) then
    editPathExit(editPath);
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeTablesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if bTableFields then
    CrpeTableFieldsDlg.Release;
  bTables := False;
  Release;
end;


end.
