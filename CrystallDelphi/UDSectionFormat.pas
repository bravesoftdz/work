unit UDSectionFormat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, UCrpe32;

type
  TCrpeSectionFormatDlg = class(TForm)
    pnlSectionFormat: TPanel;
    lblSection: TLabel;
    cbPrintAtBottomOfPage: TCheckBox;
    cbNewPageBefore: TCheckBox;
    cbNewPageAfter: TCheckBox;
    cbResetPageNAfter: TCheckBox;
    cbKeepTogether: TCheckBox;
    cbSuppressBlankSection: TCheckBox;
    cbUnderlaySection: TCheckBox;
    cbSuppress: TCheckBox;
    cbFreeFormPlacement: TCheckBox;
    lbSections: TListBox;
    btnOk: TButton;
    sbSuppress: TSpeedButton;
    sbPrintAtBottomOfPage: TSpeedButton;
    sbNewPageBefore: TSpeedButton;
    sbNewPageAfter: TSpeedButton;
    sbResetPageNAfter: TSpeedButton;
    sbKeepTogether: TSpeedButton;
    sbSuppressBlankSection: TSpeedButton;
    sbUnderlaySection: TSpeedButton;
    sbFormulaRed: TSpeedButton;
    sbFormulaBlue: TSpeedButton;
    lblCount: TLabel;
    editCount: TEdit;
    gbBackgroundColor: TGroupBox;
    lblRed: TLabel;
    lblGreen: TLabel;
    lblBlue: TLabel;
    editRed: TEdit;
    editGreen: TEdit;
    editBlue: TEdit;
    cbBackgroundColor: TCheckBox;
    sbBackgroundColor: TSpeedButton;
    colorboxBackgroundColor: TColorBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lbSectionsClick(Sender: TObject);
    procedure cbCommonClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateSectionFormat;
    procedure sbFormulaButtonClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure colorboxBackgroundColorChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    SFIndex : smallint;
  end;

var
  CrpeSectionFormatDlg: TCrpeSectionFormatDlg;
  bSectionFormat      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDFormulaEdit;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.FormCreate(Sender: TObject);
begin
  bSectionFormat := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  SFIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.FormShow(Sender: TObject);
begin
  UpdateSectionFormat;
end;
{------------------------------------------------------------------------------}
{ UpdateSectionFormat                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.UpdateSectionFormat;
var
  OnOff : boolean;
begin
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
  begin
    OnOff := False;
    SFIndex := -1;
  end
  else
  begin
    OnOff := (Cr.SectionFormat.Count > 0);
    {Get SectionFormat Index}
    if OnOff then
    begin
      if Cr.SectionFormat.ItemIndex > -1 then
        SFIndex := Cr.SectionFormat.ItemIndex
      else
        SFIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  if OnOff then
  begin
    lbSections.Clear;
    lbSections.Items.AddStrings(Cr.SectionFormat.Names);
    editCount.Text := IntToStr(Cr.SectionFormat.Count);
    lbSections.ItemIndex := SFIndex;
    lbSectionsClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.InitializeControls(OnOff: boolean);
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
      if Components[i] is TSpeedButton then
        TSpeedButton(Components[i]).Enabled := OnOff;
      if Components[i] is TCheckBox then
        TCheckBox(Components[i]).Enabled := OnOff;
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
{ lbSectionsClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.lbSectionsClick(Sender: TObject);
var
  i    : integer;
  sTmp : string;
  s1   : string;
  s2   : string;
begin
  SFIndex := lbSections.ItemIndex;
  {Disable events}
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TCheckBox then
      TCheckBox(Components[i]).OnClick := nil;
  end;

  {Set the CheckBoxes from the VCL settings}
  cbFreeFormPlacement.Checked := Cr.SectionFormat[SFIndex].FreeFormPlacement;
  cbSuppress.Checked := Cr.SectionFormat.Item.Suppress;
  cbPrintAtBottomOfPage.Checked := Cr.SectionFormat.Item.PrintAtBottomOfPage;
  cbNewPageBefore.Checked := Cr.SectionFormat.Item.NewPageBefore;
  cbNewPageAfter.Checked := Cr.SectionFormat.Item.NewPageAfter;
  cbResetPageNAfter.Checked := Cr.SectionFormat.Item.ResetPageNAfter;
  cbKeepTogether.Checked := Cr.SectionFormat.Item.KeepTogether;
  cbSuppressBlankSection.Checked := Cr.SectionFormat.Item.SuppressBlankSection;
  cbUnderlaySection.Checked := Cr.SectionFormat.Item.UnderlaySection;

  {Disable inapplicable items for the section}
  {Subreport RHb/RFb have same limitations as PH on main report}
  if (Cr.Subreports.ItemIndex > 0) then
  begin
    if (CompareText(UpperCase(Cr.SectionFormat.Item.Section),'RHB') = 0) or
       (CompareText(UpperCase(Cr.SectionFormat.Item.Section),'RFB') = 0) then
     sTmp := 'PH'
  end
  else
    sTmp := Cr.SectionFormat.Item.SectionType;
  {if the Section is Page Header or Page Footer, or RHb on Subreport...}
  if (sTmp = 'PH') or (sTmp = 'PF') then
  begin
    {Disable: PrintAtBottomOfPage, NewPageAfter,
     NewPageBefore, KeepTogether}
    cbPrintAtBottomOfPage.Enabled := False;
    cbNewPageAfter.Enabled := False;
    cbNewPageBefore.Enabled := False;
    cbKeepTogether.Enabled := False;
  end
  else
  begin
    {enable the 4 options as required}
    {PrintAtBottomOfPage}
    if cbPrintAtBottomOfPage.Enabled = False then
      cbPrintAtBottomOfPage.Enabled := True;
    {NewPageAfter}
    if cbNewPageAfter.Enabled = False then
      cbNewPageAfter.Enabled := True;
    {NewPageBefore}
    if cbNewPageBefore.Enabled = False then
      cbNewPageBefore.Enabled := True;
    {KeepTogether}
    if cbKeepTogether.Enabled = False then
      cbKeepTogether.Enabled := True;
  end;

  {Update the BackgroundColor on the Form}
  if Cr.SectionFormat.Item.BackgroundColor = clNone then
  begin
    cbBackgroundColor.Checked := False;
    editRed.Text := '';
    editGreen.Text := '';
    editBlue.Text := '';
    colorboxBackgroundColor.Selected := Cr.SectionFormat.Item.BackgroundColor;
    colorboxBackgroundColor.Enabled := False;
  end
  else
  begin
    cbBackgroundColor.OnClick := nil;
    cbBackgroundColor.Checked := True;
    cbBackgroundColor.OnClick := cbCommonClick;
    colorboxBackgroundColor.Selected := Cr.SectionFormat.Item.BackgroundColor;
    {List the Background color RGB values for the Section}
    editRed.Text := IntToStr(Round(GetRValue(Cr.SectionFormat.Item.BackgroundColor)));
    editGreen.Text := IntToStr(Round(GetGValue(Cr.SectionFormat.Item.BackgroundColor)));
    editBlue.Text := IntToStr(Round(GetBValue(Cr.SectionFormat.Item.BackgroundColor)));
  end;

  if cbBackgroundColor.Checked then
    colorboxBackgroundColor.Enabled := True;

  {Determine the section area: Subreports RHb,RFb are same as PH/PF}
  if Cr.Subreports.ItemIndex > 0 then
  begin
    if UpperCase(Cr.SectionFormat.Item.Section) = 'RHB' then
      s1 := 'PH';
    if UpperCase(Cr.SectionFormat.Item.Section) = 'RFB' then
      s1 := 'PF';
  end
  else
    s1 := UpperCase(Cr.SectionFormat.Item.SectionType);

  {Set Formula Button glyphs: check first 4 for PH/PF}
  {NewPageBefore}
  if Pos(s1, 'PHPF') = 0 then
  begin
    if not sbNewPageBefore.Enabled then
      sbNewPageBefore.Enabled := True;
    {If the formula has text...}
    s2 := RTrimList(Cr.SectionFormat.Item.Formulas.NewPageBefore);
    if Length(s2) > 0 then
    begin
      if sbNewPageBefore.Tag <> 1 then
      begin
        sbNewPageBefore.Glyph := sbFormulaRed.Glyph;
        sbNewPageBefore.Tag := 1;
      end;
    end
    else
    begin
      if sbNewPageBefore.Tag <> 0 then
      begin
        sbNewPageBefore.Glyph := sbFormulaBlue.Glyph;
        sbNewPageBefore.Tag := 0;
      end;
    end;
  end
  else
  begin
    if sbNewPageBefore.Enabled then
      sbNewPageBefore.Enabled := False;
  end;
  {NewPageAfter}
  if Pos(s1, 'PHPF') = 0 then
  begin
    if not sbNewPageAfter.Enabled then
      sbNewPageAfter.Enabled := True;
    s2 := RTrimList(Cr.SectionFormat.Item.Formulas.NewPageAfter);
    if Length(s2) > 0 then
    begin
      if sbNewPageAfter.Tag <> 1 then
      begin
        sbNewPageAfter.Glyph := sbFormulaRed.Glyph;
        sbNewPageAfter.Tag := 1;
      end;
    end
    else
    begin
      if sbNewPageAfter.Tag <> 0 then
      begin
        sbNewPageAfter.Glyph := sbFormulaBlue.Glyph;
        sbNewPageAfter.Tag := 0;
      end;
    end;
  end
  else
  begin
    if sbNewPageAfter.Enabled then
      sbNewPageAfter.Enabled := False;
  end;
  {KeepTogether}
  if Pos(s1, 'PHPF') = 0 then
  begin
    if not sbKeepTogether.Enabled then
      sbKeepTogether.Enabled := True;
    s2 := RTrimList(Cr.SectionFormat.Item.Formulas.KeepTogether);
    if Length(s2) > 0 then
    begin
      if sbKeepTogether.Tag <> 1 then
      begin
        sbKeepTogether.Glyph := sbFormulaRed.Glyph;
        sbKeepTogether.Tag := 1;
      end;
    end
    else
    begin
      if sbKeepTogether.Tag <> 0 then
      begin
        sbKeepTogether.Glyph := sbFormulaBlue.Glyph;
        sbKeepTogether.Tag := 0;
      end;
    end;
  end
  else
  begin
    if sbKeepTogether.Enabled then
      sbKeepTogether.Enabled := False;
  end;
  {PrintAtBottomOfPage}
  if Pos(s1, 'PHPF') = 0 then
  begin
    if not sbPrintAtBottomOfPage.Enabled then
      sbPrintAtBottomOfPage.Enabled := True;
    s2 := RTrimList(Cr.SectionFormat.Item.Formulas.PrintAtBottomOfPage);
    if Length(s2) > 0 then
    begin
      if sbPrintAtBottomOfPage.Tag <> 1 then
      begin
        sbPrintAtBottomOfPage.Glyph := sbFormulaRed.Glyph;
        sbPrintAtBottomOfPage.Tag := 1;
      end;
    end
    else
    begin
      if sbPrintAtBottomOfPage.Tag <> 0 then
      begin
        sbPrintAtBottomOfPage.Glyph := sbFormulaBlue.Glyph;
        sbPrintAtBottomOfPage.Tag := 0;
      end;
    end;
  end
  else
  begin
    if sbPrintAtBottomOfPage.Enabled then
      sbPrintAtBottomOfPage.Enabled := False;
  end;

  {Suppress}
  s2 := RTrimList(Cr.SectionFormat.Item.Formulas.Suppress);
  if Length(s2) > 0 then
  begin
    if sbSuppress.Tag <> 1 then
    begin
      sbSuppress.Glyph := sbFormulaRed.Glyph;
      sbSuppress.Tag := 1;
    end;
  end
  else
  begin
    if sbSuppress.Tag <> 0 then
    begin
      sbSuppress.Glyph := sbFormulaBlue.Glyph;
      sbSuppress.Tag := 0;
    end;
  end;
  {SuppressBlankSection}
  s2 := RTrimList(Cr.SectionFormat.Item.Formulas.SuppressBlankSection);
  if Length(s2) > 0 then
  begin
    if sbSuppressBlankSection.Tag <> 1 then
    begin
      sbSuppressBlankSection.Glyph := sbFormulaRed.Glyph;
      sbSuppressBlankSection.Tag := 1;
    end;
  end
  else
  begin
    if sbSuppressBlankSection.Tag <> 0 then
    begin
      sbSuppressBlankSection.Glyph := sbFormulaBlue.Glyph;
      sbSuppressBlankSection.Tag := 0;
    end;
  end;
  {ResetPageNAfter}
  s2 := RTrimList(Cr.SectionFormat.Item.Formulas.ResetPageNAfter);
  if Length(s2) > 0 then
  begin
    if sbResetPageNAfter.Tag <> 1 then
    begin
      sbResetPageNAfter.Glyph := sbFormulaRed.Glyph;
      sbResetPageNAfter.Tag := 1;
    end;
  end
  else
  begin
    if sbResetPageNAfter.Tag <> 0 then
    begin
      sbResetPageNAfter.Glyph := sbFormulaBlue.Glyph;
      sbResetPageNAfter.Tag := 0;
    end;
  end;
  {UnderlaySection}
  s2 := RTrimList(Cr.SectionFormat.Item.Formulas.UnderlaySection);
  if Length(s2) > 0 then
  begin
    if sbUnderlaySection.Tag <> 1 then
    begin
      sbUnderlaySection.Glyph := sbFormulaRed.Glyph;
      sbUnderlaySection.Tag := 1;
    end;
  end
  else
  begin
    if sbUnderlaySection.Tag <> 0 then
    begin
      sbUnderlaySection.Glyph := sbFormulaBlue.Glyph;
      sbUnderlaySection.Tag := 0;
    end;
  end;
  {BackgroundColor}
  s2 := RTrimList(Cr.SectionFormat.Item.Formulas.BackgroundColor);
  if Length(s2) > 0 then
  begin
    if sbBackgroundColor.Tag <> 1 then
    begin
      sbBackgroundColor.Glyph := sbFormulaRed.Glyph;
      sbBackgroundColor.Tag := 1;
    end;
  end
  else
  begin
    if sbBackgroundColor.Tag <> 0 then
    begin
      sbBackgroundColor.Glyph := sbFormulaBlue.Glyph;
      sbBackgroundColor.Tag := 0;
    end;
  end;

  {Enable events}
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TCheckBox then
      TCheckBox(Components[i]).OnClick := cbCommonClick;
  end;
end;
{------------------------------------------------------------------------------}
{ cbCommonClick procedure                                                      }
{   - OnClick event for the SectionFormat checkboxes                           }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.cbCommonClick(Sender: TObject);
var
  i  : integer;
begin
  if not (Sender is TCheckBox) then Exit;
  i := Cr.SectionFormat.ItemIndex;
  {Update the VCL}
  if TCheckBox(Sender).Name = 'cbFreeFormPlacement' then
    Cr.SectionFormat[i].FreeFormPlacement := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbSuppress' then
    Cr.SectionFormat[i].Suppress := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbPrintAtBottomOfPage' then
    Cr.SectionFormat[i].PrintAtBottomOfPage := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbNewPageBefore' then
    Cr.SectionFormat[i].NewPageBefore := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbNewPageAfter' then
    Cr.SectionFormat[i].NewPageAfter := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbResetPageNAfter' then
    Cr.SectionFormat[i].ResetPageNAfter := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbKeepTogether' then
    Cr.SectionFormat[i].KeepTogether := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbSuppressBlankSection' then
    Cr.SectionFormat[i].SuppressBlankSection := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbUnderlaySection' then
    Cr.SectionFormat[i].UnderlaySection := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbBackgroundColor' then
  begin
//    if TCheckBox(Sender).Checked then
//      Cr.SectionFormat[i].BackgroundColor := clWhite
//    else
//      Cr.SectionFormat[i].BackgroundColor := clNone;

    if TCheckBox(Sender).State <> cbChecked then
    begin
      editRed.Text := '';
      editGreen.Text := '';
      editBlue.Text := '';
      colorboxBackgroundColor.Enabled := False;
    end
    else
    begin
      {List the Background color RGB values for the Section}
      editRed.Text := IntToStr(Round(GetRValue(Cr.SectionFormat[i].BackgroundColor)));
      editGreen.Text := IntToStr(Round(GetGValue(Cr.SectionFormat[i].BackgroundColor)));
      editBlue.Text := IntToStr(Round(GetBValue(Cr.SectionFormat[i].BackgroundColor)));
      colorboxBackgroundColor.Enabled := True;
      colorboxBackgroundColor.Selected := Cr.SectionFormat[i].BackgroundColor;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ colorboxBackgroundColorChange procedure                                      }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.colorboxBackgroundColorChange(
  Sender: TObject);
begin
  Cr.SectionFormat.Item.BackgroundColor := colorboxBackgroundColor.Selected;
  editRed.Text := IntToStr(Round(GetRValue(colorboxBackgroundColor.Selected)));
  editGreen.Text := IntToStr(Round(GetGValue(colorboxBackgroundColor.Selected)));
  editBlue.Text := IntToStr(Round(GetBValue(colorboxBackgroundColor.Selected)));
end;
{------------------------------------------------------------------------------}
{ sbFormulaButtonClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.sbFormulaButtonClick(Sender: TObject);
var
  xList : TStrings;
begin
  if not (Sender is TSpeedButton) then
    Exit;
  {Set Crpe Formulas to chosen item}
  if TSpeedButton(Sender) = sbPrintAtBottomOfPage then
    xList := Cr.SectionFormat.Item.Formulas.PrintAtBottomOfPage
  else if TSpeedButton(Sender) = sbNewPageBefore then
    xList := Cr.SectionFormat.Item.Formulas.NewPageBefore
  else if TSpeedButton(Sender) = sbNewPageAfter then
    xList := Cr.SectionFormat.Item.Formulas.NewPageAfter
  else if TSpeedButton(Sender) = sbResetPageNAfter then
    xList := Cr.SectionFormat.Item.Formulas.ResetPageNAfter
  else if TSpeedButton(Sender) = sbKeepTogether then
    xList := Cr.SectionFormat.Item.Formulas.KeepTogether
  else if TSpeedButton(Sender) = sbSuppressBlankSection then
    xList := Cr.SectionFormat.Item.Formulas.SuppressBlankSection
  else if TSpeedButton(Sender) = sbUnderlaySection then
    xList := Cr.SectionFormat.Item.Formulas.UnderlaySection
  else if TSpeedButton(Sender) = sbBackgroundColor then
    xList := Cr.SectionFormat.Item.Formulas.BackgroundColor
  else
    {Default to Suppress}
    xList := Cr.SectionFormat.Item.Formulas.Suppress;

  {Create the Formula editing form}
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := xList;
  CrpeFormulaEditDlg.Caption := TSpeedButton(Sender).Hint;
  CrpeFormulaEditDlg.ShowModal;
  {Update the main form}
  lbSectionsClick(Self);
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeSectionFormatDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bSectionFormat := False;
  Release;
end;


end.


