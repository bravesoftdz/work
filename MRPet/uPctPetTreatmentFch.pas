unit uPctPetTreatmentFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, StdCtrls, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo, cxDBEdit,
  mrDBEdit, cxCalendar, mrDBDateEdit, cxMemo, mrDBMemo, cxButtonEdit,
  uSystemTypes;

type
  TPctPetTreatmentFch = class(TParentButtonFch)
    scTreatment: TmrDBSuperCombo;
    scTreatmentLot: TmrDBSuperCombo;
    scSystemUser: TmrDBSuperCombo;
    edtExpirationDate: TmrDBDateEdit;
    edtTreatmentDate: TmrDBDateEdit;
    edtDosesUsed: TmrDBEdit;
    memNotes: TmrDBMemo;
    scPet: TmrDBSuperCombo;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure scTreatmentPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConfigFchBeforeApplyChanges(Sender: TObject;
      var Apply: Boolean);
    procedure scTreatmentLotPropertiesEditValueChanged(Sender: TObject);
    procedure ConfigFchAfterAppend(Sender: TObject);
  private
    procedure ApplyTreatmentFilter;
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, uParentCustomFch, uParentSearchForm;

{$R *.dfm}

procedure TPctPetTreatmentFch.ApplyTreatmentFilter;
var
  sTrFilter : String;
begin

  if (scTreatment.EditValue <> Null) and (scTreatment.EditValue <> 0) then
    sTrFilter := 'IDTreatment = ' + IntToStr(scTreatment.EditValue)
  else
    sTrFilter := 'IDTreatment = -1';
  scTreatmentLot.ApplyFilters(sTrFilter);

  if (DataSet.State in dsEditModes) then
  begin
    scTreatmentLot.EditValue := Null;
    DataSet.FieldByName('IDTreatmentLot').Value := Null;
  end;

end;

procedure TPctPetTreatmentFch.ConfigFchAfterStart(Sender: TObject);
begin

  scSystemUser.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, '');
  scTreatment.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Treatment;');
  scTreatmentLot.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, '');
  scPet.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Puppy;');
  inherited;
  ApplyTreatmentFilter;

end;

procedure TPctPetTreatmentFch.scTreatmentPropertiesChange(Sender: TObject);
begin
  inherited;
  ApplyTreatmentFilter;
end;

procedure TPctPetTreatmentFch.FormShow(Sender: TObject);
begin
  inherited;
  scPet.Locked := (ActionType <> atAppend) or (not DataSet.FieldByName('IDPet').IsNull);
  scPet.Visible := not scPet.Locked;
end;

procedure TPctPetTreatmentFch.ConfigFchBeforeApplyChanges(Sender: TObject;
  var Apply: Boolean);
begin
  inherited;
  DataSet.FieldByName('SystemUser').Value := scSystemUser.EditingText;
  DataSet.FieldByName('LotNumber').Value := scTreatmentLot.EditingText;
  DataSet.FieldByName('Treatment').Value := scTreatment.EditingText;
end;

procedure TPctPetTreatmentFch.scTreatmentLotPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;

  if not (DataSet.State in [dsInactive, dsBrowse]) and (scTreatmentLot.EditValue <> Null) then
    DataSet.FieldByName('ExpirationDate').Value  := scTreatmentLot.GetFieldValue('ExpirationDate');
  
end;

procedure TPctPetTreatmentFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;
  DataSet.FieldByName('DosesUsed').AsInteger := 1;
  DataSet.FieldByName('TreatmentDate').AsDateTime := Now;
  DataSet.FieldByName('IDUser').Value := DMPet.SystemUser.ID;
end;

initialization
  RegisterClass(TPctPetTreatmentFch);


end.
