unit uFrmPrintReceiving;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, ppDB, ppDBPipe, DB, ADODB,
  ppEndUsr, ppParameter, ppCtrls, ppBands, ppModule, raCodMod, ppClass,
  myChkBox, ppReport, ppPrnabl, ppStrtch, ppSubRpt, ppCache, ppComm,
  ppRelatv, ppProd, StdCtrls, ppVar;

type
  TFrmPrintReceiving = class(TFrmParentPrint)
    btnClose: TButton;
    ppReport: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppSubReport: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel8: TppLabel;
    ppLabel12: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText5: TppDBText;
    ppDBText16: TppDBText;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    raCodeModule2: TraCodeModule;
    ppSummaryBand3: TppSummaryBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    raCodeModule1: TraCodeModule;
    ppParameterList1: TppParameterList;
    IDLanguage: TppParameter;
    ppDesigner: TppDesigner;
    quPurchaseItem: TADOQuery;
    quPurchase: TADOQuery;
    dsPurchase: TDataSource;
    ppPurchaseItem: TppDBPipeline;
    dsPurchaseItem: TDataSource;
    ppPurchase: TppDBPipeline;
    quPurchaseIDPurchase: TIntegerField;
    quPurchaseIDFornecedor: TIntegerField;
    quPurchaseSubTotal: TBCDField;
    quPurchaseStore: TStringField;
    quPurchaseVendor: TStringField;
    quPurchaseItemIDPurchaseItem: TIntegerField;
    quPurchaseItemIDPurchase: TIntegerField;
    quPurchaseItemQty: TBCDField;
    quPurchaseItemNewCostPrice: TBCDField;
    quPurchaseItemNewSalePrice: TBCDField;
    quPurchaseItemNewSuggRetail: TBCDField;
    quPurchaseItemModel: TStringField;
    quPurchaseItemDescription: TStringField;
    quPurchaseItemBarcode: TStringField;
    quPurchaseItemCategory: TStringField;
    ppDBText: TppDBText;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    quPurchaseDocumentNumber: TStringField;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppSystemVariable3: TppSystemVariable;
    ppLine1: TppLine;
    ppLabel7: TppLabel;
    ppDBText3: TppDBText;
    ppLabel9: TppLabel;
    myCheckBox1: TmyCheckBox;
    ppLine2: TppLine;
    quPurchaseLogoEmpresa: TBlobField;
    ppLogoImage: TppImage;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FIDReceivings: String;

    procedure OpenPurchase;
    procedure ClosePurchase;
    procedure OpenPurchaseItem;
    procedure ClosePurchaseItem;

    procedure LoadLogoImage;

    function PrintReport: Boolean;
  public
    function Start(AIDReceivings: String): Boolean;
    function DesignReport: Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSQLFunctions, JPEG;

{$R *.dfm}

{ TFrmPrintReceiving }

procedure TFrmPrintReceiving.ClosePurchase;
begin
  with quPurchase do
    if Active then
      Close;
end;

procedure TFrmPrintReceiving.ClosePurchaseItem;
begin
  with quPurchaseItem do
    if Active then
      Close;
end;

function TFrmPrintReceiving.DesignReport: Boolean;
begin
  Result := True;
  try
    ppDesigner.ShowModal;
  except
    Result := False;
  end;
end;

procedure TFrmPrintReceiving.OpenPurchase;
begin
  with quPurchase do
    if not Active then
    begin
      SQL.Text := ChangeWhereClause(SQL.Text, 'P.IDPurchase in (' + FIDReceivings + ')', True);
      Open;
    end;
end;

procedure TFrmPrintReceiving.OpenPurchaseItem;
begin
  with quPurchaseItem do
    if not Active then
    begin
      SQL.Text := ChangeWhereClause(SQL.Text, 'PI.IDPurchase in (' + FIDReceivings + ')', True);
      Open;
    end;
end;

function TFrmPrintReceiving.PrintReport: Boolean;
begin
  IDLanguage.AsInteger := DMGlobal.IDLanguage;

  ppReport.PrinterSetup.Copies := DM.fPrintReceipt.ReceivingReportNumCopy;

  if DM.fPrintReceipt.ReceivingReportPath <> '[SYSTEM]' then
    if FileExists(DM.fPrintReceipt.ReceivingReportPath) then
    begin
      ppReport.Template.FileName := DM.fPrintReceipt.ReceivingReportPath;
      ppReport.Template.LoadFromFile;
    end;

  if DM.fPrintReceipt.ReceivingReportPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := DM.fPrintReceipt.ReceivingReportPrinter;

  if DM.fPrintReceipt.ReceivingReportPreview then
    ppReport.DeviceType := 'Screen'
  else
    ppReport.DeviceType := 'Printer';

  try
    LoadLogoImage;
    ppReport.Print;
    Result := True;
  except
    Result := False;
  end;
end;

function TFrmPrintReceiving.Start(AIDReceivings: String): Boolean;
begin
  FIDReceivings := AIDReceivings;

  OpenPurchase;
  OpenPurchaseItem;  
  PrintReport;

  Self.Close;
end;

procedure TFrmPrintReceiving.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPrintReceiving.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ClosePurchaseItem;
  ClosePurchase;
  Action := caFree;
end;

procedure TFrmPrintReceiving.LoadLogoImage;
var
  msLogo: TMemoryStream;
  img: TJPEGImage;
begin
  if Assigned(ppLogoImage) then
  begin
    msLogo := TMemoryStream.Create;
    try
      if not quPurchaseLogoEmpresa.IsNull then
      begin
        quPurchaseLogoEmpresa.SaveToStream(msLogo);
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
