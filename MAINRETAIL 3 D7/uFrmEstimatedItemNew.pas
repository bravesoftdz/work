unit uFrmEstimatedItemNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, uFrmBarcodeSearch, uSystemTypes, DB, ADODB,
  PowerADOQuery, uFrmEstimated, LblEffct, SuperEdit, SuperEditCurrency,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit;

type
  TFrmEstimatedItemNew = class(TFrmParentAll)
    btOK: TButton;
    Label1: TLabel;
    cmbModel: TSuperComboADO;
    Label2: TLabel;
    btnSearchDesc: TBitBtn;
    lbSalePrice: TLabel;
    quEstimetedItems: TPowerADOQuery;
    quEstimetedItemsIDEstimatedItem: TIntegerField;
    quEstimetedItemsIDModel: TIntegerField;
    quEstimetedItemsModel: TStringField;
    quEstimetedItemsDescription: TStringField;
    quEstimetedItemsGrandTotal: TCurrencyField;
    quEstimetedItemsEstSalePrice: TBCDField;
    quEstimetedItemsSellingPrice: TBCDField;
    quEstimetedItemsSalePrice: TCurrencyField;
    quEstimetedItemsQty: TFloatField;
    Panel2: TPanel;
    Image3: TImage;
    Image1: TImage;
    imgTopIni: TImage;
    lblSubMenu: TLabelEffect;
    lblMenu: TLabel;
    Panel4: TPanel;
    EEE: TPanel;
    pnlAutoInc: TPanel;
    Image2: TImage;
    btLoopInc: TSpeedButton;
    lblModified: TLabel;
    edtSalePrice: TSuperEditCurrency;
    imgMenu: TImage;
    edtQty: TcxSpinEdit;
    quEstimetedItemsIDDepartment: TIntegerField;
    lblDepartment: TLabel;
    scDepartment: TSuperComboADO;
    btLoopDepartment: TSpeedButton;
    pnlCostPrice: TPanel;
    lblCost: TLabel;
    btShowCost: TSpeedButton;
    editCostPrice: TEdit;
    quPrice: TADODataSet;
    quPriceSellingPrice: TBCDField;
    quPriceFinalCost: TBCDField;
    procedure btOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSearchDescClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSalePriceKeyPress(Sender: TObject; var Key: Char);
    procedure cmbModelSelectItem(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtSalePriceEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btShowCostClick(Sender: TObject);
  private
    FFrmCommand: TBtnCommandType;
    FFrmBarcodeSearch: TFrmBarcodeSearch;
    FIDEstimated: Integer;
    FIDEstimatedItem: Integer;
    fModelCaseQty: Double;

    procedure InsertEstimatedItem;
    procedure UpdateEstimatedItem;
    procedure LoadEstimatedItem;
    procedure RefreshPrice(bSale, bCost : Boolean);
    procedure LimpaCampos;
    procedure RefreshDepartment;

    function ValidateItem: Boolean;
  public
    function Start(AFrmCommand: TBtnCommandType; AIDEstimated, AIDEstimatedItem: Integer): Boolean;
  end;

implementation

uses uDM, uSystemConst, uMsgBox, uMsgConstant, uCharFunctions,
     uNumericFunctions, StrUtils, uPassword;

{$R *.dfm}

{ TFrmEstimatedItemNew }

procedure TFrmEstimatedItemNew.InsertEstimatedItem;
var
  iIDEstimatedItem: Integer;
  cSalePrice: Currency;
begin
  cSalePrice := MyStrToMoney(edtSalePrice.Text);

  if cSalePrice = 0 then
    cSalePrice := MyStrToMoney(DM.DescCodigo(['IDModel'], [cmbModel.LookUpValue], 'Model', 'SellingPrice'));

  iIDEstimatedItem := DM.GetNextID(MR_INV_ESTIMATED_ITEM_ID);

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('INSERT INTO EstimatedItem (IDEstimatedItem, IDEstimated, Code, IDModel, Qty, SalePrice, IDDepartment)');
    SQL.Add('(SELECT ' + IntToStr(iIDEstimatedItem) + ',' + IntToStr(FIDEstimated) + ', IsNull(MAX(Code), 0) + 1, ' + cmbModel.LookUpValue + ',');
    SQL.Add(StringReplace(edtQty.Text, ',', '.', [rfReplaceAll]) + ', ' + MyFormatCur(cSalePrice, '.') + ', ' + IfThen(scDepartment.LookUpValue <> '', scDepartment.LookUpValue, '0'));
    SQL.Add(' FROM EstimatedItem WHERE IDEstimated = ' + IntToStr(FIDEstimated) + ')');
    ExecSQL;
  end;
end;

procedure TFrmEstimatedItemNew.UpdateEstimatedItem;
var
  iIDEstimatedItem: Integer;
  cSalePrice: Currency;
begin
  cSalePrice := MyStrToMoney(edtSalePrice.Text);

  if cSalePrice = 0 then
    cSalePrice := MyStrToMoney(DM.DescCodigo(['IDModel'], [cmbModel.LookUpValue], 'Model', 'SellingPrice'));

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('UPDATE EstimatedItem SET ');
    SQL.Add('IDModel = ' + cmbModel.LookUpValue);
    SQL.Add(', Qty = ' + StringReplace(edtQty.Text, ',', '.', [rfReplaceAll]));
    SQL.Add(', SalePrice = ' + MyFormatCur(cSalePrice, '.'));
    SQL.Add(', IDDepartment = ' + IfThen(scDepartment.LookUpValue <> '', scDepartment.LookUpValue, '0'));
    SQL.Add('WHERE IDEstimatedItem = ' + IntToStr(FIDEstimatedItem));
    ExecSQL;
  end;
end;

function TFrmEstimatedItemNew.Start(AFrmCommand: TBtnCommandType;
  AIDEstimated, AIDEstimatedItem: Integer): Boolean;
begin
  FIDEstimated := AIDEstimated;
  FIDEstimatedItem := AIDEstimatedItem;
  FFrmCommand := AFrmCommand;

  if FFrmCommand = btAlt then
  begin
    LoadEstimatedItem;
    btLoopInc.Down := False;
    btLoopInc.Visible := False;
    lblModified.Visible := False;
  end;

  ShowModal;
  Result := (ModalResult = mrOK);
end;

function TFrmEstimatedItemNew.ValidateItem: Boolean;
begin
  Result := False;

  if cmbModel.LookUpValue = '' then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbCritical + vbOkOnly);
    Exit;
  end;

  if (StrToFloatDef(edtQty.Text, 0) = 0) then
  begin
    MsgBox(MSG_CRT_QTY_NO_ZERO, vbCritical + vbOkOnly);
    Exit;
  end;

  if (scDepartment.LookUpValue = '') and scDepartment.Visible then
  begin
    scDepartment.SetFocus;
    MsgBox(MSG_INF_SELECT_DEPARTMENT , vbOKOnly + vbInformation);
    Exit;
  end;

  if fModelCaseQty > 0 then
    if DM.fSystem.SrvParam[PARAM_VALIDATE_CASE_QTY_ON_HOLD] then
      if Frac(StrToFloat(edtQty.Text) / fModelCaseQty) <> 0 then
      begin
        MsgBox(MSG_INF_QTY_NOT_DIF_MULT_CASE, vbCritical + vbOKOnly);
        Result := False;
        Exit;
      end;

  Result := True;
end;

procedure TFrmEstimatedItemNew.btOKClick(Sender: TObject);
begin
  if not ValidateItem then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  if FFrmCommand = btInc then
    InsertEstimatedItem
  else if FFrmCommand = btAlt then
    UpdateEstimatedItem;

  inherited;

  if btLoopInc.Down then
  begin
    ModalResult := mrNone;
    TFrmEstimated(Owner).RefreshEstimatedItem;
    LimpaCampos;
  end;

  cmbModel.SetFocus;
end;

procedure TFrmEstimatedItemNew.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);
  DM.imgSmall.GetBitmap(BTN18_LAMP, btShowCost.Glyph);
  FFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);
end;

procedure TFrmEstimatedItemNew.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;
  with FFrmBarcodeSearch do
  begin
    R := Start(MOV_TYPE_SALE);
    if R <> -1 then
    begin
      cmbModel.LookUpValue := IntToStr(R);
      if cmbModel.LookUpValue <> '' then
        cmbModelSelectItem(Sender);
    end;
  end;
end;

procedure TFrmEstimatedItemNew.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F2 then
    btnSearchDesc.Click;
end;

procedure TFrmEstimatedItemNew.edtSalePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TFrmEstimatedItemNew.cmbModelSelectItem(Sender: TObject);
begin
  inherited;
  RefreshPrice(True, True);
  RefreshDepartment;
  fModelCaseQty := StrToFloatDef(VarToStr(cmbModel.GetFieldByName('CaseQty')),0);
  edtQty.SetFocus;
end;

procedure TFrmEstimatedItemNew.RefreshPrice(bSale, bCost : Boolean);
begin

  if cmbModel.LookUpValue <> '' then
  try
    quPrice.Parameters.ParamByName('IDModel').Value := cmbModel.LookUpValue;
    quPrice.Open;
    if bSale then
      edtSalePrice.Text  := FormatFloat('#0.00', quPriceSellingPrice.AsCurrency);
    if bCost then
      EditCostPrice.Text := FormatFloat('#0.00', quPriceFinalCost.AsCurrency);
  finally
    quPrice.Close;
  end;
end;

procedure TFrmEstimatedItemNew.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FFrmBarcodeSearch);
end;

procedure TFrmEstimatedItemNew.LoadEstimatedItem;
begin
  with quEstimetedItems do
  begin
    Parameters.ParamByName('IDEstimatedItem').Value := FIDEstimatedItem;
    Open;

    cmbModel.LookUpValue := FieldByName('IDModel').Value;
    edtQty.Text := FieldByName('Qty').Value;
    edtSalePrice.Text := FormatFloat('#0.00', FieldByName('EstSalePrice').AsCurrency);
    RefreshPrice(False, True);
  end;
end;

procedure TFrmEstimatedItemNew.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  quEstimetedItems.Close;
end;

procedure TFrmEstimatedItemNew.LimpaCampos;
var
  i: integer;
begin
  for i := 0 to ComponentCount -1 do
    if Components[i] is TEdit then
      TEdit(Components[i]).Clear;
  cmbModel.LookUpValue := '';

  if btLoopDepartment.Visible and (not btLoopDepartment.Down) then
    scDepartment.LookUpValue := '';
end;

procedure TFrmEstimatedItemNew.edtSalePriceEnter(Sender: TObject);
begin
  inherited;
  edtSalePrice.SelectAll;
end;

procedure TFrmEstimatedItemNew.FormShow(Sender: TObject);
begin
  inherited;
  DM.imgSubMenu.GetBitmap(DM.fMainMenu.Image, imgMenu.Picture.Bitmap);
  lblSubMenu.Caption := Self.Caption;

  // Controla o aparecimento, e o readonly do preço de custo
  if Password.HasFuncRight(36) then
    pnlCostPrice.Visible := True
  else
    pnlCostPrice.Visible := Password.HasFuncRight(11); // fica somente pelo show

end;

procedure TFrmEstimatedItemNew.RefreshDepartment;
var
  FilterValue: String;
  DepartmentCount: Integer;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;

    SQL.Clear;
    SQL.Text := ' SELECT IDDepartment FROM Inv_ModelDepartment ' +
                ' WHERE ModelID = ' + cmbModel.LookUpValue + ' AND StoreID = ' + InttoStr(DM.fStore.IDStoreSale);
    Open;

    DepartmentCount := DM.quFreeSQL.RecordCount;

    if IsEmpty then
    begin
      if Active then
        Close;

      SQL.Clear;

      SQL.Text := ' SELECT T.IDDepartment FROM Model M JOIN TabGroup T ON (T.IDGroup = M.GroupID) ' +
                  ' WHERE M.IDModel = ' + cmbModel.LookUpValue;
      Open;

      DepartmentCount := 1;
    end;

    if not(IsEmpty) then
    begin
      {
      First;
      while not EOF do
      begin
        if FilterValue = '' then
          FilterValue := 'IDDepartment = ' + FieldByName('IDDepartment').AsString
        else
          FilterValue := FilterValue + ' or ' + 'IDDepartment = ' + FieldByName('IDDepartment').AsString;
        Next;
      end;
      }
      if DepartmentCount = 1 then
        scDepartment.LookUpValue := FieldByName('IDDepartment').AsString
      else
        scDepartment.SpcWhereClause := FilterValue;
    end;

    Close;
  end;

  {
  if DepartmentCount <= 1 then
  begin
    scDepartment.Visible := False;
    lblDepartment.Visible := False;
    btLoopDepartment.Visible := False;
  end
  else
  begin
    scDepartment.Visible := True;
    lblDepartment.Visible := True;
    btLoopDepartment.Visible := True;
  end;
  }
end;

procedure TFrmEstimatedItemNew.btShowCostClick(Sender: TObject);
begin
  inherited;
  editCostPrice.Visible := btShowCost.Down;
  lblCost.Visible := btShowCost.Down;
end;

end.
