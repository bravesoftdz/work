unit uFrmEstimatedPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  ppParameter, ppModule, raCodMod, ppBands, ppCache, ppClass, ppComm,
  ppRelatv, ppProd, ppReport, DB, ADODB, PowerADOQuery, ppDB, ppDBPipe,
  ppCtrls, ppStrtch, ppSubRpt, ppPrnabl, daDataView, daQueryDataView,
  daADO, daDataModule, ppMemo, DBCtrls, ppEndUsr, PsRBExport_Main,
  PsRBExport_MasterControl, JPEG;

type
  TFrmEstimatedPrint = class(TFrmParentAll)
    btnPrint: TButton;
    ppBudget: TppReport;
    quEstimated: TPowerADOQuery;
    quEstimatedIDEstimated: TIntegerField;
    quEstimatedEstimatedDate: TDateTimeField;
    quEstimatedTotal: TBCDField;
    quEstimatedOBS: TStringField;
    quEstimatedName: TStringField;
    quEstimatedPessoa: TStringField;
    quEstimatedSystemUser: TStringField;
    dsEstimated: TDataSource;
    dsEstimatedItems: TDataSource;
    quEstimetedItems: TPowerADOQuery;
    quEstimetedItemsIDEstimatedItem: TIntegerField;
    quEstimetedItemsIDModel: TIntegerField;
    quEstimetedItemsModel: TStringField;
    quEstimetedItemsDescription: TStringField;
    quEstimatedAddress: TStringField;
    quEstimatedIDEstado: TStringField;
    quEstimatedCity: TStringField;
    quEstimatedZip: TStringField;
    quEstimatedTelephone: TStringField;
    quEstimatedFax: TStringField;
    quEstimatedBeeper: TStringField;
    quEstimatedCellular: TStringField;
    quEstimatedContato: TStringField;
    quEstimatedEmail: TStringField;
    quEstimatedWebPage: TStringField;
    quEstimatedPessoaFirstName: TStringField;
    quEstimatedPessoaLastName: TStringField;
    ppEstimated: TppDBPipeline;
    ppEstimatedItem: TppDBPipeline;
    quEstimetedItemsLargeImage: TStringField;
    quEstimetedItemsTotal: TCurrencyField;
    dsFeatures: TDataSource;
    quFeatures: TPowerADOQuery;
    quFeaturesIDInvFeatures: TIntegerField;
    quFeaturesFeature: TStringField;
    ppModelFeatures: TppDBPipeline;
    quTechFeature: TADOQuery;
    quTechFeatureIDInvTechFeatures: TIntegerField;
    quTechFeatureTechFeature: TStringField;
    dsTechFeature: TDataSource;
    ppTechFeatures: TppDBPipeline;
    quEstimetedItemsItemImage: TStringField;
    chkImage: TCheckBox;
    quEstimetedItemsLargeImage2: TStringField;
    chkImage2: TCheckBox;
    chkFeatures: TCheckBox;
    chkTechFeatures: TCheckBox;
    quEstimetedItemsItemImage2: TStringField;
    Label1: TLabel;
    memEstimet: TMemo;
    chkQty: TCheckBox;
    ppDesigner: TppDesigner;
    quEstimatedCustomerEmail: TStringField;
    quEstimatedCustomerPhone: TStringField;
    btnEmail: TButton;
    SV: TSaveDialog;
    PsRBExportMasterControl: TPsRBExportMasterControl;
    quEstimetedItemsReplacementCost: TBCDField;
    quEstimetedItemsVendorCost: TBCDField;
    quEstimetedItemsAvgCost: TBCDField;
    quEstimetedItemsSellingPrice: TBCDField;
    quEstimetedItemsEstSalePrice: TBCDField;
    quEstimetedItemsSalePrice: TCurrencyField;
    quEstimatedOBS2: TStringField;
    Label2: TLabel;
    memEstimet2: TMemo;
    quEstimetedItemsQty: TFloatField;
    ppHeaderBand1: TppHeaderBand;
    ppLabel1: TppLabel;
    ppDBText4: TppDBText;
    ppLabel2: TppLabel;
    ppDBText5: TppDBText;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppLabel12: TppLabel;
    ppDBText15: TppDBText;
    ppLabel13: TppLabel;
    ppDBText16: TppDBText;
    ppDetailBand1: TppDetailBand;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand3: TppTitleBand;
    ppLabel5: TppLabel;
    ppLabel8: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel9: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppImage1: TppImage;
    ppDBText7: TppDBText;
    ppDBText6: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppSubReport2: TppSubReport;
    ppChildReport2: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppLabel6: TppLabel;
    ppDetailBand3: TppDetailBand;
    ppDBText11: TppDBText;
    raCodeModule3: TraCodeModule;
    ppSubReport3: TppSubReport;
    ppChildReport3: TppChildReport;
    ppTitleBand2: TppTitleBand;
    ppLabel7: TppLabel;
    ppDetailBand4: TppDetailBand;
    ppDBText12: TppDBText;
    raCodeModule4: TraCodeModule;
    ppImage2: TppImage;
    ppLine2: TppLine;
    ppSummaryBand1: TppSummaryBand;
    ppDBCalc1: TppDBCalc;
    ppLabel15: TppLabel;
    raCodeModule1: TraCodeModule;
    ppFooterBand1: TppFooterBand;
    ppLine3: TppLine;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBMemo1: TppDBMemo;
    ppLabel14: TppLabel;
    raCodeModule2: TraCodeModule;
    ppParameterList1: TppParameterList;
    ppIDLanguage: TppParameter;
    ppShowImg: TppParameter;
    ppShowImg2: TppParameter;
    ppShowFeatures: TppParameter;
    ppShowTechF: TppParameter;
    ppShowQty: TppParameter;
    quEstimatedCell: TStringField;
    quEstimatedCellAreaCode: TStringField;
    quEstimatedPhoneAreaCode: TStringField;
    quEstimetedItemsItemDiscount: TFloatField;
    quEstimetedItemsItemDiscPercent: TFloatField;
    quEstimatedEnderecoCliente: TStringField;
    quEstimatedBairroCliente: TStringField;
    quEstimatedCidadeCliente: TStringField;
    quEstimatedCEPCliente: TStringField;
    quEstimatedEstadoCliente: TStringField;
    quEstimatedContatoCliente: TStringField;
    quEstimetedItemsManufacturer: TStringField;
    quEstimetedItemsDepartment: TStringField;
    quEstimatedEmpresa: TStringField;
    quEstimatedRazaoEMP: TStringField;
    quEstimatedCNPJEMP: TStringField;
    quEstimatedIEEMP: TStringField;
    quEstimatedIMEMP: TStringField;
    quEstimatedEndEMP: TStringField;
    quEstimatedBairroEMP: TStringField;
    quEstimatedCidadeEMP: TStringField;
    quEstimatedCEPEMP: TStringField;
    quEstimatedEstadoEMP: TStringField;
    quEstimatedLogoEMP: TBlobField;
    ppLogoImage: TppImage;
    quEstimatedTipTouristGroup: TStringField;
    quEstimatedDeliverDate: TDateTimeField;
    quEstimatedDeliverAddress: TStringField;
    quEstimatedDeliverOBS: TStringField;
    quEstimatedTotalDiscount: TBCDField;
    quEstimatedConfirmed: TBooleanField;
    quEstimatedDeliverType: TStringField;
    quPayments: TADOQuery;
    dsPayments: TDataSource;
    ppPayments: TppDBPipeline;
    quPaymentsIDPaymentCondition: TIntegerField;
    quPaymentsIDMeioPag: TIntegerField;
    quPaymentsMeioPag: TStringField;
    quPaymentsImageIndex: TIntegerField;
    quPaymentsAmount: TBCDField;
    quPaymentsOBS: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure quEstimetedItemsCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
  private
    fIDEstimated : Integer;
    sEstimated, sOBS, sOBS2 : String;
    fUseSellinPrice, fAutoUpdatePrice : Boolean;
    procedure PostEstimeted;
    procedure OpenDataSets;
    procedure CloseDataSets;
    procedure SetReportParams;
    procedure PrintReport;
    procedure PreviewFormCreateEvent(Sender: TObject);
    procedure LoadEndEvent(Sender: TObject);
    procedure UpdatePrice;
    procedure LoadLogoImage;
  public
    function DesignReport:Boolean;
    function Start(IDEstimated:Integer; fOBS, fOBS2:String; fAutoPrice : Boolean):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, PsRBRoutines, uMsgBox, uMsgConstant,
  uDateTimeFunctions, DateUtils, uNumericFunctions;

{$R *.dfm}

{ TFrmEstimatedPrint }

function TFrmEstimatedPrint.Start(IDEstimated: Integer; fOBS, fOBS2:String; fAutoPrice : Boolean): Boolean;
begin
  fUseSellinPrice := True;
  fIDEstimated := IDEstimated;
  sOBS  := fOBS;
  sOBS2 := fOBS2;
  Self.Caption := sEstimated + IntToStr(IDEstimated);
  fAutoUpdatePrice := fAutoPrice;
  ShowModal;
  Result := True;
end;

procedure TFrmEstimatedPrint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseDataSets;
  Action := caFree;
end;

procedure TFrmEstimatedPrint.btCloseClick(Sender: TObject);
begin
  inherited;
  Close; 
end;

procedure TFrmEstimatedPrint.FormCreate(Sender: TObject);
begin
  inherited;

  ppBudget.Template.OnLoadEnd := LoadEndEvent;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sEstimated := 'Print Budget # ';
           end;

     LANG_PORTUGUESE :
           begin
           sEstimated := 'Imprimir Orçamento nº ';
           end;

     LANG_SPANISH :
           begin
           sEstimated := 'Imprima Presupuesto nº ';
           end;
   end;

end;

procedure TFrmEstimatedPrint.btnPrintClick(Sender: TObject);
begin
  inherited;
  UpdatePrice;
  PostEstimeted;
  CloseDataSets;
  OpenDataSets;
  SetReportParams;
  PrintReport;
  Close;
end;

procedure TFrmEstimatedPrint.CloseDataSets;
begin
  quEstimated.Close;
  quEstimetedItems.Close;
  quPayments.Close;
end;

procedure TFrmEstimatedPrint.OpenDataSets;
begin

  with quEstimated do
     if not Active then
        begin
        Parameters.ParamByName('IDEstimated').Value := fIDEstimated;
        Open;
        end;

  with quEstimetedItems do
     if not Active then
        begin
        Parameters.ParamByName('IDEstimated').Value := fIDEstimated;
        Open;
        end;

  with quPayments do
     if not Active then
        begin
        Parameters.ParamByName('IDEstimated').Value := fIDEstimated;
        Open;
        end;

end;

procedure TFrmEstimatedPrint.quEstimetedItemsCalcFields(DataSet: TDataSet);
var
 SalePrice : Currency;
 Discount : Double;
begin
  inherited;

  if fUseSellinPrice then
     SalePrice := quEstimetedItemsSellingPrice.AsCurrency
  else
     SalePrice := quEstimetedItemsEstSalePrice.AsCurrency;

  quEstimetedItemsSalePrice.AsCurrency := SalePrice;

  quEstimetedItemsTotal.AsCurrency := MyRound(quEstimetedItemsQty.AsFloat * SalePrice, 2);

 if (quEstimetedItemsLargeImage.AsString = '') or (not FileExists(quEstimetedItemsLargeImage.AsString)) then
    quEstimetedItemsItemImage.AsString := ''
 else
    quEstimetedItemsItemImage.AsString := quEstimetedItemsLargeImage.AsString;

 if (quEstimetedItemsLargeImage2.AsString = '') or (not FileExists(quEstimetedItemsLargeImage2.AsString)) then
    quEstimetedItemsItemImage2.AsString := ''
 else
    quEstimetedItemsItemImage2.AsString := quEstimetedItemsLargeImage2.AsString;

 if (not fUseSellinPrice) and (quEstimetedItemsSellingPrice.AsCurrency > quEstimetedItemsEstSalePrice.AsCurrency) then
 begin
   Discount                                := quEstimetedItemsSellingPrice.AsCurrency - quEstimetedItemsEstSalePrice.AsCurrency;
   quEstimetedItemsItemDiscount.AsFloat    := Discount;
   quEstimetedItemsItemDiscPercent.AsFloat := (Discount / quEstimetedItemsSellingPrice.AsCurrency) * 100;
 end
 else
 begin
   quEstimetedItemsItemDiscount.AsFloat    := 0;
   quEstimetedItemsItemDiscPercent.AsFloat := 0;
 end;
 
end;

procedure TFrmEstimatedPrint.SetReportParams;
begin
   ppIDLanguage.AsInteger   := DMGlobal.IDLanguage;
   ppShowImg.AsBoolean      := chkImage.Checked;
   ppShowImg2.AsBoolean     := chkImage2.Checked;
   ppShowFeatures.AsBoolean := chkFeatures.Checked;
   ppShowTechF.AsBoolean    := chkTechFeatures.Checked;
   ppShowQty.AsBoolean      := chkQty.Checked;
end;

procedure TFrmEstimatedPrint.PostEstimeted;
begin

  if (Trim(memEstimet.Text) <> '') and (sOBS <> memEstimet.Text) then
     DM.RunSQL('UPDATE Estimated SET OBS = '+QuotedStr(memEstimet.Text)+' WHERE IDEstimated = ' + IntToStr(fIDEstimated));

  if (Trim(memEstimet2.Text) <> '') and (sOBS2 <> memEstimet2.Text) then
     DM.RunSQL('UPDATE Estimated SET OBS2 = '+QuotedStr(memEstimet2.Text)+' WHERE IDEstimated = ' + IntToStr(fIDEstimated));

end;


procedure TFrmEstimatedPrint.FormShow(Sender: TObject);
begin
  inherited;
  memEstimet.Lines.Clear;
  memEstimet.Text := sOBS;

  memEstimet2.Lines.Clear;
  memEstimet2.Text := sOBS2;

end;

function TFrmEstimatedPrint.DesignReport: Boolean;
begin
  Result := True;
  try
     ppDesigner.ShowModal;
  except
     Result := False;
     end;
end;

procedure TFrmEstimatedPrint.PrintReport;
begin
  ppBudget.PrinterSetup.Copies := DM.fPrintReceipt.BudgetReportNumCopy;

  if DM.fPrintReceipt.BudgetReportPath <> '[SYSTEM]' then
    if FileExists(DM.fPrintReceipt.BudgetReportPath) then
    begin
      ppBudget.Template.FileName := DM.fPrintReceipt.BudgetReportPath;
      ppBudget.Template.LoadFromFile;
    end;

  if DM.fPrintReceipt.BudgetReportPrinter <> '' then
    ppBudget.PrinterSetup.PrinterName := DM.fPrintReceipt.BudgetReportPrinter;

  if DM.fPrintReceipt.BudgetReportPreview then
    ppBudget.DeviceType := 'Screen'
  else
    ppBudget.DeviceType := 'Printer';

  try
    LoadLogoImage;
    ppBudget.Print;
  except
    raise;
  end;
end;

procedure TFrmEstimatedPrint.btnEmailClick(Sender: TObject);
begin
  inherited;

  if SV.Execute then
     begin
     if Pos('.PDF',UpperCase(SV.FileName)) = 0 then
        SV.FileName := SV.FileName + '.PDF';
     ExportToPDF(ppBudget, SV.FileName, False, True, False);
     end;

end;

procedure TFrmEstimatedPrint.PreviewFormCreateEvent(Sender: TObject);
begin
{ BUG: As propriedades abaixo ficam false com se usa o ppReportExplorer,
       então seto manualmente com valores TRUE. }
  ppBudget.AllowPrintToArchive := True;
  ppBudget.AllowPrintToFile    := True;
  ppBudget.PreviewForm.WindowState := wsMaximized;
end;

procedure TFrmEstimatedPrint.LoadEndEvent(Sender: TObject);
begin
  ppBudget.OnPreviewFormCreate := PreviewFormCreateEvent;
end;

procedure TFrmEstimatedPrint.UpdatePrice;
begin
  if fAutoUpdatePrice then
    fUseSellinPrice := True
  else
    fUseSellinPrice := MsgBox(MSG_QST_UPDATE_SELLING_PRICE, vbYesNo + vbQuestion) = vbYes;
end;

procedure TFrmEstimatedPrint.LoadLogoImage;
var
  msLogo: TMemoryStream;
  img: TJPEGImage;
begin
  if Assigned(ppLogoImage) then
  begin
    msLogo := TMemoryStream.Create;
    try
      if not quEstimatedLogoEMP.IsNull then
      begin
        quEstimatedLogoEMP.SaveToStream(msLogo);
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
