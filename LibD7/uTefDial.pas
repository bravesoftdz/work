unit uTefDial;

interface

uses
  Windows, SysUtils, Classes, Dialogs, IniFiles, Forms, uTEFTypes;


const
  REQUEST_FILE    : array[0..1] of String = ('C:\TEF_DIAL\REQ\IntPos.001', 'C:\HiperTEF\REQ\IntPos.001');
  TEMP_FILE       : array[0..1] of String = ('C:\TEF_DIAL\REQ\IntPos.tmp', 'C:\HiperTEF\REQ\IntPos.tmp');
  STATUS_FILE     : array[0..1] of String = ('C:\TEF_DIAL\RESP\IntPos.sts', 'C:\HiperTEF\RESP\IntPos.sts');
  RESPONSE_FILE   : array[0..1] of String = ('C:\TEF_DIAL\RESP\IntPos.001', 'C:\HiperTEF\RESP\IntPos.001');
  ACTIVATION_FILE : array[0..1] of String = ('C:\TEF_DIAL\RESP\ativo.001', 'C:\HiperTEF\RESP\ativo.001');

  PERSISTENCE_FILE: String = 'C:\temp\Persist.ini';

  Moedas : array[0..1] of String = ('Real', 'Dolar');

  LINHAS_AVANCO = 4;

type
  TRequestType = (rtATV, rtADM, rtCHQ, rtCRT, rtCNC, rtCNF, rtNCN);

  TTEFPending = class;


  TTEFParcela = class
    Vencimento: TDateTime;
    Valor:      Double;
    NSUParcela: String;
  end;

  TTEFDial = class(TComponent)
  private
    FRetorno:        Boolean;
    FValorAprovado:  Double;
    FValorTotal:     Double;
    FIDMoeda:        Integer;
    FTempoEspera:    Byte;
    FNSU:            String;
    FCupomVinculado: String;
    FImagemCupom:    TStringList;
    FRequisicaoAtual: TRequestType;
    FTextoEspOperador: String;
    FTextoEspCliente: String;
    FAprovada: Boolean;
    FTemCupom: Boolean;
    FOnPrint: TTEFPrintEvent;
    FIdentificacao: LongInt;
    FDataTransacao: String;
    FHoraTransacao: String;
    FNomeRede: String;
    FFinalizacao: String;
    FOnDialog: TTEFDialMessageEvent;
    FTempoMensagem: Byte;
    FMutex: Cardinal;
    FWorking: Boolean;
    FAutorizacao: String;
    FFormaPagamento: String;
    FPendingList: TList;
    { Private declarations }
    IniPersistence : TIniFile;
    FOnNeedOpenVinculado: TTEFNeedOpenPrintVinculado;
    FOnNeedCloseVinculado: TTEFNeedClosePrint;
    FOnNeedCloseGerencial: TTEFNeedClosePrint;
    FOnNeedOpenGerencial: TTEFNeedOpenPrint;
    FOnNeedPrintLineGerencial: TTEFNeedPrintLine;
    FOnNeedPrintLineVinculado: TTEFNeedPrintLine;
    FVias: Integer;
    FLinhaVazia: String;
    FOnTryAgainDialog: TTEFTryAgainDialog;
    FRequisicao: String;
    FBloqueiaTeclado: Boolean;
    FTipoTransacao: String;
    FNParcelas: Integer;
    FParcelas: TList;
    FOnStatusPrinter: TTEFStatusPrinter;
    FOnPerguntaCupom: TTEFPerguntaCupom;
    FCodigoFiscal: String;
    FIDMeioPag: Integer;
    FTEFDIALType: Integer;
    FIDPreSale: Integer;
    procedure InicializaVariaveis;
    function FloatToTEFFloat(Valor: Double): String;
    function VerificaStatus: Boolean;
    function ExtractFieldInt(Campo: String): Integer;
    function ExtractFieldStr(Campo: String): String;
    function GetRequestStr(ATRequestType: TRequestType): String;
    function AguardaArquivo(NomeArquivo: String; Infinito: Boolean = False): Boolean;
    function FazTransacao(ARequestType: TRequestType): Boolean;
    function VerificaRetorno: Boolean;
    function LeituraRetorno: Boolean;
    procedure AddPending;
    procedure ClearPendingList;
    procedure RemovePending(ANSU: String; Save: Boolean = True);
    function GetPendingByNSU(ANSU: String): Integer;
    procedure SetPendingConfirmed(ANSU: String);
    function DoOnNeedCloseGerencial: Boolean;
    function DoOnNeedCloseVinculado: Boolean;
    function DoOnNeedOpenGerencial: Boolean;
    function DoOnNeedOpenVinculado: Boolean;
    function DoOnNeedPrintLineGerencial(LineToPrint: String): Boolean;
    function DoOnNeedPrintLineVinculado(LineToPrint: String): Boolean;
    procedure DoOnStatusPrinter(var Online: Boolean);
    function PrintTEFVinculado(var VinculadoAberto: Boolean): Boolean;
    function LinhaNaoNula(S: String): String;
    procedure SetTEFToPending(Index: Integer);
    function PrintTEFGerencial(var VinculadoAberto,
      GerencialAberto: Boolean): Boolean;
    function DoOnTryAgainDialog: Boolean;
    procedure RemoveAllPendings(Save: Boolean = True);
    procedure ReadAllPendings;
    function AvancaLinhasVinculado(Count: Integer): Boolean;
    function AvancaLinhasGerencial(Count: Integer): Boolean;
    function CancelamentoSimples: Boolean;
    procedure RemoveRelactiveNSUs(NNSU: String);
    procedure DescarregaParaReserva;
    procedure DeleteTEFFiles;
    function GetParcelas(Index: Integer): TTEFParcela;
    function AddParcela(AVencimento: TDateTime; AValor: Double;
      ANSUParcela: String): Integer;
    function TEFDateToDateTime(S: String): TDateTime;
    function TestaResposta: Boolean;

  protected
    { Protected declarations }
  public
    { Public declarations }
    property Aprovada:         Boolean            read FAprovada;
    property Autorizacao:      String             read FAutorizacao;
    property CodFiscal:        String             read FCodigoFiscal     write FCodigoFiscal;
    property DataTransacao:    String             read FDataTransacao    write FDataTransacao;
    property HoraTransacao:    String             read FHoraTransacao    write FHoraTransacao;
    property Finalizacao:      String             read FFinalizacao      write FFinalizacao;
    property IDMoeda:          Integer            read FIDMoeda          write FIDMoeda default 0;
    property IDMeioPag:        Integer            read FIDMeioPag        write FIDMeioPag;
    property Identificacao:    LongInt            read FIdentificacao    write FIdentificacao;
    property IDPreSale:        Integer            read FIDPreSale        write FIDPreSale;
    property ImagemCupom:      TStringList        read FImagemCupom;
    property FormaPagamento:   String             read FFormaPagamento   write FFormaPagamento;
    property NomeRede:         String             read FNomeRede         write FNomeRede;
    property NParcelas:        Integer            read FNParcelas;
    property NSU:              String             read FNSU              write FNSU;
    property Retorno:          Boolean            read FRetorno;
    property TemCupom:         Boolean            read FTemCupom;
    property TextoEspOperador: String             read FTextoEspOperador;
    property TextoEspCliente:  String             read FTextoEspCliente;
    property ValorAprovado:    Double             read FValorAprovado    write FValorAprovado;
    property Mutex:            Cardinal           read FMutex;
    property PendingList:      TList              read FPendingList      write FPendingList;

    property Parcelas[Index: Integer]: TTEFParcela            read GetParcelas;
    property Requisicao:       String             read FRequisicao;
    property TipoTransacao:    String             read FTipoTransacao;


    constructor Create(AOwner: TComponent);override;
    destructor Destroy;override;

    function Ativacao(Exibir: Boolean = True): Boolean;
    function FazRequisicao(RequestType: TRequestType; PendingOK: Boolean = True): Boolean;
    function GeraIdentificacao : String;
    function VerificaAtivacao: Boolean;
    function VendaCartao: Boolean;
    function VendaCheque: Boolean;
    function ConfirmaTransacao: Boolean;
    function Cancelamento: Boolean;
    function Administracao: Boolean;
    function ResolvePendencias: Boolean;
    function ConfirmacaoSimples: Boolean;
    function ImprimeTudo: Boolean;

    function TemPendencia: Boolean;
  published
    { Published declarations }
    property BloqueiaTeclado:          Boolean                read FBloqueiaTeclado          write FBloqueiaTeclado  default True;
    property CupomVinculado:           String                 read FCupomVinculado           write FCupomVinculado;
    property OnPrint:                  TTEFPrintEvent         read FOnPrint                  write FOnPrint;
    property RequisicaoAtual:          TRequestType           read FRequisicaoAtual          write FRequisicaoAtual;
    property LinhaVazia:               String                 read FLinhaVazia               write FLinhaVazia;
    property TempoEspera:              Byte                   read FTempoEspera              write FTempoEspera      default 7;
    property TempoMensagem:            Byte                   read FTempoMensagem            write FTempoMensagem    default 5;
    property ValorTotal:               Double                 read FValorTotal               write FValorTotal;
    property Vias:                     Integer                read FVias                     write FVias             default 2;


    property TEFDIALType: Integer read FTEFDIALType write FTEFDIALType;

    property OnDialog:                 TTEFDialMessageEvent       read FOnDialog                 write FOnDialog;
    property OnNeedOpenVinculado:      TTEFNeedOpenPrintVinculado read FOnNeedOpenVinculado      write FOnNeedOpenVinculado;
    property OnNeedOpenGerencial:      TTEFNeedOpenPrint          read FOnNeedOpenGerencial      write FOnNeedOpenGerencial;
    property OnNeedCloseVinculado:     TTEFNeedClosePrint         read FOnNeedCloseVinculado     write FOnNeedCloseVinculado;
    property OnNeedCloseGerencial:     TTEFNeedClosePrint         read FOnNeedCloseGerencial     write FOnNeedCloseGerencial;
    property OnNeedPrintLineGerencial: TTEFNeedPrintLine          read FOnNeedPrintLineGerencial write FOnNeedPrintLineGerencial;
    property OnNeedPrintLineVinculado: TTEFNeedPrintLine          read FOnNeedPrintLineVinculado write FOnNeedPrintLineVinculado;
    property OnTryAgainDialog:         TTEFTryAgainDialog         read FOnTryAgainDialog         write FOnTryAgainDialog;
    property OnStatusPrinter:          TTEFStatusPrinter          read FOnStatusPrinter          write FOnStatusPrinter;
    property OnPerguntaCupom:          TTEFPerguntaCupom          read FOnPerguntaCupom          write FOnPerguntaCupom;
  end;

  TTEFPending = class
  private
    FValorTotal: Double;
    FNomeRede: String;
    FHoraTransacao: String;
    FNSU: String;
    FFormaPagamento: String;
    FDataTransacao: String;
    FImagemCupom: TStringList;
    FConfirmed: Boolean;
    FCupomVinculado: String;
    FValorAprovado: Double;
    FRequisicao: String;
    FFinalizacao: String;
    FTEFDIALType: Integer;
    FIDPreSale: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property DataTransacao:    String      read FDataTransacao  write FDataTransacao;
    property HoraTransacao:    String      read FHoraTransacao  write FHoraTransacao;
    property ImagemCupom:      TStringList read FImagemCupom    write FImagemCupom;
    property FormaPagamento:   String      read FFormaPagamento write FFormaPagamento;
    property NomeRede:         String      read FNomeRede       write FNomeRede;
    property NSU:              String      read FNSU            write FNSU;
    property ValorTotal:       Double      read FValorTotal     write FValorTotal;
    property Confirmed:        Boolean     read FConfirmed      write FConfirmed;
    property CupomVinculado:   String      read FCupomVinculado write FCupomVinculado;
    property ValorAprovado:    Double      read FValorAprovado  write FValorAprovado;
    property Requisicao:       String      read FRequisicao     write FRequisicao;
    property Finalizacao:      String      read FFinalizacao    write FFinalizacao;
    property TEFDIALType:      Integer     read FTEFDIALType    write FTEFDIALType;
    property IDPreSale:        Integer     read FIDPreSale      write FIDPreSale;
  end;

procedure Register;

procedure BlockInput(Block: LongBool);stdcall;external 'USER32.DLL';

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TTEFDial]);
end;

constructor TTEFDial.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InicializaVariaveis;
  if not (csDesigning in ComponentState) then
    FMutex := CreateMutex(nil, False, PChar(Self.Name))
end;

destructor TTEFDial.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    ClearPendingList;
    FreeAndNil(FPendingList);
    FreeAndNil(FImagemCupom);
    FreeAndNil(FParcelas);
  end;
  inherited Destroy;
end;

procedure TTEFDial.InicializaVariaveis;
begin
  FTextoEspOperador := '';
  FTextoEspCliente  := '';
  FAprovada         := False;
  FTemCupom         := False;
  FWorking          := False;
  FBloqueiaTeclado := True;
  FTempoEspera      := 7;
  FTempoMensagem    := 5;
  FLinhaVazia       := '';
  FVias             := 2;
  FRequisicao       := '';
  FCodigoFiscal     := '';
  FTEFDIALType      := 0;

  if not (csDesigning in ComponentState) then
    begin
      if not DirectoryExists(ExtractFilePath(PERSISTENCE_FILE)) then
        ForceDirectories(ExtractFilePath(PERSISTENCE_FILE));

      IniPersistence    := TIniFile.Create(PERSISTENCE_FILE);
      FPendingList      := TList.Create;
      FImagemCupom      := TStringList.Create;
      FParcelas         := TList.Create;
    end;
end;

function TTEFDial.TEFDateToDateTime(S: String): TDateTime;
var
  Dia, Mes, Ano: Word;
begin
  Dia    := StrToInt(Copy(S, 1, 2));
  Mes    := StrToInt(Copy(S, 3, 2));
  Ano    := StrToInt(Copy(S, 5, 4));
  Result := EncodeDate(Ano, Mes, Dia);
end;

function TTEFDial.FloatToTEFFloat(Valor: Double): String;
begin
  Result := StringReplace(FormatFloat('0.00', Valor), DecimalSeparator, '', [rfReplaceAll]);
end;

function TTEFDial.GeraIdentificacao: String;
begin
  Result := FormatDateTime('hhnnss', NOW) + FormatDateTime('zzzz', NOW);
end;

function TTEFDial.GetRequestStr(ATRequestType: TRequestType): String;
begin
  case ATRequestType of
     rtATV: Result := 'ATV';
     rtADM: Result := 'ADM';
     rtCHQ: Result := 'CHQ';
     rtCRT: Result := 'CRT';
     rtCNC: Result := 'CNC';
     rtCNF: Result := 'CNF';
     rtNCN: Result := 'NCN';
     else Result := '';
  end;
end;

function TTEFDial.ExtractFieldStr(Campo: String): String;
begin
  Result := Campo;
  Delete(Result, 1, 10);
end;

function TTEFDial.ExtractFieldInt(Campo: String): Integer;
begin
  Result := StrToInt(ExtractFieldStr(Campo));
end;

function TTEFDial.AguardaArquivo(NomeArquivo: String; Infinito: Boolean = False): Boolean;
var
  HoraInicio, HoraFim : Cardinal;
begin
  Result := False;
  HoraFim := 0;
  try
    if not Infinito then
    begin
      HoraInicio := GetTickCount;
      HoraFim := HoraInicio + (FTempoEspera * 1000);
    end;

    repeat
      Result := FileExists(NomeArquivo);
      Sleep(0);
    until Result or ((not Infinito) and (GetTickCount >= HoraFim));
  except
  end;
end;

function TTEFDial.VerificaAtivacao: Boolean;
var
    AFValorTotal: Double;
    AFNomeRede: String;
    AFHoraTransacao: String;
    AFNSU: String;
    AFFormaPagamento: String;
    AFDataTransacao: String;
    //AFImagemCupom: TStringList;
    //AFConfirmed: Boolean;
    AFCupomVinculado: String;
    AFValorAprovado: Double;
    AFRequisicao: String;
    AFRequisicaoAtual: TRequestType;
    AFIdentificacao: LongInt;
    AFTextoEspCliente :String;
    AFTextoEspOperador :String;
    AFFinalizacao: String;
    AFCodigoFiscal: String;
    AFIDMeioPag: Integer;
    AFTEFDIALType: Integer;
begin
    {if FRequisicaoAtual = rtATV then
    begin
      Result := True;
      Exit;
    end;}

    Result := False;
    AFTextoEspCliente := FTextoEspCliente;
    AFTextoEspOperador := FTextoEspOperador;
    AFIdentificacao  := FIdentificacao;
    AFRequisicaoAtual:= FRequisicaoAtual;
    AFValorTotal     := FValorTotal;
    AFNomeRede       := FNomeRede;
    AFHoraTransacao  := FHoraTransacao;
    AFNSU            := FNSU;
    AFFormaPagamento := FFormaPagamento;
    AFDataTransacao  := FDataTransacao;
    AFCupomVinculado := FCupomVinculado;
    AFValorAprovado  := FValorAprovado;
    AFRequisicao     := FRequisicao;
    AFFinalizacao    := FFinalizacao;
    AFCodigoFiscal   := FCodigoFiscal;
    AFIDMeioPag      := FIDMeioPag;
    AFTEFDIALType    := FTEFDIALType;

    if FazRequisicao(rtATV) then
    begin
      FTextoEspOperador := '';
      Result := VerificaStatus;
    end;

    FTextoEspCliente := AFTextoEspCliente;
    FTextoEspOperador := AFTextoEspOperador;
    FIdentificacao  := AFIdentificacao;
    FRequisicaoAtual:= AFRequisicaoAtual;
    FValorTotal     := AFValorTotal;
    FNomeRede       := AFNomeRede;
    FHoraTransacao  := AFHoraTransacao;
    FNSU            := AFNSU;
    FFormaPagamento := AFFormaPagamento;
    FDataTransacao  := AFDataTransacao;
    FCupomVinculado := AFCupomVinculado;
    FValorAprovado  := AFValorAprovado;
    FRequisicao     := AFRequisicao;
    FFinalizacao    := AFFinalizacao;
    FCodigoFiscal   := AFCodigoFiscal;
    FIDMeioPag      := AFIDMeioPag;
    FTEFDIALType    := AFTEFDIALType;

  if not Result then
    if Assigned(FOnDialog) then
      FOnDialog(Self, mtInatividade);
end;


function TTEFDial.FazRequisicao(RequestType: TRequestType; PendingOK: Boolean = True): Boolean;
var
  ReqFile : TextFile;
  Verificado : Boolean;
  procedure GravaCampo(Field, FieldValue : String);
  begin
    WriteLn(ReqFile, Format('%S = %S', [Field, FieldValue]));
  end;

begin
  FRequisicaoAtual := RequestType;
  Result := True;
  Verificado := (FRequisicaoAtual = rtATV);
  if not Verificado then
    Verificado := VerificaAtivacao;

  if Verificado then
    try
      DeleteTEFFiles;
      
      AssignFile(ReqFile, TEMP_FILE[FTEFDialType]);
      Rewrite(ReqFile);
      try
        FIdentificacao := StrToInt(GeraIdentificacao);

        if not (FRequisicaoAtual in [rtCNF, rtNCN]) then
          FRequisicao := GetRequestStr(FRequisicaoAtual);

        GravaCampo('000-000', GetRequestStr(FRequisicaoAtual));
        GravaCampo('001-000', FormatFloat('0000000000', FIdentificacao));


        case FRequisicaoAtual of
          rtATV:
            begin
            end;

          rtCRT:
            begin
              GravaCampo('002-000', FCupomVinculado);
              GravaCampo('003-000', FloatToTEFFloat(FValorTotal));
              //GravaCampo('004-000', Moedas[FIDMoeda]);
            end;

          rtCHQ:
            begin
              GravaCampo('003-000', FloatToTEFFloat(FValorTotal));
            end;

          rtCNF:
            begin
              GravaCampo('003-000', FloatToTEFFloat(FValorAprovado));
              GravaCampo('010-000', FNomeRede);
              GravaCampo('012-000', FNSU);
              GravaCampo('027-000', Finalizacao);
            end;

          rtCNC:
            begin
              GravaCampo('003-000', FloatToTEFFloat(FValorAprovado));
              GravaCampo('010-000', FNomeRede);
              GravaCampo('012-000', FNSU);
              GravaCampo('022-000', FDataTransacao);
              GravaCampo('023-000', FHoraTransacao);
            end;

          rtNCN:
            begin
              GravaCampo('010-000', FNomeRede);
              GravaCampo('012-000', FNSU);
              GravaCampo('027-000', Finalizacao);
            end;

          rtADM:
            begin
              // Os campos necessários já encontram se gravados
            end;

          else
            raise Exception.Create('Tipo de transação não implementado.');
        end;


        GravaCampo('777-777', 'Teste Hipercard');

        GravaCampo('999-999', '0');

        Flush(ReqFile);
      finally
        CloseFile(ReqFile);
      end;

      if not (CopyFile(PChar(TEMP_FILE[FTEFDialType]), PChar(REQUEST_FILE[FTEFDialType]), False) and DeleteFile(TEMP_FILE[FTEFDialType])) then
        Result := False;
    except
      Result := False;
    end
  else
    Result := False;

  if Result and (FRequisicaoAtual in [rtCNF, rtNCN]) then
  begin
    //DeleteFile(RESPONSE_FILE);

    case FRequisicaoAtual Of
      rtCNF: SetPendingConfirmed(FRequisicao + FNSU);
      rtNCN: RemovePending(FRequisicao + FNSU);
    end;

    if PendingOK then
      RemovePending(FRequisicao + FNSU);
  end;

  FRetorno := Result;
end;

function TTEFDial.VerificaStatus: Boolean;
var
  StatusFile : TextFile;
  IsIDOK, IsRequestOK: Boolean;
  Campo: String;
begin
  try
    IsIDOK := False;
    IsRequestOK := False;
    // HOMOLOGA
    if FRequisicaoAtual <> rtATV then
      FTextoEspOperador := '';
    if not AguardaArquivo(STATUS_FILE[FTEFDialType], FRequisicaoAtual <> rtATV) then
      begin
        Result := False;
        //ShowMessage('Gerenciador Padrão não está ativo');
      end
    else
      begin
        AssignFile(StatusFile, STATUS_FILE[FTEFDialType]);
        Reset(StatusFile);
        try
          while not EOF(StatusFile) do
          begin
            Readln(StatusFile, Campo);

            if Copy(Campo, 1, 7) = '999-999' then
              Break;

            if (Copy(Campo, 1, 7) = '001-000') and (ExtractFieldInt(Campo) = FIdentificacao) then
              IsIDOK := True;

            if (Copy(Campo, 1, 7) = '000-000') and (ExtractFieldStr(Campo) = GetRequestStr(FRequisicaoAtual)) then
              IsRequestOK := True;

            if (Copy(Campo, 1, 7) = '030-000') and (ExtractFieldStr(Campo) <> '') then
              FTextoEspOperador := ExtractFieldStr(Campo);

            Sleep(0);
          end;
          Result := IsIDOK and IsRequestOK;
        finally
          CloseFile(StatusFile);
          {if FRequisicaoAtual = rtCNF then}
          //DeleteFile(STATUS_FILE);
        end;
      end;
  except
    Result := False;
  end;


  if Result and (FTextoEspOperador <> '') then
    if Assigned(FOnDialog) then
      FOnDialog(Self);

  FRetorno := Result;
end;

function TTEFDial.VerificaRetorno: Boolean;
var
  bCerto: Boolean;
begin
  Result := False;
  try
    repeat
      AguardaArquivo(RESPONSE_FILE[FTEFDialType], True);
      bCerto := TestaResposta;
      if not bCerto then
        DeleteFile(RESPONSE_FILE[FTEFDialType]);
    until bCerto;

    DescarregaParaReserva;
    if not LeituraRetorno then
      Exit;

    if FAprovada then
      begin
        Result := True;
        if (FTextoEspOperador <> '') then
          if FTemCupom then
          begin
             if Assigned(FOnDialog) then
              FOnDialog(Self, mtOperador, False);
          end
          else
            if Assigned(FOnDialog) then
              FOnDialog(Self);
      end
    else
      begin
        if Assigned(FOnDialog) then
           FOnDialog(Self);
      end;
  except
    Result := False;
  end;
  FRetorno := Result;
end;

function TTEFDial.TestaResposta: Boolean;
var
  ResFile : TextFile;
  Campo: String;
begin
  Result := False;
  AssignFile(ResFile, RESPONSE_FILE[FTEFDialType]);
  Reset(ResFile);
  try
    while not EOF(ResFile) do
    begin
      Readln(ResFile, Campo);
      if Copy(Campo, 1, 7) = '999-999' then
        Break;
      if Copy(Campo, 1, 7) = '001-000' then
      begin
        if (ExtractFieldInt(Campo) = FIdentificacao) then
          Result := True;
        Break;
      end;
      Sleep(0);
    end;
  finally
    CloseFile(ResFile);
  end;
end;

function TTEFDial.LeituraRetorno: Boolean;
var
  ResFile : TextFile;
  Campo, sLinha : String;
  stlCampos : TStringList;
  I, QtdLinhas : Integer;
  {ADataParcela: TDateTime;
  AValorParcela: Double;
  ANSUParcela: String;}
begin
  try
    AssignFile(ResFile, RESPONSE_FILE[FTEFDialType]);
    stlCampos := TStringList.Create;
    try
      stlCampos.Duplicates := dupIgnore;
      stlCampos.NameValueSeparator := '=';

      // Lê o arquivo e alimenta a lista
      Reset(ResFile);
      try
        while not EOF(ResFile) do
        begin
          Readln(ResFile, Campo);
          if Copy(Campo, 1, 7) = '999-999' then
            Break;
          stlCampos.Add(Copy(Campo, 1, 7) + '=' + ExtractFieldStr(Campo));
          Sleep(0);
        end;
        Flush(ResFile);
      finally
        CloseFile(ResFile);
      end;

      // Trata os campos Recebidos, preenchendo as propriedades
      if Trim(stlCampos.Values['003-000']) <> '' then
         FValorAprovado := StrToIntDef(stlCampos.Values['003-000'], 0) / 100;

      FAprovada         := Trim(stlCampos.Values['009-000']) = '0';
      FNomeRede         := stlCampos.Values['010-000'];
      FTipoTransacao    := stlCampos.Values['011-000'];
      FNSU              := stlCampos.Values['012-000'];
      FAutorizacao      := stlCampos.Values['013-000'];

      FNParcelas        := StrToIntDef(stlCampos.Values['018-000'], 0);
      FDataTransacao    := stlCampos.Values['022-000'];
      FHoraTransacao    := stlCampos.Values['023-000'];
      FFinalizacao      := stlCampos.Values['027-000'];
      FTextoEspOperador := stlCampos.Values['030-000'];
      FTextoEspCliente  := stlCampos.Values['031-000'];

      QtdLinhas         := StrToIntDef(stlCampos.Values['028-000'], 0);

      FTemCupom         := QtdLinhas > 0;

      // Preenche a imagem do cupom
      FImagemCupom.Clear;
      for I := 1 to QtdLinhas do
      begin
        sLinha := Trim(stlCampos.Values['029-'+FormatFloat('000', I)]);
        // Adicionado para resolver o problema Visa da Mara - Inicio
          sLinha := Copy(sLinha, 2, Length(sLinha) - 2);
          if Trim(sLinha) = '' then
            sLinha := '';
          {FImagemCupom.Add(Copy(sLinha, 2, Length(sLinha) - 2));}
          FImagemCupom.Add(sLinha);
        // Adicionado para resolver o problema Visa da Mara - Fim
        Sleep(0);
      end;

      // Descomentar esse código para funcionar com parcelamento
      {
      FParcelas.Clear;

      if FNParcelas = 0 then
      begin
        AddParcela(TEFDateToDateTime(FDataTransacao), FValorAprovado, FNSU);
      end

      else
        for I := 1 to NParcelas do
        begin
          ADataParcela  := TEFDateToDateTime(Trim(stlCampos.Values['019-'+FormatFloat('000', I)]));
          AValorParcela := StrToIntDef(Trim(stlCampos.Values['020-'+FormatFloat('000', I)]), 0) / 100;
          ANSUParcela   := Trim(stlCampos.Values['021-'+FormatFloat('000', I)]);
          AddParcela(ADataParcela, AValorParcela, ANSUParcela);

          Sleep(0);
        end;
      }


      if FTemCupom then
      begin
        AddPending;
      end;


    finally
      stlCampos.Free;
      DeleteFile(REQUEST_FILE[FTEFDialType]);
    end;
    Result := True;
  except
    Result := False;
  end;
end;

function TTEFDial.AddParcela(AVencimento: TDateTime; AValor: Double; ANSUParcela: String): Integer;
var
  TEFParcela: TTEFParcela;
begin
  TEFParcela := TTEFParcela.Create;
  with TEFParcela do
  begin
    Vencimento := AVencimento;
    Valor      := AValor;
    NSUParcela := ANSUParcela;
  end;
  Result := FParcelas.Add(TEFParcela);
end;

procedure TTEFDial.AddPending;
var
  TEFPending : TTEFPending;
  Chave: String;
begin
  TEFPending := TTEFPending.Create;

  Chave := FRequisicao + FNSU;

  if not IniPersistence.SectionExists(Chave) then
  begin
    IniPersistence.WriteString(Chave, 'NSU', FNSU);
    IniPersistence.WriteString(Chave, 'DataTransacao', FDataTransacao);
    IniPersistence.WriteString(Chave, 'HoraTransacao', FHoraTransacao);
    IniPersistence.WriteString(Chave, 'FormaPagamento', FFormaPagamento);
    IniPersistence.WriteString(Chave, 'NomeRede', FNomeRede);
    IniPersistence.WriteFloat(Chave, 'ValorTotal', FValorTotal);
    IniPersistence.WriteFloat(Chave, 'ValorAprovado', FValorAprovado);
    IniPersistence.WriteString(Chave, 'CupomVinculado', FCupomVinculado);
    IniPersistence.WriteString(Chave, 'Requisicao', FRequisicao);
    IniPersistence.WriteBool(Chave, 'Confirmed', False);
    IniPersistence.WriteString(Chave, 'Finalizacao', FFinalizacao);
    IniPersistence.WriteInteger(Chave, 'TEFDIALType', FTEFDIALType);
  end;

  TEFPending.DataTransacao  := FDataTransacao;
  TEFPending.HoraTransacao  := FHoraTransacao;
  TEFPending.FormaPagamento := FFormaPagamento;
  TEFPending.NomeRede       := FNomeRede;
  TEFPending.NSU            := FNSU;
  TEFPending.Requisicao     := FRequisicao;
  TEFPending.ValorTotal     := FValorTotal;
  TEFPending.CupomVinculado := FCupomVinculado;
  TEFPending.Finalizacao    := FFinalizacao;
  TEFPending.Confirmed      := False;
  TEFPending.ValorAprovado  := FValorAprovado;
  TEFPending.ValorTotal     := FValorTotal;
  TEFPending.TEFDIALType    := FTEFDIALType;



  TEFPending.FImagemCupom.Clear;
  TEFPending.FImagemCupom.AddStrings(Self.FImagemCupom);

  FPendingList.Add(TEFPending);
end;

procedure TTEFDial.ClearPendingList;
begin
  while FPendingList.Count > 0 do
  begin
    TTEFPending(FPendingList[0]).Free;
    FPendingList[0] := nil;
    FPendingList.Delete(0);
  end;
end;

function TTEFDial.GetPendingByNSU(ANSU: String): Integer;
var
  I : Integer;
begin
  Result := -1;
  for I := 0 to FPendingList.Count - 1 do
  begin
    if FPendingList[I] <> nil then
      if (TTEFPending(FPendingList[I]).FRequisicao + TTEFPending(FPendingList[I]).NSU = ANSU) then
      begin
        Result := I;
        Break;
      end;
  end;
end;

procedure TTEFDial.RemovePending(ANSU: String; Save: Boolean = True);
var
  iPending: Integer;
begin
  if Save and IniPersistence.SectionExists(ANSU) then
    IniPersistence.EraseSection(ANSU);

  iPending := GetPendingByNSU(ANSU);
  if iPending >= 0 then
  begin
    TTEFPending(FPendingList[iPending]).Free;
    FPendingList[iPending] := nil;
    FPendingList.Delete(iPending);
    FPendingList.Pack;
  end;
end;

procedure TTEFDial.SetPendingConfirmed(ANSU: String);
var
  iPending: Integer;
begin
  iPending := GetPendingByNSU(ANSU);
  if iPending >= 0 then
  begin
    if IniPersistence.SectionExists(ANSU) then
      IniPersistence.WriteBool(ANSU, 'Confirmed', True);
    TTEFPending(FPendingList[iPending]).Confirmed := True;
  end;
end;

procedure TTEFDial.SetTEFToPending(Index: Integer);
var
  TEFPending : TTEFPending;
begin
  TEFPending      := TTEFPending(FPendingList[Index]);

  FValorTotal     := TEFPending.ValorTotal;
  FValorAprovado  := TEFPending.ValorAprovado;
  FNomeRede       := TEFPending.NomeRede;
  FHoraTransacao  := TEFPending.HoraTransacao;
  FNSU            := TEFPending.NSU;
  FFormaPagamento := TEFPending.FormaPagamento;
  FDataTransacao  := TEFPending.DataTransacao;
  FCupomVinculado := TEFPending.CupomVinculado;
  FRequisicao     := TEFPending.Requisicao;
  FFinalizacao    := TEFPending.Finalizacao;
  FTEFDIALType    := TEFPending.TEFDIALType;
  IDPreSale       := TEFPending.IDPreSale;

  FImagemCupom.Clear;
  FImagemCupom.AddStrings(TEFPending.FImagemCupom);

  FAprovada       := True;
  FTemCupom       := True;
end;


procedure TTEFDial.RemoveAllPendings(Save: Boolean = True);
var
  TEFPending: TTEFPending;
begin
  while FPendingList.Count > 0 do
  begin
    TEFPending := TTEFPending(FPendingList[0]);
    RemovePending(TEFPending.Requisicao + TEFPending.NSU, Save);
  end;
  FPendingList.Clear;
end;

procedure TTEFDial.ReadAllPendings;
var
  stlSessions: TStringList;
  I: Integer;
  TEFPending: TTEFPending;
begin
  RemoveAllPendings(False);

  stlSessions := TStringList.Create;
  try
    IniPersistence.ReadSections(stlSessions);
    for I := 0 to stlSessions.Count - 1 do
    begin
      TEFPending                 := TTEFPending.Create;
      TEFPending.FNSU            := IniPersistence.ReadString(stlSessions[I], 'NSU', '');
      TEFPending.FDataTransacao  := IniPersistence.ReadString(stlSessions[I], 'DataTransacao', '');
      TEFPending.FHoraTransacao  := IniPersistence.ReadString(stlSessions[I], 'HoraTransacao', '');
      TEFPending.FFormaPagamento := IniPersistence.ReadString(stlSessions[I], 'FormaPagamento', '');
      TEFPending.FNomeRede       := IniPersistence.ReadString(stlSessions[I], 'NomeRede', '');
      TEFPending.FValorTotal     := IniPersistence.ReadFloat(stlSessions[I], 'ValorTotal', 0);
      TEFPending.FValorAprovado  := IniPersistence.ReadFloat(stlSessions[I], 'ValorAprovado', 0);
      TEFPending.FCupomVinculado := IniPersistence.ReadString(stlSessions[I], 'CupomVinculado', '');
      TEFPending.FConfirmed      := IniPersistence.ReadBool(stlSessions[I], 'Confirmed', False);
      TEFPending.FRequisicao     := IniPersistence.ReadString(stlSessions[I], 'Requisicao', '');
      TEFPending.FFinalizacao    := IniPersistence.ReadString(stlSessions[I], 'Finalizacao', '');
      TEFPending.FTEFDIALType    := IniPersistence.ReadInteger(stlSessions[I], 'TEFDIALType', 0);

      FPendingList.Add(TEFPending);
    end;

  finally
    stlSessions.Free;
  end;
end;


function TTEFDial.FazTransacao(ARequestType: TRequestType): Boolean;
var
  Printed : Boolean;
begin
  Result := False;

  if FWorking then
    Exit;

  FWorking := True;
  try
    if not VerificaAtivacao then
      Exit;

    if FazRequisicao(ARequestType) then
      if VerificaStatus then
        if VerificaRetorno then
        begin
          if FAprovada and FTemCupom then
            begin
              Printed := ImprimeTudo;
              Result  := Printed;

              if Result then
                DeleteTEFFiles;
            end
          else
            Printed := True;

          if (not (ARequestType in [rtCNF, rtNCN])) and
          ((ARequestType = rtADM) and (FTemCupom or (StrToInt(FTipoTransacao) <> 0)) or (ARequestType <> rtADM)) then
          begin
            // HOMOLOGACAO
            // Loop para verificar ativação

            while not VerificaAtivacao do
            begin
             Sleep(7000);
            end;


            if (Printed) then
              begin
                FazRequisicao(rtCNF);
                Result := VerificaStatus;
              end
            else
              begin
                FazRequisicao(rtNCN);
                VerificaStatus;
                if Assigned(FOnDialog) then
                  FOnDialog(Self, mtPendencia, True);
              end;

          end;
        end;
  finally
    FWorking := False;
  end;
end;

function TTEFDial.VendaCheque: Boolean;
begin
  Result := False;

  if FWorking then
    Exit;

  FWorking := True;
  try
    if not VerificaAtivacao then
      Exit;

    //if FazRequisicao(rtCRT) then
    if FazRequisicao(rtCHQ) then
      if VerificaStatus then
        if VerificaRetorno then
          Result := FAprovada;
  finally
    FWorking := False;
  end;

  FRetorno := Result;
end;

function TTEFDial.VendaCartao: Boolean;
begin
  Result := False;

  if FWorking then
    Exit;

  FWorking := True;
  try
    if not VerificaAtivacao then
      Exit;

    if FazRequisicao(rtCRT) then
      if VerificaStatus then
        if VerificaRetorno then
          Result := FAprovada;
  finally
    FWorking := False;
  end;

  FRetorno := Result;
end;

procedure TTEFDial.RemoveRelactiveNSUs(NNSU: String);
var
  iPending: Integer;
begin
  iPending := GetPendingByNSU('CRT' + NNSU);
  if iPending >= 0 then
    RemovePending('CRT' + NNSU);
end;


function TTEFDial.Cancelamento: Boolean;
var
  sNSU: String;
begin
  sNSU := FNSU;
  Result := FazTransacao(rtCNC);
  if Result then
    RemoveRelactiveNSUs(sNSU);
  DeleteTEFFiles;
end;

function TTEFDial.Administracao: Boolean;
begin
  FValorAprovado := 0;
  FValorTotal := 0;
  Result := FazTransacao(rtADM);
  DeleteTEFFiles;
end;



function TTEFDial.ImprimeTudo: Boolean;
var
  VinculadoAberto,
  GerencialAberto,
  Printed,
  TryAgain,
  NeedVinculado: Boolean;
begin
  Result := False;
  TryAgain        := True;
  Printed         := False;
  VinculadoAberto := False;
  GerencialAberto := False;
  try
    NeedVinculado := not (FRequisicaoAtual in [rtCNC, rtADM]);

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


function TTEFDial.ConfirmaTransacao: Boolean;
var
  Printed: Boolean;
begin
  Result  := False;
  Printed := ImprimeTudo;

  if Printed then
    begin
      while not VerificaAtivacao do
        Sleep(7000);

      if ConfirmacaoSimples then
      begin
        //DeleteTEFFiles;
        RemoveAllPendings;
        Result := True;
      end;
    end
  else
    repeat
    until ResolvePendencias;
end;


function TTEFDial.Ativacao(Exibir: Boolean = True): Boolean;
begin
  Result := VerificaAtivacao;

  if Result Then
    if Exibir then
      if Assigned(FOnDialog) then
        FOnDialog(Self, mtAtividade, True);
  DeleteTEFFiles;
end;

function TTEFDial.ResolvePendencias: Boolean;
begin
  Result := True;
  try

    ReadAllPendings;
    if FPendingList.Count = 0 then
      Exit;

    // RE-PRE-HOMOLOGACAO
    (*

    // HOMOLOGACAO
    // Loop para verificar ativação
    while not VerificaAtivacao do
    begin
     Sleep(7000);
    end;

    *)

    ReadAllPendings;

    if FPendingList.Count > 0 then
    begin
      if not TTEFPending(FPendingList[FPendingList.Count - 1]).FConfirmed then
      begin
        SetTEFToPending(FPendingList.Count - 1);
        Result := CancelamentoSimples;
        // HOMOLOGACAO
        if Assigned(FOnDialog) then
          FOnDialog(Self, mtPendencia, True);
        if not Result then
          Exit;
      end;
    end;


    //for I := 0 to FPendingList.Count - 1 do
    while FPendingList.Count > 0 do
    begin
      // HOMOLOGACAO
      // Loop para verificar ativação
      while not VerificaAtivacao do
      begin
       Sleep(7000);
      end;
      if TTEFPending(FPendingList[FPendingList.Count-1]).FConfirmed then
      begin
        SetTEFToPending(FPendingList.Count-1);
        Result := Cancelamento;
        if not Result then
          Exit;
      end;
    end;

  except
    Result := False;
  end;
end;

function TTEFDial.ConfirmacaoSimples: Boolean;
begin
  Result := FazRequisicao(rtCNF, False);
  if Result then
    Result := VerificaStatus;
  DeleteTEFFiles;
  Sleep(2000);
end;

function TTEFDial.CancelamentoSimples: Boolean;
begin
  while not VerificaAtivacao do
    Sleep(7000);
  Result := FazRequisicao(rtNCN);
  if Result then
    Result := VerificaStatus;
  DeleteTEFFiles;
  Sleep(2000);
end;

function TTEFDial.PrintTEFVinculado(var VinculadoAberto: Boolean): Boolean;
var
  Printed: Boolean;
  iTefs,
  iVias,
  iLinhas : Integer;
begin
  Result          := False;
  VinculadoAberto := False;
  Printed         := False;

  BlockInput(FBloqueiaTeclado);
  try
    try
      for iTefs := 0 to FPendingList.Count - 1 do
      begin
        SetTEFToPending(iTefs);

        if not VinculadoAberto then
        begin
          VinculadoAberto  := DoOnNeedOpenVinculado;
          Printed          := VinculadoAberto;
        end;

        if Printed then
          for iVias := 1 to FVias do
          begin
            for iLinhas := 0 to FImagemCupom.Count - 1 do
            begin
              DoOnStatusPrinter(Printed);
              if not Printed then
                Exit;
              Printed := DoOnNeedPrintLineVinculado(FImagemCupom[iLinhas]);
              if not Printed then
                Exit;
            end;

            // Imprime linhas vazias para separar os cupons
            if iVias <> FVias then
            begin
              Printed := AvancaLinhasVinculado(LINHAS_AVANCO);
              if not Printed then
                Exit;
              Sleep(FTempoMensagem * 1000);
            end;

          end
        else
          Exit;

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

function TTEFDial.PrintTEFGerencial(var VinculadoAberto, GerencialAberto: Boolean): Boolean;
var
  Printed: Boolean;
  iTefs,
  iVias,
  iLinhas : Integer;
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
      for iTefs := 0 to FPendingList.Count - 1 do
      begin
        SetTEFToPending(iTefs);

        //if not VinculadoAberto then After Homo
        if not GerencialAberto then
        begin
          GerencialAberto  := DoOnNeedOpenGerencial;
          Printed          := GerencialAberto;
        end;

        if Printed then
          begin
            for iVias := 1 to FVias do
            begin
              for iLinhas := 0 to FImagemCupom.Count - 1 do
              begin
                DoOnStatusPrinter(Printed);
                if not Printed then
                  Exit;
                Printed := DoOnNeedPrintLineGerencial(FImagemCupom[iLinhas]);
                if not Printed then
                  Exit;
              end;

              // Imprime linhas vazias para separar os cupons
              if iVias <> FVias then
              begin
                Printed := AvancaLinhasGerencial(LINHAS_AVANCO);
                if not Printed then
                  Exit;
                Sleep(FTempoMensagem * 1000);
              end;

            end;
          end
        else
          Exit;
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


function TTEFDial.DoOnNeedOpenVinculado: Boolean;
var
  VinculadoInfo: TVinculadoInfo;
begin
  if Assigned(FOnNeedOpenVinculado) then
    begin
      VinculadoInfo := TVinculadoInfo.Create;
      try
        VinculadoInfo.CupomVinculado := Self.CupomVinculado;
        VinculadoInfo.FormaPagamento := Self.FormaPagamento;
        VinculadoInfo.IDMeioPag := Self.IDMeioPag;
        VinculadoInfo.ValorAprovado := Self.ValorAprovado;
        FOnNeedOpenVinculado(Self, VinculadoInfo, Result);
      finally
        VinculadoInfo.Free;
      end;
    end
  else
    Result := False;
end;


function TTEFDial.DoOnNeedOpenGerencial: Boolean;
begin
  if Assigned(FOnNeedOpenGerencial) then
    FOnNeedOpenGerencial(Self, Result)
  else
    Result := False;
end;

function TTEFDial.DoOnNeedCloseVinculado: Boolean;
begin
  Sleep(0);
  if Assigned(FOnNeedCloseVinculado) then
    FOnNeedCloseVinculado(Self, Result)
  else
    Result := False;
  Sleep(0);
end;

function TTEFDial.DoOnNeedCloseGerencial: Boolean;
begin
  Sleep(0);
  if Assigned(FOnNeedCloseGerencial) then
    FOnNeedCloseGerencial(Self, Result)
  else
    Result := False;
  Sleep(0);
end;

function TTEFDial.DoOnNeedPrintLineGerencial(LineToPrint: String): Boolean;
begin
  Sleep(0);
  if Assigned(FOnNeedPrintLineGerencial) then
    FOnNeedPrintLineGerencial(Self, LinhaNaoNula(LineToPrint), Result)
  else
    Result := False;
  Sleep(0);
end;

function TTEFDial.DoOnNeedPrintLineVinculado(LineToPrint: String): Boolean;
begin
  if Assigned(FOnNeedPrintLineVinculado) then
    FOnNeedPrintLineVinculado(Self, LinhaNaoNula(LineToPrint), Result)
  else
    Result := False;
  Sleep(0);
end;

function TTEFDial.AvancaLinhasVinculado(Count: Integer) : Boolean;
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

function TTEFDial.AvancaLinhasGerencial(Count: Integer) : Boolean;
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

function TTEFDial.DoOnTryAgainDialog: Boolean;
begin
  if Assigned(FOnTryAgainDialog) then
    FOnTryAgainDialog(Self, Result)
  else
    Result := False;
end;

function TTEFDial.LinhaNaoNula(S: String): String;
begin
  if S = '' then
    Result := FLinhaVazia
  else
    Result := S;
end;


{ TTEFPending }

constructor TTEFPending.Create;
begin
  FImagemCupom := TStringList.Create;
  inherited Create;
end;

destructor TTEFPending.Destroy;
begin
  FreeAndNil(FImagemCupom);
  inherited Destroy;
end;

function TTEFDial.TemPendencia: Boolean;
begin
  Result := FPendingList.Count > 0;
end;


procedure TTEFDial.DescarregaParaReserva;
var
  fHandle : LongInt;
  iRet: Boolean;
  RESERVED_FILE: String;
begin
  RESERVED_FILE := ExtractFilePath(Application.ExeName) + 'INTPOS.001';

  if FileExists(RESERVED_FILE) then
    DeleteFile(RESERVED_FILE);

  iRet := False;
  { Depois do arquivo Intpos.001 retornar da operadora copiar para  o diretório de  reserva }
  CopyFile(Pchar(RESPONSE_FILE[FTEFDialType]), Pchar(RESERVED_FILE), iRet);

  { Cria-se um Handle }
  fHandle := CreateFile('INTPOS.001',GENERIC_WRITE,0, nil, OPEN_ALWAYS,FILE_FLAG_NO_BUFFERING,0);

  { Descarrega o arquivo com essa função }
  FlushFileBuffers(fHandle);

  { Fecha o Handle }
  CloseHandle(fHandle);
end;


procedure TTEFDial.DeleteTEFFiles;
begin
  DeleteFile(TEMP_FILE[FTEFDialType]);
  DeleteFile(REQUEST_FILE[FTEFDialType]);
  DeleteFile(STATUS_FILE[FTEFDialType]);
  DeleteFile(RESPONSE_FILE[FTEFDialType]);
end;

function TTEFDial.GetParcelas(Index: Integer): TTEFParcela;
begin
  Result := FParcelas[Index];
end;

procedure TTEFDial.DoOnStatusPrinter(var Online: Boolean);
begin
  if Assigned(FOnStatusPrinter) then
    OnStatusPrinter(Self, Online)
  else
    Online := False;
end;

end.
