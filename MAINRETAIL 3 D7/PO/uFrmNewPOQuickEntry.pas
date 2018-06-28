unit uFrmNewPOQuickEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Buttons, DB, ADODB, DBCtrls,{amf October 18, 2012 - uFrmModelQuickEntry} ufrmModelAdd,
  uFrmBarcodeSearch,  mrBarCodeEdit;

type
  TFrmNewPOQuickEntry = class(TFrmParent)
    gbxModelProperties: TGroupBox;
    cbxSearchType: TComboBox;
    edtSearchNumber: TEdit;
    pnlButtons: TPanel;
    btNewItem: TSpeedButton;
    btSearch: TSpeedButton;
    lblVendor: TLabel;
    edtVendor: TEdit;
    lblSearchType: TLabel;
    edtQty: TEdit;
    lblModel: TLabel;
    lblDescription: TLabel;
    lblCost: TLabel;
    lblManufacturer: TLabel;
    lblOurPrice: TLabel;
    lblQty: TLabel;
    qryModel: TADODataSet;
    DBText: TDBText;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    dtsModel: TDataSource;
    btAdd: TButton;
    qryModelIDModel: TIntegerField;
    qryModelModel: TStringField;
    qryModelDescription: TStringField;
    qryModelSellingPrice: TBCDField;
    qryModelFinalCost: TBCDField;
    qryModelManufacturer: TStringField;
    cmdInsPOItem: TADOCommand;
    qryModelSuggRetail: TBCDField;
    lblCaseQty: TLabel;
    DBText5: TDBText;
    lblQtyType: TLabel;
    cbxQtyType: TComboBox;
    qryModelCaseQty: TFloatField;
    spPoItemDO: TADOStoredProc;
    edtBarcode: TmrBarCodeEdit;
    qryModelMinQtyPO: TFloatField;
    lblVendorCode: TLabel;
    DBText6: TDBText;
    qryModelVendorCode: TStringField;
    qryModelDesativado: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure edtSearchNumberKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btSearchClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure btAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btNewItemClick(Sender: TObject);
    procedure edtQtyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxQtyTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSearchNumberExit(Sender: TObject);
    procedure cbxSearchTypeChange(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
  private
    FModelSQL: String;
    FIDPO: Integer;
    FIDVendor: Integer;
    FIDStore: Integer;
    //amf October 18, 2012 - fix wrong called to add screen
    FFrmModelQuickEntry: TFrmModelAdd;
    FFrmBarcodeSearch: TfrmBarcodeSearch;


    procedure NewItemRefresh;
    procedure LoadImages;
    procedure SearchModel(AIDModel: Integer);
    procedure InsertPOItem;
    procedure RefreshControls;
    procedure InformOpenPOItem(AIDModel: Integer);  
    procedure PoItemDO(IDPreInvMov:Integer; IDPO : Integer);
    function ValidateMinPOQty: Boolean;
  public
    procedure Start(AIDPO, AIDStore, AIDVendor: Integer; AVendorName: String);
  end;

implementation

uses uDM, uSystemConst, uCharFunctions, uMsgBox, uMsgConstant, uContentClasses,
  uNumericFunctions;

{$R *.dfm}

{ TFrmNewPOQuickEntry }

procedure TFrmNewPOQuickEntry.LoadImages;
begin
  DM.imgSmall.GetBitmap(BTN18_NEW, btNewItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_SEARCH, btSearch.Glyph);
end;

procedure TFrmNewPOQuickEntry.Start(AIDPO, AIDStore, AIDVendor: Integer;
  AVendorName: String);
begin
  FIDPO := AIDPO;
  FIDStore := AIDStore;
  FIDVendor := AIDVendor;
  edtVendor.Text := AVendorName;
  ShowModal;
end;

procedure TFrmNewPOQuickEntry.FormCreate(Sender: TObject);
begin
  inherited;
  LoadImages;
  FModelSQL := qryModel.CommandText;

  //amf October 18, 2012
  FFrmModelQuickEntry := TFrmModelAdd.Create(Self);
  FFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];
  
end;

procedure TFrmNewPOQuickEntry.edtSearchNumberKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = 13) then
    SearchModel(0);
end;

procedure TFrmNewPOQuickEntry.SearchModel(AIDModel: Integer);
begin
  with qryModel do
  begin
    Close;
    CommandText := FModelSQL;

    if AIDModel <> 0 then
      CommandText := CommandText + ' WHERE M.IDModel = ' + IntToStr(AIDModel)
    else
    begin
      case cbxSearchType.ItemIndex of
        0: CommandText := CommandText + ' WHERE B.IDBarcode = ' + QuotedStr(edtBarcode.Text);
        1: CommandText := CommandText + ' WHERE M.Model = ' + QuotedStr(edtSearchNumber.Text);
        2: CommandText := CommandText + ' WHERE VMC.VendorCode = ' + QuotedStr(edtSearchNumber.Text);
      end;
    end;

    Parameters.ParamByName('IDVendorVMC').Value := FIDVendor;
    Parameters.ParamByName('IDVendorIMV').Value := FIDVendor;
    Open;

    if RecordCount = 0 then
    begin
      edtSearchNumber.Clear;
      edtBarcode.Clear;
      case cbxSearchType.ItemIndex of
        0: MsgBox(MSG_INF_BARCODE_NOT_FOUND, vbInformation + vbOKOnly);
        1: MsgBox(MSG_INF_MODEL_NOT_FOUND, vbInformation + vbOKOnly);
        2: MsgBox(MSG_INF_VENDOR_NUMBER_NOT_FOUND, vbInformation + vbOKOnly);
      end;
    end
    else
    begin
      RefreshControls;
      InformOpenPOItem(AIDModel);
      edtSearchNumber.Clear;
      edtBarcode.Clear;
    end;
  end;
end;

procedure TFrmNewPOQuickEntry.btSearchClick(Sender: TObject);
var
  iIDModel: Integer;
begin
  inherited;
  iIDModel := FFrmBarcodeSearch.Start;
  if iIDModel <> -1 then
    SearchModel(iIDModel);
end;

procedure TFrmNewPOQuickEntry.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FFrmModelQuickEntry);
  FreeAndNil(FFrmBarcodeSearch);
end;

procedure TFrmNewPOQuickEntry.InsertPOItem;
var
  IDPreInvMov : Integer;
begin
  with cmdInsPOItem do
  begin
    IDPreInvMov := DM.GetNextID('PreInventoryMov.IDPreInventoryMov');
    Parameters.ParamByName('IDPreInventoryMov').Value := IDPreInvMov;
    Parameters.ParamByName('InventMovTypeID').Value := INV_MOVTYPE_BOUGHT;
    Parameters.ParamByName('StoreID').Value := FIDStore;
    Parameters.ParamByName('ModelID').Value := qryModel.FieldByName('IDModel').AsInteger;
    Parameters.ParamByName('IDPessoa').Value := FIDVendor;
    Parameters.ParamByName('UserID').Value := DM.fUser.ID;
    Parameters.ParamByName('DocumentID').Value := FIDPO;
    Parameters.ParamByName('MovDate').Value := Now;
    Parameters.ParamByName('DateEstimatedMov').Value := Now+7;

    if cbxQtyType.ItemIndex = 0 then
    begin
      Parameters.ParamByName('CaseQty').Value := StrToInt(edtQty.Text);
      Parameters.ParamByName('CaseCost').Value := qryModel.FieldByName('CaseQty').AsFloat * qryModel.FieldByName('FinalCost').AsFloat;
      Parameters.ParamByName('Qty').Value := StrToInt(edtQty.Text) * qryModel.FieldByName('CaseQty').AsFloat;
    end
    else
    begin
      Parameters.ParamByName('CaseQty').Value := NULL;
      Parameters.ParamByName('CaseCost').Value := NULL;
      Parameters.ParamByName('Qty').Value := StrToInt(edtQty.Text);
    end;

    Parameters.ParamByName('CostPrice').Value := qryModel.FieldByName('FinalCost').AsFloat;
    Parameters.ParamByName('SalePrice').Value := qryModel.FieldByName('SellingPrice').AsFloat;
    Parameters.ParamByName('SuggRetail').Value := qryModel.FieldByName('SuggRetail').AsFloat;
    Execute;
  end;

  PoItemDO(IDPreInvMov, FIDPO);
end;

procedure TFrmNewPOQuickEntry.edtQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TFrmNewPOQuickEntry.btAddClick(Sender: TObject);
begin
  inherited;
  if (not qryModel.Active) or (qryModel.RecordCount = 0) then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbInformation + vbOKOnly);
    if edtSearchNumber.CanFocus then
      edtSearchNumber.SetFocus;
    if edtBarcode.CanFocus then
      edtBarcode.SetFocus;
  end
  else if qryModel.FieldByName('FinalCost').AsCurrency = 0 then
    MsgBox(MSG_CRT_COST_POSITIVE, vbInformation + vbOKOnly)
  else if (edtQty.Text = '') or (StrToInt(edtQty.Text) = 0) then
  begin
    MsgBox(MSG_CRT_QTY_NO_ZERO, vbInformation + vbOKOnly);
    edtQty.SetFocus;
  end
  else if not ValidateMinPOQty then
  begin
    MsgBox(MSG_INF_LESSER_MINIM_VENDOR, vbInformation + vbOKOnly);
    edtQty.SetFocus;
  end
  else
  begin
    if qryModelDesativado.AsInteger = 1 then
      DM.ModelRestored(qryModelIDModel.AsInteger);

    InsertPOItem;
    edtQty.Clear;
    NewItemRefresh;
    cbxQtyType.Visible := False;
    lblQtyType.Visible := False;
    qryModel.Close;
  end;
end;

procedure TFrmNewPOQuickEntry.FormShow(Sender: TObject);
begin
  inherited;
  edtBarcode.SetFocus;
end;

procedure TFrmNewPOQuickEntry.btNewItemClick(Sender: TObject);
var
  ABarcode: TBarcode;
begin
  inherited;
  ABarcode := FFrmModelQuickEntry.Start(False, True, False, '');
  if ABarcode.Model.IDModel <> -1 then
    SearchModel(ABarcode.Model.IDModel);
end;

procedure TFrmNewPOQuickEntry.edtQtyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = 13) then
    btAddClick(Sender);
end;

procedure TFrmNewPOQuickEntry.RefreshControls;
var
  dQtyPO: Double;
begin
  with qryModel do
  begin
    if FieldByName('CaseQty').AsFloat > 0 then
    begin
      cbxQtyType.Enabled := True;
      cbxQtyType.TabStop := False;
      cbxQtyType.ItemIndex := 0;
      cbxQtyType.Visible := True;
      lblQtyType.Visible := True;
      if FieldByName('MinQtyPO').AsFloat > 0 then
      begin
        dQtyPO := FieldByName('MinQtyPO').Value / FieldByName('CaseQty').AsFloat;
        if Frac(dQtyPO) > 0 then
          dQtyPO := dQtyPO + 1;
        edtQty.Text := IntToStr(Trunc(dQtyPO));
      end;

      edtQty.SetFocus;
    end
    else
    begin
      cbxQtyType.Enabled := False;
      cbxQtyType.TabStop := True;
      cbxQtyType.ItemIndex := 1;
      cbxQtyType.Visible := False;
      lblQtyType.Visible := False;
      if FieldByName('MinQtyPO').AsFloat > 0 then
        edtQty.Text := FieldByName('MinQtyPO').Value;
      edtQty.SetFocus;
    end;
  end;
end;

procedure TFrmNewPOQuickEntry.cbxQtyTypeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = 13) then
    edtQty.SetFocus;
end;

procedure TFrmNewPOQuickEntry.edtSearchNumberExit(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).Text <> '' then
    SearchModel(0);
end;

procedure TFrmNewPOQuickEntry.PoItemDO(IDPreInvMov, IDPO: Integer);
begin
  with spPoItemDO do
  try
    Parameters.ParambyName('@IDPreInventoryMov').Value := IDPreInvMov;
    Parameters.ParambyName('@IDPO').Value := IDPO;
    ExecProc;
  except
    raise Exception.Create('Error on class.method TFrmNewPOQuickEntry.PoItemDO');
  end;
end;

procedure TFrmNewPOQuickEntry.cbxSearchTypeChange(Sender: TObject);
begin
  inherited;
  if cbxSearchType.ItemIndex = 0 then
    edtBarcode.BringToFront
  else
    edtSearchNumber.BringToFront;
end;

procedure TFrmNewPOQuickEntry.edtBarcodeAfterSearchBarcode(
  Sender: TObject);
begin
  inherited;
  with edtBarcode do
    if SearchResult then
      SearchModel(GetFieldValue('IDModel'))
    else
    begin
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
      Clear;
    end;
end;

function TFrmNewPOQuickEntry.ValidateMinPOQty: Boolean;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    // to fix bug about quick entry. The prior query wasn't considering IDModel
    SQL.Text :=
      'SELECT MinQtyPO FROM Inv_ModelVendor WHERE IDPessoa = ' + IntToStr(FIDVendor) +
      '       and IDModel = ' + IntToStr(qryModel.fieldByName('IDModel').AsInteger);
    Open;
    Result := IsEmpty;

    if not Result then
      if cbxQtyType.ItemIndex = 0 then
      begin
        if qryModel.FieldByName('CaseQty').AsFloat > 0 then
          Result := (MyStrToFloat(edtQty.Text) * qryModel.FieldByName('CaseQty').AsFloat) >= FieldByName('MinQtyPO').AsFloat;
      end
      else
        Result := MyStrToFloat(edtQty.Text) >= FieldByName('MinQtyPO').AsFloat
  finally
    Close;
  end;
end;

procedure TFrmNewPOQuickEntry.NewItemRefresh;
begin
  edtSearchNumber.Clear;
  edtBarcode.Clear;
  if cbxSearchType.ItemIndex = 0 then
    edtBarcode.SetFocus
  else
    edtSearchNumber.SetFocus;
end;

procedure TFrmNewPOQuickEntry.InformOpenPOItem(AIDModel: Integer);
begin
  with TADOQuery.Create(self) do
  try
    Connection := DM.ADODBConnect;
    SQL.Add('SELECT DISTINCT PIM.ModelID');
    SQL.Add('FROM PreInventoryMov PIM (NOLOCK)');
    SQL.Add('JOIN PO (NOLOCK) ON (PIM.DocumentID = PO.IDPO) ');
    SQL.Add('JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel) ');
    SQL.Add('LEFT JOIN Barcode B (NOLOCK) ON (B.IDModel = M.IDModel)');
    SQL.Add('LEFT OUTER JOIN VendorModelCode VMC (NOLOCK) ON (M.IDModel = VMC.IDModel AND VMC.IDPessoa = PO.IDFornecedor)');
    SQL.Add('WHERE PIM.Qty > PIM.QtyRealMov ');

    if AIDModel <> 0 then
      SQL.Add('AND M.IDModel = ' + IntToStr(AIDModel) )
    else
      case cbxSearchType.ItemIndex of
        0: SQL.Add('AND B.IDBarcode = ' + QuotedStr(edtBarcode.Text) );
        1: SQL.Add('AND M.Model = ' + QuotedStr(edtSearchNumber.Text) );
        2: SQL.Add('AND VMC.VendorCode = ' + QuotedStr(edtSearchNumber.Text) );
      end;

    SQL.Add('AND PO.Aberto = 1');
    Open;
    if not IsEmpty then
      MsgBox(MSG_INF_MODEL_ORDERED, vbInformation + vbOkOnly);
  finally
    Close;
    Free;
  end;

end;

end.
