unit uDMInventory;

interface

uses
  SysUtils, Classes, DB, ADODB, Variants;

type
  TDMInventory = class(TDataModule)
    quQtyDifference: TADODataSet;
    cmdInsInventoryMov: TADOCommand;
    quModelExist: TADODataSet;
    quCategory: TADODataSet;
    cmdInsertModelPriceLog: TADOCommand;
    spLotAdjust: TADOStoredProc;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSQLConnection: TADOConnection;
    FLogError: TStringList;

    procedure InsertInventoryMov(AIDStore, AIDModel, AIDUser,
      AIDMovType: Integer; AQty: Double);
    function GetQtyDifference(AIDStore, AIDModel: Integer; AQty: Double): Double;
  public
    procedure ZeroInventory(AIDStore, AIDModel, AIDUser: Integer);
    procedure AddInventory(AIDStore, AIDModel, AIDUser: Integer; AQty: Double);
    procedure ReplaceInventory(AIDStore, AIDModel, AIDUser: Integer; AQty: Double);
    procedure ModelPriceLog(AIDModel, AIDUser, AIDStore : Integer; 
      AOldCost, ANewCost, AOldSale, ANewSale : Currency);
    function GetValidModelCode: String;
    function GetModelType(IDCategory:Integer):Char;
    function LotAdjust(AIDModel, AIDStore, AIDLot : Integer; AQty : Double; AType : Integer):Boolean;

    property SQLConnection: TADOConnection read FSQLConnection write FSQLConnection;
    property LogError: TStringList read FLogError write FLogError;
  end;

implementation

uses uDM, uSystemConst;

{$R *.dfm}

{ TDMInventory }

procedure TDMInventory.AddInventory(AIDStore, AIDModel, AIDUser: Integer;
  AQty: Double);
begin
  InsertInventoryMov(AIDStore, AIDModel, AIDUser, INV_MOVTYPE_INCREASEONHAND, AQty);
end;

function TDMInventory.GetQtyDifference(AIDStore, AIDModel: Integer;
  AQty: Double): Double;
begin
  with quQtyDifference do
  try
    Connection := SQLConnection;
    Parameters.ParamByName('IDStore').Value := AIDStore;
    Parameters.ParamByName('IDModel').Value := AIDModel;
    Open;

    Result := AQty - FieldByName('QtyOnHand').AsFloat;
  finally
    Close;
  end;
end;

procedure TDMInventory.InsertInventoryMov(AIDStore, AIDModel, AIDUser,
  AIDMovType: Integer; AQty: Double);
begin
  with cmdInsInventoryMov do
  try
    Connection := SQLConnection;
    Parameters.ParamByName('IDInventoryMov').Value := DM.GetNextID(MR_INVENTORY_MOV_ID);
    Parameters.ParamByName('InventMovTypeID').Value := AIDMovType;
    Parameters.ParamByName('DocumentID').Value := 0;
    Parameters.ParamByName('IDStore').Value := AIDStore;
    Parameters.ParamByName('IDModel').Value := AIDModel;
    Parameters.ParamByName('MovDate').Value := Now;
    Parameters.ParamByName('Qty').Value := AQty;
    Parameters.ParamByName('IDUser').Value := AIDUser;
    Execute;
  except
    on E: Exception do
      FLogError.Add('' + E.Message);
  end;
end;

procedure TDMInventory.ReplaceInventory(AIDStore, AIDModel, AIDUser: Integer;
  AQty: Double);
var
  iIDMovType: Integer;
  dQty: Double;
begin
  dQty := GetQtyDifference(AIDStore, AIDModel, AQty);
  if dQty > 0 then
    iIDMovType := INV_MOVTYPE_INCREASEONHAND
  else
    iIDMovType := INV_MOVTYPE_DECREASEONHAND;

  InsertInventoryMov(AIDStore, AIDModel, AIDUser, iIDMovType, Abs(dQty));
end;

procedure TDMInventory.ZeroInventory(AIDStore, AIDModel, AIDUser: Integer);
var
  iIDMovType: Integer;
  dQty: Double;
begin
  dQty := GetQtyDifference(AIDStore, AIDModel, 0);
  if dQty > 0 then
    iIDMovType := INV_MOVTYPE_RESETUPTOZERO
  else
    iIDMovType := INV_MOVTYPE_RESETDOWNTOZERO;

  InsertInventoryMov(AIDStore, AIDModel, AIDUser, iIDMovType, Abs(dQty));
end;

procedure TDMInventory.DataModuleCreate(Sender: TObject);
begin
  FLogError := TStringList.Create;
end;

procedure TDMInventory.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FLogError);
end;

function TDMInventory.GetValidModelCode: String;
var
  bValidModel: Boolean;
begin
  bValidModel := False;

  while not bValidModel do
  try
    Result := IntToStr(DM.GetNextID('Model.Model'));

    quModelExist.Parameters.ParamByName('Model').Value := Result;
    quModelExist.Open;
    bValidModel := quModelExist.IsEmpty;
  finally
    quModelExist.Close;
  end;

end;

function TDMInventory.GetModelType(IDCategory: Integer): Char;
begin
  Result := MODEL_TYPE_REGULAR;

  with quCategory do
    try
     if not(Active) then
      Open;

     if Locate('IDGroup', IDCategory, []) then
      begin
        if FieldByName('SizeAndColor').AsBoolean then
          Result := MODEL_TYPE_MASTER
        else if FieldByName('PackModel').AsBoolean then
          Result := MODEL_TYPE_PACKAGE
        else if FieldByName('Service').AsBoolean then
          Result := MODEL_TYPE_SERVICE
        else if FieldByName('Credit').AsBoolean then
          Result := MODEL_TYPE_CREDIT
        else if FieldByName('GiftCard').AsBoolean then
          Result := MODEL_TYPE_GIFTCARD;
      end;
    finally
      Close;
    end;
end;

procedure TDMInventory.ModelPriceLog(AIDModel, AIDUser, AIDStore: Integer;
  AOldCost, ANewCost, AOldSale, ANewSale: Currency);
begin

  with cmdInsertModelPriceLog do
  try
    Parameters.ParamByName('IDModelPriceLog').Value := DM.GetNextID('ModelPriceLog.IDModelPriceLog');
    Parameters.ParamByName('IDModel').Value         := AIDModel;
    Parameters.ParamByName('IDUser').Value          := AIDUser;
    if AIDStore = 0 then
      Parameters.ParamByName('IDStore').Value       := NULL
    else
      Parameters.ParamByName('IDStore').Value       := AIDStore;
    Parameters.ParamByName('ChangeDate').Value      := Now;
    Parameters.ParamByName('OldCostPrice').Value    := AOldCost;
    Parameters.ParamByName('NewCostPrice').Value    := ANewCost;
    Parameters.ParamByName('OldSalePrice').Value    := AOldSale;
    Parameters.ParamByName('NewSalePrice').Value    := ANewSale;
    Execute;
  except
    on E: Exception do
      FLogError.Add('' + E.Message);
  end;

end;

function TDMInventory.LotAdjust(AIDModel, AIDStore, AIDLot: Integer;
  AQty: Double; AType: Integer): Boolean;
var
  iError : Integer;
begin

  try
    with spLotAdjust do
    begin
        Parameters.ParambyName('@IDModel').Value      := AIDModel;
        Parameters.ParamByName('@IDStore').Value      := AIDStore;
        Parameters.ParamByName('@IDLot').Value        := AIDLot;
        Parameters.ParamByName('@Qty').Value          := AQty;
        Parameters.ParamByName('@Type').Value         := AType;
        ExecProc;
        iError := Parameters.ParamByName('@RETURN_VALUE').Value;
    end;

    if iError = 0 then
      Result := True
    else
      Result := False;
  except
    Result := False;
  end;
end;

end.
