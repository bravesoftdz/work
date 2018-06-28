unit uFrmPrintTranfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, StdCtrls, DB, ADODB, ppDB,
  ppDBPipe, ppParameter, ppBands, ppMemo, ppClass, ppModule, raCodMod,
  ppCtrls, ppReport, ppPrnabl, ppStrtch, ppSubRpt, ppCache, ppRelatv,
  ppProd, ppComm, ppEndUsr;

type
  TFrmPrintTransfer = class(TFrmParentPrint)
    ppDesigner: TppDesigner;
    ppReport: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand3: TppSummaryBand;
    raCodeModule1: TraCodeModule;
    ppParameterList1: TppParameterList;
    IDLanguage: TppParameter;
    ppTransfer: TppDBPipeline;
    dsTransfer: TDataSource;
    quTransfer: TADOQuery;
    btnClose: TButton;
    quTransferIDModelTransf: TIntegerField;
    quTransferIDLojaOrigem: TIntegerField;
    quTransferIDLojaDestino: TIntegerField;
    quTransferData: TDateTimeField;
    quTransferNumber: TStringField;
    quTransferTransferType: TBooleanField;
    quTransferIDUser: TIntegerField;
    quTransferItems: TADOQuery;
    dsTransferItems: TDataSource;
    ppTransferItems: TppDBPipeline;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    quTransferSystemUser: TStringField;
    quTransferStoreOrigem: TStringField;
    quTransferStoreDestino: TStringField;
    quTransferStoreOrigPhone: TStringField;
    quTransferStoreDestPhone: TStringField;
    quTransferStoreOrigFax: TStringField;
    quTransferStoreDestFax: TStringField;
    quTransferStoreOrigContact: TStringField;
    quTransferStoreDestContact: TStringField;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand2: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel8: TppLabel;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppLabel7: TppLabel;
    ppDBText8: TppDBText;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    raCodeModule2: TraCodeModule;
    ppLabel9: TppLabel;
    quTransferItemsIDModel: TIntegerField;
    quTransferItemsModel: TStringField;
    quTransferItemsDescription: TStringField;
    quTransferItemsIDModelTransfDet: TIntegerField;
    quTransferItemsIDModelTransf: TIntegerField;
    quTransferItemsCostPrice: TBCDField;
    ppDBText9: TppDBText;
    ppDBCalc3: TppDBCalc;
    ppLabel10: TppLabel;
    ppDBText10: TppDBText;
    ppLabel11: TppLabel;
    quTransferItemsQtyTransfer: TFloatField;
    quTransferItemsTax: TBCDField;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLine1: TppLine;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    quTransferItemsFabricante: TStringField;
    quTransferItemsSellingPrice: TBCDField;
    quTransferStoreDestAddress: TStringField;
    quTransferStoreOrigAddress: TStringField;
    quTransferStoreDestCity: TStringField;
    quTransferStoreOrigCity: TStringField;
    quTransferStoreDestZip: TStringField;
    quTransferStoreOrigZip: TStringField;
    quTransferStoreDestState: TStringField;
    quTransferStoreOrigState: TStringField;
    quTransferCompanyDestCNPJ: TStringField;
    quTransferCompanyOrigCNPJ: TStringField;
    quTransferCompanyDestNeighboor: TStringField;
    quTransferCompanyOrigNeighboor: TStringField;
    quTransferCompanyDestInscEstadual: TStringField;
    quTransferCompanyOrigInscEstadual: TStringField;
    quTransferCFOPNum: TStringField;
    quTransferCFOP: TStringField;
    quTransferCompanyDestLegalName: TStringField;
    quTransferCompanyOrigLegalName: TStringField;
    quTransferCompanyDestName: TStringField;
    quTransferCompanyOrigName: TStringField;
    quTransferOBS: TStringField;
    quTransferItemsTaxCode: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
  private
    fIDTransfers : String;
    procedure OpenTransfer;
    procedure CloseTransfer;
    procedure OpenItem;
    procedure CloseItem;
    function PrintReport : Boolean;
  public
    function Start(IDTransfers:String):Boolean;
    function DesignReport:Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, uSQLFunctions;

{$R *.dfm}

function TFrmPrintTransfer.DesignReport: Boolean;
begin
  Result := True;
  try
     ppDesigner.ShowModal;
  except
     Result := False;
     end;
end;

procedure TFrmPrintTransfer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseTransfer;
  CloseItem;
  Action := caFree;
end;

function TFrmPrintTransfer.Start(IDTransfers: String): Boolean;
begin
  fIDTransfers := IDTransfers;

  OpenTransfer;
  OpenItem;

  Result := PrintReport;

  Self.Close;
  
end;

procedure TFrmPrintTransfer.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPrintTransfer.CloseTransfer;
begin
  with quTransfer do
    if Active then
       Close;
end;

procedure TFrmPrintTransfer.OpenTransfer;
begin
  with quTransfer do
    if not Active then
       begin
       SQL.Text := ChangeWhereClause(SQL.Text, 'MT.IDModelTransf in ('+fIDTransfers+')', True);
       Open;
       end;
end;

procedure TFrmPrintTransfer.CloseItem;
begin
  with quTransfer do
    if Active then
       Close;
end;

procedure TFrmPrintTransfer.OpenItem;
begin
  with quTransfer do
    if not Active then
       Open;
end;

function TFrmPrintTransfer.PrintReport: Boolean;
begin
  IDLanguage.AsInteger := DMGlobal.IDLanguage;

  ppReport.PrinterSetup.Copies := DM.fPrintReceipt.TransferReportNumCopy;

  if DM.fPrintReceipt.TransferReportPath <> '[SYSTEM]' then
    if FileExists(DM.fPrintReceipt.TransferReportPath) then
    begin
      ppReport.Template.FileName := DM.fPrintReceipt.TransferReportPath;
      ppReport.Template.LoadFromFile;
    end;

  if DM.fPrintReceipt.TransferReportPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := DM.fPrintReceipt.TransferReportPrinter;

  if DM.fPrintReceipt.TransferReportPreview then
    ppReport.DeviceType := 'Screen'
  else
    ppReport.DeviceType := 'Printer';

  try
    ppReport.Print;
    Result := True;
  except
    Result := False;
  end;
end;

end.
