unit uPctPetFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, uNTUpdateControl,
  cxDBLookupComboBox, mrSuperCombo, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxDBEdit, mrDBEdit, cxCurrencyEdit, mrDBCurrencyEdit,
  cxImageComboBox, mrDBImageComboBox, cxMemo, mrDBMemo, StdCtrls,
  cxCalendar, mrDBDateEdit, ComCtrls, mrSubListPanel, uMRSQLParam;

type
  TPctPetFch = class(TParentButtonFch)
    edtSKU: TmrDBEdit;
    scBreed: TmrDBSuperCombo;
    scPetSatus: TmrDBSuperCombo;
    scBreeder: TmrDBSuperCombo;
    edtPenNum: TmrDBEdit;
    edtUSDA: TmrDBEdit;
    edtCollar: TmrDBEdit;
    cbxSex: TmrDBImageComboBox;
    edtWhelpDate: TmrDBDateEdit;
    edtPurchaseDate: TmrDBDateEdit;
    memNotes: TmrDBMemo;
    pgPetInfo: TPageControl;
    tsRegistry: TTabSheet;
    tsMicrochip: TTabSheet;
    tsWeight: TTabSheet;
    slpRegistry: TmrSubListPanel;
    slpMicrochip: TmrSubListPanel;
    slpWeight: TmrSubListPanel;
    edtSire: TmrDBEdit;
    edtDam: TmrDBEdit;
    scSpecies: TmrDBSuperCombo;
    tsTreatment: TTabSheet;
    slpTreatment: TmrSubListPanel;
    tsMedicalCondition: TTabSheet;
    slpMedicalCon: TmrSubListPanel;
    edtCost: TmrDBCurrencyEdit;
    edtSale: TmrDBCurrencyEdit;
    edtPromo: TmrDBCurrencyEdit;
    edtSugg: TmrDBCurrencyEdit;
    scColor: TmrDBSuperCombo;
    scStore: TmrDBSuperCombo;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure slpRegistryGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpRegistryGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure FormShow(Sender: TObject);
    procedure ConfigFchAfterNavigation(Sender: TObject);
    procedure slpRegistryGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpRegistryStateChange(Sender: TObject);
    procedure slpMicrochipGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpMicrochipGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpMicrochipGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpMicrochipStateChange(Sender: TObject);
    procedure slpWeightGetFilter(Sender: TObject; var Filter: TMRSQLParam);
    procedure slpWeightGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpWeightGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpWeightStateChange(Sender: TObject);
    procedure slpTreatmentGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpTreatmentGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpTreatmentGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpTreatmentStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure slpMedicalConGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpMedicalConGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpMedicalConGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpMedicalConStateChange(Sender: TObject);
    procedure ConfigFchAfterAppend(Sender: TObject);
    procedure ConfigFchBeforeApplyChanges(Sender: TObject;
      var Apply: Boolean);
    procedure scBreederBeforeGetRecordsList(Sender: TObject;
      var OwnerData: OleVariant);
    procedure edtSKUKeyPress(Sender: TObject; var Key: Char);
    procedure dsFchDataChange(Sender: TObject; Field: TField);
    procedure pgPetInfoChange(Sender: TObject);
  private
    procedure ClearSubList;
    procedure RefreshSubList;
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, uDMMaintenance, uParentCustomFch, uSystemTypes,
     mrMsgBox, uClasseFunctions, uParentModalForm;

{$R *.dfm}

procedure TPctPetFch.ConfigFchAfterStart(Sender: TObject);
begin
  scBreed.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Breed;');
  scPetSatus.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser);
  scBreeder.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Breeder;EntityType='+IntToStr(PT_BREEDER)+';');
  scSpecies.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Species;');
  scColor.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Color;');
  scStore.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Store;');
  slpRegistry.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Registry;');
  slpMicrochip.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Microchip;');
  slpWeight.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Weight;');
  slpTreatment.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Apply Treatment;');
  slpMedicalCon.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Apply Medical Condition;');
  inherited;
  
end;

procedure TPctPetFch.slpRegistryGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('PPR.IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('PPR.IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetFch.slpRegistryGetForeignKeyValue(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetFch.FormShow(Sender: TObject);
begin
  inherited;
  RefreshSubList;
  edtSKU.Locked := (ActionType <> atAppend);
  scStore.Locked := edtSKU.Locked;
  scSpecies.Locked := edtSKU.Locked;
  scBreed.Locked := edtSKU.Locked;
  if scStore.Locked then
    scPetSatus.Locked := DataSet.FieldByName('IDStore').Value <> DMPet.GetPropertyDomain('PctDefaultStore');
end;

procedure TPctPetFch.ConfigFchAfterNavigation(Sender: TObject);
begin
  inherited;
  RefreshSubList;
end;

procedure TPctPetFch.RefreshSubList;
begin
{ disabled refresh sublist to avoid lost datas.
  case pgPetInfo.ActivePageIndex of
    0 : slpRegistry.RefreshSubList;
    1 : slpMicrochip.RefreshSubList;
    2 : slpWeight.RefreshSubList;
    3 : slpTreatment.RefreshSubList;
    4 : slpMedicalCon.RefreshSubList;
  end;
 }
end;

procedure TPctPetFch.slpRegistryGetTransaction(Sender: TObject;
  var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctPetFch.slpRegistryStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctPetFch.slpMicrochipGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('PM.IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('PM.IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetFch.slpMicrochipGetForeignKeyValue(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('IDPet').Condition := tcEquals;
  end;
  
end;

procedure TPctPetFch.slpMicrochipGetTransaction(Sender: TObject;
  var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctPetFch.slpMicrochipStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctPetFch.slpWeightGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('PW.IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('PW.IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetFch.slpWeightGetForeignKeyValue(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('IDPet').Condition := tcEquals;
  end;
  
end;

procedure TPctPetFch.slpWeightGetTransaction(Sender: TObject;
  var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctPetFch.slpWeightStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctPetFch.slpTreatmentGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('PT.IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('PT.IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetFch.slpTreatmentGetForeignKeyValue(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetFch.slpTreatmentGetTransaction(Sender: TObject;
  var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctPetFch.slpTreatmentStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctPetFch.FormDestroy(Sender: TObject);
begin
  slpRegistry.FreeSubList;
  slpMicrochip.FreeSubList;
  slpWeight.FreeSubList;
  slpTreatment.FreeSubList;
  slpMedicalCon.FreeSubList;
  inherited;
end;

procedure TPctPetFch.slpMedicalConGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('PMC.IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('PMC.IDPet').Condition := tcEquals;
  end;

end;

procedure TPctPetFch.slpMedicalConGetForeignKeyValue(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDPet').AsInteger := DataSet.FieldByName('IDPet').AsInteger;
    KeyByName('IDPet').Condition := tcEquals;
  end;
  
end;

procedure TPctPetFch.slpMedicalConGetTransaction(Sender: TObject;
  var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctPetFch.slpMedicalConStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctPetFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;

  DataSet.FieldByName('IDStatus').Value := PET_STATUS_AVAILABLE;
  DataSet.FieldByName('SKU').Value := VarToStr(DMPet.ActiveConnection.AppServer.GetNextCode('Pet', 'SKU'));
  DataSet.FieldByName('IDStore').Value := DMPet.GetPropertyDomain('PctDefaultStore');

  ClearSubList;
end;

procedure TPctPetFch.ConfigFchBeforeApplyChanges(Sender: TObject;
  var Apply: Boolean);
begin
  inherited;

  if (ActionType = atAppend) and (DMPet.PetCenterConn.AppServer.PetSKUExist(DataSet.FieldByName('SKU').AsString)) then
  begin
    MsgBox('SKU already exist!', vbInformation + vbOKOnly);
    Apply := False;
    Exit;
  end;

  if (VarToStr(DMPet.GetPropertyDomain('PctPetCategory')) = '') or
     (VarToStr(DMPet.GetPropertyDomain('PctPetKitCategory')) = '') or
     (VarToStr(DMPet.GetPropertyDomain('PctDefaultStore')) = '') then
  begin
    MsgBox('You need to configure the application before creat a Puppy!', vbInformation + vbOKOnly);
    Apply := False;
    Exit;
  end;

end;

procedure TPctPetFch.ClearSubList;
begin
  slpRegistry.RefreshSubList;
  slpMicrochip.RefreshSubList;
  slpWeight.RefreshSubList;
  slpTreatment.RefreshSubList;
  slpMedicalCon.RefreshSubList;
end;

procedure TPctPetFch.scBreederBeforeGetRecordsList(Sender: TObject;
  var OwnerData: OleVariant);
begin
  inherited;

  with TMRSQLParam.Create do
    try
      AddKey('Path').AsString := DMPet.GetPropertyDomain('PctBreederDefaultEntityTypePath');
      KeyByName('Path').Condition := tcLikeStartWith;

      AddKey('P.Desativado').AsBoolean := False;
      KeyByName('P.Desativado').Condition := tcEquals;

      AddKey('P.Hidden').AsBoolean := False;
      KeyByName('P.Hidden').Condition := tcEquals;

      OwnerData := ParamString;
    finally
      Free;
    end;
   
end;

procedure TPctPetFch.edtSKUKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key = ' ') then
    key := #0;
end;

procedure TPctPetFch.dsFchDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  scStore.Locked := (ActionType <> atAppend);

  if scStore.Locked then
   scPetSatus.Locked := DataSet.FieldByName('IDStore').Value <> DMPet.GetPropertyDomain('PctDefaultStore');

end;

procedure TPctPetFch.pgPetInfoChange(Sender: TObject);
begin
  inherited;
  RefreshSubList;
end;

initialization
  RegisterClass(TPctPetFch);

end.
