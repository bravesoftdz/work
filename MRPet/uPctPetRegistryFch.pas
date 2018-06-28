unit uPctPetRegistryFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, mrSuperCombo, StdCtrls;

type
  TPctPetRegistryFch = class(TParentButtonFch)
    edtRegistryNum: TmrDBEdit;
    scRegistry: TmrDBSuperCombo;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure ConfigFchBeforeApplyChanges(Sender: TObject;
      var Apply: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, uParentCustomFch, mrMsgBox, uSystemTypes;

{$R *.dfm}

procedure TPctPetRegistryFch.ConfigFchAfterStart(Sender: TObject);
begin
  inherited;
  scRegistry.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Registry;');
end;

procedure TPctPetRegistryFch.ConfigFchBeforeApplyChanges(Sender: TObject;
  var Apply: Boolean);
begin
  inherited;

  if (ActionType = atAppend) and DMPet.PetCenterConn.AppServer.PetRegistryExist(DataSet.FieldByName('IDPet').AsInteger, DataSet.FieldByName('IDRegistry').AsInteger) then
  begin
    MsgBox('Puppy already has an entry for this registry', vbInformation + vbOKOnly);
    Apply := False;
    Exit;
  end;

  DataSet.FieldByName('Registry').Value := scRegistry.EditingText;
end;

initialization
  RegisterClass(TPctPetRegistryFch);


end.
