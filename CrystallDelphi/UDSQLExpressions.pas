unit UDSQLExpressions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32;

type
  TCrpeSQLExpressionsDlg = class(TForm)
    pnlExpressions: TPanel;
    lblExpression: TLabel;
    lblExpressionName: TLabel;
    lbNames: TListBox;
    memoExpression: TMemo;
    btnCheck: TButton;
    btnCheckAll: TButton;
    btnOk: TButton;
    btnClear: TButton;
    lblCount: TLabel;
    editCount: TEdit;
    gbFormat: TGroupBox;
    lblFieldName: TLabel;
    lblFieldType: TLabel;
    lblFieldLength: TLabel;
    lblTop: TLabel;
    lblLeft: TLabel;
    lblSection: TLabel;
    lblWidth: TLabel;
    lblHeight: TLabel;
    editFieldName: TEdit;
    editFieldType: TEdit;
    editFieldLength: TEdit;
    btnBorder: TButton;
    btnFont: TButton;
    btnFormat: TButton;
    editTop: TEdit;
    editLeft: TEdit;
    editWidth: TEdit;
    editHeight: TEdit;
    cbSection: TComboBox;
    rgUnits: TRadioGroup;
    FontDialog1: TFontDialog;
    btnHiliteConditions: TButton;
    cbObjectPropertiesActive: TCheckBox;
    procedure lbNamesClick(Sender: TObject);
    procedure memoExpressionChange(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateSQLExpressions;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure btnHiliteConditionsClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure InitializeFormatControls(OnOff: boolean);
    procedure cbObjectPropertiesActiveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    ExIndex  : smallint;
    PrevSize : string;
  end;

var
  CrpeSQLExpressionsDlg: TCrpeSQLExpressionsDlg;
  bSQLExpressions      : boolean;

implementation

{$R *.DFM}

uses TypInfo, UCrpeUtl, UDBorder, UDFormat, UDHiliteConditions,
  UDFont, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.FormCreate(Sender: TObject);
begin
  bSQLExpressions := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  ExIndex := -1;
  cbObjectPropertiesActive.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.FormShow(Sender: TObject);
begin
  UpdateSQLExpressions;
end;
{------------------------------------------------------------------------------}
{ UpdateSQLExpressions                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.UpdateSQLExpressions;
var
  OnOff : boolean;
  i     : integer;
begin
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
  begin
    OnOff := False;
    ExIndex := -1;
  end
  else
  begin
    OnOff := (Cr.SQLExpressions.Count > 0);
    {Get SQLExpressions Index}
    if OnOff then
    begin
      if Cr.SQLExpressions.ItemIndex > -1 then
        ExIndex := Cr.SQLExpressions.ItemIndex
      else
        ExIndex := 0;
    end;
  end;
  cbObjectPropertiesActive.Checked := Cr.SQLExpressions.ObjectPropertiesActive;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    for i := 0 to (Cr.SQLExpressions.Count - 1) do
      lbNames.Items.Add(Cr.SQLExpressions[i].Name);
    editCount.Text := IntToStr(Cr.SQLExpressions.Count);
    lbNames.ItemIndex := ExIndex;
    lbNamesClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.InitializeControls(OnOff: boolean);
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
{ InitializeFormatControls                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.InitializeFormatControls(OnOff: boolean);
var
  i : integer;
begin
  {Enable/Disable the Form Controls}
  for i := 0 to ComponentCount - 1 do
  begin
    {Check Tag}
    if TComponent(Components[i]).Tag <> 0 then
      Continue;
    {Make sure these components are owned by the Format groupbox}
    if Components[i] is TButton then
    begin
      if TButton(Components[i]).Parent <> gbFormat then Continue;
      TButton(Components[i]).Enabled := OnOff;
    end;
    if Components[i] is TRadioGroup then
    begin
      if TRadioGroup(Components[i]).Parent <> gbFormat then Continue;
      TRadioGroup(Components[i]).Enabled := OnOff;
    end;
    if Components[i] is TComboBox then
    begin
      if TComboBox(Components[i]).Parent <> gbFormat then Continue;
      TComboBox(Components[i]).Color := ColorState(OnOff);
      TComboBox(Components[i]).Enabled := OnOff;
    end;
    if Components[i] is TEdit then
    begin
      if TEdit(Components[i]).Parent <> gbFormat then Continue;
      TEdit(Components[i]).Text := '';
      if TEdit(Components[i]).ReadOnly = False then
        TEdit(Components[i]).Color := ColorState(OnOff);
      TEdit(Components[i]).Enabled := OnOff;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbNamesClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.lbNamesClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  ExIndex := lbNames.ItemIndex;
  memoExpression.OnChange := nil;
  memoExpression.Lines.Assign(Cr.SQLExpressions[ExIndex].Expression);
  memoExpression.OnChange := memoExpressionChange;

  {Activate Format options}
  OnOff := (Cr.SQLExpressions.Item.Handle <> 0);
  InitializeFormatControls(OnOff);
  if OnOff then
  begin
    {Field Info}
    editFieldName.Text := Cr.SQLExpressions.Item.FieldName;
    editFieldType.Text := GetEnumName(TypeInfo(TCrFieldValueType),
      Ord(Cr.SQLExpressions.Item.FieldType));
    editFieldLength.Text := IntToStr(Cr.SQLExpressions.Item.FieldLength);
    {Size and Position}
    cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.SQLExpressions.Item.Section);
    rgUnitsClick(Self);
  end;
  {Set HiliteConditions button}
  btnHiliteConditions.Enabled := (Cr.SQLExpressions.Item.FieldType in [fvInt8s..fvCurrency])
    and OnOff;
end;
{------------------------------------------------------------------------------}
{ memoExpressionChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.memoExpressionChange(Sender: TObject);
begin
  Cr.SQLExpressions.Item.Expression.Assign(memoExpression.Lines);
end;
{------------------------------------------------------------------------------}
{ btnCheckClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.btnCheckClick(Sender: TObject);
begin
  if Cr.SQLExpressions.Item.Check then
    MessageDlg('SQLExpression is Good!', mtInformation, [mbOk], 0)
  else
    MessageDlg('SQLExpression has an Error.' + Chr(10) +
      Cr.LastErrorString, mtError, [mbOk], 0);
end;
{------------------------------------------------------------------------------}
{ btnCheckAllClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.btnCheckAllClick(Sender: TObject);
var
  i : integer;
  s : string;
begin
  Screen.Cursor := crHourglass;
  lbNames.ItemIndex := 0;
  for i := 0 to (lbNames.Items.Count - 1) do
  begin
    lbNames.ItemIndex:= i;
    Cr.SQLExpressions[lbNames.ItemIndex];
    memoExpression.OnChange := nil;
    memoExpression.Lines.Assign(Cr.SQLExpressions.Item.Expression);
    memoExpression.OnChange := memoExpressionChange;
    Cr.SQLExpressions.Item.Expression.Assign(memoExpression.Lines);
    if not Cr.SQLExpressions.Item.Check then
    begin
      MessageBeep(0);
      s := 'The SQLExpression "' + Cr.SQLExpressions[i].Name + '" has an error!' +
        Chr(10) + 'Continue checking?';
      if Application.MessageBox(PChar(s), 'Formula Error', MB_OKCANCEL + MB_DEFBUTTON1) = IDOK then
        Continue
      else
        Break;
    end;
  end;
  if i = (lbNames.Items.Count) then
  begin
    MessageBeep(0);
    MessageDlg('Finished verifying formulas!', mtInformation, [mbOk], 0)
  end;
  Screen.Cursor := crDefault;
end;
{------------------------------------------------------------------------------}
{ cbObjectPropertiesActiveClick                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.cbObjectPropertiesActiveClick(Sender: TObject);
begin
  Cr.SQLExpressions.ObjectPropertiesActive := cbObjectPropertiesActive.Checked;
  UpdateSQLExpressions;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.SQLExpressions.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.SQLExpressions.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.SQLExpressions.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.SQLExpressions.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.SQLExpressions.Item.Top);
    editLeft.Text := IntToStr(Cr.SQLExpressions.Item.Left);
    editWidth.Text := IntToStr(Cr.SQLExpressions.Item.Width);
    editHeight.Text := IntToStr(Cr.SQLExpressions.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.SQLExpressions.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.SQLExpressions.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.SQLExpressions.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.SQLExpressions.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateSQLExpressions; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.SQLExpressions.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.SQLExpressions.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.SQLExpressions.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.SQLExpressions.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.SQLExpressions.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.SQLExpressions.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.SQLExpressions.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.SQLExpressions.Item.Font);
    if FontDialog1.Execute then
      Cr.SQLExpressions.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.SQLExpressions.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnHiliteConditionsClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.btnHiliteConditionsClick(Sender: TObject);
begin
  CrpeHiliteConditionsDlg := TCrpeHiliteConditionsDlg.Create(Application);
  CrpeHiliteConditionsDlg.Crh := Cr.SQLExpressions.Item.HiliteConditions;
  CrpeHiliteConditionsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.btnClearClick(Sender: TObject);
begin
  Cr.SQLExpressions.Clear;
  UpdateSQLExpressions;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the Update call}
  if (not IsStrEmpty(Cr.ReportName)) and (ExIndex > -1) then 
  begin
    editSizeExit(editTop);
    editSizeExit(editLeft);
    editSizeExit(editWidth);
    editSizeExit(editHeight);
  end;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSQLExpressionsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSQLExpressions := False;
  Release;
end;


end.
