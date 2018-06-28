unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UCRXI_ExportWrapper, UCrpe32, StdCtrls;

type
  TfrmMain = class(TForm)
    btnExcelDataOnly: TButton;
    btnExcel: TButton;
    btnEditableRTF: TButton;
    rdoApplication: TRadioButton;
    rdoDiskFile: TRadioButton;
    Label1: TLabel;
    edFileName: TEdit;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcelDataOnlyClick(Sender: TObject);
    procedure btnEditableRTFClick(Sender: TObject);
    procedure btnExcelClick(Sender: TObject);
  private
    Crpe1: TCrpe;
    AppPath : String;
    ExportWrapper : TXIExportWrapper;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Crpe1 := TCrpe.Create(Self);
  AppPath := ExtractFilePath(Forms.Application.ExeName);
  Crpe1.ReportName := AppPath + 'MultiPageGroup.rpt';
  Crpe1.OpenJob;
  ExportWrapper := TXIExportWrapper.Create();
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  Crpe1.Free;
  Crpe1 := nil;
  ExportWrapper.Destroy;
  ExportWrapper := nil;
end;

procedure TfrmMain.btnExcelDataOnlyClick(Sender: TObject);
var
  diskFileName, areaName : String;
begin
  areaName := 'PH';
  if rdoApplication.Checked then begin
     if ExportWrapper.ExportExcelDataOnlyToApplication(
           Crpe1.JobNumber, PChar(AppPath + 'MultiPageGroup.xls' + #0 + #0),
           True, 1440*2, PChar(areaName), False, True, True, False, True,
           True, True) = true then begin
        Crpe1.CrpeEngine.PEStartPrintJob(Crpe1.JobNumber, true);
     end else
       ShowMessage(IntToStr(Crpe1.CrpeEngine.PEGetErrorCode(Crpe1.JobNumber)));
  end
  else if rdoDiskFile.Checked then begin
     diskFileName := edFileName.Text;
     if ExportWrapper.ExportExcelDataOnlyToDisk(
           Crpe1.JobNumber, PChar(diskFileName),
           True, 1440*2, PChar(areaName), False, True, True, False, True,
           True, True) = true then begin
        Crpe1.CrpeEngine.PEStartPrintJob(Crpe1.JobNumber, true);
     end else
       ShowMessage(IntToStr(Crpe1.CrpeEngine.PEGetErrorCode(Crpe1.JobNumber)));
  end
  else begin
     //unreachable
     ShowMessage('not yet implmented');
  end;
end;

procedure TfrmMain.btnEditableRTFClick(Sender: TObject);
var
  diskFileName : WideString;
begin
  if rdoApplication.Checked then begin
     if ExportWrapper.ExportEditableRTFToApplication(Crpe1.JobNumber,
           PChar(AppPath + 'MultiPageGroup.rtf' + #0 + #0), 1, 1, true) = true then begin
        Crpe1.CrpeEngine.PEStartPrintJob(Crpe1.JobNumber, true);
     end else
       ShowMessage(IntToStr(Crpe1.CrpeEngine.PEGetErrorCode(Crpe1.JobNumber)));
  end
  else if rdoDiskFile.Checked then begin
     diskFileName := edFileName.Text;
     if ExportWrapper.ExportEditableRTFToDisk(Crpe1.JobNumber,
           PChar(edFilename.Text), 1, 1, true) = true then begin
        Crpe1.CrpeEngine.PEStartPrintJob(Crpe1.JobNumber, true);
     end else
       ShowMessage(IntToStr(Crpe1.CrpeEngine.PEGetErrorCode(Crpe1.JobNumber)));
  end
  else begin
     //unreachable
     ShowMessage('not yet implmented');
  end;
end;

procedure TfrmMain.btnExcelClick(Sender: TObject);
var
  diskFileName, areaName : String;
begin
  areaName := 'PH';
  if rdoApplication.Checked then begin
     if ExportWrapper.ExportExcelToApplication(
           Crpe1.JobNumber, PChar(AppPath + 'MultiPageGroup.xls' + #0 + #0),
           True, 1440*2, PChar(areaName), true, true, true, 1, 1, 1)= true then begin
        Crpe1.CrpeEngine.PEStartPrintJob(Crpe1.JobNumber, true);
     end else
       ShowMessage(IntToStr(Crpe1.CrpeEngine.PEGetErrorCode(Crpe1.JobNumber)));
  end
  else if rdoDiskFile.Checked then begin
     diskFileName := edFileName.Text;
     if ExportWrapper.ExportExcelToDisk(
           Crpe1.JobNumber, PChar(diskFileName),
           True, 1440*2, PChar(areaName), True, True, True, 1,1,1) = true then begin
        Crpe1.CrpeEngine.PEStartPrintJob(Crpe1.JobNumber, true);
     end else
       ShowMessage(IntToStr(Crpe1.CrpeEngine.PEGetErrorCode(Crpe1.JobNumber)));
  end
  else begin
     //unreachable
     ShowMessage('not yet implmented');
  end;
end;

end.
