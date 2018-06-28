unit uMediaResults;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, LblEffct, ExtCtrls, StdCtrls, ComCtrls, DateBox, Mask, Variants,
  Buttons, Db, DBTables, Grids, TeEngine, Series, TeeProcs, Chart, DBChart,
  RadioButtonAll, ADODB, SuperComboADO, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid;

type
  TMediaResults = class(TFrmParent)
    pgMedia: TPageControl;
    tsMedia: TTabSheet;
    pnlBody: TPanel;
    Panel4: TPanel;
    dsProfit: TDataSource;
    pnlMediaSales: TPanel;
    dsMedia: TDataSource;
    tsAllMedia: TTabSheet;
    chartMediaAll: TDBChart;
    Series1: TBarSeries;
    Series2: TPieSeries;
    pnlTotalAll: TPanel;
    pnlStore: TPanel;
    scStore: TSuperComboADO;
    pnlGraphControl: TPanel;
    SbtnValue1: TSpeedButton;
    SBtnPercent1: TSpeedButton;
    SBtnClear1: TSpeedButton;
    pnlLancDocTitle: TPanel;
    Panel6: TPanel;
    lbResult: TLabel;
    Label3: TLabel;
    btAreaTodas: TButton;
    Panel7: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    btRefresh: TSpeedButton;
    edtDateIni: TDateBox;
    edtDateFim: TDateBox;
    pnlMedia: TPanel;
    Label2: TLabel;
    scMedia: TSuperComboADO;
    sbShowBar: TSpeedButton;
    sbShowPie: TSpeedButton;
    spHelp: TSpeedButton;
    dstAllMedias: TADODataSet;
    dstAllMediasIDMedia: TIntegerField;
    dstAllMediasMedia: TStringField;
    dstAllMediasProfit: TBCDField;
    dstAllMediaProfit: TADODataSet;
    dstAllMediaProfitSale: TBCDField;
    dstAllMediaProfitCost: TBCDField;
    dstAllMediaProfitProfit: TBCDField;
    dstMedia: TADODataSet;
    dstMediaInvoiceDate: TDateTimeField;
    dstMediaSales: TBCDField;
    dstMediaInvoices: TIntegerField;
    dstMediaAvgInvoice: TBCDField;
    dstProfit: TADODataSet;
    dstProfitCategory: TStringField;
    dstProfitSale: TBCDField;
    dstProfitCost: TBCDField;
    dstProfitProfit: TBCDField;
    grdCateg: TcxGrid;
    grdCategDB: TcxGridDBTableView;
    grdCategLevel: TcxGridLevel;
    grdCategDBCategory: TcxGridDBColumn;
    grdCategDBSale: TcxGridDBColumn;
    grdCategDBCost: TcxGridDBColumn;
    grdCategDBProfit: TcxGridDBColumn;
    grdMedia: TcxGrid;
    gridMediaDB: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    gridMediaDBInvoiceDate: TcxGridDBColumn;
    gridMediaDBSales: TcxGridDBColumn;
    gridMediaDBInvoices: TcxGridDBColumn;
    gridMediaDBAvgInvoice: TcxGridDBColumn;
    dstAllMediasID: TIntegerField;
    cmdInserts: TADOCommand;
    pnlSale: TPanel;
    Label16: TLabel;
    edtSalesAll: TEdit;
    Label1: TLabel;
    pnlCost: TPanel;
    Label7: TLabel;
    edtCostAll: TEdit;
    Label10: TLabel;
    Panel5: TPanel;
    Label14: TLabel;
    Shape2: TShape;
    edtTotal: TEdit;
    Label11: TLabel;
    pnlTax: TPanel;
    lbTax: TLabel;
    edtTax: TEdit;
    Label5: TLabel;
    dstAllMediaProfitTax: TCurrencyField;
    Splitter1: TSplitter;
    procedure btCloseClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure sbShowBarClick(Sender: TObject);
    procedure chartMediaAllClickSeries(Sender: TCustomChart;
      Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure spHelpClick(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure pgMediaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dstMediaAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grdCategDBColumnHeaderClick(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure dstAllMediasCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    ID : Integer;
    sAvg,
    sAvarage : string;

    IniDate,
    EndDate : TDate;

    NumInvoices : Integer;
    dTotalSales : Currency;
    function ValidaField : Boolean;
    procedure RefreshResults;
    procedure RefreshTabs;

    procedure CreateTmpTable;
    procedure DestroyTmpTable;
    procedure DeleteTmpTable;

    //All Medias
    procedure OpenAllMediaInv;
    procedure OpenAllMediaPreInv;
    procedure AllMediasOpen;
    procedure AllMediasClose;
    procedure AllMediasRefresh;

    //All MediaProft
    procedure OpenAllMediaProfitInv;
    procedure OpenAllMediaProfitPreInv;
    procedure AllMediaProfitOpen;
    procedure AllMediaProfitClose;
    procedure AllMediaProfitRefresh;

    //One Media
    procedure OpenMediaInv;
    procedure OpenMediaPreInv;
    procedure MediaClose;
    procedure MediaOpen;
    procedure MediaRefresh;

    //One Profit
    procedure OpenMediaProfitInv;
    procedure OpenMediaProfitPreInv;
    procedure ProfitClose;
    procedure ProfitOpen;
    procedure ProfitRefresh;

  public
    { Public declarations }
    procedure Start;
  end;

implementation

uses uDM, uMsgBox, uDateTimeFunctions, uMsgConstant, uNumericFunctions,
     uDMGlobal, uSystemConst;

{$R *.DFM}


procedure TMediaResults.ProfitClose;
begin
    with dstProfit do
       if Active then
          Close;
end;

procedure TMediaResults.ProfitOpen;
begin

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
     OpenMediaProfitPreInv
  else
     OpenMediaProfitInv;

  with dstProfit do
     If not Active then
        Open;

end;

procedure TMediaResults.ProfitRefresh;
begin

  ProfitClose;
  ProfitOpen;

end;

procedure TMediaResults.MediaClose;
begin

   with TADODataSet(dsMedia.DataSet) do
      if Active then
         Close;

end;

procedure TMediaResults.MediaOpen;
begin

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
     OpenMediaPreInv
  else
     OpenMediaInv;


  with dstMedia do
     If not Active then
        Open;

end;

procedure TMediaResults.MediaRefresh;
begin

   MediaClose;
   MediaOpen;

end;


procedure TMediaResults.AllMediaProfitOpen;
begin

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
     OpenAllMediaProfitPreInv
  else
     OpenAllMediaProfitInv;

   with dstAllMediaProfit do
      If not Active then
         Open;
         
end;

procedure TMediaResults.AllMediaProfitClose;
begin

  with dstAllMediaProfit do
     if Active then
        Close;

end;

procedure TMediaResults.AllMediaProfitRefresh;
begin
  AllMediaProfitClose;
  AllMediaProfitOpen;
end;


procedure TMediaResults.Start;
begin

  edtDateIni.Date     := FirstDateMonth;
  edtDateFim.Date     := LastDateMonth;
  scStore.LookUpValue := IntToStr(DM.fStore.ID);

  pnlTax.Visible := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];

  RefreshTabs;

  ShowModal;

end;

procedure TMediaResults.OpenAllMediaInv;
var
  sSQL,
  sWhere : String;
begin

   IniDate := Trunc(edtDateIni.Date);
   EndDate := Trunc(edtDateFim.Date+1);

   sWhere := 'AND I.InvoiceDate >= ' + QuotedStr(MyFormatDate(IniDate)) +
             ' AND I.InvoiceDate < ' + QuotedStr(MyFormatDate(EndDate));
   if scStore.LookUpValue <> '' then
      sWhere := sWhere + ' AND I.IDStore = ' + scStore.LookUpValue;

  sSQL := 'INSERT #Midias ( IDMedia, Media, Profit) ' +
          'SELECT M.IDMedia, CONVERT(varchar(10),M.Media) as Media, ' +
          'sum(((InvMov.SalePrice-InvMov.CostPrice)*InvMov.Qty)-InvMov.Discount) as Profit ' +
          'FROM dbo.InventoryMov InvMov (NOLOCK) ' +
          'JOIN dbo.Invoice I (NOLOCK) ON ( InvMov.DocumentID = I.IDInvoice ) ' +
          'JOIN dbo.Media M (NOLOCK) ON ( I.MediaID = M.IDMedia) ' +
          'WHERE InvMov.InventMovTypeID = 1 ' +
          'AND I.IDPreSaleParent IS NULL ' +
          'AND I.Canceled = 0 ' +
          sWhere+
          ' GROUP BY	M.IDMedia, M.Media';

  with cmdInserts do
     begin
     CommandText := sSQL;
     Try
       Execute;
     Except
       end;
     end;
end;

procedure TMediaResults.OpenAllMediaPreInv;
var
  sSQL,
  sWhere : String;
begin

   IniDate := Trunc(edtDateIni.Date);
   EndDate := Trunc(edtDateFim.Date+1);

   sWhere := 'AND I.PreSaleDate >= ' + QuotedStr(MyFormatDate(IniDate)) +
             ' AND I.PreSaleDate < ' + QuotedStr(MyFormatDate(EndDate));
   if scStore.LookUpValue <> '' then
      sWhere := sWhere + ' AND I.IDStore = ' + scStore.LookUpValue;

  sSQL := 'INSERT #Midias ( IDMedia, Media, Profit) ' +
          'SELECT M.IDMedia, CONVERT(varchar(10),M.Media) as Media, ' +
          'SUM(C.ItemSaleTotal-C.ItemCostTotal-TaxValue) as Prof ' +
          'FROM  vwInvoiceParents I (NOLOCK) ' +
          'JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia) ' +
          'JOIN vwSaleItem C (NOLOCK) ON (I.DocumentID = C.IDPreSale) ' +
          'JOIN Pessoa P ON (C.ComissionID = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa) ' +
          'WHERE C.InventMovTypeID = 1 ' +
          'AND I.Canceled = 0 ' +
          sWhere +
          ' GROUP BY	M.IDMedia, M.Media';

  with cmdInserts do
     begin
     CommandText := sSQL;
     Try
       Execute;
     Except
       end;
     end;
end;

procedure TMediaResults.AllMediasOpen;
begin

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
     OpenAllMediaPreInv
  else
     OpenAllMediaInv;


  with dstAllMedias do
     If not Active then
        Open;
        
end;

procedure TMediaResults.AllMediasClose;
begin

  with dstAllMedias do
     if Active then
        Close;

end;

procedure TMediaResults.AllMediasRefresh;
begin
  AllMediasClose;
  AllMediasOpen;
end;


procedure TMediaResults.RefreshResults;
Var
sOldSQL : String;
begin

   Screen.Cursor := crHourGlass;

   DeleteTmpTable;

   //Media
   Case pgMedia.ActivePageIndex of

   0 : begin
       AllMediasRefresh;
       AllMediaProfitRefresh;

       //Atuaiza os Totals
       edtSalesAll.Text := FormatFloat('#,##0.00', dstAllMediaProfitSale.AsCurrency);
       edtCostAll.Text  := FormatFloat('#,##0.00', dstAllMediaProfitCost.AsCurrency);
       edtTotal.Text    := FormatFloat('#,##0.00', dstAllMediaProfitProfit.AsCurrency);
       edtTax.Text      := FormatFloat('#,##0.00', dstAllMediaProfitTax.AsCurrency);
       end;

   1 : begin
       MediaRefresh;
       ProfitRefresh;
       end;


   end;

   Screen.Cursor := crDefault;
end;

function TMediaResults.ValidaField : Boolean;
begin

  Result := False;

  if not TestDate(edtDateIni.Text) then
     begin
     MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbCritical);
     edtDateIni.SetFocus;
     Exit;
     end;

  if not TestDate(edtDateFim.Text) then
     begin
     MsgBox(MSG_CRT_NO_VALID_DATE, vbOKOnly + vbCritical);
     edtDateFim.SetFocus;
     Exit;
     end;

  Case pgMedia.ActivePageIndex of

   1 : if scMedia.LookUpValue = '' then
          begin
          MsgBox(MSG_CRT_NO_MEDIA_SELECTED, vbOKOnly + vbCritical);
          scMedia.SetFocus;
          Exit;
          end;
   end;


  Result := True;

end;

procedure TMediaResults.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TMediaResults.btRefreshClick(Sender: TObject);
begin
  inherited;
  //Verificar os Fields
  If not ValidaField then
     Exit;

  //Refresh Fields
  RefreshResults;

end;

procedure TMediaResults.sbShowBarClick(Sender: TObject);
begin
  inherited;
  If Sender = sbShowBar then
     begin
     chartMediaAll.Series[0].Active := True;
     chartMediaAll.Series[1].Active := False;
     end;

  If Sender = sbShowPie then
     begin
     chartMediaAll.Series[0].Active := False;
     chartMediaAll.Series[1].Active := True;
     end;
end;

procedure TMediaResults.chartMediaAllClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  Var
  dIDMedia : Double;
begin
  inherited;
  //Chamar o Detalhe
  If sbShowBar.Down then
     begin
     pgMedia.ActivePage := tsMedia;

     with dstAllMedias do
        begin
        if not Active then
           Open;
        if Locate(Series1.XLabelsSource, Series1.XLabel[ValueIndex], [loPartialKey]) then
           dIDMedia := dstAllMediasIDMedia.AsInteger
        else
           Exit;
        end;

     scMedia.LookUpValue := FloatToStr(dIDMedia);

     RefreshResults;

     RefreshTabs;

     end;
end;

procedure TMediaResults.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1320);
end;

procedure TMediaResults.btAreaTodasClick(Sender: TObject);
begin
  inherited;

  scStore.LookUpValue := '';
  scStore.Text        := '<'+btAreaTodas.Caption+'>';

end;

procedure TMediaResults.RefreshTabs;
begin

  pnlMedia.Visible  := False;
  sbShowBar.Visible := False;
  sbShowPie.Visible := False;


  if pgMedia.ActivePageIndex = 1 then
     pnlMedia.Visible  := True
  else
     begin
     sbShowBar.Visible := True;
     sbShowPie.Visible := True;
     end;

end;

procedure TMediaResults.pgMediaChange(Sender: TObject);
begin
  inherited;

  RefreshTabs;

end;

procedure TMediaResults.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  ProfitClose;
  MediaClose;
  AllMediaProfitClose;
  AllMediasClose;
  DestroyTmpTable;

  Action := caFree; 
end;

procedure TMediaResults.dstMediaAfterOpen(DataSet: TDataSet);
begin
  inherited;

  NumInvoices := 0;
  dTotalSales := 0;

  with dstMedia do
     begin
       DisableControls;
       while not EOF do
         begin
         NumInvoices := NumInvoices + dstMediaInvoices.AsInteger;
         dTotalSales := dTotalSales + dstMediaSales.AsCurrency;
         Next;
         end;
       First;
       EnableControls;
     end;

  if dstMedia.RecordCount = 0 then
     lbResult.Caption := sAvg
  else
     lbResult.Caption := sAvarage + FormatFloat('#,##0.00', dTotalSales/NumInvoices);

end;

procedure TMediaResults.FormCreate(Sender: TObject);
begin
  inherited;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sAvg     := 'Avg';
           sAvarage := 'Average : ';
           end;

     LANG_PORTUGUESE :
           begin
           sAvg     := 'Med';
           sAvarage := 'Média : ';
           end;

     LANG_SPANISH :
           begin
           sAvg     := 'Prom';
           sAvarage := 'Promedio : ';
           end;
   end;

  CreateTmpTable;
  
end;

procedure TMediaResults.grdCategDBColumnHeaderClick(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  {
  If Sender = grdCateg then
     grdCateg.FocusedColumn := AColumn.ColIndex
  else
     grdMedia.FocusedColumn := AColumn.ColIndex;
  }
end;

procedure TMediaResults.dstAllMediasCalcFields(DataSet: TDataSet);
begin
  inherited;
  Inc(ID);
  dstAllMediasID.AsInteger := ID;
end;

procedure TMediaResults.CreateTmpTable;
begin

  with cmdInserts do
     begin
     CommandText := 'CREATE TABLE #Midias ( IDMedia int Null, Media varchar(10), Profit Money)';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'CREATE TABLE #MidiasProft ( Sale Money, Cost Money, Profit Money, Tax Money) ';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'CREATE TABLE #Midia (InvoiceDate DateTime, Sales Money, Invoices Int, AvgInvoice Money) ';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'CREATE TABLE #MidiaProfit (Category varchar(30), Sale Money, Cost Money, Profit Money)';
     Try
       Execute;
     Except
       end;
     end;

end;

procedure TMediaResults.DestroyTmpTable;
begin
  with cmdInserts do
     begin
     CommandText := 'DROP TABLE #Midias ';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'DROP TABLE #MidiasProft ';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'DROP TABLE #Midia ';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'DROP TABLE #MidiaProfit ';
     Try
       Execute;
     Except
       end;
     end;


end;

procedure TMediaResults.DeleteTmpTable;
begin
  with cmdInserts do
     begin
     CommandText := 'DELETE #Midias';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'DELETE #MidiasProft';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'DELETE #Midia';
     Try
       Execute;
     Except
       end;
     end;

  with cmdInserts do
     begin
     CommandText := 'DELETE #MidiaProfit';
     Try
       Execute;
     Except
       end;
     end;

end;

procedure TMediaResults.OpenAllMediaProfitInv;
var
  sSQL,
  sWhere,
  sField : String;
begin

  IniDate := Trunc(edtDateIni.Date);
  EndDate := Trunc(edtDateFim.Date+1);

  sWhere := 'AND I.InvoiceDate >= ' + QuotedStr(MyFormatDate(IniDate)) +
            ' AND I.InvoiceDate < ' + QuotedStr(MyFormatDate(EndDate));

  if scStore.LookUpValue <> '' then
     sWhere := sWhere + ' AND I.IDStore = ' + scStore.LookUpValue;

  sSQL := 'INSERT #MidiasProft (Sale, Cost, Profit, Tax) ' +
          'SELECT sum( InvMov.SalePrice * InvMov.Qty - InvMov.Discount ) as Sale, ' +
          'sum( InvMov.CostPrice * InvMov.Qty ) as Cost, ' +
          'sum(((InvMov.SalePrice-InvMov.CostPrice)*InvMov.Qty)-InvMov.Discount) as Profit, ' +
          '0 as Tax ' +
          'FROM dbo.InventoryMov InvMov (NOLOCK) ' +
          'JOIN dbo.Invoice I (NOLOCK) ON ( InvMov.DocumentID = I.IDInvoice) ' +
          'WHERE (InvMov.InventMovTypeID = 1) ' +
          'AND I.IDPreSaleParent IS NULL ' +
          'AND I.Canceled = 0 ' +
          sWhere;
          
  with cmdInserts do
     begin
     CommandText := sSQL;
     Try
       Execute;
     Except
       end;
     end;

end;

procedure TMediaResults.OpenAllMediaProfitPreInv;
var
  sSQL,
  sWhere : String;
begin

  sWhere := 'AND I.PreSaleDate >= ' + QuotedStr(MyFormatDate(IniDate)) +
            ' AND I.PreSaleDate < ' + QuotedStr(MyFormatDate(EndDate));

  if scStore.LookUpValue <> '' then
     sWhere := sWhere + ' AND I.IDStore = ' + scStore.LookUpValue;

  sSQL := 'INSERT #MidiasProft (Sale, Cost, Profit, Tax) ' +
          'SELECT SUM(C.ItemSaleTotal) as Sale, ' +
          'SUM(C.ItemCostTotal) as Cost, ' +
          'SUM(C.ItemSaleTotal-C.ItemCostTotal-TaxValue) as Prof, ' +
          'SUM(C.TaxValue) as Tax ' +
          'FROM vwInvoiceParents I (NOLOCK) ' +
          'JOIN vwSaleItem C (NOLOCK) ON (I.DocumentID = C.IDPreSale) ' +
          'JOIN Pessoa P (NOLOCK) ON (C.ComissionID = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa) ' +
          'WHERE (C.InventMovTypeID = 1) ' +
          'AND I.Canceled = 0 ' +
          sWhere;

  with cmdInserts do
     begin
     CommandText := sSQL;
     Try
       Execute;
     Except
       end;
     end;
end;

procedure TMediaResults.OpenMediaInv;
var
  sSQL,
  sWhere : String;
begin

  IniDate := Trunc(edtDateIni.Date);
  EndDate := Trunc(edtDateFim.Date+1);

  sWhere := 'AND I.InvoiceDate >= ' + QuotedStr(MyFormatDate(IniDate)) +
            ' AND I.InvoiceDate < ' + QuotedStr(MyFormatDate(EndDate));
  if scStore.LookUpValue <> '' then
     sWhere := sWhere + ' AND I.IDStore = ' + scStore.LookUpValue;

  if scMedia.LookUpValue <> '' then
     sWhere := sWhere + ' AND I.MediaID = ' + scMedia.LookUpValue;

  sSQL := 'INSERT #Midia (InvoiceDate, Sales, Invoices, AvgInvoice) ' +
          'SELECT Convert(DateTime, Convert(VarChar(20), InvoiceDate, 101) ) as InvoiceDate, ' +
          'SUM( I.SubTotal - I.InvoiceDiscount - I.ItemDiscount ) as Sales , ' +
          'COUNT( I.IDPreSale ) as Invoices, ' +
          'SUM(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount)/COUNT(I.IDPreSale) as AvgInvoice ' +
          'FROM Invoice I (NOLOCK) ' +
          'WHERE I.IDInvoice IS NOT NULL ' +
          'AND I.IDPreSaleParent IS NULL ' +
          'AND I.Canceled = 0 ' +
          sWhere +
          ' GROUP BY Convert(DateTime, Convert(VarChar(20), InvoiceDate, 101) ) ' +
          ' ORDER BY Convert(DateTime, Convert(VarChar(20), InvoiceDate, 101) )';

  with cmdInserts do
     begin
     CommandText := sSQL;
     Try
       Execute;
     Except
       end;
     end;

end;

procedure TMediaResults.OpenMediaPreInv;
var
  sSQL,
  sWhere : String;
begin

  IniDate := Trunc(edtDateIni.Date);
  EndDate := Trunc(edtDateFim.Date+1);

  sWhere := 'AND I.PreSaleDate >= ' + QuotedStr(MyFormatDate(IniDate)) +
            ' AND I.PreSaleDate < ' + QuotedStr(MyFormatDate(EndDate));

  if scStore.LookUpValue <> '' then
     sWhere := sWhere + ' AND I.IDStore = ' + scStore.LookUpValue;

  if scMedia.LookUpValue <> '' then
     sWhere := sWhere + ' AND I.MediaID = ' + scMedia.LookUpValue;

  sSQL := 'INSERT #Midia (InvoiceDate, Sales, Invoices, AvgInvoice) ' +
          'SELECT Convert(DateTime, Convert(VarChar(20), PreSaleDate, 101) ) as InvoiceDate, ' +
          'SUM( I.SubTotal - I.InvoiceDiscount - I.ItemDiscount ) as Sales , ' +
          'COUNT( I.IDPreSale ) as Invoices, ' +
          'SUM(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount)/COUNT(I.IDPreSale) as AvgInvoice ' +
          'FROM Invoice I (NOLOCK) ' +
          'WHERE I.IDPreSaleParent IS NULL ' +
          'AND I.Canceled = 0 ' +
          sWhere +
          ' GROUP BY Convert(DateTime, Convert(VarChar(20), PreSaleDate, 101) ) ' +
          ' ORDER BY Convert(DateTime, Convert(VarChar(20), PreSaleDate, 101) )';

  with cmdInserts do
     begin
     CommandText := sSQL;
     Try
       Execute;
     Except
       end;
     end;

end;

procedure TMediaResults.OpenMediaProfitInv;
var
  sSQL,
  sWhere : String;
begin

  IniDate := Trunc(edtDateIni.Date);
  EndDate := Trunc(edtDateFim.Date+1);

  sWhere := 'AND Invoice.InvoiceDate >= ' + QuotedStr(MyFormatDate(IniDate)) +
            ' AND Invoice.InvoiceDate < ' + QuotedStr(MyFormatDate(EndDate));
  if scStore.LookUpValue <> '' then
     sWhere := sWhere + ' AND Invoice.IDStore = ' + scStore.LookUpValue;

  if scMedia.LookUpValue <> '' then
     sWhere := sWhere + ' AND Invoice.MediaID = ' + scMedia.LookUpValue;


  sSQL := 'INSERT #MidiaProfit (Category, Sale, Cost, Profit) ' +
          'SELECT TG.Name as Category, ' +
          'SUM(InvMov.SalePrice * InvMov.Qty - InvMov.Discount) as Sale, ' +
          'SUM(InvMov.CostPrice * InvMov.Qty ) as Cost, ' +
          'SUM(((InvMov.SalePrice - InvMov.CostPrice )*InvMov.Qty)-InvMov.Discount) as Profit ' +
          'FROM dbo.InventoryMov InvMov (NOLOCK) ' +
          'JOIN dbo.Invoice Invoice (NOLOCK) ON ( InvMov.DocumentID = Invoice.IDInvoice) ' +
          'JOIN dbo.Model Model (NOLOCK) ON ( InvMov.ModelID = Model.IDModel ) ' +
          'JOIN dbo.TabGroup TG (NOLOCK) ON ( Model.GroupID = TG.IDGroup ) ' +
          'JOIN dbo.Media ME (NOLOCK) ON ( Invoice.MediaID = ME.IDMedia) ' +
          'WHERE ( InvMov.InventMovTypeID = 1 ) ' +
          'AND Invoice.IDPreSaleParent IS NULL ' +
          'AND Invoice.Canceled = 0 ' +
          sWhere +
          ' GROUP BY TG.Name ' +
          ' ORDER BY Profit DESC';

  with cmdInserts do
     begin
     CommandText := sSQL;
     Try
       Execute;
     Except
       end;
     end;

end;

procedure TMediaResults.OpenMediaProfitPreInv;
var
  sSQL,
  sWhere : String;
begin

  IniDate := Trunc(edtDateIni.Date);
  EndDate := Trunc(edtDateFim.Date+1);

  sWhere := 'AND I.PreSaleDate >= ' + QuotedStr(MyFormatDate(IniDate)) +
             ' AND I.PreSaleDate < ' + QuotedStr(MyFormatDate(EndDate));
  if scStore.LookUpValue <> '' then
     sWhere := sWhere + ' AND I.IDStore = ' + scStore.LookUpValue;

  if scMedia.LookUpValue <> '' then
     sWhere := sWhere + ' AND I.MediaID = ' + scMedia.LookUpValue;

  sSQL := 'INSERT #MidiaProfit (Category, Sale, Cost, Profit) ' +
          'SELECT TB.Name as Category, ' +
          'SUM(C.ItemSaleTotal) as Sale, ' +
          'SUM(C.ItemCostTotal) as Cost, ' +
          'SUM(C.ItemSaleTotal-C.ItemCostTotal-TaxValue) as Profit ' +
          'FROM vwInvoiceParents I (NOLOCK) ' +
          'JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia) ' +
          'JOIN vwSaleItem C (NOLOCK) ON (I.DocumentID = C.IDPreSale) ' +
          'JOIN TabGroup TB (NOLOCK) ON (C.GroupID = TB.IDGroup) ' +
          'JOIN Pessoa P ON (C.ComissionID = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa) ' +
          'WHERE C.InventMovTypeID = 1 ' +
          'AND I.Canceled = 0 ' +
          sWhere +
          ' GROUP BY TB.Name ' +
          ' ORDER BY Profit DESC';

  with cmdInserts do
     begin
     CommandText := sSQL;
     Try
       Execute;
     Except
       end;
     end;

end;

end.
