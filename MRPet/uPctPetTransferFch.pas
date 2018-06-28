unit uPctPetTransferFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, StdCtrls, XiButton, ExtCtrls,
  cxDropDownEdit, cxCalendar, cxDBEdit, mrDBDateEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, mrSuperCombo;

type
  TPctPetTransferFch = class(TParentButtonFch)
    scStoreFrom: TmrDBSuperCombo;
    cdStoreTo: TmrDBSuperCombo;
    edtWhelpDate: TmrDBDateEdit;
    scSystemUser: TmrDBSuperCombo;
    scPet: TmrDBSuperCombo;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure ConfigFchBeforeApplyChanges(Sender: TObject;
      var Apply: Boolean);
    procedure ConfigFchAfterAppend(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure scPetStartSearch(Sender: TObject; var Params: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, uDMMaintenance, uParentCustomFch, uSystemTypes,
     mrMsgBox, uClasseFunctions, uParentModalForm;


{$R *.dfm}

procedure TPctPetTransferFch.ConfigFchAfterStart(Sender: TObject);
begin

  scSystemUser.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, '');
  scStoreFrom.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Store;');
  cdStoreTo.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Store;');
  scPet.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Puppy;');

  inherited;
  
end;

procedure TPctPetTransferFch.ConfigFchBeforeApplyChanges(Sender: TObject;
  var Apply: Boolean);
begin
  inherited;
  
  if (DataSet.FieldByName('IDStoreSource').AsInteger = DataSet.FieldByName('IDStoreDest').AsInteger) then
  begin
    MsgBox('Stores cannot be the same!', vbInformation + vbOKOnly);
    Apply := False;
    Exit;
  end;

  if (DataSet.FieldByName('IDStoreSource').AsInteger <> DMPet.GetPropertyDomain('PctDefaultStore')) then
  begin
    MsgBox('You cannot transfer puppy from other stores!', vbInformation + vbOKOnly);
    Apply := False;
    Exit;
  end;


end;

procedure TPctPetTransferFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;
  DataSet.FieldByName('IDStoreSource').Value     := DMPet.GetPropertyDomain('PctDefaultStore');
  DataSet.FieldByName('IDUser').Value            := DMPet.SystemUser.ID;
  DataSet.FieldByName('TransferDate').AsDateTime := Trunc(Now);
end;

procedure TPctPetTransferFch.FormShow(Sender: TObject);
begin
  inherited;

  if (ActionType = atAppend) then
    scPet.ApplyFilters('IDStore = ' + VarToStr(DMPet.GetPropertyDomain('PctDefaultStore')))
  else
    scPet.ApplyFilters('');

  scStoreFrom.Locked := True;

end;

procedure TPctPetTransferFch.scPetStartSearch(Sender: TObject;
  var Params: String);
begin
  inherited;

  Params := 'IDStore=' + VarToStr(DMPet.GetPropertyDomain('PctDefaultStore')) +';';
  
end;

initialization
  RegisterClass(TPctPetTransferFch);


end.
