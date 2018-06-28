unit uNTDataSetControl;

interface

uses Contnrs, DBClient, MConnect, Forms, Classes;

type
  TmrDataSet = class(TObject)
  private
    FDataSet: TClientDataSet;
  public
    constructor Create(ADataSet: TClientDataSet);
    property DataSet: TClientDataSet read FDataSet write FDataSet;
  end;

  TmrSessionList = class;

  TmrSession = class(TObjectList)
  private
    FOwner: TmrSessionList;
    function GetItem(Index: Integer): TmrDataSet;
    procedure SetItem(Index: Integer; const Value: TmrDataSet);
  public
    constructor Create(AOwner: TmrSessionList);
    procedure Terminate;
    function CreateDataSet(AConnection, AProviderName: String): TClientDataSet;
    property Items[Index: Integer]: TmrDataSet read GetItem write SetItem;
  end;

  TmrSessionList = class(TObjectList)
  private
    FOwner: TComponent;
    FConnection: TDispatchConnection;
    FOnReconcileError: TReconcileErrorEvent;
    function GetItem(Index: Integer): TmrSession;
    procedure SetItem(Index: Integer; const Value: TmrSession);
  public
    property Items[Index: Integer]: TmrSession read GetItem write SetItem;
    property Connection: TDispatchConnection read FConnection write FConnection;
    property OnReconcileError: TReconcileErrorEvent read FOnReconcileError write FOnReconcileError;
  end;

  TmrDataSetControl = class(TObject)
  private
    FRestrictForms : WideString;
    FSoftwareExpired : Boolean;
    FSoftwareExpirationDate : TDateTime;
    FSessionList: TmrSessionList;
    FOwner: TComponent;
    FConnection: TDispatchConnection;
    FOnReconcileError: TReconcileErrorEvent;
    procedure SetConnection(const Value: TDispatchConnection);
    procedure SetOnReconcileError(const Value: TReconcileErrorEvent);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    function CreateSession: TmrSession;
    property Connection: TDispatchConnection read FConnection write SetConnection;
    property OnReconcileError: TReconcileErrorEvent read FOnReconcileError write SetOnReconcileError;
    property RestrictForms : WideString read FRestrictForms write FRestrictForms;
    property SoftwareExpired : Boolean read FSoftwareExpired write FSoftwareExpired;
    property SoftwareExpirationDate : TDateTime read FSoftwareExpirationDate write FSoftwareExpirationDate;
  end;

implementation

{ TmrDataSetControl }

constructor TmrDataSetControl.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;
  FSessionList := TmrSessionList.Create;
  FSessionList.FOwner := AOwner;
end;

function TmrDataSetControl.CreateSession: TmrSession;
var
  Session: TmrSession;
begin
  Session := TmrSession.Create(FSessionList);
  FSessionList.Add(Session);
  Result := Session;
end;

destructor TmrDataSetControl.Destroy;
begin
  FSessionList.Free;
  inherited Destroy;
end;

procedure TmrDataSetControl.SetConnection(
  const Value: TDispatchConnection);
begin
  FConnection := Value;
  FSessionList.Connection := Value;
end;

procedure TmrDataSetControl.SetOnReconcileError(
  const Value: TReconcileErrorEvent);
begin
  FOnReconcileError := Value;
  FSessionList.OnReconcileError := Self.OnReconcileError;
end;

{ TmrSessionList }

function TmrSessionList.GetItem(Index: Integer): TmrSession;
begin
  Result := TmrSession(inherited Items[Index]);
end;

procedure TmrSessionList.SetItem(Index: Integer; const Value: TmrSession);
begin
  inherited Items[Index] := Value;
end;

{ TmrSession }

constructor TmrSession.Create(AOwner: TmrSessionList);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TmrSession.CreateDataSet(AConnection, AProviderName: String): TClientDataSet;
var
  Connection: TCustomRemoteServer;
begin
  if AConnection = '' then
    Connection := FOwner.Connection
  else
    Connection := TCustomRemoteServer(FOwner.FOwner.FindComponent(AConnection));
  Result := TClientDataSet.Create(FOwner.FOwner);
  with Result do
  begin
    RemoteServer := Connection;
    ProviderName := AProviderName;
    OnReconcileError := Self.FOwner.OnReconcileError;
  end;
  Add(TmrDataSet.Create(Result));
end;

procedure TmrSession.Terminate;
var
  I: Integer;
begin
  for I := 0 to Count -1 do
  begin
    Items[I].DataSet.BeforeGetRecords := nil;
    Items[I].DataSet.Close;
  end;
  FOwner.Remove(Self);
end;

function TmrSession.GetItem(Index: Integer): TmrDataSet;
begin
  Result := TmrDataSet(inherited Items[Index]);
end;

procedure TmrSession.SetItem(Index: Integer; const Value: TmrDataSet);
begin
  inherited Items[Index] := Value;
end;

{ TmrDataSet }

constructor TmrDataSet.Create(ADataSet: TClientDataSet);
begin
  FDataSet := ADataSet;
end;

end.
