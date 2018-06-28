unit uClientThread;

interface

uses Classes, IdTCPClient, URepSocketTypes, SysUtils;

type
  TClientThread = class(TThread)
    Client : TIdTCPClient;
    Data: TClientData;
    public
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
  Data := TClientData.Create;
  Data.SendingList.Clear;
  Data.SendingList.Add('', '');
end;


destructor TClientThread.Destroy;
begin
  FreeAndNil(Data);
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
      ThreadFlow(Self.Data);
      Sleep(0);
    end;
  finally
    Self.Terminate;
    Client.Disconnect;
  end;
end;

end.
