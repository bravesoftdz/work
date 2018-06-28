unit uThreadConnectMRPDS;

interface

uses
  Classes, uInvoicePollDisplay, IdTCPClient;

type
  TAfterSynchAdvertising = procedure of object;
  TAfterSynchCrossSaleItem = procedure of object;

  TThreadConnectMRPDS = class(TThread)
  private
    TCPClient: TIdTCPClient;
    FLocalPath: String;
    FIP : String;
    FPort : Integer;
    FTerminated: Boolean;
    FAfterSynchAdvertising: TAfterSynchAdvertising;
    FAfterSynchCrossSaleItem: TAfterSynchCrossSaleItem;
    function SimpleStreamRequest(
      ARequestType: TMRPDSHeaderType): TMemoryStream;
    procedure SynchAdvertising;
    procedure SynchCrossSaleItem;
    { Private declarations }
  public
    property LocalPath: String read FLocalPath write FLocalPath;
    property IP: String read FIP write FIP;
    property Port: Integer read FPort write FPort;
    property Terminated: Boolean read FTerminated write FTerminated;

    property AfterSynchAdvertising: TAfterSynchAdvertising read FAfterSynchAdvertising write FAfterSynchAdvertising;
    property AfterSynchCrossSaleItem: TAfterSynchCrossSaleItem read FAfterSynchCrossSaleItem write FAfterSynchCrossSaleItem;

    constructor Create(CreateSuspended: Boolean);
  protected
    procedure Execute; override;
  end;

implementation


{ ThreadConnectMRPDS }

constructor TThreadConnectMRPDS.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FTerminated := False;
end;

procedure TThreadConnectMRPDS.Execute;
begin
  FTerminated := False;
  try
    if FIP = '' then
      Exit;

    TCPClient := TIdTCPClient.Create(nil);
    try
      TCPClient.Host := FIP;
      TCPClient.Port := FPort;

      try
        TCPClient.Connect(5000);
      except
      end;
      
      if TCPClient.Connected then
      begin
        SynchAdvertising;
        SynchCrossSaleItem;
      end;
    finally
      TCPClient.Free;
    end;
  finally
    FTerminated := True;
  end;
end;

function TThreadConnectMRPDS.SimpleStreamRequest(ARequestType: TMRPDSHeaderType): TMemoryStream;
var
  SendingHeader, ReceivingHeader: TMRPDSHeader;
  SendingStream, SendingHeaderStream, ReceivingStream: TMemoryStream;
begin

  ReceivingStream := TMemoryStream.Create;

  SendingHeaderStream := TMemoryStream.Create;
  try
    SendingStream := TMemoryStream.Create;
    try
      SendingStream.Write(SendingHeader, SizeOf(TMRPDSHeader));

      SendingHeader.BodyType := ARequestType;
      SendingHeader.ByteCount := SendingStream.Size;

      SendingHeaderStream.Write(SendingHeader, SizeOf(TMRPDSHeader));

      SendingStream.Seek(0, soFromBeginning);
      SendingHeaderStream.Seek(0, soFromBeginning);

      TCPClient.WriteStream(SendingHeaderStream);
      TCPClient.WriteStream(SendingStream);
    finally
      SendingStream.Free;
    end;
  finally
    SendingHeaderStream.Free;
  end;

  TCPClient.ReadStream(ReceivingStream, SizeOf(TMRPDSHeader));
  ReceivingStream.Seek(0, soFromBeginning);


  ReceivingHeader := TMRPDSHeader(ReceivingStream.Memory^);

  ReceivingStream.Clear;
  ReceivingStream.Seek(0, soFromBeginning);

  TCPClient.ReadStream(ReceivingStream, ReceivingHeader.ByteCount);
  ReceivingStream.Seek(0, soFromBeginning);

  Result := ReceivingStream;
end;

procedure TThreadConnectMRPDS.SynchAdvertising;
var
  ReceivedStream : TMemoryStream;
begin
  ReceivedStream := SimpleStreamRequest(pdsAdvertising);
  if ReceivedStream.Size > 0 then
  begin
    ReceivedStream.SaveToFile(FLocalPath + 'Advertising.xml');
    ReceivedStream.Clear;
    ReceivedStream.Free;
  end;

  if Assigned(FAfterSynchAdvertising) then
    FAfterSynchAdvertising;
end;

procedure TThreadConnectMRPDS.SynchCrossSaleItem;
var
  ReceivedStream : TMemoryStream;
begin
  ReceivedStream := SimpleStreamRequest(pdsCrossSaleItem);
  if ReceivedStream.Size > 0 then
  begin
    ReceivedStream.SaveToFile(FLocalPath + 'CrossSaleItem.xml');
    ReceivedStream.Clear;
    ReceivedStream.Free;
  end;

  if Assigned(FAfterSynchCrossSaleItem) then
    FAfterSynchCrossSaleItem;
end;


end.
