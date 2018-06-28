unit uFrmServiceOrderPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, PsRBExport_Main, PsRBExport_PDF,
  ppParameter, ppCtrls, ppBands, ppModule, raCodMod, ppClass, myChkBox,
  ppReport, ppPrnabl, ppStrtch, ppSubRpt, ppCache, ppRelatv, ppProd,
  ppComm, ppEndUsr, ppDB, ppDBPipe, DB, ADODB, ppMemo, ppRegion;

type
  TFrmServiceOrderPrint = class(TFrmParentPrint)
    ppDesigner: TppDesigner;
    ppReport: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand3: TppSummaryBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppLabel10: TppLabel;
    ppDBText10: TppDBText;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    raCodeModule1: TraCodeModule;
    ppParameterList1: TppParameterList;
    IDLanguage: TppParameter;
    ppExportPDF: TPsRBExportPDF;
    quSO: TADOQuery;
    dsSO: TDataSource;
    ppSO: TppDBPipeline;
    ppLabel5: TppLabel;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText16: TppDBText;
    quSOIDServiceOrder: TIntegerField;
    quSOSONumber: TStringField;
    quSOSODate: TDateTimeField;
    quSOSOCloseDate: TDateTimeField;
    quSOCustomer: TStringField;
    quSOCustomerAreaPhone: TStringField;
    quSOCustomerPhone: TStringField;
    quSOCustomerAreaCel: TStringField;
    quSOCustomerCel: TStringField;
    quSOCustomerEmail: TStringField;
    quSOCustomerAddress: TStringField;
    quSOCustomerCity: TStringField;
    quSOCustomerZip: TStringField;
    quSOCustomerState: TStringField;
    quSOSOStatus: TStringField;
    quSOColor: TStringField;
    quSOStore: TStringField;
    quSOStoreAddress: TStringField;
    quSOStoreCity: TStringField;
    quSOStoreZip: TStringField;
    quSOStoreEmail: TStringField;
    quSOStoreWebPage: TStringField;
    quSOStorePhone: TStringField;
    quSOStoreFax: TStringField;
    ppDBText17: TppDBText;
    quSOItem: TADOQuery;
    dsSOItem: TDataSource;
    ppSOItem: TppDBPipeline;
    quSOItemIDSOItem: TIntegerField;
    quSOItemIDSOCustomerProduct: TIntegerField;
    quSOItemSerialNumber: TStringField;
    quSOItemIniDate: TDateTimeField;
    quSOItemEndDate: TDateTimeField;
    quSOItemOBS: TStringField;
    quSOItemModel: TStringField;
    quSOItemDescription: TStringField;
    quSOItemManufacture: TStringField;
    quSOItemSubTotal: TBCDField;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppDetailBand2: TppDetailBand;
    ppSummaryBand1: TppSummaryBand;
    ppLabel7: TppLabel;
    ppDBText18: TppDBText;
    ppLabel8: TppLabel;
    ppDBText20: TppDBText;
    ppLabel9: TppLabel;
    ppDBText21: TppDBText;
    ppLabel11: TppLabel;
    ppDBText22: TppDBText;
    ppLabel12: TppLabel;
    ppDBText23: TppDBText;
    ppLabel13: TppLabel;
    ppDBMemo1: TppDBMemo;
    raCodeModule2: TraCodeModule;
    quSOItemModelDesc: TStringField;
    quDefect: TADOQuery;
    dsDefect: TDataSource;
    ppDefect: TppDBPipeline;
    quDefectType: TIntegerField;
    quDefectIDSOItemDefect: TIntegerField;
    quDefectDefectType: TStringField;
    ppRegion1: TppRegion;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppTitleBand2: TppTitleBand;
    ppDetailBand3: TppDetailBand;
    ppSummaryBand2: TppSummaryBand;
    ppLabel14: TppLabel;
    ppDBText19: TppDBText;
    ppLabel15: TppLabel;
    raCodeModule3: TraCodeModule;
    quProdutcs: TADOQuery;
    dsProducts: TDataSource;
    ppProducts: TppDBPipeline;
    quProdutcsIDSOItemProduct: TIntegerField;
    quProdutcsSalePrice: TBCDField;
    quProdutcsQty: TBCDField;
    quProdutcsSubTotal: TBCDField;
    quProdutcsModelType: TStringField;
    quProdutcsModel: TStringField;
    quProdutcsDescription: TStringField;
    quProdutcsMovDate: TDateTimeField;
    ppSubReport3: TppSubReport;
    ppChildReport3: TppChildReport;
    ppTitleBand3: TppTitleBand;
    ppDetailBand4: TppDetailBand;
    ppSummaryBand4: TppSummaryBand;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBCalc1: TppDBCalc;
    quSOSalePrice: TBCDField;
    ppFooterBand1: TppFooterBand;
    ppLine1: TppLine;
    ppDBText30: TppDBText;
    ppLabel22: TppLabel;
    raCodeModule4: TraCodeModule;
    ppLabel23: TppLabel;
    quSOOBS: TStringField;
    ppLabel24: TppLabel;
    ppDBMemo2: TppDBMemo;
    quPayments: TADOQuery;
    dsPayments: TDataSource;
    ppSOPayments: TppDBPipeline;
    quPaymentsIDMeioPag: TIntegerField;
    quPaymentsMeioPag: TStringField;
    quPaymentsPayType: TIntegerField;
    quPaymentsDrawerKickOnPay: TBooleanField;
    quPaymentsValorNominal: TBCDField;
    quPaymentsDataVencimento: TDateTimeField;
    quPaymentsIDQuitacaoMeioPrevisto: TIntegerField;
    quPaymentsIDLancamentoTipo: TIntegerField;
    quPaymentsIDDocumentoTipo: TIntegerField;
    quPaymentsIDPreSale: TIntegerField;
    quPaymentsCheckNumber: TStringField;
    quPaymentsIDBankCheck: TIntegerField;
    quPaymentsCustomerDocument: TStringField;
    quPaymentsCustomerName: TStringField;
    quPaymentsCustomerPhone: TStringField;
    quPaymentsHistorico: TMemoField;
    quPaymentsPaymentPlace: TIntegerField;
    quPaymentsNumMeioQuitPreVisto: TStringField;
    Payments: TppSubReport;
    ppChildReport4: TppChildReport;
    ppTitleBand4: TppTitleBand;
    ppDetailBand5: TppDetailBand;
    ppSummaryBand5: TppSummaryBand;
    ppDBText31: TppDBText;
    ppLabel25: TppLabel;
    ppDBText32: TppDBText;
    raCodeModule5: TraCodeModule;
    quSOItemUsedTime: TStringField;
    quSOItemDiscount: TBCDField;
    quProdutcsDiscount: TBCDField;
    ppDBText33: TppDBText;
    ppLabel26: TppLabel;
    quSOCustomerEmployeeID: TStringField;
    quSOCustomerFederalID: TStringField;
    quSOCustomerDBA: TStringField;
    quSOCustomerNeiborhood: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quSOItemCalcFields(DataSet: TDataSet);
  private
    FFileName : String;
    FIDSO : String;
    FPrintToFile : Boolean;

    procedure OpenSO;
    procedure CloseSO;

    procedure OpenSOItem;
    procedure CloseSOItem;

    procedure OpenSOItemDefect;
    procedure CloseSOItemDefect;

    procedure OpenSOItemProducts;
    procedure CloseSOItemProducts;

    procedure ClosePayments;
    procedure OpenPayments;

    function PrintReport: Boolean;
  public
    function Start(AIDSO: String; APrintToFile: Boolean = False): Boolean;
    function DesignReport:Boolean;
    function PrintToFile: Boolean;

    property FileName: String read FFileName write FFileName;
  end;

implementation

uses uDM, uDMGlobal;

{$R *.dfm}

{ TFrmServiceOrderPrint }

procedure TFrmServiceOrderPrint.CloseSO;
begin
  with quSO do
    if Active then
      Close;
end;

function TFrmServiceOrderPrint.DesignReport: Boolean;
begin
  Result := True;
  try
    ppDesigner.ShowModal;
  except
    Result := False;
  end;
end;

procedure TFrmServiceOrderPrint.OpenSO;
begin
  with quSO do
    if not Active then
    begin
      Parameters.ParamByName('IDServiceOrder').Value := FIDSO;
      Open;
    end;
end;

function TFrmServiceOrderPrint.PrintReport: Boolean;
begin

  IDLanguage.AsInteger := DMGlobal.IDLanguage;

  ppReport.PrinterSetup.Copies := DM.fPrintReceipt.ServiceReportNumCopy;

  if DM.fPrintReceipt.ServiceReportPath <> '[SYSTEM]' then
    if FileExists(DM.fPrintReceipt.ServiceReportPath) then
    begin
      ppReport.Template.FileName := DM.fPrintReceipt.ServiceReportPath;
      ppReport.Template.LoadFromFile;
    end;

  if DM.fPrintReceipt.ServiceReportPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := DM.fPrintReceipt.ServiceReportPrinter;

  if DM.fPrintReceipt.ServiceReportPreview then
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

function TFrmServiceOrderPrint.PrintToFile: Boolean;
begin
  ppReport.PrintToDevices;
  Result := True;
end;

function TFrmServiceOrderPrint.Start(AIDSO: String;
  APrintToFile: Boolean): Boolean;
begin

  FIDSO := AIDSO;
  FPrintToFile := APrintToFile;
  FFileName := '';

  OpenSO;
  OpenSOItem;
  OpenSOItemDefect;
  OpenSOItemProducts;
  OpenPayments;

  Result := PrintReport;

  Self.Close;

end;

procedure TFrmServiceOrderPrint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseSO;
  CloseSOItem;
  CloseSOItemDefect;
  CloseSOItemProducts;
  ClosePayments;
  Action := caFree;
end;

procedure TFrmServiceOrderPrint.CloseSOItem;
begin
  with quSOItem do
    If Active then
      Close;
end;

procedure TFrmServiceOrderPrint.OpenSOItem;
begin
  with quSOItem do
    If not Active then
    begin
      Parameters.ParamByName('IDServiceOrder').Value := FIDSO;
      Open;
    end;
end;

procedure TFrmServiceOrderPrint.quSOItemCalcFields(DataSet: TDataSet);
begin
  inherited;
  quSOItemModelDesc.AsString := quSOItemModel.AsString + ' ' + quSOItemDescription.AsString;
end;

procedure TFrmServiceOrderPrint.CloseSOItemDefect;
begin
  with quDefect do
    if Active then
      Close;
end;

procedure TFrmServiceOrderPrint.OpenSOItemDefect;
begin
  with quDefect do
    if not Active then
      Open;
end;

procedure TFrmServiceOrderPrint.CloseSOItemProducts;
begin
  with quProdutcs do
    if Active then
      Close;
end;

procedure TFrmServiceOrderPrint.OpenSOItemProducts;
begin
  with quProdutcs do
    if not Active then
      Open;
end;

procedure TFrmServiceOrderPrint.ClosePayments;
begin
  with quPayments do
   if Active then
     Close;
end;

procedure TFrmServiceOrderPrint.OpenPayments;
begin
  with quPayments do
   if not Active then
    begin
      Parameters.ParamByName('IDServiceOrder').Value := FIDSO;
      Open;
    end;
end;

end.
