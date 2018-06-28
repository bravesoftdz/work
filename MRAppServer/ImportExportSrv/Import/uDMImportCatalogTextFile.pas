unit uDMImportCatalogTextFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMImportTextFile, FMTBcd, DB, ADODB;

type
  TDMImportCatalogTextFile = class(TDMImportTextFile)
    qryCreateVendorTable: TADOQuery;
    qryCreateDatabase: TADOQuery;
    qryCreateModelCatalogTable: TADOQuery;
    qryInsertModelCatalog: TADOQuery;
  private
    procedure CreateDataBase;
    procedure CreateTables;
    function GetIDVendor(Vendor :String): Integer;
    function GetNewIDVendor(Vendor :String): Integer;
    function GetModelLastCode: Integer;
    procedure InsertModelCatalog(Cod, IDVendor: Integer);
    procedure SetQueryConnections;
  public
    function Import: Boolean; override;
    procedure CreateCatalogDB;
  end;

implementation

uses uNumericFunctions, uDMGlobal;

{$R *.dfm}

{ TDMImportCatalogTextFile }

procedure TDMImportCatalogTextFile.CreateCatalogDB;
begin
  CreateDataBase;
  CreateTables;
end;

procedure TDMImportCatalogTextFile.CreateDataBase;
begin
  try
    qryCreateDatabase.Connection := SQLConnection;
    qryCreateDatabase.ExecSQL;
  except
    on E: Exception do
      Log.Add(Format('Error: %s', [E.Message]));
  end;
end;

procedure TDMImportCatalogTextFile.CreateTables;
begin
  try
    qryCreateVendorTable.Connection := SQLConnection;
    qryCreateVendorTable.ExecSQL;
  except
    on E: Exception do
      Log.Add(Format('Error: %s', [E.Message]));
  end;

  try
    qryCreateModelCatalogTable.Connection := SQLConnection;
    qryCreateModelCatalogTable.ExecSQL;
  except
    on E: Exception do
      Log.Add(Format('Error: %s', [E.Message]));
  end;
end;

function TDMImportCatalogTextFile.GetIDVendor(Vendor: String): Integer;
begin
  with DMGlobal.qryFreeSQL do
  begin
    if Active then
      Close;

    SQL.Text := 'SELECT IDVendor from MRCatalogDB..Vendor WHERE Vendor = ' + QuotedStr(Vendor);
    Open;

    if IsEmpty then
      Result := GetNewIDVendor(Vendor)
    else
      Result := FieldByName('IDVendor').AsInteger;
   end;
end;

function TDMImportCatalogTextFile.GetModelLastCode: Integer;
begin
  Result := -1; 

  with DMGlobal.qryFreeSQL do
   begin
     if Active then
       Close;

     SQL.Text := 'SELECT Max(IDModelCatalog) Max_IDModelCatalog from MRCatalogDB..Model_Catalog';

     try
       Open;
       Result := Fields.FieldByName('Max_IDModelCatalog').AsInteger;
       Close;
     except
      on E: Exception do
        Log.Add(Format('Error: %s', [E.Message]));
     end;
   end;
end;

function TDMImportCatalogTextFile.GetNewIDVendor(Vendor: String): Integer;
begin
  Result := -1;

  try
    DMGlobal.RunSQL('INSERT INTO MRCatalogDB..Vendor (Vendor) VALUES (' + QuotedStr(Vendor) + ')',SQLConnection);

    with DMGlobal.qryFreeSQL do
    begin
      if Active then
        Close;

      SQL.Text := 'SELECT Max(IDVendor) Max_IDVendor from MRCatalogDB..Vendor';

      Open;

      try
        Result:= FieldByName('Max_IDVendor').AsInteger;
      finally
        Close;
      end;
    end;
  except
    on E: Exception do
      Log.Add(Format('Error: %s', [E.Message]));
  end;

end;

function TDMImportCatalogTextFile.Import: Boolean;
var
  Cod: Integer;
  IDVendor: Integer;
begin
  Result := True;

  SetQueryConnections;
  IDVendor := GetIDVendor(ImpExpConfig.Values['Vendor']);

  DMGlobal.RunSQL('DELETE FROM MRCatalogDB..Model_Catalog WHERE IDVendor = ' + InttoStr(IDVendor),SQLConnection);

  Cod := GetModelLastCode + 1;

  try
    with TextFile do
      while not Eof do
      begin
        InsertModelCatalog(Cod,IDVendor);
        inc(Cod);
        Next;
      end;
  except
    on E: Exception do
    begin
      Log.Add(Format('Error: %s', [E.Message]));
      Result := False;
    end;
  end;
end;

procedure TDMImportCatalogTextFile.InsertModelCatalog(Cod, IDVendor: Integer);
begin
  with qryInsertModelCatalog do
  begin
    if Active then
      Close;
    Parameters.ParamByName('IDModelCatalog').Value := InttoStr(Cod);
    Parameters.ParamByName('IDVendor').Value := InttoStr(IDVendor);

    if not(LinkedColumns.Values['IDBarcode'] = '') then
      Parameters.ParamByName('IDBarcode').Value := TextFile.FieldByName(LinkedColumns.Values['IDBarcode']).AsString
    else
      Parameters.ParamByName('IDBarcode').Value := '';

    if not(LinkedColumns.Values['Model'] = '') then
      Parameters.ParamByName('Model').Value := TextFile.FieldByName(LinkedColumns.Values['Model']).AsString
    else
      Parameters.ParamByName('Model').Value := '';

    if not(LinkedColumns.Values['InvSize'] = '') then
      Parameters.ParamByName('InvSize').Value := TextFile.FieldByName(LinkedColumns.Values['InvSize']).AsString
    else
      Parameters.ParamByName('InvSize').Value := '';

    if not(LinkedColumns.Values['InvColor'] = '') then
      Parameters.ParamByName('InvColor').Value := TextFile.FieldByName(LinkedColumns.Values['InvColor']).AsString
    else
      Parameters.ParamByName('InvColor').Value := '';

    if not(LinkedColumns.Values['Description'] = '') then
      Parameters.ParamByName('Description').Value := TextFile.FieldByName(LinkedColumns.Values['Description']).AsString
    else
      Parameters.ParamByName('Description').Value := '';

    if not(LinkedColumns.Values['Manufacture'] = '') then
      Parameters.ParamByName('Manufacture').Value := TextFile.FieldByName(LinkedColumns.Values['Manufacture']).AsString
    else
      Parameters.ParamByName('Manufacture').Value := '';

    if not(LinkedColumns.Values['TabGroup'] = '') then
      Parameters.ParamByName('TabGroup').Value := TextFile.FieldByName(LinkedColumns.Values['TabGroup']).AsString
    else
      Parameters.ParamByName('TabGroup').Value := '';

    if not(LinkedColumns.Values['CustoPrice'] = '') then
      Parameters.ParamByName('CustoPrice').Value := MyStrToMoney(TextFile.FieldByName(LinkedColumns.Values['CustoPrice']).AsString)
    else
      Parameters.ParamByName('CustoPrice').Value := 0;

    if not(LinkedColumns.Values['SalePrice'] = '') then
      Parameters.ParamByName('SalePrice').Value := MyStrToMoney(TextFile.FieldByName(LinkedColumns.Values['SalePrice']).AsString)
    else
      Parameters.ParamByName('SalePrice').Value := 0;

    if not(LinkedColumns.Values['VendorCode'] = '') then
      Parameters.ParamByName('VendorCode').Value := TextFile.FieldByName(LinkedColumns.Values['VendorCode']).AsString
    else
      Parameters.ParamByName('VendorCode').Value := '';

    if not(LinkedColumns.Values['Qty'] = '') then
      Parameters.ParamByName('Qty').Value := MyStrToFloat(TextFile.FieldByName(LinkedColumns.Values['Qty']).AsString)
    else
      Parameters.ParamByName('Qty').Value := 0;

    if not(LinkedColumns.Values['QtyMin'] = '') then
      Parameters.ParamByName('QtyMin').Value := MyStrToFloat(TextFile.FieldByName(LinkedColumns.Values['QtyMin']).AsString)
    else
      Parameters.ParamByName('QtyMin').Value := 0;

    if not(LinkedColumns.Values['QtyMax'] = '') then
      Parameters.ParamByName('QtyMax').Value := MyStrToFloat(TextFile.FieldByName(LinkedColumns.Values['QtyMax']).AsString )
    else
      Parameters.ParamByName('QtyMax').Value := 0;

    try
      ExecSQL;
    finally
      Close;
    end;
  end;
end;

procedure TDMImportCatalogTextFile.SetQueryConnections;
begin
  qryInsertModelCatalog.Connection := SQLConnection;
  DMGlobal.qryFreeSQL.Connection := SQLConnection;
end;

end.
