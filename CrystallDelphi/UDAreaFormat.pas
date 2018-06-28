unit UDAreaFormat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, UCrpe32;

type
  TCrpeAreaFormatDlg = class(TForm)
    pnlAreaFormat: TPanel;
    lblArea: TLabel;
    cbPrintAtBottomOfPage: TCheckBox;
    cbNewPageBefore: TCheckBox;
    cbNewPageAfter: TCheckBox;
    cbResetPageNAfter: TCheckBox;
    cbKeepTogether: TCheckBox;
    cbHide: TCheckBox;
    cbSuppress: TCheckBox;
    lbAreas: TListBox;
    btnOk: TButton;
    btnClear: TButton;
    sbSuppress: TSpeedButton;
    sbPrintAtBottomOfPage: TSpeedButton;
    sbNewPageBefore: TSpeedButton;
    sbNewPageAfter: TSpeedButton;
    sbResetPageNAfter: TSpeedButton;
    sbKeepTogether: TSpeedButton;
    sbHide: TSpeedButton;
    sbFormulaRed: TSpeedButton;
    sbFormulaBlue: TSpeedButton;
    lblCount: TLabel;
    editCount: TEdit;
    editNSections: TEdit;
    lblNSections: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure lbAreasClick(Sender: TObject);
    procedure cbCommonClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateAreaFormat;
    procedure sbFormulaButtonClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr        : TCrpe;
    AreaIndex : smallint;
  end;

var
  CrpeAreaFormatDlg: TCrpeAreaFormatDlg;
  bAreaFormat      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDFormulaEdit;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  AreaIndex := -1;
  btnOk.Tag := 1;
  bAreaFormat := True;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.FormShow(Sender: TObject);
begin
  UpdateAreaFormat;
end;
{------------------------------------------------------------------------------}
{ UpdateAreaFormat procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.UpdateAreaFormat;
var
  OnOff : boolean;
begin
  AreaIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.AreaFormat.Count > 0);
    {Get AreaFormat Index}
    if OnOff then
    begin
      if Cr.AreaFormat.ItemIndex > -1 then
        AreaIndex := Cr.AreaFormat.ItemIndex
      else
        AreaIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff = True then
  begin
    lbAreas.Items.AddStrings(Cr.AreaFormat.Names);
    editCount.Text := IntToStr(Cr.AreaFormat.Count);
    lbAreas.ItemIndex := AreaIndex;
    lbAreasClick(self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.InitializeControls(OnOff: boolean);
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
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbAFSectionClick procedure                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.lbAreasClick(Sender: TObject);
const
  aSection : array[0..3] of string = ('PH','PF','RH','RF');
var
  sTmp : string;
  i    : integer;
  s1   : string;
begin
  AreaIndex := lbAreas.ItemIndex;
  {Disable events}
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TCheckBox then
      TCheckBox(Components[i]).OnClick := nil;
  end;

  cbSuppress.Checked := Cr.AreaFormat[AreaIndex].Suppress;
  cbHide.Checked := Cr.AreaFormat.Item.Hide;
  cbPrintAtBottomOfPage.Checked := Cr.AreaFormat.Item.PrintAtBottomOfPage;
  cbNewPageBefore.Checked := Cr.AreaFormat.Item.NewPageBefore;
  cbNewPageAfter.Checked := Cr.AreaFormat.Item.NewPageAfter;
  cbResetPageNAfter.Checked := Cr.AreaFormat.Item.ResetPageNAfter;
  cbKeepTogether.Checked := Cr.AreaFormat.Item.KeepTogether;
  editNSections.Text := IntToStr(Cr.AreaFormat.Item.NSections);

  {Disable inapplicable items for the section}
  sTmp := Copy(Cr.AreaFormat.Area, 1, 2);
  sTmp := UpperCase(sTmp);
  {if the Section is Report Header...}
  if (sTmp = 'RH') then
  begin
    {disable New Page Before}
    cbNewPageBefore.Enabled := False;
    {enable the other 4 options if needed}
    {Hide}
    if cbHide.Enabled = False then
      cbHide.Enabled := True;
    {PrintAtBottomOfPage}
    if cbPrintAtBottomOfPage.Enabled = False then
      cbPrintAtBottomOfPage.Enabled := True;
    {NewPageAfter}
    if cbNewPageAfter.Enabled = False then
      cbNewPageAfter.Enabled := True;
    {KeepTogether}
    if cbKeepTogether.Enabled = False then
      cbKeepTogether.Enabled := True;
  end
  {if the Section is Report Footer...}
  else if (sTmp = 'RF') then
  begin
    {disable NewPageAfter}
    cbNewPageAfter.Enabled := False;
    {enable the other 4 options if needed}
    {Hide}
    if cbHide.Enabled = False then
      cbHide.Enabled := True;
    {PrintAtBottomOfPage}
    if cbPrintAtBottomOfPage.Enabled = False then
      cbPrintAtBottomOfPage.Enabled := True;
    {KeepTogether}
    if cbKeepTogether.Enabled = False then
      cbKeepTogether.Enabled := True;
    {NewPageBefore}
    if cbNewPageBefore.Enabled = False then
      cbNewPageBefore.Enabled := True;
  end
  {if the Section is Page Header or Page Footer...}
  else if (sTmp = 'PH') or (sTmp = 'PF') then
  begin
    {Disable: Hide, PrintAtBottomOfPage, NewPageAfter,
     NewPageBefore, KeepTogether}
    cbHide.Enabled := False;
    cbPrintAtBottomOfPage.Enabled := False;
    cbNewPageAfter.Enabled := False;
    cbNewPageBefore.Enabled := False;
    cbKeepTogether.Enabled := False;
  end
  else
  begin
    {enable the 5 options as required}
    {Hide}
    if cbHide.Enabled = False then
      cbHide.Enabled := True;
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

  {Set Formula Button glyphs: check first 5 for PH/PF, RH/RF}
  {NewPageBefore}
  if Pos(UpperCase(Cr.AreaFormat.Area), 'PHPFRH') = 0 then
  begin
    if not sbNewPageBefore.Enabled then
      sbNewPageBefore.Enabled := True;
    {If formula has text...}
    s1 := RTrimList(Cr.AreaFormat.Item.Formulas.NewPageBefore);
    if Length(s1) > 0 then
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
  if Pos(UpperCase(Cr.AreaFormat.Area), 'PHPFRF') = 0 then
  begin
    if not sbNewPageAfter.Enabled then
      sbNewPageAfter.Enabled := True;
    s1 := RTrimList(Cr.AreaFormat.Item.Formulas.NewPageAfter);
    if Length(s1) > 0 then
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
  if Pos(UpperCase(Cr.AreaFormat.Area), 'PHPF') = 0 then
  begin
    if not sbKeepTogether.Enabled then
      sbKeepTogether.Enabled := True;
    s1 := RTrimList(Cr.AreaFormat.Item.Formulas.KeepTogether);
    if Length(s1) > 0 then
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
  if Pos(UpperCase(Cr.AreaFormat.Area), 'PHPF') = 0 then
  begin
    if not sbPrintAtBottomOfPage.Enabled then
      sbPrintAtBottomOfPage.Enabled := True;
    s1 := RTrimList(Cr.AreaFormat.Item.Formulas.PrintAtBottomOfPage);
    if Length(s1) > 0 then
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

  {Hide}
  if Pos(UpperCase(Cr.AreaFormat.Area), 'PHPF') = 0 then
  begin
    if not sbHide.Enabled then
      sbHide.Enabled := True;
    s1 := RTrimList(Cr.AreaFormat.Item.Formulas.Hide);
    if Length(s1) > 0 then
    begin
      if sbHide.Tag <> 1 then
      begin
        sbHide.Glyph := sbFormulaRed.Glyph;
        sbHide.Tag := 1;
      end;
    end
    else
    begin
      if sbHide.Tag <> 0 then
      begin
        sbHide.Glyph := sbFormulaBlue.Glyph;
        sbHide.Tag := 0;
      end;
    end;
  end
  else
  begin
    if sbHide.Enabled then
      sbHide.Enabled := False;
  end;

  {Suppress}
  s1 := RTrimList(Cr.AreaFormat.Item.Formulas.Suppress);
  if Length(s1) > 0 then
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

  {ResetPageNAfter}
  s1 := RTrimList(Cr.AreaFormat.Item.Formulas.ResetPageNAfter);
  if Length(s1) > 0 then
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

  {Enable events}
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TCheckBox then
      TCheckBox(Components[i]).OnClick := cbCommonClick;
  end;
end;
{------------------------------------------------------------------------------}
{ sbFormulaButtonClick procedure                                             }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.sbFormulaButtonClick(Sender: TObject);
var
  sFormula : TStrings;
begin
  if not (Sender is TSpeedButton) then
    Exit;

  {Set Crpe Formulas to chosen item}
  if TSpeedButton(Sender) = sbPrintAtBottomOfPage then
    sFormula := Cr.AreaFormat.Item.Formulas.PrintAtBottomOfPage
  else if TSpeedButton(Sender) = sbNewPageBefore then
    sFormula := Cr.AreaFormat.Item.Formulas.NewPageBefore
  else if TSpeedButton(Sender) = sbNewPageAfter then
    sFormula := Cr.AreaFormat.Item.Formulas.NewPageAfter
  else if TSpeedButton(Sender) = sbResetPageNAfter then
    sFormula := Cr.AreaFormat.Item.Formulas.ResetPageNAfter
  else if TSpeedButton(Sender) = sbKeepTogether then
    sFormula := Cr.AreaFormat.Item.Formulas.KeepTogether
  else if TSpeedButton(Sender) = sbHide then
    sFormula := Cr.AreaFormat.Item.Formulas.Hide
  else
    {Default to Suppress}
    sFormula := Cr.AreaFormat.Item.Formulas.Suppress;

  {Create the Formula editing form}
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := sFormula;
  CrpeFormulaEditDlg.Caption := TSpeedButton(Sender).Hint;
  CrpeFormulaEditDlg.ShowModal;

  {Update the main form}
  lbAreasClick(Self);
end;
{------------------------------------------------------------------------------}
{ cbCommonClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.cbCommonClick(Sender: TObject);
begin
  if not (Sender is TCheckBox) then
    Exit;
  {Update the VCL}
  if TCheckBox(Sender).Name = 'cbSuppress' then
    Cr.AreaFormat.Item.Suppress := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbHide' then
    Cr.AreaFormat.Item.Hide := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbPrintAtBottomOfPage' then
    Cr.AreaFormat.Item.PrintAtBottomOfPage := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbNewPageBefore' then
    Cr.AreaFormat.Item.NewPageBefore := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbNewPageAfter' then
    Cr.AreaFormat.Item.NewPageAfter := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbResetPageNAfter' then
    Cr.AreaFormat.Item.ResetPageNAfter := TCheckBox(Sender).Checked
  else if TCheckBox(Sender).Name = 'cbKeepTogether' then
    Cr.AreaFormat.Item.KeepTogether := TCheckBox(Sender).Checked;
end;
{------------------------------------------------------------------------------}
{ btnClearClick procedure                                                      }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.btnClearClick(Sender: TObject);
begin
  Cr.AreaFormat.Clear;
  UpdateAreaFormat;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeAreaFormatDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bAreaFormat := False;
  Release;
end;


end.
