unit uPaymentCheck;

interface

uses
  uPayment, ADODB;

type
  TPaymentCheck = class(TPayment)
  private
    FAuthorization: String;
    FCheckNumber: String;
    FCustomerDocument: String;
    FCustomerName: String;
    FCustomerPhone: String;
    FIDBankCheck: Integer;
    FHistorico: String;
    FPaymentPlace: Integer;
    FIsPreDatado: Boolean;
    FNumDesdobramento: String;

  protected
    procedure FillParameters(FCmdPayment: TADOCommand); override;
    procedure SetProperties(ADSPayment: TADODataSet); override;
    function GetSQLFields: String; override;
    function GetPaymentType: Integer; override;

  public
    property Authorization: String read FAuthorization write FAuthorization;
    property CheckNumber: String read FCheckNumber write FCheckNumber;
    property CustomerNumber: String read FCustomerDocument write FCustomerDocument;
    property CustomerName: String read FCustomerName write FCustomerName;
    property CustomerPhone: String read FCustomerPhone write FCustomerPhone;
    property IDBankCheck: Integer read FIDBankCheck write FIDBankCheck;
    property OBS: String read FHistorico write FHistorico;
    property PaymentPlace: Integer read FPaymentPlace write FPaymentPlace;
    property IsPostDate: Boolean read FIsPreDatado write FIsPreDatado;
    property PartNumber: String read FNumDesdobramento write FNumDesdobramento;

  end;

implementation

uses uSystemConst, DB;

{ TPaymentCheck }

procedure TPaymentCheck.FillParameters(FCmdPayment: TADOCommand);
begin
  inherited;
  FCmdPayment.Parameters.ParamByName('NumMeioQuitPrevisto').Value := FAuthorization;
  FCmdPayment.Parameters.ParamByName('CheckNumber').Value := FCheckNumber;
  FCmdPayment.Parameters.ParamByName('CustomerDocument').Value := FCustomerDocument;
  FCmdPayment.Parameters.ParamByName('CustomerName').Value := FCustomerName;
  FCmdPayment.Parameters.ParamByName('CustomerPhone').Value := FCustomerPhone;
  FCmdPayment.Parameters.ParamByName('IDBankCheck').Value := FIDBankCheck;
  FCmdPayment.Parameters.ParamByName('Historico').Value := FHistorico;
  FCmdPayment.Parameters.ParamByName('PaymentPlace').Value := FPaymentPlace;
  FCmdPayment.Parameters.ParamByName('IsPreDatado').Value := FIsPreDatado;
  FCmdPayment.Parameters.ParamByName('NumDesdobramento').Value := FNumDesdobramento;
end;

function TPaymentCheck.GetPaymentType: Integer;
begin
  Result := PAYMENT_TYPE_CHECK;
end;

function TPaymentCheck.GetSQLFields: String;
begin
  Result := (inherited GetSQLFields) + ',NumMeioQuitPrevisto,' +
                                       'CheckNumber,' +
                                       'CustomerDocument,' +
                                       'CustomerName,' +
                                       'CustomerPhone,' +
                                       'IDBankCheck,' +
                                       'Historico,' +
                                       'PaymentPlace,' +
                                       'IsPreDatado,' +
                                       'NumDesdobramento';
end;

procedure TPaymentCheck.SetProperties(ADSPayment: TADODataSet);
begin
  inherited;
  FAuthorization     := ADSPayment.FieldByName('NumMeioQuitPrevisto').AsString;
  FCheckNumber       := ADSPayment.FieldByName('CheckNumber').AsString;
  FCustomerDocument  := ADSPayment.FieldByName('CustomerDocument').AsString;
  FCustomerName      := ADSPayment.FieldByName('CustomerName').AsString;
  FCustomerPhone     := ADSPayment.FieldByName('CustomerPhone').AsString;
  FIDBankCheck       := ADSPayment.FieldByName('IDBankCheck').AsInteger;
  FHistorico         := ADSPayment.FieldByName('Historico').AsString;
  FPaymentPlace      := ADSPayment.FieldByName('PaymentPlace').AsInteger;
  FIsPreDatado       := ADSPayment.FieldByName('IsPreDatado').AsBoolean;
  FNumDesdobramento  := ADSPayment.FieldByName('NumDesdobramento').AsString;
end;

end.
