unit uFchTransferModel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichasBrowse, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, DBCtrls, StdCtrls, Mask, SuperComboADO, FormConfig,
  ADODB, PowerADOQuery, siComp, siLangRT, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGrid, ComCtrls, LblEffct, ExtCtrls,
  Buttons, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu, DateBox, Menus;

type
  TFchTransferModel = class(TbrwFrmParentBrw)
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cmbLojaOrigem: TDBSuperComboADO;
    cmbLojaDestino: TDBSuperComboADO;
    cbmUser: TDBSuperComboADO;
    quFormIDModelTransf: TIntegerField;
    quFormIDLojaOrigem: TIntegerField;
    quFormIDLojaDestino: TIntegerField;
    quFormData: TDateTimeField;
    quFormIDUser: TIntegerField;
    quBrowseIDModel: TIntegerField;
    quBrowseModel: TStringField;
    quBrowseDescription: TStringField;
    quBrowseVendorCost: TBCDField;
    quBrowseDateLastCost: TDateTimeField;
    quBrowseSellingPrice: TBCDField;
    quBrowseDateLastSellingPrice: TDateTimeField;
    quBrowseLastCost: TBCDField;
    quBrowseSuggRetail: TBCDField;
    quBrowseOtherCost: TBCDField;
    quBrowseFreightCost: TBCDField;
    quBrowseIDModelTransfDet: TIntegerField;
    quBrowseIDModelTransf: TIntegerField;
    quBrowseFinalCost: TCurrencyField;
    quBrowseTotalLastCost: TCurrencyField;
    quBrowseTotalSellingPrice: TCurrencyField;
    quBrowseTotalSuggRetail: TCurrencyField;
    quBrowseTotalFinalCost: TCurrencyField;
    grdBrowseDBIDModel: TcxGridDBColumn;
    grdBrowseDBModel: TcxGridDBColumn;
    grdBrowseDBDescription: TcxGridDBColumn;
    grdBrowseDBVendorCost: TcxGridDBColumn;
    grdBrowseDBDateLastCost: TcxGridDBColumn;
    grdBrowseDBSellingPrice: TcxGridDBColumn;
    grdBrowseDBDateLastSellingPrice: TcxGridDBColumn;
    grdBrowseDBLastCost: TcxGridDBColumn;
    grdBrowseDBSuggRetail: TcxGridDBColumn;
    grdBrowseDBOtherCost: TcxGridDBColumn;
    grdBrowseDBFreightCost: TcxGridDBColumn;
    grdBrowseDBQtyOnHand: TcxGridDBColumn;
    grdBrowseDBIDModelTransfDet: TcxGridDBColumn;
    grdBrowseDBIDModelTransf: TcxGridDBColumn;
    grdBrowseDBQtyTransfer: TcxGridDBColumn;
    grdBrowseDBFinalCost: TcxGridDBColumn;
    grdBrowseDBTotalLastCost: TcxGridDBColumn;
    grdBrowseDBTotalSellingPrice: TcxGridDBColumn;
    grdBrowseDBTotalSuggRetail: TcxGridDBColumn;
    grdBrowseDBTotalFinalCost: TcxGridDBColumn;
    quFormNumber: TStringField;
    quFormTransferType: TBooleanField;
    lbNumber: TLabel;
    dbNumber: TDBEdit;
    rbType: TDBRadioGroup;
    spDelInventoryMov: TADOStoredProc;
    quBrowseCostPrice: TBCDField;
    quBrowseTotalCost: TCurrencyField;
    grdBrowseDBCostPrice: TcxGridDBColumn;
    grdBrowseDBTotalCost: TcxGridDBColumn;
    btnPrintBarcode: TSpeedButton;
    Panel7: TPanel;
    quBrowseQtyOnHand: TFloatField;
    quBrowseQtyTransfer: TFloatField;
    quOriginalTransfer: TADODataSet;
    quOriginalTransferIDLojaOrigem: TIntegerField;
    quOriginalTransferIDLojaDestino: TIntegerField;
    quOriginalTransferNumber: TStringField;
    quFormImported: TBooleanField;
    edtDate: TDBDateBox;
    quBrowseManufacturer: TStringField;
    grdBrowseDBManufacturer: TcxGridDBColumn;
    quBrowseCaseQty: TFloatField;
    grdBrowseDBCaseQty: TcxGridDBColumn;
    btnAddQuick: TSpeedButton;
    PopNew: TPopupMenu;
    menuQuickEntry: TMenuItem;
    menuAdd: TMenuItem;
    cmdUpdAVGCost: TADOCommand;
    cmdInsInventoryMov: TADOCommand;
    quTransfModel: TADODataSet;
    quTransfPackModel: TADODataSet;
    quHasInventory: TADODataSet;
    cmdInsertInventory: TADOCommand;
    quInventoryMovOld: TADODataSet;
    cmdUpdModelAVGCost: TADOCommand;
    cmdUpdInventoryAVGCost: TADOCommand;
    cmdUpdTransfOUT: TADOCommand;
    quTransfSerial: TADOQuery;
    quTransfSerialIDModelTransfSerial: TIntegerField;
    quTransfSerialIDModelTransfDet: TIntegerField;
    quTransfSerialSerialNum: TStringField;
    lblCFOP: TLabel;
    scCFOP: TDBSuperComboADO;
    quFormIDCFOP: TIntegerField;
    quBrowseLot: TStringField;
    quBrowseUseLot: TBooleanField;
    grdBrowseDBUseLot: TcxGridDBColumn;
    grdBrowseDBLot: TcxGridDBColumn;
    quBrowseIDLote: TIntegerField;
    quFormOBS: TStringField;
    lbOBS: TLabel;
    memOBS: TDBMemo;
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure btAddClick(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure btnPrintBarcodeClick(Sender: TObject);
    procedure btnAddQuickClick(Sender: TObject);
    procedure menuQuickEntryClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    FIDTransfer: Integer;
    FIDTransferOUT : Integer;
    FDoError : String;
    FOut : String;
    FIsInc : Boolean;
    procedure AddItens(ALista: TList);
    procedure RefreshLista;
    procedure OpenModelTransfDet;
    procedure CloseModelTransfDet;
    procedure SetTransferPrinted;

    function DoTransfer : Boolean;
    function DoTransferItem : Boolean;
    function UpdateTransferOut : Boolean;
    procedure OpenDataSets;
    function RemoveInventoryMov : Boolean;
    function RemoveLot : Boolean;
    function UpdateAVGCost : Boolean;
    procedure UpdateModelAVGCost(AIDModel: Integer; AQty: Double; AAvgCost: Currency);
    procedure UpdateInventoryAVGCost(AIDStore, AIDModel: Integer; AQty: Double; AAvgCost: Currency);
    procedure InsertInventory(AIDStore, AIDModel: Integer);
    procedure InsertInventoryMov(AIDDocument, AIDStore, AIDModel, AIDUser,
      AIDPreInventoryMov: Integer; AMovDate: TDateTime; AQty: Double; ACostPrice,
      AAvgCost: Currency);
    procedure UpdateLot(AIDStore, AIDModel, AIDLot, AType : Integer; AQty: Double);
    procedure CloseDataSets;
    procedure SetEnabledButtons;
    procedure SetLockedFields;

    function TranferNumberExists(AType: Integer; ANumber: String): Boolean;
    function ValidateStores: Boolean;
    procedure InsertSerial(IDLojaDestino, IDLojaOrigem: Integer; IDModelTransfDet: String);

    function ValidateLot : Boolean;
  protected
    procedure OnBeforeShow; override;
    procedure OnCreateFicha; override;
    procedure OnAfterRollBack; override;

    function BeforeChange: Boolean; override;
    function OnValidadeField: boolean; override;
    function OnAfterSaveChange(var iError:Integer):Boolean; override;
  end;

implementation

{$R *.dfm}

uses uDM, uMsgBox, uFchTranfModelItem, uPassword, uMsgConstant, uDMGlobal,
     uSystemTypes, uFrmTransferImport, PaiDeFichas, uFrmBarcodePrint, Math,
     uParamFunctions, StrUtils, uFrmPrintTranfer, uFrmAddItems, uSystemConst,
     uNumericFunctions, uHandleError;

procedure TFchTransferModel.OnCreateFicha;
begin
  //
end;

procedure TFchTransferModel.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;
  quBrowseFinalCost.AsCurrency := quBrowseVendorCost.AsCurrency +
                                  quBrowseOtherCost.AsCurrency +
                                  quBrowseFreightCost.AsCurrency;

  if quBrowseQtyTransfer.AsFloat > 0 then
  begin
    quBrowseTotalLastCost.AsCurrency     := quBrowseQtyTransfer.AsFloat * quBrowseLastCost.AsCurrency;
    quBrowseTotalSellingPrice.AsCurrency := quBrowseQtyTransfer.AsFloat * quBrowseSellingPrice.AsCurrency;
    quBrowseTotalSuggRetail.AsCurrency   := quBrowseQtyTransfer.AsFloat * quBrowseSuggRetail.AsCurrency;
    quBrowseTotalFinalCost.AsCurrency    := quBrowseQtyTransfer.AsFloat * quBrowseFinalCost.AsCurrency;
    quBrowseTotalCost.AsCurrency         := quBrowseQtyTransfer.AsFloat * quBrowseCostPrice.AsCurrency;
  end;
end;

procedure TFchTransferModel.FormShow(Sender: TObject);
var
  FHasLot : Boolean;
begin
  inherited;
  grdBrowse.SetFocus;

  SetEnabledButtons;
  SetLockedFields;

  lblCFOP.Visible := (DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] and (DMGlobal.IDLanguage = LANG_PORTUGUESE));
  scCFOP.Visible  := lblCFOP.Visible;

  FIDTransferOUT := 0;

  labelName.Caption := 'Items to Transfer';

  if FIDTransfer <> -1 then
    with quOriginalTransfer do
    try
      Parameters.ParamByName('IDModelTransf').Value := FIDTransfer;
      Open;
      if not IsEmpty then
        if quForm.Active then
        begin
          quForm.Edit;
          quFormIDLojaOrigem.AsInteger  := quOriginalTransferIDLojaOrigem.AsInteger;
          quFormIDLojaDestino.AsInteger := quOriginalTransferIDLojaDestino.AsInteger;
          quFormData.AsDateTime         := Now;
          quFormIDUser.AsInteger        := DM.fUser.ID;
          quFormNumber.AsString         := quOriginalTransferNumber.AsString;
          quFormTransferType.AsBoolean  := True;
          //ImportData
          FIDTransferOUT                := FIDTransfer;
          with TFrmTransferImport.Create(Self) do
            if AutoStart(quFormNumber.AsString, quFormIDModelTransf.AsInteger, FIDTransferOUT, FHasLot) then
            begin
              //btCancel.Enabled := not FHasLot;
            end;
          BrowseRefresh('');
        end;
    finally
      Close;
    end;
end;

procedure TFchTransferModel.btRemoveClick(Sender: TObject);
begin
  inherited;

  // verifica se pode deletar o item;
  if (not Password.HasFuncRight(67)) then//and IsNewPreSale then
  begin
    MsgBox(MSG_INF_NOT_DEL_ITEMS_TRANFER, vbOKOnly + vbInformation);
    Exit;
  end;

  if MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes then
  begin
    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      try
        DM.ADODBConnect.BeginTrans;
        SQL.Text := 'DELETE InventoryMov FROM ModelTransfDet MTD WHERE InventoryMov.DocumentID = ' + quBrowseIDModelTransf.AsString +
                    ' AND InventoryMov.PreInventoryMovID = ' + quBrowseIDModelTransfDet.AsString + ' AND InventoryMov.InventMovTypeID in (7,8)';
        ExecSQL;
        SQL.Text := 'DELETE FROM ModelTransfDet WHERE IDModelTransfDet = ' +
                     quBrowseIDModelTransfDet.AsString;
        ExecSQL;

        SQL.Text := 'DELETE FROM ModelTransfSerial WHERE IDModelTransfDet = ' +
                     quBrowseIDModelTransfDet.AsString;
        ExecSQL;

        if quBrowse.FieldByName('IDLote').AsInteger <> 0 then
          if not quFormTransferType.AsBoolean then //Saida = 7
          begin
            UpdateLot(quFormIDLojaOrigem.AsInteger,
                      quBrowse.FieldByName('IDModel').AsInteger,
                      quBrowse.FieldByName('IDLote').AsInteger,
                      2,
                      quBrowse.FieldByName('QtyTransfer').AsFloat);
          end
          else
          begin
            UpdateLot(quFormIDLojaDestino.AsInteger,
                      quBrowse.FieldByName('IDModel').AsInteger,
                      quBrowse.FieldByName('IDLote').AsInteger,
                      3,
                      quBrowse.FieldByName('QtyTransfer').AsFloat);
          end;


        DM.ADODBConnect.CommitTrans;
        except
         DM.ADODBConnect.RollbackTrans;
        end;
    end;
    BrowseRefresh('');
    quForm.Edit;
  end;
end;

procedure TFchTransferModel.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1810);
end;

procedure TFchTransferModel.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2:
    begin
      if btAdd.Enabled and ValidateStores then
        btAddClick(nil);
    end;
    VK_F4:
    begin //Del
      if btRemove.Enabled then
        btRemoveClick(nil);
    end;
    else
      inherited;
  end;
end;

procedure TFchTransferModel.FormCreate(Sender: TObject);
begin
  inherited;
  PPageControl.ActivePage:= tsBrowse;
  brwForm := TFchTranfModelItem.Create(Self);
  FIDTransferOUT := 0;
end;

function TFchTransferModel.OnAfterSaveChange(var iError: Integer): Boolean;
begin
  try
    FDoError := '';
    Result := DoTransfer;

    if frmCommand = btInc then
      if DM.fPrintReceipt.TransferSuggestPrint then
        if MsgBox(MSG_QST_PRINT_TRANSFER, vbQuestion + vbYesNo) = vbYes then
        begin
          SetTransferPrinted;
          with TFrmPrintTransfer.Create(Self) do
            Start(quFormIDModelTransf.AsString);
        end;

  except
    Result := False;
  end;
end;

procedure TFchTransferModel.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormData.AsDateTime        := Now;
  quFormIDUser.AsInteger       := DM.fUser.ID;
  quFormIDLojaOrigem.AsInteger := DM.fStore.ID;
  quFormTransferType.AsBoolean := False;
  quFormImported.AsBoolean     := False;

  if (frmCommand = btInc) and (FIDTransfer = -1) and (DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_TRANSF]) then
  begin
    quFormNumber.AsString := IntToStr(DM.GetNextID('ModelTransf.Number'));
    dbNumber.ReadOnly := True;
    dbNumber.ParentColor := True;
  end
  else
  begin
    dbNumber.ReadOnly := False;
    dbNumber.Color := clWindow;
  end;
end;

function TFchTransferModel.OnValidadeField: boolean;
begin
  Result := True;

  if not ValidateStores then
  begin
    Result := False;
    Exit;
  end;

  if dbNumber.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_NUMBER, vbOKOnly + vbCritical);
    dbNumber.SetFocus;
    Result := False;
    Exit;
  end;

  if quFormIDLojaOrigem.AsInteger = quFormIDLojaDestino.AsInteger then
  begin
    MsgBox(MSG_INF_DIFER_STORE, vbOKOnly + vbInformation);
    Result := False;
  end;

  if TranferNumberExists(rbType.ItemIndex, quFormNumber.AsString) then
  begin
    MsgBox(MSG_INF_TRANF_NUMBER_EXISTS, vbOKOnly + vbInformation);
    dbNumber.SetFocus;
    Result := False;
  end;

  if not ValidateLot then
  begin
    Result := False;
    Exit;
  end;
  
end;

function TFchTransferModel.TranferNumberExists(AType: Integer; ANumber: String): Boolean;
var
  quNumberExists: TADOQuery;
begin

  if (cmbLojaOrigem.LookUpValue = '') or (cmbLojaDestino.LookUpValue = '') or
     (ANumber = '') then
    Exit;

  quNumberExists := TADOQuery.Create(Self);
  with quNumberExists do
    try
      quNumberExists.Connection := DM.ADODBConnect;

      SQL.Text := 'SELECT ' +
                  '  Number ' +
                  'FROM ' +
                  '  ModelTransf (NOLOCK) ' +
                  'WHERE ' +
                  '  TransferType = ' + IntToStr(AType) +
                  '  AND Number = ' + QuotedStr(ANumber) +
                  '  AND IDLojaOrigem = ' + quFormIDLojaOrigem.AsString +
                  '  AND IDLojaDestino = ' + quFormIDLojaDestino.AsString +
                  '  AND IDModelTransf <> ' + quFormIDModelTransf.AsString;
      Open;

      if IsEmpty then
        Result := False
      else
        Result := True;

    finally
      FreeAndNil(quNumberExists);
    end;
end;

procedure TFchTransferModel.btAddClick(Sender: TObject);
begin
  if ValidateStores then
  begin
    if frmCommand = btInc then
    begin
      quForm.Post;
      frmCommand := btAlt;
    end;

    if not quFormTransferType.AsBoolean then
      FOut := '0'
    else
      FOut := '1';

    BrwForm.sParam := 'IDLojaOriginal='+quFormIDLojaOrigem.AsString+';IDLojaDestino='+quFormIDLojaDestino.AsString+';Out='+FOut+';';
    inherited;
    quForm.Edit;
    SetLockedFields;
  end;
end;

procedure TFchTransferModel.btDetailClick(Sender: TObject);
begin
  // verifica se pode editar o item;
  if (not Password.HasFuncRight(68)) then//and IsNewPreSale then
  begin
    MsgBox(MSG_INF_NOT_MODI_ITEMS_TRANFER, vbOKOnly + vbInformation);
    Exit;
  end;

  if not quFormTransferType.AsBoolean then
    FOut := '0'
  else
    FOut := '1';

  BrwForm.sParam := 'IDLojaOriginal='+quFormIDLojaOrigem.AsString+';IDLojaDestino='+quFormIDLojaDestino.AsString+';Out='+FOut+';';
  inherited;
  quForm.Edit;
end;

procedure TFchTransferModel.btnPrintBarcodeClick(Sender: TObject);
begin
  inherited;
  //Print Barcode
  with TFrmBarcodePrint.Create(Self) do
    StartTransfer(quFormIDModelTransf.AsString);
end;

procedure TFchTransferModel.OnBeforeShow;
var
  bCanAccess: Boolean;
begin
  inherited;
  FIDTransfer := StrToIntDef(ParseParam(Self.sParam,'IDTransfer'),-1);

  bCanAccess := Password.HasFuncRight(70);
  grdBrowseDBCostPrice.Hidden := not bCanAccess;
  grdBrowseDBTotalCost.Hidden := not bCanAccess;
  btColumn.Enabled := bCanAccess;

  FIsInc := (frmCommand = btInc);
end;

procedure TFchTransferModel.btnAddQuickClick(Sender: TObject);
var
  P: TPoint;
begin
  inherited;
  GetCursorPos(P);
  PopNew.Popup(P.X, P.Y);
end;

procedure TFchTransferModel.menuQuickEntryClick(Sender: TObject);
var
   Lista: Tlist;
begin
  inherited;
  if ValidateStores then
  begin
    with TFrmAddItems.Create(Self) do
      Lista := Start(-1,[dcQty, dcCostPrice], [vvQty, vvCostPrice]);
    AddItens(Lista);
    RefreshLista;
  end;
end;

procedure TFchTransferModel.AddItens(ALista: TList);
var
  iIDModelTransfDet, i: Integer;
begin
  for i := 0 to Pred(ALista.Count) do
  begin
    iIDModelTransfDet := DM.GetNextID(MR_MODEL_TRANSFER_DET_ID);

    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Clear;
      SQL.Text := 'INSERT INTO ModelTransfDet(IDModelTransfDet, IDModelTransf, IDModel, Tax, Qty, CostPrice) ' +
                  ' VALUES ('+
                           IntToStr(iIDModelTransfDet) + ', ' +
                           IntToStr(quFormIDModelTransf.AsInteger) + ', ' +
                           IntToStr(TAddItem(ALista[i]).IDModel) + ', ' +
                           MyFormatDouble(TAddItem(ALista[i]).Tax, '.') + ', ' +
                           MyFormatDouble(TAddItem(ALista[i]).Qty, '.') + ', ' +
                           MyFormatCur(TAddItem(ALista[i]).VendorCost, '.') + ')';
      ExecSQL;
    end;
  end;

end;

procedure TFchTransferModel.CloseModelTransfDet;
begin
  with quBrowse do
    if Active then
      Close;
end;

procedure TFchTransferModel.OpenModelTransfDet;
begin
  with quBrowse do
    if not Active then
    begin
      Parameters.ParamByName('IDModelTransf').Value := quFormIDModelTransf.AsInteger;
      Open;
    end;
end;

procedure TFchTransferModel.RefreshLista;
begin
  CloseModelTransfDet;
  OpenModelTransfDet;
end;

procedure TFchTransferModel.btCloseClick(Sender: TObject);
begin
  if (frmCommand <> btInc) and (quFormTransferType.NewValue <> quFormTransferType.OldValue) then
    MsgBox(MSG_INF_TYPE_CHANGE, vbInformation + vbOKOnly)
  else
    inherited;
end;

procedure TFchTransferModel.SetTransferPrinted;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Text := 'UPDATE ModelTransf SET PrintDate = GetDate() WHERE IDModelTransf = ' + quFormIDModelTransf.AsString;
    ExecSQL;
  finally;
    Close;
  end;
end;

function TFchTransferModel.ValidateStores: Boolean;
begin
  Result := False;

  if cmbLojaOrigem.LookUpValue = '' then
  begin
    cmbLojaOrigem.SetFocus;
    MsgBox(MSG_CRT_NO_ORG_STORE, vbOKOnly + vbCritical);
    Exit;
  end;

  if cmbLojaDestino.LookUpValue = '' then
  begin
    cmbLojaDestino.SetFocus;
    MsgBox(MSG_CRT_NO_DES_STORE, vbOKOnly + vbCritical);
    Exit;
  end;

  Result := True;
end;

function TFchTransferModel.DoTransfer : Boolean;
begin

  Result := RemoveLot;

  if Result then
    Result := RemoveInventoryMov;

  if Result then
    Result := UpdateAVGCost;

  if Result then
    Result := DoTransferItem;

  if Result then
    Result := UpdateTransferOut;

  CloseDataSets;
end;

function TFchTransferModel.RemoveInventoryMov : Boolean;
begin

  try

    with quInventoryMovOld do
      while not Eof do
      begin
        spDelInventoryMov.Parameters.ParamByName('@IDInventoryMov').Value := FieldByName('IDInventoryMov').Value;
        spDelInventoryMov.ExecProc;
        Next;
      end;

    Result := True;

  except
    on E : Exception do
    begin
      Result := False;
      FDoError := E.Message;
    end;
  end;


end;

function TFchTransferModel.UpdateAVGCost : Boolean;
begin

  try

    with cmdUpdAVGCost do
    begin
      Parameters.ParamByName('IDModelTransf').Value := quFormIDModelTransf.Value;
      Execute;
    end;

    Result := True;

  except
    on E : Exception do
    begin
      Result := False;
      FDoError := E.Message;
    end;
  end;

end;

procedure TFchTransferModel.InsertInventoryMov(AIDDocument, AIDStore, AIDModel,
  AIDUser, AIDPreInventoryMov: Integer; AMovDate: TDateTime; AQty: Double;
  ACostPrice, AAvgCost: Currency);
var
  iIDInventoryMov: Integer;
begin
  iIDInventoryMov := DM.GetNextID('InventoryMov.IDInventoryMov');

  with cmdInsInventoryMov do
  begin
    Parameters.ParamByName('IDInventoryMov').Value := iIDInventoryMov;
    Parameters.ParamByName('DocumentID').Value := AIDDocument;
    Parameters.ParamByName('StoreIDOrigem').Value := AIDStore;
    Parameters.ParamByName('ModelID').Value := AIDModel;
    Parameters.ParamByName('TrasfDate').Value := AMovDate;
    Parameters.ParamByName('Qty').Value := AQty;
    Parameters.ParamByName('IDUser').Value := AIDUser;
    Parameters.ParamByName('PreInventoryMovID').Value := AIDPreInventoryMov;
    Parameters.ParamByName('CostPrice').Value := ACostPrice;
    Parameters.ParamByName('AvgCost').Value := AAvgCost;

    if quFormTransferType.AsBoolean then
      Parameters.ParamByName('InventMovTypeID').Value := 8
    else
      Parameters.ParamByName('InventMovTypeID').Value := 7;

    Execute;
  end;
end;

procedure TFchTransferModel.CloseDataSets;
begin
  with quInventoryMovOld do
    if Active then
      Close;

  with quTransfModel do
    if Active then
      Close;

  with quTransfPackModel do
    if Active then
      Close;

  with quHasInventory do
    if Active then
      Close;
end;

procedure TFchTransferModel.OpenDataSets;
begin
  with quInventoryMovOld do
  begin
    if Active then
      Close;

    if quFormTransferType.AsBoolean then
      Parameters.ParamByName('IDInventMovType').Value := 8
    else
      Parameters.ParamByName('IDInventMovType').Value := 7;
    Parameters.ParamByName('IDModelTransf').Value := quFormIDModelTransf.Value;
    Open;
  end;

  with quTransfModel do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDModelTransf').Value := quFormIDModelTransf.Value;
    Open;
  end;
end;

function TFchTransferModel.BeforeChange: Boolean;
begin
  Result := inherited BeforeChange;
  OpenDataSets;
end;

procedure TFchTransferModel.UpdateModelAVGCost(AIDModel: Integer; AQty: Double; AAvgCost: Currency);
begin
  with cmdUpdModelAVGCost do
  begin
    Parameters.ParamByName('IDModel').Value := AIDModel;
    Parameters.ParamByName('QtyA').Value := AQty;
    Parameters.ParamByName('QtyB').Value := AQty;
    Parameters.ParamByName('QtyC').Value := AQty;
    Parameters.ParamByName('QtyD').Value := AQty;
    Parameters.ParamByName('AvgCostA').Value := AAvgCost;
    Parameters.ParamByName('AvgCostB').Value := AAvgCost;
    Execute;
  end;
end;

procedure TFchTransferModel.InsertInventory(AIDStore, AIDModel: Integer);
var
  iIDInventory: Integer;
begin
  with quHasInventory do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDStore').Value := AIDStore;
    Parameters.ParamByName('IDModel').Value := AIDModel;
    Open;

    if IsEmpty then
    begin
      iIDInventory := DM.GetNextID('Inventory.IDInventory');
      cmdInsertInventory.Parameters.ParamByName('IDInventory').Value := iIDInventory;
      cmdInsertInventory.Parameters.ParamByName('IDStore').Value := AIDStore;
      cmdInsertInventory.Parameters.ParamByName('IDModel').Value := AIDModel;
      cmdInsertInventory.Execute;
    end;
  end;
end;

function TFchTransferModel.DoTransferItem : Boolean;
var
  iIDStore: Integer;
  sIDModelTransfDet: String;
begin

  try

    with quTransfModel do
    begin
      First;
      while not Eof do
      begin
        if quFormTransferType.AsBoolean then
        begin
          iIDStore := quFormIDLojaDestino.AsInteger;
          sIDModelTransfDet := quBrowseIDModelTransfDet.AsString;

          UpdateModelAVGCost(FieldByName('IDModel').AsInteger, FieldByName('Qty').AsFloat, FieldByName('AvgCost').AsCurrency);
          InsertInventory(iIDStore, FieldByName('IDModel').AsInteger);
          UpdateInventoryAVGCost(iIDStore, FieldByName('IDModel').AsInteger, FieldByName('Qty').AsFloat, FieldByName('AvgCost').AsCurrency);
          InsertSerial(iIDStore, FieldByName('IDLojaOrigem').AsInteger, sIDModelTransfDet);
        end
        else
          iIDStore := FieldByName('IDLojaOrigem').AsInteger;
          sIDModelTransfDet := quBrowseIDModelTransfDet.AsString;
        InsertInventoryMov(FieldByName('IDModelTransf').AsInteger,
                           iIDStore,
                           FieldByName('IDModel').AsInteger,
                           FieldByName('IDUser').AsInteger,
                           FieldByName('IDModelTransfDet').AsInteger,
                           FieldByName('Data').AsDateTime,
                           FieldByName('Qty').AsFloat,
                           FieldByName('CostPrice').AsCurrency,
                           FieldByName('AvgCost').AsCurrency);

        InsertSerial(quFormIDLojaDestino.AsInteger, iIDStore, sIDModelTransfDet);

        if FieldByName('IDLote').AsInteger <> 0 then
          if not quFormTransferType.AsBoolean then //Saida = 7
          begin
            UpdateLot(quFormIDLojaOrigem.AsInteger,
                      FieldByName('IDModel').AsInteger,
                      FieldByName('IDLote').AsInteger,
                      3,
                      FieldByName('Qty').AsFloat);
          end
          else
          begin
            UpdateLot(quFormIDLojaDestino.AsInteger,
                      FieldByName('IDModel').AsInteger,
                      FieldByName('IDLote').AsInteger,
                      2,
                      FieldByName('Qty').AsFloat);
          end;

        if quTransfPackModel.Active then
          quTransfPackModel.Close;
        quTransfPackModel.Parameters.ParamByName('IDModelTransfDet').Value := FieldByName('IDModelTransfDet').AsInteger;
        quTransfPackModel.Open;

        while not quTransfPackModel.Eof do
        begin
          InsertInventory(iIDStore, quTransfPackModel.FieldByName('IDModel').AsInteger);
          InsertInventoryMov(FieldByName('IDModelTransf').AsInteger,
                             iIDStore,
                             quTransfPackModel.FieldByName('IDModel').AsInteger,
                             FieldByName('IDUser').AsInteger,
                             FieldByName('IDModelTransfDet').AsInteger,
                             FieldByName('Data').AsDateTime,
                             quTransfPackModel.FieldByName('Qty').AsFloat,
                             quTransfPackModel.FieldByName('VendorCost').AsCurrency,
                             quTransfPackModel.FieldByName('AvgCost').AsCurrency);
          quTransfPackModel.Next;
        end;

        Next;
      end;
    end;

    Result := True;

  except
    on E : Exception do
    begin
      Result := False;
      FDoError := E.Message;
    end;
  end;

end;

procedure TFchTransferModel.UpdateInventoryAVGCost(AIDStore, AIDModel: Integer;
  AQty: Double; AAvgCost: Currency);
begin
  with cmdUpdInventoryAVGCost do
  begin
    Parameters.ParamByName('IDModel').Value := AIDStore;
    Parameters.ParamByName('IDModel').Value := AIDModel;
    Parameters.ParamByName('Qty').Value := AQty;
    Parameters.ParamByName('AvgCostA').Value := AAvgCost;
    Parameters.ParamByName('AvgCostB').Value := AAvgCost;
    Execute;
  end;
end;

procedure TFchTransferModel.grdBrowseDBDblClick(Sender: TObject);
begin
  if btDetail.Enabled then
    btDetailClick(nil);
end;

procedure TFchTransferModel.SetLockedFields;
begin

  if ((frmCommand = btAlt) or (FIDTransfer <> -1)) then
  begin
    cmbLojaOrigem.ReadOnly     := True;
    cmbLojaOrigem.ParentColor  := True;
    cmbLojaDestino.ReadOnly    := True;
    cmbLojaDestino.ParentColor := True;
    if (not quFormTransferType.AsBoolean) and (not quFormImported.AsBoolean and (FIDTransfer = -1)) then
    begin
      dbNumber.ReadOnly     := False;
      dbNumber.ParentColor  := False;
      dbNumber.Color        := clWindow;
    end
    else
    begin
      dbNumber.ReadOnly     := True;
      dbNumber.ParentColor  := True;
    end;
    edtDate.Enabled            := False;
    edtDate.ParentColor        := True;
    rbType.ReadOnly            := True;
  end
  else
  begin
    cmbLojaOrigem.ReadOnly     := False;
    cmbLojaOrigem.Color        := clWindow;
    cmbLojaDestino.ReadOnly    := False;
    cmbLojaDestino.Color       := clWindow;
    edtDate.Enabled            := True;
    edtDate.Color              := clWindow;
    rbType.ReadOnly            := False;

    if DM.fSystem.SrvParam[PARAM_AUTO_GENERATE_TRANSF] then
    begin
      dbNumber.ReadOnly    := True;
      dbNumber.ParentColor := True;
    end
    else
    begin
      dbNumber.ReadOnly    := False;
      dbNumber.Color       := clWindow;
    end;
  end;
end;

procedure TFchTransferModel.SetEnabledButtons;
begin
  btCancel.Enabled := True;

  if (FIDTransfer <> -1) or (quFormImported.AsBoolean) or (TranferNumberExists(1, quFormNumber.AsString)) then
  begin
    btAdd.Enabled       := False;
    btnAddQuick.Enabled := False;
    btDetail.Enabled    := False;
    btRemove.Enabled    := False;
  end
  else
  begin
    btAdd.Enabled       := True;
    btnAddQuick.Enabled := True;
    btDetail.Enabled    := True;
    btRemove.Enabled    := True;
  end;
end;

function TFchTransferModel.UpdateTransferOut: Boolean;
begin

  try

    if FIDTransferOUT <> 0 then
    begin
      cmdUpdTransfOUT.Parameters.ParamByName('IDTransfOUT').Value := FIDTransferOUT;
      cmdUpdTransfOUT.Execute;
    end;

    Result := True;

  except
    on E : Exception do
    begin
      Result := False;
      FDoError := E.Message;
    end;
  end;
end;

procedure TFchTransferModel.OnAfterRollBack;
begin
  inherited;
  if FDoError <> '' then
  begin
    DM.SetError(CRITICAL_ERROR, Self.Name, 'TFchTransferModel.OnAfterRollBack' + #13#10 + FDoError);
    MsgBox('Error: ' + FDoError, vbOKOnly + vbInformation);
  end;
end;

procedure TFchTransferModel.InsertSerial(IDLojaDestino, IDLojaOrigem: Integer; IDModelTransfDet: String);
begin
   with quTransfSerial do
   begin
     if Active then
        Close;
     Parameters.ParamByName('IDModelTransfDet').Value := StrToInt(IDModelTransfDet);
     Open;
     First;
     while not Eof do
     begin
       DM.RunSQL('UPDATE InventorySerial SET StoreID = '+ IntToStr(IDLojaDestino) +' WHERE StoreID = '+ IntToStr(IDLojaOrigem)
       + ' AND Serial = '+ QuotedStr(Trim(quTransfSerialSerialNum.AsString)));
       Next;
     end;
     Close;
   end;
          {if quSNStoreOrigem.Locate('Serial', Items[i], []) then
        begin
          quSNStoreOrigem.Edit;
          quSNStoreOrigemStoreID.AsInteger := fIDStoreDest;
          quSNStoreOrigem.Post;
        end; }
end;

function TFchTransferModel.ValidateLot: Boolean;
var
  bLotControl : Boolean;
  sModels : String;
begin

  Result := True;
  sModels := '';

  bLotControl := DM.fSystem.SrvParam[PARAM_USE_LOT_CONTROL];

  with DM.quFreeSQL do
  begin
    SQL.Clear;
    SQL.Add('SELECT M.Model');
    SQL.Add('FROM ModelTransfDet MTD');
    SQL.Add('JOIN Model M (NOLOCK) ON (M.IDModel = MTD.IDModel)');
    SQL.Add('WHERE MTD.IDModelTransf = ' + quFormIDModelTransf.AsString);
    SQL.Add('AND M.UseLot = 1 AND MTD.IDLote IS NULL');
    try
      Open;
      if not IsEmpty then
      begin
        First;
        While not EOF do
        begin
          sModels := sModels + FieldByName('Model').AsString + '; ';
          Next;
        end;
      end;
    finally
      Close;
    end;
  end;

  if sModels <> '' then
    if bLotControl then
    begin
      MsgBox(Format(MSG_CRT_MODEL_WITHOUT_LOT, [sModels]), vbOKOnly + vbCritical);
      Result := False;
    end
    else
    begin
      if MsgBox(Format(MSG_QST_MODEL_LOT, [sModels]), vbYesNo + vbQuestion) = vbYes then
        Result := True
      else
        Result := False;
    end;

end;

procedure TFchTransferModel.UpdateLot(AIDStore, AIDModel, AIDLot,
   AType : Integer; AQty: Double);
begin
  DM.FDMInventory.LotAdjust(AIDModel, AIDStore, AIDLot, AQty, AType);
end;

function TFchTransferModel.RemoveLot: Boolean;
begin

  Result := False;

  try

    with quTransfModel do
      if Active and (not IsEmpty) then
      begin
        First;
        while not Eof do
        begin
          if FieldByName('IDLote').AsInteger <> 0 then
            if not quFormTransferType.AsBoolean then //Saida = 7
            begin
              UpdateLot(quFormIDLojaOrigem.AsInteger,
                        FieldByName('IDModel').AsInteger,
                        FieldByName('IDLote').AsInteger,
                        2,
                        FieldByName('Qty').AsFloat);
            end
            else
            begin
              UpdateLot(quFormIDLojaDestino.AsInteger,
                        FieldByName('IDModel').AsInteger,
                        FieldByName('IDLote').AsInteger,
                        3,
                        FieldByName('Qty').AsFloat);
            end;

          Next;
        end;
      end;

  Result := True;
  
  except
    on E : Exception do
    begin
      Result := False;
    end;
  end;

end;


procedure TFchTransferModel.btCancelClick(Sender: TObject);
begin

  if (frmCommand <> btInc) and TestOnEditModes then
    if (MsgBox(MSG_QST_UNSAVE_CHANGES, vbYesNo + vbQuestion) = vbNo) then
      Exit;

  if FIsInc then
  try
    OpenDataSets;
    RemoveLot;
  finally
    CloseDataSets
  end;

  inherited;

end;

end.
