unit uDMSintegra;

interface

uses
  SysUtils, Classes, DB, ADODB, IniFiles, Forms, uDMGlobal, ImgList,
  Controls, siComp, DBClient, Provider;

const
  SV_SERVER     = '#SRV#=';
  SV_DATABASE   = '#DB#=';
  SV_USER       = '#USER#=';
  SV_PASSWORD   = '#PW#=';
  SV_WIN_LOGIN  = '#WIN#=';
  SV_USE_NETLIB = '#NLIB#=';

type
  TDMSintegra = class(TDataModule)
    ADOConn: TADOConnection;
    quSale: TADOQuery;
    quEcfProd: TClientDataSet;
    quEcfProdcodigoproduto: TStringField;
    quEcfProdquantidade: TFloatField;
    quEcfProdvalortotal: TFloatField;
    quEcfProdaliquotaimposto: TStringField;
    quEcfProdnomeproduto: TStringField;
    quEcfProdunidade: TStringField;
    quEcfProdcf: TStringField;
    qu60R: TADOQuery;
    qu60RCodigoProduto: TStringField;
    qu60RProduto: TStringField;
    qu60RQuantidade: TFloatField;
    qu60RValorTotal: TFloatField;
    qu60RPercImposto: TBCDField;
    qu60RUnidade: TStringField;
    qu60RCF: TStringField;
    quReducaoZ: TADOQuery;
    dspReducaoZ: TDataSetProvider;
    cdsReducaoZ: TClientDataSet;
    quTributacaoEcf: TADOQuery;
    dspTributacaoEcf: TDataSetProvider;
    cdsTributacaoEcf: TClientDataSet;
    cdsTributacaoEcfIDReducaoZ: TIntegerField;
    cdsTributacaoEcfAliquota: TFloatField;
    cdsTributacaoEcfBaseCalculo: TBCDField;
    cdsTributacaoEcfValImposto: TBCDField;
    quStore: TADOQuery;
    quCashRegister: TADOQuery;
    dsCashRegister: TDataSource;
    dsStore: TDataSource;
    quCashRegisterIDCashRegister: TIntegerField;
    quCashRegisterCashRegister: TStringField;
    quStoreIDStore: TIntegerField;
    quStoreStore: TStringField;
    spGetNextCode: TADOStoredProc;
    quECF: TADOQuery;
    dsECF: TDataSource;
    quECFIDECF: TIntegerField;
    quECFNumeroECF: TIntegerField;
    quECFNumeroSerie: TStringField;
    quECFIDStore: TIntegerField;
    quFreeSQL: TADOQuery;
    quPurchase: TADOQuery;
    qryEmpresa: TADOQuery;
    qryEmpresaIDEmpresa: TIntegerField;
    qryEmpresaRazaoSocial: TStringField;
    qryEmpresaCGC: TStringField;
    qryEmpresaInscricaoEstadual: TStringField;
    qryEmpresaInscricaoMunicipal: TStringField;
    qryEmpresaEndereco: TStringField;
    qryEmpresaNumero: TIntegerField;
    qryEmpresaCoplemento: TStringField;
    qryEmpresaBairro: TStringField;
    qryEmpresaCEP: TStringField;
    qryEmpresaCidade: TStringField;
    qryEmpresaIDEstado: TStringField;
    qryEmpresaContato: TStringField;
    qryEmpresaTelefone: TStringField;
    qryEmpresaFax: TStringField;
    Virtual_Produtos: TClientDataSet;
    Virtual_ProdutosCodigoProduto: TStringField;
    Virtual_ProdutosDescricao: TStringField;
    Virtual_ProdutosAliquota: TFloatField;
    Virtual_ProdutosCF: TStringField;
    Virtual_ProdutosUNIDADE: TStringField;
    cdsSintegra: TClientDataSet;
    cdsSintegraTipo: TStringField;
    cdsSintegraCNPJ: TStringField;
    cdsSintegraIEst: TStringField;
    cdsSintegraDataReg: TDateField;
    cdsSintegraUF: TStringField;
    cdsSintegraRF: TStringField;
    cdsSintegraSerie: TStringField;
    cdsSintegraDoc: TStringField;
    cdsSintegraCFOP: TStringField;
    cdsSintegraP_T: TStringField;
    cdsSintegraContabil: TFloatField;
    cdsSintegraBase: TFloatField;
    cdsSintegraImposto: TFloatField;
    cdsSintegraIsento: TFloatField;
    cdsSintegraOutras: TFloatField;
    cdsSintegraAliq: TFloatField;
    cdsSintegraS_N: TStringField;
    cdsSintegracodfornecedor: TStringField;
    cdsSintegraCF: TStringField;
    cdsSintegraUNIDADE: TStringField;
    Virtual_CFOP: TClientDataSet;
    Virtual_CFOPCFOP: TStringField;
    Virtual_CFOPVALORCONTABIL: TFloatField;
    Virtual_CFOPBASECALCULO: TFloatField;
    Virtual_CFOPVALORICMS: TFloatField;
    Virtual_CFOPVALORISENTAS: TFloatField;
    Virtual_CFOPVALOROUTRAS: TFloatField;
    Virtual_UF: TClientDataSet;
    Virtual_UFUF: TStringField;
    Virtual_UFVALORCONTABIL: TFloatField;
    Virtual_UFBASECALCULO: TFloatField;
    Virtual_UFVALORICMS: TFloatField;
    Virtual_UFVALORISENTAS: TFloatField;
    Virtual_UFVALOROUTRAS: TFloatField;
    cdsProdutoCompra: TClientDataSet;
    cdsProdutoCompranf: TStringField;
    cdsProdutoCompracodfornecedor: TStringField;
    cdsProdutoCompracodproduto: TStringField;
    cdsProdutoCompracfop: TStringField;
    cdsProdutoCompraksfi: TStringField;
    cdsProdutoCompranritem: TStringField;
    cdsProdutoCompraquantidade: TStringField;
    cdsProdutoCompravalortotal: TStringField;
    cdsProdutoCompraaliq: TStringField;
    cdsProdutoCompracnpj: TStringField;
    cdsProdutoCompradescricao: TStringField;
    cdsProdutoCompraUnidade: TStringField;
    qryLuEmpresa: TADOQuery;
    dsLuEmpresa: TDataSource;
    qryLuEmpresaIDEmpresa: TIntegerField;
    qryLuEmpresaEmpresa: TStringField;
    quSaleCodFornecedor: TStringField;
    quSaleCodProduto: TStringField;
    quSaleQtd: TFloatField;
    quSaleValorTotal: TFloatField;
    quSaleValorImposto: TBCDField;
    quSalePercImposto: TBCDField;
    quSaleFrete: TBCDField;
    quSaleOutrosCustos: TBCDField;
    quSaleNovoCusto: TBCDField;
    quSaleNotaFiscal: TStringField;
    quSaleDataRegistro: TDateTimeField;
    quSaleDataFatura: TDateTimeField;
    quSaleCPF: TStringField;
    quSaleInscEstadual: TStringField;
    quSaleUF: TStringField;
    quSaleCliente: TStringField;
    quSaleProduto: TStringField;
    quPurchaseCodFornecedor: TStringField;
    quPurchaseCodProduto: TStringField;
    quPurchaseQtd: TFloatField;
    quPurchaseValorTotal: TFloatField;
    quPurchaseValorImposto: TBCDField;
    quPurchasePercImposto: TBCDField;
    quPurchaseFrete: TBCDField;
    quPurchaseOutrosCustos: TBCDField;
    quPurchaseNovoCusto: TBCDField;
    quPurchaseTipo: TStringField;
    quPurchaseNotaFiscal: TStringField;
    quPurchaseDataRegistro: TDateTimeField;
    quPurchaseDataFatura: TDateTimeField;
    quPurchaseCNPJ: TStringField;
    quPurchaseInscEstadual: TStringField;
    quPurchaseUF: TStringField;
    quPurchaseFornecedor: TStringField;
    quPurchaseProduto: TStringField;
    quReducaoZIDReducaoZ: TIntegerField;
    quReducaoZMovDate: TDateTimeField;
    quReducaoZNumeroSerie: TStringField;
    quReducaoZNumeroLoja: TIntegerField;
    quReducaoZNumeroECF: TIntegerField;
    quReducaoZCOOInicial: TIntegerField;
    quReducaoZCOOFinal: TIntegerField;
    quReducaoZNumCancelamentos: TIntegerField;
    quReducaoZValCancelamentos: TBCDField;
    quReducaoZValDescontos: TBCDField;
    quReducaoZGTInicial: TBCDField;
    quReducaoZGTFinal: TBCDField;
    quReducaoZSubstituicaoTrib: TBCDField;
    quReducaoZIsencao: TBCDField;
    quReducaoZNumReducaoZ: TIntegerField;
    quPurchaseCFOP: TStringField;
    quSaleIDPessoa: TIntegerField;
    quSaleCFOP: TStringField;
    quSaleEstado_UF: TStringField;
    quReducaoZNaoTributavel: TBCDField;
    quSaleGrupoFornecido: TStringField;
    quSaleCF: TStringField;
    quPurchaseGrupoFornecido: TStringField;
    quPurchaseCF: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure quSaleCalcFields(DataSet: TDataSet);
    procedure qryEmpresaAfterOpen(DataSet: TDataSet);
  private
    FUF : String;
    FAppInfo: TInifile;
    function SetConnectionStr(sUser, sPw, sDB, sServer:String):String;
    function SetConnectionStrNoNETLIB(sUser, sPw, sDB, sServer:String):String;
    function GetConfigFile : String;
  public
    procedure SetAppProperty(sSection, sKey, Text: String);
    function GetAppProperty(sSection, sKey: String): String;
    function Decode(Key, Value: String): String;
    function Encode(Key, Value: String): String;
  end;

var
  DMSintegra: TDMSintegra;

implementation

uses Windows, uEncryptFunctions, uParamFunctions, Math, Registry;

{$R *.dfm}

procedure TDMSintegra.DataModuleCreate(Sender: TObject);
var
  sDBConfig, sPW, sUser, sDBAlias, sServer, sWinLogin, sLib : String;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('SOFTWARE\AppleNet', True);

    sDBConfig := DecodeServerInfo(ReadString('ServerInfo'), 'Server', CIPHER_TEXT_STEALING, FMT_UU);

    sServer   := ParseParam(sDBConfig, SV_SERVER);
    sDBAlias  := ParseParam(sDBConfig, SV_DATABASE);
    sUser     := ParseParam(sDBConfig, SV_USER);
    sPW       := ParseParam(sDBConfig, SV_PASSWORD);
    sWinLogin := ParseParam(sDBConfig, SV_WIN_LOGIN);
    sLib      := ParseParam(sDBConfig, SV_USE_NETLIB);

    if sWinLogin = 'N' then
      if sLib = 'Y' then
        ADOConn.ConnectionString := SetConnectionStr(sUser, sPW, sDBAlias, sServer)
      else
        ADOConn.ConnectionString := SetConnectionStrNoNETLIB(sUser, sPW, sDBAlias, sServer)
    else
      if sLib = 'Y' then
        ADOConn.ConnectionString := SetWinConnectionStr(sDBAlias, sServer)
      else
        ADOConn.ConnectionString := SetWinConnectionStrNoNETLIB(sDBAlias, sServer);
  finally
    Free;
  end;

  FAppInfo := TIniFile.Create(ExtractFilePath(Application.ExeName) + GetConfigFile);
end;

procedure TDMSintegra.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FAppInfo);
end;

function TDMSintegra.GetAppProperty(sSection, sKey: String): String;
begin
  Result := FAppInfo.ReadString(sSection, sKey, '');
end;

function TDMSintegra.GetConfigFile: String;
begin
  Result := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
end;

procedure TDMSintegra.SetAppProperty(sSection, sKey, Text: String);
begin
  FAppInfo.WriteString(sSection, sKey, Text);
end;

function TDMSintegra.Decode(Key, Value: String): String;
begin
 Result := DecodeServerInfo(Value, Key, CIPHER_TEXT_STEALING, FMT_UU);
end;

function TDMSintegra.Encode(Key, Value: String): String;
begin
  Result := EncodeServerInfo(Value, Key, CIPHER_TEXT_STEALING, FMT_UU);
end;

function TDMSintegra.SetConnectionStrNoNETLIB(sUser, sPw, sDB, sServer:String):String;
begin
  //Provider=SQLOLEDB.1 uses ADO
  if Trim(sPW) <> '' then
     sPW := 'Password='+sPW+';';
  Result := 'Provider=SQLOLEDB.1;Persist Security Info=True;'+
            sPW+'User ID='+sUser+';Initial Catalog='+sDB+';Data Source='+sServer+';'
end;

function TDMSintegra.SetConnectionStr(sUser, sPw, sDB, sServer:String):String;
begin
  //"Network Library=DBMSSOCN" tells OLE DB to use TCP/IP rather than Named Pipes
  //Provider=SQLOLEDB.1 uses ADO
  if Trim(sPW) <> '' then
     sPW := 'Password='+sPW+';';
  Result := 'Provider=SQLOLEDB.1;Persist Security Info=True;Network Library=DBMSSOCN;'+
            sPW+'User ID='+sUser+';Initial Catalog='+sDB+';Data Source='+sServer+';'
end;

procedure TDMSintegra.quSaleCalcFields(DataSet: TDataSet);
var
  sEstado : String;
begin

  sEstado := 'RJ';

  if quSale.FieldByName('IDPessoa').AsInteger in [0, 1] then
  begin
    if FUF <> '' then
     sEstado := FUF;
  end
  else
  begin
   sEstado := quSale.FieldByName('UF').AsString;
  end;

  quSale.FieldByName('Estado_UF').AsString := sEstado;

end;

procedure TDMSintegra.qryEmpresaAfterOpen(DataSet: TDataSet);
begin
  FUF := qryEmpresa.FieldByName('IDEstado').AsString;
end;

end.
