unit mrBarCodeEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, ADODB, Types, Messages;

type
  TmrBarCodeEdit = class(TEdit)
  private
    FRunSecondSQL : Boolean;
    FConnection: TADOConnection;
    FDataSet: TADOQuery;
    FSQL: TStringList;
    FSecondSQL: TStringList;
    FKeyField: String;
    FSecondKeyField: String;
    FQtyEdit: TEdit;
    FDisplayQty: Boolean;
    FCheckBarcodeDigit : Integer;

    FAfterSearchBarcode: TNotifyEvent;
    FBeforeSearchBarcode: TNotifyEvent;

    FBeforeSearchSecondBarcode: TNotifyEvent;
    FMinimalDigits: Integer;

    procedure SetupQtyEdit;
    procedure SetQtyEditPosition;
    procedure SetSQL(const Value: TStringList);
    procedure SetSecondSQL(const Value: TStringList);
    procedure FirstSearch;
    procedure SecondSearch;
    function GetMaxBarcodeOrder(AIDModel: Integer): Integer;
  protected
    procedure SetParent(AParent: TWinControl); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CMVisiblechanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMEnabledchanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMBidimodechanged(var Message: TMessage); message CM_BIDIMODECHANGED;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure SearchBarcode;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetParameterValue(AParameterName: String; AValue: Variant);
    procedure DoKeyPress(Key: Char);
    function GetFieldValue(AFieldName: String): Variant;
    function SearchResult: Boolean;

    property QtyEdit: TEdit read FQtyEdit write FQtyEdit;
  published
    property Connection: TADOConnection read FConnection write FConnection;
    property SQL: TStringList read FSQL write SetSQL;
    property SecondSQL : TStringList read FSecondSQL write SetSecondSQL;
    property KeyField: String read FKeyField write FKeyField;
    property SecondKeyField: String read FSecondKeyField write FSecondKeyField;
    property DisplayQty: Boolean read FDisplayQty write FDisplayQty;
    property RunSecondSQL : Boolean read FRunSecondSQL write FRunSecondSQL;
    property CheckBarcodeDigit : Integer read FCheckBarcodeDigit write FCheckBarcodeDigit;

    property MinimalDigits: Integer read FMinimalDigits write FMinimalDigits;

    property AfterSearchBarcode: TNotifyEvent read FAfterSearchBarcode write FAfterSearchBarcode;
    property BeforeSearchBarcode: TNotifyEvent read FBeforeSearchBarcode write FBeforeSearchBarcode;

    property BeforeSearchSecondBarcode: TNotifyEvent read FBeforeSearchSecondBarcode write FBeforeSearchSecondBarcode;

  end;

procedure Register;

implementation

uses DB;

procedure Register;
begin
  RegisterComponents('MainRetail', [TmrBarCodeEdit]);
end;

{ TmrBarCodeEdit }

constructor TmrBarCodeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSQL := TStringList.Create;
  FSecondSQL := TStringList.Create; 
  FDataSet := TADOQuery.Create(Self);
  FDataSet.CommandTimeout := 1800;

  SetupQtyEdit;
end;

destructor TmrBarCodeEdit.Destroy;
begin
  FreeAndNil(FDataSet);
  FreeAndNil(FSQL);
  FreeAndNil(FSecondSQL);
  inherited;
end;

procedure TmrBarCodeEdit.SearchBarcode;
begin

  if Trim(Text) <> '' then
  begin
    if Pos('*', Text) <> 0 then
      begin
      QtyEdit.Text  := Copy(Text, 0, Pos('*', Text)-1);
      Text          := Copy(Text, Pos('*', Text)+1, Length(Text));
      end;

    FirstSearch;

    if FRunSecondSQL and (FDataSet.IsEmpty) then
      SecondSearch;

    if Assigned(FAfterSearchBarcode) then
       AfterSearchBarCode(Self);

    QtyEdit.Text := '1';
  end;

end;

procedure TmrBarCodeEdit.SetupQtyEdit;
begin
  if not Assigned(FQtyEdit) then
  begin
    FQtyEdit := TEdit.Create(Self);
    FQtyEdit.Name := 'SubQtyEdit';
    FQtyEdit.Text := '1';
    FQtyEdit.SetSubComponent(True);
    FQtyEdit.FreeNotification(Self);
  end;
end;

procedure TmrBarCodeEdit.SetQtyEditPosition;
begin
  if Assigned(FQtyEdit) then
    FQtyEdit.SetBounds(Left - 50, Top, 50, Height);
end;

procedure TmrBarCodeEdit.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetQtyEditPosition;
end;

procedure TmrBarCodeEdit.CMBidimodechanged(var Message: TMessage);
begin
  inherited;
  FQtyEdit.BiDiMode := BiDiMode;
end;

procedure TmrBarCodeEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FQtyEdit) and (Operation = opRemove) then
    FQtyEdit := nil;
end;

procedure TmrBarCodeEdit.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FQtyEdit) then
  begin
    FQtyEdit.Parent := AParent;
    FQtyEdit.Visible := FDisplayQty;
  end;
end;

procedure TmrBarCodeEdit.CMEnabledchanged(var Message: TMessage);
begin
  inherited;
  FQtyEdit.Enabled := Enabled;
end;

procedure TmrBarCodeEdit.CMVisiblechanged(var Message: TMessage);
begin
  inherited;
  FQtyEdit.Visible := FDisplayQty;
end;

procedure TmrBarCodeEdit.KeyPress(var Key: Char);
begin
  if Key = #32 then //Nao permitir espaco
    Key := #0
  else if Key = #13 then
  begin
    SearchBarcode;
    Key := #0;
  end;
end;

procedure TmrBarCodeEdit.SetParameterValue(AParameterName: String; AValue: Variant);
begin
  FDataSet.Parameters.ParamByName(AParameterName).Value := AValue;
end;

function TmrBarCodeEdit.GetFieldValue(AFieldName: String): Variant;
begin
  Result := FDataSet.FieldByName(AFieldName).Value;
end;

procedure TmrBarCodeEdit.SetSQL(const Value: TStringList);
begin
  FSQL.Assign(Value);
end;

function TmrBarCodeEdit.SearchResult: Boolean;
begin
  Result := FDataSet.RecordCount > 0;
end;

procedure TmrBarCodeEdit.SetSecondSQL(const Value: TStringList);
begin
  FSecondSQL.Assign(Value);
end;

procedure TmrBarCodeEdit.FirstSearch;
var
  iRows, iMaxBarcodeOrder: Integer;
  sBarcode: String;
begin

  with FDataSet do
  begin
    if Active then
      Close;
    Connection := FConnection;
    SQL.Text := FSQL.Text;
    Parameters.ParamByName(FKeyField).Value := Text;

    if Assigned(FBeforeSearchBarcode) then
      BeforeSearchBarCode(Self);

    Open;

    if (IsEmpty) and (FCheckBarcodeDigit <> 0) and (Length(Text)>= FMinimalDigits) then
    begin
    if Active then
      Close;
    Connection := FConnection;
    SQL.Text := FSQL.Text;
    Case FCheckBarcodeDigit of
      1 : sBarcode := Copy(Text, 2, Length(Text));
      2 : sBarcode := Copy(Text, 1, Length(Text)-1);
      3 : sBarcode := Copy(Text, 2, Length(Text)-2)
      else sBarcode := Copy(Text, 2, Length(Text)-2);
    end;
    Parameters.ParamByName(FKeyField).Value := sBarcode;
    Open;
    if (not IsEmpty) then
    begin
      iMaxBarcodeOrder := GetMaxBarcodeOrder(FieldByName('IDModel').AsInteger);

      FConnection.Execute(
      ' IF NOT EXISTS (SELECT IDBarcode FROM Barcode WHERE IDBarcode = '+QuotedStr(Text)+')' +
      ' BEGIN ' +
      ' INSERT Barcode (IDBarcode, IDModel, Data, BarcodeOrder) ' +
      ' SELECT ' + QuotedStr(Text)+ ', M.IDModel, GetDate(), ' + IntToStr(iMaxBarcodeOrder+1) +
      ' FROM Barcode B ' +
      ' JOIN Model M ON (M.IDModel = B.IDModel) ' +
      ' WHERE IDBarcode = ' + QuotedStr(sBarcode) +
      ' END ');
    end;
    end;

  end;

end;

procedure TmrBarCodeEdit.SecondSearch;
begin
  with FDataSet do
  begin
    if Active then
      Close;

    SQL.Text := FSecondSQL.Text;
    Parameters.ParamByName(FSecondKeyField).Value := Text;

    if Assigned(FBeforeSearchSecondBarcode) then
      FBeforeSearchSecondBarcode(Self);

    Open;
  end;
end;

procedure TmrBarCodeEdit.DoKeyPress(Key: Char);
var
  cKey: Char;
begin
  cKey := Key;
  Self.KeyPress(cKey);
end;

function TmrBarCodeEdit.GetMaxBarcodeOrder(AIDModel: Integer): Integer;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := FConnection;
    SQL.Text := 'SELECT IsNull(MAX(BarcodeOrder), 0) MaxOrder FROM Barcode WHERE IDModel = ' + IntToStr(AIDModel);
    Open;
    Result := FieldByName('MaxOrder').AsInteger;
  finally
    Free;
  end;
end;

end.
