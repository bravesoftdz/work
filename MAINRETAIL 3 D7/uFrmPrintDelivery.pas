unit uFrmPrintDelivery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPrinting, siComp, siLangRT, ExtCtrls, StdCtrls, DB, ADODB,
  ppDB, ppDBPipe, ppParameter, ppModule, raCodMod, ppBands, ppCtrls,
  ppPrnabl, ppClass, ppCache, ppComm, ppRelatv, ppProd, ppReport, ppStrtch,
  ppMemo, ppSubRpt, ppEndUsr, daDataModule;

type
  TFrmPrintDelivery = class(TFrmPrinting)
    ppPreSaleInfo: TppDBPipeline;
    dsPreSaleInfo: TDataSource;
    quPreSaleInfo: TADOQuery;
    quPreSaleInfoIDPreSale: TIntegerField;
    quPreSaleInfoIDMeioPag: TIntegerField;
    quPreSaleInfoIDTouristGroup: TIntegerField;
    quPreSaleInfoPreSaleDate: TDateTimeField;
    quPreSaleInfoOtherComissionID: TIntegerField;
    quPreSaleInfoIDCustomer: TIntegerField;
    quPreSaleInfoPassportDate: TDateTimeField;
    quPreSaleInfoAirLine: TStringField;
    quPreSaleInfoCompanyName: TStringField;
    quPreSaleInfoCompanyCGC: TStringField;
    quPreSaleInfoDepositDate: TDateTimeField;
    quPreSaleInfoNote: TStringField;
    quPreSaleInfoInvoiceDate: TDateTimeField;
    quPreSaleInfoIDInvoice: TIntegerField;
    quPreSaleInfoPassport: TStringField;
    quPreSaleInfoTicket: TStringField;
    quPreSaleInfoMediaID: TIntegerField;
    quPreSaleInfoCashReceived: TFloatField;
    quPreSaleInfoCashRegMovID: TIntegerField;
    quPreSaleInfoPrinted: TBooleanField;
    quPreSaleInfoTaxIsent: TBooleanField;
    quPreSaleInfoCardNumber: TStringField;
    quPreSaleInfoAddress: TStringField;
    quPreSaleInfoFirstName: TStringField;
    quPreSaleInfoLastName: TStringField;
    quPreSaleInfoPrintNotes: TBooleanField;
    quPreSaleInfoMedia: TStringField;
    quPreSaleInfoCountryCod: TStringField;
    quPreSaleInfoCountry: TStringField;
    quPreSaleInfoStateCode: TStringField;
    quPreSaleInfoState: TStringField;
    quPreSaleInfoClientAddress: TStringField;
    quPreSaleInfoClientCity: TStringField;
    quPreSaleInfoClientNeighborhood: TStringField;
    quPreSaleInfoClientZip: TStringField;
    quPreSaleInfoClientPhone: TStringField;
    quPreSaleInfoClientCell: TStringField;
    quPreSaleInfoClientEmail: TStringField;
    quPreSaleInfoClientBirthDate: TDateTimeField;
    quPreSaleInfoClientEmployeeID: TStringField;
    quPreSaleInfoClientSocialSecurity: TStringField;
    quPreSaleInfoClientFederalID: TStringField;
    quPreSaleInfoClientSalesTax: TStringField;
    quPreSaleInfoClientDBA: TStringField;
    quPreSaleInfoIDFormOfPayment: TIntegerField;
    ppPreSaleItem: TppDBPipeline;
    dsPreSaleItem: TDataSource;
    quPreSaleInfoDeliverTypeID: TIntegerField;
    quPreSaleInfoDeliverDate: TDateTimeField;
    quPreSaleInfoDeliverAddress: TStringField;
    quPreSaleInfoDeliverOBS: TStringField;
    quPreSaleInfoDeliverConfirmation: TBooleanField;
    quPreSaleItem: TADOQuery;
    quPreSaleItemIDPreSale: TIntegerField;
    quPreSaleItemModel: TStringField;
    quPreSaleItemDescription: TStringField;
    quPreSaleInfoFullname: TStringField;
    quPreSaleInfoSaleCode: TStringField;
    btnClose: TButton;
    quPayments: TADOQuery;
    quPaymentsIDMeioPag: TIntegerField;
    quPaymentsMeioPag: TStringField;
    quPaymentsValorNominal: TFloatField;
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
    quPaymentsPaymentPlaceDesc: TStringField;
    ppDesigner: TppDesigner;
    quPreSaleItemSalePrice: TBCDField;
    quPreSaleItemTotal: TCurrencyField;
    ppPayments: TppDBPipeline;
    dsPayment: TDataSource;
    quPreSaleItemDiscount: TBCDField;
    quPreSaleInfoDeliverType: TStringField;
    quPreSaleInfoIDPreSaleParent: TIntegerField;
    quPaymentsBanco: TStringField;
    quPreSaleItemQty: TFloatField;
    quPreSaleItemManufacture: TStringField;
    ppReport: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppLabel3: TppLabel;
    ppLabel8: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppLine1: TppLine;
    ppSummaryBand1: TppSummaryBand;
    raCodeModule2: TraCodeModule;
    ppSummaryBand3: TppSummaryBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText3: TppDBText;
    ppDBText1: TppDBText;
    ppLabel5: TppLabel;
    ppLabel7: TppLabel;
    ppLabel4: TppLabel;
    ppDBText2: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBMemo1: TppDBMemo;
    ppDBText11: TppDBText;
    ppLabel2: TppLabel;
    ppDBText12: TppDBText;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLine2: TppLine;
    raCodeModule1: TraCodeModule;
    ppParameterList1: TppParameterList;
    IDLanguage: TppParameter;
    daDataModule1: TdaDataModule;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure quPreSaleItemCalcFields(DataSet: TDataSet);
    procedure quPaymentsCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    sStore,
    sOutStore,
    sOther : String;
    fDeliveryDate : TDateTime;
    procedure PreSaleOpen;
    procedure PreSaleClose;
    procedure PreSaleItemOpen;
    procedure PreSaleItemClose;
    procedure PreSalePaymentsOpen;
    procedure PreSalePaymentsClose;
  public
    { Public declarations }
    function DesignReport:Boolean;
    function Start(DeliveryDate:TDateTime):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst;

{$R *.dfm}

{ TFrmPrintDelivery }

procedure TFrmPrintDelivery.PreSaleClose;
begin
   with quPreSaleInfo do
      if Active then
         Close;
end;

procedure TFrmPrintDelivery.PreSaleItemClose;
begin
   with quPreSaleItem do
      if Active then
         Close;
end;

procedure TFrmPrintDelivery.PreSaleItemOpen;
begin
   with quPreSaleItem do
      if not Active then
         begin
         Parameters.ParamByName('IniDate').Value := fDeliveryDate;
         Parameters.ParamByName('EndDate').Value := (fDeliveryDate+1);
         Open;
         end;
end;

procedure TFrmPrintDelivery.PreSaleOpen;
begin
   with quPreSaleInfo do
      if not Active then
         begin
         Parameters.ParamByName('IniDate').Value := fDeliveryDate;
         Parameters.ParamByName('EndDate').Value := (fDeliveryDate+1);
         Open;
         end;
end;

function TFrmPrintDelivery.Start(DeliveryDate:TDateTime): Boolean;
begin
  fDeliveryDate := Trunc(DeliveryDate);
  PreSaleOpen;
  PreSaleItemOpen;
  PreSalePaymentsOpen;

  ShowModal;

  Result := (ModalResult = mrOK);

  PreSaleClose;
  PreSaleItemClose;
  PreSalePaymentsClose;
end;

procedure TFrmPrintDelivery.FormShow(Sender: TObject);
begin
  inherited;

  IDLanguage.AsInteger := DMGlobal.IDLanguage;

  if DM.fPrintReceipt.DeliveryReportPreview then
    ppReport.DeviceType := 'Screen'
  else
    ppReport.DeviceType := 'Printer';
  ppReport.PrinterSetup.Copies := DM.fPrintReceipt.DeliveryReportNumCopy;

  if DM.fPrintReceipt.DeliveryReportPath <> '[SYSTEM]' then
     if FileExists(DM.fPrintReceipt.DeliveryReportPath) then
        begin
        ppReport.Template.FileName := DM.fPrintReceipt.DeliveryReportPath;
        ppReport.Template.LoadFromFile;
        end;

  if DM.fPrintReceipt.DeliveryReportPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := DM.fPrintReceipt.DeliveryReportPrinter;

  try
    ppReport.Print;
  except
    raise;
    end;

end;

procedure TFrmPrintDelivery.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPrintDelivery.PreSalePaymentsOpen;
begin
  with quPayments do
     if not Active then
        Open;
end;

procedure TFrmPrintDelivery.PreSalePaymentsClose;
begin
  with quPayments do
     if Active then
        Close;
end;

function TFrmPrintDelivery.DesignReport: Boolean;
begin

  Result := True;
  try
     ppDesigner.ShowModal;
  except
     Result := False;
     end;

end;

procedure TFrmPrintDelivery.quPreSaleItemCalcFields(DataSet: TDataSet);
begin
  inherited;
  quPreSaleItemTotal.AsCurrency := (quPreSaleItemQty.AsInteger *
                                   quPreSaleItemSalePrice.AsCurrency) - quPreSaleItemDiscount.AsCurrency;

end;

procedure TFrmPrintDelivery.quPaymentsCalcFields(DataSet: TDataSet);
begin
  inherited;

  case quPaymentsPaymentPlace.AsInteger of
    0 : quPaymentsPaymentPlaceDesc.AsString := sStore;
    1 : quPaymentsPaymentPlaceDesc.AsString := sOutStore;
    2 : quPaymentsPaymentPlaceDesc.AsString := sOther;
  end;

end;

procedure TFrmPrintDelivery.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sStore    := 'Store';
           sOutStore := 'Out of Store';
           sOther    := 'Other';
           end;

     LANG_PORTUGUESE :
           begin
           sStore    := 'Loja';
           sOutStore := 'Contra-Entrega';
           sOther    := 'Outros';
           end;

     LANG_SPANISH :
           begin
           sStore    := 'Tienda';
           sOutStore := 'Contra-Entrega';
           sOther    := 'Otros';
           end;
   end;

end;

end.
