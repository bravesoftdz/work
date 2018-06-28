unit uPctWarrantyPrintForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentPrintForm, ppEndUsr, ppComm, ppRelatv, ppProd, ppClass,
  ppReport, XiButton, ExtCtrls, StdCtrls, Provider, DB, ADODB, DBClient,
  ppDB, ppDBPipe, ppCtrls, ppPrnabl, ppBands, ppCache, ppStrtch, ppMemo,
  ppRichTx, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  mrSuperCombo, ppParameter, ppModule, ppDsgnDB, daDataModule, ppCTDsgn,
  raIDE, ppSubRpt, raCodMod, ppRegion, ppVar, PsRBExport_MasterControl,
  ppCTMain;

type
  TWarrantyPrintData = class
    IDPet: Integer;
    IDSpecies: Integer;
    IDWarrantyReport: Integer;
    IDPetSale: Integer;
  end;

  TPctWarrantyPrintForm = class(TParentPrintForm)
    cdsDBPet: TClientDataSet;
    dsDBPet: TDataSource;
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
    btnCancel: TXiButton;
    pnlDesignReport: TPanel;
    scSpecies: TmrSuperCombo;
    btnEdit: TXiButton;
    ppDBWarranty: TppDBPipeline;
    cdsWarranty: TClientDataSet;
    dsWarranty: TDataSource;
    cdsWarrantyIDWarrantyReport: TIntegerField;
    cdsWarrantyIDSpecies: TIntegerField;
    cdsWarrantyReport: TBlobField;
    cdsWarrantyReportDate: TDateTimeField;
    ppParameterList1: TppParameterList;
    cdsWarrantyReportName: TStringField;
    ppDBWarrantyppField5: TppField;
    cdsPetTreatment: TClientDataSet;
    dsPetTreatment: TDataSource;
    cdsPetTreatmentTreatmentType: TIntegerField;
    cdsPetTreatmentTreatment: TStringField;
    cdsPetTreatmentMfg: TStringField;
    cdsPetTreatmentLotNumber: TStringField;
    cdsPetTreatmentTreatmentTypeStr: TStringField;
    ppDBPetTreatment: TppDBPipeline;
    cdsPetTreatmentTreatmentDate: TDateTimeField;
    cdsPetMedical: TClientDataSet;
    dsPetMedical: TDataSource;
    cdsPetMedicalIDPetMedicalCondition: TIntegerField;
    cdsPetMedicalMedicalCondition: TStringField;
    cdsPetMedicalSubMedicalCondition: TStringField;
    cdsPetMedicalRecordDate: TDateTimeField;
    cdsPetMedicalNotes: TStringField;
    ppDBPetMedical: TppDBPipeline;
    cdsMicrochip: TClientDataSet;
    dsMicrochip: TDataSource;
    cdsMicrochipIDMicrochip: TIntegerField;
    cdsMicrochipIDPet: TIntegerField;
    cdsMicrochipMicrochip: TStringField;
    cdsMicrochipMicrochipNum: TStringField;
    ppDBMicrochip: TppDBPipeline;
    dsRegistry: TDataSource;
    cdsRegistry: TClientDataSet;
    cdsRegistryIDRegistry: TIntegerField;
    cdsRegistryIDPet: TIntegerField;
    cdsRegistryRegistrationNum: TStringField;
    cdsRegistryRegistry: TStringField;
    cdsRegistrySKU: TStringField;
    ppDBRegistry: TppDBPipeline;
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
    ppDBPet: TppDBPipeline;
    cdsDBPetBreederAddress: TStringField;
    cdsDBPetBreederCity: TStringField;
    cdsDBPetBreederStateID: TStringField;
    cdsDBPetBreederZip: TStringField;
    cdsDBPetWSalePhoneAreaCode: TStringField;
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
    cdsEmptyPet: TClientDataSet;
    cdsEmptyPetIDPet: TIntegerField;
    cdsEmptyPetIDSpecies: TIntegerField;
    cdsEmptyPetIDPorte: TIntegerField;
    cdsEmptyPetIDBreed: TIntegerField;
    cdsEmptyPetIDStatus: TIntegerField;
    cdsEmptyPetIDBreeder: TIntegerField;
    cdsEmptyPetIDModel: TIntegerField;
    cdsEmptyPetName: TStringField;
    cdsEmptyPetSex: TStringField;
    cdsEmptyPetColor: TStringField;
    cdsEmptyPetSKU: TStringField;
    cdsEmptyPetPenNum: TStringField;
    cdsEmptyPetVendorCost: TBCDField;
    cdsEmptyPetMSRP: TBCDField;
    cdsEmptyPetSalePrice: TBCDField;
    cdsEmptyPetPromoPrice: TBCDField;
    cdsEmptyPetUSDA: TStringField;
    cdsEmptyPetCollar: TStringField;
    cdsEmptyPetSire: TStringField;
    cdsEmptyPetDam: TStringField;
    cdsEmptyPetWhelpDate: TDateTimeField;
    cdsEmptyPetPurchaseDate: TDateTimeField;
    cdsEmptyPetNotes: TStringField;
    cdsEmptyPetSpecies: TStringField;
    cdsEmptyPetBreed: TStringField;
    cdsEmptyPetStatusCode: TStringField;
    cdsEmptyPetStatus: TStringField;
    cdsEmptyPetBreeder: TStringField;
    cdsEmptyPetBreederAddress: TStringField;
    cdsEmptyPetBreederCity: TStringField;
    cdsEmptyPetBreederStateID: TStringField;
    cdsEmptyPetBreederZip: TStringField;
    cdsEmptyPetIDWarrantyReport: TIntegerField;
    cdsEmptyPetWarrantyCustomerName: TStringField;
    cdsEmptyPetWCustomerFirstName: TStringField;
    cdsEmptyPetWCustomerLastName: TStringField;
    cdsEmptyPetWCustomerAddress: TStringField;
    cdsEmptyPetWCustomerCity: TStringField;
    cdsEmptyPetWCustomerStateID: TStringField;
    cdsEmptyPetWCustomerZip: TStringField;
    cdsEmptyPetWCustomerPhone: TStringField;
    cdsEmptyPetWCustomerEmail: TStringField;
    cdsEmptyPetPetSaleDate: TDateTimeField;
    cdsEmptyPetPetSaleCost: TBCDField;
    cdsEmptyPetPetSaleSold: TBCDField;
    cdsEmptyPetPetSaleDiscount: TBCDField;
    cdsEmptyPetSaleCustomerName: TStringField;
    cdsEmptyPetWSalePhoneAreaCode: TStringField;
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
    cdsEmptyPetIDStore: TIntegerField;
    cdsEmptyPetStoreName: TStringField;
    cdsEmptyPetStoreState: TStringField;
    cdsEmptyPetStoreAddress: TStringField;
    cdsEmptyPetStoreCity: TStringField;
    cdsEmptyPetStoreZip: TStringField;
    cdsEmptyPetStorePhone: TStringField;
    cdsEmptyPetStoreFax: TStringField;
    cdsEmptyPetStoreEmail: TStringField;
    cdsEmptyPetStoreWebPage: TStringField;
    procedure cdsDBPetBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsWarrantyBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure btnEditClick(Sender: TObject);
    procedure cdsWarrantyNewRecord(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsPetTreatmentBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsPetMedicalBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsMicrochipBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsRegistryBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure FormCreate(Sender: TObject);
    procedure cdsEmptyPetBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    FMSReport : TMemoryStream;
    procedure LoadReportDB;
    procedure GetReportConfig;
  protected
    procedure OnBeforePrint; override;
    procedure ConfirmFrm; override;
  public
    property MSReport : TMemoryStream read FMSReport write FMSReport;
    function DesignReport(AParam : TObject) : Boolean; override;
    function PrintReport(AParam : TObject; ShowForm: Boolean = True) : Boolean; overload; override;
  end;

implementation

uses uDMPetCenter, uParamFunctions, uMRSQLParam, uDMPet;

{$R *.dfm}

{ TPctWarrantyPrintForm }

procedure TPctWarrantyPrintForm.ConfirmFrm;
begin
  inherited;
  if FDesignMode then
  begin
    if cdsWarranty.ApplyUpdates(-1) > 0 then
    begin
      DMPetCenter.cdsRepWarranty.Close;
      DMPetCenter.cdsRepWarranty.CreateDataSet;
    end;
  end;
  Close;
end;

procedure TPctWarrantyPrintForm.OnBeforePrint;
begin

  if Assigned(FMSReport) then
    try
      ppReport.Template.LoadFromStream(FMSReport);
    except
      raise;
    end;

  inherited;

end;

procedure TPctWarrantyPrintForm.cdsDBPetBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (TWarrantyPrintData(FParam).IDPet <> 0) then
      begin
        AddKey('P.IDPet').AsInteger := TWarrantyPrintData(FParam).IDPet;
        KeyByName('P.IDPet').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;
    
end;

function TPctWarrantyPrintForm.DesignReport(AParam : TObject): Boolean;
begin
  FParam := AParam;
  if FParam = nil then
    FParam := TWarrantyPrintData.Create;
  scSpecies.EditValue := TWarrantyPrintData(FParam).IDSpecies;
  FDesignMode := True;
  btnCancel.Visible := True;
  pnlDesignReport.Visible := True;
  scSpecies.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  GetReportConfig;
  Result := (ShowModal = mrOk);
end;

procedure TPctWarrantyPrintForm.cdsWarrantyBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (TWarrantyPrintData(FParam).IDSpecies <> 0) then
      begin
        AddKey('IDSpecies').AsInteger := TWarrantyPrintData(FParam).IDSpecies;
        KeyByName('IDSpecies').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TPctWarrantyPrintForm.btnEditClick(Sender: TObject);
begin
  inherited;
  if (scSpecies.EditValue <> Null) and (scSpecies.EditValue <> 0) then
  begin
    TWarrantyPrintData(FParam).IDSpecies := scSpecies.EditValue;
    scSpecies.Locked := True;

    cdsWarranty.Open;
    if cdsWarranty.IsEmpty then
      cdsWarranty.Append
    else
      begin
        LoadReportDB;
      end;

    ShowDesignReport;
    ppReport.Template.SaveToDatabase;
  end;
end;

procedure TPctWarrantyPrintForm.LoadReportDB;
begin
  if not cdsWarranty.FieldByName('Report').IsNull then
    ppReport.Template.LoadFromDatabase;
end;

procedure TPctWarrantyPrintForm.cdsWarrantyNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsWarranty.FieldByName('IDSpecies').AsInteger := TWarrantyPrintData(FParam).IDSpecies;
  cdsWarranty.FieldByName('ReportName').AsString := 'Warranty';
  cdsWarranty.FieldByName('ReportDate').AsDateTime := Now;
end;


procedure TPctWarrantyPrintForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if cdsWarranty.Active then
    cdsWarranty.Close;
end;

procedure TPctWarrantyPrintForm.cdsPetTreatmentBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (TWarrantyPrintData(FParam).IDPet <> 0) then
      begin
        AddKey('PT.IDPet').AsInteger := TWarrantyPrintData(FParam).IDPet;
        KeyByName('PT.IDPet').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TPctWarrantyPrintForm.cdsPetMedicalBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (TWarrantyPrintData(FParam).IDPet <> 0) then
      begin
        AddKey('P.IDPet').AsInteger := TWarrantyPrintData(FParam).IDPet;
        KeyByName('P.IDPet').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TPctWarrantyPrintForm.cdsMicrochipBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (TWarrantyPrintData(FParam).IDPet <> 0) then
      begin
        AddKey('PS.IDPet').AsInteger := TWarrantyPrintData(FParam).IDPet;
        KeyByName('PS.IDPet').Condition := tcEquals;
      end;

      if (TWarrantyPrintData(FParam).IDPetSale <> 0) then
      begin
        AddKey('PM.IDPetSale').AsInteger := TWarrantyPrintData(FParam).IDPetSale;
        KeyByName('PM.IDPetSale').Condition := tcEquals;
      end;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TPctWarrantyPrintForm.cdsRegistryBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (TWarrantyPrintData(FParam).IDPet <> 0) then
      begin
        AddKey('P.IDPet').AsInteger := TWarrantyPrintData(FParam).IDPet;
        KeyByName('P.IDPet').Condition := tcEquals;
      end;

      if (TWarrantyPrintData(FParam).IDPetSale <> 0) then
      begin
        AddKey('PPR.IDPetSale').AsInteger := TWarrantyPrintData(FParam).IDPetSale;
        KeyByName('PPR.IDPetSale').Condition := tcEquals;
      end;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TPctWarrantyPrintForm.FormCreate(Sender: TObject);
begin
  inherited;
  GetReportConfig;
end;

procedure TPctWarrantyPrintForm.GetReportConfig;
begin
  Preview := (StrToIntDef(DMPet.GetAppProperty('WarrantyRep', 'Preview'), 1) = 1);
  DefaultPrinter := DMPet.GetAppProperty('WarrantyRep', 'PrinterName');
end;

function TPctWarrantyPrintForm.PrintReport(AParam: TObject;
  ShowForm: Boolean): Boolean;
begin

  Result := inherited PrintReport(AParam, ShowForm);

  if not ShowForm then
  begin
    cdsDBPet.Close;
    cdsWarranty.Close;
    cdsMicrochip.Close;
    cdsRegistry.Close;
    cdsPetMedical.Close;
    cdsPetTreatment.Close;
  end;
  
end;

procedure TPctWarrantyPrintForm.cdsEmptyPetBeforeGetRecords(
  Sender: TObject; var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (TWarrantyPrintData(FParam).IDPet <> 0) then
      begin
        AddKey('P.IDPet').AsInteger := TWarrantyPrintData(FParam).IDPet;
        KeyByName('P.IDPet').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;
  
end;

initialization
  RegisterClass(TPctWarrantyPrintForm);


end.
