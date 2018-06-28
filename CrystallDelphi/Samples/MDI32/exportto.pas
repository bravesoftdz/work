unit Exportto;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Buttons, UCRPE32, UCrpeClasses;

type
  TExportForm = class(TForm)
    RGExportType: TRadioGroup;
    ChkProgressDialog: TCheckBox;
    Crpe1: TCrpe;
    BtnOK: TBitBtn;
    BtnCancel: TBitBtn;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    procedure ChkProgressDialogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExportForm: TExportForm;

implementation

{$R *.DFM}

uses Main;

procedure TExportForm.ChkProgressDialogClick(Sender: TObject);
begin
   If ChkProgressDialog.Checked then
      Crpe1.ProgressDialog := False
   else
      Crpe1.ProgressDialog := True;
end;

procedure TExportForm.FormCreate(Sender: TObject);
begin
   Screen.Cursor := crHourGlass;
   MainForm.File1.Enabled := False;
   MainForm.SpeedPanel.Enabled := False;
   if OpenDialog.Execute then
   begin
     Refresh;
     {Get the name of the report from Open Dialog on the Main form}
     Crpe1.ReportName := OpenDialog.Filename;
     Crpe1.Output := toExport;
   end;
   Screen.Cursor := crDefault;
   MainForm.File1.Enabled := True;
   MainForm.SpeedPanel.Enabled := True;
end;

procedure TExportForm.BtnOKClick(Sender: TObject);
begin
   Crpe1.ExportOptions.Destination := toFile;
   case RGExportType.ItemIndex of
     0 : begin
           Crpe1.ExportOptions.FileType := CrystalReportRPT;
           SaveDialog.DefaultExt := 'RPT';
           SaveDialog.Filter := 'Crystal Reports (*.rpt)|*.RPT';
         end;
     1 : begin
           Crpe1.ExportOptions.FileType := MSExcel;
           SaveDialog.DefaultExt := 'XLS';
           SaveDialog.Filter := 'MS Excel 97 Document (*.xls)|*.XLS';
         end;
     2 : begin
           Crpe1.ExportOptions.FileType := HTML40;
           SaveDialog.DefaultExt := 'HTM';
           SaveDialog.Filter := 'DHTML 4.0 Standard (*.htm)|*.HTM';
         end;
     {3 : begin
           //Removed from CR 9 Export format types
           Crpe1.ExportOptions.FileType := LotusWK3;
           SaveDialog.DefaultExt := 'WK3';
           SaveDialog.Filter := 'Lotus 3.0 (*.wk3)|*.WK3';
         end;}
     3 : begin
           Crpe1.ExportOptions.FileType := RichText;
           SaveDialog.DefaultExt := 'Rtf';
           SaveDialog.Filter := 'Rich Text Format (*.rtf)|*.RTF';
         end;
     4 : begin
           Crpe1.ExportOptions.FileType := MSWord;
           SaveDialog.DefaultExt := 'doc';
           SaveDialog.Filter := 'MS Word Document (*.doc)|*.DOC';
         end;
     5 : begin
           Crpe1.ExportOptions.FileType := TextFormat;
           SaveDialog.DefaultExt := 'txt';
           SaveDialog.Filter := 'Ascii Text (*.txt)|*.TXT';
         end;
     6 : begin
           Crpe1.ExportOptions.FileType := AdobeAcrobatPDF;
           SaveDialog.DefaultExt := 'pdf';
           SaveDialog.Filter := 'Adobe Acrobat (*.pdf))|*.PDF';
         end;
   end;
   if RGExportType.ItemIndex = -1 then
      MessageDlg('An Export Type MUST be chosen!', mtWarning, [mbOK], 0)
   else
   begin
     if SaveDialog.Execute then
     begin
       Refresh;
       BtnOK.Enabled := False;
       BtnCancel.Enabled := False;
       Screen.Cursor := crHourGlass;
       Crpe1.ExportOptions.FileName := SaveDialog.Filename;
       DeleteFile(PChar(SaveDialog.Filename));
       Crpe1.Execute;
       while not Crpe1.PrintEnded do
          Application.ProcessMessages;
       BtnOK.Enabled := True;
       BtnCancel.Enabled := True;
       Screen.Cursor := crDefault;
       Close;
     end;
   end;
end;

procedure TExportForm.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TExportForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

end.
