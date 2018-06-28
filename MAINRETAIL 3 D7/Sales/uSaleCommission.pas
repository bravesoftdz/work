unit uSaleCommission;

interface

uses SysUtils, Classes;

type
  TSaleCommission = class
  private
    FIDSale: Integer;
    FSaleType: Integer;
    FCommissionList: TStringList;
    procedure InsertCommission;
    procedure DeleteCommission;
    procedure AddCommission(AID: Integer; AName: String; APercent: Double);
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadCommissionList;

    property IDSale: Integer read FIDSale write FIDSale;
    property SaleType: Integer read FSaleType write FSaleType;
    property CommissionList: TStringList read FCommissionList write FCommissionList;
  end;

implementation

uses ADODB, uFrmPOSFunctions, uSystemConst, uDM;

{ TSaleCommission }

procedure TSaleCommission.AddCommission(AID: Integer; AName: String; APercent: Double);
var
  SalesPerson: TSalesPerson;
begin
  SalesPerson          := TSalesPerson.Create;
  SalesPerson.IDPessoa := AID;
  SalesPerson.Pessoa   := AName;
  SalesPerson.Percent  := APercent;

  FCommissionList.AddObject(SalesPerson.Pessoa + ' - ' +
    FloattoStr(SalesPerson.Percent) + '%', SalesPerson);
end;

constructor TSaleCommission.Create;
begin
  FCommissionList := TStringList.Create;
end;

procedure TSaleCommission.DeleteCommission;
begin

end;

destructor TSaleCommission.Destroy;
begin
  FreeAndNil(FCommissionList);
  inherited;
end;

procedure TSaleCommission.InsertCommission;
begin

end;

procedure TSaleCommission.LoadCommissionList;
const
  SQLCommisionList = 'select Pessoa, IDPessoa, CommissionPercent ' +
                     'from SaleItemCommission SIC ' +
                     'join Pessoa P on (SIC.IDCoMmission = P.IDPessoa) ' +
                     'where ';
begin
  FCommissionList.Clear;

  with TADOQuery.Create(nil) do
  try
    Connection := DM.ADODBConnect;

    case FSaleType of
      SALE_INVOICE:
        SQL.Text := SQLCommisionList + 'IDInventoryMov = ' + InttoStr(FIDSale)
      else
        SQL.Text := SQLCommisionList + 'IDPreInventoryMov = ' + InttoStr(FIDSale);
    end;

    First;
    while not EOF do
    begin
      AddCommission(FieldByName('IDPessoa').AsInteger,
        FieldByName('Pessoa').AsString, FieldByName('CommissionPercent').AsFloat);
      Next;
    end;
  finally
    Free;
  end;
end;

end.
