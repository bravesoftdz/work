unit uFrmImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cxLookAndFeelPainters, cxButtons,
  uEplataformaEntidadeClasses, uStringFunctions;

type
  TFrmImport = class(TForm)
    Image11: TImage;
    pnlComple: TPanel;
    lblResultado: TLabel;
    Image1: TImage;
    pbImportacao: TProgressBar;
    chkPedido: TCheckBox;
    chkCliente: TCheckBox;
    PTitle: TPanel;
    ShapeImage: TShape;
    lblTitulo: TLabel;
    ImageClass: TImage;
    imgLine: TImage;
    mmDescricao: TMemo;
    imgExpPO: TImage;
    btnImportar: TcxButton;
    btnFechar: TcxButton;
    procedure btnImportarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    procedure CriarCliente(AepCliente: TepCliente);

    function GetStatusCompra: String;
    function GetCliente(AepCliente: TepCliente): TepCliente;
    function GetComissionado: Integer;

    function ClienteExiste(var AepCliente: TepCliente): Boolean;
    function PedidoExiste(AepCompra: TepCompra): Boolean;
  public
    function Start: Boolean;
    procedure SincronizarCliente;
    procedure SincronizarPedido;
  end;

var
  FrmImport: TFrmImport;

implementation

uses uInvoiceClasses, uDM, uEplataformaSyncClasses,  DateUtils, uFrmLog,
  DB, ADODB;

{$R *.dfm}

{ TfrmImport }

procedure TFrmImport.SincronizarCliente;
var
  i: Integer;
  epClienteSync: TepClienteSync;
  epClienteLista: TepClienteLista;
begin
  epClienteSync := TepClienteSync.Create;
  try
    epClienteSync.Init(DM.HTTPReqRespCatalog,
                       DM.ECommerceInfo.FURL,
                       DM.ECommerceInfo.FUser,
                       DM.ECommerceInfo.FPW);

    TepEntidadeLista(epClienteLista) := epClienteSync.Listar(IncDay(Now, (DM.ImpExpInfo.DiasImportacao*-1)));
    for i := 0 to Pred(epClienteLista.Count) do
    begin
      pbImportacao.Max := epClienteLista.Count;
      Application.ProcessMessages;

      try
        TepCliente(epClienteLista[i]).IDCliente := GetCliente(epClienteLista[i]).IDCliente;
      except
        on E: Exception do
          DM.SaveToLog(TepCliente(epClienteLista[i]).IDCliente, E.Message);
      end;
    end;
  finally
    FreeAndNil(epClienteLista);
    FreeAndNil(epClienteSync);
  end;
end;

procedure TFrmImport.SincronizarPedido;
var
  i, j: Integer;
  epCompraSync: TepCompraSync;
  epCompraLista: TepCompraLista;

  Invoice: TInvoice;
  InvoiceItem: TInvoiceItem;
  InvoiceItemCommission: TInvoiceItemCommission;
  InvoicePayment: TInvoicePayment;
  InvoiceOtherCost: TInvoiceOtherCost;
begin
  epCompraSync := TepCompraSync.Create;
  try
    epCompraSync.Init(DM.HTTPReqRespCatalog,
                      DM.ECommerceInfo.FURL,
                      DM.ECommerceInfo.FUser,
                      DM.ECommerceInfo.FPW);

    lblResultado.Caption := 'Sincronizando Pedidos...';
    pbImportacao.Position := 0;

    epCompraSync.StatusCompra := GetStatusCompra;
    TepEntidadeLista(epCompraLista) := epCompraSync.Listar(IncDay(Now, (DM.ImpExpInfo.DiasImportacao*-1)));

    for i := 0 to Pred(epCompraLista.Count) do
    begin
      pbImportacao.Max := epCompraLista.Count;
      Application.ProcessMessages;

      try
        if not PedidoExiste(epCompraLista[i]) then
        begin
          TepCompra(epCompraLista[i]).Cliente.IDCliente := GetCliente(TepCompra(epCompraLista[i]).Cliente).IDCliente;


          Invoice := TInvoice.Create(DM.ADOCon);

          Invoice.IDStore          := DM.MRInfo.FIDStore;
          Invoice.IDCustomer       := TepCompra(epCompraLista[i]).Cliente.IDCliente;
          Invoice.IDMedia          := DM.MRInfo.FIDMedia;
          Invoice.IDDeliverType    := 1;
          Invoice.IDOtherComission := 0;
          Invoice.IDTouristGroup   := 0;
          Invoice.IsLayaway        := True;
          Invoice.FirstName        := TepCompra(epCompraLista[i]).Cliente.Nome;
          Invoice.LastName         := TepCompra(epCompraLista[i]).Cliente.SobreNome;
          Invoice.Zip              := TepCompra(epCompraLista[i]).Cliente.Cep;
          Invoice.PreSaleDate      := TepCompra(epCompraLista[i]).Data;
          Invoice.InvoiceDate      := TepCompra(epCompraLista[i]).Data;
          Invoice.COO              := 'EC-' + IntToStr(TepCompra(epCompraLista[i]).IDCompra);
          Invoice.SaleCode         := 'EC-' + IntToStr(TepCompra(epCompraLista[i]).IDCompra);
          Invoice.Note             := '';
          Invoice.ECFSerial        := '';
          Invoice.PuppyTracker     := False;
          Invoice.TaxExempt        := False;

          // Adiciona o frete que será acumulado na nota, com o valor de frete de cada item abaixo
          InvoiceOtherCost            := TInvoiceOtherCost.Create(DM.ADOCon);
          InvoiceOtherCost.IDCostType := DM.MRInfo.FIDFreight;
          // Adiciona o item
          for j := 0 to Pred(TepEntrega(TepCompra(epCompraLista[i]).EntregaLista[0]).CompraEntregaSkuLista.Count) do
          begin
            InvoiceItem              := TInvoiceItem.Create(DM.ADOCon);
            InvoiceItemCommission    := TInvoiceItemCommission.Create(DM.ADOCon);
            InvoiceItem.IDCustomer   := TepCompra(epCompraLista[i]).Cliente.IDCliente;
            InvoiceItem.IDModel      := TepCompraEntregaSku(TepEntrega(TepCompra(epCompraLista[i]).EntregaLista[0]).CompraEntregaSkuLista[j]).IDSku;
            InvoiceItem.IDStore      := DM.MRInfo.FIDInventoryStore;
            InvoiceItem.IDUser       := DM.MRInfo.FIDUser;
            InvoiceItem.IDComission  := 0;
            InvoiceItem.IDDepartment := 0;
            InvoiceItem.Qty          := 1;
            InvoiceItem.Discount     := TepCompraEntregaSku(TepEntrega(TepCompra(epCompraLista[i]).EntregaLista[0]).CompraEntregaSkuLista[j]).ValorVendaUnidadeSemDesconto - TepCompraEntregaSku(TepEntrega(TepCompra(epCompraLista[i]).EntregaLista[0]).CompraEntregaSkuLista[j]).ValorVendaUnidade;
            InvoiceItem.SalePrice    := TepCompraEntregaSku(TepEntrega(TepCompra(epCompraLista[i]).EntregaLista[0]).CompraEntregaSkuLista[j]).ValorVendaUnidadeSemDesconto;
            InvoiceItem.CostPrice    := TepCompraEntregaSku(TepEntrega(TepCompra(epCompraLista[i]).EntregaLista[0]).CompraEntregaSkuLista[j]).ValorVendaUnidadeSemDesconto;
            InvoiceItem.MovDate      := TepCompra(epCompraLista[i]).Data;
            InvoiceItem.IsPromo      := False;

            InvoiceItemCommission.IDCommission      := GetComissionado;
            InvoiceItemCommission.CommissionPercent := 100;

            InvoiceItem.CommssionList.Add(InvoiceItemCommission);
            Invoice.ItemList.Add(InvoiceItem);

            // Acumula frete no pedido
            InvoiceOtherCost.Amount := InvoiceOtherCost.Amount + TepCompraEntregaSku(TepEntrega(TepCompra(epCompraLista[i]).EntregaLista[0]).CompraEntregaSkuLista[j]).ValorFreteComDesconto;
          end;
          Invoice.OtherCostList.Add(InvoiceOtherCost);

          // Adiciona pagamento
          for j := 0 to Pred(TepCompra(epCompraLista[i]).FormaPagamentoLista.Count) do
          begin
            InvoicePayment                  := TInvoicePayment.Create(DM.ADOCon);
            InvoicePayment.IDStore          := DM.MRInfo.FIDStore;
            InvoicePayment.IDUser           := DM.MRInfo.FIDUser;
            InvoicePayment.IDCustomer       := TepCompra(epCompraLista[i]).Cliente.IDCliente;
            InvoicePayment.IDInvoice        := 0;
            InvoicePayment.IDMeioPag        := 0;
            InvoicePayment.IDCashRegMov     := 0;
            InvoicePayment.IDBankCheck      := 0;
            InvoicePayment.IDPreSale        := 0;
            InvoicePayment.IsPredatado      := False;
            InvoicePayment.PaymentValue     := TepFormaPagamento(TepCompra(epCompraLista[i]).FormaPagamentoLista[j]).ValorComJuros;
            InvoicePayment.PaymentPlace     := 0;
            InvoicePayment.CustomerPhone    := TepCompra(epCompraLista[i]).Cliente.TelefoneResidencial;
            InvoicePayment.Parcela          := '';
            InvoicePayment.Authorization    := '';
            InvoicePayment.OBS              := '';
            InvoicePayment.CheckNumber      := '';
            InvoicePayment.PreSaleDate      := TepCompra(epCompraLista[i]).Data;
            InvoicePayment.ExpirationDate   := TepCompra(epCompraLista[i]).Data;
            InvoicePayment.MeioPag          := TepFormaPagamento(TepCompra(epCompraLista[i]).FormaPagamentoLista[j]).NomeFormaPagamento;
            InvoicePayment.CustomerDocument := TepCompra(epCompraLista[i]).Cliente.CpfCnpj;

            if TepCompra(epCompraLista[i]).Cliente.FlagPj then
              InvoicePayment.CustomerName := TepCompra(epCompraLista[i]).Cliente.RazaoSocial
            else
              InvoicePayment.CustomerName := TepCompra(epCompraLista[i]).Cliente.Nome;

            Invoice.PaymentList.Add(InvoicePayment);
          end;

          if not Invoice.CreateInvoice then
            raise Exception.Create('');
        end;
      except
        on E: Exception do
          DM.SaveToLog(TepCompra(epCompraLista[i]).IDCompra, E.Message);
      end;
    end;
  finally
    FreeAndNil(epCompraLista);
    FreeAndNil(epCompraSync);
  end;
end;

function TFrmImport.Start: Boolean;
begin
  DM.OpenConnection;
  ShowModal;
  DM.CloseConnection;
  Result := True;
end;

procedure TFrmImport.btnImportarClick(Sender: TObject);
var
  bResult : Boolean;
begin
  if chkPedido.Checked or chkCliente.Checked then
  try
    DM.AppendLog('Importação.');

    Cursor := crHourGlass;
    lblResultado.Caption := '';
    lblResultado.Visible := True;
    pbImportacao.Visible := True;

    try

      if chkCliente.Checked then
        SincronizarCliente;

      if chkPedido.Checked then
        SincronizarPedido;

      bResult := True;

    except
      on E: Exception do
      begin
        bResult := False;
        DM.PostLog('Erro Importação: ' + E.Message);
        DM.SendEmailLogText(DM.ECommerceInfo.FURL, 'Erro Importação', '');
      end;
    end;

  finally
    Cursor := crDefault;
    lblResultado.Visible := False;
    pbImportacao.Visible := False;

    if bResult then
    begin
      DM.PostLog('Importação.');
      MessageDlg('Importação concluída com sucesso!', mtConfirmation, [mbOK], 0);
    end;

  end
  else
    ShowMessage('Nenhuma opção foi marcada!');
end;

procedure TFrmImport.btnFecharClick(Sender: TObject);
begin
  Close;
end;

function TFrmImport.GetStatusCompra: String;
begin
  case DM.ECommerceInfo.FStatusPedido of
    0: Result := 'ACR'; //Aguardando Análise de Fraude
    1: Result := 'AES'; //Aguardando Estoque Físico
    2: Result := 'AMC'; //Analise Manual de Fraude
    3: Result := 'CAN'; //Cancelado
    4: Result := '_CANM'; //Cancelado Manualmente
    5: Result := 'CAP'; //Crédito Aprovado
    6: Result := 'ETR'; //Entregue Transportadora
    7: Result := 'AAP'; //Enviado Pagamento
    8: Result := 'PNA'; //Pagamento não Aprovado
    9: Result := 'ENT'; //Pedido Entregue com Sucesso
    10: Result := '_NEAS'; //Pendente
    11: Result := 'REC'; //Rejeitado no Fraude (*)
    12: Result := 'RIE'; //Recebimento de Insucesso de Entrega
  end;
end;

function TFrmImport.GetCliente(AepCliente: TepCliente): TepCliente;
begin
  Result := AepCliente;

  if not ClienteExiste(Result) then
    CriarCliente(Result);
end;

function TFrmImport.ClienteExiste(var AepCliente: TepCliente): Boolean;
begin
  with DM.quHasCustomer do
  begin
    if Active then
      Close;

    SQL.Text := 'SELECT ' +
                '  P.IDPessoa ' +
                'FROM ' +
                '  Pessoa P (NOLOCK) ' +
                '  JOIN TipoPessoa TP (NOLOCK) ON (P.IDTipoPessoa = TP.IDTipoPessoa) ' +
                'WHERE ' +
                '  TP.Path LIKE ' + QuotedStr('.001%');

    if AepCliente.FlagPj then
      SQL.Text := SQL.Text + '  AND REPLACE(REPLACE(REPLACE(P.InscEstadual, '+QuotedStr('.')+', '+QuotedStr('')+'), '+QuotedStr('-')+', '+QuotedStr('')+'), '+QuotedStr('/')+', '+QuotedStr('')+') = ' + QuotedStr(StringReplace(StringReplace(StringReplace(AepCliente.CpfCnpj, '.', '', [rfReplaceAll]), '-', '', [rfReplaceAll]), '/', '', [rfReplaceAll]))
    else
      SQL.Text := SQL.Text + '  AND REPLACE(REPLACE(REPLACE(P.CPF, '+QuotedStr('.')+', '+QuotedStr('')+'), '+QuotedStr('-')+', '+QuotedStr('')+'), '+QuotedStr('/')+', '+QuotedStr('')+') = ' + QuotedStr(StringReplace(StringReplace(StringReplace(AepCliente.CpfCnpj, '.', '', [rfReplaceAll]), '-', '', [rfReplaceAll]), '/', '', [rfReplaceAll]));

    Open;

    Result := RecordCount > 0;

    if Result then
      AepCliente.IDCliente := FieldByName('IDPessoa').AsInteger;

    Close;
  end;
end;

function TFrmImport.PedidoExiste(AepCompra: TepCompra): Boolean;
begin
  with DM.quHasSale do
  begin
    if Active then
      Close;
    Parameters.ParamByName('SaleCode').Value := 'EC-' + IntToStr(AepCompra.IDCompra);
    Open;

    Result := RecordCount > 0;
    Close;
  end;
end;

procedure TFrmImport.CriarCliente(AepCliente: TepCliente);
var
  iIDCliente: Integer;
begin
  with DM.quInsertCustomer do
  begin
    if Active then
      Close;

    iIDCliente := DM.GetNewID('Pessoa.IDPessoa');

    Parameters.ParamByName('IDPessoa').Value       := iIDCliente;
    Parameters.ParamByName('IDTipoPessoa').Value   := DM.MRInfo.FIDPersonType;
    Parameters.ParamByName('IDStore').Value        := DM.MRInfo.FIDStore;
    Parameters.ParamByName('IDUser').Value         := DM.MRInfo.FIDUser;
    Parameters.ParamByName('IDEstado').Value       := AepCliente.Estado;
    Parameters.ParamByName('NomeJuridico').Value   := AepCliente.RazaoSocial;
    Parameters.ParamByName('Endereco').Value       := AepCliente.Rua;
    Parameters.ParamByName('Cidade').Value         := AepCliente.Municipio;
    Parameters.ParamByName('CEP').Value            := AepCliente.Cep;
    Parameters.ParamByName('Pais').Value           := AepCliente.Pais;
    Parameters.ParamByName('Telefone').Value       := AepCliente.TelefoneResidencial;
    Parameters.ParamByName('Cellular').Value       := AepCliente.TelefoneCelular;
    Parameters.ParamByName('Fax').Value            := AepCliente.TelefoneComercial;
    Parameters.ParamByName('Email').Value          := AepCliente.Email;
    Parameters.ParamByName('OBS').Value            := 'IMPORTADO DO E-PLATAFORMA';
    Parameters.ParamByName('Juridico').Value       := AepCliente.FlagPj;
    Parameters.ParamByName('Nascimento').Value     := AepCliente.DataNascimento;
    Parameters.ParamByName('HomePage').Value       := AepCliente.Site;
    Parameters.ParamByName('Bairro').Value         := AepCliente.Bairro;
    Parameters.ParamByName('Code').Value           := AepCliente.IDCliente;
    Parameters.ParamByName('Complemento').Value    := AepCliente.Complemento;

    if AepCliente.Numero <> '' then
      Parameters.ParamByName('ComplementoNum').Value := StrToInt(AepCliente.Numero);

    if AepCliente.FlagPj then
    begin
      Parameters.ParamByName('ShortName').Value    := AepCliente.NomeFantasia;
      Parameters.ParamByName('Pessoa').Value       := AepCliente.RazaoSocial;
      Parameters.ParamByName('CGC').Value          := ReturnNumber(AepCliente.CpfCnpj);
      Parameters.ParamByName('InscEstadual').Value := AepCliente.InscricaoEstadual;
    end
    else
    begin
      Parameters.ParamByName('ShortName').Value       := AepCliente.Apelido;
      Parameters.ParamByName('Pessoa').Value          := AepCliente.Nome+' '+AepCliente.SobreNome;
      Parameters.ParamByName('PessoaFirstName').Value := AepCliente.Nome;
      Parameters.ParamByName('PessoaLastName').Value  := AepCliente.SobreNome;
      Parameters.ParamByName('CPF').Value             := ReturnNumber(AepCliente.CpfCnpj);
    end;

    AepCliente.IDCliente := iIDCliente;

    ExecSQL;
  end;
end;

function TFrmImport.GetComissionado: Integer;
begin
  with DM.quCommission do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDUser').Value := DM.MRInfo.FIDUser;
    Open;

    Result := FieldByName('ComissionID').AsInteger;
    Close;
  end;
end;

end.
