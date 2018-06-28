unit uDados;

interface

uses
  Sintegra, SysUtils, Classes, Forms, Dialogs, DB, DBClient, Provider;

type
  TDados = class(TDataModule)
    Registro75: TClientDataSet;
    Registro60R: TClientDataSet;
    Empresa: TClientDataSet;
    EmpresaRazaoSocial: TStringField;
    EmpresaInscEstadual: TStringField;
    EmpresaEndereco: TStringField;
    EmpresaComplemento: TStringField;
    EmpresaNumero: TIntegerField;
    EmpresaBairro: TStringField;
    EmpresaMunicipio: TStringField;
    EmpresaUF: TStringField;
    EmpresaCNPJ: TStringField;
    EmpresaCEP: TStringField;
    EmpresaFax: TStringField;
    EmpresaFone: TStringField;
    EmpresaResponsavel: TStringField;
    EmpresaSubstitutoTributario: TBooleanField;
    EmpresaContribuinteIPI: TBooleanField;
    Registro75DtValidadeIni: TDateField;
    Registro75DtValidadeFim: TDateField;
    Registro75CodProduto: TStringField;
    Registro75CodNCM: TStringField;
    Registro75Descricao: TStringField;
    Registro75Unidade: TStringField;
    Registro75AliquotaIPI: TCurrencyField;
    Registro75AliquotaICMS: TCurrencyField;
    Registro75ReducaoBaseCalc: TCurrencyField;
    Registro75BaseICMSST: TCurrencyField;
    Registro60RMes: TIntegerField;
    Registro60RAno: TIntegerField;
    Registro60RCodProduto: TStringField;
    Registro60RDescProduto: TStringField;
    Registro60RQuantidade: TFloatField;
    Registro60RValorAcumulado: TCurrencyField;
    Registro60RValorAcumuladoICMS: TCurrencyField;
    Registro60RSitTributaria: TStringField;
    Registro60M: TClientDataSet;
    Registro60MNumSerieEquipamento: TStringField;
    Registro60MDataEmissao: TDateField;
    Registro60MNumeroECF: TIntegerField;
    Registro60MCOOInicial: TIntegerField;
    Registro60MCOOFinal: TIntegerField;
    Registro60MContReducaoZ: TIntegerField;
    Registro60MVendaBruta: TCurrencyField;
    Registro60MGTFinal: TCurrencyField;
    Registro60A: TClientDataSet;
    Registro60ANumSerieEquipamento: TStringField;
    Registro60ASitTributaria: TStringField;
    Registro60AValorAcumulado: TCurrencyField;
    Registro60I: TClientDataSet;
    Registro60D: TClientDataSet;
    Registro60INumSerieEquipamento: TStringField;
    Registro60ICOOCupom: TIntegerField;
    Registro60INumItem: TIntegerField;
    Registro60ICodProduto: TStringField;
    Registro60IDescProduto: TStringField;
    Registro60IQuantidade: TFloatField;
    Registro60IValorunitario: TCurrencyField;
    Registro60IBaseICMS: TCurrencyField;
    Registro60ISitTributaria: TStringField;
    Registro60DNumSerieEquipamento: TStringField;
    Registro60DQuantAcumulada: TFloatField;
    Registro60DValorAcumulado: TCurrencyField;
    Registro60DBaseICMSAcumulada: TCurrencyField;
    Registro60DSitTributaria: TStringField;
    dsRegistro60M: TDataSource;
    dsRegistro60A: TDataSource;
    dsRegistro60D: TDataSource;
    dsRegistro60I: TDataSource;
    Registro60MContReinicioOper: TIntegerField;
    Registro60MModeloDoc: TIntegerField;
    Registro60DCodProduto: TStringField;
    Registro60DDescProduto: TStringField;
    ModeloDoc: TClientDataSet;
    ModeloDocCodigo: TIntegerField;
    ModeloDocDescricao: TStringField;
    Registro60MDescModeloDoc: TStringField;
    Registro61: TClientDataSet;
    Registro61R: TClientDataSet;
    Registro61DataEmissao: TDateField;
    Registro61ModeloDoc: TIntegerField;
    Registro61Serie: TStringField;
    Registro61SubSerie: TStringField;
    Registro61NumeroIncial: TIntegerField;
    Registro61NumeroFinal: TIntegerField;
    Registro61ValorTotal: TCurrencyField;
    Registro61BaseICMS: TCurrencyField;
    Registro61IsentasNTributadas: TCurrencyField;
    Registro61Outras: TCurrencyField;
    Registro61Aliquota: TCurrencyField;
    TipoDocumento: TClientDataSet;
    TipoDocumentoCodigo: TIntegerField;
    TipoDocumentoDescricao: TStringField;
    Registro61TipoDocumento: TStringField;
    Registro61RMes: TSmallintField;
    Registro61RAno: TSmallintField;
    Registro61RCodProduto: TStringField;
    Registro61RQuantidade: TFloatField;
    Registro61RValorBruto: TCurrencyField;
    Registro61RBaseCalcICMS: TCurrencyField;
    Registro61RAliquota: TCurrencyField;
    Registro61RDescProduto: TStringField;
    Registro50: TClientDataSet;
    Registro50CNPJCPF: TStringField;
    Registro50InscEstadual: TStringField;
    Registro50Data: TDateField;
    Registro50UF: TStringField;
    Registro50Modelo: TIntegerField;
    Registro50Serie: TStringField;
    Registro50Numero: TIntegerField;
    Registro50Emitente: TStringField;
    Registro50Situacao: TStringField;
    SitNotaFiscal: TClientDataSet;
    TipoEmitente: TClientDataSet;
    TipoEmitenteDescricao: TStringField;
    SitNotaFiscalCodigo: TStringField;
    SitNotaFiscalDescricao: TStringField;
    TipoEmitentecodigo: TStringField;
    Registro50DescSituacao: TStringField;
    Registro50DescTipoEmitente: TStringField;
    dsRegistro50: TDataSource;
    Registro50Aliq: TClientDataSet;
    dsRegistro50Aliq: TDataSource;
    Registro50AliqAliquota: TCurrencyField;
    Registro50AliqValorTotal: TCurrencyField;
    Registro50AliqBaseICMS: TCurrencyField;
    Registro50AliqValorICMS: TCurrencyField;
    Registro50AliqIsenta_NTrib: TCurrencyField;
    Registro50AliqOutras: TCurrencyField;
    Registro50NumLancamento: TIntegerField;
    Registro50AliqNumLancamento: TIntegerField;
    Registro50Itens: TClientDataSet;
    dsRegistro50Itens: TDataSource;
    Registro50ItensNumLancamento: TIntegerField;
    Registro50ItensCST: TStringField;
    Registro50ItensCodProduto: TStringField;
    Registro50ItensQuantidade: TFloatField;
    Registro50ItensValorProduto: TCurrencyField;
    Registro50ItensDesconto: TCurrencyField;
    Registro50ItensBaseICMS: TCurrencyField;
    Registro50ItensBaseICMSST: TCurrencyField;
    Registro50ItensValorIPI: TCurrencyField;
    Registro50ItensAliquota: TCurrencyField;
    Registro50ItensNumItem: TSmallintField;
    Registro50ItensDescProduto: TStringField;
    Registro50Frete: TCurrencyField;
    Registro50Seguro: TCurrencyField;
    Registro50DespAcessorias: TCurrencyField;
    Registro74: TClientDataSet;
    Registro74DataInventario: TDateField;
    Registro74CodProduto: TStringField;
    Registro74Quantidade: TFloatField;
    Registro74ValorTotal: TCurrencyField;
    Registro74DescProduto: TStringField;
    Registro50AliqCFOP: TStringField;
    Registro50ItensCFOP: TStringField;
    Sintegra: TSintegra;
    procedure DataModuleCreate(Sender: TObject);
    procedure EmpresaNewRecord(DataSet: TDataSet);
    procedure Registro60RNewRecord(DataSet: TDataSet);
    procedure Registro60ANewRecord(DataSet: TDataSet);
    procedure Registro60INewRecord(DataSet: TDataSet);
    procedure Registro61RNewRecord(DataSet: TDataSet);
    procedure Registro50NewRecord(DataSet: TDataSet);
    procedure Registro50AliqNewRecord(DataSet: TDataSet);
    procedure Registro50ItensNewRecord(DataSet: TDataSet);
    procedure Registro74NewRecord(DataSet: TDataSet);
    procedure SintegraErro(aErro: String);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FRelatorioErro: TStringList;
    procedure Abre(cli: TClientDataset);
    procedure LocalSave(DataSet: TDataSet);
    function GetRelatorioErro: TStringList;
    procedure SetRelatorioErro(const Value: TStringList);
  public
    property RelatorioErro: TStringList read GetRelatorioErro write SetRelatorioErro;
  end;

var
  Dados: TDados;

implementation

{$R *.dfm}

procedure TDados.LocalSave(DataSet: TDataSet);
begin
  TClientDataset(DataSet).SaveToFile();
end;

procedure TDados.Abre(cli: TClientDataset);
begin
  if (not(Cli.Active)) and (cli.Fields.Count > 0) then
  begin
    Cli.FileName := ExtractFilePath(ParamStr(0)) + Cli.FileName;
    Cli.CreateDataSet;
  end;

  {
  if FileExists(Cli.FileName) then
    Cli.LoadFromFile()
  else
    Cli.SaveToFile();
  
  Cli.AfterPost   := LocalSave;
  Cli.AfterDelete := LocalSave;
  }
  
end;      

procedure TDados.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin

  FRelatorioErro := TStringList.Create;

  Abre(Registro75);

  Abre(ModeloDoc);

  Abre(TipoDocumento);

  Abre(SitNotaFiscal);

  Abre(TipoEmitente);

  for i := 0 to ComponentCount -1 do
    if Components[i] is TClientDataSet then
      Abre(Components[i] as TClientDataSet);

end;

procedure TDados.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FRelatorioErro)
end;

procedure TDados.EmpresaNewRecord(DataSet: TDataSet);
begin
  EmpresaSubstitutoTributario.Value := False;
  EmpresaContribuinteIPI.Value := False;
end;

procedure TDados.Registro60RNewRecord(DataSet: TDataSet);
begin
  Registro60RMes.Value := StrToInt(FormatDateTime('m', Date));
  Registro60RAno.Value := StrToInt(FormatDateTime('yyyy', Date));
  Registro60RQuantidade.Value := 0;
  Registro60RValorAcumulado.Value := 0;
  Registro60RValorAcumulado.Value := 0;
  Registro60RValorAcumuladoICMS.Value := 0;
end;

procedure TDados.Registro60ANewRecord(DataSet: TDataSet);
begin
  Registro60ANumSerieEquipamento.Value := Registro60MNumSerieEquipamento.Value;
  Registro60AValorAcumulado.Value := 0;
end;

procedure TDados.Registro60INewRecord(DataSet: TDataSet);
begin
  Registro60INumSerieEquipamento.Value := Registro60MNumSerieEquipamento.Value;
  Registro60IQuantidade.Value := 0;
  Registro60IValorunitario.Value := 0;
  Registro60IBaseICMS.Value := 0;
end;

procedure TDados.Registro61RNewRecord(DataSet: TDataSet);
begin
  Registro61RQuantidade.Value   := 0;
  Registro61RValorBruto.Value   := 0;
  Registro61RBaseCalcICMS.Value := 0;
  Registro61RAliquota.Value     := 0;
end;

procedure TDados.Registro50NewRecord(DataSet: TDataSet);
begin
  Registro50Emitente.Value       := 'P';
  Registro50Situacao.Value       := 'N';
  Registro50Frete.Value          := 0;
  Registro50Seguro.Value         := 0;
  Registro50DespAcessorias.Value := 0;
end;

procedure TDados.Registro50AliqNewRecord(DataSet: TDataSet);
begin
  Registro50AliqNumLancamento.Value := Registro50NumLancamento.Value;
  Registro50AliqAliquota.Value      := 0;
  Registro50AliqValorTotal.Value    := 0;
  Registro50AliqBaseICMS.Value      := 0;
  Registro50AliqIsenta_NTrib.Value  := 0;
  Registro50AliqValorICMS.Value     := 0;
  Registro50AliqOutras.Value        := 0;
end;

procedure TDados.Registro50ItensNewRecord(DataSet: TDataSet);
begin
  Registro50ItensNumLancamento.Value := Registro50NumLancamento.Value;
  Registro50ItensQuantidade.Value    := 0;
  Registro50ItensValorProduto.Value  := 0;
  Registro50ItensDesconto.Value      := 0;
  Registro50ItensBaseICMS.Value      := 0;
  Registro50ItensBaseICMSST.Value    := 0;
  Registro50ItensValorIPI.Value      := 0;
  Registro50ItensAliquota.Value      := 0;
end;

procedure TDados.Registro74NewRecord(DataSet: TDataSet);
begin
  Registro74Quantidade.Value := 0;
  Registro74ValorTotal.Value := 0;
  Registro74DataInventario.Value := Date;
end;

procedure TDados.SintegraErro(aErro: String);
begin
  RelatorioErro.Add(aErro);
end;

function TDados.GetRelatorioErro: TStringList;
begin
  Result := FRelatorioErro;
end;

procedure TDados.SetRelatorioErro(const Value: TStringList);
begin
  FRelatorioErro := Value;
end;

end.

