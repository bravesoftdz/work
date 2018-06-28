unit uPctPetMedicalConditionFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, StdCtrls, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo,
  cxCalendar, cxDBEdit, mrDBDateEdit, cxMemo, mrDBMemo, uSystemTypes;

type
  TPctPetMedicalConditionFch = class(TParentButtonFch)
    scPet: TmrDBSuperCombo;
    scSystemUser: TmrDBSuperCombo;
    scMedicalCondition: TmrDBSuperCombo;
    memNotes: TmrDBMemo;
    edtRecordDate: TmrDBDateEdit;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConfigFchBeforeApplyChanges(Sender: TObject;
      var Apply: Boolean);
    procedure ConfigFchAfterAppend(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, uParentCustomFch, uParentSearchForm;

{$R *.dfm}

procedure TPctPetMedicalConditionFch.ConfigFchAfterStart(Sender: TObject);
begin
  scSystemUser.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, '');
  scPet.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Puppy;');
  scMedicalCondition.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Medical Condition;');
  inherited;

end;

procedure TPctPetMedicalConditionFch.FormShow(Sender: TObject);
begin
  inherited;

  scPet.Locked := (ActionType <> atAppend) or (not DataSet.FieldByName('IDPet').IsNull);
  scPet.Visible := not scPet.Locked;

end;

procedure TPctPetMedicalConditionFch.ConfigFchBeforeApplyChanges(
  Sender: TObject; var Apply: Boolean);
begin
  inherited;
  DataSet.FieldByName('MedicalCondition').Value := Copy(scMedicalCondition.EditingText, 0, Pos('-', scMedicalCondition.EditingText)-1);
  DataSet.FieldByName('SubMedicalCondition').Value := Copy(scMedicalCondition.EditingText, Pos('-', scMedicalCondition.EditingText)+1, Length(scMedicalCondition.EditingText));
  DataSet.FieldByName('SystemUser').Value := scSystemUser.EditingText;
end;

procedure TPctPetMedicalConditionFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;
  DataSet.FieldByName('IDUser').Value := DMPet.SystemUser.ID;
end;

initialization
  RegisterClass(TPctPetMedicalConditionFch);

end.
