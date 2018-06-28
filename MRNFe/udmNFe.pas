unit udmNFe;

interface

uses
  SysUtils, Classes, ACBrNFeDANFEClass, ACBrNFeDANFERave, ACBrNFe, ACBrNFeNotasFiscais, pcnNFE, pcnConversao,
  Dialogs;

const
  NFE_RESULT_LOT_SUCESSO = 103;
  NFE_RESULT_DUPLICIDADE = 204;
  NFE_RESULT_SUCESSO     = 106;

  NFE_TEMP_FILE          = 'C:\temp.xml';

type
  TdmNFe = class(TDataModule)
    ACBrNFe: TACBrNFe;
    ACBrNFeDANFERave: TACBrNFeDANFERave;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function IntToFormaEmissao(i: integer): TpcnTipoEmissao;
    function IntToAmbiente(i: integer): TpcnTipoAmbiente;
    function IntToTipoDanfe(i: integer): TpcnTipoImpressao;

    procedure ConsultaNotaCorrente;
    procedure EnviaNotaCorrente;
    procedure ImprimeNotaCorrente(XML : WideString);
    procedure CancelaNotaCorrente;
  public
    procedure ReadConfig;
    procedure EnviaNotasSelecionadas;
    procedure ImprimirNotasSelecionadas;
    procedure ConsultaNotasSelecionadas;
    procedure CancelaNotasSelecionadas;
    procedure InutilizaNotas;
  end;

var
  dmNFe: TdmNFe;

implementation

uses udmSQL, uFrmProgresso, IniFiles, uFrmUnitilizaNota;

{$R *.dfm}

{ TdmNFe }

procedure TdmNFe.ConsultaNotasSelecionadas;
var
  frmWait: TfrmProgresso;
begin
  frmWait := TFrmProgresso.Create(Self);
  try
    with dmSQL.daNotaFiscal do begin
      // Mostra o formulario de progresso
      frmWait.Start(SelectedCount);
      // Navega para a primeira nota (selecionada ou nao)
      First;
      // Laco pelas notas selecionadas
      // Se a corrente ja esta selecionada, ProximaSelecionada nao faz nada
      while ProximaSelecionada and not frmWait.Cancelar do begin
        // Consulta a nota corrente
        ConsultaNotaCorrente;;
        // Atualiza a progressbar
        frmWait.StepUp;
        // vai para a proxima nota
        Next;
      end;
    end;

  finally
    frmWait.Free;
  end;
end;

procedure TdmNFe.EnviaNotasSelecionadas;
var
  frmWait: TfrmProgresso;
begin
  frmWait := TFrmProgresso.Create(Self);
  try
    with dmSQL.daNotaFiscal do begin
      // Mostra o formulario de progresso
      frmWait.Start(SelectedCount);
      // Navega para a primeira nota (selecionada ou nao)
      First;
      // Laco pelas notas selecionadas
      // Se a corrente ja esta selecionada, ProximaSelecionada nao faz nada
      while ProximaSelecionada and not frmWait.Cancelar do begin
        // Envia a nota corrente
        EnviaNotaCorrente;
        // Atualiza a progressbar
        frmWait.StepUp;
        // vai para a proxima nota
        Next;
      end;
    end;

  finally
    frmWait.Free;
  end;
end;

procedure TdmNFe.ConsultaNotaCorrente;
var
  sPath : String;
begin

  if (dmSQL.RetornaXMLNotaFiscal <> '') then
  begin
    with TStringList.Create do
    try
      Text := dmSQL.RetornaXMLNotaFiscal;
      SaveToFile(NFE_TEMP_FILE);
      sPath := NFE_TEMP_FILE;
    finally
      Free;
    end;

    if FileExists(sPath) then
    begin
      ACBrNFe.NotasFiscais.Clear;
      ACBrNFe.NotasFiscais.LoadFromFile(sPath);
      ACBrNFe.Consultar;
      if ACBrNFe.WebServices.Retorno.cStat in [0, NFE_RESULT_LOT_SUCESSO, NFE_RESULT_DUPLICIDADE, NFE_RESULT_SUCESSO] then
      begin
        // Grava o sucesso
        dmSQL.SalvaAprovacaoEnvio(ACBrNFe.WebServices.Consulta.RetWS);
        ImprimeNotaCorrente('');
      end;

    end;
  end;

end;

procedure TdmNFe.EnviaNotaCorrente;
var
  aNFe: TNFe;
  sXMLEnviado, sXMLRecebido: WideString;
  sNFe : String;
begin
  try
    // Limpar os dados do componente de envio
    ACBrNFe.NotasFiscais.Clear;

    // Criar uma nova nota no componente
    aNFe := ACBrNFe.NotasFiscais.Add.NFe;

    // Preencher a nota fiscal recem criada a partir do banco
    dmSQL.PreecheNotaFiscal(aNFe);

    // Realiza o envio
    ACBrNFe.Enviar(0,False);

    // Recolhe os XMLs
    sXMLEnviado := UTF8Encode(ACBrNFe.NotasFiscais.Items[0].XML);
    sXMLRecebido := UTF8Encode(ACBrNFe.WebServices.Enviar.RetWS);

    //Retornar o ID da nota fiscal eletronica (Verificar se tem outro methodo)
    sNFe := Copy(sXMLEnviado, Pos('Id="', sXMLEnviado)+4, Pos('Id="', sXMLEnviado)+50);
    sNFe := Copy(sNFe, 1, Pos('">', sNFe)-2);

    // Grava o sucesso
    dmSQL.SalvaEnvioCompleto(sXMLEnviado, sXMLRecebido, sNFe);
    //Imprime nota corrente
    ImprimeNotaCorrente(sXMLEnviado);
  except
    on E: Exception do begin
      // Recolhe os XMLs
      sXMLEnviado := UTF8Encode(ACBrNFe.NotasFiscais.Items[0].XML);
      sXMLRecebido := UTF8Encode(ACBrNFe.WebServices.Enviar.RetWS);

      if ACBrNFe.WebServices.Retorno.cStat in [NFE_RESULT_LOT_SUCESSO, NFE_RESULT_DUPLICIDADE, NFE_RESULT_SUCESSO] then
        // Grava o sucesso
        dmSQL.SalvaSucessoEnvio(sXMLEnviado, sXMLRecebido, sNFe)
      else
        // Grava a falha
        dmSQL.SalvaFalhaEnvio(sXMLEnviado, sXMLRecebido, E.Message);

    end;
  end;
end;

procedure TdmNFe.DataModuleCreate(Sender: TObject);
begin
  dmNFe.ReadConfig;
  ACBrNFeDANFERave.CasasDecimais._qCom   := dmSQL.FDecimal;
  ACBrNFeDANFERave.CasasDecimais._vUnCom := dmSQL.FDecimal;
end;

procedure TdmNFe.ReadConfig;
begin
  with TIniFile.Create( ChangeFileExt( ParamStr(0), '.ini') ) do
  try
    ACBrNFe.Configuracoes.Certificados.NumeroSerie := ReadString( 'Certificado','NumSerie','');
    ACBrNFe.Configuracoes.Geral.FormaEmissao       := IntToFormaEmissao(ReadInteger( 'Geral', 'FormaEmissao',1));
    ACBrNFe.Configuracoes.WebServices.UF           := ReadString( 'WebService', 'UF', 'RJ');
    ACBrNFe.Configuracoes.WebServices.Ambiente     := IntToAmbiente(ReadInteger( 'WebService', 'Ambiente', 1));
    dmSQL.FAmbiente                                := ACBrNFe.Configuracoes.WebServices.Ambiente; //set o tipo de ambiente para o DM
    ACBrNFe.Configuracoes.Geral.PathSalvar         := ReadString( 'Geral','PathSalvar','');
    ACBrNFe.Configuracoes.Geral.Salvar             := ReadBool( 'Geral','Salvar', False);
    ACBrNFeDANFERave.TipoDANFE                     := IntToTipoDanfe(ReadInteger( 'Geral', 'DANFE',1));
    ACBrNFeDANFERave.Logo                          := ReadString( 'Geral', 'LogoMarca', '');
    ACBrNFeDANFERave.RavFile                       := ReadString( 'Geral', 'RavFile', '');
    ACBrNFeDANFERave.Sistema                       := 'MainRetail';
    ACBrNFeDANFERave.Email                         := ReadString( 'Empresa','Email','');
    ACBrNFeDANFERave.Site                          := ReadString( 'Empresa','Website','');
    dmSQL.FCalcFreete                              := ReadBool( 'MR','CalcFrete', True);
    dmSQL.FHideItemDesc                            := ReadBool( 'MR','HideDescontoItem', False);
    dmSQL.FIDEmpresaVenda                          := StrToIntDef(ReadString('MR','IDEmpresa',''), 0);
    dmSQL.FDecimal                                 := ReadInteger( 'MR','Decimal', 2);
    dmSQL.FNumCopia                                := ReadInteger( 'MR','NumCopia', 1);
  finally
    Free;
  end;
end;

function TdmNFe.IntToFormaEmissao(i: integer): TpcnTipoEmissao;
begin
  case i of
    0: result := teNormal;
    1: result := teContingencia;
    2: result := teSCAN;
    3: result := teDPEC;
    4: result := teFSDA;
    else
       result := teNormal;
  end;
end;

function TdmNFe.IntToAmbiente(i: integer): TpcnTipoAmbiente;
begin
  case i of
    0: result := taProducao;
    1: result := taHomologacao;
    else
       result := taHomologacao;
  end;
end;

function TdmNFe.IntToTipoDanfe(i: integer): TpcnTipoImpressao;
begin
  case i of
    0: result := tiRetrato;
    1: result := tiPaisagem;
    else
       result := tiRetrato;
  end;
end;
procedure TdmNFe.ImprimirNotasSelecionadas;
begin

  with dmSQL.daNotaFiscal do
  begin
    // Navega para a primeira nota (selecionada ou nao)
    First;
    // Laco pelas notas selecionadas
    // Se a corrente ja esta selecionada, ProximaSelecionada nao faz nada
    while ProximaSelecionada do
    begin
      // Imprime a nota corrente
      ImprimeNotaCorrente('');
      // vai para a proxima nota
      Next;
    end;
  end;

end;

procedure TdmNFe.ImprimeNotaCorrente(XML : WideString);
var
  sPath : String;
  i : Integer;
begin

  if XML = '' then
    XML := dmSQL.RetornaXMLNotaFiscal;

  if (XML <> '') then
  begin
    with TStringList.Create do
    try
      Text := XML;
      SaveToFile(NFE_TEMP_FILE);
      sPath := NFE_TEMP_FILE;
    finally
      Free;
    end;

    if FileExists(sPath) then
    begin
      ACBrNFe.NotasFiscais.Clear;
      ACBrNFe.NotasFiscais.LoadFromFile(sPath);
      for i:=1 to dmSQL.FNumCopia do
        ACBrNFe.NotasFiscais.Imprimir;
      dmSQL.SalvaImpressao;
    end;
  end;

end;

procedure TdmNFe.CancelaNotasSelecionadas;
begin

  with dmSQL.daNotaFiscal do
  begin
    // Navega para a primeira nota (selecionada ou nao)
    First;
    // Laco pelas notas selecionadas
    // Se a corrente ja esta selecionada, ProximaSelecionada nao faz nada
    while ProximaSelecionada do
    begin
      // Cancela a nota corrente
      CancelaNotaCorrente;
      // vai para a proxima nota
      Next;
    end;
  end;

end;

procedure TdmNFe.CancelaNotaCorrente;
var
  sPath, vAux : String;
begin

  if (dmSQL.RetornaXMLNotaFiscal <> '') then
  begin
    with TStringList.Create do
    try
      Text := dmSQL.RetornaXMLNotaFiscal;
      SaveToFile(NFE_TEMP_FILE);
      sPath := NFE_TEMP_FILE;
    finally
      Free;
    end;

    if FileExists(sPath) then
      if (InputQuery('Cancelamento da NF-e', 'Justificativa :', vAux)) then
      begin
        ACBrNFe.NotasFiscais.Clear;
        ACBrNFe.NotasFiscais.LoadFromFile(sPath);
        ACBrNFe.Cancelamento(vAux);
        dmSQL.SalvaCancelamentoEnvio(ACBrNFe.WebServices.Cancelamento.RetWS);
      end;
  end;

end;

procedure TdmNFe.InutilizaNotas;
var
  CNPJ, Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa : String;
  sXMLRecebido: WideString;
begin

  with TFrmUnitilizaNota.Create(Self) do
  try
    if Start(CNPJ, Modelo, Serie, Ano, NumeroInicial, NumeroFinal, Justificativa) then
    begin
      ACBrNFe.WebServices.Inutiliza(CNPJ, Justificativa, StrToInt(Ano), StrToInt(Modelo), StrToInt(Serie), StrToInt(NumeroInicial), StrToInt(NumeroFinal));
      sXMLRecebido := ACBrNFe.WebServices.Inutilizacao.RetWS;
    end;

  finally
    Free;
  end;

end;

end.

