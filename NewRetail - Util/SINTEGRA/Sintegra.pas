{===============================================================================
Projeto Sintegra
****************

Biblioteca de Componente para geração do arquivo Sintegra
Site: http://www.sultan.welter.pro.br

Direitos Autorais Reservados (c) 2004 Régys Borges da Silveira

Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la sob
os termos da Licença Pública Geral Menor do GNU conforme publicada pela Free
Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) qualquer
versão posterior.

Esta biblioteca é distribuído na expectativa de que seja útil, porém, SEM
NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU
ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor do
GNU para mais detalhes.

Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto com
esta biblioteca; se não, escreva para a Free Software Foundation, Inc., no
endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.
================================================================================
Contato:
          Autor...: Régys Borges da Silveira
          Email...: regyssilveira@hotmail.com
================================================================================
Colaboração:
          Marcelo Welter <marcelo@welter.pro.br>
===============================================================================}

unit Sintegra;

interface

uses
  SysUtils, Controls, Classes, Windows, Forms;

type
  ESintegraException = class(Exception);

  TEventoErro = procedure(aErro: string) of object;

  TCodIdentificaOper = (opeInterestaduais, opeInterestSubTributaria, opeTotal);
  TCodFinalidade = (finNormal, finRetificacaoTotal, finRetificacaoAditiva, finDesfazimento);
  TModDocumento = (modMaqRegistradora, modPDV, modECF);
  TSitNotaFiscal = (nfNormal, nfCancelado, nfExtNormal, nfExtCancelado);
  TTipoEmitente = (tpeProprio, tpeTerceiros);
  TTipoPosse = (tpo1, tpo2, tpo3);
  TModalidadeFrete = (frCIF, frFOB, frOUTRO);

  ISintegra_Reg70_unico = interface(IInterface)
    ['{96006577-18BD-4444-A582-B6E57E2A9CF2}']
    function GetBaseCalcICMS: Currency;
    function GetCFOP: string;
    function GetCNPJEmitente: string;
    function GetDataEmisao: TDate;
    function GetInscEstEmitente: string;
    function GetIsentaNTributada: Currency;
    function GetModelo: SmallInt;
    function GetModFrete: TModalidadeFrete;
    function GetNumero: Integer;
    function GetOutras: Currency;
    function GetSerie: string;
    function GetSituacao: TSitNotaFiscal;
    function GetSubSerie: string;
    function GetUF: string;
    function GetValorICMS: Currency;
    function GetValorTotal: Currency;
    procedure SetBaseCalcICMS(const Value: Currency);
    procedure SetCFOP(const Value: string);
    procedure SetCNPJEmitente(const Value: string);
    procedure SetDataEmisao(const Value: TDate);
    procedure SetInscEstEmitente(const Value: string);
    procedure SetIsentaNTributada(const Value: Currency);
    procedure SetModelo(const Value: SmallInt);
    procedure SetModFrete(const Value: TModalidadeFrete);
    procedure SetNumero(const Value: Integer);
    procedure SetOutras(const Value: Currency);
    procedure SetSerie(const Value: string);
    procedure SetSituacao(const Value: TSitNotaFiscal);
    procedure SetSubSerie(const Value: string);
    procedure SetUF(const Value: string);
    procedure SetValorICMS(const Value: Currency);
    procedure SetValorTotal(const Value: Currency);
    property CNPJEmitente: string read GetCNPJEmitente write SetCNPJEmitente;
    property InscEstEmitente: string read GetInscEstEmitente write SetInscEstEmitente;
    property DataEmisao: TDate read GetDataEmisao write SetDataEmisao;
    property UF: string read GetUF write SetUF;
    property Modelo: SmallInt read GetModelo write SetModelo;
    property Serie: string read GetSerie write SetSerie;
    property SubSerie: string read GetSubSerie write SetSubSerie;
    property Numero: Integer read GetNumero write SetNumero;
    property CFOP: string read GetCFOP write SetCFOP;
    property ValorTotal: Currency read GetValorTotal write SetValorTotal;
    property BaseCalcICMS: Currency read GetBaseCalcICMS write SetBaseCalcICMS;
    property ValorICMS: Currency read GetValorICMS write SetValorICMS;
    property IsentaNTributada: Currency read GetIsentaNTributada write SetIsentaNTributada;
    property Outras: Currency read GetOutras write SetOutras;
    property ModFrete: TModalidadeFrete read GetModFrete write SetModFrete;
    property Situacao: TSitNotaFiscal read GetSituacao write SetSituacao;
  end;

  ISintegra_Reg70_Lista = interface(IInterface)
    ['{943AEAD3-C1D8-4C14-B03D-414830F8A93C}']
    function GetItem(Index: Integer): ISintegra_Reg70_unico;
    procedure SetItem(Index: Integer; const Value: ISintegra_Reg70_unico);
    function Add: ISintegra_Reg70_unico;
    procedure Delete(Index: integer);
    function Count: Integer;
    procedure Clear;
    property Items[Index: Integer]: ISintegra_Reg70_unico read GetItem write SetItem;
  end;

  ISintegra_Reg71_unico = interface(IInterface)
    ['{96006577-18BD-4444-A582-B6E57E2A9CF2}']
    function GetCNPJRemetDest: string;
    function GetCNPJTomador: string;
    function GetDataEmissao: TDate;
    function GetInscEstRemetDest: string;
    function GetInscEstTomador: string;
    function GetModelo: SmallInt;
    function GetNFDataEmissao: TDate;
    function GetNFModelo: SmallInt;
    function GetNFNumero: Integer;
    function GetNFSerie: string;
    function GetNFValorTotal: Currency;
    function GetNumero: Integer;
    function GetSerie: string;
    function GetSubSerie: string;
    function GetUFRemetDest: string;
    function GetUFTomador: string;
    procedure SetCNPJRemetDest(const Value: string);
    procedure SetCNPJTomador(const Value: string);
    procedure SetDataEmissao(const Value: TDate);
    procedure SetInscEstRemetDest(const Value: string);
    procedure SetInscEstTomador(const Value: string);
    procedure SetModelo(const Value: SmallInt);
    procedure SetNFDataEmissao(const Value: TDate);
    procedure SetNFModelo(const Value: SmallInt);
    procedure SetNFNumero(const Value: Integer);
    procedure SetNFSerie(const Value: string);
    procedure SetNFValorTotal(const Value: Currency);
    procedure SetNumero(const Value: Integer);
    procedure SetSerie(const Value: string);
    procedure SetSubSerie(const Value: string);
    procedure SetUFRemetDest(const Value: string);
    procedure SetUFTomador(const Value: string);
    property DataEmissao: TDate read GetDataEmissao write SetDataEmissao;
    property Modelo: SmallInt read GetModelo write SetModelo;
    property Serie: string read GetSerie write SetSerie;
    property SubSerie: string read GetSubSerie write SetSubSerie;
    property Numero: Integer read GetNumero write SetNumero;
    property CNPJTomador: string read GetCNPJTomador write SetCNPJTomador;
    property InscEstTomador: string read GetInscEstTomador write SetInscEstTomador;
    property UFTomador: string read GetUFTomador write SetUFTomador;
    property CNPJRemetDest: string read GetCNPJRemetDest write SetCNPJRemetDest;
    property InscEstRemetDest: string read GetInscEstRemetDest write SetInscEstRemetDest;
    property UFRemetDest: string read GetUFRemetDest write SetUFRemetDest;
    property NFDataEmissao: TDate read GetNFDataEmissao write SetNFDataEmissao;
    property NFModelo: SmallInt read GetNFModelo write SetNFModelo;
    property NFSerie: string read GetNFSerie write SetNFSerie;
    property NFNumero: Integer read GetNFNumero write SetNFNumero;
    property NFValorTotal: Currency read GetNFValorTotal write SetNFValorTotal;
  end;

  ISintegra_Reg71_Lista = interface(IInterface)
    ['{943AEAD3-C1D8-4C14-B03D-414830F8A93C}']
    function GetItem(Index: Integer): ISintegra_Reg71_unico;
    procedure SetItem(Index: Integer; const Value: ISintegra_Reg71_unico);
    function Add: ISintegra_Reg71_unico;
    procedure Delete(Index: integer);
    function Count: Integer;
    procedure Clear;
    property Items[Index: Integer]: ISintegra_Reg71_unico read GetItem write SetItem;
  end;

  ISintegra_Reg74_Unico = interface(IInterface)
    ['{A9FD144C-BE79-4E13-A1E9-CB99D2626E4D}']
    function GetCNPJ: string;
    function GetCodPRoduto: string;
    function GetDataInventario: TDate;
    function GetInscEstadual: string;
    function GetQuantidade: Extended;
    function GetTipoPosse: TTipoPosse;
    function GetUF: string;
    function GetValorTotal: Currency;
    procedure SetCNPJ(const Valor: string);
    procedure SetCodPRoduto(const Valor: string);
    procedure SetDataInventario(const Valor: TDate);
    procedure SetInscEstadual(const Valor: string);
    procedure SetQuantidade(const Valor: Extended);
    procedure SetTipoPosse(const Valor: TTipoPosse);
    procedure SetUF(const Valor: string);
    procedure SetValorTotal(const Valor: Currency);
    property TipoPosse: TTipoPosse read GetTipoPosse write SetTipoPosse;
    property CNPJ: string read GetCNPJ write SetCNPJ;
    property InscEstadual: string read GetInscEstadual write SetInscEstadual;
    property UF: string read GetUF write SetUF;
    property DataInventario: TDate read GetDataInventario write SetDataInventario;
    property CodPRoduto: string read GetCodPRoduto write SetCodPRoduto;
    property Quantidade: Extended read GetQuantidade write SetQuantidade;
    property ValorTotal: Currency read GetValorTotal write SetValorTotal;
  end;

  ISintegra_Reg74_Lista = interface(IInterface)
    ['{CD2F0EE7-C5BE-41E2-A9FB-E8839E9260CF}']
    function GetItem(Index: Integer): ISintegra_Reg74_unico;
    procedure SetItem(Index: Integer; const Value: ISintegra_Reg74_unico);
    function Add: ISintegra_Reg74_unico;
    procedure Delete(Index: integer);
    function Count: Integer;
    procedure Clear;
    property Items[Index: Integer]: ISintegra_Reg74_unico read GetItem write SetItem;
  end;

  ISintegra_Reg75_unico = interface(IInterface)
    ['{86306321-1EE9-442D-8585-D9B5B9187572}']
    function GetAliquotaICMS: Currency;
    function GetAliquotaIPI: Currency;
    function GetBaseICMSST: Currency;
    function GetCodNCM: string;
    function GetCodProduto: string;
    function GetDescricaoProd: string;
    function GetReducaoBaseCalc: Currency;
    function GetUnidade: string;
    function GetValidadeFinal: TDate;
    function GetValidadeInicial: TDate;
    procedure SetAliquotaICMS(const Valor: Currency);
    procedure SetAliquotaIPI(const Valor: Currency);
    procedure SetBaseICMSST(const Valor: Currency);
    procedure SetCodNCM(const Valor: string);
    procedure SetCodProduto(const Valor: string);
    procedure SetDescricaoProd(const Valor: string);
    procedure SetReducaoBaseCalc(const Valor: Currency);
    procedure SetUnidade(const Valor: string);
    procedure SetValidadeFinal(const Valor: TDate);
    procedure SetValidadeInicial(const Valor: TDate);
    property ValidadeInicial: TDate read GetValidadeInicial write SetValidadeInicial;
    property ValidadeFinal: TDate read GetValidadeFinal write SetValidadeFinal;
    property CodProduto: string read GetCodProduto write SetCodProduto;
    property CodNCM: string read GetCodNCM write SetCodNCM;
    property DescricaoProd: string read GetDescricaoProd write SetDescricaoProd;
    property Unidade: string read GetUnidade write SetUnidade;
    property AliquotaIPI: Currency read GetAliquotaIPI write SetAliquotaIPI;
    property AliquotaICMS: Currency read GetAliquotaICMS write SetAliquotaICMS;
    property ReducaoBaseCalc: Currency read GetReducaoBaseCalc write SetReducaoBaseCalc;
    property BaseICMSST: Currency read GetBaseICMSST write SetBaseICMSST;
  end;

  ISintegra_Reg75_Lista = interface(IInterface)
    ['{7621A167-AB53-4CF2-8AB3-E538F4648E60}']
    function GetItem(Index: Integer): ISintegra_Reg75_unico;
    procedure SetItem(Index: Integer; const Value: ISintegra_Reg75_unico);
    function Add: ISintegra_Reg75_unico;
    procedure Delete(Index: integer);
    function Count: Integer;
    procedure Clear;
    property Items[Index: Integer]: ISintegra_Reg75_unico read GetItem write SetItem;
  end;

  ISintegra_Reg60R_unico = interface(IInterface)
    ['{A846B50C-E2A0-4B4A-887C-E30CD6DE0B46}']
    function GetAno: SmallInt;
    function GetCodProduto: string;
    function GetMes: SmallInt;
    function GetQuantidade: Extended;
    function GetSitTributaria: string;
    function GetValorAcumICMS: Currency;
    function GetValorAcumProduto: Currency;
    procedure SetAno(const Valor: SmallInt);
    procedure SetCodProduto(const Valor: string);
    procedure SetMes(const Valor: SmallInt);
    procedure SetQuantidade(const Valor: Extended);
    procedure SetSitTributaria(const Valor: string);
    procedure SetValorAcumICMS(const Valor: Currency);
    procedure SetValorAcumProduto(const Valor: Currency);
    property Mes: SmallInt read GetMes write SetMes;
    property ANo: SmallInt read GetAno write SetAno;
    property CodProduto: string read GetCodProduto write SetCodProduto;
    property Quantidade: Extended read GetQuantidade write SetQuantidade;
    property ValorAcumProduto: Currency read GetValorAcumProduto write SetValorAcumProduto;
    property ValorAcumICMS: Currency read GetValorAcumICMS write SetValorAcumICMS;
    property SitTributaria: string read GetSitTributaria write SetSitTributaria;
  end;

  ISintegra_Reg60R_Lista = interface(IInterface)
    ['{4AF3F1E1-F645-45EF-8A23-5F0437E93C58}']
    function GetItem(Index: Integer): ISintegra_Reg60R_unico;
    procedure SetItem(Index: Integer; const Value: ISintegra_Reg60R_unico);
    function Add: ISintegra_Reg60R_unico;
    procedure Delete(Index: integer);
    function Count: Integer;
    procedure Clear;
    property Items[Index: Integer]: ISintegra_Reg60R_unico read GetItem write SetItem;
  end;

  ISintegra_Reg60A_unico = interface(IInterface)
    ['{EDEFBBD5-CFD3-45E4-BB64-9FCB0A500330}']
    function GetSitTributaria: string;
    procedure SetSitTributaria(const Valor: string);
    function GetValorAcumulado: Currency;
    procedure SetValorAcumulado(const Valor: Currency);
    property SitTributaria: string read GetSitTributaria write SetSitTributaria;
    property ValorAcumulado: Currency read GetValorAcumulado write SetValorAcumulado;
  end;

  ISintegra_Reg60A_Lista = interface(IInterface)
    ['{C6B68871-908B-4CD7-BF4C-1AA16BA2CD71}']
    function GetItem(Index: Integer): ISintegra_Reg60A_unico;
    procedure SetItem(Index: Integer; const Value: ISintegra_Reg60A_unico);
    function Total: Currency;
    function Add: ISintegra_Reg60A_unico;
    procedure Delete(Index: integer);
    function Count: Integer;
    procedure Clear;
    property Items[Index: Integer]: ISintegra_Reg60A_unico read GetItem write SetItem;
  end;

  ISintegra_Reg60M_unico = interface(IInterface)
    ['{1EA59280-823F-4149-81DA-5992AD482562}']
    function GetDataEmissao: TDate;
    procedure SetDataEmissao(const Valor: TDate);
    function GetNumSerieEquip: string;
    procedure SetNumSerieEquip(const Valor: string);
    function GetNumSequencial: Integer;
    procedure SetNumSequencial(const Valor: Integer);
    function GetModDocFiscal: TModDocumento;
    procedure SetModDocFiscal(const Valor: TModDocumento);
    function GetCOOInicial: Integer;
    procedure SetCOOInicial(const Valor: Integer);
    function GetCOOFinal: Integer;
    procedure SetCOOFinal(const Valor: Integer);
    function GetContReducaoZ: Integer;
    procedure SetContReducaoZ(const Valor: Integer);
    function GetContReinicioOper: Integer;
    procedure SetContReinicioOper(const Valor: Integer);
    function GetVendaBruta: Currency;
    procedure SetVendaBruta(const Valor: Currency);
    function GetGTFinal: Currency;
    procedure SetGTFinal(const Valor: Currency);
    function GetAliquotas: ISintegra_Reg60A_Lista;
    procedure SetAliquotas(const Valor: ISintegra_Reg60A_Lista);
    property DataEmissao: TDate read GetDataEmissao write SetDataEmissao;
    property NumSerieEquip: string read GetNumSerieEquip write SetNumSerieEquip;
    property NumSequencial: Integer read GetNumSequencial write SetNumSequencial;
    property ModDocFiscal: TModDocumento read GetModDocFiscal write SetModDocFiscal;
    property COOInicial: Integer read GetCOOInicial write SetCOOInicial;
    property COOFinal: Integer read GetCOOFinal write SetCOOFinal;
    property ContReducaoZ: Integer read GetContReducaoZ write SetContReducaoZ;
    property ContReinicioOper: Integer read GetContReinicioOper write SetContReinicioOper;
    property VendaBruta: Currency read GetVendaBruta write SetVendaBruta;
    property GTFinal: Currency read GetGTFinal write SetGTFinal;
    property Registro60A: ISintegra_Reg60A_Lista read GetAliquotas write SetAliquotas;
  end;

  ISintegra_Reg60M_Lista = interface(IInterface)
    ['{5497071C-DC2B-4E69-90FB-354C041EB46F}']
    function GetItem(Index: Integer): ISintegra_Reg60M_unico;
    procedure SetItem(Index: Integer; const Value: ISintegra_Reg60M_unico);
    function Add: ISintegra_Reg60M_unico;
    procedure Delete(Index: integer);
    function Count: Integer;
    procedure Clear;
    property Items[Index: Integer]: ISintegra_Reg60M_unico read GetItem write SetItem;
  end;

  TSintegraObject = class(TPersistent, IInterface)
  private
    fContador: Integer;
    fOwner: TObject;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(aOwner: TObject);
    property Owner: TObject read fOwner;
  end;

  TSintegraEmpresa = class(TSintegraObject)
  private
    FempRazaoSocial: string[35];
    FempCNPJ: string[14];
    FempInscEstadual: string[14];
    FempMunicipio: string[30];
    FempUF: string[2];
    FempFax: string[10];
    FempResponsavel: string[28];
    FempEndereco: string[34];
    FempComplemento: string[22];
    FempNumero: 0..99999;
    FempBairro: string[15];
    FempCEP: string[8];
    FempFone: string[12];
    FContribuinteIPI: Boolean;
    FSubstitutoTributario: Boolean;
    function GetempRazaoSocial: string;
    procedure SetempRazaoSocial(const Valor: string);
    function GetempCNPJ: string;
    procedure SetempCNPJ(const Valor: string);
    function GetempInscEstadual: string;
    procedure SetempInscEstadual(const Valor: string);
    function GetempMunicipio: string;
    procedure SetempMunicipio(const Valor: string);
    function GetempUF: string;
    procedure SetempUF(const Valor: string);
    function GetempFax: string;
    procedure SetempFax(const Valor: string);
    function GetempResponsavel: string;
    procedure SetempResponsavel(const Valor: string);
    function GetempEndereco: string;
    procedure SetempEndereco(const Valor: string);
    function GetempComplemento: string;
    procedure SetempComplemento(const Valor: string);
    function GetempNumero: Integer;
    procedure SetempNumero(const Valor: Integer);
    function GetempBairro: string;
    procedure SetempBairro(const Valor: string);
    function GetempCEP: string;
    procedure SetempCEP(const Valor: string);
    function GetempFone: string;
    procedure SetempFone(const Valor: string);
    function GetempContribuinteIPI: Boolean;
    procedure SetempContribuinteIPI(const Valor: Boolean);
    function GetempSubstitutoTributario: Boolean;
    procedure SetempSubstitutoTributario(const Valor: Boolean);
  published
    property RazaoSocial: string read GetempRazaoSocial write SetempRazaoSocial;
    property CNPJ: string read GetempCNPJ write SetempCNPJ;
    property InscEstadual: string read GetempInscEstadual write SetempInscEstadual;
    property Endereco: string read GetempEndereco write SetempEndereco;
    property Complemento: string read GetempComplemento write SetempComplemento;
    property Numero: Integer read GetempNumero write SetempNumero default 0;
    property Bairro: string read GetempBairro write SetempBairro;
    property Municipio: string read GetempMunicipio write SetempMunicipio;
    property CEP: string read GetempCEP write SetempCEP;
    property UF: string read GetempUF write SetempUF;
    property Fax: string read GetempFax write SetempFax;
    property Fone: string read GetempFone write SetempFone;
    property Responsavel: string read GetempResponsavel write SetempResponsavel;
    property ContribuinteIPI: Boolean read GetempContribuinteIPI write SetempContribuinteIPI default False;
    property SubstitutoTributario: Boolean read GetempSubstitutoTributario write SetempSubstitutoTributario default False;
  end;

  TSintegra = class(TComponent)
  private
    FValidacaoOK: Boolean;
    FOnErro: TEventoErro;
    fDataInicial: TDate;
    fDataFinal: TDate;
    fNaturezaOperacao: TCodIdentificaOper;
    fFinalidade: TCodFinalidade;
    fEmpresa: TSintegraEmpresa;
    fRegistro60: ISintegra_Reg60M_Lista;
    fRegistro60R: ISintegra_Reg60R_Lista;
    function GetDataInicial: TDate;
    procedure SetDataInicial(const Valor: TDate);
    function GetDataFinal: TDate;
    procedure SetDataFinal(const Valor: TDate);
    function GetNaturezaOperacao: TCodIdentificaOper;
    procedure SetNaturezaOperacao(const Valor: TCodIdentificaOper);
    function GetFinalidade: TCodFinalidade;
    procedure SetFinalidade(const Valor: TCodFinalidade);
    function GetEmpresa: TSintegraEmpresa;
    procedure SetEmpresa(const Valor: TSintegraEmpresa);
    function GetRegistro60: ISintegra_Reg60M_Lista;
    procedure SetRegistro60(const Valor: ISintegra_Reg60M_Lista);
    function GetResumoMensal60: ISintegra_Reg60R_Lista;
    procedure SetResumoMensal60(const Valor: ISintegra_Reg60R_Lista);
    function GerarCabecalho: String;
    function GerarRegistro60: String;
    function GerarRegistro90: String;
    function VerificarProdutoCorrespondente(aProduto: string): Boolean;
    function ProcurarProduto(aProduto: string): Boolean;
    function GetOnErro: TEventoErro;
    procedure SetOnErro(const Value: TEventoErro);
    procedure GerarErro(aErro: string);
  public
    constructor Create(AOwner: TComponent); override;
    procedure LimparRegistros;
    function GerarArquivo(aArquivo: string; aConfirma: Boolean = True): Boolean;
  published
    property OnErro: TEventoErro read GetOnErro write SetOnErro;
    property DataInicial: TDate read GetDataInicial write SetDataInicial;
    property DataFinal: TDate read GetDataFinal write SetDataFinal;
    property NaturezaOperacao: TCodIdentificaOper read GetNaturezaOperacao write SetNaturezaOperacao default opeTotal;
    property Finalidade: TCodFinalidade read GetFinalidade write SetFinalidade default finNormal;
    property Empresa: TSintegraEmpresa read GetEmpresa write SetEmpresa;
    property Registro60: ISintegra_Reg60M_Lista read GetRegistro60 write SetRegistro60;
    property Registro60R: ISintegra_Reg60R_Lista read GetResumoMensal60 write SetResumoMensal60;
  end;

procedure Register;

implementation

uses Registro60, Funcoes;

procedure Register;
begin
  RegisterComponents('Sintegra', [TSintegra]);
end;

{ TSintegraObject }

function TSintegraObject._AddRef: Integer;
begin
  Inc(fContador);
  Result := fContador;
end;

function TSintegraObject._Release: Integer;
begin
  Dec(fContador);
  Result := fContador;
end;

constructor TSintegraObject.Create(aOwner: TObject);
begin
  fContador := 0;
  fOwner := aOwner;
end;

function TSintegraObject.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

{ TSintegraEmpresa }

function TSintegraEmpresa.GetempRazaoSocial: string;
begin
  Result := FempRazaoSocial;
end;

procedure TSintegraEmpresa.SetempRazaoSocial(const Valor: string);
begin
  FempRazaoSocial := Valor;
end;

function TSintegraEmpresa.GetempCNPJ: string;
begin
  Result := FempCNPJ;
end;

procedure TSintegraEmpresa.SetempCNPJ(const Valor: string);
begin
  FempCNPJ := Valor;
end;

function TSintegraEmpresa.GetempInscEstadual: string;
begin
  Result := FempInscEstadual;
end;

procedure TSintegraEmpresa.SetempInscEstadual(const Valor: string);
begin
  FempInscEstadual := Valor;
end;

function TSintegraEmpresa.GetempMunicipio: string;
begin
  Result := FempMunicipio;
end;

procedure TSintegraEmpresa.SetempMunicipio(const Valor: string);
begin
  FempMunicipio := Valor;
end;

function TSintegraEmpresa.GetempUF: string;
begin
  Result := FempUF;
end;

procedure TSintegraEmpresa.SetempUF(const Valor: string);
begin
  FempUF := UpperCase(Valor);
end;

function TSintegraEmpresa.GetempFax: string;
begin
  Result := FempFax;
end;

procedure TSintegraEmpresa.SetempFax(const Valor: string);
begin
  FempFax := Valor;
end;

function TSintegraEmpresa.GetempResponsavel: string;
begin
  Result := FempResponsavel;
end;

procedure TSintegraEmpresa.SetempResponsavel(const Valor: string);
begin
  FempResponsavel := Valor;
end;

function TSintegraEmpresa.GetempEndereco: string;
begin
  Result := FempEndereco;
end;

procedure TSintegraEmpresa.SetempEndereco(const Valor: string);
begin
  FempEndereco := Valor;
end;

function TSintegraEmpresa.GetempComplemento: string;
begin
  Result := FempComplemento;
end;

procedure TSintegraEmpresa.SetempComplemento(const Valor: string);
begin
  FempComplemento := Valor;
end;

function TSintegraEmpresa.GetempNumero: Integer;
begin
  Result := FempNumero;
end;

procedure TSintegraEmpresa.SetempNumero(const Valor: Integer);
begin
  FempNumero := Valor;
end;

function TSintegraEmpresa.GetempBairro: string;
begin
  Result := FempBairro;
end;

procedure TSintegraEmpresa.SetempBairro(const Valor: string);
begin
  FempBairro := Valor;
end;

function TSintegraEmpresa.GetempCEP: string;
begin
  Result := FempCEP;
end;

procedure TSintegraEmpresa.SetempCEP(const Valor: string);
begin
  FempCEP := Valor;
end;

function TSintegraEmpresa.GetempFone: string;
begin
  Result := FempFone;
end;

procedure TSintegraEmpresa.SetempFone(const Valor: string);
begin
  FempFone := Valor;
end;

function TSintegraEmpresa.GetempContribuinteIPI: Boolean;
begin
  Result := FContribuinteIPI;
end;

procedure TSintegraEmpresa.SetempContribuinteIPI(const Valor: Boolean);
begin
  FContribuinteIPI := Valor
end;

function TSintegraEmpresa.GetempSubstitutoTributario: Boolean;
begin
  Result := FSubstitutoTributario
end;

procedure TSintegraEmpresa.SetempSubstitutoTributario(const Valor: Boolean);
begin
  FSubstitutoTributario := Valor;
end;

{ TSintegra }

constructor TSintegra.Create;
begin
  inherited;
  FValidacaoOK := True;

  fDataInicial := 0;
  fDataFinal := 0;

  fEmpresa := TSintegraEmpresa.Create(Self);
  fRegistro60 := TSintegraReg60M_Lista.Create(Self);
  fRegistro60R := TSintegraReg60R_Lista.Create(Self);
end;

function TSintegra.GetDataInicial: TDate;
begin
  Result := fDataInicial;
end;

procedure TSintegra.SetDataInicial(const Valor: TDate);
begin
  fDataInicial := Valor;
end;

function TSintegra.GetDataFinal: TDate;
begin
  Result := fDataFinal;
end;

procedure TSintegra.SetDataFinal(const Valor: TDate);
begin
  fDataFinal := Valor;
end;

function TSintegra.GetNaturezaOperacao: TCodIdentificaOper;
begin
  Result := fNaturezaOperacao;
end;

procedure TSintegra.SetNaturezaOperacao(const Valor: TCodIdentificaOper);
begin
  fNaturezaOperacao := Valor;
end;

function TSintegra.GetFinalidade: TCodFinalidade;
begin
  Result := fFinalidade;
end;

procedure TSintegra.SetFinalidade(const Valor: TCodFinalidade);
begin
  fFinalidade := Valor;
end;

function TSintegra.GetEmpresa: TSintegraEmpresa;
begin
  Result := fEmpresa;
end;

procedure TSintegra.SetEmpresa(const Valor: TSintegraEmpresa);
begin
  fEmpresa := Valor;
end;

function TSintegra.GetRegistro60: ISintegra_Reg60M_Lista;
begin
  Result := fRegistro60;
end;

procedure TSintegra.SetRegistro60(const Valor: ISintegra_Reg60M_Lista);
begin
  fRegistro60 := Valor;
end;

function TSintegra.GetResumoMensal60: ISintegra_Reg60R_Lista;
begin
  Result := fRegistro60R;
end;

procedure TSintegra.SetResumoMensal60(const Valor: ISintegra_Reg60R_Lista);
begin
  fRegistro60R := Valor;
end;

function TSintegra.ProcurarProduto(aProduto: string): Boolean;
var
  i: integer;
  Encontrado: Boolean;
begin
  {Verifica se o produto existe no Registro 75 }

  i := 0;
  Encontrado := False;

  {while (not Encontrado) and (i < Registro75.Count) do
  begin
    Encontrado := Registro75.Items[i].CodProduto = aProduto;
    inc(i, 1);
  end;}

  Result := Encontrado;
end;

function TSintegra.VerificarProdutoCorrespondente(aProduto: string): Boolean;
var
  i, a: Integer;
  Encontrado: Boolean;
begin
  {*****************************************************************************
     - O registro 75 deve ter algum correspondente nos registros
       54, 60D, 60I, 60R, 74, 77
  *****************************************************************************}

  Encontrado := False;

  if Assigned(Registro60) and (not Encontrado) then
  begin
    i := 0;

    while (not Encontrado) and (i < Registro60.Count) do
    begin
      { Registro 60D }

     { if Assigned(Registro60.Items[i].Registro60D) then
      begin
        a := 0;

        while (not Encontrado) and (a < Registro60.Items[i].Registro60D.Count) do
        begin
          Encontrado := Registro60.Items[i].Registro60D.Items[a].CodProduto = aProduto;
          inc(a);
        end;
      end;  }

      inc(i);
    end;
  end;

  { Registro 60R }

  if Assigned(Registro60R) and (not Encontrado) then
  begin
    i := 0;

    while (not Encontrado) and (i < Registro60R.Count) do
    begin
      Encontrado := Registro60R.Items[i].CodProduto = aProduto;
      inc(i);
    end;
  end;

  Result := Encontrado;
end;

function TSintegra.GetOnErro: TEventoErro;
begin
  Result := FOnErro;
end;

procedure TSintegra.SetOnErro(const Value: TEventoErro);
begin
  FOnErro := Value;
end;

procedure TSintegra.LimparRegistros;
begin
  Registro60.Clear;
  Registro60R.Clear;
end;

{ Cabecalho do arquivo referente aos dados da empresa }

function TSintegra.GerarCabecalho: string;
var
  aComplemento: string;
  Ano, Mes, Dia: Word;
begin
  if DataInicial = 0 then
    GerarErro('Geração: Informe a Data Inicial do arquivo');

  if Datafinal = 0 then
    GerarErro('Geração: Informe a Data final do arquivo');

  DecodeDate(DataInicial, Ano, Mes, Dia);

  if Ano < 1993 then
    GerarErro('Geração: O ano da data inicial do arquivo deve ser superior a 1993');

  if DataFinal > Date then
    GerarErro('Registro 10: Data final não pode ser maior que a Data atual');

  if Dia <> 1 then
    GerarErro('Registro 10: Data inicial deve corresponder ao primeiro dia do mês informado!');

  if Trim(Empresa.RazaoSocial) = '' then
    GerarErro('Registro 10: Não informado: Razão Social');

  if Trim(Empresa.Municipio) = '' then
    GerarErro('Registro 10: Não informado: Municipio');

  if Trim(Empresa.UF) = '' then
    GerarErro('Registro 10: Não informado: Estado (UF)');

  if Trim(Empresa.CNPJ) = '' then
    GerarErro('Registro 10: Não informado: CNPJ/CPF');

  if Trim(Empresa.InscEstadual) = '' then
    GerarErro('Registro 10: Não informado: Inscrição Estadual');

  if not (VerificarUF(Empresa.UF)) then
    GerarErro(Format('Registro 10: UF "%s" digitado inválido', [Empresa.UF]))
  else if not VerificarInscEstadual(Empresa.InscEstadual, Empresa.UF) then
    GerarErro('Registro 10: Inscrição Estadual informada inválida');

  if Empresa.Fone = '' then
    GerarErro('Registro 11: Não informado: Telefone para contado');

  if Empresa.CEP <> '' then
    if not (VerificarCEP(Empresa.CEP, Empresa.UF)) then
      GerarErro('Registro 11: CEP Informado não é válido');

  if (Trim(Empresa.Complemento) = '') and (Empresa.Numero = 0) then
    aComplemento := 'SEM NUMERO';

  Result :=
    '10' +
    LFill(Empresa.CNPJ, '0', 14) +
    RFill(Empresa.InscEstadual, ' ', 14) +
    RFill(Empresa.RazaoSocial, ' ', 35) +
    RFill(Empresa.Municipio, ' ', 30) +
    Empresa.UF +
    LFill(Empresa.Fax, '0', 10) +
    FormatDateTime('YYYYMMDD', DataInicial) +
    FormatDateTime('YYYYMMDD', DataFinal) +
    '3' +
    RetornarNatureza(NaturezaOperacao) +
    RetornarFinalidade(Finalidade) + #13#10 +
    '11' +
    RFill(Empresa.Endereco, ' ', 34) +
    LFill(FloatToStr(Empresa.Numero), '0', 5) +
    RFill(aComplemento, ' ', 22) +
    RFill(Empresa.Bairro, ' ', 15) +
    LFill(Empresa.CEP, '0', 8) +
    RFill(Empresa.Responsavel, ' ', 28) +
    LFill(Empresa.Fone, '0', 12);
end;

{ registro do fim do arquivo }

function TSintegra.GerarRegistro90: string;
var
  i, ToTReg, TotReg60: Integer;

  Inicio, Linha: string;

  fLista: TStringList;

  procedure VerificaLinha;
  begin
    if Length(Linha) = 90 then
      Linha := Linha + #13#10;
  end;
begin
  {*****************************************************************************
    *  A quantidade de registros 90 deve ser informada usando as 6 ultimas
       posicoes do registro alinhado a direita Ex: '     1';

    *  Podem ser usados 9 contadores por registro 90 sendo 2 posicoes
       para o codigo do registro ex: 50, 54, etc e 8 posicoes para a quantidade
       de registros;

    *  o contador 99 deve informar a quantidade total incluindo
       os registros 10, 11, e 90 e deve ser informado somente no
       ultimo registro 90 caso haja mais de um registro 90;
  *****************************************************************************}

  flista := TStringList.Create;
  ToTReg := 3;
  TotReg60 := 0;

   Inicio := '90' +
    LFill(Empresa.CNPJ, '0', 14) +
    RFill(Empresa.InscEstadual, ' ', 14);

  // total de registros 60
  if (Assigned(Registro60)) and (Registro60.Count > 0) then
  begin
    TotReg60 := Registro60.Count;

    if Assigned(Registro60R) and (Registro60R.Count > 0) then
      TotReg60 := TotReg60 + Registro60R.Count;

    for i := 0 to Registro60.Count - 1 do
    begin
      if Assigned(Registro60.Items[i].Registro60A) then
        TotReg60 := TotReg60 + Registro60.Items[i].Registro60A.Count;

     { if Assigned(Registro60.Items[i].Registro60D) then
        TotReg60 := TotReg60 + Registro60.Items[i].Registro60D.Count;

      if Assigned(Registro60.Items[i].Registro60I) then
        TotReg60 := TotReg60 + Registro60.Items[i].Registro60I.Count; }
    end;
  end;

  TotReg := TotReg + TotReg60;

  if TotReg60 > 0 then
  begin
    Linha := Linha + FormatFloat('"60"00000000', TotReg60);
    VerificaLinha;
  end;

  Linha := Linha + FormatFloat('"99"00000000', ToTReg);

  fLista.Add(Linha);

  Linha := '';
  for i := 0 to fLista.Count - 1 do
  begin
    if Length(fLista.Strings[i]) = 90 then
    begin
      Linha := Linha + Inicio +
        fLista.Strings[i] +
        FormatFloat('000000', fLista.Count) + #13#10;
    end
    else
    begin
      Linha := Linha + Inicio +
        RFill(fLista.Strings[i], ' ', 90) +
        FormatFloat('000000', fLista.Count);
    end;
  end;

  fLista.Free;

  Result := Trim(Linha);
end;


function TSintegra.GerarRegistro60: string;
var
  aRegistro: TStringList;
  iReg60, a: Integer;
  dDataResumo: TDate;
begin
  aRegistro := TStringList.Create;

  for iReg60 := 0 to Registro60.Count - 1 do
  begin
    // Verifica se o valor informado no 60M e difrente da soma dos 60A
    // ***Retirado***
    //if Registro60.Items[iReg60].VendaBruta <> Registro60.Items[iReg60].Registro60A.Total then
    //  GerarErro('Registro 60A: Valor acumulado difere da somas das aliquotas informadas!');

    // Verifica se o valor informado no 60M e difrente da soma dos 60D
    // Somente quando for gerar o resumo diario 60D
    {if Registro60.Items[iReg60].Registro60D.Count > 0 then
      if Registro60.Items[iReg60].VendaBruta <> Registro60.Items[iReg60].Registro60D.TotalAcumulado then
        GerarErro('Registro60D: Valor acumulado difere da somas dos resumos informados!'); }

    aRegistro.Add('60M' +
      FormatDateTime('yyyymmdd', Registro60.Items[iReg60].DataEmissao) +
      RFill(Registro60.Items[iReg60].NumSerieEquip, ' ', 20) +
      FormatFloat('000', Registro60.Items[iReg60].NumSequencial) +
      RetornarModDocumento(Registro60.Items[iReg60].ModDocFiscal) +
      FormatFloat('000000', Registro60.Items[iReg60].COOInicial) +
      FormatFloat('000000', Registro60.Items[iReg60].COOFinal) +
      FormatFloat('000000', Registro60.Items[iReg60].ContReducaoZ) +
      FormatFloat('000', Registro60.Items[iReg60].ContReinicioOper) +
      LFill(FormatFloat('#0', Trunc(Registro60.Items[iReg60].VendaBruta * 100)), '0', 16) +
      LFill(FormatFloat('#0', Trunc(Registro60.Items[iReg60].GTFinal * 100)), '0', 16) +
      StringOfChar(' ', 37)
      );

    // obrigatorio quando se gera o registro 60M
    for a := 0 to Registro60.Items[iReg60].Registro60A.Count - 1 do
    begin
      aRegistro.Add('60A' +
        FormatDateTime('yyyymmdd', Registro60.Items[iReg60].DataEmissao) +
        RFill(Registro60.Items[iReg60].NumSerieEquip, ' ', 20) +
        RFill(Registro60.Items[iReg60].Registro60A.Items[a].SitTributaria, ' ', 4) +
        LFill(FormatFloat('#0', Trunc(Registro60.Items[iReg60].Registro60A.Items[a].ValorAcumulado * 100)), '0', 12) +
        StringOfChar(' ', 79)
        );
    end;

  end;

  // Registro 60R Opcional (depende de legislacao da UF)
  if (Assigned(Registro60R)) and (Registro60R.Count > 0) then
  begin
    {if (not (Assigned(Registro75))) or (Registro75.Count = 0) then
      GerarErro('Registro 75: Nenhum registro 75 foi assinalado!');  }

    for a := 0 to Registro60R.Count - 1 do
    begin
      dDataResumo := StrToDate('01/' + IntTosTr(Registro60R.Items[a].Mes) + '/' + IntTosTr(Registro60R.Items[a].Ano));

      if (dDataResumo < DataInicial) or (dDataResumo > DataFinal) then
        GerarErro(Format('Registro 60R: Mês/Ano "%s" fora do período informado "%s à %s"!', [FormatDateTime('mm/yyyy', dDataResumo), DateToStr(DataInicial), DateToStr(DataFinal)]));

      // Verifica se o produto esta cadastrado no registro 75
      // ***Retirado***
      //if not (ProcurarProduto(Registro60R.Items[a].CodProduto)) then
       // GerarErro(Format('Registro 60R: Produto "%s" não assinalado no registro 75!', [Registro60R.Items[a].CodProduto]));

      aRegistro.Add('60R' +
        FormatFloat('00', Registro60R.Items[a].Mes) +
        FormatFloat('0000', Registro60R.Items[a].ANo) +
        RFill(Registro60R.Items[a].CodProduto, ' ', 14) +
        LFill(FormatFloat('#0', Trunc(Registro60R.Items[a].Quantidade * 1000)), '0', 13) +
        LFill(FormatFloat('#0', Trunc(Registro60R.Items[a].ValorAcumProduto * 100)), '0', 16) +
        LFill(FormatFloat('#0', Trunc(Registro60R.Items[a].ValorAcumICMS * 100)), '0', 16) +
        RFill(Registro60R.Items[a].SitTributaria, ' ', 4) +
        StringOfChar(' ', 54)
        );
    end;
  end;

  Result := aRegistro.Text;

  Result := Copy(Result, 0, Length(Result) - 2);

  FreeAndNil(aRegistro);
end;

procedure TSintegra.GerarErro(aErro: string);
begin
  FOnErro(aErro);
  FValidacaoOK := False;
end;

function TSintegra.GerarArquivo(aArquivo: string; aConfirma: Boolean = True): Boolean;
var
  Arquivo: TStringList;
  sLinha: String;
begin
  FValidacaoOK := True;

  { Verifica se o nome do arquivo foi passado }
  if Trim(aArquivo) = '' then
    raise ESintegraException.Create('Informe o nome do arquivo a ser gerado!');

  { Criacao do arquivo }
  try
    Arquivo := TStringList.Create;

    Arquivo.Add(GerarCabecalho);

    sLinha := GerarRegistro60;
    if Trim(sLinha) <> '' then
      Arquivo.Add(sLinha);

    { Geração do Fim do arquivo }
    Arquivo.Add(GerarRegistro90);

    if (Arquivo.Count > 0) and (FValidacaoOK) then
      Arquivo.SaveToFile(aArquivo);

    Result := FValidacaoOK;

    FreeAndNil(Arquivo);
  except
    on E: Exception do
    begin
      Result := False;
      Application.MessageBox(PAnsiChar(E.Message), 'Criação do arquivo', MB_ICONERROR + MB_OK);
    end;
  end;
end;

end.

