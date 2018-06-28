unit uFrmPrintPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, ppDB, ppDBPipe, DB, ADODB,
  ppEndUsr, ppParameter, ppCtrls, ppBands, ppClass, ppModule, raCodMod,
  ppReport, ppPrnabl, ppStrtch, ppSubRpt, ppCache, ppComm, ppRelatv,
  ppProd, StdCtrls, daDataModule, myChkBox, JPEG, PsRBExport_Main,
  PsRBExport_PDF, ppFilDev, ExtCtrls, ppVar;

type
  TFrmPrintPO = class(TFrmParentPrint)
    btnClose: TButton;
    ppReport: TppReport;
    ppDesigner: TppDesigner;
    quPOItems: TADOQuery;
    quPO: TADOQuery;
    dsPO: TDataSource;
    ppTransferItems: TppDBPipeline;
    dsPOItems: TDataSource;
    quPODataPedido: TDateTimeField;
    quPOFreight: TBCDField;
    quPOCharges: TBCDField;
    quPOSubTotal: TBCDField;
    quPOEstArrival: TDateTimeField;
    quPOPayDays: TIntegerField;
    quPOOBS: TStringField;
    quPOVendor: TStringField;
    quPOEmail: TStringField;
    quPOFax: TStringField;
    quPOContact: TStringField;
    quPOAddress: TStringField;
    quPOCity: TStringField;
    quPONeighborhood: TStringField;
    quPOIDEstado: TStringField;
    quPOZip: TStringField;
    quPOPhone: TStringField;
    quPOCell: TStringField;
    quPOFax_1: TStringField;
    quPOVOBS: TStringField;
    quPOPhoneAreaCode: TStringField;
    quPOCellAreaCode: TStringField;
    quPOBirthState: TStringField;
    quPOSocialSecurity: TStringField;
    quPOFederalID: TStringField;
    quPOSalesTax: TStringField;
    quPOHomePage: TStringField;
    quPOStore: TStringField;
    quPOStoreAddress: TStringField;
    quPOStoreCity: TStringField;
    quPOStoreZip: TStringField;
    quPOStorePhone: TStringField;
    quPOStoreCell: TStringField;
    quPOStoreFax: TStringField;
    quPOStoreContact: TStringField;
    quPOStoreEmail: TStringField;
    quPOStoreWebSite: TStringField;
    quPOIDVendor: TIntegerField;
    quPODocumentID: TIntegerField;
    quPOItemsCostPrice: TBCDField;
    quPOItemsSalePrice: TBCDField;
    quPOItemsSuggRetail: TBCDField;
    quPOItemsQty: TFloatField;
    quPOItemsCaseQty: TFloatField;
    quPOItemsCaseCost: TBCDField;
    quPOItemsModel: TStringField;
    quPOItemsDescription: TStringField;
    quPOItemsVendorCode: TStringField;
    quPOItemsCostTotal: TFloatField;
    quPOItemsDocumentID: TIntegerField;
    quPOItemsQtyRealMov: TFloatField;
    quPOItemsUnitQty: TFloatField;
    quPOVendorAccount: TStringField;
    quPOItemsModelSellingPrice: TBCDField;
    quPOItemsTotQtyOnHand: TFloatField;
    quPOItemsCategory: TStringField;
    quPOStoreState: TStringField;
    ppTransfer: TppDBPipeline;
    quPOItemsManufacturer: TStringField;
    quPOItemsWeight: TCurrencyField;
    quPOEmpresa: TStringField;
    quPORazaoEMP: TStringField;
    quPOCNPJEMP: TStringField;
    quPOIEEMP: TStringField;
    quPOIMEMP: TStringField;
    quPOBairroEMP: TStringField;
    quPOCidadeEMP: TStringField;
    quPOCEPEMP: TStringField;
    quPOEstadoEMP: TStringField;
    quPOItemsSize: TStringField;
    quPOItemsColor: TStringField;
    quPOItemsSystemUser: TStringField;
    quPOEndEMP: TStringField;
    quPOLogoEmpresa: TBlobField;
    ppExportPDF: TPsRBExportPDF;
    quPOItemsBarcode: TStringField;
    quPOItemsQtyOnHand: TBCDField;
    sortOrderRadio: TRadioGroup;
    quPOItemsHasCase: TIntegerField;
    ppHeaderBand: TppHeaderBand;
    ppDetailBand: TppDetailBand;
    ppSubReport: TppSubReport;
    ppChildReport: TppChildReport;
    ppTitleBand: TppTitleBand;
    ppDetailBand2: TppDetailBand;
    ppDBText6: TppDBText;
    ppDBText5: TppDBText;
    ppDBText9: TppDBText;
    ppDBText16: TppDBText;
    ppVariable1: TppVariable;
    ppLabel7: TppLabel;
    ppDBText8: TppDBText;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel18: TppLabel;
    ppLabel12: TppLabel;
    ppLabel8: TppLabel;
    ppLabel16: TppLabel;
    ppLabel9: TppLabel;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLabel11: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppLine2: TppLine;
    raCodeModule2: TraCodeModule;
    ppSummaryBand3: TppSummaryBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppLabel10: TppLabel;
    ppDBText10: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText24: TppDBText;
    lbAccount: TppLabel;
    ppLabel17: TppLabel;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText21: TppDBText;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppDBText22: TppDBText;
    ppLabel15: TppLabel;
    ppDBText23: TppDBText;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBText7: TppDBText;
    ppLine1: TppLine;
    ppLogoImage: TppImage;
    ppGroupFooterBand1: TppGroupFooterBand;
    raCodeModule1: TraCodeModule;
    ppParameterList1: TppParameterList;
    IDLanguage: TppParameter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure ppReportBeforePrint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FIDPOs: String;
    FPrintToFile: Boolean;
    FFileName: String;

    procedure OpenPO;
    procedure ClosePO;
    procedure OpenItem;
    procedure CloseItem;
    procedure RefreshItem;
    procedure LoadLogoImage;
    function PrintReport: Boolean;

    // Antonio, 2013 Oct 22: MR-33
    function getOrderByItem: String;
    function getItemsInsidePOItemSQL(arg_name: String): String;
    // Antonio 2013 Nov 01 - could be removed in the future to particular data object class (PurchaseDAO for instance)
    function getPOItemSQLToUseFilter(): String;

    function GetOrderByIndex(): Integer;
    procedure SetOrderByIndex(selected_index: Integer);


  public
    function Start(AIDPOs: String; APrintToFile: Boolean = False): Boolean; overload;
    // Antonio 2013 Oct 31, MR-43
    function start(arg_poItems: TADOQuery; AIDPOs: String; APrintToFile: Boolean = False): Boolean; overload;

    function DesignReport:Boolean;
    function PrintToFile: Boolean;

    property FileName: String read FFileName write FFileName;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, uSQLFunctions, uMsgBox, uStringFunctions, StoreSysRegistryCls, SysRegistryDAO,
     SysRegistryCls;

{$R *.dfm}

procedure TFrmPrintPO.RefreshItem;
begin
  CloseItem;
  OpenItem;
end;

procedure TFrmPrintPO.CloseItem;
begin
  with quPOItems do
    if Active then
      Close;
end;

procedure TFrmPrintPO.ClosePO;
begin
  with quPO do
    if Active then
      Close;
end;

procedure TFrmPrintPO.OpenItem;
begin
  with quPOItems do
    if not Active then
    begin
      Parameters.ParamByName('DocumentID').Value := quPODocumentID.AsString;
      Parameters.ParamByName('IDVendor').Value   := quPOIDVendor.AsInteger;
      Parameters.ParamByName('IDStore').Value    := DM.fStore.ID;
      Open;
    end;
end;

procedure TFrmPrintPO.OpenPO;
begin
  with quPO do
    if not Active then
    begin
      SQL.Text := ChangeWhereClause(SQL.Text, 'PO.IDPO in ('+FIDPOs+')', True);
      Open;
    end;
end;

function TFrmPrintPO.DesignReport: Boolean;
begin
  Result := True;
  try
    ppDesigner.ShowModal;
  except
    Result := False;
  end;
end;

function TFrmPrintPO.Start(AIDPOs: String; APrintToFile: Boolean = False): Boolean;
begin
  FIDPOs := AIDPOs;
  FPrintToFile := APrintToFile;
  FFileName := '';

  // Antonio 09/22/2016: MR-102 get last index from database
  sortOrderRadio.itemIndex := GetOrderByIndex();
  result := ( showModal = mrOK );
end;

procedure TFrmPrintPO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ClosePO;
  CloseItem;
  Action := caFree;
end;

procedure TFrmPrintPO.btnCloseClick(Sender: TObject);
begin
  // Antonio, 2013 Oct 22 - MR-33
  quPOItems.SQL.Add(getOrderByItem);
  OpenPO;
  quPO.First;

  with quPO do
    while not Eof do
    begin
      RefreshItem;
      PrintReport;
      Next;
    end;


  // Antonio 09/22/2016: MR-102 save selected index to next print
  SetOrderByIndex(sortOrderRadio.ItemIndex);

  Close;

  inherited;
end;

function TFrmPrintPO.PrintReport: Boolean;
var
  sMsgError: String;
  sDir: String;
begin
  IDLanguage.AsInteger := DMGlobal.IDLanguage;

  ppReport.PrinterSetup.Copies := DM.fPrintReceipt.POReportNumCopy;

  if DM.fPrintReceipt.POReportPath <> '[SYSTEM]' then
    if FileExists(DM.fPrintReceipt.POReportPath) then
    begin
      ppReport.Template.FileName := DM.fPrintReceipt.POReportPath;
      ppReport.Template.LoadFromFile;
    end;

  if DM.fPrintReceipt.POReportPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := DM.fPrintReceipt.POReportPrinter;

  sMsgError := 'Erro ao imprimir relatório.';

  if FPrintToFile then
  begin
    sDir := DM.LocalPath + PO_FILE_DIR;
    if not DirectoryExists(sDir) then
      ForceDirectories(sDir);
    FFileName := sDir + 'PO-' + quPODocumentID.AsString + '.pdf';
    ppReport.DeviceType := 'Adobe Acrobat Document';
    ppReport.ShowPrintDialog := False;
    sMsgError := 'Erro ao gerar arquivo PDF.';
  end
  else if DM.fPrintReceipt.POReportPreview then
    ppReport.DeviceType := 'Screen'
  else
    ppReport.DeviceType := 'Printer';

  try
    LoadLogoImage;
    ppReport.ArchiveFileName := FFileName;
    ppReport.Print;
    Result := True;
  except
    on E: Exception do
    begin
      MsgBoxError(sMsgError, E.Message, vbCritical + vbOKOnly);
      Result := False;
    end;
  end;
end;

function TFrmPrintPO.PrintToFile: Boolean;
begin
  ppReport.PrintToDevices;
end;

procedure TFrmPrintPO.LoadLogoImage;
var
  msLogo: TMemoryStream;
  img: TJPEGImage;
begin
  if Assigned(ppLogoImage) then
  begin
    msLogo := TMemoryStream.Create;
    try
      if not quPOLogoEmpresa.IsNull then
      begin
        quPOLogoEmpresa.SaveToStream(msLogo);
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

procedure TFrmPrintPO.ppReportBeforePrint(Sender: TObject);
begin
  inherited;
  if Assigned(ppReport.FileDevice) then
    ppReport.FileDevice.FileName := FFileName;
end;

function TFrmPrintPO.getOrderByItem: String;
begin
  result := getItemsInsidePOItemSQL(sortOrderRadio.Items.Strings[sortOrderRadio.ItemIndex]);
end;

function TFrmPrintPO.getItemsInsidePOItemSQL(arg_name: String): String;
begin
   if ( upperCase(arg_name) = 'BARCODE' ) then begin
              result := ' order by Barcode';
   end
   else if ( upperCase(arg_name) = 'COST' ) then begin
      result := ' order by CostPrice'
   end
   else if ( upperCase(arg_name) = 'DESCRIPTION' ) then begin
          result := ' order by Description';
   end
   else if ( upperCase(arg_name) = 'MODEL' ) then begin
              result := ' order by Model';
   end
   else if ( upperCase(arg_name) = 'QTY' ) then begin
              result := ' order by Qty';
   end
   else if ( upperCase(arg_name) = 'VENDORCOST' ) then begin
              result := ' order by CaseCost';
   end;
end;

procedure TFrmPrintPO.Button1Click(Sender: TObject);
begin
  inherited;
  // Antonio, 2013 Oct 22 - MR-33
  quPOItems.SQL.Add(getOrderByItem);

end;

function TFrmPrintPO.Start(arg_poItems: TADOQuery; AIDPOs: String;
  APrintToFile: Boolean): Boolean;
begin
  FIDPOs := AIDPOs;
  FPrintToFile := APrintToFile;
  FFileName := '';
  arg_poItems.close;
  arg_poItems.SQL.Text := getPOItemSQLToUseFilter();
  quPOItems := arg_poItems;
  openPO();
  with quPO do
    while not Eof do
    begin
      //RefreshItem;

      PrintReport;
      Next;
    end;

  Close;

end;

function TFrmPrintPO.getPOItemSQLToUseFilter: String;
var
	sql: TStringList;
begin
	try
   	sql := TStringList.Create;
		sql.add('SELECT PIM.IDPreInventoryMov, PIM.DocumentID,');
		sql.add('IsNull(SubModel.QtySubItem, PIM.Qty) Qty,');
		sql.add('PIM.CostPrice, PIM.DateEstimatedMov, M.ModelType, PIM.MovDate, IsNull(SubModel.QtySubRealMov, PIM.QtyRealMov) QtyRealMov,');
		sql.add('case when M.SellingPrice <> PIM.SalePrice then m.SellingPrice else m.SellingPrice End as SalePrice,');
		sql.add('IsNull(SubModel.SubItemTotal, (PIM.Qty * PIM.CostPrice)) SubTotal, PIM.SuggRetail,');
		sql.add('M.VendorCost CurrentCost, M.SellingPrice CurrentSale, M.Model, M.IDModel,');
		sql.add('M.Peso Weight, 	M.[Description], M.SuggRetail CurrentSuggRetail, ');
		sql.add('CASE WHEN M.SellingPrice > 0 THEN (1 - (M.FinalCost/M.SellingPrice)) * 100 END MarginPercent,');
		sql.Add('CASE WHEN M.SellingPrice > 0 THEN ((1 - (M.FinalCost/M.SellingPrice)) * M.SellingPrice) END MarginValue,');
		sql.add('TG.[Name] Category, P.Pessoa, ');
    	sql.Add('PIM.CaseCost, PIM.CaseQty, C.Color, S.CodSize, S.SizeName [Size],');
	 	sql.add('	C.CodColor,');
		sql.add('	B.IDBarcode as Barcode,');
		sql.add('V.QtyOnHand,');
		sql.add('(SELECT TOP 1 MVC.VendorCode');
		sql.add('FROM VendorModelCode MVC WHERE MVC.IDModel = M.IDModel AND MVC.IDPessoa is not null)as VendorCode,');
		sql.add('V.StoreID');
		sql.add('FROM');
		sql.add('PreInventoryMov PIM (NOLOCK)');
		sql.add('JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)');
		sql.add('JOIN Inventory V (NOLOCK) ON (PIM.ModelId = V.ModelId and PIM.StoreId = V.StoreId)');
		sql.add('JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)');
		sql.add('LEFT JOIN Barcode B (NOLOCK) ON (M.IDModel = B.IDModel AND B.BarcodeOrder = 1)');
		sql.add('LEFT OUTER JOIN InvColor C (NOLOCK) ON (M.IDColor = C.IDColor)');
		sql.add('LEFT OUTER JOIN InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)');
		sql.add('LEFT OUTER JOIN Pessoa P (NOLOCK) ON (M.IDFabricante = P.IDPessoa)');
      sql.add('LEFT OUTER JOIN ( ');
		sql.add('SELECT');
		sql.add('SUM(IsNull(PIMT.Qty,0)) QtySubItem,');
		sql.add('SUM(IsNull(PIMT.QtyRealMov,0)) QtySubRealMov,');
		sql.add('SUM(IsNull(PIMT.Qty,0) * IsNull(PIMT.CostPrice,0)) SubItemTotal,');
		sql.add('PIMT.IDPreInventoryMovParent');
		sql.add('FROM');
		sql.add('	PreInventoryMov PIMT (NOLOCK)');
		sql.add('GROUP BY');
		sql.add('PIMT.IDPreInventoryMovParent');
		sql.add(') as SubModel ON (SubModel.IDPreInventoryMovParent = PIM.IDPreInventoryMov)');
		sql.add('WHERE');
		sql.add('PIM.DocumentID is not null');
      sql.add('AND PIM.InventMovTypeID = 2');
      sql.Add('AND (M.ModelType = ''R'' OR M.ModelType = ''M'')');
      sql.Add('AND IsNull(SubModel.QtySubItem, PIM.Qty) > IsNull(SubModel.QtySubRealMov, PIM.QtyRealMov)');

      result := String(sql.GetText);

   finally
      freeAndNil(sql);
   end;
end;

function TFrmPrintPO.GetOrderByIndex(): Integer;
var
   defaultOrderBy: Integer;
   store: TStoreSysRegistry;
   dao: TSysRegistryDAO;
   sisRegistryList: TList;
   sisRegistry: TSysRegistry;
   i: integer;

begin

  result := 3; // model

  // save select index to next print
  try
      sisRegistryList := TList.Create();
      dao := TSysRegistryDAO.create(dm.ADODBConnect);
      store := TStoreSysRegistry.create();
      TSysRegistry(store).AttributeName := 'Database.Default.OrderByPrintPO.Index';
      TSysRegistry(store).AttributeValue := IntToStr(sortOrderRadio.ItemIndex);
      TSysRegistry(store).AttributeType := 'Int';
      TSysRegistry(store).ConstraintValue := IntToStr(1);
      TSysRegistry(store).ConstraintType := 2;
      dao.setRegistry(TSysRegistry(store));

      if ( dao.select('Database.Default.OrderByPrintPO.Index', sisRegistryList ) ) then begin
         for i:= 0 to sisRegistryList.Count -1 do begin
             sisRegistry := sisRegistryList[i];

             if ( sisRegistry.AttributeName = TSysRegistry(store).AttributeName ) then begin
                  result := StrToInt(sisRegistry.AttributeValue);
                  break;
             end;

         end;
      end;
  finally
     for i:= 0 to sisRegistryList.Count - 1 do begin
         TSysRegistry(sisRegistryList[i]).Free();
     end;

     sisRegistryList.Free();

  end;
end;

procedure TFrmPrintPO.SetOrderByIndex(selected_index: Integer);
var
   defaultOrderBy: Integer;
   store: TStoreSysRegistry;
   dao: TSysRegistryDAO;
   sisRegistryList: TList;
   sisRegistry: TSysRegistry;
   i: integer;
   idFound: Integer;
begin
  // save select index to next print
  try
      idFound := 0;

      sisRegistryList := TList.Create();
      dao := TSysRegistryDAO.create(dm.ADODBConnect);
      store := TStoreSysRegistry.create();
      TSysRegistry(store).AttributeName := 'Database.Default.OrderByPrintPO.Index';
      TSysRegistry(store).AttributeValue := IntToStr(sortOrderRadio.ItemIndex);
      TSysRegistry(store).AttributeType := 'Int';
      TSysRegistry(store).ConstraintValue := IntToStr(1);
      TSysRegistry(store).ConstraintType := 2;
      dao.setRegistry(TSysRegistry(store));

      if ( dao.select('Database.Default.OrderByPrintPO.Index', sisRegistryList ) ) then begin
         for i:= 0 to sisRegistryList.Count -1 do begin
             sisRegistry := sisRegistryList[i];

             if ( sisRegistry.AttributeName = TSysRegistry(store).AttributeName ) then begin
                  idFound := sisRegistry.ID;
                  break;
             end;

         end;
      end;

      if ( idFound = 0 ) then begin
         dao.insert
      end else begin
             dao.update(idFound);
          end;

  finally
     for i:= 0 to sisRegistryList.Count - 1 do begin
         TSysRegistry(sisRegistryList[i]).Free();
     end;

     sisRegistryList.Free();

  end;
end;

end.
