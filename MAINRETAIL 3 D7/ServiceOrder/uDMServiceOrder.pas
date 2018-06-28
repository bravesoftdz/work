unit uDMServiceOrder;

interface

uses
  SysUtils, Classes, DB, ADODB, PowerADOQuery, LookUpADOQuery, uSystemTypes;

const
  SO_STATUS_OPEN  = 1;
  SO_STATUS_CLOSE = 2;

type
  TDMServiceOrder = class(TDataModule)
    LookUpSOStatus: TLookUpADOQuery;
    dsLookUpSOStatus: TDataSource;
    LookUpSOStatusIDSOStatus: TIntegerField;
    LookUpSOStatusSOStatus: TStringField;
    LookUpSOStatusColor: TStringField;
    dsSOCutomerProduct: TDataSource;
    LookUpSOCutomerProduct: TLookUpADOQuery;
    LookUpSOCutomerProductIDSOCustomerProduct: TIntegerField;
    LookUpSOCutomerProductModel: TStringField;
    LookUpSOCutomerProductDescription: TStringField;
    spApplyPayDiscount: TADOStoredProc;
    function LookUpSOStatusClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
    function LookUpSOCutomerProductClickButton(Sender: TPowerADOQuery;
      ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
  private
    { Private declarations }
  public
    function DeleteSO(AIDSO : Integer) : Boolean;
    function DeleteSOItem(AIDSOItem : Integer) : Boolean;
    function ApplyPaymentDiscount(AIDSO : Integer; APercent : Double) : Boolean;
  end;

var
  DMServiceOrder: TDMServiceOrder;

implementation

uses uDM, uFchSOStatus,uFchSOCustomerProduct;

{$R *.dfm}

function TDMServiceOrder.DeleteSOItem(AIDSOItem : Integer): Boolean;
begin
  try
    DM.ADODBConnect.BeginTrans;
    DM.RunSQL('DELETE InventoryMov WHERE DocumentID IN (SELECT IDSOItemProduct FROM Ser_SOItemProduct WHERE IDSOItem = '+ InttoStr(AIDSOItem)+')  AND InventMovTypeID = 50');
    DM.RunSQL('DELETE Ser_SOItemProduct WHERE IDSOItem = ' + InttoStr(AIDSOItem));
    DM.RunSQL('DELETE Ser_SOItemDefect WHERE IDSOItem = ' + InttoStr(AIDSOItem));
    DM.RunSQL('DELETE Ser_SOItem WHERE IDSOItem = ' + InttoStr(AIDSOItem));
    DM.ADODBConnect.CommitTrans;
    Result := True;
  except
    DM.ADODBConnect.RollbackTrans;
    raise;
    Result := False;
  end;
end;

function TDMServiceOrder.DeleteSO(AIDSO: Integer): Boolean;
var
  sSQL : String;
begin
  try
    DM.ADODBConnect.BeginTrans;

    sSQL := 'DELETE InventoryMov ' +
            'WHERE InventMovTypeID = 50 AND DocumentID IN (SELECT SOI.IDSOItemProduct FROM Ser_SOItemProduct SOI ' +
            'JOIN Ser_SOItem SO ON (SOI.IDSOItem = SO.IDSOItem) ' +
            'WHERE SO.IDServiceOrder = ' + IntToStr(AIDSO) + ' ) ';
    DM.RunSQL(sSQL);


    sSQL := 'DELETE SOI FROM Ser_SOItemProduct SOI ' +
            'JOIN Ser_SOItem SO ON ((SOI.IDSOItem = SO.IDSOItem)) ' +
            'WHERE SO.IDServiceOrder = ' + IntToStr(AIDSO);
    DM.RunSQL(sSQL);

    sSQL := 'DELETE SOD FROM Ser_SOItemDefect SOD ' +
            'JOIN Ser_SOItem SO ON (SOD.IDSOItem = SO.IDSOItem) ' +
            'WHERE SO.IDServiceOrder = ' + IntToStr(AIDSO);
    DM.RunSQL(sSQL);

    sSQL := 'DELETE Ser_SOItem WHERE IDServiceOrder = ' + IntToStr(AIDSO);
    DM.RunSQL(sSQL);

    sSQL := 'DELETE History WHERE IDServiceOrder = ' + IntToStr(AIDSO);
    DM.RunSQL(sSQL);

    sSQL := 'DELETE Ser_ServiceOrder WHERE IDServiceOrder = ' + IntToStr(AIDSO);
    DM.RunSQL(sSQL);

    DM.ADODBConnect.CommitTrans;
    Result := True;
  except
    DM.ADODBConnect.RollbackTrans;
    raise;
    Result := False;
  end;
end;


function TDMServiceOrder.LookUpSOStatusClickButton(Sender: TPowerADOQuery;
  ClickedButton: TBtnCommandType; var PosID1, PosID2: String): Boolean;
begin

  if (DM.IsFormsRestric('FchSOStatus') and (ClickedButton = btInc))then
     Exit;

  with TFchSOStatus.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;


end;

function TDMServiceOrder.LookUpSOCutomerProductClickButton(
  Sender: TPowerADOQuery; ClickedButton: TBtnCommandType; var PosID1,
  PosID2: String): Boolean;
begin

  if (DM.IsFormsRestric('FchSOCustomerProduct') and (ClickedButton = btInc))then
     Exit;

  with TFchSOCustomerProduct.Create(Self) do
    begin
      Result := Start(ClickedButton, Sender, False, PosID1, PosID2, nil);
      Free;
    end;

end;


function TDMServiceOrder.ApplyPaymentDiscount(AIDSO: Integer;
  APercent: Double): Boolean;
begin

  with spApplyPayDiscount do
  try
    Parameters.ParambyName('@IDServiceOrder').Value := AIDSO;
    Parameters.ParambyName('@PercDiscount').Value   := APercent;
    ExecProc;
    Result := True;
  except
    Result := False;
  end;

end;

end.
