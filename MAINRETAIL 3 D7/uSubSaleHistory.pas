unit uSubSaleHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, Grids, StdCtrls, Mask, StrUtils,
  SuperComboADO, DB, ADODB, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox;

type
  TSubSaleHistory = class(TParentSub)
    Label7: TLabel;
    btnRefreshSales: TButton;
    grdSaleHist: TStringGrid;
    quSaleHistory: TADOQuery;
    quSaleHistoryYear: TIntegerField;
    quSaleHistoryMonth: TIntegerField;
    quSaleHistoryTotSale: TFloatField;
    quSaleHistoryTotCost: TFloatField;
    cmbStoreSale: TcxLookupComboBox;
    procedure btnRefreshSalesClick(Sender: TObject);
    procedure grdSaleHistSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cmbStoreSaleEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxLookupComboBox1PropertiesChange(Sender: TObject);
  private
    { Private declarations }
    fIDModel : Integer;
    fIDStore : Integer;
    sRetail,
    sCost,
    sProfit,
    sMarkup,
    sTotalYear,
    sTotalMonth,
    sProfValor  : String;
    procedure RefreshSaleHistory;
    procedure FillSaleHistory(Tipo, MyMonth, MyYear : integer);
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
  end;

implementation

uses uDM, uParamFunctions, uDMGlobal, uNumericFunctions, uSystemConst,
  uSqlFunctions;

{$R *.dfm}

procedure TSubSaleHistory.AfterSetParam;
begin

   fIDModel := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
   fIDStore := StrToIntDef(ParseParam(FParam, 'IDStore'),0);
   RefreshSaleHistory;

end;

procedure TSubSaleHistory.FillSaleHistory(Tipo, MyMonth, MyYear : integer);
var
   TotYearSale, TotYearCost : Double;
   i, Pos                   : integer;
begin
   for i := 1 to 14 do
      grdSaleHist.Cells[i, grdSaleHist.RowCount-1] := '0';

   case Tipo of
        HIST_RETAIL : grdSaleHist.Cells[0 , grdSaleHist.RowCount-1] := sRetail;
        HIST_COST   : grdSaleHist.Cells[0 , grdSaleHist.RowCount-1] := sCost;
        HIST_GROSS  : grdSaleHist.Cells[0 , grdSaleHist.RowCount-1] := sProfit;
        HIST_MARKUP : grdSaleHist.Cells[0 , grdSaleHist.RowCount-1] := sMarkup;
        HIST_PROFIT : grdSaleHist.Cells[0 , grdSaleHist.RowCount-1] := sProfValor;
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
         Pos := (MyMonth-quSaleHistoryMonth.AsInteger)+1
      else if (quSaleHistoryMonth.AsInteger >= MyMonth) and
              (quSaleHistoryYear.AsInteger  < MyYear )  then
         Pos := (12-quSaleHistoryMonth.AsInteger)+MyMonth+1;

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


procedure TSubSaleHistory.RefreshSaleHistory;
var
   i, j , MyMonth, MyYear,
   AtualMovID   : Integer;
begin

  Screen.Cursor := crHourGlass;

     with quSaleHistory do
       begin
         if Active then
            Close;

         if not Active then
           begin
             MyMonth := StrToInt(FormatDateTime('m', Date));
             MyYear  := StrToInt(FormatDateTime('yyyy', Date));

             SQL.Clear;
             SQL.Add('SELECT Year, Month, SUM(TotSale) as TotSale, SUM(TotCost) as TotCost');
             SQL.Add('FROM InventoryMovTotal InventoryMovTotal (NOLOCK)');
             SQL.Add(' WHERE ModelID = ' + IntToStr(fIDModel));

             if fIDStore <> 0 then
                SQL.Add(' AND StoreID = ' + IntToStr(fIDStore))
             else
                SQL.Add(' AND StoreID IN (' + DM.fStore.StoreList + ')');

             SQL.Add(' AND InventMovTypeID in (1, 50)');
             SQL.Add(' AND ((Year >=  '+IntToStr(MyYear - 1)+ ' AND Month >= '+ IntToStr(MyMonth-1)+') or ((Year-1) = '+IntToStr(MyYear-1)+')) ');
             SQL.Add(' GROUP BY Year, Month ');
             SQL.Add(' ORDER BY Year, Month ');

             Open;
           end;

         grdSaleHist.RowCount := 2;

         // Cabecalho TotYear e TotMonth
         grdSaleHist.Cells[1, 0] := sTotalMonth;
         grdSaleHist.Cells[14, 0] := sTotalYear;

         // Cabeçalho dos meses
         for i := 1 to 12 do
            if i < MyMonth then
               grdSaleHist.Cells[(MyMonth-i)+1, 0] := ShortMonthNames[i] + ' ' + RightStr(IntToStr(MyYear),2)
            else
               grdSaleHist.Cells[(12-i)+MyMonth+1, 0]   := ShortMonthNames[i] + ' ' + RightStr(IntToStr(MyYear - 1),2);

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

  Screen.Cursor := crDefault;

end;

procedure TSubSaleHistory.btnRefreshSalesClick(Sender: TObject);
begin
  inherited;
  DM.quLookUpStore.Close;
  fIDStore := 0;
  RefreshSaleHistory;
end;

procedure TSubSaleHistory.grdSaleHistSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  grdSaleHist.Hint := grdSaleHist.Cells[ACol, ARow];
end;

procedure TSubSaleHistory.FormCreate(Sender: TObject);
var
  sSQL, sWhere : String;
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sRetail    := 'Retail   ';
           sCost      := 'Cost     ';
           sProfit    := 'Profit % ';
           sMarkup    := 'MarkUp % ';
           sProfValor := 'Profit Amount';
           sTotalYear := 'YTD';
           sTotalMonth:= 'MTD';
           end;

     LANG_PORTUGUESE :
           begin
           sRetail    := 'Venda    ';
           sCost      := 'Custo    ';
           sProfit    := '% Lucro  ';
           sMarkup    := '% Margem ';
           sProfValor := 'Lucro';
           sTotalYear := 'ANO';
           sTotalMonth:= 'MES';
           end;

     LANG_SPANISH :
           begin
           sRetail    := 'Venta    ';
           sCost      := 'Costo    ';
           sProfit    := '% Lucro  ';
           sMarkup    := '% Margen ';
           sProfValor := 'Margen';
           sTotalYear := 'YTD';
           sTotalMonth:= 'MTD';
           end;
   end;

  DM.quLookUpStore.Close;
  sWhere := ' Desativado = 0 AND IDStore <> 0 ';
  if DM.fStore.StoreList <> '' then
    sWhere := sWhere + ' AND IDStore IN (' + DM.fStore.StoreList + ')';
  sSQL := ChangeWhereClause(DM.quLookUpStore.CommandText, sWhere, True);
  DM.quLookUpStore.CommandText := sSQL;


end;

procedure TSubSaleHistory.cmbStoreSaleEnter(Sender: TObject);
begin
  inherited;
  with DM.quLookUpStore do
    if not Active then
       Open;
end;

procedure TSubSaleHistory.FormDestroy(Sender: TObject);
begin

  DM.quLookUpStore.Close;
  quSaleHistory.Close;

  inherited;

end;

procedure TSubSaleHistory.cxLookupComboBox1PropertiesChange(
  Sender: TObject);
begin
  inherited;

  with DM.quLookUpStore do
    if Active then
       if DM.quLookUpStore.Locate('Name', cmbStoreSale.Text, []) then
          fIDStore := DM.quLookUpStoreIDStore.AsInteger;


  RefreshSaleHistory;
end;

initialization
   RegisterClass(TSubSaleHistory);

end.
