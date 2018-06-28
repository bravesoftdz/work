unit uPetCenterCli;

interface

uses
  SysUtils, Classes, ShellAPI, Windows, Dialogs, IdTCPConnection,
  IdTCPClient;

type
  TPetCenterComponentType = (ictInvoice);

  TInvoiceStreamHeader = record
    ByteCount: Int64;
    PCComponentType: TPetCenterComponentType;
    ComponentCount: Integer;
  end;

  TInvoiceInfo = record
    IDPreSale : Integer;
  end;

  TPetCenterClient = class
  private
    IdTCPClient: TIdTCPClient;
    FServerIP: String;
    FServerPort: Integer;
    function ConnectToPetCenter : Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetPetCenterConInfo(AServerIP : String; AServerPort : Integer);
    function SendSale(AIDPerSale : Integer) : Boolean;
  end;

implementation

{ TPetCenterClient }

function TPetCenterClient.ConnectToPetCenter: Boolean;
begin
  Result := False;

  if FServerIP <> '' then
    with IdTCPClient do
    try
      if not Connected then
      begin
        Host := FServerIP;
        Port := FServerPort;
        Connect(5000);
      end;
      Result := True;
    except
      Result := False;
      end;

end;

constructor TPetCenterClient.Create;
begin
  IdTCPClient  := TIdTCPClient.Create(nil);
end;

destructor TPetCenterClient.Destroy;
begin
  if IdTCPClient.Connected then
  begin
    IdTCPClient.DisconnectSocket;
    IdTCPClient.Disconnect;
  end;
  FreeAndNil(IdTCPClient);
  inherited;
end;

function TPetCenterClient.SendSale(AIDPerSale: Integer): Boolean;
var
  Header: TInvoiceStreamHeader;
  HeaderStream, InvoiceStream : TMemoryStream;
  InvoiceInfoRecord : TInvoiceInfo;
begin
  InvoiceInfoRecord.IDPreSale := AIDPerSale;
  Result := False;

  if (InvoiceInfoRecord.IDPreSale <> 0) and ConnectToPetCenter then
    with IdTCPClient do
      if Connected then
      begin
        InvoiceStream := TMemoryStream.Create;
        try
          HeaderStream := TMemoryStream.Create;
          try
            //Crio uma stream do invoice
            InvoiceStream.WriteBuffer(InvoiceInfoRecord, SizeOf(TInvoiceInfo));
            InvoiceStream.Seek(0, soFromBeginning);
            //Crio o header do invoice
            Header.ByteCount := InvoiceStream.Size;
            Header.ComponentCount := 1;
            Header.PCComponentType := ictInvoice;
            //Preparo a stream do header
            HeaderStream.WriteBuffer(Header, SizeOf(TInvoiceStreamHeader));
            HeaderStream.Seek(0, soFromBeginning);
            //Envio a stream do header e do invoice
            WriteStream(HeaderStream);
            //Envio a stream do body
            WriteStream(InvoiceStream);

            Result := True;
          finally
            FreeAndNil(HeaderStream);
          end;
        finally
          FreeAndNil(InvoiceStream);
        end;

      end;
end;

procedure TPetCenterClient.SetPetCenterConInfo(AServerIP: String;
  AServerPort: Integer);
begin
  FServerIP := AServerIP;
  FServerPort := AServerPort;
end;


end.
