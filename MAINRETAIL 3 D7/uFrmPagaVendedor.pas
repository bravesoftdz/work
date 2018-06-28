unit uFrmPagaVendedor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, DBCtrls, DateBox, Db, DBTables, Grids,
  StdCtrls, Mask, ComCtrls, LblEffct, ExtCtrls, Buttons,
  Menus, ADODB, SuperComboADO, ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB,
  ppDBPipe, ppModule, raCodMod, ppBands, ppCache, ppPrnabl, ppCtrls,
  daDataModule, DBGrids, ppVar, siComp, siLangRT, SMDBGrid, ppEndUsr;

type
  TFrmPagaVendedor = class(TFrmParent)
    dsHistPag: TDataSource;
    quHistPag: TADOQuery;
    Panel10: TPanel;
    lblTip: TLabel;
    Label3: TLabel;
    Panel4: TPanel;
    Panel11: TPanel;
    spPayCommission: TADOStoredProc;
    Label11: TLabel;
    btPrint: TSpeedButton;
    spDelPayComiss: TADOStoredProc;
    mnuPayment: TPopupMenu;
    DeletePayment1: TMenuItem;
    quHistPagDataLancamento: TDateTimeField;
    quHistPagIDLancamento: TIntegerField;
    spHelp: TSpeedButton;
    quHistPagValorNominal: TFloatField;
    quSalesPersonCommis: TADOQuery;
    quSalesPersonCommisIDInvoice: TIntegerField;
    quSalesPersonCommisFirstName: TStringField;
    quSalesPersonCommisLastName: TStringField;
    quSalesPersonCommisInvoiceDate: TDateTimeField;
    quSalesPersonCommisMovSale: TBCDField;
    quSalesPersonCommisMovCost: TBCDField;
    quSalesPersonCommisModel: TStringField;
    quSalesPersonCommisDescription: TStringField;
    quSalesPersonCommisMovCommission: TBCDField;
    dsSalesPersonCommis: TDataSource;
    ppSalesPersonCommis: TppDBPipeline;
    quSalesPersonCommisSalesPerson: TStringField;
    Panel5: TPanel;
    Label4: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Shape1: TShape;
    Label16: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    Adjusted: TLabel;
    pnlInicio: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Panel6: TPanel;
    scPessoa: TSuperComboADO;
    editPayDate: TDateBox;
    dbInicio: TDateBox;
    dbFim: TDateBox;
    btRefresh: TSpeedButton;
    Label1: TLabel;
    editCommission: TEdit;
    Label19: TLabel;
    Label9: TLabel;
    editExtorno: TEdit;
    editCorrecao: TEdit;
    editValor: TEdit;
    rpSalesPerson: TppReport;
    ppHeaderBand2: TppHeaderBand;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppDBText16: TppDBText;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppDBCalc7: TppDBCalc;
    ppDBCalc8: TppDBCalc;
    ppDBCalc9: TppDBCalc;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppLine2: TppLine;
    ppDBText19: TppDBText;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppDBCalc10: TppDBCalc;
    ppDBCalc11: TppDBCalc;
    ppDBCalc12: TppDBCalc;
    raCodeModule1: TraCodeModule;
    daDataModule2: TdaDataModule;
    spCalcComiss: TADOStoredProc;
    quHistPagUsuario: TStringField;
    Label6: TLabel;
    Label7: TLabel;
    sbPaymentType: TSuperComboADO;
    scBanckAccount: TSuperComboADO;
    Label5: TLabel;
    Label2: TLabel;
    btPreviewCommission: TSpeedButton;
    btAddCommission: TSpeedButton;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel10: TppLabel;
    ppLine1: TppLine;
    ppLabel6: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel7: TppLabel;
    grdPayment: TSMDBGrid;
    ppDesigner: TppDesigner;
    quSPCommisAll: TADOQuery;
    quSPCommisAllIDInvoice: TIntegerField;
    quSPCommisAllFirstName: TStringField;
    quSPCommisAllLastName: TStringField;
    quSPCommisAllSalesPerson: TStringField;
    quSPCommisAllInvoiceDate: TDateTimeField;
    quSPCommisAllMovSale: TBCDField;
    quSPCommisAllMovCost: TBCDField;
    quSPCommisAllModel: TStringField;
    quSPCommisAllDescription: TStringField;
    quSPCommisAllMovCommission: TBCDField;
    quSalesPersonCommisSaleCode: TStringField;
    quSalesPersonCommisInvoiceCode: TStringField;
    quSPCommisAllSaleCode: TStringField;
    quSPCommisAllInvoiceCode: TStringField;
    quSalesPersonCommisPreSaleDate: TDateTimeField;
    quSPCommisAllPreSaleDate: TDateTimeField;
    quSalesPersonCommisDesiredMarkup: TBCDField;
    quSPCommisAllDesiredMarkup: TBCDField;
    quSPCommisAllMarkup: TBCDField;
    quSalesPersonCommisMarkup: TBCDField;
    quSPCommisAllItemNetValue: TBCDField;
    quSalesPersonCommisItemNetValue: TBCDField;
    quSPCommisAllGroupID: TIntegerField;
    quSPCommisAllService: TBooleanField;
    quSalesPersonCommisDiscount: TBCDField;
    quSPCommisAllDiscount: TBCDField;
    quSalesPersonCommisQty: TFloatField;
    quSPCommisAllQty: TFloatField;
    quSalesPersonCommisFullName: TStringField;
    quSPCommisAllFullName: TStringField;
    ppSalesPersonCommisppField21: TppField;
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbInicioChange(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure dsHistPagDataChange(Sender: TObject; Field: TField);
    procedure DeletePayment1Click(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure grdPaymentDblClick(Sender: TObject);
    procedure btAddCommissionClick(Sender: TObject);
    procedure rpSalesPersonPreviewFormCreate(Sender: TObject);
    procedure btPreviewCommissionClick(Sender: TObject);
    procedure sbPaymentTypeSelectItem(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure scPessoaSelectItem(Sender: TObject);
  private
    Extorno, Correcao, Commis, Valor: Currency;
    Inside: Boolean;
    Merda: Boolean;
    bIsOffice: Boolean;
    bCommOnPaid: Boolean;

    procedure Refresh;
    procedure SPRefreshWhere(sWhere: String);
    procedure PrintSalesPerson(iPaid: Integer);

    procedure HistPagClose;
    procedure HistPagOpen;
    procedure HistPagRefresh;
  public
    function DesignReport:Boolean;
  end;

implementation

uses uDM, XBase, uPrintComissReceipt, uMsgBox, uMsgConstant, uPassword,
     uNumericFunctions, uSqlFunctions, uDateTimeFunctions, uDMGlobal,
     uSystemConst;

{$R *.DFM}

procedure TFrmPagaVendedor.HistPagClose;
begin
  with quHistPag do
    if Active then
      Close;
end;

procedure TFrmPagaVendedor.HistPagOpen;
begin
  with quHistPag do
    if not Active then
    begin
      Parameters.ParambyName('IDPessoa').Value := StrToInt(scPessoa.LookUpValue);
      Open;
    end;
end;

procedure TFrmPagaVendedor.HistPagRefresh;
begin
  HistPagClose;
  HistPagOpen;
end;

procedure TFrmPagaVendedor.PrintSalesPerson(iPaid: Integer);
var
  i: Integer;
  sWhere, sPaidField: String;
  sWhereClause: TStringList;
begin
  sWhereClause := TStringList.Create;

  try
    if not bIsOffice then
    begin
      sWhereClause.Add(' I.IDInvoice IS NOT NULL');
      sWhereClause.Add(' I.InvoiceDate >=  ' + QuotedStr( FormatDateTime('mm/dd/yyyy', (dbInicio.Date))));
      sWhereClause.Add(' I.InvoiceDate <  ' + QuotedStr( FormatDateTime('mm/dd/yyyy', (dbFim.Date+1))));
      sPaidField := ' CP.IDLancPag ';
    end
    else
    begin
      sPaidField := ' CP.IDLancPag ';
      if iPaid = 0 then
      begin
        sWhereClause.Add(' I.PreSaleDate >=  ' + QuotedStr( FormatDateTime('mm/dd/yyyy', (dbInicio.Date))));
        sWhereClause.Add(' I.PreSaleDate <  ' + QuotedStr( FormatDateTime('mm/dd/yyyy', (dbFim.Date+1))));
      end;
    end;

    if iPaid = 0 then
      sWhereClause.Add(sPaidField+' IS NULL')
    else
      sWhereClause.Add(sPaidField+' = ' + IntToStr(iPaid));

    sWhereClause.Add(' C.ComissionID = ' + scPessoa.LookUpValue);
    sWhereClause.Add(' IsNull(I.Canceled, 0) = 0 ');

    if bIsOffice and bCommOnPaid then
      sWhereClause.Add(' IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento (NOLOCK) ) ');

    for i := 0 to sWhereClause.Count-1 do
      if i = 0 then
        sWhere := sWhereClause.Strings[i]
      else
        sWhere := sWhere + ' AND ' + sWhereClause.Strings[i];

  finally
    FreeAndNil(sWhereClause);
  end;

  SPRefreshWhere(sWhere);

  if DM.fPrintReceipt.CommissionReportPreview then
    rpSalesPerson.DeviceType := 'Screen'
  else
    rpSalesPerson.DeviceType := 'Printer';

  rpSalesPerson.PrinterSetup.Copies := DM.fPrintReceipt.CommissionReportNumCopy;

  if DM.fPrintReceipt.CommissionReportPath <> '[SYSTEM]' then
    if FileExists(DM.fPrintReceipt.CommissionReportPath) then
    begin
      rpSalesPerson.Template.FileName := DM.fPrintReceipt.CommissionReportPath;
      rpSalesPerson.Template.LoadFromFile;
    end;

  if DM.fPrintReceipt.CommissionReportPrinter <> '' then
    rpSalesPerson.PrinterSetup.PrinterName := DM.fPrintReceipt.CommissionReportPrinter;

  try
    rpSalesPerson.Print;
  except
    raise;
  end;
end;

procedure TFrmPagaVendedor.SPRefreshWhere(sWhere: String);
var
  sOldSQL: String;
begin
  with TADOQuery(dsSalesPersonCommis.DataSet) do
  begin
    Close;
    sOldSQL  := SQL.Text;
    SQL.Clear;
    SQL.Text := ChangeWhereClause(sOldSQL, sWhere, True);
    Parameters.ParamByName('IDVendedor').Value := StrToInt(scPessoa.LookUpValue);
    Open;
  end;
end;

procedure TFrmPagaVendedor.Refresh;
begin
  if Merda then
    Abort;

  // Se uma das datas for em branco aborta
  if scPessoa.LookUpValue = '' then
  begin
    MsgBox(MSG_INF_CHOOSE_NAME, vbOKOnly + vbInformation);
    scPessoa.SetFocus;
    Abort;
  end;

  Screen.Cursor := crHourGlass;

  // Refresh do Historio de Pagamentos
  HistPagRefresh;

  // Recalculo do valor da comissão
  with spCalcComiss do
  begin
    Parameters.ParambyName('@IDVendedor').Value  := StrToInt(scPessoa.LookUpValue);
    Parameters.ParambyName('@DataInicio').Value  := dbInicio.Date;
    Parameters.ParambyName('@DataFim').Value     := dbFim.Date+1;
    Parameters.ParambyName('@IsPre').Value       := bIsOffice;
    Parameters.ParambyName('@IsPaid').Value      := bCommOnPaid;

    ExecProc;

    Commis := Parameters.ParambyName('@Commission').Value;
    Extorno := Parameters.ParambyName('@Extorno').Value;
    Correcao := Parameters.ParambyName('@Correcao').Value;

    Valor := MyRound(Commis - Extorno + Correcao, 2);

    editCommission.Text := FloatToStrF(Commis, ffCurrency, 20, 2);
    editExtorno.Text := FloatToStrF(Extorno, ffCurrency, 20, 2);
    editCorrecao.Text := FloatToStrF(Correcao, ffCurrency, 20, 2);

    editValor.Text := MyFloatToStr(valor);
  end;

  btAddCommission.Enabled := Valor <> 0;
  btPreviewCommission.Enabled := Valor <> 0;

  Screen.Cursor := crDefault;
end;

procedure TFrmPagaVendedor.FormShow(Sender: TObject);
var
  Day, Month, Year: Word;
begin
  inherited;
  Merda := True;

  if DM.fSystem.SrvParam[PARAM_TREAT_HOLD_AS_INVOICE] then
  begin
    dbInicio.Date := FirstDateMonth;
    dbFim.Date    := LastDateMonth;
  end
  else
  begin
    DecodeDate(Date, Year, Month, Day);
    editPayDate.Date := Date;
    dbFim.Date := EncodeDate(Year, Month, 1) - 1;

    if Month = 1 then
    begin
      Month := 12;
      Year := Year - 1;
    end
    else
    begin
      Month := Month -1;
    end;

    dbInicio.Date := EncodeDate(Year, Month, 1);
  end;

  Merda := False;
  scPessoa.SetFocus;

  sbPaymentType.LookUpValue  := '1';
  scBanckAccount.LookUpValue := IntToStr(DM.GetContaCorrente(MyStrToInt('1'), DM.fStore.ID));

  //Funcao para nao ver commissoes de outros funcionarios
  if not Password.HasFuncRight(50) then
  begin
    scPessoa.LookUpValue    := IntToStr(DM.fUser.IDCommission);
    scPessoa.Enabled        := False;
    btAddCommission.Visible := False;
    dbInicio.SetFocus;
  end;

  bIsOffice := not DM.fSystem.SrvParam[PARAM_CALC_COMMISSION_ON_INVOICE];
  bCommOnPaid := DM.fSystem.SrvParam[PARAM_CALC_COMM_ON_PAID_HOLD];

  if bIsOffice then
    dsSalesPersonCommis.DataSet := quSPCommisAll
  else
    dsSalesPersonCommis.DataSet := quSalesPersonCommis;
end;

procedure TFrmPagaVendedor.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPagaVendedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  scPessoa.SpcWhereClause := '';
  HistPagClose;
  Action := caFree;
end;

procedure TFrmPagaVendedor.dbInicioChange(Sender: TObject);
begin
  inherited;
  if TestDate(dbInicio.Text) then
  begin
    //#Rod - Trunc
    spCalcComiss.Parameters.ParambyName('@DataInicio').Value := Int(dbInicio.Date);
  end;

  if TestDate(dbFim.Text) then
  begin
    spCalcComiss.Parameters.ParambyName('@DataFim').Value := Int(dbFim.Date) + 1;
  end;
end;

procedure TFrmPagaVendedor.btPrintClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_CONFIRM_REPRINT, vbYesNo + vbQuestion) = vbNo then
    Exit;

  // Imprime recibo
  with TPrintComissReceipt.Create(Self) do
    Start(quHistPagIDLancamento.AsInteger, COMIS_SALESPRSON, True);
end;

procedure TFrmPagaVendedor.dsHistPagDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btPrint.Enabled := not (quHistPag.EOF and quHistPag.BOF);
end;

procedure TFrmPagaVendedor.DeletePayment1Click(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes then
  begin
    with spDelPayComiss do
    begin
      Parameters.ParambyName('@IDVendedor').Value      := StrToInt(scPessoa.LookUpValue);
      Parameters.ParambyName('@IDLancamento').Value    := quHistPagIDLancamento.AsInteger;
      ExecProc;
    end;

    Refresh;
  end;
end;

procedure TFrmPagaVendedor.btRefreshClick(Sender: TObject);
begin
  inherited;
  if TestDate(dbFim.Text) or TestDate(dbInicio.Text) then
    Refresh;
end;

procedure TFrmPagaVendedor.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1880);
end;

procedure TFrmPagaVendedor.grdPaymentDblClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  with quHistPag do
    if not (EOF and BOF) then
      PrintSalesPerson(quHistPagIDLancamento.AsInteger);

  Screen.Cursor := crDefault;
end;

procedure TFrmPagaVendedor.btAddCommissionClick(Sender: TObject);
var
  MyValor: Double;
  iIDLanc: integer;
begin
  inherited;
  MyValor := MyStrToFloat(editValor.text);

  if MyRound(MyValor, 2) = 0 then
  begin
    MsgBox(MSG_INF_NOT_EMPTY_VALUES, vbOKOnly + vbInformation);
    Exit;
  end;

  if sbPaymentType.LookUpValue = '' then
  begin
    MsgBox(MSG_INF_CHOOSE_PAYTYPE, vbOKOnly + vbInformation);
    sbPaymentType.SetFocus;
    Exit;
  end;

  if scBanckAccount.LookUpValue = '' then
  begin
    MsgBox(MSG_INF_CHOOSE_BANK, vbOKOnly + vbInformation);
    scBanckAccount.SetFocus;
    Exit;
  end;

  if editPayDate.Text = '' then
  begin
    MsgBox(MSG_CRT_NO_DATE, vbOKOnly + vbInformation);
    editPayDate.SetFocus;
    Exit;
  end;

  if MsgBox(MSG_QST_CONFIRM_PAYMENT, vbYesNo + vbQuestion) = vbNo then
    Exit;

  with spPayCommission do
  begin
    Parameters.ParambyName('@IDVendedor').Value        := StrToInt(scPessoa.LookUpValue);
    Parameters.ParambyName('@IDStore').Value           := DM.fStore.ID;
    Parameters.ParambyName('@IDMeioPag').Value         := MyStrToInt(sbPaymentType.LookUpValue);
    Parameters.ParambyName('@IDContaCorrente').Value   := MyStrToInt(scBanckAccount.LookUpValue);
    Parameters.ParambyName('@PayDate').Value           := editPayDate.Date;
    Parameters.ParambyName('@Commission').Value        := MyValor;
    Parameters.ParambyName('@DataIni').Value           := spCalcComiss.Parameters.ParambyName('@DataInicio').Value;
    Parameters.ParambyName('@DataFim').Value           := spCalcComiss.Parameters.ParambyName('@DataFim').Value;
    Parameters.ParambyName('@IDUser').Value            := DM.fUser.ID;
    Parameters.ParambyName('@IsPre').Value             := bIsOffice;
    Parameters.ParambyName('@IsPaid').Value            := bCommOnPaid;
    ExecProc;
  end;

  MsgBox(MSG_INF_PART1_COMMISS_PAIED + editValor.text + MSG_INF_PART2_COMMISS_PAIED, vbOKOnly + vbInformation);

  Refresh;

  // Imprime recibo
  if MsgBox(MSG_QST_CONFIRM_PRINT_RECEIPET, vbYesNo + vbQuestion) = vbYes then
    with TPrintComissReceipt.Create(Self) do
      Start(spPayCommission.Parameters.ParambyName('@IDLancamento').Value, COMIS_SALESPRSON, False);
end;

procedure TFrmPagaVendedor.rpSalesPersonPreviewFormCreate(Sender: TObject);
begin
  inherited;
  rpSalesPerson.PreviewForm.WindowState := WSMAXIMIZED;
end;

procedure TFrmPagaVendedor.btPreviewCommissionClick(Sender: TObject);
begin
  inherited;
  PrintSalesPerson(0);
end;

procedure TFrmPagaVendedor.sbPaymentTypeSelectItem(Sender: TObject);
begin
  inherited;
  if sbPaymentType.LookUpValue <> '' then
    scBanckAccount.LookUpValue := IntToStr(DM.GetContaCorrente(MyStrToInt(sbPaymentType.LookUpValue), DM.fStore.ID));
end;

procedure TFrmPagaVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  if fIsRestricForm then
  begin
    btAddCommission.Visible := False;
    DeletePayment1.Enabled  := False;
  end;
end;

function TFrmPagaVendedor.DesignReport: Boolean;
begin
  Result := True;
  try
    ppDesigner.ShowModal;
  except
    Result := False;
  end;
end;

procedure TFrmPagaVendedor.scPessoaSelectItem(Sender: TObject);
var
  i, j: Integer;
  sStores,
  sUser: TStringList;
  CanView: Boolean;
begin
  inherited;
  //Ver comissoes de outras lojas
  if (not Password.HasFuncRight(51)) then
  begin
    if (scPessoa.LookUpValue = '') then
      Exit;

    try
      sStores := TStringList.Create;
      sUser   := TStringList.Create;
      CanView := False;

      with DM.quFreeSQL do
      begin
        if Active then
          Close;

        SQL.Clear;
        SQL.Add('Select StoresAccess From SystemUser (NOLOCK) Where ComissionID = ' + scPessoa.LookUpValue);
        Open;
        sStores.CommaText := Fields[0].AsString;
        Close;
      end;

      sUser.CommaText := DM.fStore.StoreList;
      sStores.Sort;

      for i:=0 to sUser.Count-1 do
        if sStores.Find(sUser.Strings[i], j) then
        begin
          CanView := True;
          Break;
        end;
    finally
      FreeAndNil(sStores);
      FreeAndNil(sUser);
    end;

    if not CanView then
    begin
      scPessoa.LookUpValue := '';
      scPessoa.Text := '';
      MsgBox(MSG_CRT_OTHER_COMMISS_NOT_ALLOW, vbOKOnly + vbCritical);
    end;
  end;
end;

end.
