unit uBrwInvoice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, 
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, RadioButtonAll, siComp,
  siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwInvoice = class(TbrwParent)
    btViewInvoice: TSpeedButton;
    quBrowseIDInvoice: TIntegerField;
    quBrowseTipTouristGroup: TStringField;
    quBrowseInvoiceDate: TDateTimeField;
    quBrowseIDPreSale: TIntegerField;
    quBrowseTotalInvoice: TFloatField;
    quBrowseSubTotal: TFloatField;
    quBrowseTax: TFloatField;
    quBrowseIDAgency: TIntegerField;
    quBrowseIDGuide: TIntegerField;
    Panel4: TPanel;
    Label5: TLabel;
    scMedia: TSuperComboADO;
    Panel5: TPanel;
    scGuide: TSuperComboADO;
    Label4: TLabel;
    btUnpay: TSpeedButton;
    spUnpay: TADOStoredProc;
    quBrowseFirstName: TStringField;
    quBrowseLastName: TStringField;
    dsLaywayPayments: TDataSource;
    quLayawayPayments: TADOQuery;
    quLayawayPaymentsIDPreSale: TIntegerField;
    quLayawayPaymentsFirstName: TStringField;
    quLayawayPaymentsLastName: TStringField;
    quLayawayPaymentsAmountPaid: TFloatField;
    quLayawayPaymentsIDInvoice: TIntegerField;
    quBrowseLayaway: TBooleanField;
    quBrowseMediaID: TIntegerField;
    quLayawayPaymentsLayawayTotal: TCurrencyField;
    pnlLayaway: TPanel;
    lbLayway: TLabel;
    quLayawayPaid: TADOQuery;
    quLayawayPaidAmountPaid: TBCDField;
    quLayawayPaymentsDataLancamento: TDateTimeField;
    btAreaTodas: TButton;
    Button1: TButton;
    Label3: TLabel;
    cmbStore: TSuperComboADO;
    Button2: TButton;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    grdBrowseDBIDInvoice: TcxGridDBColumn;
    grdBrowseDBFirstName: TcxGridDBColumn;
    grdBrowseDBLastName: TcxGridDBColumn;
    grdBrowseDBTipTouristGroup: TcxGridDBColumn;
    grdBrowseDBInvoiceDate: TcxGridDBColumn;
    grdBrowseDBIDPreSale: TcxGridDBColumn;
    grdBrowseDBTotalInvoice: TcxGridDBColumn;
    grdBrowseDBSubTotal: TcxGridDBColumn;
    grdBrowseDBTax: TcxGridDBColumn;
    grdBrowseDBIDAgency: TcxGridDBColumn;
    grdBrowseDBIDGuide: TcxGridDBColumn;
    grdBrowseDBLayaway: TcxGridDBColumn;
    grdBrowseDBMediaID: TcxGridDBColumn;
    gridLayaway: TcxGrid;
    gridLayawayDB: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    gridLayawayDBIDPreSale: TcxGridDBColumn;
    gridLayawayDBIDInvoice: TcxGridDBColumn;
    gridLayawayDBDataLancamento: TcxGridDBColumn;
    gridLayawayDBAmountPaid: TcxGridDBColumn;
    gridLayawayDBLayawayTotal: TcxGridDBColumn;
    quBrowseAditionalExpenses: TBCDField;
    grdBrowseDBAditionalExpenses: TcxGridDBColumn;
    quLayawayPaymentsIDLancamento: TIntegerField;
    chkInvCalceled: TCheckBox;
    sbHistory: TSpeedButton;
    Label1: TLabel;
    cbmDocs: TComboBox;
    edtDocs: TEdit;
    Label2: TLabel;
    cbmName: TComboBox;
    edtNames: TEdit;
    quLayawayPaymentsSaleCode: TStringField;
    quLayawayPaymentsInvoiceCode: TStringField;
    gridLayawayDBSaleCode: TcxGridDBColumn;
    gridLayawayDBInvoiceCode: TcxGridDBColumn;
    quBrowseSaleCode: TStringField;
    quBrowseInvoiceCode: TStringField;
    grdBrowseDBSaleCode: TcxGridDBColumn;
    grdBrowseDBInvoiceCode: TcxGridDBColumn;
    quBrowseCanceled: TBooleanField;
    btnInvTax: TSpeedButton;
    Panel6: TPanel;
    quBrowseCustomer: TStringField;
    quBrowseTotalParent: TBCDField;
    quBrowseSubTotalParent: TBCDField;
    grdBrowseDBCustomer: TcxGridDBColumn;
    quBrowseParentTotal: TCurrencyField;
    grdBrowseDBParentTotal: TcxGridDBColumn;
    quStoreAccPaid: TADOQuery;
    quStoreAccPaidAmountPaid: TBCDField;
    pnlServiceOrder: TPanel;
    lbServiceOrder: TLabel;
    grdServiceOrder: TcxGrid;
    cxServiceOrderView: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    quSOPayments: TADOQuery;
    dsSOPayments: TDataSource;
    quSOPaymentsIDLancamento: TIntegerField;
    quSOPaymentsDataLancamento: TDateTimeField;
    quSOPaymentsAmountPaid: TBCDField;
    quSOPaymentsIDServiceOrder: TIntegerField;
    quSOPaymentsCustomer: TStringField;
    quSOPaymentsSONumber: TStringField;
    quSOPaymentsSODate: TDateTimeField;
    quSOPaymentsSOCloseDate: TDateTimeField;
    cxServiceOrderViewDataLancamento: TcxGridDBColumn;
    cxServiceOrderViewAmountPaid: TcxGridDBColumn;
    cxServiceOrderViewCustomer: TcxGridDBColumn;
    cxServiceOrderViewSONumber: TcxGridDBColumn;
    pnlTotal: TPanel;
    lbTotalAll: TLabel;
    lbLayawaypaid: TLabel;
    lbLPaid: TLabel;
    lbGrandTotal: TLabel;
    lbStoreAccount: TLabel;
    lbStoreAccPaid: TLabel;
    lbSOTotal: TLabel;
    lbSOValue: TLabel;
    gridLayawayDBCustomer: TcxGridDBColumn;
    quLayawayPaymentsCustomer: TStringField;
    procedure btViewInvoiceClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btUnpayClick(Sender: TObject);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure btnExecClick(Sender: TObject);
    procedure scGuideAfterAddUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure quLayawayPaymentsCalcFields(DataSet: TDataSet);
    procedure quBrowseBeforeClose(DataSet: TDataSet);
    procedure btAreaTodasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cmbStoreSelectItem(Sender: TObject);
    procedure grdBrowseDblClick(Sender: TObject);
    procedure gridLayawayDBDblClick(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
    procedure chkInvCalceledClick(Sender: TObject);
    procedure sbHistoryClick(Sender: TObject);
    procedure btnInvTaxClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    sOriginalSQL   : String;
    fTotalInvoice  : Currency;
    bLayawayShow   : Boolean;
    FStoreAccTotal : Currency;
    FTotalLayaway  : Currency;
    fServiceOrderTotal : Currency;

    procedure RefreshGridFooter;
    procedure RefreshGridFooterLayaway;
    procedure RefreshGridSOFooter;

    //LayawayPayments
    procedure LayawayPaymentsClose;
    procedure LayawayPaymentsOpen;

    //LayawayPaid
    procedure LayawayPaidClose;
    procedure LayawayPaidOpen;

    //StoreAccountPaid
    procedure StoreAccPaidClose;
    procedure StoreAccPaidOpen;

    //StoreAccountPaid
    procedure SOPaymentClose;
    procedure SOPaymentOpen;

    //refresh Brwoser
    procedure RefreshBrowser;
  public
    function StartCashRegMov : Boolean;
  end;

implementation

{$R *.DFM}

uses uFrmStore, uDM, uInvoice, uMsgBox, uPassword, XBase, uSqlFunctions,
     uMsgConstant, uDateTimeFunctions, uDMGlobal, uSystemConst, uFrmHistoryManage,
     uFrmSaleItemTax, uStringFunctions, PaiDeTodos;


procedure TbrwInvoice.StoreAccPaidClose;
begin
  with quStoreAccPaid do
     if Active then
        Close;
end;

procedure TbrwInvoice.StoreAccPaidOpen;
begin

  with quStoreAccPaid do
     if not Active then
     begin
       Parameters.ParamByName('IDCashRegMov').Value := StrToIntDef(Copy(aWhereBasicFilters[1], 15, 20), 0);
       Open;
     end;
end;


procedure TbrwInvoice.LayawayPaidClose;
begin
  with quLayawayPaid do
     if Active then
        Close;
end;

procedure TbrwInvoice.LayawayPaidOpen;
var
   sWhere : String;
begin

   with quLayawayPaid do
     if not Active then
        begin
        sWhere := ' I.Layaway = 1 ' +
                  ' AND (L.IDCashRegMov <> :IDCashReg1) ' +
                  ' AND L.IDPreSale in (SELECT IDPreSale FROM Invoice WHERE CashRegMovID = :IDCashReg2)';
        if cmbStore.LookUpValue <> '' then
           sWhere := sWhere + 'AND I.IDStore = ' + cmbStore.LookUpValue
        else
           sWhere := sWhere + 'AND I.IDStore IN ('+ DM.fStore.StoreList +') ';

        SQL.Text := ChangeWhereClause(SQL.Text, sWhere, True);
        Parameters.ParamByName('IDCashReg1').Value := StrToInt(Copy(aWhereBasicFilters[1], 15,20));
        Parameters.ParamByName('IDCashReg2').Value := StrToInt(Copy(aWhereBasicFilters[1], 15,20));
        Open;
        end;
end;

procedure TbrwInvoice.LayawayPaymentsClose;
begin
   with quLayawayPayments do
      if Active then
         Close;
end;

procedure TbrwInvoice.LayawayPaymentsOpen;
var
   sWhere : String;
begin
  with quLayawayPayments do
     if not Active then
        begin
        sWhere := ' I.Layaway = 1 ' +
                  ' AND L.DataLancamento >= :IniDate ' +
                  ' AND L.DataLancamento < :FimDate ';
        if cmbStore.LookUpValue <> '' then
           sWhere := sWhere + 'AND I.IDStore = ' + cmbStore.LookUpValue
        else
           sWhere := sWhere + 'AND I.IDStore IN ('+ DM.fStore.StoreList +') ';

        SQL.Text := ChangeWhereClause(SQL.Text, sWhere, True);
        Parameters.ParamByName('IniDate').Value := Int(DateInicio.Date);
        Parameters.ParamByName('FimDate').Value := (Int(DateFim.Date)+1);
        Open;
        end;
end;

procedure TbrwInvoice.btViewInvoiceClick(Sender: TObject);
var
  sMenuName: String;
begin
  inherited;

  Screen.Cursor := crHourGlass;

  // Abre tela do Invoice
  with TFrmInvoice.Create(Self) do
    try
      sMenuName := DM.fMainMenu.MenuName;
      DM.fMainMenu.MenuName := DM.fMainMenu.MenuName + ' - ' + lblSubMenu.Caption;
      if not chkInvCalceled.Checked then
         Start(quBrowseIDPreSale.AsInteger, SALE_INVOICE, 0, False)
      else
         Start(quBrowseIDPreSale.AsInteger, SALE_CANCELED, 0, False);
    finally
      DM.fMainMenu.MenuName := sMenuName;
    end;
  Screen.Cursor := crDefault;

end;


procedure TbrwInvoice.FormShow(Sender: TObject);
begin
  inherited;

  FStoreAccTotal := 0;
  FTotalLayaway := 0;

  if aWhereBasicFilters[1] = '' then
    begin
     DateInicio.Date := Date;
     DateFim.Date := Date;
     pnlBasicFilter.Visible := True;

     //Show Layway - CashReg
     bLayawayShow := DM.fSystem.SrvParam[PARAM_SHOW_LAYAWAY_CR_HIST];
     pnlLayaway.Visible := (bLayawayShow);
    end
  else
    begin
     pnlBasicFilter.Visible := False;
     RefreshBrowser;
     //ExecBrowseSQL(True);

     //Exib Layaway
     bLayawayShow       := DM.fSystem.SrvParam[PARAM_SHOW_LAYAWAY_INVOICE_HIST];
     pnlLayaway.Visible := (bLayawayShow);

     SOPaymentOpen;

     If bLayawayShow then
        begin
        //Layaway parcelas
        With quLayawayPayments do
           begin
           SQL.Clear;
           SQL.Add('SELECT L.IDLancamento, I.IDPreSale , L.DataLancamento, P.Pessoa as Customer, I.FirstName, I.LastName,');
           SQL.Add('L.ValorNominal AmountPaid, I.IDInvoice, I.SaleCode, I.InvoiceCode');
           SQL.Add('FROM Invoice I (NOLOCK)');
           SQL.Add('JOIN Fin_Lancamento L (NOLOCK) ON ( L.IDPreSale = I.IDPreSale )');
           SQL.Add('JOIN Pessoa P (NOLOCK) ON (I.IDCustomer = P.IDPessoa)');
           SQL.Add('WHERE (I.Layaway = 1)');
           SQL.Add('AND (I.IDStore = ' + IntToStr(DM.fStore.ID)+ ')');
           If Copy(aWhereBasicFilters[1], 1,16) = 'I.IDTouristGroup' then
              SQL.Add('AND ('+(aWhereBasicFilters[1])+')')
           else
              SQL.Add('AND (L.IDCashRegMov = '+Copy(aWhereBasicFilters[1], 15,20)+')');
           Open;
           end;

        //Show Layaway Paid
        If (Copy(aWhereBasicFilters[1], 1,12) = 'CashRegMovID') then
           begin
           LayawayPaidOpen;
           StoreAccPaidOpen;

           FTotalLayaway := quLayawayPaidAmountPaid.AsCurrency;
           lbLayawaypaid.Caption := FormatFloat('#,###,##0.00', FTotalLayaway);
           FStoreAccTotal := quStoreAccPaidAmountPaid.AsCurrency;
           lbStoreAccPaid.Caption := FormatFloat('#,###,##0.00', FStoreAccTotal);
           end;

        end;
    end;

  pnlLayaway.Visible := (not quLayawayPayments.IsEmpty);

  pnlTotal.Visible := (not quLayawayPayments.IsEmpty) or
                      (FStoreAccTotal <> 0) or
                      (not quSOPayments.IsEmpty);

  // define quem pode e quem não pode ver os totais
  pnlPage.Visible := Password.HasFuncRight(34);
  pnlTotal.Visible := Password.HasFuncRight(34);

  grdBrowse.SetFocus;

  //Refresh Total - Verifica so o User poder ver os totail
  If Password.HasFuncRight(34) then
     If pnlBasicFilter.Visible = False then
        begin
        RefreshGridFooter;
        If bLayawayShow then
           RefreshGridFooterLayaway;
        RefreshGridSOFooter;
        end;

  //Desable BtnAdd
  btAdd.Visible := False;
  btRemove.Visible := False;

  StoreAccPaidClose;
  LayawayPaidClose;

end;

procedure TbrwInvoice.btUnpayClick(Sender: TObject);
var
 L: String;
begin
  inherited;
  if MsgBox(MSG_QST_SURE, vbQuestion + vbYesNo) = vbYes then
    begin
      try

        with spUnpay do
          begin
            Parameters.ParamByName('@IDInvoice').Value := quBrowseIDInvoice.AsInteger;
            //Parameters.ParamByName('@IDPreSale').Value := quBrowseIDPreSale.AsInteger;
            ExecProc;
          end;
        with quBrowse do
          begin
            DisableControls;
            Next;
            L := quBrowseIDInvoice.AsString;
            Close;
            Open;
            Locate('IDInvoice', L, []);
            EnableControls;
          end;
      except
        MsgBox(MSG_CRT_NO_INVOICE_UNPAY, vbCritical + vbOkOnly);
      end;
    end;

end;

procedure TbrwInvoice.RefreshGridFooter;
var
  TotSubTotal, TotTax, TotInvoice, TotInv : Currency;
begin
  // Mostra o total do periodo do Invoice
  TotSubTotal := 0;
  TotTax      := 0;
  TotInvoice  := 0;
  with quBrowse do
    begin
      DisableControls;
      First;
      while not Eof do
        begin
          TotSubTotal := TotSubTotal + quBrowseSubTotal.AsCurrency;
          TotTax      := TotTax + quBrowseTax. AsCurrency;
          TotInv      := TotInv + quBrowseTotalInvoice.AsCurrency;

          //If the Layway is an invoice, it does not count on the total!!!
          //because the layaway total will count it
          If (quBrowseIDInvoice.AsString <> '') and
             (quBrowseLayaway.AsBoolean = False)  then
             TotInvoice  := TotInvoice + quBrowseTotalInvoice.AsCurrency;

          Next;
        end;
      First;
      EnableControls;
    end;
  fTotalInvoice := TotInvoice;

end;

procedure TbrwInvoice.RefreshGridFooterLayaway;
var
  TotSubTotal : Currency;
begin
  // Mostra o total do periodo do Layaway
  TotSubTotal   := 0;
  with quLayawayPayments do
    begin
      DisableControls;
      First;
      while not Eof do
        begin
          TotSubTotal := TotSubTotal + quLayawayPaymentsAmountPaid.AsCurrency;
          //FTotalLayaway := FTotalLayaway + quLayawayPaymentsAmountPaid.AsCurrency;
          Next;
        end;
      First;
      EnableControls;
    end;

  FTotalLayaway := (TotSubTotal - FTotalLayaway) + FTotalLayaway;

  lbTotalAll.Caption := FormatFloat('#,###,##0.00', fTotalInvoice + FTotalLayaway + FStoreAccTotal + fServiceOrderTotal);
end;

procedure TbrwInvoice.RefreshGridSOFooter;
begin
  fServiceOrderTotal := 0;
  with quSOPayments do
    begin
      DisableControls;
      First;
      while not Eof do
        begin
          fServiceOrderTotal := fServiceOrderTotal + quSOPaymentsAmountPaid.AsCurrency;
          Next;
        end;
      First;
      EnableControls;
    end;

  lbSOValue.Caption  := FormatFloat('#,###,##0.00', fServiceOrderTotal);
  lbTotalAll.Caption := FormatFloat('#,###,##0.00', fTotalInvoice + FStoreAccTotal + FTotalLayaway + fServiceOrderTotal);
end;

procedure TbrwInvoice.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  If Password.HasFuncRight(34) then
     RefreshGridFooter;
end;

procedure TbrwInvoice.btnExecClick(Sender: TObject);
var
 sField, sField1 : String;
begin
  inherited;

  if TestDate(DateInicio.Text) and TestDate(DateFim.Text) then
    begin
     aWhereBasicFilters[0] := 'InvoiceDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                               'InvoiceDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);
    end
  else
    begin
      MsgBox(MSG_CRT_NO_VALID_DATE, vbCritical + vbOkOnly);
      Exit;
    end;

  if scMedia.LookUpValue <> '' then
    aWhereBasicFilters[2] := 'MediaID = ' + scMedia.LookUpValue
  else
    aWhereBasicFilters[2] := '';

  if scGuide.LookUpValue <> '' then
    aWhereBasicFilters[3] := 'IDGuide = ' + scGuide.LookUpValue
  else
    aWhereBasicFilters[3] := '';

  // filtro por Store
  if cmbStore.LookUpValue <> '' then
    aWhereBasicFilters[4] := 'I.IDStore = ' + cmbStore.LookUpValue
  else
    aWhereBasicFilters[4] := 'I.IDStore IN ('+ DM.fStore.StoreList +')';

  //Show Canceled
  if chkInvCalceled.Checked then
     begin
     aWhereBasicFilters[0] := 'PreSaleDate >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                              'PreSaleDate < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);
     aWhereBasicFilters[5] := 'I.Canceled = 1';
     end
  else
     aWhereBasicFilters[5] := 'IsNull(I.Canceled,0) = 0';

  //Customer Options
   Case cbmName.ItemIndex of
      0 : sField := '';
      1 : sField := 'FirstName';
      2 : sField := 'LastName';
      3 : sField := 'Pessoa';
   end;


   Case cbmDocs.ItemIndex of
      0 : sField1 := '';
      1 : sField1 := 'DriverLicense';
      2 : sField1 := 'SocialSecurity';
      3 : sField1 := 'CustomerCard';
      4 : sField1 := 'CPF';
   end;

  case cbmName.ItemIndex of
    0: //Todos
      aWhereBasicFilters[6] := '';
    else //Add like
      aWhereBasicFilters[6] := sField+ ' Like ' + QuotedStr('%' + trim(edtNames.Text) + '%');
  end;

  case cbmDocs.ItemIndex of
    0: //Todos
      aWhereBasicFilters[7] := '';
    else //Add like
      aWhereBasicFilters[7] := sField1+ ' Like ' + QuotedStr('%' + trim(edtDocs.Text) + '%');
  end;

  RefreshBrowser;

  //Desliga o pisca do pnlGo!
  DesativaAviso;

  if chkInvCalceled.Checked then
     Exit;

  //Show the Layawys Payments
  LayawayPaymentsOpen;
  SOPaymentOpen;

  pnlLayaway.Visible := (not quLayawayPayments.IsEmpty);

  //Rodrigo - Exibir totais
  If Password.HasFuncRight(34) then
     begin
     RefreshGridFooter;
     If bLayawayShow then
        RefreshGridFooterLayaway;
     RefreshGridSOFooter;
     end
  else
     lbTotalAll.Visible := False;

end;

procedure TbrwInvoice.scGuideAfterAddUpdate(Sender: TObject);
begin
  inherited;
  //Ativa o pisca do pnlGo
  AtivaAviso;
end;

procedure TbrwInvoice.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_F3 : begin //Edit
            if btViewInvoice.Enabled then
               btViewInvoiceClick(btDetail);
            end;
  end;

end;

procedure TbrwInvoice.quLayawayPaymentsCalcFields(DataSet: TDataSet);
begin
  inherited;

  //Sum only the layaway that is opened.
  if quLayawayPaymentsIDInvoice.AsInteger = 0 then
     quLayawayPaymentsLayawayTotal.AsCurrency := quLayawayPaymentsLayawayTotal.AsCurrency + quLayawayPaymentsAmountPaid.AsCurrency;

end;

procedure TbrwInvoice.quBrowseBeforeClose(DataSet: TDataSet);
begin
  inherited;

  LayawayPaymentsClose;
  SOPaymentClose;

end;

procedure TbrwInvoice.btAreaTodasClick(Sender: TObject);
begin
  inherited;

  scGuide.LookUpValue := '';
  scGuide.Text        := '<'+btAreaTodas.Caption+'>';

  AtivaAviso;

end;

procedure TbrwInvoice.Button1Click(Sender: TObject);
begin
  inherited;

  scMedia.LookUpValue := '';
  scMedia.Text        := '<'+Button1.Caption+'>';

  AtivaAviso;

end;

procedure TbrwInvoice.DateInicioChange(Sender: TObject);
begin
  inherited;

  //Ativa o pisca do BtnGo!!!
  if not BrowseConfig.AutoOpen then
     AtivaAviso;

end;

procedure TbrwInvoice.FormCreate(Sender: TObject);
begin
  inherited;

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  cmbStore.LookUpValue := intToStr(DM.fStore.ID);

  DM.imgBTN.GetBitmap(BTN_HISTORY, sbHistory.Glyph);

  sOriginalSQL := quBrowse.CommandText;

end;

procedure TbrwInvoice.Button2Click(Sender: TObject);
begin
  inherited;

  cmbStore.LookUpValue := '';
  cmbStore.Text        := '<'+Button2.Caption+'>';

  AtivaAviso;

end;

procedure TbrwInvoice.cmbStoreSelectItem(Sender: TObject);
begin
  inherited;

  AtivaAviso;

end;

procedure TbrwInvoice.grdBrowseDblClick(Sender: TObject);
begin
  inherited;
  btViewInvoiceClick(Self);
end;

procedure TbrwInvoice.gridLayawayDBDblClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor := crHourGlass;

  // Abre tela do Invoice
  with TFrmInvoice.Create(Self) do
       Start(quLayawayPaymentsIDPreSale.AsInteger, SALE_INVOICE, 0, False);

  Screen.Cursor := crDefault;

end;

procedure TbrwInvoice.grdBrowseDBDblClick(Sender: TObject);
begin

  Screen.Cursor := crHourGlass;

  if btViewInvoice.Enabled then
     btViewInvoiceClick(btDetail);

  Screen.Cursor := crDefault;

end;

procedure TbrwInvoice.chkInvCalceledClick(Sender: TObject);
begin
  inherited;

  //Ativa o pisca do BtnGo!!!
  if not BrowseConfig.AutoOpen then
     AtivaAviso;
  
end;

procedure TbrwInvoice.sbHistoryClick(Sender: TObject);
begin
  inherited;

  if (not quBrowse.Active) and quBrowseIDPreSale.IsNull then
     Exit;

  with TFrmHistoryManage.Create(Self) do
     Start(quBrowseIDPreSale.AsInteger);
end;

procedure TbrwInvoice.btnInvTaxClick(Sender: TObject);
begin
  inherited;
  with TFrmSaleItemTax.Create(Self) do
      Start; 
end;

procedure TbrwInvoice.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;
  if chkInvCalceled.Checked then
     quBrowseParentTotal.AsCurrency := quBrowseTotalInvoice.AsCurrency
  else
     quBrowseParentTotal.AsCurrency := (quBrowseTotalInvoice.AsCurrency-
                                       quBrowseTotalParent.AsCurrency);
end;

procedure TbrwInvoice.RefreshBrowser;
var
 i: integer;
 sWhereClause : String;
begin
  try
    Screen.Cursor := crHourGlass;

   with quBrowse do
     begin
     DisableControls;
     if Active then
        Close;

    for i := Low(aWhereBasicFilters) to High(aWhereBasicFilters) do
      if aWhereBasicFilters[i] <> '' then
         sWhereClause := ChangeWhereClause(sWhereClause, aWhereBasicFilters[i], False);

     Commandtext := Replace(sOriginalSQL, '#Main_Where#', sWhereClause);


     Open;
     EnableControls;
     end;
  finally
    Screen.Cursor := crDefault;
    end;

end;

procedure TbrwInvoice.SOPaymentClose;
begin
  with quSOPayments do
     if Active then
        Close;
end;

procedure TbrwInvoice.SOPaymentOpen;
begin

  with quSOPayments do
    if not Active then
    begin
     Parameters.ParamByName('IDCashRegMov').Value := StrToIntDef(Copy(aWhereBasicFilters[1], 15, 20), 0);
     Open;
    end;

  pnlServiceOrder.Visible := (not quSOPayments.IsEmpty);

end;

function TbrwInvoice.StartCashRegMov: Boolean;
var
  AOptions: TcxGridStorageOptions;
  ASaveViewName, fRegistryPath : String;
begin

  //Grid options
  fRegistryPath := MR_BRW_REG_PATH + lblSubMenu.Caption + 'BrwCashMov';
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  ShowModal;

  //Saval para o registry
  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);

end;

end.
