unit UDExportExcel;

interface

uses
  SysUtils, Windows, Controls, Forms, Buttons, StdCtrls,
  Classes, ExtCtrls, UCrpe32;

type
  TCrpeExcelDlg = class(TForm)
    panel1: TPanel;
    gbColumnWidth: TGroupBox;
    rbByConstant: TRadioButton;
    rbByArea: TRadioButton;
    editConstant: TEdit;
    cbArea: TComboBox;
    btnOk: TButton;
    btnCancel: TButton;
    cbWorksheetFunctions: TCheckBox;
    cbXLSType: TComboBox;
    lblXLSType: TLabel;
    cbCreatePageBreaks: TCheckBox;
    cbConvertDatesToStrings: TCheckBox;
    cbChopPageHeader: TCheckBox;
    cbExportHeaderFooter: TCheckBox;
    gbPageRange: TGroupBox;
    lblLastPage: TLabel;
    rbAllPages: TRadioButton;
    rbFirstPage: TRadioButton;
    editFirstPage: TEdit;
    editLastPage: TEdit;
    lblConstantNote: TLabel;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure rbByConstantClick(Sender: TObject);
    procedure rbByAreaClick(Sender: TObject);
    procedure editConstantKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbXLSTypeChange(Sender: TObject);
    procedure rbAllPagesClick(Sender: TObject);
    procedure rbFirstPageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeExcelDlg: TCrpeExcelDlg;

implementation

{$R *.DFM}

uses Graphics, TypInfo, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.FormCreate(Sender: TObject);
begin
  LoadFormPos(Self);
end;
{------------------------------------------------------------------------------}
{ FormShow                                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.FormShow(Sender: TObject);
var
  i  : integer;
  s  : string;
begin
  {XlsType}
  cbXLSType.Clear;
  for i := 0 to Ord(High(TCrExportExcelType)) do
    cbXLSType.Items.Add(GetEnumName(TypeInfo(TCrExportExcelType), i));
  cbXLSType.ItemIndex := Ord(Cr.ExportOptions.Excel.XLSType);
  {WorksheetFunctions}
  cbWorksheetFunctions.Checked := Cr.ExportOptions.Excel.WorksheetFunctions;
  {ColumnWidth}
  case Cr.ExportOptions.Excel.ColumnWidth of
    ByConstant : rbByConstant.Checked := True;
    ByArea     : rbByArea.Checked := True;
  end;
  {Area}
  cbArea.Clear;
  if cbArea.Items.Count = 0 then
  begin
    cbArea.Items.Add('Whole Report');
    for i := 0 to (Cr.AreaFormat.Count - 1) do
      cbArea.Items.Add(Cr.AreaFormat[i].Area);
  end;
  i := cbArea.Items.IndexOf(Cr.ExportOptions.Excel.Area);
  if i = -1 then
    cbArea.ItemIndex := 0;
  if cbArea.Items.Count = 0 then
    cbArea.Text := Cr.ExportOptions.Excel.Area;
  {Constant}
  Str(Cr.ExportOptions.Excel.Constant:0:8, s);
  editConstant.Text := s;
  {Booleans}
  cbExportHeaderFooter.Checked := Cr.ExportOptions.Excel.ExportHeaderFooter;
  cbCreatePageBreaks.Checked := Cr.ExportOptions.Excel.CreatePageBreaks;
  cbConvertDatesToStrings.Checked := Cr.ExportOptions.Excel.ConvertDatesToStrings;
  cbChopPageHeader.Checked := Cr.ExportOptions.Excel.ChopPageHeader;
  {Page Range}
  editFirstPage.Text := IntToStr(Cr.ExportOptions.Excel.FirstPage);
  editLastPage.Text := IntToStr(Cr.ExportOptions.Excel.LastPage);
  if Cr.ExportOptions.Excel.UsePageRange then
  begin
    rbFirstPage.Checked := True;
    rbFirstPageClick(Self);
  end
  else
  begin
    rbAllPages.Checked := True;
    rbAllPagesClick(Self);
  end;
end;
{------------------------------------------------------------------------------}
{ cbXLSTypeChange                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.cbXLSTypeChange(Sender: TObject);
var
  OnOff : Boolean;
begin
  OnOff := (Pos('Data', cbXLSType.Text) > 0);
  cbWorksheetFunctions.Enabled := OnOff;
  cbChopPageHeader.Enabled := OnOff;
end;
{------------------------------------------------------------------------------}
{ rbByConstantClick                                                            }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.rbByConstantClick(Sender: TObject);
begin
  editConstant.Enabled := True;
  editConstant.Color := clWindow;
  cbArea.Enabled := False;
  cbArea.Color := clInactiveCaptionText;
end;
{------------------------------------------------------------------------------}
{ rbByAreaClick                                                                }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.rbByAreaClick(Sender: TObject);
begin
  editConstant.Enabled := False;
  editConstant.Color := clInactiveCaptionText;
  cbArea.Enabled := True;
  cbArea.Color := clWindow;
end;
{------------------------------------------------------------------------------}
{ editConstantKeyPress                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.editConstantKeyPress(Sender: TObject;
  var Key: Char);
begin
  {Allow periods or commas}
  if Ord(Key) = 44 then Exit;
  if Ord(Key) = 46 then Exit;
  {Do not allow letters or extended ascii}
  if Ord(Key) in [33..47] then Key := Char(0);
  if Ord(Key) in [58..255] then Key := Char(0);
end;
{------------------------------------------------------------------------------}
{ rbAllPagesClick                                                              }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.rbAllPagesClick(Sender: TObject);
begin
  editFirstPage.Enabled := False;
  editLastPage.Enabled := False;
  editFirstPage.Color := ColorState(False);
  editLastPage.Color := ColorState(False);
end;
{------------------------------------------------------------------------------}
{ rbFirstPageClick                                                             }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.rbFirstPageClick(Sender: TObject);
begin
  editFirstPage.Enabled := True;
  editLastPage.Enabled := True;
  editFirstPage.Color := ColorState(True);
  editLastPage.Color := ColorState(True);
end;
{------------------------------------------------------------------------------}
{ btnOKClick                                                                   }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.btnOKClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Cr.ExportOptions.Excel.XLSType := TCrExportExcelType(cbXLSType.ItemIndex);
  Cr.ExportOptions.Excel.WorksheetFunctions := cbWorksheetFunctions.Checked;
  {ColumnWidth}
  if rbByConstant.Checked then
    Cr.ExportOptions.Excel.ColumnWidth := ByConstant
  else
    Cr.ExportOptions.Excel.ColumnWidth := ByArea;
  {Constant}
  if Length(editConstant.Text) > 0 then
    Cr.ExportOptions.Excel.Constant := StrToFloat(editConstant.Text);
  {Area}
  Cr.ExportOptions.Excel.Area := cbArea.Text;
  {Booleans}
  Cr.ExportOptions.Excel.ExportHeaderFooter := cbExportHeaderFooter.Checked;
  Cr.ExportOptions.Excel.CreatePageBreaks := cbCreatePageBreaks.Checked;
  Cr.ExportOptions.Excel.ConvertDatesToStrings := cbConvertDatesToStrings.Checked;
  Cr.ExportOptions.Excel.ChopPageHeader := cbChopPageHeader.Checked;
  {Page Range}
  Cr.ExportOptions.Excel.FirstPage := CrStrToInteger(editFirstPage.Text);
  Cr.ExportOptions.Excel.LastPage := CrStrToInteger(editLastPage.Text);
  Cr.ExportOptions.Excel.UsePageRange := (rbFirstPage.Checked);
end;
{------------------------------------------------------------------------------}
{ btnCancelClick                                                               }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.btnCancelClick(Sender: TObject);
begin
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose                                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeExcelDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
