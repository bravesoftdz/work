unit uPctMedicalConditionSpeciesFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo, StdCtrls;

type
  TPctMedicalConditionSpeciesFch = class(TParentButtonFch)
    scSpecies: TmrDBSuperCombo;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure ConfigFchBeforeApplyChanges(Sender: TObject;
      var Apply: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPet;

{$R *.dfm}

procedure TPctMedicalConditionSpeciesFch.ConfigFchAfterStart(
  Sender: TObject);
begin

  scSpecies.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Species;');
  inherited;

end;

procedure TPctMedicalConditionSpeciesFch.ConfigFchBeforeApplyChanges(
  Sender: TObject; var Apply: Boolean);
begin
  inherited;
  DataSet.FieldByName('Species').Value := scSpecies.EditingText;
end;

initialization
  RegisterClass(TPctMedicalConditionSpeciesFch);


end.
