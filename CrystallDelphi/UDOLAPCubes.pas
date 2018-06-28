unit UDOLAPCubes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeOLAPCubesDlg = class(TForm)
    pnlOLAPCubes: TPanel;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    lblCount: TLabel;
    gbFormat: TGroupBox;
    btnBorder: TButton;
    btnFormat: TButton;
    editTop: TEdit;
    lblTop: TLabel;
    lblLeft: TLabel;
    editLeft: TEdit;
    lblSection: TLabel;
    editWidth: TEdit;
    lblWidth: TLabel;
    lblHeight: TLabel;
    editHeight: TEdit;
    cbSection: TComboBox;
    btnOk: TButton;
    btnClear: TButton;
    rgUnits: TRadioGroup;
    btnTest: TButton;
    lblServerName: TLabel;
    lblDatabaseName: TLabel;
    lblUserID: TLabel;
    lblPassword: TLabel;
    editServerName: TEdit;
    editDatabaseName: TEdit;
    editUserID: TEdit;
    editPassword: TEdit;
    lblCubeName: TLabel;
    editCubeName: TEdit;
    lblConnectionString: TLabel;
    editConnectionString: TEdit;
    procedure btnClearClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateOLAPCubes;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure rgUnitsClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure editServerNameChange(Sender: TObject);
    procedure editDatabaseNameChange(Sender: TObject);
    procedure editCubeNameChange(Sender: TObject);
    procedure editUserIDChange(Sender: TObject);
    procedure editPasswordChange(Sender: TObject);
    procedure editConnectionStringChange(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    OlapIndex  : smallint;
    PrevSize : string;
  end;

var
  CrpeOLAPCubesDlg: TCrpeOLAPCubesDlg;
  bOLAPCubes      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDBorder, UDFormat;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.FormCreate(Sender: TObject);
begin
  bOLAPCubes := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  OlapIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.FormShow(Sender: TObject);
begin
  UpdateOLAPCubes;
end;
{------------------------------------------------------------------------------}
{ UpdateOLAPCubes                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.UpdateOLAPCubes;
var
  OnOff : boolean;
  i     : integer;
begin
  OlapIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.OLAPCubes.Count > 0);
    {Get OLAPCubes Index}
    if OnOff then
    begin
      if Cr.OLAPCubes.ItemIndex > -1 then
        OlapIndex := Cr.OLAPCubes.ItemIndex
      else
        OlapIndex := 0;
    end
    else
      OlapIndex := -1;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Section ComboBox}
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.OLAPCubes.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.OLAPCubes.Count);
    lbNumbers.ItemIndex := OlapIndex;
    lbNumbersClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.InitializeControls(OnOff: boolean);
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
        TEdit(Components[i]).Text := '';
        if TEdit(Components[i]).ReadOnly = False then
          TEdit(Components[i]).Color := ColorState(OnOff);
        TEdit(Components[i]).Enabled := OnOff;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNumbersClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.lbNumbersClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  OlapIndex := lbNumbers.ItemIndex;
  OnOff := (Cr.OLAPCubes[OlapIndex].Handle <> 0);
  btnBorder.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  editServerName.Text := Cr.OLAPCubes.Item.ServerName;
  editDatabaseName.Text := Cr.OLAPCubes.Item.DatabaseName;
  editUserID.Text := Cr.OLAPCubes.Item.UserID;
  editPassword.Text := Cr.OLAPCubes.Item.Password;
  editCubeName.Text := Cr.OLAPCubes.Item.CubeName;
  editConnectionString.Text := Cr.OLAPCubes.Item.ConnectionString;
  cbSection.ItemIndex := cbSection.Items.IndexOf(Cr.OLAPCubes.Item.Section);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ editServerNameChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.editServerNameChange(Sender: TObject);
begin
  Cr.OLAPCubes.Item.ServerName := editServerName.Text;
end;
{------------------------------------------------------------------------------}
{ editDatabaseNameChange                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.editDatabaseNameChange(Sender: TObject);
begin
  Cr.OLAPCubes.Item.DatabaseName := editDatabaseName.Text;
end;
{------------------------------------------------------------------------------}
{ editCubeNameChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.editCubeNameChange(Sender: TObject);
begin
  Cr.OLAPCubes.Item.CubeName := editCubeName.Text;
end;
{------------------------------------------------------------------------------}
{ editUserIDChange                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.editUserIDChange(Sender: TObject);
begin
  Cr.OLAPCubes.Item.UserID := editUserID.Text;
end;
{------------------------------------------------------------------------------}
{ editPasswordChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.editPasswordChange(Sender: TObject);
begin
  Cr.OLAPCubes.Item.Password := editPassword.Text;
end;
{------------------------------------------------------------------------------}
{ editConnectionStringChange                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.editConnectionStringChange(Sender: TObject);
begin
  Cr.OLAPCubes.Item.ConnectionString := editConnectionString.Text;
end;
{------------------------------------------------------------------------------}
{ btnTestClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.btnTestClick(Sender: TObject);
begin
  if Cr.OLAPCubes.Item.Test then
    MessageDlg('Connection Succeeded!', mtInformation, [mbOk], 0)
  else
    MessageDlg('Connection Failed.' + Chr(10) + Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.OLAPCubes.Item.Top);
    editWidth.Text := TwipsToInchesStr(Cr.OLAPCubes.Item.Width);
    editLeft.Text := TwipsToInchesStr(Cr.OLAPCubes.Item.Left);
    editHeight.Text := TwipsToInchesStr(Cr.OLAPCubes.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.OLAPCubes.Item.Top);
    editWidth.Text := IntToStr(Cr.OLAPCubes.Item.Width);
    editLeft.Text := IntToStr(Cr.OLAPCubes.Item.Left);
    editHeight.Text := IntToStr(Cr.OLAPCubes.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.OLAPCubes.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.OLAPCubes.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.OLAPCubes.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.OLAPCubes.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateOLAPCubes; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.OLAPCubes.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.OLAPCubes.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.OLAPCubes.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.OLAPCubes.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.cbSectionChange(Sender: TObject);
begin
  Cr.OLAPCubes.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.OLAPCubes.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.OLAPCubes.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.btnClearClick(Sender: TObject);
begin
  Cr.OLAPCubes.Clear;
  UpdateOLAPCubes;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateOLAPCubes call}
  if (not IsStrEmpty(Cr.ReportName)) and (OlapIndex > -1) then 
  begin
    editSizeExit(editTop);
    editSizeExit(editWidth);
    editSizeExit(editLeft);
    editSizeExit(editHeight);
  end;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeOLAPCubesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bOLAPCubes := False;
  Release;
end;


end.
