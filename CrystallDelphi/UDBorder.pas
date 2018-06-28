unit UDBorder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCrpe32, UCrpeClasses;

type
  TCrpeBorderDlg = class(TForm)
    gbLineStyle: TGroupBox;
    cbLeft: TComboBox;
    lblLeft: TLabel;
    lblRight: TLabel;
    cbRight: TComboBox;
    cbTop: TComboBox;
    lblTop: TLabel;
    lblBottom: TLabel;
    cbBottom: TComboBox;
    sbFormulaRed: TSpeedButton;
    sbFormulaBlue: TSpeedButton;
    sbLeft: TSpeedButton;
    sbRight: TSpeedButton;
    sbTop: TSpeedButton;
    sbBottom: TSpeedButton;
    pnlTightHorizontal: TPanel;
    pnlDropShadow: TPanel;
    cbTightHorizontal: TCheckBox;
    cbDropShadow: TCheckBox;
    sbDropShadow: TSpeedButton;
    gbColor: TGroupBox;
    ColorDialog1: TColorDialog;
    lblForeColor: TLabel;
    sbForeColor: TSpeedButton;
    sbBackgroundColor: TSpeedButton;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    lblBackgroundColor: TLabel;
    sbTightHorizontal: TSpeedButton;
    cbForeColor: TColorBox;
    cbBackgroundColor: TColorBox;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnClearClick(Sender: TObject);
    procedure FormulaButtonClick(Sender: TObject);
    procedure UpdateBorder;
  private
    { Private declarations }
  public
    Border : TCrpeBorder; {reference to TCrpeBorder}
  end;

var
  CrpeBorderDlg: TCrpeBorderDlg;
  bBorder      : boolean;

implementation

{$R *.DFM}

uses UCrpeUtl, UDFormulaEdit;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeBorderDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  bBorder := True;
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeBorderDlg.FormShow(Sender: TObject);
begin
  UpdateBorder;
end;
{------------------------------------------------------------------------------}
{ UpdateBorder                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeBorderDlg.UpdateBorder;

  procedure SetFormulaButton(sb: TSpeedButton; sList: TStrings);
  begin
    if IsStringListEmpty(sList) then
    begin
      if sb.Tag <> 0 then
      begin
        sb.Glyph := sbFormulaBlue.Glyph;
        sb.Tag := 0;
      end;
    end
    else
    begin
      if sb.Tag <> 1 then
      begin
        sb.Glyph := sbFormulaRed.Glyph;
        sb.Tag := 1;
      end;
    end;
  end;

begin
  {ForeColor}
  cbForeColor.Selected := Border.ForeColor;
  {BackgroundColor}
  cbBackgroundColor.Selected := Border.BackgroundColor;
  {Left}
  SetFormulaButton(sbLeft, Border.Formulas.Left);
  {Right}
  SetFormulaButton(sbRight, Border.Formulas.Right);
  {Top}
  SetFormulaButton(sbTop, Border.Formulas.Top);
  {Bottom}
  SetFormulaButton(sbBottom, Border.Formulas.Bottom);
  {TightHorizontal}
  SetFormulaButton(sbTightHorizontal, Border.Formulas.TightHorizontal);
  {DropShadow}
  SetFormulaButton(sbDropShadow, Border.Formulas.DropShadow);
  {Color}
  SetFormulaButton(sbForeColor, Border.Formulas.ForeColor);
  {BackgroundColor}
  SetFormulaButton(sbBackgroundColor, Border.Formulas.BackgroundColor);

  cbLeft.ItemIndex := Ord(Border.Left);
  cbRight.ItemIndex := Ord(Border.Right);
  cbTop.ItemIndex := Ord(Border.Top);
  cbBottom.ItemIndex := Ord(Border.Bottom);
  cbTightHorizontal.Checked := Border.TightHorizontal;
  cbDropShadow.Checked := Border.DropShadow;
end;
{------------------------------------------------------------------------------}
{ FormulaButtonClick                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeBorderDlg.FormulaButtonClick(Sender: TObject);
var
  CRFF : TStrings;
begin
  if not (Sender is TSpeedButton) then
    Exit;

  {Set Crpe Formulas to chosen item}
  if TSpeedButton(Sender) = sbLeft then
    CRFF := Border.Formulas.Left
  else if TSpeedButton(Sender) = sbRight then
    CRFF := Border.Formulas.Right
  else if TSpeedButton(Sender) = sbTop then
    CRFF := Border.Formulas.Top
  else if TSpeedButton(Sender) = sbBottom then
    CRFF := Border.Formulas.Bottom
  else if TSpeedButton(Sender) = sbTightHorizontal then
    CRFF := Border.Formulas.TightHorizontal
  else if TSpeedButton(Sender) = sbDropShadow then
    CRFF := Border.Formulas.DropShadow
  else if TSpeedButton(Sender) = sbForeColor then
    CRFF := Border.Formulas.ForeColor
  else if TSpeedButton(Sender) = sbBackgroundColor then
    CRFF := Border.Formulas.BackgroundColor
  else
    CRFF := Border.Formulas.Left;

  {Create the Formula editing form}
  CrpeFormulaEditDlg := TCrpeFormulaEditDlg.Create(Application);
  CrpeFormulaEditDlg.SenderList := CRFF;
  CrpeFormulaEditDlg.Caption := TSpeedButton(Sender).Hint;
  CrpeFormulaEditDlg.ShowModal;
  {Update the form}
  UpdateBorder;
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeBorderDlg.btnOkClick(Sender: TObject);
begin
  Border.Left := TCrLineStyle(cbLeft.ItemIndex);
  Border.Right := TCrLineStyle(cbRight.ItemIndex);
  Border.Top := TCrLineStyle(cbTop.ItemIndex);
  Border.Bottom := TCrLineStyle(cbBottom.ItemIndex);
  Border.TightHorizontal := cbTightHorizontal.Checked;
  Border.DropShadow := cbDropShadow.Checked;
  Border.ForeColor := cbForeColor.Selected;
  Border.BackgroundColor := cbBackgroundColor.Selected;
end;
{------------------------------------------------------------------------------}
{ btnClearClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeBorderDlg.btnClearClick(Sender: TObject);
begin
  Border.Clear;
  UpdateBorder;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeBorderDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bBorder := False;
  Release;
end;


end.
