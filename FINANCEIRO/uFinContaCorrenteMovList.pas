unit uFinContaCorrenteMovList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, BrowseConfig, Db, Menus, DBTables, Grids,
  Buttons, Mask, dxBar, uParentList, dxDBGridPrint, dxBarExtItems, dxCntner,
  dxTL, dxDBGrid, dxGrClms, dxDateEdit, ImgList, dxDBCGrid, dxDBCtrl,
  dxDBTLCl, ADODB, PowerADOQuery, SuperComboADO, dxEditor, dxExEdtr,
  dxEdLib, DBCtrls, DBCGrids, dxDBTL, uFinTransferenciaFch, uFinContaCorrenteAjustaDlg,
  uFinContaCorrenteReconcile, dxPSCore, dxPSdxTLLnk, dxPSdxDBCtrlLnk,
  dxPSdxDBGrLnk, siComp, siLangRT, DateBox;

type
  TFinContaCorrenteMovList = class(TParentList)
    lblInicio: TLabel;
    Label3: TLabel;
    scContaCorrente: TSuperComboADO;
    lblFim: TLabel;
    quBrowseIDQuitacao: TIntegerField;
    quBrowseDebito: TFloatField;
    quBrowseCredito: TFloatField;
    quBrowseDataQuitacao: TDateTimeField;
    quBrowseNumeroMeioQuit: TStringField;
    quBrowseIdentificadorDocumento: TStringField;
    quBrowseSaldo: TCurrencyField;
    quSaldo: TADOQuery;
    quSaldoSaldo: TFloatField;
    brwGridDebito: TdxDBGridMaskColumn;
    brwGridCredito: TdxDBGridMaskColumn;
    brwGridDataQuitacao: TdxDBGridDateColumn;
    brwGridQuitacaoMeio: TdxDBGridMaskColumn;
    brwGridNumeroMeioQuit: TdxDBGridMaskColumn;
    brwGridSaldo: TdxDBGridColumn;
    quBrowseQuitacaoMeio: TStringField;
    quBrowseDataReconciliacao: TDateTimeField;
    quBrowseAReconciliar: TBooleanField;
    bbReconcilia: TdxBarButton;
    quBrowseValor: TFloatField;
    brwGridValor: TdxDBGridMaskColumn;
    bbMostraLancamento: TdxBarButton;
    quLancamento: TPowerADOQuery;
    quLancamentoIDLancamento: TIntegerField;
    quLancamentoValorNominal: TFloatField;
    quLancamentoDataVencimento: TDateTimeField;
    quLancamentoLancamentoTipo: TStringField;
    quLancamentoPessoa: TStringField;
    quLancamentoDataEmissao: TDateTimeField;
    quLancamentoPagando: TBooleanField;
    dsLancamento: TDataSource;
    bbMark: TdxBarButton;
    bbDesmarcaReconciliacao: TdxBarButton;
    quBrowseIcon: TIntegerField;
    brwGridIcon: TdxDBGridImageColumn;
    quBrowsePagando: TBooleanField;
    quContaCorrente: TADOQuery;
    quContaCorrenteUltimoSaldoBancario: TFloatField;
    quContaCorrenteUltimaReconciliacao: TDateTimeField;
    Splitter1: TSplitter;
    pnlBaixo: TPanel;
    pnlLancamento: TPanel;
    Panel6: TPanel;
    dxDBCGrid1: TdxDBCGrid;
    dxDBCGrid1IDLancamento: TdxDBGridMaskColumn;
    dxDBCGrid1LancamentoTipo: TdxDBGridMaskColumn;
    dxDBCGrid1Pessoa: TdxDBGridMaskColumn;
    dxDBCGrid1DataVencimento: TdxDBGridDateColumn;
    dxDBCGrid1Valor: TdxDBGridMaskColumn;
    pnlReconciliacao: TPanel;
    Label6: TLabel;
    lbClearedBal: TLabel;
    lblBalDiferrence: TLabel;
    Label9: TLabel;
    lblDebitoCount: TLabel;
    lblCreditoCount: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblDebitoValue: TLabel;
    lblCreditoValue: TLabel;
    lblLastBankEndBal: TLabel;
    lblClearedBal: TLabel;
    Panel1: TPanel;
    btReconcilia: TButton;
    btUpdateBankBalance: TButton;
    Panel3: TPanel;
    dxDBCGrid1FromAcc: TdxDBGridMaskColumn;
    quLancamentoTotalQuitado: TFloatField;
    quLancamentoValor: TFloatField;
    btnTransfer: TdxBarButton;
    quAllBanks: TADODataSet;
    dsAllBanks: TDataSource;
    btnTransOpt: TdxBarSubItem;
    btnAdjust: TdxBarButton;
    gbxBalance: TGroupBox;
    lblSaldoSistema: TLabel;
    eSaldoSistema: TEdit;
    lblSaldo: TLabel;
    eSaldo: TEdit;
    lbBank: TLabel;
    Label2: TLabel;
    edtAccBal: TEdit;
    edtBankBal: TEdit;
    quAllBanksAccBal: TBCDField;
    quAllBanksBankBal: TBCDField;
    quAllBanksBanco: TStringField;
    btnDebit: TdxBarButton;
    btnCredit: TdxBarButton;
    btnQuicken: TdxBarButton;
    quBrowseFavorecido: TStringField;
    brwGridFavorecido: TdxDBGridMaskColumn;
    Label1: TLabel;
    lbCalcTotal: TLabel;
    quLancamentoFromAcc: TStringField;
    dbFim: TDateBox;
    dbInicio: TDateBox;
    quBrowseOBS: TStringField;
    brwGridOBS: TdxDBGridColumn;
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure bbListaImprimeClick(Sender: TObject);
    procedure bbReconciliaClick(Sender: TObject);
    procedure bbMostraLancamentoClick(Sender: TObject);
    procedure bbMarkClick(Sender: TObject);
    procedure bbDesmarcaReconciliacaoClick(Sender: TObject);
    procedure bpmDetailPopup(Sender: TObject);
    procedure scContaCorrenteSelectItem(Sender: TObject);
    procedure btUpdateBankBalanceClick(Sender: TObject);
    procedure btReconciliaClick(Sender: TObject);
    procedure Panel6Click(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure dbInicioChange(Sender: TObject);
    procedure brwGridCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
    procedure btnTransferClick(Sender: TObject);
    procedure btnAdjustClick(Sender: TObject);
    procedure quAllBanksAfterOpen(DataSet: TDataSet);
    procedure btnDebitClick(Sender: TObject);
    procedure btnQuickenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure quLancamentoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    //Translation
    sContaCorrente,
    sPeriodo,
    sAte,
    sMarkRec,
    sUnMarkRec,
    sRec,
    sPay : String;


    FrmReconcile : TFinContaCorrenteReconcile;
    FrmAdjustBal : TFinContaCorrenteAjustaDlg;

    BeginBal,
    EndBal : Currency;

    SaldoChave,
    SaldoValor: TStringList;

    SaldoSistema: Double;

    DebitMarkedTotal, CreditMarkedTotal: Currency;
    DebitMarkedCount, CreditMarkedCount: Integer;

    DefaultLancamentoHeight,
    DefaultReconciliacaoHeight: integer;

    FinTrans : TFinTransferenciaFch;

    procedure InsereAQuitar;
    procedure DeleteAQuitar;

    procedure MostraLancamentoRefresh;
    procedure ContaCorrenteRefresh;
    procedure ReconcileButtonRefresh;
    procedure ReconciliacaoRefresh;

    procedure BuildFilter;
    procedure CalcBalance;

    procedure AllBankRefresh;


  public
    { Public declarations }
    function  ListParamRefresh : integer; override;
  end;

implementation

uses uDM, uMsgBox, uFinQuitacaoFch, uDateTimeFunctions, uSisWizardFrm,
     uNumericFunctions, uSystemTypes, uSystemConst, uFinLancamentoCalc,
     uMsgConstant, uDMGlobal;

{$R *.DFM}


procedure TFinContaCorrenteMovList.InsereAQuitar;
begin

  with DM.quFreeSQL do
    begin
      if Active then
         Close;
      SQL.Text := 'Insert #AQuitar (IDLancamento, ValorAQuitar, IDContaCorrente, Favorecido, IDQuitacaoMeio, NumeroMeioQuit) ' +
                  'Values (0, 0, '+ scContaCorrente.LookUpValue +', null ,-1, null)';
      ExecSQL;
    end;

end;

procedure TFinContaCorrenteMovList.DeleteAQuitar;
begin

    with DM.quFreeSQL do
      begin
        if Active then
           Close;
        SQL.Text := 'DELETE #AQuitar';
        ExecSQL;
      end;

end;


function  TFinContaCorrenteMovList.ListParamRefresh : integer;
begin

  // Testa se foi escolhida um Conta Corrente
  if scContaCorrente.LookUpValue = '' then
    begin
      MsgBox(MSG_INF_CHOOSE_BANK, vbCritical + vbOkOnly);
      scContaCorrente.SetFocus;
      Exit;
    end;

  if dbInicio.Visible then
    begin
      // Testa se das datas de período são válidas
      if not TestDate(dbInicio.Text) then
        begin
          MsgBox(MSG_CRT_NO_VALID_INIDATE, vbCritical + vbOkOnly);
          dbInicio.SetFocus;
          Exit;
        end;

      if not TestDate(dbInicio.Text) then
        begin
          MsgBox(MSG_CRT_NO_VALID_FIMDATE, vbCritical + vbOkOnly);
          dbFim.SetFocus;
          Exit;
        end;
    end;


  //Calculate the Balance
  CalcBalance;

  //Construct the filters
  BuildFilter;

  ListRefresh;

  DesligaAviso;

end;

procedure TFinContaCorrenteMovList.AllBankRefresh;
begin

  with quAllBanks do
    begin
    Close;
    Parameters.ParamByName('IDContaCorrente').Value := scContaCorrente.LookUpValue;
    Open;
    Close;
    end;

end;

procedure TFinContaCorrenteMovList.CalcBalance;
begin

  // Calcula o Saldo
  with quSaldo do
    begin
      Parameters.ParamByName('Inicio').Value := (dbInicio.Date);

      if scContaCorrente.LookUpValue = '' then
        Parameters.ParamByName('IDContaCorrente').Value := Null
      else
        Parameters.ParamByName('IDContaCorrente').Value
           := StrToInt(scContaCorrente.LookUpValue);

      Open;

      eSaldoSistema.text := FloatToStrF(quSaldoSaldo.AsCurrency, ffCurrency, 20, 2);
      SaldoSistema := quSaldoSaldo.AsCurrency;

      Close;
    end;

end;

procedure TFinContaCorrenteMovList.BuildFilter;
var
  InicioStr, FimStr: String;
begin

  // altera qual o filtro por data
  if dbInicio.Visible then
    begin
      InicioStr := Chr(39) + FormatDateTime('mm/dd/yyyy', dbInicio.Date) + Chr(39);
      FimStr    := Chr(39) + FormatDateTime('mm/dd/yyyy', dbFim.Date + 1) + Chr(39);
      WhereBasicFilter[1] := ' (DataQuitacao >= ' + InicioStr + ' AND DataQuitacao < ' + FimStr + ') ';
    end
  else
    begin
      WhereBasicFilter[1] := '';
    end;

  // Altera o filtro por conta corrente
  if scContaCorrente.LookUpValue = '' then
    WhereBasicFilter[5] := ''
  else
    WhereBasicFilter[5] := ' Q.IDContaCorrente = ' + scContaCorrente.LookUpValue;


  //Altera o filtro da reconciliacao
  if bbReconcilia.Down then
    WhereBasicFilter[6] := ' Q.DataReconciliacao IS NULL '
  else
    WhereBasicFilter[6] := '';

end;


procedure TFinContaCorrenteMovList.quBrowseAfterOpen(DataSet: TDataSet);
var
  i: integer;
  SaldoAnterior: double;

begin
  inherited;
  // Percorro a query calculando tudo e colocando em memoria para
  // o calc field recuperar

  with quBrowse do
    begin
      try
        DisableControls;
        First;

        // Zera todos os saldos correntes
        SaldoChave.Clear;
        SaldoValor.Clear;

        DebitMarkedTotal  := 0;
        CreditMarkedTotal := 0;
        DebitMarkedCount  := 0;
        CreditMarkedCount := 0;

        if eSaldo.Text <> '' then
          SaldoAnterior := MyStrToFloat(eSaldo.Text)
        else
          SaldoAnterior := SaldoSistema;

        while not eof do
          begin
            // Calculo os totais de reconciliacao
            if quBrowseAReconciliar.AsBoolean then
              begin
                if quBrowseValor.AsFloat < 0 then
                  begin
                    DebitMarkedTotal  := DebitMarkedTotal + quBrowseValor.AsFloat;
                    Inc(DebitMarkedCount);
                  end
                else
                  begin
                    CreditMarkedTotal  := CreditMarkedTotal + quBrowseValor.AsFloat;
                    Inc(CreditMarkedCount);
                end;
              end;

            // Guardo no string list o saldo corrente
            SaldoAnterior := SaldoAnterior +
                             quBrowseCredito.AsFloat -
                             quBrowseDebito.AsFloat;

            SaldoChave.Add(quBrowseIDQuitacao.AsString);
            SaldoValor.Add(FloatToStr(SaldoAnterior));

            Next;
          end;

      finally
        First;
        EnableControls;
      end;
    end;

  ContaCorrenteRefresh;

  ReconciliacaoRefresh;

end;

procedure TFinContaCorrenteMovList.FormCreate(Sender: TObject);
begin
  inherited;

  DefaultLancamentoHeight    := pnlLancamento.Height;
  DefaultReconciliacaoHeight := pnlReconciliacao.Height;

  brwForm := TFinQuitacaoFch.Create(self);

  SaldoChave := TStringList.Create;
  SaldoValor := TStringList.Create;

  eSaldo.Text := '';
  dbInicio.Date := InicioMes(Date());
  dbFim.Date    := FimMes(Date());

  ReconcileButtonRefresh;
  MostraLancamentoRefresh;

  FinTrans := nil;

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sContaCorrente := 'Bank Account ';
           sPeriodo       := ', from ';
           sAte           := ' to ';
           sMarkRec       := 'Mark for reconciliation';
           sUnMarkRec     := 'Unmark reconciliation';
           sRec           := 'Receivable';
           sPay           := 'Payable';
           end;
    LANG_PORTUGUESE :
           begin
           sContaCorrente := 'Conta Bancária ';
           sPeriodo       := ', de ';
           sAte           := ' ate ';
           sMarkRec       := 'Marcar para reconciliar';
           sUnMarkRec     := 'Desmarcar reconciliamento';
           sRec           := 'Recebimento';
           sPay           := 'Pagamento';
           end;
    LANG_SPANISH :
           begin
           sContaCorrente := 'Cuenta Bancaria ';
           sPeriodo       := ', de ';
           sAte           := ' hasta ';
           sMarkRec       := 'Marcar parar reconciliar';
           sUnMarkRec     := 'Borrar reconciliamiento';
           sRec           := 'Recebido';
           sPay           := 'Pago';
           end;
  end;


end;

procedure TFinContaCorrenteMovList.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FrmReconcile) then
     FreeAndNil(FrmReconcile);

  if Assigned(FrmAdjustBal) then
     FreeAndNil(FrmAdjustBal);

  SaldoChave.Destroy;
  SaldoValor.Destroy;

end;

procedure TFinContaCorrenteMovList.quBrowseCalcFields(DataSet: TDataSet);
var
  i: integer;

begin
  inherited;
  // Descubro qual o saldo corrente, baseado na chave.

  i := SaldoChave.IndexOf(quBrowseIDQuitacao.AsString);
  if i <> -1 then
    quBrowseSaldo.AsCurrency := StrToFloat(SaldoValor[i]);

end;



procedure TFinContaCorrenteMovList.bbListaImprimeClick(Sender: TObject);
begin
  // Aplico o Filtro
  MyReportFilter := sContaCorrente +
                    scContaCorrente.Text +
                    sPeriodo +
                    FormatDateTime('mm/dd/yyyy', dbInicio.Date) +
                    sAte +
                    FormatDateTime('mm/dd/yyyy', dbFim.Date);

  dxDBGridPrint.FilterText := MyReportFilter;
                      
  inherited;

end;

procedure TFinContaCorrenteMovList.bbReconciliaClick(Sender: TObject);
begin
  inherited;
  ReconcileButtonRefresh;
end;

procedure TFinContaCorrenteMovList.MostraLancamentoRefresh;
begin

  if bbMostraLancamento.Down then
    pnlBaixo.Height := DefaultLancamentoHeight + pnlReconciliacao.Height
  else
    pnlBaixo.Height := 18 + pnlReconciliacao.Height;

  quLancamento.Active := bbMostraLancamento.Down ;

end;

procedure TFinContaCorrenteMovList.ReconcileButtonRefresh;
begin

  if bbReconcilia.Down then
    pnlReconciliacao.Height := DefaultReconciliacaoHeight
  else
    pnlReconciliacao.Height := 1;

  //display the Reconciled Form
  if bbReconcilia.Down then
     if scContaCorrente.LookUpValue <> '' then
        begin
        if not Assigned(FrmReconcile) then
           FrmReconcile := TFinContaCorrenteReconcile.Create(Self);
        FrmReconcile.Start(BeginBal, EndBal, StrToInt(scContaCorrente.LookUpValue));
        end;

  MostraLancamentoRefresh;

  brwGridValor.Visible := bbReconcilia.Down;

  brwGridDebito.Visible := not bbReconcilia.Down;
  brwGridCredito.Visible := not bbReconcilia.Down;
  brwGridSaldo.Visible := not bbReconcilia.Down;


  if bbReconcilia.Down then
    brwGridIcon.Sorted := csUp
  else
    brwGridIcon.Sorted := csNone;

  //dbInicio.Visible := not bbReconcilia.Down;
  //lblInicio.Visible := not bbReconcilia.Down;

  dbFim.Visible := not bbReconcilia.Down;
  lblFim.Visible := not bbReconcilia.Down;

  eSaldoSistema.Visible := not bbReconcilia.Down;
  eSaldo.Visible := not bbReconcilia.Down;

  lblSaldoSistema.Visible := not bbReconcilia.Down;
  lblSaldo.Visible := not bbReconcilia.Down;

  if quBrowse.Active then
    btExecutaClick(nil);

end;

procedure TFinContaCorrenteMovList.bbMostraLancamentoClick(
  Sender: TObject);
begin
  inherited;
  MostraLancamentoRefresh;
end;

procedure TFinContaCorrenteMovList.bbMarkClick(Sender: TObject);
var
   BMB : TBookMarkStr;
   i   : integer;
begin
  inherited;

  try
     BMB     := quBrowse.Bookmark;
     quBrowse.DisableControls;

     for i := 0 to brwGrid.SelectedCount -1 do
        begin
        quBrowse.BookMark := brwGrid.SelectedRows[i];
        DM.RunSQL('UPDATE Fin_Quitacao SET AReconciliar = CASE AReconciliar WHEN 1 THEN 0 ELSE 1 END WHERE IDQuitacao = ' + quBrowseIDQuitacao.AsString)
        end;
  finally
    quBrowse.BookMark := BMB;
    quBrowse.EnableControls;
    ListRefresh;
  end;
  
end;

procedure TFinContaCorrenteMovList.bbDesmarcaReconciliacaoClick(Sender: TObject);
var
   BMB   : TBookMarkStr;
   i     : integer;
begin
  inherited;

   if MsgBox(MSQ_QST_CHANGE_RECONCILED_TRANS + #10#13,
             vbQuestion + vbYesNo) = vbNo then
      Exit;


  try
     BMB     := quBrowse.Bookmark;
     quBrowse.DisableControls;

     for i := 0 to brwGrid.SelectedCount -1 do
        begin
        quBrowse.BookMark := brwGrid.SelectedRows[i];
        DM.RunSQL('UPDATE Fin_Quitacao SET DataReconciliacao = Null WHERE IDQuitacao = ' + quBrowseIDQuitacao.AsString);

        //Recalcula o Total Reconciliado de Cada Linha
        DM.RunSQL('UPDATE Fin_ContaCorrente SET UltimoSaldoBancario = UltimoSaldoBancario - ' +
                   FloatToStr(quBrowseValor.AsFloat) +
                   ' WHERE IDContaCorrente = ' + scContaCorrente.LookUpValue);
        end;
  finally
    quBrowse.BookMark := BMB;
    quBrowse.EnableControls;
    ListRefresh;
  end;

end;

procedure TFinContaCorrenteMovList.bpmDetailPopup(Sender: TObject);
begin
  if quBrowseIcon.AsInteger = 1 then
    begin
      bbMark.Caption := sMarkRec;
      bbMark.ImageIndex := 54;
    end
  else
    begin
      bbMark.Caption := sUnMarkRec;
      bbMark.ImageIndex := -1;
    end;



  bbMark.Enabled := (quBrowseDataReconciliacao.IsNull);
  bbDesmarcaReconciliacao.Enabled := (quBrowseIcon.AsInteger = 3);

  inherited;

end;

procedure TFinContaCorrenteMovList.ReconciliacaoRefresh;
var
  CurrentBalance: Currency;

begin

  lblDebitoCount.Caption := IntToStr(DebitMarkedCount);
  lblCreditoCount.Caption := IntToStr(CreditMarkedCount);

  lblDebitoValue.Caption := FormatFloat(ffValor, DebitMarkedTotal);
  lblCreditoValue.Caption := FormatFloat(ffValor, CreditMarkedTotal);

  CurrentBalance := DebitMarkedTotal + CreditMarkedTotal;

  lblLastBankEndBal.Caption := FormatFloat(ffValor, EndBal);

  lblBalDiferrence.Caption := FormatFloat(ffValor, EndBal - (BeginBal + CurrentBalance));

  lblClearedBal.Caption := FormatFloat(ffValor, BeginBal + CurrentBalance);

  lbCalcTotal.Caption := FormatFloat(ffValor, CurrentBalance);

end;

procedure TFinContaCorrenteMovList.scContaCorrenteSelectItem(
  Sender: TObject);
begin
  inherited;
  ContaCorrenteRefresh;
end;

procedure TFinContaCorrenteMovList.ContaCorrenteRefresh;
begin
  with quContaCorrente do
    if scContaCorrente.LookUpValue <> '' then
      begin
        Close;
        Parameters.ParamByName('IDContaCorrente').Value := StrToInt(scContaCorrente.LookUpValue);
        Open;
      end
    else
      Close;

  AllBankRefresh;
      
end;


procedure TFinContaCorrenteMovList.btUpdateBankBalanceClick(Sender: TObject);
var
  NewBalance: Currency;
begin
  inherited;
  if scContaCorrente.LookUpValue <> '' then
     begin

     if not Assigned(FrmReconcile) then
        FrmReconcile := TFinContaCorrenteReconcile.Create(Self);

     FrmReconcile.Start(BeginBal, EndBal, StrToInt(scContaCorrente.LookUpValue));

     NewBalance := BeginBal;

      if NewBalance <> 0 then
         begin
         if NewBalance <> quContaCorrenteUltimoSaldoBancario.AsCurrency then
            begin
            DM.RunSQL('UPDATE Fin_ContaCorrente SET UltimoSaldoBancario = ' + FloatToStr(NewBalance) + ' WHERE IDContaCorrente = ' + scContaCorrente.LookUpValue);
            ContaCorrenteRefresh;
            end;
         ReconciliacaoRefresh;
         end;
     end;
end;


procedure TFinContaCorrenteMovList.btReconciliaClick(Sender: TObject);
var
  i : Integer;
  hasDiference : boolean;
begin
  inherited;

  //Verifica se tem item para ser reconciliado
  if (DebitMarkedTotal=0) and (CreditMarkedTotal=0) then
     begin
     MsgBox(MSG_INF_NOT_TRANS_TO_RECONCILE + #10#13, vbInformation + vbOKOnly);
     Exit;
     end;

  hasDiference := False;

  //Verifica se tem diferenca no Total, se tiver mostra o Adjust dialog
  if MyStrToMoney(Trim(lblBalDiferrence.Caption)) <> 0 then
     if MsgBox(MSQ_QST_PART1_DIFFER_RECONC_BAL + #13#10 +
               MSQ_QST_PART2_DIFFER_RECONC_BAL + #13#10,
               vbQuestion + vbYesNo) = vbYes then
         begin

         if not Assigned(FrmAdjustBal) then
            FrmAdjustBal := TFinContaCorrenteAjustaDlg.Create(self);

         i := MyStrToInt(scContaCorrente.LookUpValue);
         with FrmAdjustBal do
             Start(i, dbFim.Date, EndBal, True);

         hasDiference := True;
         end;


  Try
    DM.DBADOConnection.BeginTrans;

    DM.RunSQL( 'UPDATE Fin_Quitacao SET DataReconciliacao = ' +QuotedStr(FormatDateTime('mm/dd/yyyy',Now))+ ', ' +
               'AReconciliar = 0 WHERE AReconciliar = 1 AND IDContaCorrente = ' + scContaCorrente.LookUpValue);

    DM.RunSQL( 'UPDATE Fin_ContaCorrente SET UltimoSaldoBancario = '+CurrToStr(EndBal)+ ', ' +
               'UltimaReconciliacao = '+QuotedStr(FormatDateTime('mm/dd/yyyy',Now))+' ' +
               'WHERE IDContaCorrente = ' + scContaCorrente.LookUpValue);

    DM.DBADOConnection.CommitTrans;

  except
     DM.DBADOConnection.RollbackTrans;
     MsgBox(MSG_CRT_ERROR_RECONCILING, vbCritical + vbOKOnly);
     Exit;
  end;

  if not hasDiference then
     MsgBox(MSG_INF_PART1_RECONCILED_OK +#10#13+
            MSG_INF_PART2_RECONCILED_OK +#10#13, vbInformation + vbOKOnly);

  BeginBal := EndBal;
  EndBal   := 0;

  ContaCorrenteRefresh;
  ReconciliacaoRefresh;
  ListRefresh;
  DesligaAviso;


end;

procedure TFinContaCorrenteMovList.Panel6Click(Sender: TObject);
begin
  inherited;
  bbMostraLancamento.Down := not bbMostraLancamento.Down;
  MostraLancamentoRefresh;
end;

procedure TFinContaCorrenteMovList.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  Accept := bbMostraLancamento.Down;
end;

procedure TFinContaCorrenteMovList.dbInicioChange(Sender: TObject);
begin
  inherited;
  if bbReconcilia.Down then
    btExecutaClick(nil)
  else
    LigaAviso;
end;

procedure TFinContaCorrenteMovList.brwGridCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxDBTreeListColumn; const AText: String; AFont: TFont;
  var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean);
begin
  inherited;

  if AColumn.Name = 'brwGridSaldo' then
    if ANode.Values[AColumn.Index] < 0 then
      begin
        AColor := $00CDCCFF;
        AFont.Color := clWindowText;
      end
    else
      begin
        AColor := $00FFE0CC;
        AFont.Color := clWindowText;
      end;

end;

procedure TFinContaCorrenteMovList.btnTransferClick(Sender: TObject);
var
 ID1, ID2 : String;
begin
  inherited;

  //Transfer the money
  if FinTrans = nil then
     FinTrans := TFinTransferenciaFch.Create(Self);

  if FinTrans.Start(btInc, nil, false, ID1, ID2, '', '', nil) then
     begin
     CalcBalance;
     ListRefresh;
     DesligaAviso;
     end;


end;

procedure TFinContaCorrenteMovList.btnAdjustClick(Sender: TObject);
var
  i : integer;
begin
  inherited;
  //AdjustBalance

  i := MyStrToInt(scContaCorrente.LookUpValue);

  if not Assigned(FrmAdjustBal) then
     FrmAdjustBal := TFinContaCorrenteAjustaDlg.Create(self);

  with FrmAdjustBal do
      if Start(i, now, 0, False) then
         begin
         CalcBalance;
         ListRefresh;
         DesligaAviso;
         end;


end;

procedure TFinContaCorrenteMovList.quAllBanksAfterOpen(DataSet: TDataSet);
begin
  inherited;

  edtAccBal.Text  := FloatToStrF(quAllBanksAccBal.AsCurrency, ffCurrency, 20, 2);
  edtBankBal.Text := FloatToStrF(quAllBanksBankBal.AsCurrency, ffCurrency, 20, 2);

  lbBank.Caption  := quAllBanksBanco.AsString + ' :'; 

end;

procedure TFinContaCorrenteMovList.btnDebitClick(Sender: TObject);
var
   ID1, ID2: String;
begin
  inherited;

  if scContaCorrente.LookUpValue = '' then
     begin
     MsgBox(MSG_INF_CHOOSE_BANK, vbCritical + vbOkOnly);
     scContaCorrente.Setfocus;
     Exit;
     end;

  // Os lancamentos a serem quitados são passados para a ficha de quitacao
  // atraves da tabela temporaria #AQuitar.

  // Tenta criar a Tabela Temporária no Server
  // se não conseguir e porque ela já existe.
  try

    CreateAQuitar;

  except
    // Como existe esvazia a tabela temporaria, exvazia-a.
    Self.DeleteAQuitar;
  end;

  // Inclui o registro selecionado na tabela temporária.
  Self.InsereAQuitar;

  if Sender = btnDebit then
     brwForm.Param := 'Pagando=1'
  else
     brwForm.Param := 'Pagando=0';

  if brwForm.Start(btInc, nil, False, ID1, ID2, '', MyUserRights, nil) then
     ListRefresh;

  // Caso necessario cria a ficha de pagamento.
{  if FinQuitacaoFch = Nil then
    FinQuitacaoFch := TFinQuitacaoFch.Create(Self);

  // Seta o parametro que vai ser passado para a ficha
  if Self.Pagando then
    FinQuitacaoFch.Param := 'Pagando=1'
  else
    FinQuitacaoFch.Param := 'Pagando=0';

  // Abre a ficha de pagamento.
  if FinQuitacaoFch.Start(btInc, nil, False, ID1, ID2, '', MyUserRights, nil) then
    begin
      ListRefresh;
    end;}


end;

procedure TFinContaCorrenteMovList.btnQuickenClick(Sender: TObject);
begin
  inherited;

  //Start Wizaed
  with TSisWizardFrm.Create(self) do
       Start(scContaCorrente.LookUpValue, dbInicio.Date, dbFim.Date);


end;

procedure TFinContaCorrenteMovList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  quContaCorrente.Close;
  quLancamento.Close;  
end;

procedure TFinContaCorrenteMovList.quLancamentoCalcFields(
  DataSet: TDataSet);
begin
  inherited;

  if quLancamentoPagando.AsBoolean = False then
     quLancamentoFromAcc.AsString := sRec
  else
     quLancamentoFromAcc.AsString := sPay;
end;

Initialization
  RegisterClass(TFinContaCorrenteMovList);


end.
