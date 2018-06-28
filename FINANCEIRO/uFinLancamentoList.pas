unit uFinLancamentoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus,DBTables, StdCtrls,  ExtCtrls, Buttons, ComCtrls,
  uFinQuitacaoFch, uFinQuitacaoToolBarMover, uFinQuitacaoMoverHelp, Mask,
  checklst, dxBar, uParentList, dxDBGrid, dxGrClms, dxDBGridPrint,
  dxBarExtDBItems, dxBarExtItems, dxCntner, dxTL, dxDateEdit, uFinLancamentoQrp, dxDBCGrid,
  ImgList, dxDBTLCl, dxDBCtrl, ADODB, PowerADOQuery,
  RCADOQuery, SuperComboADO, dxEditor, dxExEdtr, dxEdLib, dxPSCore,
  dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT, DateBox;

type
  TFinLancamentoList = class(TParentList)
    pnlQuitaMulti: TPanel;
    efjdsfkhsdjfhnsjdkalfskda: TPanel;
    Panel6: TPanel;
    pnlQuitCmd: TPanel;
    pnlBrwQuitMulti: TPanel;
    Panel3: TPanel;
    wfsldkfiosdufciosuyixch: TPanel;
    btQuitaMulti: TSpeedButton;
    btCancelaMulti: TSpeedButton;
    quAQuitar: TRCADOQuery;
    dsAQuitar: TDataSource;
    lblTotalAQuitar: TLabel;
    lblTotalQuitado: TLabel;
    lblLines: TLabel;
    quAQuitarLancamentoTipo: TStringField;
    quAQuitarPessoa: TStringField;
    quAQuitarDataVencimento: TDateTimeField;
    quAQuitarValorNominal: TFloatField;
    quAQuitarValorAQuitar: TFloatField;
    quAQuitarIDLancamento: TIntegerField;
    quAQuitarTotalQuitado: TFloatField;
    quBrowseS: TStringField;
    quBrowseV: TStringField;
    quBrowseQ: TStringField;
    quBrowseSac: TIntegerField;
    CorConfirmado: TPanel;
    CorVencido: TPanel;
    CorQuitado: TPanel;
    CorCancelado: TPanel;
    CorJuridico: TPanel;
    quBrowseDataVencimento: TDateTimeField;
    quBrowseSituacao: TIntegerField;
    quBrowsePrevisao: TBooleanField;
    quBrowseIDLancamento: TIntegerField;
    quBrowseLancamentoTipo: TStringField;
    quBrowseDataLancamento: TDateTimeField;
    quBrowseDataInicioQuitacao: TDateTimeField;
    quBrowseDataFimQuitacao: TDateTimeField;
    quBrowsePagando: TBooleanField;
    quBrowseValorNominal: TFloatField;
    quBrowseTotalQuitado: TFloatField;
    quBrowseDesdobramentoTipo: TStringField;
    quBrowseNumDesdobramento: TStringField;
    quBrowseDocumentoTipo: TStringField;
    quBrowseNumDocumento: TStringField;
    quBrowseSigla: TStringField;
    trmGO: TTimer;
    lblTotal: TLabel;
    quBrowseDataEmissao: TDateTimeField;
    cmbData: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    cmbSituacao: TComboBox;
    btTodasPessoas: TButton;
    scPessoa: TSuperComboADO;
    pnlEmpresa: TPanel;
    Splitter2: TSplitter;
    lvEmpresa: TListView;
    btSelEmpresa: TSpeedButton;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    quBrowseIDEmpresa: TIntegerField;
    quBrowseCodigoEmpresa: TStringField;
    quBrowseEmpresa: TStringField;
    quBrowsePessoa: TStringField;
    brwGridDataVencimento: TdxDBGridDateColumn;
    brwGridIDLancamento: TdxDBGridMaskColumn;
    brwGridPessoa: TdxDBGridMaskColumn;
    brwGridLancamentoTipo: TdxDBGridMaskColumn;
    brwGridDataLancamento: TdxDBGridDateColumn;
    brwGridDataInicioQuitacao: TdxDBGridDateColumn;
    brwGridDataFimQuitacao: TdxDBGridDateColumn;
    brwGridValorNominal: TdxDBGridMaskColumn;
    brwGridTotalQuitado: TdxDBGridMaskColumn;
    brwGridDesdobramentoTipo: TdxDBGridMaskColumn;
    brwGridNumDesdobramento: TdxDBGridMaskColumn;
    brwGridDocumentoTipo: TdxDBGridMaskColumn;
    brwGridNumDocumento: TdxDBGridMaskColumn;
    brwGridDataEmissao: TdxDBGridDateColumn;
    brwGridCodigoEmpresa: TdxDBGridMaskColumn;
    brwGridEmpresa: TdxDBGridMaskColumn;
    bbQuita: TdxBarButton;
    bbQuitaMulti: TdxBarButton;
    bbHistorico: TdxBarButton;
    quBrowseMeioQuit: TStringField;
    quBrowseDocQuit: TStringField;
    brwGridMeioQuit: TdxDBGridMaskColumn;
    bsImprime: TdxBarSubItem;
    bbImprimeLancamento: TdxBarButton;
    grdAQuitar: TdxDBCGrid;
    grdAQuitarLancamentoTipo: TdxDBGridMaskColumn;
    grdAQuitarPessoa: TdxDBGridMaskColumn;
    grdAQuitarDataVencimento: TdxDBGridDateColumn;
    grdAQuitarValorNominal: TdxDBGridMaskColumn;
    grdAQuitarValorAQuitar: TdxDBGridMaskColumn;
    grdAQuitarTotalQuitado: TdxDBGridMaskColumn;
    brwGridSac: TdxDBGridImageColumn;
    brwGridHistorico: TdxDBGridBlobColumn;
    quBrowseAQuitar: TFloatField;
    brwGridAQuitar: TdxDBGridMaskColumn;
    quBrowseHistorico: TStringField;
    quBrowseDiscountValue: TFloatField;
    brwGridDiscountDate: TdxDBGridMaskColumn;
    brwGridDiscountValue: TdxDBGridMaskColumn;
    quBrowseDiscountDate: TDateTimeField;
    quBrowseFrequency: TStringField;
    brwGridFrequency: TdxDBGridMaskColumn;
    quBrowseLancamentoType: TIntegerField;
    quBrowseIDLancamentoParent: TIntegerField;
    imgLancType: TdxImageEdit;
    quBrowseIDPessoa: TIntegerField;
    quBrowseIDCashRegMov: TIntegerField;
    brwGridIDCashRegMov: TdxDBGridMaskColumn;
    quBrowseTotalJuros: TBCDField;
    brwGridTotalJuros: TdxDBGridColumn;
    quBrowseCheckNumber: TStringField;
    quBrowseCustomerDocument: TStringField;
    quBrowseCustomerName: TStringField;
    quBrowseCustomerPhone: TStringField;
    quBrowseBanco: TStringField;
    brwGridCheckNumber: TdxDBGridMaskColumn;
    brwGridCustomerDocument: TdxDBGridMaskColumn;
    brwGridCustomerName: TdxDBGridMaskColumn;
    brwGridCustomerPhone: TdxDBGridMaskColumn;
    brwGridBanco: TdxDBGridMaskColumn;
    quBrowseNumero: TStringField;
    brwGridNumero: TdxDBGridMaskColumn;
    dbFim: TDateBox;
    dbInicio: TDateBox;
    btnTaxes: TdxBarButton;
    quBrowseCostCenter: TStringField;
    brwGridCostCenter: TdxDBGridColumn;
    cbxShowDue: TCheckBox;
    quBrowseIDPreSale: TIntegerField;
    lbAmount: TLabel;
    edtAmount: TEdit;
    quBrowseSaleCode: TStringField;
    quBrowseInvoiceCode: TStringField;
    brwGridSaleCode: TdxDBGridColumn;
    brwGridInvoiceCode: TdxDBGridColumn;
    btnLoan: TdxBarButton;
    bbImprimeBoleto: TdxBarButton;
    bbExportarBoleto: TdxBarButton;
    quBrowseSystemUser: TStringField;
    brwGridSystemUser: TdxDBGridMaskColumn;
    quBrowseTipoMeioPag: TIntegerField;
    procedure quAQuitarAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btCancelaMultiClick(Sender: TObject);
    procedure btQuitaMultiClick(Sender: TObject);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure CommandClick(Sender: TObject);
    procedure brwGridDblClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure trmGOTimer(Sender: TObject);
    procedure dbInicioChange(Sender: TObject);
    procedure btTodasPessoasClick(Sender: TObject);
    procedure cmbSituacaoChange(Sender: TObject);
    procedure scPessoaSelectItem(Sender: TObject);
    procedure btSelEmpresaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure lvEmpresaClick(Sender: TObject);
    procedure bbQuitaClick(Sender: TObject);
    procedure bbQuitaMultiClick(Sender: TObject);
    procedure bbHistoricoClick(Sender: TObject);
    procedure bbListaImprimeClick(Sender: TObject);
    procedure bbImprimeLancamentoClick(Sender: TObject);
    procedure brwGridCustomDraw(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxDBTreeListColumn;
      const AText: String; AFont: TFont; var AColor: TColor; ASelected,
      AFocused: Boolean; var ADone: Boolean);
    procedure imgLancTypeChange(Sender: TObject);
    procedure btnTaxesClick(Sender: TObject);
    procedure edtAmountKeyPress(Sender: TObject; var Key: Char);
    procedure btnLoanClick(Sender: TObject);
    procedure bbImprimeBoletoClick(Sender: TObject);
    procedure bbExportarBoletoClick(Sender: TObject);
  private
    //Translation
    sReceive,
    sRecMult,
    sLines,
    sTotalPaid,
    sTotalRecv,
    sTotalToBePaid,
    sTotalToBerecv,
    sRecords,
    sWith,
    sBetween,
    sAnd,
    sCompany : String;

    Tot, TotAQuitar, TotQuitado: Currency;

    FinQuitacaoFch : TFinQuitacaoFch;
    FinQuitacaoToolBarMover: TFinQuitacaoToolBarMover;
    OriginalAQuitarHeight: Integer;
    OriginalBrowseHeight: Integer;

    function OnTestDelete: Boolean; override;
    procedure OnAfterDeleteItem; override;
    procedure OnAfterRestoreItem; override;
    procedure OnAfterStart; override;
    procedure FchCreate;
    procedure AjustaAAQuitarHeight;
    function ValidateLancamento : Boolean;
  public
    FinQuitacaoMoverHelp: TFinQuitacaoMoverHelp;
    function  ListParamRefresh : integer; override;
    procedure IncluiSelecionado;
    procedure IncluiVisao;
    procedure ExcluiSelecionado;
    procedure ExcluiTodos;
  protected
    Pagando: Boolean;
    Realizado: Boolean;
    LancType: Integer;
  end;

implementation

{$R *.DFM}

uses uDM, uMsgBox, uFinChoicerFrm, uSystemTypes, uFinLancamentoFch,
     uFinLancamentoCalc, uDateTimeFunctions, uMsgConstant, uDMGlobal,
     uFinTaxComper, uCharFunctions, uNumericFunctions, uFinEmprestimoFrm,
  uFrmPrintBoleto, uFrmExportBoleto;

procedure TFinLancamentoList.OnAfterRestoreItem;
begin
  case quBrowseLancamentoType.AsInteger of
    FIN_LANCAMENTO_PARENT: UpdateStatusChildren(quBrowseIDLancamento.AsString);
    FIN_LANCAMENTO_CHILD : UpdateStatusParent(quBrowseIDLancamento.AsString,
                                              quBrowseIDLancamentoParent.AsString);
  end;
end;

procedure TFinLancamentoList.OnAfterDeleteItem;
begin
  //Delete ou Restore disbersements
  case quBrowseLancamentoType.AsInteger of
    FIN_LANCAMENTO_PARENT: UpdateStatusChildren(quBrowseIDLancamento.AsString);
    FIN_LANCAMENTO_CHILD:
    begin
      UpdateStatusParent(quBrowseIDLancamento.AsString,
                         quBrowseIDLancamentoParent.AsString);
      UpdateTotalDisbursement(quBrowseIDLancamentoParent.AsString);
    end;
  end;
end;

function TFinLancamentoList.ListParamRefresh : Integer;
var
  InicioStr, FimStr, ShowDue: String;
  i: integer;
  Todos: Boolean;
begin
  // Testa se das datas de período são válidas
  if not TestDate(dbInicio.Text) then
  begin
    MsgBox(MSG_CRT_NO_VALID_INIDATE, vbCritical + vbOkOnly);
    dbInicio.SetFocus;
    Exit;
  end;

  if not TestDate(dbFim.Text) then
  begin
    MsgBox(MSG_CRT_NO_VALID_FIMDATE, vbCritical + vbOkOnly);
    dbFim.SetFocus;
    Exit;
  end;

  // Filtro por situacao
  case cmbSituacao.ItemIndex of
    0:// Aberto
      WhereBasicFilter[3] := '(L.Situacao IN (1, 5) AND (IsNull((L.ValorNominal - L.TotalQuitado),0) <> 0))';
    1:// Parte Quitado
      WhereBasicFilter[3] := '((L.Situacao = 5) AND (IsNull((L.ValorNominal - L.TotalQuitado),0) <> 0))';
    2:// Quitado e Conta da loja quitado pelo MR
      WhereBasicFilter[3] := '((L.Situacao = 2) OR (MP.Tipo = 9 AND ((L.ValorNominal - L.TotalQuitado) = 0)))';
    3:// Cancelados
      WhereBasicFilter[3] := '((L.Situacao = 4) AND (IsNull((L.ValorNominal - L.TotalQuitado),0) <> 0))';
    4:// Todos
      WhereBasicFilter[3] := '';
  end;

  // altera qual o filtro por data
  InicioStr := Chr(39) + FormatDateTime('mm/dd/yyyy', dbInicio.Date) + Chr(39);
  FimStr    := Chr(39) + FormatDateTime('mm/dd/yyyy', dbFim.Date + 1) + Chr(39);
  case cmbData.ItemIndex of
    0: // Data de Lançamento
      WhereBasicFilter[4] := ' DataLancamento >= ' + InicioStr + ' AND DataLancamento < ' + FimStr;
    1: // Data de Emissão
      WhereBasicFilter[4] := ' DataEmissao >= ' + InicioStr + ' AND DataEmissao < ' + FimStr;
    2: // Data de Vencimento
      begin
        if cbxShowDue.Checked then
          ShowDue := ' OR (DataVencimento < GetDate() AND L.TotalQuitado < L.ValorNominal) ';
        WhereBasicFilter[4] := ' (((DataVencimento >= ' + InicioStr + ' AND DataVencimento < ' + FimStr + ') ' +
                               '   OR (DateAdd(day, -1*LAT.DueDateShift, L.DataVencimento) >= ' + InicioStr + ' AND DateAdd(day, -1*LAT.DueDateShift, L.DataVencimento) < ' + FimStr + ') ) ' + ShowDue + ')';
      end;
    3: // Data de Início da Quitação
      WhereBasicFilter[4] := ' DataInicioQuitacao >= ' + InicioStr + ' AND DataInicioQuitacao < ' + FimStr;
    4: // Data de Fim da Quitação
      WhereBasicFilter[4] := ' DataFimQuitacao >= ' + InicioStr + ' AND DataFimQuitacao < ' + FimStr;
    5: // Data de Pagamento
      WhereBasicFilter[4] := ' DataFimQuitacao >= ' + InicioStr + ' AND DataFimQuitacao < ' + FimStr;

  end;

  // Altera o filtro por pessoa
  if scPessoa.LookUpValue = '' then
    WhereBasicFilter[5] := ''
  else
    WhereBasicFilter[5] := ' L.IDPessoa = ' + scPessoa.LookUpValue;

  // Aplica o filtro de empresas
  WhereBasicFilter[6] := '';
  Todos := True;
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
    begin
      Todos := Todos AND Items[i].Checked;
      if Items[i].Checked then
      begin
        if WhereBasicFilter[6] <> '' then
          WhereBasicFilter[6] := WhereBasicFilter[6] + ' OR '
        else
          WhereBasicFilter[6] := WhereBasicFilter[6] + ' ( ';

        WhereBasicFilter[6] := WhereBasicFilter[6] + 'L.IDEmpresa = ' + Items[i].SubItems[0];
      end;
    end;

  if WhereBasicFilter[6] <> '' then
    WhereBasicFilter[6] := WhereBasicFilter[6] + ' ) ';

  if Todos then
    WhereBasicFilter[6] := '';

  if imgLancType.Text = '0' then
    WhereBasicFilter[7] := '((IsNull(L.LancamentoType,0) = 0) OR (L.LancamentoType = 2))'
  else
    WhereBasicFilter[7] := 'L.LancamentoType = 1'; 


  if (edtAmount.Text <> '') and (MyStrToCurrency(edtAmount.Text) <> 0) then
  begin
    WhereBasicFilter[8] := 'L.ValorNominal = ' + MyFormatCur(MyStrToCurrency(edtAmount.Text), '.');
    WhereBasicFilter[3] := '';
    WhereBasicFilter[4] := '';
    WhereBasicFilter[5] := '';
    WhereBasicFilter[6] := '';
  end
  else
    WhereBasicFilter[8] := '';

  ListRefresh;
  trmGo.Enabled := False;
  pnlExecutaAviso.ParentColor := True;
  DesligaAviso;
end;

function TFinLancamentoList.OnTestDelete: Boolean;
begin
  // Testa se o lancamento já esta quitado
  if quBrowseTotalQuitado.AsCurrency <> 0 then
    begin
      MsgBox(MSG_CRT_NO_DEL_RECORD_DETAIL, vbCritical + vbOkOnly );
      Result := False;
    end
  else
    Result := True;
end;

procedure TFinLancamentoList.OnAfterStart;
begin
  // Controla o modo de abertura do Browse
  // A Browse esta configurado para nao abrir automaticamente

  dbInicio.Date := InicioMes(Date());
  dbFim.Date    := FimMes(Date());

  cmbData.ItemIndex := 2;

  btTodasPessoasClick(nil);

  if DM.TaxInCost then
     btnTaxes.Visible := ivAlways
  else
     btnTaxes.Visible := ivNever;

  if Trim(MyParametro) =  'ContasAReceber' then
    begin
      Pagando := False;
      Realizado := False;
      cmbSituacao.Visible := True;
      cmbSituacao.ItemIndex := 0;
      WhereBasicFilter[1] := 'L.Pagando = 0';
      bbQuita.Visible := ivAlways;
      bbQuitaMulti.Visible := ivAlways;
      bbQuita.Caption := sReceive;
      bbQuitaMulti.Caption := sRecMult;
      HelpContext := 17;
    end
  else if Trim(MyParametro) = 'ContasRecebidas' then
    begin
      Pagando := False;
      Realizado := True;
      cmbSituacao.Visible := False;
      WhereBasicFilter[1] := 'L.Pagando = 0';
      WhereBasicFilter[2] := 'L.Situacao = ' + IntToStr(DM.SitQuitado);
      bbQuita.Visible := ivNever;
      bbQuitaMulti.Visible := ivNever;
              HelpContext := 17;
    end
  else if Trim(MyParametro) = 'ContasAPagar' then
    begin
      Pagando := True;
      Realizado := False;
      cmbSituacao.Visible := True;
      cmbSituacao.ItemIndex := 0;
      WhereBasicFilter[1] := 'L.Pagando = 1';
      bbQuita.Visible := ivAlways;
      bbQuitaMulti.Visible := ivAlways;
      HelpContext := 14;
    end
  else if Trim(MyParametro) = 'ContasPagas' then
    begin
      Pagando := True;
      Realizado := True;
      cmbSituacao.Visible := False;
      WhereBasicFilter[1] := 'L.Pagando = 1';
      WhereBasicFilter[2] := 'L.Situacao = ' + IntToStr(DM.SitQuitado);
      bbQuita.Visible := ivNever;
      bbQuitaMulti.Visible := ivNever;
      HelpContext := 14;
    end;

  btSelEmpresaClick(nil);
end;

procedure TFinLancamentoList.AjustaAAQuitarHeight;
var
   NewHeight: Integer;

begin
  // Controla o tamanho da lista na tela
  if quAQuitar.RecordCount > 3 then
    begin
      NewHeight := (quAQuitar.RecordCount - 3) * 15;
      if NewHeight < (OriginalBrowseHeight * 0.20) then
        begin
          pnlQuitaMulti.Height := NewHeight + OriginalAQuitarHeight;
        end
      else
        begin
          // Pega o proximo multiplo que pode chegar e aplica
          pnlQuitaMulti.Height := Trunc((OriginalBrowseHeight * 0.20) / 15) * 15 + OriginalAQuitarHeight;
        end
    end
  else
    begin
      pnlQuitaMulti.Height := OriginalAQuitarHeight;
    end;
end;

procedure TFinLancamentoList.quAQuitarAfterOpen(DataSet: TDataSet);
var
   TotalAQuitar, TotalQuitado: Currency;
   BO: TBookMarkStr;

begin
  inherited;
  btTodasPessoasClick(nil);

  with quAQuitar do
    begin
      DisableControls;
      TotalAQuitar := 0;
      TotalQuitado := 0;
      BO := BookMark;
      First;
      While not EOF do
        begin
          TotalAQuitar  := TotalAQuitar + quAQuitarValorAQuitar.AsCurrency;
          TotalQuitado  := TotalQuitado + quAQuitarTotalQuitado.AsCurrency;
          Next;
        end;

      BookMark := BO;
      EnableControls;
    end;

  lblLines.Caption := sLines + IntToStr(quAQuitar.RecordCount);
  lblTotalQuitado.Caption := FloatToStrF(TotalQuitado, ffCurrency, 20, 2);
  lblTotalAQuitar.Caption := FloatToStrF(TotalAQuitar, ffCurrency, 20, 2);

end;

procedure TFinLancamentoList.IncluiSelecionado;
var
   BMB, BMQ: TBookMarkStr;
   RequeryAQuitar: Boolean;
   i: integer;

begin

  try

    // Guardo onde estava
    BMB := quBrowse.BookMark;
    BMQ := quAQuitar.BookMark;

    // Deligo os controles, para performace
    quBrowse.DisableControls;
    quAQuitar.DisableControls;

    RequeryAQuitar := False;

    // Intero pelas linhas selecionadas
    for i := 0 to brwGrid.SelectedCount -1 do
      begin
        quBrowse.BookMark := brwGrid.SelectedRows[i];

        // Se não exitir na tabela de AQuitar, incluo
        if not (quAquitar.Locate('IDLancamento', quBrowse.FieldByName('IDLancamento').AsString, [])) then
           if (quBrowse.FieldByName('Situacao').AsInteger <> 2) and (ValidateLancamento) then
           begin
             InsereAQuitar(quBrowse.FieldByName('IDLancamento').AsInteger, False);
             RequeryAQuitar := True;
           end;
      end;

    // Se houve alteracao no lista de AQuitar dou o refresh
    if RequeryAQuitar then
      quAQuitar.Requery
    else
      quAQuitar.BookMark := BMQ;

    AjustaAAQuitarHeight;

  finally
    quBrowse.BookMark := BMB;
    quBrowse.EnableControls;
    quAQuitar.EnableControls;
  end;


end;

procedure TFinLancamentoList.IncluiVisao;
var
   SQL: String;
   BO: TBookMarkStr;

begin
  DeleteAQuitar(-1);
  with quBrowse do
    begin
      DisableControls;
      BO := BookMark;
      If not Active then
         Open;
      First;
      while NOT EOF do
        begin
        if quBrowse.FieldByName('Situacao').AsInteger <> 2 then
           InsereAQuitar(FieldByName('IDLancamento').AsInteger, False);
        Next;
        end;

      BookMark := BO;
      EnableControls;
    end;
  quAQuitar.Requery;
  AjustaAAQuitarHeight;
end;

procedure TFinLancamentoList.ExcluiSelecionado;
begin
  DeleteAQuitar(quAQuitarIDLancamento.AsInteger);
  quAQuitar.Requery;
  AjustaAAQuitarHeight;
end;

procedure TFinLancamentoList.ExcluiTodos;
begin
  DeleteAQuitar(-1);
  quAQuitar.Requery;
  AjustaAAQuitarHeight;
end;

procedure TFinLancamentoList.FchCreate;
begin
  // Caso necessario cria a ficha de pagamento.
  if brwForm = Nil then
    begin
      brwForm := TFinLancamentoFch.Create(Self);
      TFinLancamentoFch(brwForm).setPagando(Pagando);
    end;

  TFinLancamentoFch(brwForm).setLancType(LancType);

end;

procedure TFinLancamentoList.FormCreate(Sender: TObject);
var
  ListItem: TListItem;

begin
  inherited;
  OriginalAQuitarHeight := pnlQuitaMulti.Height;
  OriginalBrowseHeight := pnlBrowse.Height;

  // Caheia em variaveis as constantes que seram testadas nos laços
  // de paint do Grid
  DM.CreateLancSituacao;

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

  bbImprimeLancamento.Enabled := (DMGlobal.IDLanguage = LANG_PORTUGUESE);

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sReceive       := 'Receive';
           sRecMult       := 'Receive multiple';
           sLines         := 'Lines: ';
           sTotalPaid     := 'Total paid: ';
           sTotalRecv     := 'Total received: ';
           sTotalToBePaid := 'Total to be paid: ';
           sTotalToBeRecv := 'Total to be received: ';
           sRecords       := 'Records ';
           sWith          := ' with ';
           sBetween       := ' between ';
           sAnd           := ' and ';
           sCompany       := '. Company: ';
           end;
    LANG_PORTUGUESE :
           begin
           sReceive       := 'Recebido';
           sRecMult       := 'Recebimento Múltiplo';
           sLines         := 'Linhas: ';
           sTotalPaid     := 'Total pago: ';
           sTotalRecv     := 'Total recebido: ';
           sTotalToBePaid := 'Total a pagar: ';
           sTotalToBeRecv := 'Total a receber: ';
           sRecords       := 'Registros ';
           sWith          := ' com ';
           sBetween       := ' entre ';
           sAnd           := ' e ';
           sCompany       := '. Empresa: ';
           end;

    LANG_SPANISH :
           begin
           sReceive       := 'Recibido';
           sRecMult       := 'Recibimento Múltiple';
           sLines         := 'Líneas: ';
           sTotalPaid     := 'Total pagado: ';
           sTotalRecv     := 'Total recibido: ';
           sTotalToBePaid := 'Total a pagar: ';
           sTotalToBeRecv := 'Total a reciber: ';
           sRecords       := 'Registros ';
           sWith          := ' com ';
           sBetween       := ' entre ';
           sAnd           := ' y ';
           sCompany       := '. Empresa: ';
           end;
  end;

end;

procedure TFinLancamentoList.btCancelaMultiClick(Sender: TObject);
begin
  inherited;
  // Some com o panel de multi quitacao
  pnlQuitaMulti.Visible := False;

  // Religa os botões de quitacao
  bbQuita.Visible      := ivAlways;
  bbQuitaMulti.Visible := ivAlways;

  // Some com o Mover
  FinQuitacaoToolBarMover.Close;

  // Limpa a tabela temporaria
  DeleteAQuitar(-1);

end;

procedure TFinLancamentoList.btQuitaMultiClick(Sender: TObject);
var
   ID1, ID2: String;
   function CanPayMultiple:Boolean;
   var Entity : String;
   begin
   Result := True;

   if not quAQuitar.Active then
      Exit;

      with quAQuitar do
          Try
            DisableControls;
            First;
            Entity := quAQuitarPessoa.AsString;
            while not(EOF) do
               if Entity <> quAQuitarPessoa.AsString then
                  begin
                  Result := False;
                  Break;
                  Exit;
                  end
               else
                  Next;
          finally
            EnableControls;
          end;

   end;

begin
  inherited;

  {
  //So pode pagar se for Entity do mesmo type
  if not CanPayMultiple then
     begin
     MsgBox(MSG_INF_NOT_PAY_DIFFER_ENTITY, vbInformation + vbOkOnly);
     Exit;
     end;
  }
  
  // Abre a ficha de pagamento.
  if FinQuitacaoFch = nil then
    FinQuitacaoFch := TFinQuitacaoFch.Create(Self);

  // Seta o parametro que vai ser passado para a ficha
  if Self.Pagando then
    FinQuitacaoFch.Param := 'Pagando=1'
  else
    FinQuitacaoFch.Param := 'Pagando=0';

  if FinQuitacaoFch.Start(btInc, nil, False, ID1, ID2, '', MyUserRights, nil) then
    begin
      ListRefresh;
      btCancelaMultiClick(nil);
    end;

end;

procedure TFinLancamentoList.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  // caso alguma linha do browse seja alterada, o lista deverá refletir estas
  // modificaoes.
  // So se estiver durante uma quitacao multipla

  if pnlQuitaMulti.Visible then
    quAQuitar.Requery;

  with quBrowse do
    begin
      DisableControls;
      First;
      Tot := 0;
      TotQuitado := 0;
      TotAQuitar := 0;
      while not EOF do
        begin
          Tot := Tot + quBrowseValorNominal.AsCurrency;
          TotAQuitar := TotAQuitar + (quBrowseValorNominal.AsCurrency) - (quBrowseTotalQuitado.AsCurrency);
          TotQuitado := TotQuitado + quBrowseTotalQuitado.AsCurrency;
          Next;
        end;
      First;
      EnableControls;
    end;

  if Realizado then
    begin
      if Pagando then
        lblTotal.Caption := sTotalPaid + FloatToStrF(TotQuitado, ffCurrency, 20, 2)
      else
        lblTotal.Caption := sTotalRecv + FloatToStrF(TotQuitado, ffCurrency, 20, 2);
    end
  else
    begin
      if Pagando then
        lblTotal.Caption := sTotalToBePaid + FloatToStrF(TotAQuitar, ffCurrency, 20, 2)
      else
        lblTotal.Caption := sTotalToBerecv + FloatToStrF(TotAQuitar, ffCurrency, 20, 2);
    end;

end;

procedure TFinLancamentoList.CommandClick(Sender: TObject);
var
  pCommand : TBtnCommandType;
  iRes : integer;
begin

  pCommand := TBtnCommandType(TComponent(Sender).Tag);

  case pCommand of
       btInc  : begin
                with TFinchoicerFrm.Create(Self) do
                     iRes := Start(CHOICE_DOCUMENT_TYPE);

                Case iRes of
                     -1 : exit;
                      1 : LancType := FIN_LANCAMENTO_SINGLE; //Fin Lancamento
                      2 : LancType := FIN_LANCAMENTO_PARENT; //Fin Lancamento Parent
                end;
                end;

       btAlt : begin
                 LancType := quBrowseLancamentoType.AsInteger;
               end;

       btExc : begin
                 if not quBrowse.FieldByName('IDPreSale').IsNull then
                 begin
                   MsgBox(MSG_CRT_NO_DEL_SYSTEM_PAYMENT, vbCritical + vbOKOnly);
                   Exit;
                 end;
               end;
  end;

  // Coloca se necessario a ficha de lancamento na memoria
  FchCreate;


  inherited;

end;


procedure TFinLancamentoList.brwGridDblClick(Sender: TObject);
begin

  LancType := quBrowseLancamentoType.AsInteger;

  FchCreate;
  inherited;

end;

procedure TFinLancamentoList.quBrowseCalcFields(DataSet: TDataSet);
var
  PorraCase: Integer;
begin
  inherited;
  {
        Situações (quBrowseSituacao)
          1 - Aberto
          2 - Quitado
          3 - Juridico
          4 - Cancelado
          5 - Parte quitado

        Sub-situação (quBrowseSAC)
          0 - Aberto
          1 - Confirmado
          2 - Vencido
          3 - Quitado
          4 - Parte quitado
          5 - Juridico
          6 - Cancelado
  }

  //Tratamento para conta da loja
  if (quBrowseTipoMeioPag.AsInteger = 9) and (quBrowseAQuitar.AsCurrency = 0) then
    PorraCase := DM.SitQuitado
  else
    PorraCase := quBrowseSituacao.AsInteger;

  if PorraCase = DM.SitCancelado then
    quBrowseSac.AsInteger := 6
  else if PorraCase = DM.SitJuridico then
    quBrowseSac.AsInteger := 5
  else if (PorraCase = DM.SitQuitado) then
    quBrowseSac.AsInteger := 3
  else if PorraCase = DM.SitParteQuitado then
    quBrowseSac.AsInteger := 4
  else if quBrowseDataVencimento.AsDateTime < Now then
    quBrowseSac.AsInteger := 2
  else if quBrowsePrevisao.AsBoolean then
    quBrowseSac.AsInteger := 0
  else
    quBrowseSac.AsInteger := 1;

  if imgLancType.Text <> '0' then
     quBrowseSac.AsInteger := -1;
end;

procedure TFinLancamentoList.trmGOTimer(Sender: TObject);
begin
  inherited;

  if pnlExecutaAviso.ParentColor then
    pnlExecutaAviso.Color := clMaroon
  else
    pnlExecutaAviso.ParentColor := True;

end;

procedure TFinLancamentoList.dbInicioChange(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;

procedure TFinLancamentoList.btTodasPessoasClick(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

  scPessoa.LookUpValue := '';

end;

procedure TFinLancamentoList.cmbSituacaoChange(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;

procedure TFinLancamentoList.scPessoaSelectItem(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;

procedure TFinLancamentoList.btSelEmpresaClick(Sender: TObject);
begin
  inherited;
  if btSelEmpresa.Down then
    pnlEmpresa.Width := 150
  else
    pnlEmpresa.Width := 1;

end;


procedure TFinLancamentoList.Button1Click(Sender: TObject);
var
  i: integer;
begin
  inherited;
  trmGo.Enabled := True;
  // Marca todas as empresas
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
      Items[i].Checked := True;
end;

procedure TFinLancamentoList.Button2Click(Sender: TObject);
var
  i: integer;
begin
  inherited;
  trmGo.Enabled := True;
  // Desmarca todas as empresas
  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
      Items[i].Checked := False;
end;

procedure TFinLancamentoList.lvEmpresaClick(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

end;


procedure TFinLancamentoList.bbQuitaClick(Sender: TObject);
var
   ID1, ID2: String;

begin
  inherited;

  if (not OnBeforePay) then
    Exit;

  if (not ValidateLancamento) then
  begin
    MsgBox(MSG_CRT_SA_PAYMENT, vbCritical + vbOkOnly);
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
    DeleteAQuitar(-1);
  end;


  //Se o documento tiver mais de uma parte
  if quBrowseIDLancamentoParent.AsInteger <> 0 then
     begin
     if MsgBox(MSG_QST_DOC_SPLITED_PAY_ALL + #13#10, vbQuestion + vbYesNo) = vbYes then
        InsereAQuitar(quBrowse.FieldByName('IDLancamentoParent').AsInteger, True)
     else
        InsereAQuitar(quBrowse.FieldByName('IDLancamento').AsInteger, False);
     end
  else
     // Inclui o registro selecionado na tabela temporária.
     InsereAQuitar(quBrowse.FieldByName('IDLancamento').AsInteger, False);


  // Caso necessario cria a ficha de pagamento.
  if FinQuitacaoFch = Nil then
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
    end;

  OnAfterPay;

end;

procedure TFinLancamentoList.bbQuitaMultiClick(Sender: TObject);
var
  PID1, PID2:   String;

begin
  inherited;

  if pnlQuitaMulti.Visible then
     Exit;
     
  // Os lancamentos a serem quitados são passados para a ficha de quitacao
  // atraves da tabela temporaria #AQuitar.

  // Abre o help do mover
  if FinQuitacaoMoverHelp = Nil then
     FinQuitacaoMoverHelp := TFinQuitacaoMoverHelp.Create(Self);
  FinQuitacaoMoverHelp.ShowModal;

  bbQuita.Visible      := ivNever;
  // Some com os botoes de quitacao - Access Vialotion
  //bbQuitaMulti.Visible := ivNever;


  // Abre a Toolbar do Mover
  if FinQuitacaoToolBarMover = Nil then
     FinQuitacaoToolBarMover := TFinQuitacaoToolBarMover.Create(Self);
  FinQuitacaoToolBarMover.Show;


  // Mostra o Panel de MultiQuitacao
  pnlQuitaMulti.Visible := True;

  // Tenta criar a Tabela Temporária no Server
  // se não conseguir e porque ela já existe.
  try
    CreateAQuitar;
  except
    // Como existe esvazia a tabela temporaria.
    DeleteAQuitar(-1);
  end;

  // Liga o grid e o Total
  quAQuitar.Close;
  quAQuitar.Open;



end;

procedure TFinLancamentoList.bbHistoricoClick(Sender: TObject);
begin
  inherited;
  brwGrid.ColumnByFieldName('LancamentoTipo').Visible := not bbHistorico.Down;

  if bbHistorico.Down then
    brwGrid.Options := brwGrid.Options + [egoPreview]
  else
    brwGrid.Options := brwGrid.Options - [egoPreview];

end;

procedure TFinLancamentoList.bbListaImprimeClick(Sender: TObject);
var
 i: Integer;
 ListaDeEmpresas: String;

begin
  // Ajusta os Multiplos totais dos lancamentos
  with dxDBGridPrint.CustomTot do
    begin
      Clear;
      if Pagando then
        begin
          Add('Total');
          Add(FloatToStrF(Tot, ffCurrency, 20, 2));
          Add(sTotalPaid);
          Add(FloatToStrF(TotQuitado, ffCurrency, 20, 2));
          Add(sTotalToBePaid);
          Add(FloatToStrF(TotAQuitar, ffCurrency, 20, 2));
        end
      else
        begin
          Add('Total');
          Add(FloatToStrF(Tot, ffCurrency, 20, 2));
          Add(sTotalRecv);
          Add(FloatToStrF(TotQuitado, ffCurrency, 20, 2));
          Add(sTotalToBeRecv);
          Add(FloatToStrF(TotAQuitar, ffCurrency, 20, 2));
        end;
    end;

  MyReportFilter := sRecords +
                    LowerCase(cmbSituacao.text) +
                    sWith +
                    LowerCase(cmbData.text) +
                    sBetween +
                    FormatDateTime('mm/dd/yyyy', dbInicio.Date) +
                    sAnd +
                    FormatDateTime('mm/dd/yyyy', dbFim.Date) +
                    sCompany;

  with lvEmpresa do
    for i := 0 to Items.Count - 1 do
      if Items[i].Checked then
         begin
           if ListaDeEmpresas <> '' then
             ListaDeEmpresas := ListaDeEmpresas + ', ';

           ListaDeEmpresas := ListaDeEmpresas + Items[i].Caption;
         end;

  MyReportFilter := MyReportFilter + ListaDeEmpresas;


  // Ajusta o filtro
  with dxDBGridPrint do
  begin
    FilterText := MyReportFilter;
  end;

  inherited;

end;

procedure TFinLancamentoList.bbImprimeLancamentoClick(Sender: TObject);
var
  Where, sTitle: String;
  i: integer;
begin
  inherited;
  // Imprime os lancamentos em formato detalhado
    if brwGrid.SelectedCount = 0 then
    begin
      MsgBox(MSG_CRT_NO_RECORD, vbCritical + vbOkOnly);
      Exit;
    end;

  // Monta a clausula where com as quitacaoes selecionadas
  with brwGrid, brwGrid.datasource.dataset do
    begin
      DisableControls;
      for i:= 0 to SelectedCount-1 do
        begin
       	  BookMark := SelectedRows[i];

          if Where <> '' then
            Where := Where + ' OR '
          else
            Where := 'WHERE ';


       	  Where := Where + '(IDLancamento = ' + FieldByName('IDLancamento').asString + ')';
        end;
      EnableControls;
    end;

  // Realiza a impressao dos cheques
  if Pagando then
    sTitle := 'Comprovante de Pagamento';

  with TFinLancamentoQrp.Create(self) do
    begin
      Start(Where, sTitle);
      Free;
    end;

end;

procedure TFinLancamentoList.brwGridCustomDraw(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxDBTreeListColumn; const AText: String; AFont: TFont;
  var AColor: TColor; ASelected, AFocused: Boolean; var ADone: Boolean);
var
  G: TdxDBGrid;
begin
  // inherited;

  if ANode.HasChildren then Exit;
  G := Sender as TdxDBGrid;

  if not ASelected  then
    begin

      if ANode.Values[brwGridDiscountValue.Index] <> null then
        AColor := $00F0F0FF
      else
        begin
          if (not (egoPreview in G.Options)) AND (ANode.Index mod 2 = 0) then
            AColor := clWindow
          else
            AColor := $00EEEEEE;
        end;

    end;

  if ANode.Selected then
     begin
     AColor := G.HighlightColor;
     AFont.Color := $00EEEEEE;
     end;

end;

procedure TFinLancamentoList.imgLancTypeChange(Sender: TObject);
begin
  inherited;
  trmGo.Enabled := True;

  if imgLancType.Text = '0' then
     begin
     bbQuita.Visible               := ivAlways;
     bbQuitaMulti.Visible          := ivAlways;
     brwGridLancamentoTipo.Visible := True;
     cmbSituacao.Enabled           := True;
     end
  else
     begin
     bbQuita.Visible               := ivNever;
     bbQuitaMulti.Visible          := ivNever;
     brwGridLancamentoTipo.Visible := False;
     cmbSituacao.ItemIndex         := 3;
     cmbSituacao.Enabled           := False;
     end;

   ListParamRefresh;

end;

procedure TFinLancamentoList.btnTaxesClick(Sender: TObject);
begin
  inherited;
  with TFinTaxComper.Create(Self) do
     Start;
end;

procedure TFinLancamentoList.edtAmountKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateCurrency(Key);
end;

procedure TFinLancamentoList.btnLoanClick(Sender: TObject);
begin
  inherited;
  with TFinEmprestimoFrm.Create(Self) do
  try
    Start;
  finally
    Free;
  end
end;

procedure TFinLancamentoList.bbImprimeBoletoClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  // Imprime os boletos dos lançamentos selecionados
  if brwGrid.SelectedCount = 0 then
  begin
    MsgBox(MSG_CRT_NO_RECORD, vbCritical + vbOkOnly);
    Exit;
  end;

  // Faz a chamada do objeto de impressão para cada lançamento
  with brwGrid, brwGrid.datasource.dataset do
  try
    DisableControls;

    for i := 0 to Pred(SelectedCount) do
    begin
      BookMark := SelectedRows[i];

      with TFrmPrintBoleto.Create(Self) do
        Start(quBrowseIDLancamento.AsInteger);
    end;
  finally
    EnableControls;
  end;
end;

procedure TFinLancamentoList.bbExportarBoletoClick(Sender: TObject);
var
  i: Integer;
  LancamentoList: array of Integer;
begin
  inherited;
  // Imprime os boletos dos lançamentos selecionados
  if brwGrid.SelectedCount = 0 then
  begin
    MsgBox(MSG_CRT_NO_RECORD, vbCritical + vbOkOnly);
    Exit;
  end;

  // Faz a chamada do objeto de impressão para cada lançamento
  with brwGrid, brwGrid.datasource.dataset do
  try
    DisableControls;
    SetLength(LancamentoList, SelectedCount);

    for i := 0 to Pred(SelectedCount) do
    begin
      BookMark := SelectedRows[i];
      LancamentoList[i] := quBrowseIDLancamento.AsInteger;
    end;

    with TFrmExportBoleto.Create(Self) do
      Start(LancamentoList);
  finally
    EnableControls;
  end;
end;

function TFinLancamentoList.ValidateLancamento: Boolean;
begin

  Result := (quBrowseTipoMeioPag.AsInteger <> 9);

end;

Initialization
  RegisterClass(TFinLancamentoList);


end.

