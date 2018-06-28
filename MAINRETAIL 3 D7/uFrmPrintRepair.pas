unit uFrmPrintRepair;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, StdCtrls, ppDB, ppDBPipe, DB,
  ADODB, ppEndUsr, ppParameter, ppModule, raCodMod, ppBands, ppCache,
  ppClass, ppComm, ppRelatv, ppProd, ppReport, ppCtrls, ppPrnabl;

type
  TFrmPrintRepair = class(TFrmParentPrint)
    btnClose: TButton;
    ppReport: TppReport;
    ppDesigner: TppDesigner;
    quRepair: TADOQuery;
    dsRepair: TDataSource;
    ppRepair: TppDBPipeline;
    ppHeaderBand1: TppHeaderBand;
    lblTitle: TppLabel;
    ppDBText: TppDBText;
    lblStore: TppLabel;
    lblAddress: TppLabel;
    ppDBText1: TppDBText;
    lblCity: TppLabel;
    ppDBText2: TppDBText;
    lblZip: TppLabel;
    ppDBText3: TppDBText;
    lblPhone: TppLabel;
    ppDBText4: TppDBText;
    lblFax: TppLabel;
    ppDBText5: TppDBText;
    lblEmail: TppLabel;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    lblModel: TppLabel;
    lblDescription: TppLabel;
    lblQty: TppLabel;
    lblCost: TppLabel;
    lblTotal: TppLabel;
    lblDefect: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand3: TppSummaryBand;
    ppParameterList1: TppParameterList;
    IDLanguage: TppParameter;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    quRepairIDRepair: TIntegerField;
    quRepairFase: TStringField;
    quRepairSentDate: TDateTimeField;
    quRepairTipoRepair: TIntegerField;
    quRepairQty: TBCDField;
    quRepairLastCost: TBCDField;
    quRepairTotal: TBCDField;
    quRepairSerialNumber: TStringField;
    quRepairDefect: TStringField;
    quRepairReturnDate: TDateTimeField;
    quRepairModel: TStringField;
    quRepairDescription: TStringField;
    quRepairVendor: TStringField;
    quRepairStore: TStringField;
    quRepairAddress: TStringField;
    quRepairCity: TStringField;
    quRepairZip: TStringField;
    quRepairTelephone: TStringField;
    quRepairFax: TStringField;
    quRepairContato: TStringField;
    quRepairEmail: TStringField;
    quRepairDefectType: TStringField;
    ppDBText13: TppDBText;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppDBCalc: TppDBCalc;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    quRepairIDFornecedor: TIntegerField;
    raCodeModule1: TraCodeModule;
    quRepairLogoEmpresa: TBlobField;
    ppLogoImage: TppImage;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FIDRepairs: String;

    procedure OpenRepair;
    procedure CloseRepair;

    procedure LoadLogoImage;
    function PrintReport: Boolean;
  public
    function Start(AIDRepairs: String): Boolean;
    function DesignReport: Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, uSQLFunctions, JPEG;

{$R *.dfm}

procedure TFrmPrintRepair.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPrintRepair.CloseRepair;
begin
  with quRepair do
    if Active then
      Close;
end;

function TFrmPrintRepair.DesignReport: Boolean;
begin
  Result := True;
  try
    ppDesigner.ShowModal;
  except
    Result := False;
  end;
end;

procedure TFrmPrintRepair.OpenRepair;
begin

  with quRepair do
    if not Active then
    begin
      SQL.Text := ChangeWhereClause(SQL.Text, 'R.IDRepair in (' + FIDRepairs + ')', True);
      Open;
    end;
    
end;

function TFrmPrintRepair.PrintReport: Boolean;
begin
  IDLanguage.AsInteger := DMGlobal.IDLanguage;

  ppReport.PrinterSetup.Copies := DM.fPrintReceipt.RepairReportNumCopy;

  if DM.fPrintReceipt.RepairReportPath <> '[SYSTEM]' then
    if FileExists(DM.fPrintReceipt.RepairReportPath) then
    begin
      ppReport.Template.FileName := DM.fPrintReceipt.RepairReportPath;
      ppReport.Template.LoadFromFile;
    end;

  if DM.fPrintReceipt.RepairReportPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := DM.fPrintReceipt.RepairReportPrinter;

  if DM.fPrintReceipt.RepairReportPreview then
    ppReport.DeviceType := 'Screen'
  else
    ppReport.DeviceType := 'Printer';

  try
    //LoadLogoImage;
    ppReport.Print;
    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPrintRepair.Start(AIDRepairs: String): Boolean;
begin
  FIDRepairs := AIDRepairs;

  OpenRepair;
  PrintReport;

  Self.Close;
end;

procedure TFrmPrintRepair.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseRepair;
  Action := caFree;
end;

procedure TFrmPrintRepair.LoadLogoImage;
var
  msLogo: TMemoryStream;
  img: TJPEGImage;
begin
  if Assigned(ppLogoImage) then
  begin
    msLogo := TMemoryStream.Create;
    try
      if not quRepairLogoEmpresa.IsNull then
      begin
        quRepairLogoEmpresa.SaveToStream(msLogo);
        msLogo.Seek(0, soFromBeginning);
        img := TJPEGImage.Create;
        try
          img.LoadFromStream(msLogo);
          ppLogoImage.Picture.Bitmap.Assign(img);
        finally
          FreeAndNil(img);
        end;
      end
      else
        ppLogoImage.Picture.CleanupInstance;
    finally
      msLogo.Free;
    end;
  end;
end;

end.
