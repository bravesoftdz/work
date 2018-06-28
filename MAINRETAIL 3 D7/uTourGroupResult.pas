unit uTourGroupResult;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, Db, DBTables, StdCtrls, Grids, Mask, ComCtrls, Variants,
  LblEffct, ExtCtrls, DateBox, Buttons, uBrwTouristGroup, TeEngine, Series,
  TeeProcs, Chart, DBChart, ADODB, SuperComboADO, siComp, siLangRT, DBGrids,
  SMDBGrid;

type
  TTourGroupResult = class(TFrmParent)
    TabControl: TTabControl;
    pnlResult: TPanel;
    dsProfit: TDataSource;
    dsExpense: TDataSource;
    dsTourGroup: TDataSource;
    Panel4: TPanel;
    editTotSale: TEdit;
    Label5: TLabel;
    Label3: TLabel;
    Panel5: TPanel;
    editTotExpence: TEdit;
    Label7: TLabel;
    Label6: TLabel;
    Panel6: TPanel;
    lblTotals: TLabel;
    Panel7: TPanel;
    pnlPeriodo: TPanel;
    pnlAgency: TPanel;
    Label1: TLabel;
    pnlGuide: TPanel;
    Label2: TLabel;
    EditDateIni: TDateBox;
    EditDateFim: TDateBox;
    Label8: TLabel;
    Label9: TLabel;
    pnlTotal: TPanel;
    btShow: TSpeedButton;
    lblPlus: TLabel;
    pnlTotalSale: TPanel;
    Label12: TLabel;
    editTotCost: TEdit;
    Label27: TLabel;
    Shape1: TShape;
    Label24: TLabel;
    editTotProfit: TEdit;
    Label13: TLabel;
    Label16: TLabel;
    EditTotPax: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    EditTotInvoice: TEdit;
    editAvgInvoiceValueL: TLabel;
    editAvgInvoiceValue: TEdit;
    Label21: TLabel;
    editAvgSalesPax: TEdit;
    Label11: TLabel;
    editRealProfit: TEdit;
    Label22: TLabel;
    editSliceSales: TEdit;
    Label23: TLabel;
    editSalesTourGroup: TEdit;
    AvgInvoicesGroupL: TLabel;
    editAvgSalesGroupL: TLabel;
    editAvgSalesGroup: TEdit;
    editAvgInvoicesGroup: TEdit;
    Label10: TLabel;
    editSliceTourGroupSales: TEdit;
    btRefresh: TSpeedButton;
    Label4: TLabel;
    EditFutureCom: TEdit;
    Label20: TLabel;
    EditProfit30: TEdit;
    chartProfit: TDBChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    spHelp: TSpeedButton;
    scGuide: TSuperComboADO;
    scAgency: TSuperComboADO;
    dtsTourGroup: TADODataSet;
    dtsProfit: TADODataSet;
    dtsExpense: TADODataSet;
    dtsSales: TADODataSet;
    dtsSalesTourGroup: TADODataSet;
    dtsFutureCom: TADODataSet;
    dtsChart: TADODataSet;
    dtsTourGroupDate: TDateTimeField;
    dtsTourGroupPax: TIntegerField;
    dtsTourGroupSales: TFloatField;
    dtsTourGroupInvoices: TIntegerField;
    dtsTourGroupTourGuide: TStringField;
    dtsTourGroupGroupCost: TFloatField;
    dtsTourGroupAvgPerPax: TFloatField;
    dtsTourGroupAvgInvoice: TFloatField;
    dtsTourGroupIDAgency: TIntegerField;
    dtsTourGroupIDGuide: TIntegerField;
    dtsProfitCategory: TStringField;
    dtsProfitProfit: TFloatField;
    dtsProfitSale: TFloatField;
    dtsProfitCost: TFloatField;
    dtsExpenseExpence: TStringField;
    dtsExpenseValue: TFloatField;
    dtsSalesTotSales: TFloatField;
    dtsSalesNumInvoices: TIntegerField;
    dtsSalesTourGroupTotSales: TFloatField;
    dtsSalesTourGroupNumInvoices: TIntegerField;
    dtsChartTotalProfit: TFloatField;
    dtsChartTourGroupProfit: TFloatField;
    dtsChartData: TStringField;
    dtsChartnData: TIntegerField;
    grdSale: TSMDBGrid;
    dxDBGrid1: TSMDBGrid;
    grdAgency: TSMDBGrid;
    grdGuide: TSMDBGrid;
    grdSaleFull: TSMDBGrid;
    procedure dtsProfitAfterOpen(DataSet: TDataSet);
    procedure dtsExpenseAfterOpen(DataSet: TDataSet);
    procedure TabControlChange(Sender: TObject);
    procedure scGuideSelectItem(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dtsTourGroupAfterOpen(DataSet: TDataSet);
    procedure dtsTourGroupAfterClose(DataSet: TDataSet);
    procedure dtsProfitAfterClose(DataSet: TDataSet);
    procedure dtsExpenseAfterClose(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure EditDateChange(Sender: TObject);
    procedure scAgencySelectItem(Sender: TObject);
    procedure btShowClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure grdAgencyDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sTotalsAgency,
    sMonthProfit : String;
    TotExpence : Double;
    TotSales, TotCost, TotProfit : Double;
    NumPax, NumInvoices, NumGroups: Integer;
    brwTouristGroup : TbrwTouristGroup;
    procedure RefreshCombo(Sender: TObject);
    procedure CalcResult(Zera: Boolean);
    procedure TourGroupOpen(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
    procedure ProfitOpen(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
    procedure ExpenseOpen(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
    procedure TourGroupClose;
    procedure ProfitClose;
    procedure ExpenseClose;
    procedure TourGroupRefresh(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
    procedure ProfitRefresh(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
    procedure ExpenseRefresh(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
  public
    { Public declarations }
  end;

var
  TourGroupResult: TTourGroupResult;

implementation

uses uDM, uMsgBox, uMsgConstant, uNumericFunctions, uDateTimeFunctions,
     uDMGlobal;

{$R *.DFM}

procedure TTourGroupResult.TourGroupOpen(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
begin
  with dtsTourGroup do
  begin
    if aDataInicio <> 0 then
      Parameters.ParamByName('DataInicio').Value := aDataInicio
    else
      Parameters.ParamByName('DataInicio').Value := null;

    if aDataFim <> 0 then
      Parameters.ParamByName('DataFim').Value    := aDataFim
    else
      Parameters.ParamByName('DataFim').Value    := null;

    if aIDGuide > -1 then  // parametro sendo -1 eu nao mexo nele
      Parameters.ParamByName('IDGuide').Value    := aIDGuide;

    if aIDAgency > -1 then // parametro sendo -1 eu nao mexo nele
      Parameters.ParamByName('IDAgency').Value   := aIDAgency;

    Open;
  end;
end;

procedure TTourGroupResult.ProfitOpen(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
begin
  with dtsProfit do
  begin
    if aDataInicio <> 0 then
      Parameters.ParamByName('DataInicio').Value := aDataInicio
    else
      Parameters.ParamByName('DataInicio').Value := null;

    if aDataFim <> 0 then
      Parameters.ParamByName('DataFim').Value    := aDataFim
    else
      Parameters.ParamByName('DataFim').Value    := null;

    if aIDGuide > -1 then  // parametro sendo -1 eu nao mexo nele
      Parameters.ParamByName('IDGuide').Value    := aIDGuide;

    if aIDAgency > -1 then // parametro sendo -1 eu nao mexo nele
      Parameters.ParamByName('IDAgency').Value   := aIDAgency;

    Open;
  end;
end;

procedure TTourGroupResult.ExpenseOpen(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
begin
  with dtsExpense do
  begin
    if aDataInicio <> 0 then
      Parameters.ParamByName('DataInicio').Value := aDataInicio
    else
      Parameters.ParamByName('DataInicio').Value := null;

    if aDataFim <> 0 then
      Parameters.ParamByName('DataFim').Value    := aDataFim
    else
      Parameters.ParamByName('DataFim').Value    := null;

    if aIDGuide > -1 then  // parametro sendo -1 eu nao mexo nele
      Parameters.ParamByName('IDGuide').Value    := aIDGuide;

    if aIDAgency > -1 then // parametro sendo -1 eu nao mexo nele
      Parameters.ParamByName('IDAgency').Value   := aIDAgency;

    Open;
  end;
end;

procedure TTourGroupResult.TourGroupClose;
begin
  dtsTourGroup.Close;
end;

procedure TTourGroupResult.ProfitClose;
begin
  dtsProfit.Close;
end;

procedure TTourGroupResult.ExpenseClose;
begin
  dtsExpense.Close;
end;

procedure TTourGroupResult.TourGroupRefresh(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
begin
  TourGroupClose;
  TourGroupOpen(aDataInicio, aDataFim, aIDGuide, aIDAgency);
end;

procedure TTourGroupResult.ProfitRefresh(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
begin
  ProfitClose;
  ProfitOpen(aDataInicio, aDataFim, aIDGuide, aIDAgency);
end;

procedure TTourGroupResult.ExpenseRefresh(aDataInicio, aDataFim: TDateTime;
          aIDGuide, aIDAgency: variant);
begin
  ExpenseClose;
  ExpenseOpen(aDataInicio, aDataFim, aIDGuide, aIDAgency);
end;

procedure TTourGroupResult.dtsProfitAfterOpen(DataSet: TDataSet);
begin
  with dtsProfit do
  begin
    DisableControls;

    TotSales  := 0;
    TotCost   := 0;
    TotProfit := 0;

    while not EOF do
    begin
      TotSales  := TotSales + dtsProfitSale.AsFloat;
      TotCost   := TotCost + dtsProfitCost.AsFloat;
      TotProfit := TotProfit + dtsProfitProfit.AsFloat;
      Next;
    end;
    First;
    EnableControls;
  end;
  editTotSale.Text   := FloatToStrF(TotSales, ffCurrency, 20, 2);
  editTotCost.Text   := FloatToStrF(TotCost, ffCurrency, 20, 2);
  editTotProfit.Text := FloatToStrF(TotProfit, ffCurrency, 20, 2);
end;

procedure TTourGroupResult.dtsExpenseAfterOpen(DataSet: TDataSet);
begin
  with dtsExpense do
  begin
    DisableControls;
    TotExpence := 0;
    while not EOF do
    begin
      TotExpence := TotExpence + dtsExpenseValue.AsFloat;
      Next;
    end;
    First;
    EnableControls;
  end;
  editTotExpence.Text := FloatToStrF(TotExpence, ffCurrency, 20, 2);
end;

procedure TTourGroupResult.CalcResult(Zera: Boolean);
var
  TotLucro: Double;
begin
  if ( Not Zera ) then
  begin
    TADOStoredProc(dtsFutureCom).ExecProc;
    EditFutureCom.Text := FloatToStrF(dtsFutureCom.Parameters.ParamByName('@Commission').Value, ffCurrency, 20, 2);
    TotExpence := TotExpence + dtsFutureCom.Parameters.ParamByName('@Commission').Value;
    editTotExpence.Text := FloatToStrF(TotExpence, ffCurrency, 20, 2);
  end
  else
  begin
    EditFutureCom.Text  := '0.00';
    editTotExpence.Text := '0.00';
  end;

  // decobre o total de vendas no periodo
  dtsSales.Open;
  dtsSalesTourGroup.Open;

  if ( NumPax <> 0 ) and ( not Zera ) then
    editAvgSalesPax.Text := FloatToStrF((TotSales / NumPax), ffCurrency, 20, 2)
  else
    editAvgSalesPax.Text := '';

  if ( NumInvoices <> 0  ) and ( Not Zera ) then
    editAvgInvoiceValue.Text := FloatToStrF((TotSales / NumInvoices), ffCurrency, 20, 2)
  else
    editAvgInvoiceValue.Text := '';

  if ( NumGroups <> 0 ) and ( Not Zera ) then
  begin
    editAvgSalesGroup.Text    := FloatToStrF((TotSales / NumGroups), ffCurrency, 20, 2);
    editAvgInvoicesGroup.Text := FloatToStr(Trunc((NumInvoices / NumGroups)*100)/100);
  end
  else
  begin
    editAvgSalesGroup.Text    := '';
    editAvgInvoicesGroup.Text := '';
  end;

  if not Zera then
    editRealProfit.Text := FloatToStrF((TotProfit - TotExpence), ffCurrency, 20, 2)
  else
    editRealProfit.Text := '';

  if ( dtsSalesTotSales.AsFloat <> 0 ) and ( Not Zera ) then
    editSliceSales.Text := FloatToStr(Trunc((TotSales / dtsSalesTotSales.AsFloat)* 10000 )/100 ) + ' %'
  else
    editSliceSales.Text := '';

  if ( dtsSalesTourGroupTotSales.AsFloat <> 0 ) and ( Not Zera ) then
    editSliceTourGroupSales.Text := FloatToStr(Trunc((TotSales / dtsSalesTourGroupTotSales.AsFloat)* 10000 )/100 ) + ' %'
  else
    editSliceTourGroupSales.Text := '';

  if ( dtsSalesNumInvoices.AsFloat <> 0 ) and ( Not Zera ) then
    editSalesTourGroup.Text := FloatToStr(Trunc((dtsSalesTourGroupTotSales.AsFloat / dtsSalesTotSales.AsFloat)* 10000 )/100 ) + ' %'
  else
    editSalesTourGroup.Text := '';

  if not Zera then
    editProfit30.Text := FloatToStrF((TotProfit - TotExpence) * 0.7, ffCurrency, 20, 2)
  else
    editProfit30.Text := '';

  dtsSalesTourGroup.Close;
  dtsSales.Close;
end;

procedure TTourGroupResult.TabControlChange(Sender: TObject);
begin
  inherited;
  pnlAgency.Visible := (TabControl.TabIndex = 0);
  pnlGuide.Visible  := (TabControl.TabIndex = 1);

  if TabControl.TabIndex in [0, 1] then
    lblTotals.Caption := sTotalsAgency
  else
    lblTotals.Caption := sMonthProfit;

  if pnlAgency.Visible then
  begin
    scAgency.LookUpValue := '';
    scAgency.SetFocus;
  end;

  if pnlGuide.Visible then
  begin
    scGuide.SetFocus;
    scGuide.LookUpValue  := '';
  end;

  grdAgency.Visible   := (TabControl.TabIndex = 0);
  grdGuide.Visible    := (TabControl.TabIndex = 1);
  chartProfit.Visible := (TabControl.TabIndex = 2);

  {if not(TabControl.TabIndex = 2) then
     RefreshCombo(nil)        { Atualiza no click do TabControl
  else}
  begin
    ExpenseRefresh(0, 0, -1, -1);

    ProfitRefresh(0, 0, -1, -1);

    TourGroupRefresh(0, 0, -1, -1);

    with dtsChart do
    begin
      Close;
      Parameters.ParamByName('DataInicio').Value := Null;
      Parameters.ParamByName('DataFim').Value    := Null;
      Open;
    end;

    CalcResult(True);
  end;
end;

procedure TTourGroupResult.RefreshCombo(Sender : TObject);
begin
  Screen.Cursor := crHourGlass;

  //#Rod - Trunc
  dtsSales.Parameters.ParamByName('DataInicio').Value := Int(EditDateIni.Date);
  dtsSales.Parameters.ParamByName('DataFim').Value    := Int(EditDateFim.Date)+1;

  dtsSalesTourGroup.Parameters.ParamByName('DataInicio').Value := Int(EditDateIni.Date);
  dtsSalesTourGroup.Parameters.ParamByName('DataFim').Value    := Int(EditDateFim.Date)+1;

  dtsFutureCom.Parameters.ParamByName('@DataInicio').Value := Int(EditDateIni.Date);
  dtsFutureCom.Parameters.ParamByName('@DataFim').Value    := Int(EditDateFim.Date)+1;

  if TabControl.TabIndex = 0 then
  begin
    ExpenseRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, Null, MyStrToInt(scAgency.LookUpValue));

    ProfitRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, Null, MyStrToInt(scAgency.LookUpValue));

    TourGroupRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, Null, MyStrToInt(scAgency.LookUpValue));

    dtsFutureCom.Parameters.ParamByName('@IDGuide').Value  := Null;
    dtsFutureCom.Parameters.ParamByName('@IDAgency').Value := MyStrToInt(scAgency.LookUpValue);
  end
  else if TabControl.TabIndex = 1 then
  begin
    ExpenseRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, MyStrToInt(scGuide.LookUpValue), Null);

    ProfitRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, MyStrToInt(scGuide.LookUpValue), Null);

    TourGroupRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, MyStrToInt(scGuide.LookUpValue), Null);

    dtsFutureCom.Parameters.ParamByName('@IDGuide').Value  := MyStrToInt(scGuide.LookUpValue);
    dtsFutureCom.Parameters.ParamByName('@IDAgency').Value := Null;
  end
  else if TabControl.TabIndex = 2 then
  begin
    ExpenseRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, Null, Null);

    ProfitRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, Null, Null);

    TourGroupRefresh(Int(EditDateIni.Date), Int(EditDateFim.Date)+1, Null, Null);

    with dtsChart do
    begin
      Close;
      //#Rod
      Parameters.ParamByName('DataInicio').Value := Int(EditDateIni.Date);
      Parameters.ParamByName('DataFim').Value    := Int(EditDateFim.Date)+1;
      Open;
    end;

    dtsFutureCom.Parameters.ParamByName('@IDGuide').Value  := Null;
    dtsFutureCom.Parameters.ParamByName('@IDAgency').Value := Null;
  end;
  CalcResult(False);

  Screen.Cursor := crDefault;
end;

procedure TTourGroupResult.scGuideSelectItem(Sender: TObject);
begin
  inherited;
//  RefreshCombo(nil);
end;

procedure TTourGroupResult.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTourGroupResult.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TTourGroupResult.dtsTourGroupAfterOpen(DataSet: TDataSet);
begin
  NumPax      := 0;
  NumInvoices := 0;
  NumGroups   := 0;

  with dtsTourGroup do
  begin
    DisableControls;
    while not EOF do
    begin
      NumPax      := NumPax + dtsTourGroupPax.AsInteger;
      NumInvoices := NumInvoices + dtsTourGroupInvoices.AsInteger;
      NumGroups   := NumGroups + 1;

      Next;
    end;
    First;
    EnableControls;
  end;
  editTotPax.Text     := IntToStr(NumPax);
  editTotInvoice.Text := IntToStr(NumInvoices);
end;

procedure TTourGroupResult.dtsTourGroupAfterClose(DataSet: TDataSet);
begin
  inherited;
  editTotPax.Text     := '';
  editTotInvoice.Text := '';
end;

procedure TTourGroupResult.dtsProfitAfterClose(DataSet: TDataSet);
begin
  inherited;
  editTotProfit.Text := '';
end;

procedure TTourGroupResult.dtsExpenseAfterClose(DataSet: TDataSet);
begin
  inherited;
  editTotExpence.Text := '';
end;

procedure TTourGroupResult.FormShow(Sender: TObject);
begin
  inherited;
  EditDateIni.Date := Date;
  EditDateFim.Date := Date;
  btShowClick(nil);
  TabControl.TabIndex := 0;
  scAgency.SetFocus;
//**  TabControlChange(nil);
end;

procedure TTourGroupResult.EditDateChange(Sender: TObject);
begin
  inherited;
{
  if TestDate(EditDateIni.Text) and TestDate(EditDateFim.Text) then
    begin
      RefreshCombo(nil);
    end;
}
end;

procedure TTourGroupResult.scAgencySelectItem(Sender: TObject);
begin
  inherited;
//  RefreshCombo(nil);
end;

procedure TTourGroupResult.btShowClick(Sender: TObject);
begin
  inherited;
  lblPlus.Visible      := btShow.Down;
  pnlTotal.Visible     := btShow.Down;
  pnlTotalSale.Visible := btShow.Down;
  grdSaleFull.Visible  := btShow.Down;
  grdSale.Visible      := not btShow.Down;
end;

procedure TTourGroupResult.btRefreshClick(Sender: TObject);
begin
  inherited;
  if not TestDate(EditDateIni.Text) then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbCritical);
    EditDateIni.SetFocus;
    Exit;
  end;

  if not TestDate(EditDateFim.Text) then
  begin
    MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbCritical);
    EditDateFim.SetFocus;
    Exit;
  end;

  if TabControl.TabIndex = 0 then
  begin
    if scAgency.LookUpValue = '' then
    begin
      MsgBox(MSG_CRT_NO_AGENCY_SELECTED, vbOKOnly + vbCritical);
      scAgency.SetFocus;
      Exit;
    end;
  end
  else if TabControl.TabIndex = 1 then
  begin
    if scGuide.LookUpValue = '' then
    begin
      MsgBox(MSG_CRT_NO_GUIDE, vbOKOnly + vbInformation);
      scGuide.SetFocus;
      Exit;
    end;
  end;

  RefreshCombo(nil);
end;

procedure TTourGroupResult.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1430);
end;

procedure TTourGroupResult.grdAgencyDblClick(Sender: TObject);
begin
  inherited;
  with TbrwTouristGroup.Create(self) do
  begin
    pnlBasicFilter.Visible := False;
    aWhereBasicFilters[0] := 'EnterDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(Self.EditDateIni.Date))) + Chr(39) + ' AND ' +
                             'EnterDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(Self.EditDateFim.Date)+1)) + Chr(39);
    aWhereBasicFilters[1] := 'TouristGroup.IDAgency = ' + dtsTourGroupIDAgency.AsString + ' AND ' +
                             'TouristGroup.IDGuide  = ' + dtsTourGroupIDGuide.AsString;
    ExecBrowseSQL(True);
    ShowModal;
  end;
end;

procedure TTourGroupResult.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sTotalsAgency := 'Total by Agency Groups';
           sMonthProfit  := 'Monthly Profit';
           end;

     LANG_PORTUGUESE :
           begin
           sTotalsAgency := 'Total por Grupo Agencia';
           sMonthProfit  := 'Lucro mensal';
           end;

     LANG_SPANISH :
           begin
           sTotalsAgency := 'Total por Grupo Agencia';
           sMonthProfit  := 'Lucro mensal';
           end;
   end;

end;

end.
