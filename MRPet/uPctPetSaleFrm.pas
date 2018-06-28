unit uPctPetSaleFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentModalForm, XiButton, ExtCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo, DB, DBClient,
  cxCalendar, cxDBEdit, mrDBDateEdit, StdCtrls, cxCurrencyEdit,
  mrDBCurrencyEdit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid;

type
  TPctPetSaleFrm = class(TParentModalForm)
    cdsPetSale: TClientDataSet;
    cdsPetSaleStoreID: TIntegerField;
    cdsPetSaleModelID: TIntegerField;
    cdsPetSaleIDPessoa: TIntegerField;
    cdsPetSaleIDUser: TIntegerField;
    cdsPetSaleCostPrice: TCurrencyField;
    cdsPetSaleSalePrice: TCurrencyField;
    cdsPetSaleDiscount: TCurrencyField;
    cdsPetSaleIDWarrantyCustomer: TIntegerField;
    cdsPetSaleIDPet: TIntegerField;
    scPet: TmrDBSuperCombo;
    dsPetSale: TDataSource;
    scSystemUser: TmrDBSuperCombo;
    cdsPetSaleSaleDate: TDateTimeField;
    edtRecordDate: TmrDBDateEdit;
    edtSale: TmrDBCurrencyEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    scCustomerPurchase: TmrDBSuperCombo;
    Bevel2: TBevel;
    Label2: TLabel;
    scCustomerWarranty: TmrDBSuperCombo;
    scPetSatus: TmrDBSuperCombo;
    cdsPetSaleIDStatus: TIntegerField;
    cdsMicrochipSale: TClientDataSet;
    cdsRegistrySale: TClientDataSet;
    cdsMicrochipSaleIDMicrochip: TIntegerField;
    cdsMicrochipSaleMicrochip: TStringField;
    cdsMicrochipSaleMicrochipNum: TStringField;
    cdsRegistrySaleIDRegistry: TIntegerField;
    cdsRegistrySaleMarked: TBooleanField;
    cdsRegistrySaleRegistry: TStringField;
    cdsRegistrySaleRegistrationNum: TStringField;
    lbMAddress: TLabel;
    lbWAddress: TLabel;
    cdsMicrochipSaleIDPet: TIntegerField;
    pnlMicrochips: TPanel;
    dsMicrochipSale: TDataSource;
    grdMicrochip: TcxGrid;
    grdMicrochipDBTableView: TcxGridDBTableView;
    grdMicrochipLevel: TcxGridLevel;
    cdsMicrochipSaleAmount: TBCDField;
    grdMicrochipDBTableViewMicrochip: TcxGridDBColumn;
    grdMicrochipDBTableViewMicrochipNum: TcxGridDBColumn;
    grdMicrochipDBTableViewAmount: TcxGridDBColumn;
    grdMicrochipDBTableViewMarked: TcxGridDBColumn;
    cdsMicrochipSaleMarked: TBooleanField;
    cdsMicrochipSaleIDModel: TIntegerField;
    lbEmail: TLabel;
    cdsPetSaleInvoiceTotal: TCurrencyField;
    edtInvoiceTotal: TmrDBCurrencyEdit;
    procedure FormCreate(Sender: TObject);
    procedure scPetPropertiesEditValueChanged(Sender: TObject);
    procedure cdsPetSaleNewRecord(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure scCustomerPurchasePropertiesEditValueChanged(
      Sender: TObject);
    procedure scCustomerWarrantyPropertiesEditValueChanged(
      Sender: TObject);
    procedure cdsMicrochipSaleBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    FIDSpecies : Integer;
    FIDPet     : Integer;
    FIDSalePet : Integer;
    procedure OpenPetSale;
    procedure ClosePetSale;
    procedure OpenMicrochipSale;
    procedure CloseMicrochipSale;
    procedure OpenRegistrySale;
    procedure CloseRegistrySale;
    procedure PrintWarranty;

    function ValidateField : Boolean;
  protected
    procedure ConfirmFrm; override;
    procedure CancelFrm; override;
  public
    { Public declarations }
  end;

implementation

uses uDMPet, uDMGlobalNTier, uDMPetCenter, mrMsgBox, uMRSQLParam,
     uPctWarrantyPrintForm, uDMMaintenance, uClasseFunctions;

{$R *.dfm}

{ TPctPetSaleFrm }

procedure TPctPetSaleFrm.CancelFrm;
begin
  inherited;

end;

procedure TPctPetSaleFrm.ClosePetSale;
begin
  with cdsPetSale do
    if Active then
      Close;
end;

procedure TPctPetSaleFrm.OpenPetSale;
begin
  with cdsPetSale do
    if not Active then
      CreateDataSet;
end;

procedure TPctPetSaleFrm.ConfirmFrm;
var
  sMsgError : String;
begin
  inherited;
  if ValidateField then
  begin
    if DMPet.PetCenterConn.AppServer.PetCreateSale(cdsPetSale.Data, cdsMicrochipSale.Data, cdsRegistrySale.Data, sMsgError, FIDSalePet) then
      PrintWarranty
    else
      MsgBox('Error. Sale not recorded!-> Check report configuration!', vbCritical + vbOKOnly, sMsgError);
  end
  else
    ModalResult := mrNone;
end;

procedure TPctPetSaleFrm.FormCreate(Sender: TObject);
begin
  inherited;
  scSystemUser.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  scPet.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, 'MenuDisplay=Puppy;');
  scPetSatus.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, '');
  scCustomerWarranty.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, 'MenuDisplay=Customer;EntityType='+IntToStr(PT_CUSTOMER)+';');
  scCustomerPurchase.CreateListSource(DMPet.TraceControl, DMPet.DataSetControl, DMPet.UpdateControl, nil, DMPet.SystemUser, 'MenuDisplay=Customer;EntityType='+IntToStr(PT_CUSTOMER)+';');
  OpenPetSale;
  OpenMicrochipSale;
  OpenRegistrySale;
end;

procedure TPctPetSaleFrm.scPetPropertiesEditValueChanged(Sender: TObject);
var
  cSalePrice,
  cDiscount,
  cPromoPrice : Variant;
begin
  inherited;

  if (cdsPetSale.State <> dsInactive) and (scPet.EditValue <> Null) then
  begin
    cPromoPrice := scPet.GetFieldValue('PromoPrice');
    cSalePrice  := scPet.GetFieldValue('SalePrice');
    cDiscount   := 0;

    if cPromoPrice <> 0 then
      cSalePrice := cPromoPrice;

    FIDPet     := scPet.EditValue;
    FIDSpecies := scPet.GetFieldValue('IDSpecies');
    cdsPetSale.FieldByName('IDStatus').Value  := scPet.GetFieldValue('IDStatus');
    cdsPetSale.FieldByName('CostPrice').Value := scPet.GetFieldValue('VendorCost');
    cdsPetSale.FieldByName('ModelID').Value   := scPet.GetFieldValue('IDModel');
    cdsPetSale.FieldByName('SalePrice').Value := cSalePrice;
    cdsPetSale.FieldByName('Discount').Value  := cDiscount;

    cdsMicrochipSale.Close;
    cdsMicrochipSale.Open;
  end;

end;

procedure TPctPetSaleFrm.cdsPetSaleNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsPetSale.FieldByName('SaleDate').AsDateTime := Now;
  cdsPetSale.FieldByName('StoreID').AsInteger := DMPet.GetPropertyDomain('PctDefaultStore');
  cdsPetSale.FieldByName('IDUser').Value := DMPet.SystemUser.ID;
end;

function TPctPetSaleFrm.ValidateField: Boolean;
begin
  Result := False;

  if (scSystemUser.EditValue = Null) or (scSystemUser.EditValue = 0) then
  begin
    MsgBox('User cannot be empty', vbInformation + vbOKOnly);
    scSystemUser.SetFocus;
    Exit;
  end;

  if (scPet.EditValue = Null) or (scPet.EditValue = 0) then
  begin
    MsgBox('SKU cannot be empty', vbInformation + vbOKOnly);
    scPet.SetFocus;
    Exit;
  end;

  if (edtRecordDate.EditValue = Null) then
  begin
    MsgBox('Date cannot be empty', vbInformation + vbOKOnly);
    edtRecordDate.SetFocus;
    Exit;
  end;

  if (edtSale.EditValue = Null) or (edtSale.EditValue = 0) then
  begin
    MsgBox('Sale Price cannot be 0', vbInformation + vbOKOnly);
    edtSale.SetFocus;
    Exit;
  end;

  if (scCustomerWarranty.EditValue = Null) or (scCustomerWarranty.EditValue = 0) then
  begin
    MsgBox('Customer warranty cannot be empty', vbInformation + vbOKOnly);
    scCustomerWarranty.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TPctPetSaleFrm.CloseMicrochipSale;
begin
  with cdsMicrochipSale do
    if not Active then
      CreateDataSet;
end;

procedure TPctPetSaleFrm.CloseRegistrySale;
begin
  with cdsMicrochipSale do
    if Active then
      Close;
end;

procedure TPctPetSaleFrm.OpenMicrochipSale;
begin
  with cdsRegistrySale do
    if not Active then
      CreateDataSet;
end;

procedure TPctPetSaleFrm.OpenRegistrySale;
begin
  with cdsRegistrySale do
    if Active then
      Close;
end;

procedure TPctPetSaleFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ClosePetSale;
  CloseMicrochipSale;
  CloseRegistrySale;
end;

procedure TPctPetSaleFrm.PrintWarranty;
var
  Form : TForm;
  WPD: TWarrantyPrintData;
  MS : TMemoryStream;
begin
  Form := CreateForm(Self, 'TPctWarrantyPrintForm');
  try
    try
      WPD := TWarrantyPrintData.Create;
      try
        WPD.IDPet := FIDPet;
        WPD.IDSpecies := FIDSpecies;
        WPD.IDPetSale := FIDSalePet;
        MS := DMPetCenter.GetWarrantyReport('IDSpecies', WPD.IDSpecies);
        try
          TPctWarrantyPrintForm(Form).MSReport := MS;
          TPctWarrantyPrintForm(Form).PrintReport(WPD);
        finally
          FreeAndNil(MS);
          end;
      finally
        WPD.Free;
      end;
    except
      MsgBox('Report error._Check report configuration', vbCritical + vbOKOnly);
    end;
  finally
    FreeAndNil(Form);
  end;

end;

procedure TPctPetSaleFrm.scCustomerPurchasePropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if (cdsPetSale.State <> dsInactive) and (scCustomerPurchase.EditValue <> Null) then
  begin
    cdsPetSale.FieldByName('IDWarrantyCustomer').AsInteger := scCustomerPurchase.EditValue;

    lbMAddress.Caption := DMPetCenter.FormatAddress(scCustomerPurchase.GetFieldValue('Endereco'),
                                        scCustomerPurchase.GetFieldValue('Cidade'),
                                        scCustomerPurchase.GetFieldValue('IDEstado'),
                                        scCustomerPurchase.GetFieldValue('CEP'));
    scCustomerPurchase.Hint := lbMAddress.Caption;

    lbEmail.Caption := VarToStr(scCustomerPurchase.GetFieldValue('Email'));
  end;

end;

procedure TPctPetSaleFrm.scCustomerWarrantyPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  if (cdsPetSale.State <> dsInactive) then
    lbWAddress.Caption := DMPetCenter.FormatAddress(scCustomerWarranty.GetFieldValue('Endereco'),
                                        scCustomerWarranty.GetFieldValue('Cidade'),
                                        scCustomerWarranty.GetFieldValue('IDEstado'),
                                        scCustomerWarranty.GetFieldValue('CEP'));
  scCustomerWarranty.Hint := lbWAddress.Caption;

end;

procedure TPctPetSaleFrm.cdsMicrochipSaleBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      if (FIDPet <> 0) then
      begin
        AddKey('PM.IDPet').AsInteger := FIDPet;
        KeyByName('PM.IDPet').Condition := tcEquals;
      end;
      OwnerData := ParamString;
    finally
      Free;
    end;

end;

initialization
  RegisterClass(TPctPetSaleFrm);

end.
