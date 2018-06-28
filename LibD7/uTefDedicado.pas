unit uTefDedicado;

interface

uses
  SysUtils, Classes, Windows, Dialogs, Controls, uTEFTypes,
  uTefDedicadoInterface, IniFiles;

const
  STATUS_CONTINUE = 10000;
  STATUS_OK = 0;
  STATUS_SEM_CONEXAO = -5;
  TAM_SITEF_BUFFER = 20000;

  FUNCAO_PAGAMENTO = 0;
  FUNCAO_TRANS_GERENCIAIS = 110;
  FUNCAO_TESTE_COMUNICACAO = 111;
  FUNCAO_CANCELAMENTO = 200;
  TEMPO_ENTRE_LINHAS = 0;

  PERSISTENCE_FILE = 'TEFDED.ini';

  CHAVE_CUPOMFISCAL = 'CupomFiscal';
  CHAVE_DATAFISCAL = 'DataFiscal';
  CHAVE_HORAFISCAL = 'HoraFiscal';
  CHAVE_TEXTO_DESC = 'TextoDesc';

  FLUXO_CONTINUA = 0;
  FLUXO_VOLTAR   = 1;
  FLUXO_ABORTA   = -1;

type
  TFormaPgto = (fpCartaoCredito, fpCartaoDebito, fpCheque);

  TSizedStrPos = (sspLeft, sspRight);

  TIniciaFuncaoError = procedure(Sender: TObject; Retorno: Integer) of Object;
  TResultCommand = procedure(Sender: TObject; Comando, TipoCampo, Retorno: Integer; Msg: String) of Object;


  TExecutaComandoInputText = procedure(Sender: TObject; Msg: String; TamMin, TamMax: Integer; var CampoInput: String; const Comando, TipoCampo: Integer) of Object;
  TExecutaComandoInputDouble = procedure(Sender: TObject; Msg: String; TamMin, TamMax: Integer; var CampoInput: Double) of Object;
  TExecutaComando0 = procedure(Sender: TObject; TipoCampo: Integer; Msg: String) of Object;
  TExecutaComandoMsgOpcao = procedure(Sender: TObject; Msg: String; var Opcao: String) of Object;


  PConfiguraIntSiTefInterativo = function(
                                        EndSitef: PChar;
                                        IdLoja: PChar;
                                        IdTerminal: PChar;
                                        Reservado: Smallint
                                       ): LongInt; stdcall;

  PIniciaFuncaoSiTefInterativo = function(
                                     Funcao: LongInt;
                                     Valor: PChar;
                                     CuponFiscal: PChar;
                                     DataFiscal: PChar;
                                     HoraFiscal: PChar;
                                     Operador: PChar;
                                     ParamAdic: PChar;
                                     Produtos: PChar
                                    ): LongInt; stdcall;

  PContinuaFuncaoSiTefInterativo = function(
                                       var Comando: LongInt;
                                       var TipoCampo: LongInt;
                                       var TamMinimo: SmallInt;
                                       var TamMaximo: SmallInt;
                                       Buffer: PChar;
                                       const TamBuffer: LongInt;
                                       const Continua: LongInt
                                     ): LongInt; stdcall;

  PEscreveMensagemPermanentePinPad = function(
                                       Mensagem: PChar
                                     ): LongInt; stdcall;

  PFinalizaTransacaoSiTefInterativo = function (smallint: Word;
            pNumeroCuponFiscal: PChar;
            pDataFiscal: PChar;
            pHorario: PChar): LongInt; StdCall;

  PLeCartaoInteravito = function (
                                 Mensagem: PChar
                                 ): LongInt; stdcall;

  PLeCartaoDireto = function (
                                 Mensagem: PChar;
                                 Trilha1: PChar;
                                 Trilha2: PChar
                                 ): LongInt; stdcall;

  PInterrompdLeCartaoDireto = procedure(); stdcall;

  PLeCartaoDiretoEx = function (
                                 Mensagem: PChar;
                                 Trilha1: PChar;
                                 Trilha2: PChar;
                                 TimeOut: SmallInt;
                                 TestaCancelamento: SmallInt
                                 ): LongInt; stdcall;

  PLeSenhaInterativo = function (
                                 Parametros: PChar
                                 ): LongInt; stdcall;

  PLeSenhaDireto = function (
                                 Parametros: PChar;
                                 SenhaCliente: PChar
                                 ): LongInt; stdcall;

  TTEFOutput = class
  public
    CupomFiscal: String;
    TextoDescritivo: String;
    DataHora: String;
    PrimeiraVia: TStringList;
    SegundaVia: TStringList;
    NSU: String;
    NSUHost: String;
    Autorizacao: String;
    AutenticacaoCheque: String;
    Modalidade: String;
    VinculadoInfo: TVinculadoInfo;
    Imprime: Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

  TTEFDedicado = class(TComponent)
  private
    FHandleDLL: THandle;
    FNomeDll: String;
    FIPServidor: String;
    FCodigoLoja: String;
    FNumeroTerminal: String;
    FOnIniciaFuncaoError: TIniciaFuncaoError;
    ConfiguraIntSiTefInterativo: PConfiguraIntSiTefInterativo;
    IniciaFuncaoSiTefInterativo: PIniciaFuncaoSiTefInterativo;
    ContinuaFuncaoSiTefInterativo: PContinuaFuncaoSiTefInterativo;
    FinalizaTransacaoSiTefInterativo: PFinalizaTransacaoSiTefInterativo;
    EscreveMensagemPermanentePinPad: PEscreveMensagemPermanentePinPad;
    LeCartaoInteravito: PLeCartaoInteravito;
    LeCartaoDireto: PLeCartaoDireto;
    InterrompdLeCartaoDireto: PInterrompdLeCartaoDireto;
    LeCartaoDiretoEx: PLeCartaoDiretoEx;
    LeSenhaInterativo: PLeSenhaInterativo;
    LeSenhaDireto: PLeSenhaDireto;
    FOnResultCommand: TResultCommand;
    FOnExecutaComando0: TExecutaComando0;

    FOnExecutaComando4: TExecutaComandoMsg;
    FOnExecutaComando14: TExecutaComando;

    FOnExecutaComando20: TExecutaComandoMsgOpcao;
    FOnExecutaComando21: TExecutaComandoMsgOpcao;
    FOnExecutaComando30: TExecutaComandoInputText;
    FOnExecutaComando31: TExecutaComandoMsgOpcao;
    FOnExecutaComando34: TExecutaComandoInputDouble;
    FOnExecutaComando23: TExecutaComandoMsgOpcao;
    FOnExecutaComando35: TExecutaComandoMsgOpcao;
    FOnExecutaComandoSenha: TExecutaComandoInputText;

    FSiTefLoaded: Boolean;
    FBuffer: PChar;
    FTEFOutputList: TList;
    FBloqueiaTeclado: Boolean;
    FOnNeedCloseGerencial: TTEFNeedClosePrint;
    FOnNeedCloseVinculado: TTEFNeedClosePrint;
    FOnNeedOpenGerencial: TTEFNeedOpenPrint;
    FOnNeedOpenVinculado: TTEFNeedOpenPrintVinculado;
    FOnNeedPrintLineGerencial: TTEFNeedPrintLine;
    FOnNeedPrintLineVinculado: TTEFNeedPrintLine;
    FOnStatusPrinter: TTEFStatusPrinter;
    FOnTryAgainDialog: TTEFTryAgainDialog;
    FLinhaVazia: String;
    FTempVinculadoInfo: TVinculadoInfo;
    FConectado: Boolean;
    FTefDedicadoInterface: TTefDedicadoInterface;
    FMensagemPinPad: String;
    FIniFile: TIniFile;
    FDataFiscal: String;
    FCupomFiscal: String;
    FHorafiscal: String;
    FFuncao: LongInt;
    function CarregaSiTef: Boolean;
    function ContinuaFuncao: LongInt;
    procedure DescarregaSiTef;
    function GetTEFOutputList(Index: Integer): TTEFOutput;

    procedure AddOutput(AImprime : Boolean);
    procedure ClearOutPutList;
    function GetCurrentOutPut: TTEFOutput;
    function ImprimeTudo(NeedVinculado: Boolean): Boolean;
    function AvancaLinhasGerencial(Count: Integer): Boolean;
    function AvancaLinhasVinculado(Count: Integer): Boolean;
    function DoOnNeedCloseGerencial: Boolean;
    function DoOnNeedCloseVinculado: Boolean;
    function DoOnNeedOpenGerencial: Boolean;
    function DoOnNeedOpenVinculado(AVinculadoInfo: TVinculadoInfo): Boolean;
    function DoOnNeedPrintLineGerencial(LineToPrint: String): Boolean;
    function DoOnNeedPrintLineVinculado(LineToPrint: String): Boolean;
    function DoOnTryAgainDialog: Boolean;
    function LinhaNaoNula(S: String): String;
    function PrintTEFGerencial(var VinculadoAberto,
      GerencialAberto: Boolean): Boolean;
    function PrintTEFVinculado(var VinculadoAberto: Boolean): Boolean;
    procedure DoOnStatusPrinter(var Online: Boolean);
    procedure MsgCliente(AMsg: String);
    procedure SaveCurrentOutPut;
    procedure ClearIni;
    function TemImpressao: Boolean;

  public
    property SiTefLoaded: Boolean read FSiTefLoaded write FSiTefLoaded;
    property TEFOutputList[Index: Integer]: TTEFOutput read GetTEFOutputList;
    property CupomFiscal: String read FCupomFiscal write FCupomFiscal;
    property DataFiscal: String read FDataFiscal write FDataFiscal;
    property Horafiscal: String read FHorafiscal write FHorafiscal;

    function ConfiguraInt: LongInt;
    function FazTransacao(AModalidade: LongInt; AValor: Double; ANumeroCupom: String;
      AData: TDateTime; AOperador: String; ARestricoes, AProdutos: String;
      AVinculadoInfo: TVinculadoInfo; ATefDedicadoInterface: TTefDedicadoInterface): LongInt;
    function ConfirmaTransacao: Boolean;
    function CancelaTransacao(ACupom, AData, AHora: PChar): Boolean;

    function TemPendencia: Boolean;

    function ResolvePendencias: Boolean;

    function TestaCominicacao(ATefDedicadoInterface: TTefDedicadoInterface): Boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property IPServidor: String read FIPServidor write FIPServidor;
    property CodigoLoja: String read FCodigoLoja write FCodigoLoja;
    property NumeroTerminal: String read FNumeroTerminal write FNumeroTerminal;
    property LinhaVazia: String read FLinhaVazia write FLinhaVazia;
    property MensagemPinPad: String read FMensagemPinPad write FMensagemPinPad;
    property BloqueiaTeclado: Boolean read FBloqueiaTeclado write FBloqueiaTeclado;
    property OnIniciaFuncaoError: TIniciaFuncaoError read FOnIniciaFuncaoError write FOnIniciaFuncaoError;
    property OnResultCommand: TResultCommand read FOnResultCommand write FOnResultCommand;
    property OnExecutaComando0: TExecutaComando0 read FOnExecutaComando0 write FOnExecutaComando0;
    property OnExecutaComando4: TExecutaComandoMsg read FOnExecutaComando4 write FOnExecutaComando4;

    property OnExecutaComando14: TExecutaComando read FOnExecutaComando14 write FOnExecutaComando14;

    property OnExecutaComando20: TExecutaComandoMsgOpcao read FOnExecutaComando20 write FOnExecutaComando20;
    property OnExecutaComando21: TExecutaComandoMsgOpcao read FOnExecutaComando21 write FOnExecutaComando21;
    property OnExecutaComando23: TExecutaComandoMsgOpcao read FOnExecutaComando23 write FOnExecutaComando23;

    property OnExecutaComando30: TExecutaComandoInputText read FOnExecutaComando30 write FOnExecutaComando30;
    property OnExecutaComando31: TExecutaComandoMsgOpcao read FOnExecutaComando31 write FOnExecutaComando31;
    property OnExecutaComando34: TExecutaComandoInputDouble read FOnExecutaComando34 write FOnExecutaComando34;
    property OnExecutaComando35: TExecutaComandoMsgOpcao read FOnExecutaComando35 write FOnExecutaComando35;
    property OnExecutaComandoSenha: TExecutaComandoInputText read FOnExecutaComandoSenha write FOnExecutaComandoSenha;

    property OnNeedOpenVinculado:      TTEFNeedOpenPrintVinculado  read FOnNeedOpenVinculado      write FOnNeedOpenVinculado;
    property OnNeedOpenGerencial:      TTEFNeedOpenPrint           read FOnNeedOpenGerencial      write FOnNeedOpenGerencial;
    property OnNeedCloseVinculado:     TTEFNeedClosePrint          read FOnNeedCloseVinculado     write FOnNeedCloseVinculado;
    property OnNeedCloseGerencial:     TTEFNeedClosePrint          read FOnNeedCloseGerencial     write FOnNeedCloseGerencial;
    property OnNeedPrintLineGerencial: TTEFNeedPrintLine           read FOnNeedPrintLineGerencial write FOnNeedPrintLineGerencial;
    property OnNeedPrintLineVinculado: TTEFNeedPrintLine           read FOnNeedPrintLineVinculado write FOnNeedPrintLineVinculado;
    property OnTryAgainDialog:         TTEFTryAgainDialog          read FOnTryAgainDialog         write FOnTryAgainDialog;
    property OnStatusPrinter:          TTEFStatusPrinter           read FOnStatusPrinter          write FOnStatusPrinter;

  end;

procedure Register;

implementation



procedure BlockInput(Block: LongBool);stdcall;external 'USER32.DLL';

function MyFormatCur(Value: Double; Decimal: Char): String;
var
  OldDecimalSeparator: Char;
begin
  OldDecimalSeparator  := DecimalSeparator;
  DecimalSeparator := Decimal;
  Result := FormatCurr('0.00',Value);
  DecimalSeparator := OldDecimalSeparator;
end;

function SizedStr(S: String; ALength: Integer; C: Char;
  StrPos: TSizedStrPos): String;
begin
  Result := Copy(S, 1, ALength);
  if Length(Result) < ALength then
    case StrPos of
      sspLeft:  Result := StringOfChar(C, ALength - Length(Result)) + Result;
      sspRight: Result := Result + StringOfChar(C, ALength - Length(Result));
    end;
end;

function InitPChar(Len: Integer): PChar;
begin
  Result := AllocMem(Succ(Len));
end;

function AllocPChar(S: String): PChar;
begin
  Result := InitPChar(Length(S));
  StrPCopy(Result, S);
end;

procedure UnallocPChar(P: PChar);
begin
  FreeMem(P, Sizeof(P));
end;


procedure Register;
begin
  RegisterComponents('MainRetail', [TTEFDedicado]);
end;

{ TTEFDedicado }

constructor TTEFDedicado.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHandleDLL := 0;
  FSiTefLoaded := False;
  FBuffer := nil;
  FTempVinculadoInfo := nil;
  FTefDedicadoInterface := nil;
  FConectado := False;
  if not (csDesigning in ComponentState) then
  begin
    FTEFOutputList := TList.Create;
    FIniFile := TIniFile.Create(PERSISTENCE_FILE);
  end;
end;

destructor TTEFDedicado.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    FTefDedicadoInterface := nil;
    if FSiTefLoaded then
      DescarregaSiTef;
    ClearOutPutList;
    FTEFOutputList.Free;
    FIniFile.Free;
  end;
  inherited Destroy;
end;

function TTEFDedicado.CarregaSiTef: Boolean;
begin
  Result := True;
  try
    if FSiTefLoaded then
      Exit;

    @ConfiguraIntSiTefInterativo := nil;
    @IniciaFuncaoSiTefInterativo := nil;
    @ContinuaFuncaoSiTefInterativo := nil;
    @FinalizaTransacaoSiTefInterativo := nil;

    FBuffer := InitPChar(TAM_SITEF_BUFFER);

    FNomeDll := 'CliSiTef32I.dll';
    FHandleDLL := LoadLibrary(PChar(FNomeDll));

    if FHandleDLL = 0 then
      raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [FNomeDll, GetLastError]);

    @ConfiguraIntSiTefInterativo := GetProcAddress(FHandleDLL, 'ConfiguraIntSiTefInterativo');
    @IniciaFuncaoSiTefInterativo := GetProcAddress(FHandleDLL, 'IniciaFuncaoSiTefInterativo');
    @ContinuaFuncaoSiTefInterativo := GetProcAddress(FHandleDLL, 'ContinuaFuncaoSiTefInterativo');
    @FinalizaTransacaoSiTefInterativo := GetProcAddress(FHandleDLL, 'FinalizaTransacaoSiTefInterativo');
    //Opcoes adcionais
    @EscreveMensagemPermanentePinPad := GetProcAddress(FHandleDLL, 'EscreveMensagemPermanentePinPad');
    @LeCartaoInteravito := GetProcAddress(FHandleDLL, 'LeCartaoInteravito');
    @LeCartaoDireto := GetProcAddress(FHandleDLL, 'LeCartaoDireto');
    @InterrompdLeCartaoDireto := GetProcAddress(FHandleDLL, 'InterrompdLeCartaoDireto');
    @LeCartaoDiretoEx := GetProcAddress(FHandleDLL, 'LeCartaoDiretoEx');
    @LeSenhaInterativo := GetProcAddress(FHandleDLL, 'LeSenhaInterativo');
    @LeSenhaDireto := GetProcAddress(FHandleDLL, 'LeSenhaDireto');

  except
    Result := False;
  end;
  FSiTefLoaded := Result;
end;

procedure TTEFDedicado.DescarregaSiTef;
begin
  if FHandleDLL = 0 then
    FSiTefLoaded := False;

  if FBuffer <> nil then
  begin
    UnallocPChar(FBuffer);
    FBuffer := nil;
  end;

  if FSiTefLoaded then
  begin
    if (FreeLibrary(FHandleDLL)) then
    begin
      FHandleDLL := 0;
      FSiTefLoaded := False;
    end;
  end;
end;

procedure TTEFDedicado.MsgCliente(AMsg: String);
begin
  EscreveMensagemPermanentePinPad(PChar(AMsg));
end;


function TTEFDedicado.ConfiguraInt: LongInt;
begin
  Result := -1;

  if CarregaSiTef then
  begin
    Result := ConfiguraIntSiTefInterativo(PChar(FIPServidor), PChar(FCodigoLoja), PChar(FNumeroTerminal), 0);
    FConectado := Result = STATUS_OK;
    MsgCliente(FMensagemPinPad);
  end;
end;


function TTEFDedicado.FazTransacao(AModalidade: LongInt; AValor: Double; ANumeroCupom: String;
  AData: TDateTime; AOperador: String; ARestricoes, AProdutos: String; AVinculadoInfo: TVinculadoInfo;
  ATefDedicadoInterface: TTefDedicadoInterface): LongInt;
var
  Cupom, Valor, Data, Hora, Operador, Restricoes, Produtos: PChar;
begin

  FCupomFiscal := ANumeroCupom;
  FDataFiscal := FormatDateTime('yyyymmdd', AData);
  FHorafiscal := FormatDateTime('hhnnss', AData);

  Cupom := PChar(FCupomFiscal);
  Valor := PChar(MyFormatCur(AValor, ','));
  Data := PChar(FDataFiscal);
  Hora := PChar(FHorafiscal);
  Operador := PChar(AOperador);

  FTefDedicadoInterface := ATefDedicadoInterface;
  FTempVinculadoInfo := AVinculadoInfo;

  if ARestricoes = '' then
    Restricoes := nil
  else
    Restricoes := PChar(ARestricoes);

  if AProdutos = '' then
    Produtos := nil
  else
    Produtos := PChar(AProdutos);

  Result := IniciaFuncaoSiTefInterativo(AModalidade, Valor, Cupom, Data, Hora, Operador, Restricoes, Produtos);

  if (Result <> STATUS_CONTINUE) then
  begin
    if Assigned(OnIniciaFuncaoError) then
      FOnIniciaFuncaoError(Self, Result);
    if FTefDedicadoInterface <> nil then
      FTefDedicadoInterface.DoLimpaMsg(Self);
    Exit;
  end;

  Result := ContinuaFuncao;

end;

function TTEFDedicado.ContinuaFuncao: LongInt;
var
  iComando, iTipoCampo, iContinua: LongInt;
  iTamMin, iTamMax: SmallInt;
  msg, opcao: String;
  dValor: Double;
begin
  iComando := 0;
  iTipoCampo := 0;
  iContinua := 0;
  iTamMin := 0;
  iTamMax := 0;
  AddOutput(False);

  repeat
    Result := ContinuaFuncaoSiTefInterativo(iComando, iTipoCampo, iTamMin, iTamMax, FBuffer, SizeOf(FBuffer) - 1, iContinua);
    msg := StrPas(FBuffer);

    case Result of
      STATUS_CONTINUE:
        case iComando of
          0: begin
               case iTipoCampo of
                 -1, 0:;
                 100: ;
                 101: GetCurrentOutPut.Modalidade := msg;
                 102: GetCurrentOutPut.TextoDescritivo := msg;
                 105: begin
                      GetCurrentOutPut.DataHora := msg;
                      if FFuncao <> FUNCAO_TESTE_COMUNICACAO then
                        SaveCurrentOutPut;
                      end;
                 120: begin
                      GetCurrentOutPut.AutenticacaoCheque := msg;
                      if GetCurrentOutPut.AutenticacaoCheque <> '' then
                        ShowMessage('ANOTAR NO VERSO DO CHEQUE.' + #13#10 + GetCurrentOutPut.AutenticacaoCheque);
                      end;
                 121: begin
                        GetCurrentOutPut.PrimeiraVia.Text := msg;
                        GetCurrentOutPut.Imprime := True;
                      end;
                 122: begin
                        GetCurrentOutPut.SegundaVia.Text := msg;
                        GetCurrentOutPut.Imprime := True;
                      end;
                 133: GetCurrentOutPut.NSU := msg;
                 134: GetCurrentOutPut.NSUHost := msg;
                 135: GetCurrentOutPut.Autorizacao := msg;
                 else;
               end;

               if Assigned(FOnExecutaComando0) then
                 OnExecutaComando0(Self, iTipoCampo, msg);
             end;
             
          1: if FTefDedicadoInterface <> nil then
               FTefDedicadoInterface.DoExecutaComando1(Self, Msg);
          2: if FTefDedicadoInterface <> nil then
               FTefDedicadoInterface.DoExecutaComando2(Self, Msg);
          3: if FTefDedicadoInterface <> nil then
               FTefDedicadoInterface.DoExecutaComando3(Self, Msg);
          4: if Assigned(FOnExecutaComando4) then
               OnExecutaComando4(Self, msg);
          11: if FTefDedicadoInterface <> nil then
               FTefDedicadoInterface.DoExecutaComando11(Self);
          12: if FTefDedicadoInterface <> nil then
               FTefDedicadoInterface.DoExecutaComando12(Self);
          13: if FTefDedicadoInterface <> nil then
               FTefDedicadoInterface.DoExecutaComando13(Self);
          14: if Assigned(FOnExecutaComando14) then
               OnExecutaComando14(Self);
          20: begin
                if Assigned(FOnExecutaComando20) then
                begin
                  OnExecutaComando20(Self, msg, Opcao);
                  StrPCopy (FBuffer, Opcao);
                  iContinua := FLUXO_CONTINUA;
                end
                else
                begin
                  Opcao := '0';
                  StrPCopy (FBuffer, Opcao);
                  iContinua := FLUXO_ABORTA;
                end;
              end;
          21: begin
                if Assigned(FOnExecutaComando21) then
                begin
                  OnExecutaComando21(Self, msg, Opcao);

                  if Opcao = '-1' then
                    iContinua := FLUXO_ABORTA
                  else if Opcao = '-2' then (* HOMOLOGACAO OPCAO DE VOLTAR *)
                    iContinua := FLUXO_VOLTAR
                  else
                  begin
                    StrPCopy (FBuffer, Opcao);
                    iContinua := FLUXO_CONTINUA;
                  end;
                end
                else
                  iContinua := FLUXO_ABORTA;
              end;
          22: if FTefDedicadoInterface <> nil then
               FTefDedicadoInterface.DoExecutaComando22(Self, Msg);
          23: begin
                if Assigned(FOnExecutaComando23) then
                  OnExecutaComando23(Self, msg, Opcao)
                else
                  Opcao := '1';

                if Opcao = '1' then //Abortar
                  iContinua := FLUXO_ABORTA
                else
                begin
                  iContinua := FLUXO_CONTINUA;
                end;
              end;
          30: begin
                 {
                 // Não pode utilizar restrições na homologação
                 if (iTipoCampo = 505) and (FTempVinculadoInfo.NumeroParcelas > 1) then
                   begin //Numero de parcelas
                     if FTempVinculadoInfo.NumeroParcelas > 1 then
                     begin
                       opcao := IntToStr(FTempVinculadoInfo.NumeroParcelas);
                       opcao := SizedStr(opcao, 2, '0', sspLeft);
                       FTempVinculadoInfo.NumeroParcelas := 0;
                     end
                     else
                       opcao := '-1';
                   end
                 else if (iTipoCampo = 506) and (FTempVinculadoInfo.PreDatado <> 0) then
                   begin //Data Pre-Dadado Cartao Debito
                     if FTempVinculadoInfo.PreDatado <> 0 then
                     begin
                       opcao := FormatDateTime('ddmmyyyy', FTempVinculadoInfo.PreDatado);
                       FTempVinculadoInfo.PreDatado := 0;
                     end
                     else
                       opcao := '-1';
                   end
                 else if (iTipoCampo = 510) then
                   begin //Pre-Dadado Com garantia = 0, sem Garantia = 1
                     if FTempVinculadoInfo.PreDatadoComGarantia then
                       opcao := '0'
                     else
                       opcao := '1';
                   end
                else  }
                   begin

                     if iTipoCampo = 500 then
                     begin
                       if Assigned(FOnExecutaComandoSenha) then
                         OnExecutaComandoSenha(Self, msg, iTamMin, iTamMax, opcao, iComando, iTipoCampo)
                       else
                         opcao := '-1';
                     end
                     else if Assigned(FOnExecutaComando30) then
                       OnExecutaComando30(Self, msg, iTamMin, iTamMax, opcao, iComando, iTipoCampo)
                     else
                       opcao := '-1';
                   end;

                if opcao = '-1' then
                  iContinua := FLUXO_ABORTA
                else if opcao = '-2' then  (* HOMOLOGACAO OPCAO DE VOLTAR *)
                  iContinua := FLUXO_VOLTAR
                else
                begin
                  StrPCopy (FBuffer, opcao);
                  iContinua := FLUXO_CONTINUA;
                end;
              end;
          31: begin
                if Assigned(FOnExecutaComando31) then
                  OnExecutaComando31(Self, msg, Opcao)
                else
                  Opcao := '-1';

                if Opcao = '-1' then //Abortar
                  iContinua := FLUXO_ABORTA
                else
                begin
                  StrPCopy (FBuffer, opcao);
                  iContinua := FLUXO_CONTINUA;
                end;
              end;

          34: begin
                if Assigned(FOnExecutaComando34) then
                  OnExecutaComando34(Self, msg, iTamMin, iTamMax, dValor);

                opcao := MyFormatCur(dValor, ',');

                if opcao = '-1,00' then
                  iContinua := FLUXO_ABORTA
                else if opcao = '-2,00' then  (* HOMOLOGACAO OPCAO DE VOLTAR *)
                  iContinua := FLUXO_VOLTAR
                else
                begin
                  StrPCopy (FBuffer, opcao);
                  iContinua := FLUXO_CONTINUA;
                end;
              end;
          35: begin
                if Assigned(FOnExecutaComando35) then
                  OnExecutaComando35(Self, msg, Opcao)
                else
                  Opcao := '-1';

                if Opcao = '-1' then //Abortar
                  iContinua := FLUXO_ABORTA
                else
                begin
                  StrPCopy (FBuffer, opcao);
                  iContinua := FLUXO_CONTINUA;
                end;
              end
          else begin
               //iContinua
               // 0 = Continua a transacao
               // 1 = Retorna, quando possivel, a coleta ao campo anterior
               // 10000 = Continua a transacao, vide Obs a seguir
               //-1 = Encerra a transacao
               iContinua := FLUXO_ABORTA;
               //Break;
               end;
        end;
        STATUS_SEM_CONEXAO:
          ConfiguraInt;
      end;
      if Assigned(FOnResultCommand) then
        OnResultCommand(Self, iComando, iTipoCampo, Result, msg);

  until (Result <> STATUS_CONTINUE);
  if FTefDedicadoInterface <> nil then
  begin
     if Result = STATUS_OK then  (* HOMOLOGACAO PARAR O FLUXO POR ALGUNS SEGUNDOS *)
       Sleep(4000);
     FTefDedicadoInterface.DoLimpaMsg(Self);
  end;
end;


function TTEFDedicado.ConfirmaTransacao: Boolean;
var
  Cupom, Data, Hora: PChar;
  bCancelou, bImpressaoOK : Boolean;
begin
  Result := False;
  bCancelou := False;

  if FCupomFiscal <> '' then
    begin
      Cupom := PChar(FCupomFiscal);
      Data := PChar(FDataFiscal);
      Hora := PChar(FHorafiscal);
    end
  else
    begin
      Cupom := nil;
      Data := PChar(Copy(TTEFOutput(FTEFOutputList[0]).DataHora, 1, 8));
      Hora := PChar(Copy(TTEFOutput(FTEFOutputList[0]).DataHora, 9, 6));
    end;

  if TemImpressao then
    bImpressaoOK := ImprimeTudo(Trim(FCupomFiscal) <> '')
  else
    bImpressaoOK := True;

  if bImpressaoOK then
    Result := FinalizaTransacaoSiTefInterativo (1, Cupom, Data, Hora) = STATUS_OK
  else
    bCancelou := CancelaTransacao(Cupom, Data, Hora);

  if Result or bCancelou then
    ClearIni;

  FTempVinculadoInfo := nil;

  ClearOutPutList;
end;

function TTEFDedicado.TemImpressao : Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to FTEFOutputList.Count-1 do
    if TTEFOutput(FTEFOutputList[i]).Imprime then
    begin
      Result := True;
      Break;
    end;
end;

function TTEFDedicado.CancelaTransacao(ACupom, AData, AHora: PChar): Boolean;
begin
  FTempVinculadoInfo := nil;

  Result := FinalizaTransacaoSiTefInterativo (0, ACupom, AData, AHora) = STATUS_OK;
  ShowMessage('Transação não foi efetuada. Favor reter o Cupom.');
  
end;

function TTEFDedicado.GetTEFOutputList(Index: Integer): TTEFOutput;
begin
  Result := FTEFOutputList[Index];
end;

procedure TTEFDedicado.AddOutput(AImprime : Boolean);
begin
  FTEFOutputList.Add(TTEFOutput.Create);
  GetCurrentOutPut.VinculadoInfo := FTempVinculadoInfo;
  GetCurrentOutPut.Imprime := AImprime;
end;

function TTEFDedicado.GetCurrentOutPut: TTEFOutput;
begin
  if FTEFOutputList.Count = 0 then
    Result := nil
  else
    Result := FTEFOutputList[Pred(FTEFOutputList.Count)];
end;

procedure TTEFDedicado.ClearOutPutList;
var
  ATEFOutput: TTEFOutput;
begin
  while FTEFOutputList.Count > 0 do
  begin
    if FTEFOutputList[0] <> nil then
    begin
      ATEFOutput := FTEFOutputList[0];
      FreeAndNil(ATEFOutput);
    end;
    FTEFOutputList.Delete(0);
  end;
  FTEFOutputList.Clear;
end;

function TTEFDedicado.ImprimeTudo(NeedVinculado: Boolean): Boolean;
var
  VinculadoAberto,
  GerencialAberto,
  Printed,
  TryAgain
  (*,NeedVinculado*): Boolean;
begin
  Result          := False;
  TryAgain        := True;
  Printed         := False;
  VinculadoAberto := False;
  GerencialAberto := False;
  try
    (*NeedVinculado := not (FRequisicaoAtual in [rtCNC, rtADM]);*)

    //DoOnNeedCloseVinculado;
    //DoOnNeedCloseGerencial;

    // Imprime vinculado se precisar
    if NeedVinculado then
      Printed := PrintTEFVinculado(VinculadoAberto);

    if NeedVinculado and (not Printed) then
    // Se precisava de vinculado e não foi impresso, pergunto se o usuário
    // Deseja continuar, antes de abrir o gerencial
    begin
      TryAgain := DoOnTryAgainDialog;
      if not TryAgain then
        Exit;
    end;

    if not Printed then
      repeat
        Printed := PrintTEFGerencial(VinculadoAberto, GerencialAberto);
        if not Printed then
          TryAgain := DoOnTryAgainDialog;
      until Printed or (not TryAgain);

    if not Printed then
    begin
      if VinculadoAberto then
        DoOnNeedCloseVinculado;
      if GerencialAberto then
        DoOnNeedCloseGerencial;
    end;
  finally
    Result := Printed;
  end;
end;

function TTEFDedicado.PrintTEFVinculado(var VinculadoAberto: Boolean): Boolean;
var
  Printed: Boolean;
  iTefs,
  iVias,
  iLinhas : Integer;
  lstLinhas: TStringList;
begin
  Result          := False;
  VinculadoAberto := False;
  Printed         := False;

  BlockInput(FBloqueiaTeclado);
  try
    try
      for iVias := 1 to 2 do
      begin
        for iTefs := 0 to FTEFOutputList.Count - 1 do
        begin

          if not TTEFOutput(FTEFOutputList[iTefs]).Imprime then
            Continue;

          if not VinculadoAberto then
          begin
            VinculadoAberto  := DoOnNeedOpenVinculado(TTEFOutput(FTEFOutputList[iTefs]).VinculadoInfo);
            Printed          := VinculadoAberto;
          end;

          if Printed then
            //for iVias := 1 to FVias do
            begin
              if iVias = 1 then
                lstLinhas := TTEFOutput(FTEFOutputList[iTefs]).PrimeiraVia
              else
              begin
                lstLinhas := TTEFOutput(FTEFOutputList[iTefs]).SegundaVia;
                if lstLinhas.Count = 0 then
                  Result := True;
              end;


              for iLinhas := 0 to lstLinhas.Count - 1 do
              begin
                DoOnStatusPrinter(Printed);
                if not Printed then
                  Exit;
                Printed := DoOnNeedPrintLineVinculado(lstLinhas[iLinhas]);
                if not Printed then
                  Exit;
              end;

            end
          else
            Exit;
        end;

        // Imprime linhas vazias para separar os cupons
        if iVias <> 2 then
        begin
          Printed := AvancaLinhasVinculado(2);
          if not Printed then
            Exit;
          //Sleep(FTempoMensagem * 1000);
        end;
      end;
    finally
      if VinculadoAberto then
      begin
        Sleep(2000);
        VinculadoAberto := not DoOnNeedCloseVinculado;
        if Printed then
          Printed := not VinculadoAberto;
      end;
      Result := Printed;
    end;
  finally
    BlockInput(False);
  end;
end;

function TTEFDedicado.PrintTEFGerencial(var VinculadoAberto, GerencialAberto: Boolean): Boolean;
var
  Printed: Boolean;
  iTefs,
  iVias,
  iLinhas : Integer;
  lstLinhas: TStringList;
begin
  Result          := False;

  BlockInput(FBloqueiaTeclado);
  try

    {if VinculadoAberto then
    begin}
      { VinculadoAberto := not DoOnNeedCloseVinculado; }
      DoOnNeedCloseVinculado;
      VinculadoAberto := False;
      if VinculadoAberto then
        Exit;
    {end;}

    {if GerencialAberto then
    begin}
      //GerencialAberto := not DoOnNeedCloseVinculado;   After Homo
      {GerencialAberto := not DoOnNeedCloseGerencial;}
      DoOnNeedCloseGerencial;
      GerencialAberto := False;
      if GerencialAberto then
        Exit;
    {end;}

    Printed         := False;
    try
      for iVias := 1 to 2 do
      begin
        for iTefs := 0 to FTEFOutputList.Count - 1 do
        begin

          //if not VinculadoAberto then After Homo
          if not GerencialAberto then
          begin
            GerencialAberto  := DoOnNeedOpenGerencial;
            Printed          := GerencialAberto;
          end;

          if Printed then
            begin
              if iVias = 1 then
                 lstLinhas := TTEFOutput(FTEFOutputList[iTefs]).PrimeiraVia
              else
                 lstLinhas := TTEFOutput(FTEFOutputList[iTefs]).SegundaVia;

              begin
                for iLinhas := 0 to lstLinhas.Count - 1 do
                begin
                  DoOnStatusPrinter(Printed);
                  if not Printed then
                    Exit;
                  Printed := DoOnNeedPrintLineGerencial(lstLinhas[iLinhas]);
                  if not Printed then
                    Exit;
                end;
              end;
            end
          else
            Exit;
        end;
        // Imprime linhas vazias para separar os cupons
        if iVias <> 2 then
        begin
          Printed := AvancaLinhasGerencial(2);
          if not Printed then
            Exit;
          //Sleep(FTempoMensagem * 1000);
        end;
      end;
    finally
      if GerencialAberto then
      begin
        Sleep(2000);
        GerencialAberto := not DoOnNeedCloseGerencial;
        if Printed then
          Printed := not GerencialAberto;
      end;
      Result := Printed;
    end;
  finally
    BlockInput(False);
  end;
end;

function TTEFDedicado.DoOnNeedOpenVinculado(AVinculadoInfo: TVinculadoInfo): Boolean;
begin
  if Assigned(FOnNeedOpenVinculado) then
    FOnNeedOpenVinculado(Self, AVinculadoInfo, Result)
  else
    Result := False;
end;

function TTEFDedicado.DoOnNeedOpenGerencial: Boolean;
begin
  if Assigned(FOnNeedOpenGerencial) then
    FOnNeedOpenGerencial(Self, Result)
  else
    Result := False;
end;

function TTEFDedicado.DoOnNeedCloseVinculado: Boolean;
begin
  Sleep(0);
  if Assigned(FOnNeedCloseVinculado) then
    FOnNeedCloseVinculado(Self, Result)
  else
    Result := False;
  Sleep(0);
end;

function TTEFDedicado.DoOnNeedCloseGerencial: Boolean;
begin
  Sleep(0);
  if Assigned(FOnNeedCloseGerencial) then
    FOnNeedCloseGerencial(Self, Result)
  else
    Result := False;
  Sleep(0);
end;

function TTEFDedicado.DoOnNeedPrintLineGerencial(LineToPrint: String): Boolean;
begin
  Sleep(0);
  if Assigned(FOnNeedPrintLineGerencial) then
    FOnNeedPrintLineGerencial(Self, LinhaNaoNula(LineToPrint), Result)
  else
    Result := False;
   // Homologação TEF Dedicado - Problema da bufferização
  (*
  Sleep(0);
  *)
  Sleep(TEMPO_ENTRE_LINHAS);
end;

function TTEFDedicado.DoOnNeedPrintLineVinculado(LineToPrint: String): Boolean;
begin
  if Assigned(FOnNeedPrintLineVinculado) then
    FOnNeedPrintLineVinculado(Self, LinhaNaoNula(LineToPrint), Result)
  else
    Result := False;
   // Homologação TEF Dedicado - Problema da bufferização
  (*
  Sleep(0);
  *)
  Sleep(TEMPO_ENTRE_LINHAS);
end;

function TTEFDedicado.AvancaLinhasVinculado(Count: Integer) : Boolean;
var
  I : Integer;
begin
  Result := False;
  for I := 1 to Count do
  begin
    Result := DoOnNeedPrintLineVinculado(' ');
    if not Result then
      Break;
  end;
end;

function TTEFDedicado.AvancaLinhasGerencial(Count: Integer) : Boolean;
var
  I : Integer;
begin
  Result := False;
  for I := 1 to Count do
  begin
    DoOnStatusPrinter(Result);
    if not Result then
      Break;
    Result := DoOnNeedPrintLineGerencial(' ');
    if not Result then
      Break;
  end;
end;

function TTEFDedicado.DoOnTryAgainDialog: Boolean;
begin
  if Assigned(FOnTryAgainDialog) then
    FOnTryAgainDialog(Self, Result)
  else
    Result := False;
end;

procedure TTEFDedicado.DoOnStatusPrinter(var Online: Boolean);
begin
  if Assigned(FOnStatusPrinter) then
    OnStatusPrinter(Self, Online)
  else
    Online := False;
end;

function TTEFDedicado.LinhaNaoNula(S: String): String;
begin
  if S = '' then
    Result := FLinhaVazia
  else
    Result := S;
end;

function TTEFDedicado.TemPendencia: Boolean;
begin
  Result := FTEFOutputList.Count > 0;
end;

function TTEFDedicado.ResolvePendencias: Boolean;
var
  I: Integer;
  stlPendencias: TStringList;
  ADataFiscal, AHoraFiscal: String;
  ACupomFiscal: String;
  IsFiscal: Boolean;
begin
  Result := True;
  stlPendencias := TStringList.Create;
  try
    FIniFile.ReadSections(stlPendencias);
    for I := 0 to stlPendencias.Count - 1 do
    begin

      ACupomFiscal := FIniFile.ReadString(stlPendencias[I], CHAVE_CUPOMFISCAL, '');
      IsFiscal := ACupomFiscal <> '';

      if isFiscal then
      begin
        ADataFiscal := FIniFile.ReadString(stlPendencias[I], CHAVE_DATAFISCAL, '');
        AHoraFiscal := FIniFile.ReadString(stlPendencias[I], CHAVE_HORAFISCAL, '');
        Result := CancelaTransacao(PChar(ACupomFiscal), PChar(ADataFiscal), PChar(AHoraFiscal));
        if Result then
          ClearIni;
        ClearOutPutList;
        Break;
      end
      else
      begin
        ADataFiscal := Copy(stlPendencias[I], 1, 8);
        AHoraFiscal := Copy(stlPendencias[I], 9, 6);
        Result := CancelaTransacao(nil, PChar(ADataFiscal), PChar(AHoraFiscal));
        if Result then
          FIniFile.EraseSection(stlPendencias[I]);
        ClearOutPutList;
      end;
    end;
  finally
    stlPendencias.Free;
  end;
end;

procedure TTEFDedicado.SaveCurrentOutPut;
var
  I: Integer;
  TEFOutPut: TTEFOutput;
begin
  ClearIni;
  for I := 0 to FTEFOutputList.Count - 1 do
  begin
    TEFOutPut := TTEFOutput(FTEFOutputList[I]);
    if TEFOutPut.Imprime then
    begin
      FIniFile.WriteString(TEFOutPut.DataHora, CHAVE_TEXTO_DESC, TEFOutPut.TextoDescritivo);
      FIniFile.WriteString(TEFOutPut.DataHora, CHAVE_CUPOMFISCAL, FCupomFiscal);
      FIniFile.WriteString(TEFOutPut.DataHora, CHAVE_DATAFISCAL, FDataFiscal);
      FIniFile.WriteString(TEFOutPut.DataHora, CHAVE_HORAFISCAL, FHorafiscal);
    end;
  end;
end;

procedure TTEFDedicado.ClearIni;
var
  I: Integer;
  stlSessions: TStringList;
begin
  stlSessions := TStringList.Create;
  try
    FIniFile.ReadSections(stlSessions);
    for I := 0 to stlSessions.Count - 1 do
      FIniFile.EraseSection(stlSessions[i]);
  finally
   stlSessions.Free;
  end;
end;

function TTEFDedicado.TestaCominicacao(ATefDedicadoInterface: TTefDedicadoInterface): Boolean;
begin
  Result := FazTransacao(FUNCAO_TESTE_COMUNICACAO, 0, '', Now, '', '', '', nil, ATefDedicadoInterface) = 0;
end;



{ TTEFOutput }

constructor TTEFOutput.Create;
begin
  inherited Create;
  PrimeiraVia := TStringList.Create;
  SegundaVia := TStringList.Create;
  PrimeiraVia.Delimiter := #$A;
  SegundaVia.Delimiter := #$A;
end;

destructor TTEFOutput.Destroy;
begin
  FreeAndNil(PrimeiraVia);
  FreeAndNil(SegundaVia);
  inherited Destroy;
end;

end.
