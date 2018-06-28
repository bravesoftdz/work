unit uEplataformaSyncClasses;

interface

uses SysUtils, Classes, SOAPHTTPTrans, uXMLClasses, uEplataformaEntidadeClasses;

const
  COMPL_URL = 'site/';

type
  TepParentSync = class
  private
    FHTTPReqResp: THTTPReqResp;
    FUserName: String;
    FURLSite: String;
    FUserPassword: String;
    FXMLContent: TXMLContent;

    function GetWebServiceURL: String; virtual; abstract;

    function GetSoapActionURL: String; virtual; abstract;
    function GetSoapActionCriar: String; virtual; abstract;
    function GetSoapActionAlterar: String; virtual; abstract;
    function GetSoapActionVerificar: String; virtual; abstract;
    function GetSoapActionObter: String; virtual; abstract;
    function GetSoapActionListar: String; virtual; abstract;

    function GetXMLCriarRequest(epEntidade: TepEntidade): WideString; virtual; abstract;
    function GetXMLAlterarRequest(epEntidade: TepEntidade): WideString; virtual; abstract;
    function GetXMLVerificarRequest(epEntidade: TepEntidade): WideString; virtual; abstract;
    function GetXMLObterRequest(epEntidade: TepEntidade): WideString; virtual; abstract;
    function GetXMLListarRequest: WideString; overload; virtual; abstract;
    function GetXMLListarRequest(ADataApartir: TDateTime): WideString; overload; virtual; abstract;

    function CarregarEntidade: TepEntidade; virtual; abstract;
    function CarregarEntidadeLista: TepEntidadeLista; virtual; abstract;

    function HasExecutionError: Boolean;
    function GetExecutionErrorMessage: String;

    function FormatarDataXML(AData: TDateTime): String;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Init(AHTTPReqResp: THTTPReqResp; AURLSite, AUserName, AUserPassword: String);
    function Criar(AepEntidade: TepEntidade): Boolean;
    function Alterar(AepEntidade: TepEntidade): Boolean;
    function Verificar(AepEntidade: TepEntidade): Boolean;
    function Obter(AepEntidade: TepEntidade): TepEntidade;
    function Listar: TepEntidadeLista; overload;
    function Listar(ADataApartir: TDateTime): TepEntidadeLista; overload;

    property XMLContent: TXMLContent read FXMLContent write FXMLContent;
  end;

  TepCatalogoSync = class(TepParentSync)
  private
    function GetSoapActionURL: String; override;
    function GetWebServiceURL: String; override;
  end;

  TepProfileSync = class(TepParentSync)
  private
    function GetSoapActionURL: String; override;
    function GetWebServiceURL: String; override;
  end;

  TepMarcaSync = class(TepCatalogoSync)
  private
    function GetSoapActionCriar: String; override;
    function GetSoapActionAlterar: String; override;
    function GetSoapActionVerificar: String; override;
    function GetSoapActionObter: String; override;
    function GetXMLCriarRequest(AepEntidade: TepEntidade): WideString; override;
    function GetXMLAlterarRequest(epEntidade: TepEntidade): WideString; override;
    function GetXMLVerificarRequest(epEntidade: TepEntidade): WideString; override;
    function GetXMLObterRequest(epEntidade: TepEntidade): WideString; override;

    function CarregarEntidade: TepEntidade; override;
  public
    function Listar: TepMarcaLista;
  end;

  TepCategoriaSync = class(TepCatalogoSync)
  private
    function GetSoapActionCriar: String; override;
    function GetSoapActionAlterar: String; override;
    function GetSoapActionVerificar: String; override;
    function GetSoapActionObter: String; override;
    function GetSoapActionListar: String; override;
    function GetXMLCriarRequest(AepEntidade: TepEntidade): WideString; override;
    function GetXMLAlterarRequest(epEntidade: TepEntidade): WideString; override;
    function GetXMLVerificarRequest(epEntidade: TepEntidade): WideString; override;
    function GetXMLObterRequest(epEntidade: TepEntidade): WideString; override;
    function GetXMLListarRequest: WideString; override;

    function CarregarEntidade: TepEntidade; override;
    function CarregarEntidadeLista: TepEntidadeLista; override;
  public
    //function Listar: TepCategoriaLista;
  end;

  TepProdutoSync = class(TepCatalogoSync)
  private
    function GetSoapActionCriar: String; override;
    function GetSoapActionAlterar: String; override;
    function GetSoapActionVerificar: String; override;
    function GetSoapActionObter: String; override;
    function GetXMLCriarRequest(AepEntidade: TepEntidade): WideString; override;
    function GetXMLAlterarRequest(AepEntidade: TepEntidade): WideString; override;
    function GetXMLVerificarRequest(epEntidade: TepEntidade): WideString; override;
    function GetXMLObterRequest(epEntidade: TepEntidade): WideString; override;

    function CarregarEntidade: TepEntidade; override;
  end;

  TepSKUSync = class(TepCatalogoSync)
  private
    function GetSoapActionCriar: String; override;
    function GetSoapActionAlterar: String; override;
    function GetSoapActionVerificar: String; override;
    function GetSoapActionObter: String; override;
    function GetXMLCriarRequest(AepEntidade: TepEntidade): WideString; override;
    function GetXMLAlterarRequest(AepEntidade: TepEntidade): WideString; override;
    function GetXMLVerificarRequest(epEntidade: TepEntidade): WideString; override;
    function GetXMLObterRequest(epEntidade: TepEntidade): WideString; override;

    function CarregarEntidade: TepEntidade; override;
  end;

  TepEstoqueSync = class(TepCatalogoSync)
  private
    function GetSoapActionAtualizar: String;
    function GetSoapActionListar: String; override;
    function GetXMLAtualizarRequest(AepSaldoSKU: TepSaldoSKU): WideString;
    function GetXMLListarRequest: WideString; override;
    function CarregarEntidadeLista: TepEntidadeLista; override;
  public
    function Atualizar(AepSaldoSKU: TepSaldoSKU): Boolean;
  end;

  TepClienteSync = class(TepProfileSync)
  private
    function GetSoapActionListar: String; override;
    function GetXMLListarRequest(ADataApartir: TDateTime): WideString; override;
    function CarregarEntidadeLista: TepEntidadeLista; override;
  end;

  TepCompraSync = class(TepProfileSync)
  private
    FStatusCompra: String;
    function GetSoapActionListar: String; override;
    function GetXMLListarRequest(ADataApartir: TDateTime): WideString; override;
    function CarregarEntidadeLista: TepEntidadeLista; override;
  public
    property StatusCompra: String read FStatusCompra write FStatusCompra;
  end;

implementation

{ TepParentSync }

function TepParentSync.Alterar(AepEntidade: TepEntidade): Boolean;
var
  ContentStream: TStream;
  ContentStringStream: TStringStream;
begin
  Result := False;

  ContentStream := TMemoryStream.Create;
  ContentStringStream := TStringStream.Create('');
  try
    try
      FHTTPReqResp.SoapAction := GetSoapActionURL + GetSoapActionAlterar;
      FHTTPReqResp.Execute(UTF8Encode(GetXMLAlterarRequest(AepEntidade)), ContentStream);

      ContentStringStream.CopyFrom(ContentStream, 0);
      FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);
      if HasExecutionError then
        raise Exception.Create(GetExecutionErrorMessage);
    except
      on E: Exception do
        raise Exception.Create(self.ClassName + '.Alterar. - ' + E.Message);
    end;
  finally
    ContentStream.Free;
    ContentStringStream.Free;
  end;
end;

constructor TepParentSync.Create;
begin
  try
    FXMLContent := TXMLContent.Create;
  except
    raise Exception.Create(self.ClassName + '.Create');
  end;
end;

function TepParentSync.Criar(AepEntidade: TepEntidade): Boolean;
var
  ContentStream: TStream;
  ContentStringStream: TStringStream;
begin
  Result := False;

  ContentStream := TMemoryStream.Create;
  ContentStringStream := TStringStream.Create('');
  try
    try
      FHTTPReqResp.SoapAction := GetSoapActionURL + GetSoapActionCriar;
      FHTTPReqResp.Execute(UTF8Encode(GetXMLCriarRequest(AepEntidade)), ContentStream);

      ContentStringStream.CopyFrom(ContentStream, 0);
      FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);
      if HasExecutionError then
        raise Exception.Create(GetExecutionErrorMessage);
    except
      on E: Exception do
        raise Exception.Create(self.ClassName + '.Criar. - ' + E.Message);
    end;
  finally
    ContentStream.Free;
    ContentStringStream.Free;
  end;
end;

destructor TepParentSync.Destroy;
begin
  try
    FXMLContent.Free;
    inherited Destroy;
  except
    raise Exception.Create(self.ClassName + '.Destroy');
  end;
end;

function TepParentSync.FormatarDataXML(AData: TDateTime): String;
var
  sYear, sMonth, sDay: String;
  Year, Month, Day: Word;
begin
  DecodeDate(AData, Year, Month, Day);

  sYear := IntToStr(Year);
  if Length(sYear) = 2 then
    sYear := '20' + sYear;

  sMonth := IntToStr(Month);
  if Length(sMonth) = 1 then
    sMonth := '0' + sMonth;

  sDay := IntToStr(Day);
  if Length(sDay) = 1 then
    sDay := '0' + sDay;

  Result := sYear + '-' + sMonth + '-' + sDay + 'T00:00:00';
end;

function TepParentSync.GetExecutionErrorMessage: String;
begin
  Result := FXMLContent.GetTagString('Message');
end;

function TepParentSync.HasExecutionError: Boolean;
begin
  Result := FXMLContent.GetTagString('faultcode') <> ''
end;

procedure TepParentSync.Init(AHTTPReqResp: THTTPReqResp; AURLSite,
  AUserName, AUserPassword: String);
begin
  try
    FHTTPReqResp  := AHTTPReqResp;
    FURLSite      := AURLSite;
    FUserName     := AUserName;
    FUserPassword := AUserPassword;

    FHTTPReqResp.URL             := GetWebServiceURL;
    FHTTPReqResp.UserName        := AUserName;
    FHTTPReqResp.Password        := AUserPassword;
    FHTTPReqResp.UseUTF8InHeader := True;
  except
    raise Exception.Create(self.ClassName + '.Init');
  end;
end;

function TepParentSync.Listar(ADataApartir: TDateTime): TepEntidadeLista;
var
  ContentStream: TStream;
  ContentStringStream: TStringStream;
begin
  ContentStream := TMemoryStream.Create;
  ContentStringStream := TStringStream.Create('');
  try
    try
      FHTTPReqResp.SoapAction := GetSoapActionURL + GetSoapActionListar;
      FHTTPReqResp.Execute(UTF8Encode(GetXMLListarRequest(ADataApartir)), ContentStream);

      ContentStringStream.CopyFrom(ContentStream, 0);
      FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);
      Result := CarregarEntidadeLista;
      if HasExecutionError then
        raise Exception.Create(GetExecutionErrorMessage);
    except
      on E: Exception do
        raise Exception.Create(self.ClassName + '.Listar por data. - ' + E.Message);
    end;
  finally
    ContentStream.Free;
    ContentStringStream.Free;
  end;
end;

function TepParentSync.Listar: TepEntidadeLista;
var
  ContentStream: TStream;
  ContentStringStream: TStringStream;
begin
  ContentStream := TMemoryStream.Create;
  ContentStringStream := TStringStream.Create('');
  try
    try
      FHTTPReqResp.SoapAction := GetSoapActionURL + GetSoapActionListar;
      FHTTPReqResp.Execute(UTF8Encode(GetXMLListarRequest), ContentStream);

      ContentStringStream.CopyFrom(ContentStream, 0);
      FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);
      Result := CarregarEntidadeLista;
      if HasExecutionError then
        raise Exception.Create(GetExecutionErrorMessage);
    except
      on E: Exception do
        raise Exception.Create(self.ClassName + '.Listar. - ' + E.Message);
    end;
  finally
    ContentStream.Free;
    ContentStringStream.Free;
  end;
end;

function TepParentSync.Obter(AepEntidade: TepEntidade): TepEntidade;
var
  ContentStream: TStream;
  ContentStringStream: TStringStream;
begin
  ContentStream := TMemoryStream.Create;
  ContentStringStream := TStringStream.Create('');
  try
    try
      FHTTPReqResp.SoapAction := GetSoapActionURL + GetSoapActionObter;
      FHTTPReqResp.Execute(UTF8Encode(GetXMLObterRequest(AepEntidade)), ContentStream);

      ContentStringStream.CopyFrom(ContentStream, 0);
      FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);
      Result := CarregarEntidade;
      if HasExecutionError then
        raise Exception.Create(GetExecutionErrorMessage);
    except
      on E: Exception do
        raise Exception.Create(self.ClassName + '.Obter. - ' + E.Message);
    end;
  finally
    ContentStream.Free;
    ContentStringStream.Free;
  end;
end;

function TepParentSync.Verificar(AepEntidade: TepEntidade): Boolean;
var
  ContentStream: TStream;
  ContentStringStream: TStringStream;
begin
  ContentStream := TMemoryStream.Create;
  ContentStringStream := TStringStream.Create('');
  try
    try
      FHTTPReqResp.SoapAction := GetSoapActionURL + GetSoapActionVerificar;
      FHTTPReqResp.Execute(UTF8Encode(GetXMLVerificarRequest(AepEntidade)), ContentStream);

      ContentStringStream.CopyFrom(ContentStream, 0);
      FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);

      Result := FXMLContent.GetTagBoolean(GetSoapActionVerificar + 'Result');
      if HasExecutionError then
        raise Exception.Create(GetExecutionErrorMessage);
    except
      on E: Exception do
        raise Exception.Create(self.ClassName + '.Verificar. - ' + E.Message);
    end;
  finally
    ContentStream.Free;
    ContentStringStream.Free;
  end;
end;

{ TepCatalogoSync }

function TepCatalogoSync.GetSoapActionURL: String;
begin
  Result := 'http://www.e-plataforma.com.br/ICatalogoService/';
end;

function TepCatalogoSync.GetWebServiceURL: String;
begin
  Result := FURLSite + 'WebService/Catalogo.svc/CatalogoService';
end;

{ TepProfileSync }

function TepProfileSync.GetSoapActionURL: String;
begin
  Result := 'http://www.e-plataforma.com.br/IProfileService/';
end;

function TepProfileSync.GetWebServiceURL: String;
begin
  Result := FURLSite + 'WebService/Profile.svc/ProfileService';
end;

{ TepCategoriaSync }

function TepCategoriaSync.CarregarEntidade: TepEntidade;
begin
  TepCategoria(Result)                     := TepCategoria.Create;
  TepCategoria(Result).IDCategoria         := FXMLContent.GetAttributeInteger('IdCategoria');
  TepCategoria(Result).IDCategoriaPai      := FXMLContent.GetAttributeInteger('IdCategoriaPai');
  TepCategoria(Result).IDDepartamento      := FXMLContent.GetAttributeInteger('IdDepartamento');
  TepCategoria(Result).FlagAtiva           := FXMLContent.GetAttributeBoolean('FlagAtiva');
  TepCategoria(Result).FlagMenu            := FXMLContent.GetAttributeBoolean('FlagMenu');
  TepCategoria(Result).Nome                := FXMLContent.GetAttributeString('Nome');
  TepCategoria(Result).Texto               := FXMLContent.GetAttributeString('Texto');
  TepCategoria(Result).MargemLucro         := FXMLContent.GetAttributeDouble('MargemLucro');
  TepCategoria(Result).Ordem               := FXMLContent.GetAttributeInteger('Ordem');
  TepCategoria(Result).PalavraChave        := FXMLContent.GetAttributeString('PalavraChave');
  TepCategoria(Result).TituloSite          := FXMLContent.GetAttributeString('TituloSite');
  TepCategoria(Result).ModoExibicaoProduto := FXMLContent.GetAttributeString('ModoExibicaoProduto');
  TepCategoria(Result).FlagExisteProduto   := FXMLContent.GetAttributeBoolean('FlagExisteProduto');
  TepCategoria(Result).FlagFiltroMarca     := FXMLContent.GetAttributeBoolean('FlagFiltroMarca');
  TepCategoria(Result).FlagAtivaMenuLink   := FXMLContent.GetAttributeBoolean('FlagAtivaMenuLink');
end;

function TepCategoriaSync.CarregarEntidadeLista: TepEntidadeLista;
var
  i: Integer;
  epCategoria: TepCategoria;
begin
  Result := TepCategoriaLista.Create;

  for i := 0 to Pred(FXMLContent.GetNodeCount('DCCategoria')) do
  begin
    epCategoria              := TepCategoria.Create;
    epCategoria.IdCategoria  := FXMLContent.GetAttributeIntegerByNodeIndex('DCCategoria', 'IdCategoria', i);
    epCategoria.Nome         := FXMLContent.GetAttributeStringByNodeIndex('DCCategoria', 'Nome', i);

    Result.Add(epCategoria);
  end;

end;

function TepCategoriaSync.GetSoapActionAlterar: String;
begin
  Result := 'AlterarCategoria';
end;

function TepCategoriaSync.GetSoapActionCriar: String;
begin
  Result := 'CriarCategoria';
end;

function TepCategoriaSync.GetSoapActionListar: String;
begin
  Result := 'ListarCategoria';
end;

function TepCategoriaSync.GetSoapActionObter: String;
begin
  Result := 'ObterCategoria';
end;

function TepCategoriaSync.GetSoapActionVerificar: String;
begin
  Result := 'VerificarCategoria';
end;

function TepCategoriaSync.GetXMLAlterarRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br" xmlns:dat="http://datacontract.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:AlterarCategoria>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Categoria>'+
            '            <dat:IdCategoria>'+IntToStr(TepCategoria(epEntidade).IDCategoria)+'</dat:IdCategoria>'+
            '            <!--Optional:-->'+
            '            <dat:IdCategoriaPai>'+IntToStr(TepCategoria(epEntidade).IDCategoriaPai)+'</dat:IdCategoriaPai>'+
            '            <!--Optional:-->'+
            '            <dat:IdDepartamento>'+IntToStr(TepCategoria(epEntidade).IDDepartamento)+'</dat:IdDepartamento>'+
            '            <dat:FlagAtiva>'+LowerCase(BoolToStr(TepCategoria(epEntidade).FlagAtiva, True))+'</dat:FlagAtiva>'+
            '            <dat:FlagMenu>'+LowerCase(BoolToStr(TepCategoria(epEntidade).FlagMenu, True))+'</dat:FlagMenu>'+
            '            <dat:Nome>'+TepCategoria(epEntidade).Nome+'</dat:Nome>'+
            '            <!--Optional:-->'+
            '            <dat:Texto>'+TepCategoria(epEntidade).Texto+'</dat:Texto>'+
            '            <!--Optional:-->'+
            '            <dat:MargemLucro>'+StringReplace(FloatToStr(TepCategoria(epEntidade).MargemLucro), ',', '.', [rfReplaceAll])+'</dat:MargemLucro>'+
            '            <dat:Ordem>'+IntToStr(TepCategoria(epEntidade).Ordem)+'</dat:Ordem>'+
            '            <!--Optional:-->'+
            '            <dat:PalavraChave>'+TepCategoria(epEntidade).PalavraChave+'</dat:PalavraChave>'+
            '            <!--Optional:-->'+
            '            <dat:TituloSite>'+TepCategoria(epEntidade).TituloSite+'</dat:TituloSite>'+
            '            <dat:ModoExibicaoProduto>'+TepCategoria(epEntidade).ModoExibicaoProduto+'</dat:ModoExibicaoProduto>'+
            '            <!--Optional:-->'+
            '            <dat:FlagExisteProduto>'+LowerCase(BoolToStr(TepCategoria(epEntidade).FlagExisteProduto, True))+'</dat:FlagExisteProduto>'+
            '            <dat:FlagFiltroMarca>'+LowerCase(BoolToStr(TepCategoria(epEntidade).FlagFiltroMarca, True))+'</dat:FlagFiltroMarca>'+
            '            <dat:FlagAtivaMenuLink>'+LowerCase(BoolToStr(TepCategoria(epEntidade).FlagAtivaMenuLink, True))+'</dat:FlagAtivaMenuLink>'+
            '         </e:Categoria>'+
            '      </e:AlterarCategoria>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepCategoriaSync.GetXMLCriarRequest(AepEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br" xmlns:dat="http://datacontract.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:CriarCategoria>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Categoria>'+
            '            <dat:IdCategoria>'+IntToStr(TepCategoria(AepEntidade).IDCategoria)+'</dat:IdCategoria>'+
//            '            <!--Optional:-->'+
//            '            <dat:IdCategoriaPai>'+IntToStr(TepCategoria(AepEntidade).IDCategoriaPai)+'</dat:IdCategoriaPai>'+
            '            <!--Optional:-->'+
            '            <dat:IdDepartamento>'+IntToStr(TepCategoria(AepEntidade).IDDepartamento)+'</dat:IdDepartamento>'+
            '            <dat:FlagAtiva>'+LowerCase(BoolToStr(TepCategoria(AepEntidade).FlagAtiva, True))+'</dat:FlagAtiva>'+
            '            <dat:FlagMenu>'+LowerCase(BoolToStr(TepCategoria(AepEntidade).FlagMenu, True))+'</dat:FlagMenu>'+
            '            <dat:Nome>'+TepCategoria(AepEntidade).Nome+'</dat:Nome>'+
            '            <!--Optional:-->'+
            '            <dat:Texto>'+TepCategoria(AepEntidade).Texto+'</dat:Texto>'+
            '            <!--Optional:-->'+
            '            <dat:MargemLucro>'+StringReplace(FloatToStr(TepCategoria(AepEntidade).MargemLucro), ',', '.', [rfReplaceAll])+'</dat:MargemLucro>'+
            '            <dat:Ordem>'+IntToStr(TepCategoria(AepEntidade).Ordem)+'</dat:Ordem>'+
            '            <!--Optional:-->'+
            '            <dat:PalavraChave>'+TepCategoria(AepEntidade).PalavraChave+'</dat:PalavraChave>'+
            '            <!--Optional:-->'+
            '            <dat:TituloSite>'+TepCategoria(AepEntidade).TituloSite+'</dat:TituloSite>'+
            '            <dat:ModoExibicaoProduto>'+TepCategoria(AepEntidade).ModoExibicaoProduto+'</dat:ModoExibicaoProduto>'+
            '            <!--Optional:-->'+
            '            <dat:FlagExisteProduto>'+LowerCase(BoolToStr(TepCategoria(AepEntidade).FlagExisteProduto, True))+'</dat:FlagExisteProduto>'+
            '            <dat:FlagFiltroMarca>'+LowerCase(BoolToStr(TepCategoria(AepEntidade).FlagFiltroMarca, True))+'</dat:FlagFiltroMarca>'+
            '            <dat:FlagAtivaMenuLink>'+LowerCase(BoolToStr(TepCategoria(AepEntidade).FlagAtivaMenuLink, True))+'</dat:FlagAtivaMenuLink>'+
            '         </e:Categoria>'+
            '      </e:CriarCategoria>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepCategoriaSync.GetXMLListarRequest: WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
             '<soapenv:Header/>'+
             '<soapenv:Body>'+
                '<e:ListarCategoria>'+
                   '<!--Optional:-->'+
                   '<e:Usuario>'+FUserName+'</e:Usuario>'+
                   '<!--Optional:-->'+
                   '<e:Senha>'+FUserPassword+'</e:Senha>'+
                   '<!--Optional:-->'+
                   '<e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
                '</e:ListarCategoria>'+
             '</soapenv:Body>'+
          '</soapenv:Envelope>';
end;

function TepCategoriaSync.GetXMLObterRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">' +
            '  <soapenv:Header/>' +
            '  <soapenv:Body>' +
            '    <e:ObterCategoria>' +
            '      <!--Optional:-->' +
            '      <e:Usuario>' + FUserName + '</e:Usuario>' +
            '      <!--Optional:-->' +
            '      <e:Senha>' + FUserPassword + '</e:Senha>' +
            '      <!--Optional:-->' +
            '      <e:UrlSite>' + FURLSite+COMPL_URL + '</e:UrlSite>' +
            '      <!--Optional:-->' +
            '      <e:Id>' + IntToStr(TepCategoria(epEntidade).IDCategoria) + '</e:Id>' +
            '    </e:ObterCategoria>' +
            '  </soapenv:Body>' +
            '</soapenv:Envelope>';
end;

function TepCategoriaSync.GetXMLVerificarRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:VerificarCategoria>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Id>'+IntToStr(TepCategoria(epEntidade).IDCategoria)+'</e:Id>'+
            '      </e:VerificarCategoria>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

{
function TepCategoriaSync.Listar: TepCategoriaLista;
begin
  Result := TepCategoriaLista.Create;
end;
}

{ TepMarcaSync }

function TepMarcaSync.CarregarEntidade: TepEntidade;
begin
  Result                            := TepMarca.Create;
  TepMarca(Result).IDMarca          := FXMLContent.GetAttributeInteger('IdMarca');
  TepMarca(Result).Nome             := FXMLContent.GetAttributeString('Nome');
  TepMarca(Result).Texto            := FXMLContent.GetAttributeString('Texto');
  TepMarca(Result).PalavraChave     := FXMLContent.GetAttributeString('PalavraChave');
  TepMarca(Result).TituloSite       := FXMLContent.GetAttributeString('Nome');
  TepMarca(Result).FlagAtivaHotSite := FXMLContent.GetAttributeBoolean('FlagAtivaHotSite');
  TepMarca(Result).FlagAtiva        := FXMLContent.GetAttributeBoolean('FlagAtiva');
end;

function TepMarcaSync.GetSoapActionAlterar: String;
begin
  Result := 'AlterarMarca';
end;

function TepMarcaSync.GetSoapActionCriar: String;
begin
  Result := 'CriarMarca';
end;

function TepMarcaSync.GetSoapActionObter: String;
begin
  Result := 'ObterMarca';
end;

function TepMarcaSync.GetSoapActionVerificar: String;
begin
  Result := 'VerificarMarca';
end;

function TepMarcaSync.GetXMLAlterarRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br" xmlns:dat="http://datacontract.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:AlterarMarca>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Marca>'+
            '            <dat:IdMarca>'+IntToStr(TepMarca(epEntidade).IDMarca)+'</dat:IdMarca>'+
            '            <dat:Nome>'+TepMarca(epEntidade).Nome+'</dat:Nome>'+
            '            <!--Optional:-->'+
            '            <dat:Texto>'+TepMarca(epEntidade).Texto+'</dat:Texto>'+
            '            <!--Optional:-->'+
            '            <dat:PalavraChave>'+TepMarca(epEntidade).PalavraChave+'</dat:PalavraChave>'+
            '            <!--Optional:-->'+
            '            <dat:TituloSite>'+TepMarca(epEntidade).TituloSite+'</dat:TituloSite>'+
            '            <dat:FlagAtivaHotSite>'+LowerCase(BoolToStr(TepMarca(epEntidade).FlagAtivaHotSite, True))+'</dat:FlagAtivaHotSite>'+
            '            <dat:FlagAtiva>'+LowerCase(BoolToStr(TepMarca(epEntidade).FlagAtiva, True))+'</dat:FlagAtiva>'+
            '         </e:Marca>'+
            '      </e:AlterarMarca>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepMarcaSync.GetXMLCriarRequest(AepEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br" xmlns:dat="http://datacontract.e-plataforma.com.br">'+
            '  <soapenv:Header/>'+
            '  <soapenv:Body>'+
            '    <e:CriarMarca>'+
            '      <!--Optional:-->'+
            '      <e:Usuario>'+FUserName+'</e:Usuario>'+
            '      <!--Optional:-->'+
            '      <e:Senha>'+FUserPassword+'</e:Senha>'+
            '      <!--Optional:-->'+
            '      <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '      <!--Optional:-->'+
            '      <e:Marca>'+
            '        <dat:IdMarca>'+IntToStr(TepMarca(AepEntidade).IDMarca)+'</dat:IdMarca>'+
            '        <dat:Nome>'+TepMarca(AepEntidade).Nome+'</dat:Nome>'+
            '        <!--Optional:-->'+
            '        <dat:Texto>'+TepMarca(AepEntidade).Texto+'</dat:Texto>'+
            '        <!--Optional:-->'+
            '        <dat:PalavraChave>'+TepMarca(AepEntidade).PalavraChave+'</dat:PalavraChave>'+
            '        <!--Optional:-->'+
            '        <dat:TituloSite>'+TepMarca(AepEntidade).TituloSite+'</dat:TituloSite>'+
            '        <dat:FlagAtivaHotSite>'+LowerCase(BoolToStr(TepMarca(AepEntidade).FlagAtivaHotSite, True))+'</dat:FlagAtivaHotSite>'+
            '        <dat:FlagAtiva>'+LowerCase(BoolToStr(TepMarca(AepEntidade).FlagAtivaHotSite, True))+'</dat:FlagAtiva>'+
            '      </e:Marca>'+
            '    </e:CriarMarca>'+
            '  </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepMarcaSync.GetXMLObterRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:ObterMarca>'+
            '      <!--Optional:-->' +
            '      <e:Usuario>' + FUserName + '</e:Usuario>' +
            '      <!--Optional:-->' +
            '      <e:Senha>' + FUserPassword + '</e:Senha>' +
            '      <!--Optional:-->' +
            '      <e:UrlSite>' + FURLSite+COMPL_URL + '</e:UrlSite>' +
            '      <!--Optional:-->' +
            '      <e:Id>' + IntToStr(TepMarca(epEntidade).IDMarca) + '</e:Id>' +
            '      </e:ObterMarca>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepMarcaSync.GetXMLVerificarRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:VerificarMarca>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Id>'+IntToStr(TepMarca(epEntidade).IDMarca)+'</e:Id>'+
            '      </e:VerificarMarca>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepMarcaSync.Listar: TepMarcaLista;
begin
  Result := TepMarcaLista.Create;
end;

{ TepProdutoSync }

function TepProdutoSync.CarregarEntidade: TepEntidade;
var
  i: Integer;
  epSKU: TepSKU;
begin
  TepProduto(Result)                         := TepProduto.Create;
  TepProduto(Result).IDProduto               := FXMLContent.GetAttributeInteger('IdProduto');
  TepProduto(Result).IDProdutoEdicao         := FXMLContent.GetAttributeInteger('IdProdutoEdicao');
  TepProduto(Result).Nome                    := FXMLContent.GetAttributeString('Nome');
  TepProduto(Result).PalavraChave            := FXMLContent.GetAttributeString('PalavraChave');
  TepProduto(Result).Texto                   := FXMLContent.GetAttributeString('Texto');
  TepProduto(Result).TextoLink               := FXMLContent.GetAttributeString('TextoLink');
  TepProduto(Result).TituloSite              := FXMLContent.GetAttributeString('TituloSite');
  TepProduto(Result).IDAdministradorEdicao   := FXMLContent.GetAttributeInteger('IdAdministradorEdicao');
  TepProduto(Result).IDAdministradorAprovado := FXMLContent.GetAttributeInteger('IdAdministradorAprovado');
  TepProduto(Result).IDFornecedor            := FXMLContent.GetAttributeInteger('IdFornecedor');
  TepProduto(Result).IDDepartamento          := FXMLContent.GetAttributeInteger('IdDepartamento');
  TepProduto(Result).IDCategoria             := FXMLContent.GetAttributeInteger('IdCategoria');
  TepProduto(Result).IDMarca                 := FXMLContent.GetAttributeInteger('IdMarca');
  TepProduto(Result).IDLinha                 := FXMLContent.GetAttributeInteger('IdLinha');
  TepProduto(Result).DataEdicao              := FXMLContent.GetAttributeDateTime('DataEdicao');
  TepProduto(Result).DataAprovado            := FXMLContent.GetAttributeDateTime('DataAprovado');
  TepProduto(Result).FlagExibe               := FXMLContent.GetAttributeBoolean('FlagExibe');
  TepProduto(Result).FlagSorteiaSku          := FXMLContent.GetAttributeBoolean('FlagSorteiaSku');
  TepProduto(Result).FlagAtiva               := FXMLContent.GetAttributeBoolean('FlagAtiva');
  TepProduto(Result).Prioridade              := FXMLContent.GetAttributeInteger('Prioridade');
  TepProduto(Result).PalavraChaveMarca       := FXMLContent.GetAttributeString('PalavraChaveMarca');
  TepProduto(Result).PrecoSkuDe              := FXMLContent.GetAttributeDouble('PrecoSkuDe');
  TepProduto(Result).PrecoSkuAte             := FXMLContent.GetAttributeDouble('PrecoSkuAte');
  TepProduto(Result).Ordenacao               := FXMLContent.GetAttributeString('Ordenacao');
  TepProduto(Result).TextoMarca              := FXMLContent.GetAttributeString('TextoMarca');
  TepProduto(Result).TextoCategoria          := FXMLContent.GetAttributeString('TextoCategoria');
  TepProduto(Result).TextoDepartamento       := FXMLContent.GetAttributeString('TextoDepartamento');

  TepProduto(Result).Skus := TepSKULista.Create;
  for i := 0 to Pred(FXMLContent.GetNodeCount('DCSku')) do
  begin
    epSKU := TepSKU.Create;
    epSKU.IDSku                   := FXMLContent.GetAttributeIntegerByNodeIndex('DCSku', 'IdSku', i);
    epSKU.IDSkuEdicao             := FXMLContent.GetAttributeIntegerByNodeIndex('DCSku', 'IdSkuEdicao', i);
    epSKU.IDAdministradorEdicao   := FXMLContent.GetAttributeIntegerByNodeIndex('DCSku', 'IdAdministradorEdicao', i);
    epSKU.IDAdministradorAprovado := FXMLContent.GetAttributeIntegerByNodeIndex('DCSku', 'IdAdministradorAprovado', i);
    epSKU.IDProduto               := FXMLContent.GetAttributeIntegerByNodeIndex('DCSku', 'IdProduto', i);
    epSKU.IDFreteModalTipo        := FXMLContent.GetAttributeIntegerByNodeIndex('DCSku', 'IdFreteModalTipo', i);
    epSKU.FlagAtiva               := FXMLContent.GetAttributeBooleanByNodeIndex('DCSku', 'FlagAtiva', i);
    epSKU.FlagKit                 := FXMLContent.GetAttributeBooleanByNodeIndex('DCSku', 'FlagKit', i);
    epSKU.Nome                    := FXMLContent.GetAttributeStringByNodeIndex('DCSku', 'Nome', i);
    epSKU.Texto                   := FXMLContent.GetAttributeStringByNodeIndex('DCSku', 'Texto', i);
    epSKU.PrecoAnterior           := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'PrecoAnterior', i);
    epSKU.PrecoVenda              := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'PrecoVenda', i);
    epSKU.PrecoCusto              := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'PrecoCusto', i);
    epSKU.Peso                    := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'Peso', i);
    epSKU.Altura                  := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'Altura', i);
    epSKU.Largura                 := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'Largura', i);
    epSKU.Comprimento             := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'Comprimento', i);
    epSKU.PesoCubico              := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'PesoCubico', i);
    epSKU.DataPrevisaoChegada     := FXMLContent.GetAttributeDateTimeByNodeIndex('DCSku', 'DataPrevisaoChegada', i);
    epSKU.DataCadastro            := FXMLContent.GetAttributeDateTimeByNodeIndex('DCSku', 'DataCadastro', i);
    epSKU.PesoReal                := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'PesoReal', i);
    epSKU.AlturaReal              := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'AlturaReal', i);
    epSKU.LarguraReal             := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'LarguraReal', i);
    epSKU.ComprimentoReal         := FXMLContent.GetAttributeDoubleByNodeIndex('DCSku', 'ComprimentoReal', i);
    epSKU.CodigoReferencia        := FXMLContent.GetAttributeStringByNodeIndex('DCSku', 'CodigoReferencia', i);
    epSKU.DepartamentoGerencial   := FXMLContent.GetAttributeStringByNodeIndex('DCSku', 'DepartamentoGerencial', i);
    epSKU.SetorGerencial          := FXMLContent.GetAttributeStringByNodeIndex('DCSku', 'SetorGerencial', i);
    epSKU.IDSkuCondicaoComercial  := FXMLContent.GetAttributeIntegerByNodeIndex('DCSku', 'IdSkuCondicaoComercial', i);
    epSKU.FlagAtivaERP            := FXMLContent.GetAttributeBooleanByNodeIndex('DCSku', 'FlagAtivaERP', i);

    TepProduto(Result).Skus.Add(epSKU);
  end;
end;

function TepProdutoSync.GetSoapActionAlterar: String;
begin
  Result := 'AlterarProduto';
end;

function TepProdutoSync.GetSoapActionCriar: String;
begin
  Result := 'CriarProduto';
end;

function TepProdutoSync.GetSoapActionObter: String;
begin
  Result := 'ObterProduto';
end;

function TepProdutoSync.GetSoapActionVerificar: String;
begin
  Result := 'VerificarProduto';
end;

function TepProdutoSync.GetXMLAlterarRequest(AepEntidade: TepEntidade): WideString;
var
  i: Integer;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br" xmlns:dat="http://datacontract.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:AlterarProduto>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Produto>'+
            '            <dat:IdProduto>'+IntToStr(TepProduto(AepEntidade).IDProduto)+'</dat:IdProduto>'+
            '            <dat:IdProdutoEdicao>'+IntToStr(TepProduto(AepEntidade).IDProdutoEdicao)+'</dat:IdProdutoEdicao>'+
            '            <dat:Nome>'+TepProduto(AepEntidade).Nome+'</dat:Nome>'+
            '            <dat:PalavraChave>'+TepProduto(AepEntidade).PalavraChave+'</dat:PalavraChave>'+
            '            <dat:Texto>'+TepProduto(AepEntidade).Texto+'</dat:Texto>'+
            '            <dat:TextoLink>'+TepProduto(AepEntidade).TextoLink+'</dat:TextoLink>'+
            '            <dat:TituloSite>'+TepProduto(AepEntidade).TituloSite+'</dat:TituloSite>'+
            '            <!--Optional:-->'+
            '            <dat:IdAdministradorEdicao>'+IntToStr(TepProduto(AepEntidade).IDAdministradorEdicao)+'</dat:IdAdministradorEdicao>'+
            '            <!--Optional:-->'+
            '            <dat:IdAdministradorAprovado>'+IntToStr(TepProduto(AepEntidade).IDAdministradorAprovado)+'</dat:IdAdministradorAprovado>'+
            '            <!--Optional:-->'+
            '            <dat:IdFornecedor>'+IntToStr(TepProduto(AepEntidade).IDFornecedor)+'</dat:IdFornecedor>'+
            '            <dat:IdDepartamento>'+IntToStr(TepProduto(AepEntidade).IDDepartamento)+'</dat:IdDepartamento>'+
            '            <dat:IdCategoria>'+IntToStr(TepProduto(AepEntidade).IDCategoria)+'</dat:IdCategoria>'+
            '            <dat:IdMarca>'+IntToStr(TepProduto(AepEntidade).IDMarca)+'</dat:IdMarca>'+
            '            <dat:IdLinha>'+IntToStr(TepProduto(AepEntidade).IDLinha)+'</dat:IdLinha>'+
            '            <dat:FlagExibe>'+LowerCase(BoolToStr(TepProduto(AepEntidade).FlagExibe, True))+'</dat:FlagExibe>'+
            '            <dat:FlagSorteiaSku>'+LowerCase(BoolToStr(TepProduto(AepEntidade).FlagSorteiaSku, True))+'</dat:FlagSorteiaSku>'+
            '            <dat:FlagAtiva>'+LowerCase(BoolToStr(TepProduto(AepEntidade).FlagExibe, True))+'</dat:FlagAtiva>'+
            '            <!--Optional:-->'+
            '            <dat:Prioridade>'+IntToStr(TepProduto(AepEntidade).Prioridade)+'</dat:Prioridade>'+
            '            <!--Optional:-->'+
            '            <dat:PalavraChaveMarca>'+TepProduto(AepEntidade).PalavraChaveMarca+'</dat:PalavraChaveMarca>'+
            '            <!--Optional:-->'+
            '            <dat:PrecoSkuDe>'+StringReplace(FloatToStr(TepProduto(AepEntidade).PrecoSkuDe), ',', '.', [rfReplaceAll])+'</dat:PrecoSkuDe>'+
            '            <!--Optional:-->'+
            '            <dat:PrecoSkuAte>'+StringReplace(FloatToStr(TepProduto(AepEntidade).PrecoSkuAte), ',', '.', [rfReplaceAll])+'</dat:PrecoSkuAte>'+
            '            <!--Optional:-->'+
            '            <dat:Ordenacao>'+TepProduto(AepEntidade).Ordenacao+'</dat:Ordenacao>'+
            '            <!--Optional:-->'+
            '            <dat:TextoMarca>'+TepProduto(AepEntidade).TextoMarca+'</dat:TextoMarca>'+
            '            <!--Optional:-->'+
            '            <dat:TextoCategoria>'+TepProduto(AepEntidade).TextoCategoria+'</dat:TextoCategoria>'+
            '            <!--Optional:-->'+
            '            <dat:TextoDepartamento>'+TepProduto(AepEntidade).TextoDepartamento+'</dat:TextoDepartamento>'+
            '            <!--Optional:-->'+
            '            <dat:Skus>'+
            '               <!--Zero or more repetitions:-->';
            for i := 0 to Pred(TepProduto(AepEntidade).Skus.Count) do
            begin
              Result := Result +
              '               <dat:DCSku>'+
              '                  <dat:IdSku>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDSku)+'</dat:IdSku>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdSkuEdicao>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDSkuEdicao)+'</dat:IdSkuEdicao>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdAdministradorEdicao>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDAdministradorEdicao)+'</dat:IdAdministradorEdicao>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdAdministradorAprovado>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDAdministradorAprovado)+'</dat:IdAdministradorAprovado>'+
              '                  <dat:IdProduto>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDProduto)+'</dat:IdProduto>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdFreteModalTipo>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDFreteModalTipo)+'</dat:IdFreteModalTipo>'+
              '                  <dat:FlagAtiva>'+LowerCase(BoolToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).FlagAtiva, True))+'</dat:FlagAtiva>'+
              '                  <dat:FlagKit>'+LowerCase(BoolToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).FlagKit, True))+'</dat:FlagKit>'+
              '                  <dat:Nome>'+TepSKU(TepProduto(AepEntidade).Skus[i]).Nome+'</dat:Nome>'+
              '                  <dat:Texto>'+TepSKU(TepProduto(AepEntidade).Skus[i]).Texto+'</dat:Texto>'+
              '                  <dat:PrecoAnterior>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PrecoAnterior), ',', '.', [rfReplaceAll])+'</dat:PrecoAnterior>'+
              '                  <dat:PrecoVenda>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PrecoVenda), ',', '.', [rfReplaceAll])+'</dat:PrecoVenda>'+
              '                  <dat:PrecoCusto>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PrecoCusto), ',', '.', [rfReplaceAll])+'</dat:PrecoCusto>'+
              '                  <dat:Peso>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).Peso), ',', '.', [rfReplaceAll])+'</dat:Peso>'+
              '                  <dat:Altura>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).Altura), ',', '.', [rfReplaceAll])+'</dat:Altura>'+
              '                  <dat:Largura>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).Largura), ',', '.', [rfReplaceAll])+'</dat:Largura>'+
              '                  <dat:Comprimento>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).Comprimento), ',', '.', [rfReplaceAll])+'</dat:Comprimento>'+
              '                  <dat:PesoCubico>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PesoCubico), ',', '.', [rfReplaceAll])+'</dat:PesoCubico>'+
              '                  <!--Optional:-->'+
              '                  <dat:PesoReal>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PesoReal), ',', '.', [rfReplaceAll])+'</dat:PesoReal>'+
              '                  <dat:AlturaReal>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).AlturaReal), ',', '.', [rfReplaceAll])+'</dat:AlturaReal>'+
              '                  <dat:LarguraReal>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).LarguraReal), ',', '.', [rfReplaceAll])+'</dat:LarguraReal>'+
              '                  <dat:ComprimentoReal>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).ComprimentoReal), ',', '.', [rfReplaceAll])+'</dat:ComprimentoReal>'+
              '                  <!--Optional:-->'+
              '                  <dat:CodigoReferencia>'+TepSKU(TepProduto(AepEntidade).Skus[i]).CodigoReferencia+'</dat:CodigoReferencia>'+
              '                  <!--Optional:-->'+
              '                  <dat:DepartamentoGerencial>'+TepSKU(TepProduto(AepEntidade).Skus[i]).DepartamentoGerencial+'</dat:DepartamentoGerencial>'+
              '                  <!--Optional:-->'+
              '                  <dat:SetorGerencial>'+TepSKU(TepProduto(AepEntidade).Skus[i]).SetorGerencial+'</dat:SetorGerencial>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdSkuCondicaoComercial>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDSkuCondicaoComercial)+'</dat:IdSkuCondicaoComercial>'+
              '                  <!--Optional:-->'+
              '                  <dat:FlagAtivaERP>'+LowerCase(BoolToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).FlagAtivaERP, True))+'</dat:FlagAtivaERP>'+
              '                  <!--Optional:-->'+
              '                  <dat:Produto/>'+
              '               </dat:DCSku>';
            end;
            Result := Result +
            '            </dat:Skus>'+
            '            <!--Optional:-->'+
            '            <dat:CodigoReferencia>'+TepProduto(AepEntidade).CodigoReferencia+'</dat:CodigoReferencia>'+
            '            <!--Optional:-->'+
            '            <dat:NomeComplemento>'+TepProduto(AepEntidade).NomeCompleto+'</dat:NomeComplemento>'+
            '         </e:Produto>'+
            '      </e:AlterarProduto>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepProdutoSync.GetXMLCriarRequest(AepEntidade: TepEntidade): WideString;
var
  i: Integer;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br" xmlns:dat="http://datacontract.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:CriarProduto>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Produto>'+
            '            <dat:IdProduto>'+IntToStr(TepProduto(AepEntidade).IDProduto)+'</dat:IdProduto>'+
            '            <dat:IdProdutoEdicao>'+IntToStr(TepProduto(AepEntidade).IDProdutoEdicao)+'</dat:IdProdutoEdicao>'+
            '            <dat:Nome>'+TepProduto(AepEntidade).Nome+'</dat:Nome>'+
            '            <dat:PalavraChave>'+TepProduto(AepEntidade).PalavraChave+'</dat:PalavraChave>'+
            '            <dat:Texto>'+TepProduto(AepEntidade).Texto+'</dat:Texto>'+
            '            <dat:TextoLink>'+TepProduto(AepEntidade).TextoLink+'</dat:TextoLink>'+
            '            <dat:TituloSite>'+TepProduto(AepEntidade).TituloSite+'</dat:TituloSite>'+
            '            <!--Optional:-->'+
            '            <dat:IdAdministradorEdicao>'+IntToStr(TepProduto(AepEntidade).IDAdministradorEdicao)+'</dat:IdAdministradorEdicao>'+
            '            <!--Optional:-->'+
            '            <dat:IdAdministradorAprovado>'+IntToStr(TepProduto(AepEntidade).IDAdministradorAprovado)+'</dat:IdAdministradorAprovado>'+
            '            <!--Optional:-->'+
            '            <dat:IdFornecedor>'+IntToStr(TepProduto(AepEntidade).IDFornecedor)+'</dat:IdFornecedor>'+
            '            <dat:IdDepartamento>'+IntToStr(TepProduto(AepEntidade).IDDepartamento)+'</dat:IdDepartamento>'+
            '            <dat:IdCategoria>'+IntToStr(TepProduto(AepEntidade).IDCategoria)+'</dat:IdCategoria>'+
            '            <dat:IdMarca>'+IntToStr(TepProduto(AepEntidade).IDMarca)+'</dat:IdMarca>'+
            '            <dat:IdLinha>'+IntToStr(TepProduto(AepEntidade).IDLinha)+'</dat:IdLinha>'+
            '            <dat:FlagExibe>'+LowerCase(BoolToStr(TepProduto(AepEntidade).FlagExibe, True))+'</dat:FlagExibe>'+
            '            <dat:FlagSorteiaSku>'+LowerCase(BoolToStr(TepProduto(AepEntidade).FlagSorteiaSku, True))+'</dat:FlagSorteiaSku>'+
            '            <dat:FlagAtiva>'+LowerCase(BoolToStr(TepProduto(AepEntidade).FlagAtiva, True))+'</dat:FlagAtiva>'+
            '            <!--Optional:-->'+
            '            <dat:Prioridade>'+IntToStr(TepProduto(AepEntidade).Prioridade)+'</dat:Prioridade>'+
            '            <!--Optional:-->'+
            '            <dat:PalavraChaveMarca>'+TepProduto(AepEntidade).PalavraChaveMarca+'</dat:PalavraChaveMarca>'+
            '            <!--Optional:-->'+
            '            <dat:PrecoSkuDe>'+StringReplace(FloatToStr(TepProduto(AepEntidade).PrecoSkuDe), ',', '.', [rfReplaceAll])+'</dat:PrecoSkuDe>'+
            '            <!--Optional:-->'+
            '            <dat:PrecoSkuAte>'+StringReplace(FloatToStr(TepProduto(AepEntidade).PrecoSkuAte), ',', '.', [rfReplaceAll])+'</dat:PrecoSkuAte>'+
            '            <!--Optional:-->'+
            '            <dat:Ordenacao>'+TepProduto(AepEntidade).Ordenacao+'</dat:Ordenacao>'+
            '            <!--Optional:-->'+
            '            <dat:TextoMarca>'+TepProduto(AepEntidade).TextoMarca+'</dat:TextoMarca>'+
            '            <!--Optional:-->'+
            '            <dat:TextoCategoria>'+TepProduto(AepEntidade).TextoCategoria+'</dat:TextoCategoria>'+
            '            <!--Optional:-->'+
            '            <dat:TextoDepartamento>'+TepProduto(AepEntidade).TextoDepartamento+'</dat:TextoDepartamento>'+
            '            <!--Optional:-->'+
            '            <dat:Skus>'+
            '               <!--Zero or more repetitions:-->';
            for i := 0 to Pred(TepProduto(AepEntidade).Skus.Count) do
            begin
              Result := Result +
              '               <dat:DCSku>'+
              '                  <dat:IdSku>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDSku)+'</dat:IdSku>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdSkuEdicao>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDSkuEdicao)+'</dat:IdSkuEdicao>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdAdministradorEdicao>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDAdministradorEdicao)+'</dat:IdAdministradorEdicao>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdAdministradorAprovado>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDAdministradorAprovado)+'</dat:IdAdministradorAprovado>'+
              '                  <dat:IdProduto>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDProduto)+'</dat:IdProduto>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdFreteModalTipo>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDFreteModalTipo)+'</dat:IdFreteModalTipo>'+
              '                  <dat:FlagAtiva>'+LowerCase(BoolToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).FlagAtiva, True))+'</dat:FlagAtiva>'+
              '                  <dat:FlagKit>'+LowerCase(BoolToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).FlagKit, True))+'</dat:FlagKit>'+
              '                  <dat:Nome>'+TepSKU(TepProduto(AepEntidade).Skus[i]).Nome+'</dat:Nome>'+
              '                  <dat:Texto>'+TepSKU(TepProduto(AepEntidade).Skus[i]).Texto+'</dat:Texto>'+
              '                  <dat:PrecoAnterior>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PrecoAnterior), ',', '.', [rfReplaceAll])+'</dat:PrecoAnterior>'+
              '                  <dat:PrecoVenda>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PrecoVenda), ',', '.', [rfReplaceAll])+'</dat:PrecoVenda>'+
              '                  <dat:PrecoCusto>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PrecoCusto), ',', '.', [rfReplaceAll])+'</dat:PrecoCusto>'+
              '                  <dat:Peso>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).Peso), ',', '.', [rfReplaceAll])+'</dat:Peso>'+
              '                  <dat:Altura>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).Altura), ',', '.', [rfReplaceAll])+'</dat:Altura>'+
              '                  <dat:Largura>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).Largura), ',', '.', [rfReplaceAll])+'</dat:Largura>'+
              '                  <dat:Comprimento>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).Comprimento), ',', '.', [rfReplaceAll])+'</dat:Comprimento>'+
              '                  <dat:PesoCubico>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PesoCubico), ',', '.', [rfReplaceAll])+'</dat:PesoCubico>'+
              '                  <dat:PesoReal>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).PesoReal), ',', '.', [rfReplaceAll])+'</dat:PesoReal>'+
              '                  <dat:AlturaReal>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).AlturaReal), ',', '.', [rfReplaceAll])+'</dat:AlturaReal>'+
              '                  <dat:LarguraReal>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).LarguraReal), ',', '.', [rfReplaceAll])+'</dat:LarguraReal>'+
              '                  <dat:ComprimentoReal>'+StringReplace(FloatToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).ComprimentoReal), ',', '.', [rfReplaceAll])+'</dat:ComprimentoReal>'+
              '                  <!--Optional:-->'+
              '                  <dat:CodigoReferencia>'+TepSKU(TepProduto(AepEntidade).Skus[i]).CodigoReferencia+'</dat:CodigoReferencia>'+
              '                  <!--Optional:-->'+
              '                  <dat:DepartamentoGerencial>'+TepSKU(TepProduto(AepEntidade).Skus[i]).DepartamentoGerencial+'</dat:DepartamentoGerencial>'+
              '                  <!--Optional:-->'+
              '                  <dat:SetorGerencial>'+TepSKU(TepProduto(AepEntidade).Skus[i]).SetorGerencial+'</dat:SetorGerencial>'+
              '                  <!--Optional:-->'+
              '                  <dat:IdSkuCondicaoComercial>'+IntToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).IDSkuCondicaoComercial)+'</dat:IdSkuCondicaoComercial>'+
              '                  <!--Optional:-->'+
              '                  <dat:FlagAtivaERP>'+LowerCase(BoolToStr(TepSKU(TepProduto(AepEntidade).Skus[i]).FlagAtivaERP, True))+'</dat:FlagAtivaERP>'+
              '                  <!--Optional:-->'+
              '                  <dat:Produto/>'+
              '               </dat:DCSku>';
            end;
            Result := Result +
            '            </dat:Skus>'+
            '            <!--Optional:-->'+
            '            <dat:CodigoReferencia>'+TepProduto(AepEntidade).CodigoReferencia+'</dat:CodigoReferencia>'+
            '            <!--Optional:-->'+
            '            <dat:NomeComplemento>'+TepProduto(AepEntidade).NomeCompleto+'</dat:NomeComplemento>'+
            '         </e:Produto>'+
            '      </e:CriarProduto>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepProdutoSync.GetXMLObterRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:ObterProduto>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Id>'+IntToStr(TepProduto(epEntidade).IDProduto)+'</e:Id>'+
            '      </e:ObterProduto>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepProdutoSync.GetXMLVerificarRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:VerificarProduto>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Id>'+IntToStr(TepProduto(epEntidade).IDProduto)+'</e:Id>'+
            '      </e:VerificarProduto>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

{ TepSKUSync }

function TepSKUSync.CarregarEntidade: TepEntidade;
begin
  Result                                 := TepSKU.Create;
  TepSKU(Result).IDSku                   := FXMLContent.GetAttributeInteger('IdSku');
  TepSKU(Result).IDSkuEdicao             := FXMLContent.GetAttributeInteger('IdSkuEdicao');
  TepSKU(Result).IDAdministradorEdicao   := FXMLContent.GetAttributeInteger('IdAdministradorEdicao');
  TepSKU(Result).IDAdministradorAprovado := FXMLContent.GetAttributeInteger('IdAdministradorAprovado');
  TepSKU(Result).IDProduto               := FXMLContent.GetAttributeInteger('IdProduto');
  TepSKU(Result).IDFreteModalTipo        := FXMLContent.GetAttributeInteger('IdFreteModalTipo');
  TepSKU(Result).FlagAtiva               := FXMLContent.GetAttributeBoolean('FlagAtiva');
  TepSKU(Result).FlagKit                 := FXMLContent.GetAttributeBoolean('FlagKit');
  TepSKU(Result).Nome                    := FXMLContent.GetAttributeString('Nome');
  TepSKU(Result).Texto                   := FXMLContent.GetAttributeString('Texto');
  TepSKU(Result).PrecoAnterior           := FXMLContent.GetAttributeDouble('PrecoAnterior');
  TepSKU(Result).PrecoVenda              := FXMLContent.GetAttributeDouble('PrecoVenda');
  TepSKU(Result).PrecoCusto              := FXMLContent.GetAttributeDouble('PrecoCusto');
  TepSKU(Result).Peso                    := FXMLContent.GetAttributeDouble('Peso');
  TepSKU(Result).Altura                  := FXMLContent.GetAttributeDouble('Altura');
  TepSKU(Result).Largura                 := FXMLContent.GetAttributeDouble('Largura');
  TepSKU(Result).Comprimento             := FXMLContent.GetAttributeDouble('Comprimento');
  TepSKU(Result).PesoCubico              := FXMLContent.GetAttributeDouble('PesoCubico');
  TepSKU(Result).DataPrevisaoChegada     := FXMLContent.GetAttributeDateTime('DataPrevisaoChegada');
  TepSKU(Result).DataCadastro            := FXMLContent.GetAttributeDateTime('DataCadastro');
  TepSKU(Result).PesoReal                := FXMLContent.GetAttributeDouble('PesoReal');
  TepSKU(Result).AlturaReal              := FXMLContent.GetAttributeDouble('AlturaReal');
  TepSKU(Result).LarguraReal             := FXMLContent.GetAttributeDouble('LarguraReal');
  TepSKU(Result).ComprimentoReal         := FXMLContent.GetAttributeDouble('ComprimentoReal');
  TepSKU(Result).CodigoReferencia        := FXMLContent.GetAttributeString('CodigoReferencia');
  TepSKU(Result).DepartamentoGerencial   := FXMLContent.GetAttributeString('DepartamentoGerencial');
  TepSKU(Result).SetorGerencial          := FXMLContent.GetAttributeString('SetorGerencial');
  TepSKU(Result).IDSkuCondicaoComercial  := FXMLContent.GetAttributeInteger('IdSkuCondicaoComercial');
  TepSKU(Result).FlagAtivaERP            := FXMLContent.GetAttributeBoolean('FlagAtivaERP');
  TepSKU(Result).Ean13                   := FXMLContent.GetAttributeString('Ean13');

  TepSKU(Result).Produto                         := TepProduto.Create;
  TepSKU(Result).Produto.IDProduto               := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdProduto', 0);
  TepSKU(Result).Produto.IDProdutoEdicao         := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdProdutoEdicao', 0);
  TepSKU(Result).Produto.Nome                    := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'Nome', 0);
  TepSKU(Result).Produto.PalavraChave            := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'PalavraChave', 0);
  TepSKU(Result).Produto.Texto                   := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'Texto', 0);
  TepSKU(Result).Produto.TextoLink               := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'TextoLink', 0);
  TepSKU(Result).Produto.TituloSite              := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'TituloSite', 0);
  TepSKU(Result).Produto.IDAdministradorEdicao   := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdAdministradorEdicao', 0);
  TepSKU(Result).Produto.IDAdministradorAprovado := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdAdministradorAprovado', 0);
  TepSKU(Result).Produto.IDFornecedor            := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdFornecedor', 0);
  TepSKU(Result).Produto.IDDepartamento          := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdDepartamento', 0);
  TepSKU(Result).Produto.IDCategoria             := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdCategoria', 0);
  TepSKU(Result).Produto.IDMarca                 := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdMarca', 0);
  TepSKU(Result).Produto.IDLinha                 := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'IdLinha', 0);
  TepSKU(Result).Produto.DataEdicao              := FXMLContent.GetAttributeDateTimeByNodeIndex('Produto', 'DataEdicao', 0);
  TepSKU(Result).Produto.DataAprovado            := FXMLContent.GetAttributeDateTimeByNodeIndex('Produto', 'DataAprovado', 0);
  TepSKU(Result).Produto.FlagExibe               := FXMLContent.GetAttributeBooleanByNodeIndex('Produto', 'FlagExibe', 0);
  TepSKU(Result).Produto.FlagSorteiaSku          := FXMLContent.GetAttributeBooleanByNodeIndex('Produto', 'FlagSorteiaSku', 0);
  TepSKU(Result).Produto.FlagAtiva               := FXMLContent.GetAttributeBooleanByNodeIndex('Produto', 'FlagAtiva', 0);
  TepSKU(Result).Produto.Prioridade              := FXMLContent.GetAttributeIntegerByNodeIndex('Produto', 'Prioridade', 0);
  TepSKU(Result).Produto.PalavraChaveMarca       := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'PalavraChaveMarca', 0);
  TepSKU(Result).Produto.PrecoSkuDe              := FXMLContent.GetAttributeDoubleByNodeIndex('Produto', 'PrecoSkuDe', 0);
  TepSKU(Result).Produto.PrecoSkuAte             := FXMLContent.GetAttributeDoubleByNodeIndex('Produto', 'PrecoSkuAte', 0);
  TepSKU(Result).Produto.Ordenacao               := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'Ordenacao', 0);
  TepSKU(Result).Produto.TextoMarca              := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'TextoMarca', 0);
  TepSKU(Result).Produto.TextoCategoria          := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'TextoCategoria', 0);
  TepSKU(Result).Produto.TextoDepartamento       := FXMLContent.GetAttributeStringByNodeIndex('Produto', 'TextoDepartamento', 0);
end;

function TepSKUSync.GetSoapActionAlterar: String;
begin
  Result := 'AlterarSku';
end;

function TepSKUSync.GetSoapActionCriar: String;
begin
  Result := 'CriarSku';
end;

function TepSKUSync.GetSoapActionObter: String;
begin
  Result := 'ObterSku';
end;

function TepSKUSync.GetSoapActionVerificar: String;
begin
  Result := 'VerificarSku';
end;

function TepSKUSync.GetXMLAlterarRequest(AepEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br" xmlns:dat="http://datacontract.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:AlterarSku>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Sku>'+
            '            <dat:IdSku>'+IntToStr(TepSKU(AepEntidade).IDSku)+'</dat:IdSku>'+
            '            <!--Optional:-->'+
            '            <dat:IdSkuEdicao>'+IntToStr(TepSKU(AepEntidade).IDSkuEdicao)+'</dat:IdSkuEdicao>'+
            '            <!--Optional:-->'+
            '            <dat:IdAdministradorEdicao>'+IntToStr(TepSKU(AepEntidade).IDAdministradorEdicao)+'</dat:IdAdministradorEdicao>'+
            '            <!--Optional:-->'+
            '            <dat:IdAdministradorAprovado>'+IntToStr(TepSKU(AepEntidade).IDAdministradorAprovado)+'</dat:IdAdministradorAprovado>'+
            '            <dat:IdProduto>'+IntToStr(TepSKU(AepEntidade).IDProduto)+'</dat:IdProduto>'+
            '            <!--Optional:-->'+
            '            <dat:IdFreteModalTipo>'+IntToStr(TepSKU(AepEntidade).IDFreteModalTipo)+'</dat:IdFreteModalTipo>'+
            '            <dat:FlagAtiva>'+LowerCase(BoolToStr(TepSKU(AepEntidade).FlagAtiva, True))+'</dat:FlagAtiva>'+
            '            <dat:FlagKit>'+LowerCase(BoolToStr(TepSKU(AepEntidade).FlagKit, True))+'</dat:FlagKit>'+
            '            <dat:Nome>'+TepSKU(AepEntidade).Nome+'</dat:Nome>'+
            '            <dat:Texto>'+TepSKU(AepEntidade).Texto+'</dat:Texto>'+
            '            <dat:PrecoAnterior>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PrecoAnterior), ',', '.', [rfReplaceAll])+'</dat:PrecoAnterior>'+
            '            <dat:PrecoVenda>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PrecoVenda), ',', '.', [rfReplaceAll])+'</dat:PrecoVenda>'+
            '            <dat:PrecoCusto>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PrecoCusto), ',', '.', [rfReplaceAll])+'</dat:PrecoCusto>'+
            '            <dat:Peso>'+StringReplace(FloatToStr(TepSKU(AepEntidade).Peso), ',', '.', [rfReplaceAll])+'</dat:Peso>'+
            '            <dat:Altura>'+StringReplace(FloatToStr(TepSKU(AepEntidade).Altura), ',', '.', [rfReplaceAll])+'</dat:Altura>'+
            '            <dat:Largura>'+StringReplace(FloatToStr(TepSKU(AepEntidade).Largura), ',', '.', [rfReplaceAll])+'</dat:Largura>'+
            '            <dat:Comprimento>'+StringReplace(FloatToStr(TepSKU(AepEntidade).Comprimento), ',', '.', [rfReplaceAll])+'</dat:Comprimento>'+
            '            <dat:PesoCubico>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PesoCubico), ',', '.', [rfReplaceAll])+'</dat:PesoCubico>'+
//            '            <!--Optional:-->'+
//            '            <dat:DataPrevisaoChegada>'++'</dat:DataPrevisaoChegada>'+
            '            <!--Optional:-->'+
            '            <dat:DataCadastro>'+FormatarDataXML(Now)+'</dat:DataCadastro>'+
            '            <dat:PesoReal>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PesoReal), ',', '.', [rfReplaceAll])+'</dat:PesoReal>'+
            '            <dat:AlturaReal>'+StringReplace(FloatToStr(TepSKU(AepEntidade).AlturaReal), ',', '.', [rfReplaceAll])+'</dat:AlturaReal>'+
            '            <dat:LarguraReal>'+StringReplace(FloatToStr(TepSKU(AepEntidade).LarguraReal), ',', '.', [rfReplaceAll])+'</dat:LarguraReal>'+
            '            <dat:ComprimentoReal>'+StringReplace(FloatToStr(TepSKU(AepEntidade).ComprimentoReal), ',', '.', [rfReplaceAll])+'</dat:ComprimentoReal>'+
            '            <!--Optional:-->'+
            '            <dat:CodigoReferencia>'+TepSKU(AepEntidade).CodigoReferencia+'</dat:CodigoReferencia>'+
            '            <!--Optional:-->'+
            '            <dat:DepartamentoGerencial>'+TepSKU(AepEntidade).DepartamentoGerencial+'</dat:DepartamentoGerencial>'+
            '            <!--Optional:-->'+
            '            <dat:SetorGerencial>'+TepSKU(AepEntidade).SetorGerencial+'</dat:SetorGerencial>'+
            '            <!--Optional:-->'+
            '            <dat:IdSkuCondicaoComercial>'+IntToStr(TepSKU(AepEntidade).IDSkuCondicaoComercial)+'</dat:IdSkuCondicaoComercial>'+
            '            <!--Optional:-->'+
            '            <dat:FlagAtivaERP>'+LowerCase(BoolToStr(TepSKU(AepEntidade).FlagAtivaERP, True))+'</dat:FlagAtivaERP>';
            if TepSKU(AepEntidade).Ean13 <> '' then
              Result := Result + '            <dat:Ean13>'+
                                 '               <!--Zero or more repetitions:-->'+
                                 '               <string>'+TepSKU(AepEntidade).Ean13+'</string>'+
                                 '            </dat:Ean13>';
  Result := Result + '         </e:Sku>'+
                     '      </e:AlterarSku>'+
                     '   </soapenv:Body>'+
                     '</soapenv:Envelope>';
end;

function TepSKUSync.GetXMLCriarRequest(AepEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br" xmlns:dat="http://datacontract.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:CriarSku>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Sku>'+
            '            <dat:IdSku>'+IntToStr(TepSKU(AepEntidade).IDSku)+'</dat:IdSku>'+
            '            <!--Optional:-->'+
            '            <dat:IdSkuEdicao>'+IntToStr(TepSKU(AepEntidade).IDSkuEdicao)+'</dat:IdSkuEdicao>'+
            '            <!--Optional:-->'+
            '            <dat:IdAdministradorEdicao>'+IntToStr(TepSKU(AepEntidade).IDAdministradorEdicao)+'</dat:IdAdministradorEdicao>'+
            '            <!--Optional:-->'+
            '            <dat:IdAdministradorAprovado>'+IntToStr(TepSKU(AepEntidade).IDAdministradorAprovado)+'</dat:IdAdministradorAprovado>'+
            '            <dat:IdProduto>'+IntToStr(TepSKU(AepEntidade).IDProduto)+'</dat:IdProduto>'+
            '            <!--Optional:-->'+
            '            <dat:IdFreteModalTipo>'+IntToStr(TepSKU(AepEntidade).IDFreteModalTipo)+'</dat:IdFreteModalTipo>'+
            '            <dat:FlagAtiva>'+LowerCase(BoolToStr(TepSKU(AepEntidade).FlagAtiva, True))+'</dat:FlagAtiva>'+
            '            <dat:FlagKit>'+LowerCase(BoolToStr(TepSKU(AepEntidade).FlagKit, True))+'</dat:FlagKit>'+
            '            <dat:Nome>'+TepSKU(AepEntidade).Nome+'</dat:Nome>'+
            '            <dat:Texto>'+TepSKU(AepEntidade).Texto+'</dat:Texto>'+
            '            <dat:PrecoAnterior>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PrecoAnterior), ',', '.', [rfReplaceAll])+'</dat:PrecoAnterior>'+
            '            <dat:PrecoVenda>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PrecoVenda), ',', '.', [rfReplaceAll])+'</dat:PrecoVenda>'+
            '            <dat:PrecoCusto>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PrecoCusto), ',', '.', [rfReplaceAll])+'</dat:PrecoCusto>'+
            '            <dat:Peso>'+StringReplace(FloatToStr(TepSKU(AepEntidade).Peso), ',', '.', [rfReplaceAll])+'</dat:Peso>'+
            '            <dat:Altura>'+StringReplace(FloatToStr(TepSKU(AepEntidade).Altura), ',', '.', [rfReplaceAll])+'</dat:Altura>'+
            '            <dat:Largura>'+StringReplace(FloatToStr(TepSKU(AepEntidade).Largura), ',', '.', [rfReplaceAll])+'</dat:Largura>'+
            '            <dat:Comprimento>'+StringReplace(FloatToStr(TepSKU(AepEntidade).Comprimento), ',', '.', [rfReplaceAll])+'</dat:Comprimento>'+
            '            <dat:PesoCubico>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PesoCubico), ',', '.', [rfReplaceAll])+'</dat:PesoCubico>'+
//            '            <!--Optional:-->'+
//            '            <dat:DataPrevisaoChegada>'++'</dat:DataPrevisaoChegada>'+
            '            <!--Optional:-->'+
            '            <dat:DataCadastro>'+FormatarDataXML(Now)+'</dat:DataCadastro>'+
            '            <dat:PesoReal>'+StringReplace(FloatToStr(TepSKU(AepEntidade).PesoReal), ',', '.', [rfReplaceAll])+'</dat:PesoReal>'+
            '            <dat:AlturaReal>'+StringReplace(FloatToStr(TepSKU(AepEntidade).AlturaReal), ',', '.', [rfReplaceAll])+'</dat:AlturaReal>'+
            '            <dat:LarguraReal>'+StringReplace(FloatToStr(TepSKU(AepEntidade).LarguraReal), ',', '.', [rfReplaceAll])+'</dat:LarguraReal>'+
            '            <dat:ComprimentoReal>'+StringReplace(FloatToStr(TepSKU(AepEntidade).ComprimentoReal), ',', '.', [rfReplaceAll])+'</dat:ComprimentoReal>'+
            '            <!--Optional:-->'+
            '            <dat:CodigoReferencia>'+TepSKU(AepEntidade).CodigoReferencia+'</dat:CodigoReferencia>'+
            '            <!--Optional:-->'+
            '            <dat:DepartamentoGerencial>'+TepSKU(AepEntidade).DepartamentoGerencial+'</dat:DepartamentoGerencial>'+
            '            <!--Optional:-->'+
            '            <dat:SetorGerencial>'+TepSKU(AepEntidade).SetorGerencial+'</dat:SetorGerencial>'+
            '            <!--Optional:-->'+
            '            <dat:IdSkuCondicaoComercial>'+IntToStr(TepSKU(AepEntidade).IDSkuCondicaoComercial)+'</dat:IdSkuCondicaoComercial>'+
            '            <!--Optional:-->'+
            '            <dat:FlagAtivaERP>'+LowerCase(BoolToStr(TepSKU(AepEntidade).FlagAtivaERP, True))+'</dat:FlagAtivaERP>';
            if TepSKU(AepEntidade).Ean13 <> '' then
              Result := Result + '            <dat:Ean13>'+
                                 '               <!--Zero or more repetitions:-->'+
                                 '               <string>'+TepSKU(AepEntidade).Ean13+'</string>'+
                                 '            </dat:Ean13>';
  Result := Result + '         </e:Sku>'+
                     '      </e:CriarSku>'+
                     '   </soapenv:Body>'+
                     '</soapenv:Envelope>';
end;

function TepSKUSync.GetXMLObterRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:ObterSku>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Id>'+IntToStr(TepSKU(epEntidade).IDSku)+'</e:Id>'+
            '      </e:ObterSku>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepSKUSync.GetXMLVerificarRequest(epEntidade: TepEntidade): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:VerificarSku>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:Id>'+IntToStr(TepSKU(epEntidade).IDSku)+'</e:Id>'+
            '      </e:VerificarSku>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

{ TepClienteSync }

function TepClienteSync.GetSoapActionListar: String;
begin
  Result := 'ListarCliente';
end;

function TepClienteSync.GetXMLListarRequest(ADataApartir: TDateTime): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:ListarCliente>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:DataApartir>'+FormatarDataXML(ADataApartir)+'</e:DataApartir>'+
            '      </e:ListarCliente>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepClienteSync.CarregarEntidadeLista: TepEntidadeLista;
var
  i: Integer;
  epCliente: TepCliente;
begin
  Result := TepClienteLista.Create;

  for i := 0 to Pred(FXMLContent.GetNodeCount('DCCliente')) do
  begin
    epCliente := TepCliente.Create;
    epCliente.IDCliente                   := FXMLContent.GetAttributeIntegerByNodeIndex('DCCliente', 'IdCliente', i);
    epCliente.UsuarioGuid                 := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'UsuarioGuid', i);
    epCliente.IDClienteEnderecoEntrega    := FXMLContent.GetAttributeIntegerByNodeIndex('DCCliente', 'IdClienteEnderecoEntrega', i);
    epCliente.IDAdministradorTelevenda    := FXMLContent.GetAttributeIntegerByNodeIndex('DCCliente', 'IdAdministradorTelevenda', i);
    epCliente.Sexo                        := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Sexo', i);
    epCliente.Nome                        := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Nome', i);
    epCliente.Apelido                     := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Apelido', i);
    epCliente.Email                       := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Email', i);
    epCliente.TelefoneResidencial         := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'TelefoneResidencial', i);
    epCliente.TelefoneCelular             := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'TelefoneCelular', i);
    epCliente.TelefoneComercial           := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'TelefoneComercial', i);
    epCliente.Senha                       := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Senha', i);
    epCliente.CpfCnpj                     := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'CpfCnpj', i);
    epCliente.Credito                     := FXMLContent.GetAttributeDoubleByNodeIndex('DCCliente', 'Credito', i);
    epCliente.Parceiro                    := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Parceiro', i);
    epCliente.Midia                       := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Midia', i);
    epCliente.Campanha                    := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Campanha', i);
    epCliente.NumeroLogon                 := FXMLContent.GetAttributeIntegerByNodeIndex('DCCliente', 'NumeroLogon', i);
    epCliente.DataNascimento              := FXMLContent.GetAttributeDateTimeByNodeIndex('DCCliente', 'DataNascimento', i);
    epCliente.DataCriacao                 := FXMLContent.GetAttributeDateTimeByNodeIndex('DCCliente', 'DataCriacao', i);
    epCliente.DataUltimoLogon             := FXMLContent.GetAttributeDateTimeByNodeIndex('DCCliente', 'DataUltimoLogon', i);
    epCliente.DataUltimaAtualizacao       := FXMLContent.GetAttributeDateTimeByNodeIndex('DCCliente', 'DataUltimaAtualizacao', i);
    epCliente.FlagPj                      := FXMLContent.GetAttributeBooleanByNodeIndex('DCCliente', 'FlagPj', i);
    epCliente.FlagAtiva                   := FXMLContent.GetAttributeBooleanByNodeIndex('DCCliente', 'FlagAtiva', i);
    epCliente.FlagFraude                  := FXMLContent.GetAttributeBooleanByNodeIndex('DCCliente', 'FlagFraude', i);
    epCliente.FlagNews                    := FXMLContent.GetAttributeBooleanByNodeIndex('DCCliente', 'FlagNews', i);
    epCliente.DataUltimaCompraEnviada     := FXMLContent.GetAttributeDateTimeByNodeIndex('DCCliente', 'DataUltimaCompraEnviada', i);
    epCliente.QuantidadeCompraEnviada     := FXMLContent.GetAttributeIntegerByNodeIndex('DCCliente', 'QuantidadeCompraEnviada', i);
    epCliente.RazaoSocial                 := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'RazaoSocial', i);
    epCliente.NomeFantasia                := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'NomeFantasia', i);
    epCliente.SobreNome                   := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'SobreNome', i);
    epCliente.Site                        := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Site', i);
    epCliente.InscricaoEstadual           := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'InscricaoEstadual', i);
    epCliente.FlagIsentoInscricaoEstadual := FXMLContent.GetAttributeBooleanByNodeIndex('DCCliente', 'FlagIsentoInscricaoEstadual', i);
    epCliente.FlagSMSNews                 := FXMLContent.GetAttributeBooleanByNodeIndex('DCCliente', 'FlagSMSNews', i);
    epCliente.Idade                       := FXMLContent.GetAttributeIntegerByNodeIndex('DCCliente', 'Idade', i);
    epCliente.Pais                        := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Pais', i);
    epCliente.Estado                      := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Estado', i);
    epCliente.Municipio                   := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Municipio', i);
    epCliente.Identificador               := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Identificador', i);
    epCliente.Rua                         := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Rua', i);
    epCliente.Numero                      := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Numero', i);
    epCliente.Complemento                 := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Complemento', i);
    epCliente.Bairro                      := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Bairro', i);
    epCliente.Cep                         := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'Cep', i);
    epCliente.PontoReferencia             := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'PontoReferencia', i);
    epCliente.TipoEndereco                := FXMLContent.GetAttributeStringByNodeIndex('DCCliente', 'TipoEndereco', i);

    Result.Add(epCliente);
  end;
end;

{ TepCompraSync }

function TepCompraSync.GetSoapActionListar: String;
begin
  Result := 'ListarComprasPorStatus';
end;

function TepCompraSync.GetXMLListarRequest(ADataApartir: TDateTime): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:ListarComprasPorStatus>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:DataApartir>'+FormatarDataXML(ADataApartir)+'</e:DataApartir>'+
            '         <!--Optional:-->'+
            '         <e:Status>'+FStatusCompra+'</e:Status>'+
            '      </e:ListarComprasPorStatus>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepCompraSync.CarregarEntidadeLista: TepEntidadeLista;
var
  i, j, k: Integer;
  XMLCompra, XMLEnderecoEntrega, XMLEntrega, XMLEntregaLista, XMLEntregaSku, XMLFormaPagamento, XMLCliente: TXMLContent;
  epCompra: TepCompra;
  epEnderecoEntrega: TepEnderecoEntrega;
  epEntrega: TepEntrega;
  epCompraEntregaSku: TepCompraEntregaSku;
  epFormaPagamento: TepFormaPagamento;
begin
  Result := TepCompraLista.Create;

  XMLCompra          := TXMLContent.Create;
  XMLEnderecoEntrega := TXMLContent.Create;
  XMLEntrega         := TXMLContent.Create;
  XMLEntregaLista    := TXMLContent.Create;
  XMLEntregaSku      := TXMLContent.Create;
  XMLFormaPagamento  := TXMLContent.Create;
  XMLCliente         := TXMLContent.Create;

  try
    for i := 0 to Pred(FXMLContent.GetNodeCount('DCCompra')) do
    begin
      XMLCompra.XML          := FXMLContent.GetNodeByIndex('DCCompra', i);
      XMLEnderecoEntrega.XML := XMLCompra.CutNode('EnderecoEntregas');
      XMLEntregaLista.XML    := XMLCompra.CutNode('Entregas');
      XMLFormaPagamento.XML  := XMLCompra.CutNode('FormasPagamento');
      XMLCliente.XML         := XMLCompra.CutNode('Cliente');

      epCompra                             := TepCompra.Create;
      epCompra.IDCompra                    := XMLCompra.GetAttributeInteger('IdCompra');
      epCompra.IDCliente                   := XMLCompra.GetAttributeInteger('IdCliente');
      epCompra.IDAdministradorTelevenda    := XMLCompra.GetAttributeInteger('IdAdministradorTelevenda');
      epCompra.IDAfiliado                  := XMLCompra.GetAttributeInteger('IdAfiliado');
      epCompra.IdListaDeCompra             := XMLCompra.GetAttributeInteger('IdListaDeCompra');
      epCompra.Midia                       := XMLCompra.GetAttributeString('Midia');
      epCompra.Parceiro                    := XMLCompra.GetAttributeString('Parceiro');
      epCompra.Campanha                    := XMLCompra.GetAttributeString('Campanha');
      epCompra.PalavraChave                := XMLCompra.GetAttributeString('PalavraChave');
      epCompra.Origem                      := XMLCompra.GetAttributeString('Origem');
      epCompra.Data                        := XMLCompra.GetAttributeDateTime('Data');
      epCompra.ValorTotalComDesconto       := XMLCompra.GetAttributeDouble('ValorTotalComDesconto');
      epCompra.ValorTotalComDescontoDevido := XMLCompra.GetAttributeDouble('ValorTotalComDescontoDevido');
      epCompra.TesteAB                     := XMLCompra.GetAttributeString('TesteAB');
      epCompra.FlagAtiva                   := XMLCompra.GetAttributeBoolean('FlagAtiva');
      epCompra.IpCliente                   := XMLCompra.GetAttributeString('IpCliente');

      // ENDEREÇO ENTREGA
      epCompra.EnderecoEntregaLista := TepEnderecoEntregaLista.Create;
      for j := 0 to Pred(XMLEnderecoEntrega.GetNodeCount('DCCompraEnderecoEntrega')) do
      begin
        epEnderecoEntrega                         := TepEnderecoEntrega.Create;
        epEnderecoEntrega.IDCompraEnderecoEntrega := XMLEnderecoEntrega.GetAttributeIntegerByNodeIndex('DCCompraEnderecoEntrega', 'IdCompraEnderecoEntrega', j);
        epEnderecoEntrega.IDCompra                := XMLEnderecoEntrega.GetAttributeIntegerByNodeIndex('DCCompraEnderecoEntrega', 'IdCompra', j);
        epEnderecoEntrega.NomeDestinatario        := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'NomeDestinatario', j);
        epEnderecoEntrega.TelefoneResidencial     := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'TelefoneResidencial', j);
        epEnderecoEntrega.TelefoneCelular         := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'TelefoneCelular', j);
        epEnderecoEntrega.TelefoneComercial       := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'TelefoneComercial', j);
        epEnderecoEntrega.Rua                     := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Rua', j);
        epEnderecoEntrega.Numero                  := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Numero', j);
        epEnderecoEntrega.Complemento             := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Complemento', j);
        epEnderecoEntrega.Bairro                  := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Bairro', j);
        epEnderecoEntrega.Municipio               := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Municipio', j);
        epEnderecoEntrega.Estado                  := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Estado', j);
        epEnderecoEntrega.Cep                     := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Cep', j);
        epEnderecoEntrega.Pais                    := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Pais', j);
        epEnderecoEntrega.PontoReferencia         := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'PontoReferencia', j);
        epEnderecoEntrega.Identificacao           := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Identificacao', j);
        epEnderecoEntrega.Tipo                    := XMLEnderecoEntrega.GetAttributeStringByNodeIndex('DCCompraEnderecoEntrega', 'Tipo', j);

        epCompra.EnderecoEntregaLista.Add(epEnderecoEntrega);
      end;

      // ENTREGA
      epCompra.EntregaLista := TepEntregaLista.Create;
      for j := 0 to Pred(XMLEntregaLista.GetNodeCount('DCEntrega')) do
      begin
        XMLEntrega.XML := XMLEntregaLista.GetNodeByIndex('DCEntrega', j);
        XMLEntregaSku.XML := XMLEntrega.CutNode('CompraEntregaSkus');

        epEntrega                                 := TepEntrega.Create;
        epEntrega.IDCompraEntrega                 := XMLEntrega.GetAttributeInteger('IdCompraEntrega');
        epEntrega.IDCompra                        := XMLEntrega.GetAttributeInteger('IdCompra');
        epEntrega.IDFreteEntregaTipo              := XMLEntrega.GetAttributeInteger('IdFreteEntregaTipo');
        epEntrega.IDCompraEntregaStatus           := XMLEntrega.GetAttributeString('IdCompraEntregaStatus');
        epEntrega.IDentificadorFrete              := XMLEntrega.GetAttributeString('IdentificadorFrete');
        epEntrega.IDAdministradorStatus           := XMLEntrega.GetAttributeInteger('IdAdministradorStatus');
        epEntrega.DataSaida                       := XMLEntrega.GetAttributeDateTime('DataSaida');
        epEntrega.DataPrevisao                    := XMLEntrega.GetAttributeDateTime('DataPrevisao');
        epEntrega.DataEntrega                     := XMLEntrega.GetAttributeDateTime('DataEntrega');
        epEntrega.DataStatus                      := XMLEntrega.GetAttributeDateTime('DataStatus');
        epEntrega.ObsTransportadora               := XMLEntrega.GetAttributeString('ObsTransportadora');
        epEntrega.PrazoEntregaMaisDisponibilidade := XMLEntrega.GetAttributeInteger('PrazoEntregaMaisDisponibilidade');
        epEntrega.PrazoEstoque                    := XMLEntrega.GetAttributeInteger('PrazoEstoque');

        // COMPRA ENTREGA SKU
        epEntrega.CompraEntregaSkuLista := TepCompraEntregaSkuLista.Create;
        for k := 0 to Pred(XMLEntregaSku.GetNodeCount('DCCompraEntregaSku')) do
        begin
          epCompraEntregaSku                                    := TepCompraEntregaSku.Create;
          epCompraEntregaSku.IDCompraEntregaSku                 := XMLEntregaSku.GetAttributeIntegerByNodeIndex('DCCompraEntregaSku', 'IdCompraEntregaSku', k);
          epCompraEntregaSku.IDCompraEntregaSkuPai              := XMLEntregaSku.GetAttributeIntegerByNodeIndex('DCCompraEntregaSku', 'IdCompraEntregaSkuPai', k);
          epCompraEntregaSku.IDDescontoCompreJunto              := XMLEntregaSku.GetAttributeIntegerByNodeIndex('DCCompraEntregaSku', 'IdDescontoCompreJunto', k);
          epCompraEntregaSku.IDDescontoBrindeCausa              := XMLEntregaSku.GetAttributeIntegerByNodeIndex('DCCompraEntregaSku', 'IdDescontoBrindeCausa', k);
          epCompraEntregaSku.IDCompraEntrega                    := XMLEntregaSku.GetAttributeIntegerByNodeIndex('DCCompraEntregaSku', 'IdCompraEntrega', k);
          epCompraEntregaSku.IDSku                              := XMLEntregaSku.GetAttributeIntegerByNodeIndex('DCCompraEntregaSku', 'IdSku', k);
          epCompraEntregaSku.IDEstoqueProvavel                  := XMLEntregaSku.GetAttributeIntegerByNodeIndex('DCCompraEntregaSku', 'IdEstoqueProvavel', k);
          epCompraEntregaSku.ValorVendaUnidadeSemDesconto       := XMLEntregaSku.GetAttributeDoubleByNodeIndex('DCCompraEntregaSku', 'ValorVendaUnidadeSemDesconto', k);
          epCompraEntregaSku.ValorVendaUnidade                  := XMLEntregaSku.GetAttributeDoubleByNodeIndex('DCCompraEntregaSku', 'ValorVendaUnidade', k);
          epCompraEntregaSku.ValorCupomNominal                  := XMLEntregaSku.GetAttributeDoubleByNodeIndex('DCCompraEntregaSku', 'ValorCupomNominal', k);
          epCompraEntregaSku.ValorVendaUnidadeMenosCupomNominal := XMLEntregaSku.GetAttributeDoubleByNodeIndex('DCCompraEntregaSku', 'ValorVendaUnidadeMenosCupomNominal', k);
          epCompraEntregaSku.ValorFreteComDesconto              := XMLEntregaSku.GetAttributeDoubleByNodeIndex('DCCompraEntregaSku', 'ValorFreteComDesconto', k);
          epCompraEntregaSku.ValorFrete                         := XMLEntregaSku.GetAttributeDoubleByNodeIndex('DCCompraEntregaSku', 'ValorFrete', k);
          epCompraEntregaSku.Servicos                           := XMLEntregaSku.GetAttributeStringByNodeIndex('DCCompraEntregaSku', 'Servicos', k);
          epCompraEntregaSku.CodigoReferenciaSku                := XMLEntregaSku.GetAttributeStringByNodeIndex('DCCompraEntregaSku', 'CodigoReferenciaSku', k);

          epEntrega.CompraEntregaSkuLista.Add(epCompraEntregaSku);
        end;

        // FRETE
        epEntrega.Frete                              := TepFrete.Create;
        epEntrega.Frete.IDFrete                      := XMLEntrega.GetAttributeInteger('IdFrete');
        epEntrega.Frete.IDFreteEntregaTipo           := XMLEntrega.GetAttributeInteger('IdFreteEntregaTipo');
        epEntrega.Frete.IDFreteModalTipo             := XMLEntrega.GetAttributeInteger('IdFreteModalTipo');
        epEntrega.Frete.Nome                         := XMLEntrega.GetAttributeString('Nome');
        epEntrega.Frete.Texto                        := XMLEntrega.GetAttributeString('Texto');
        epEntrega.Frete.FlagAtiva                    := XMLEntrega.GetAttributeBoolean('FlagAtiva');
        epEntrega.Frete.PrazoEntrega                 := XMLEntrega.GetAttributeInteger('PrazoEntrega');

        epEntrega.Frete.FreteTipo                    := TepFreteTipo.Create;
        epEntrega.Frete.FreteTipo.IDFreteEntregaTipo := XMLEntrega.GetAttributeInteger('IdFreteEntregaTipo');
        epEntrega.Frete.FreteTipo.Nome               := XMLEntrega.GetAttributeString('Nome');
        epEntrega.Frete.FreteTipo.Texto              := XMLEntrega.GetAttributeString('Texto');

        epCompra.EntregaLista.Add(epEntrega);
      end;

      // FORMA PAGAMENTO
      epCompra.FormaPagamentoLista := TepFormaPagamentoLista.Create;
      for j := 0 to Pred(XMLFormaPagamento.GetNodeCount('DCCompraFormaPagamento')) do
      begin
        epFormaPagamento                              := TepFormaPagamento.Create;
        epFormaPagamento.IDCompraFormaPagamento       := XMLFormaPagamento.GetAttributeIntegerByNodeIndex('DCCompraFormaPagamento', 'IdCompraFormaPagamento', j);
        epFormaPagamento.IDFormaPagamento             := XMLFormaPagamento.GetAttributeIntegerByNodeIndex('DCCompraFormaPagamento', 'IdFormaPagamento', j);
        epFormaPagamento.IDCompra                     := XMLFormaPagamento.GetAttributeIntegerByNodeIndex('DCCompraFormaPagamento', 'IdCompra', j);
        epFormaPagamento.IDVale                       := XMLFormaPagamento.GetAttributeIntegerByNodeIndex('DCCompraFormaPagamento', 'IdVale', j);
        epFormaPagamento.IDCompraFormaPagamentoStatus := XMLFormaPagamento.GetAttributeIntegerByNodeIndex('DCCompraFormaPagamento', 'IdCompraFormaPagamentoStatus', j);
        epFormaPagamento.QuantidadeParcelas           := XMLFormaPagamento.GetAttributeIntegerByNodeIndex('DCCompraFormaPagamento', 'QuantidadeParcelas', j);
        epFormaPagamento.ValorComJuros                := XMLFormaPagamento.GetAttributeDoubleByNodeIndex('DCCompraFormaPagamento', 'ValorComJuros', j);
        epFormaPagamento.ValorJuros                   := XMLFormaPagamento.GetAttributeDoubleByNodeIndex('DCCompraFormaPagamento', 'ValorJuros', j);
        epFormaPagamento.CcNome                       := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'CcNome', j);
        epFormaPagamento.CcUltimos4Numeros            := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'CcUltimos4Numeros', j);
        epFormaPagamento.CcNumero                     := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'CcNumero', j);
        epFormaPagamento.CcCodigo                     := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'CcCodigo', j);
        epFormaPagamento.CcAnoMes                     := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'CcAnoMes', j);
        epFormaPagamento.CcAno                        := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'CcAno', j);
        epFormaPagamento.CcMes                        := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'CcMes', j);
        epFormaPagamento.FlagModoManual               := XMLFormaPagamento.GetAttributeBooleanByNodeIndex('DCCompraFormaPagamento', 'FlagModoManual', j);
        epFormaPagamento.FlagAtiva                    := XMLFormaPagamento.GetAttributeBooleanByNodeIndex('DCCompraFormaPagamento', 'FlagAtiva', j);
        epFormaPagamento.Data                         := XMLFormaPagamento.GetAttributeDateTimeByNodeIndex('DCCompraFormaPagamento', 'Data', j);
        epFormaPagamento.Rua                          := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Rua', j);
        epFormaPagamento.Numero                       := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Numero', j);
        epFormaPagamento.Complemento                  := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Complemento', j);
        epFormaPagamento.Bairro                       := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Bairro', j);
        epFormaPagamento.Municipio                    := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Municipio', j);
        epFormaPagamento.Estado                       := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Estado', j);
        epFormaPagamento.Cep                          := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Cep', j);
        epFormaPagamento.Pais                         := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Pais', j);
        epFormaPagamento.Url                          := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'Url', j);
        epFormaPagamento.PontoReferencia              := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'PontoReferencia', j);
        epFormaPagamento.TipoEndereco                 := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'TipoEndereco', j);
        epFormaPagamento.CcPrimeiros6Numeros          := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'CcPrimeiros6Numeros', j);
        epFormaPagamento.NomeFormaPagamento           := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'NomeFormaPagamento', j);
        epFormaPagamento.TipoFormaPagamento           := XMLFormaPagamento.GetAttributeStringByNodeIndex('DCCompraFormaPagamento', 'TipoFormaPagamento', j);

        epCompra.FormaPagamentoLista.Add(epFormaPagamento);
      end;

      // CLIENTE
      epCompra.Cliente                             := TepCliente.Create;
      epCompra.Cliente.IDCliente                   := XMLCliente.GetAttributeInteger('IdCliente');
      epCompra.Cliente.UsuarioGuid                 := XMLCliente.GetAttributeString('UsuarioGuid');
      epCompra.Cliente.IDClienteEnderecoEntrega    := XMLCliente.GetAttributeInteger('IdClienteEnderecoEntrega');
      epCompra.Cliente.IDAdministradorTelevenda    := XMLCliente.GetAttributeInteger('IdAdministradorTelevenda');
      epCompra.Cliente.Sexo                        := XMLCliente.GetAttributeString('Sexo');
      epCompra.Cliente.Nome                        := XMLCliente.GetAttributeString('Nome');
      epCompra.Cliente.Apelido                     := XMLCliente.GetAttributeString('Apelido');
      epCompra.Cliente.Email                       := XMLCliente.GetAttributeString('Email');
      epCompra.Cliente.TelefoneResidencial         := XMLCliente.GetAttributeString('TelefoneResidencial');
      epCompra.Cliente.TelefoneCelular             := XMLCliente.GetAttributeString('TelefoneCelular');
      epCompra.Cliente.TelefoneComercial           := XMLCliente.GetAttributeString('TelefoneComercial');
      epCompra.Cliente.Senha                       := XMLCliente.GetAttributeString('Senha');
      epCompra.Cliente.CpfCnpj                     := XMLCliente.GetAttributeString('CpfCnpj');
      epCompra.Cliente.Credito                     := XMLCliente.GetAttributeDouble('Credito');
      epCompra.Cliente.Parceiro                    := XMLCliente.GetAttributeString('Parceiro');
      epCompra.Cliente.Midia                       := XMLCliente.GetAttributeString('Midia');
      epCompra.Cliente.Campanha                    := XMLCliente.GetAttributeString('Campanha');
      epCompra.Cliente.NumeroLogon                 := XMLCliente.GetAttributeInteger('NumeroLogon');
      epCompra.Cliente.DataNascimento              := XMLCliente.GetAttributeDateTime('DataNascimento');
      epCompra.Cliente.DataCriacao                 := XMLCliente.GetAttributeDateTime('DataCriacao');
      epCompra.Cliente.DataUltimoLogon             := XMLCliente.GetAttributeDateTime('DataUltimoLogon');
      epCompra.Cliente.DataUltimaAtualizacao       := XMLCliente.GetAttributeDateTime('DataUltimaAtualizacao');
      epCompra.Cliente.FlagPj                      := XMLCliente.GetAttributeBoolean('FlagPj');
      epCompra.Cliente.FlagAtiva                   := XMLCliente.GetAttributeBoolean('FlagAtiva');
      epCompra.Cliente.FlagFraude                  := XMLCliente.GetAttributeBoolean('FlagFraude');
      epCompra.Cliente.FlagNews                    := XMLCliente.GetAttributeBoolean('FlagNews');
      epCompra.Cliente.DataUltimaCompraEnviada     := XMLCliente.GetAttributeDateTime('DataUltimaCompraEnviada');
      epCompra.Cliente.QuantidadeCompraEnviada     := XMLCliente.GetAttributeInteger('QuantidadeCompraEnviada');
      epCompra.Cliente.RazaoSocial                 := XMLCliente.GetAttributeString('RazaoSocial');
      epCompra.Cliente.NomeFantasia                := XMLCliente.GetAttributeString('NomeFantasia');
      epCompra.Cliente.SobreNome                   := XMLCliente.GetAttributeString('SobreNome');
      epCompra.Cliente.Site                        := XMLCliente.GetAttributeString('Site');
      epCompra.Cliente.InscricaoEstadual           := XMLCliente.GetAttributeString('InscricaoEstadual');
      epCompra.Cliente.FlagIsentoInscricaoEstadual := XMLCliente.GetAttributeBoolean('FlagIsentoInscricaoEstadual');
      epCompra.Cliente.FlagSMSNews                 := XMLCliente.GetAttributeBoolean('FlagSMSNews');
      epCompra.Cliente.Idade                       := XMLCliente.GetAttributeInteger('Idade');

      Result.Add(epCompra);
    end;
  finally
    XMLCompra.Free;
    XMLEnderecoEntrega.Free;
    XMLEntrega.Free;
    XMLEntregaLista.Free;
    XMLEntregaSku.Free;
    XMLFormaPagamento.Free;
    XMLCliente.Free;
  end;
end;

{ TepEstoqueSync }

function TepEstoqueSync.Atualizar(AepSaldoSKU: TepSaldoSKU): Boolean;
var
  ContentStream: TStream;
  ContentStringStream: TStringStream;
begin
  Result := False;

  ContentStream := TMemoryStream.Create;
  ContentStringStream := TStringStream.Create('');
  try
    FHTTPReqResp.SoapAction := GetSoapActionURL + GetSoapActionAtualizar;
    FHTTPReqResp.Execute(GetXMLAtualizarRequest(AepSaldoSKU), ContentStream);

    ContentStringStream.CopyFrom(ContentStream, 0);
    FXMLContent.XML := UTF8Decode(ContentStringStream.DataString);
  finally
    ContentStream.Free;
    ContentStringStream.Free;
  end;
end;

function TepEstoqueSync.GetSoapActionAtualizar: String;
begin
  Result := 'AtualizarEstoque';
end;

function TepEstoqueSync.GetSoapActionListar: String;
begin
  Result := 'ListarEstoques';
end;

function TepEstoqueSync.GetXMLAtualizarRequest(AepSaldoSKU: TepSaldoSKU): WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:AtualizarEstoque>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '         <!--Optional:-->'+
            '         <e:IdEstoque>'+IntToStr(AepSaldoSKU.IdEstoque)+'</e:IdEstoque>'+
            '         <!--Optional:-->'+
            '         <e:IdSku>'+IntToStr(AepSaldoSKU.IdSku)+'</e:IdSku>'+
            '         <!--Optional:-->'+
            '         <e:Quantidade>'+IntToStr(AepSaldoSKU.QuantidadeDisponivel)+'</e:Quantidade>'+
            '      </e:AtualizarEstoque>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepEstoqueSync.GetXMLListarRequest: WideString;
begin
  Result := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:e="http://www.e-plataforma.com.br">'+
            '   <soapenv:Header/>'+
            '   <soapenv:Body>'+
            '      <e:ListarEstoques>'+
            '         <!--Optional:-->'+
            '         <e:Usuario>'+FUserName+'</e:Usuario>'+
            '         <!--Optional:-->'+
            '         <e:Senha>'+FUserPassword+'</e:Senha>'+
            '         <!--Optional:-->'+
            '         <e:UrlSite>'+FURLSite+COMPL_URL+'</e:UrlSite>'+
            '      </e:ListarEstoques>'+
            '   </soapenv:Body>'+
            '</soapenv:Envelope>';
end;

function TepEstoqueSync.CarregarEntidadeLista: TepEntidadeLista;
var
  i: Integer;
  epEstoque: TepEstoque;
begin
  Result := TepEstoqueLista.Create;

  for i := 0 to Pred(FXMLContent.GetNodeCount('DCEstoque')) do
  begin
    epEstoque              := TepEstoque.Create;
    epEstoque.IdEstoque    := FXMLContent.GetAttributeIntegerByNodeIndex('DCEstoque', 'IdEstoque', i);
    epEstoque.IdEndereco   := FXMLContent.GetAttributeIntegerByNodeIndex('DCEstoque', 'IdEndereco', i);
    epEstoque.Nome         := FXMLContent.GetAttributeStringByNodeIndex('DCEstoque', 'Nome', i);
    epEstoque.Sinal        := FXMLContent.GetAttributeIntegerByNodeIndex('DCEstoque', 'Sinal', i);
    epEstoque.FlagAtiva    := FXMLContent.GetAttributeBooleanByNodeIndex('DCEstoque', 'FlagAtiva', i);
    epEstoque.PrazoEntrega := FXMLContent.GetAttributeIntegerByNodeIndex('DCEstoque', 'PrazoEntrega', i);
    epEstoque.Codigo       := FXMLContent.GetAttributeStringByNodeIndex('DCEstoque', 'Codigo', i);

    Result.Add(epEstoque);
  end;

end;

end.
