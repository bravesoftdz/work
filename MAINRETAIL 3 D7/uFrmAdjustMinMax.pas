unit uFrmAdjustMinMax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Mask, SuperComboADO, Buttons, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DateBox, ADODB, Provider, DBClient;

type
  TFrmAdjustMinMax = class(TFrmParent)
    lbManufect: TLabel;
    lbVerti: TLabel;
    lbHoriz: TLabel;
    lbCategory: TLabel;
    lbGroup: TLabel;
    lbStore: TLabel;
    lbSubGroup: TLabel;
    edBarcode: TEdit;
    btSearch: TBitBtn;
    cbxMethod: TComboBox;
    cbxType: TComboBox;
    scFabricante: TSuperComboADO;
    btFabricanteAll: TButton;
    scColor: TSuperComboADO;
    scSize: TSuperComboADO;
    btnSizeClear: TButton;
    btnColorClear: TButton;
    scCategory: TSuperComboADO;
    btnCategClear: TButton;
    scGroup: TSuperComboADO;
    btnGroupClear: TButton;
    scStore: TSuperComboADO;
    scSubGroup: TSuperComboADO;
    btnSubGroupClear: TButton;
    lbVendor: TLabel;
    scVendor: TSuperComboADO;
    Button1: TButton;
    lbSalePeriod: TLabel;
    dtPeriod: TDateBox;
    Panel4: TPanel;
    pnlButtons: TPanel;
    btExcel: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    pnlDivisoria2: TPanel;
    grdBrowseMinMax: TcxGrid;
    grdBrowseMinMaxDB: TcxGridDBTableView;
    grdBrowseMinMaxLevel: TcxGridLevel;
    dsMinMax: TDataSource;
    grdBrowseMinMaxDBModel: TcxGridDBColumn;
    grdBrowseMinMaxDBDescription: TcxGridDBColumn;
    grdBrowseMinMaxDBModelPrice: TcxGridDBColumn;
    grdBrowseMinMaxDBStoreSellingPrice: TcxGridDBColumn;
    grdBrowseMinMaxDBQtyOnHand: TcxGridDBColumn;
    grdBrowseMinMaxDBTotalQtySold: TcxGridDBColumn;
    grdBrowseMinMaxDBMinQty: TcxGridDBColumn;
    grdBrowseMinMaxDBMaxQty: TcxGridDBColumn;
    grdBrowseMinMaxDBAvgQtySold: TcxGridDBColumn;
    Panel5: TPanel;
    btnApplyMax: TSpeedButton;
    btnApplyMinMax: TSpeedButton;
    dspMinMax: TDataSetProvider;
    cdsMinMax: TClientDataSet;
    btnSave: TButton;
    lbDays: TLabel;
    strepPredefined: TcxStyleRepository;
    GridTableViewStyleSheetRose: TcxGridTableViewStyleSheet;
    cxMinMax: TcxStyle;
    grdBrowseMinMaxDBMaxSugg: TcxGridDBColumn;
    quMinMax: TADODataSet;
    quMinMaxModelID: TIntegerField;
    quMinMaxStoreID: TIntegerField;
    quMinMaxModel: TStringField;
    quMinMaxDescription: TStringField;
    quMinMaxModelPrice: TBCDField;
    quMinMaxStoreSellingPrice: TBCDField;
    quMinMaxQtyOnHand: TFloatField;
    quMinMaxTotalQtySold: TFloatField;
    quMinMaxManufacture: TStringField;
    quMinMaxCategory: TStringField;
    quMinMaxSubCategory: TStringField;
    quMinMaxMGroup: TStringField;
    quMinMaxMinQty: TFloatField;
    quMinMaxMaxQty: TFloatField;
    quMinMaxAvgQtySold: TFloatField;
    quMinMaxMaxSug: TFloatField;
    edtMinSafetyStock: TEdit;
    lblMinSafetyStock: TLabel;
    edtMaxSafetyStock: TEdit;
    lblMaxSafetyStock: TLabel;
    lblInDays: TLabel;
    grdBrowseMinMaxDBMarked: TcxGridDBColumn;
    quMinMaxMarked: TBooleanField;
    btSelectAll: TSpeedButton;
    btUnSelectAll: TSpeedButton;
    Panel6: TPanel;
    quMinMaxMinSug: TFloatField;
    grdBrowseMinMaxDBMinSugg: TcxGridDBColumn;
    btnApplyMin: TSpeedButton;
    cmdUpdateMinMax: TADOCommand;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btSearchClick(Sender: TObject);
    procedure btnCategClearClick(Sender: TObject);
    procedure btnGroupClearClick(Sender: TObject);
    procedure btnSubGroupClearClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure btnSizeClearClick(Sender: TObject);
    procedure btnColorClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quMinMaxCalcFields(DataSet: TDataSet);
    procedure dspMinMaxGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure btnApplyMinMaxClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure grdBrowseMinMaxDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure grdBrowseMinMaxDBCustomization(Sender: TObject);
    procedure grdBrowseMinMaxDBFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure btExcelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure dtPeriodChange(Sender: TObject);
    procedure btnApplyMaxClick(Sender: TObject);
    procedure edtMinSafetyStockKeyPress(Sender: TObject; var Key: Char);
    procedure btSelectAllClick(Sender: TObject);
    procedure btUnSelectAllClick(Sender: TObject);
    procedure btnApplyMinClick(Sender: TObject);
  private
    sDays : String;
    FIDStore : Integer;
    AView  : TcxCustomGridTableView;
    procedure RefreshMinMax;
    procedure SaveMinMax;
    procedure UpdateQty(sWhereText : String);
    procedure InsertQty(IDModel, IDStore: Integer);
  public
    function Start(IDStore : Integer):Boolean;
  end;

implementation

uses uDM, DateUtils, uFrmAdjustMinMaxAll, uMsgBox, uMsgConstant, uFrmExport,
     uSystemConst, uDMGlobal, StrUtils, uCharFunctions;

{$R *.dfm}

procedure TFrmAdjustMinMax.UpdateQty(sWhereText : String);
begin

  with DM.quFreeSQL do
    begin
    try
      If Active then
        Close;

      SQL.Clear;
      SQL.Add('SELECT M.IDModel FROM Model M (NOLOCK) ');
      SQL.Add(sWhereText);
      SQL.Add(' AND IDModel NOT IN (Select ModelID FROM Inventory (NOLOCK) WHERE StoreID = '+scStore.LookUpValue+')');

      Open;
      if not IsEmpty then
      begin
        First;
        while not EOF do
        begin
          InsertQty(FieldByName('IDModel').AsInteger, StrToInt(scStore.LookUpValue));
          Next;
        end;
      end;
    finally
      Close;
      end;
    end;

end;

procedure TFrmAdjustMinMax.InsertQty(IDModel, IDStore : Integer);
var
  sSQL  : String;
  IDMov : Integer;
begin
  IDMov := DM.GetNextID(MR_INVENTORY_MOV_ID);
  sSQL := 'INSERT InventoryMov ' +
          '(IDInventoryMov, InventMovTypeID, DocumentID, ' +
          ' StoreID, ModelID, MovDate, Qty)  ' +
          'VALUES ('+IntToStr(IDMov)+ ',5,'+
          '0,' + IntToStr(IDStore) + ','+
          IntToStr(IDModel) + ','+
          'GetDate(), 0)';
   DM.ADODBConnect.Execute(sSQL);
end;


procedure TFrmAdjustMinMax.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmAdjustMinMax.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsMinMax.Close; 
  Action := caFree;
end;

procedure TFrmAdjustMinMax.RefreshMinMax;
var
 sSQL, sWhere, sCampo,
 sVendorJoin, sVendorFilterJoin : String;
 sWhereST : String;
begin

  sWhereST          := ' WHERE M.Desativado = 0 ' + ' AND M.ModelType in ('+QuotedStr('R')+', '+QuotedStr('S')+', '+QuotedStr('K')+', '+QuotedStr('V')+', '+QuotedStr('C')+', '+QuotedStr('G')+') ';
  sWhere            := ' M.Desativado = 0 AND IsNull(I.StoreID, '+ IntToStr(FIDStore) +') = ' + IntToStr(FIDStore) + ' ';
  sVendorJoin       := '';
  sVendorFilterJoin := '';

  If Trim(edBarcode.Text) <> '' then
     begin
     Case cbxType.ItemIndex of
       0 : sCampo := 'M.Model %S ';
       1 : sCampo := 'M.Description %S ';
       2 : begin
           sVendorJoin := 'LEFT OUTER JOIN VendorModelCode VMC ON (M.IDModel = VMC.IDModel) ';
           sCampo      := 'M.IDModel IN (SELECT IDModel FROM VendorModelCode (NOLOCK) WHERE VendorCode %S )';
           end;
     end;

     Case cbxMethod.ItemIndex of
       0 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr(edBarcode.Text+'%')]);
       1 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text)]);
       2 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text+'%')]);
     end;
     end;

     if scVendor.LookUpValue <> '' then
     begin
       sVendorFilterJoin := ' LEFT OUTER JOIN Inv_ModelVendor MV ON (MV.IDModel = M.IDModel) ';
       sWhere := sWhere + ' AND MV.IDPessoa = ' + scVendor.LookUpValue;
     end;

     if scFabricante.LookUpValue <> '' then
     begin
        sWhere   := sWhere + ' AND M.IDFabricante = ' + scFabricante.LookUpValue;
        sWhereST := sWhereST + ' AND M.IDFabricante = ' + scFabricante.LookUpValue;
     end;

     if scSize.LookUpValue <> '' then
     begin
        sWhere := sWhere + ' AND M.IDSize = ' + scSize.LookUpValue;
        sWhereST := sWhereST + ' AND M.IDSize = ' + scSize.LookUpValue;
     end;

     if scColor.LookUpValue <> '' then
     begin
        sWhere := sWhere + ' AND M.IDColor = ' + scColor.LookUpValue;
        sWhereST := sWhereST + ' AND M.IDColor = ' + scColor.LookUpValue;
     end;

     if scCategory.LookUpValue <> '' then
     begin
        sWhere   := sWhere + ' AND M.GroupID = ' + scCategory.LookUpValue;
        sWhereST := sWhereST + ' AND M.GroupID = ' + scCategory.LookUpValue;
     end;

     if scGroup.LookUpValue <> '' then
     begin
        sWhere   := sWhere + ' AND M.IDModelGroup = ' + scGroup.LookUpValue;
        sWhereST := sWhereST + ' AND M.IDModelGroup = ' + scGroup.LookUpValue;
     end;

     if scSubGroup.LookUpValue <> '' then
     begin
        sWhere   := sWhere + ' AND M.IDModelSubGroup = ' + scSubGroup.LookUpValue;
        sWhereST := sWhereST + ' AND M.IDModelSubGroup = ' + scSubGroup.LookUpValue;
     end;

     if (dtPeriod.Text <> '') and (dtPeriod.Date < now) then
        sWhere := sWhere + ' AND IM.MovDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtPeriod.Date)) +
           ' AND IM.InventMovTypeID = ' + IntToStr(INV_MOVTYPE_SALE);


     sSQL := 'SELECT CAST(0 as bit) as Marked, M.IDModel as ModelID, I.StoreID, M.Model, M.Description, M.SellingPrice as ModelPrice, ' +
             'I.SellingPrice as StoreSellingPrice, I.QtyOnHand, SUM(IM.Qty) AS TotalQtySold, ' +
             'P.Pessoa as Manufacture, TG.Name as Category, MG.ModelGroup as SubCategory, ' +
             'MGS.ModelSubGroup as MGroup, I.MinQty, I.MaxQty ' +
             //'INTO #ModelMinMax ' +
             'FROM Model M (NOLOCK) ' +
             'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) ' +
             'LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) ' +
             'LEFT OUTER JOIN ModelSubGroup MGS (NOLOCK) ON (M.IDModelSubGroup = MGS.IDModelSubGroup) '+
             'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = M.IDFabricante) ' +
             'LEFT OUTER JOIN Inventory I (NOLOCK) ON (M.IDModel = I.ModelID) ' +
             'LEFT JOIN InventoryMov IM (NOLOCK) ON (IM.ModelID = I.ModelID AND IM.StoreID = I.StoreID) ' +
             ' ' + sVendorJoin +
             ' ' + sVendorFilterJoin +
             ' WHERE M.ModelType in ('+QuotedStr('R')+', '+QuotedStr('S')+', '+QuotedStr('K')+', '+QuotedStr('V')+', '+QuotedStr('C')+', '+QuotedStr('G')+') ' +
             ' AND ' + sWhere +
             ' GROUP BY M.IDModel, I.StoreID, M.Model, M.Description, M.SellingPrice, I.SellingPrice, ' +
             'I.QtyOnHand, P.Pessoa, TG.Name, MG.ModelGroup, MGS.ModelSubGroup, ' +
             'I.MinQty, I.MaxQty ';


     UpdateQty(sWhereST);

     With quMinMax do
        CommandText := sSQL;

     try
       Screen.Cursor := crHourGlass;
       With cdsMinMax do
       begin
         Close;
         Open;
       end;
     finally
       Screen.Cursor := crDefault;
       end;

end;

function TFrmAdjustMinMax.Start(IDStore: Integer): Boolean;
var
  AOptions : TcxGridStorageOptions;
  ASaveViewName : String;
  fRegistryPath : String;
begin
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  if (DM.fPredefinedStyle.Count > DM.fGrid.Layout) and (DM.fPredefinedStyle.Strings[DM.fGrid.Layout]<>'') then
     TcxGridDBTableView(AView).Styles.StyleSheet := TcxGridTableViewStyleSheet(DM.fPredefinedStyle.Objects[DM.fGrid.Layout]);

  grdBrowseMinMaxDBMinQty.Styles.Content := cxMinMax;
  grdBrowseMinMaxDBMaxQty.Styles.Content := cxMinMax;

  FIDStore := IDStore;
  scStore.LookUpValue := IntToStr(FIDStore);

  dtPeriod.Date := Now - 30;

  Result := (ShowModal = mrOK);

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

end;

procedure TFrmAdjustMinMax.btSearchClick(Sender: TObject);
begin
  inherited;
  SaveMinMax;
  RefreshMinMax;
end;

procedure TFrmAdjustMinMax.btnCategClearClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text := '<->';
end;

procedure TFrmAdjustMinMax.btnGroupClearClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text := '<->';
end;

procedure TFrmAdjustMinMax.btnSubGroupClearClick(Sender: TObject);
begin
  inherited;
  scSubGroup.LookUpValue := '';
  scSubGroup.Text := '<->';
end;

procedure TFrmAdjustMinMax.Button1Click(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text := '<->';
end;

procedure TFrmAdjustMinMax.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scFabricante.LookUpValue := '';
  scFabricante.Text := '<->';
end;

procedure TFrmAdjustMinMax.btnSizeClearClick(Sender: TObject);
begin
  inherited;
  scSize.LookUpValue := '';
  scSize.Text := '<->';
end;

procedure TFrmAdjustMinMax.btnColorClearClick(Sender: TObject);
begin
  inherited;
  scColor.LookUpValue := '';
  scColor.Text := '<->';
end;

procedure TFrmAdjustMinMax.FormCreate(Sender: TObject);
begin
  inherited;

  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);

  AView := TcxCustomGridTableView(grdBrowseMinMax.FocusedView);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sDays := ' Days';
           end;

     LANG_PORTUGUESE :
           begin
           sDays := ' Dias';
           end;

     LANG_SPANISH :
           begin
           sDays := ' Dias';
           end;
   end;

end;

procedure TFrmAdjustMinMax.quMinMaxCalcFields(DataSet: TDataSet);
var
  Day: Integer;
  AvgCost: Double;
begin
  inherited;
  Day := DaysBetween(dtPeriod.Date, Now);

  if (Day) > 0 then
    AvgCost := quMinMaxTotalQtySold.AsFloat / Day
  else
    AvgCost := 0;

  quMinMaxAvgQtySold.AsFloat := AvgCost;

  if (edtMinSafetyStock.Text <> '') then
    quMinMaxMinSug.AsFloat := Round(quMinMaxAvgQtySold.AsFloat * StrToFloat(edtMinSafetyStock.Text))
  else
    quMinMaxMinSug.AsFloat := Round(quMinMaxMinQty.AsFloat + quMinMaxAvgQtySold.AsFloat);

  if quMinMaxMinSug.AsFloat <= 0 then
    quMinMaxMinSug.AsFloat := 1;

  if (edtMaxSafetyStock.Text <> '') then
    quMinMaxMaxSug.AsFloat := Round(quMinMaxAvgQtySold.AsFloat * StrToFloat(edtMaxSafetyStock.Text))
  else
    quMinMaxMaxSug.AsFloat := Round(quMinMaxMinQty.AsFloat + quMinMaxAvgQtySold.AsFloat);

  if quMinMaxMaxSug.AsFloat <= 0 then
    quMinMaxMaxSug.AsFloat := 1;
end;

procedure TFrmAdjustMinMax.dspMinMaxGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  inherited;
  TableName := 'Inventory';
end;

procedure TFrmAdjustMinMax.SaveMinMax;
begin
  if cdsMinMax.Active and (cdsMinMax.ChangeCount > 0) then
    with cdsMinMax do
    try
      Screen.Cursor :=  crHourGlass;
      Filter := 'Marked = 1';
      Filtered := True;

      First;
      while not Eof do
      begin
        cmdUpdateMinMax.Parameters.ParamByName('MinQty').Value := FieldByName('MinQty').AsFloat;
        cmdUpdateMinMax.Parameters.ParamByName('MaxQty').Value := FieldByName('MaxQty').AsFloat;
        cmdUpdateMinMax.Parameters.ParamByName('IDStore').Value := FieldByName('StoreID').AsInteger;
        cmdUpdateMinMax.Parameters.ParamByName('IDModel').Value := FieldByName('ModelID').AsInteger;
        cmdUpdateMinMax.Execute;
        Next;
      end;
    finally
      Filter := '';
      Filtered := False;
      Screen.Cursor :=  crDefault;
    end;
end;

procedure TFrmAdjustMinMax.btnApplyMinMaxClick(Sender: TObject);
var
  dMin,
  dMax : Double;
  iPos : Integer;
begin
  inherited;

  dMin := -1;
  dMax := -1;
  iPos := 0;

  if (cdsMinMax.Active) and (cdsMinMax.RecordCount > 0) then
    with TFrmAdjustMinMaxAll.Create(Self) do
       if Start(dMin, dMax) then
         with cdsMinMax do
            begin
            try
              DisableControls;
              iPos := cdsMinMax.RecNo;
              First;
              while not EOF do
              begin
                Edit;
                if dMin <> -1 then
                   FieldByName('MinQty').AsFloat := dMin;
                if dMax <> -1 then
                   FieldByName('MaxQty').AsFloat := dMax;
                Post;
                Next;
              end;
            finally
              EnableControls;
              cdsMinMax.RecNo := iPos;
              end;
            end;
end;

procedure TFrmAdjustMinMax.btGroupClick(Sender: TObject);
begin
  inherited;

  if btGroup.Down then
    begin
      TcxGridDBTableView(AView).OptionsView.GroupByBox := True;
    end
  else
    begin
      with grdBrowseMinMax do
        begin
          // Retiro todos os grupos
          while TcxGridDBTableView(AView).GroupedItemCount > 0 do
            TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
          TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
        end;
    end;

end;

procedure TFrmAdjustMinMax.btColumnClick(Sender: TObject);
begin
  inherited;

  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
  
end;

procedure TFrmAdjustMinMax.grdBrowseMinMaxDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AColumn;
end;

procedure TFrmAdjustMinMax.grdBrowseMinMaxDBCustomization(Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TFrmAdjustMinMax.grdBrowseMinMaxDBFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  TcxGridDBTableView(AView).OptionsBehavior.IncSearchItem := AFocusedItem;
end;

procedure TFrmAdjustMinMax.btExcelClick(Sender: TObject);
begin
  inherited;

 If (not cdsMinMax.Active) or
    (cdsMinMax.RecordCount = 0) then
    begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
    end;


 with TFrmExport.Create(Self) do
    Start(grdBrowseMinMax, Self.Caption);

end;

procedure TFrmAdjustMinMax.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveMinMax;
  Close;
end;

procedure TFrmAdjustMinMax.dtPeriodChange(Sender: TObject);
begin
  inherited;
  lbDays.Caption := IntToStr(DaysBetween(dtPeriod.Date, Now)) + sDays;
end;

procedure TFrmAdjustMinMax.btnApplyMaxClick(Sender: TObject);
begin
  inherited;
  if (cdsMinMax.Active) and (cdsMinMax.RecordCount > 0) then
    with cdsMinMax do
    try
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        if FieldByName('MaxSug').AsFloat > 0 then
          FieldByName('MaxQty').AsFloat := FieldByName('MaxSug').AsFloat;
        Post;
        Next;
      end;
    finally
      First;
      EnableControls;
    end;
end;

procedure TFrmAdjustMinMax.edtMinSafetyStockKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateFloats(Key);
end;

procedure TFrmAdjustMinMax.btSelectAllClick(Sender: TObject);
begin
  inherited;
  with cdsMinMax do
  try
    Cursor := crHourGlass;
    if Active then
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        FieldByName('Marked').AsBoolean := True;
        Post;
        Next;
      end;
      First;
    end;
  finally
    EnableControls;
    Cursor := crDefault;
  end;
end;

procedure TFrmAdjustMinMax.btUnSelectAllClick(Sender: TObject);
begin
  inherited;
  with cdsMinMax do
  try
    Cursor := crHourGlass;
    if Active then
    begin
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        FieldByName('Marked').AsBoolean := False;
        Post;
        Next;
      end;
      First;
    end;
  finally
    EnableControls;
    Cursor := crDefault;
  end;
end;

procedure TFrmAdjustMinMax.btnApplyMinClick(Sender: TObject);
begin
  inherited;
  if (cdsMinMax.Active) and (cdsMinMax.RecordCount > 0) then
    with cdsMinMax do
    try
      DisableControls;
      First;
      while not EOF do
      begin
        Edit;
        if FieldByName('MinSug').AsFloat > 0 then
          FieldByName('MinQty').AsFloat := FieldByName('MinSug').AsFloat;
        Post;
        Next;
      end;
    finally
      First;
      EnableControls;
    end;
end;

end.
