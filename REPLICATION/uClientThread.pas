unit uClientThread;

interface

uses Classes, IdTCPClient, URepSocketTypes, SysUtils;

type
  TClientThread = class(TThread)
  published
    Client : TIdTCPClient;
  private
    FData: TClientData;
  public
      property Data: TClientData read FData write FData;
      constructor Create(CreateSuspended: Boolean);
      destructor Destroy;override;
      procedure Execute;Override;
      property Terminated;
  end;



implementation
uses URepSocketFunctions;
{ TClientThread }

constructor TClientThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FData := TClientData.Create;
  FData.SendingList.Clear;
  FData.SendingList.Add('', '');
end;


destructor TClientThread.Destroy;
begin
  FreeAndNil(FData);
  inherited Destroy;
end;

procedure TClientThread.Execute;
begin
  inherited;
  Sleep(0);
  try
    if (not Self.Terminated and Client.Connected) then
    while (not Self.Terminated and Client.Connected) do
    begin
      ThreadFlow(FData);
      Sleep(0);
    end;
  finally
    Self.Terminate;
    Client.Disconnect;
  end;
end;

end.

