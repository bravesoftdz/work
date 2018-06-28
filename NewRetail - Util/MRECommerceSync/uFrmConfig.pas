unit uFrmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Mask, SuperComboADO, Grids,
  dxCntner, dxEditor, dxExEdtr, dxEdLib;

type
  TFrmConfig = class(TForm)
    pnlComple: TPanel;
    btnClose: TButton;
    pgOption: TPageControl;
    tsMainRetail: TTabSheet;
    tsLogin: TTabSheet;
    PGMainRetail: TPageControl;
    tsConfig: TTabSheet;
    Label1: TLabel;
    scCashReg: TSuperComboADO;
    ldDefStore: TLabel;
    scDefaultSaleStore: TSuperComboADO;
    Label2: TLabel;
    scUser: TSuperComboADO;
    tsPayments: TTabSheet;
    sgColumns: TStringGrid;
    cbColumns: TComboBox;
    lbUser: TLabel;
    edtUser: TEdit;
    Label3: TLabel;
    edtPW: TEdit;
    lbURL: TLabel;
    edtURL: TEdit;
    btnConectar: TButton;
    lbResult: TLabel;
    tsHorario: TTabSheet;
    chkExportacaoAuto: TCheckBox;
    edtMinExportacao: TdxSpinEdit;
    chkImportacaoAuto: TCheckBox;
    edtMinImportacao: TdxSpinEdit;
    pnlImportacao: TPanel;
    pnlExportacao: TPanel;
    edtDiasImportacao: TdxSpinEdit;
    edtDiasExportacao: TdxSpinEdit;
    lblDiasImportacao: TLabel;
    lblDiasExportacao: TLabel;
    cbxStatusPedido: TComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    lblImportarPedido: TLabel;
    chkImpCliente: TCheckBox;
    chkImpPedido: TCheckBox;
    chkExpFabricante: TCheckBox;
    chkExpEstoque: TCheckBox;
    chkExpQuantidade: TCheckBox;
    cbxEstoque: TComboBox;
    lblEstoque: TLabel;
    chkExportarDepartamento: TCheckBox;
    lblMidia: TLabel;
    scMedia: TSuperComboADO;
    lblFrete: TLabel;
    scFreight: TSuperComboADO;
    scPersonType: TSuperComboADO;
    lblTipoPessoa: TLabel;
    chkProdutosCategoria: TCheckBox;
    cbxCategoriaEPlataforma: TComboBox;
    Label4: TLabel;
    btnCancelar: TButton;
    Label5: TLabel;
    scInventoryStore: TSuperComboADO;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure cbColumnsChange(Sender: TObject);
    procedure cbColumnsExit(Sender: TObject);
    procedure sgColumnsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnConectarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkImportacaoAutoClick(Sender: TObject);
    procedure chkExportacaoAutoClick(Sender: TObject);
    procedure chkProdutosCategoriaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    procedure LoadValues;
    procedure SaveValues;

    procedure LoadColumns;
    procedure SaveGridColumns;

    procedure AddGridItem(AList, APayment : String; APos : Integer);
    procedure LoadPaymentList;
    procedure LoadEstoqueList(AIDEstoque : Integer);
    procedure LoadCategoriaEPlataforma(AIdCategoria : Integer);
  public
    function Start : Boolean;
  end;

implementation

uses uDM, uParamFunctions, Math, uEplataformaEntidadeClasses,
  uEplataformaSyncClasses;

{$R *.dfm}

{ TFrmConfig }

procedure TFrmConfig.LoadValues;
begin
  scDefaultSaleStore.LookUpValue  := IntToStr(DM.MRInfo.FIDStore);
  scInventoryStore.LookUpValue    := IntToStr(DM.MRInfo.FIDInventoryStore);
  scCashReg.LookUpValue           := IntToStr(DM.MRInfo.FIDCashReg);
  scUser.LookUpValue              := IntToStr(DM.MRInfo.FIDUser);
  scMedia.LookUpValue             := IntToStr(DM.MRInfo.FIDMedia);
  scFreight.LookUpValue           := IntToStr(DM.MRInfo.FIDFreight);
  scPersonType.LookUpValue        := IntToStr(DM.MRInfo.FIDPersonType);

  edtUser.Text                    := DM.ECommerceInfo.FUser;
  edtPW.Text                      := DM.ECommerceInfo.FPW;
  edtURL.Text                     := DM.ECommerceInfo.FURL;
  cbxStatusPedido.ItemIndex       := DM.ECommerceInfo.FStatusPedido;
  chkExportarDepartamento.Checked := DM.ECommerceInfo.FExportarDepartamento;
  chkProdutosCategoria.Checked    := DM.ECommerceInfo.FProdutoUnicaCategoria;

  if chkProdutosCategoria.Checked then
  begin
    LoadCategoriaEPlataforma(DM.ECommerceInfo.FCategoriaUnica);
    cbxCategoriaEPlataforma.Enabled := True;
  end
  else
  begin
    cbxCategoriaEPlataforma.Items.Clear;
    cbxCategoriaEPlataforma.Enabled := False;
  end;

  edtDiasImportacao.Value         := DM.ImpExpInfo.DiasImportacao;
  chkImportacaoAuto.Checked       := DM.ImpExpInfo.ImportacaoAuto;
  edtMinImportacao.Value          := DM.ImpExpInfo.MinImportacao;
  chkImpCliente.Checked           := DM.ImpExpInfo.ImportacaoCliente;
  chkImpPedido.Checked            := DM.ImpExpInfo.ImportacaoPedido;
  edtDiasExportacao.Value         := DM.ImpExpInfo.DiasExportacao;
  chkExportacaoAuto.Checked       := DM.ImpExpInfo.ExportacaoAuto;
  edtMinExportacao.Value          := DM.ImpExpInfo.MinExportacao;
  chkExpFabricante.Checked        := DM.ImpExpInfo.ExportacaoFabricante;
  chkExpEstoque.Checked           := DM.ImpExpInfo.ExportacaoEstoque;
  chkExpQuantidade.Checked        := DM.ImpExpInfo.ExportacaoQuantidade;
end;

procedure TFrmConfig.SaveValues;
begin
  DM.IniWriteString('Setting', 'Loja', scDefaultSaleStore.LookUpValue);
  DM.IniWriteString('Setting', 'LojaEstoque', scInventoryStore.LookUpValue);
  DM.IniWriteString('Setting', 'Caixa', scCashReg.LookUpValue);
  DM.IniWriteString('Setting', 'User', scUser.LookUpValue);
  DM.IniWriteString('Setting', 'Commission', VarToStr(scUser.GetFieldByName('ComissionID')));
  DM.IniWriteString('Setting', 'Media', scMedia.LookUpValue);
  DM.IniWriteString('Setting', 'Freight', scFreight.LookUpValue);
  DM.IniWriteString('Setting', 'PersonType', scPersonType.LookUpValue);

  DM.IniWriteString('ECommerce', 'User', edtUser.Text);
  DM.IniWriteString('ECommerce', 'PW', DM.EncodeStr(edtPW.Text, 'password'));
  DM.IniWriteString('ECommerce', 'URL', edtURL.Text);
  DM.IniWriteString('ECommerce', 'StatusPedido', IntToStr(cbxStatusPedido.ItemIndex));

  if cbxEstoque.ItemIndex <> -1 then
    DM.IniWriteString('ECommerce', 'Estoque', IntToStr(TepEstoque(cbxEstoque.Items.Objects[cbxEstoque.ItemIndex]).IdEstoque))
  else
    DM.IniWriteString('ECommerce', 'Estoque', '0');

  DM.IniWriteString('ECommerce', 'ExportarDepartamento', IntToStr(IfThen(chkExportarDepartamento.Checked, 1, 0)));
  DM.IniWriteString('ECommerce', 'ProdutosUnicaCategoria', IntToStr(IfThen(chkProdutosCategoria.Checked, 1, 0)));

  if cbxCategoriaEPlataforma.ItemIndex <> -1 then
  begin
    DM.IniWriteString('ECommerce', 'CategoriaUnica', IntToStr(TepCategoria(cbxCategoriaEPlataforma.Items.Objects[cbxCategoriaEPlataforma.ItemIndex]).IdCategoria));
    DM.IniWriteString('ECommerce', 'DescCategoriaUnica', TepCategoria(cbxCategoriaEPlataforma.Items.Objects[cbxCategoriaEPlataforma.ItemIndex]).Nome);
  end
  else
  begin
    DM.IniWriteString('ECommerce', 'CategoriaUnica', '0');
    DM.IniWriteString('ECommerce', 'DescCategoriaUnica', '');
  end;

  DM.IniWriteString('Schedule', 'DiasImportacao', edtDiasImportacao.Text);
  DM.IniWriteString('Schedule', 'ImportacaoAuto', IntToStr(IfThen(chkImportacaoAuto.Checked, 1, 0)));
  DM.IniWriteString('Schedule', 'MinImportacao', edtMinImportacao.Text);
  DM.IniWriteString('Schedule', 'ImportacaoCliente', IntToStr(IfThen(chkImpCliente.Checked, 1, 0)));
  DM.IniWriteString('Schedule', 'ImportacaoPedido', IntToStr(IfThen(chkImpPedido.Checked, 1, 0)));
  DM.IniWriteString('Schedule', 'DiasExportacao', edtDiasExportacao.Text);
  DM.IniWriteString('Schedule', 'ExportacaoAuto', IntToStr(IfThen(chkExportacaoAuto.Checked, 1, 0)));
  DM.IniWriteString('Schedule', 'MinExportacao', edtMinExportacao.Text);
  DM.IniWriteString('Schedule', 'ExportacaoFabricante', IntToStr(IfThen(chkExpFabricante.Checked, 1, 0)));
  DM.IniWriteString('Schedule', 'ExportacaoEstoque', IntToStr(IfThen(chkExpEstoque.Checked, 1, 0)));
  DM.IniWriteString('Schedule', 'ExportacaoQuantidade', IntToStr(IfThen(chkExpQuantidade.Checked, 1, 0)));

  DM.LoadAppValues;
end;

function TFrmConfig.Start: Boolean;
begin
  DM.OpenConnection;
  LoadValues;
  LoadEstoqueList(Dm.ECommerceInfo.FEstoque);
  LoadPaymentList;
  LoadColumns;
  ShowModal;
  DM.CloseConnection;
  Result := True;
end;

procedure TFrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmConfig.btnCloseClick(Sender: TObject);
begin
  SaveValues;
  SaveGridColumns;

  //ATUALIZO OS PARAMETROS LIDOS DO INI COM AS NOVAS CONFIGURAÇÕES QUE FORAM SALVAS.
  DM.LoadAppValues;

  DM.quPayments.Close;
  Close;
end;

procedure TFrmConfig.cbColumnsChange(Sender: TObject);
begin

  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];

  cbColumns.Visible := False;
  sgColumns.SetFocus;

end;

procedure TFrmConfig.cbColumnsExit(Sender: TObject);
begin

  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];
  cbColumns.Visible := False;
  sgColumns.SetFocus;

end;

procedure TFrmConfig.sgColumnsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  //Somente na Coluna desejada
  if ((ACol = 1) AND (ARow <> 0)) then
  begin
   {Size and position the combo box to fit the cell}
    R := sgColumns.CellRect(ACol, ARow);
    R.Left := R.Left + sgColumns.Left;
    R.Right := R.Right + sgColumns.Left;
    R.Top := R.Top + sgColumns.Top;
    R.Bottom := R.Bottom + sgColumns.Top;
    cbColumns.Left := R.Left + 1;
    cbColumns.Top := R.Top + 1;
    cbColumns.Width := (R.Right + 1) - R.Left;
    cbColumns.Height := (R.Bottom + 1) - R.Top;
   {Show the combobox}
    cbColumns.Text := sgColumns.Cells[ACol, ARow];
    cbColumns.Visible := True;
    cbColumns.SetFocus;
  end;
  CanSelect := True;
end;

procedure TFrmConfig.LoadColumns;
var
  sColumn : String;
  i : Integer;
begin

  sgColumns.Cells[0,0] := 'E-Commerce';
  sgColumns.Cells[1,0] := 'MainRetail';

  sColumn := DM.IniReadString('Payment', 'List');

  i := 1;
  AddGridItem(sColumn, 'Boleto Bancário', i);
  inc(i);
  AddGridItem(sColumn, 'Depósito Identificado', i);
  inc(i);
  AddGridItem(sColumn, 'Dinheiro', i);
  inc(i);
  AddGridItem(sColumn, 'Cheque', i);
  inc(i);
  AddGridItem(sColumn, 'Itaú Shopline', i);
  inc(i);
  AddGridItem(sColumn, 'Bradesco Visa Electron', i);
  inc(i);
  AddGridItem(sColumn, 'Débito Conta BB', i);
  inc(i);
  AddGridItem(sColumn, 'Bradesco Pagto Fácil', i);
  inc(i);
  AddGridItem(sColumn, 'Bradesco Transf Contas', i);
  inc(i);
  AddGridItem(sColumn, 'M-Cash', i);
  inc(i);
  AddGridItem(sColumn, 'CCCamex', i);
  inc(i);
  AddGridItem(sColumn, 'CCCdiners', i);
  inc(i);
  AddGridItem(sColumn, 'CCCmastercard', i);
  inc(i);
  AddGridItem(sColumn, 'CCCsollo', i);
  inc(i);
  AddGridItem(sColumn, 'CCCvisa', i);
  inc(i);
  AddGridItem(sColumn, 'CCCdiners_redecard', i);
  inc(i);
  AddGridItem(sColumn, 'CCCmaster_redecard', i);
  inc(i);
  AddGridItem(sColumn, 'CCCvisanet', i);
  inc(i);
  AddGridItem(sColumn, 'CCCamex_webpos', i);

  sgColumns.RowCount := i;

end;

procedure TFrmConfig.SaveGridColumns;
var
  sColumn : String;
  i       : integer;
begin
  {
  for i:=1 to sgColumns.RowCount-1 do
    if Trim(sgColumns.Cells[0,i]) <> '' then
      sColumn := sColumn + sgColumns.Cells[0,i] + '=' + InttoStr(DM.GetPaymentID(sgColumns.Cells[1,i])) + ';';
  }

  for i:=1 to sgColumns.RowCount-1 do
    if Trim(sgColumns.Cells[0,i]) <> '' then
      sColumn := sColumn + sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i] + ';';

  if sColumn = '' then
     Exit;

  DM.IniWriteString('Payment', 'List', sColumn);

end;

procedure TFrmConfig.AddGridItem(AList, APayment: String; APos : Integer);
begin
  sgColumns.Cells[0, APos] := APayment;
  sgColumns.Cells[1, APos] := DM.GetPaymentName(StrToIntDef(ParseParam(AList, APayment), 1));
end;

procedure TFrmConfig.LoadPaymentList;
begin
  with DM.quPayments do
  begin
    if not Active then
      Open;
    First;
    while not EOF do
    begin
      cbColumns.Items.Add(DM.quPayments.FieldByName('MeioPag').AsString);
      Next;
    end;
  end;
end;

procedure TFrmConfig.btnConectarClick(Sender: TObject);
begin
  lbResult.Caption := '';
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  edtMinImportacao.Enabled := chkImportacaoAuto.Checked;
  chkImpCliente.Enabled    := chkImportacaoAuto.Checked;
  chkImpPedido.Enabled     := chkImportacaoAuto.Checked;
  edtMinExportacao.Enabled := chkExportacaoAuto.Checked;
  chkExpFabricante.Enabled := chkExportacaoAuto.Checked;
  chkExpEstoque.Enabled    := chkExportacaoAuto.Checked;
  chkExpQuantidade.Enabled := chkExportacaoAuto.Checked;
end;

procedure TFrmConfig.chkImportacaoAutoClick(Sender: TObject);
begin
  edtMinImportacao.Enabled := chkImportacaoAuto.Checked;
  chkImpCliente.Enabled := chkImportacaoAuto.Checked;
  chkImpPedido.Enabled := chkImportacaoAuto.Checked;
end;

procedure TFrmConfig.chkExportacaoAutoClick(Sender: TObject);
begin
  edtMinExportacao.Enabled := chkExportacaoAuto.Checked;
  chkExpFabricante.Enabled := chkExportacaoAuto.Checked;
  chkExpEstoque.Enabled := chkExportacaoAuto.Checked;
  chkExpQuantidade.Enabled := chkExportacaoAuto.Checked;
end;

procedure TFrmConfig.LoadEstoqueList(AIDEstoque : Integer);
var
  i: Integer;
  epEstoqueSync: TepEstoqueSync;
  epEstoqueLista: TepEstoqueLista;
begin
  epEstoqueSync := TepEstoqueSync.Create;
  try
    epEstoqueSync.Init(DM.HTTPReqRespCatalog,
                       DM.ECommerceInfo.FURL,
                       DM.ECommerceInfo.FUser,
                       DM.ECommerceInfo.FPW);

    TepEntidadeLista(epEstoqueLista) := epEstoqueSync.Listar;
    for i := 0 to Pred(epEstoqueLista.Count) do
    begin
      cbxEstoque.Items.AddObject(TepEstoque(epEstoqueLista.Items[i]).Nome, epEstoqueLista.Items[i]);
      if AIDEstoque = TepEstoque(epEstoqueLista.Items[i]).IdEstoque then
        cbxEstoque.ItemIndex := i;
    end;
  except
    FreeAndNil(epEstoqueLista);
    FreeAndNil(epEstoqueSync);
    ShowMessage('Não foi possível se conectar ao webservice da e-Plataforma. Verifique se o Usuário, Senha ou URL estão corretos.');
  end;
end;

procedure TFrmConfig.LoadCategoriaEPlataforma(AIdCategoria : Integer);
var
  i: Integer;
  epCategoriaSync: TepCategoriaSync;
  epCategoriaLista: TepCategoriaLista;
begin
  epCategoriaSync := TepCategoriaSync.Create;
  try
    epCategoriaSync.Init(DM.HTTPReqRespCatalog,
                       DM.ECommerceInfo.FURL,
                       DM.ECommerceInfo.FUser,
                       DM.ECommerceInfo.FPW);

    TepEntidadeLista(epCategoriaLista) := epCategoriaSync.Listar;
    for i := 0 to Pred(epCategoriaLista.Count) do
    begin
      cbxCategoriaEPlataforma.Items.AddObject(TepCategoria(epCategoriaLista.Items[i]).Nome, epCategoriaLista.Items[i]);
      if TepCategoria(epCategoriaLista.Items[i]).IdCategoria = AIdCategoria then
        cbxCategoriaEPlataforma.ItemIndex := i;
    end;
  except
    FreeAndNil(epCategoriaLista);
    FreeAndNil(epCategoriaSync);
    ShowMessage('Não foi possível se conectar ao webservice da e-Plataforma. Verifique se o Usuário, Senha ou URL estão corretos.');
  end;

end;

procedure TFrmConfig.chkProdutosCategoriaClick(Sender: TObject);
begin
  cbxCategoriaEPlataforma.Enabled := chkProdutosCategoria.Checked;

  if chkProdutosCategoria.Checked then
    LoadCategoriaEPlataforma(0)
  else
    cbxCategoriaEPlataforma.Items.Clear;
end;

procedure TFrmConfig.btnCancelarClick(Sender: TObject);
begin
  DM.quPayments.Close;
  Close;
end;

end.
