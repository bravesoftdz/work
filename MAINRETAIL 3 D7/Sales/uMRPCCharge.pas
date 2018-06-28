unit uMRPCCharge;

interface

uses
  IniFiles, ADODB, uOperationSystem;

const
  PAYMENT_PROCESSOR = 'MRProcessor.ini';

type
  TMRPCCharge = class
  private
    FADOConnection: TADOConnection;
    FTimeOut: Integer;
    FPrintNum: Integer;
    FPort: Integer;
    FLastDate: Integer;
    FServer: String;
    FUser: String;
    FPath: String;
    FMultTrans: Boolean;
    FProcessorType: Integer;
    FPCChargeConfig: TIniFile;
    FIDMeioPag: Integer;
    FCopies: Integer;
    FMercantAcc: String;
    FProcessor: String;

    function DescCodigo(AFilterFields, AFilterValues: array of String;
      ADescTable, ADescField: String): String;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetIDMeioPag(const Value: Integer);
    procedure SetProcessor(AMeioPag, AProcessor, AMercantAcc: String; ACopies: Integer); overload;
    procedure SetProcessor(AIDMeioPag: Integer; AProcessor, AMercantAcc: String; ACopies: Integer); overload;

    property ADOConnection: TADOConnection read FADOConnection write FADOConnection;
    property IDMeioPag: Integer read FIDMeioPag write SetIDMeioPag;
    property Processor: String read FProcessor write FProcessor;
    property MercantAcc: String read FMercantAcc write FMercantAcc;
    property Copies: Integer read FCopies write FCopies;
    property Path: String  read FPath write FPath;
    property User: String  read FUser write FUser;
    property Server: String  read FServer write FServer;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property LastDate: Integer read FLastDate write FLastDate;
    property PrintNum: Integer read FPrintNum write FPrintNum;
    property Port: Integer read FPort write FPort;
    property ProcessorType: Integer read FProcessorType write FProcessorType;
    property MultTrans: Boolean read FMultTrans write FMultTrans;
  end;

implementation

uses SysUtils, Windows, Forms, DB, Registry, uStringFunctions, uSystemConst;

{ TMRPCCharge }

constructor TMRPCCharge.Create;
var
   buildInfo: String;
begin
  FPCChargeConfig := TIniFile.Create(ExtractFilePath(Application.ExeName) + PAYMENT_PROCESSOR);

 with TRegistry.Create do
 try
    // aponta para a chave CURRENT_USER se Windows 7
    if ( getOs(buildInfo) = osW7 ) then
      RootKey := HKEY_CURRENT_USER
    else
      RootKey := HKEY_LOCAL_MACHINE;

   OpenKey(REGISTRY_PATH, True);
   FTimeOut                    := ReadInteger('PCChargeTimeOut');
   FPrintNum                   := ReadInteger('PCChargePrintNum');
   FPort                       := ReadInteger('PCChargePort');
   FLastDate                   := ReadInteger('PCChargeLastDate');
   FServer                     := ReadString('PCChargeServer');
   FUser                       := ReadString('PCChargeUser');
   FPath                       := ReadString('PCChargePath');
   FMultTrans                  := ReadBool('PCChargeMultTrans');
   FProcessorType              := ReadInteger('ProcessorType');
 finally
   Free;
 end;
end;

destructor TMRPCCharge.Destroy;
begin
  FreeAndNil(FPCChargeConfig);
  inherited;
end;

procedure TMRPCCharge.SetProcessor(AMeioPag, AProcessor,
  AMercantAcc: String; ACopies: Integer);
var
  IDMeioPag: Integer;
begin
  IDMeioPag := StrToIntDef(DescCodigo(['MeioPag'], [QuotedStr(AMeioPag)], 'MeioPag', 'IDMeioPag'), 0);
  SetProcessor(IDMeioPag, AProcessor, AMercantAcc, ACopies);
end;

procedure TMRPCCharge.SetProcessor(AIDMeioPag: Integer; AProcessor,
  AMercantAcc: String; ACopies: Integer);
begin
  FPCChargeConfig.WriteString(IntToStr(AIDMeioPag), 'Processor', AProcessor);
  FPCChargeConfig.WriteString(IntToStr(AIDMeioPag), 'MercantNum', AMercantAcc);
  FPCChargeConfig.WriteInteger(IntToStr(AIDMeioPag), 'Copies', ACopies);
end;

function TMRPCCharge.DescCodigo(AFilterFields, AFilterValues: array of String;
  ADescTable, ADescField: String): String;
var
  i: Integer;
  sWhere, sSelect: String;
begin
  Result := '';
  sWhere := '';

  for i := Low(AFilterFields) to High(AFilterFields) do
  begin
    IncString(sWhere, '( ' + AFilterFields[i] + ' = ' + AFilterValues[i] + ' )');
    if i < High(AFilterFields) then
      IncString(sWhere, ' AND ');
  end;

  sSelect := 'SELECT ' + ADescField + ' FROM ' + ADescTable + ' WHERE ' + sWhere;

  with TADOQuery.Create(nil) do
  try
    Connection := FADOConnection;
    SQL.Text := sSelect;
    try
      Open;
      if not IsEmpty then
        Result := Fields[0].AsString;
    except
      raise Exception.Create('You enter an invalid search');
    end;
  finally
    Free;
  end;
end;

procedure TMRPCCharge.SetIDMeioPag(const Value: Integer);
begin
  FIDMeioPag := Value;
  FProcessor := FPCChargeConfig.ReadString(IntToStr(FIDMeioPag), 'Processor', '');
  FMercantAcc := FPCChargeConfig.ReadString(IntToStr(FIDMeioPag), 'MercantNum', '');
  FCopies := FPCChargeConfig.ReadInteger(IntToStr(FIDMeioPag), 'Copies', 1);

  if Trim(FProcessor) = '' then
    Exception.Create('Invalid "Processor". Card not charged')
  else if Trim(FMercantAcc) = '' then
    Exception.Create('Invalid "Mercant Number". Card not charged');
end;

end.
