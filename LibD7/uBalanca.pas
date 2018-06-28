unit uBalanca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

const
  BAL_PESO_BRUTO            = 1;
  BAL_PESO_TARA             = 2;
  BAL_PESO_LIQ              = 3;
  BAL_COUN_PASS             = 4;
  BAL_COD_BAL               = 5;
  BAL_VALOR_MONETARIO_KG    = 6;
  BAL_VALOR_MONETARIO_TOTAL = 7;
  BAL_NUM_DECIMAL           = 8;
  BAL_PESO_MEDIO_GRAMAS     = 9;
  BAL_DATA_FABRICACAO       = 10;
  BAL_DATA_VALIDADE         = 11;

  BAL_PESO_VARIANDO         = 1;
  BAL_PESO_ESTAVEL          = 2;

  BAL_MODEL_FILIZOLA_IDS_CONTINUO = 0;
  BAL_MODEL_RICE_LAKE_IQ_PLUS_810 = 1;
  BAL_MODEL_TOLEDO_9091           = 2;
  BAL_MODEL_TOLEDO_8132           = 3;
  BAL_MODEL_FILIZOLA_IDS_ID10000  = 4;
  BAL_MODEL_FILIZOLA_BP           = 5;
  BAL_MODEL_FILIZOLA_MF           = 6;
  BAL_MODEL_FILIZOLA_IDC          = 7;
  BAL_MODEL_FILIZOLA_E            = 8;
  BAL_MODEL_FILIZOLA_CS_PLURIS    = 9;
  BAL_MODEL_FILIZOLA_IDM          = 10;
  BAL_MODEL_FILIZOLA_IDU          = 11;
  BAL_MODEL_TRU_TEST_SR2000       = 12;
  BAL_MODEL_FILIZOLA_CI           = 13;

  BAL_TIPO_PLATINA                = 0;
  BAL_TIPO_TOLEDO                 = 1;
  BAL_TIPO_OUTRAS                 = 2;

  BAL_TIPO_BARCODE_PLATINA        = 0;
  BAL_TIPO_BARCODE_PRIX5          = 1;
  BAL_TIPO_POS_FILIZOLA           = 0;
  BAL_TIPO_POS_TOLEDO             = 1;

type
   PInteger = ^Integer;

   PObtemParametrosBalanca = function (Balanca: Integer; Modelo: PInteger;
                                       Porta: PInteger; BaudRate: PInteger;
                                       Tipo : PInteger; IP : PChar; Port : PInteger): Boolean stdcall;
   PInicializaLeitura = function (Balanca: Integer): Boolean; stdcall;
   PFinalizaLeitura = function (Balanca: Integer) : Boolean; stdcall;
   PConfiguraBalanca = function (Balanca: Integer; Aplicativo: THandle): Boolean; stdcall;
   PExibeMsgErro = Procedure (Aplicativo : THandle); stdcall;
   PObtemInformacao = function (Balanca: Integer; Campo: Integer): double; stdcall;
   PObtemNomeBalanca = Procedure (Modelo: Integer; Ret: PChar); stdcall;
   PEnviaPrecoCS = function (Balanca : integer; Preco : double) : Boolean; stdcall;


   TBalanca = Class
   private
     FHandleDLL: THandle;
     FNomeDll: String;
     FScaleLoaded: Boolean;

     FScaleSerialPort: String;
     FScaleCommType: Integer;
     FScaleBaudRate: Integer;
     FScaleIPEthernet: String;
     FScaleModel: String;
     FScalePortEthernet: String;
     FHandle: HWND;
     FScaleNum : Integer;

     ObtemParametrosBalanca : PObtemParametrosBalanca;
     InicializaLeitura : PInicializaLeitura;
     FinalizaLeitura : PFinalizaLeitura;
     ConfiguraBalanca : PConfiguraBalanca;
     ExibeMsgErro : PExibeMsgErro;
     ObtemInformacao : PObtemInformacao;
     ObtemNomeBalanca : PObtemNomeBalanca;
     EnviaPrecoCS : PEnviaPrecoCS;
     FScaleDecimal: Integer;

     function ObtemConfiguracoes : Boolean;
   public
     property ScaleModel        : String    read FScaleModel         write FScaleModel;
     property ScaleCommType     : Integer   read FScaleCommType      write FScaleCommType;
     property ScaleSerialPort   : String    read FScaleSerialPort    write FScaleSerialPort;
     property ScaleBaudRate     : Integer   read FScaleBaudRate      write FScaleBaudRate;
     property ScaleIPEthernet   : String    read FScaleIPEthernet    write FScaleIPEthernet;
     property ScalePortEthernet : String    read FScalePortEthernet  write FScalePortEthernet;
     property ScaleDecimal      : Integer   read FScaleDecimal       write FScaleDecimal;

     //funcoes
     function GetDecimalValue : Integer;

     //Abrir e fechar a balance
     function InitializeScale : Boolean;
     function FinalizeScale : Boolean;

     //Valores da balanca
     function GetScaleStatus(var AMsg : String) : Integer;
     function GetScaleValue(AValueType : Integer) : Double;
     function GetScaleModelValue : Double;
     function GetScaleDecimalFormat : String;

     //Abrir, Fechar e Configuragar comunicação com a balança
     function OpenScale : Boolean;
     function ConfigScale : Boolean;

     constructor Create(AOwner: TComponent);
     destructor Destroy; override;
   end;

implementation

uses uDM;

{ TBalanca }

//----------------------------LEMBRETES---------------------------//
{
  - Lembre-se que neste exemplo foi usado um objeto Timer para
    que o mesmo repeta as chamadas da Dll. Como opção pederiamos
    ter usado uma Thread.

  - A Dll PcScale.dll deve sempre estar no diretório Windows\System,
    ou no mesmo caminho onde do executável que a usa estiver rodando.

}


function TBalanca.OpenScale: boolean;
begin

  Result := ObtemConfiguracoes;

  if not Result then
  begin
    Result := ConfigScale;
    if not Result then
      ExibeMsgErro(Self.FHandle)
    else
      Result := ObtemConfiguracoes;
  end;

end;


function TBalanca.ObtemConfiguracoes : Boolean;
var
  CModelo: array[0..50] of char;
  CIP: array[0..17] of char;
  Porta, BaudRate, Tipo, Port: Integer;
begin

  if ObtemParametrosBalanca(0, @FScaleNum, @Porta, @BaudRate, @Tipo, @CIP, @Port) then
  begin
    ObtemNomeBalanca(FScaleNum, CModelo);
    FScaleModel        := CModelo;
    FScaleSerialPort   := 'COM' + IntToStr(Porta);
    FScaleBaudRate     := BaudRate;
    FScaleCommType     := Tipo;
    FScaleIPEthernet   := StrPas(CIP);
    FScalePortEthernet := IntToStr(Port);
    Result             := True;
  end
  else
    Result := False;

end;

constructor TBalanca.Create(AOwner: TComponent);
begin

  FHandleDLL := 0;
  FScaleLoaded := False;
  try

    @ObtemParametrosBalanca := nil;
    @InicializaLeitura := nil;
    @FinalizaLeitura := nil;
    @ConfiguraBalanca := nil;
    @ExibeMsgErro := nil;
    @ObtemInformacao := nil;
    @ObtemNomeBalanca := nil;
    @EnviaPrecoCS := nil;

    FNomeDll := 'PcScale.dll';
    FHandleDLL := LoadLibrary(PChar(FNomeDll));

    if FHandleDLL = 0 then
      raise Exception.CreateFmt('Não foi possível carregar %s (Erro:%d)', [FNomeDll, FHandle]);

    @ObtemParametrosBalanca := GetProcAddress(FHandleDLL, 'ObtemParametrosBalanca');
    @InicializaLeitura := GetProcAddress(FHandleDLL, 'InicializaLeitura');
    @FinalizaLeitura := GetProcAddress(FHandleDLL, 'FinalizaLeitura');
    @ConfiguraBalanca := GetProcAddress(FHandleDLL, 'ConfiguraBalanca');
    @ExibeMsgErro := GetProcAddress(FHandleDLL, 'ExibeMsgErro');
    @ObtemInformacao := GetProcAddress(FHandleDLL, 'ObtemInformacao');
    @ObtemNomeBalanca := GetProcAddress(FHandleDLL, 'ObtemNomeBalanca');
    @EnviaPrecoCS := GetProcAddress(FHandleDLL, 'EnviaPrecoCS');

    FScaleLoaded := True;

  except
  end;

end;

destructor TBalanca.Destroy;
begin

  if FScaleLoaded then
  begin
    FinalizeScale;
    if (FreeLibrary(FHandleDLL)) then
    begin
      FHandleDLL := 0;
      FScaleLoaded := False;
    end;
  end;

  inherited;
end;

function TBalanca.InitializeScale: Boolean;
begin

  Result := InicializaLeitura(0);

  if not Result then
    ExibeMsgErro(Self.FHandle);

end;

function TBalanca.FinalizeScale: Boolean;
begin

  Result := FinalizaLeitura(0);

  if not Result then
    ExibeMsgErro(Self.FHandle);

end;

function TBalanca.ConfigScale: Boolean;
begin
  Result := ConfiguraBalanca(0, Self.FHandle);
end;

function TBalanca.GetScaleStatus(var AMsg : String) : Integer;
begin

  Result := StrToInt(FloatToStr(ObtemInformacao(0, 0)));

  AMsg := '';

  case Result of
    0:  AMsg := 'Falha comunicando-se com a balança.';
    1:  AMsg := 'Peso Oscilando.';
    2:  AMsg := 'Peso Estável.';
    3:  AMsg := 'Sobrecarga de Peso ou Alivio de Plataforma.';
    4:  AMsg := 'Erro lendo licensa do Software.';
    99999: AMsg := 'Informação solicitada não existir para o modelo de indicador/balança';
  end;

end;

function TBalanca.GetScaleValue(AValueType: Integer): Double;
begin
  Result := ObtemInformacao(0, AValueType);
end;

function TBalanca.GetScaleDecimalFormat: String;
var
  i, iTotal : Integer;
begin

  Result := '0.';
  //iTotal := StrToInt(FloatToStr(ObtemInformacao(0, BAL_NUM_DECIMAL)));
  iTotal := FScaleDecimal;

  for i := 1 to iTotal do
      Result := Result + '0';

end;

function TBalanca.GetDecimalValue: Integer;
begin
  case FScaleDecimal of
    1 : Result := 10;
    2 : Result := 100;
    3 : Result := 1000;
    4 : Result := 10000;
  end;
end;

function TBalanca.GetScaleModelValue: Double;
begin
  case FScaleNum of
    BAL_MODEL_FILIZOLA_IDS_CONTINUO : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_RICE_LAKE_IQ_PLUS_810 : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_TOLEDO_9091           : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_TOLEDO_8132           : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_FILIZOLA_IDS_ID10000  : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_FILIZOLA_BP           : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_FILIZOLA_MF           : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_FILIZOLA_IDC          : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_FILIZOLA_E            : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_FILIZOLA_CS_PLURIS    : Result := GetScaleValue(BAL_PESO_LIQ);
    BAL_MODEL_FILIZOLA_IDM          : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_FILIZOLA_IDU          : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_TRU_TEST_SR2000       : Result := GetScaleValue(BAL_PESO_BRUTO);
    BAL_MODEL_FILIZOLA_CI           : Result := GetScaleValue(BAL_PESO_BRUTO);
    else GetScaleValue(BAL_PESO_BRUTO);
  end;

end;

end.
