unit uPctTreatmentFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls, StdCtrls,
  cxMaskEdit, cxDropDownEdit, cxImageComboBox, cxDBEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, mrDBEdit, mrDBImageComboBox,
  mrSubListPanel, uMRSQLParam, uNTUpdateControl, ComCtrls;

type
  TPctTreatmentFch = class(TParentButtonFch)
    edtTreatment: TmrDBEdit;
    cmxTreatmentType: TmrDBImageComboBox;
    edtMfg: TmrDBEdit;
    edtTreatmentLotSize: TmrDBEdit;
    pgTreatment: TPageControl;
    tsEspecies: TTabSheet;
    tsLot: TTabSheet;
    slpTreatmentSpecies: TmrSubListPanel;
    slpTreatmentLot: TmrSubListPanel;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure slpTreatmentSpeciesGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpTreatmentSpeciesGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpTreatmentSpeciesGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpTreatmentSpeciesStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConfigFchAfterNavigation(Sender: TObject);
    procedure slpTreatmentLotGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpTreatmentLotGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpTreatmentLotGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpTreatmentLotStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ConfigFchAfterAppend(Sender: TObject);
  private
    procedure RefreshSub;
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet;

{$R *.dfm}

procedure TPctTreatmentFch.ConfigFchAfterStart(Sender: TObject);
begin

  slpTreatmentSpecies.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Species;');
  slpTreatmentLot.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Treatment Lot;');
  inherited;

end;

procedure TPctTreatmentFch.slpTreatmentSpeciesGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('TS.IDTreatment').AsInteger := DataSet.FieldByName('IDTreatment').AsInteger;
    KeyByName('TS.IDTreatment').Condition := tcEquals;
  end;

end;

procedure TPctTreatmentFch.slpTreatmentSpeciesGetForeignKeyValue(
  Sender: TObject; var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDTreatment').AsInteger := DataSet.FieldByName('IDTreatment').AsInteger;
    KeyByName('IDTreatment').Condition := tcEquals;
  end;

end;

procedure TPctTreatmentFch.slpTreatmentSpeciesGetTransaction(
  Sender: TObject; var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctTreatmentFch.slpTreatmentSpeciesStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctTreatmentFch.FormShow(Sender: TObject);
begin
  inherited;
  RefreshSub;
end;

procedure TPctTreatmentFch.ConfigFchAfterNavigation(Sender: TObject);
begin
  inherited;
  RefreshSub;
end;

procedure TPctTreatmentFch.slpTreatmentLotGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('TL.IDTreatment').AsInteger := DataSet.FieldByName('IDTreatment').AsInteger;
    KeyByName('TL.IDTreatment').Condition := tcEquals;
  end;

end;

procedure TPctTreatmentFch.slpTreatmentLotGetForeignKeyValue(
  Sender: TObject; var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDTreatment').AsInteger := DataSet.FieldByName('IDTreatment').AsInteger;
    KeyByName('IDTreatment').Condition := tcEquals;
  end;
  
end;

procedure TPctTreatmentFch.slpTreatmentLotGetTransaction(Sender: TObject;
  var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctTreatmentFch.slpTreatmentLotStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctTreatmentFch.FormDestroy(Sender: TObject);
begin
  slpTreatmentSpecies.FreeSubList;
  slpTreatmentLot.FreeSubList;
  inherited;

end;

procedure TPctTreatmentFch.RefreshSub;
begin

  case pgTreatment.ActivePageIndex of
    0 : slpTreatmentSpecies.RefreshSubList;
    1 : slpTreatmentLot.RefreshSubList;
  end;

end;

procedure TPctTreatmentFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;
  RefreshSub;
end;

initialization
  RegisterClass(TPctTreatmentFch);

end.
