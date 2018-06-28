unit uPctPetMicrochipFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls, cxDBEdit,
  mrDBEdit, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  mrSuperCombo, StdCtrls;

type
  TPctPetMicrochipFch = class(TParentButtonFch)
    scMicrochip: TmrDBSuperCombo;
    edtMicrochipNum: TmrDBEdit;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure ConfigFchBeforeApplyChanges(Sender: TObject;
      var Apply: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, mrMsgBox;

{$R *.dfm}

procedure TPctPetMicrochipFch.ConfigFchAfterStart(Sender: TObject);
begin
  inherited;
  scMicrochip.CreateListSource(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Registry;');
end;

procedure TPctPetMicrochipFch.ConfigFchBeforeApplyChanges(Sender: TObject;
  var Apply: Boolean);
begin
  inherited;

  if DMPet.PetCenterConn.AppServer.MicrochipExist(edtMicrochipNum.Text) then
  begin
    MsgBox('Microchip already exist!', vbInformation + vbOKOnly);
    Apply := False;
    Exit;
  end;

  DataSet.FieldByName('Microchip').Value := scMicrochip.EditingText;
end;

initialization
  RegisterClass(TPctPetMicrochipFch);


end.
