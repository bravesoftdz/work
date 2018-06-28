unit uFrmGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Grids,  DBGrids, Buttons, ComCtrls,
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT,
  SMDBGrid, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, Variants,
  uDMCalcPrice;

type
  TbrwFrmGroup = class(TbrwFrmParent)
    quSpecialPrice: TADOQuery;
    quProfile: TADOQuery;
    dsProfile: TDataSource;
    dsSpecialPrice: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    quFormIDGroup: TIntegerField;
    quFormName: TStringField;
    quFormPrcPartDiscount: TFloatField;
    pgGroup: TPageControl;
    tbComission: TTabSheet;
    tbSaleHist: TTabSheet;
    Label3: TLabel;
    cmbStoreSale: TSuperComboADO;
    grdSaleHist: TStringGrid;
    quSaleHistory: TADOQuery;
    quSaleHistoryYear: TIntegerField;
    quSaleHistoryMonth: TIntegerField;
    quSaleHistoryTotSale: TFloatField;
    quSaleHistoryTotCost: TFloatField;
    Panel6: TPanel;
    Panel7: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    pnlPercDiscount: TPanel;
    Label7: TLabel;
    dbPercDiscount: TDBEdit;
    quFormSerialNumber: TBooleanField;
    quMarkUp: TPowerADOQuery;
    dsMarkUp: TDataSource;
    quFormPath: TStringField;
    quFormPathName: TStringField;
    quMarkUpActualMax: TFloatField;
    quMarkUpActualMin: TFloatField;
    quMarkUpActualAvg: TFloatField;
    tbSetTax: TTabSheet;
    pnlDepAccount: TPanel;
    Panel8: TPanel;
    quStore: TADOQuery;
    dsStore: TDataSource;
    quFormSizeAndColor: TBooleanField;
    TabSheet1: TTabSheet;
    DBCheckBox2: TDBCheckBox;
    chkDiscount: TCheckBox;
    DBCheckBox1: TDBCheckBox;
    scTaxCategory: TDBSuperComboADO;
    quProfileIDTipoComissionado: TIntegerField;
    quProfileTipoComissionado: TStringField;
    quProfileComission: TBCDField;
    pnlLancDocTitle: TPanel;
    Panel5: TPanel;
    quSpecialPriceIDSpecialPrice: TAutoIncField;
    quSpecialPriceSpecialPrice: TStringField;
    quSpecialPriceSpecialMarkUp: TBCDField;
    Label29: TLabel;
    quStoreIDTaxCategory: TIntegerField;
    quStoreIDStore: TIntegerField;
    quStoreIDGroup: TIntegerField;
    quStoreStore: TStringField;
    quStoreTaxCategory: TStringField;
    quStoreTax: TBCDField;
    Button1: TButton;
    quProfileCommisType: TStringField;
    grdProfile: TSMDBGrid;
    grdSpecialPrice: TSMDBGrid;
    grdStore: TSMDBGrid;
    quFormPackModel: TBooleanField;
    chkPackModel: TDBCheckBox;
    chkService: TDBCheckBox;
    chkCredit: TDBCheckBox;
    quFormService: TBooleanField;
    quFormCredit: TBooleanField;
    tbService: TTabSheet;
    pnlServiceControls: TPanel;
    quServiceRange: TADOQuery;
    dsServiceRange: TDataSource;
    quServiceRangeIDServiceRange: TIntegerField;
    quServiceRangeIDGroup: TIntegerField;
    quServiceRangeIDModel: TIntegerField;
    quServiceRangeBeginAmount: TBCDField;
    quServiceRangeEndAmount: TBCDField;
    quServiceRangeUseRange: TBooleanField;
    quServiceRangeModel: TStringField;
    quServiceRangeDescription: TStringField;
    Panel11: TPanel;
    btnAddService: TSpeedButton;
    btnDelService: TSpeedButton;
    pnlServices: TPanel;
    grdFeatures: TSMDBGrid;
    lblModelService: TLabel;
    scoModelService: TSuperComboADO;
    chkUseRange: TCheckBox;
    lblBeginAmount: TLabel;
    edtBeginAmount: TEdit;
    lblEndAmount: TLabel;
    edtEndAmount: TEdit;
    dsStoreImpostos: TDataSource;
    quStoreImpostos: TADOQuery;
    pnlTaxSale: TPanel;
    Label8: TLabel;
    Panel10: TPanel;
    DBSuperComboADO1: TDBSuperComboADO;
    SMDBGrid1: TSMDBGrid;
    quStoreImpostosIDSaleTax: TIntegerField;
    quStoreImpostosIDStore: TIntegerField;
    quStoreImpostosIDGroup: TIntegerField;
    quStoreImpostosStore: TStringField;
    quStoreImpostosTaxCategory: TStringField;
    quStoreImpostosTax: TBCDField;
    quFormDesiredMarkup: TBCDField;
    DBEdit3: TDBEdit;
    lbDesiredMrk: TLabel;
    pnlInfo: TPanel;
    lblCode: TLabel;
    DBEdit4: TDBEdit;
    quFormUserCode: TStringField;
    quFormServiceAutoNumber: TBooleanField;
    chkAutoServiceNum: TDBCheckBox;
    quFormPuppyTracker: TBooleanField;
    quFormRequestCustomer: TBooleanField;
    chkRequestCustomer: TDBCheckBox;
    chkPuppyTracker: TDBCheckBox;
    quFormIDRoundingTable: TIntegerField;
    Label1: TLabel;
    tbPricing: TTabSheet;
    quFormIDSalePriceMargemTable: TIntegerField;
    quFormSalePriceMargemPercent: TFloatField;
    quFormUseSalePricePercent: TBooleanField;
    quFormIDMSRPMargemTable: TIntegerField;
    quFormMSRPMargemPercent: TFloatField;
    quFormUseMSRPPercent: TBooleanField;
    pnlSaleMargin: TPanel;
    pnSalePrice: TPanel;
    scSalePriceMargemType: TDBSuperComboADO;
    dbSalePricePercent: TDBEdit;
    pnlMSRPMargin: TPanel;
    pnMSRP: TPanel;
    pnlRound: TPanel;
    pnRound: TPanel;
    scRoundType: TDBSuperComboADO;
    lbRound: TLabel;
    scMSRPMargemType: TDBSuperComboADO;
    dbMSRPPercent: TDBEdit;
    lbQuestion: TLabel;
    lbQuestion2: TLabel;
    cbMSRP: TComboBox;
    cbSalePrice: TComboBox;
    quFormGiftCard: TBooleanField;
    chkGiftCard: TDBCheckBox;
    cmbDepartment: TDBSuperComboADO;
    lblDepartment: TLabel;
    quFormIDDepartment: TIntegerField;
    lblDepartmentRequired: TLabel;
    lblCategoryRequired: TLabel;
    tsPrintReceipt: TTabSheet;
    mmReceiptText: TDBMemo;
    lblReceiptText: TLabel;
    quFormReceiptText: TStringField;
    quFormPackModelAddItems: TBooleanField;
    chkPackModelItems: TDBCheckBox;
    chkRecalcPrices: TCheckBox;
    chUsePriceTable: TDBCheckBox;
    quFormUsePriceTable: TBooleanField;
    cbxUseDocument: TDBCheckBox;
    quFormUseDocumentOnSale: TBooleanField;
    quFormTabGroupCode: TStringField;
    tsGovernement: TTabSheet;
    edtTabGroupCode: TDBEdit;
    lbCode: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure grdSaleHistDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure pgGroupChange(Sender: TObject);
    procedure cmbStoreSaleSelectItem(Sender: TObject);
    procedure chkDiscountClick(Sender: TObject);
    procedure quFormAfterScroll(DataSet: TDataSet);
    procedure dbPercDiscountExit(Sender: TObject);
    procedure quStoreAfterEdit(DataSet: TDataSet);
    procedure quProfileAfterEdit(DataSet: TDataSet);
    procedure quSpecialPriceAfterEdit(DataSet: TDataSet);
    procedure PostOnExit(Sender: TObject);
    procedure scTaxCategorySelectItem(Sender: TObject);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure grdSaleHistSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure chkServiceClick(Sender: TObject);
    procedure btnAddServiceClick(Sender: TObject);
    procedure chkUseRangeClick(Sender: TObject);
    procedure btnDelServiceClick(Sender: TObject);
    procedure DBSuperComboADO1SelectItem(Sender: TObject);
    procedure DBCheckBox2Click(Sender: TObject);
    procedure chkPackModelClick(Sender: TObject);
    procedure chkCreditClick(Sender: TObject);
    procedure dbMSRPPercentKeyPress(Sender: TObject; var Key: Char);
    procedure dbSalePricePercentKeyPress(Sender: TObject; var Key: Char);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure cbMSRPChange(Sender: TObject);
    procedure cbSalePriceChange(Sender: TObject);
    procedure chkGiftCardClick(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure dbMSRPPercentExit(Sender: TObject);
    procedure dbSalePricePercentExit(Sender: TObject);
    procedure dbPercDiscountKeyPress(Sender: TObject; var Key: Char);
    procedure chkRecalcPricesClick(Sender: TObject);
    procedure scSalePriceMargemTypeSelectItem(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    sRetail, sCost, sProfit, sMarkup, sProfValor,
    sTotalYear, sTotalMonth : String;
    bCanControl : Boolean; //Criado pq o form chama o OnClick do check

    FRecalcChanged: Boolean;
    FCalcPriceType : TCalcPriceType;

    procedure RefreshTab;
    procedure StoreRefresh;
    procedure StoreTaxRefresh;
    procedure FillSaleHistory(Tipo, MyMonth, MyYear : integer);
    procedure RefreshSaleHistory(StoreID: integer; IDGroup : integer);
    function ValidateService: Boolean;
    procedure ClearAmountFields;
    function AddServiceRange: Boolean;
    procedure OpenServiceRange;
    procedure CloseServiceRange;
    procedure RefreshServiceRange;
    function EmptyServiceRanges: Boolean;
    procedure VerifyUsePercent(Friend :Integer);
    procedure RefreshAdvancedConfig;

  protected
    procedure OnBeforeStart; override;
    function BeforeChange: boolean; override;
    function SaveChange: boolean; override;
    procedure OnAfterCommit; override;
  end;

implementation

uses uDM, xBase, uMsgBox, uNumericFunctions, uMsgConstant, uDMGlobal, uSystemConst,
  PaiDeTodos, uDMParent, uHandleError, uSystemTypes, uCharFunctions, uFrmMarginTableUpdate;

{$R *.DFM}

procedure TbrwFrmGroup.RefreshTab;
var
  test: String;
begin
  if pgGroup.ActivePage = tbSaleHist then
    RefreshSaleHistory(MyStrToInt(cmbStoreSale.LookupValue), quFormIDGroup.AsInteger);

  if pgGroup.ActivePage = tbSetTax then
  begin
    with quStore do
    begin
      if Active then
        Close;
      Parameters.ParamByName('IDGroup').Value := quFormIDGroup.AsInteger;
      Open;
    end;

    if pnlTaxSale.Visible then
      with quStoreImpostos do
      begin
        if Active then
          Close;
        Parameters.ParamByName('IDGroup').Value := quFormIDGroup.AsInteger;
        Open;
      end;
  end;

  if pgGroup.ActivePage = tbPricing then
  begin
    VerifyUsePercent(1);
    pnlSaleMargin.Visible := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
    pnlMSRPMargin.Visible := pnlSaleMargin.Visible;
    pnlRound.Visible      := DM.fSystem.SrvParam[PARAM_CALC_ROUNDING];
  end;

  if pgGroup.ActivePage = tbService then
  begin
    ClearAmountFields;
    RefreshServiceRange;
  end;
end;

function TbrwFrmGroup.BeforeChange: boolean;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT STG.IDStore ');
    SQL.Add('FROM StoreToTabGroup STG');
    SQL.Add('JOIN Store S ON (S.IDStore = STG.IDStore)');
    SQL.Add('WHERE STG.IDGroup = ' + quFormIDGroup.AsString);
    SQL.Add('AND STG.IDTaxCategory IS NULL');
    SQL.Add('AND S.Hidden=0 AND S.Desativado=0');
    Open;
    Result := (RecordCount = 0);
    Close;
  end;

  //Verifica os Impostos   
  if DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] and Result then
  begin
    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Clear;
      SQL.Add('SELECT STG.IDStore ');
      SQL.Add('FROM StoreToTabGroup STG (NOLOCK)');
      SQL.Add('JOIN Store S (NOLOCK) ON (S.IDStore = STG.IDStore)');
      SQL.Add('WHERE STG.IDGroup = ' + quFormIDGroup.AsString);
      SQL.Add('AND STG.IDSaleTax IS NULL');
      SQL.Add('AND S.Hidden=0 AND S.Desativado=0');
      Open;
      Result := (RecordCount = 0);
      Close;
    end;
  end;

  if not Result then
  begin
    pgGroup.ActivePage := tbSetTax;
    RefreshTab;
    MsgBox(MSG_CRT_ERROR_TAX_STORE, vbCritical + vbOkOnly);
    Exit;
  end;

  if not chkDiscount.checked then
  begin
    if quForm.state = dsBrowse then
      quForm.Edit;
  end;

end;

procedure TbrwFrmGroup.FormShow(Sender: TObject);
begin
  inherited;
  with quSpecialPrice do
  begin
    if Active then
      Close;
    Parameters.ParamByName('GroupID').Value := quFormIDGroup.AsInteger;
    Open
  end;

  with quProfile do
  begin
    if Active then
      Close;
    Parameters.ParamByName('GroupID').Value := quFormIDGroup.AsInteger;
    Open
  end;

  with quMarkUp do
  begin
    Close;
    Parameters.ParamByName('IDGroup').Value := quFormIDGroup.AsInteger;
    Open;
  end;

  cmbStoreSale.LookUpValue := IntToStr(DM.fStore.ID);
  pgGroup.ActivePage := tbComission;

  if fIsRestricForm then
  begin
    btnAddService.Visible := False;
    btnDelService.Visible := False;
  end;

  RefreshAdvancedConfig;
  bCanControl := True;

  chkPuppyTracker.Visible := ((DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') or
                             (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> ''));
end;

procedure TbrwFrmGroup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  with quProfile do
     if Active then Close;
  with quSpecialPrice do
     if Active then Close;

  CloseServiceRange;
  quMarkUp.Close;
end;

procedure TbrwFrmGroup.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormSizeAndColor.ReadOnly := False;
  quFormPackModel.ReadOnly    := False;
  quFormService.ReadOnly      := False;
  quFormCredit.ReadOnly       := False;

  DataSet['PrcPartDiscount'] := 100;
  quFormSerialNumber.AsBoolean := False;
  quFormSizeAndColor.AsBoolean := False;
end;

procedure TbrwFrmGroup.RefreshSaleHistory(StoreID: integer; IDGroup: integer);
var
  i, j, MyMonth, MyYear, AtualMovID: Integer;
begin
  with quSaleHistory do
  begin
    if Active then
      Close;

    MyMonth := StrToInt(FormatDateTime('m', Date));
    MyYear  := StrToInt(FormatDateTime('yyyy', Date));

    if not Active then
    begin
      MyMonth := StrToInt(FormatDateTime('m', Date));
      MyYear  := StrToInt(FormatDateTime('yyyy', Date));

      SQL.Clear;
      SQL.Add('SELECT Year, Month, SUM(TotSale) TotSale, SUM(TotCost) TotCost');
      SQL.Add('FROM InventoryMovTotal InventoryMovTotal (NOLOCK)');
      SQL.Add('JOIN Model M (NOLOCK) ON ( InventoryMovTotal.ModelID = M.IDModel)');
      SQL.Add(' WHERE InventMovTypeID = 1');
      SQL.Add(' AND M.GroupID = '+quFormIDGroup.AsString);

      if StoreID <> 0 then
        SQL.Add(' AND StoreID = ' + IntToStr(StoreID))
      else
        SQL.Add(' AND StoreID IN (' + DM.fStore.StoreList + ')');

      SQL.Add(' AND ((Year >=  '+IntToStr(MyYear - 1)+ ' AND Month >= '+ IntToStr(MyMonth-1)+') or ((Year-1) = '+IntToStr(MyYear-1)+')) ');
      SQL.Add(' GROUP BY Year, Month');
      SQL.Add(' ORDER BY Year, Month ');

      Open;
    end;

    {
    // Seto ate quando devo voltar
    Parameters.ParamByName('MesFim').Value := MyMonth;
    Parameters.ParamByName('AnoFim').Value := MyYear - 1;
    Parameters.ParamByName('StoreID').Value := StoreID;
    Parameters.ParamByName('Path').Value := quFormPath.AsString + '%';
    Open;
    }

    grdSaleHist.RowCount := 2;

    // Cabecalho TotYear e TotMonth
    grdSaleHist.Cells[1, 0] := sTotalMonth;
    grdSaleHist.Cells[14, 0] := sTotalYear;

    // Cabeçalho dos meses
    for i := 1 to 12 do
      if i < MyMonth then
        grdSaleHist.Cells[(MyMonth - i) + 1, 0] := ShortMonthNames[i] + ' ' + RightStr(IntToStr(MyYear), 2)
      else
        grdSaleHist.Cells[(12 - i) + MyMonth + 1, 0]   := ShortMonthNames[i] + ' ' + RightStr(IntToStr(MyYear - 1), 2);

    // Totaliza o Total de Sales
    FillSaleHistory(HIST_COST, MyMonth, MyYear);
    grdSaleHist.RowCount := grdSaleHist.RowCount + 1;
    FillSaleHistory(HIST_RETAIL, MyMonth, MyYear);
    grdSaleHist.RowCount := grdSaleHist.RowCount + 1;
    FillSaleHistory(HIST_GROSS, MyMonth, MyYear);
    grdSaleHist.RowCount := grdSaleHist.RowCount + 1;
    FillSaleHistory(HIST_MARKUP, MyMonth, MyYear);
    grdSaleHist.RowCount := grdSaleHist.RowCount + 1;
    FillSaleHistory(HIST_PROFIT, MyMonth, MyYear);
    Close;
  end;
end;

procedure TbrwFrmGroup.FillSaleHistory(Tipo, MyMonth, MyYear : integer);
var
  i, Pos: integer;
  TotYearSale, TotYearCost: Double;
begin
  for i := 1 to 14 do
    grdSaleHist.Cells[i, grdSaleHist.RowCount-1] := '0';

  case Tipo of
    HIST_RETAIL : grdSaleHist.Cells[0, grdSaleHist.RowCount-1] := sRetail;
    HIST_COST   : grdSaleHist.Cells[0, grdSaleHist.RowCount-1] := sCost;
    HIST_GROSS  : grdSaleHist.Cells[0, grdSaleHist.RowCount-1] := sProfit;
    HIST_MARKUP : grdSaleHist.Cells[0, grdSaleHist.RowCount-1] := sMarkup;
    HIST_PROFIT : grdSaleHist.Cells[0, grdSaleHist.RowCount-1] := sProfValor;
  end;

  quSaleHistory.First;
  TotYearSale := 0;
  TotYearCost := 0;
  while not quSaleHistory.EOF do
  begin
    // Preenche o MonthTo date
    if (quSaleHistoryMonth.AsInteger = MyMonth) and
       (quSaleHistoryYear.AsInteger  = MyYear) then
    begin
      case Tipo of
        HIST_RETAIL : grdSaleHist.Cells[1, grdSaleHist.RowCount-1] := FloatToStrF(quSaleHistoryTotSale.AsFloat, ffNumber, 20, 2);
        HIST_COST   : grdSaleHist.Cells[1, grdSaleHist.RowCount-1] := FloatToStrF(quSaleHistoryTotCost.AsFloat, ffNumber, 20, 2);
        HIST_GROSS  :
          if quSaleHistoryTotSale.AsFloat <> 0 then
            grdSaleHist.Cells[1, grdSaleHist.RowCount-1] := MyFloatToStr(MyRound(100-(quSaleHistoryTotCost.AsFloat/quSaleHistoryTotSale.AsFloat)*100, 2))
          else
            grdSaleHist.Cells[1, grdSaleHist.RowCount-1] := '0';

        HIST_MARKUP :
          if quSaleHistoryTotCost.AsFloat <> 0 then
            grdSaleHist.Cells[1, grdSaleHist.RowCount-1] := MyFloatToStr(MyRound(((quSaleHistoryTotSale.AsFloat-quSaleHistoryTotCost.AsFloat)/quSaleHistoryTotCost.AsFloat)*100, 2))
          else
            grdSaleHist.Cells[1, grdSaleHist.RowCount-1] := '0';

        HIST_PROFIT : grdSaleHist.Cells[1, grdSaleHist.RowCount-1] := FloatToStrF((quSaleHistoryTotSale.AsFloat - quSaleHistoryTotCost.AsFloat), ffNumber, 20, 2);
      end;
    end;

    TotyearSale := TotYearSale + quSaleHistoryTotSale.AsFloat;
    TotyearCost := TotYearCost + quSaleHistoryTotCost.AsFloat;

    case Tipo of
      HIST_RETAIL : grdSaleHist.Cells[14 , grdSaleHist.RowCount-1] := FloatToStrF(TotYearSale, ffNumber, 20, 2);
      HIST_COST   : grdSaleHist.Cells[14 , grdSaleHist.RowCount-1] := FloatToStrF(TotYearCost, ffNumber, 20, 2);
      HIST_GROSS  :
        if TotYearSale <> 0 then
          grdSaleHist.Cells[14 , grdSaleHist.RowCount-1] := MyFloatToStr(MyRound(100-(TotYearCost/TotYearSale)*100, 2))
        else
          grdSaleHist.Cells[14 , grdSaleHist.RowCount-1] := '0';

      HIST_MARKUP :
        if TotYearCost <> 0 then
          grdSaleHist.Cells[14 , grdSaleHist.RowCount-1]  := MyFloatToStr(MyRound(((TotYearSale-TotYearCost)/TotYearCost)*100, 2))
        else
          grdSaleHist.Cells[14 , grdSaleHist.RowCount-1]  := '0';

      HIST_PROFIT : grdSaleHist.Cells[14 , grdSaleHist.RowCount-1] := FloatToStrF(TotyearSale - TotyearCost, ffNumber, 20, 2);
    end;

    Pos := -1;

    if (quSaleHistoryMonth.AsInteger < MyMonth) and
       (quSaleHistoryYear.AsInteger  = MyYear)  then
      Pos := (MyMonth-quSaleHistoryMonth.AsInteger) + 1
    else if (quSaleHistoryMonth.AsInteger >= MyMonth) and
            (quSaleHistoryYear.AsInteger  < MyYear )  then
      Pos := (12-quSaleHistoryMonth.AsInteger)+MyMonth + 1;

    if Pos > 0 then
      case Tipo of
        HIST_RETAIL : grdSaleHist.Cells[Pos, grdSaleHist.RowCount-1] := FloatToStrF(quSaleHistoryTotSale.AsFloat, ffNumber, 20, 2);
        HIST_COST   : grdSaleHist.Cells[Pos, grdSaleHist.RowCount-1] := FloatToStrF(quSaleHistoryTotCost.AsFloat, ffNumber, 20, 2);
        HIST_GROSS  :
          if quSaleHistoryTotSale.AsFloat <> 0 then
            grdSaleHist.Cells[Pos, grdSaleHist.RowCount-1] := MyFloatToStr(MyRound(100-(quSaleHistoryTotCost.AsFloat/quSaleHistoryTotSale.AsFloat)*100, 2))
          else
            grdSaleHist.Cells[Pos, grdSaleHist.RowCount-1] := '0';

        HIST_MARKUP :
          if quSaleHistoryTotCost.AsFloat <> 0 then
            grdSaleHist.Cells[Pos, grdSaleHist.RowCount-1] := MyFloatToStr(MyRound(((quSaleHistoryTotSale.AsFloat-quSaleHistoryTotCost.AsFloat)/quSaleHistoryTotCost.AsFloat)*100, 2))
          else
            grdSaleHist.Cells[Pos, grdSaleHist.RowCount-1] := '0';

        HIST_PROFIT : grdSaleHist.Cells[Pos, grdSaleHist.RowCount-1] := FloatToStrF(quSaleHistoryTotSale.AsFloat - quSaleHistoryTotCost.AsFloat, ffNumber, 20, 2);
      end;

    quSaleHistory.Next;
  end;
end;

procedure TbrwFrmGroup.grdSaleHistDrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
var
  OldValue : String;
begin
  inherited;
  {
  if (Col = (11-StrToInt(FormatDateTime('m', Date))) ) and (Row > 0) then
  begin
    OldValue := grdSaleHist.Cells[Col, Row];
    grdSaleHist.Canvas.Brush.Color := clNavy;
    grdSaleHist.Canvas.CopyMode := cmPatInvert;
    grdSaleHist.Canvas.CopyRect(Rect, Canvas, Rect);
  end;
  }
end;

procedure TbrwFrmGroup.pgGroupChange(Sender: TObject);
begin
  inherited;
  RefreshTab;
end;

procedure TbrwFrmGroup.cmbStoreSaleSelectItem(Sender: TObject);
begin
  inherited;
  RefreshSaleHistory(MyStrToInt(cmbStoreSale.LookUpValue), quFormIDGroup.AsInteger);
end;

procedure TbrwFrmGroup.chkDiscountClick(Sender: TObject);
begin
  if not fIsRestricForm then
    quForm.Edit;
end;

procedure TbrwFrmGroup.quFormAfterScroll(DataSet: TDataSet);
begin
  // ** Refresh nas querys dependentes
  with quSpecialPrice do
  begin
   if Active then
     Close;
   Parameters.ParamByName('GroupID').Value := quFormIDGroup.AsInteger;
   Open
  end;

  with quProfile do
  begin
    if Active then
      Close;
    Parameters.ParamByName('GroupID').Value := quFormIDGroup.AsInteger;
    Open
  end;

  if pgGroup.ActivePage = tbSaleHist then
  begin
    cmbStoreSale.LookUpValue := IntToStr(DM.fStore.ID);
    RefreshSaleHistory(DM.fStore.ID, quFormIDGroup.AsInteger);
  end;

  // ** Refresh no check-box de Discount
  chkDiscount.checked := quFormPrcPartDiscount.value >= 0;  
end;

procedure TbrwFrmGroup.dbPercDiscountExit(Sender: TObject);
begin
  if dbPercDiscount.Field.Value > 100 then
  begin
    MsgBox ('Invalid Value', vbOkOnly );
    dbPercDiscount.SetFocus;
  end;
end;

procedure TbrwFrmGroup.quStoreAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TbrwFrmGroup.quProfileAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TbrwFrmGroup.quSpecialPriceAfterEdit(DataSet: TDataSet);
begin
  inherited;
  quForm.Edit;
end;

procedure TbrwFrmGroup.PostOnExit(Sender: TObject);
begin
  inherited;
  with TDBGrid(Sender).DataSource.DataSet do
    if Active then
      if State in dsEditModes then
        Post;
end;

procedure TbrwFrmGroup.scTaxCategorySelectItem(Sender: TObject);
begin
  inherited;
  StoreRefresh;
end;

procedure TbrwFrmGroup.StoreRefresh;
var
  sID: String;
begin
  inherited;
  sID := quStoreIDStore.AsString;

  with quStore do
  begin
    if State in dsEditModes then
      Post;
    Close;
    Open;
    Locate('IDStore', sID, []);
  end;
end;

procedure TbrwFrmGroup.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;
  with quStore do
    if Active then
    begin
      if State in dsEditModes then
        Post;
      Close;
    end;

  with quStoreImpostos do
    if Active then
    begin
      if State in dsEditModes then
        Post;
      Close;
    end;
end;

procedure TbrwFrmGroup.Button1Click(Sender: TObject);
begin
  inherited;
  cmbStoreSale.LookUpValue := '';
  cmbStoreSale.Text        := '<' + Button1.Caption + '>';

  RefreshSaleHistory(0, quFormIDGroup.AsInteger);
end;

procedure TbrwFrmGroup.grdSaleHistSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  grdSaleHist.Hint := grdSaleHist.Cells[ACol, ARow];
end;

procedure TbrwFrmGroup.FormCreate(Sender: TObject);
begin
  inherited;
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
    begin
      sRetail    := 'Retail   ';
      sCost      := 'Cost     ';
      sProfit    := 'Profit % ';
      sMarkup    := 'MarkUp % ';
      sProfValor := 'Profit Amount';
      sTotalYear := 'YTD';
      sTotalMonth:= 'MTD';
      sUrlHelp   := '';
      sUrlVideo  := '';
    end;

    LANG_PORTUGUESE :
    begin
      sRetail    := 'Venda    ';
      sCost      := 'Custo    ';
      sProfit    := '% Lucro  ';
      sMarkup    := '% Margem ';
      sProfValor := 'Valor Lucro';
      sTotalYear := 'ANO';
      sTotalMonth:= 'MES';
      sUrlHelp   := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Categoria.htm';
      sUrlVideo  := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Categoria/Adicionar_Categoria.html';
    end;

    LANG_SPANISH :
    begin
      sRetail    := 'Venta    ';
      sCost      := 'Costo    ';
      sProfit    := '% Lucro  ';
      sMarkup    := '% Margen ';
      sProfValor := 'Valor Margen';
      sTotalYear := 'YTD';
      sTotalMonth:= 'MTD';
      sUrlHelp   := '';
      sUrlVideo  := '';
    end;
  end;

  pnlTaxSale.Visible       := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];
  tsGovernement.TabVisible := pnlTaxSale.Visible;
  bCanControl              := False;
end;

function TbrwFrmGroup.ValidateService: Boolean;
begin
  Result := False;
  if scoModelService.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_VALID_SELECTION, vbOKOnly+vbCritical);
    scoModelService.SetFocus;
    Exit;
  end;

  if chkUseRange.Checked then
  begin
    if Trim(edtBeginAmount.Text) = '' then
    begin
      MsgBox('You must supply this value.', vbOKOnly+vbCritical);
      edtBeginAmount.SetFocus;
      Exit;
    end;

    if Trim(edtEndAmount.Text) = '' then
    begin
      MsgBox('You must supply this value.', vbOKOnly+vbCritical);
      edtEndAmount.SetFocus;
      Exit;
    end;

    if MyStrToMoney(edtEndAmount.Text) = 0 then
    begin
      MsgBox('This value cannot be ZERO.', vbOKOnly+vbCritical);
      edtEndAmount.SetFocus;
      Exit;
    end;

    if MyStrToMoney(edtBeginAmount.Text) > MyStrToMoney(edtEndAmount.Text) then
    begin
      MsgBox('Begin Amount cannot be smaller than End Amount.', vbOKOnly+vbCritical);
      edtEndAmount.SetFocus;
      Exit;
    end;
  end;
  Result := True;
end;

procedure TbrwFrmGroup.chkServiceClick(Sender: TObject);
begin
  inherited;
  tbService.TabVisible := not chkService.Checked;

  if (frmCommand = btInc) and (bCanControl) then
  begin
    DBCheckBox1.Visible       := True;
    chkAutoServiceNum.Visible := True;
    DBCheckBox2.Visible       := not chkService.Checked;
    chkPackModel.Visible      := DBCheckBox2.Visible;
    chkPackModelItems.Visible := False;
    chkCredit.Visible         := DBCheckBox2.Visible;
    chkGiftCard.Visible       := DBCheckBox2.Visible;
  end;
end;

procedure TbrwFrmGroup.btnAddServiceClick(Sender: TObject);
begin
  inherited;
  if not ValidateService then
    Exit;
  if AddServiceRange then
  begin
    scoModelService.Clear;
    scoModelService.SetFocus;
    ClearAmountFields;
    RefreshServiceRange;
  end;
end;

procedure TbrwFrmGroup.ClearAmountFields;
var
  FieldColor : TColor;
begin
  edtBeginAmount.Clear;
  edtEndAmount.Clear;

  if chkUseRange.Checked then
    FieldColor := clWindow
  else
    FieldColor := clBtnFace;

  edtBeginAmount.Color := FieldColor;
  edtEndAmount.Color   := FieldColor;

  edtBeginAmount.Enabled := chkUseRange.Checked;
  edtEndAmount.Enabled   := chkUseRange.Checked;
end;

procedure TbrwFrmGroup.chkUseRangeClick(Sender: TObject);
begin
  inherited;
  ClearAmountFields;
end;

function TbrwFrmGroup.AddServiceRange : Boolean;
var
  IDServiceRange : Integer;
begin
  IDServiceRange := DM.GetNextID('ServiceRange.IDServiceRange');
  Result :=
  DM.RunSQL(
    'INSERT INTO ServiceRange (IDServiceRange, IDModel, BeginAmount, EndAmount, UseRange, IDGroup)' + #13#10 +
    Format('VALUES (%D, %S, %S, %S, %D, %D)',
           [IDServiceRange,
            scoModelService.LookUpValue,
            MyFormatCur(MyStrToMoney(edtBeginAmount.Text), '.'),
            MyFormatCur(MyStrToMoney(edtEndAmount.Text), '.'),
            Byte(chkUseRange.Checked),
            quFormIDGroup.AsInteger]));
end;

procedure TbrwFrmGroup.OpenServiceRange;
begin
  with quServiceRange do
  begin
    Parameters.ParamByName('IDGroup').Value := quFormIDGroup.Value;
    Open;
  end;
end;

procedure TbrwFrmGroup.CloseServiceRange;
begin
  with quServiceRange do
    if Active then
      Close
end;

procedure TbrwFrmGroup.RefreshServiceRange;
begin
  CloseServiceRange;
  OpenServiceRange;
end;

procedure TbrwFrmGroup.btnDelServiceClick(Sender: TObject);
begin
  inherited;
  if not quServiceRange.IsEmpty then
    try
      DM.RunSQL(Format('DELETE FROM ServiceRange WHERE IDServiceRange = %D', [quServiceRangeIDServiceRange.AsInteger]));
      RefreshServiceRange;
    except
      on E: Exception do
      begin
        DM.SetError(CRITICAL_ERROR, 'TbrwFrmGroup.EmptyServiceRanges', E.Message);
      end;
    end;
end;

function TbrwFrmGroup.EmptyServiceRanges : Boolean;
begin
  Result := True;
  try
    with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Text := Format('DELETE FROM ServiceRange WHERE IDGroup = %D', [quFormIDGroup.AsInteger]);
      ExecSQL;
    end;
  except
    on E: Exception do
    begin
      Result := False;
      DM.SetError(CRITICAL_ERROR, 'TbrwFrmGroup.EmptyServiceRanges', E.Message);
    end;
  end;
end;

function TbrwFrmGroup.SaveChange: boolean;
begin
  Result := Inherited SaveChange;
  
  if Result and quFormService.AsBoolean then
    Result := EmptyServiceRanges;
end;

procedure TbrwFrmGroup.StoreTaxRefresh;
var
  sID: String;
begin
  inherited;
  sID := quStoreImpostosIDStore.AsString;

  with quStoreImpostos do
  begin
    if State in dsEditModes then
      Post;
    Close;
    Open;
    Locate('IDStore', sID, []);
  end;
end;

procedure TbrwFrmGroup.DBSuperComboADO1SelectItem(Sender: TObject);
begin
  inherited;
  StoreTaxRefresh;
end;

procedure TbrwFrmGroup.RefreshAdvancedConfig;
begin
  DBCheckBox1.Visible       := True;
  DBCheckBox2.Visible       := True;
  chkPackModel.Visible      := True;
  chkService.Visible        := True;
  chkCredit.Visible         := True;
  chkAutoServiceNum.Visible := True;
  chkGiftCard.Visible       := True;
  chkPackModelItems.Visible := False;


  if (frmCommand = btAlt) then
  begin
    if quFormSizeAndColor.AsBoolean then
    begin
      DBCheckBox1.Visible         := False;
      chkPackModel.Visible        := False;
      chkService.Visible          := False;
      chkAutoServiceNum.Visible   := False;
      chkCredit.Visible           := False;
      chkGiftCard.Visible         := False;
      //amfsouza 10.03.2011 - quFormSizeAndColor.ReadOnly := True;
    end
    else if quFormPackModel.AsBoolean then
    begin
      //amfsouza 10.03.2011 - quFormPackModel.ReadOnly  := True;
      chkPackModelItems.Visible := True;
      //amfsouza 09.27.2011 - chkPackModelItems.ReadOnly:= True;
      DBCheckBox2.Visible       := False;
      chkService.Visible        := False;
      chkAutoServiceNum.Visible := False;
      chkCredit.Visible         := False;
      chkGiftCard.Visible       := False;
    end
    else if quFormService.AsBoolean then
    begin
      //amfsouza 10.03.2011 - quFormService.ReadOnly    := True;
      chkAutoServiceNum.Visible := True;
      DBCheckBox2.Visible       := False;
      chkPackModel.Visible      := False;
      chkCredit.Visible         := False;
      chkGiftCard.Visible       := False;
    end
    else if quFormCredit.AsBoolean then
    begin
      //amfsouza 10.03.2011 - quFormCredit.ReadOnly     := True;
      DBCheckBox2.Visible       := False;
      chkPackModel.Visible      := False;
      chkService.Visible        := False;
      chkAutoServiceNum.Visible := False;
      chkGiftCard.Visible       := False;
    end
    else if quFormGiftCard.AsBoolean then
    begin
      //amfsouza 10.03.2011 - chkGiftCard.ReadOnly      := True;
      //amfsouza 10.03.2011 - DBCheckBox1.ReadOnly      := True;
      chkCredit.Visible         := False;
      DBCheckBox2.Visible       := False;
      chkPackModel.Visible      := False;
      chkService.Visible        := False;
      chkAutoServiceNum.Visible := False;
    end
    else
    begin
      DBCheckBox2.Visible         := False;
      chkPackModel.Visible        := False;
      chkService.Visible          := False;
      chkAutoServiceNum.Visible   := False;
      chkCredit.Visible           := False;
      chkGiftCard.Visible         := False;
    end;
  end;
end;

procedure TbrwFrmGroup.DBCheckBox2Click(Sender: TObject);
begin
  inherited;
  if (frmCommand = btInc) and (bCanControl) then
  begin
    DBCheckBox1.Visible         := not DBCheckBox2.Checked;
    chkPackModel.Visible        := DBCheckBox1.Visible;
    chkService.Visible          := DBCheckBox1.Visible;
    chkCredit.Visible           := DBCheckBox1.Visible;
    chkAutoServiceNum.Visible   := DBCheckBox1.Visible;
    chkGiftCard.Visible         := DBCheckBox1.Visible;
    chkPackModelItems.Visible   := False;
  end;
end;

procedure TbrwFrmGroup.chkPackModelClick(Sender: TObject);
begin
  inherited;
  if (frmCommand = btInc) and (bCanControl) then
  begin
    DBCheckBox1.Visible       := True;
    chkPackModelItems.Visible := chkPackModel.Checked;
    DBCheckBox2.Visible       := not chkPackModel.Checked;
    chkService.Visible        := DBCheckBox2.Visible;
    chkCredit.Visible         := DBCheckBox2.Visible;
    chkAutoServiceNum.Visible := DBCheckBox2.Visible;
    chkGiftCard.Visible       := DBCheckBox2.Visible;

    if not chkPackModel.Checked then
      if quForm.State in (dsEditModes) then
         quFormPackModelAddItems.AsBoolean := False;

  end;
end;

procedure TbrwFrmGroup.chkCreditClick(Sender: TObject);
begin
  inherited;
  if (frmCommand = btInc) and (bCanControl) then
  begin
    DBCheckBox1.Visible       := True;
    DBCheckBox2.Visible       := not chkCredit.Checked;
    chkPackModel.Visible      := DBCheckBox2.Visible;
    chkPackModelItems.Visible := False;
    chkService.Visible        := DBCheckBox2.Visible;
    chkAutoServiceNum.Visible := DBCheckBox2.Visible;
    chkGiftCard.Visible       := DBCheckBox2.Visible;
  end;
end;

procedure TbrwFrmGroup.VerifyUsePercent(Friend :Integer);
begin

end;

procedure TbrwFrmGroup.dbMSRPPercentKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key :=  ValidatePositiveCurrency(Key);
  chkRecalcPrices.Checked := True;
end;

procedure TbrwFrmGroup.dbSalePricePercentKeyPress(Sender: TObject;
  var Key: Char);
begin
  Key :=  ValidatePositiveCurrency(Key);
  chkRecalcPrices.Checked := True;
end;

procedure TbrwFrmGroup.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if quFormUseMSRPPercent.AsBoolean = True then
  begin
    cbMSRP.ItemIndex         := 0;
    scMSRPMargemType.Visible := False;
    dbMSRPPercent.Visible    := True;
  end
  else
  begin
    cbMSRP.ItemIndex         := 1;
    dbMSRPPercent.Visible    := False;
    scMSRPMargemType.Visible := True;
  end;

  if quFormUseSalePricePercent.AsBoolean = True then
  begin
    cbSalePrice.ItemIndex         := 0;
    scSalePriceMargemType.Visible := False;
    dbSalePricePercent.Visible    := True;
  end
  else
  begin
    cbSalePrice.ItemIndex         := 1;
    dbSalePricePercent.Visible    := False;
    scSalePriceMargemType.Visible := True;
  end;
end;

procedure TbrwFrmGroup.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  with quForm do
  begin
    FRecalcChanged := True;

    if chkRecalcPrices.Checked then
       FCalcPriceType := cptBoth
    else
       FRecalcChanged := False;
  end;

  if cbSalePrice.ItemIndex = 0 then
  begin
    quFormUseSalePricePercent.AsBoolean   := True;
    quFormIDSalePriceMargemTable.AsString := '';
  end
  else
  begin
    quFormUseSalePricePercent.AsBoolean     := False;
    quFormSalePriceMargemPercent.AsCurrency := 0.00;
  end;

  if cbMSRP.ItemIndex = 0 then
  begin
    quFormUseMSRPPercent.AsBoolean   := True;
    quFormIDMSRPMargemTable.AsString := '';
  end
  else
  begin
    quFormUseMSRPPercent.AsBoolean     := False;
    quFormMSRPMargemPercent.AsCurrency := 0.00;
  end;

  if (not quFormPackModel.AsBoolean) and quFormPackModelAddItems.AsBoolean then
    quFormPackModelAddItems.AsBoolean := False;

end;

procedure TbrwFrmGroup.cbMSRPChange(Sender: TObject);
begin
  inherited;
  quForm.Edit;
  if cbMSRP.ItemIndex = 0 then
  begin
    dbMSRPPercent.Visible    := True;
    scMSRPMargemType.Text    := '';
    scMSRPMargemType.Visible := False;
  end
  else
  begin
    scMSRPMargemType.Visible := True;
    dbMSRPPercent.Text       := '';
    dbMSRPPercent.Visible    := False;
  end;
end;

procedure TbrwFrmGroup.cbSalePriceChange(Sender: TObject);
begin
  inherited;
  quForm.Edit;
  if cbSalePrice.ItemIndex = 0 then
  begin
    dbSalePricePercent.Visible    := True;
    scSalePriceMargemType.Text    := '';
    scSalePriceMargemType.Visible := False;
  end
  else
  begin
    scSalePriceMargemType.Visible := True;
    dbSalePricePercent.Text       := '';
    dbSalePricePercent.Visible    := False;
  end;
end;

procedure TbrwFrmGroup.OnBeforeStart;
begin
  inherited;
  tbPricing.TabVisible := (DM.fSystem.SrvParam[PARAM_CALC_ROUNDING] OR
                           DM.fSystem.SrvParam[PARAM_CALC_MARGIN]);
end;

procedure TbrwFrmGroup.OnAfterCommit;
begin
  inherited;
  if FRecalcChanged then
    //if MsgBox(MSG_QST_UPDATE_PRODUCT_PRICES, vbQuestion + vbYesNo) = vbYes then
      with TFrmMarginTableUpdate.Create(self) do
        Start(quFormIDGroup.AsInteger, FCalcPriceType, mgtCategory);
end;

procedure TbrwFrmGroup.chkGiftCardClick(Sender: TObject);
begin
  inherited;
  if (frmCommand = btInc) and (bCanControl) then
  begin
    DBCheckBox1.Visible          := True;
    DBCheckBox2.Visible          := not chkGiftCard.Checked;
    chkService.Visible           := DBCheckBox2.Visible;
    chkCredit.Visible            := DBCheckBox2.Visible;
    chkPackModel.Visible         := DBCheckBox2.Visible;
    chkPackModelItems.Visible    := False;
    chkAutoServiceNum.Visible    := DBCheckBox2.Visible;
    if chkGiftCard.Checked then
      if quForm.State in (dsEditModes) then
         quFormSerialNumber.AsBoolean := True;
  end;
end;

procedure TbrwFrmGroup.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
  if (frmCommand = btInc) and (bCanControl) then
  begin
    if not DBCheckBox1.Checked then
    begin
      if quForm.State in (dsEditModes) then
        quFormGiftCard.AsBoolean := False;
    end;
  end;
end;

procedure TbrwFrmGroup.dbMSRPPercentExit(Sender: TObject);
begin
  if (dbMSRPPercent.Text <> '') and (MyStrToFloat(dbMSRPPercent.Text) > 99) then
  begin
    MsgBox(MSG_INF_PERCENT_LESSER_100, vbOKOnly + vbInformation);
    dbMSRPPercent.SetFocus;
    Exit
  end;
end;

procedure TbrwFrmGroup.dbSalePricePercentExit(Sender: TObject);
begin
  if (dbSalePricePercent.Text <> '') and (MyStrToFloat(dbSalePricePercent.Text) > 99) then
  begin
    MsgBox(MSG_INF_PERCENT_LESSER_100, vbOKOnly + vbInformation);
    dbSalePricePercent.SetFocus;
    Exit
  end;
end;

procedure TbrwFrmGroup.dbPercDiscountKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateFloats(Key);
end;

procedure TbrwFrmGroup.chkRecalcPricesClick(Sender: TObject);
begin
  inherited;
  quForm.Edit;
end;

procedure TbrwFrmGroup.scSalePriceMargemTypeSelectItem(Sender: TObject);
begin
  inherited;
  chkRecalcPrices.Checked := True;
end;


procedure TbrwFrmGroup.btCloseClick(Sender: TObject);
var
   msgAvoidDuplicateGroup: String;
   msgTryRestoreInactiveGroup: String;
   buttonSelected: Integer;
begin
(*
  // Antonio: 09/06/2016 -  MR-15
  if ( not BeforeChange ) then begin
      exit;
  end;


  // test to see if already exists that category
  if ( dm.isInactiveSameCategory(DBEdit2.Text) ) then begin
      msgAvoidDuplicateGroup := 'Category %s already exists.';
      msgTryRestoreInactiveGroup := 'Category %s exists, but is inactive. Do you want to restore ?';
      msgAvoidDuplicateGroup := format(msgAvoidDuplicateGroup, [dsForm.dataset.fieldByname('name').Value]);
      msgTryRestoreInactiveGroup := format(msgTryRestoreInactiveGroup, [dsForm.dataset.fieldByname('name').Value]);
      buttonSelected := MessageDlg(msgTryRestoreInactiveGroup, mtInformation, [mbYes, mbNo], 0);

      if ( buttonSelected = mrYes ) then begin
          dm.activateCategory(DBEdit2.Text);
      end;

  end;
  *)

  inherited;

end;

end.

