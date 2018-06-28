unit uFrmHourResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, Db, DBTables, TeEngine, Series, TeeFunci, TeeProcs, Chart,
  StdCtrls, ComCtrls, LblEffct, ExtCtrls, Buttons, Mask, DateBox, DBChart,
  RadioButtonAll, ADODB, SuperComboADO, siComp, siLangRT, Variants,
  SubListPanel, dxExEdtr, dxTLClms, dxTL, dxCntner, ImgList, DateUtils,
  Provider, DBClient;

const
  ST_DISABLE   = -1;
  ST_EXECUTE   = 100;
  ST_DATE_INI  = 101;
  ST_DATE_END  = 102;
  ST_STORE     = 103;
  ST_YEAR1     = 104;
  ST_YEAR2     = 105;
  ST_YEAR3     = 106;
  ST_DAYS      = 107;
  ST_MODE      = 108;
  ST_MAXRECORD = 109;
  ST_SORTORDER = 110;
  ST_MONTH     = 111;

  GRAPH_SALES_HOUR      = 1;
  GRAPH_INVOICE_HOUR    = 2;
  GRAPH_PROFIT_CATEGORY = 3;
  GRAPH_COMPER_YEAR     = 4;
  GRAPH_BEST_SELLER     = 5;
  GRAPH_CASH_FLOW       = 6;
  GRAPH_BREAK_EVEN      = 7;
  GRAPH_CASH_FLOW_FULL  = 8;
  GRAPH_SALE_DAY_WEEK   = 9;
  GRAPH_TRAFFIC_SALE    = 10;
  GRAPH_RUPTURE         = 11;
  GRAPH_SALES_CATEGORY  = 12;

type
  TFrmHourResult = class(TFrmParent)
    BTN: TBitBtn;
    spHelp: TSpeedButton;
    dsBKSales: TADODataSet;
    dsBKSalesday: TIntegerField;
    dsBKSalesProfit: TBCDField;
    dsBKExpenses: TADODataSet;
    dsBKExpensesday: TIntegerField;
    dsBKExpensesTotal: TBCDField;
    dsCategory: TADODataSet;
    dsCategoryTabGroup: TStringField;
    dsCategoryProfit: TBCDField;
    dsResultMonth3: TADODataSet;
    dsResultMonth3Year: TIntegerField;
    dsResultMonth3Month: TStringField;
    dsResultMonth3MonthNum: TIntegerField;
    dsResultMonth3Amount: TBCDField;
    dsResultMonth2: TADODataSet;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    IntegerField3: TIntegerField;
    BCDField1: TBCDField;
    dsResultMonth1: TADODataSet;
    IntegerField1: TIntegerField;
    StringField2: TStringField;
    IntegerField4: TIntegerField;
    BCDField2: TBCDField;
    dsResult: TADODataSet;
    dsResultHora: TIntegerField;
    dsResultInvoicePerHour: TBCDField;
    dsResultMoney: TADODataSet;
    dsResultMoneyHora: TIntegerField;
    dsResultMoneyProfitPerHour: TBCDField;
    dsBKProfit: TADODataSet;
    dsBKExp: TADODataSet;
    dsBKProfitday: TIntegerField;
    dsBKProfitProfit: TBCDField;
    dsBKExpday: TIntegerField;
    dsBKExpTotal: TBCDField;
    lstgraph: TImageList;
    treeGraph: TdxTreeList;
    treeColumnMain: TdxTreeListColumn;
    treeColumnValue: TdxTreeListColumn;
    treeColumnDate: TdxTreeListDateColumn;
    treeColumnStore: TdxTreeListPickColumn;
    treeColumnYear: TdxTreeListSpinColumn;
    quStore: TADODataSet;
    quStoreName: TStringField;
    quStoreIDStore: TIntegerField;
    treeColumnDays: TdxTreeListPickColumn;
    treeColumnMode: TdxTreeListPickColumn;
    treeColumnMaxRecord: TdxTreeListSpinColumn;
    treeColumnSortOrder: TdxTreeListPickColumn;
    Splitter1: TSplitter;
    treeColumnMonth: TdxTreeListPickColumn;
    pnlGraph: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBChart1: TDBChart;
    Series1: TBarSeries;
    TabSheet2: TTabSheet;
    DBChart2: TDBChart;
    BarSeries1: TBarSeries;
    TabSheet3: TTabSheet;
    chtYearResult: TDBChart;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    TabSheet4: TTabSheet;
    DBChart4: TDBChart;
    Series5: TPieSeries;
    TabSheet5: TTabSheet;
    Chart1: TChart;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Panel4: TPanel;
    lbSaldoCash: TLabel;
    lbSalesCash: TLabel;
    lbExpCash: TLabel;
    edtProft: TEdit;
    edtExp: TEdit;
    edtNet: TEdit;
    TabSheet6: TTabSheet;
    Chart2: TChart;
    LineSeries1: TLineSeries;
    LineSeries2: TLineSeries;
    Panel5: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtBKProfit: TEdit;
    edtBKPExp: TEdit;
    edtBKPNet: TEdit;
    tsBestSeller: TTabSheet;
    PanelBestSeller: TSubListPanel;
    edtTotalCateg: TEdit;
    lbTotalSelected: TLabel;
    dsCategoryTotal: TCurrencyField;
    tsCashFlow: TTabSheet;
    pnlCashFlowDetail: TPanel;
    lbCFNet: TLabel;
    lbInvoice: TLabel;
    lbCFExp: TLabel;
    edtCFStart: TEdit;
    edtCFExpensesStart: TEdit;
    edtCFNet: TEdit;
    chrCashFlow: TChart;
    LineSeries3: TLineSeries;
    LineSeries4: TLineSeries;
    dsCashFlowSales: TADODataSet;
    dsCashFlowExp: TADODataSet;
    dsCashFlowExpday: TIntegerField;
    dsCashFlowExpTotal: TBCDField;
    dsCashFlowSalesday: TIntegerField;
    dsCashFlowSalesProfit: TFloatField;
    edtCFEnd: TEdit;
    edtCFExpensesEnd: TEdit;
    tsSaleDayWeek: TTabSheet;
    dsSaleDayWeek: TADODataSet;
    DBChart3: TDBChart;
    lblSelectedTotal: TLabel;
    edtSaleDayWeekTotal: TEdit;
    PieSeries1: TPieSeries;
    dsSaleDayWeekWeekDay: TIntegerField;
    dsSaleDayWeekAmount: TBCDField;
    dsSaleDayWeekNameDayWeek: TStringField;
    cdsSaleDayWeek: TClientDataSet;
    dspSaleDayWeek: TDataSetProvider;
    cdsSaleDayWeekWeekDay: TIntegerField;
    cdsSaleDayWeekAmount: TBCDField;
    cdsSaleDayWeekNameDayWeek: TStringField;
    tsTrafficSales: TTabSheet;
    quInvoiceHour: TADODataSet;
    chtTrafficSaler: TDBChart;
    BarSeries2: TBarSeries;
    quInvoiceHourHora: TIntegerField;
    quInvoiceHourInvoicePerHour: TIntegerField;
    quTrafficCount: TADODataSet;
    quTrafficCountHora: TIntegerField;
    quTrafficCountPeoplePerHour: TIntegerField;
    Series8: TBarSeries;
    tsRupture: TTabSheet;
    PanelRupture: TSubListPanel;
    tsSalesCategory: TTabSheet;
    dsSalesCategory: TADODataSet;
    StringField3: TStringField;
    CurrencyField1: TCurrencyField;
    dsSalesCategorySales: TBCDField;
    chtSalesCategory: TDBChart;
    lblSalesCategoryTotal: TLabel;
    edtSalesCategoryTotal: TEdit;
    PieSeries2: TPieSeries;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure BTNClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure treeGraphChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure treeGraphDblClick(Sender: TObject);
    procedure treeGraphEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure dsSaleDayWeekCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    sAll,
    sDays,
    sMonths,
    sExec,
    sFrom,
    sTO,
    sStore,
    sYear,
    sDay,
    sMode,
    sMaxRec,
    sSort,
    sMonth : String;

    sSalesHour,
    sInvHour,
    sProfitCateg,
    sComperYear,
    sBestSeller,
    sCashFlow,
    sCashFlowFull,
    sBreakEven,
    sSaleDayWeek,
    sTrafficSale,
    sRupture,
    sSalesCategory: String;

    sSale,
    sTraffic : String;

    SerieLow, SerieHigh: TChartSeries;
    InicioStr, FimStr: String;
    iTotalDias : integer;
    fIncome, fExpenses : Currency;
    sFormat, sSelectedTotal : String;

    bCreateBest,
    bCreateRuptura : Boolean;
    IsStart : Boolean;
    procedure GetDefaultValues;
    function ValidateSQLValues:Boolean;
    function GetGraphs:Boolean;
    procedure StoreOpen;
    procedure StoreClose;
    procedure SaleDayWeekClose;
    function GetIDStore(Store:String):Integer;
    //Invoice Sale per hour
    procedure GraphRefreshInvSaleHour(IniDate, EndDate : TDateTime; iWeekDay, iIDStore : Integer; fDataSet : TADODataSet);
    procedure GraphMontaSQLInvSaleHour(IniDate, EndDate : TDateTime; iWeekDay, iIDStore : Integer);
    //Monthly Sales
    procedure GraphMonthSales(fYear1, fYear2, fYear3, fIDStore : Integer; sMode : String);
    //ProftCategory
    procedure GraphProftCategory(IniDate, EndDate : TDateTime; fNumCateg, fIDStore: Integer;
                                 IsDesc : Boolean; sMode : String);
    //SalesCategory
    procedure GraphSalesCategory(IniDate, EndDate : TDateTime; fNumCateg, fIDStore: Integer;
                                 IsDesc : Boolean; sMode : String);
    //Best Seller
    procedure GraphBestSeller(IniDate, EndDate : TDateTime; fIDStore: Integer);

    //Rupture
    procedure GraphRupture(DateIni, DateEnd : TDateTime; IDStore: Integer);

    //Sales per Day Week
    procedure GraphSaleDayWeek(IniDate, EndDate : TDateTime; fIDStore: Integer);

    //Traffic Sale
    procedure GraphTrafficSale(IniDate, EndDate : TDateTime; fIDStore: Integer);

    //Cash Flow & BreakEven
    procedure GraphCashFlow(fMonth, fYear, fIDStore : Integer);
    procedure GraphBreakEven(fMonth, fYear, fIDStore : Integer);

    procedure GraphFullCashFlow(fMonth, fYear, fIDStore : Integer);

    procedure GraphFillOut(MainChart:TChart; iType : Integer);

    function CalcCashFlowIncome(sDateIni, sDateFim, sStoreID : String):Currency;
    function CalcCashFlowExpenses(sDateIni, sDateFim : String):Currency;

    function CalcBreakEvenIncome(sDateIni, sDateFim, sStoreID : String):Currency;
    function CalcBreakEvenExpenses(sDateIni, sDateFim : String):Currency;
  public
    { Public declarations }
  end;

implementation

uses uDM, uMsgBox, printers, uMsgConstant, uDateTimeFunctions, uDMGlobal,
     uSystemConst;

{$R *.DFM}

function TFrmHourResult.CalcCashFlowIncome(sDateIni, sDateFim, sStoreID : String):Currency;
var
  sSQL, sWhere : String;
begin

  sWhere := '';

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
     begin
     if sStoreID <> '' then
        sWhere := ' AND I.IDStore = ' + sStoreID;
     sSQL := 'SELECT ROUND(SUM(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount),2) as Sale ' +
             'FROM Invoice I (NOLOCK) ' +
             'WHERE I.IDPreSaleParent IS NULL ' +
             ' AND I.PreSaleDate >= ' + QuotedStr(sDateIni) +
             ' AND I.PreSaleDate < ' + QuotedStr(sDateFim) +
             ' AND I.Canceled = 0 ' +
             sWhere;
     end
  else
     begin

     if sStoreID <> '' then
        sWhere := ' AND I.IDStore = ' + sStoreID;

     sSQL := 'SELECT SUM(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNull(I.OtherExpences,0)) as Sale ' +
             'FROM Invoice I ' +
             ' WHERE I.IDPreSaleParent IS NULL AND I.InvoiceDate >= ' + QuotedStr(sDateIni) +
             ' AND I.InvoiceDate < ' + QuotedStr(sDateFim) +
             ' AND I.Canceled = 0 ' +
             sWhere;
     end;

  with DM.quFreeSQL do
     begin
     If Active then
        Close;
     SQL.Clear;
     SQL.Add(sSQL);
     Open;
     Result := FieldByName('Sale').AsCurrency;
     Close;
     end;
end;

function TFrmHourResult.CalcCashFlowExpenses(sDateIni, sDateFim : String):Currency;
begin
  with DM.quFreeSQL do
     begin
     If Active then
        Close;
     SQL.Clear;
     SQL.Add('Select  Sum(L.ValorNominal) as Expenses');
     SQL.Add('From Fin_Lancamento L (NOLOCK) ');
     SQL.Add('Where L.Pagando = 1');
     SQL.Add('AND L.DataVencimento >= ' + QuotedStr(sDateIni));
     SQL.Add('AND L.DataVencimento < ' + QuotedStr(sDateFim));
     SQL.Add('AND L.Desativado = 0 ');
     SQL.Add('AND (IsNull(L.LancamentoType,1) = 1)'); // Lancamento Parent
     SQL.Add('AND L.IDLancamentoTipo = 7'); //Compras
     Open;
     Result := FieldByName('Expenses').AsCurrency;
     Close; 
     end;
end;

function TFrmHourResult.CalcBreakEvenIncome(sDateIni, sDateFim, sStoreID : String):Currency;
var
  sSQL, sWhere : String;
begin

  sWhere := '';

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
     begin
     if sStoreID <> '' then
        sWhere := ' AND I.IDStore = ' + sStoreID;
     sSQL := 'SELECT ROUND(SUM(ItemNetValue),2) as Profit ' +
             'FROM vwSaleItem C (NOLOCK) ' +
             'JOIN vwInvoiceParents I (NOLOCK) ON (I.DocumentID = C.IDPreSale) ' +
             'JOIN Pessoa P (NOLOCK) ON (C.ComissionID = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa) ' +
             'WHERE C.InventMovTypeID = 1 ' +
             ' AND I.PreSaleDate >= ' + QuotedStr(sDateIni) +
             ' AND I.PreSaleDate < ' + QuotedStr(sDateFim) +
             ' AND I.Canceled = 0 ' +
             sWhere;
     end
  else
     begin
     if sStoreID <> '' then
        sWhere := ' AND InvMov.StoreID = ' + sStoreID;
     sSQL := 'SELECT ROUND(SUM(((InvMov.SalePrice- InvMov.CostPrice) * InvMov.Qty ) - (InvMov.Discount + IVD.UnitDiscount) ),2) as Profit ' +
             'FROM InventoryMov InvMov (NOLOCK) ' +
             'JOIN Invoice I (NOLOCK) ON (I.IDInvoice = InvMov.DocumentID) ' +
             'JOIN vwUnitInvoiceDiscount IVD (NOLOCK) ON (IVD.DocumentID = I.IDInvoice AND IVD.Invoice = 1) ' +
             'WHERE InventMovTypeID = 1 ' +
             ' AND InvMov.MovDate >= ' + QuotedStr(sDateIni) +
             ' AND InvMov.MovDate < ' + QuotedStr(sDateFim) +
             sWhere;
     end;

  with DM.quFreeSQL do
     begin
     If Active then
        Close;
     SQL.Clear;
     SQL.Add(sSQL);
     Open;
     Result := FieldByName('Profit').AsCurrency;
     Close; 
     end;
end;

function TFrmHourResult.CalcBreakEvenExpenses(sDateIni, sDateFim : String):Currency;
begin
  with DM.quFreeSQL do
     begin
     If Active then
        Close;
     SQL.Clear;
     SQL.Add('Select Sum(L.ValorNominal) as Expenses');
     SQL.Add('From Fin_Lancamento L (NOLOCK) ');
     SQL.Add('Where L.Pagando = 1');
     SQL.Add('AND L.DataVencimento >= ' + QuotedStr(sDateIni));
     SQL.Add('AND L.DataVencimento < ' + QuotedStr(sDateFim));
     SQL.Add('AND L.Desativado = 0 ');
     SQL.Add('AND IDPurchase IS NULL'); //Eliminar compras (devolucao)
     SQL.Add('AND IDLancamentoParent IS NULL '); //Elimina os filhos
     SQL.Add('AND L.LancamentoType = 0'); // Lancamento Normal
     Open;
     Result := FieldByName('Expenses').AsCurrency;
     Close;
     end;
end;

procedure TFrmHourResult.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  StoreClose;
  SaleDayWeekClose;
  Action := caFree;
end;

procedure TFrmHourResult.btCloseClick(Sender: TObject);
begin
  inherited;
  dsResult.Close;
  dsResultMoney.Close;
  dsResultMonth1.Close;
  dsResultMonth2.Close;
  dsResultMonth3.Close;
  dsCategory.Close;
  Close;
end;


procedure TFrmHourResult.FormShow(Sender: TObject);
var
  Year, Month, Day: Word;

begin
  inherited;
  IsStart := True;
  GetDefaultValues;

  treeGraph.FullCollapse;
  treeGraph.GotoFirst;
  treeGraph.FocusedNode.Expand(False);

  treeColumnMain.DisableEditor := True;
  treeColumnValue.DisableEditor := True;

  chtTrafficSaler.Series[0].Title := sSale;
  chtTrafficSaler.Series[1].Title := sTraffic;

  IsStart := False;

end;


procedure TFrmHourResult.btPrintClick(Sender: TObject);
var
ChartNumber:integer;
begin
  Screen.Cursor := crHourGlass;
  ChartNumber := PageControl1.ActivePage.TabIndex + 1;
  try
    Printer.Orientation := poLandscape;
    Printer.BeginDoc;       { <-- start printer job }
    try
      { now print some text on printer.canvas }
      With Printer.Canvas do
      begin
        Font.Name:='Arial';
        Font.Size:=7;
        Font.Style:=[];
        TextOut(0,0,'Retail Maneger');
      end;

      { And now print the chart component... }
      Case ChartNumber of
      1 : DBChart1.PrintPartial(  Rect(  100,          { <-- left margin }
                                     400 ,          { <-- top margin }
                                     3200,    { <-- right margin }
                                     2460)); { <-- bottom margin }
      2 : DBChart2.PrintPartial(  Rect(  100, 400 , 3200, 2460));

      3 : chtYearResult.PrintPartial(  Rect(  100, 400 , 3200, 2460));
      end;

      Printer.EndDoc; { <-- end job and print !! }
    except
      on Exception do  { just in case an error happens... }
      Begin
        Printer.Abort;
        Printer.EndDoc;
        Raise;       { <-- raise up the exception !!! }
      end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmHourResult.BTNClick(Sender: TObject);
var
 ChartNumber:integer;
 sType : string;
 iRight, iBottom : Integer;
begin
  Screen.Cursor := crHourGlass;
  ChartNumber := PageControl1.ActivePage.TabIndex + 1;
      Case ChartNumber of
      1 : DBChart1.Series[0].Marks.Font.Size := 4;
      2 : DBChart2.Series[0].Marks.Font.Size := 4;
      3 : begin
          chtYearResult.Series[0].Marks.Font.Size := 4;
          chtYearResult.Series[1].Marks.Font.Size := 4;
          chtYearResult.Series[2].Marks.Font.Size := 4;
          end;
      4 : DBChart4.Series[0].Marks.Font.Size := 4;
      5 : begin
          Chart1.Series[0].Marks.Font.Size := 4;
          Chart1.Series[1].Marks.Font.Size := 4;
          sType := 'Net';
          end;
      6 : begin
          Chart2.Series[0].Marks.Font.Size := 4;
          Chart2.Series[1].Marks.Font.Size := 4;
          sType := 'Net';
          end;
      end;

  try
    iRight  := 6200;
    iBottom := 5000;

    Printer.Orientation := poLandscape;
    Printer.BeginDoc;       { <-- start printer job }
    try
      Case ChartNumber of
        1 : DBChart1.PrintPartial(  Rect(  100,          { <-- left margin }
                                     100 ,          { <-- top margin }
                                     iRight,    { <-- right margin }
                                     iBottom)); { <-- bottom margin }
        2 : DBChart2.PrintPartial(  Rect(  100, 100 , iRight, iBottom));
        3 : chtYearResult.PrintPartial(  Rect(  100, 100 , iRight, iBottom));
        4 : DBChart4.PrintPartial(  Rect(  100, 100 , iRight, iBottom));
        5 : Chart1.PrintPartial(  Rect(  100, 100 , iRight, iBottom));
        6 : Chart2.PrintPartial(Rect(  100, 100 , iRight, iBottom));
        8 : chrCashFlow.PrintPartial(Rect(  100, 100 , iRight, iBottom));
        9 : DBChart3.PrintPartial(Rect(  100, 100 , iRight, iBottom));
        10: chtTrafficSaler.PrintPartial(Rect(  100, 100 , iRight, iBottom));
        12: chtSalesCategory.PrintPartial(Rect(  100, 100 , iRight, iBottom));
      end;

    Printer.EndDoc; { <-- end job and print !! }
    except
      on Exception do  { just in case an error happens... }
      Begin
        Printer.Abort;
        Printer.EndDoc;
        Raise;       { <-- raise up the exception !!! }
      end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmHourResult.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1280);
end;

procedure TFrmHourResult.FormCreate(Sender: TObject);
begin
  inherited;

  bCreateBest    := False;
  bCreateRuptura := False;
  sFormat := ShortDateFormat;

  //pnlStore.Visible := True;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sAll           := '<all>';
           sDays          := 'Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,"<all>"';
           sMonths        := 'January,February,March,April,May,June,July,August,September,October,November,December';
           sExec          := 'Execute';
           sFrom          := 'From';
           sTO            := 'To';
           sStore         := 'Store';
           sYear          := 'Year';
           sDay           := 'Week day';
           sMode          := 'Style';
           sMaxRec        := 'Num Record';
           sSort          := 'Sort Order';
           sMonth         := 'Month';
           sSalesHour     := 'Sales per Hour(Qty)';
           sInvHour       := 'Sales per Hour(Amount)';
           sProfitCateg   := 'Profit per Category';
           sComperYear    := 'Monthly Sales';
           sBestSeller    := 'Best Seller';
           sCashFlow      := 'Cash Flow';
           sCashFlowFull  := 'Cash Flow';
           sBreakEven     := 'Break Even';
           sSaleDayWeek   := 'Week day sales';
           sTrafficSale   := 'Traffic x Sales';
           sSelectedTotal := 'Selected Total';
           sSale          := 'Sales';
           sTraffic       := 'Traffic';
           sRupture       := 'Lost Revenue';
           sSalesCategory := 'Sales per Category';
           end;

     LANG_PORTUGUESE :
           begin
           sAll           := '<todos>';
           sDays          := 'Domingo,Segunda,Terça,Quarta,Quinta,Sexta,Sábado,"<todos>"';
           sMonths        := 'Janeiro,Fevereiro,Março,Abril,Maio,Junho,Julho,Agosto,Setembro,Outubro,Novembro,Dezembro';
           sExec          := 'Executar';
           sFrom          := 'De';
           sTO            := 'Até';
           sStore         := 'Loja';
           sYear          := 'Ano';
           sDay           := 'Dia da semana';
           sMode          := 'Formato';
           sMaxRec        := 'Nº Registros';
           sSort          := 'Ordem';
           sMonth         := 'Mês';
           sSalesHour     := 'Notas Hora(Qtd)';
           sInvHour       := 'Notas Hora(Valor)';
           sProfitCateg   := 'Lucro por Categoria';
           sComperYear    := 'Vendas Mensais';
           sBestSeller    := 'Mais Vendido';
           sCashFlow      := 'Previsão F. Caixa';
           sCashFlowFull  := 'Fluxo de Caixa';
           sBreakEven     := 'Ponto de Equilíbrio';
           sSaleDayWeek   := 'Vendas por dia';
           sTrafficSale   := 'Tráfego x Vendas';
           sSelectedTotal := 'Total Selecionado';
           sSale          := 'Vendas';
           sTraffic       := 'Tráfego';
           sRupture       := 'Ruptura';
           sSalesCategory := 'Vendas por Categoria';
           end;

     LANG_SPANISH :
           begin
           sAll           := '<todos>';
           sDays          := 'Domingo,Lunes,Martes,Miércoles,Jueves,Viernes,Sábado,"<todos>"';
           sMonths        := 'Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre';
           sExec          := 'Executar';
           sFrom          := 'Desde';
           sTO            := 'Hasta';
           sStore         := 'Tienda';
           sYear          := 'Año';
           sDay           := 'Día semana';
           sMode          := 'Formato';
           sMaxRec        := 'Nº Registros';
           sSort          := 'Orden';
           sMonth         := 'Mes';
           sSalesHour     := 'Ventas por Hora';
           sInvHour       := 'Boletas por Hora';
           sProfitCateg   := 'Lucro por Categoría';
           sComperYear    := 'Ventas Mensuales';
           sBestSeller    := 'Mejor Venta';
           sCashFlow      := 'Flujo de Caja';
           sCashFlowFull  := 'Flujo de Caja';
           sBreakEven     := 'Mejor Venta';
           sSaleDayWeek   := 'Ventas por Día';
           sTrafficSale   := 'Tráfico x Ventas';
           sSelectedTotal := 'Total Selecionado';
           sSale          := 'Ventas';
           sTraffic       := 'Tráfico';
           sRupture       := 'Ruptura';
           sSalesCategory := 'Ventas por Categoría';
           end;
   end;

end;

procedure TFrmHourResult.treeGraphChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
var
  Column : TdxTreeListColumn;
begin

  if IsStart then
     Exit;

  treeColumnDate.Visible      := False;
  treeColumnStore.Visible     := False;
  treeColumnYear.Visible      := False;
  treeColumnDays.Visible      := False;
  treeColumnMode.Visible      := False;
  treeColumnMaxRecord.Visible := False;
  treeColumnSortOrder.Visible := False;
  treeColumnMonth.Visible     := False;
  treeColumnValue.Visible     := True;
  Column := nil;

  case treeGraph.FocusedNode.StateIndex of
    ST_DATE_INI,
    ST_DATE_END  : Column := treeColumnDate;
    ST_STORE     : Column := treeColumnStore;
    ST_YEAR1,
    ST_YEAR2,
    ST_YEAR3     : Column := treeColumnYear;
    ST_DAYS      : Column := treeColumnDays;
    ST_MODE      : Column := treeColumnMode;
    ST_MAXRECORD : Column := treeColumnMaxRecord;
    ST_SORTORDER : Column := treeColumnSortOrder;
    ST_MONTH     : Column := treeColumnMonth;
  end;

  if Column <> nil then
     begin
     Column.Visible  := True;
     treeColumnValue.Visible := False;
     end;

end;

procedure TFrmHourResult.treeGraphEdited(Sender: TObject;
  Node: TdxTreeListNode);
var
  s : String;
  Column : TdxTreeListColumn;
begin

  Column := nil;

  case treeGraph.FocusedNode.StateIndex of
    ST_DATE_INI,
    ST_DATE_END  : Column := treeColumnDate;
    ST_STORE     : Column := treeColumnStore;
    ST_YEAR1,
    ST_YEAR2,
    ST_YEAR3     : Column := treeColumnYear;
    ST_DAYS      : Column := treeColumnDays;
    ST_MODE      : Column := treeColumnMode;
    ST_MAXRECORD : Column := treeColumnMaxRecord;
    ST_SORTORDER : Column := treeColumnSortOrder;
    ST_MONTH     : Column := treeColumnMonth;
  end;

  s := treeGraph.FocusedNode.Values[Column.Index];
  treeGraph.FocusedNode.Strings[treeColumnValue.Index] := s;

  Column.Visible := False;
  treeColumnValue.Visible := True;

end;

procedure TFrmHourResult.treeGraphDblClick(Sender: TObject);
begin
  inherited;

  case treeGraph.FocusedNode.StateIndex of
    ST_EXECUTE
      : begin
        if ValidateSQLValues then
           GetGraphs;
        end;
  end;

end;

procedure TFrmHourResult.GetDefaultValues;
var
 ActualNode : TdxTreeListNode;
begin
  //Store
  treeColumnStore.Items.Clear;
  treeColumnStore.Items.Add(sAll);
  StoreOpen;
  quStore.First;
  while not quStore.EOF do
    begin
    treeColumnStore.Items.Add(quStoreName.AsString);
    quStore.Next;
    end;

  //Days
  treeColumnDays.Items.Clear;
  treeColumnDays.Items.CommaText := sDays;

  //Month
  treeColumnMonth.Items.Clear;
  treeColumnMonth.Items.CommaText := sMonths;

  //Default values
  treeGraph.FullExpand;
  while not treeGraph.IsEOF do
    begin
    ActualNode := treeGraph.FocusedNode;
    case ActualNode.StateIndex of
         GRAPH_SALES_HOUR
                     : ActualNode.Values[treeColumnMain.Index] := sSalesHour;
         GRAPH_INVOICE_HOUR
                     : ActualNode.Values[treeColumnMain.Index] := sInvHour;
         GRAPH_PROFIT_CATEGORY
                     : ActualNode.Values[treeColumnMain.Index] := sProfitCateg;
         GRAPH_COMPER_YEAR
                     : ActualNode.Values[treeColumnMain.Index] := sComperYear;
         GRAPH_BEST_SELLER
                     : ActualNode.Values[treeColumnMain.Index] := sBestSeller;
         //GRAPH_CASH_FLOW
         //            : ActualNode.Values[treeColumnMain.Index] := sCashFlow;
         GRAPH_BREAK_EVEN
                     : ActualNode.Values[treeColumnMain.Index] := sBreakEven;
         //GRAPH_CASH_FLOW_FULL
         //            : ActualNode.Values[treeColumnMain.Index] := sCashFlowFull;
         GRAPH_SALE_DAY_WEEK
                     : ActualNode.Values[treeColumnMain.Index] := sSaleDayWeek;
         GRAPH_TRAFFIC_SALE
                     : ActualNode.Values[treeColumnMain.Index] := sTrafficSale;
         ST_EXECUTE
                     : ActualNode.Values[treeColumnMain.Index] := sExec;
         GRAPH_RUPTURE
                     : ActualNode.Values[treeColumnMain.Index] := sRupture;
         GRAPH_SALES_CATEGORY
                     : ActualNode.Values[treeColumnMain.Index] := sSalesCategory;

         ST_DATE_INI : begin
                       ActualNode.Values[treeColumnValue.Index] := FirstDateMonth;
                       ActualNode.Values[treeColumnDate.Index]  := FirstDateMonth;
                       ActualNode.Values[treeColumnMain.Index]  := sFrom;
                       end;
         ST_DATE_END : begin
                       ActualNode.Values[treeColumnValue.Index] := LastDateMonth;
                       ActualNode.Values[treeColumnDate.Index]  := LastDateMonth;
                       ActualNode.Values[treeColumnMain.Index]  := sTO;
                       end;
         ST_STORE    : begin
                       ActualNode.Values[treeColumnValue.Index] := sAll;
                       ActualNode.Values[treeColumnStore.Index] := sAll;
                       ActualNode.Values[treeColumnMain.Index]  := sStore;
                       end;
         ST_YEAR1    : begin
                       ActualNode.Values[treeColumnValue.Index] := YearOf(Date)-2;
                       ActualNode.Values[treeColumnYear.Index]  := YearOf(Date)-2;
                       ActualNode.Values[treeColumnMain.Index]  := sYear;
                       end;
         ST_YEAR2    : begin
                       ActualNode.Values[treeColumnValue.Index] := YearOf(Date)-1;
                       ActualNode.Values[treeColumnYear.Index]  := YearOf(Date)-1;
                       ActualNode.Values[treeColumnMain.Index]  := sYear;
                       end;
         ST_YEAR3    : begin
                       ActualNode.Values[treeColumnValue.Index] := YearOf(Date);
                       ActualNode.Values[treeColumnYear.Index]  := YearOf(Date);
                       ActualNode.Values[treeColumnMain.Index]  := sYear;
                       end;

         ST_DAYS     : begin
                       ActualNode.Values[treeColumnValue.Index] := sAll;
                       ActualNode.Values[treeColumnDays.Index]  := sAll;
                       ActualNode.Values[treeColumnMain.Index]  := sDay;
                       end;
         ST_MODE     : begin
                       ActualNode.Values[treeColumnValue.Index] := '$';
                       ActualNode.Values[treeColumnMode.Index]  := '$';
                       ActualNode.Values[treeColumnMain.Index]  := sMode;
                       end;
         ST_MAXRECORD
                     : begin
                       ActualNode.Values[treeColumnValue.Index]     := '10';
                       ActualNode.Values[treeColumnMaxRecord.Index] := '10';
                       ActualNode.Values[treeColumnMain.Index]      := sMaxRec;
                       end;
         ST_SORTORDER
                     : begin
                       ActualNode.Values[treeColumnValue.Index]     := 'DESC';
                       ActualNode.Values[treeColumnSortOrder.Index] := 'DESC';
                       ActualNode.Values[treeColumnMain.Index]      := sSort;
                       end;
         ST_MONTH    : begin
                       ActualNode.Values[treeColumnValue.Index] := FormatDateTime('mmmm',Date);
                       ActualNode.Values[treeColumnMonth.Index] := FormatDateTime('mmmm',Date);
                       ActualNode.Values[treeColumnMain.Index]  := sMonth;
                       end;
        end;
    treeGraph.GotoNext(False);
    end;

end;

function TFrmHourResult.GetGraphs: Boolean;
var
  ParentNode : TdxTreeListNode;
  ActualNode : TdxTreeListNode;
  sFiled     : String;
  iGraph     : Integer;

  fIniDate,
  fEndDate : TDateTime;
  fWeekDay,
  fIDStore : Integer;
  fYear1,
  fYear2,
  fYear3  : Integer;
  fMode   : String;
  fMaxRec : Integer;
  fIsDesc : Boolean;
  fMonth  : Integer;
begin

   fIDStore := 0;
   fMode    := '$';
   fMaxRec  := 10;

   ParentNode := treeGraph.FocusedNode.Parent;
   iGraph     := ParentNode.StateIndex;

   ActualNode  := ParentNode.GetFirstChild;
   BTN.Enabled := True;
   while ActualNode.StateIndex <> 100 do
   begin
     sFiled := '';
     case iGraph of
        GRAPH_SALES_HOUR,
        GRAPH_INVOICE_HOUR
            : begin
              case ActualNode.StateIndex of
                  ST_DATE_INI : fIniDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_DATE_END : fEndDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
                  ST_DAYS     : begin
                                if ActualNode.Strings[treeColumnValue.Index] = sAll then
                                   fWeekDay := 7
                                else
                                   fWeekDay := treeColumnDays.Items.IndexOf(ActualNode.Strings[treeColumnValue.Index]);
                                end;
                  end;
              end;
        GRAPH_PROFIT_CATEGORY
            : begin
              case ActualNode.StateIndex of
                  ST_DATE_INI : fIniDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_DATE_END : fEndDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
                  ST_MODE      : fMode := ActualNode.Strings[treeColumnValue.Index];
                  ST_MAXRECORD : fMaxRec := StrToInt(ActualNode.Strings[treeColumnValue.Index]);
                  ST_SORTORDER : fIsDesc := (ActualNode.Strings[treeColumnValue.Index]='DESC');
                  end;
             end;

       GRAPH_COMPER_YEAR
           : begin
             case ActualNode.StateIndex of
                  ST_YEAR1  : fYear1 := StrToInt(ActualNode.Strings[treeColumnValue.Index]);
                  ST_YEAR2  : fYear2 := StrToInt(ActualNode.Strings[treeColumnValue.Index]);
                  ST_YEAR3  : fYear3 := StrToInt(ActualNode.Strings[treeColumnValue.Index]);
                  ST_STORE  : begin
                              if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                 fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                              end;
                  ST_MODE   : fMode := ActualNode.Strings[treeColumnValue.Index];
                  end;
             end;

      GRAPH_BEST_SELLER
          : begin
            case ActualNode.StateIndex of
                  ST_DATE_INI : fIniDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index],DM.fSystem.WinDateFormat);
                  ST_DATE_END : fEndDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index],DM.fSystem.WinDateFormat);
                  ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
                end;
            BTN.Enabled := False;
            end;
      GRAPH_CASH_FLOW
          : begin
            case ActualNode.StateIndex of
                  ST_MONTH    : fMonth := MonthNumber(ActualNode.Strings[treeColumnValue.Index]);
                  ST_YEAR3    : fYear3 := StrToInt(ActualNode.Strings[treeColumnValue.Index]);
                  ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
                end;

            end;
      GRAPH_BREAK_EVEN
          : begin
            case ActualNode.StateIndex of
                  ST_MONTH    : fMonth := MonthNumber(ActualNode.Strings[treeColumnValue.Index]);
                  ST_YEAR3    : fYear3 := StrToInt(ActualNode.Strings[treeColumnValue.Index]);
                  ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
                end;
            end;

      GRAPH_CASH_FLOW_FULL
          : begin
              case ActualNode.StateIndex of
                   ST_MONTH    : fMonth := MonthNumber(ActualNode.Strings[treeColumnValue.Index]);
                   ST_YEAR3    : fYear3 := StrToInt(ActualNode.Strings[treeColumnValue.Index]);
                   ST_STORE    : begin
                                 if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                    fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                 end;
              end;
            end;
      GRAPH_SALE_DAY_WEEK
          : begin
              case ActualNode.StateIndex of
                  ST_DATE_INI : fIniDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_DATE_END : fEndDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
              end;
            end;

      GRAPH_TRAFFIC_SALE
          : begin
              case ActualNode.StateIndex of
                  ST_DATE_INI : fIniDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_DATE_END : fEndDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
              end;
            end;

      GRAPH_RUPTURE
          : begin
              case ActualNode.StateIndex of
                    ST_DATE_INI : fIniDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index],DM.fSystem.WinDateFormat);
                    ST_DATE_END : fEndDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index],DM.fSystem.WinDateFormat);
                    ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
              end;
              BTN.Enabled := False;
            end;
      GRAPH_SALES_CATEGORY
          : begin
              case ActualNode.StateIndex of
                  ST_DATE_INI : fIniDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_DATE_END : fEndDate := MyFormatDateEng(ActualNode.Strings[treeColumnValue.Index], DM.fSystem.WinDateFormat);
                  ST_STORE    : begin
                                if ActualNode.Strings[treeColumnValue.Index] <> sAll then
                                   fIDStore := GetIDStore(ActualNode.Strings[treeColumnValue.Index]);
                                end;
                  ST_MODE      : fMode := ActualNode.Strings[treeColumnValue.Index];
                  ST_MAXRECORD : fMaxRec := StrToInt(ActualNode.Strings[treeColumnValue.Index]);
                  ST_SORTORDER : fIsDesc := (ActualNode.Strings[treeColumnValue.Index]='DESC');
                  end;
            end;
     end; //Case

  ActualNode := ActualNode.GetNextNode;
  end; //While

  case iGraph of
    GRAPH_SALES_HOUR : begin
                       PageControl1.ActivePage := TabSheet1;
                       GraphRefreshInvSaleHour(fIniDate, fEndDate, fWeekDay, fIDStore, dsResult);
                       end;
    GRAPH_INVOICE_HOUR
                     : begin
                       PageControl1.ActivePage := TabSheet2;
                       GraphRefreshInvSaleHour(fIniDate, fEndDate, fWeekDay, fIDStore, dsResultMoney);
                       end;
    GRAPH_PROFIT_CATEGORY
                        : begin
                          PageControl1.ActivePage := TabSheet4;
                          GraphProftCategory(fIniDate, fEndDate, fMaxRec, fIDStore, fIsDesc, fMode);
                          end;
    GRAPH_COMPER_YEAR
                        : begin
                          PageControl1.ActivePage := TabSheet3;
                          GraphMonthSales(fYear1, fYear2, fYear3, fIDStore, fMode);
                          end;
    GRAPH_BEST_SELLER
                        : begin
                          PageControl1.ActivePage := tsBestSeller;
                          GraphBestSeller(fIniDate, fEndDate, fIDStore);
                          end;
    GRAPH_CASH_FLOW
                        : begin
                          PageControl1.ActivePage := TabSheet5;
                          GraphCashFlow(fMonth, fYear3, fIDStore);
                          end;
    GRAPH_BREAK_EVEN
                        : begin
                          PageControl1.ActivePage := TabSheet6;
                          GraphBreakEven(fMonth, fYear3, fIDStore);
                          end;
    GRAPH_CASH_FLOW_FULL
                        : begin
                          PageControl1.ActivePage := tsCashFlow;
                          GraphFullCashFlow(fMonth, fYear3, fIDStore);
                          end;
    GRAPH_SALE_DAY_WEEK
                        : begin
                          PageControl1.ActivePage := tsSaleDayWeek;
                          GraphSaleDayWeek(fIniDate, fEndDate, fIDStore);
                          end;
    GRAPH_TRAFFIC_SALE
                        : begin
                          PageControl1.ActivePage := tsTrafficSales;
                          GraphTrafficSale(fIniDate, fEndDate, fIDStore);
                          end;
    GRAPH_RUPTURE
                        : begin
                          PageControl1.ActivePage := tsRupture;
                          GraphRupture(fIniDate, fEndDate, fIDStore);
                          end;
    GRAPH_SALES_CATEGORY
                        : begin
                          PageControl1.ActivePage := tsSalesCategory;
                          GraphSalesCategory(fIniDate, fEndDate, fMaxRec, fIDStore, fIsDesc, fMode);
                          end;
  end;

  Result := True;
end;

function TFrmHourResult.ValidateSQLValues: Boolean;
begin
  Result := True;
end;

procedure TFrmHourResult.GraphRefreshInvSaleHour(IniDate, EndDate: TDateTime;
  iWeekDay, iIDStore: Integer; fDataSet : TADODataSet);
begin

Try

  Screen.Cursor := crHourGlass;

  GraphMontaSQLInvSaleHour(IniDate, EndDate, iWeekDay, iIDStore);

  // Abro a query e conforme o corte vou divindo os totais
  with fDataSet do
    begin
      if Active then
         Close;
      if iWeekDay = 7 then
        begin
        Parameters.ParambyName('Day1').Value := 1;
        Parameters.ParambyName('Day2').Value := 1;
        end
      else
        begin
        Parameters.ParambyName('Day1').Value := 7;
        Parameters.ParambyName('Day2').Value := 7;
        end;
      Parameters.ParambyName('Inicio1').Value := Int(IniDate);
      Parameters.ParambyName('Fim1').Value    := Int(EndDate)+1;
      Parameters.ParambyName('Inicio2').Value := Int(IniDate);
      Parameters.ParambyName('Fim2').Value    := Int(EndDate)+1;
      Open;
    end;

 Finally
   Screen.Cursor:=crDefault;
 end;

end;

procedure TFrmHourResult.GraphMontaSQLInvSaleHour(IniDate, EndDate: TDateTime;
  iWeekDay, iIDStore: Integer);
var
 sWhere : String;
 sSQL : String;
begin

  InicioStr := FormatDateTime('yyyymmdd', IniDate);
  FimStr := FormatDateTime('yyyymmdd', EndDate + 1);

  //Procedure p/ montar a query
  DM.RunSQL('DROP TABLE #InvoiceTemp');

  // Devido a um bug do SQL tenho que criar um tbl temp antes
  //  e operar sobre ela
  sWhere := '';

  If iIDStore <> 0 then
     sWhere := 'AND IDStore = '+ IntToStr(iIDStore);

  if iWeekDay <> 7 then
     if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
        sWhere := sWhere + ' AND DatePart(WeekDay, PreSaleDate) = ' + IntToStr(iWeekDay + 1)
     else
        sWhere := sWhere + ' AND DatePart(WeekDay, InvoiceDate) = ' + IntToStr(iWeekDay + 1);

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
     sSQL :=  'SELECT DocumentID as IDInvoice, SubTotal, InvoiceDiscount, ItemDiscount, DateAdd(Hour, -3, PreSaleDate) InvoiceDate ' +
              'INTO #InvoiceTemp FROM vwInvoiceParents (NOLOCK) ' +
              'WHERE PreSaleDate >= ' + Chr(39) + InicioStr +  Chr(39) +
              'AND PreSaleDate < ' + Chr(39) + FimStr +  Chr(39)+ ' ' +
              ' AND Canceled = 0 ' +
              sWhere
  else
     sSQL := 'SELECT IDInvoice, SubTotal, InvoiceDiscount, ItemDiscount, DateAdd(Hour, -3, InvoiceDate) InvoiceDate ' +
             'INTO #InvoiceTemp FROM Invoice (NOLOCK) ' +
             'WHERE InvoiceDate IS NOT Null '+
             'AND IDInvoice IS NOT Null ' +
             'AND InvoiceDate >= ' + Chr(39) + InicioStr +  Chr(39) +
             'AND InvoiceDate < ' + Chr(39) + FimStr +  Chr(39)+ ' ' +
             ' AND Canceled = 0 ' +
             sWhere;

  DM.RunSQL(sSQL);

end;

function TFrmHourResult.GetIDStore(Store: String): Integer;
begin
   Result := 0;
   with quStore do
     if Active then
        if Locate('Name', Store, []) then
           Result := quStoreIDStore.AsInteger;

end;

procedure TFrmHourResult.StoreClose;
begin
 with quStore do
   if Active then
      Close;
end;

procedure TFrmHourResult.StoreOpen;
begin
 with quStore do
   if not Active then
      Open;
end;


procedure TFrmHourResult.GraphMonthSales(fYear1, fYear2, fYear3, fIDStore: Integer;
                                         sMode : String);
  procedure SetMod(Mode:String);
  var
  x : Integer;
  begin
   For x := 0 to 2 do
     begin
     chtYearResult.Series[x].Marks.Visible := True;
     If Mode = '%' then
        chtYearResult.Series[x].Marks.Style := smsPercent
     else If Mode = '$' then
        chtYearResult.Series[x].Marks.Style := smsValue
     else chtYearResult.Series[x].Marks.Visible := False;
     chtYearResult.Series[x].RefreshSeries;
     end;
  end;
Var
  sSQLMonth, sWhere: String;
begin

  Try

   Screen.Cursor := crHourGlass;

   SetMod(sMode);

   chtYearResult.Series[0].Active := False;
   chtYearResult.Series[1].Active := False;
   chtYearResult.Series[2].Active := False;

   //Rodrigo 1º SQL do ANO
   sWhere := '';

   If fIDStore <> 0 then
      sWhere := 'AND IDStore = '+ IntToStr(fIDStore);

   if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
     sSQLMonth := ' SELECT DatePart(Year, PreSaleDate) Year, '+
                  ' CAST(DateName(Month, PreSaleDate) as Varchar(3)) Month, '+
                  ' DatePart(Month, PreSaleDate) as MonthNum,' +
                  ' ROUND(SUM(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount),2) Amount '+
                  ' FROM Invoice I (NOLOCK) '+
                  ' Where YEAR (PreSaleDate) = :Year ' +
                  ' AND I.IDPreSaleParent IS NULL ' +
                  ' AND I.Canceled = 0 ' +
                  sWhere +
                  ' GROUP BY DatePart(Year, PreSaleDate), '+
                  ' DatePart(Month, PreSaleDate), '+
                  ' CAST(DateName(Month, PreSaleDate) as Varchar(3))'+
                  ' Order by Year, MonthNum'
   else
     sSQLMonth := ' SELECT DatePart(Year, InvoiceDate) Year, '+
                  ' CAST(DateName(Month, InvoiceDate) as Varchar(3)) Month, '+
                  ' DatePart(Month, InvoiceDate) as MonthNum,' +
                  ' ROUND(SUM(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount),2) Amount '+
                  ' FROM Invoice I (NOLOCK) '+
                  ' Where YEAR (InvoiceDate) = :Year ' +
                  ' AND I.Canceled = 0 ' +
                  ' AND I.InvoiceDate is not null '+
                  ' AND I.IDInvoice is not null '+ sWhere +
                  ' GROUP BY DatePart(Year, InvoiceDate), '+
                  ' DatePart(Month, InvoiceDate), '+
                  ' CAST(DateName(Month, InvoiceDate) as Varchar(3))'+
                  ' Order by Year, MonthNum';

   If fYear1 <> 0 then
      begin
      with dsResultMonth1 do
         begin
         if Active then
            Close;
         CommandText := sSQLMonth;
         Parameters.ParambyName('Year').Value := fYear1;

         Open;
         If RecordCount > 0 then
            begin
            chtYearResult.Series[0].Active := True;
            chtYearResult.Series[0].Title  := IntToStr(fYear1);
            end
         else
           begin
           Close;
           chtYearResult.Series[0].Active := False;
           end;
        end;
   end;

   //2º SQL do ANO
   If fYear2 <> 0 then
      begin
      with dsResultMonth2 do
        begin
         if Active then
            Close;
        CommandText := sSQLMonth;
        Parameters.ParambyName('Year').Value := fYear2;
        Open;
        If RecordCount > 0 then
           begin
           chtYearResult.Series[1].Active := True;
           chtYearResult.Series[1].Title  := IntToStr(fYear2);
           end
        else
          begin
          Close;
          chtYearResult.Series[1].Active := False;
          end;
        end;
    end;

   //3º SQL do ANO
   If fYear3 <> 0 then
      begin
      with dsResultMonth3 do
        begin
         if Active then
            Close;
        CommandText := sSQLMonth;
        Parameters.ParambyName('Year').Value := fYear3;
        Open;
        If RecordCount > 0 then
           begin
           chtYearResult.Series[2].Active := True;
           chtYearResult.Series[2].Title  := IntToStr(fYear3);
           end
        else
           begin
           Close;
           chtYearResult.Series[2].Active := False;
           end;
        end;
    end;

 Finally
   Screen.Cursor:=crDefault;
 end;

end;

procedure TFrmHourResult.GraphProftCategory(IniDate, EndDate: TDateTime;
  fNumCateg, fIDStore: Integer; IsDesc: Boolean; sMode : String);

  procedure SetMod(Mode:String);
  begin
   DBChart4.Series[0].Marks.Visible := True;
   If Mode = '%' then
      DBChart4.Series[0].Marks.Style := smsPercent
   else If Mode = '$' then
      DBChart4.Series[0].Marks.Style := smsValue
   else
      DBChart4.Series[0].Marks.Visible := False;
   DBChart4.Series[0].RefreshSeries;
  end;

Var
  sWhere, sOrder, sIniDate, sEndDate : String;
  CategoryTotal : Currency;
begin

  Try

  sWhere := '';

  SetMod(sMode);

  sIniDate := FormatDateTime('mm/dd/yyyy', IniDate);
  sEndDate := FormatDateTime('mm/dd/yyyy', EndDate+1);

  //Rodrigo SQL Categoria
   with dsCategory do
      begin
        if Active then
           close;

        If fIDStore <> 0 then
           sWhere := ' AND I.IDStore = '+ IntToStr(fIDStore);

        If IsDesc then
           sOrder := ' Order By Profit DESC '
        else
           sOrder := ' Order By Profit ASC ';

       if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
          CommandText :=
                    ' SET ROWCOUNT :Numero' +
                    ' SELECT TG.Name  TabGroup,' +
                    ' sum(SI.ItemNetValue) as Profit' +
                    ' FROM vwInvoiceParents I (NOLOCK)'+
                    ' JOIN vwSaleItem SI (NOLOCK) ON ( SI.IDPreSale = I.DocumentID )'+
                    ' JOIN Pessoa P (NOLOCK) ON (SI.ComissionID = P.IDPessoa AND SI.IDTipoPessoa = P.IDTipoPessoa) ' +
                    ' JOIN Model M (NOLOCK) ON ( SI.ModelID = M.IDModel )' +
                    ' JOIN dbo.TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup ) ' +
                    ' WHERE SI.InventMovTypeID = 1 ' +
                    ' AND I.PreSaleDate >= ' + QuotedStr(sIniDate) +
                    ' AND I.PreSaleDate < ' + QuotedStr(sEndDate) +
                    ' AND I.Canceled = 0 ' +
                    sWhere +
                    ' GROUP BY TG.Name' + sOrder
       else
          CommandText :=
                    ' SET ROWCOUNT :Numero' +
                    ' SELECT TG.Name  TabGroup,' +
                    ' (sum(  (( InvMov.SalePrice - InvMov.CostPrice )  * InvMov.Qty) - (InvMov.Discount + IVD.UnitDiscount)))   as Profit' +
                    ' FROM InventoryMov InvMov (NOLOCK)'+
                    ' JOIN Invoice I (NOLOCK) ON ( InvMov.DocumentID = I.IDInvoice )'+
                    ' JOIN Model Model (NOLOCK) ON ( InvMov.ModelID = Model.IDModel )' +
                    ' JOIN TabGroup TG (NOLOCK) ON ( Model.GroupID = TG.IDGroup )' +
                    ' JOIN vwUnitInvoiceDiscount IVD (NOLOCK) ON (IVD.DocumentID = I.IDInvoice AND IVD.Invoice = 1) ' +
                    ' WHERE ( InvMov.InventMovTypeID = 1 )' +
                    ' AND I.InvoiceDate >= ' + QuotedStr(sIniDate) +
                    ' AND I.InvoiceDate < ' + QuotedStr(sEndDate) +
                    ' AND I.Canceled = 0 ' +
                    sWhere +
                    ' GROUP BY TG.Name' + sOrder;

       //Set params
       Parameters.ParambyName('Numero').Value := fNumCateg;
       try
         Screen.Cursor := crHourGlass;
         Open;
       finally
         Screen.Cursor := crDefault;
       end;

       try
         dsCategory.DisableControls;
         CategoryTotal := 0;
         dsCategory.First;
         While not EOF do
            begin
            CategoryTotal := CategoryTotal + dsCategoryProfit.AsCurrency;
            dsCategory.Next;
            end;
       finally
         dsCategory.EnableControls;
         edtTotalCateg.Text := FormatFloat('#,##0.00', CategoryTotal);
         end;
      end;

 Finally
   Screen.Cursor:=crDefault;
 end;

end;

procedure TFrmHourResult.GraphBestSeller(IniDate, EndDate: TDateTime;
  fIDStore: Integer);
begin

  if not bCreateBest then
  begin
    PanelBestSeller.CreateSubList;
    bCreateBest := True;
  end;

  PanelBestSeller.Param := 'IDStore='+IntToStr(fIDStore)+';' +
                           'DateIni='+DateTimeToStr(IniDate)+';'+
                           'DateEnd='+DateTimeToStr(EndDate+1)+';'+
                           'Title='+sBestSeller;

end;

procedure TFrmHourResult.GraphCashFlow(fMonth, fYear, fIDStore: Integer);
var
  sDataIni, sDataFim, sSqlProft, sMonth, sIDStore, sDateformat : string;
  sSQL, sWhere : String;
  fDataIni : TDatetime;
begin

  Try

   //Verificar a funcao p/ passar os dados
   Chart1.Series[0].Clear;
   Chart1.Series[1].Clear;

   sMonth := IntTostr(fMonth);

   If Length(sMonth) = 1 then
      sMonth := '0'+sMonth;

   sDataIni   := sMonth+'/01/'+IntToStr(fYear);

   try
     sDateformat := ShortDateFormat;
     ShortDateFormat := 'mm/dd/yyyy';

     fDataIni := StrToDate(sDataIni);
     sDataFim := DateToStr(AddMonth(fDataIni)+1);

     //pego o total de dias do mes
     iTotalDias := StrTOInt(Copy( MyFormatDate((FimMes(fDataIni))) ,4,2));

   finally
      ShortDateFormat := sDateformat;
      end;

   Screen.Cursor := crHourGlass;


   sWhere := '';
   if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
      begin
      if fIDStore <> 0 then
         sWhere := ' AND I.IDStore = ' + IntTostr(fIDStore);

      sSQL := 'SELECT DatePart(day, I.PreSaleDate) day, '+
              'ROUND(SUM(C.ItemSaleTotal),2) as Profit ' +
              'FROM vwSaleItem C (NOLOCK) ' +
              'JOIN vwInvoiceParents I (NOLOCK) ON (I.DocumentID = C.IDPreSale) ' +
              'JOIN Pessoa P (NOLOCK) ON (C.ComissionID = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa) ' +
              'WHERE C.InventMovTypeID = 1 ' +
              ' AND I.PreSaleDate >=  ' + QuotedStr(sDataIni) +
              ' AND I.PreSaleDate < ' + QuotedStr(sDataFim) +
              ' AND I.Canceled = 0 ' +
              sWhere +
              ' GROUP BY DatePart(day, I.PreSaleDate)';
      end
   else
     begin
     if fIDStore <> 0 then
        sWhere := ' AND I.IDStore = ' + IntTostr(fIDStore);

      sSQL := 'SELECT DatePart(day, I.InvoiceDate) day, '+
              'SUM(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + IsNull(I.OtherExpences,0)) as Profit ' +
              'FROM Invoice I ' +
              'WHERE I.IDPreSaleParent IS NULL ' +
              'AND I.InvoiceDate >= ' + QuotedStr(sDataIni) +
              'AND I.InvoiceDate < ' + QuotedStr(sDataFim) +
              sWhere +
              ' GROUP BY DatePart(day, I.InvoiceDate)';
      end;

   with dsBKSales do
     begin
     CommandText := sSQL;
     Open;
     end;

   //expenses
   sSQL := 'SELECT DatePart(day, L.DataVencimento) day, '+
           'SUM(L.ValorNominal) Total ' +
           'FROM Fin_Lancamento L (NOLOCK) ' +
           'WHERE L.Pagando = 1 ' +
           'AND L.DataVencimento >= ' + QuotedStr(sDataIni) +
           'AND L.DataVencimento < ' + QuotedStr(sDataFim) +
           'AND L.Desativado = 0 ' +
           'AND (IsNull(L.LancamentoType,1) = 1) ' +
           'GROUP BY DatePart(day, L.DataVencimento) ' ;

    with dsBKExpenses do
      begin
      CommandText := sSQL;
      Open;
      end;

   //Calc Totals
   sIDStore := '';
   if fIDStore <> 0 then
      sIDStore := IntToStr(fIDStore);

   fIncome   := CalcCashFlowIncome(sDataIni, sDataFim, sIDStore);
   fExpenses := CalcCashFlowExpenses(sDataIni, sDataFim);

   //Jogar os Valores no Grafico
   GraphFillOut(Chart1, GRAPH_CASH_FLOW);

 Finally
  dsBKSales.Close;
  dsBKExpenses.Close;
  Screen.Cursor := crDefault;
 end;

end;

procedure TFrmHourResult.GraphBreakEven(fMonth, fYear, fIDStore: Integer);
var
  sDataIni, sDataFim, sSqlProft, sMonth, sIDStore, sDateformat : string;
  fDataIni : TDateTime;
  sWhere, sSQL : String;
begin

  Try

    Chart2.Series[0].Clear;
    Chart2.Series[1].Clear;

    sMonth := IntTostr(fMonth);

    If Length(sMonth) = 1 then
       sMonth := '0'+sMonth;

    sDataIni   := sMonth+'/01/'+IntToStr(fYear);

   try
     sDateformat := ShortDateFormat;
     ShortDateFormat := 'mm/dd/yyyy';
     fDataIni := StrToDate(sDataIni);
     sDataFim := DateToStr(AddMonth(fDataIni)+1);
     //pego o total de dias do mes
     iTotalDias := StrTOInt(Copy( MyFormatDate((FimMes(fDataIni))) ,4,2));
   finally
      ShortDateFormat := sDateformat;
      end;

    Screen.Cursor := crHourGlass;


   sWhere := '';
   if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
      begin
      if fIDStore <> 0 then
         sWhere := ' AND I.IDStore = ' + IntTostr(fIDStore);

      sSQL := 'SELECT DatePart(day, I.PreSaleDate) day, '+
              'ROUND(SUM(C.ItemNetValue),2) as Profit ' +
              'FROM vwSaleItem C (NOLOCK) ' +
              'JOIN vwInvoiceParents I (NOLOCK) ON (I.DocumentID = C.IDPreSale) ' +
              'JOIN Pessoa P (NOLOCK) ON (C.ComissionID = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa) ' +
              'WHERE C.InventMovTypeID = 1 ' +
              'AND I.PreSaleDate >= ' + QuotedStr(sDataIni) +
              'AND I.PreSaleDate < ' + QuotedStr(sDataFim) +
              ' AND I.Canceled = 0 ' +
              sWhere +
              ' GROUP BY DatePart(day, I.PreSaleDate)';
      end
   else
      begin
      if fIDStore <> 0 then
         sWhere := ' AND InvMov.StoreID = ' + IntTostr(fIDStore);

      sSQL := 'SELECT DatePart(day, InvMov.MovDate) day, ' +
              'ROUND(Sum(((InvMov.SalePrice- InvMov.CostPrice) * InvMov.Qty ) - (InvMov.Discount + IVD.UnitDiscount)),2) as Profit ' +
              'FROM InventoryMov InvMov (NOLOCK) ' +
              'JOIN Invoice I (NOLOCK) ON (I.IDInvoice = InvMov.DocumentID) ' +
              'JOIN vwUnitInvoiceDiscount IVD (NOLOCK) ON (IVD.DocumentID = I.IDInvoice AND IVD.Invoice = 1) ' +

              'WHERE InventMovTypeID = 1 ' +
              'AND InvMov.MovDate >= ' + QuotedStr(sDataIni) +
              'AND InvMov.MovDate < ' + QuotedStr(sDataFim) +
              sWhere +
              ' GROUP BY DatePart(day, InvMov.MovDate)';
     end;

    with dsBKProfit do
      begin
      CommandText := sSQL;
      Open;
      end;

   //expenses
   sSQL := 'Select DatePart(day, L.DataVencimento) day, '+
           'Sum(L.ValorNominal) Total ' +
           'FROM Fin_Lancamento L (NOLOCK) ' +
           'WHERE L.Pagando = 1 ' +
           'AND L.DataVencimento >= ' + QuotedStr(sDataIni) +
           'AND L.DataVencimento < ' + QuotedStr(sDataFim) +
           'AND L.Desativado = 0 ' +
           'AND IDPurchase IS NULL ' +
           'AND (IsNull(L.LancamentoType,0) <> 2) ' +
           'GROUP BY DatePart(day, L.DataVencimento) ' ;

    with dsBKExp do
      begin
      CommandText := sSQL;
      Open;
      end;

   //Calc Totals
   sIDStore := '';
   if fIDStore <> 0 then
      sIDStore := IntToStr(fIDStore);

   //Calc Totals
   fIncome   := CalcBreakEvenIncome(sDataIni, sDataFim, sIDStore);
   fExpenses := CalcBreakEvenExpenses(sDataIni, sDataFim);

   //Jogar os Valores no Grafico
   GraphFillOut(Chart2, GRAPH_BREAK_EVEN);

 Finally
  dsBKProfit.Close;
  dsBKExp.Close;
  Screen.Cursor := crDefault;
 end;

end;


procedure TFrmHourResult.GraphFillOut(MainChart: TChart; iType: Integer);
var
  i    : integer;
  SomaProfit, SomaExp, CurrentMonth : Double;
begin
  i            := 0;
  SomaProfit   := 0;
  CurrentMonth := 0;

  if iType = GRAPH_CASH_FLOW_FULL then
    SomaProfit := fIncome;

  //Prencheer a QueryBkProfit
  While i <= iTotalDias do
  begin

  case iType of
     GRAPH_CASH_FLOW
        : begin
          If dsBKSales.Locate('Day',i,[]) then
             SomaProfit   := SomaProfit + dsBKSalesProfit.AsCurrency
          else
             SomaProfit   := SomaProfit + 0;
         end;
     GRAPH_BREAK_EVEN
        : begin
          If dsBKProfit.Locate('Day',i,[]) then
             SomaProfit   := SomaProfit + dsBKProfitProfit.AsCurrency
          else
             SomaProfit   := SomaProfit + 0;
         end;

     GRAPH_CASH_FLOW_FULL
        : begin
          If dsCashFlowSales.Locate('Day',i,[]) then
          begin
             SomaProfit   := SomaProfit + dsCashFlowSalesProfit.AsCurrency;
             CurrentMonth := CurrentMonth + dsCashFlowSalesProfit.AsCurrency;
          end
          else
             SomaProfit   := SomaProfit + 0;
         end;
  end;

  MainChart.Series[0].AddY(SomaProfit,'', clteecolor);
  inc(i);
  end;

  case iType of
     GRAPH_CASH_FLOW      :  edtProft.Text    := FormatFloat('#,##0.00', fIncome);
     GRAPH_BREAK_EVEN     :  edtBKProfit.Text := FormatFloat('#,##0.00', fIncome);
     GRAPH_CASH_FLOW_FULL :  begin
                             edtCFStart.Text := FormatFloat('#,##0.00', fIncome);
                             edtCFEnd.Text   := FormatFloat('#,##0.00', SomaProfit);
                             end;
  end;

  //Preencher a QueryBKExpenses
  i       := 0;
  SomaExp := 0;

  if iType = GRAPH_CASH_FLOW_FULL then
    SomaExp := fExpenses;

  While i <= iTotalDias do
  begin
  case iType of
     GRAPH_CASH_FLOW
        : begin
          If dsBKExpenses.Locate('Day',i,[]) then
             SomaExp   := SomaExp + dsBKExpensesTotal.AsCurrency
          else
             SomaExp   := SomaExp + 0;
         end;
     GRAPH_BREAK_EVEN
        : begin
          If dsBKExp.Locate('Day',i,[]) then
             SomaExp   := SomaExp + dsBKExpTotal.AsCurrency
          else
             SomaExp   := SomaExp + 0;
         end;
     GRAPH_CASH_FLOW_FULL
        : begin
          If dsCashFlowExp.Locate('Day',i,[]) then
             SomaExp   := SomaExp + dsCashFlowExpTotal.AsCurrency
          else
             SomaExp   := SomaExp + 0;
         end;
  end;

  MainChart.Series[1].AddY(SomaExp,'', clteecolor);
  inc(i);
  end;

  case iType of
     GRAPH_CASH_FLOW
       : begin
         edtExp.Text := FormatFloat('#,##0.00', fExpenses);
         edtNet.Text := FormatFloat('#,##0.00', fIncome - fExpenses);
         end;
     GRAPH_BREAK_EVEN
       : begin
         edtBKPExp.Text := FormatFloat('#,##0.00', fExpenses);
         edtBKPNet.Text := FormatFloat('#,##0.00', fIncome - fExpenses);
         end;
     GRAPH_CASH_FLOW_FULL
       : begin
         edtCFExpensesStart.Text := FormatFloat('#,##0.00', fExpenses);
         edtCFExpensesEnd.Text := FormatFloat('#,##0.00', SomaExp);

         edtCFNet.Text      := FormatFloat('#,##0.00', SomaProfit - SomaExp);
         end;
  end;

end;

procedure TFrmHourResult.GraphFullCashFlow(fMonth, fYear,
  fIDStore: Integer);
var
  sDataIni, sDataFim, sSqlProft, sMonth, sIDStore, sDateformat : string;
  sSQL : String;
  fDataIni : TDatetime;
begin

  Try

   //Verificar a funcao p/ passar os dados
   chrCashFlow.Series[0].Clear;
   chrCashFlow.Series[1].Clear;

   sMonth := IntTostr(fMonth);

   If Length(sMonth) = 1 then
      sMonth := '0'+sMonth;

   sDataIni   := sMonth+'/01/'+IntToStr(fYear);

   try
     sDateformat := ShortDateFormat;
     ShortDateFormat := 'mm/dd/yyyy';

     fDataIni := StrToDate(sDataIni);
     sDataFim := DateToStr(AddMonth(fDataIni)+1);

     //pego o total de dias do mes
     iTotalDias := StrTOInt(Copy( MyFormatDate((FimMes(fDataIni))) ,4,2));

   finally
      ShortDateFormat := sDateformat;
      end;

   Screen.Cursor := crHourGlass;


   sSQL := 'SELECT DatePart(day, L.DataVencimento) as day, '+
           'SUM(L.ValorNominal) as Profit ' +
           'FROM Fin_Lancamento L (NOLOCK) ' +
           'WHERE L.Pagando = 0 ' +
           'AND L.DataVencimento >= ' + QuotedStr(sDataIni) +
           'AND L.DataVencimento < ' + QuotedStr(sDataFim) +
           'AND L.Desativado = 0 ' +
           'GROUP BY DatePart(day, L.DataVencimento) ' ;

   with dsCashFlowSales do
     begin
     CommandText := sSQL;
     Open;
     end;

   //expenses
   sSQL := 'SELECT DatePart(day, L.DataVencimento) day, '+
           'SUM(L.ValorNominal) Total ' +
           'FROM Fin_Lancamento L (NOLOCK) ' +
           'WHERE L.Pagando = 1 ' +
           'AND L.DataVencimento >= ' + QuotedStr(sDataIni) +
           'AND L.DataVencimento < ' + QuotedStr(sDataFim) +
           'AND L.Desativado = 0 ' +
           'GROUP BY DatePart(day, L.DataVencimento) ' ;

    with dsCashFlowExp do
      begin
      CommandText := sSQL;
      Open;
      end;

   //Calc Totals
   sIDStore := '';
   if fIDStore <> 0 then
      sIDStore := IntToStr(fIDStore);

   //Sum Income
   sSQL := ' SELECT SUM(L.ValorNominal) as Income ' +
           ' FROM Fin_Lancamento L (NOLOCK) WHERE L.Pagando = 0 ' +
           ' AND L.DataVencimento < ' + QuotedStr(sDataIni) +
           ' AND L.Desativado = 0 ';

   with DM.quFreeSQL do
   begin
       If Active then
          Close;
       SQL.Clear;
       SQL.Add(sSQL);
       Open;
       fIncome := FieldByName('Income').AsCurrency;
       Close;
   end;


   //Sum Income
   sSQL := ' SELECT SUM(L.ValorNominal) as Expenses ' +
           ' FROM Fin_Lancamento L (NOLOCK) WHERE L.Pagando = 1 ' +
           ' AND L.DataVencimento < ' + QuotedStr(sDataIni) +
           ' AND L.Desativado = 0 ';

   with DM.quFreeSQL do
   begin
       If Active then
          Close;
       SQL.Clear;
       SQL.Add(sSQL);
       Open;
       fExpenses := FieldByName('Expenses').AsCurrency;
       Close;
   end;

   //Jogar os Valores no Grafico
   GraphFillOut(chrCashFlow, GRAPH_CASH_FLOW_FULL);

 Finally
  dsCashFlowSales.Close;
  dsCashFlowExp.Close;
  Screen.Cursor := crDefault;
 end;

end;

procedure TFrmHourResult.GraphSaleDayWeek(IniDate, EndDate: TDateTime; fIDStore: Integer);
var
  SaleDayWeekTotal : Double;
  sSQL : String;
  i : Integer;
begin
  Try
    Screen.Cursor := crHourGlass;

    lblSelectedTotal.Caption := sSelectedTotal;

    sSQL := ' SELECT DatePart(weekday, InvoiceDate) as WeekDay, ROUND(SUM(SubTotal - InvoiceDiscount - ItemDiscount),2) Amount ' +
            ' FROM Invoice (NOLOCK) ' +
            ' WHERE InvoiceDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',IniDate)) + ' AND InvoiceDate < ' +QuotedStr(FormatDateTime('mm/dd/yyyy',EndDate + 1)) + ' AND Canceled = 0 ';

    if fIDStore <> 0 then
      sSQL := sSQL + ' AND IDStore = ' + InttoStr(fIDStore);


    if not DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
      sSQL := sSQL + ' AND InvoiceDate is not null AND IDInvoice is not null';

    sSQL := sSQL + ' GROUP BY DatePart(WeekDay, InvoiceDate) Order By DatePart(WeekDay, InvoiceDate)';

    with dsSaleDayWeek do
    begin
      if Active then
        begin
          Close;
          cdsSaleDayWeek.Close;
        end;

      CommandText := sSQL;
      Open;
    end;

    with cdsSaleDayWeek do
    begin
      DisableControls;
      try
        Open;
        SaleDayWeekTotal := 0;

        for i := 1 to 7 do
          if not(Locate('WeekDay', i, [])) then
             begin
               Append;
               FieldByName('WeekDay').AsInteger    := i;
               FieldByName('Amount').AsInteger     := 0;
               FieldByName('NameDayWeek').AsString := treeColumnDays.Items[i - 1];
               Post;
             end;

        First;
        While not EOF do
        begin
          SaleDayWeekTotal := SaleDayWeekTotal + cdsSaleDayWeekAmount.AsCurrency;
          Next;
        end;

         edtSaleDayWeekTotal.Text := FormatFloat('#,##0.00', SaleDayWeekTotal);
      finally
        EnableControls;
      end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmHourResult.dsSaleDayWeekCalcFields(DataSet: TDataSet);
var
  i : Integer;
begin
  case dsSaleDayWeek.FieldByName('WeekDay').AsInteger of
    1 : dsSaleDayWeek.FieldByName('NameDayWeek').AsString := treeColumnDays.Items[0];
    2 : dsSaleDayWeek.FieldByName('NameDayWeek').AsString := treeColumnDays.Items[1];
    3 : dsSaleDayWeek.FieldByName('NameDayWeek').AsString := treeColumnDays.Items[2];
    4 : dsSaleDayWeek.FieldByName('NameDayWeek').AsString := treeColumnDays.Items[3];
    5 : dsSaleDayWeek.FieldByName('NameDayWeek').AsString := treeColumnDays.Items[4];
    6 : dsSaleDayWeek.FieldByName('NameDayWeek').AsString := treeColumnDays.Items[5];
    7 : dsSaleDayWeek.FieldByName('NameDayWeek').AsString := treeColumnDays.Items[6];
  end;
end;

procedure TFrmHourResult.SaleDayWeekClose;
begin
  with dsSaleDayWeek do
   if Active then
      Close;

  with cdsSaleDayWeek do
   if Active then
      Close;
end;

procedure TFrmHourResult.GraphTrafficSale(IniDate, EndDate: TDateTime;
  fIDStore: Integer);
var
  sSQL, sWhere : String;
begin
  Try
    Screen.Cursor := crHourGlass;

    if not DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
      sWhere := ' WHERE InvoiceDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',IniDate)) + ' AND InvoiceDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',(EndDate + 1))) + ' AND Canceled = 0 '
    else
      sWhere := ' WHERE PreSaleDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',IniDate)) + ' AND PreSaleDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',(EndDate + 1))) + ' AND Canceled = 0 ';

    if fIDStore <> 0 then
      sWhere := sWhere + ' AND IDStore = ' + InttoStr(fIDStore);

    sSQL := ' SELECT DatePart(Hour, InvoiceDate) as Hora, COUNT(IDInvoice) as InvoicePerHour ' +
            ' FROM Invoice (NOLOCK) ' +
            sWhere +
            ' GROUP BY DatePart(Hour, InvoiceDate) ' +
            ' ORDER BY Hora ';

    with quInvoiceHour do
    begin
      if Active then
          Close;
      CommandText := sSQL;
      Open;
    end;

    sWhere := ' WHERE TM.DateMov >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',IniDate)) + ' AND TM.DateMov < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',(EndDate + 1)));
    if fIDStore <> 0 then
      sWhere := ' AND IDStore = ' + InttoStr(fIDStore);

    sSQL := ' SELECT DatePart(Hour, TM.DateMov) as Hora, SUM(TM.Qty) as PeoplePerHour ' +
            ' FROM Sal_TrafficMov TM (NOLOCK) ' +
            ' JOIN Sal_TrafficBox T (NOLOCK) ON (T.IDTrafficBox = TM.IDTrafficBox) ' +
            sWhere +
            ' GROUP BY DatePart(Hour, TM.DateMov) ' +
            ' ORDER BY Hora ';

    with quTrafficCount do
    begin
      if Active then
          Close;
      CommandText := sSQL;
      Open;
    end;


  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFrmHourResult.GraphRupture(DateIni, DateEnd: TDateTime; IDStore: Integer);
begin

  if not bCreateRuptura then
  begin
    PanelRupture.CreateSubList;
    bCreateRuptura := True;
  end;

  PanelRupture.Param := 'DateIni='+DateTimeToStr(DateIni)+';'+
                        'DateEnd='+DateTimeToStr(DateEnd)+';'+
                        'IDStore='+IntToStr(IDStore)+';'+
                        'Title='+sRupture;
end;

procedure TFrmHourResult.GraphSalesCategory(IniDate, EndDate: TDateTime;
  fNumCateg, fIDStore: Integer; IsDesc: Boolean; sMode: String);

  procedure SetMod(Mode:String);
  begin
    chtSalesCategory.Series[0].Marks.Visible := True;

    if Mode = '%' then
      chtSalesCategory.Series[0].Marks.Style := smsPercent
    else If Mode = '$' then
      chtSalesCategory.Series[0].Marks.Style := smsValue
    else
      chtSalesCategory.Series[0].Marks.Visible := False;

    chtSalesCategory.Series[0].RefreshSeries;
  end;

var
  sWhere, sOrder, sIniDate, sEndDate: String;
  CategoryTotal: Currency;
begin
  try
    sWhere := '';
    SetMod(sMode);

    sIniDate := FormatDateTime('mm/dd/yyyy', IniDate);
    sEndDate := FormatDateTime('mm/dd/yyyy', EndDate+1);

    with dsSalesCategory do
    begin
      if Active then
        close;

      if fIDStore <> 0 then
        sWhere := ' AND I.IDStore = '+ IntToStr(fIDStore);

      if IsDesc then
        sOrder := ' Order By Sales DESC '
      else
        sOrder := ' Order By Sales ASC ';

      if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
        CommandText := ' SET ROWCOUNT :Numero' +
                       ' SELECT TG.Name  TabGroup,' +
                       ' sum((SI.SalePrice * SI.Qty) - SI.Discount) as Sales' +
                       ' FROM vwInvoiceParents I (NOLOCK)'+
                       ' JOIN vwSaleItem SI (NOLOCK) ON ( SI.IDPreSale = I.DocumentID )'+
                       ' JOIN Pessoa P (NOLOCK) ON (SI.ComissionID = P.IDPessoa AND SI.IDTipoPessoa = P.IDTipoPessoa) ' +
                       ' JOIN Model M (NOLOCK) ON ( SI.ModelID = M.IDModel )' +
                       ' JOIN dbo.TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup ) ' +
                       ' WHERE SI.InventMovTypeID = 1 ' +
                       ' AND I.PreSaleDate >= ' + QuotedStr(sIniDate) +
                       ' AND I.PreSaleDate < ' + QuotedStr(sEndDate) +
                       ' AND I.Canceled = 0 ' +
                       sWhere +
                       ' GROUP BY TG.Name' + sOrder
      else
        CommandText := ' SET ROWCOUNT :Numero' +
                       ' SELECT TG.Name  TabGroup,' +
                       ' sum((InvMov.SalePrice * InvMov.Qty) - (InvMov.Discount + IVD.UnitDiscount)) as Sales' +
                       ' FROM InventoryMov InvMov (NOLOCK)'+
                       ' JOIN Invoice I (NOLOCK) ON (InvMov.DocumentID = I.IDInvoice)'+
                       ' JOIN Model Model (NOLOCK) ON (InvMov.ModelID = Model.IDModel)' +
                       ' JOIN TabGroup TG (NOLOCK) ON (Model.GroupID = TG.IDGroup)' +
                       ' JOIN vwUnitInvoiceDiscount IVD (NOLOCK) ON (IVD.DocumentID = I.IDInvoice AND IVD.Invoice = 1) ' +
                       ' WHERE (InvMov.InventMovTypeID = 1)' +
                       ' AND I.InvoiceDate >= ' + QuotedStr(sIniDate) +
                       ' AND I.InvoiceDate < ' + QuotedStr(sEndDate) +
                       ' AND I.Canceled = 0 ' +
                       sWhere +
                       ' GROUP BY TG.Name' + sOrder;

      //Set params
      Parameters.ParambyName('Numero').Value := fNumCateg;
      try
        Screen.Cursor := crHourGlass;
        Open;
      finally
        Screen.Cursor := crDefault;
      end;

      try
        dsSalesCategory.DisableControls;
        CategoryTotal := 0;
        dsSalesCategory.First;
        while not EOF do
        begin
          CategoryTotal := CategoryTotal + dsSalesCategorySales.AsCurrency;
          dsSalesCategory.Next;
        end;
      finally
        dsSalesCategory.EnableControls;
        edtSalesCategoryTotal.Text := FormatFloat('#,##0.00', CategoryTotal);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
