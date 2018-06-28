unit uFrmModelPriceAdj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, LblEffct, ExtCtrls, StdCtrls, CheckLst, Buttons, Db, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT, ComCtrls, Grids, DBGrids,
  SMDBGrid, Mask, SuperComboADO, Variants, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Provider, DBClient, uDMCalcPrice, uDMInventory;

type
  TfrmModelPriceAdj = class(TFrmParent)
    btOk: TButton;
    quCategory: TPowerADOQuery;
    quUpdate: TADOQuery;
    pgModelInfo: TPageControl;
    tsPrice: TTabSheet;
    tsFloating: TTabSheet;
    Label4: TLabel;
    clbCategories: TCheckListBox;
    scGroup: TSuperComboADO;
    btGroupAll: TButton;
    lbCateg: TLabel;
    quModelFloating: TADODataSet;
    dsModelFloating: TDataSource;
    quModelFloatingModel: TStringField;
    quModelFloatingDescription: TStringField;
    quModelFloatingFloatPercent: TIntegerField;
    quModelFloatingPessoa: TStringField;
    quModelFloatingName: TStringField;
    scFabricante: TSuperComboADO;
    btFabricanteAll: TButton;
    lbManu: TLabel;
    tsPricing: TTabSheet;
    lbCate1: TLabel;
    scCategoryPrice: TSuperComboADO;
    lbManu1: TLabel;
    scManufacturePrice: TSuperComboADO;
    btnManuAll: TButton;
    lbVer: TLabel;
    scVerticalPrice: TSuperComboADO;
    btnVerticalAll: TButton;
    lbHor: TLabel;
    scHorizontalPrice: TSuperComboADO;
    btnHorizAll: TButton;
    lbNew: TLabel;
    edtAdjustValue: TEdit;
    lbDesc: TLabel;
    edtDescription: TEdit;
    btSelectAll: TSpeedButton;
    btUnSelectAll: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    lblValue: TLabel;
    cmbAdjType: TComboBox;
    cmbCalcType: TComboBox;
    edtValue: TEdit;
    grdPriceRange: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtPrice1: TEdit;
    edtPrice2: TEdit;
    Label3: TLabel;
    gdUpdatePriceDBTableView: TcxGridDBTableView;
    gdUpdatePriceLevel: TcxGridLevel;
    gdUpdatePrice: TcxGrid;
    gdUpdatePriceDBTableModel: TcxGridDBColumn;
    gdUpdatePriceDBTableDescription: TcxGridDBColumn;
    gdUpdatePriceDBTableSellingPrice: TcxGridDBColumn;
    cdsModelFloating: TClientDataSet;
    dspModelFloating: TDataSetProvider;
    cdsModelFloatingModel: TStringField;
    cdsModelFloatingDescription: TStringField;
    cdsModelFloatingPessoa: TStringField;
    cdsModelFloatingName: TStringField;
    cdsModelFloatingFloatPercent: TIntegerField;
    quModelFloatingIDModel: TIntegerField;
    cdsModelFloatingIDModel: TIntegerField;
    grdFloating: TcxGrid;
    grdFloatingTableView: TcxGridDBTableView;
    grdFloatingLevel: TcxGridLevel;
    grdFloatingTableViewModel: TcxGridDBColumn;
    grdFloatingTableViewDescription: TcxGridDBColumn;
    grdFloatingTableViewPessoa: TcxGridDBColumn;
    grdFloatingTableViewName: TcxGridDBColumn;
    grdFloatingTableViewFloatPercent: TcxGridDBColumn;
    btnRefresh: TSpeedButton;
    lblVendor: TLabel;
    scVendor: TSuperComboADO;
    btVendorAll: TButton;
    btnPriceGo: TSpeedButton;
    btnCatgAll: TButton;
    edtNewFloat: TEdit;
    lbNewFloat: TLabel;
    quModelPrice: TADODataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField4: TStringField;
    BCDField1: TBCDField;
    dspModelPrice: TDataSetProvider;
    cdsModelPrice: TClientDataSet;
    dsModelPrice: TDataSource;
    lblStore: TLabel;
    scStore: TSuperComboADO;
    btnStoreAll: TButton;
    cbxAdjustMode: TComboBox;
    quModelPriceVendorCost: TBCDField;
    quModelPriceStoreSellingPrice: TBCDField;
    quModelPriceStoreCostPrice: TBCDField;
    gdUpdatePriceDBTableVendorCost: TcxGridDBColumn;
    gdUpdatePriceDBTableStoreSellingPrice: TcxGridDBColumn;
    gdUpdatePriceDBTableStoreCostPrice: TcxGridDBColumn;
    quModelPriceMarkup: TBCDField;
    quModelPriceOriginalSellingPrice: TBCDField;
    gdUpdatePriceDBTableOriginalSellingPrice: TcxGridDBColumn;
    quModelPriceRealMarkUp: TBCDField;
    quModelPriceOrigStoreSellingPrice: TBCDField;
    quModelPriceRealStoreMarkUp: TBCDField;
    cdsModelPriceIDModel: TIntegerField;
    cdsModelPriceModel: TStringField;
    cdsModelPriceDescription: TStringField;
    cdsModelPriceName: TStringField;
    cdsModelPriceOriginalSellingPrice: TBCDField;
    cdsModelPriceSellingPrice: TBCDField;
    cdsModelPriceVendorCost: TBCDField;
    cdsModelPriceMarkup: TBCDField;
    cdsModelPriceRealMarkUp: TBCDField;
    cdsModelPriceOrigStoreSellingPrice: TBCDField;
    cdsModelPriceStoreSellingPrice: TBCDField;
    cdsModelPriceStoreCostPrice: TBCDField;
    cdsModelPriceRealStoreMarkUp: TBCDField;
    gdUpdatePriceDBTableOrigStoreSellingPrice: TcxGridDBColumn;
    gdUpdatePriceDBTableRealMarkUp: TcxGridDBColumn;
    gdUpdatePriceDBTableRealStoreMarkUp: TcxGridDBColumn;
    pnlPrices: TPanel;
    rbSalePrice: TRadioButton;
    rbPromoPrice: TRadioButton;
    lbUpdate: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure cmbCalcTypeChange(Sender: TObject);
    procedure edtDescriptionExit(Sender: TObject);
    procedure btSelectAllClick(Sender: TObject);
    procedure btUnSelectAllClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure pgModelInfoChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure btGroupAllClick(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure btVendorAllClick(Sender: TObject);
    procedure btnCatgAllClick(Sender: TObject);
    procedure btnManuAllClick(Sender: TObject);
    procedure btnVerticalAllClick(Sender: TObject);
    procedure btnHorizAllClick(Sender: TObject);
    procedure btnStoreAllClick(Sender: TObject);
    procedure scStoreSelectItem(Sender: TObject);
  private
    FDMInventory: TDMInventory;
    DMCalcPrice: TDMCalcPrice;
    slCategoryIDList: TStrings;
    iIDStoreFiltered: Integer;

    procedure LoadList;

    procedure OpenModelPrice;
    procedure CloseModelPrice;
    procedure OpenModelFloating;
    procedure CloseModelFloating;
    procedure RefreshModel;

    procedure ApplyChanges(ATabIndex: Integer);
    procedure ApplyPricesByCategory;
    procedure ApplyFloatingPerc;
    procedure ApplyPricesByModel;

    procedure SavePriceChanges(FIDStore : Integer);

    procedure CalcNewPrices;
    procedure UpdateStorePrices;
    procedure UpdatePromoPrices;

    function GetExpressionStr: string;
    function GetCategoryList: String;
    function CategorySelected: Boolean;
    function HasChange(ATabIndex: Integer): Boolean;
    function GetModelPriceSQL: String;
  public
    function Start(ACategoryID: String; AParams: String = ''): Boolean;
  end;

implementation

uses uDM, uDMGlobal, uMsgBox, uMsgConstant, uSystemConst, uSqlFunctions,
  uCharFunctions, uNumericFunctions, uParamFunctions;

{$R *.DFM}

function TfrmModelPriceAdj.GetExpressionStr: string;
var
  OperChar: Char;
  sAbsValue, sValue: String;
begin
  Result:= '';

  if StrToFloat(edtValue.Text) > 0 then
    OperChar:= '*'
  else
    OperChar:= '/';

  sValue := StringReplace(FloatToStr(StrToFloat(edtValue.Text)), ',', '.', [rfReplaceAll]);
  sAbsValue := StringReplace(FloatToStr(Abs(StrToFloat(edtValue.Text))), ',', '.', [rfReplaceAll]);

  //Tipo de Ajuste
  if cmbAdjType.ItemIndex = 0 then //Model Selling Price
  begin
    //Tipo de Calculo: 0- Percentual, 1- Constante
    if cmbCalcType.ItemIndex = 0 then
      Result:= 'SellingPrice ' + OperChar + ' (1 + ' + sAbsValue + '/ 100.0)'
    else
      Result:= 'SellingPrice + ' + sValue;
  end
  else  //Model Profit
  begin
    //Tipo de Calculo: 0- Percentual, 1- Constante
    if cmbCalcType.ItemIndex = 0 then
      Result:= 'VendorCost + ((SellingPrice - VendorCost) ' + OperChar +' (1 + ' + sAbsValue + '/ 100.0))'
    else
      Result:= 'VendorCost + ((SellingPrice - VendorCost) + ' + sValue + ')';
  end;
end;

function TfrmModelPriceAdj.GetCategoryList: String;
var
  i: Integer;
begin
  Result:= '';

  for i := 0 to clbCategories.Items.Count - 1 do
    if clbCategories.Checked[i] then
      if Result = '' then
        Result:= slCategoryIDList[i]
      else
        Result:= Result + ', ' + slCategoryIDList[i];
end;

function TfrmModelPriceAdj.CategorySelected: boolean;
var
  i: Integer;
begin
  Result:= false;

  for i := 0 to clbCategories.Items.Count - 1 do
    if clbCategories.Checked[i] then
    begin
      Result:= true;
      break;
    end;
end;

procedure TfrmModelPriceAdj.LoadList;
begin
  with quCategory do
  begin
    First;
    slCategoryIDList.Clear;
    clbCategories.Clear;

    while not Eof do
    begin
      clbCategories.Items.Add(FieldByName('Name').AsString);
      slCategoryIDList.Add(FieldByName('IDGroup').AsString);
      Next;
    end;
  end;
end;

function TfrmModelPriceAdj.Start(ACategoryID: String; AParams: String = ''): Boolean;
var
  iID: Integer;
begin
  pgModelInfo.TabIndex := 0;
  cmbAdjType.ItemIndex := 0;
  cmbCalcType.ItemIndex := 0;
  edtPrice1.Clear;
  edtPrice2.Clear;
  edtValue.Clear;

  quCategory.Open;
  LoadList;

  iID := slCategoryIDList.IndexOf(ACategoryID);
  if iID > -1 then
    clbCategories.Checked[iID] := true;

  if ParseParam(AParams, 'PriceAdjust') = '1' then
  begin
    tsPrice.TabVisible := False;
    tsFloating.TabVisible := False;
    scStore.LookUpValue := ParseParam(AParams, 'IDStore');    
  end;

  pnlPrices.Visible := (scStore.LookUpValue = '');

  ShowModal;

  quCategory.Close;
end;

procedure TfrmModelPriceAdj.edtValueKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Pos('.', edtAdjustValue.Text) > 0) or (Pos(',', edtAdjustValue.Text) > 0)) and ((Key = '.') or (Key = ',')) then
  begin
    Key := Chr(VK_CLEAR);
    Exit;
  end;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:    if Key = ',' then Key := '.';
    LANG_PORTUGUESE: if Key = '.' then Key := ',';
    LANG_SPANISH:    if Key = '.' then Key := ',';
  end;

  Key := ValidateCurrency(Key);
end;

procedure TfrmModelPriceAdj.FormCreate(Sender: TObject);
begin
  slCategoryIDList := TStringList.Create;
  tsFloating.TabVisible := DM.fSystem.SrvParam[PARAM_DISPLAY_QTY_FLOATING];
  FDMInventory := TDMInventory.Create(Self);
end;

procedure TfrmModelPriceAdj.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(slCategoryIDList);
  FreeAndNil(DMCalcPrice);
  FreeAndNil(FDMInventory);
end;

procedure TfrmModelPriceAdj.btOkClick(Sender: TObject);
begin
  ApplyChanges(pgModelInfo.ActivePageIndex);
  inherited;
end;

procedure TfrmModelPriceAdj.cmbCalcTypeChange(Sender: TObject);
begin
  inherited;
  lblValue.Caption:= cmbCalcType.Items[cmbCalcType.ItemIndex];
end;

procedure TfrmModelPriceAdj.CloseModelFloating;
begin
  with cdsModelFloating do
    if Active then
      Close;
end;

procedure TfrmModelPriceAdj.OpenModelFloating;
var
  sIDFabricante,
  sIDGroup,
  sWHERE: String;
begin
  sIDFabricante := scFabricante.LookUpValue;
  sIDGroup      := scGroup.LookUpValue;

  sWHERE := ' M.Desativado = 0 AND M.ModelType IN (' + QuotedStr('R') + ',' +
    QuotedStr('S') + ',' + QuotedStr('V') + ',' + QuotedStr('C') + ',' + QuotedStr('G') + ') ';

  with quModelFloating do
    if not Active then
    begin
      if sIDFabricante <> '' then
         sWHERE := sWHERE + ' AND IDFabricante = ' + sIDFabricante;

      if sIDGroup <> '' then
         sWHERE := sWHERE + ' AND GroupID = ' + sIDGroup;

      CommandText := ChangeWhereClause(CommandText, sWHERE, True);

      cdsModelFloating.Open;
    end;
end;

procedure TfrmModelPriceAdj.RefreshModel;
begin
  if pgModelInfo.ActivePage = tsFloating then
  begin
    CloseModelFloating;
    OpenModelFloating;
  end
  else if pgModelInfo.ActivePage = tsPricing then
  begin
    CloseModelPrice;
    OpenModelPrice;
  end;
end;

procedure TfrmModelPriceAdj.edtDescriptionExit(Sender: TObject);
begin
  inherited;
  if Trim(edtDescription.Text) <> '' then
    RefreshModel;
end;

procedure TfrmModelPriceAdj.btSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  with clbCategories do
    for I := 0 to Pred(Items.Count) do
      Checked[I] := True;
end;

procedure TfrmModelPriceAdj.btUnSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  with clbCategories do
    for I := 0 to Pred(Items.Count) do
      Checked[I] := False;
end;

procedure TfrmModelPriceAdj.ApplyPricesByCategory;
var
  sIDModelList, sWhere: String;
begin
  if not CategorySelected then
  begin
    clbCategories.SetFocus;
    MsgBox(MSG_CRT_NOT_EMPTY_CATEGORY, vbOkOnly + vbCritical);
    ModalResult := mrNone;
  end
  else if edtValue.Text = '' then
  begin
    edtValue.SetFocus;
    MsgBox(MSG_CRT_NO_EMPTY_VALUE, vbOkOnly + vbCritical);
    ModalResult := mrNone;
  end
  else
    with quUpdate do
    try
      SQL.Clear;
      SQL.Add(' UPDATE MODEL');
      SQL.Add(' SET SellingPrice = ' + GetExpressionStr);
      SQL.Add(' , DateLastSellingPrice = GetDate(), IDUserLastSellingPrice = ' + InttoStr(DM.fUser.ID));
      SQL.Add(' WHERE GROUPID IN ('+ GetCategoryList + ')');

      if edtPrice1.Text <> '' then
      begin
        SQL.Add(' AND SellingPrice >= :MinPrice');
        Parameters.ParamByName('MinPrice').Value := MyStrToCurrency(edtPrice1.Text);
      end;

      if edtPrice2.Text <> '' then
      begin
        SQL.Add(' AND SellingPrice <= :MaxPrice');
        Parameters.ParamByName('MaxPrice').Value := MyStrToCurrency(edtPrice2.Text);
      end;

      ExecSQL;
      MsgBox(MSG_INF_ADJUSTMENT, vbOkOnly);
    except
      on E: Exception do
      begin
        MsgBox(MSG_CRT_NOT_UPDATE_SELL_PRICE + #13 + E.Message, vbOkOnly + vbCritical);
      end;
    end;
end;

procedure TfrmModelPriceAdj.btnGoClick(Sender: TObject);
var
  iActivePageIndex: Integer;
begin
  iActivePageIndex := pgModelInfo.ActivePageIndex;

  if HasChange(iActivePageIndex) and (edtAdjustValue.Text <> '') then
    if MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbSuperCritical + vbYesNo) = vbYes then
      ApplyChanges(iActivePageIndex);

  RefreshModel;
end;

function TfrmModelPriceAdj.HasChange(ATabIndex: Integer): Boolean;
begin
  Result := False; 

  case ATabIndex of
    1: Result := cdsModelFloating.ChangeCount > 0;
    2: Result := cdsModelPrice.ChangeCount > 0;
  end;
end;

procedure TfrmModelPriceAdj.btCloseClick(Sender: TObject);
var
  iActivePageIndex: Integer;
begin
  iActivePageIndex := pgModelInfo.ActivePageIndex;

  if HasChange(iActivePageIndex) and (edtAdjustValue.Text <> '') then
    if MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbQuestion + vbYesNo) = vbYes then
      ApplyChanges(iActivePageIndex);

  inherited;
end;

procedure TfrmModelPriceAdj.ApplyChanges(ATabIndex: Integer);
begin
  case ATabIndex of
    0: ApplyPricesByCategory;
    1: ApplyFloatingPerc;
    2: ApplyPricesByModel;
  end;
end;

procedure TfrmModelPriceAdj.pgModelInfoChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  iActivePageIndex: Integer;
begin
  inherited;
  AllowChange := True;
  iActivePageIndex := pgModelInfo.ActivePageIndex;

  if HasChange(iActivePageIndex) and (edtAdjustValue.Text <> '') then
    if MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbQuestion + vbYesNo) = vbYes then
      ApplyChanges(iActivePageIndex);
end;

procedure TfrmModelPriceAdj.btGroupAllClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text := '<->';
end;

procedure TfrmModelPriceAdj.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scFabricante.LookUpValue := '';
  scFabricante.Text := '<->';
end;

procedure TfrmModelPriceAdj.btVendorAllClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text := '<->';
end;

procedure TfrmModelPriceAdj.btnCatgAllClick(Sender: TObject);
begin
  inherited;
  scCategoryPrice.LookUpValue := '';
  scCategoryPrice.Text := '<->';
end;

procedure TfrmModelPriceAdj.btnManuAllClick(Sender: TObject);
begin
  inherited;
  scManufacturePrice.LookUpValue := '';
  scManufacturePrice.Text := '<->';
end;

procedure TfrmModelPriceAdj.btnVerticalAllClick(Sender: TObject);
begin
  inherited;
  scVerticalPrice.LookUpValue := '';
  scVerticalPrice.Text := '<->';
end;

procedure TfrmModelPriceAdj.btnHorizAllClick(Sender: TObject);
begin
  inherited;
  scHorizontalPrice.LookUpValue := '';
  scHorizontalPrice.Text := '<->';
end;

procedure TfrmModelPriceAdj.CloseModelPrice;
begin
  with cdsModelPrice do
    if Active then
      Close;
end;

procedure TfrmModelPriceAdj.OpenModelPrice;
begin

  if scStore.LookUpValue = '' then
  begin
    iIDStoreFiltered := -1;
    gdUpdatePriceDBTableOriginalSellingPrice.Visible  := True;
    gdUpdatePriceDBTableSellingPrice.Visible          := True;
    gdUpdatePriceDBTableVendorCost.Visible            := True;
    gdUpdatePriceDBTableRealMarkUp.Visible            := True;
    gdUpdatePriceDBTableOrigStoreSellingPrice.Visible := False;
    gdUpdatePriceDBTableStoreSellingPrice.Visible     := False;
    gdUpdatePriceDBTableStoreCostPrice.Visible        := False;
    gdUpdatePriceDBTableRealStoreMarkUp.Visible       := False;
  end
  else
  begin
    iIDStoreFiltered := StrToInt(scStore.LookUpValue);
    gdUpdatePriceDBTableOriginalSellingPrice.Visible  := False;
    gdUpdatePriceDBTableSellingPrice.Visible          := False;
    gdUpdatePriceDBTableVendorCost.Visible            := False;
    gdUpdatePriceDBTableRealMarkUp.Visible            := False;
    gdUpdatePriceDBTableOrigStoreSellingPrice.Visible := True;
    gdUpdatePriceDBTableStoreSellingPrice.Visible     := True;
    gdUpdatePriceDBTableStoreCostPrice.Visible        := True;
    gdUpdatePriceDBTableRealStoreMarkUp.Visible       := True;
  end;

  with quModelPrice do
    if not Active then
    begin
      CommandText := GetModelPriceSQL;
      cdsModelPrice.Open;
      CalcNewPrices;
    end;
    
end;

procedure TfrmModelPriceAdj.ApplyFloatingPerc;
begin
  if not cdsModelFloating.IsEmpty then
  begin
    if edtNewFloat.Text <> '' then
    begin
      with cdsModelFloating do
      begin
        DisableControls;
        Screen.Cursor := crHourGlass;
        First;
        while not Eof do
        begin
          Edit;
          FieldByName('FloatPercent').AsFloat := StrToFloat(edtNewFloat.Text);
          Post;
          Next;
        end;
      end;
    end;
    cdsModelFloating.ApplyUpdates(-1);
    cdsModelFloating.EnableControls;
    Screen.Cursor := crDefault;
  end
  else
  begin
    MsgBox(MSG_CRT_NO_MODEL_SELECTED, vbCritical + vbOKOnly);
    ModalResult := mrNone;
  end;
end;

procedure TfrmModelPriceAdj.ApplyPricesByModel;
begin
  if not cdsModelPrice.IsEmpty then
  begin
    if iIDStoreFiltered = -1 then
    begin
      if rbSalePrice.Checked then
      begin
        cdsModelPrice.ApplyUpdates(-1);
        SavePriceChanges(0);
      end
      else
        UpdatePromoPrices;
    end
    else
      begin
        UpdateStorePrices;
      end;
  end
  else
  begin
    MsgBox(MSG_CRT_NO_MODEL_SELECTED, vbCritical + vbOKOnly);
    ModalResult := mrNone;
  end;
end;

procedure TfrmModelPriceAdj.btnStoreAllClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text := '<->';
  pnlPrices.Visible := (scStore.LookUpValue = '');
end;

procedure TfrmModelPriceAdj.UpdateStorePrices;
begin
  with cdsModelPrice do
  try
    DisableControls;
    Screen.Cursor := crHourGlass;
    First;

    //if rbPromoPrice.Checked then
    //   sField :=
    while not Eof do
    begin
      quUpdate.SQL.Clear;
      quUpdate.SQL.Add('UPDATE Inventory');
      quUpdate.SQL.Add('SET SellingPrice = :SellingPrice');
      quUpdate.SQL.Add('WHERE StoreID = :IDStore AND ModelID = :IDModel');
      quUpdate.Parameters.ParamByName('SellingPrice').Value := FieldByName('StoreSellingPrice').Value;
      quUpdate.Parameters.ParamByName('IDStore').Value := iIDStoreFiltered;
      quUpdate.Parameters.ParamByName('IDModel').Value := FieldByName('IDModel').Value;
      quUpdate.ExecSQL;

      FDMInventory.ModelPriceLog(cdsModelPriceIDModel.AsInteger,
                                 DM.fUser.ID,
                                 iIDStoreFiltered,
                                 FieldByName('VendorCost').Value,
                                 FieldByName('VendorCost').Value,
                                 FieldByName('OriginalSellingPrice').Value,
                                 FieldByName('SellingPrice').Value);

      Next;
    end;
  finally
    First;
    EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

function TfrmModelPriceAdj.GetModelPriceSQL: String;
var
  sIDStore,
  sIDFabricante,
  sIDGroup,
  sIDSize,
  sIDColor,
  sDescription,
  sWhere: String;
begin
  sIDStore      := scStore.LookUpValue;
  sIDFabricante := scManufacturePrice.LookUpValue;
  sIDGroup      := scCategoryPrice.LookUpValue;
  sIDSize       := scHorizontalPrice.LookUpValue;
  sIDColor      := scVerticalPrice.LookUpValue;
  sDescription  := Trim(edtDescription.Text);

  Result := 'SELECT ' +
            '  M.IDModel, ' +
            '  M.Model, ' +
            '  M.[Description], ' +
            '  M.SellingPrice OriginalSellingPrice, ' +
            '  M.SellingPrice, ' +
            '  M.VendorCost, ' +
            '  M.Markup, ' +
            '  CASE WHEN IsNull(M.SellingPrice, 0) > 0 AND IsNull(M.VendorCost, 0) <> 0 THEN (IsNull(M.SellingPrice, 0) - IsNull(M.VendorCost, 0)) / IsNull(M.VendorCost, 0) * 100 ELSE 0 END RealMarkUp, ' +
            '  C.[Name], ';

  if sIDStore = '' then
    Result := Result +
              '  CAST(0 as money) OrigStoreSellingPrice, ' +
              '  CAST(0 as money) StoreSellingPrice, ' +
              '  CAST(0 as money) StoreCostPrice, ' +
              '  CAST(0 as money) RealStoreMarkUp ' +
              'FROM ' +
              '  Model M ' +
              '  JOIN TabGroup C ON (C.IDGroup = M.GroupID) '
  else
    Result := Result +
              '  IsNull(I.SellingPrice, M.SellingPrice) OrigStoreSellingPrice, ' +
              '  IsNull(I.SellingPrice, M.SellingPrice) StoreSellingPrice, ' +
              '  IsNull(I.StoreCostPrice, M.VendorCost) StoreCostPrice, ' +
              '  CASE WHEN IsNull(I.SellingPrice, M.SellingPrice) > 0 AND IsNull(I.StoreCostPrice, M.VendorCost) <> 0 THEN ' + '(IsNull(I.SellingPrice, M.SellingPrice) - IsNull(I.StoreCostPrice, M.VendorCost)) / IsNull(I.StoreCostPrice, M.VendorCost) * 100 ELSE 0 END RealStoreMarkUp ' +
              'FROM ' +
              '  Model M (NOLOCK) ' +
              '  JOIN TabGroup C (NOLOCK) ON (C.IDGroup = M.GroupID) ' +
              '  JOIN Inventory I (NOLOCK) ON (M.IDModel = I.ModelID) ';

  sWhere := 'WHERE M.Desativado = 0 AND M.ModelType IN (' + QuotedStr('R') + ',' +
    QuotedStr('S') + ',' + QuotedStr('V') + ',' + QuotedStr('C') + ',' + QuotedStr('G') + ') ';

  if sIDStore <> '' then
     sWhere := sWhere + ' AND I.StoreID = ' + sIDStore;

  if sIDFabricante <> '' then
     sWhere := sWhere + ' AND M.IDFabricante = ' + sIDFabricante;

  if sIDGroup <> '' then
     sWhere := sWhere + ' AND M.GroupID = ' + sIDGroup;

  if sIDSize <> '' then
     sWhere := sWhere + ' AND M.IDSize = ' + sIDSize;

  if sIDColor <> '' then
     sWhere := sWhere + ' AND M.IDColor = ' + sIDColor;

  if sDescription <> '' then
     sWhere := sWhere + ' AND M.Description like ' + QuotedStr('%' + sDescription + '%');

  Result := Result + sWhere
end;

procedure TfrmModelPriceAdj.CalcNewPrices;
var
  dAdjustValue: Double;
begin
  if Trim(edtAdjustValue.Text) = '' then
    dAdjustValue := StrToFloatDef(edtAdjustValue.Text, 0)
  else
    dAdjustValue := StrToFloat(edtAdjustValue.Text);

  if not Assigned(DMCalcPrice) then
    DMCalcPrice := TDMCalcPrice.Create(Self);

  with cdsModelPrice do
  try
    DisableControls;
    Screen.Cursor := crHourGlass;
    First;
    while not Eof do
    begin
      Edit;
      case cbxAdjustMode.ItemIndex of
        0: begin
             if iIDStoreFiltered = -1 then
             begin
               if rbSalePrice.Checked then
               begin
                 FieldByName('Markup').AsFloat := dAdjustValue;
                 FieldByName('SellingPrice').AsCurrency := DMCalcPrice.GetMarkupPrice(FieldByName('VendorCost').AsCurrency, dAdjustValue);
               end
               else
               begin
                 if (dAdjustValue <> 0) then
                    FieldByName('SellingPrice').AsCurrency := FieldByName('SellingPrice').AsCurrency + (FieldByName('SellingPrice').AsCurrency - DMCalcPrice.GetMarkupPrice(FieldByName('SellingPrice').AsCurrency, dAdjustValue))
                 else
                    FieldByName('SellingPrice').AsCurrency := 0;
               end;
             end
             else
               FieldByName('StoreSellingPrice').AsCurrency := DMCalcPrice.GetMarkupPrice(FieldByName('StoreCostPrice').AsCurrency, dAdjustValue);
           end;
        1: begin
             if iIDStoreFiltered = -1 then
               FieldByName('SellingPrice').AsCurrency := dAdjustValue
             else
               FieldByName('StoreSellingPrice').AsCurrency := dAdjustValue;
           end;
      end;
      Post;
      Next;
    end;

  finally
    First;
    EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmModelPriceAdj.UpdatePromoPrices;
begin

  with cdsModelPrice do
  try
    DisableControls;
    Screen.Cursor := crHourGlass;
    First;

    while not Eof do
    begin
      quUpdate.SQL.Clear;
      quUpdate.SQL.Add('UPDATE Model');
      quUpdate.SQL.Add('SET PromotionPrice = :PromotionPrice');
      quUpdate.SQL.Add('WHERE IDModel = :IDModel');
      quUpdate.Parameters.ParamByName('PromotionPrice').Value := FieldByName('SellingPrice').Value;
      quUpdate.Parameters.ParamByName('IDModel').Value := FieldByName('IDModel').Value;
      quUpdate.ExecSQL;
      Next;
    end;
  finally
    First;
    EnableControls;
    Screen.Cursor := crDefault;
  end;

end;

procedure TfrmModelPriceAdj.scStoreSelectItem(Sender: TObject);
begin
  inherited;
  pnlPrices.Visible := (scStore.LookUpValue = '');
end;

procedure TfrmModelPriceAdj.SavePriceChanges(FIDStore: Integer);
var
  cCostOld, sCostNew, cSaleOld, cSaleNew : Currency;
begin

  try

    cdsModelPrice.DisableControls;
    Screen.Cursor := crHourGlass;
    cdsModelPrice.First;

    while not cdsModelPrice.Eof do
    begin
      cCostOld := cdsModelPriceVendorCost.AsCurrency;
      sCostNew := cdsModelPriceVendorCost.AsCurrency;
      cSaleOld := cdsModelPriceOriginalSellingPrice.AsCurrency;
      cSaleNew := cdsModelPriceSellingPrice.AsCurrency;

      FDMInventory.ModelPriceLog(cdsModelPriceIDModel.AsInteger,
                                 DM.fUser.ID,
                                 FIDStore,
                                 cCostOld,
                                 sCostNew,
                                 cSaleOld,
                                 cSaleNew);

      cdsModelPrice.Next;
    end;
  finally
    cdsModelPrice.First;
    cdsModelPrice.EnableControls;
    Screen.Cursor := crDefault;
    end;


end;

end.
