unit uMRPinPad;

interface
uses Windows, SysUtils, Dialogs, VER1000XLib_TLB, VER2000XLib_TLB, uXML, uCreditCardFunction, uOperationSystem,
     dbClient, classes, uSystemConst, OleCtrls, OleServer;

const
  ctab  = Chr(9);
  ccrlf = Chr(13) + Chr(10);

type
  TMRPinPad = class
  private
    FVer1000X   : TVer1000X;
    FComPort    : String;
    FMsg        : String;
    AXMLContent : TXMLContent;

    FDataBits: String;
    FBaud: String;
    FComm: String;
    FParity: String;
    FDevice: String;
    FEncryptMethod: String;
    FTimeOut: String;
    function ProcessRequest(FXML : WideString):String;

  public
    Constructor Create;
    Destructor Destroy; override;

    property Device       : String  read FDevice        write FDevice;
    property Baud         : String  read FBaud          write FBaud;
    property Parity       : String  read FParity        write FParity;
    property Comm         : String  read FComm          write FComm;
    property DataBits     : String  read FDataBits      write FDataBits;
    property EncryptMethod: String  read FEncryptMethod write FEncryptMethod;
    property TimeOut      : String  read FTimeOut       write FTimeOut;

    property Comport: String read FComport write FComport;

    function GetDevice : String;
    function InitializePinPad : Boolean;
    function SetBaudRate : Boolean;
    function GetPin(FAccountNo : String; FAmount: Currency; var FPINBlock, FDervdKey : String):Boolean;
    function CancelRequest : Boolean;
    function ResetPinPad : Boolean;

  end;

implementation

{ TMRPinPad }

function TMRPinPad.CancelRequest: Boolean;
begin
  try
    FVer1000X.CancelRequest;
    Result := True;
  except
    Result := False;
  end;

end;

constructor TMRPinPad.Create;
begin
  FVer1000X   := TVer1000x.Create(nil);
  AXMLContent := TXMLContent.Create;
end;

destructor TMRPinPad.Destroy;
begin
  FreeAndNil(FVer1000X);
  FreeAndNil(AXMLContent);
  inherited;
end;

function TMRPinPad.GetDevice: String;
begin
  if FDevice = 'Verifone' then
    Result := '0'
  else if FDevice = 'Ingenico' then
    Result := '1'
  else if FDevice = '550/5000' then
    Result := '1'
  else
    Result := '0';
end;

function TMRPinPad.GetPin(FAccountNo: String; FAmount: Currency;
  var FPINBlock, FDervdKey: String): Boolean;
var
  strRequest, AResult: string;
begin

  try

    strRequest := '<?xml version="1.0"?>' + ccrlf + '<RequestStream>' + ccrlf +
                  ctab + ctab + '<ComPort>' + FComPort + '</ComPort>' + ccrlf +
                  ctab + ctab + '<Command>GetPin</Command>' + ccrlf +
                  ctab + ctab + '<Timeout>' + FTimeout + '</Timeout>' + ccrlf +
                  ctab + ctab + '<AccountNo>' + FAccountNo + '</AccountNo>' + ccrlf +
                  ctab + ctab + '<Amount>' + FormatFloat('0.00', FAmount) + '</Amount>' + ccrlf +
                  '</RequestStream>';

    FMsg := '';
    AXMLContent.XML := ProcessRequest(strRequest);

    AResult := AXMLContent.GetAttributeString('CmdStatus');

    if AResult <> 'Success' then
    begin
      FMsg := AResult + ' ' + AXMLContent.GetAttributeString('CmdStatus') + '. '+
              AXMLContent.GetAttributeString('TextResponse');
      Result := False;
    end
    else
    begin
      FPINBlock := AXMLContent.GetAttributeString('PINBlock');
      FDervdKey := AXMLContent.GetAttributeString('DervdKey');
      Result := True;
    end;
  finally
    ReseTPinPad;
    end;


end;

function TMRPinPad.InitializePinPad: Boolean;
var
  strRequest, AResult: string;
begin

  strRequest := '<?xml version="1.0"?>' + ccrlf + '<RequestStream>' + ccrlf +
                ctab + ctab + '<ComPort>' + FComPort + '</ComPort>' + ccrlf +
                ctab + ctab + '<Command>Init</Command>' + ccrlf +
                ctab + ctab + '<IdlePrompt>' + 'MainRetail' + '</IdlePrompt>' + ccrlf +
                '</RequestStream>';
  FMsg := '';
  AXMLContent.XML := ProcessRequest(strRequest);

  AResult := AXMLContent.GetAttributeString('CmdStatus');

  if AResult <> 'Success' then
  begin
    FMsg := AResult + ' ' + AXMLContent.GetAttributeString('CmdStatus') + '. '+
            AXMLContent.GetAttributeString('TextResponse');
    Result := False;
  end
  else
    Result := True;

end;

function TMRPinPad.ProcessRequest(FXML: WideString): String;
begin
   Result := FVer1000X.ProcessRequest(FXML, 0);
end;

function TMRPinPad.ResetPinPad: Boolean;
var
  strRequest, AResult: string;
begin

  strRequest := '<?xml version="1.0"?>' + ccrlf + '<RequestStream>' + ccrlf +
                ctab + ctab + '<ComPort>' + FComPort + '</ComPort>' + ccrlf +
                ctab + ctab + '<Command>ReseTPinPadDevice</Command>' + ccrlf +
                '</RequestStream>';

  FMsg := '';
  AXMLContent.XML := ProcessRequest(strRequest);

  AResult := AXMLContent.GetAttributeString('CmdStatus');

  if AResult <> 'Success' then
  begin
    FMsg := AResult + ' ' + AXMLContent.GetAttributeString('CmdStatus') + '. '+
            AXMLContent.GetAttributeString('TextResponse');
    Result := False;
  end
  else
    Result := True;

end;

function TMRPinPad.SetBaudRate: Boolean;
var
  strRequest, AResult: string;
begin

  strRequest := '<?xml version="1.0"?>' + ccrlf + '<RequestStream>' + ccrlf +
                ctab + ctab + '<ComPort>' + FComPort + '</ComPort>' + ccrlf +
                ctab + ctab + '<Command>SetBaudRate</Command>' + ccrlf +
                '</RequestStream>';

  FMsg := '';
  AXMLContent.XML := ProcessRequest(strRequest);

  AResult := AXMLContent.GetAttributeString('CmdStatus');

  if AResult <> 'Success' then
  begin
    FMsg := AResult + ' ' + AXMLContent.GetAttributeString('CmdStatus') + '. '+
            AXMLContent.GetAttributeString('TextResponse');
    Result := False;
  end
  else
    Result := True;

end;

end.
