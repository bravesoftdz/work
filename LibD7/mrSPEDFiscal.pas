unit mrSPEDFiscal;

interface

uses
  Windows, SysUtils, Classes, StrUtils, XMLDoc, XMLIntf, ComCtrls, DbClient,
  Dialogs;

const
  ARQUIVO_SPEDFISCAL_TXT                             = 'SPEDFISCAL';
  ARQUIVO_CONTRIBUINTE_ST_XML                        = 'ARQUIVO_CONTRIBUINTE_ST.XML';
  ARQUIVO_PARTICIPANTE_XML                           = 'ARQUIVO_PARTICIPANTE.XML';
  ARQUIVO_UNIDADE_MEDIDA_XML                         = 'ARQUIVO_UNIDADE_MEDIDA.XML';
  ARQUIVO_ITEM_XML                                   = 'ARQUIVO_ITEM.XML';
  ARQUIVO_TOTAL_INVENTARIO_XML                       = 'ARQUIVO_TOTAL_INVENTARIO.XML';
  ARQUIVO_INVENTARIO_XML                             = 'ARQUIVO_INVENTARIO.XML';
  ARQUIVO_NF_CONSUMIDOR_300_XML                      = 'ARQUIVO_NF_CONSUMIDOR_300.XML';
  ARQUIVO_NF_CONSUMIDOR_320_XML                      = 'ARQUIVO_NF_CONSUMIDOR_320.XML';
  ARQUIVO_NF_CONSUMIDOR_350_XML                      = 'ARQUIVO_NF_CONSUMIDOR_350.XML';
  ARQUIVO_NF_VENDA_CUPOM_XML                         = 'ARQUIVO_NF_VENDA_CUPOM.XML';
  ARQUIVO_ITEM_NF_CONSUMIDOR_320_XML                 = 'ARQUIVO_ITEM_NF_CONSUMIDOR_320.XML';
  ARQUIVO_ITEM_NF_CONSUMIDOR_350_XML                 = 'ARQUIVO_ITEM_NF_CONSUMIDOR_350.XML';
  ARQUIVO_ITEM_NF_VENDA_CUPOM_XML                    = 'ARQUIVO_ITEM_NF_VENDA_CUPOM.XML';
  ARQUIVO_ITEM_NF_CONSUMIDOR_E_CUPOM_XML             = 'ARQUIVO_ITEM_NF_CONSUMIDOR_E_CUPOM.XML';
  REGISTRO_C100_COMPRA_XML                           = 'REGISTRO_C100_COMPRA.XML';
  REGISTRO_C100_VENDA_XML                            = 'REGISTRO_C100_VENDA.XML';
  REGISTRO_C170_COMPRA_XML                           = 'REGISTRO_C170_COMPRA.XML';
  REGISTRO_C170_VENDA_XML                            = 'REGISTRO_C170_VENDA.XML';
  REGISTRO_C190_COMPRA_XML                           = 'REGISTRO_C190_COMPRA.XML';
  REGISTRO_C190_VENDA_XML                            = 'REGISTRO_C190_VENDA.XML';
  REGISTRO_C400_EQUIP_ECF_XML                        = 'REGISTRO_C400_EQUIP_ECF.XML';
  REGISTRO_C405_REDUCAO_Z_XML                        = 'REGISTRO_C405_REDUCAO_Z.XML';
  REGISTRO_C420_TOTALIZADORES_PARCIAIS_REDUCAO_Z_XML = 'REGISTRO_C420_TOTALIZADORES_PARCIAIS_REDUCAO_Z.XML';
  REGISTRO_C425_RESUMO_ITENS_MOVDIARIO_XML           = 'REGISTRO_C425_RESUMO_ITENS_MOVDIARIO.XML';
  REGISTRO_C490_ANALITICO_MOVDIARIO_XML              = 'REGISTRO_C490_ANALITICO_MOVDIARIO.XML';
type
  TTipoNF = (tNFVenda, tNFConsumidor, tNFVendaCupom, tNFCompra);


  TTotalRecordEvent = procedure(ATotalRecord: Integer) of object;
  TStepItRecordEvent = procedure(ADescription : String; ARecordPos: Integer) of object;

  TTotalizadorRegistro = Record
    Registro: String;
    Total: Integer;
  end;

  TmrSPEDFiscalUsuario = class(TPersistent)
  private
    FInscricaoEstadual: String;
    FInscricaoMunicipal: String;
    FCNPJ: String;
    FRazaoSocial: String;
    FSUFRAMA: String;
    FTipoAtividade: String;
    FPerfil: String;
    FCodigoMunicipioIBGE: String;
    FUF: String;
    FEndComplemento: String;
    FCEP: String;
    FNomeFantasia: String;
    FEndLogradouro: String;
    FEndNumero: String;
    FEmail: String;
    FFone: String;
    FFax: String;
    FBairro: String;
    FCodigoContaContabil: String;
  published
    property NomeFantasia: String read FNomeFantasia write FNomeFantasia;
    property RazaoSocial: String read FRazaoSocial write FRazaoSocial;
    property CNPJ: String read FCNPJ write FCNPJ;
    property InscricaoMunicipal: String read FInscricaoMunicipal write FInscricaoMunicipal;
    property InscricaoEstadual: String read FInscricaoEstadual write FInscricaoEstadual;
    property SUFRAMA: String read FSUFRAMA write FSUFRAMA;
    property EndLogradouro: String read FEndLogradouro write FEndLogradouro;
    property EndNumero: String read FEndNumero write FEndNumero;
    property EndComplemento: String read FEndComplemento write FEndComplemento;
    property Bairro: String read FBairro write FBairro;
    property CEP: String read FCEP write FCEP;
    property CodigoMunicipioIBGE: String read FCodigoMunicipioIBGE write FCodigoMunicipioIBGE;
    property UF: String read FUF write FUF;
    property Fone: String read FFone write FFone;
    property Fax: String read FFax write FFax;
    property Email: String read FEmail write FEmail;
    property Perfil: String read FPerfil write FPerfil;
    property TipoAtividade: String read FTipoAtividade write FTipoAtividade;
    property CodigoContaContabil: String read FCodigoContaContabil write FCodigoContaContabil;
  end;

  TmrSPEDFiscalContabilista = class(TPersistent)
  private
    FCEP: String;
    FEndNumero: String;
    FCPF: String;
    FEndLogradouro: String;
    FNome: String;
    FEndComplemento: String;
    FCRC: String;
    FCNPJ: String;
    FCodigoMunicipioIBGE: String;
    FFone: String;
    FFax: String;
    FBairro: String;
    FEmail: String;
  published
    property Nome: String read FNome write FNome;
    property CPF: String read FCPF write FCPF;
    property CRC: String read FCRC write FCRC;
    property CNPJ: String read FCNPJ write FCNPJ;
    property EndLogradouro: String read FEndLogradouro write FEndLogradouro;
    property EndNumero: String read FEndNumero write FEndNumero;
    property EndComplemento: String read FEndComplemento write FEndComplemento;
    property Bairro: String read FBairro write FBairro;
    property CEP: String read FCEP write FCEP;
    property CodigoMunicipioIBGE: String read FCodigoMunicipioIBGE write FCodigoMunicipioIBGE;
    property Fone: String read FFone write FFone;
    property Fax: String read FFax write FFax;
    property Email: String read FEmail write FEmail;
  end;

  TmrSPEDFiscal = class(TComponent)
  private
    FSPEDFile : TStringList;
    FArquivo: TextFile;
    FCaminhoArquivos: String;
    FVersaoLayout: String;
    FDataInicial: TDateTime;
    FDataFinal: TDateTime;
    FFinalidadeRemessa: Integer;
    FSPEDFiscalUsuario: TmrSPEDFiscalUsuario;
    FSPEDFiscalContabilista: TmrSPEDFiscalContabilista;
    FTotalLinhaBloco0: Integer;
    FTotalLinhaBlocoC: Integer;
    FTotalLinhaBlocoD: Integer;
    FTotalLinhaBlocoE: Integer;
    FTotalLinhaBlocoH: Integer;
    FTotalLinhaBloco1: Integer;
    FTotalLinhaBloco9: Integer;
    FTotalizadorRegistros: array of TTotalizadorRegistro;
    FValorTotalEstoque: Currency;
    FBaseICMS: Currency;
    FValorICMS: Currency;
    FXMLContribuinteST: TXMLDocument;
    FXMLParticipante: TXMLDocument;
    FXMLUnidadeMedida: TXMLDocument;
    FXMLItem: TXMLDocument;
    FXMLInventario: TXMLDocument;
    FXMLTotalInventario: TXMLDocument;
    FXMLNFVendaCupom: TXMLDocument;
    FXMLNFConsumidor300: TXMLDocument;
    FXMLNFConsumidor320: TXMLDocument;
    FXMLNFConsumidor350: TXMLDocument;
    FXMLItemNFVendaCupom: TXMLDocument;
    FXMLItemNFConsumidor320: TXMLDocument;
    FXMLItemNFConsumidor350: TXMLDocument;
    FXMLItemNFConsumidorCupom: TXMLDocument;
    FXMLC170Venda: TXMLDocument;
    FXMLC170Compra: TXMLDocument;
    FXMLC190Compra: TXMLDocument;
    FXMLC190Venda: TXMLDocument;
    FXMLC100Compra: TXMLDocument;
    FXMLC100Venda: TXMLDocument;
    FXMLC400EquipECF : TXMLDocument;
    FXMLC405ReducaoZ: TXMLDocument;
    FXMLC420TotalizadoresParcReducaoZ: TXMLDocument;
    FXMLC425ResumoItensMovDiario: TXMLDocument;
    FXMLC490RegistroAnaliticoMovDiario: TXMLDocument;
    FCounter: integer;
    FProgressBar: TProgressBar;

    cdsParticipante:                    TClientDataSet;
    cdsUnidadeMedida:                   TClientDataSet;
    cdsItem:                            TClientDataSet;
    cdsTotalInventario:                 TClientDataSet;
    cdsInventario:                      TClientDataSet;
    cdsNFConsumidor300:                 TClientDataSet;
    cdsNFConsumidor320:                 TClientDataSet;
    cdsConsumidor350:                   TClientDataSet;
    cdsNFVendaCupom:                    TClientDataSet;
    cdsItemNFConsumidor320:             TClientDataSet;
    cdsItemNFConsumidor350:             TClientDataSet;
    cdsItemNFVendaCupom:                TClientDataSet;
    cdsItemNFConsumidorCupom:           TClientDataSet;
    cdsC100Compra:                      TClientDataSet;
    cdsC100Venda:                       TClientDataSet;
    cdsC400EquipECF:                    TClientDataSet;
    cdsC405ReducaoZ:                    TClientDataSet;
    cdsC420TotalizadoresParcReducaoZ:   TClientDataSet;
    cdsC425ResumoItensMovDiario:        TClientDataSet;
    cdsC490AnaliticoMovDiario:          TClientDataSet;
    cdsFilterCompra170:                 TClientDataSet;
    cdsFilterVenda170:                  TClientDataSet;
    cdsFilterCompra190:                 TClientDataSet;
    cdsFilterVenda190:                  TClientDataSet;

    FOnTotalRecordEvent:                TTotalRecordEvent;
    FOnStepItRecordEvent:               TStepItRecordEvent;

    function AlinharTexto(ATexto: String; ATamanho: Integer): String;
    function AlinharNumero(ANumero: String; ATamanho: Integer): String;
    function RemoverMascara(ATexto: String; AEspaco: Boolean = True): String;
    function FormatarData(AData: TDateTime): String;
    function FormatarDataXML(AData: String): String;
    function FormatarQuantidade(AQuantidade: Variant): String;
    function FormatarValor(AValor: Variant): String;
    function FormatarPercentual(APercentual: Variant): String;
    function ReturnNumber(text:String):String;

    procedure CalculaValoresICMS(ATipoNF: TTipoNF; ANumeroDocFiscal: String);

    //BLOCO 0: ABERTURA, IDENTIFICAÇÃO E REFERÊNCIAS
    function  GerarBloco0: Boolean;
    procedure GerarRegistro0000;
    procedure GerarRegistro0001;
    procedure GerarRegistro0005;
    procedure GerarRegistro0015;
    procedure GerarRegistro0100;
    procedure GerarRegistro0150;
    procedure GerarRegistro0190;
    procedure GerarRegistro0200;
    procedure GerarRegistro0990;

    //BLOCO C: DOCUMENTOS FISCAIS I - MERCADORIAS (ICMS/IPI)
    function  GerarBlocoC: Boolean;
    procedure GerarRegistroC001;
    procedure GerarRegistroC100;
    procedure GerarRegistroC110;
    procedure GerarRegistroC111;
    procedure GerarRegistroC112;
    procedure GerarRegistroC113;
    procedure GerarRegistroC114;
    procedure GerarRegistroC115;
    procedure GerarRegistroC120;
    procedure GerarRegistroC140;
    procedure GerarRegistroC141;
    procedure GerarRegistroC160;
    procedure GerarRegistroC165;
    procedure GerarRegistroC170(ATipoNF: TTipoNF; ANumeroDocFiscal: String);
    procedure GerarRegistroC171;
    procedure GerarRegistroC172;
    procedure GerarRegistroC173;
    procedure GerarRegistroC174;
    procedure GerarRegistroC175;
    procedure GerarRegistroC176;
    procedure GerarRegistroC177;
    procedure GerarRegistroC178;
    procedure GerarRegistroC179;
    procedure GerarRegistroC190(ATipoNF: TTipoNF; ANumeroDocFiscal: String; ARecordIndex: Integer);
    procedure GerarRegistroC195;
    procedure GerarRegistroC197;
    procedure GerarRegistroC300;
    procedure GerarRegistroC310;
    procedure GerarRegistroC320(ADataMovimento: String);
    procedure GerarRegistroC321(ADataMovimento, AAliqICMS: String);
    procedure GerarRegistroC350;
    procedure GerarRegistroC370(ANumeroDocFiscal: String);
    procedure GerarRegistroC390(ARecordIndex: Integer);
    procedure GerarRegistroC400;
//    procedure GerarRegistroC405(ANumeroSerie: String);
    procedure GerarRegistroC405;
    procedure GerarRegistroC410;
//    procedure GerarRegistroC420(ACodEquipECF: String);
    procedure GerarRegistroC420;
    procedure GerarRegistroC425;
    procedure GerarRegistroC460;
    procedure GerarRegistroC470;
    procedure GerarRegistroC490;
    procedure GerarRegistroC495;
    procedure GerarRegistroC500;
    procedure GerarRegistroC510;
    procedure GerarRegistroC590;
    procedure GerarRegistroC600;
    procedure GerarRegistroC601;
    procedure GerarRegistroC610;
    procedure GerarRegistroC690;
    procedure GerarRegistroC700;
    procedure GerarRegistroC790;
    procedure GerarRegistroC791;
    procedure GerarRegistroC990;

    //BLOCO D: DOCUMENTOS FISCAIS II - SERVIÇOS (ICMS).
    function GerarBlocoD: Boolean;
    procedure GerarRegistroD001;
    procedure GerarRegistroD100;
    procedure GerarRegistroD110;
    procedure GerarRegistroD120;
    procedure GerarRegistroD130;
    procedure GerarRegistroD140;
    procedure GerarRegistroD150;
    procedure GerarRegistroD160;
    procedure GerarRegistroD161;
    procedure GerarRegistroD162;
    procedure GerarRegistroD170;
    procedure GerarRegistroD180;
    procedure GerarRegistroD190;
    procedure GerarRegistroD300;
    procedure GerarRegistroD301;
    procedure GerarRegistroD310;
    procedure GerarRegistroD350;
    procedure GerarRegistroD355;
    procedure GerarRegistroD360;
    procedure GerarRegistroD365;
    procedure GerarRegistroD370;
    procedure GerarRegistroD390;
    procedure GerarRegistroD400;
    procedure GerarRegistroD410;
    procedure GerarRegistroD411;
    procedure GerarRegistroD420;
    procedure GerarRegistroD500;
    procedure GerarRegistroD510;
    procedure GerarRegistroD530;
    procedure GerarRegistroD590;
    procedure GerarRegistroD600;
    procedure GerarRegistroD610;
    procedure GerarRegistroD690;
    procedure GerarRegistroD695;
    procedure GerarRegistroD696;
    procedure GerarRegistroD697;
    procedure GerarRegistroD990;

    //BLOCO E: APURAÇÃO DO ICMS, ICMS-ST E DO IPI
    function GerarBlocoE: Boolean;
    procedure GerarRegistroE001;
    procedure GerarRegistroE100;
    procedure GerarRegistroE110;
    procedure GerarRegistroE116;
    procedure GerarRegistroE200;
    procedure GerarRegistroE210;
    procedure GerarRegistroE990;

    //BLOCO H: INVENTÁRIO FÍSICO
    function GerarBlocoH: Boolean;
    procedure GerarRegistroH001;
    procedure GerarRegistroH005;
    procedure GerarRegistroH010;
    procedure GerarRegistroH990;

    //BLOCO 1: OUTRAS INFORMAÇÕES
    function GerarBloco1: Boolean;
    procedure GerarRegistro1001;
    procedure GerarRegistro1100;
    procedure GerarRegistro1105;
    procedure GerarRegistro1110;
    procedure GerarRegistro1200;
    procedure GerarRegistro1210;
    procedure GerarRegistro1300;
    procedure GerarRegistro1310;
    procedure GerarRegistro1320;
    procedure GerarRegistro1350;
    procedure GerarRegistro1360;
    procedure GerarRegistro1370;
    procedure GerarRegistro1400;
    procedure GerarRegistro1500;
    procedure GerarRegistro1510;
    procedure GerarRegistro1600;
    procedure GerarRegistro1990;

    //BLOCO 9: CONTROLE E ENCERRAMENTO DO ARQUIVO DIGITAL
    function GerarBloco9: Boolean;
    procedure GerarRegistro9001;
    procedure GerarRegistro9900;
    procedure GerarRegistro9990;
    procedure GerarRegistro9999;
  protected
    { Protected declarations }
    VlTotCreditos_E110, VlTotDebitos_E110, VlObrigacaoRecolher, VlTotalAputacao : Currency;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function Init: Boolean;
    function GerarArquivoEFD: Boolean;
  published
    property CaminhoArquivos: String read FCaminhoArquivos write FCaminhoArquivos;
    property VersaoLayout: String read FVersaoLayout write FVersaoLayout;
    property FinalidadeRemessa: Integer read FFinalidadeRemessa write FFinalidadeRemessa;
    property DataInicial: TDateTime read FDataInicial write FDataInicial;
    property DataFinal: TDateTime read FDataFinal write FDataFinal;
    property ValorTotalEstoque: Currency read FValorTotalEstoque write FValorTotalEstoque;

    property SPEDFiscalUsuario: TmrSPEDFiscalUsuario read FSPEDFiscalUsuario write FSPEDFiscalUsuario;
    property SPEDFiscalContabilista: TmrSPEDFiscalContabilista read FSPEDFiscalContabilista write FSPEDFiscalContabilista;

    property XMLContribuinteST: TXMLDocument read FXMLContribuinteST write FXMLContribuinteST;
    property XMLParticipante: TXMLDocument read FXMLParticipante write FXMLParticipante;
    property XMLUnidadeMedida: TXMLDocument read FXMLUnidadeMedida write FXMLUnidadeMedida;
    property XMLItem: TXMLDocument read FXMLItem write FXMLItem;
    property XMLTotalInventario: TXMLDocument read FXMLTotalInventario write FXMLTotalInventario;
    property XMLInventario: TXMLDocument read FXMLInventario write FXMLInventario;
    property XMLNFConsumidor300: TXMLDocument read FXMLNFConsumidor300 write FXMLNFConsumidor300;
    property XMLNFConsumidor320: TXMLDocument read FXMLNFConsumidor320 write FXMLNFConsumidor320;
    property XMLNFConsumidor350: TXMLDocument read FXMLNFConsumidor350 write FXMLNFConsumidor350;
    property XMLNFVendaCupom: TXMLDocument read FXMLNFVendaCupom write FXMLNFVendaCupom;
    property XMLItemNFConsumidor320: TXMLDocument read FXMLItemNFConsumidor320 write FXMLItemNFConsumidor320;
    property XMLItemNFConsumidor350: TXMLDocument read FXMLItemNFConsumidor350 write FXMLItemNFConsumidor350;
    property XMLItemNFVendaCupom: TXMLDocument read FXMLItemNFVendaCupom write FXMLItemNFVendaCupom;
    property XMLItemNFConsumidorCupom: TXMLDocument read FXMLItemNFConsumidorCupom write FXMLItemNFConsumidorCupom;

    property XMLC100Compra: TXMLDocument read FXMLC100Compra write FXMLC100Compra;
    property XMLC100Venda: TXMLDocument read FXMLC100Venda write FXMLC100Venda;
    property XMLC170Compra: TXMLDocument read FXMLC170Compra write FXMLC170Compra;
    property XMLC170Venda: TXMLDocument read FXMLC170Venda write FXMLC170Venda;
    property XMLC190Compra: TXMLDocument read FXMLC190Compra write FXMLC190Compra;
    property XMLC190Venda: TXMLDocument read FXMLC190Venda write FXMLC190Venda;

    property XMLC400EquipECF: TXMLDocument read FXMLC400EquipECF write FXMLC400EquipECF;
    property XMLC405ReducaoZ: TXMLDocument read FXMLC405ReducaoZ write FXMLC405ReducaoZ;
    property XMLC420TotalizadoresParcReducaoZ: TXMLDocument read FXMLC420TotalizadoresParcReducaoZ write FXMLC420TotalizadoresParcReducaoZ;
    property XMLC425ResumoItensMovDiario: TXMLDocument read FXMLC425ResumoItensMovDiario write FXMLC425ResumoItensMovDiario;
    property XMLC490RegistroAnaliticoMovDiario: TXMLDocument read FXMLC490RegistroAnaliticoMovDiario write FXMLC490RegistroAnaliticoMovDiario;

    property ProgressBar: TProgressBar read FProgressBar write FProgressBar;
    property OnTotalRecordEvent: TTotalRecordEvent read FOnTotalRecordEvent write FOnTotalRecordEvent;
    property OnStepItRecordEvent: TStepItRecordEvent read FOnStepItRecordEvent write FOnStepItRecordEvent;
  end;

procedure Register;

implementation

uses Variants;

procedure Register;
begin
  RegisterComponents('MainRetail', [TmrSPEDFiscal]);
end;

{ TmrSPEDFiscal }

function TmrSPEDFiscal.AlinharNumero(ANumero: String; ATamanho: Integer): String;
begin
  Result := '00000000000000000000000000000000000000000000000000000' +
            '00000000000000000000000000000000000000000000000000000' +
            '00000000000000000000000000000000000000000000000000000' +
            '00000000000000000000000000000000000000000000000000000' + ANumero;
  Result := RightStr(Result, ATamanho) + '|';

  //Result := Copy(ANumero, 1, ATamanho) + '|';
end;

function TmrSPEDFiscal.AlinharTexto(ATexto: String; ATamanho: Integer): String;
begin
  //Result := ATexto + '                                                     ' +
  //                   '                                                     ' +
  //                   '                                                     ' +
  //                   '                                                     ';
  //Result := LeftStr(Result, ATamanho) + '|';

  Result := Copy(ATexto, 1, ATamanho) + '|';
end;

constructor TmrSPEDFiscal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FSPEDFiscalUsuario      := TmrSPEDFiscalUsuario.Create;
  FSPEDFiscalContabilista := TmrSPEDFiscalContabilista.Create;

  FXMLContribuinteST                 := TXMLDocument.Create(Self);
  FXMLParticipante                   := TXMLDocument.Create(Self);
  FXMLUnidadeMedida                  := TXMLDocument.Create(Self);
  FXMLItem                           := TXMLDocument.Create(Self);
  FXMLTotalInventario                := TXMLDocument.Create(Self);
  FXMLInventario                     := TXMLDocument.Create(Self);
  FXMLNFConsumidor300                := TXMLDocument.Create(Self);
  FXMLNFConsumidor320                := TXMLDocument.Create(Self);
  FXMLNFConsumidor350                := TXMLDocument.Create(Self);
  FXMLNFVendaCupom                   := TXMLDocument.Create(Self);
  FXMLItemNFConsumidor320            := TXMLDocument.Create(Self);
  FXMLItemNFConsumidor350            := TXMLDocument.Create(Self);
  FXMLItemNFVendaCupom               := TXMLDocument.Create(Self);
  FXMLItemNFConsumidorCupom          := TXMLDocument.Create(Self);

  FXMLC100Compra                     := TXMLDocument.Create(Self);
  FXMLC100Venda                      := TXMLDocument.Create(Self);
  FXMLC170Compra                     := TXMLDocument.Create(Self);
  FXMLC170Venda                      := TXMLDocument.Create(Self);
  FXMLC190Compra                     := TXMLDocument.Create(Self);
  FXMLC190Venda                      := TXMLDocument.Create(Self);

  FXMLC400EquipECF                   := TXMLDocument.Create(self);
  FXMLC405ReducaoZ                   := TXMLDocument.Create(self);
  FXMLC420TotalizadoresParcReducaoZ  := TXMLDocument.Create(self);
  FXMLC425ResumoItensMovDiario       := TXMLDocument.Create(self);
  FXMLC490RegistroAnaliticoMovDiario := TXMLDocument.Create(self);


  cdsParticipante                    := TClientDataSet.Create(self);
  cdsUnidadeMedida                   := TClientDataSet.Create(self);
  cdsItem                            := TClientDataSet.Create(self);
  cdsTotalInventario                 := TClientDataSet.Create(self);
  cdsInventario                      := TClientDataSet.Create(self);
  cdsNFConsumidor300                 := TClientDataSet.Create(self);
  cdsNFConsumidor320                 := TClientDataSet.Create(self);
  cdsConsumidor350                   := TClientDataSet.Create(self);
  cdsNFVendaCupom                    := TClientDataSet.Create(self);
  cdsItemNFConsumidor320             := TClientDataSet.Create(self);
  cdsItemNFConsumidor350             := TClientDataSet.Create(self);
  cdsItemNFVendaCupom                := TClientDataSet.Create(self);
  cdsItemNFConsumidorCupom           := TClientDataSet.Create(self);

  cdsC100Compra                      := TClientDataSet.Create(self);
  cdsC100Venda                       := TClientDataSet.Create(self);
  cdsC400EquipECF                    := TClientDataSet.Create(self);
  cdsC405ReducaoZ                    := TClientDataSet.Create(self);
  cdsC420TotalizadoresParcReducaoZ   := TClientDataSet.Create(self);
  cdsC425ResumoItensMovDiario        := TClientDataSet.Create(self);
  cdsC490AnaliticoMovDiario          := TClientDataSet.Create(self);

  cdsFilterCompra170                 := TClientDataSet.Create(self);
  cdsFilterVenda170                  := TClientDataSet.Create(self);
  cdsFilterCompra190                 := TClientDataSet.Create(self);
  cdsFilterVenda190                  := TClientDataSet.Create(self);


  FProgressBar                       := TProgressBar.Create(nil);

  if FVersaoLayout = '' then
    FVersaoLayout := '002';

  if FCaminhoArquivos = '' then
    FCaminhoArquivos := 'C:\Program Files\MainRetail\SPED\';
end;

destructor TmrSPEDFiscal.Destroy;
begin
  FSPEDFiscalUsuario.Free;
  FSPEDFiscalContabilista.Free;

  FXMLContribuinteST.Free;
  FXMLParticipante.Free;
  FXMLUnidadeMedida.Free;
  FXMLItem.Free;
  FXMLTotalInventario.Free;
  FXMLInventario.Free;
  FXMLNFConsumidor300.Free;
  FXMLNFConsumidor320.Free;
  FXMLNFConsumidor350.Free;
  FXMLNFVendaCupom.Free;
  FXMLItemNFConsumidor320.Free;
  FXMLItemNFConsumidor350.Free;
  FXMLItemNFVendaCupom.Free;
  FXMLItemNFConsumidorCupom.Free;

  FXMLC100Compra.Free;
  FXMLC100Venda.Free;
  FXMLC170Compra.Free;
  FXMLC170Venda.Free;
  FXMLC190Compra.Free;
  FXMLC190Venda.Free;

  FXMLC400EquipECF.Free;
  FXMLC405ReducaoZ.Free;
  FXMLC420TotalizadoresParcReducaoZ.Free;
  FXMLC425ResumoItensMovDiario.Free;
  FXMLC490RegistroAnaliticoMovDiario.free;

  cdsParticipante.close;
  freeAndNil(cdsParticipante);

  cdsUnidadeMedida.Close;
  freeAndNil(cdsUnidadeMedida);

  cdsItem.Close;
  freeAndNil(cdsItem);

  cdsTotalInventario.Close;
  freeAndNil(cdsTotalInventario);

  cdsInventario.Close;
  freeAndNil(cdsInventario);

  cdsNFConsumidor300.Close;
  freeAndNil(cdsNFConsumidor300);

  cdsNFConsumidor320.Close;
  freeAndNil(cdsNFConsumidor320);

  cdsConsumidor350.Close;
  freeAndNil(cdsConsumidor350);

  cdsNFVendaCupom.Close;
  freeAndNil(cdsNFVendaCupom);

  cdsItemNFConsumidor320.Close;
  freeAndNil(cdsItemNFConsumidor320);

  cdsItemNFConsumidor350.Close;
  freeAndNil(cdsItemNFConsumidor350);

  cdsItemNFVendaCupom.Close;
  freeAndNil(cdsItemNFVendaCupom);

  cdsItemNFConsumidorCupom.Close;
  freeAndNil(cdsItemNFConsumidorCupom);

  cdsC100Compra.Close;
  freeAndNil(cdsC100Compra);

  cdsC100Venda.Close;
  freeAndNil(cdsC100Venda);

  cdsC400EquipECF.Close;
  freeAndNil(cdsC400EquipECF);

  cdsC405ReducaoZ.Close;
  freeAndNil(cdsC405ReducaoZ);

  cdsC420TotalizadoresParcReducaoZ.Close;
  freeAndNil(cdsC420TotalizadoresParcReducaoZ);

  cdsC490AnaliticoMovDiario.Close;
  freeAndNil(cdsC490AnaliticoMovDiario);

  cdsFilterCompra170.close;
  freeAndNil(cdsFilterCompra170);

  cdsFilterVenda170.Close;
  freeAndNil(cdsFilterVenda170);

  cdsFilterCompra190.Close;
  freeAndNil(cdsFilterCompra190);

  cdsFilterVenda190.Close;
  freeAndNil(cdsFilterVenda190);

  inherited Destroy;
end;

function TmrSPEDFiscal.FormatarData(AData: TDateTime): String;
var
  Year, Month, Day: Word;
  sYear, sMonth, sDay: String;
begin
  DecodeDate(AData, Year, Month, Day);
  sYear := IntToStr(Year);
  sMonth := IntToStr(Month);
  sDay := IntToStr(Day);

  if Length(sDay) = 1 then
    sDay := '0' + sDay;

  if Length(sMonth) = 1 then
    sMonth := '0' + sMonth;

  if Length(sYear) = 1 then
    sYear := '20' + sYear;

  Result := sDay + sMonth + sYear;
end;

function TmrSPEDFiscal.FormatarDataXML(AData: String): String;
begin
  Result := Copy(AData, 7, 2) + Copy(AData, 5, 2) + Copy(AData, 1, 4);
end;

function TmrSPEDFiscal.FormatarValor(AValor: Variant): String;
var
  cValor: Currency;
begin
  cValor := StrToCurr(StringReplace(AValor, '.', ',', [rfReplaceAll]));

  if cValor = 0 then
    Result := '0'
  else
    Result := FormatFloat('###0.00', Abs(cValor));
end;

function TmrSPEDFiscal.Init: Boolean;
begin
  try
    Result := true;
  except
    on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.RemoverMascara(ATexto: String; AEspaco: Boolean = True): String;
begin
  Result := ATexto;

  if AEspaco then
    Result := StringReplace(Result, ' ', '', [rfReplaceAll]);

  Result := StringReplace(Result, '.', '', [rfReplaceAll]);
  Result := StringReplace(Result, ',', '', [rfReplaceAll]);
  Result := StringReplace(Result, ':', '', [rfReplaceAll]);
  Result := StringReplace(Result, ';', '', [rfReplaceAll]);
  Result := StringReplace(Result, '-', '', [rfReplaceAll]);
  Result := StringReplace(Result, '\', '', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '', [rfReplaceAll]);
end;

procedure TmrSPEDFiscal.GerarRegistro0000;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0000';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(1);

  sLinha := '|0000|';
  sLinha := sLinha + AlinharTexto(FVersaoLayout, 3);
  sLinha := sLinha + AlinharTexto(IntToStr(FFinalidadeRemessa), 1);
  sLinha := sLinha + AlinharTexto(FormatarData(FDataInicial), 8);
  sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.RazaoSocial, 100);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.CNPJ, 14);
  sLinha := sLinha + AlinharTexto('', 11);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.UF, 2);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.InscricaoEstadual, 14);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.CodigoMunicipioIBGE, 7);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.InscricaoMunicipal, 14);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.SUFRAMA, 9);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.Perfil, 1);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.TipoAtividade, 1);

  Inc(FTotalLinhaBloco0);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);

  if Assigned(FOnStepItRecordEvent) then
     FOnStepItRecordEvent('registro 0000', 1);


  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro0001;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0001';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(1);

  sLinha := '|0001|';
  sLinha := sLinha + AlinharNumero('0', 1);

  Inc(FTotalLinhaBloco0);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);

  if Assigned(FOnStepItRecordEvent) then
     FOnStepItRecordEvent('registro 0001', 1);

  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro0005;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0005';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(1);


  sLinha := '|0005|';
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.NomeFantasia, 60);
  sLinha := sLinha + AlinharNumero(FSPEDFiscalUsuario.CEP, 8);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.EndLogradouro, 60);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.EndNumero, 10);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.EndComplemento, 30);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.Bairro, 60);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.Fone, 10);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.FInscricaoEstadual, 10);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.Email, 30);

  Inc(FTotalLinhaBloco0);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);

  if Assigned(FOnStepItRecordEvent) then
     FOnStepItRecordEvent('registro 0005', 1);


  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro0015;
var
  i: Integer;
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0015';

  FXMLContribuinteST.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(FXMLContribuinteST.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count);

  for i := 0 to Pred(FXMLContribuinteST.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := '|0015|';
    sLinha := sLinha + AlinharTexto(FXMLContribuinteST.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['UF'], 2);
    sLinha := sLinha + AlinharTexto(RemoverMascara(FXMLContribuinteST.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['InscricaoEstadual']), 14);

    Inc(FTotalLinhaBloco0);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro 0015', i);

  end;
end;

procedure TmrSPEDFiscal.GerarRegistro0100;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0100';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(1);


  sLinha := '|0100|';
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.Nome, 60);
  sLinha := sLinha + AlinharNumero(FSPEDFiscalContabilista.CPF, 11);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.CRC, 15);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.CNPJ, 14);
  sLinha := sLinha + AlinharNumero(FSPEDFiscalContabilista.CEP, 8);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.EndLogradouro, 60);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.EndNumero, 30);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.EndComplemento, 60);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.Bairro, 60);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.Fone, 10);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.Fax, 10);
  sLinha := sLinha + AlinharTexto(FSPEDFiscalContabilista.Email, 30);
  sLinha := sLinha + AlinharNumero(FSPEDFiscalContabilista.CodigoMunicipioIBGE, 7);

  Inc(FTotalLinhaBloco0);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);

  if Assigned(FOnStepItRecordEvent) then
     FOnStepItRecordEvent('registro 0100', 1);

  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro0150;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0150';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsParticipante.RecordCount);

  while ( not cdsParticipante.Eof ) do
  begin
    sLinha := '|0150|';
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('CodigoParticipante').Value, 60);
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('Nome').value, 100);
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('CodigoPais').value, 5);
    sLinha := sLinha + AlinharTexto(RemoverMascara(cdsParticipante.fieldByName('CNPJ').value), 14);
    sLinha := sLinha + AlinharTexto(RemoverMascara(cdsParticipante.fieldByName('CPF').value), 11);
    sLinha := sLinha + AlinharTexto(RemoverMascara(cdsParticipante.fieldByName('InscricaoEstadual').value), 14);
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('CodigoMunicipio').value, 7);
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('SUFRAMA').value, 9);
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('Endereco').value, 60);
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('EndNumero').value, 10);
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('EndComplemento').value, 60);
    sLinha := sLinha + AlinharTexto(cdsParticipante.fieldByName('Bairro').value, 60);

    Inc(FTotalLinhaBloco0);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro 0150', cdsParticipante.RecNo);

    cdsParticipante.Next;
  end;
  cdsParticipante.close;
end;

procedure TmrSPEDFiscal.GerarRegistro0190;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0190';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsUnidadeMedida.RecordCount);

  while ( not cdsUnidadeMedida.Eof ) do
  begin
    sLinha := '|0190|';
    sLinha := sLinha + AlinharTexto(cdsUnidadeMedida.fieldByName('CodigoUnidade').Value, 6);
    sLinha := sLinha + AlinharTexto(cdsUnidadeMedida.fieldByName('Unidade').Value, 60);

    Inc(FTotalLinhaBloco0);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

   if Assigned(FOnStepItRecordEvent) then
      FOnStepItRecordEvent('registro 0190', cdsUnidadeMedida.RecNo);

    cdsUnidadeMedida.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistro0200;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0200';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsItem.RecordCount);

  while ( not cdsItem.Eof ) do
  begin
    sLinha := '|0200|';
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('CodigoItem').value, 60);
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('Descricao').Value, 100);
    sLinha := sLinha + AlinharTexto(RemoverMascara(cdsItem.FieldByName('CodigoBarras').Value), 60);
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('CodigoAnteriorItem').Value, 60);
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('CodigoUnidade').Value, 6);
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('TipoItem').Value, 2);
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('CodigoNCM').Value, 8);
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('CodigoExNCM').Value, 3);
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('CodigoGenero').Value, 2);
    sLinha := sLinha + AlinharTexto(cdsItem.FieldByName('CodigoServico').Value, 4);
    sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsItem.FieldByName('AliqICMS').Value), 6);

    Inc(FTotalLinhaBloco0);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

   if Assigned(FOnStepItRecordEvent) then
      FOnStepItRecordEvent('registro 0200', cdsItem.RecNo);

    cdsItem.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistro0990;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '0990';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(1);

  sLinha := '|0990|';
  Inc(FTotalLinhaBloco0);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBloco0), 100000);

  if Assigned(FOnStepItRecordEvent) then
     FOnStepItRecordEvent('registro 0990', 1);

  //WriteLn(FArquivo, sLinha);

  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroC001;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C001';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(1);

  sLinha := '|C001|';
  sLinha := sLinha + AlinharNumero('0', 1);

  Inc(FTotalLinhaBlocoC);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);

  if Assigned(FOnStepItRecordEvent) then
     FOnStepItRecordEvent('registro C001', 1);

  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroC100;
var
  i: Integer;
  sLinha: String;
  dDateRefPS: TDateTime; // PS = Purchase/Sale
  sDateRefPS: String;
  wDateRefPSYear, wDateRefPSMonth, wDateRefPSDay: word;
  sDocFiscal: String;

begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C100';
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C170';
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C190';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsC100Compra.RecordCount);

  // NF Compra
  i := 0;
  while ( not cdsC100Compra.Eof ) do
  begin
    CalculaValoresICMS(tNFCompra, cdsC100Compra.FieldByName('NumeroDocFiscal').Value);

    sLinha := '|C100|';
    sLinha := sLinha + AlinharTexto('0', 1);
    sLinha := sLinha + AlinharTexto('1', 1);
    sLinha := sLinha + AlinharTexto(cdsC100Compra.FieldByName('CodigoParticipante').Value, 60);
    // TODO (pegar o código conforme o tipo de NF)
    sLinha := sLinha + AlinharTexto(cdsC100Compra.FieldByName('CodigoModelo').Value, 2);
    sLinha := sLinha + AlinharTexto(cdsC100Compra.FieldByName('CodigoSituacao').Value, 2);
    sLinha := sLinha + AlinharTexto(cdsC100Compra.FieldByName('SerieDocFiscal').Value, 30);
    sLinha := sLinha + AlinharTexto(ReturnNumber(cdsC100Compra.FieldByName('NumeroDocFiscal').Value), 9);

    sDocFiscal := cdsC100Compra.FieldByName('NumeroDocFiscal').Value;

    sLinha := sLinha + AlinharTexto(cdsC100Compra.FieldByName('ChaveNFe').Value, 4);

{    //I need to do emission date also.
    sDateRefPS :=   FormatarData(cdsC100Compra.FieldByName('DataEmissao').Value);

    wDateRefPSDay   := strToInt(copy(sDateRefPS, 1, 2));
    wDateRefPSMonth := strToInt(copy(sDateRefPS, 3, 2));
    wDateRefPSYear  := strToInt(copy(sDateRefPS, 5, 4));

    dDateRefPS := EncodeDate(wDateRefPSYear, wDateRefPSMonth, wDateRefPSDay);

    if ( dDateRefPS > FDataFinal ) then
       sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal -1), 8)
    else
       sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Compra.FieldByName('DataEmissao').Value), 8);

    sDateRefPS := FormatarData(cdsC100Compra.FieldByName('DataEntrada').Value);
    wDateRefPSDay   := strToInt(copy(sDateRefPS, 1, 2));
    wDateRefPSMonth := strToInt(copy(sDateRefPS, 3, 2));
    wDateRefPSYear  := strToInt(copy(sDateRefPS, 5, 4));

    dDateRefPS := EncodeDate(wDateRefPSYear, wDateRefPSMonth, wDateRefPSDay);

    if ( dDateRefPS > FDataFinal ) then
        sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8)
    else
        sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Compra.FieldByName('DataEntrada').Value), 8);
 }
    if ( cdsC100Compra.fieldByName('DataEmissao').value > FDataFinal )  then
        sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8)
    else
       sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Compra.FieldByName('DataEmissao').Value), 8);

    if ( cdsC100Compra.fieldByName('DataEntrada').value > FDataFinal ) then
        sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8)
    else
       sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Compra.FieldByName('DataEntrada').Value), 8);

//    sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Compra.FieldByName('DataEntrada').Value), 8);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorTotal').Value), 100);
    sLinha := sLinha + AlinharTexto(cdsC100Compra.FieldByName('IndicadorPagamento').Value, 1);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorDesconto').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('AbatimentoNaoTrib').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorMercServ').Value), 100);
    sLinha := sLinha + AlinharTexto(cdsC100Compra.FieldByName('IndicadorFrete').Value, 1);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorFrete').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorSeguro').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorOutrasDespesas').Value), 100);

    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorBaseICMS').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorICMS').Value), 100);

    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorBaseICMSST').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorICMSST').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorIPI').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorPIS').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorCOFINS').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorPISST').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Compra.FieldByName('ValorCOFINSST').Value), 100);

    Inc(FTotalLinhaBlocoC);
    Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-3].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    GerarRegistroC170(tNFCompra, cdsC100Compra.FieldByName('NumeroDocFiscal').Value);
    GerarRegistroC190(tNFCompra, cdsC100Compra.FieldByName('NumeroDocFiscal').Value, i);
    inc(i);

    if Assigned(FOnStepItRecordEvent) then
      FOnStepItRecordEvent('registro C100 compra', i);

    cdsC100Compra.Next;
  end;

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsC100Venda.RecordCount);

  // NF Venda
  i := 0;
  while ( not cdsC100Venda.Eof ) do
  begin
    sLinha := '|C100|';
    sLinha := sLinha + AlinharTexto('1', 1);
    sLinha := sLinha + AlinharTexto('0', 1);
    sLinha := sLinha + AlinharTexto(cdsC100Venda.FieldByName('CodigoParticipante').value, 60);
    // TODO (pegar o código conforme o tipo de NF)
    sLinha := sLinha + AlinharTexto(cdsC100Venda.FieldByName('CodigoModelo').Value, 2);
    sLinha := sLinha + AlinharTexto(cdsC100Venda.FieldByName('CodigoSituacao').value, 2);
    sLinha := sLinha + AlinharTexto(cdsC100Venda.FieldByName('SerieDocFiscal').value, 30);
    sLinha := sLinha + AlinharTexto(ReturnNumber(cdsC100Venda.FieldByName('NumeroDocFiscal').value), 9);
    sLinha := sLinha + AlinharTexto(cdsC100Venda.FieldByName('ChaveNFe').value, 4);

{    if ( not cdsC100Venda.FieldByName('DataSaida').isNull ) then
    begin
        sDateRefPS := FormatarData(cdsC100Venda.FieldByName('DataSaida').Value);
        wDateRefPSDay   := StrToInt(copy(sDateRefPS, 1, 2));
        wDateRefPSMonth := StrToInt(copy(sDateRefPS, 3, 2));
        wDateRefPSYear  := StrToInt(copy(sDateRefPS, 5, 4));

        dDateRefPS := encodedate(wDateRefPSYear, wDateRefPSMonth, wDateRefPSDay);

        if ( dDateRefPS > FDataFinal ) then
            sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8)
        else
            sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Venda.FieldByName('DataSaida').Value), 8);
    end
    else }

   if ( cdsC100Venda.FieldByName('DataEmissao').Value > FDataFinal ) then
      sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8)
   else
      sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Venda.FieldByName('DataEmissao').value), 8);

   if ( cdsC100Venda.FieldByName('DataSaida').Value > FDataFinal ) then
      sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8)
   else
      sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Venda.FieldByName('DataSaida').value), 8);

//    sLinha := sLinha + AlinharTexto(FormatarData(cdsC100Venda.FieldByName('DataSaida').Value), 8);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorTotal').value), 100);
    sLinha := sLinha + AlinharTexto(cdsC100Venda.FieldByName('IndicadorPagamento').value, 1);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorDesconto').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('AbatimentoNaoTrib').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorMercServ').Value), 100);
    sLinha := sLinha + AlinharTexto(cdsC100Venda.FieldByName('IndicadorFrete').value, 1);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorFrete').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorSeguro').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorOutrasDespesas').value), 100);

    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorBaseICMS').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorICMS').Value), 100);

    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorBaseICMSST').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorICMSST').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorIPI').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorPIS').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorCOFINS').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorPISST').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC100Venda.FieldByName('ValorCOFINSST').value), 100);

    Inc(FTotalLinhaBlocoC);
    Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-3].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    GerarRegistroC170(tNFVenda, cdsC100Venda.FieldByName('NumeroDocFiscal').value);
    GerarRegistroC190(tNFVenda, cdsC100Venda.FieldByName('NumeroDocFiscal').value, i);
    inc(i);

    if Assigned(FOnStepItRecordEvent) then
      FOnStepItRecordEvent('registro C100 venda', i);

    cdsC100Venda.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC110;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC111;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC112;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC113;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC114;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC115;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC120;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC140;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC141;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC160;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC165;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC170(ATipoNF: TTipoNF; ANumeroDocFiscal: String);
var
  iNumeroItem: Integer;
  sLinha: String;
begin
  iNumeroItem := 0;
  if ATipoNF = tNFCompra then
  begin
      // NF Compra
     FBaseICMS := 0;
     FValorICMS := 0;

     cdsFilterCompra170.Filtered := false;
     cdsFilterCompra170.Filter := 'NumeroDocFiscal = ' + quotedStr(AnumeroDocFiscal);
     cdsFilterCompra170.Filtered := true;

{    if Assigned(FOnTotalRecordEvent) then
       FOnTotalRecordEvent(cdsFilterCompra170.RecordCount);
  }
     while ( not cdsFilterCompra170.eof ) do
     begin
          Inc(iNumeroItem);
          sLinha := '|C170|';
          // TODO (pegar a sequencia do item na nota)
          sLinha := sLinha + AlinharTexto(IntToStr(iNumeroItem), 3);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoItem'], 60);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CodigoItem').Value, 60);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['DescComplItem'], 60);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('DescComplItem').Value, 60);
   //          sLinha := sLinha + AlinharTexto(FormatarQuantidade(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Quantidade']), 100);
          sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsFilterCompra170.fieldbyName('Quantidade').Value), 100);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoUnidade'], 6);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CodigoUnidade').Value, 6);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorTotal']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.fieldByName('ValorTotal').Value), 100);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorDesconto']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.fieldByName('ValorDesconto').Value), 100);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IndicadorMov'], 1);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('IndicadorMov').Value, 1);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoSituacaoTrib'], 3);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByname('CodigoSituacaoTrib').Value, 3);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CFOP'], 4);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CFOP').Value, 4);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoNatureza'], 10);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CodigoNatureza').Value, 10);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorBaseICMS']), 100);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('ValorBaseICMS').Value, 100);
   //          sLinha := sLinha + AlinharTexto(FormatarPercentual(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['AliqICMS']), 6);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterCompra170.fieldByName('AliqICMS').Value), 6);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorICMS']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.fieldByName('ValorICMS').Value), 100);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorBaseICMSST']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.fieldByName('ValorBaseICMSST').Value), 100);
   //          sLinha := sLinha + AlinharTexto(FormatarPercentual(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['AliqICMSST']), 6);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterCompra170.fieldByName('AliqICMSST').Value), 6);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorICMSSt']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.fieldByName('ValorICMSSt').Value), 100);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['IndicadorPeriodo'], 1);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.FieldByName('IndicadorPeriodo').Value, 1);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoSituacaoTribIPI'], 2);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CodigoSituacaoTribIPI').Value, 2);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoEnquadramentoIPI'], 3);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CodigoEnquadramentoIPI').Value, 3);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorBaseIPI']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.fieldByname('ValorBaseIPI').value), 100);
   //          sLinha := sLinha + AlinharTexto(FormatarPercentual(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['AliqIPI']), 6);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterCompra170.FieldByName('AliqIPI').value), 6);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorIPI']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.FieldByName('ValorIPI').value), 100);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoSituacaoTribPIS'], 2);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CodigoSituacaoTribPIS').value, 2);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorBasePIS']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.fieldByName('ValorBasePIS').value), 100);
   //          sLinha := sLinha + AlinharTexto(FormatarPercentual(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['AliqPISPerc']), 6);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterCompra170.fieldByName('AliqPISPerc').value), 6);
   //          sLinha := sLinha + AlinharTexto(FormatarQuantidade(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['QtdBasePIS']), 100);
          sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsFilterCompra170.FieldByName('QtdBasePIS').value), 100);
   //          sLinha := sLinha + AlinharTexto(FormatarPercentual(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['AliqPISVal']), 6);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterCompra170.FieldByName('AliqPISVal').value), 6);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorPIS']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.FieldByName('ValorPIS').value), 100);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoSituacaoTribCOFINS'], 2);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CodigoSituacaoTribCOFINS').value, 2);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorBaseCOFINS']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.FieldByName('ValorBaseCOFINS').value), 100);
   //          sLinha := sLinha + AlinharTexto(FormatarPercentual(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['AliqCOFINSPerc']), 6);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterCompra170.fieldByName('AliqCOFINSPerc').value), 6);
   //          sLinha := sLinha + AlinharTexto(FormatarQuantidade(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['QtdBaseCOFINS']), 3);
          sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsFilterCompra170.FieldByName('QtdBaseCOFINS').value), 3);
   //          sLinha := sLinha + AlinharTexto(FormatarPercentual(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['AliqCOFINSVal']), 6);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterCompra170.fieldByName('AliqCOFINSVal').value), 6);
   //          sLinha := sLinha + AlinharTexto(FormatarValor(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorCOFINS']), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra170.fieldByName('ValorCOFINS').value), 100);
   //          sLinha := sLinha + AlinharTexto(FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoContaContabil'], 60);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra170.fieldByName('CodigoContaContabil').Value, 60);
   //          FBaseICMS := FBaseICMS + FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorBaseICMS'];
          FBaseICMS := FBaseICMS + cdsFilterCompra170.fieldByName('ValorBaseICMS').value;
   //          FValorICMS := FValorICMS + FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorICMS'];
          FValorICMS := FValorICMS + cdsFilterCompra170.FieldByName('ValorICMS').value;

          Inc(FTotalLinhaBlocoC);
          Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-2].Total);
          //WriteLn(FArquivo, sLinha);
          FSPEDFile.Add(sLinha);
{
          if Assigned(FOnStepItRecordEvent) then
             FOnStepItRecordEvent('registro C170 compra', cdsFilterCompra170.RecNo);
}
          cdsFilterCompra170.Next;
     end;
     while ( not cdsFilterCompra170.Bof ) do
     begin
       cdsFilterCompra170.Delete;
       cdsFilterCompra170.Prior;
     end;
  end
  else if ATipoNF = tNFVenda then
  begin
      // NF Venda
      FBaseICMS := 0;
      FValorICMS := 0;

      cdsFilterVenda170.Filtered := false;
      cdsFilterVenda170.Filter := 'NumeroDocFiscal = ' + quotedStr(AnumeroDocFiscal);
      cdsFilterVenda170.Filtered := true;
{
      if Assigned(FOnTotalRecordEvent) then
         FOnTotalRecordEvent(cdsFilterVenda170.RecordCount);
}
      //      FXMLC170Venda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;
      //      for i := 0 to Pred(FXMLC170Venda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
      while ( not cdsFilterVenda170.Eof ) do
      begin
         Inc(iNumeroItem);
         sLinha := '|C170|';
         // TODO (pegar a sequencia do item na nota)
         sLinha := sLinha + AlinharTexto(IntToStr(iNumeroItem), 3);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('CodigoItem').Value, 60);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('DescComplItem').Value, 60);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('Quantidade').Value, 100);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.fieldByName('CodigoUnidade').value, 6);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorTotal').value), 100);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorDesconto').value), 100);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.fieldByName('IndicadorMov').value, 1);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.fieldByName('CodigoSituacaoTrib').value, 3);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('CFOP').value, 4);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByname('CodigoNatureza').value, 10);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.fieldByName('ValorBaseICMS').value), 100);
         sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterVenda170.fieldByName('AliqICMS').value), 6);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.fieldByName('ValorICMS').value), 100);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorBaseICMSST').value), 100);
         sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterVenda170.FieldByName('AliqICMSST').value), 6);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorICMSSt').value), 100);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('IndicadorPeriodo').value, 1);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('CodigoSituacaoTribIPI').value, 2);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('CodigoEnquadramentoIPI').value, 3);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorBaseIPI').value), 100);
         sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterVenda170.FieldByName('AliqIPI').value), 6);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorIPI').value), 100);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('CodigoSituacaoTribPIS').value, 2);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorBasePIS').value), 100);
         sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterVenda170.FieldByName('AliqPISPerc').value), 6);
         sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsFilterVenda170.FieldByName('QtdBasePIS').value), 100);
         sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterVenda170.FieldByName('AliqPISVal').value), 6);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorPIS').value), 100);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('CodigoSituacaoTribCOFINS').value, 2);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorBaseCOFINS').value), 100);
         sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterVenda170.FieldByName('AliqCOFINSPerc').value), 6);
         sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsFilterVenda170.FieldByName('QtdBaseCOFINS').value), 3);
         sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterVenda170.FieldByName('AliqCOFINSVal').value), 6);
         sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda170.FieldByName('ValorCOFINS').value), 100);
         sLinha := sLinha + AlinharTexto(cdsFilterVenda170.FieldByName('CodigoContaContabil').value, 60);

         FBaseICMS := FBaseICMS + cdsFilterVenda170.FieldByName('ValorBaseICMS').value;
         FValorICMS := FValorICMS + cdsFilterVenda170.FieldByName('ValorICMS').value;

         Inc(FTotalLinhaBlocoC);
         Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-2].Total);
         //WriteLn(FArquivo, sLinha);
         FSPEDFile.Add(sLinha);

{
         if Assigned(FOnStepItRecordEvent) then
           FOnStepItRecordEvent('registro C170 venda', cdsFilterVenda170.RecNo);
}
         cdsFilterVenda170.Next;
      end;

      while ( not cdsFilterVenda170.Bof ) do
      begin
        cdsFilterVenda170.Delete;
        cdsFilterVenda170.Prior;
      end;

  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC171;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC172;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC173;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC174;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC175;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC176;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC177;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC178;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC179;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC190(ATipoNF: TTipoNF; ANumeroDocFiscal: String; ARecordIndex: Integer);
var
  i: Integer;
  sLinha, sCFOP: String;
  iCodSituacao: Integer;

  cdsFilter: TClientDataSet;

begin
    if ATipoNF = tNFCompra then
    begin
      cdsFilterCompra190.Filtered := false;
      cdsFilterCompra190.Filter   := 'NumeroDocFiscal = ' + quotedStr(AnumeroDocFiscal);
      cdsFilterCompra190.Filtered := true;

{
      if Assigned(FOnTotalRecordEvent) then
         FOnTotalRecordEvent(cdsFilterCompra190.RecordCount);
 }
      while ( not cdsFilterCompra190.Eof ) do
      begin
          sLinha := '|C190|';
          sLinha := sLinha + AlinharTexto(cdsFilterCompra190.FieldByname('CodigoSituacaoTribICMS').value, 3);
          sLinha := sLinha + AlinharTexto(cdsFilterCompra190.FieldByname('CFOP').Value, 4);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterCompra190.FieldByname('AliqICMS').Value), 6);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra190.FieldByname('ValorTotal').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra190.FieldByname('ValorBaseICMS').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra190.FieldByname('ValorICMS').value), 100);

          sCFOP := cdsFilterCompra190.FieldByname('CFOP').value;
          if (sCFOP <> '1605') then
            VlTotCreditos_E110 := VlTotCreditos_E110 + StrToFloat(FormatarValor(cdsFilterCompra190.FieldByname('ValorICMS').Value));

          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra190.FieldByname('ValorBaseICMSST').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra190.FieldByname('ValorICMSST').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra190.FieldByname('AbatimentoNaoTrib').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterCompra190.FieldByname('ValorIPI').Value), 100);

          Inc(FTotalLinhaBlocoC);
          Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-1].Total);
          //WriteLn(FArquivo, sLinha);
          FSPEDFile.Add(sLinha);

         if Assigned(FOnStepItRecordEvent) then
           FOnStepItRecordEvent('registro C190 compra', cdsFilterCompra190.RecNo);

          cdsFilterCompra190.Next;
      end;

      while ( not cdsFilterCompra190.Bof ) do
      begin
        cdsFilterCompra190.Delete;
        cdsFilterCompra190.Prior;
      end;

    end
    else if ATipoNF = tNFVenda then
    begin
      cdsFilterVenda190.Filtered := false;
      cdsFilterVenda190.Filter := 'NumeroDocFiscal = ' + quotedStr(AnumeroDocFiscal);
      cdsFilterVenda190.Filtered := true;
{
      if Assigned(FOnTotalRecordEvent) then
         FOnTotalRecordEvent(cdsFilterVenda190.RecordCount);
 }
      while ( not cdsFilterVenda190.Eof ) do
      begin
          sLinha := '|C190|';
          sLinha := sLinha + AlinharTexto(cdsFilterVenda190.FieldByname('CodigoSituacaoTrib').Value, 3);
          sLinha := sLinha + AlinharTexto(cdsFilterVenda190.FieldByname('CFOP').Value, 4);
          sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsFilterVenda190.FieldByname('AliqICMS').Value), 6);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda190.FieldByname('ValorTotal').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda190.FieldByname('ValorBaseICMS').value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda190.FieldByname('ValorICMS').Value), 100);

          iCodSituacao := cdsFilterVenda190.FieldByname('CodigoSituacaoTrib').Value;
          sCFOP := cdsFilterVenda190.FieldByname('CFOP').Value;

          if ( ((iCodSituacao <> 1) and (iCodSituacao <> 7) and (sCFOP = '5605')) and
               ((StrToInt(Copy(sCFOP, 1, 1)) in [5,6,7]) or (sCFOP = '1605')) ) then
            VlTotDebitos_E110 := VlTotDebitos_E110 + StrToFloat(FormatarValor(cdsFilterVenda190.FieldByname('ValorICMS').Value));

          if ((iCodSituacao = 1) or (iCodSituacao = 7)) then
            VlTotalAputacao := VlTotalAputacao + StrToFloat(FormatarValor(cdsFilterVenda190.FieldByname('ValorICMS').Value));

          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda190.FieldByname('ValorBaseCalcICMSST').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda190.FieldByname('ValorICMSST').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda190.FieldByname('ValorReducaoBaseCalc').Value), 100);
          sLinha := sLinha + AlinharTexto(FormatarValor(cdsFilterVenda190.FieldByname('ValorIPI').Value), 100);

          Inc(FTotalLinhaBlocoC);
          Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-1].Total);
          //WriteLn(FArquivo, sLinha);
          FSPEDFile.Add(sLinha);

          if Assigned(FOnStepItRecordEvent) then
             FOnStepItRecordEvent('registro C190 venda', cdsFilterCompra190.RecNo);

          cdsFilterVenda190.Next;
        end;

        while ( not cdsFilterVenda190.Bof ) do
        begin
           cdsFilterVenda190.Delete;
           cdsFilterVenda190.Prior;
        end;
    end;
end;

procedure TmrSPEDFiscal.GerarRegistroC195;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC197;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC300;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C300';
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C320';
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C321';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsNFConsumidor300.RecordCount);


  while ( not cdsNFConsumidor300.Eof ) do
  begin
    sLinha := '|C300|';
    sLinha := sLinha + AlinharTexto(cdsNFConsumidor300.fieldByName('CodigoModelo').Value, 2);
    sLinha := sLinha + AlinharTexto(cdsNFConsumidor300.fieldByName('Serie').value, 4);
    sLinha := sLinha + AlinharTexto(cdsNFConsumidor300.fieldByName('SubSerie').value, 3);
    sLinha := sLinha + AlinharTexto(cdsNFConsumidor300.fieldByName('NumDocInicial').value, 6);
    sLinha := sLinha + AlinharTexto(cdsNFConsumidor300.fieldByName('NumDocFinal').value, 6);
    sLinha := sLinha + AlinharTexto(FormatarData(cdsNFConsumidor300.fieldByName('DataEmissao').value), 8);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFConsumidor300.fieldByName('ValorTotal').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFConsumidor300.fieldByName('ValorPIS').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFConsumidor300.fieldByName('ValorCOFINS').value), 100);
    sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.CodigoContaContabil, 60);

    Inc(FTotalLinhaBlocoC);
    Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-3].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    if FSPEDFiscalUsuario.Perfil = 'B' then
    begin
      GerarRegistroC320(cdsNFConsumidor300.fieldByName('DataEmissao').Value);
      //GerarRegistroC321(cdsNFConsumidor300.fieldByName('DataEmissao']);
    end;

    if Assigned(FOnStepItRecordEvent) then
      FOnStepItRecordEvent('registro C300', cdsNFConsumidor300.RecNo);

    cdsNFConsumidor300.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC310;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC320(ADataMovimento: String);
var
  iCodSituacao: Integer;
  sLinha, sCFOP: String;
  MovDate: TDateTime;
begin

(*
  day   := StrToInt(copy(ADataMovimento, 1, 2));
  month := StrToInt(copy(ADataMovimento, 3, 2));
  year  := StrToInt(copy(ADataMovimento, 5, 4));

  MovDate := EncodeDate(year, month, day);
 *)

  MovDate := StrToDateTime(ADataMovimento);

  cdsNFConsumidor320.Filtered := false;
  cdsNFConsumidor320.Filter   := 'DataMovimento = ' + QuotedStr(DateTimeToStr(MovDate));
  cdsNFConsumidor320.Filtered := true;

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsNFConsumidor300.RecordCount);

  while ( not cdsNFConsumidor320.Eof ) do
  begin
      sLinha := '|C320|';
      sLinha := sLinha + AlinharTexto(cdsNFConsumidor320.fieldByName('CodigoSituacaoTribICMS').value, 3);
      sLinha := sLinha + AlinharTexto(cdsNFConsumidor320.fieldByName('CFOP').Value, 4);
      sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsNFConsumidor320.fieldByName('AliqICMS').Value), 6);
      sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFConsumidor320.fieldByName('ValorTotal').Value), 100);
      sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFConsumidor320.fieldByName('ValorBaseICMS').Value), 100);
      sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFConsumidor320.fieldByName('ValorICMS').Value), 100);

      iCodSituacao := StrToInt(cdsNFConsumidor320.fieldByName('CodigoSituacaoTribICMS').Value);
      sCFOP := cdsNFConsumidor320.fieldByName('CFOP').Value;
      if ( ((iCodSituacao <> 1) and (iCodSituacao <> 7) and (sCFOP = '5605')) and
           ((StrToInt(Copy(sCFOP, 1, 1)) in [5,6,7]) or (sCFOP = '1605')) ) then
        VlTotDebitos_E110 := VlTotDebitos_E110 + StrToFloat(FormatarValor(cdsNFConsumidor320.fieldByName('ValorICMS').Value));

      if ((iCodSituacao = 1) or (iCodSituacao = 7)) then
        VlTotalAputacao := VlTotalAputacao + StrToFloat(FormatarValor(cdsNFConsumidor320.fieldByName('ValorICMS').value));

      sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFConsumidor320.fieldByName('ValorReducaoICMS').value), 100);
      sLinha := sLinha + AlinharTexto(cdsNFConsumidor320.fieldByName('CodigoOBS').value, 6);

      Inc(FTotalLinhaBlocoC);
      Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-2].Total);
      //WriteLn(FArquivo, sLinha);
      FSPEDFile.Add(sLinha);

      GerarRegistroC321(cdsNFConsumidor320.fieldByName('DataMovimento').value,
                        cdsNFConsumidor320.fieldByName('AliqICMS').value);

     if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C320', cdsNFConsumidor320.RecNo);

      cdsNFConsumidor320.Next;
  end;

  while ( not cdsNFConsumidor320.Bof ) do
  begin
    cdsNFConsumidor320.Delete;
    cdsNFConsumidor320.Prior;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC321(ADataMovimento, AAliqICMS: String);
var
  sLinha: String;
  MovDate: TDateTime;
begin

  MovDate := StrToDateTime(ADataMovimento);

  cdsItemNFConsumidor320.Filtered := false;
  cdsItemNFConsumidor320.Filter   := '( AliqICMS = ' + AALiqICMS + ' and ' + 'DataMovimento = ' + QuotedStr(DateTimeToStr(MovDate)) + ')';
  cdsItemNFConsumidor320.Filtered := true;

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsNFConsumidor320.RecordCount);

  while ( not cdsItemNFConsumidor320.Eof ) do
  begin
     sLinha := '|C321|';
     sLinha := sLinha + AlinharTexto(cdsItemNFConsumidor320.fieldByName('CodigoItem').Value, 60);
     sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsItemNFConsumidor320.fieldByName('Quantidade').Value), 100);
     sLinha := sLinha + AlinharTexto(cdsItemNFConsumidor320.fieldByName('CodigoUnidade').Value, 6);
     sLinha := sLinha + AlinharTexto(cdsItemNFConsumidor320.fieldByName('ValorTotal').Value, 100);
     sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFConsumidor320.fieldByName('ValorDesconto').Value), 100);
     sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFConsumidor320.fieldByName('ValorBaseICMS').Value), 100);
     sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFConsumidor320.fieldByName('ValorICMS').Value), 100);
     sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFConsumidor320.fieldByName('ValorPIS').Value), 100);
     sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFConsumidor320.fieldByName('ValorCOFINS').Value), 100);

     Inc(FTotalLinhaBlocoC);
     Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-1].Total);
     //WriteLn(FArquivo, sLinha);
     FSPEDFile.Add(sLinha);

     if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C321', cdsNFConsumidor320.RecNo);

     cdsItemNFConsumidor320.next;
  end;

  while ( not cdsItemNFConsumidor320.Bof ) do
  begin
    cdsItemNFConsumidor320.Delete;
    cdsItemNFConsumidor320.Prior;
  end
end;

procedure TmrSPEDFiscal.GerarRegistroC350;
var
  i: integer;
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C350';
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C370';
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C390';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsConsumidor350.RecordCount);

  i := 0;
  while ( not cdsConsumidor350.Eof ) do
  begin
    CalculaValoresICMS(tNFConsumidor, cdsConsumidor350.FieldByName('NumeroDocFiscal').Value);

    sLinha := '|C350|';
    sLinha := sLinha + AlinharTexto('', 1);
    sLinha := sLinha + AlinharTexto('', 1);
    sLinha := sLinha + AlinharTexto(ReturnNumber(cdsConsumidor350.FieldByName('NumeroDocFiscal').Value), 6);
    sLinha := sLinha + AlinharTexto(FormatarData(cdsConsumidor350.FieldByName('DataEmissao').Value), 8);
    sLinha := sLinha + AlinharTexto(cdsConsumidor350.FieldByName('DocAdquirente').Value, 14);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsConsumidor350.FieldByName('ValorMercServ').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsConsumidor350.FieldByName('ValorTotal').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsConsumidor350.FieldByName('ValorDesconto').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsConsumidor350.FieldByName('ValorPIS').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsConsumidor350.FieldByName('ValorCOFINS').Value), 100);
    sLinha := sLinha + AlinharTexto(cdsConsumidor350.FieldByName('CodigoContaContabil').Value, 60);

    Inc(FTotalLinhaBlocoC);
    Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-3].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    GerarRegistroC370(cdsConsumidor350.FieldByName('NumeroDocFiscal').Value);
    GerarRegistroC390(cdsConsumidor350.recNo);

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C350', cdsConsumidor350.RecNo);

    cdsConsumidor350.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC370(ANumeroDocFiscal: String);
var
  i, iNumeroItem: Integer;
  sLinha: String;
begin
  iNumeroItem := 0;

  FBaseICMS := 0;
  FValorICMS := 0;

  cdsItemNFConsumidor350.Filtered := false;
  cdsItemNFConsumidor350.Filter := 'NumeroDocFiscal = ' + quotedStr(AnumeroDocFiscal);
  cdsItemNFConsumidor350.Filtered := true;

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsConsumidor350.RecordCount);

  while ( not cdsItemNFConsumidor350.Eof ) do
  begin
     Inc(iNumeroItem);
     sLinha := '|C370|';
     sLinha := sLinha + AlinharTexto(IntToStr(iNumeroItem), 3);
     sLinha := sLinha + AlinharTexto(cdsItemNFConsumidor350.fieldByName('CodigoItem').value, 60);
     sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsItemNFConsumidor350.fieldByName('Quantidade').Value), 100);
     sLinha := sLinha + AlinharTexto(cdsItemNFConsumidor350.fieldByName('CodigoUnidade').Value, 6);
     sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFConsumidor350.fieldByName('ValorTotal').Value), 100);
     sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFConsumidor350.fieldByName('ValorDesconto').Value), 100);

     FBaseICMS := FBaseICMS + cdsItemNFConsumidor350.fieldByName('ValorBaseICMS').Value;
     FValorICMS := FValorICMS + cdsItemNFConsumidor350.fieldByName('ValorICMS').Value;

     Inc(FTotalLinhaBlocoC);
     Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-2].Total);
     //WriteLn(FArquivo, sLinha);
     FSPEDFile.Add(sLinha);

     if Assigned(FOnStepItRecordEvent) then
        FOnStepItRecordEvent('registro C370', cdsConsumidor350.RecNo);

     cdsItemNFConsumidor350.Next;
  end;

  while ( not cdsItemNFConsumidor350.Bof ) do
  begin
    cdsItemNFConsumidor350.Delete;
    cdsItemNFConsumidor350.Prior;
  end;


end;

procedure TmrSPEDFiscal.GerarRegistroC390(ARecordIndex: Integer);
var
  sLinha: String;
begin
  sLinha := '|C390|';
  sLinha := sLinha + AlinharTexto(cdsConsumidor350.FieldByName('CodigoSituacaoTribICMS').Value, 3);
  sLinha := sLinha + AlinharTexto(cdsConsumidor350.FieldByName('CFOP').Value, 4);
  sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsConsumidor350.FieldByName('AliqICMS').Value), 6);
  sLinha := sLinha + AlinharTexto(FormatarValor(FBaseICMS), 100);
  sLinha := sLinha + AlinharTexto(FormatarValor(FBaseICMS), 100);
  sLinha := sLinha + AlinharTexto(FormatarValor(FValorICMS), 100);
  sLinha := sLinha + AlinharTexto(FormatarValor(cdsConsumidor350.FieldByName('AbatimentoNaoTrib').Value), 100);
  sLinha := sLinha + AlinharTexto('', 1);

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsConsumidor350.RecordCount);


  Inc(FTotalLinhaBlocoC);
  Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-1].Total);
  //WriteLn(FArquivo, sLinha);

  if Assigned(FOnStepItRecordEvent) then
     FOnStepItRecordEvent('registro C390', cdsConsumidor350.RecNo);

  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroC400;
var
  i: Integer;
  sLinha: String;
  iNumeroItem: Integer;
  bWrited: boolean;
begin
  iNumeroItem := 0;

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsC400EquipECF.RecordCount);

  bWrited := false;
  sLinha := '|C400|';
  while ( not cdsC400EquipECF.Eof ) do
  begin
    Inc(iNumeroItem);
    if ( cdsC400EquipECF.fieldByName('numeroserie').Value <> '' ) then
    begin
      sLinha := sLinha + AlinharTexto(cdsC400EquipECF.fieldByName('CodMod').Value, 2);
      sLinha := sLinha + AlinharTexto(cdsC400EquipECF.fieldByName('modeloECF').Value, 20);
      sLinha := sLinha + AlinharTexto(cdsC400EquipECF.fieldByName('numeroserie').Value, 20);
      sLinha := sLinha + AlinharTexto(FormatarValor(cdsC400EquipECF.fieldByName('idcashregister').Value), 3);

      Inc(FTotalLinhaBlocoC);
      Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-2].Total);
      //WriteLn(FArquivo, sLinha);
      FSPEDFile.Add(sLinha);
      bWrited := true;
//      GerarRegistroC405(FXMLC400EquipECF.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['numeroserie']);
    end;

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C400 Equip. ECF', cdsC400EquipECF.RecNo);

    cdsC400EquipECF.Next;
  end;

  if ( bWrited ) then
  begin
    GerarRegistroC405;
    GerarRegistroC410;
    GerarRegistroC420;
    GerarRegistroC425;
    GerarRegistroC460;
    GerarRegistroC470;
    GerarRegistroC490;
    GerarRegistroC495;
  end;

end;

procedure TmrSPEDFiscal.GerarRegistroC405;
var
  i: Integer;
  sLinha: String;
  iNumeroItem: Integer;
begin
  iNumeroItem := 0;
  sLinha := '|C405|';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsC405ReducaoZ.RecordCount);

  while ( not cdsC405ReducaoZ.Eof ) do
  begin
    inc(iNumeroItem);
    sLinha := sLinha + AlinharTexto(IntToStr(iNumeroItem), 3);

    if ( not cdsC405ReducaoZ.fieldByName('datamov').IsNull ) then
    begin
      sLinha := sLinha + AlinharTexto(cdsC405ReducaoZ.fieldByName('datamov').Value, 8);
      sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsC405ReducaoZ.fieldByName('ContadorReinicioOper').Value), 3);
      sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsC405ReducaoZ.fieldByName('ContadorOrdemOperacao').Value), 6);
      sLinha := sLinha + AlinharTexto(cdsC405ReducaoZ.fieldByName('COOreducaoZ').Value, 6);
      sLinha := sLinha + AlinharTexto(cdsC405ReducaoZ.fieldByName('GrandTotFinal').Value, 100);
      sLinha := sLinha + AlinharTexto(cdsC405ReducaoZ.fieldByName('ValorAcumulado').Value, 100);

      Inc(FTotalLinhaBlocoC);
      Inc(FTotalizadorRegistros[Length(FTotalizadorRegistros)-2].Total);
      //WriteLn(FArquivo, sLinha);
      FSPEDFile.Add(sLinha);
    end;

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C405 Redução Z', cdsC405ReducaoZ.RecNo);

    cdsC405ReducaoZ.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC410;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC420;
var
  i, j, k: integer;
  sCodTotalizadorECF: String;
  vlr_acum_tot: extended;
  nr_tot: String;
  iNumeroItem: integer;
  sLinha: String;
begin
  iNumeroItem := 0;
  sLinha := '|C420|';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsC420TotalizadoresParcReducaoZ.RecordCount);

  i := 0;
  while ( not cdsC420TotalizadoresParcReducaoZ.Eof ) do
  begin
     inc(iNumeroItem);

     if (cdsC420TotalizadoresParcReducaoZ.fieldByName('codTotParcial').Value <> 'X') then
     begin
       sLinha := sLinha + AlinharTexto(cdsC420TotalizadoresParcReducaoZ.fieldByName('codTotParcial').Value, 7);
       sLinha := sLinha + AlinharTexto(formatarValor(cdsC420TotalizadoresParcReducaoZ.fieldbyName('ValorAcumulado').Value), 100);
       sLinha := sLinha + AlinharTexto(cdsC420TotalizadoresParcReducaoZ.fieldByName('numTotalizador').Value, 2);
       sLinha := sLinha + AlinharTexto(cdsC420TotalizadoresParcReducaoZ.fieldByName('descNrTot').Value, 100);

       Inc(FTotalLinhaBlocoC);
       Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
       //WriteLn(FArquivo, sLinha);
       FSPEDFile.Add(sLinha);
     end;

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C420 Totalizador Parcial Redução Z', cdsC420TotalizadoresParcReducaoZ.RecNo);

    cdsC420TotalizadoresParcReducaoZ.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC425;
var
  i: Integer;
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C425';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsC425ResumoItensMovDiario.RecordCount);

  while ( not cdsC425ResumoItensMovDiario.Eof ) do
  begin
    sLinha := '|C425|';
    sLinha := sLinha + AlinharTexto(cdsC425ResumoItensMovDiario.fieldByName('CodigoItem').Value, 60);
    sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsC425ResumoItensMovDiario.fieldByName('Quantidade').value), 3);
    sLinha := sLinha + AlinharTexto(cdsC425ResumoItensMovDiario.fieldByName('CodigoUnidade').value, 6);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC425ResumoItensMovDiario.fieldByName('ValorTotal').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC425ResumoItensMovDiario.fieldByName('ValorPIS').value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC425ResumoItensMovDiario.fieldByName('ValorCOFINS').value), 100);

    Inc(FTotalLinhaBlocoC);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C425 Resumo Itens (Mov. Diario)', cdsC425ResumoItensMovDiario.RecNo);

    cdsC425ResumoItensMovDiario.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC460;
var
  i: Integer;
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C460';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsNFVendaCupom.RecordCount);

  while ( not cdsNFVendaCupom.Eof ) do
  begin
    sLinha := '|C460|';
    // TODO (pegar o código conforme o tipo de NF)
    sLinha := sLinha + AlinharTexto(cdsNFVendaCupom.fieldByName('CodigoModelo').Value, 2);
    sLinha := sLinha + AlinharTexto(cdsNFVendaCupom.fieldByName('CodigoSituacao').Value, 2);
    sLinha := sLinha + AlinharTexto(ReturnNumber(cdsNFVendaCupom.fieldByName('NumeroDocFiscal').Value), 9);
    sLinha := sLinha + AlinharTexto(FormatarData(cdsNFVendaCupom.fieldByName('DataEmissao').Value), 8);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFVendaCupom.fieldByName('ValorTotal').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFVendaCupom.fieldByName('ValorPIS').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsNFVendaCupom.fieldByName('ValorCOFINS').Value), 100);
    sLinha := sLinha + AlinharTexto(cdsNFVendaCupom.fieldByName('DocAdquirente').Value, 14);
    sLinha := sLinha + AlinharTexto(cdsNFVendaCupom.fieldByName('NomeAdquirente').Value, 60);

    Inc(FTotalLinhaBlocoC);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C460 NF Venda Cupom ', cdsNFVendaCupom.RecNo);

    cdsNFVendaCupom.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC470;
var
  i: Integer;
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C470';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsNFVendaCupom.RecordCount);

  while ( not cdsItemNFVendaCupom.Eof ) do
  begin
    sLinha := '|C470|';
    sLinha := sLinha + AlinharTexto(cdsItemNFVendaCupom.fieldByName('CodigoItem').Value, 60);
    sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsItemNFVendaCupom.fieldByName('Quantidade').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarQuantidade(cdsItemNFVendaCupom.fieldByName('QuantidadeCanc').Value), 3);
    sLinha := sLinha + AlinharTexto(cdsItemNFVendaCupom.fieldByName('CodigoUnidade').Value, 6);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFVendaCupom.fieldByName('ValorTotal').Value), 100);
    sLinha := sLinha + AlinharTexto(cdsItemNFVendaCupom.fieldByName('CodigoSituacaoTrib').Value, 3);
    sLinha := sLinha + AlinharTexto(cdsItemNFVendaCupom.fieldByName('CFOP').Value, 4);
    // TODO (pegar a aliquota do cadastro)
    sLinha := sLinha + AlinharTexto(FormatarPercentual(cdsItemNFVendaCupom.fieldByName('AliqICMS').Value), 6);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFVendaCupom.fieldByName('ValorPIS').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsItemNFVendaCupom.fieldByName('ValorCOFINS').Value), 100);  // 11 VL_COFINS Valor da COFINS N - 02 OC

    Inc(FTotalLinhaBlocoC);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C470 Item NF Venda Cupom ', cdsItemNFVendaCupom.RecNo);

    cdsItemNFVendaCupom.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC490;
var
  i: Integer;
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C490';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(cdsC490AnaliticoMovDiario.RecordCount);

  while ( not cdsC490AnaliticoMovDiario.Eof) do
  begin
    sLinha := '|C490|';
    sLinha := sLinha + AlinharTexto(cdsC490AnaliticoMovDiario.fieldByName('CodigoSituacaoTrib').Value, 3);
    sLinha := sLinha + AlinharTexto(cdsC490AnaliticoMovDiario.fieldByName('CFOP').Value, 4);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC490AnaliticoMovDiario.fieldByName('AliqICMS').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC490AnaliticoMovDiario.fieldByName('ValorTotal').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC490AnaliticoMovDiario.fieldByName('ValorBaseICMS').Value), 100);
    sLinha := sLinha + AlinharTexto(FormatarValor(cdsC490AnaliticoMovDiario.fieldByName('ValorICMS').Value), 100);
    sLinha := sLinha + AlinharTexto(cdsC490AnaliticoMovDiario.fieldByName('CodigoModelo').Value, 2);

    Inc(FTotalLinhaBlocoC);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    if Assigned(FOnStepItRecordEvent) then
       FOnStepItRecordEvent('registro C490 Analitico Mov. Diario ', cdsC490AnaliticoMovDiario.RecNo);

    cdsC490AnaliticoMovDiario.Next;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroC495;
begin
  // somente na Bahia.
end;

procedure TmrSPEDFiscal.GerarRegistroC500;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC510;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC590;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC600;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC601;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC610;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC690;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC700;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC790;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC791;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroC990;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'C990';

  if Assigned(FOnTotalRecordEvent) then
    FOnTotalRecordEvent(1);

  sLinha := '|C990|';
  Inc(FTotalLinhaBlocoC);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBlocoC), 100000);

  if Assigned(FOnStepItRecordEvent) then
     FOnStepItRecordEvent('registro C990 Totalizador bloco C ', 1);

 //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro1001;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '1001';

  sLinha := '|1001|';
  sLinha := sLinha + AlinharNumero('1', 1);

  Inc(FTotalLinhaBloco1);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro1100;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1105;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1110;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1200;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1210;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1300;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1310;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1320;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1350;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1360;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1370;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1400;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1500;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1510;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1600;
begin

end;

procedure TmrSPEDFiscal.GerarRegistro1990;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '1990';

  sLinha := '|1990|';
  Inc(FTotalLinhaBloco1);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBloco1), 100000);

  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro9001;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := '9001';

  sLinha := '|9001|';
  sLinha := sLinha + AlinharNumero('0', 1);

  Inc(FTotalLinhaBloco9);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro9900;
var
  i: Integer;
  sLinha: String;
begin
  for i := 0 to Pred(Length(FTotalizadorRegistros)) do
  begin
    sLinha := '|9900|';
    sLinha := sLinha + AlinharTexto(FTotalizadorRegistros[i].Registro, 4);
    sLinha := sLinha + AlinharTexto(IntToStr(FTotalizadorRegistros[i].Total), 100000);

    Inc(FTotalLinhaBloco9);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);
  end;

  sLinha := '|9900|';
  sLinha := sLinha + AlinharTexto('9900', 4);
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBloco9 + 2), 100000000);
  Inc(FTotalLinhaBloco9);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);

  sLinha := '|9900|';
  sLinha := sLinha + AlinharTexto('9990', 4);
  sLinha := sLinha + AlinharTexto('1', 1);
  Inc(FTotalLinhaBloco9);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);

  sLinha := '|9900|';
  sLinha := sLinha + AlinharTexto('9999', 4);
  sLinha := sLinha + AlinharTexto('1', 1);
  Inc(FTotalLinhaBloco9);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro9990;
var
  sLinha: String;
begin
  sLinha := '|9990|';
  Inc(FTotalLinhaBloco9);
  Inc(FTotalLinhaBloco9);
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBloco9), 100000);

  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistro9999;
var
  sLinha: String;
begin
  sLinha := '|9999|';
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBloco0 +
                                           FTotalLinhaBlocoC +
                                           FTotalLinhaBlocoD +
                                           FTotalLinhaBlocoE +
                                           FTotalLinhaBlocoH +
                                           FTotalLinhaBloco1 +
                                           FTotalLinhaBloco9), 100000000);

  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroD001;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'D001';

  sLinha := '|D001|';
  sLinha := sLinha + AlinharNumero('1', 1);

  Inc(FTotalLinhaBlocoD);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroD100;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD110;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD120;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD130;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD140;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD150;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD160;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD161;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD162;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD170;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD180;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD190;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD300;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD301;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD310;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD350;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD355;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD360;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD365;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD370;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD390;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD400;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD410;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD411;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD420;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD500;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD510;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD530;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD590;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD600;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD610;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD690;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD695;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD696;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD697;
begin

end;

procedure TmrSPEDFiscal.GerarRegistroD990;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'D990';

  sLinha := '|D990|';
  Inc(FTotalLinhaBlocoD);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBlocoD), 100000);

  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroE001;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'E001';

  sLinha := '|E001|';
  sLinha := sLinha + AlinharNumero('0', 1);

  Inc(FTotalLinhaBlocoE);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroE100;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'E100';

  sLinha := '|E100|';
  sLinha := sLinha + AlinharTexto(FormatarData(FDataInicial), 8);
  sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8);

  Inc(FTotalLinhaBlocoE);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroE110;
var
  sLinha: String;
  dVlsaldoApurado : Currency;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'E110';

  dVlsaldoApurado := VlTotDebitos_E110 - VlTotCreditos_E110;

  sLinha := '|E110|';
  //sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto(FormatarValor(VlTotDebitos_E110), 100);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto(FormatarValor(VlTotCreditos_E110), 100);
  sLinha := sLinha + AlinharTexto('0', 10);
  //sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);

  //11 - SALDO DEVEDOR APURADO -  VL_SLD_APURADO
  if dVlsaldoApurado >= 0 then
  begin
    VlObrigacaoRecolher := dVlsaldoApurado;
    sLinha := sLinha + AlinharTexto(FormatarValor(dVlsaldoApurado), 100)
  end
  else
  begin
    VlObrigacaoRecolher := 0;
    dVlsaldoApurado := 0;    
    sLinha := sLinha + AlinharTexto('0', 10);
  end;

  //12 - VL_TOT_DED
  sLinha := sLinha + AlinharTexto('0', 10);

  //13 - VL_ICMS_RECOLHER
  sLinha := sLinha + AlinharTexto(FormatarValor(dVlsaldoApurado), 100);

  //14 - SALDO CREDOR A TRANSPORTAR - VL_SLD_CREDOR_TRANSPORTAR
  if (VlTotDebitos_E110 - VlTotCreditos_E110) >= 0 then
    sLinha := sLinha + AlinharTexto('0', 10)
  else
    sLinha := sLinha + AlinharTexto(FormatarValor(VlTotCreditos_E110 - VlTotDebitos_E110), 100);

  sLinha := sLinha + AlinharTexto(FormatarValor(VlTotalAputacao), 100);
  //sLinha := sLinha + AlinharTexto('0', 10);

  Inc(FTotalLinhaBlocoE);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroE200;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'E200';

  sLinha := '|E200|';
  sLinha := sLinha + AlinharTexto(FormatarData(FDataInicial), 8);
  sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8);

  Inc(FTotalLinhaBlocoE);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroE210;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'E210';

  sLinha := '|E210|';
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);
  sLinha := sLinha + AlinharTexto('0', 10);

  Inc(FTotalLinhaBlocoE);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroE990;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'E990';

  sLinha := '|E990|';
  Inc(FTotalLinhaBlocoE);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBlocoE), 100000);

  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroH001;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'H001';

  sLinha := '|H001|';
  sLinha := sLinha + AlinharNumero('0', 1);

  Inc(FTotalLinhaBlocoH);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

procedure TmrSPEDFiscal.GerarRegistroH005;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'H005';

  FXMLTotalInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;
  sLinha := '|H005|';
  sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8);

  if FXMLTotalInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['ValorTotal'] <= 0 then
  begin
    sLinha := sLinha + AlinharTexto('0', 1);
    Inc(FTotalLinhaBlocoH);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);
  end
  else
  begin
    sLinha := sLinha + AlinharTexto(FormatarValor(FXMLTotalInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(0).Attributes['ValorTotal']), 100000000);
    Inc(FTotalLinhaBlocoH);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);

    GerarRegistroH010;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroH010;
var
  i: Integer;
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'H010';

  FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;

  for i := 0 to Pred(FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Count) do
  begin
    sLinha := '|H010|';
    sLinha := sLinha + AlinharTexto(FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoItem'], 60);
    sLinha := sLinha + AlinharTexto(FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['CodigoUnidade'], 6);

    if FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Quantidade'] <= 0 then
    begin
      sLinha := sLinha + AlinharTexto('0', 1);
      sLinha := sLinha + AlinharTexto(FormatarValor(FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorUnitario']), 100000000);
      sLinha := sLinha + AlinharTexto('0', 1);
    end
    else
    begin
      sLinha := sLinha + AlinharTexto(FormatarQuantidade(FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['Quantidade']), 100000000);
      sLinha := sLinha + AlinharTexto(FormatarValor(FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorUnitario']), 100000000);
      sLinha := sLinha + AlinharTexto(FormatarValor(FXMLInventario.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.Get(i).Attributes['ValorTotal']), 100000000);
    end;

    sLinha := sLinha + AlinharTexto('0', 1);
    sLinha := sLinha + AlinharTexto('', 60);
    sLinha := sLinha + AlinharTexto('', 100);
    sLinha := sLinha + AlinharTexto(FSPEDFiscalUsuario.CodigoContaContabil, 100);

    Inc(FTotalLinhaBlocoH);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroH990;
var
  sLinha: String;
begin
  SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
  FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'H990';

  sLinha := '|H990|';
  Inc(FTotalLinhaBlocoH);
  Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
  sLinha := sLinha + AlinharTexto(IntToStr(FTotalLinhaBlocoH), 100000);

  //WriteLn(FArquivo, sLinha);
  FSPEDFile.Add(sLinha);
end;

function TmrSPEDFiscal.GerarArquivoEFD: Boolean;
var
  sMesAno : String[06];
  sNomeArqFinal : String;
begin
  VlTotCreditos_E110 := 0;
  VlTotDebitos_E110 := 0;
  VlObrigacaoRecolher := 0;
  VlTotalAputacao := 0;
  try
     cdsParticipante.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_PARTICIPANTE_XML);
     cdsParticipante.Open;

     cdsUnidadeMedida.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_UNIDADE_MEDIDA_XML);
     cdsUnidadeMedida.Open;

     cdsItem.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_ITEM_XML);
     cdsItem.Open;
//     showmessage('cdsItem opened');

     cdsTotalInventario.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_TOTAL_INVENTARIO_XML);
     cdsTotalInventario.Open;
//     showmessage('cdsTotalInventario opened');

     cdsInventario.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_INVENTARIO_XML);
     cdsInventario.Open;
//     showmessage('cdsInventario opened');

     cdsNFConsumidor300.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_NF_CONSUMIDOR_300_XML);
     cdsNFConsumidor300.Open;
//     showmessage('cdsNFConsumidor opened');


     cdsNFConsumidor320.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_NF_CONSUMIDOR_320_XML);
     cdsNFConsumidor320.Open;
//     showmessage('cdsNFConsumidor320 opened');

     cdsConsumidor350.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_NF_CONSUMIDOR_350_XML);
     cdsConsumidor350.Open;
//     showmessage('cdsIConsumidor350 opened');


     cdsNFVendaCupom.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_NF_VENDA_CUPOM_XML);
     cdsNFVendaCupom.Open;
//     showmessage('cdsNFVendaCupom opened');


     cdsItemNFConsumidor320.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_ITEM_NF_CONSUMIDOR_320_XML);
     cdsItemNFConsumidor320.Open;
//     showmessage('cdsItemNFConsumidor320 opened');


     cdsItemNFConsumidor350.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_ITEM_NF_CONSUMIDOR_350_XML);
     cdsItemNFConsumidor350.Open;
//     showmessage('cdsItemNFConsumidor350 opened');


     cdsItemNFVendaCupom.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_ITEM_NF_VENDA_CUPOM_XML);
     cdsItemNFVendaCupom.Open;
//     showmessage('cdsItemNFVendaCupom opened');


     cdsItemNFConsumidorCupom.LoadFromFile(FCaminhoArquivos+'Base\'+ARQUIVO_ITEM_NF_CONSUMIDOR_E_CUPOM_XML);
     cdsItemNFConsumidorCupom.Open;
//     showmessage('cdsItemNFConsumidorCupom opened');


     cdsC100Compra.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C100_COMPRA_XML);
     cdsC100Compra.Open;
//     showmessage('cdsC100Compra opened');


     cdsC100Venda.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C100_VENDA_XML);
     cdsC100Venda.Open;
//     showmessage('cdsC100Venda opened');

     cdsC400EquipECF.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C400_EQUIP_ECF_XML);
     cdsC400EquipECF.Open;
//     showmessage('cdsC400EquipECF opened');

     cdsC405ReducaoZ.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C405_REDUCAO_Z_XML);
     cdsC405ReducaoZ.Open;
//     showmessage('cds405ReducaoZ opened');


     cdsC420TotalizadoresParcReducaoZ.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C420_TOTALIZADORES_PARCIAIS_REDUCAO_Z_XML);
     cdsC420TotalizadoresParcReducaoZ.Open;
//     showmessage('cdsC420TotalizadoresResParcRedu opened');


     cdsC425ResumoItensMovDiario.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C425_RESUMO_ITENS_MOVDIARIO_XML);
     cdsC425ResumoItensMovDiario.Open;
//     showmessage('cdsC425ResumoItensMovDiario opened');

     cdsC490AnaliticoMovDiario.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C490_ANALITICO_MOVDIARIO_XML);
     cdsC490AnaliticoMovDiario.Open;
//     showmessage('cds490AnaliticoMovDiario opened');

     cdsFilterCompra170.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C170_COMPRA_XML);
     cdsFilterCompra170.Open;
//     showmessage('cdsFilterCompra170 opened');


     cdsFilterVenda170.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C170_VENDA_XML);
     cdsFilterVenda170.Open;
//     showmessage('cdsFilterVenda170 opened');


     cdsFilterCompra190.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C190_COMPRA_XML);
     cdsFilterCompra190.Open;
//     showmessage('cdsFilterCompra opened');


     cdsFilterVenda190.LoadFromFile(FCaminhoArquivos+'Base\'+REGISTRO_C190_VENDA_XML);
     cdsFilterVenda190.Open;
//     showmessage('cdsfilterVenda190 opened');


    try
      sMesAno := FormatDateTime('mmyyyy', FDataFinal);
      sNomeArqFinal := ARQUIVO_SPEDFISCAL_TXT + '_' + ReturnNumber(FSPEDFiscalUsuario.CNPJ) + '_' + sMesAno + '.txt';

      //AssignFile(FArquivo, FCaminhoArquivos + sNomeArqFinal);
      //Rewrite(FArquivo);

      FSPEDFile := TStringList.Create;

      //FProgressBar.Max := FProgressBar.Max + 7;

      GerarBloco0;
      FProgressBar.Position := FProgressBar.Position + 1;

      GerarBlocoC;
      FProgressBar.Position := FProgressBar.Position + 1;

      GerarBlocoD;
      FProgressBar.Position := FProgressBar.Position + 1;

      GerarBlocoE;
      FProgressBar.Position := FProgressBar.Position + 1;

      GerarBlocoH;
      FProgressBar.Position := FProgressBar.Position + 1;

      GerarBloco1;
      FProgressBar.Position := FProgressBar.Position + 1;

      GerarBloco9;
      FProgressBar.Position := FProgressBar.Position + 1;
    finally
      FSPEDFile.SaveToFile(sNomeArqFinal);
      FreeAndNil(FSPEDFile);
      //CloseFile(FArquivo);
    end;

    Result := True;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.GerarBloco0: Boolean;
begin
  FTotalLinhaBloco0 := 0;

  try
    FXMLContribuinteST.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_CONTRIBUINTE_ST_XML);
    GerarRegistro0000;
    GerarRegistro0001;
    GerarRegistro0005;
    GerarRegistro0015;
    GerarRegistro0100;
    GerarRegistro0150;
    GerarRegistro0190;
    GerarRegistro0200;
    GerarRegistro0990;

    Result := True;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.GerarBlocoC: Boolean;
begin
  FTotalLinhaBlocoC := 0;

  try
(*
    FXMLNFConsumidor300.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_NF_CONSUMIDOR_300_XML);
    FXMLNFConsumidor320.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_NF_CONSUMIDOR_320_XML);
    FXMLNFConsumidor350.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_NF_CONSUMIDOR_350_XML);
    FXMLNFVendaCupom.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_NF_VENDA_CUPOM_XML);
    FXMLItemNFConsumidor320.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_ITEM_NF_CONSUMIDOR_320_XML);
    FXMLItemNFConsumidor350.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_ITEM_NF_CONSUMIDOR_350_XML);
    FXMLItemNFVendaCupom.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_ITEM_NF_VENDA_CUPOM_XML);
    FXMLItemNFConsumidorCupom.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_ITEM_NF_CONSUMIDOR_E_CUPOM_XML);

    FXMLC100Compra.LoadFromFile(FCaminhoArquivos+'Base\' + REGISTRO_C100_COMPRA_XML);
    FXMLC100Venda.LoadFromFile(FCaminhoArquivos+'Base\' + REGISTRO_C100_VENDA_XML);
    FXMLC170Compra.LoadFromFile(FCaminhoArquivos+'Base\' + REGISTRO_C170_COMPRA_XML);
    FXMLC170Venda.LoadFromFile(FCaminhoArquivos+'Base\' + REGISTRO_C170_VENDA_XML);
    FXMLC190Compra.LoadFromFile(FCaminhoArquivos+'Base\' + REGISTRO_C190_COMPRA_XML);
    FXMLC190Venda.LoadFromFile(FCaminhoArquivos+'Base\' + REGISTRO_C190_VENDA_XML);

    FXMLC400EquipECF.LoadFromFile(FCaminhoArquivos+'Base\'+ REGISTRO_C400_EQUIP_ECF_XML);
    FXMLC405ReducaoZ.LoadFromFile(FCaminhoArquivos+'Base\'+ REGISTRO_C405_REDUCAO_Z_XML);
    FXMLC420TotalizadoresParcReducaoZ.LoadFromFile(FCaminhoArquivos+'Base\'+ REGISTRO_C420_TOTALIZADORES_PARCIAIS_REDUCAO_Z_XML);
    FXMLC425ResumoItensMovDiario.LoadFromFile(FCaminhoArquivos+'Base\' + REGISTRO_C425_RESUMO_ITENS_MOVDIARIO_XML);
    FXMLC490RegistroAnaliticoMovDiario.LoadFromFile(FCaminhoArquivos+'Base\' + REGISTRO_C490_ANALITICO_MOVDIARIO_XML);
 *)
    GerarRegistroC001;
    GerarRegistroC100;
    GerarRegistroC110;
    GerarRegistroC111;
    GerarRegistroC112;
    GerarRegistroC113;
    GerarRegistroC114;
    GerarRegistroC115;
    GerarRegistroC120;
    GerarRegistroC140;
    GerarRegistroC141;
    GerarRegistroC160;
    GerarRegistroC165;
    GerarRegistroC171;
    GerarRegistroC172;
    GerarRegistroC173;
    GerarRegistroC174;
    GerarRegistroC175;
    GerarRegistroC176;
    GerarRegistroC177;
    GerarRegistroC178;
    GerarRegistroC179;
    GerarRegistroC195;
    GerarRegistroC197;
    GerarRegistroC300;

    GerarRegistroC310;


    if FSPEDFiscalUsuario.Perfil = 'A' then
      GerarRegistroC350;

    GerarRegistroC400;

    //GerarRegistroC405;
    //GerarRegistroC410;

    //GerarRegistroC420;

    //GerarRegistroC425;

    //GerarRegistroC460;

    //GerarRegistroC470;

    //GerarRegistroC490;

    //GerarRegistroC495;

    GerarRegistroC500;
    GerarRegistroC510;
    GerarRegistroC590;
    GerarRegistroC600;
    GerarRegistroC601;
    GerarRegistroC610;
    GerarRegistroC690;
    GerarRegistroC700;
    GerarRegistroC790;
    GerarRegistroC791;
    GerarRegistroC990;

    Result := True;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.GerarBlocoD: Boolean;
begin
  FTotalLinhaBlocoD := 0;

  try
    GerarRegistroD001;
    GerarRegistroD100;
    GerarRegistroD110;
    GerarRegistroD120;
    GerarRegistroD130;
    GerarRegistroD140;
    GerarRegistroD150;
    GerarRegistroD160;
    GerarRegistroD161;
    GerarRegistroD162;
    GerarRegistroD170;
    GerarRegistroD180;
    GerarRegistroD190;
    GerarRegistroD300;
    GerarRegistroD301;
    GerarRegistroD310;
    GerarRegistroD350;
    GerarRegistroD355;
    GerarRegistroD360;
    GerarRegistroD365;
    GerarRegistroD370;
    GerarRegistroD390;
    GerarRegistroD400;
    GerarRegistroD410;
    GerarRegistroD411;
    GerarRegistroD420;
    GerarRegistroD500;
    GerarRegistroD510;
    GerarRegistroD530;
    GerarRegistroD590;
    GerarRegistroD600;
    GerarRegistroD610;
    GerarRegistroD690;
    GerarRegistroD695;
    GerarRegistroD696;
    GerarRegistroD697;
    GerarRegistroD990;

    Result := True;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.GerarBlocoE: Boolean;
begin
  FTotalLinhaBlocoE := 0;

  try
    GerarRegistroE001;
    GerarRegistroE100;
    GerarRegistroE110;
    GerarRegistroE116;
    //GerarRegistroE200;
    //GerarRegistroE210;
    GerarRegistroE990;
    
    Result := True;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.GerarBlocoH: Boolean;
begin
  FTotalLinhaBlocoH := 0;

  try
    FXMLTotalInventario.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_TOTAL_INVENTARIO_XML);
    FXMLInventario.LoadFromFile(FCaminhoArquivos+'Base\' + ARQUIVO_INVENTARIO_XML);

    GerarRegistroH001;
    GerarRegistroH005;
    GerarRegistroH990;

    Result := True;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.GerarBloco1: Boolean;
begin
  FTotalLinhaBloco1 := 0;

  try
    GerarRegistro1001;
    GerarRegistro1100;
    GerarRegistro1105;
    GerarRegistro1110;
    GerarRegistro1200;
    GerarRegistro1210;
    GerarRegistro1300;
    GerarRegistro1310;
    GerarRegistro1320;
    GerarRegistro1350;
    GerarRegistro1360;
    GerarRegistro1370;
    GerarRegistro1400;
    GerarRegistro1500;
    GerarRegistro1510;
    GerarRegistro1600;
    GerarRegistro1990;

    Result := True;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.GerarBloco9: Boolean;
begin
  FTotalLinhaBloco9 := 0;

  try
    GerarRegistro9001;
    GerarRegistro9900;
    GerarRegistro9990;
    GerarRegistro9999;

    Result := True;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TmrSPEDFiscal.FormatarQuantidade(AQuantidade: Variant): String;
var
  dQuantidade: Double;
begin
  dQuantidade := StrToCurr(StringReplace(AQuantidade, '.', ',', [rfReplaceAll]));

  if dQuantidade = 0 then
    Result := '0'
  else if Frac(dQuantidade) > 0 then
    Result := FormatFloat('###0.00', Abs(dQuantidade))
  else
    Result := FloatToStr(Abs(dQuantidade));
end;

function TmrSPEDFiscal.FormatarPercentual(APercentual: Variant): String;
var
  dPercentual: Currency;
begin
  dPercentual := StrToCurr(StringReplace(APercentual, '.', ',', [rfReplaceAll]));

  if dPercentual = 0 then
    Result := '0'
  else
    Result := FormatFloat('###0.00', dPercentual);
end;

procedure TmrSPEDFiscal.CalculaValoresICMS(ATipoNF: TTipoNF; ANumeroDocFiscal: String);
var
  i: Integer;
begin
  if ATipoNF = tNFCompra then
  begin
    // NF Compra
    FBaseICMS := 0;
    FValorICMS := 0;

    cdsFilterCompra170.Filtered := false;
    cdsFilterCompra170.Filter   := 'NumeroDocFiscal = ' + quotedStr(AnumeroDocFiscal);
    cdsFilterCompra170.Filtered := true;

    //FXMLC170Compra.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;
    for i := 0 to Pred(cdsFilterCompra170.RecordCount) do
    begin
        FBaseICMS := FBaseICMS + cdsFilterCompra170.fieldByName('ValorBaseICMS').Value;
        FValorICMS := FValorICMS + cdsFilterCompra170.fieldByName('ValorICMS').Value;
    end;
  end
  else if ATipoNF = tNFVenda then
  begin
    // NF Venda
    FBaseICMS := 0;
    FValorICMS := 0;

    cdsFilterVenda170.Filtered := false;
    cdsFilterVenda170.Filter   := 'NumeroDocFiscal = ' + quotedStr(AnumeroDocFiscal);
    cdsFilterVenda170.Filtered := true;

//    FXMLC170Venda.ChildNodes.FindNode('DATAPACKET').ChildNodes.FindNode('ROWDATA').ChildNodes.First;
    for i := 0 to Pred(cdsFilterVenda170.RecordCount) do
    begin
        FBaseICMS := FBaseICMS + cdsFilterVenda170.fieldByName('ValorBaseICMS').Value;
        FValorICMS := FValorICMS + cdsFilterVenda170.fieldByName('ValorICMS').Value;
    end;
  end;
end;

procedure TmrSPEDFiscal.GerarRegistroE116;
var
  sLinha : String;
begin
  if VlObrigacaoRecolher + VlTotalAputacao > 0 then
  begin
    SetLength(FTotalizadorRegistros, Length(FTotalizadorRegistros)+1);
    FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Registro := 'E116';

    sLinha := '|E116|';
    sLinha := sLinha + AlinharTexto('000', 10);
    sLinha := sLinha + AlinharTexto(FormatarValor(VlObrigacaoRecolher+VlTotalAputacao), 100);
    sLinha := sLinha + AlinharTexto(FormatarData(FDataFinal), 8);
    sLinha := sLinha + AlinharTexto('0', 10);
    sLinha := sLinha + AlinharTexto('0', 10);
    sLinha := sLinha + AlinharTexto('0', 10);
    sLinha := sLinha + AlinharTexto('0', 10);
    sLinha := sLinha + AlinharTexto('0', 10);

    Inc(FTotalLinhaBlocoE);
    Inc(FTotalizadorRegistros[Pred(Length(FTotalizadorRegistros))].Total);
    //WriteLn(FArquivo, sLinha);
    FSPEDFile.Add(sLinha);
  end;
end;

function TmrSPEDFiscal.ReturnNumber(text: String): String;
var
  i : Integer;
begin
  i := 1;
  while i <= Length(text) do
     begin
     if not (text[i] in ['0'..'9']) then
        Delete(text, i, 1);
     inc(i);
     end;
  Result := text;
end;

end.
