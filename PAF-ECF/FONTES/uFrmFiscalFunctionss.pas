unit uFrmFiscalFunctions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFrmFiscalFunctions = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    //BEMATECH ----------------------------------------------
    function Bematech_AbrirPorta:Boolean;
    function Bematech_FecharPorta:Boolean;
    function Bematech_AbrirCupomFiscal(CGC:String):Boolean;
    //Tributo = Taxa
    function Bematech_InserirItem(Codigo, Descricao, Tributo:String;
                                  Qtd : Integer; ValorUnit, Desconto: Double):Boolean;
    function Bematech_RemoveUltimoItem:Boolean;
    function Bematech_CancelaCupom:Boolean;
    //Desc - Desconto, TipoDesc - Tipo de desconto('%' para percentual ou '$' para valor),
    //AC - (Acrescimio ou desconto)
    function Bematech_IniciarFechamentoCupom(Desc:Double;TipoDesc:String;AC:Char):Boolean;
    //TipoPag - Tipo de pagamento, Desc - Desconto, Tipo Desc - Tipo desconto(%),
    //AC - (Acrescimio ou desconto), Valor Pago - Valor total pago (Troco), MsgParam - Msg promocional
    function Bematech_FecharCupom(TipoPag:String; Desc:Double;TipoDesc:String;
                                  AC:Char; ValorPago:Double; MsgParam:String):Boolean;
    function Bematech_EfetuaPagamento(PagForma : String; TotalPag:Double):Boolean;
    function Bematech_FechaCupomResumido(PagForma, Msg : String):Boolean;
    function Bematech_TerminaFechamentoCupom( Mensagem: String): Boolean;
    // para controle quando abrir e fechar o caixa
    function Bematech_AberturaDoDia(valorcompra,formapag:String):Boolean;
    function Bematech_FechamentoDoDia:Boolean;
    // Funções de Impressão de Cheques
    function Bematech_ProgramaMoedaSingular( ValorNomeSingular: String ): Boolean;
    function Bematech_ProgramaMoedaPlural( ValorNomePlural: String ): Boolean;
    function Bematech_CancelaImpressaoCheque: Boolean;
    function Bematech_VerificaStatusCheque( var StatusCheque: Integer ): Boolean;
    function Bematech_ImprimeCheque( nrBanco: String; ValorDoCheque: String; NomeDoFavorecido: String; Cidade: String; Data: String; Mensagem: String ): Boolean;
    function Bematech_IncluiCidadeFavorecido( NomeCidade: String; NomeDoFavorecido: String ): Boolean;
    function Bematech_ImprimeCopiaCheque: Boolean;
    // Funções dos Relatórios Fiscais Gerenciais
    function Bematech_RelatorioGerencial( Texto: String ): Boolean;
    function Bematech_FechaRelatorioGerencial: Boolean;
    // Funções de Autenticação e Gaveta de Dinheiro
    function Bematech_Autenticacao:Boolean;
    function Bematech_ProgramaCaracterAutenticacao( Parametros: String ): Boolean;
    function Bematech_AcionaGaveta:Boolean;
    function Bematech_VerificaEstadoGaveta( var EstadoGaveta: Integer ): Boolean;

  end;

implementation

uses uBematech, uNumericFunctions;

{$R *.dfm}

function TFrmFiscalFunctions.Bematech_FechaCupomResumido(PagForma, Msg : String):Boolean;
begin
   Result := (Bematech_FI_FechaCupomResumido(PagForma, Msg)<>0);
end;

function TFrmFiscalFunctions.Bematech_EfetuaPagamento(PagForma : String; TotalPag:Double):Boolean;
begin
   Result := (Bematech_FI_EfetuaFormaPagamento(PagForma,
                                               MyFormatCur(TotalPag,DecimalSeparator))<>0);
end;

function TFrmFiscalFunctions.Bematech_AbrirPorta:Boolean;
begin
   Result := (Bematech_FI_AbrePortaSerial<>0);
end;

function TFrmFiscalFunctions.Bematech_FecharPorta:Boolean;
begin
   Result := (Bematech_FI_FechaPortaSerial<>0);
end;

function TFrmFiscalFunctions.Bematech_FecharCupom(TipoPag:String; Desc:Double;TipoDesc:String;
                                  AC:Char; ValorPago:Double; MsgParam:String):Boolean;
begin
{
Bematech_FI_FechaCupom('VISA',
                                    '0',
                                    '%',
                                    'd',
                                    '0',
                                    'Minha msg');
}

  Result := (Bematech_FI_FechaCupom(TipoPag,
                                    MyFormatCur(Desc,DecimalSeparator),
                                    TipoDesc,
                                    AC,
                                    MyFormatCur(ValorPago,DecimalSeparator),
                                    MsgParam)<>0);


end;

function TFrmFiscalFunctions.Bematech_IniciarFechamentoCupom(Desc:Double;TipoDesc:String;AC:Char):Boolean;
begin
  Result := (Bematech_FI_IniciaFechamentoCupom(MyFormatCur(Desc,DecimalSeparator),
                                               TipoDesc,
                                               AC)<>0);
end;

function TFrmFiscalFunctions.Bematech_TerminaFechamentoCupom(Mensagem: String):Boolean;
begin
  Result := (Bematech_FI_TerminaFechamentoCupom( Mensagem)<>0);
end;

function TFrmFiscalFunctions.Bematech_CancelaCupom:Boolean;
begin
  Result := (Bematech_FI_CancelaCupom()<>0);
end;

function TFrmFiscalFunctions.Bematech_RemoveUltimoItem:Boolean;
begin
  Result := (Bematech_FI_CancelaItemAnterior()<>0);
end;

function TFrmFiscalFunctions.Bematech_InserirItem(Codigo, Descricao, Tributo :String;
                                                  Qtd : Integer; ValorUnit, Desconto: Double):Boolean;
var
  sTipoQtde, sTipoDesconto : String;
  iDecimal : Integer;
  //iError : Integer;
begin
    // Verifica o Tipo da Quantidade:
    // 'I' para Inteira ou 'F' para Fracionária
    sTipoQtde := 'I';
    //If RadioButton1.Checked = True Then Begin sTipoQtde := 'I' End;
    //If RadioButton2.Checked = True Then Begin sTipoQtde := 'F' End;
    // Verifica o Tipo de Decimal:
    // 2 para duas casas ou 3 para três casas
    iDecimal := 2;
    //If RadioButton3.Checked = True Then Begin iDecimal := 2 End;
    //If RadioButton4.Checked = True Then Begin iDecimal := 3 End;
    // Verifica o Tipo de Desconto:
    // '%' para percentual ou '$' para valor
    sTipoDesconto := '$';
    //If RadioButton5.Checked = True Then Begin sTipoDesconto := '%' End;
    //If RadioButton6.Checked = True Then Begin sTipoDesconto := '$' End;
    {envia para a impressora fiscal}
    Result := (Bematech_FI_VendeItem(Codigo,
                                     Descricao,
                                     Tributo,
                                     sTipoQtde,
                                     //MyFormatCur(Qtd,DecimalSeparator),
                                     IntToStr(Qtd),
                                     iDecimal,
                                     MyFormatCur(ValorUnit, DecimalSeparator),
                                     sTipoDesconto,
                                     MyFormatCur(Desconto,DecimalSeparator))<>0);
end;

function TFrmFiscalFunctions.Bematech_AbrirCupomFiscal(CGC:String):Boolean;
begin
   Result := (Bematech_FI_AbreCupom(PCHAR(CGC))<>0);
end;

function TFrmFiscalFunctions.Bematech_AberturaDoDia(valorcompra,formapag:String):Boolean;
begin
   Result := (Bematech_FI_AberturaDoDia(valorcompra,formapag)<>0);
end;

function TFrmFiscalFunctions.Bematech_FechamentoDoDia:Boolean;
begin
   Result := (Bematech_FI_FechamentoDoDia<>0);
end;

function TFrmFiscalFunctions.Bematech_ProgramaMoedaSingular( ValorNomeSingular: String ): Boolean;
begin
   Result := (Bematech_FI_ProgramaMoedaSingular(ValorNomeSingular)<>0);
end;

function TFrmFiscalFunctions.Bematech_ProgramaMoedaPlural( ValorNomePlural: String ): Boolean;
begin
   Result := (Bematech_FI_ProgramaMoedaPlural(ValorNomePlural)<>0);
end;

function TFrmFiscalFunctions.Bematech_CancelaImpressaoCheque: Boolean;
begin
   Result := (Bematech_FI_CancelaImpressaoCheque<>0);
end;

function TFrmFiscalFunctions.Bematech_VerificaStatusCheque( var StatusCheque: Integer ): Boolean;
begin
   Result := (Bematech_FI_VerificaStatusCheque(StatusCheque)<>0);
end;

function TFrmFiscalFunctions.Bematech_ImprimeCheque( nrBanco: String; ValorDoCheque: String; NomeDoFavorecido: String; Cidade: String; Data: String; Mensagem: String ): Boolean;
begin
   Result := (Bematech_FI_ImprimeCheque(nrBanco,ValorDoCheque,NomeDoFavorecido,cidade,data,mensagem)<>0);
end;

function TFrmFiscalFunctions.Bematech_IncluiCidadeFavorecido( NomeCidade: String; NomeDoFavorecido: String ): Boolean;
begin
   Result := (Bematech_FI_IncluiCidadeFavorecido(NomeCidade,NomeDofavorecido)<>0);
end;

function TFrmFiscalFunctions.Bematech_ImprimeCopiaCheque: Boolean;
begin
   Result := (Bematech_FI_ImprimeCopiaCheque<>0);
end;

function TFrmFiscalFunctions.Bematech_RelatorioGerencial( Texto: String ): Boolean;
begin
   Result := (Bematech_FI_RelatorioGerencial( Texto )<>0);
end;

function TFrmFiscalFunctions.Bematech_FechaRelatorioGerencial: Boolean;
begin
   Result := (Bematech_FI_FechaRelatorioGerencial<>0);
end;

function TFrmFiscalFunctions.Bematech_Autenticacao:Boolean;
begin
   Result := (Bematech_FI_FechaRelatorioGerencial<>0);
end;

function TFrmFiscalFunctions.Bematech_ProgramaCaracterAutenticacao( Parametros: String ): Boolean;
begin
   Result := (Bematech_FI_ProgramaCaracterAutenticacao( Parametros )<>0);
end;

function TFrmFiscalFunctions.Bematech_AcionaGaveta:Boolean;
begin
   Result := (Bematech_FI_AcionaGaveta<>0);
end;

function TFrmFiscalFunctions.Bematech_VerificaEstadoGaveta( var EstadoGaveta: Integer ): Boolean;
begin
   Result := (Bematech_FI_VerificaEstadoGaveta(estadogaveta)<>0);
end;

end.
