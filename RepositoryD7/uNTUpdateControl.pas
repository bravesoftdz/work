unit uNTUpdateControl;

interface

uses Classes, Contnrs, DBClient, MConnect;

type
  TmrDataSetUpdate = class(TObject)
  private
    FDataSet: TClientDataSet;
  public
    constructor Create(ADataSet: TClientDataSet);
    property DataSet: TClientDataSet read FDataSet write FDataSet;
  end;

  TmrTransactionList = class;

  TmrTransaction = class(TObjectList)
  private
    FOwner: TmrTransactionList;
    function GetItem(Index: Integer): TmrDataSetUpdate;
    procedure SetItem(Index: Integer; const Value: TmrDataSetUpdate);
    function GetDataSetUpdateByCds(ADataSet: TClientDataSet): TmrDataSetUpdate;
    function ApplyUpdates: Boolean;
  public
    constructor Create(AOwner: TmrTransactionList);
    destructor Destroy; override;
    procedure PostUpdate(ADataSet: TClientDataSet);
    procedure CancelUpdate(ADataSet: TClientDataSet);
    function CommitTransaction: Boolean;
    procedure RollBackTransaction;
    property Items[Index: Integer]: TmrDataSetUpdate read GetItem write SetItem;
    property Owner: TmrTransactionList read FOwner;
  end;

  TmrTransactionList = class(TObjectList)
  private
    FOnReconcileError: TReconcileErrorEvent;
    FConnection: TDispatchConnection;
    function GetItem(Index: Integer): TmrTransaction;
    procedure SetItem(Index: Integer; const Value: TmrTransaction);
  public
    property Items[Index: Integer]: TmrTransaction read GetItem write SetItem;
    property Connection: TDispatchConnection read FConnection write FConnection;
    property OnReconcileError: TReconcileErrorEvent read FOnReconcileError write FOnReconcileError;
  end;

  TmrUpdateControl = class(TObject)
  private
    FTransactionList: TmrTransactionList;
    FConnection: TDispatchConnection;
    FOnReconcileError: TReconcileErrorEvent;
    procedure SetConnection(const Value: TDispatchConnection);
    procedure SetOnReconcileError(const Value: TReconcileErrorEvent);
  public
    constructor Create;
    destructor Destroy; override;
    function CreateTransaction: TmrTransaction;
    property Connection: TDispatchConnection read FConnection write SetConnection;
    property OnReconcileError: TReconcileErrorEvent read FOnReconcileError write SetOnReconcileError;
  end;

implementation

uses SysUtils;

{ TmrTransaction }

function TmrTransaction.ApplyUpdates: Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count -1 do
  begin
    Result := True;
    if Items[I].DataSet.ChangeCount > 0 then
      Result := Items[I].DataSet.ApplyUpdates(-1) = 0;
    if not Result then
      Break
    else
      if Items[I].DataSet.ChangeCount > 0 then
        Items[I].DataSet.MergeChangeLog;
  end;
end;

procedure TmrTransaction.PostUpdate(ADataSet: TClientDataSet);
var
  DataSetUpdate: TmrDataSetUpdate;
begin
  DataSetUpdate := GetDataSetUpdateByCds(ADataSet);
  if not Assigned(DataSetUpdate) then
  begin
    DataSetUpdate := TmrDataSetUpdate.Create(ADataSet);
    DataSetUpdate.DataSet.OnReconcileError := Owner.OnReconcileError;
    Insert(0, DataSetUpdate);
  end;
end;

procedure TmrTransaction.CancelUpdate(ADataSet: TClientDataSet);
var
  DataSetUpdate: TmrDataSetUpdate;
begin
  DataSetUpdate := GetDataSetUpdateByCds(ADataSet);
  if Assigned(DataSetUpdate) then
    Owner.Remove(DataSetUpdate);
end;

function TmrTransaction.GetItem(Index: Integer): TmrDataSetUpdate;
begin
  Result := TmrDataSetUpdate(inherited Items[Index]);
end;

function TmrTransaction.GetDataSetUpdateByCds(ADataSet: TClientDataSet): TmrDataSetUpdate;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count -1 do
    if Items[I].DataSet = ADataSet then
    Begin
      Result := Items[I];
      Break;
    end;
end;

procedure TmrTransaction.SetItem(Index: Integer; const Value: TmrDataSetUpdate);
begin
  inherited Items[Index] := Value;
end;

function TmrTransaction.CommitTransaction: Boolean;
begin
  Result := False;
  try
    Owner.Connection.AppServer.StartTransaction;
    Result := ApplyUpdates;
    if Result then
    begin
      Owner.Connection.AppServer.CommitTransaction;
      Owner.Remove(Self);
    end
  except
    if Owner.Connection.AppServer.InTransaction then
      Owner.Connection.AppServer.RollBackTransaction;
  end;
end;

procedure TmrTransaction.RollBackTransaction;
var
  I: Integer;
begin
  for I := 0 to Count -1 do
    Items[I].DataSet.CancelUpdates;
  Owner.Remove(Self);
end;

constructor TmrTransaction.Create(AOwner: TmrTransactionList);
begin
  inherited Create;
  OwnsObjects := False;
  FOwner := AOwner;
end;

destructor TmrTransaction.Destroy;
var
  DataSetUpdate: TmrDataSetUpdate;
  i : integer;
begin

  for i := 0 to Count-1 do
  begin
    DataSetUpdate := Items[i];
    FreeAndNil(DataSetUpdate);
  end;
  
  inherited;
end;

{ TmrTransactionList }

function TmrTransactionList.GetItem(Index: Integer): TmrTransaction;
begin
  Result := TmrTransaction(inherited Items[Index]);
end;

procedure TmrTransactionList.SetItem(Index: Integer; const Value: TmrTransaction);
begin
  inherited Items[Index] := Value;
end;

{ TmrUpdateControl }

constructor TmrUpdateControl.Create;
begin
  inherited Create;
  FTransactionList := TmrTransactionList.Create;
end;

function TmrUpdateControl.CreateTransaction: TmrTransaction;
var
  Transaction: TmrTransaction;
begin
  Transaction := TmrTransaction.Create(FTransactionList);
  FTransactionList.Add(Transaction);
  Result := Transaction;
end;

destructor TmrUpdateControl.Destroy;
begin
  FTransactionList.Free;
  inherited Destroy;
end;

procedure TmrUpdateControl.SetConnection(const Value: TDispatchConnection);
begin
  FConnection := Value;
  FTransactionList.Connection := Self.Connection;
end;

procedure TmrUpdateControl.SetOnReconcileError(
  const Value: TReconcileErrorEvent);
begin
  FOnReconcileError := Value;
  FTransactionList.OnReconcileError := Self.OnReconcileError;
end;

{ TmrDataSetUpdate }

constructor TmrDataSetUpdate.Create(ADataSet: TClientDataSet);
begin
  inherited Create;
  FDataSet := ADataSet;
end;

end.

