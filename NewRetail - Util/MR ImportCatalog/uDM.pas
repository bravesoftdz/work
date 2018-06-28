unit uDM;

interface

uses
  SysUtils, Classes, ADODB, DB, PowerADOQuery, LookUpADOQuery, DBClient,
  MConnect;

type
  TDM = class(TDataModule)
    DBConnection: TADOConnection;
    quCkeckModel: TADODataSet;
    quCkeckModelModel: TStringField;
    quLookUpTax: TLookUpADOQuery;
    quLookUpTaxIDTaxCategory: TAutoIncField;
    quLookUpTaxTaxCategory: TStringField;
    dsLookUpStore: TDataSource;
    dsLookUpTax: TDataSource;
    quSize: TADODataSet;
    quSizeInvSize: TStringField;
    quColor: TADODataSet;
    quColorInvColor: TStringField;
    quFabricante: TADODataSet;
    quFabricanteManufacture: TStringField;
    quSubGroup: TADODataSet;
    quSubGroupSubGroup: TStringField;
    quTabGroup: TADODataSet;
    quTabGroupTabGroup: TStringField;
    quModel: TADODataSet;
    quModelModel: TStringField;
    quModelDescription: TStringField;
    quModelCustoPrice: TBCDField;
    quModelSalePrice: TBCDField;
    quModelIDSize: TIntegerField;
    quModelIDColor: TIntegerField;
    quModelIDManufect: TIntegerField;
    quModelIDTabGroup: TIntegerField;
    quModelIDBarcode: TStringField;
    quModelIDSubGroup: TIntegerField;
    quVendorCode: TADODataSet;
    quVendorCodeIDModel: TIntegerField;
    quVendorCodeIDManufect: TIntegerField;
    quVendorCodeVendorCode: TStringField;
    quInventory: TADODataSet;
    quInventoryQty: TIntegerField;
    quInventoryIDModel: TIntegerField;
    quInventoryVendorCost: TBCDField;
    quInventorySellingPrice: TBCDField;
    spGetNextID: TADOStoredProc;
    quLookUpStore: TLookUpADOQuery;
    quLookUpStoreIDStore: TIntegerField;
    quLookUpStoreName: TStringField;
    quVendorList: TADODataSet;
    quVendorListIDVendor: TIntegerField;
    quVendorListVendor: TStringField;
    quVendorFiltered: TADODataSet;
    quVendorFilteredIDVendor: TIntegerField;
    quVendorFilteredVendor: TStringField;
    quModelCatalogList: TADODataSet;
    DsModelCatalogList: TDataSource;
    quModelCatalogListIDModelCatalog: TIntegerField;
    quModelCatalogListIDModel: TIntegerField;
    quModelCatalogListIDVendor: TIntegerField;
    quModelCatalogListIDSize: TIntegerField;
    quModelCatalogListIDColor: TIntegerField;
    quModelCatalogListIDManufect: TIntegerField;
    quModelCatalogListIDTabGroup: TIntegerField;
    quModelCatalogListIDSubGroup: TIntegerField;
    quModelCatalogListIDBarcode: TStringField;
    quModelCatalogListModel: TStringField;
    quModelCatalogListInvSize: TStringField;
    quModelCatalogListInvColor: TStringField;
    quModelCatalogListDescription: TStringField;
    quModelCatalogListManufacture: TStringField;
    quModelCatalogListTabGroup: TStringField;
    quModelCatalogListCustoPrice: TBCDField;
    quModelCatalogListSalePrice: TBCDField;
    quModelCatalogListVendorCode: TStringField;
    quModelCatalogListQty: TIntegerField;
    quModelCatalogListSubGroup: TStringField;
    quModelCatalogListQtyMin: TIntegerField;
    quModelCatalogListQtyMax: TIntegerField;
    quSelectModelCatalog: TADODataSet;
    quSelectModelCatalogIDModelCatalog: TIntegerField;
    quModelFiltered: TADODataSet;
    quModelFilteredIDModel: TIntegerField;
    quModelFilteredDescription: TStringField;
    quCmdFree: TADOCommand;
    DCOMConn: TDCOMConnection;
  private
    { Private declarations }
  public
    function GetNextID(Const sTabela: String): LongInt;
    procedure RunSQL(SQL:String);
    procedure OpenVendor;
    procedure CloseVendor;
    procedure VendorFilteredID(Vendor: String);
    procedure CloseVendorFiltered;
    function SelectModelCatalog(IDModel, IDVendor: Integer): Integer;
    function SelectIDModel(Description: String): Integer;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

{ TDM }

function TDM.GetNextID(const sTabela: String): LongInt;
begin
 with spGetNextID do
    begin
    Parameters.ParamByName('@Tabela').Value := sTabela;
    ExecProc;
    Result := Parameters.ParamByName('@NovoCodigo').Value;
    end;
end;

procedure TDM.OpenVendor;
begin
  with quVendorList do
   begin
   if Active then
    Close;
    Open;
   end;
end;

procedure TDM.CloseVendor;
begin
  with quVendorList do
   if Active then
    Close;
end;

procedure TDM.VendorFilteredID(Vendor: String);
begin
 with quVendorFiltered do
   begin
   if Active then
    Close;
    Parameters.ParamByName('Vendor').Value := Vendor;
    Open;
   end;
end;

procedure TDM.CloseVendorFiltered;
begin
  with quVendorFiltered do
   if Active then
    Close;
end;

procedure TDM.RunSQL(SQL: String);
begin
 with quCmdFree do
      begin
      CommandText := SQL;
      Execute;
      end;
end;

function TDM.SelectModelCatalog(IDModel,IDVendor: Integer): Integer;
begin
 with quSelectModelCatalog do
  begin
  if Active then
   Close;
  Parameters.ParamByName('IDModel').Value := IDModel;
  Parameters.ParamByName('IDVendor').Value := IDVendor;
  Open;
  end;

 Result := quSelectModelCatalogIDModelCatalog.AsInteger;
end;



function TDM.SelectIDModel(Description: String): Integer;
begin
 with quModelFiltered do
  begin
  if Active then
   Close;
  Parameters.ParamByName('ModelDescription').Value := Description;
  Open;
  end;

 Result := quModelFilteredIDModel.AsInteger;
end;

end.
