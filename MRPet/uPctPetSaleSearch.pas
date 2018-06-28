unit uPctPetSaleSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSearchForm, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, ExtCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, XiButton, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo, StdCtrls,
  cxContainer, cxTextEdit;

type
  TPctPetSaleSearch = class(TParentSearchForm)
    edtSKU: TcxTextEdit;
    lbSKU: TLabel;
    scBreed: TmrSuperCombo;
    scSpecies: TmrSuperCombo;
    scStatus: TmrSuperCombo;
    cdsSearchIDPet: TIntegerField;
    cdsSearchIDSpecies: TIntegerField;
    cdsSearchIDPorte: TIntegerField;
    cdsSearchIDBreed: TIntegerField;
    cdsSearchIDStatus: TIntegerField;
    cdsSearchIDBreeder: TIntegerField;
    cdsSearchIDModel: TIntegerField;
    cdsSearchName: TStringField;
    cdsSearchSex: TStringField;
    cdsSearchColor: TStringField;
    cdsSearchSKU: TStringField;
    cdsSearchPenNum: TStringField;
    cdsSearchVendorCost: TBCDField;
    cdsSearchMSRP: TBCDField;
    cdsSearchSalePrice: TBCDField;
    cdsSearchPromoPrice: TBCDField;
    cdsSearchUSDA: TStringField;
    cdsSearchCollar: TStringField;
    cdsSearchSire: TStringField;
    cdsSearchDam: TStringField;
    cdsSearchWhelpDate: TDateTimeField;
    cdsSearchPurchaseDate: TDateTimeField;
    cdsSearchNotes: TStringField;
    cdsSearchSpecies: TStringField;
    cdsSearchBreed: TStringField;
    cdsSearchStatusCode: TStringField;
    cdsSearchStatus: TStringField;
    cdsSearchBreeder: TStringField;
    cdsSearchIDWarrantyReport: TIntegerField;
    cdsSearchWarrantyCustomerName: TStringField;
    cdsSearchWCustomerFirstName: TStringField;
    cdsSearchWCustomerLastName: TStringField;
    cdsSearchWCustomerAddress: TStringField;
    cdsSearchWCustomerCity: TStringField;
    cdsSearchWCustomerStateID: TStringField;
    cdsSearchWCustomerZip: TStringField;
    cdsSearchWCustomerPhone: TStringField;
    cdsSearchWCustomerEmail: TStringField;
    cdsSearchPetSaleDate: TDateTimeField;
    cdsSearchPetSaleCost: TBCDField;
    cdsSearchPetSaleSold: TBCDField;
    cdsSearchPetSaleDiscount: TBCDField;
    cdsSearchSaleCustomerName: TStringField;
    cdsSearchIDPetSale: TIntegerField;
    grdListDBTableViewSex: TcxGridDBColumn;
    grdListDBTableViewSKU: TcxGridDBColumn;
    grdListDBTableViewPetSaleDate: TcxGridDBColumn;
    grdListDBTableViewPetSaleSold: TcxGridDBColumn;
    grdListDBTableViewPetSaleDiscount: TcxGridDBColumn;
    grdListDBTableViewSaleCustomerName: TcxGridDBColumn;
    grdListDBTableViewWarrantyCustomerName: TcxGridDBColumn;
    grdListDBTableViewDBColumn1: TcxGridDBColumn;
    cdsSearchIDStore: TIntegerField;
    grdListDBTableViewInvoiceTotal: TcxGridDBColumn;
    cdsSearchInvoiceTotal: TBCDField;
    cdsSearchPetNetSale: TBCDField;
    grdListDBTableViewPetNetSale: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure cdsSearchBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure btnOkClick(Sender: TObject);
  private
    FSKU : String;
  protected
    procedure AfterSetParams; override;
  public
    { Public declarations }
  end;

implementation

uses uDMPet, uDMPetCenter, uClasseFunctions, uMRSQLParam, uNTierConsts,
  uParamFunctions, mrMsgBox, uDMWarrantyPrintThread, uMRParam;

{$R *.dfm}

procedure TPctPetSaleSearch.FormCreate(Sender: TObject);
begin
  inherited;
  scBreed.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  scStatus.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  scSpecies.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  grdListDBTableViewInvoiceTotal.Visible := not DMPet.PetIntegration;

end;

procedure TPctPetSaleSearch.cdsSearchBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (edtSKU.Text <> '') then
      begin
        AddKey('P.SKU').AsString := edtSKU.Text;
        KeyByName('P.SKU').Condition := tcLike;
      end;

      if (scBreed.Text <> '') then
      begin
        AddKey('P.IDBreed').AsString := scBreed.EditValue;
        KeyByName('P.IDBreed').Condition := tcEquals;
      end;

      if (scStatus.Text <> '') then
      begin
        AddKey('P.IDStatus').AsString := scStatus.EditValue;
        KeyByName('P.IDStatus').Condition := tcEquals;
      end;

      if (scSpecies.Text <> '') then
      begin
        AddKey('P.IDSpecies').AsString := scSpecies.EditValue;
        KeyByName('P.IDSpecies').Condition := tcEquals;
      end;

      OwnerData := ParamString;
    finally
      Free;
    end;

end;

procedure TPctPetSaleSearch.btnOkClick(Sender: TObject);
var
  FDMThread : TDMWarrantyPrintThread;
  FReportParam : TMRParams;
begin

  if cdsSearch.Active and (cdsSearch.FieldByName('IDPetSale').AsInteger <> 0) then
  begin
    if (DMPet.ClientRpl or DMPet.CorpRpl) and (DMPet.GetPropertyDomain('PctDefaultStore') <> cdsSearch.FieldByName('IDStore').AsInteger) then
    begin
      MsgBox('You cannot re-print sales from the other store.', vbInformation + vbOKOnly);
      Exit;
    end;

    try
      DMPetCenter.GetWarrantyReport('IDWarrantyReport', cdsSearch.FieldByName('IDWarrantyReport').AsInteger);

      FDMThread := TDMWarrantyPrintThread.Create(nil);
      try
        FReportParam := TMRParams.Create;
        try
          FReportParam.AddKey(CON_PARAM_TYPE);
          FReportParam.KeyByName(CON_PARAM_TYPE).AsString := DMPet.FConType;

          FReportParam.AddKey(CON_PARAM_CLIENT_ID);
          FReportParam.KeyByName(CON_PARAM_CLIENT_ID).AsString := DMPet.FClientID;

          FReportParam.AddKey(CON_PARAM_HOST);
          FReportParam.KeyByName(CON_PARAM_HOST).AsString := DMPet.FHost;

          FReportParam.AddKey(CON_PARAM_PORT);
          FReportParam.KeyByName(CON_PARAM_PORT).AsString := DMPet.FPort;

          FReportParam.AddKey(CON_PARAM_SOFTWARE);
          FReportParam.KeyByName(CON_PARAM_SOFTWARE).AsString := DMPet.FSoftware;

          FDMThread.Preview             := (StrToIntDef(DMPet.GetAppProperty('WarrantyRep', 'Preview'), 1) = 1);
          FDMThread.DefaulPrinter       := DMPet.GetAppProperty('WarrantyRep', 'PrinterName');
          FDMThread.cdsRepWarranty.Data := DMPetCenter.cdsRepWarranty.Data;
          FDMThread.ConnectionParams    := FReportParam;

          FDMThread.PrintWarrantyFromPetCenter(cdsSearch.FieldByName('IDPetSale').AsInteger);
        finally
          FreeAndNil(FReportParam);
        end;

      finally
        FreeAndNil(FDMThread);
      end;

    except
      MsgBox('Report error._Check report configuration', vbCritical + vbOKOnly);
    end;

  end;

end;

procedure TPctPetSaleSearch.AfterSetParams;
begin
  inherited;
  FSKU := ParseParam(FParams, 'SKU');
  if FSKU <> '' then
  begin
    edtSKU.Text := FSKU;
    RefreshSearchList;
  end;
end;

initialization
  RegisterClass(TPctPetSaleSearch);


end.
