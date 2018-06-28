unit uDMExportPO;

interface

uses
  SysUtils, Classes, DBClient, DB, ADODB, Provider, uDMExportTextFile;

type
  TDMExportPO = class(TDMExportTextFile)
    quGetPOData: TADOQuery;
    cdsGetPOData: TClientDataSet;
    dspGetPOData: TDataSetProvider;
    quGetPODataIDPO: TIntegerField;
    quGetPODataPODate: TDateTimeField;
    quGetPODataFreight: TBCDField;
    quGetPODataCharges: TBCDField;
    quGetPODataSubTotal: TBCDField;
    quGetPODataEstArrival: TDateTimeField;
    quGetPODataPayDays: TIntegerField;
    quGetPODataOBS: TStringField;
    quGetPODataCostPrice: TBCDField;
    quGetPODataSalePrice: TBCDField;
    quGetPODataDateEstimatedMov: TDateTimeField;
    quGetPODataDateRealMov: TDateTimeField;
    quGetPODataQty: TFloatField;
    quGetPODataCaseQty: TFloatField;
    quGetPODataCaseCost: TBCDField;
    quGetPODataModel: TStringField;
    quGetPODataDescription: TStringField;
    quGetPODataVendorCode: TStringField;
    quGetPODataBarcode: TStringField;
    quGetPODataUserCode: TStringField;
    quGetPODataStoreName: TStringField;
    quGetPODataVendorAccount: TStringField;
    quGetPODataQtyOrdered: TFloatField;
    quGetPODataIDModel: TIntegerField;
    ADOConnection: TADOConnection;
    quGetPODataVendor: TStringField;
    quGetPODataAddress: TStringField;
    quGetPODataCity: TStringField;
    quGetPODataZIP: TStringField;
    quGetPODataIDVendor: TIntegerField;
  private
    FIDPO: Integer;
    function SetVendorModelCode(IDModel, IDFornecedor: Integer): String;
  public
    property IDPO: Integer read FIDPO write FIDPO;

    procedure ExportFile; override;
  end;

implementation

{$R *.dfm}

{ TDMExportPO }

procedure TDMExportPO.ExportFile;
begin
  inherited;
  cdsGetPOData.Close;
  try
    try
      quGetPOData.Connection := SQLConnection;
      cdsGetPOData.Params.ParamByName('IDPO').Value := FIDPO;
      cdsGetPOData.Open;

      cdsGetPOData.First;
      while not cdsGetPOData.Eof do
      begin
        cdsGetPOData.Edit;
        cdsGetPOData.FieldByName('VendorCode').AsString := SetVendorModelCode(cdsGetPOData.FieldByName('IDModel').AsInteger ,
                                                                              cdsGetPOData.FieldByName('IDVendor').AsInteger );
        cdsGetPOData.Post;
        cdsGetPOData.Next;
      end;
      TextFile.Data := cdsGetPOData.Data;
    except
      on E: Exception do
        Log.Add(E.Message);
    end;
  finally
    cdsGetPOData.Close;
  end;
end;

function TDMExportPO.SetVendorModelCode(IDModel, IDFornecedor: Integer): String;
var
  qryVendorModelCode: TADOQuery;
begin
  qryVendorModelCode := TADOQuery.Create(self);
  Try
    qryVendorModelCode.Connection := SQLConnection;
    qryVendorModelCode.SQL.Text := ' SELECT TOP 1 VendorCode ' +
                                   ' FROM VendorModelCode ' +
                                   ' WHERE IDModel = ' + InttoStr(IDModel) + ' and IDPessoa = ' + InttoStr(IDFornecedor);
    qryVendorModelCode.Open;

    Result := qryVendorModelCode.FieldByName('VendorCode').AsString;
  finally
    FreeAndNil(qryVendorModelCode);
  end;
end;

end.
