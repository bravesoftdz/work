unit uDMWarrantyPrintThread;

interface

uses
  SysUtils, Classes, DB, DBClient, Forms, ActiveX, uMRParam, MConnect, uNTierClasses, 
  ppDB, ppComm, ppRelatv, ppDBPipe, ppParameter, ppVar, ppBands, ppClass,
  ppRegion, ppModule, raCodMod, ppCtrls, ppReport, ppSubRpt, ppStrtch,
  ppRichTx, ppPrnabl, ppCache, ppProd, PsRBExport_MasterControl;

type

  TWarrantyPrintData = class
    IDPet: Integer;
    IDSpecies: Integer;
    IDWarrantyReport: Integer;
    IDPetSale: Integer;
  end;

  TDMWarrantyPrintThread = class(TDataModule)
    cdsPetPrint: TClientDataSet;
    ReportConn: TSharedConnection;
    PetCenterConn: TSharedConnection;
    SearchPetConn: TSharedConnection;
    cdsRepWarranty: TClientDataSet;
    cdsRepWarrantyIDWarrantyReport: TIntegerField;
    cdsRepWarrantyIDSpecies: TIntegerField;
    cdsRepWarrantyReport: TBlobField;
    cdsRepWarrantyReportDate: TDateTimeField;
    cdsRepWarrantyReportName: TStringField;
    cdsDBPet: TClientDataSet;
    cdsDBPetIDPet: TIntegerField;
    cdsDBPetIDSpecies: TIntegerField;
    cdsDBPetIDPorte: TIntegerField;
    cdsDBPetIDBreed: TIntegerField;
    cdsDBPetIDStatus: TIntegerField;
    cdsDBPetIDBreeder: TIntegerField;
    cdsDBPetIDModel: TIntegerField;
    cdsDBPetName: TStringField;
    cdsDBPetSex: TStringField;
    cdsDBPetColor: TStringField;
    cdsDBPetSKU: TStringField;
    cdsDBPetPenNum: TStringField;
    cdsDBPetVendorCost: TBCDField;
    cdsDBPetMSRP: TBCDField;
    cdsDBPetSalePrice: TBCDField;
    cdsDBPetPromoPrice: TBCDField;
    cdsDBPetUSDA: TStringField;
    cdsDBPetCollar: TStringField;
    cdsDBPetSire: TStringField;
    cdsDBPetDam: TStringField;
    cdsDBPetWhelpDate: TDateTimeField;
    cdsDBPetPurchaseDate: TDateTimeField;
    cdsDBPetNotes: TStringField;
    cdsDBPetSpecies: TStringField;
    cdsDBPetBreed: TStringField;
    cdsDBPetStatusCode: TStringField;
    cdsDBPetStatus: TStringField;
    cdsDBPetBreeder: TStringField;
    cdsDBPetIDWarrantyReport: TIntegerField;
    cdsDBPetWarrantyCustomerName: TStringField;
    cdsDBPetWCustomerFirstName: TStringField;
    cdsDBPetWCustomerLastName: TStringField;
    cdsDBPetWCustomerAddress: TStringField;
    cdsDBPetWCustomerCity: TStringField;
    cdsDBPetWCustomerStateID: TStringField;
    cdsDBPetWCustomerZip: TStringField;
    cdsDBPetWCustomerPhone: TStringField;
    cdsDBPetWCustomerEmail: TStringField;
    cdsDBPetPetSaleDate: TDateTimeField;
    cdsDBPetPetSaleCost: TBCDField;
    cdsDBPetPetSaleSold: TBCDField;
    cdsDBPetPetSaleDiscount: TBCDField;
    cdsDBPetSaleCustomerName: TStringField;
    cdsDBPetBreederAddress: TStringField;
    cdsDBPetBreederCity: TStringField;
    cdsDBPetBreederStateID: TStringField;
    cdsDBPetBreederZip: TStringField;
    cdsDBPetWSalePhoneAreaCode: TStringField;
    dsDBPet: TDataSource;
    ppDBPet: TppDBPipeline;
    cdsWarranty: TClientDataSet;
    cdsWarrantyIDWarrantyReport: TIntegerField;
    cdsWarrantyIDSpecies: TIntegerField;
    cdsWarrantyReport: TBlobField;
    cdsWarrantyReportDate: TDateTimeField;
    cdsWarrantyReportName: TStringField;
    dsWarranty: TDataSource;
    ppDBWarranty: TppDBPipeline;
    ppDBWarrantyppField1: TppField;
    ppDBWarrantyppField2: TppField;
    ppDBWarrantyppField3: TppField;
    ppDBWarrantyppField4: TppField;
    ppDBWarrantyppField5: TppField;
    cdsMicrochip: TClientDataSet;
    cdsMicrochipIDMicrochip: TIntegerField;
    cdsMicrochipIDPet: TIntegerField;
    cdsMicrochipMicrochip: TStringField;
    cdsMicrochipMicrochipNum: TStringField;
    dsMicrochip: TDataSource;
    ppDBMicrochip: TppDBPipeline;
    ppDBMicrochipppField1: TppField;
    ppDBMicrochipppField2: TppField;
    ppDBMicrochipppField3: TppField;
    ppDBMicrochipppField4: TppField;
    cdsRegistry: TClientDataSet;
    cdsRegistryIDRegistry: TIntegerField;
    cdsRegistryIDPet: TIntegerField;
    cdsRegistryRegistrationNum: TStringField;
    cdsRegistryRegistry: TStringField;
    cdsRegistrySKU: TStringField;
    dsRegistry: TDataSource;
    ppDBRegistry: TppDBPipeline;
    cdsPetMedical: TClientDataSet;
    cdsPetMedicalIDPetMedicalCondition: TIntegerField;
    cdsPetMedicalMedicalCondition: TStringField;
    cdsPetMedicalSubMedicalCondition: TStringField;
    cdsPetMedicalRecordDate: TDateTimeField;
    cdsPetMedicalNotes: TStringField;
    dsPetMedical: TDataSource;
    ppDBPetMedical: TppDBPipeline;
    ppDBPetMedicalppField1: TppField;
    ppDBPetMedicalppField2: TppField;
    ppDBPetMedicalppField3: TppField;
    ppDBPetMedicalppField4: TppField;
    ppDBPetMedicalppField5: TppField;
    cdsPetTreatment: TClientDataSet;
    cdsPetTreatmentTreatmentType: TIntegerField;
    cdsPetTreatmentTreatment: TStringField;
    cdsPetTreatmentMfg: TStringField;
    cdsPetTreatmentLotNumber: TStringField;
    cdsPetTreatmentTreatmentTypeStr: TStringField;
    cdsPetTreatmentTreatmentDate: TDateTimeField;
    dsPetTreatment: TDataSource;
    ppDBPetTreatment: TppDBPipeline;
    ppDBPetTreatmentppField1: TppField;
    ppDBPetTreatmentppField2: TppField;
    ppDBPetTreatmentppField3: TppField;
    ppDBPetTreatmentppField4: TppField;
    ppDBPetTreatmentppField5: TppField;
    ppDBPetTreatmentppField6: TppField;
    RBExportrControl: TPsRBExportMasterControl;
    ppReport: TppReport;
    ppTitleBand: TppTitleBand;
    ppImage: TppImage;
    ppShape10: TppShape;
    ppLabel2: TppLabel;
    ppLabel1: TppLabel;
    ppRichText1: TppRichText;
    ppDetailBand: TppDetailBand;
    ppSubRepTerms: TppSubReport;
    ppChildRepTerm: TppChildReport;
    ppTitleBand1: TppTitleBand;
    ppRichTerm: TppRichText;
    ppDetailBand1: TppDetailBand;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLine4: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    raCodeModule1: TraCodeModule;
    ppRegion1: TppRegion;
    ppShape: TppShape;
    ppLabel5: TppLabel;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText1: TppDBText;
    ppLabel9: TppLabel;
    ppDBText2: TppDBText;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLine: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel: TppLabel;
    ppDBText: TppDBText;
    ppLabelw: TppLabel;
    ppDBTextw: TppDBText;
    ppLinew: TppLine;
    ppLine12: TppLine;
    ppLine13: TppLine;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLine16: TppLine;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppVariable4: TppVariable;
    ppVariable5: TppVariable;
    ppLine17: TppLine;
    ppLabel27: TppLabel;
    ppVariable6: TppVariable;
    ppLabel29: TppLabel;
    ppDBText20: TppDBText;
    SubRepTreatment: TppSubReport;
    ppChildReport1: TppChildReport;
    ppHeaderBand1: TppHeaderBand;
    ppLine26: TppLine;
    ppDetailBand2: TppDetailBand;
    ppDBText11: TppDBText;
    ppVariable1: TppVariable;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppFooterBandTreat: TppFooterBand;
    ppGroup: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppDBText10: TppDBText;
    ppLine24: TppLine;
    ppLine25: TppLine;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLine20: TppLine;
    raCodeModule3: TraCodeModule;
    ppRegion2: TppRegion;
    ppShape2: TppShape;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLabel16: TppLabel;
    ppDBText3: TppDBText;
    ppLabel18: TppLabel;
    ppDBText8: TppDBText;
    ppLine3: TppLine;
    ppLine10: TppLine;
    ppLabel17: TppLabel;
    ppDBText4: TppDBText;
    ppDBText9: TppDBText;
    ppLabel19: TppLabel;
    ppLine11: TppLine;
    ppLabel28: TppLabel;
    ppDBText19: TppDBText;
    ppSubRepMedical: TppSubReport;
    ppChildReport: TppChildReport;
    ppTitleBand4: TppTitleBand;
    ppShape4: TppShape;
    ppLabel20: TppLabel;
    ppDetailBand3: TppDetailBand;
    ppDBText12: TppDBText;
    ppVariable2: TppVariable;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppSummaryBand3: TppSummaryBand;
    ppLine23: TppLine;
    raCodeModule4: TraCodeModule;
    ppRegion3: TppRegion;
    ppSubRepMicrochip: TppSubReport;
    ppChildReport2: TppChildReport;
    ppTitleBand5: TppTitleBand;
    ppDetailBand4: TppDetailBand;
    ppDBText13: TppDBText;
    ppSummaryBand4: TppSummaryBand;
    raCodeModule6: TraCodeModule;
    ppRegion4: TppRegion;
    ppSubRepRegistry: TppSubReport;
    ppChildReport3: TppChildReport;
    ppTitleBand6: TppTitleBand;
    ppDetailBand5: TppDetailBand;
    ppVariable3: TppVariable;
    ppSummaryBand5: TppSummaryBand;
    raCodeModule5: TraCodeModule;
    ppFooterBand: TppFooterBand;
    ppLabel26: TppLabel;
    raCodeModule2: TraCodeModule;
    ppParameterList1: TppParameterList;
    cdsDBPetIDStore: TIntegerField;
    cdsDBPetStoreName: TStringField;
    cdsDBPetStoreState: TStringField;
    cdsDBPetStoreAddress: TStringField;
    cdsDBPetStoreCity: TStringField;
    cdsDBPetStoreZip: TStringField;
    cdsDBPetStorePhone: TStringField;
    cdsDBPetStoreFax: TStringField;
    cdsDBPetStoreEmail: TStringField;
    cdsDBPetStoreWebPage: TStringField;
    procedure cdsPetPrintBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsDBPetBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsWarrantyBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsMicrochipBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsRegistryBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsPetMedicalBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsPetTreatmentBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    FIDPresale: Integer;
    FIDPetSale: Integer;
    FConnectionParams: TMRParams;
    FConnectionService: TNTierConnectionService;
    WPD: TWarrantyPrintData;
    FDefaulPrinter: String;
    FPreview: Boolean;
    procedure SetConnection;
    procedure SetReportConnection;
    function GetWarrantyReport(AFieldName: String; AID : Integer) : TMemoryStream;
    procedure OnBeforePrint;
    procedure OnAfterPrint;
    function PrintWarranty : Boolean;
  public
    property ConnectionParams: TMRParams read FConnectionParams write FConnectionParams;
    property DefaulPrinter : String read FDefaulPrinter write FDefaulPrinter;
    property Preview : Boolean read FPreview write FPreview;
    function PrintWarrantyFromMainRetail(AIDPresale: Integer): Boolean;
    function PrintWarrantyFromPetCenter(AIDPetSale: Integer): Boolean;
  end;

var
  DMWarrantyPrintThread: TDMWarrantyPrintThread;

implementation

uses uDMPet, uMRSQLParam, uClasseFunctions, ppTypes;

{$R *.dfm}

procedure TDMWarrantyPrintThread.cdsPetPrintBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin
  with TMRSQLParam.Create do
    try
      if (FIDPreSale <> 0) then
      begin
        AddKey('I.IDPresale').AsInteger := FIDPresale;
        KeyByName('I.IDPresale').Condition := tcEquals;
      end else if (FIDPetSale <> 0) then
      begin
        AddKey('PPS.IDPetSale').AsInteger := FIDPetSale;
        KeyByName('PPS.IDPetSale').Condition := tcEquals;
      end;

      OwnerData := ParamString;
    finally
      Free;
    end;
end;


function TDMWarrantyPrintThread.PrintWarranty : Boolean;
var
  MS : TMemoryStream;
begin

  Result := False;
  SetConnection;
  FConnectionService.OpenConnection;
  try
    cdsPetPrint.Open;
    if not cdsPetPrint.IsEmpty then
    begin
      WPD := TWarrantyPrintData.Create;
      try
        cdsPetPrint.First;
        while not cdsPetPrint.Eof do
        begin
          WPD.IDPet := cdsPetPrint.FieldByName('IDPet').AsInteger;
          WPD.IDSpecies := cdsPetPrint.FieldByName('IDSpecies').AsInteger;
          WPD.IDPetSale := cdsPetPrint.FieldByName('IDPetSale').AsInteger;
          WPD.IDWarrantyReport := cdsPetPrint.FieldByName('IDWarrantyReport').AsInteger;
          MS := GetWarrantyReport('IDWarrantyReport', WPD.IDWarrantyReport);
          try

            if Assigned(MS) then
              ppReport.Template.LoadFromStream(MS);

            SetReportConnection;
            try
              OnBeforePrint;
              ppReport.Print;
              Result := True;
            finally
              OnAfterPrint;
            end;

          finally
            FreeAndNil(MS);
          end;
          cdsPetPrint.Next;
        end;
      finally
        FreeAndNil(WPD);
      end;
    end;
  finally
    FConnectionService.CloseConnection;
  end;

end;

function TDMWarrantyPrintThread.PrintWarrantyFromMainRetail(AIDPresale: Integer): Boolean;
begin
  Result := False;
  FIDPresale := AIDPresale;
  Result := PrintWarranty;
end;

function TDMWarrantyPrintThread.PrintWarrantyFromPetCenter(AIDPetSale: Integer): Boolean;
begin
  Result := False;
  FIDPetSale := AIDPetSale;
  Result := PrintWarranty;
end;


procedure TDMWarrantyPrintThread.SetConnection;
var
  I: Integer;
begin
  FConnectionService.ConnectionParams := FConnectionParams;
  FConnectionService.CreateNTierConnection;

  for I := 0 to Pred(ComponentCount) do
    if Components[I] is TSharedConnection then
       TSharedConnection(Components[I]).ParentConnection := FConnectionService.ActiveConnection;
       
end;

procedure TDMWarrantyPrintThread.SetReportConnection;
begin
  cdsDBPet.RemoteServer := ReportConn;
  cdsMicrochip.RemoteServer := ReportConn;
  cdsRegistry.RemoteServer := ReportConn;
  cdsPetTreatment.RemoteServer := ReportConn;

  cdsPetMedical.RemoteServer := PetCenterConn;
  cdsWarranty.RemoteServer := PetCenterConn;
end;

procedure TDMWarrantyPrintThread.DataModuleCreate(Sender: TObject);
begin
  CoInitialize(nil);
  FConnectionService := TNTierConnectionService.Create;
  FIDPresale := 0;
  FIDPetSale := 0;
end;

procedure TDMWarrantyPrintThread.DataModuleDestroy(Sender: TObject);
begin
  FConnectionService.Free;
  CoUninitialize;
end;

function TDMWarrantyPrintThread.GetWarrantyReport(AFieldName: String;
  AID: Integer): TMemoryStream;
begin
  try
    Result := nil;
    cdsRepWarranty.First;
    if cdsRepWarranty.Locate(AFieldName, AID, []) then
    begin
      Result := TMemoryStream.Create();
      TBlobField(cdsRepWarranty.FieldByName('Report')).SaveToStream(Result);
      Result.seek(0, soFromBeginning);
    end
  finally
  end;
end;

procedure TDMWarrantyPrintThread.cdsDBPetBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  with TMRSQLParam.Create do
    try
      if (WPD.IDPet <> 0) then
      begin
        AddKey('P.IDPet').AsInteger := WPD.IDPet;
        KeyByName('P.IDPet').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;
end;

procedure TDMWarrantyPrintThread.cdsWarrantyBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin

  with TMRSQLParam.Create do
    try
      if (WPD.IDSpecies <> 0) then
      begin
        AddKey('IDSpecies').AsInteger := WPD.IDSpecies;
        KeyByName('IDSpecies').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TDMWarrantyPrintThread.cdsMicrochipBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin

  with TMRSQLParam.Create do
    try
      if (WPD.IDPet <> 0) then
      begin
        AddKey('PS.IDPet').AsInteger := WPD.IDPet;
        KeyByName('PS.IDPet').Condition := tcEquals;
      end;

      if (WPD.IDPetSale <> 0) then
      begin
        AddKey('PM.IDPetSale').AsInteger := WPD.IDPetSale;
        KeyByName('PM.IDPetSale').Condition := tcEquals;
      end;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TDMWarrantyPrintThread.cdsRegistryBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin

  with TMRSQLParam.Create do
    try
      if (WPD.IDPet <> 0) then
      begin
        AddKey('P.IDPet').AsInteger := WPD.IDPet;
        KeyByName('P.IDPet').Condition := tcEquals;
      end;

      if (WPD.IDPetSale <> 0) then
      begin
        AddKey('PPR.IDPetSale').AsInteger := WPD.IDPetSale;
        KeyByName('PPR.IDPetSale').Condition := tcEquals;
      end;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TDMWarrantyPrintThread.cdsPetMedicalBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin

  with TMRSQLParam.Create do
    try
      if (WPD.IDPet <> 0) then
      begin
        AddKey('P.IDPet').AsInteger := WPD.IDPet;
        KeyByName('P.IDPet').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TDMWarrantyPrintThread.cdsPetTreatmentBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin

  with TMRSQLParam.Create do
    try
      if (WPD.IDPet <> 0) then
      begin
        AddKey('PT.IDPet').AsInteger := WPD.IDPet;
        KeyByName('PT.IDPet').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TDMWarrantyPrintThread.OnBeforePrint;
begin

  if FPreview then
    ppReport.DeviceType := dtScreen
  else
  begin
    ppReport.DeviceType      := dtPrinter;
    ppReport.ShowPrintDialog := False;
  end;

  ppReport.AllowPrintToArchive := True;
  ppReport.AllowPrintToFile    := True;

  if FDefaulPrinter <> '' then
    ppReport.PrinterSetup.PrinterName := FDefaulPrinter;

end;

procedure TDMWarrantyPrintThread.OnAfterPrint;
begin
  cdsDBPet.Close;
  cdsWarranty.Close;
  cdsMicrochip.Close;
  cdsRegistry.Close;
  cdsPetMedical.Close;
  cdsPetTreatment.Close;
end;

end.
