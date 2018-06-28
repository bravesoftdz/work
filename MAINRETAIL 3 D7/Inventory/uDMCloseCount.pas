unit uDMCloseCount;

interface

uses
  SysUtils, Classes, DB, ADODB, uDMInventory;

type
  TDMCloseCount = class(TDataModule)
    quInvCountItem: TADODataSet;
    cmdUpdInventory: TADOCommand;
    quModelByBarcode: TADODataSet;
    cmdUpdInvCount: TADOCommand;
    quInvFrozeItem: TADODataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSQLConnection: TADOConnection;
    FLogError: TStringList;
    FDMInventory: TDMInventory;
    FIDStore: Integer;
    FIDCount: Integer;
    FIDUser: Integer;

    procedure CloseCycleCount;
    procedure ClosePhysicalCount;
    procedure CloseLiveCount;
    procedure CloseStartUpCount;
    procedure UpdateInvCount;
    function GetModelByBarcode(ABarcode: String): Integer;
  public
    procedure CloseInvCount(AIDStore, AIDCount, AIDUser, ACountType: Integer);
    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property LogError: TStringList read FLogError write FLogError;
  end;

implementation

uses uSystemConst, uDM;

{$R *.dfm}

{ TDMCloseCount }

procedure TDMCloseCount.DataModuleCreate(Sender: TObject);
begin
  FLogError := TStringList.Create;
  FDMInventory := TDMInventory.Create(Self);
end;

procedure TDMCloseCount.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FLogError);
  FreeAndNil(FDMInventory);
end;

procedure TDMCloseCount.CloseInvCount(AIDStore, AIDCount, AIDUser,
  ACountType: Integer);
begin
  FDMInventory.SQLConnection := FSQLConnection;
  FIDStore := AIDStore;
  FIDCount := AIDCount;
  FIDUser := AIDUser;

  case ACountType of
    INV_COUNT_CYCLE:    CloseCycleCount;
    INV_COUNT_PHYSICAL: ClosePhysicalCount;
    INV_COUNT_LIVE:     CloseLiveCount;
    INV_COUNT_STARTUP:  CloseStartUpCount;
  end;

  UpdateInvCount;
end;

procedure TDMCloseCount.CloseCycleCount;
var
  iIDModel: Integer;
begin
  with quInvCountItem do
  try
    FSQLConnection.BeginTrans;
    try
      Connection := FSQLConnection;
      Parameters.ParamByName('IDCount').Value := FIDCount;
      Open;

      while not Eof do
      begin
        iIDModel := GetModelByBarcode(FieldByName('Barcode').AsString);
        if iIDModel <> -1 then
          FDMInventory.ReplaceInventory(FIDStore, iIDModel, FIDUser,
            FieldByName('Qty').AsFloat);

        Next;
      end;
    finally
      Close;
    end;

    FSQLConnection.CommitTrans;
  except
    on E: Exception do
    begin
      FLogError.Add('' + E.Message);
      FSQLConnection.RollbackTrans;
    end;
  end;
end;

procedure TDMCloseCount.ClosePhysicalCount;
var
  iIDModel: Integer;
begin
  try
    FSQLConnection.BeginTrans;
    with quInvFrozeItem do
    try
      Connection := FSQLConnection;
      Parameters.ParamByName('IDCount').Value := FIDCount;
      Open;

      while not Eof do
      begin
        iIDModel := FieldByName('IDModel').AsInteger;
        FDMInventory.ZeroInventory(FIDStore, iIDModel, FIDUser);
        Next;
      end;
    finally
      Close;
    end;

    with quInvCountItem do
    try
      Connection := FSQLConnection;
      Parameters.ParamByName('IDCount').Value := FIDCount;
      Open;

      while not Eof do
      begin
        iIDModel := GetModelByBarcode(FieldByName('Barcode').AsString);
        if iIDModel <> -1 then
          FDMInventory.AddInventory(FIDStore, iIDModel, FIDUser,
            FieldByName('Qty').AsFloat);

        Next;
      end;
    finally
      Close;
    end;

    FSQLConnection.CommitTrans;
  except
    on E: Exception do
    begin
      FLogError.Add('' + E.Message);
      FSQLConnection.RollbackTrans;
    end;
  end;
end;

procedure TDMCloseCount.CloseLiveCount;
begin
  with cmdUpdInvCount do
  try
    Connection := FSQLConnection;
    Parameters.ParamByName('IDCount').Value := FIDCount;
    Parameters.ParamByName('EndDate').Value := Now;

    Execute;
  except
    on E: Exception do
      FLogError.Add('' + E.Message);
  end;
end;

procedure TDMCloseCount.CloseStartUpCount;
begin
  //Look in catalog
  with cmdUpdInvCount do
  try
    Connection := FSQLConnection;
    Parameters.ParamByName('IDCount').Value := FIDCount;
    Parameters.ParamByName('EndDate').Value := Now;

    Execute;
  except
    on E: Exception do
      FLogError.Add('' + E.Message);
  end;
end;

procedure TDMCloseCount.UpdateInvCount;
begin
  with cmdUpdInvCount do
  try
    Connection := FSQLConnection;
    Parameters.ParamByName('IDCount').Value := FIDCount;
    Parameters.ParamByName('EndDate').Value := Now;

    Execute;
  except
    on E: Exception do
      FLogError.Add('' + E.Message);
  end;
end;

function TDMCloseCount.GetModelByBarcode(ABarcode: String): Integer;
begin
  Result := -1;

  with quModelByBarcode do
  try
    Connection := FSQLConnection;
    Parameters.ParamByName('Barcode').Value := ABarcode;
    Open;

    if Recordset.RecordCount > 0 then
      Result := FieldByName('IDModel').AsInteger;
  finally
    Close;
  end;
end;

end.
