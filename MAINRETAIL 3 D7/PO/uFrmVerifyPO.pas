(*
-----------------------------------------------------------------------------------------------------

Version : (289 - 286)
Date    : 03.11.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : issue related to barcode length and character barcode
Solution: There was a mistake in parameters.
Version : (289 - 287)
-----------------------------------------------------------------------------------------------------

Version : (288 - 279)
Date    : 02.12.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Scanned Receipt Verify Greying out Early
Solution: I changed function forceUpdate to consider IdPurchase field when update.
Version : (288 - 280)
-----------------------------------------------------------------------------------------------------

Version : (288 - 276)
Date    : 12.10.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : if user close screen without verify or update the controls ( barcode, remove button, etc )
          should be enabled.
Solution: Change previous function. when updated there are lines in table Pur_PurchaseItem, instead
          PurchaseVerify.
Version : (288 - 277)
-----------------------------------------------------------------------------------------------------

Version : (287 - 275)
Date    : 12.02.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : After press update button, must be disabled barcode, remove button and itself.
Solution: Implemented function to verify if update button had been pressed.
Version : (287 - 276)
-----------------------------------------------------------------------------------------------------
*)

unit uFrmVerifyPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, mrBarCodeEdit, ADODB, ComCtrls, uDMCalcTax, uSystemConst, dbClient;

type
  TFrmVerifyPO = class(TFrmParent)
    pnlResult: TPanel;
    pnlScan: TPanel;
    pnlDetail: TPanel;
    pnlButtons: TPanel;
    btExcel: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    btFilter: TSpeedButton;
    pnlDivisoria2: TPanel;
    grdVerifySearch: TcxGrid;
    grdVerifySearchDB: TcxGridDBTableView;
    grdVerifySearchLevel: TcxGridLevel;
    btnRemove: TSpeedButton;
    Panel5: TPanel;
    edtBarcode: TmrBarCodeEdit;
    lbBarcode: TLabel;
    pnLastScan: TPanel;
    lbModelGroup2: TLabel;
    pnlModelMeasure: TPanel;
    lbSalePrice: TLabel;
    lbPriceResult: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel4: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    grdVerifySearchDBIDBarcode: TcxGridDBColumn;
    grdVerifySearchDBQtyReceiving: TcxGridDBColumn;
    grdVerifySearchDBQtyCounted: TcxGridDBColumn;
    grdVerifySearchDBSystemUser: TcxGridDBColumn;
    grdVerifySearchDBModel: TcxGridDBColumn;
    grdVerifySearchDBDescription: TcxGridDBColumn;
    grdVerifySearchDBCategory: TcxGridDBColumn;
    grdVerifySearchDBDifference: TcxGridDBColumn;
    lbBarcodeResult: TLabel;
    lbModelResult: TLabel;
    lbDescResult: TLabel;
    lbTotCounted: TLabel;
    lbTotPO: TLabel;
    lbTotDiff: TLabel;
    Panel6: TPanel;
    Label6: TLabel;
    edtNumCopy: TEdit;
    udCopy: TUpDown;
    btPrint: TSpeedButton;
    chkPrint: TCheckBox;
    edtReportFile: TEdit;
    btnOpenFile: TSpeedButton;
    OD: TOpenDialog;
    pnlLegend: TPanel;
    pnlBadItem: TPanel;
    lbItemNotImp: TLabel;
    pnlGreaterQty: TPanel;
    lbQtyExceeds: TLabel;
    pnlLessQty: TPanel;
    lbQtyBellow: TLabel;
    spRemoveItem: TADOStoredProc;
    tmrRefresh: TTimer;
    lbPrinter: TLabel;
    btnUpdate: TButton;
    btnVerify: TButton;
    spHelp: TSpeedButton;
    btnVideo: TSpeedButton;
    grdVerifySearchDBScanDate: TcxGridDBColumn;
    grdVerifySearchDBDBColumn1: TcxGridDBColumn;
    pnEqualOrder: TPanel;
    lbEqual: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btExcelClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btFilterClick(Sender: TObject);
    procedure quVerifyAfterOpen(DataSet: TDataSet);
    procedure chkPrintClick(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure btnVerifyClick(Sender: TObject);
    procedure grdVerifySearchDBCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnUpdateClick(Sender: TObject);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    //amfsouza 12.10.2010 - if <> NULL via non import PO.
    FpurchaseType: Integer;
    FEnterDate: TDateTime;
    FCountModel: integer;
    fTaxCalcTax : Boolean;
    FHasUpdate  : Boolean;
    FIDPurchase : Integer;
    FIDModel    : Integer;
    FIDVendor   : Integer;
    AView       : TcxCustomGridTableView;
    DMCalcTax   : TDMCalcTax;
    FPrinter    : String;
    FIsInvoicePresent: Boolean;
    
    FItemPurchase: TClientDataset;
    FItemVerification: TClientDataset;
    FVerifyItems: TClientDataset;

    dsGrid: TDataSource;

    function getModelFromBarcode(argIdModel: String): String;
    //amfsouza 03.18.2011
    function getLastScanDate(idbarcode: String): TDatetime;
    //amfsouza 12.10.2010
    procedure InsertPurchaseItem;
    function ReceivingExist : Boolean;

    function InsertItemInPurchaseVerification(AIDModel : Variant; AQtyRec,
       AQtyCounted : Double; ABarcode : String) : Boolean;
    function UpdateItemInPurchaseVerification(AIDBarcode : String; AID : Integer; AQtyCounted : Double) : Boolean;
    function SearchItem(AIDModel: Integer; AIDBarcode : String; var AID: Integer; var AQtyCounted : Double) : Boolean;

    procedure StartVerification();
    procedure RefreshVerify();

    //amfsouza 05.04.2012 - passing suggestion retail parameter
    function PrintUPC(AModel, ABarcode, ADescription : String;
       AQty: Integer; ASellingPrice, sugg_retail: Currency): Boolean;

    procedure UpdateReceivingTotal;
    function AdjustReceivingQty(AIDModel, AIDPPItem : Integer; ACaseQtyScan,
         AQtyScan, AQtyRec : Double; ACostPrice : Currency) : Boolean;
    function InsertReceiving(AIDModel, AIDGroup, AIDVendor : Integer; AQtyScan,
       ACaseQty : Double; ACost, ASale, ASugg : Currency) : Boolean;
    function RemoveReceiving(AIDPPI : Integer) : Boolean;
    function AlreadyWasUpdated: boolean;
    procedure EnabledComponents(AUpdated: boolean);

    // Antonio 04/26/2017
    procedure DealWithPositiveQuantityReceiving();

    // Antonio 06-26-2017
    function GetModelInfo(argIdModel: String): TADOQuery;
    procedure LoadModelInfo(argModel, argIdBarcode, argDescription: String; argPrice, argSuggRetail: Currency);
    function ItemFoundInPurchaseVerification(argIdPurchase, argIdModel: Integer): Boolean;
    function ItemFoundInPurchase(argIdModel: Integer; argIdBarcode: String): Boolean;

    procedure SetDataSourceGrid(argDatasource: TDataSource);
    function CreateVerifyItems(argIdPurchase: Integer): TClientDataset;

  public
    procedure SetCountModel(const AValue: integer);
    function Start(AIDPurchase, AIDVendor : Integer; argIsInvoicePresent: Boolean = false;  argReceivingType: Integer = PURCHASE_PRE) : Boolean;
  end;

implementation

uses uDM, uSQLFunctions, uNumericFunctions, uFrmExport, uMsgBox,
   Registry, tBarcodePrint, uWebFunctions, uDMGlobal,
  uOperationSystem, uMsgConstant;

{$R *.dfm}

procedure TFrmVerifyPO.FormCreate(Sender: TObject);
var
  buildInfo: String;
begin
  inherited;

  DM.imgBTN.GetBitmap(BTN_DELETE, btnRemove.Glyph);
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
  DM.imgBTN.GetBitmap(BTN_FILTER, btFilter.Glyph);
  DM.imgBTN.GetBitmap(BTN_PREVIEW, btPrint.Glyph);

  AView := TcxCustomGridTableView(grdVerifySearch.FocusedView);

  with TRegistry.Create do
  begin
   //amfsouza 05.04.2012 - to correct keys according windows version
   if ( GetOS(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
   else
      RootKey := HKEY_LOCAL_MACHINE;

   OpenKey(REGISTRY_PATH, True);

   if not ValueExists('BarcodeReport') then
      WriteString('BarcodeReport', '');
   if not ValueExists('BarcodePrinter') then
      WriteString('BarcodePrinter', '');

   edtReportFile.Text := ReadString('BarcodeReport');
   FPrinter           := ReadString('BarcodePrinter');
   Free;
  end;

  lbPrinter.Caption := FPrinter;
  DMCalcTax := TDMCalcTax.Create(Self);
  DMCalcTax.ADODBConnect := DM.ADODBConnect;

  dsGrid := TDataSource.Create(Self);

end;

function TFrmVerifyPO.Start(AIDPurchase, AIDVendor: Integer; argIsInvoicePresent: Boolean; argReceivingType: Integer): Boolean;
var
  AOptions: TcxGridStorageOptions;
  ASaveViewName, fRegistryPath : String;
begin
  FIDPurchase := AIDPurchase;

  FIDVendor := AIDVendor;

  StartVerification();

//  RefreshVerify();
  edtBarcode.RunSecondSQL := True;
  FHasUpdate := False;
  fTaxCalcTax := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  // Antonio 04/26/2017 to control verify and update buttons ( is a quite different depending on purchase type.
  Self.FpurchaseType := argReceivingType;
  self.FIsInvoicePresent := argIsInvoicePresent;

  chkPrint.Checked := false;

  RefreshVerify();

  ShowModal;

  //Saval para o registry
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

  Result := FHasUpdate;

end;

procedure TFrmVerifyPO.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(DMCalcTax);

  if ( FItemPurchase <> nil ) then
     FreeAndNil(FItemPurchase);

  if ( FItemVerification <> nil ) then
     FreeAndNil(FItemVerification);

  if ( FVerifyItems <> nil ) then
     FreeAndNil(FVerifyItems);


  inherited;
  Action := caFree;
end;

procedure TFrmVerifyPO.InsertPurchaseItem;
var
  _sumByModel: TClientDataset;
begin
    try
        _sumByModel := dm.GetSumByModelInPurchase(FIdPurchase);

        if ( ReceivingExist ) then begin
           UpdateItemInPurchaseVerification(_sumByModel.FieldByName('barcode').Value
                                            , _sumByModel.FieldByName('IdPurchaseVerify').Value
                                            ,_sumByModel.fieldByName('Qty').Value );
        end else begin
                while ( not _sumByModel.Eof ) do begin
                     InsertItemInPurchaseVerification(_sumByModel.fieldByName('IdModel').Value
                                                      , _sumByModel.fieldByName('Qty').Value
                                                      , 0
                                                      , _sumByModel.FieldByName('barcode').Value);
                     _sumByModel.Next();

                end;
            end;
   finally
        FreeAndNil(_sumByModel);
   end;
end;

function TFrmVerifyPO.InsertItemInPurchaseVerification(AIDModel : Variant; AQtyRec,
   AQtyCounted : Double; ABarcode : String): Boolean;
var
  _idPurchaseVerify: Integer;
  _idUser: Integer;
  _lastScanDate: TDatetime;
begin
    result := false;

    try
       _idPurchaseVerify := DM.GetNextID('Pur_PurchaseVerify.IDPurchaseVerify');
       _idUser           := DM.fUser.ID;
       _lastScanDate     := getLastScanDate(ABarcode);

       if (_lastScanDate = 0) then begin
          _lastScanDate := now;
       end;

       dm.InsertItemToPurchaseVerification(_idPurchaseVerify
                                           ,FIDPurchase
                                           ,_idUser
                                           ,AIdModel
                                           ,ABarcode
                                           ,AqtyRec
                                           ,AqtyCounted
                                           ,_lastScanDate);

       result := true;
    except
       result := false;
    end;

  (*
  with cmdInsertVerify do
  begin
    Parameters.ParamByName('IDPurchaseVerify').Value := DM.GetNextID('Pur_PurchaseVerify.IDPurchaseVerify');
    Parameters.ParamByName('IDPurchase').Value       := FIDPurchase;
    Parameters.ParamByName('IDUser').Value           := DM.fUser.ID;
    if AIDModel <> -1 then
      Parameters.ParamByName('IDModel').Value        := AIDModel
    else
      Parameters.ParamByName('IDModel').Value        := Null;
    Parameters.ParamByName('IDBarcode').Value        := ABarcode;
    Parameters.ParamByName('QtyReceiving').Value     := AQtyRec;
    Parameters.ParamByName('QtyCounted').Value       := AQtyCounted;
    Parameters.ParamByName('EnterDate').Value        := Null;
    //amfsouza 03.18.2011 - new field
    Parameters.ParamByName('scandate').Value         := getLastScanDate(ABarcode);
    Execute;
  end;

  *)

end;


function TFrmVerifyPO.ReceivingExist: Boolean;
begin

 with DM.quFreeSQL do
 try
   if Active then
     Close;
   SQL.Clear;
   SQL.Add('SELECT IDPurchase FROM Pur_PurchaseVerify WHERE IDPurchase = :IDPurchase');
   Parameters.ParamByName('IDPurchase').Value := FIDPurchase;
   Open;
   Result := not IsEmpty;
 finally
   Close;
 end;

end;

procedure TFrmVerifyPO.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  _id, _idModel : Integer;
  _qty, _qtyExtracted : Double;
  _barcode : String;
  _qtyCounted: Double;
begin
  inherited;

  _barcode := edtBarcode.Text;
  _qtyCounted := 0;

  if Trim(_barcode) <> '' then
  begin
    _qty := StrToFloatDef(edtBarcode.QtyEdit.Text, 1);
    _qtyCounted := _qty;
    _qtyExtracted := _qty;

    _idModel := StrToIntDef(VarToStr(edtBarcode.GetFieldValue('IDModel')), -1);
    lbBarcodeResult.Caption := _barcode;

    if ( ItemFoundInPurchase(_idModel, _barcode)) then begin

        if (ItemFoundInPurchaseVerification(FIDPurchase, _idModel)) then begin
            _qtyCounted := _qtyCounted + FItemVerification.fieldByName('QtyCounted').Value;
            UpdateItemInPurchaseVerification(_barcode
                                             ,FItemVerification.fieldByName('IdPurchaseVerify').Value
                                             ,_qtyCounted);
        end else begin
                InsertItemInPurchaseVerification(_idModel, FItemPurchase.FieldByName('QtyReceiving').Value
                                                 , _qtyExtracted, _barcode);
            end;

    end else begin
            // inserir o item no purchase verify com quantidade igual a escaneada
        end;

    dsGrid.DataSet := dm.SelectItemsFromPurchaseVerification(FIDPurchase);
    SetDataSourceGrid(dsGrid);
    quVerifyAfterOpen(dsGrid.DataSet);
    
    tmrRefresh.Enabled := False;
    tmrRefresh.Enabled := True;
    edtBarcode.Clear;
    edtBarcode.SetFocus;
    
  end;

end;

function TFrmVerifyPO.UpdateItemInPurchaseVerification(AIDBarcode : String; AID: Integer;
  AQtyCounted: Double): Boolean;
begin
   result := false;
   try
      dm.UpdateItemToPurchaseVerification(dm.fUser.ID, AID, AIDBarcode, AQtyCounted);
      result := true;
   except
      result := false;
   end;

end;

function TFrmVerifyPO.SearchItem(AIDModel: Integer; AIDBarcode : String;
  var AID : Integer; var AQtyCounted: Double): Boolean;
var
  _model, _description: String;
  _salePrice: Currency;
  suggRetail: Currency;
  dsModel: TADOQuery;
begin

  (*
  Result := False;

  // verify if model is verified on this purchase (purchase verify )
     LoadModelInfo(quItemSearch.fieldByname('Model').AsString,
                   AIDBarcode,
                   quItemSearch.fieldByname('Description').AsString,
                   quItemSearch.fieldByname('SellingPrice').AsCurrency,
                   quItemSearch.FieldByname('SuggRetail').AsCurrency);
     AQtyCounted   := AQtyCounted + quItemSearchQtyCounted.AsFloat;
     result := true;
  end else begin
          // verify if model is in table
          dsModel := GetModelInfo(IntToStr(AIDModel));
          if (not dsModel.IsEmpty) then begin
             LoadModelInfo(dsModel.fieldByName('model').AsString,
                           AIDBarcode,
                           dsModel.fieldByName('description').AsString,
                           dsModel.FieldByName('SellingPrice').Value,
                           dsModel.fieldByName('SuggRetail').Value) ;
          end;
      end;

(*
  if (chkPrint.Checked) then begin
      PrintUPC();
  end;

  with quItemSearch do
  try
    if Active then
      Close;
    if AIDModel = -1 then
    begin
      Parameters.ParamByName('IDModel').Value   := Null;
      Parameters.ParamByName('IDBarcode').Value := AIDBarcode;
    end
    else
    begin
      Parameters.ParamByName('IDModel').Value   := AIDModel;
      Parameters.ParamByName('IDBarcode').Value := Null;
    end;

    Parameters.ParamByName('IDPurchase').Value := FIDPurchase;
    Open;

//    pnlastScan.Visible := ( not isEmpty );
    pnLastScan.Visible   := true;

    dsModel := TAdoquery.Create(nil);
    dsModel.Connection := dm.ADODBConnect;
    dsModel.sql.Text := getModelFromBarcode(AIdBarcode);
    dsModel.Parameters.ParamByName('idbarcode').value := AIdbarcode;
    dsModel.Open;

    if ( not dsModel.IsEmpty ) then begin
      lbModelResult.Caption := dsModel.fieldByname('Model').Value;
      lbDescResult.Caption  := dsModel.fieldByname('Description').Value;
      lbPriceResult.Caption := FormatCurr('#,##0.00', dsModel.fieldByName('SellingPrice').Value);
    end
    else begin
      lbDescResult.Caption  := '';
      lbPriceResult.Caption := '';
    end;


    freeAndNil(dsModel);

    if not IsEmpty then
    begin
      AID                   := quItemSearchIDPurchaseVerify.AsInteger;
      AQtyCounted           := AQtyCounted + quItemSearchQtyCounted.AsFloat;
      lbModelResult.Caption := quItemSearchModel.AsString;
      lbDescResult.Caption  := quItemSearchDescription.AsString;
      lbPriceResult.Caption := FormatCurr('#,##0.00', quItemSearchSellingPrice.AsCurrency);
      Result                := True;
    end;

    if IsEmpty or (quItemSearchQtyReceiving.AsFloat = 0) then
      MessageBeep(MB_ICONERROR);

    if (chkPrint.Checked) then
    begin
      sModel := '';

      if (quItemSearchModel.AsString <> '') then
      begin
        sModel      := quItemSearchModel.AsString;
        Description := quItemSearchDescription.AsString;
        cSalePrice  := quItemSearchSellingPrice.AsCurrency;
      end
      else
      begin
        with quModelSearch do
        try
          if AIDModel = -1 then
          begin
            Parameters.ParamByName('IDModel').Value   := Null;
            Parameters.ParamByName('IDBarcode').Value := AIDBarcode;
          end
          else
          begin
            Parameters.ParamByName('IDModel').Value   := AIDModel;
            Parameters.ParamByName('IDBarcode').Value := Null;
          end;
          Open;

          if not IsEmpty then
          begin
            sModel      := quModelSearchModel.AsString;
            Description := quModelSearchDescription.AsString;
            cSalePrice  := quModelSearchSellingPrice.AsCurrency;
            suggRetail  := quModelSearchSuggRetail.AsCurrency;
          end;

        finally
          Close;
        end;
      end;

      if sModel <> '' then
        PrintUPC(sModel, AIDBarcode, Description, 1, cSalePrice, suggRetail);
    end;

  finally
    Close;
  end;

  *)

end;

procedure TFrmVerifyPO.FormShow(Sender: TObject);
begin
  inherited;
  edtBarcode.SetFocus;
  btnUpdate.Enabled := true;
  btnVerify.Enabled := true;
  EnabledComponents(AlreadyWasUpdated);
end;

procedure TFrmVerifyPO.btnRemoveClick(Sender: TObject);
var
  sSQL : String;
begin
  inherited;

  if (not FVerifyItems.IsEmpty) then begin
    sSQL := 'DELETE Pur_PurchaseVerify ' +
            'WHERE IDPurchaseVerify = ' + FVerifyItems.FieldByName('IDPurchaseVerify').AsString;
    DM.RunSQL(sSQL);

    RefreshVerify();

    edtBarcode.Clear;
    edtBarcode.SetFocus;
  end;

end;

procedure TFrmVerifyPO.btExcelClick(Sender: TObject);
begin
  inherited;

  if ( FVerifyItems.Active and ( not FVerifyItems.IsEmpty ) ) then begin
     with TfrmExport.Create(self) do
         Start(grdVerifySearch, lblSubMenu.Caption);
  end;
end;

procedure TFrmVerifyPO.btGroupClick(Sender: TObject);
begin
  inherited;

  if btGroup.Down then
    begin
      TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdVerifySearch do
      begin
        while TcxGridDBTableView(AView).GroupedItemCount > 0 do
          TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
        TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
      end;
    end;
  
end;

procedure TFrmVerifyPO.btColumnClick(Sender: TObject);
begin
  inherited;

  // Mostra a coluna de customizing do grid
  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
  
end;

procedure TFrmVerifyPO.btFilterClick(Sender: TObject);
begin
  inherited;

  if btFilter.Down then
    begin
    TcxGridDBTableView(AView).Filtering.Visible := fvAlways;
    TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := True;
    end
  else
    begin
    TcxGridDBTableView(AView).Filtering.Visible := fvNever;
    TcxGridDBTableView(AView).OptionsCustomize.ColumnFiltering := False;
    end;

end;

procedure TFrmVerifyPO.quVerifyAfterOpen(DataSet: TDataSet);
var
  dTotRec, dTotCount : Double;
begin
  inherited;

  if grdVerifySearchDB.DataController.Summary.FooterSummaryValues[1] <> null then
     dTotCount := grdVerifySearchDB.DataController.Summary.FooterSummaryValues[1];

  if grdVerifySearchDB.DataController.Summary.FooterSummaryValues[0] <> null then
     dTotRec := grdVerifySearchDB.DataController.Summary.FooterSummaryValues[0];

  lbTotCounted.Caption := FormatFloat('0.##', dTotCount);
  lbTotPO.Caption := FormatFloat('0.##', dTotRec);
  lbTotDiff.Caption := FormatFloat('0.##', dTotCount - dTotRec);

end;

procedure TFrmVerifyPO.chkPrintClick(Sender: TObject);
begin
  inherited;
  edtReportFile.Visible := chkPrint.Checked;
  btnOpenFile.Visible   := chkPrint.Checked;
  lbPrinter.Visible     := chkPrint.Checked;
end;

procedure TFrmVerifyPO.btnOpenFileClick(Sender: TObject);
begin
  inherited;

  if OD.Execute then
    edtReportFile.Text := OD.FileName;

end;

procedure TFrmVerifyPO.btPrintClick(Sender: TObject);
begin
  inherited;

  if ( (chkPrint.Checked) and
       (FVerifyItems.Active) and
       ( not FVerifyItems.IsEmpty) and
       (FVerifyItems.FieldByName('IdModel').AsString <> '') ) then begin

       PrintUPC(FVerifyItems.fieldByName('Model').AsString
              , FVerifyItems.FieldByName('IdBarcode').AsString
              , FVerifyItems.FieldByName('Description').AsString
              , udCopy.Position
              , FVerifyItems.FieldByName('SellingPrice').AsCurrency
              , FVerifyItems.FieldByName('SuggRetail').AsCurrency);

  end

end;

function TFrmVerifyPO.PrintUPC(AModel, ABarcode, ADescription: String;
  AQty: Integer; ASellingPrice, sugg_retail: Currency): Boolean;
var
  AThreadBarcodePrint : TThreadBarcodePrint;
begin

  if (chkPrint.Checked) then
  try
    AThreadBarcodePrint := TThreadBarcodePrint.Create(True);
    AThreadBarcodePrint.Priority := tpLower;
    AThreadBarcodePrint.FreeOnTerminate := True;
    AThreadBarcodePrint.SetReport(edtReportFile.Text, FPrinter);
    AThreadBarcodePrint.AddBarcode(AModel, ABarcode, ADescription, AQty, ASellingPrice, sugg_retail );
    if AThreadBarcodePrint.Suspended then
      AThreadBarcodePrint.Resume;

  finally
  end;

end;

procedure TFrmVerifyPO.btnVerifyClick(Sender: TObject);
var
  sWhere : String;
begin
  inherited;
  //CloseVerify;
  //sWhere := ' PV.IDPurchase = ' + IntToStr(FIDPurchase);
  //OpenVerify(sWhere);
  RefreshVerify();

  btnUpdate.Visible := ( (self.FpurchaseType = PURCHASE_FINAL) and (self.FIsInvoicePresent) ); // turn "update button" visible
  btnVerify.Enabled := ( (self.FpurchaseType = PURCHASE_PRE) or (not self.FIsInvoicePresent) );   // disable verify if "final receiving"

end;

procedure TFrmVerifyPO.grdVerifySearchDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if AViewInfo.GridRecord.Values[grdVerifySearchDBModel.Index] = NULL then
    ACanvas.Font.Color := pnlBadItem.Color
  else if AViewInfo.GridRecord.Values[grdVerifySearchDBDifference.Index] > '0' then
      ACanvas.Font.Color := pnlGreaterQty.Color
  else if AViewInfo.GridRecord.Values[grdVerifySearchDBDifference.Index] < '0' then
      ACanvas.Font.Color := pnlLessQty.Color
  else
    ACanvas.Font.Color := clBlack;

end;

procedure TFrmVerifyPO.btnUpdateClick(Sender: TObject);
begin
  inherited;

  if (MsgBox(MSG_QST_CONFIRM_NICE, vbYesNo + vbQuestion) = vbYes) then begin
    try

      // update should activate once time.
      btnUpdate.Enabled := false;

      RefreshVerify();

      FVerifyItems.DisableControls;
      FVerifyItems.First;

      DM.ADODBConnect.BeginTrans;
      try
        while ( not FVerifyItems.Eof ) do begin
           if ( FVerifyItems.FieldByName('IdModel').Value > 0 ) then begin
              if ( FVerifyItems.FieldByName('QtyCounted').Value > 0 ) then begin  // counted means scaned on receiving.
                  DealWithPositiveQuantityReceiving();
                  FHasUpdate := true;
              end else if( FVerifyItems.FieldByName('IdPurchase').Value > 0 ) then begin//Remove Item
                     RemoveReceiving(FVerifyItems.FieldByName('IDPurchaseItem').AsInteger);
                     FHasUpdate := true;
                  end;
           end;

           FVerifyItems.Next;

        end;

        UpdateReceivingTotal();

        DM.ADODBConnect.CommitTrans;
        btnUpdate.Enabled  := false;
        edtBarcode.Enabled := btnUpdate.Enabled;
        btnRemove.Enabled  := edtBarCode.Enabled;

        RefreshVerify();

      except
        DM.ADODBConnect.RollbackTrans;
        raise;
      end;

    finally
      FVerifyItems.EnableControls;
    end;

    FVerifyItems.Close;
  end;
end;


procedure TFrmVerifyPO.DealWithPositiveQuantityReceiving();
begin

    if (FVerifyItems.FieldByName('QtyCounted').AsFloat <= FVerifyItems.FieldByName('QtyReceiving').AsFloat) then begin
       FHasUpdate := TRUE;
       AdjustReceivingQty(FVerifyItems.FieldByName('IdModel').AsInteger,
                          FVerifyItems.FieldByName('IDPurchaseItem').AsInteger,
                          FVerifyItems.FieldByName('CaseQty').AsFloat,
                          FVerifyItems.FieldByName('QtyCounted').AsFloat,
                          FVerifyItems.FieldByName('QtyReceiving').AsFloat,
                          FVerifyItems.FieldByName('PurchaseCost').AsCurrency);

    end else begin
            fHasUpdate := true;
            InsertReceiving(FVerifyItems.FieldByName('IDModel').AsInteger,
                            FVerifyItems.FieldByName('IDGroup').AsInteger,
                            FIDVendor,
                            FVerifyItems.FieldByName('QtyCounted').AsFloat,
                            FVerifyItems.FieldByName('CaseQty').AsFloat,
                            FVerifyItems.FieldByName('FinalCost').AsCurrency,
                            FVerifyItems.FieldByName('SellingPrice').AsCurrency,
                            FVerifyItems.FieldByName('SuggRetail').AsCurrency);
        end;

end;


procedure TFrmVerifyPO.UpdateReceivingTotal;
begin
  DM.RunSQL('EXEC sp_Purchase_AtuPurchaseSubTotal ' + IntToStr(FIDPurchase) + ', ' + IntToStr(Byte(fTaxCalcTax)));
end;

function TFrmVerifyPO.AdjustReceivingQty(AIDModel, AIDPPItem : Integer; ACaseQtyScan,
         AQtyScan, AQtyRec : Double; ACostPrice : Currency): Boolean;
begin
   result  := FALSE;
   try
      dm.UpdateReceiving(AIDModel, AIDPPItem, ACaseQtyScan, AQtyScan, AQtyRec, ACostPrice, fTaxCalcTax);
      result := TRUE;
   except
      result := FALSE;
   end;

end;

function TFrmVerifyPO.InsertReceiving(AIDModel, AIDGroup, AIDVendor : Integer; AQtyScan,
   ACaseQty : Double; ACost, ASale, ASugg : Currency): Boolean;
begin
   try
      result := FALSE;

      dm.InsertReceiving(FIDPurchase, AIDModel, AIDGroup, AIDVendor, AQtyScan, ACaseQty, ACost, ASale, ASugg, fTaxCalcTax);

      result := TRUE;
   except
      result := FALSE;
   end;
end;

function TFrmVerifyPO.RemoveReceiving(AIDPPI: Integer): Boolean;
begin

  with spRemoveItem do
  begin
    Parameters.ParambyName('@IDPurchase').Value     := FIDPurchase;
    Parameters.ParambyName('@IDPurchaseItem').Value := AIDPPI;
    Parameters.ParambyName('@TaxInCost').Value      := fTaxCalcTax;
    ExecProc;
  end;

end;

procedure TFrmVerifyPO.tmrRefreshTimer(Sender: TObject);
begin
  inherited;

  tmrRefresh.Enabled := False;
  RefreshVerify;
  grdVerifySearchDB.Controller.GoToFirst;
  
end;

procedure TFrmVerifyPO.spHelpClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
     // OpenURL('http://www.mainretail.com.br/treinamento/Compras/Com_ValidarRecebimento.htm');
    end;

    LANG_SPANISH :
    begin
    end;
  end;

end;

procedure TFrmVerifyPO.btnVideoClick(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
    end;

    LANG_PORTUGUESE:
    begin
    //  OpenURL('http://www.mainretail.com.br/treinamento/video/OC_Conferir_Recebimento/Conferir_Recebimento.htm');
    end;

    LANG_SPANISH :
    begin
    end;
  end;


end;


function TFrmVerifyPO.AlreadyWasUpdated: boolean;
var
  sWhere: String;
  ds: TADODataSet;
  sql: String;
begin
  try
    result          := false;
    sql := 'select * from Pur_PurchaseVerify where IdPurchase = ' + intToStr(FIdPurchase);

    ds := TADODataSet.Create(nil);
    ds.Connection := DM.ADODBConnect;
    ds.CommandText := sql; //ChangeWhereClause(quVerify.CommandText, sWhere, true);
    ds.Open;

    while ( not ds.Eof ) do begin
      result := ( not ds.FieldByName('EnterDate').IsNull );

      //amfsouza 12.10.2010
      if ( result ) then
         break;
         
      ds.next;
    end;

  finally
    freeAndNil(ds);
  end;
end;

procedure TFrmVerifyPO.setCountModel(const AValue: integer);
begin
  FCountModel := AValue;
end;

procedure TFrmVerifyPO.EnabledComponents(AUpdated: boolean);
begin
  edtBarcode.Enabled := ( not AUpdated );

  if ( not edtBarCode.Enabled ) then
     edtBarcode.Color := clGray
  else
     edtBarcode.Color := $0080FFFF;

  btnVerify.Enabled  := true;
  btnRemove.Enabled  := ( not AUpdated );
  btnUpdate.Enabled  := ( not AUpdated );
end;



function TFrmVerifyPO.getLastScanDate(idbarcode: String): TDatetime;
var
  ds: TADOQuery;
  sql: String;
begin
  try
    sql := 'select max(EnterDate) EnterDate from Pur_PurchaseVerify where IdBarcode = :idbarcode';
    ds := TADOQuery.Create(nil);
    ds.Connection := dm.ADODBConnect;
    ds.SQL.Text := sql;
    ds.Parameters.ParamByName('idbarcode').Value := idbarcode;
    ds.Open;

   (* amfsouza 11.22.2011 - under test
    if ( ds.FieldByName('EnterDate').IsNull ) then
        result := now
    else
       result := ds.FieldByName('EnterDate').Value;
   *)

    result := now();

  finally
    freeAndNil(ds);
  end;
end;

function TFrmVerifyPO.getModelFromBarcode(argIdModel: String): String;
begin
   result := 'select model, description, sellingPrice, SuggRetail ' +
          'from model m ' +
          'join barcode b on m.idmodel = b.idmodel ' +
          'where b.idModel = :idModel       ';
end;

function TFrmVerifyPO.GetModelInfo(argIdModel: String): TADOQuery;
var
   dsModel: TADOQuery;
begin
    dsModel := TAdoquery.Create(nil);
    dsModel.Connection := dm.ADODBConnect;
    dsModel.sql.Text := getModelFromBarcode(argIdModel);
    dsModel.Parameters.ParamByName('idModel').value := argIdModel;
    dsModel.Open;

    Result := dsModel;

end;


procedure TFrmVerifyPO.LoadModelInfo(argModel, argIdBarcode, argDescription: String; argPrice, argSuggRetail: Currency);
begin
   lbModelResult.Caption := argModel;
   lbDescResult.Caption  := argDescription;
   lbPriceResult.Caption := FormatCurr('#,##0.00', argPrice);

   if (chkPrint.Checked) then begin
      PrintUPC(argModel, argIDBarcode, argDescription, 1, argPrice, argSuggRetail);
   end;

end;

function TFrmVerifyPO.ItemFoundInPurchaseVerification(argIdPurchase, argIdModel: Integer): Boolean;
begin

   FItemVerification := dm.SelectItemFromPurchaseVerification(argIdPurchase, argIdModel);
   result := not FItemVerification.IsEmpty;

end;

function TFrmVerifyPO.ItemFoundInPurchase(argIdModel: Integer;
  argIdBarcode: String): Boolean;
begin
   result := FALSE;

   if ( argIdModel = -1 ) then begin
      FItemPurchase := dm.SelectItemInPurchase(FIdPurchase, argIdBarcode);

   end else begin
          FItemPurchase := dm.SelectItemInPurchase(FIdPurchase, argIdModel);
       end;

   result  := ( not FItemPurchase.IsEmpty );

end;

procedure TFrmVerifyPO.SetDataSourceGrid(argDataSource: TDataSource);
begin
   grdVerifySearchDB.DataController.DataSource := dsGrid;
end;

function TFrmVerifyPO.CreateVerifyItems(argIdPurchase: Integer): TClientDataset;
begin
   if ( FVerifyItems = nil ) then begin
      result := dm.SelectItemsFromPurchaseVerification(argIdPurchase);
   end else begin
           FVerifyItems.Close();
           FVerifyItems.Open(); 
           result := FVerifyItems;
       end;

end;

procedure TFrmVerifyPO.RefreshVerify;
begin

   FVerifyItems := CreateVerifyItems(FIdPurchase);
   dsGrid.DataSet := FVerifyItems;
   grdVerifySearchDB.DataController.DataSource := dsGrid;

end;

procedure TFrmVerifyPO.StartVerification();
var
  _sumByModel: TClientDataset;
begin
    try
        _sumByModel := dm.GetSumByModelInPurchase(FIdPurchase);

        if ( ReceivingExist ) then begin
           RefreshVerify();
        end else begin
                while ( not _sumByModel.Eof ) do begin
                     InsertItemInPurchaseVerification(_sumByModel.fieldByName('IdModel').Value
                                                      , _sumByModel.fieldByName('Qty').Value
                                                      , 0
                                                      , _sumByModel.FieldByName('barcode').Value);
                     _sumByModel.Next();

                end;
                RefreshVerify();
            end;
   finally
        FreeAndNil(_sumByModel);
   end;

end;

end.
