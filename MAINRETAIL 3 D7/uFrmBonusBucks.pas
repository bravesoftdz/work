unit uFrmBonusBucks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodos, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, ADODB, Provider, DBClient, ExtCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Mask,
  SuperComboADO, StdCtrls, Buttons, siComp, siLangRT, LblEffct,
  uFrmSelectRebateCalendar, uFrmBonusBuckPercentAll, PanelRights;

type
  TFrmBonusBucks = class(TFrmParent)
    pnlGrid: TPanel;
    dsRebateItem: TDataSource;
    dsRebateItemCalendar: TDataSource;
    cdsRebateItem: TClientDataSet;
    cdsRebateItemCalendar: TClientDataSet;
    dspRebateItem: TDataSetProvider;
    qryRebateItem: TADOQuery;
    qryRebateItemCalendar: TADOQuery;
    dspRebateItemCalendar: TDataSetProvider;
    pnlControl: TPanel;
    pnlRebateItemCalendar: TPanel;
    grdRebateItemCalendar: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridDBTableViewDescription: TcxGridDBColumn;
    cxGridDBTableViewDiscountPerc: TcxGridDBColumn;
    cxGridDBTableViewStartDate: TcxGridDBColumn;
    cxGridDBTableViewEndDate: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    grdRebateItem: TcxGrid;
    grdRebateItemDBTableView: TcxGridDBTableView;
    grdRebateItemDBTableViewIDModel: TcxGridDBColumn;
    grdRebateItemDBTableViewModel: TcxGridDBColumn;
    grdRebateItemDBTableViewDescription: TcxGridDBColumn;
    grdRebateItemDBTableViewCategoria: TcxGridDBColumn;
    grdRebateItemDBTableViewModelSubGroup: TcxGridDBColumn;
    grdRebateItemDBTableViewModelGroup: TcxGridDBColumn;
    grdRebateItemDBTableViewDiscountPerc: TcxGridDBColumn;
    grdRebateItemLevel: TcxGridLevel;
    Splitter: TSplitter;
    btnSave: TButton;
    btExcel: TSpeedButton;
    btGroup: TSpeedButton;
    btColumn: TSpeedButton;
    btnApplyCalendar: TSpeedButton;
    btnApplyCalendarAll: TSpeedButton;
    pnlDivisoria2: TPanel;
    Panel5: TPanel;
    btnApplyPercAll: TSpeedButton;
    qryRebateItemIDStore: TIntegerField;
    qryRebateItemIDModel: TIntegerField;
    qryRebateItemModel: TStringField;
    qryRebateItemDescription: TStringField;
    qryRebateItemCategoria: TStringField;
    qryRebateItemModelSubGroup: TStringField;
    qryRebateItemModelGroup: TStringField;
    qryRebateItemIDRebateItem: TIntegerField;
    qryRebateItemDiscountPerc: TFloatField;
    qryRebateItemCalendarIDRebateItem: TIntegerField;
    qryRebateItemCalendarIDRebateCalendar: TIntegerField;
    qryRebateItemCalendarIDModel: TIntegerField;
    qryRebateItemCalendarIDStore: TIntegerField;
    qryRebateItemCalendarDescription: TStringField;
    qryRebateItemCalendarDiscountPerc: TFloatField;
    qryRebateItemCalendarStartDate: TDateTimeField;
    qryRebateItemCalendarEndDate: TDateTimeField;
    cmdInsertRebateItem: TADOCommand;
    cmdUpdateRebateItem: TADOCommand;
    btnRemoveCalendar: TSpeedButton;
    cdsRebateItemCalendarIDRebateItem: TIntegerField;
    cdsRebateItemCalendarIDRebateCalendar: TIntegerField;
    cdsRebateItemCalendarIDModel: TIntegerField;
    cdsRebateItemCalendarIDStore: TIntegerField;
    cdsRebateItemCalendarDescription: TStringField;
    cdsRebateItemCalendarDiscountPerc: TFloatField;
    cdsRebateItemCalendarStartDate: TDateTimeField;
    cdsRebateItemCalendarEndDate: TDateTimeField;
    btnRemoveAllCalendar: TSpeedButton;
    cdsRebateItemIDStore: TIntegerField;
    cdsRebateItemIDModel: TIntegerField;
    cdsRebateItemModel: TStringField;
    cdsRebateItemDescription: TStringField;
    cdsRebateItemCategoria: TStringField;
    cdsRebateItemModelSubGroup: TStringField;
    cdsRebateItemModelGroup: TStringField;
    cdsRebateItemIDRebateItem: TIntegerField;
    cdsRebateItemDiscountPerc: TFloatField;
    pnlFilter: TPanel;
    pnlRedeemed: TPanelRights;
    lbSubGroup: TLabel;
    lbGroup: TLabel;
    lbCategory: TLabel;
    lbStore: TLabel;
    lblCalendar: TLabel;
    lblPercent: TLabel;
    edBarcode: TEdit;
    cbxMethod: TComboBox;
    cbxType: TComboBox;
    scSubGroup: TSuperComboADO;
    scStore: TSuperComboADO;
    scCategory: TSuperComboADO;
    scGroup: TSuperComboADO;
    btnSubGroupAll: TButton;
    btnGroupAll: TButton;
    btnCategAll: TButton;
    scCalendar: TSuperComboADO;
    btCalendarAll: TButton;
    edPercent: TEdit;
    edtRedeemed: TEdit;
    lblRedeemed: TLabel;
    btnShowFilter: TButton;
    btnHideFilter: TButton;
    cmdUpdateRedeemedPerc: TADOCommand;
    qryRedeemedPerc: TADOQuery;
    qryRedeemedPercPropertyValue: TStringField;
    cmdUpdateDaysToUseBonus: TADOCommand;
    qryDaysToUseBonus: TADOQuery;
    qryDaysToUseBonusPropertyValue: TStringField;
    edtDaysToUseBonus: TEdit;
    lblDaysToUseBonus: TLabel;
    lblMinSaleValue: TLabel;
    edtMinSaleValue: TEdit;
    cmdUpdateMinSaleValue: TADOCommand;
    qryMinSaleValue: TADOQuery;
    qryMinSaleValuePropertyValue: TStringField;
    btnRefresh: TSpeedButton;
    lblDaysToExpireBonus: TLabel;
    edtDaysToExpireBonus: TEdit;
    qryExpireDays: TADOQuery;
    cmdUpdateExpireDaysBonus: TADOCommand;
    qryExpireDaysPropertyValue: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btExcelClick(Sender: TObject);
    procedure btGroupClick(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure btnCategAllClick(Sender: TObject);
    procedure btnGroupAllClick(Sender: TObject);
    procedure btnSubGroupAllClick(Sender: TObject);
    procedure btnApplyCalendarClick(Sender: TObject);
    procedure btnApplyCalendarAllClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnApplyPercAllClick(Sender: TObject);
    procedure grdRebateItemDBTableViewFocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure edPercentKeyPress(Sender: TObject; var Key: Char);
    procedure btCalendarAllClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure grdRebateItemDBTableViewCustomization(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnRemoveCalendarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRemoveAllCalendarClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtRedeemedKeyPress(Sender: TObject; var Key: Char);
    procedure edtDaysToUseBonusKeyPress(Sender: TObject; var Key: Char);
    procedure dspRebateItemCalendarBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure edtMinSaleValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnRefreshClick(Sender: TObject);
  private
    FFrmBonusBucksPercentAll: TFrmBonusBucksPercentAll;
    FFrmSelectRebateCalendar: TFrmSelectRebateCalendar;
    AView: TcxCustomGridTableView;

    procedure LoadImages;
    procedure OpenRebateItem;
    procedure OpenRebateItemCalendar;
    procedure CloseRebateItem;
    procedure CloseRebateItemCalendar;
    procedure AddRebateItemCalendar(AIDModel, AIDStore, AIDRebateItem: Integer);
    procedure ApplyRedeemedPerc;
    procedure ApplyDaysToUseBonus;
    procedure ApplyDaysToExpirateBonus;
    procedure ApplyMinSaleValue;
    procedure ApplyRebateItem;
    procedure ApplyRebateItemCalendar;
    procedure GetRebateCalendar;
    procedure FilterCalendar(AIDStore, AIDModel : Integer);
    procedure SetEnableButtons;
    procedure ApplyChanges;

    function GetRedeemedPerc: Double;
    function GetDaysToUseBonus: Integer;
    function GetDaysToExpirateBonus: Integer;
    function GetMinSaleValue: Currency;
    function GetIDRebateItem(AIDModel, AIDStore: Integer): Integer;
    function CalendarExist(AIDModel, AIDStore: Integer): Boolean;
    function HasRebateItemChange: Boolean;
    function HasRebateItemCalendarChange: Boolean;
    function HasCalendar(AIDModel, AIDStore: Integer): Boolean;
  public
    function Start: Boolean;
  end;

implementation

uses uDM, uFrmExport, uMsgBox, uMsgConstant, uCharFunctions, Math;

{$R *.dfm}

{ TFrmParent1 }

procedure TFrmBonusBucks.CloseRebateItem;
begin
  with cdsRebateItem do
    if Active then
      Close;
end;

procedure TFrmBonusBucks.CloseRebateItemCalendar;
begin
  with cdsRebateItemCalendar do
    if Active then
      Close;
end;

procedure TFrmBonusBucks.OpenRebateItem;
var
  sSQL, sWhere, sGroup, sCampo,
  sVendorJoin, sVendorFilterJoin, sCalendarJoin: String;
begin
  sWhere            := ' M.Desativado = 0 ';
  sVendorJoin       := '';
  sVendorFilterJoin := '';

  if Trim(edBarcode.Text) <> '' then
  begin
    case cbxType.ItemIndex of
      0: sCampo := 'M.Model %S ';
      1: sCampo := 'M.Description %S ';
      2:
      begin
        sVendorJoin := 'LEFT OUTER JOIN VendorModelCode VMC ON (M.IDModel = VMC.IDModel) ';
        sCampo      := 'M.IDModel IN (SELECT IDModel FROM VendorModelCode WHERE VendorCode %S )';
      end;
    end;

    case cbxMethod.ItemIndex of
      0: sWhere := Format(sCampo, [' like ' + QuotedStr(edBarcode.Text+'%')]);
      1: sWhere := Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text)]);
      2: sWhere := Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text+'%')]);
    end;
  end;

//  if scStore.LookUpValue <> '' then
//    sWhere        := sWhere + ' AND IsNull(RI.IDStore, ' + scStore.LookUpValue + ') = ' + scStore.LookUpValue;

  if scCategory.LookUpValue <> '' then
    sWhere        := sWhere + ' AND M.GroupID = ' + scCategory.LookUpValue;

  if scGroup.LookUpValue <> '' then
    sWhere        := sWhere + ' AND M.IDModelGroup = ' + scGroup.LookUpValue;

  if scSubGroup.LookUpValue <> '' then
    sWhere        := sWhere + ' AND M.IDModelSubGroup = ' + scSubGroup.LookUpValue;

  if scCalendar.LookUpValue <> '' then
  begin
    sWhere        := sWhere + ' AND RIC.IDRebateCalendar = ' + scCalendar.LookUpValue;
    sCalendarJoin := 'LEFT OUTER JOIN Sal_RebateItemCalendar RIC ON (RI.IDRebateItem = RIC.IDRebateItem) ';
    sGroup        := 'GROUP BY ' +
                     '  RI.IDStore, ' +
                     '  M.IDModel, ' +
                     '  M.Model, ' +
                     '  M.[Description], ' +
                     '  TG.[Name], ' +
                     '  MSG.ModelSubGroup, ' +
                     '  MG.ModelGroup, ' +
                     '  RI.IDRebateItem, ' +
                     '  RI.DiscountPerc';
  end;
  if edPercent.Text <> '' then
    //amfsouza 12.16.2011
    sWhere   := sWhere + ' AND RI.DiscountPerc = ' + edPercent.Text;

  //    sWhere   := sWhere + ' AND IsNull(RI.DiscountPerc, ' + edPercent.Text +') = ' + edPercent.Text;

  sSQL := 'SELECT ' +
          '  ' + scStore.LookUpValue + ' IDStore, ' +
          '  M.IDModel, ' +
          '  M.Model, ' +
          '  M.[Description], ' +
          '  TG.[Name] Categoria, ' +
          '  MSG.ModelSubGroup, ' +
          '  MG.ModelGroup, ' +
          '  RI.IDRebateItem, ' +
          '  CASE WHEN RI.IDStore IS NULL THEN 0 ELSE RI.DiscountPerc END as DiscountPerc ' +
          'FROM ' +
          '  Model M ' +
          '  JOIN TabGroup TG ON (M.GroupID = TG.IDGroup) ' +
          '  LEFT OUTER JOIN ModelGroup MG ON (M.IDModelGroup = MG.IDModelGroup) ' +
          '  LEFT OUTER JOIN ModelSubGroup MSG ON (M.IDModelSubGroup = MSG.IDModelSubGroup) ' +
          '  LEFT OUTER JOIN Sal_RebateItem RI ON (M.IDModel = RI.IDModel AND RI.IDStore = ' + scStore.LookUpValue + ')' +
          ' ' + sVendorJoin +
          ' ' + sVendorFilterJoin +
          ' ' + sCalendarJoin +
          'WHERE M.ModelType in ('+QuotedStr('R')+', '+QuotedStr('S')+', '+QuotedStr('K')+', '+QuotedStr('V')+', '+QuotedStr('C')+', '+QuotedStr('G')+') ' +
          ' AND ' + sWhere +
          ' ' + sGroup;

  with qryRebateItem do
    SQL.Text := sSQL;

  with cdsRebateItem do
  try
    Screen.Cursor := crHourGlass;
    if Active then
      Close;
    Open;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmBonusBucks.OpenRebateItemCalendar;
begin
  with cdsRebateItemCalendar do
  begin
    if Active then
      Close;
    FetchParams;
    Params.ParamByName('IDStore').Value := scStore.LookUpValue;
    Open;
  end;
end;

function TFrmBonusBucks.Start: Boolean;
begin
  scStore.LookUpValue := IntToStr(DM.fStore.IDDefault);
  edtRedeemed.Text := FloatToStr(GetRedeemedPerc);
  edtDaysToUseBonus.Text := IntToStr(GetDaysToUseBonus);
  edtDaysToExpireBonus.Text := IntToStr(GetDaysToExpirateBonus);
  edtMinSaleValue.Text := CurrToStr(GetMinSaleValue);

  Result := (ShowModal = mrOk);
end;

procedure TFrmBonusBucks.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  CloseRebateItem;
  CloseRebateItemCalendar;
end;

procedure TFrmBonusBucks.btExcelClick(Sender: TObject);
begin
  inherited;
  if (not cdsRebateItem.Active) or (cdsRebateItem.RecordCount = 0) then
  begin
    MsgBox(MSG_INF_NOT_EXCEL_ITEMS, vbOKOnly + vbInformation);
    Exit;
  end;

  with TFrmExport.Create(Self) do
    Start(grdRebateItem, Self.Caption);
end;

procedure TFrmBonusBucks.btGroupClick(Sender: TObject);
var
  AView: TcxCustomGridTableView;
begin
  inherited;
  AView := TcxCustomGridTableView(grdRebateItem.FocusedView);

  if btGroup.Down then
    TcxGridDBTableView(AView).OptionsView.GroupByBox := True
  else
    with grdRebateItem do
    begin
      // Retiro todos os grupos
      while TcxGridDBTableView(AView).GroupedItemCount > 0 do
        TcxGridDBTableView(AView).GroupedColumns[TcxGridDBTableView(AView).GroupedItemCount-1].GroupIndex :=-1;
      TcxGridDBTableView(AView).OptionsView.GroupByBox := False;
    end;
end;

procedure TFrmBonusBucks.btColumnClick(Sender: TObject);
begin
  inherited;
  AView := TcxCustomGridTableView(grdRebateItem.FocusedView);

  if btColumn.Down then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

procedure TFrmBonusBucks.btnCategAllClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text := '<'+ btnCategAll.Caption +'>';
end;

procedure TFrmBonusBucks.btnGroupAllClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text := '<'+ btnGroupAll.Caption +'>';
end;

procedure TFrmBonusBucks.btnSubGroupAllClick(Sender: TObject);
begin
  inherited;
  scSubGroup.LookUpValue := '';
  scSubGroup.Text := '<'+ btnSubGroupAll.Caption +'>';
end;

procedure TFrmBonusBucks.GetRebateCalendar;
begin
  if not Assigned(FFrmSelectRebateCalendar) then
    FFrmSelectRebateCalendar := TFrmSelectRebateCalendar.Create(Self);

  FFrmSelectRebateCalendar.Start;
end;

procedure TFrmBonusBucks.btnApplyCalendarClick(Sender: TObject);
var
  iIDModel, iIDStore, iIDRebateItem: Integer;
begin
  inherited;
  iIDModel      := cdsRebateItem.FieldByName('IDModel').AsInteger;
  iIDStore      := cdsRebateItem.FieldByName('IDStore').AsInteger;
  iIDRebateItem := cdsRebateItem.FieldByName('IDRebateItem').AsInteger;
  GetRebateCalendar;

  if FFrmSelectRebateCalendar.IDRebateCalendar <> -1 then
    if not CalendarExist(iIDModel, iIDStore) then
      AddRebateItemCalendar(iIDModel, iIDStore, iIDRebateItem);
end;

procedure TFrmBonusBucks.btnApplyCalendarAllClick(Sender: TObject);
var
  iIDModel, iIDStore, iIDRebateItem: Integer;
begin
  inherited;
  GetRebateCalendar;

  if FFrmSelectRebateCalendar.IDRebateCalendar <> -1 then
    with cdsRebateItem do
    begin
      DisableControls;
      First;

      while not Eof do
      begin
        iIDModel      := FieldByName('IDModel').AsInteger;
        iIDStore      := FieldByName('IDStore').AsInteger;
        iIDRebateItem := FieldByName('IDRebateItem').AsInteger;
        FilterCalendar(iIDStore, iIDModel);

        if not CalendarExist(iIDModel, iIDStore) then
          AddRebateItemCalendar(iIDModel, iIDStore, iIDRebateItem);

        Next;
      end;

      First;
      EnableControls;
    end;
end;

function TFrmBonusBucks.CalendarExist(AIDModel, AIDStore: Integer): Boolean;
begin
  Result := cdsRebateItemCalendar.Locate('IDModel;IDStore;IDRebateCalendar',
    VarArrayOf([AIDModel, AIDStore, FFrmSelectRebateCalendar.IDRebateCalendar]), []);
end;

procedure TFrmBonusBucks.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FFrmBonusBucksPercentAll);
  FreeAndNil(FFrmSelectRebateCalendar);
end;

procedure TFrmBonusBucks.AddRebateItemCalendar(AIDModel, AIDStore, AIDRebateItem: Integer);
begin
  with cdsRebateItemCalendar do
  begin
    Append;
    FieldByName('IDModel').AsInteger := AIDModel;
    FieldByName('IDStore').AsInteger := AIDStore;
    FieldByName('IDRebateItem').AsInteger := AIDRebateItem;
    FieldByName('IDRebateCalendar').AsInteger := FFrmSelectRebateCalendar.IDRebateCalendar;
    FieldByName('Description').AsString := FFrmSelectRebateCalendar.Description;
    FieldByName('DiscountPerc').AsFloat := FFrmSelectRebateCalendar.DiscountPerc;
    FieldByName('StartDate').AsDateTime := FFrmSelectRebateCalendar.StartDate;
    FieldByName('EndDate').AsDateTime := FFrmSelectRebateCalendar.EndDate;
    Post;
  end;
end;

procedure TFrmBonusBucks.ApplyRebateItem;
var
  iIDRebateItem, iIDStore, iIDModel: Integer;
  dDiscountPerc: Double;
begin
  if HasRebateItemChange then
    with cdsRebateItem do
    begin
      DisableControls;
      First;

      while not Eof do
      begin
        iIDRebateItem := cdsRebateItem.FieldByName('IDRebateItem').AsInteger;
        iIDStore := cdsRebateItem.FieldByName('IDStore').AsInteger;
        iIDModel := cdsRebateItem.FieldByName('IDModel').AsInteger;
        dDiscountPerc := cdsRebateItem.FieldByName('DiscountPerc').AsFloat;

        if cdsRebateItem.FieldByName('IDRebateItem').IsNull then
        begin
          FilterCalendar(iIDStore, iIDModel);

          if (dDiscountPerc > 0) or (HasCalendar(iIDModel, iIDStore)) then
          with cmdInsertRebateItem do
          begin
            iIDRebateItem := DM.GetNextID('Sal_RebateItem.IDRebateItem');

            Edit;
            FieldByName('IDRebateItem').AsInteger := iIDRebateItem;
            Post;

            Parameters.ParamByName('IDRebateItem').Value := iIDRebateItem;
            Parameters.ParamByName('IDStore').Value := iIDStore;
            Parameters.ParamByName('IDModel').Value := iIDModel;
            Parameters.ParamByName('DiscountPerc').Value := dDiscountPerc;
            Execute;
          end;
        end
        else
          if cdsRebateItem.FieldByName('DiscountPerc').OldValue <> dDiscountPerc then
            with cmdUpdateRebateItem do
            begin
              Parameters.ParamByName('IDRebateItem').Value := iIDRebateItem;
              Parameters.ParamByName('DiscountPerc').Value := dDiscountPerc;
              Execute;
            end;

        Next;
      end;

      First;
      EnableControls;
    end;
end;

procedure TFrmBonusBucks.ApplyRebateItemCalendar;
begin
  if HasRebateItemCalendarChange then
    cdsRebateItemCalendar.ApplyUpdates(-1);
end;

function TFrmBonusBucks.HasRebateItemCalendarChange: Boolean;
begin
  Result := cdsRebateItemCalendar.ChangeCount > 0;
end;

function TFrmBonusBucks.HasRebateItemChange: Boolean;
begin
  Result := ((cdsRebateItem.ChangeCount > 0) or (cdsRebateItemCalendar.ChangeCount > 0));
end;

procedure TFrmBonusBucks.btnApplyPercAllClick(Sender: TObject);
var
  dBonusPerc: Double;
begin
  inherited;
  if not Assigned(FFrmBonusBucksPercentAll) then
    FFrmBonusBucksPercentAll := TFrmBonusBucksPercentAll.Create(Self);

  dBonusPerc := FFrmBonusBucksPercentAll.Start;

  if dBonusPerc <> -1 then
    with cdsRebateItem do
    begin
      DisableControls;
      First;

      while not Eof do
      begin
        Edit;
        FieldByName('DiscountPerc').AsFloat := dBonusPerc;
        Post;
        Next;
      end;

      First;
      EnableControls;
    end;
end;

procedure TFrmBonusBucks.grdRebateItemDBTableViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord;
  ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  FilterCalendar(cdsRebateItem.FieldByName('IDStore').AsInteger,
    cdsRebateItem.FieldByName('IDModel').AsInteger);
end;

procedure TFrmBonusBucks.FilterCalendar(AIDStore, AIDModel: Integer);
begin
  with cdsRebateItemCalendar do
    if (AIDStore <> -1) and (AIDModel <> -1) then
    begin
      Filtered := False;
      Filter := 'IDModel = ' + IntToStr(AIDModel) +
                ' AND IDStore = ' + IntToStr(AIDStore);
      Filtered := True;
    end
    else
    begin
      Filter   := '';
      Filtered := False;
    end;
  SetEnableButtons;
end;

function TFrmBonusBucks.HasCalendar(AIDModel, AIDStore: Integer): Boolean;
begin
  Result := cdsRebateItemCalendar.Locate('IDModel;IDStore',
    VarArrayOf([AIDModel, AIDStore]), []);
end;

procedure TFrmBonusBucks.edPercentKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidateFloats(Key);
end;

procedure TFrmBonusBucks.btCalendarAllClick(Sender: TObject);
begin
  inherited;
  scCalendar.LookUpValue := '';
  scCalendar.Text := '<'+ btCalendarAll.Caption +'>';
end;

procedure TFrmBonusBucks.SetEnableButtons;
begin
  btnApplyPercAll.Enabled       := not cdsRebateItem.IsEmpty;
  btnApplyCalendar.Enabled      := not cdsRebateItem.IsEmpty;
  btnApplyCalendarAll.Enabled   := not cdsRebateItem.IsEmpty;
  btnRemoveAllCalendar.Enabled  := not cdsRebateItem.IsEmpty;
  btnRemoveCalendar.Enabled     := not cdsRebateItemCalendar.IsEmpty;
end;

procedure TFrmBonusBucks.btCloseClick(Sender: TObject);
begin
  if HasRebateItemChange or HasRebateItemCalendarChange then
    if MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbQuestion + vbYesNo) = vbYes then
      ApplyChanges;
end;

procedure TFrmBonusBucks.grdRebateItemDBTableViewCustomization(
  Sender: TObject);
begin
  inherited;
  btColumn.Down := TcxGridDBTableView(AView).Controller.Customization;
end;

procedure TFrmBonusBucks.ApplyChanges;
begin
  ApplyRedeemedPerc;
  ApplyDaysToUseBonus;
  ApplyDaysToExpirateBonus;
  ApplyMinSaleValue;
  ApplyRebateItem;
  ApplyRebateItemCalendar;
end;

procedure TFrmBonusBucks.btnSaveClick(Sender: TObject);
begin
  inherited;
  ApplyChanges;
end;

function TFrmBonusBucks.GetIDRebateItem(AIDModel, AIDStore: Integer): Integer;
begin
  cdsRebateItem.Locate('IDModel;IDStore', VarArrayOf([AIDModel, AIDStore]), []);
  Result := cdsRebateItem.FieldByName('IDRebateItem').AsInteger;
end;

procedure TFrmBonusBucks.btnRemoveCalendarClick(Sender: TObject);
begin
  inherited;
  cdsRebateItemCalendar.Delete;

  {
  with DM.quFreeSQL do
  begin
    Close;
    SQL.Text := 'DELETE Sal_RebateItemCalendar WHERE IDRebateItem = ' +
                IntToStr(cdsRebateItemCalendarIDRebateItem.Value);
    ExecSQL;
  end;
  cdsRebateItemCalendar.Close;
  cdsRebateItemCalendar.Open;
  }
  SetEnableButtons;
end;

procedure TFrmBonusBucks.FormShow(Sender: TObject);
begin
  inherited;
  SetEnableButtons;
end;

procedure TFrmBonusBucks.btnRemoveAllCalendarClick(Sender: TObject);
var
  iIDModel, iIDStore: Integer;
begin
  inherited;
  GetRebateCalendar;

  if FFrmSelectRebateCalendar.IDRebateCalendar <> -1 then
    with cdsRebateItem do
    begin
      DisableControls;
      First;

      while not Eof do
      begin
        iIDModel      := FieldByName('IDModel').AsInteger;
        iIDStore      := FieldByName('IDStore').AsInteger;
        FilterCalendar(iIDStore,iIDModel);

        if CalendarExist(iIDModel,iIDStore) then
          cdsRebateItemCalendar.Delete;
        Next;
      end;
      
      First;
      EnableControls;
    end;
end;

procedure TFrmBonusBucks.btnFilterClick(Sender: TObject);
begin
  inherited;
  pnlFilter.Visible := not pnlFilter.Visible;
  btnHideFilter.Visible := pnlFilter.Visible;
  btnShowFilter.Visible := not pnlFilter.Visible;
end;

procedure TFrmBonusBucks.FormCreate(Sender: TObject);
begin
  inherited;
  LoadImages;
end;

procedure TFrmBonusBucks.LoadImages;
begin
  DM.imgBTN.GetBitmap(BTN_EXPORT, btExcel.Glyph);
  DM.imgBTN.GetBitmap(BTN_GROUPING, btGroup.Glyph);
  DM.imgBTN.GetBitmap(BTN_COLUMN, btColumn.Glyph);
end;

procedure TFrmBonusBucks.ApplyRedeemedPerc;
begin
  with cmdUpdateRedeemedPerc do
  begin
    Parameters.ParamByName('PropertyValue').Value := StrToFloatDef(edtRedeemed.Text, 0);
    Parameters.ParamByName('Property').Value := 'BonusBuckRedeemedPerc';
    Execute;
  end;
end;

procedure TFrmBonusBucks.ApplyDaysToUseBonus;
begin
  with cmdUpdateDaysToUseBonus do
  begin
    Parameters.ParamByName('PropertyValue').Value := StrToIntDef(edtDaysToUseBonus.Text, 0);
    Parameters.ParamByName('Property').Value := 'DaysToUseBonusBucks';
    Execute;
  end;
end;

procedure TFrmBonusBucks.ApplyDaysToExpirateBonus;
begin
  with cmdUpdateExpireDaysBonus do
  begin
    Parameters.ParamByName('PropertyValue').Value := StrToIntDef(edtDaysToExpireBonus.Text, 0);
    Parameters.ParamByName('Property').Value := 'ExpireDaysBonusBucks';
    Execute;
  end;
end;

procedure TFrmBonusBucks.edtRedeemedKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateFloats(Key);
end;

function TFrmBonusBucks.GetRedeemedPerc: Double;
begin
  with qryRedeemedPerc do
  try
    if Active then
      Close;

    Parameters.ParamByName('Property').Value := 'BonusBuckRedeemedPerc';
    Open;
    Result := StrToFloatDef(FieldByName('PropertyValue').AsString, 0);
  finally
    Close;
  end;
end;

function TFrmBonusBucks.GetDaysToUseBonus: Integer;
begin
  with qryDaysToUseBonus do
  try
    if Active then
      Close;

    Parameters.ParamByName('Property').Value := 'DaysToUseBonusBucks';
    Open;
    Result := StrToIntDef(FieldByName('PropertyValue').AsString, 0);
  finally
    Close;
  end;
end;

function TFrmBonusBucks.GetDaysToExpirateBonus: Integer;
begin
  with qryExpireDays do
  try
    if Active then
      Close;

    Parameters.ParamByName('Property').Value := 'ExpireDaysBonusBucks';
    Open;
    Result := StrToIntDef(FieldByName('PropertyValue').AsString, 0);
  finally
    Close;
  end;
end;

procedure TFrmBonusBucks.edtDaysToUseBonusKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateQty(Key);
end;

procedure TFrmBonusBucks.dspRebateItemCalendarBeforeUpdateRecord(
  Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
var
  iIDRebateItem: Integer;
begin
  inherited;
  if UpdateKind = ukInsert then
    if SourceDS.FieldByName('IDRebateItem').AsInteger = 0 then
    begin
      iIDRebateItem := GetIDRebateItem(DeltaDS.FieldByName('IDModel').AsInteger, DeltaDS.FieldByName('IDStore').AsInteger);
      DeltaDS.Edit;
      DeltaDS.FieldByName('IDRebateItem').AsInteger := iIDRebateItem;
      DeltaDS.Post;
    end;
end;

procedure TFrmBonusBucks.ApplyMinSaleValue;
begin
  with cmdUpdateMinSaleValue do
  begin
    Parameters.ParamByName('PropertyValue').Value := StrToCurrDef(edtMinSaleValue.Text, 0);
    Parameters.ParamByName('Property').Value := 'BonusBuckMinSaleValue';
    Execute;
  end;
end;

function TFrmBonusBucks.GetMinSaleValue: Currency;
begin
  with qryMinSaleValue do
  try
    if Active then
      Close;

    Parameters.ParamByName('Property').Value := 'BonusBuckMinSaleValue';
    Open;
    Result := StrToCurrDef(FieldByName('PropertyValue').AsString, 0);
  finally
    Close;
  end;
end;

procedure TFrmBonusBucks.edtMinSaleValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
end;

procedure TFrmBonusBucks.btnRefreshClick(Sender: TObject);
begin
  inherited;
  if scStore.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_STORE_SELECTED, vbInformation + vbOkOnly);
    scStore.SetFocus;
  end
  else
    if HasRebateItemChange or HasRebateItemCalendarChange then
      if MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbQuestion + vbYesNo) = vbYes then
        ApplyChanges;

  OpenRebateItem;
  OpenRebateItemCalendar;
  SetEnableButtons;
end;

end.
