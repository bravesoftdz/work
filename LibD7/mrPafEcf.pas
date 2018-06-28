unit mrPafEcf;

interface

uses
  Windows, SysUtils, Classes, StrUtils, XMLDoc, XMLIntf;

const
  ARQUIVO_DAV_TXT                    = 'ARQUIVO_DAV.TXT';
  ARQUIVO_ESTOQUE_TXT                = 'ARQUIVO_ESTOQUE.TXT';
  ARQUIVO_MERCADORIA_SERVICO_TXT     = 'ARQUIVO_MERCADORIA_SERVICO.TXT';
  ARQUIVO_OPERACAO_TXT               = 'ARQUIVO_OPERACAO.TXT';
  ARQUIVO_TRANSPORTE_PASSAGEIROS_TXT = 'ARQUIVO_TRANSPORTE_PASSAGEIROS.TXT';
  ARQUIVO_MEIO_PAGAMENTO_TXT         = 'ARQUIVO_MEIO_PAGAMENTO.TXT';

  ARQUIVO_DAV_XML                    = 'ARQUIVO_DAV.XML';
  ARQUIVO_ESTOQUE_XML                = 'ARQUIVO_ESTOQUE.XML';
  ARQUIVO_MERCADORIA_SERVICO_XML     = 'ARQUIVO_MERCADORIA_SERVICO.XML';
  ARQUIVO_REDUCAOZ_XML               = 'ARQUIVO_REDUCAOZ.XML';
  ARQUIVO_TOTALIZADOR_PARCIAL_XML    = 'ARQUIVO_TOTALIZADOR_PARCIAL.XML';
  ARQUIVO_VENDA_XML                  = 'ARQUIVO_VENDA.XML';
  ARQUIVO_ITEM_VENDA_XML             = 'ARQUIVO_ITEM_VENDA.XML';
  ARQUIVO_DOCUMENTO_GERAL_XML        = 'ARQUIVO_DOCUMENTO_GERAL.XML';
  ARQUIVO_PAGAMENTO_XML              = 'ARQUIVO_PAGAMENTO.XML';
  ARQUIVO_TRANSPORTE_PASSAGEIROS_XML = 'ARQUIVO_TRANSPORTE_PASSAGEIROS.XML';
  ARQUIVO_MEIO_PAGAMENTO_XML         = 'ARQUIVO_MEIO_PAGAMENTO.XML';

type
  PGenerateEAD = function (NomeArq: String; ChavePublica: String; ChavePrivada: String; EAD:String; Sign: Integer): Integer; StdCall;

  TmrPAFECFDesenvolvedora = class(TPersistent)
  private
    FInscricaoEstadual: String;
    FInscricaoMunicipal: String;
    FCNPJ: String;
    FRazaoSocial: String;
  published
    property RazaoSocial: String read FRazaoSocial write FRazaoSocial;
    property CNPJ: String read FCNPJ write FCNPJ;
    property InscricaoMunicipal: String read FInscricaoMunicipal write FInscricaoMunicipal;
    property InscricaoEstadual: String read FInscricaoEstadual write FInscricaoEstadual;
  end;

  TmrPAFECFUsuario = class(TPersistent)
  private
    FInscricaoEstadual: String;
    FInscricaoMunicipal: String;
    FCNPJ: String;
    FRazaoSocial: String;
  published
    property RazaoSocial: String read FRazaoSocial write FRazaoSocial;
    property CNPJ: String read FCNPJ write FCNPJ;
    property InscricaoMunicipal: String read FInscricaoMunicipal write FInscricaoMunicipal;
    property InscricaoEstadual: String read FInscricaoEstadual write FInscricaoEstadual;
  end;

  TmrPafEcf = class(TComponent)
  private
    FArquivo: TextFile;
    FVersaoERPAFECF: String;
    FCodigoMD5: String;
    FNomePAFECF: String;
    FVersaoPAFECF: String;
    FPAFECFDesenvolvedora: TmrPAFECFDesenvolvedora;
    FPAFECFUsuario: TmrPAFECFUsuario;
    FCaminhoArquivos: String;
    FChavePrivada: String;
    FChavePublica: String;
    HandleAssinaturaDLL: THandle;
    NomeAssinaturaDll: string;
    GenerateEAD: PGenerateEAD;
    FXMLMercadoriaServico: TXMLDocument;
    FXMLDAV: TXMLDocument;
    FTransportePassageiros: TXMLDocument;
    FXMLEstoque: TXMLDocument;
    FXMLReducaoZ: TXMLDocument;
    FXMLTotalizadorParcial: TXMLDocument;
    FXMLVenda: TXMLDocument;
    FXMLItemVenda: TXMLDocument;
    FXMLPagamento: TXMLDocument;
    FXMLDocumentoGeral: TXMLDocument;
    FXMLMeioPagamento: TXMLDocument;

    function AlinharTexto(ATexto: String; ATamanho: Integer): String;
    function AlinharNumero(ANumero: String; ATamanho: Integer): String;
    function RemoverMascara(ATexto: String): String;
    function FormatarData(AData: TDateTime): String;
    function FormatarDataXML(AData: String): String;
    function FormatarHora(AData: String): String;
    function FormatarValor(AValor: String): String;
    function FormatarBoolean(AValor: String): String;

    procedure GerarRegistroD1;
    procedure GerarRegistroD2;
    procedure GerarRegistroD9;

    procedure GerarRegistroE1;
    procedure GerarRegistroE2;
    procedure GerarRegistroE9;

    procedure GerarRegistroP1;
    procedure GerarRegistroP2;
    procedure GerarRegistroP9;

    procedure GerarRegistroR01(ADataInicial, ADataFinal: TDateTime);
    procedure GerarRegistroR02;
    procedure GerarRegistroR03;
    procedure GerarRegistroR04;
    procedure GerarRegistroR05;
    procedure GerarRegistroR06;
    procedure GerarRegistroR07;

    procedure GerarRegistroT1;
    procedure GerarRegistroT2;
    procedure GerarRegistroT9;

    procedure GerarRegistroMeioPagamento;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Init: Boolean;
    function GerarArquivoDAV: Boolean; // REQUISITO VI
    function GerarArquivoEstoque: Boolean; // REQUISITO VII
    function GerarArquivoMercadoriaServico: Boolean; // REQUISITO XX
    function GerarArquivoOperacao(ADataInicial, ADataFinal: TDateTime): Boolean; // REQUISITO XXV
    function GerarArquivoTransportePassageiros: Boolean; // REQUISITO XLII
    function GerarArquivoMeioPagamento: Boolean; // REQUISITO

    function GerarRegistroEAD(ANomeArquivo: String): Boolean;
  published
    property NomePAFECF: String read FNomePAFECF write FNomePAFECF;
    property VersaoPAFECF: String read FVersaoPAFECF write FVersaoPAFECF;
    property CodigoMD5: String read FCodigoMD5 write FCodigoMD5;
    property VersaoERPAFECF: String read FVersaoERPAFECF write FVersaoERPAFECF;
    property CaminhoArquivos: String read FCaminhoArquivos write FCaminhoArquivos;
    property ChavePublica: String read FChavePublica write FChavePublica;
    property ChavePrivada: String read FChavePrivada write FChavePrivada;

    property PAFECFDesenvolvedora: TmrPAFECFDesenvolvedora read FPAFECFDesenvolvedora write FPAFECFDesenvolvedora;
    property PAFECFUsuario: TmrPAFECFUsuario read FPAFECFUsuario write FPAFECFUsuario;

    property XMLDAV: TXMLDocument read FXMLDAV write FXMLDAV;
    property XMLEstoque: TXMLDocument read FXMLEstoque write FXMLEstoque;
    property XMLMercadoriaServico: TXMLDocument read FXMLMercadoriaServico write FXMLMercadoriaServico;
    property XMLReducaoZ: TXMLDocument read FXMLReducaoZ write FXMLReducaoZ;
    property XMLTotalizadorParcial: TXMLDocument read FXMLTotalizadorParcial write FXMLTotalizadorParcial;
    property XMLVenda: TXMLDocument read FXMLVenda write FXMLVenda;
    property XMLItemVenda: TXMLDocument read FXMLItemVenda write FXMLItemVenda;
    property XMLDocumentoGeral: TXMLDocument read FXMLDocumentoGeral write FXMLDocumentoGeral;
    property XMLPagamento: TXMLDocument read FXMLPagamento write FXMLPagamento;
    property XMLTransportePassageiros: TXMLDocument read FTransportePassageiros write FTransportePassageiros;
    property XMLMeioPagamento: TXMLDocument read FXMLMeioPagamento write FXMLMeioPagamento;
  end;

procedure Register;

implementation

uses Variants;



procedure Register;
begin
  RegisterComponents('MainRetail', [TmrPafEcf]);
end;

{ TmrPafEcf }

function TmrPafEcf.AlinharNumero(ANumero: String; ATamanho: Integer): String;
begin
  Result := '00000000000000000000000000000000000000000000000000000' +
            '00000000000000000000000000000000000000000000000000000' +
            '00000000000000000000000000000000000000000000000000000' +
            '00000000000000000000000000000000000000000000000000000' + ANumero;

  Result := RightStr(Result, ATamanho);
end;

function TmrPafEcf.AlinharTexto(ATexto: String; ATamanho: Integer): String;
begin
  Result := ATexto + '                                                     ' +
                     '                                                     ' +
                     '                                                     ' +
                     '                                                     ';

  Result := LeftStr(Result, ATamanho);
end;

constructor TmrPafEcf.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPAFECFDesenvolvedora := TmrPAFECFDesenvolvedora.Create;
  FPAFECFUsuario := TmrPAFECFUsuario.Create;

  FXMLDAV                := TXMLDocument.Create(Self);
  FXMLEstoque            := TXMLDocument.Create(Self);
  FXMLMercadoriaServico  := TXMLDocument.Create(Self);
  FXMLReducaoZ           := TXMLDocument.Create(Self);
  FXMLTotalizadorParcial := TXMLDocument.Create(Self);
  FXMLVenda              := TXMLDocument.Create(Self);
  FXMLItemVenda          := TXMLDocument.Create(Self);
  FXMLDocumentoGeral     := TXMLDocument.Create(Self);
  FXMLPagamento          := TXMLDocument.Create(Self);
  FTransportePassageiros := TXMLDocument.Create(Self);
  FXMLMeioPagamento      := TXMLDocument.Create(Self);

  if FVersaoERPAFECF = '' then
    FVersaoERPAFECF := '01.00';

  if FCaminhoArquivos = '' then
    FCaminhoArquivos := 'C:\Program Files\MainRetail\PDV\';

  if FChavePublica = '' then
    FChavePublica := 'B146872648A6F5222DC919A85DE1131565875FB7FFEDB72652' +
                     '999161D0D4B585274A01B4B160EE2C39B7691563F39BA39BEF' +
                     'C966341F818B1154D71911295751B6C5478B023B439EC5EE82' +
                     '060432E7122FF2D9490D2ED5430820FAE2EDCC02D9AEAE1875' +
                     'B342A707C42980F6C0769EC42F29BD8B13769FCBA2418983A8' +
                     'FBCA6B';

  if FChavePrivada = '' then
    FChavePrivada := 'E9CE8FB7CF8A3D3CD0DF92A55643C1B5368F9D3A24DEEB790B' +
                     'ACEC273C802B7113170D9D0D171364DE67C68A0D5DB78910AA' +
                     '12D1065C0490C0DA3F172C76D807C21A454393B73CB89A4B2E' +
                     'F7A96A417C1D0D4FF909ED3AAB53FBBD9E2169B4F408FA4F33' +
                     '393E6DA2DE76B6A6D1313E99E5BDB135C14DCE6093ED21CCF2' +
                     '1F797D';
end;

destructor TmrPafEcf.Destroy;
begin
  FPAFECFDesenvolvedora.Free;
  FPAFECFUsuario.Free;

  FXMLDAV.Free;
  FXMLEstoque.Free;
  FXMLMercadoriaServico.Free;
  FXMLReducaoZ.Free;
  FXMLTotalizadorParcial.Free;
  FXMLVenda.Free;
  FXMLItemVenda.Free;
  FXMLDocumentoGeral.Free;
  FXMLPagamento.Free;
  FTransportePassageiros.Free;
  FXMLMeioPagamento.Free;

  inherited Destroy;
end;

function TmrPafEcf.FormatarBoolean(AValor: String): String;
begin
  Result := '';

  if AValor = 'TRUE' then
    Result := '1'
  else if AValor = 'FALSE' then
    Result := '0';
end;

function TmrPafEcf.FormatarData(AData: TDateTime): String;
var
  FormatSettings: TFormatSettings;
begin
  Result := DateTimeToStr(AData, FormatSettings);
end;

function TmrPafEcf.FormatarDataXML(AData: String): String;
begin
  Result := Copy(AData, 1, 8);
end;

function TmrPafEcf.FormatarHora(AData: String): String;
begin
  Result := Copy(AData, 10, 8);
  Result := StringReplace(Result, ':', '', [rfReplaceAll]);
end;

function TmrPafEcf.FormatarValor(AValor: String): String;
begin
  Result := Copy(AValor, 1, Length(AValor)-2);
  Result := StringReplace(Result, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, ',', '', [rfReplaceAll]);
end;

function TmrPafEcf.GerarArquivoDAV: Boolean;
begin
  try
    try
      AssignFile(FArquivo, FCaminhoArquivos + ARQUIVO_DAV_TXT);
      Rewrite(FArquivo);

      GerarRegistroD1;
      GerarRegistroD2;
      GerarRegistroD9;
    finally
      CloseFile(FArquivo);
    end;

    GerarRegistroEAD(FCaminhoArquivos + ARQUIVO_DAV_TXT);
    Result := True;
  except
    on E: Exception do
      raise Exception.CreateFmt('Não foi possível gerar o arquivo de DAV (Erro: %d).', [GetLastError]);
  end;
end;

function TmrPafEcf.GerarArquivoEstoque: Boolean;
begin
  try
    FXMLEstoque.LoadFromFile(FCaminhoArquivos + ARQUIVO_ESTOQUE_XML);

    try
      AssignFile(FArquivo, FCaminhoArquivos + ARQUIVO_ESTOQUE_TXT);
      Rewrite(FArquivo);

      GerarRegistroE1;
      GerarRegistroE2;
      GerarRegistroE9;
    finally
      CloseFile(FArquivo);
    end;

    GerarRegistroEAD(FCaminhoArquivos + ARQUIVO_ESTOQUE_TXT);
    Result := True;
  except
    on E: Exception do
      raise Exception.CreateFmt('Não foi possível gerar o arquivo de Estoque (Erro: %d).', [GetLastError]);
  end;
end;

function TmrPafEcf.GerarArquivoMercadoriaServico: Boolean;
begin
  try
    FXMLMercadoriaServico.LoadFromFile(FCaminhoArquivos + ARQUIVO_MERCADORIA_SERVICO_XML);

    try
      AssignFile(FArquivo, FCaminhoArquivos + ARQUIVO_MERCADORIA_SERVICO_TXT);
      Rewrite(FArquivo);

      GerarRegistroP1;
      GerarRegistroP2;
      GerarRegistroP9;
    finally
      CloseFile(FArquivo);
    end;

    GerarRegistroEAD(FCaminhoArquivos + ARQUIVO_MERCADORIA_SERVICO_TXT);
    Result := True;
  except
    on E: Exception do
      raise Exception.CreateFmt('Não foi possível gerar o arquivo de Mercadoria e Serviço (Erro: %d).', [GetLastError]);
  end;
end;

function TmrPafEcf.GerarArquivoOperacao(ADataInicial, ADataFinal: TDateTime): Boolean;
begin
  {
  o arquivo gerado deverá ser denominado no formato CCCCCCNNNNNNNNNNNNNNDDMMAAAA.txt, sendo:
  a) "CCCCCC" o Código Nacional de Identificação de ECF relativo ao ECF a que se refere o movimento informado;
  b) "NNNNNNNNNNNNNN" os 14 (quatorze) últimos dígitos do número de fabricação do ECF;
  c) "DDMMAAAA" a data (dia/mês/ano) do movimento informado no caso de arquivo gerado automaticamente após a emissão da Redução Z, ou a data (dia/mês/ano) da geração do arquivo no caso de execução por meio do comando previsto no item 9 do requisito VII.
  }

  try
    FXMLReducaoZ.LoadFromFile(FCaminhoArquivos + ARQUIVO_REDUCAOZ_XML);
    FXMLTotalizadorParcial.LoadFromFile(FCaminhoArquivos + ARQUIVO_TOTALIZADOR_PARCIAL_XML);
    FXMLVenda.LoadFromFile(FCaminhoArquivos + ARQUIVO_VENDA_XML);
    FXMLItemVenda.LoadFromFile(FCaminhoArquivos + ARQUIVO_ITEM_VENDA_XML);
    FXMLDocumentoGeral.LoadFromFile(FCaminhoArquivos + ARQUIVO_DOCUMENTO_GERAL_XML);
    FXMLPagamento.LoadFromFile(FCaminhoArquivos + ARQUIVO_PAGAMENTO_XML);

    try
      AssignFile(FArquivo, FCaminhoArquivos + ARQUIVO_OPERACAO_TXT);
      Rewrite(FArquivo);

      GerarRegistroR01(ADataInicial, ADataFinal);
      GerarRegistroR02;
      GerarRegistroR03;
      GerarRegistroR04;
      GerarRegistroR05;
      GerarRegistroR06;
      GerarRegistroR07;
    finally
      CloseFile(FArquivo);
    end;

    GerarRegistroEAD(FCaminhoArquivos + ARQUIVO_OPERACAO_TXT);
    Result := True;
  except
    on E: Exception do
      raise Exception.CreateFmt('Não foi possível gerar o arquivo de Operação (Erro: %d).', [GetLastError]);
  end;
end;

function TmrPafEcf.GerarArquivoMeioPagamento: Boolean;
begin
  try
    FXMLMeioPagamento.LoadFromFile(FCaminhoArquivos + ARQUIVO_MEIO_PAGAMENTO_XML);

    try
      AssignFile(FArquivo, FCaminhoArquivos + ARQUIVO_MEIO_PAGAMENTO_TXT);
      Rewrite(FArquivo);

      GerarRegistroMeioPagamento;
    finally
      CloseFile(FArquivo);
    end;

    GerarRegistroEAD(FCaminhoArquivos + ARQUIVO_MEIO_PAGAMENTO_TXT);
    Result := True;
  except
    on E: Exception do
      raise Exception.CreateFmt('Não foi possível gerar o arquivo de Pagamento (Erro: %d).', [GetLastError]);
  end;
end;

function TmrPafEcf.GerarArquivoTransportePassageiros: Boolean;
begin
  try
    try
      AssignFile(FArquivo, FCaminhoArquivos + ARQUIVO_TRANSPORTE_PASSAGEIROS_TXT);
      Rewrite(FArquivo);

      GerarRegistroT1;
      GerarRegistroT2;
      GerarRegistroT9;
    finally
      CloseFile(FArquivo);
    end;

    GerarRegistroEAD(FCaminhoArquivos + ARQUIVO_TRANSPORTE_PASSAGEIROS_TXT);

    Result := True;
  except
    on E: Exception do
      raise Exception.CreateFmt('Não foi possível gerar o arquivo de Transporte e Passageiros (Erro: %d).', [GetLastError]);
  end;
end;

procedure TmrPafEcf.GerarRegistroD1;
begin

end;

procedure TmrPafEcf.GerarRegistroD2;
begin

end;

procedure TmrPafEcf.GerarRegistroD9;
begin

end;

procedure TmrPafEcf.GerarRegistroE1;
var
  sLinha: String;
begin
  sLinha := 'E1';
  sLinha := sLinha + AlinharNumero(FPAFECFUsuario.FCNPJ, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FInscricaoEstadual, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FInscricaoMunicipal, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FRazaoSocial, 50);

  WriteLn(FArquivo, sLinha);
end;

procedure TmrPafEcf.GerarRegistroE2;
var
  i: Integer;
  sLinha: String;
begin
  FXMLEstoque.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLEstoque.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := 'E2';
    sLinha := sLinha + AlinharNumero(FPAFECFUsuario.FCNPJ, 14);
    sLinha := sLinha + AlinharTexto(FXMLEstoque.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Model'], 14);
    sLinha := sLinha + AlinharTexto(FXMLEstoque.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Description'], 50);
    sLinha := sLinha + AlinharTexto(FXMLEstoque.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Unidade'], 6);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLEstoque.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Quantidade']), 9);
    sLinha := sLinha + AlinharNumero(FormatarDataXML(FXMLEstoque.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DataEstoque']), 8);

    WriteLn(FArquivo, sLinha);
  end;
end;

procedure TmrPafEcf.GerarRegistroE9;
var
  sLinha: String;
begin
  sLinha := 'E9';
  sLinha := sLinha + AlinharNumero(FPAFECFUsuario.FCNPJ, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FInscricaoEstadual, 14);
  sLinha := sLinha + AlinharNumero(IntToStr(FXMLEstoque.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count), 6);

  WriteLn(FArquivo, sLinha);
end;

function TmrPafEcf.GerarRegistroEAD(ANomeArquivo: String): Boolean;
var
  iRetorno: Integer;
  sLinha: String;
begin
  SetLength(sLinha, 256);
  iRetorno := GenerateEAD(ANomeArquivo, FChavePublica, FChavePrivada, sLinha, 1);

  if iRetorno = 0 then
    raise Exception.Create('Não foi possível gerar o EAD.');

  Result := True;
end;

procedure TmrPafEcf.GerarRegistroP1;
var
  sLinha: String;
begin
  sLinha := 'P1';
  sLinha := sLinha + AlinharNumero(FPAFECFUsuario.FCNPJ, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FInscricaoEstadual, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FInscricaoMunicipal, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FRazaoSocial, 50);

  WriteLn(FArquivo, sLinha);
end;

procedure TmrPafEcf.GerarRegistroP2;
var
  i: Integer;
  sLinha: String;
begin
  FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := 'P2';
    sLinha := sLinha + AlinharNumero(FPAFECFUsuario.FCNPJ, 14);
    sLinha := sLinha + AlinharTexto(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Model'], 14);
    sLinha := sLinha + AlinharTexto(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Description'], 50);
    sLinha := sLinha + AlinharTexto(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Unidade'], 6);
    sLinha := sLinha + AlinharTexto(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IAT'], 1);
    sLinha := sLinha + AlinharTexto(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IPPT'], 1);
    sLinha := sLinha + AlinharTexto(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['SituacaoTributaria'], 1);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Aliquota']), 4);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorUnitario']), 12);

    WriteLn(FArquivo, sLinha);
  end;
end;

procedure TmrPafEcf.GerarRegistroP9;
var
  sLinha: String;
begin
  sLinha := 'P9';
  sLinha := sLinha + AlinharNumero(FPAFECFUsuario.FCNPJ, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FInscricaoEstadual, 14);
  sLinha := sLinha + AlinharNumero(IntToStr(FXMLMercadoriaServico.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count), 6);

  WriteLn(FArquivo, sLinha);
end;

procedure TmrPafEcf.GerarRegistroR01(ADataInicial, ADataFinal: TDateTime);
var
  sLinha: String;
begin
  FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  sLinha := 'R01';
  sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['NumeroFabricacao'], 20);
  sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['MFAdicional'], 1);
  sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['TipoECF'], 7);
  sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['MarcaECF'], 20);
  sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['ModeloECF'], 20);
  sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['VersaoSBECF'], 10);
  sLinha := sLinha + AlinharNumero(FormatarDataXML(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['DataInstalacaoSBECF']), 8);
  sLinha := sLinha + AlinharNumero(FormatarHora(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['DataInstalacaoSBECF']), 6);
  sLinha := sLinha + AlinharNumero(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['NumeroECF'], 3);
  sLinha := sLinha + AlinharNumero(FPAFECFUsuario.FCNPJ, 14);
  sLinha := sLinha + AlinharTexto(FPAFECFUsuario.FInscricaoEstadual, 14);
  sLinha := sLinha + AlinharNumero(FPAFECFDesenvolvedora.FCNPJ, 14);
  sLinha := sLinha + AlinharNumero(FPAFECFDesenvolvedora.FInscricaoEstadual, 14);
  sLinha := sLinha + AlinharNumero(FPAFECFDesenvolvedora.FInscricaoMunicipal, 14);
  sLinha := sLinha + AlinharNumero(FPAFECFDesenvolvedora.FRazaoSocial, 40);
  sLinha := sLinha + AlinharTexto(FNomePAFECF, 40);
  sLinha := sLinha + AlinharTexto(FVersaoPAFECF, 10);
  sLinha := sLinha + AlinharTexto(FCodigoMD5, 32);
  sLinha := sLinha + AlinharNumero(FormatarData(ADataInicial), 8);
  sLinha := sLinha + AlinharNumero(FormatarData(ADataFinal), 8);
  sLinha := sLinha + AlinharTexto(FVersaoERPAFECF, 4);

  WriteLn(FArquivo, sLinha);
end;

procedure TmrPafEcf.GerarRegistroR02;
var
  i: Integer;
  sLinha: String;
begin
  FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := 'R02';
    sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroFabricacao'], 20);
    sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MFAdicional'], 1);
    sLinha := sLinha + AlinharTexto(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ModeloECF'], 20);
    sLinha := sLinha + AlinharNumero(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroUsuarioECF'], 2);
    sLinha := sLinha + AlinharNumero(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ContadorReducaoZ'], 6);
    sLinha := sLinha + AlinharNumero(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ContadorOrdemOperacao'], 6);
    sLinha := sLinha + AlinharNumero(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ContadorReinicioOperacao'], 8);
    sLinha := sLinha + AlinharNumero(FormatarDataXML(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MovDate']), 8);
    sLinha := sLinha + AlinharNumero(FormatarDataXML(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DataEmissao']), 8);
    sLinha := sLinha + AlinharNumero(FormatarHora(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DataEmissao']), 6);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['VendaBruta']), 14);
    sLinha := sLinha + AlinharTexto(FormatarBoolean(FXMLReducaoZ.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IncideISSQN']), 1);

    WriteLn(FArquivo, sLinha);
  end;
end;

procedure TmrPafEcf.GerarRegistroR03;
var
  i: Integer;
  sLinha: String;
begin
  FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := 'R03';
    sLinha := sLinha + AlinharTexto(FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroFabricacao'], 20);
    sLinha := sLinha + AlinharTexto(FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MFAdicional'], 1);
    sLinha := sLinha + AlinharTexto(FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ModeloECF'], 20);
    sLinha := sLinha + AlinharNumero(FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroUsuarioECF'], 2);
    sLinha := sLinha + AlinharNumero(FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ContadorReducaoZ'], 6);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Codigo']), 7);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLTotalizadorParcial.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorAcumulado']), 13);

    WriteLn(FArquivo, sLinha);
  end;
end;

procedure TmrPafEcf.GerarRegistroR04;
var
  i: Integer;
  sLinha: String;
begin
  FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := 'R04';
    sLinha := sLinha + AlinharTexto(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroFabricacao'], 20);
    sLinha := sLinha + AlinharTexto(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MFAdicional'], 1);
    sLinha := sLinha + AlinharTexto(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ModeloECF'], 20);
    sLinha := sLinha + AlinharNumero(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroUsuarioECF'], 2);
    sLinha := sLinha + AlinharNumero(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ContadorDocumento'], 6);
    sLinha := sLinha + AlinharNumero(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ContadorOrdemOperacao'], 6);
    sLinha := sLinha + AlinharNumero(FormatarDataXML(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DataInicioEmissao']), 8);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorSubTotal']), 14);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorDesconto']), 13);
    sLinha := sLinha + AlinharTexto(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IndicadorDesconto'], 1);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorAcrescimo']), 13);
    sLinha := sLinha + AlinharTexto(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IndicadorAcrescimo'], 1);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorTotalLiquido']), 14);
    sLinha := sLinha + AlinharTexto(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IndicadorCancelamento'], 1);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CancelamentoAcrescimo']), 13);
    sLinha := sLinha + AlinharTexto(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['OrdemAplicacaoDA'], 1);
    sLinha := sLinha + AlinharTexto(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NomeCliente'], 40);
    sLinha := sLinha + AlinharTexto(RemoverMascara(FXMLVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DocumentoCliente']), 14);

    WriteLn(FArquivo, sLinha);
  end;
end;

procedure TmrPafEcf.GerarRegistroR05;
var
  i: Integer;
  sLinha: String;
begin
  FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := 'R05';

    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroFabricacao'], 20);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MFAdicional'], 1);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ModeloECF'], 20);
    sLinha := sLinha + AlinharNumero(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroUsuarioECF'], 2);
    sLinha := sLinha + AlinharNumero(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ContadorOrdemOperacao'], 6);
    sLinha := sLinha + AlinharNumero(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ContadorDocumento'], 6);
    sLinha := sLinha + AlinharNumero(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroItem'], 3);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoProduto'], 14);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DescricaoProduto'], 100);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Quantidade']), 7);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Unidade'], 6);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorUnitario']), 8);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Desconto']), 8);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Acrescimo']), 8);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorTotalLiquido']), 14);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['TotalizadorParcial'], 7);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IndicadorCancelamento'], 1);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['QuantidadeCancelada']), 7);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorCancelado']), 13);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CancelamentoAcrescimo']), 13);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IAT'], 1);
    sLinha := sLinha + AlinharTexto(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IPPT'], 1);
    sLinha := sLinha + AlinharNumero(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumCasaDecQtd'], 1);
    sLinha := sLinha + AlinharNumero(FXMLItemVenda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumCasaDecVal'], 1);

    WriteLn(FArquivo, sLinha);
  end;
end;

procedure TmrPafEcf.GerarRegistroR06;
var
  i: Integer;
  sLinha: String;
begin
  FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := 'R06';
    sLinha := sLinha + AlinharTexto(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroFabricacao'], 20);
    sLinha := sLinha + AlinharTexto(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MFAdicional'], 1);
    sLinha := sLinha + AlinharTexto(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ModeloECF'], 20);
    sLinha := sLinha + AlinharNumero(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroUsuarioECF'], 2);
    sLinha := sLinha + AlinharNumero(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['COO'], 6);
    sLinha := sLinha + AlinharNumero(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['GNF'], 6);
    sLinha := sLinha + AlinharNumero(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['GRG'], 6);
    sLinha := sLinha + AlinharNumero(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CDC'], 4);
    sLinha := sLinha + AlinharTexto(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Denominacao'], 2);
    sLinha := sLinha + AlinharNumero(FormatarDataXML(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DataEmissao']), 8);
    sLinha := sLinha + AlinharNumero(FormatarHora(FXMLDocumentoGeral.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DataEmissao']), 6);

    WriteLn(FArquivo, sLinha);
  end
end;

procedure TmrPafEcf.GerarRegistroR07;
var
  i: Integer;
  sLinha: String;
begin
  FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := 'R07';
    sLinha := sLinha + AlinharTexto(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroFabricacao'], 20);
    sLinha := sLinha + AlinharTexto(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MFAdicional'], 1);
    sLinha := sLinha + AlinharTexto(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ModeloECF'], 20);
    sLinha := sLinha + AlinharNumero(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['NumeroUsuarioECF'], 2);
    sLinha := sLinha + AlinharNumero(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['COO'], 6);
    sLinha := sLinha + AlinharNumero(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CCF'], 6);
    sLinha := sLinha + AlinharNumero(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['GNF'], 6);
    sLinha := sLinha + AlinharTexto(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MeioPagamento'], 15);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorPago']), 13);
    sLinha := sLinha + AlinharTexto(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IndicadorEstorno'], 1);
    sLinha := sLinha + AlinharNumero(FormatarValor(FXMLPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorEstorno']), 13);

    WriteLn(FArquivo, sLinha);
  end;
end;

procedure TmrPafEcf.GerarRegistroT1;
begin

end;

procedure TmrPafEcf.GerarRegistroT2;
begin

end;

procedure TmrPafEcf.GerarRegistroT9;
begin

end;

function TmrPafEcf.Init: Boolean;
begin
  try
    NomeAssinaturaDll := 'sign_bema.dll';
    HandleAssinaturaDLL := LoadLibrary(PChar(NomeAssinaturaDll));
    if HandleAssinaturaDLL = 0 then
      raise Exception.CreateFmt('Não foi possível carregar %s (Erro: %d)', [NomeAssinaturaDll, GetLastError]);

    @GenerateEAD := GetProcAddress(HandleAssinaturaDLL, 'generateEAD');
    Result := true;
  except
    on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TmrPafEcf.RemoverMascara(ATexto: String): String;
begin
  Result := StringReplace(ATexto, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, ',', '', [rfReplaceAll]);
  Result := StringReplace(Result, ':', '', [rfReplaceAll]);
  Result := StringReplace(Result, ';', '', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '\', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
end;

procedure TmrPafEcf.GerarRegistroMeioPagamento;
var
  i: Integer;
  sLinha: String;
begin
  WriteLn(FArquivo, 'MEIOS DE PAGAMENTO');

  FXMLMeioPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLMeioPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := AlinharTexto(FXMLMeioPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['MeioPag'], 20);
    sLinha := sLinha + ': ' + AlinharNumero(FormatarValor(FXMLMeioPagamento.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorPagamento']), 13);

    WriteLn(FArquivo, sLinha);
  end;
end;

end.
