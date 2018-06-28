unit uFrmExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, cxLookAndFeelPainters, cxButtons,
  IdMessage, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP;

type
  TFrmExport = class(TForm)
    pnlComple: TPanel;
    lblResultado: TLabel;
    pbExportacao: TProgressBar;
    chkEstoque: TCheckBox;
    chkFabricante: TCheckBox;
    PTitle: TPanel;
    ShapeImage: TShape;
    lblTitulo: TLabel;
    ImageClass: TImage;
    mmDescricao: TMemo;
    chkQuantidade: TCheckBox;
    Image11: TImage;
    Image2: TImage;
    Image10: TImage;
    imgLine: TImage;
    Image1: TImage;
    chkCategoria: TCheckBox;
    chkProduto: TCheckBox;
    chkSKU: TCheckBox;
    btnExportar: TcxButton;
    btnFechar: TcxButton;
    procedure btnExportarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure chkEstoqueClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function FormatarTextoLink(ATexto: String): String;
    function FormatarTextoDescricao(ATexto: String): String;

    procedure SincronizarCategoria;
    procedure SincronizarProduto;
    procedure SincronizarSKU;
  public
    function Start: Boolean;
    procedure SincronizarFabricante;
    procedure SincronizarEstoque;
    procedure SincronizarQuantidade;
  end;

var
  FrmExport: TFrmExport;

implementation

uses uDM, uEplataformaSyncClasses, uEplataformaEntidadeClasses, DB, ADODB,
  uFrmLog;

{$R *.dfm}

{ TFrmExport }

function TFrmExport.Start: Boolean;
begin
  DM.OpenConnection;
  chkEstoqueClick(Self);
  ShowModal;
  DM.CloseConnection;
  Result := True;
end;

procedure TFrmExport.SincronizarCategoria;
var
  epCategoria: TepCategoria;
  epCategoriaSync: TepCategoriaSync;
begin
  epCategoriaSync := TepCategoriaSync.Create;
  try
    epCategoriaSync.Init(DM.HTTPReqRespCatalog,
                         DM.ECommerceInfo.FURL,
                         DM.ECommerceInfo.FUser,
                         DM.ECommerceInfo.FPW);

    with DM.quCategory do
    try
      if Active then
        Close;
      Open;
      First;
      lblResultado.Caption := 'Sincronizando Categorias...';
      pbExportacao.Position := 0;
      pbExportacao.Max := RecordCount;
      Application.ProcessMessages;

      epCategoria := TepCategoria.Create;
      try
        while not EOF do
        begin
          try
            pbExportacao.Position := pbExportacao.Position + 1;
            Application.ProcessMessages;

            epCategoria.IDCategoria := DM.quCategory.FieldByName('IDGroup').AsInteger;
            if epCategoriaSync.Verificar(epCategoria) then
            begin
              epCategoria := TepCategoria(epCategoriaSync.Obter(epCategoria));

              {
              if DM.ECommerceInfo.FExportarDepartamento then
              begin
                epCategoria.Nome      := DM.quCategory.FieldByName('Department').AsString;
                epCategoria.FlagAtiva := not DM.quCategory.FieldByName('DepDesativado').AsBoolean;
              end
              else
              begin
                epCategoria.Nome      := DM.quCategory.FieldByName('Name').AsString;
                epCategoria.FlagAtiva := not DM.quCategory.FieldByName('CatDesativado').AsBoolean;
              end;
              }

              epCategoria.Nome      := DM.quCategory.FieldByName('Name').AsString;
              epCategoria.FlagAtiva := not DM.quCategory.FieldByName('CatDesativado').AsBoolean;

              epCategoriaSync.Alterar(epCategoria);
            end
            else
              if (not DM.quCategory.FieldByName('DepDesativado').AsBoolean) and (not DM.quCategory.FieldByName('CatDesativado').AsBoolean) then
              begin
              {
                if DM.ECommerceInfo.FExportarDepartamento then
                begin
                  epCategoria.IDCategoria := DM.quCategory.FieldByName('IDDepartment').AsInteger;
                  epCategoria.Nome        := DM.quCategory.FieldByName('Department').AsString;
                  epCategoria.FlagAtiva   := not DM.quCategory.FieldByName('DepDesativado').AsBoolean;
                end
                else
                begin
                  epCategoria.IDCategoria := DM.quCategory.FieldByName('IDGroup').AsInteger;
                  epCategoria.Nome        := DM.quCategory.FieldByName('Name').AsString;
                  epCategoria.FlagAtiva   := not DM.quCategory.FieldByName('CatDesativado').AsBoolean;
                end;
               }
               
                epCategoria.IDCategoria := DM.quCategory.FieldByName('IDGroup').AsInteger;
                epCategoria.Nome        := DM.quCategory.FieldByName('Name').AsString;
                epCategoria.FlagAtiva   := not DM.quCategory.FieldByName('CatDesativado').AsBoolean;

                epCategoria.IDDepartamento      := 0;
                epCategoria.Ordem               := 0;
                epCategoria.FlagMenu            := True;
                epCategoria.Texto               := '';
                epCategoria.MargemLucro         := 0;
                epCategoria.PalavraChave        := '';
                epCategoria.TituloSite          := '';
                epCategoria.ModoExibicaoProduto := '';
                epCategoria.FlagExisteProduto   := False;
                epCategoria.FlagFiltroMarca     := False;
                epCategoria.FlagAtivaMenuLink   := True;

                epCategoriaSync.Criar(epCategoria);
              end;
          except
            on E: Exception do
              DM.SaveToLog(epCategoria.IDCategoria, E.Message);
          end;

          Next;
        end;
      finally
        FreeAndNil(epCategoria);
      end;

      Close;
    except
      raise;
    end;
  finally
    FreeAndNil(epCategoriaSync);
  end;
end;

procedure TFrmExport.btnExportarClick(Sender: TObject);
var
  bResult : Boolean;
begin
  if chkFabricante.Checked or chkEstoque.Checked or chkQuantidade.Checked then
  try
    DM.AppendLog('Exportação.');

    Cursor := crHourGlass;
    lblResultado.Caption := '';
    lblResultado.Visible := True;
    pbExportacao.Visible := True;

    try
    
      if chkFabricante.Checked then
        SincronizarFabricante;

      if chkEstoque.Checked then
        SincronizarEstoque;

      if chkQuantidade.Checked then
        SincronizarQuantidade;

      bResult := True;

    except
      on E: Exception do
      begin
        bResult := False;
        DM.PostLog('Erro Exportação: ' + E.Message);
        DM.SendEmailLogText(DM.ECommerceInfo.FURL, 'Erro Exportação', '');
      end;
    end;


  finally
    Cursor := crDefault;
    lblResultado.Visible := False;
    pbExportacao.Visible := False;
    
    if bResult then
    begin
      DM.PostLog('Exportação.');
      MessageDlg('Exportação concluída com sucesso!', mtConfirmation, [mbOK], 0);
    end;
  end
  else
    ShowMessage('Nenhuma opção foi marcada!');
end;

procedure TFrmExport.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmExport.SincronizarFabricante;
var
  epMarca: TepMarca;
  epMarcaSync: TepMarcaSync;
begin
  epMarcaSync := TepMarcaSync.Create;
  try
    epMarcaSync.Init(DM.HTTPReqRespCatalog,
                     DM.ECommerceInfo.FURL,
                     DM.ECommerceInfo.FUser,
                     DM.ECommerceInfo.FPW);

    with DM.quManufacturer do
    try
      if Active then
        Close;
      Open;
      First;
      lblResultado.Caption := 'Sincronizando Fabricantes...';
      pbExportacao.Position := 0;
      pbExportacao.Max := RecordCount;
      Application.ProcessMessages;

      epMarca := TepMarca.Create;
      try
        while not EOF do
        begin
          try
            pbExportacao.Position := pbExportacao.Position + 1;
            Application.ProcessMessages;

            epMarca.IDMarca := DM.quManufacturer.FieldByName('IDPessoa').AsInteger;

            if epMarcaSync.Verificar(epMarca) then
            begin
              epMarca           := TepMarca(epMarcaSync.Obter(epMarca));
              epMarca.Nome      := DM.quManufacturer.FieldByName('Pessoa').AsString;
              epMarca.FlagAtiva := not DM.quManufacturer.FieldByName('Desativado').AsBoolean;

              epMarcaSync.Alterar(epMarca);
            end
            else
              if not DM.quManufacturer.FieldByName('Desativado').AsBoolean then
              begin
                epMarca.Nome      := DM.quManufacturer.FieldByName('Pessoa').AsString;
                epMarca.FlagAtiva := not DM.quManufacturer.FieldByName('Desativado').AsBoolean;
                epMarcaSync.Criar(epMarca);
              end;
          except
            on E: Exception do
              DM.SaveToLog(epMarca.IDMarca, E.Message);
          end;

          Next;
        end;
      finally
        FreeAndNil(epMarca);
      end;

      Close;
    except
      raise;
    end;
  finally
    FreeAndNil(epMarcaSync);
  end;
end;

procedure TFrmExport.SincronizarProduto;
var
  epProduto: TepProduto;
  epProdutoSync: TepProdutoSync;
begin
  epProdutoSync := TepProdutoSync.Create;
  try
    epProdutoSync.Init(DM.HTTPReqRespCatalog,
                       DM.ECommerceInfo.FURL,
                       DM.ECommerceInfo.FUser,
                       DM.ECommerceInfo.FPW);

    with DM.quProduct do
    try
      if Active then
        Close;
      Parameters.ParamByName('IDStore').Value := DM.MRInfo.FIDStore;
      Open;
      First;
      lblResultado.Caption := 'Sincronizando Produtos...';
      pbExportacao.Position := 0;
      pbExportacao.Max := RecordCount;
      Application.ProcessMessages;

      epProduto := TepProduto.Create;
      try
        while not EOF do
        begin
          epProduto.IDProduto := DM.quProduct.FieldByName('IDModel').AsInteger;

          if DM.quProduct.FieldByName('IDFabricante').AsInteger > 0 then
          begin
            try
              pbExportacao.Position := pbExportacao.Position + 1;
              Application.ProcessMessages;

              //epProduto.IDProduto := DM.quProduct.FieldByName('IDModel').AsInteger;

              if epProdutoSync.Verificar(epProduto) then
              begin
                TepEntidade(epProduto)     := epProdutoSync.Obter(epProduto);
                epProduto.Nome             := FormatarTextoDescricao(DM.quProduct.FieldByName('Description').AsString);
                epProduto.TextoLink        := FormatarTextoLink(DM.quProduct.FieldByName('Description').AsString)+'-'+InttoStr(epProduto.IDProduto);

                {
                if DM.ECommerceInfo.FExportarDepartamento then
                begin
                  epProduto.IDCategoria    := DM.quProduct.FieldByName('IDDepartment').AsInteger;
                  epProduto.TextoCategoria := DM.quProduct.FieldByName('Department').AsString;
                end
                else
                begin
                  epProduto.IDCategoria    := DM.quProduct.FieldByName('IDCategoria').AsInteger;
                  epProduto.TextoCategoria := DM.quProduct.FieldByName('Categoria').AsString;
                end;
                }

                {
                  SOMENTE ATUALIZA A CATEGORIA SE A OPÇÃO "Enviar todos os produtos para uma única categoria."
                  NÃO ESTIVER SELECIONADA
                }
                if not DM.ECommerceInfo.FProdutoUnicaCategoria then
                begin
                  epProduto.IDCategoria    := DM.quProduct.FieldByName('IDCategoria').AsInteger;
                  epProduto.TextoCategoria := DM.quProduct.FieldByName('Categoria').AsString;
                end;

                epProduto.IDMarca          := DM.quProduct.FieldByName('IDFabricante').AsInteger;
                epProduto.PrecoSkuAte      := DM.quProduct.FieldByName('SellingPrice').AsCurrency;
                epProduto.TextoMarca       := DM.quProduct.FieldByName('Fabricante').AsString;
                epProduto.CodigoReferencia := FormatarTextoDescricao(DM.quProduct.FieldByName('Model').AsString);
                epProduto.FlagAtiva        := not DM.quProduct.FieldByName('Desativado').AsBoolean;

                epProduto.Skus             := TepSKULista.Create;

                epProdutoSync.Alterar(epProduto);
              end
              else
                if not DM.quProduct.FieldByName('Desativado').AsBoolean then
                begin
                  epProduto.Nome                    := FormatarTextoDescricao(DM.quProduct.FieldByName('Description').AsString);
                  epProduto.Texto                   := FormatarTextoDescricao(DM.quProduct.FieldByName('Description').AsString);
                  epProduto.TextoLink               := FormatarTextoLink(DM.quProduct.FieldByName('Description').AsString)+'-'+InttoStr(epProduto.IDProduto);

                  {
                  if DM.ECommerceInfo.FExportarDepartamento then
                  begin
                    epProduto.IDCategoria    := DM.quProduct.FieldByName('IDDepartment').AsInteger;
                    epProduto.TextoCategoria := DM.quProduct.FieldByName('Department').AsString;
                  end
                  else
                  begin
                    epProduto.IDCategoria    := DM.quProduct.FieldByName('IDCategoria').AsInteger;
                    epProduto.TextoCategoria := DM.quProduct.FieldByName('Categoria').AsString;
                  end;
                  }
                  if DM.ECommerceInfo.FProdutoUnicaCategoria then
                  begin
                    epProduto.IDCategoria    := DM.ECommerceInfo.FCategoriaUnica;
                    epProduto.TextoCategoria := DM.ECommerceInfo.FDescCategoriaUnica;
                  end
                  else
                  begin
                    epProduto.IDCategoria    := DM.quProduct.FieldByName('IDCategoria').AsInteger;
                    epProduto.TextoCategoria := DM.quProduct.FieldByName('Categoria').AsString;
                  end;

                  epProduto.IDMarca                 := DM.quProduct.FieldByName('IDFabricante').AsInteger;
                  epProduto.PrecoSkuDe              := DM.quProduct.FieldByName('SellingPrice').AsCurrency;
                  epProduto.PrecoSkuAte             := DM.quProduct.FieldByName('SellingPrice').AsCurrency;
                  epProduto.TextoMarca              := DM.quProduct.FieldByName('Fabricante').AsString;
                  epProduto.TextoCategoria          := DM.quProduct.FieldByName('Categoria').AsString;
                  epProduto.CodigoReferencia        := FormatarTextoDescricao(DM.quProduct.FieldByName('Model').AsString);
                  epProduto.IDProdutoEdicao         := 0;
                  epProduto.PalavraChave            := '';
                  epProduto.TituloSite              := '';
                  epProduto.IDAdministradorEdicao   := 0;
                  epProduto.IDAdministradorAprovado := 0;
                  epProduto.IDFornecedor            := 0;
                  epProduto.IDDepartamento          := 0;
                  epProduto.IDLinha                 := 0;
                  epProduto.FlagExibe               := False;
                  epProduto.FlagSorteiaSku          := False;
                  epProduto.FlagAtiva               := False;
                  epProduto.Prioridade              := 0;
                  epProduto.PalavraChaveMarca       := '';
                  epProduto.Ordenacao               := '';
                  epProduto.TextoDepartamento       := '';
                  epProduto.NomeCompleto            := '';
                  epProduto.Skus                    := TepSKULista.Create;

                  epProdutoSync.Criar(epProduto);
                end;
            except
              on E: Exception do
                DM.SaveToLog(epProduto.IDProduto, E.Message);
            end;

          end //FIM if DM.quProduct.FieldByName('IDFabricante').AsInteger > 0 then
          else
          begin
            //PRODUTO SEM FABRICANTE - GERO LOG DE ERRO.
            if not DM.quProduct.FieldByName('Desativado').AsBoolean then
              DM.SaveToLog(epProduto.IDProduto, 'Não foi possível criar/atualizar o produto. Motivo: PRODUTO SEM FABRICANTE RELACIONADO.');
          end;

          Next;
        end;
      finally
        FreeAndNil(epProduto);
      end;

      Close;
    except
      raise;
    end;
  finally
    FreeAndNil(epProdutoSync);
  end;
end;

procedure TFrmExport.SincronizarSKU;
var
  epSKU: TepSKU;
  epSKUSync: TepSKUSync;
begin
  epSKUSync := TepSKUSync.Create;
  try
    epSKUSync.Init(DM.HTTPReqRespCatalog,
                   DM.ECommerceInfo.FURL,
                   DM.ECommerceInfo.FUser,
                   DM.ECommerceInfo.FPW);

    with DM.quSKU do
    try
      if Active then
        Close;
      Parameters.ParamByName('IDStore').Value := DM.MRInfo.FIDStore;
      Open;
      First;
      lblResultado.Caption := 'Sincronizando SKUs...';
      pbExportacao.Position := 0;
      pbExportacao.Max := RecordCount;
      Application.ProcessMessages;

      epSKU := TepSKU.Create;
      try
        while not EOF do
        begin
          epSKU.IDSku := DM.quSKU.FieldByName('IDModel').AsInteger;

          if DM.quSKU.FieldByName('IDFabricante').AsInteger > 0 then
            begin
              try
                pbExportacao.Position := pbExportacao.Position + 1;
                Application.ProcessMessages;

                //epSKU.IDSku := DM.quSKU.FieldByName('IDModel').AsInteger;

                if epSKUSync.Verificar(epSKU) then
                begin
                  TepEntidade(epSKU) := epSKUSync.Obter(epSKU);

                  if DM.quSKU.FieldByName('IDModelParent').AsInteger = 0 then
                  begin
                    epSKU.IDProduto := DM.quSKU.FieldByName('IDModel').AsInteger;
                    epSKU.Nome := FormatarTextoDescricao(DM.quSKU.FieldByName('Description').AsString);
                  end
                  else
                    epSKU.IDProduto := DM.quSKU.FieldByName('IDModelParent').AsInteger;

                  epSKU.Nome             := FormatarTextoDescricao(DM.quSKU.FieldByName('SizeName').AsString) + '-' + (DM.quSKU.FieldByName('Color').AsString);
                  epSKU.Texto            := FormatarTextoDescricao(DM.quSKU.FieldByName('Description').AsString);
                  epSKU.PrecoVenda       := DM.quSKU.FieldByName('SellingPrice').AsCurrency;
                  epSKU.PrecoCusto       := DM.quSKU.FieldByName('VendorCost').AsCurrency;
                  epSKU.CodigoReferencia := FormatarTextoDescricao(DM.quSKU.FieldByName('Model').AsString);
                  epSKU.Ean13            := DM.quSKU.FieldByName('Barcode').AsString;
                  epSKU.FlagAtiva        := not DM.quSKU.FieldByName('Desativado').AsBoolean;
                  epSKU.FlagAtivaERP     := not DM.quSKU.FieldByName('Desativado').AsBoolean;

                  epSKUSync.Alterar(epSKU);
                end
                else
                  if not DM.quSKU.FieldByName('Desativado').AsBoolean then
                  begin
                    if DM.quSKU.FieldByName('IDModelParent').AsInteger = 0 then
                    begin
                      epSKU.IDProduto := DM.quSKU.FieldByName('IDModel').AsInteger;
                      epSKU.Nome := FormatarTextoDescricao(DM.quSKU.FieldByName('Description').AsString);
                    end
                    else
                      epSKU.IDProduto := DM.quSKU.FieldByName('IDModelParent').AsInteger;

                    epSKU.Nome                    := FormatarTextoDescricao(DM.quSKU.FieldByName('SizeName').AsString) + '-' + (DM.quSKU.FieldByName('Color').AsString);
                    epSKU.Texto                   := FormatarTextoDescricao(DM.quSKU.FieldByName('Description').AsString);
                    epSKU.PrecoAnterior           := DM.quSKU.FieldByName('SellingPrice').AsCurrency;
                    epSKU.PrecoVenda              := DM.quSKU.FieldByName('SellingPrice').AsCurrency;
                    epSKU.PrecoCusto              := DM.quSKU.FieldByName('VendorCost').AsCurrency;
                    epSKU.CodigoReferencia        := FormatarTextoDescricao(DM.quSKU.FieldByName('Model').AsString);
                    epSKU.Ean13                   := DM.quSKU.FieldByName('Barcode').AsString;
                    epSKU.FlagAtiva               := False; //not DM.quSKU.FieldByName('Desativado').AsBoolean;
                    epSKU.FlagAtivaERP            := True; //not DM.quSKU.FieldByName('Desativado').AsBoolean;
                    epSKU.IDSkuEdicao             := 0;
                    epSKU.IDAdministradorEdicao   := 0;
                    epSKU.IDAdministradorAprovado := 0;
                    epSKU.IDFreteModalTipo        := 1;
                    epSKU.FlagKit                 := False;
                    epSKU.Peso                    := 0;
                    epSKU.Altura                  := 0;
                    epSKU.Largura                 := 0;
                    epSKU.Comprimento             := 0;
                    epSKU.PesoCubico              := 0;
                    epSKU.DataCadastro            := 0;
                    epSKU.PesoReal                := 0;
                    epSKU.AlturaReal              := 0;
                    epSKU.LarguraReal             := 0;
                    epSKU.ComprimentoReal         := 0;
                    epSKU.DepartamentoGerencial   := '';
                    epSKU.SetorGerencial          := '';
                    epSKU.IDSkuCondicaoComercial  := 0;

                    epSKUSync.Criar(epSKU);
                  end;
              except
                on E: Exception do
                  DM.SaveToLog(epSKU.IDSku, E.Message);
              end;

          end //FIM if DM.quSKU.FieldByName('IDFabricante').AsInteger > 0 then
          else
          begin
            //PRODUTO SEM FABRICANTE - GERO LOG DE ERRO.
            if not DM.quSKU.FieldByName('Desativado').AsBoolean then
              DM.SaveToLog(epSKU.IDSku, 'Não foi possível criar/atualizar o SKU. Motivo: PRODUTO SEM FABRICANTE RELACIONADO.');
          end;

          Next;
        end;
      finally
        FreeAndNil(epSKU);
      end;

      Close;
    except
      raise;
    end;
  finally
    FreeAndNil(epSKUSync);
  end;
end;

procedure TFrmExport.SincronizarQuantidade;
var
  epSaldoSKU: TepSaldoSKU;
  epEstoqueSync: TepEstoqueSync;
begin
  epEstoqueSync := TepEstoqueSync.Create;
  try
    epEstoqueSync.Init(DM.HTTPReqRespCatalog,
                       DM.ECommerceInfo.FURL,
                       DM.ECommerceInfo.FUser,
                       DM.ECommerceInfo.FPW);

    with DM.quInventory do
    try
      if Active then
        Close;
      Parameters.ParamByName('IDStore').Value := DM.MRInfo.FIDInventoryStore;
      Open;
      First;
      lblResultado.Caption := 'Sincronizando Quantidades...';
      pbExportacao.Position := 0;
      pbExportacao.Max := RecordCount;
      Application.ProcessMessages;

      epSaldoSKU := TepSaldoSKU.Create;
      try
        while not EOF do
        begin
          try
            pbExportacao.Position := pbExportacao.Position + 1;
            Application.ProcessMessages;

            epSaldoSKU.IdEstoque            := DM.ECommerceInfo.FEstoque;
            epSaldoSKU.IdSku                := FieldByName('ModelID').AsInteger;
            epSaldoSKU.QuantidadeTotal      := FieldByName('QtyOnHand').AsInteger;
            epSaldoSKU.QuantidadeReservada  := FieldByName('QtyOnPreSale').AsInteger;
            epSaldoSKU.QuantidadeDisponivel := epSaldoSKU.QuantidadeTotal - epSaldoSKU.QuantidadeReservada;

            epEstoqueSync.Atualizar(epSaldoSKU);
          except
            on E: Exception do
              DM.SaveToLog(epSaldoSKU.IdEstoque, E.Message);
          end;

          Next;
        end;
      finally
        FreeAndNil(epSaldoSKU);
      end;

      Close;
    except
      raise;
    end;
  finally
    FreeAndNil(epEstoqueSync);
  end;
end;

procedure TFrmExport.SincronizarEstoque;
begin
  if chkCategoria.Checked then
    SincronizarCategoria;

  if chkProduto.Checked then
    SincronizarProduto;

  if chkSKU.Checked then
    SincronizarSKU;
end;

procedure TFrmExport.chkEstoqueClick(Sender: TObject);
begin
  chkCategoria.Enabled := chkEstoque.Checked;
  chkProduto.Enabled   := chkEstoque.Checked;
  chkSKU.Enabled       := chkEstoque.Checked;
end;

function TFrmExport.FormatarTextoLink(ATexto: String): String;
begin
  Result := StringReplace(ATexto, ' ', '-', [rfReplaceAll]);
  Result := StringReplace(Result, '!', '', [rfReplaceAll]);
  Result := StringReplace(Result, '?', '', [rfReplaceAll]);
  Result := StringReplace(Result, '@', '', [rfReplaceAll]);
  Result := StringReplace(Result, '#', '', [rfReplaceAll]);
  Result := StringReplace(Result, '$', '', [rfReplaceAll]);
  Result := StringReplace(Result, '%', '', [rfReplaceAll]);
  Result := StringReplace(Result, '&', '', [rfReplaceAll]);
  Result := StringReplace(Result, '+', '', [rfReplaceAll]);
  Result := StringReplace(Result, '*', '', [rfReplaceAll]);

  Result := StringReplace(Result, 'á', 'a', [rfReplaceAll]);
  Result := StringReplace(Result, 'Á', 'A', [rfReplaceAll]);
  Result := StringReplace(Result, 'à', 'a', [rfReplaceAll]);
  Result := StringReplace(Result, 'À', 'A', [rfReplaceAll]);
  Result := StringReplace(Result, 'ã', 'a', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ã', 'A', [rfReplaceAll]);
  Result := StringReplace(Result, 'â', 'a', [rfReplaceAll]);
  Result := StringReplace(Result, 'Â', 'A', [rfReplaceAll]);
  Result := StringReplace(Result, 'é', 'e', [rfReplaceAll]);
  Result := StringReplace(Result, 'É', 'E', [rfReplaceAll]);
  Result := StringReplace(Result, 'è', 'e', [rfReplaceAll]);
  Result := StringReplace(Result, 'È', 'E', [rfReplaceAll]);
  Result := StringReplace(Result, 'ê', 'e', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ê', 'E', [rfReplaceAll]);
  Result := StringReplace(Result, 'í', 'i', [rfReplaceAll]);
  Result := StringReplace(Result, 'Í', 'I', [rfReplaceAll]);
  Result := StringReplace(Result, 'ì', 'i', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ì', 'I', [rfReplaceAll]);
  Result := StringReplace(Result, 'î', 'i', [rfReplaceAll]);
  Result := StringReplace(Result, 'Î', 'I', [rfReplaceAll]);
  Result := StringReplace(Result, 'ó', 'o', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ó', 'O', [rfReplaceAll]);
  Result := StringReplace(Result, 'ò', 'o', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ò', 'O', [rfReplaceAll]);
  Result := StringReplace(Result, 'õ', 'o', [rfReplaceAll]);
  Result := StringReplace(Result, 'Õ', 'O', [rfReplaceAll]);
  Result := StringReplace(Result, 'ô', 'o', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ô', 'O', [rfReplaceAll]);
  Result := StringReplace(Result, 'ú', 'u', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ú', 'U', [rfReplaceAll]);
  Result := StringReplace(Result, 'ù', 'u', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ù', 'U', [rfReplaceAll]);
  Result := StringReplace(Result, 'û', 'u', [rfReplaceAll]);
  Result := StringReplace(Result, 'Û', 'U', [rfReplaceAll]);
  Result := StringReplace(Result, 'ç', 'c', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ç', 'C', [rfReplaceAll]);
end;

procedure TFrmExport.Button1Click(Sender: TObject);
begin
  FrmLog.ShowModal;
end;

function TFrmExport.FormatarTextoDescricao(ATexto: String): String;
begin
  Result := StringReplace(ATexto, '&', 'e', [rfReplaceAll]);
end;

end.
