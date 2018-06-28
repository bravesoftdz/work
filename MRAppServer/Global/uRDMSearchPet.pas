unit uRDMSearchPet;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, MRAppServer_TLB, StdVcl, ADODB, DB, Provider, mrConfigTable;

type
  TRDMSearchPet = class(TRemoteDataModule, IRDMSearchPet)
    qrySearchPet: TADOQuery;
    dspSearchPet: TDataSetProvider;
    ctSearchPet: TmrConfigTable;
    qrySearchTreatment: TADOQuery;
    dspSearchTreatment: TDataSetProvider;
    ctSearchTreatment: TmrConfigTable;
    qrySearchPetSale: TADOQuery;
    dspSearchPetSale: TDataSetProvider;
    ctSearchPetSale: TmrConfigTable;
    qryMRPetSate: TADOQuery;
    dspMRPetSale: TDataSetProvider;
    ctMRPetSale: TmrConfigTable;
    ADOConnection: TADOConnection;
    cdsMRPetSale: TClientDataSet;
    cdsMRPetSaleDocumentID: TIntegerField;
    cdsMRPetSaleModel: TStringField;
    cdsMRPetSaleDescription: TStringField;
    cdsMRPetSaleIDPetSale: TIntegerField;
    cdsMRPetSaleMicrochipNum: TStringField;
    cdsMRPetSaleIDPet: TIntegerField;
    cdsMRPetSaleIDSpecies: TIntegerField;
    cdsMRPetSaleIDPorte: TIntegerField;
    cdsMRPetSaleIDBreed: TIntegerField;
    cdsMRPetSaleIDStatus: TIntegerField;
    cdsMRPetSaleIDBreeder: TIntegerField;
    cdsMRPetSaleIDModel: TIntegerField;
    cdsMRPetSaleIDStore: TIntegerField;
    cdsMRPetSaleName: TStringField;
    cdsMRPetSaleSex: TStringField;
    cdsMRPetSaleColor: TStringField;
    cdsMRPetSaleSKU: TStringField;
    cdsMRPetSalePenNum: TStringField;
    cdsMRPetSaleVendorCost: TBCDField;
    cdsMRPetSaleMSRP: TBCDField;
    cdsMRPetSaleSalePrice: TBCDField;
    cdsMRPetSalePromoPrice: TBCDField;
    cdsMRPetSaleUSDA: TStringField;
    cdsMRPetSaleCollar: TStringField;
    cdsMRPetSaleSire: TStringField;
    cdsMRPetSaleDam: TStringField;
    cdsMRPetSaleWhelpDate: TDateTimeField;
    cdsMRPetSalePurchaseDate: TDateTimeField;
    cdsMRPetSaleNotes: TStringField;
    cdsMRPetSaleSpecies: TStringField;
    cdsMRPetSaleBreed: TStringField;
    cdsMRPetSaleStatusCode: TStringField;
    cdsMRPetSaleStatus: TStringField;
    cdsMRPetSaleBreeder: TStringField;
    cdsMRPetSaleIDWarrantyReport: TIntegerField;
    cdsMRPetSaleWarrantyCustomerName: TStringField;
    cdsMRPetSaleWCustomerFirstName: TStringField;
    cdsMRPetSaleWCustomerLastName: TStringField;
    cdsMRPetSaleWCustomerAddress: TStringField;
    cdsMRPetSaleWCustomerCity: TStringField;
    cdsMRPetSaleWCustomerStateID: TStringField;
    cdsMRPetSaleWCustomerZip: TStringField;
    cdsMRPetSaleWCustomerPhone: TStringField;
    cdsMRPetSaleWCustomerEmail: TStringField;
    cdsMRPetSalePetSaleDate: TDateTimeField;
    cdsMRPetSalePetSaleCost: TBCDField;
    cdsMRPetSalePetSaleSold: TBCDField;
    cdsMRPetSalePetSaleDiscount: TBCDField;
    cdsMRPetSaleSaleCustomerName: TStringField;
    cdsMRPetSaleStore: TStringField;
    cdsMRPetSaleQtyOnHand: TBCDField;
    dsMRPetSale: TDataSource;
    qryMRPetInventory: TADOQuery;
    dspMRPetInventory: TDataSetProvider;
    ctMRPetInventory: TmrConfigTable;
    cdsMRPetInventory: TClientDataSet;
    dsMRPetInventory: TDataSource;
    cdsMRPetInventoryIDPet: TIntegerField;
    cdsMRPetInventorySKU: TStringField;
    cdsMRPetInventorySex: TStringField;
    cdsMRPetInventoryColor: TStringField;
    cdsMRPetInventoryPenNum: TStringField;
    cdsMRPetInventoryVendorCost: TBCDField;
    cdsMRPetInventoryMSRP: TBCDField;
    cdsMRPetInventorySalePrice: TBCDField;
    cdsMRPetInventoryPromoPrice: TBCDField;
    cdsMRPetInventoryUSDA: TStringField;
    cdsMRPetInventoryCollar: TStringField;
    cdsMRPetInventorySire: TStringField;
    cdsMRPetInventoryDam: TStringField;
    cdsMRPetInventoryWhelpDate: TDateTimeField;
    cdsMRPetInventoryPurchaseDate: TDateTimeField;
    cdsMRPetInventoryNotes: TStringField;
    cdsMRPetInventorySpecies: TStringField;
    cdsMRPetInventoryPort: TStringField;
    cdsMRPetInventoryBreed: TStringField;
    cdsMRPetInventoryStatusCode: TStringField;
    cdsMRPetInventoryStatus: TStringField;
    cdsMRPetInventoryBreeder: TStringField;
    cdsMRPetInventoryPhoneAreaCode: TStringField;
    cdsMRPetInventoryBreederPhone: TStringField;
    cdsMRPetInventoryStore: TStringField;
    cdsMRPetInventoryWeightEntryDate: TDateTimeField;
    cdsMRPetInventoryWeight: TBCDField;
    cdsMRPetInventoryRegistry: TStringField;
    cdsMRPetInventoryRegistrationNum: TStringField;
    cdsMRPetSaleWCustomerPhoneAreaCode: TStringField;
    procedure ctMRPetSaleBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsMRPetSaleBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    FSaleDate : TDateTime;
    FKey : String;
    FIRDMApplicationHub: IRDMApplicationHub;
    FSQLConnection: TADOConnection;
    procedure SetConnection;
    function FormatSaleFile(dDate : TDateTime) : String;
    function FormatPetInventoryFile(ADate : TDateTime) : String;
    function PetDataSent(ASaleDate : TDateTime) : Boolean;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    function Get_RDMApplicationHub: IRDMApplicationHub; safecall;
    procedure Set_RDMApplicationHub(const Value: IRDMApplicationHub); safecall;
    function SendPetData(const Key: WideString; SaleDate: TDateTime): WordBool;
      safecall;
  public
    { Public declarations }
  end;

var
  RDMSearchPet: TRDMSearchPet;
  RDMSearchPetFactory: TComponentFactory;

implementation

uses uSQLFunctions, uMRSQLParam, uMainRetailTransferData, Forms, IniFiles,
     uMain;

{$R *.DFM}

class procedure TRDMSearchPet.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

function TRDMSearchPet.Get_RDMApplicationHub: IRDMApplicationHub;
begin
  Result := FIRDMApplicationHub;
end;

procedure TRDMSearchPet.Set_RDMApplicationHub(
  const Value: IRDMApplicationHub);
begin
  FIRDMApplicationHub := Value;
  FSQLConnection := TADOConnection(FIRDMApplicationHub.SQLConnection);
  SetConnection;
end;

procedure TRDMSearchPet.SetConnection;
var
  i: Integer;
begin
  for i := 0 to Pred(ComponentCount) do
    if Components[i] is TADOQuery then
      TADOQuery(Components[i]).Connection := FSQLConnection;
end;

procedure TRDMSearchPet.ctMRPetSaleBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  sWhere: WideString;
  Where: TMRSQLParam;
begin

  try
    Where := TMRSQLParam.Create;
    Where.ParamString := OwnerData;

    sWhere := Where.GetWhereSQL +
                 ' AND IM.InventMovTypeID = 1 AND IM.DocumentID IN (SELECT IDInvoice FROM Invoice I (NOLOCK) WHERE PuppyTracker = 1) ORDER BY IM.DocumentID ';
    OwnerData := sWhere;

  finally
    FreeAndNil(Where);
  end;

end;

procedure TRDMSearchPet.cdsMRPetSaleBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin

  with TMRSQLParam.Create do
    try

      AddKey('MovDate1').AsString := FormatDateTime('mm/dd/yyyy', Trunc(FSaleDate));
      KeyByName('MovDate1').Condition := tcGreaterThanEqual;
      KeyByName('MovDate1').Field := 'IM.MovDate';

      AddKey('MovDate2').AsString := FormatDateTime('mm/dd/yyyy', Trunc(FSaleDate+1));
      KeyByName('MovDate2').Condition := tcLessThan;
      KeyByName('MovDate2').Field := 'IM.MovDate';

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

function TRDMSearchPet.SendPetData(const Key: WideString;
  SaleDate: TDateTime): WordBool;
var
  FMRFTPTransfer : TMRFTPTransfer;
  sFile : String;
  i : Integer;
begin

  Result := False;

  try

    FSaleDate := SaleDate;
    FKey := Key;

    if not PetDataSent(FSaleDate) then
    begin
      for i := 0 to 2 do
      begin
        FSaleDate := SaleDate - (i);

        cdsMRPetSale.Open;
        try
          if not cdsMRPetSale.IsEmpty then
          begin
            FMRFTPTransfer := TMRFTPTransfer.Create;
            try
              sFile := FormatSaleFile(Trunc(FSaleDate));
              cdsMRPetSale.SaveToFile(sFile, dfXML);

              FMRFTPTransfer.FZipFile := True;
              FMRFTPTransfer.FDeleteFileAfterSend := True;
              FMRFTPTransfer.SendFile(sFile, True);
              Result := True;
            finally
              FreeAndNil(FMRFTPTransfer);
            end;
          end;
        finally
          cdsMRPetSale.Close;
        end;
      end;


      cdsMRPetInventory.Open;
      try
        if not cdsMRPetInventory.IsEmpty then
        begin
          FMRFTPTransfer := TMRFTPTransfer.Create;
          try
            sFile := FormatPetInventoryFile(FSaleDate);
            cdsMRPetInventory.SaveToFile(sFile, dfXML);

            FMRFTPTransfer.FZipFile := True;
            FMRFTPTransfer.FDeleteFileAfterSend := True;
            FMRFTPTransfer.SendFile(sFile, False);
            Result := True;
          finally
            FreeAndNil(FMRFTPTransfer);
          end;
        end;
      finally
        cdsMRPetInventory.Close;
      end;


    end;

  except
  end;


end;

function TRDMSearchPet.FormatSaleFile(dDate: TDateTime): String;
begin

  Result := ExtractFilePath(Application.ExeName) + 'sales_' +
            FormatDateTime('YYYYMMDD', dDate) + '_' +
            FKey + '.xml';

end;

function TRDMSearchPet.PetDataSent(ASaleDate : TDateTime): Boolean;
var
  fConFile : TIniFile;
begin

  Result := True;

  fConFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + frmMain.GetConfigFile);
  try
    if not fConFile.ValueExists('MRPet', 'LastSendData') then
      fConFile.WriteDate('MRPet', 'LastSendData', ASaleDate-1);

    if fConFile.ReadDate('MRPet', 'LastSendData', ASaleDate-1) < ASaleDate then
    begin
      fConFile.WriteDate('MRPet', 'LastSendData', ASaleDate);
      Result := False;
    end;

  finally
    FreeAndNil(fConFile);
  end;

end;

function TRDMSearchPet.FormatPetInventoryFile(ADate : TDateTime): String;
begin

  Result := ExtractFilePath(Application.ExeName) + 'petinfo_' +
            FormatDateTime('YYYYMMDD', ADate) + '_' +
            FKey + '.xml';

end;

initialization
  RDMSearchPetFactory := TComponentFactory.Create(ComServer, TRDMSearchPet,
    Class_RDMSearchPet, ciInternal, tmApartment);
end.
