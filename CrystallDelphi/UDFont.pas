unit UDFont;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UCrpe32, UCrpeClasses;

type
  TCrpeFontDlg = class(TForm)
    editFontName: TEdit;
    lbFontNames: TListBox;
    Label1: TLabel;
    editStyle: TEdit;
    lbStyles: TListBox;
    Label2: TLabel;
    editSize: TEdit;
    lbSizes: TListBox;
    Label3: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    gbEffects: TGroupBox;
    cbStrikeout: TCheckBox;
    cbUnderline: TCheckBox;
    gbSample: TGroupBox;
    pnlSample: TPanel;
    lblColor: TLabel;
    ColorDialog1: TColorDialog;
    lblActualSize: TLabel;
    editActualSize: TEdit;
    PaintBox1: TPaintBox;
    imgTrueType: TImage;
    imgType1: TImage;
    cbColor: TColorBox;
    procedure cbColorChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbFontNamesClick(Sender: TObject);
    procedure editFontNameChange(Sender: TObject);
    procedure UpdateFont;
    procedure editStyleChange(Sender: TObject);
    procedure lbStylesClick(Sender: TObject);
    procedure editSizeChange(Sender: TObject);
    procedure lbSizesClick(Sender: TObject);
    procedure editActualSizeChange(Sender: TObject);
    procedure cbStrikeoutClick(Sender: TObject);
    procedure cbUnderlineClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure editFontNameExit(Sender: TObject);
    procedure editStyleExit(Sender: TObject);
    procedure editSizeExit(Sender: TObject);
    procedure lbFontNamesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    Crf         : TCrpeFont;
    CustomColor : TColor;
    bFont       : Boolean;
  end;

var
  CrpeFontDlg: TCrpeFontDlg;

implementation

{$R *.DFM}

uses Printers, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
  btnOk.Tag := 1;
  bFont := True;
  cbColor.Selected := clBlack;
  {Font Name}
  lbFontNames.Clear;
  lbFontNames.Sorted := True;
  lbFontNames.Items.AddStrings(Screen.Fonts);
  {Style}
  lbStyles.Clear;
  lbStyles.Items.Add('Regular');
  lbStyles.Items.Add('Italic');
  lbStyles.Items.Add('Bold');
  lbStyles.Items.Add('Bold Italic');
  {Size}
  lbSizes.Clear;
  lbSizes.Items.Add('8');
  lbSizes.Items.Add('9');
  lbSizes.Items.Add('10');
  lbSizes.Items.Add('11');
  lbSizes.Items.Add('12');
  lbSizes.Items.Add('14');
  lbSizes.Items.Add('16');
  lbSizes.Items.Add('18');
  lbSizes.Items.Add('20');
  lbSizes.Items.Add('22');
  lbSizes.Items.Add('24');
  lbSizes.Items.Add('26');
  lbSizes.Items.Add('28');
  lbSizes.Items.Add('36');
  lbSizes.Items.Add('48');
  lbSizes.Items.Add('72');
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.FormShow(Sender: TObject);
begin
  UpdateFont;
end;
{------------------------------------------------------------------------------}
{ UpdateFont                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.UpdateFont;
begin
  editFontName.Text := Crf.Name;
  if Crf.Style = [] then
    editStyle.Text := 'Regular';
  if Crf.Style = [fsBold] then
    editStyle.Text := 'Bold';
  if Crf.Style = [fsItalic] then
    editStyle.Text := 'Italic';
  if Crf.Style = [fsBold, fsItalic] then
    editStyle.Text := 'Bold Italic';
  editSize.OnChange := nil;
  editSize.Text := IntToStr(Crf.Size);
  editSize.OnChange := editSizeChange;
  lbSizes.ItemIndex := lbSizes.Items.IndexOf(editSize.Text);
  editActualSize.OnChange := nil;
  editActualSize.Text := CrFloatingToStr(Crf.ActualSize);
  editActualSize.OnChange := editActualSizeChange;
  cbStrikeout.Checked := fsStrikeOut in Crf.Style;
  cbUnderline.Checked := fsUnderline in Crf.Style;
  cbColor.Selected := Crf.Color;
  pnlSample.Font.Assign(Crf);
end;
{------------------------------------------------------------------------------}
{ cbColorChange                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.cbColorChange(Sender: TObject);
begin
  Crf.Color := cbColor.Selected;
end;
{------------------------------------------------------------------------------}
{ editFontNameChange                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.editFontNameChange(Sender: TObject);
var
  i,j : integer;
  s,f : string;
begin
  i := lbFontNames.Items.IndexOf(editFontName.Text);
  if i > -1 then
  begin
    lbFontNames.ItemIndex := i;
    editFontName.Text := lbFontNames.Items[i];
    pnlSample.Font.Name := editFontName.Text;
  end
  else
  begin
    for i := 0 to lbFontNames.Items.Count-1 do
    begin
      s := LowerCase(editFontName.Text);
      f := LowerCase(lbFontNames.Items[i]);
      j := Pos(s, f);
      if j = 1 then
      begin
        lbFontNames.ItemIndex := i;
        Exit;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ editFontNameExit                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.editFontNameExit(Sender: TObject);
var
  i : integer;
begin
  i := lbFontNames.Items.IndexOf(editFontName.Text);
  if i = -1 then
  begin
    if lbFontNames.ItemIndex < 0 then lbFontNames.ItemIndex := 0;
    lbFontNamesClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ lbFontNamesClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.lbFontNamesClick(Sender: TObject);
begin
  editFontName.OnChange := nil;
  editFontName.Text := lbFontNames.Items[lbFontNames.ItemIndex];
  editFontName.OnChange := editFontNameChange;
  pnlSample.Font.Name := lbFontNames.Items[lbFontNames.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ lbFontNamesDrawItem                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.lbFontNamesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  ColorR   : TRect;
  TextR    : TRect;
  FontInfo : TTextMetric;
  g        : TBitmap;
begin
  ColorR.Left := Rect.Left + 1;
  ColorR.Top := Rect.Top + 1;
  ColorR.Right := Rect.Left + 14{ColorWidth} - 1;
  ColorR.Bottom := Rect.Top + lbFontNames.ItemHeight - 1;
  TextR.Left := Rect.Left + 14{ColorWidth} + 4;
  TextR.Top := Rect.Top + 1;
  TextR.Right := Rect.Right;
  TextR.Bottom := Rect.Bottom - 1;
  with lbFontNames.Canvas do
  begin
    FillRect(Rect);	{ clear the rectangle }
    PaintBox1.Canvas.Font.Name := lbFontNames.Items[Index];
    GetTextMetrics(PaintBox1.Canvas.Handle, FontInfo);
    if ((FontInfo.tmPitchAndFamily and $0F) and TMPF_TRUETYPE) = TMPF_TRUETYPE then
    begin
      g := TBitmap.Create;
      g.Assign(imgTrueType.Picture.Bitmap);
      Draw(ColorR.Left, ColorR.Top, g);
      g.Free;
    end
    else if ((FontInfo.tmPitchAndFamily and $0F) and TMPF_VECTOR) = TMPF_VECTOR then
    begin
      g := TBitmap.Create;
      g.Assign(imgType1.Picture.Bitmap);
      Draw(ColorR.Left, ColorR.Top, g);
      g.Free;
    end;
    DrawText(Handle, PChar(lbFontNames.Items[Index]), -1, TextR, DT_VCENTER or DT_SINGLELINE);
  end;
end;
{------------------------------------------------------------------------------}
{ editStyleChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.editStyleChange(Sender: TObject);
var
  i : integer;
begin
  i := lbStyles.Items.IndexOf(editStyle.Text);
  if i > -1 then
  begin
    lbStyles.ItemIndex := i;
    editStyle.Text := lbStyles.Items[lbStyles.ItemIndex];
    if editStyle.Text = 'Regular' then
      pnlSample.Font.Style := [];
    if editStyle.Text = 'Italic' then
      pnlSample.Font.Style := [fsItalic];
    if editStyle.Text = 'Bold' then
      pnlSample.Font.Style := [fsBold];
    if editStyle.Text = 'Bold Italic' then
      pnlSample.Font.Style := [fsBold, fsItalic];
  end;
end;
{------------------------------------------------------------------------------}
{ lbStylesClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.lbStylesClick(Sender: TObject);
begin
  editStyle.OnChange := nil;
  editStyle.Text := lbStyles.Items[lbStyles.ItemIndex];
  editStyle.OnChange := editStyleChange;
  if editStyle.Text = 'Regular' then
    pnlSample.Font.Style := [];
  if editStyle.Text = 'Italic' then
    pnlSample.Font.Style := [fsItalic];
  if editStyle.Text = 'Bold' then
    pnlSample.Font.Style := [fsBold];
  if editStyle.Text = 'Bold Italic' then
    pnlSample.Font.Style := [fsBold, fsItalic];
end;
{------------------------------------------------------------------------------}
{ editStyleExit                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.editStyleExit(Sender: TObject);
var
  i : integer;
begin
  i := lbStyles.Items.IndexOf(editStyle.Text);
  if i = -1 then
  begin
    if lbStyles.ItemIndex < 0 then lbStyles.ItemIndex := 0;
    lbStylesClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ editSizeChange                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.editSizeChange(Sender: TObject);
var
  i : integer;
begin
  i := lbSizes.Items.IndexOf(editSize.Text);
  if i > -1 then
  begin
    lbSizes.ItemIndex := i;
    pnlSample.Font.Size := i;
  end
  else
  begin
    if IsNumeric(editSize.Text) then
    begin
      i := StrToInt(editSize.Text);
      editActualSize.Text := editSize.Text;
      pnlSample.Font.Size := i;
    end;
  end;
end;
{------------------------------------------------------------------------------}
{ lbSizesClick                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.lbSizesClick(Sender: TObject);
begin
  editSize.OnChange := nil;
  editSize.Text := lbSizes.Items[lbSizes.ItemIndex];
  editSize.OnChange := editSizeChange;
  pnlSample.Font.Size := StrToInt(lbSizes.Items[lbSizes.ItemIndex]);
  editActualSize.Text := lbSizes.Items[lbSizes.ItemIndex];
end;
{------------------------------------------------------------------------------}
{ editSizeExit                                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.editSizeExit(Sender: TObject);
var
  i : integer;
begin
  i := lbSizes.Items.IndexOf(editSize.Text);
  if i = -1 then
  begin
    if lbSizes.ItemIndex < 0 then lbSizes.ItemIndex := 0;
    lbSizesClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ editActualSizeChange                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.editActualSizeChange(Sender: TObject);
var
  i : integer;
  d : double;
begin
  if IsFloating(editActualSize.Text) then
  begin
    d := CrStrToFloating(editActualSize.Text);
    i := Round(d);
    editSize.Text := IntToStr(i);
    {Attempt to show the difference but it doesn't really work
     since Pixels and Points are very similar measurements...however
     the fraction will be converted to Twips when sent to the Print
     Engine, which is more accurate}
    i := Round(d * 100);
    i := (i * pnlSample.Font.PixelsPerInch);
    i := i div 72;
    i := i div 100;
    pnlSample.Font.Height := -i;
  end;
end;
{------------------------------------------------------------------------------}
{ cbStrikeoutClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.cbStrikeoutClick(Sender: TObject);
begin
  if cbStrikeout.Checked then
    pnlSample.Font.Style := pnlSample.Font.Style + [fsStrikeOut]
  else
    pnlSample.Font.Style := pnlSample.Font.Style - [fsStrikeOut];
end;
{------------------------------------------------------------------------------}
{ cbUnderlineClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.cbUnderlineClick(Sender: TObject);
begin
  if cbUnderline.Checked then
    pnlSample.Font.Style := pnlSample.Font.Style + [fsUnderline]
  else
    pnlSample.Font.Style := pnlSample.Font.Style - [fsUnderline];
end;
{------------------------------------------------------------------------------}
{ btnOkClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.btnOkClick(Sender: TObject);
begin
  editFontNameExit(Self);
  editStyleExit(Self);
  Crf.Name := editFontName.Text;
  if editStyle.Text = 'Regular' then
    Crf.Style := [];
  if editStyle.Text = 'Bold' then
    Crf.Style := [fsBold];
  if editStyle.Text = 'Italic' then
    Crf.Style := [fsItalic];
  if editStyle.Text = 'Bold Italic' then
    Crf.Style := [fsBold, fsItalic];
  if IsNumeric(editSize.Text) then
    Crf.Size := StrToInt(editSize.Text);
  if IsFloating(editActualSize.Text) then
    Crf.ActualSize := CrStrToFloating(editActualSize.Text);
  if cbStrikeout.Checked then
    Crf.Style := (Crf.Style + [fsStrikeOut])
  else
    Crf.Style := (Crf.Style - [fsStrikeOut]);
  if cbUnderline.Checked then
    Crf.Style := (Crf.Style + [fsUnderline])
  else
    Crf.Style := (Crf.Style - [fsUnderline]);
  Crf.Color := cbColor.Selected;
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.btnCancelClick(Sender: TObject);
begin
  //
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeFontDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  bFont := False;
  Release;
end;



end.
