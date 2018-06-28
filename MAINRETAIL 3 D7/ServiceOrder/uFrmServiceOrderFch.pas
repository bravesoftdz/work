unit uFrmServiceOrderFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeForms, siComp, siLangRT, StdCtrls, ExtCtrls, DB, DBClient,
  Provider, ADODB, Mask, SuperComboADO, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, DBCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDBData, Buttons,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls;

type
  TFrmServiceOrderFch = class(TFrmParentForms)
    Panel1: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    btClose: TButton;
    btnSave: TButton;
    quSOItemDetail: TADODataSet;
    dspSOItemDetail: TDataSetProvider;
    cdsSOItemDetail: TClientDataSet;
    dsSOItemDetail: TDataSource;
    cdsSOItemDetailIDSOItem: TIntegerField;
    cdsSOItemDetailIDSOCustomerProduct: TIntegerField;
    cdsSOItemDetailIDUser: TIntegerField;
    cdsSOItemDetailIDServiceOrder: TIntegerField;
    cdsSOItemDetailSerialNumber: TStringField;
    cdsSOItemDetailIniDate: TDateTimeField;
    cdsSOItemDetailEndDate: TDateTimeField;
    cdsSOItemDetailOBS: TStringField;
    scUser: TDBSuperComboADO;
    Label1: TLabel;
    dateStart: TcxDBDateEdit;
    lbProduct: TLabel;
    lbSerial: TLabel;
    edtSerialNumber: TDBEdit;
    Label4: TLabel;
    Label8: TLabel;
    memNotes: TDBMemo;
    Label37: TLabel;
    scStatus: TDBSuperComboADO;
    Label5: TLabel;
    Label6: TLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    quCustDefect: TADODataSet;
    dsCustDefect: TDataSource;
    quCustDefectIDSOItemDefect: TIntegerField;
    quCustDefectDefectType: TStringField;
    PageControl1: TPageControl;
    tsDefects: TTabSheet;
    scCDefect: TSuperComboADO;
    grdCDefects: TcxGrid;
    grdCDefectsDB: TcxGridDBTableView;
    grdCDefectsDBDefectType: TcxGridDBColumn;
    grdCDefectsLevel: TcxGridLevel;
    btAddCDefect: TSpeedButton;
    btnDelCdefect: TSpeedButton;
    quCustDefectType: TIntegerField;
    cbxDefectType: TComboBox;
    quCustDefectTypeStr: TStringField;
    grdCDefectsDBTypeStr: TcxGridDBColumn;
    strepSaleItem: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleContent: TcxStyle;
    cxStyleContentEven: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyleGroup: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyleHeader: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyleSelection: TcxStyle;
    cxStyleContent2: TcxStyle;
    cxStyleSelection2: TcxStyle;
    cxStyleHeader2: TcxStyle;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    tsModel: TTabSheet;
    grdSaleItem: TcxGrid;
    grdSaleItemView: TcxGridDBTableView;
    grdSaleItemLevel: TcxGridLevel;
    btnRemoveItem: TSpeedButton;
    btnAddItem: TSpeedButton;
    quItemSale: TADODataSet;
    dsItemSale: TDataSource;
    quItemSaleIDSOItemProduct: TIntegerField;
    quItemSaleSalePrice: TBCDField;
    quItemSaleQty: TBCDField;
    quItemSaleSubTotal: TBCDField;
    quItemSaleModel: TStringField;
    quItemSaleDescription: TStringField;
    quItemSaleMovDate: TDateTimeField;
    grdSaleItemViewSalePrice: TcxGridDBColumn;
    grdSaleItemViewQty: TcxGridDBColumn;
    grdSaleItemViewSubTotal: TcxGridDBColumn;
    grdSaleItemViewModel: TcxGridDBColumn;
    grdSaleItemViewDescription: TcxGridDBColumn;
    grdSaleItemViewMovDate: TcxGridDBColumn;
    Label7: TLabel;
    lbUsedTime: TLabel;
    edtUsedTime: TDBEdit;
    cdsSOItemDetailUsedTime: TStringField;
    quItemSaleItemType: TStringField;
    quItemSaleModelType: TStringField;
    grdSaleItemViewItemType: TcxGridDBColumn;
    quItemSaleDiscount: TBCDField;
    quItemSaleTotal: TBCDField;
    grdSaleItemViewDiscount: TcxGridDBColumn;
    grdSaleItemViewTotal: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure cdsSOItemDetailAfterOpen(DataSet: TDataSet);
    procedure btAddCDefectClick(Sender: TObject);
    procedure btnDelCdefectClick(Sender: TObject);
    procedure quCustDefectCalcFields(DataSet: TDataSet);
    procedure btnRemoveItemClick(Sender: TObject);
    procedure btnAddItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quItemSaleCalcFields(DataSet: TDataSet);
  private
    FResult : Boolean;
    FIDSO : Integer;
    FIDSOItem : Integer;
    FIDCustomer : Integer;
    FNewSOItem : Boolean;
    FIsClosed : Boolean;

    sSerial,
    sUsedTime,
    sProduct,
    sItemTypeService,
    sItemTypeProduct : String;

    procedure AddSOItemDetail;

    procedure OpenSOItemDetail;
    procedure CloseSOItemDetail;
    procedure SaveSOItemDetail;

    procedure CloseCustomerDefect;
    procedure OpenCustomerDefect;
    procedure RefreshCustomerDefect;
    procedure InsertCustomerDefect;
    procedure DeleteCustomerDefect;

    procedure DeleteServiceSale;

    procedure RefreshItemSale;
    procedure CloseItemSale;
    procedure OpenItemSale;
    procedure DeleteItemSale;

    function ValidateFields : Boolean;
    procedure LoadImages;

    procedure RefreshControls;
  public
    function Start(AIDSO, AIDSOItem, AIDCustomer : Integer; IsClosed : Boolean):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uDMServiceOrder, uMsgBox, uMsgConstant, uFrmSearchSOItem,
 uPassword, uSystemConst;

{$R *.dfm}

function TFrmServiceOrderFch.Start(AIDSO, AIDSOItem, AIDCustomer: Integer;
  IsClosed : Boolean): Boolean;
begin

  FIDSO       := AIDSO;
  FIDSOItem   := AIDSOItem;
  FIDCustomer := AIDCustomer;
  FNewSOItem  := False;
  FIsClosed   := IsClosed;

  if (AIDSOItem = -1) then
  begin
    FNewSOItem := True;
    AddSOItemDetail;
  end
  else
    OpenSOItemDetail;

  FResult := False;

  LoadImages;

  RefreshControls;

  ShowModal;

  Result := FResult;

end;

procedure TFrmServiceOrderFch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := CaFree;
end;

procedure TFrmServiceOrderFch.AddSOItemDetail;
begin

  OpenSOItemDetail;

  FIDSOItem := DM.GetNextID('Ser_SOItem.IDSOItem');

  with cdsSOItemDetail do
  begin
    Append;
    FieldByName('IDSOItem').AsInteger       := FIDSOItem;
    FieldByName('IDUser').AsInteger         := DM.fUser.ID;
    FieldByName('IDServiceOrder').AsInteger := FIDSO;
    FieldByName('IniDate').AsDateTime       := Now;
    Post;
    ApplyUpdates(0);
  end;

end;

procedure TFrmServiceOrderFch.OpenSOItemDetail;
begin

  with cdsSOItemDetail do
    if not Active then
    begin
      FetchParams;
      Params.ParamByName('IDSOItem').Value := FIDSOItem;
      Open;
    end;

end;

procedure TFrmServiceOrderFch.CloseSOItemDetail;
begin

  with cdsSOItemDetail do
    if Active then
      Close;
      
end;

procedure TFrmServiceOrderFch.SaveSOItemDetail;
begin

  with cdsSOItemDetail do
    if Active then
      if (State in dsEditModes) then
      begin
        Post;
        ApplyUpdates(0);
      end;

end;

procedure TFrmServiceOrderFch.btnSaveClick(Sender: TObject);
begin
  inherited;

  if ValidateFields then
  begin
    SaveSOItemDetail;
    CloseSOItemDetail;
    FResult := True;
    Close;
  end
  else
  begin
    ModalResult := mrNone;
    FResult     := False;
  end;
  
end;

procedure TFrmServiceOrderFch.btCloseClick(Sender: TObject);
begin
  inherited;

  CloseSOItemDetail;

  if FNewSOItem then
    DMServiceOrder.DeleteSOItem(FIDSOItem)
  else
    FResult := True;

  Close;
    
end;

function TFrmServiceOrderFch.ValidateFields: Boolean;
begin

  Result := False;

  if (cdsSOItemDetailIDUser.AsInteger = 0) then
  begin
    MsgBox(MSG_CRT_NOT_EMPTY_USER, vbOkOnly + vbCritical);
    Exit;
  end;

  if (cdsSOItemDetailIDSOCustomerProduct.AsInteger = 0) then
  begin
    MsgBox(MSG_CRT_NO_PRODUCT, vbOkOnly + vbCritical);
    Exit;
  end;

  if (cdsSOItemDetailSerialNumber.AsString = '') then
  begin
    MsgBox(MSG_CRT_NO_SERIALNUMBER, vbOkOnly + vbCritical);
    Exit;
  end;

  Result := True;

end;

procedure TFrmServiceOrderFch.LoadImages;
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddCDefect.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btnAddItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnDelCdefect.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btnRemoveItem.Glyph);
end;


procedure TFrmServiceOrderFch.CloseCustomerDefect;
begin
  with quCustDefect do
    if Active then
      Close;
end;

procedure TFrmServiceOrderFch.DeleteCustomerDefect;
begin

  with quCustDefect do
    if Active and (not IsEmpty) then
    begin
      if not Password.HasFuncRight(79) then
        MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOKOnly)
      else
      begin
        DM.RunSQL('DELETE Ser_SOItemDefect WHERE IDSOItemDefect = ' + FieldByName('IDSOItemDefect').AsString);
        RefreshCustomerDefect;
      end;
    end;

end;

procedure TFrmServiceOrderFch.InsertCustomerDefect;
var
  sSQL : String;
  iID, iType : Integer;
begin
   if scCDefect.LookUpValue <> '' then
   begin

     iID := DM.GetNextID('Ser_SOItemDefect.IDSOItemDefect');
     iType := cbxDefectType.ItemIndex;

     sSQL := 'INSERT Ser_SOItemDefect (IDSOItemDefect, IDDefectType, IDSOItem, Type) ' +
             'VALUES ('+ IntToStr(iID) + ', ' + scCDefect.LookUpValue + ', ' + IntToStr(FIDSOItem) + ', ' + IntToStr(iType) + ')';

     DM.RunSQL(sSQL);

     RefreshCustomerDefect;
     scCDefect.LookUpValue := '';
     scCDefect.Text := '';
   end;
end;

procedure TFrmServiceOrderFch.OpenCustomerDefect;
begin
  with quCustDefect do
    if not Active then
    begin
      Parameters.ParamByName('IDSOItem').Value := FIDSOItem;
      Open;
      grdCDefectsDB.DataController.Groups.FullExpand;
    end;
end;

procedure TFrmServiceOrderFch.RefreshCustomerDefect;
begin
  CloseCustomerDefect;
  OpenCustomerDefect;
end;

procedure TFrmServiceOrderFch.cdsSOItemDetailAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshCustomerDefect;
  RefreshItemSale;
end;

procedure TFrmServiceOrderFch.btAddCDefectClick(Sender: TObject);
begin
  inherited;
  InsertCustomerDefect;
end;

procedure TFrmServiceOrderFch.btnDelCdefectClick(Sender: TObject);
begin
  inherited;
  DeleteCustomerDefect;
end;

procedure TFrmServiceOrderFch.quCustDefectCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quCustDefectType.AsInteger = 0 then
    quCustDefectTypeStr.AsString := 'Customer'
  else
    quCustDefectTypeStr.AsString := 'Product';
end;

procedure TFrmServiceOrderFch.DeleteServiceSale;
begin
  with quItemSale do
    if Active and (not IsEmpty) then
    begin
      if not Password.HasFuncRight(78) then
        MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOKOnly)
      else
      begin
        try
          DM.ADODBConnect.BeginTrans;
          DM.RunSQL('DELETE Ser_SOItemProduct WHERE IDSOItemProduct = ' + FieldByName('IDSOItemProduct').AsString);
          DM.RunSQL('DELETE InventoryMov WHERE DocumentID = ' + FieldByName('IDSOItemProduct').AsString + ' AND InventMovTypeID = 50');
          DM.ADODBConnect.CommitTrans;
        except
          DM.ADODBConnect.RollbackTrans;
        end;
        RefreshItemSale;
      end;
    end;
end;

procedure TFrmServiceOrderFch.CloseItemSale;
begin
  with quItemSale do
    if Active then
      Close;
end;

procedure TFrmServiceOrderFch.DeleteItemSale;
begin
  with quItemSale do
    if Active and (not IsEmpty) then
    begin
      if not Password.HasFuncRight(78) then
        MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOKOnly)
      else
      begin
        try
          DM.ADODBConnect.BeginTrans;
          DM.RunSQL('DELETE Ser_SOItemProduct WHERE IDSOItemProduct = ' + FieldByName('IDSOItemProduct').AsString);
          DM.RunSQL('DELETE InventoryMov WHERE DocumentID = ' + FieldByName('IDSOItemProduct').AsString + ' AND InventMovTypeID = 50');
          DM.ADODBConnect.CommitTrans;
        except
          DM.ADODBConnect.RollbackTrans;
        end;
        RefreshItemSale;
      end;
    end;
end;

procedure TFrmServiceOrderFch.OpenItemSale;
begin
  with quItemSale do
    if not Active then
    begin
      Parameters.ParamByName('IDSOItem').Value := FIDSOItem;
      Open;
    end;
end;

procedure TFrmServiceOrderFch.RefreshItemSale;
begin
  CloseItemSale;
  OpenItemSale;
  grdSaleItemView.DataController.Groups.FullExpand;
end;

procedure TFrmServiceOrderFch.btnRemoveItemClick(Sender: TObject);
begin
  inherited;

  if quItemSaleModelType.AsString = 'V' then
    DeleteServiceSale
  else
    DeleteItemSale;

end;

procedure TFrmServiceOrderFch.btnAddItemClick(Sender: TObject);
begin
  inherited;
  with TFrmSearchSOItem.Create(Self) do
    if Start(FIDSOItem, FIDCustomer, StrToInt(scUser.LookUpValue)) then
      RefreshItemSale;
end;

procedure TFrmServiceOrderFch.RefreshControls;
begin
  btAddCDefect.Visible     := not FIsClosed;
  btnDelCdefect.Visible    := not FIsClosed;
  btnAddItem.Visible       := not FIsClosed;
  btnRemoveItem.Visible    := not FIsClosed;
  scUser.Enabled           := not FIsClosed;
  scStatus.Enabled         := not FIsClosed;
  edtSerialNumber.Enabled  := not FIsClosed;
  dateStart.Enabled        := not FIsClosed;
  cxDBDateEdit1.Enabled    := not FIsClosed;
  memNotes.Enabled         := not FIsClosed;
  btnSave.Visible          := not FIsClosed;

  if not Password.HasFuncRight(86) then
  begin
    dateStart.Enabled        := False;
    cxDBDateEdit1.Enabled    := False;
  end;

  lbSerial.Caption         := sSerial;
  lbUsedTime.Caption       := sUsedTime;
  lbProduct.Caption        := sProduct;

  tsDefects.TabVisible     := not DM.fSystem.SrvParam[PARAM_DISABLE_SO_DEFECTS];

end;

procedure TFrmServiceOrderFch.FormCreate(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sSerial          := 'Serial :';
      sUsedTime        := 'Used Time :';
      sItemTypeService := 'Service';
      sItemTypeProduct := 'Product';
      sProduct         := 'Product :';
    end;

    LANG_PORTUGUESE:
    begin
      sSerial          := 'Nº Serie :';
      sUsedTime        := 'Tempo de Uso :';
      sItemTypeService := 'Serviço';
      sItemTypeProduct := 'Produto';
      sProduct         := 'Produto :';
    end;

    LANG_SPANISH :
    begin
      sSerial          := 'Nº Serie :';
      sUsedTime        := 'Tempo de Uso :';
      sItemTypeService := 'Servicio';
      sItemTypeProduct := 'Producto';
      sProduct         := 'Producto :';
    end;
  end;


  if DM.fSystem.SrvParam[PARAM_SO_TYPE] = 1 then
    case DMGlobal.IDLanguage of
      LANG_ENGLISH:
      begin
        sSerial   := 'Plate Number:';
        sUsedTime := 'Milles :';
        sProduct  := 'Car :';
      end;

      LANG_PORTUGUESE:
      begin
        sSerial   := 'Número da placa :';
        sUsedTime := 'Km :';
        sProduct  := 'Carro :';
      end;

      LANG_SPANISH :
      begin
        sSerial   := 'Número da placa :';
        sUsedTime := 'Km :';
        sProduct  := 'Carro :';
      end;
    end;

end;

procedure TFrmServiceOrderFch.quItemSaleCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quItemSaleModelType.AsString = 'V' then
    quItemSaleItemType.AsString := sItemTypeService
  else
    quItemSaleItemType.AsString := sItemTypeProduct
end;

end.
