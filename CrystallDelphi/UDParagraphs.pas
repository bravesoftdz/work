unit UDParagraphs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UCrpe32;

type
  TCrpeParagraphsDlg = class(TForm)
    pnlParagraphs: TPanel;
    lblNames: TLabel;
    lblFieldName: TLabel;
    lblTextStart: TLabel;
    lblCount: TLabel;
    lblTextEnd: TLabel;
    lbNumbers: TListBox;
    editTextStart: TEdit;
    editCount: TEdit;
    editTextEnd: TEdit;
    btnOk: TButton;
    btnClear: TButton;
    cbAlignment: TComboBox;
    gbIndent: TGroupBox;
    editFirstLine: TEdit;
    lblFirstLine: TLabel;
    lblLeft: TLabel;
    editLeft: TEdit;
    lblRight: TLabel;
    editRight: TEdit;
    rgUnits: TRadioGroup;
    btnTabStops: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbNumbersClick(Sender: TObject);
    procedure cbAlignmentChange(Sender: TObject);
    procedure editIndentEnter(Sender: TObject);
    procedure editIndentExit(Sender: TObject);
    procedure rgUnitsClick(Sender: TObject);
    procedure btnTabStopsClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InitializeControls(OnOff: boolean);
    procedure UpdateParagraphs;
  private
    { Private declarations }
  public
    { Public declarations }
    Crp      : TCrpeParagraphs;
    PIndex   : integer;
    PrevSize : string;
  end;

var
  CrpeParagraphsDlg: TCrpeParagraphsDlg;
  bParagraphs      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDTabStops, UCrpeClasses;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.FormCreate(Sender: TObject);
begin
  bParagraphs := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  PIndex := -1;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.FormShow(Sender: TObject);
begin
  UpdateParagraphs;
end;
{------------------------------------------------------------------------------}
{ UpdateParagraphs                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.UpdateParagraphs;
var
  OnOff : boolean;
  i     : integer;
begin
  PIndex := -1;
  {Enable/Disable controls}
  if IsStrEmpty(Crp.Cr.ReportName) then
    OnOff := False
  else
  begin
    OnOff := (Crp.Count > 0);
    {Get Paragraphs Index}
    if OnOff then
    begin
      if Crp.ItemIndex > -1 then
        PIndex := Crp.ItemIndex
      else
        PIndex := 0;
    end;
  end;
  InitializeControls(OnOff);

  {Update list box}
  if OnOff then
  begin
    {Fill Numbers ListBox}
    for i := 0 to Crp.Count - 1 do
      lbNumbers.Items.Add(IntToStr(i));
    editCount.Text := IntToStr(Crp.Count);
    lbNumbers.ItemIndex := PIndex;
    lbNumbersClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ InitializeControls                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.InitializeControls(OnOff: boolean);
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
procedure TCrpeParagraphsDlg.lbNumbersClick(Sender: TObject);
begin
  PIndex := lbNumbers.ItemIndex;
  cbAlignment.ItemIndex := Ord(Crp[PIndex].Alignment);
  editTextStart.Text := IntToStr(Crp.Item.TextStart);
  editTextEnd.Text := IntToStr(Crp.Item.TextEnd);
  rgUnitsClick(Self);
end;
{------------------------------------------------------------------------------}
{ cbAlignmentChange                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.cbAlignmentChange(Sender: TObject);
begin
  Crp.Item.Alignment := TCrHorizontalAlignment(cbAlignment.ItemIndex);
end;
{------------------------------------------------------------------------------}
{ editIndentEnter                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.editIndentEnter(Sender: TObject);
begin
  PrevSize := TEdit(Sender).Text;
end;
{------------------------------------------------------------------------------}
{ editIndentExit                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.editIndentExit(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then  {inches}
  begin
    if not IsFloating(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editFirstLine' then
        Crp.Item.IndentFirstLine := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Crp.Item.IndentLeft := InchesStrToTwips(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editRight' then
        Crp.Item.IndentRight := InchesStrToTwips(TEdit(Sender).Text);
      UpdateParagraphs; {this will truncate any decimals beyond 3 places}
    end;
  end
  else  {twips}
  begin
    if not IsNumeric(TEdit(Sender).Text) then
      TEdit(Sender).Text := PrevSize
    else
    begin
      if TEdit(Sender).Name = 'editFirstLine' then
        Crp.Item.IndentFirstLine := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editLeft' then
        Crp.Item.IndentLeft := StrToInt(TEdit(Sender).Text);
      if TEdit(Sender).Name = 'editRight' then
        Crp.Item.IndentRight := StrToInt(TEdit(Sender).Text);
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ rgUnitsClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then {inches}
  begin
    editFirstLine.Text := TwipsToInchesStr(Crp.Item.IndentFirstLine);
    editLeft.Text := TwipsToInchesStr(Crp.Item.IndentLeft);
    editRight.Text := TwipsToInchesStr(Crp.Item.IndentRight);
  end
  else  {twips}
  begin
    editFirstLine.Text := IntToStr(Crp.Item.IndentFirstLine);
    editLeft.Text := IntToStr(Crp.Item.IndentLeft);
    editRight.Text := IntToStr(Crp.Item.IndentRight);
  end;
end;
{------------------------------------------------------------------------------}
{ btnTabStopsClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.btnTabStopsClick(Sender: TObject);
begin
  CrpeTabStopsDlg := TCrpeTabStopsDlg.Create(Application);
  CrpeTabStopsDlg.Crt := Crp.Item.TabStops;
  CrpeTabStopsDlg.ShowModal;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.btnClearClick(Sender: TObject);
begin
  Crp.Clear;
  UpdateParagraphs;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeParagraphsDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bParagraphs := False;
  Release;
end;


end.
