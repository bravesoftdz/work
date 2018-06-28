unit uPctRegistryFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit, StdCtrls,
  mrSubListPanel, uMRSQLParam, uNTUpdateControl;

type
  TPctRegistryFch = class(TParentButtonFch)
    edtRegistry: TmrDBEdit;
    slpRegistrySpecies: TmrSubListPanel;
    procedure FormShow(Sender: TObject);
    procedure ConfigFchAfterNavigation(Sender: TObject);
    procedure slpRegistrySpeciesGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpRegistrySpeciesGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpRegistrySpeciesGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpRegistrySpeciesStateChange(Sender: TObject);
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ConfigFchAfterAppend(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet;

{$R *.dfm}

procedure TPctRegistryFch.FormShow(Sender: TObject);
begin
  inherited;
  slpRegistrySpecies.RefreshSubList;
end;

procedure TPctRegistryFch.ConfigFchAfterNavigation(Sender: TObject);
begin
  inherited;
  slpRegistrySpecies.RefreshSubList;
end;

procedure TPctRegistryFch.slpRegistrySpeciesGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('RS.IDRegistry').AsInteger := DataSet.FieldByName('IDRegistry').AsInteger;
    KeyByName('RS.IDRegistry').Condition := tcEquals;
  end;

end;

procedure TPctRegistryFch.slpRegistrySpeciesGetForeignKeyValue(
  Sender: TObject; var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDRegistry').AsInteger := DataSet.FieldByName('IDRegistry').AsInteger;
    KeyByName('IDRegistry').Condition := tcEquals;
  end;

end;

procedure TPctRegistryFch.slpRegistrySpeciesGetTransaction(Sender: TObject;
  var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctRegistryFch.slpRegistrySpeciesStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctRegistryFch.ConfigFchAfterStart(Sender: TObject);
begin

  slpRegistrySpecies.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Species;');
  inherited;

end;

procedure TPctRegistryFch.FormDestroy(Sender: TObject);
begin
  slpRegistrySpecies.FreeSubList;
  inherited;

end;

procedure TPctRegistryFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;
  slpRegistrySpecies.RefreshSubList;
end;

initialization
  RegisterClass(TPctRegistryFch);

end.
