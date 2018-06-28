unit uPctMedicalConditionFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit,
  mrSubListPanel, uMRSQLParam, uNTUpdateControl, StdCtrls;

type
  TPctMedicalConditionFch = class(TParentButtonFch)
    edtMedicalCondition: TmrDBEdit;
    slpMedicalCondSpecies: TmrSubListPanel;
    edtSubMedicalCondition: TmrDBEdit;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure slpMedicalCondSpeciesGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpMedicalCondSpeciesGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpMedicalCondSpeciesGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpMedicalCondSpeciesStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConfigFchAfterNavigation(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ConfigFchAfterAppend(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, uDMMaintenance, uParentCustomFch;


{$R *.dfm}

procedure TPctMedicalConditionFch.ConfigFchAfterStart(Sender: TObject);
begin
  slpMedicalCondSpecies.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Species;');
  inherited;
end;

procedure TPctMedicalConditionFch.slpMedicalCondSpeciesGetFilter(
  Sender: TObject; var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('MCS.IDMedicalCondition').AsInteger := DataSet.FieldByName('IDMedicalCondition').AsInteger;
    KeyByName('MCS.IDMedicalCondition').Condition := tcEquals;
  end;

end;

procedure TPctMedicalConditionFch.slpMedicalCondSpeciesGetForeignKeyValue(
  Sender: TObject; var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDMedicalCondition').AsInteger := DataSet.FieldByName('IDMedicalCondition').AsInteger;
    KeyByName('IDMedicalCondition').Condition := tcEquals;
  end;

end;

procedure TPctMedicalConditionFch.slpMedicalCondSpeciesGetTransaction(
  Sender: TObject; var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctMedicalConditionFch.slpMedicalCondSpeciesStateChange(
  Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctMedicalConditionFch.FormShow(Sender: TObject);
begin
  inherited;
  slpMedicalCondSpecies.RefreshSubList;
end;

procedure TPctMedicalConditionFch.ConfigFchAfterNavigation(
  Sender: TObject);
begin
  inherited;
  slpMedicalCondSpecies.RefreshSubList;
end;

procedure TPctMedicalConditionFch.FormDestroy(Sender: TObject);
begin
  slpMedicalCondSpecies.FreeSubList;
  inherited;

end;

procedure TPctMedicalConditionFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;
  slpMedicalCondSpecies.RefreshSubList;
end;

initialization
  RegisterClass(TPctMedicalConditionFch);


end.
