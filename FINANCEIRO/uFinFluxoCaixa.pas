unit uFinFluxoCaixa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, DBTables, Grids, StdCtrls, Mask,
  Buttons, uFinLancamentoFch, ComCtrls, dxBar,
  uParentBrwWaitFrm, dxDBGrid, dxCntner, dxTL, dxGrClms, dxDBGridPrint,
  dxDateEdit, uParentFixedFrm, ImgList, dxDBTLCl, dxDBCtrl, ADODB,
  RCADOQuery, PowerADOQuery, SuperComboADO, dxEditor, dxExEdtr, dxEdLib,
  siComp, siLangRT;

type
  TFinFluxoCaixa = class(TParentFixedFrm)
    dsFluxoCaixa: TDataSource;
    pnlBasicFilter: TPanel;
    quSaldo: TRCADOQuery;
    quSaldoSaldo: TFloatField;
    trmGO: TTimer;
    pnlLancamento: TPanel;
    werrgdfgfhjhgjkghifgpfg: TPanel;
    pnlBrwCmd: TPanel;
    Panel4: TPanel;
    btDetalhe: TSpeedButton;
    pnlBrwTitle: TPanel;
    dsLancamento: TDataSource;
    quLancamento: TPowerADOQuery;
    quLancamentoIDLancamento: TIntegerField;
    quLancamentoTotalQuitado: TFloatField;
    quLancamentoValorNominal: TFloatField;
    quLancamentoDataVencimento: TDateTimeField;
    quLancamentoLancamentoTipo: TStringField;
    quLancamentoCentroCusto: TStringField;
    quLancamentoPessoa: TStringField;
    btMostra: TSpeedButton;
    pnlAviso: TPanel;
    btGo: TButton;
    PageControl: TPageControl;
    tsFiltro: TTabSheet;
    tsDetalhe: TTabSheet;
    tsBasico: TTabSheet;
    Label5: TLabel;
    cmbGranulacao: TComboBox;
    Label3: TLabel;
    dbInicio: TdxDateEdit;
    Label4: TLabel;
    dbFim: TdxDateEdit;
    cbLancamentoTipo: TCheckBox;
    cbCentroCusto: TCheckBox;
    cbPessoaTipo: TCheckBox;
    cbPessoa: TCheckBox;
    cbEmpresa: TCheckBox;
    scPessoaTipo: TSuperComboADO;
    Label7: TLabel;
    btTodoTP: TButton;
    btTodoTL: TButton;
    scLancamentoTipo: TSuperComboADO;
    Label6: TLabel;
    btTodoCC: TButton;
    scCentroCusto: TSuperComboADO;
    Label2: TLabel;
    btTodaPessoa: TButton;
    scPessoa: TSuperComboADO;
    Label10: TLabel;
    lblSaldoSis: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    eSaldo: TEdit;
    Splitter: TSplitter;
    btTodosDetalhes: TButton;
    btNehumDetalhe: TButton;
    quLancamentoDataEmissao: TDateTimeField;
    btPrint: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    PrintDialog: TPrintDialog;
    quLancamentoPagando: TBooleanField;
    ImpFluxo: TdxDBGridPrint;
    ImpLancamento: TdxDBGridPrint;
    cbSubCC: TCheckBox;
    cbSubLT: TCheckBox;
    grdFluxoCaixa: TdxDBGrid;
    grdFluxoCaixaData: TdxDBGridColumn;
    grdFluxoCaixaPessoa: TdxDBGridMaskColumn;
    grdFluxoCaixaPessoaTipo: TdxDBGridMaskColumn;
    grdFluxoCaixaLancamentoTipo: TdxDBGridMaskColumn;
    grdFluxoCaixaCentroCusto: TdxDBGridMaskColumn;
    grdFluxoCaixaCredito: TdxDBGridMaskColumn;
    grdFluxoCaixaDebito: TdxDBGridMaskColumn;
    grdFluxoCaixaSaldo: TdxDBGridColumn;
    grdFluxoCaixaCodigoEmpresa: TdxDBGridMaskColumn;
    Label11: TLabel;
    grdLancamento: TdxDBGrid;
    grdLancamentoIDLancamento: TdxDBGridMaskColumn;
    grdLancamentoTotalQuitado: TdxDBGridMaskColumn;
    grdLancamentoValorNominal: TdxDBGridMaskColumn;
    grdLancamentoDataVencimento: TdxDBGridDateColumn;
    grdLancamentoLancamentoTipo: TdxDBGridMaskColumn;
    grdLancamentoPessoa: TdxDBGridMaskColumn;
    grdLancamentoDataEmissao: TdxDBGridDateColumn;
    pnlEmpresa: TPanel;
    lvEmpresa: TListView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Splitter2: TSplitter;
    btSelEmpresa: TSpeedButton;
    quFluxoCaixa: TRCADOQuery;
    quFluxoCaixaData: TStringField;
    quFluxoCaixaPessoa: TStringField;
    quFluxoCaixaPessoaTipo: TStringField;
    quFluxoCaixaLancamentoTipo: TStringField;
    quFluxoCaixaCentroCusto: TStringField;
    quFluxoCaixaDebito: TFloatField;
    quFluxoCaixaCredito: TFloatField;
    quFluxoCaixaSaldo: TCurrencyField;
    quFluxoCaixagrao: TIntegerField;
    quFluxoCaixaAno: TIntegerField;
    quFluxoCaixaCodigoEmpresa: TStringField;
    quFluxoCaixaIDEmpresa: TIntegerField;
    quFluxoCaixaIDPessoa: TIntegerField;
    quFluxoCaixaIDPessoaTipo: TIntegerField;
    quFluxoCaixaIDCentroCusto: TIntegerField;
    quFluxoCaixaIDLancamentoTipo: TIntegerField;
    chkInterest: TCheckBox;
    chkOpenRecord: TCheckBox;
    procedure btGoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure quFluxoCaixaCalcFields(DataSet: TDataSet);
    procedure eSaldoChange(Sender: TObject);
    procedure btTodoCCClick(Sender: TObject);
    procedure btTodoTLClick(Sender: TObject);
    procedure btTodoTPClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quFluxoCaixaAfterScroll(DataSet: TDataSet);
    procedure trmGOTimer(Sender: TObject);
    procedure scCentroCustoChange(Sender: TObject);
    procedure cbCentroCustoClick(Sender: TObject);
    procedure btDetalheClick(Sender: TObject);
    procedure dsLancamentoDataChange(Sender: TObject; Field: TField);
    procedure grdLancamento2DblClick(Sender: TObject);
    procedure btMostraClick(Sender: TObject);
    procedure grdFluxoCaixaCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure dsFluxoCaixaDataChange(Sender: TObject; Field: TField);
    procedure btTodaPessoaClick(Sender: TObject);
    procedure grdFluxoCaixaDblClick(Sender: TObject);
    procedure btNehumDetalheClick(Sender: TObject);
    procedure btTodosDetalhesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btUpClick(Sender: TObject);
    procedure btDownClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure grdLancamento2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure quFluxoCaixaAfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure grdLancamentoCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
    procedure btSelEmpresaClick(Sender: TObject);
    procedure lvEmpresaClick(Sender: TObject);
    procedure grdFluxoCaixaCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
  private
    { Private declarations }
    Fator,
    PrimeiroAno: Integer;

    sWeek, sYear, sFrom, sTo : String;

    aSaldoCorrente: array [0..9999] of double;

    SaldoSistema: Currency;
    UnidadeGrao: integer;
    OriginalSQLLanc, OriginalSQL: String;
    Vez: Boolean;

    OEmpresaWidth,
    OPessoaTipoWidth,
    OPessoaWidth,
    OLancamentoTipoWidth,
    OCentroCustoWidth: Integer;

    FinLancamentoFch: TFinLancamentoFch;
    ParentBrwWaitFrm: TParentBrwWaitFrm;

    function RetornaNomeMes(iMes : Integer) : String;
    function GetFilterText : String;

    procedure RefreshLancamento;
    Function MontaWhereClase : String;
  public
    { Public declarations }
    ActualSQL: String;

  end;

implementation

uses uDM, uMsgBox, uSQLFunctions, uNumericFunctions, uDateTimeFunctions,
     uSystemTypes, uMsgConstant, uDMGlobal;

{$R *.DFM}


Function TFinFluxoCaixa.MontaWhereClase : String;
var
  SQLAux, FiltroEmpresa : String;
  i : Integer;
  Todos : Boolean;
begin

  // Filtro por centro de custo
  if scCentroCusto.LookUpValue <> '' then
    begin
      if cbSubCC.Checked then
        begin
          SQLAux :=
            SQLAux +
            ' AND (CC.Path LIKE ' + Chr(39) +
            DM.DescCodigo( ['IDCentroCusto'],
                           [scCentroCusto.LookUpValue],
                           'Fin_CentroCusto',
                           'Path' ) + '%' + Chr(39) + ')';
        end
      else
        SQLAux := SQLAux + ' AND L.IDCentroCusto = ' + scCentroCusto.LookUpValue;
    end;

  // Filtro por tipo de lancamento
  if scLancamentoTipo.LookUpValue <> '' then
    begin
      if cbSubLT.Checked then
        begin
          SQLAux :=
            SQLAux +
            ' AND (LT.Path LIKE ' + Chr(39) +
            DM.DescCodigo( ['IDLancamentoTipo'],
                           [scLancamentoTipo.LookUpValue],
                           'Fin_LancamentoTipo',
                           'Path' ) + '%' + Chr(39) + ')';
        end
      else
        SQLAux := SQLAux + ' AND LT.IDLancamentoTipo = ' + scLancamentoTipo.LookUpValue;
    end;

  // PessoaTipo
  if scPessoaTipo.LookUpValue <> '' then
     SQLAux := SQLAux + ' AND P.IDTipoPessoa = ' + scPessoaTipo.LookUpValue;

  if scPessoa.LookUpValue <> '' then
     SQLAux := SQLAux + ' AND P.IDPessoa = ' + scPessoa.LookUpValue;


  // Aplica o filtro de empresas
  FiltroEmpresa := '';
  Todos := True;
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
      begin
        Todos := Todos AND Items[i].Checked;
        if Items[i].Checked then
          begin
            if FiltroEmpresa <> '' then
              FiltroEmpresa := FiltroEmpresa + ' OR '
            else
              FiltroEmpresa := FiltroEmpresa + ' ( ';


            FiltroEmpresa
               := FiltroEmpresa + 'L.IDEmpresa = ' + Items[i].SubItems[0];
          end;
      end;

  if FiltroEmpresa <> '' then
    FiltroEmpresa := ' AND ' + FiltroEmpresa + ' ) ';

  if Todos then
    FiltroEmpresa := '';

  if FiltroEmpresa <> '' then
    SQLAux := SQLAux + FiltroEmpresa;

  Result := SQLAux;

end;

procedure TFinFluxoCaixa.btGoClick(Sender: TObject);
var
   MySqlStatement: TSQlStatement;
   Ano, Grao: Integer;
begin
  inherited;

try
  Screen.Cursor := crHourGlass;

  // Testa se os campos obrigatorios foram preenchidos
  if dbInicio.Date = 0 then
    begin
      MsgBox(MSG_CRT_NO_VALID_INIDATE, vbInformation + vbOkOnly);
      dbInicio.SetFocus;
      exit;
    end;

  if dbFim.Date = 0 then
    begin
      MsgBox(MSG_CRT_NO_VALID_FIMDATE, vbInformation + vbOkOnly);
      dbFim.SetFocus;
      exit;
    end;

  if quFluxoCaixa.Active then
    // Salva o ano e o grao
    begin
      Ano  := quFluxoCaixaAno.AsInteger;
      Grao := quFluxoCaixaGrao.AsInteger;
      quFluxoCaixa.Close;
    end
  else
    begin
      Ano  := 0;
      Grao := 0;
    end;

  // Se estava aberto fecha
  with quFluxoCaixa do
    if Active then Close;

  ParentBrwWaitFrm.Show;
  Application.ProcessMessages;

  // Calcula o Saldo anterior
  with quSaldo do
    begin
      Parameters.ParamByName('DateIni').Value := dbInicio.Date;
      Open;
      SaldoSistema := FieldByName('Saldo').AsCurrency;

      if SaldoSistema = 0 then
        lblSaldoSis.Caption := '0.00'
      else
        lblSaldoSis.Caption := FloatToStrF(FieldByName('Saldo').AsCurrency, ffCurrency, 20, 2);
      Close;
    end;

  // Monta o SQL
  MySqlStatement := UnMountSQL(OriginalSQL);


  if not chkOpenRecord.Checked then
  begin
    if chkInterest.Checked then
      begin
        MySqlStatement[ST_SELECT] :=
           MySqlStatement[ST_SELECT] + ', SUM( (IsNull(L.ValorNominal,0) + IsNull(L.TotalJuros,0)) * (L.Pagando - 1) * - 1 ) as Credito ';

        MySqlStatement[ST_SELECT] :=
           MySqlStatement[ST_SELECT] + ', SUM( (IsNull(L.ValorNominal,0) + IsNull(L.TotalJuros,0)) * (L.Pagando)) as Debito ';
      end
    else
      begin
        MySqlStatement[ST_SELECT] :=
           MySqlStatement[ST_SELECT] + ', SUM( IsNull(L.ValorNominal,0) * (L.Pagando - 1) * - 1 ) as Credito ';

        MySqlStatement[ST_SELECT] :=
           MySqlStatement[ST_SELECT] + ', SUM( IsNull(L.ValorNominal,0) * (L.Pagando)) as Debito ';
      end;
  end
  else
  begin
    if chkInterest.Checked then
      begin
        MySqlStatement[ST_SELECT] :=
           MySqlStatement[ST_SELECT] + ', SUM( (IsNull(L.ValorNominal,0) + IsNull(L.TotalJuros,0) - IsNull(L.TotalQuitado,0)) * (L.Pagando - 1) * - 1 ) as Credito ';

        MySqlStatement[ST_SELECT] :=
           MySqlStatement[ST_SELECT] + ', SUM( (IsNull(L.ValorNominal,0) + IsNull(L.TotalJuros,0) - IsNull(L.TotalQuitado,0)) * (L.Pagando)) as Debito ';
      end
    else
      begin
        MySqlStatement[ST_SELECT] :=
           MySqlStatement[ST_SELECT] + ', SUM( (IsNull(L.ValorNominal,0) - IsNull(L.TotalQuitado,0)) * (L.Pagando - 1) * - 1 ) as Credito ';

        MySqlStatement[ST_SELECT] :=
           MySqlStatement[ST_SELECT] + ', SUM( (IsNull(L.ValorNominal,0) - IsNull(L.TotalQuitado,0)) * (L.Pagando)) as Debito ';
      end;
  end;

  if cbCentroCusto.Checked then
    // Adiciona ao select e ao group by a Campo CentroCusto
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', CC.CentroCusto, CC.IDCentroCusto ';

      MySqlStatement[ST_GROUP] :=
         MySqlStatement[ST_GROUP] + ', CC.CentroCusto, CC.IDCentroCusto ';
    end
  else
    // Adiciona um campo dumy
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', Convert(varchar(35),' + chr(39) + 'Vários' + chr(39) + ') as CentroCusto';

      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', -1 as IDCentroCusto';
    end;

  if cbLancamentoTipo.Checked then
    // Adiciona ao select e ao group by a Campo Lancamento Tipo
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', LT.LancamentoTipo, LT.IDLancamentoTipo ';

      MySqlStatement[ST_GROUP] :=
         MySqlStatement[ST_GROUP] + ', LT.LancamentoTipo, LT.IDLancamentoTipo ';
    end
  else
    // Adiciona um campo dumy
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', Convert(varchar(65),' + chr(39) + 'Vários' + chr(39) + ') as LancamentoTipo';

      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', -1 as IDLancamentoTipo';

    end;

  if cbPessoaTipo.Checked then
    // Adiciona ao select e ao group by a Campo Lancamento Tipo
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', TP.TipoPessoa, TP.IDTipoPessoa ';

      MySqlStatement[ST_GROUP] :=
         MySqlStatement[ST_GROUP] + ', TP.TipoPessoa, TP.IDTipoPessoa ';
    end
  else
    // Adiciona um campo dumy
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', Convert(varchar(50),' + chr(39) + 'Vários' + chr(39) + ') as TipoPessoa';

      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', -1 as IDTipoPessoa';
    end;

  if cbPessoa.Checked then
    // Adiciona ao select e ao group by a Campo Lancamento Tipo
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', P.Pessoa, P.IDPessoa ';

      MySqlStatement[ST_GROUP] :=
         MySqlStatement[ST_GROUP] + ', P.Pessoa, P.IDPessoa ';
    end
  else
    // Adiciona um campo dumy
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', Convert(varchar(100),' + chr(39) + 'Várias' + chr(39) + ') as Pessoa';

      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', -1 as IDPessoa';

    end;

  if cbEmpresa.Checked then
    // Adiciona ao select e ao group by a Campo CentroCusto
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', E.CodigoEmpresa, E.IDEmpresa ';

      MySqlStatement[ST_GROUP] :=
         MySqlStatement[ST_GROUP] + ', E.CodigoEmpresa, E.IDEmpresa ';
    end
  else
    // Adiciona um campo dumy
    begin
      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', Convert(varchar(20),' + chr(39) + 'Várias' + chr(39) + ') as CodigoEmpresa';

      MySqlStatement[ST_SELECT] :=
         MySqlStatement[ST_SELECT] + ', -1 as IDEmpresa';
    end;



  // Seta os parametros na query e da o requery
  // periodo
  quFluxoCaixa.Parameters.ParamByName('DataInicio').Value := dbInicio.Date;
  quFluxoCaixa.Parameters.ParamByName('DataFim').Value := dbFim.Date + 1;

  // grao
  CASE cmbGranulacao.ItemIndex of
       0 : begin
           MySqlStatement[ST_SELECT] := MySqlStatement[ST_SELECT] + ', DatePart(year, L.DataVencimento) as Grao';
           MySqlStatement[ST_GROUP]  := MySqlStatement[ST_GROUP] +', DatePart(year, L.DataVencimento)';
           end;
       1 : begin
           MySqlStatement[ST_SELECT] := MySqlStatement[ST_SELECT] + ', DatePart(month, L.DataVencimento) as Grao';
           MySqlStatement[ST_GROUP]  := MySqlStatement[ST_GROUP]+', DatePart(month, L.DataVencimento)';
           end;
       2 : begin
           MySqlStatement[ST_SELECT] := MySqlStatement[ST_SELECT] + ', DatePart(week, L.DataVencimento) as Grao';
           MySqlStatement[ST_GROUP]  := MySqlStatement[ST_GROUP]+', DatePart(week, L.DataVencimento)';
           end;
       3 : begin
           MySqlStatement[ST_SELECT] := MySqlStatement[ST_SELECT] + ', DatePart(dy, L.DataVencimento) as Grao';
           MySqlStatement[ST_GROUP]  := MySqlStatement[ST_GROUP]+', DatePart(dy, L.DataVencimento)';
           end;
  END;

  MySqlStatement[ST_WHERE] := MySqlStatement[ST_WHERE] + MontaWhereClase;

  ActualSQL := MountSQL(MySqlStatement);
  quFluxoCaixa.SQL.Text := ActualSQL;
  //ShowMessage(quFluxoCaixa.SQL.Text);

  if quLancamento.Active then
    begin
      quLancamento.Close;
      quFluxoCaixa.Close;
      quFluxoCaixa.Open;
      quLancamento.Open;
    end
  else
    begin
    quFluxoCaixa.Close;
    quFluxoCaixa.Open;
    end;


  // Mostra somente as colunas detalhas
  grdFluxoCaixa.ColumnByFieldName('CentroCusto').Visible := cbCentroCusto.Checked;
  grdFluxoCaixa.ColumnByFieldName('LancamentoTipo').Visible := cbLancamentoTipo.Checked;
  grdFluxoCaixa.ColumnByFieldName('PessoaTipo').Visible := cbPessoaTipo.Checked;
  grdFluxoCaixa.ColumnByFieldName('Pessoa').Visible := cbPessoa.Checked;
  grdFluxoCaixa.ColumnByFieldName('CodigoEmpresa').Visible := cbEmpresa.Checked;

  trmGo.Enabled := False;
  pnlAviso.ParentColor := True;

  // Se estava ativa, da o locate para manter a posicao
  if (Grao <> 0) and (Ano <> 0) then
    begin
      quFluxoCaixa.Locate( 'Grao;Ano',
                           VarArrayOf([IntToStr(Grao), IntToStr(Ano)]),
                           []);

    end;
finally
  Screen.Cursor := crDefault;
  ParentBrwWaitFrm.Hide;
end;
end;

procedure TFinFluxoCaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;

end;

procedure TFinFluxoCaixa.FormShow(Sender: TObject);
begin
  inherited;
  cmbGranulacao.ItemIndex := 3;

  PageControl.ActivePage := tsBasico;

  btTodoCCClick(nil);
  btTodoTLClick(nil);
  btTodoTPClick(nil);
  btMostraClick(nil);
  btTodaPessoaClick(nil);

  eSaldo.Text := '';

  dbInicio.Date := InicioMes(Date());
  dbFim.Date    := FimMes(Date());

end;


procedure TFinFluxoCaixa.quFluxoCaixaCalcFields(DataSet: TDataSet);
var
  i: integer;
begin
  inherited;

  if (PrimeiroAno = 0) or (quFluxoCaixa.RecordCount = 0) then
    Exit;


  i := (quFluxoCaixaAno.AsInteger - PrimeiroAno) *
      Fator + quFluxoCaixaGrao.AsInteger;

  quFluxoCaixaSaldo.AsCurrency := ASaldoCorrente[i];

  // Calculo da data inical do grao
  case cmbGranulacao.ItemIndex of
    0: // Anual
      begin
        quFluxoCaixaData.AsString := quFluxoCaixaAno.AsString;
      end;

    1: // Mensal
      case quFluxoCaixaGrao.AsInteger of
        1:  quFluxoCaixaData.AsString := RetornaNomeMes(1)  + ' ' + quFluxoCaixaAno.AsString;
        2:  quFluxoCaixaData.AsString := RetornaNomeMes(2)  + ' ' + quFluxoCaixaAno.AsString;
        3:  quFluxoCaixaData.AsString := RetornaNomeMes(3)  + ' ' + quFluxoCaixaAno.AsString;
        4:  quFluxoCaixaData.AsString := RetornaNomeMes(4)  + ' ' + quFluxoCaixaAno.AsString;
        5:  quFluxoCaixaData.AsString := RetornaNomeMes(5)  + ' ' + quFluxoCaixaAno.AsString;
        6:  quFluxoCaixaData.AsString := RetornaNomeMes(6)  + ' ' + quFluxoCaixaAno.AsString;
        7:  quFluxoCaixaData.AsString := RetornaNomeMes(7)  + ' ' + quFluxoCaixaAno.AsString;
        8:  quFluxoCaixaData.AsString := RetornaNomeMes(8)  + ' ' + quFluxoCaixaAno.AsString;
        9:  quFluxoCaixaData.AsString := RetornaNomeMes(9)  + ' ' + quFluxoCaixaAno.AsString;
        10: quFluxoCaixaData.AsString := RetornaNomeMes(10) + ' ' + quFluxoCaixaAno.AsString;
        11: quFluxoCaixaData.AsString := RetornaNomeMes(11) + ' ' + quFluxoCaixaAno.AsString;
        12: quFluxoCaixaData.AsString := RetornaNomeMes(12) + ' ' + quFluxoCaixaAno.AsString;
      end;
    2: // Semanal
      begin
        quFluxoCaixaData.AsString :=
              sWeek + quFluxoCaixaGrao.AsString + sYear + quFluxoCaixaAno.AsString + sFrom +
              FormatDateTime('ddddd', GetPrimeiroDomingo(quFluxoCaixaAno.AsInteger) + (quFluxoCaixaGrao.AsInteger - 2) * 7) +
              sTo +
              FormatDateTime('ddddd',GetPrimeiroDomingo(quFluxoCaixaAno.AsInteger) + (quFluxoCaixaGrao.AsInteger - 1) * 7);
      end;
    3: // Diaria
      begin
        quFluxoCaixaData.AsString := FormatDateTime('ddddd',EncodeDate( quFluxoCaixaAno.AsInteger, 1, 1) + quFluxoCaixaGrao.AsInteger -1);
      end;
  end;


end;


procedure TFinFluxoCaixa.eSaldoChange(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;


procedure TFinFluxoCaixa.btTodoCCClick(Sender: TObject);
begin
  inherited;
  scCentroCusto.LookUpValue := '';

end;

procedure TFinFluxoCaixa.btTodoTLClick(Sender: TObject);
begin
  inherited;
  scLancamentoTipo.LookUpValue := '';

end;

procedure TFinFluxoCaixa.btTodoTPClick(Sender: TObject);
begin
  inherited;
  scPessoaTipo.LookUpValue := '';

end;

procedure TFinFluxoCaixa.FormCreate(Sender: TObject);
var
   ListItem: TListItem;
begin
  inherited;
  // Guarda o SQL original
  OriginalSQL := quFluxoCaixa.SQL.Text;
  OriginalSQLLanc := quLancamento.CommandText;
  OEmpresaWidth := -1;
  PrimeiroAno := 0;

  ParentBrwWaitFrm := TParentBrwWaitFrm.Create(Self);

  btSelEmpresaClick(nil);

  // Preenche o check list box de empresas
  with DM.quFreeSQL do
    begin
      if Active then
        Close;
      SQL.Text := 'SELECT E.IDEmpresa, E.Empresa FROM #Sis_EmpresaP EP JOIN Sis_Empresa E ON (EP.IDEmpresaP = E.IDEmpresa) WHERE E.Desativado = 0 AND E.Hidden = 0';
      Open;
      First;
      lvEmpresa.Items.Clear;
      while not EOF do
        begin
          ListItem := lvEmpresa.Items.Add;
          ListItem.Caption := Fields[1].AsString;
          ListItem.Checked := True;
          ListItem.SubItems.Add(Fields[0].AsString);
          Next;
        end;
      Close;
    end;


  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
     begin
       sWeek := 'week ';
       sYear := ' - year ';
       sFrom := ' from ';
       sTo   := ' to ';
     end;
    LANG_PORTUGUESE :
     begin
       sWeek := 'semana ';
       sYear := ' - ano ';
       sFrom := ' desde ';
       sTo   := ' até ';
     end;

    LANG_SPANISH :
     begin
       sWeek := 'semana ';
       sYear := ' - ano ';
       sFrom := ' desde ';
       sTo   := ' ate ';
     end;
  end;


end;

procedure TFinFluxoCaixa.RefreshLancamento;
var
   MyField: TField;
   MySqlStatement: TSQlStatement;
   Inicio, Fim : TDateTime;
begin
  inherited;
  // Ajusta a lente, o Grao explodido do fluxo de caixa
  if pnlLancamento.Visible then
    with quLancamento do
      begin
        // Calculas o Inicio e o Fim do Grao
        case cmbGranulacao.ItemIndex of
          0: // Ano
            begin
              Inicio := EncodeDate( quFluxoCaixaAno.AsInteger,
                                    1,
                                    1);
              Fim    := EncodeDate( quFluxoCaixaAno.AsInteger + 1,
                                    1,
                                    1);
            end;
          1: // Mes
            begin
              Inicio := EncodeDate( quFluxoCaixaAno.AsInteger,
                                    quFluxoCaixaGrao.AsInteger,
                                    1);

              if quFluxoCaixaGrao.AsInteger = 12 then
                Fim    := EncodeDate( quFluxoCaixaAno.AsInteger + 1,
                                      1,
                                      1)
              else
                Fim    := EncodeDate( quFluxoCaixaAno.AsInteger,
                                      quFluxoCaixaGrao.AsInteger + 1,
                                      1);
            end;
          2: // Semana
            begin
              Inicio := GetPrimeiroDomingo(quFluxoCaixaAno.AsInteger)
                            + (quFluxoCaixaGrao.AsInteger - 2) * 7;
              Fim    := GetPrimeiroDomingo(quFluxoCaixaAno.AsInteger)
                            + (quFluxoCaixaGrao.AsInteger - 1) * 7;
            end;
          3: // Dia
            begin
              Inicio := EncodeDate( quFluxoCaixaAno.AsInteger,
                                    1,
                                    1) + quFluxoCaixaGrao.AsInteger - 1;
              Fim    := EncodeDate( quFluxoCaixaAno.AsInteger,
                                    1,
                                    1) + quFluxoCaixaGrao.AsInteger;
            end;
        end;

        Close;

        MySqlStatement := UnMountSQL(OriginalSQLLanc);

        Parameters.ParamByName('DataInicio').Value := Inicio;
        Parameters.ParamByName('DataFim').Value    := Fim;

        MySqlStatement[ST_WHERE] := MySqlStatement[ST_WHERE] + MontaWhereClase;

        CommandText := MountSQL(MySqlStatement);

        Open;
      end;
end;

procedure TFinFluxoCaixa.quFluxoCaixaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshLancamento;
end;

procedure TFinFluxoCaixa.trmGOTimer(Sender: TObject);
begin
  inherited;
  Vez := not Vez;
  if not Vez then
    pnlAviso.Color := clMaroon
  else
    pnlAviso.ParentColor := True;

end;

procedure TFinFluxoCaixa.scCentroCustoChange(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;
end;

procedure TFinFluxoCaixa.cbCentroCustoClick(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;
end;

procedure TFinFluxoCaixa.btDetalheClick(Sender: TObject);
var
  ID1, ID2: String;
begin

  if FinLancamentoFch = nil then
    FinLancamentoFch := TFinLancamentoFch.Create(self);

  ID1 := quLancamentoIDLancamento.AsString;
  ID2 := '';

  if FinLancamentoFch.Start(btAlt, nil, False, ID1, ID2, '', '', nil) then
    btGoClick(nil);

end;

procedure TFinFluxoCaixa.dsLancamentoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  with quLancamento do
    btDetalhe.Enabled := NOT (EOF and BOF);

end;

procedure TFinFluxoCaixa.grdLancamento2DblClick(Sender: TObject);
begin
  inherited;
  if btDetalhe.Enabled then
    btDetalheClick(nil);
end;

procedure TFinFluxoCaixa.btMostraClick(Sender: TObject);
begin
  inherited;
  Splitter.Visible  := btMostra.Down;
  pnlLancamento.Visible := btMostra.Down;

  if btMostra.Down then
    RefreshLancamento;
end;


procedure TFinFluxoCaixa.grdFluxoCaixaCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;

end;
  {
  if (grdFluxoCaixa.CalcCellRow mod 2) = 0 then
    ABrush.color := cl3DLight
  else
    ABrush.Color := clWindow;

  if highlight then
    begin
      Afont.color := clHighLightText;
      ABrush.Color := clHighLight;
    end;

  if Field.FieldName = 'Saldo' then
    begin
      if Field.AsCurrency < 0 then
        begin
          ABrush.Color := $00CDCCFF;
          AFont.Color := clBlack;
        end
      else
        begin
          ABrush.Color := $00FFE0CC;
          AFont .Color := clBlack;
        end;
    end;

   }


procedure TFinFluxoCaixa.dsFluxoCaixaDataChange(Sender: TObject;
  Field: TField);
var
  x: boolean;

begin
  inherited;

  with quFluxoCaixa do
    x := (EOF and BOF);

  if btMostra.Down and x then
    btMostraClick(nil);

  btMostra.Enabled := not x;

end;

procedure TFinFluxoCaixa.btTodaPessoaClick(Sender: TObject);
begin
  inherited;
  scPessoa.LookUpValue := '';

end;


procedure TFinFluxoCaixa.grdFluxoCaixaDblClick(Sender: TObject);
begin
  inherited;
  if not btMostra.Down then
    begin
      btMostra.Down := True;
      btMostraClick(nil);
    end;
end;

procedure TFinFluxoCaixa.btNehumDetalheClick(Sender: TObject);
begin
  inherited;
  cbCentroCusto.Checked := False;
  cbLancamentoTipo.Checked := False;
  cbPessoaTipo.Checked := False;
  cbPessoa.Checked := False;
  cbEmpresa.Checked := False;
end;

procedure TFinFluxoCaixa.btTodosDetalhesClick(Sender: TObject);
begin
  inherited;
  cbCentroCusto.Checked := True;
  cbLancamentoTipo.Checked := True;
  cbPessoaTipo.Checked := True;
  cbPessoa.Checked := True;
  cbEmpresa.Checked := True;

end;

procedure TFinFluxoCaixa.Button1Click(Sender: TObject);
var
  i: integer;
begin
  inherited;
  // Marca todas as empresas
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
      Items[i].Checked := True;
  trmGo.Enabled := True;
      
end;

procedure TFinFluxoCaixa.Button2Click(Sender: TObject);
var
  i: integer;
begin
  inherited;
  // Desmarca todas as empresas
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
      Items[i].Checked := False;
  trmGo.Enabled := True;
end;

procedure TFinFluxoCaixa.btUpClick(Sender: TObject);
begin
  inherited;
  with quFluxoCaixa do
    if Active then Prior;
end;

procedure TFinFluxoCaixa.btDownClick(Sender: TObject);
begin
  inherited;
  with quFluxoCaixa do
    if Active then Next;

end;

procedure TFinFluxoCaixa.SpeedButton2Click(Sender: TObject);
var
  ID1, ID2: String;
begin

  if FinLancamentoFch = nil then
    FinLancamentoFch := TFinLancamentoFch.Create(self);

  ID1 := '';
  ID2 := '';

  if FinLancamentoFch.Start(btInc, nil, False, ID1, ID2, '', '', grdLancamento) then
    btGoClick(nil);

end;



procedure TFinFluxoCaixa.btPrintClick(Sender: TObject);
begin
  inherited;
  if PrintDialog.Execute then
    begin
      try
        quLancamento.DisableControls;
        ImpFluxo.FilterText := GetFilterText;
        ImpFluxo.Print;
      finally
        quLancamento.EnableControls;
      end;
    end;
end;

procedure TFinFluxoCaixa.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if PrintDialog.Execute then
    begin
      with ImpLancamento do
        begin
          with CustomTot do
            begin
              Clear;
              Add('Total Débito');
              Add(FloatToStrF(quFluxoCaixaDebito.AsFloat, ffCurrency, 20,2));
              Add('Total Crédito');
              Add(FloatToStrF(quFluxoCaixaCredito.AsFloat, ffCurrency, 20,2));
              Add('Saldo Corrente');
              Add(FloatToStrF(quFluxoCaixaSaldo.AsFloat, ffCurrency, 20,2));
            end;
          Print;
        end;
    end;
end;

procedure TFinFluxoCaixa.grdLancamento2CalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Field.FieldName = 'ValorNominal' then
    begin
      if quLancamentoPagando.AsBoolean then
        begin
          ABrush.Color := $00CDCCFF;
          AFont.Color := clBlack;
        end
      else
        begin
          ABrush.Color := $00FFE0CC;
          AFont .Color := clBlack;
        end;
    end;

end;

procedure TFinFluxoCaixa.quFluxoCaixaAfterOpen(DataSet: TDataSet);
var
  i: integer;
  SaldoAnterior: double;

begin
  inherited;
  // Percorro o fluxo calculando tudo e colocando em memoria para
  // o calc field recuperar

  with quFluxoCaixa do
    begin
      try
        DisableControls;
        First;

        // Variavel global que controla o deslocamento do ano
        PrimeiroAno := quFLuxoCaixaAno.AsInteger;

        // Dependendo da granulidade calculo o fator de conversao do ano
        case cmbGranulacao.ItemIndex of
          0: // Anual
            Fator := 1;
          1: // Mensal
            Fator := 12;
          2: // Semanal
            Fator := 52;
          3: // Diária
            Fator := 356;
        end;

        // Zera todos os saldos correntes
        for i := Low(aSaldoCorrente) to High(aSaldoCorrente) do
          aSaldoCorrente[i] := 0;

        if eSaldo.Text <> '' then
          SaldoAnterior := MyStrToFloat(eSaldo.Text)
        else
          SaldoAnterior := SaldoSistema;

        while not eof do
          begin
            // Calculo o indice de onde sera armazenado o saldo corrente
            i := (quFluxoCaixaAno.AsInteger - PrimeiroAno) *
                 Fator + quFluxoCaixaGrao.AsInteger;

            SaldoAnterior := SaldoAnterior +
                             quFluxoCaixaCredito.AsFloat -
                             quFluxoCaixaDebito.AsFloat;

            aSaldoCorrente[i] := SaldoAnterior;

            Next;
          end;
      finally
        First;
        EnableControls;
      end;
    end;
end;

procedure TFinFluxoCaixa.FormDestroy(Sender: TObject);
begin
  inherited;
  ParentBrwWaitFrm.Free;
end;



procedure TFinFluxoCaixa.grdLancamentoCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxDBTreeListColumn; const AText: String; AFont: TFont;
  var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean);
var
  G: TdxDBGrid;
begin
  if ANode.HasChildren then Exit;
  G := Sender as TdxDBGrid;

  if not ASelected  then
    begin
      if ANode.Parent = nil then // There is no groupping
        if ((egoLoadAllRecords in G.Options) and (ANode.Index mod 2 = 0))
          or (not (egoLoadAllRecords in G.Options)) and (G.DataSource.DataSet.RecNo mod 2 = 0) then
          AColor := clWindow
        else
          AColor := $00EEEEEE
      else
        if ANode.Index mod 2 = 0 then
          AColor := clWindow
        else
          AColor := $00EEEEEE;
    end;

end;

procedure TFinFluxoCaixa.btSelEmpresaClick(Sender: TObject);
begin
  inherited;
  if btSelEmpresa.Down then
    pnlEmpresa.Width := 150
  else
    pnlEmpresa.Width := 1;

end;

procedure TFinFluxoCaixa.lvEmpresaClick(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;

procedure TFinFluxoCaixa.grdFluxoCaixaCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxDBTreeListColumn; const AText: String; AFont: TFont;
  var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean);
var
  G: TdxDBGrid;
begin
  if ANode.HasChildren then Exit;
  G := Sender as TdxDBGrid;

  if AColumn.FieldName = 'Saldo' then
    if ANode.Values[AColumn.Index] < 0 then
      begin
        AColor := $00CDCCFF;
        AFont.Color := clWindowText;
      end
    else
      begin
        AColor := $00FFE0CC;
        AFont.Color := clWindowText;
      end
  else
    if not ASelected then
      begin
        if ANode.Parent = nil then // There is no groupping
          if ((egoLoadAllRecords in G.Options) and (ANode.Index mod 2 = 0))
            or (not (egoLoadAllRecords in G.Options)) and (G.DataSource.DataSet.RecNo mod 2 = 0) then
            AColor := clWindow
          else
            AColor := $00EEEEEE
        else
          if ANode.Index mod 2 = 0 then
            AColor := clWindow
          else
            AColor := $00EEEEEE;
      end;


end;

function TFinFluxoCaixa.RetornaNomeMes(iMes: Integer): String;
begin

  Case DMGlobal.IDLanguage of
    L_ENGLISH : Result := AEnglishLongMonth[iMes];
    L_PORTUGUESE : Result  := APortuguesLongMonth[iMes];
    L_SPANISH : Result := AEspanholLongMonth[iMes];
  end;

end;

function TFinFluxoCaixa.GetFilterText: String;
begin

  if not chkOpenRecord.Checked then
  begin
    Result := 'Todos os registros';

    if chkInterest.Checked then
      Result := Result + ' com juros '
    else
      Result := Result + ' sem juros ';
  end
  else
  begin
    Result := 'Registros em aberto';

    if chkInterest.Checked then
      Result := Result + ' com juros '
    else
      Result := Result + ' sem juros ';
  end;

  // Seta os parametros na query e da o requery
  // periodo
  Result := Result + '. Desde ' + FormatDateTime('ddddd', dbInicio.Date);
  Result := Result + ' ate ' + FormatDateTime('ddddd', dbFim.Date);

  // grao
  CASE cmbGranulacao.ItemIndex of
       0 : begin
           Result := Result + '. Agrupado por ano.';
           end;
       1 : begin
           Result := Result + '. Agrupado por mês.';
           end;
       2 : begin
           Result := Result + '. Agrupado por semana.';
           end;
       3 : begin
           Result := Result + '. Agrupado por dia.';
           end;
  END;

end;

Initialization
  RegisterClass(TFinFluxoCaixa);


end.
