unit UDTextObjects;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32;

type
  TCrpeTextObjectsDlg = class(TForm)
    pnlTextObjects: TPanel;
    lblNumber: TLabel;
    lbNumbers: TListBox;
    editCount: TEdit;
    lblCount: TLabel;
    GroupBox1: TGroupBox;
    btnBorder: TButton;
    btnFont: TButton;
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
    memoLines: TMemo;
    lblLines: TLabel;
    rgUnits: TRadioGroup;
    btnEmbeddedFields: TButton;
    btnParagraphs: TButton;
    editTextSize: TEdit;
    lblTextSize: TLabel;
    lblTextHeight: TLabel;
    editTextHeight: TEdit;
    btnInsertText: TButton;
    btnDeleteText: TButton;
    btnInsertFile: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnClearClick(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure UpdateTextObjects;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure editSizeEnter(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure cbSectionChange(Sender: TObject);
    procedure btnBorderClick(Sender: TObject);
    procedure InitializeControls(OnOff: boolean);
    procedure rgUnitsClick(Sender: TObject);
    procedure memoLinesExit(Sender: TObject);
    procedure btnEmbeddedFieldsClick(Sender: TObject);
    procedure btnParagraphsClick(Sender: TObject);
    procedure btnFormatClick(Sender: TObject);
    procedure btnInsertFileClick(Sender: TObject);
    procedure btnInsertTextClick(Sender: TObject);
    procedure btnDeleteTextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr       : TCrpe;
    TIndex   : integer;
    PrevSize : string;
    OpenDir  : string;
  end;

var
  CrpeTextObjectsDlg : TCrpeTextObjectsDlg;
  bTextObjects       : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDBorder, UDFormat, UDParagraphs, UDEmbeddedFields,
  UDFormulaEdit, UDTODeleteText, UDFont;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.FormCreate(Sender: TObject);
begin
  bTextObjects := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  TIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.FormShow(Sender: TObject);
begin
  OpenDir := ExtractFilePath(Application.ExeName);
  UpdateTextObjects;
end;
{------------------------------------------------------------------------------}
{ UpdateTextObjects                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.UpdateTextObjects;
var
  OnOff : boolean;
  i     : integer;
begin
  TIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Cr.TextObjects.Count > 0);
    {Get TextObjects Index}
    if OnOff then
    begin
      if Cr.TextObjects.ItemIndex > -1 then
        TIndex := Cr.TextObjects.ItemIndex
      else
        TIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Section ComboBox}
    cbSection.Clear;
    cbSection.Items.AddStrings(Cr.SectionFormat.Names);
    {Fill Numbers ListBox}
    for i := 0 to Cr.TextObjects.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Cr.TextObjects.Count);
    lbNumbers.ItemIndex := TIndex;
    lbNumbersClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.InitializeControls(OnOff: boolean);
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
{ lbNumbersClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.lbNumbersClick(Sender: TObject);
begin
  TIndex := lbNumbers.ItemIndex;
  memoLines.Lines.Assign(Cr.TextObjects[TIndex].Lines);
  editTextSize.Text := IntToStr(Cr.TextObjects.Item.TextSize);
  editTextHeight.Text := IntToStr(Cr.TextObjects.Item.TextHeight);
  {Formatting}
  cbSection.ItemIndex := Cr.SectionFormat.IndexOf(Cr.TextObjects.Item.Section);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ memoLinesExit                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.memoLinesExit(Sender: TObject);
begin
  Cr.TextObjects.Item.Lines.Assign(memoLines.Lines);
end;
{------------------------------------------------------------------------------}
{ btnEmbeddedFieldsClick                                                       }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnEmbeddedFieldsClick(Sender: TObject);
begin
  CrpeEmbeddedFieldsDlg := TCrpeEmbeddedFieldsDlg.Create(Application);
  CrpeEmbeddedFieldsDlg.Cr := Cr;
  CrpeEmbeddedFieldsDlg.CursorPos := memoLines.SelStart;
  CrpeEmbeddedFieldsDlg.ShowModal;
  UpdateTextObjects;
end;
{------------------------------------------------------------------------------}
{ btnParagraphsClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnParagraphsClick(Sender: TObject);
begin
  CrpeParagraphsDlg := TCrpeParagraphsDlg.Create(Application);
  CrpeParagraphsDlg.Crp := Cr.TextObjects.Item.Paragraphs;
  CrpeParagraphsDlg.ShowModal;
  UpdateTextObjects;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editTop.Text := TwipsToInchesStr(Cr.TextObjects.Item.Top);
    editLeft.Text := TwipsToInchesStr(Cr.TextObjects.Item.Left);
    editWidth.Text := TwipsToInchesStr(Cr.TextObjects.Item.Width);
    editHeight.Text := TwipsToInchesStr(Cr.TextObjects.Item.Height);
  end
  else  {twips}
  begin
    editTop.Text := IntToStr(Cr.TextObjects.Item.Top);
    editLeft.Text := IntToStr(Cr.TextObjects.Item.Left);
    editWidth.Text := IntToStr(Cr.TextObjects.Item.Width);
    editHeight.Text := IntToStr(Cr.TextObjects.Item.Height);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeEnter                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.editSizeEnter(Sender: TObject);
begin
  if Sender is TEdit then
    PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.editSizeExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.TextObjects.Item.Top := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.TextObjects.Item.Left := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.TextObjects.Item.Width := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.TextObjects.Item.Height := InchesStrToTwips(TEdit(Sender).Text);
      UpdateTextObjects; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editTop' then
        Cr.TextObjects.Item.Top := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Cr.TextObjects.Item.Left := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editWidth' then
        Cr.TextObjects.Item.Width := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editHeight' then
        Cr.TextObjects.Item.Height := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ cbSectionChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.cbSectionChange(Sender: TObject);
begin
  Cr.TextObjects.Item.Section := cbSection.Items[cbSection.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ btnBorderClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnBorderClick(Sender: TObject);
begin
  CrpeBorderDlg := TCrpeBorderDlg.Create(Application);
  CrpeBorderDlg.Border := Cr.TextObjects.Item.Border;
  CrpeBorderDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnFontClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnFontClick(Sender: TObject);
begin
  if Cr.Version.Crpe.Major > 7 then
  begin
    CrpeFontDlg := TCrpeFontDlg.Create(Application);
    CrpeFontDlg.Crf := Cr.TextObjects.Item.Font;
    CrpeFontDlg.ShowModal;
  end
  else
  begin
    FontDialog1.Font.Assign(Cr.TextObjects.Item.Font);
    if FontDialog1.Execute then
      Cr.TextObjects.Item.Font.Assign(FontDialog1.Font);
  end;
end;
{------------------------------------------------------------------------------}
{ btnFormatClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnFormatClick(Sender: TObject);
begin
  CrpeFormatDlg := TCrpeFormatDlg.Create(Application);
  CrpeFormatDlg.Format := Cr.TextObjects.Item.Format;
  CrpeFormatDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnInsertFileClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnInsertFileClick(Sender: TObject);
var
  prevCursor : TCursor;
begin
  {Set the dialog default filename, filter and title}
  OpenDialog1.FileName := '*.*';
  OpenDialog1.Filter := 'Text File (*.*)|*.*';
  OpenDialog1.Title := 'Choose Text File to Insert...';
  OpenDialog1.InitialDir := OpenDir;
  if OpenDialog1.Execute then
  begin
    prevCursor := Screen.Cursor;
    Screen.Cursor := crHourglass;
    Refresh;
    OpenDir := ExtractFilePath(OpenDialog1.FileName);
    Cr.TextObjects.Item.InsertFile(OpenDialog1.FileName, memoLines.SelStart);
    UpdateTextObjects;
    Screen.Cursor := prevCursor;
  end;
end;
{------------------------------------------------------------------------------}
{ btnInsertTextClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnInsertTextClick(Sender: TObject);
var
  sList      : TStringList;
  prevCursor : TCursor;
begin
  sList := TStringList.Create;
  try
    {Create the Formula editing form}
    CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
    CrpeFormulaEditDlg.SenderList := sList;
    CrpeFormulaEditDlg.Caption := 'Type Text to Insert';
    CrpeFormulaEditDlg.ShowModal;
    if CrpeFormulaEditDlg.ModalResult = mrOk then
    begin
      prevCursor := Screen.Cursor;
      Screen.Cursor := crHourglass;
      Refresh;
      Cr.TextObjects.Item.InsertText(sList, memoLines.SelStart);
      UpdateTextObjects;
      Screen.Cursor := prevCursor;
    end;
  finally
    sList.Free;
  end;
end;
{------------------------------------------------------------------------------}
{ btnDeleteTextClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnDeleteTextClick(Sender: TObject);
begin
  CrpeDeleteTextDlg := TCrpeDeleteTextDlg.Create(Application);
  CrpeDeleteTextDlg.Cr := Cr;
  CrpeDeleteTextDlg.ShowModal;
  if CrpeDeleteTextDlg.ModalResult = mrOk then
    UpdateTextObjects;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnClearClick(Sender: TObject);
begin
  Cr.TextObjects.Item.Clear;
  UpdateTextObjects;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeTextObjectsDlg.btnOkClick(Sender: TObject);
begin
  rgUnits.ItemIndex := 1; {change to twips to avoid the UpdateTextObjects call}
  if (not IsStrEmpty(Cr.ReportName)) and (TIndex > -1) then 
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
procedure TCrpeTextObjectsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bTextObjects := False;
  Release;
end;


end.
