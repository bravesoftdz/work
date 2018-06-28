unit UDSubreports;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeSubreportsDlg = class(TForm)
    pnlSubreports: TPanel;
    lbSubNames: TListBox;
    GroupBox1: TGroupBox;
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
    FontDialog1: TFontDialog;
    editNLinks: TEdit;
    lblNLinks: TLabel;
    cbSubExecute: TCheckBox;
    rbMain: TRadioButton;
    rbSub: TRadioButton;
    imgReport: TImage;
    OpenDialog1: TOpenDialog;
    sbFormulaRed: TSpeedButton;
    sbFormulaBlue: TSpeedButton;
    GroupBox2: TGroupBox;
    cbIsExternal: TCheckBox;
    cbOnDemand: TCheckBox;
    sbOnDemandCaption: TSpeedButton;
    lblOnDemandCaption: TLabel;
    lblPreviewTabCaption: TLabel;
    sbPreviewTabCaption: TSpeedButton;
    cbReImportWhenOpening: TCheckBox;
    rgUnits: TRadioGroup;
    procedure btnClearClick(Sender: TObject);
    procedure lbSubNamesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateSubreports;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure rbMainClick(Sender: TObject);
    procedure rbSubClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure btnFormatClick(Sender: TObject);
    procedure sbOnDemandCaptionClick(Sender: TObject);
    procedure sbPreviewTabCaptionClick(Sender: TObject);
    procedure cbSubExecuteClick(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr           : TCrpe;
    SubIndex     : integer;
    SubNameIndex : integer;
    PrevSize     : string;
    OpenDir      : string;
  end;

var
  CrpeSubreportsDlg: TCrpeSubreportsDlg;
  bSubreports      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDBorder, UDFormat, UDToolTipEdit;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.FormCreate(Sender: TObject);
begin
  bSubreports := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  OpenDir := 'C:\';
  SubIndex := 0;
  SubNameIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.FormShow(Sender: TObject);
begin
  UpdateSubreports;
end;
{------------------------------------------------------------------------------}
{ UpdateSubreports                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.UpdateSubreports;
var
  OnOff : boolean;
begin
  SubIndex := 0;
  SubNameIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.Subreports.Count >= 0);
    {Get Subreport Index}
    if OnOff then
    begin
      if Cr.Subreports.ItemIndex > -1 then
      begin
        SubIndex := Cr.Subreports.ItemIndex;
        if Cr.Subreports.ItemIndex > 0 then
          SubNameIndex := Cr.Subreports.ItemIndex - 1;
      end;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    rbSub.Enabled := Cr.Subreports.Count > 1;
    {Get Sections from Main Report}
    Cr.Subreports.ItemIndex := 0;
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Switch back to SubReport}
    Cr.Subreports.ItemIndex := SubIndex;
    lbSubNames.Clear;
    lbSubNames.Items.AddStrings(Cr.Subreports.Names);
    lbSubNames.ItemIndex := SubNameIndex;
    if SubIndex = 0 then
      rbMainClick(Self)
    else
      rbSubClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TRadioButton then
        TRadioButton(Components[i]).Enabled := OnOff;
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
{ rbMainClick                                                                  }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.rbMainClick(Sender: TObject);
begin
  rbMain.Checked := True;
  SubIndex := 0;
  {Set VCL to Main Report}
  Cr.Subreports[SubIndex];
  {Disable Subreports controls}
  rbSub.Checked := False;
  lbSubNames.Enabled := False;
  lbSubNames.Color := ColorState(False);
  cbSubExecute.Enabled := False;
  cbOnDemand.Checked := False;
  cbIsExternal.Checked := False;
  cbReImportWhenOpening.Checked := False;
  editNLinks.Text := '';
  sbOnDemandCaption.Enabled := False;
  sbPreviewTabCaption.Enabled := False;
  {Disable Object properties}
  rgUnits.Enabled := False;
  btnBorder.Enabled := False;
  btnFormat.Enabled := False;
  editTop.Text := '';
  editTop.Enabled := False;
  editTop.Color := ColorState(False);
  editLeft.Text := '';
  editLeft.Enabled := False;
  editLeft.Color := ColorState(False);
  editWidth.Text := '';
  editWidth.Enabled := False;
  editWidth.Color := ColorState(False);
  editHeight.Text := '';
  editHeight.Enabled := False;
  editHeight.Color := ColorState(False);
  cbSection.ItemIndex := -1;
  cbSection.Enabled := False;
  cbSection.Color := ColorState(False);
end;
{------------------------------------------------------------------------------}
{ rbSubClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.rbSubClick(Sender: TObject);
begin
  rbSub.Checked := True;
  rbMain.Checked := False;
  {Enable Subreport controls}
  lbSubNames.Enabled := True;
  lbSubNames.Color := ColorState(True);
  cbSubExecute.Enabled := True;
  cbSubExecute.Checked := Cr.Subreports.SubExecute;
  sbOnDemandCaption.Enabled := False;
  sbPreviewTabCaption.Enabled := False;
  {set the List Box to the first item}
  if SubNameIndex = -1 then SubNameIndex := 0;
  lbSubNames.SetFocus;
  lbSubNames.ItemIndex := SubNameIndex;
  lbSubNamesClick(Self);
end;
{------------------------------------------------------------------------------}
{ lbSubNamesClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.lbSubNamesClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  rbSub.Checked := True;
  SubIndex := lbSubNames.ItemIndex + 1;
  SubNameIndex := lbSubNames.ItemIndex;
  {Enable Sub properties}
  cbIsExternal.Checked := Cr.Subreports[SubIndex].IsExternal;
  cbOnDemand.Enabled := Cr.Subreports.Item.OnDemand;
  cbReImportWhenOpening.Checked := Cr.Subreports.Item.ReImportWhenOpening;
  editNLinks.Text := IntToStr(Cr.Subreports.Item.NLinks);
  {OnDemandCaption}
  sbOnDemandCaption.Enabled := True;
  if IsStrEmpty(Cr.Subreports.Item.OnDemandCaption) then
  begin
    if sbOnDemandCaption.Glyph <> sbFormulaBlue.Glyph then
      sbOnDemandCaption.Glyph := sbFormulaBlue.Glyph;
  end
  else
  begin
    if sbOnDemandCaption.Glyph <> sbFormulaRed.Glyph then
      sbOnDemandCaption.Glyph := sbFormulaRed.Glyph;
  end;
  {PreviewTabCaption}
  sbPreviewTabCaption.Enabled := True;
  if IsStrEmpty(Cr.Subreports.Item.PreviewTabCaption) then
  begin
    if sbPreviewTabCaption.Glyph <> sbFormulaBlue.Glyph then
      sbPreviewTabCaption.Glyph := sbFormulaBlue.Glyph;
  end
  else
  begin
    if sbPreviewTabCaption.Glyph <> sbFormulaRed.Glyph then
      sbPreviewTabCaption.Glyph := sbFormulaRed.Glyph;
  end;

  {Update Object properties}
  OnOff := (Cr.Subreports.Item.Handle <> 0);
  rgUnits.Enabled := OnOff;
  btnBorder.Enabled := OnOff;
  btnFormat.Enabled := OnOff;
  editTop.Enabled := OnOff;
  editTop.Color := ColorState(OnOff);
  editLeft.Enabled := OnOff;
  editLeft.Color := ColorState(OnOff);
  editWidth.Enabled := OnOff;
  editWidth.Color := ColorState(OnOff);
  editHeight.Enabled := OnOff;
  editHeight.Color := ColorState(OnOff);
  cbSection.Enabled := OnOff;
  cbSection.Color := ColorState(OnOff);
  if OnOff then
    cbSection.ItemIndex := cbSection.Items.IndexOf(Cr.Subreports.Item.Section);
  rgUnitsClick(Self);
  lbSubNames.SetFocus;
end;
{------------------------------------------------------------------------------}
{ sbOnDemandCaptionClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.sbOnDemandCaptionClick(Sender: TObject);
var
  s : string;
begin
  CrpeToolTipEditDlg := TCrpeToolTipEditDlg.Create(Application);
  s := Cr.Subreports.Item.OnDemandCaption;
  {Display the edit dialog}
  CrpeToolTipEditDlg.pTip := Addr(s);
  CrpeToolTipEditDlg.Caption := 'OnDemandCaption';
  CrpeToolTipEditDlg.ShowModal;
  Cr.Subreports.Item.OnDemandCaption := s;

  if IsStrEmpty(s) then
  begin
    if sbOnDemandCaption.Glyph <> sbFormulaBlue.Glyph then
      sbOnDemandCaption.Glyph := sbFormulaBlue.Glyph;
  end
  else
  begin
    if sbOnDemandCaption.Glyph <> sbFormulaRed.Glyph then
      sbOnDemandCaption.Glyph := sbFormulaRed.Glyph;
  end;
end;
{------------------------------------------------------------------------------}
{ sbPreviewTabCaptionClick                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.sbPreviewTabCaptionClick(Sender: TObject);
var
  s : string;
begin
  CrpeToolTipEditDlg := TCrpeToolTipEditDlg.Create(Application);
  s := Cr.Subreports.Item.PreviewTabCaption;
  {Display the edit dialog}
  CrpeToolTipEditDlg.pTip := Addr(s);
  CrpeToolTipEditDlg.Caption := 'PreviewTabCaption';
  CrpeToolTipEditDlg.ShowModal;
  Cr.Subreports.Item.PreviewTabCaption := s;

  if IsStrEmpty(s) then
  begin
    if sbPreviewTabCaption.Glyph <> sbFormulaBlue.Glyph then
      sbPreviewTabCaption.Glyph := sbFormulaBlue.Glyph;
  end
  else
  begin
    if sbPreviewTabCaption.Glyph <> sbFormulaRed.Glyph then
      sbPreviewTabCaption.Glyph := sbFormulaRed.Glyph;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSubExecuteClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.cbSubExecuteClick(Sender: TObject);
begin
  Cr.Subreports.SubExecute := cbSubExecute.Checked;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Subreports.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Subreports.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Subreports.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Subreports.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateSubreports; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.Subreports.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.Subreports.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.Subreports.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.Subreports.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.Subreports.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.Subreports[SubIndex].Top);
    editLeft.Text := TwipsToInchesStr(Cr.Subreports[SubIndex].Left);
    editWidth.Text := TwipsToInchesStr(Cr.Subreports[SubIndex].Width);
    editHeight.Text := TwipsToInchesStr(Cr.Subreports[SubIndex].Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.Subreports[SubIndex].Top);
    editLeft.Text := IntToStr(Cr.Subreports[SubIndex].Left);
    editWidth.Text := IntToStr(Cr.Subreports[SubIndex].Width);
    editHeight.Text := IntToStr(Cr.Subreports[SubIndex].Height);
  end;
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.Subreports.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.Subreports.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.btnClearClick(Sender: TObject);
begin
  Cr.Subreports.Clear;
  UpdateSubreports;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSubreportsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the Update call}
  if (not IsStrEmpty(Cr.ReportName)) and (SubNameIndex > -1) then
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
procedure TCrpeSubreportsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSubreports := False;
  Release;
end;


end.
