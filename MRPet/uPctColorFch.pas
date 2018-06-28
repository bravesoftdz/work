unit uPctColorFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentButtonFch, mrConfigFch, DB, StdCtrls, XiButton, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit, mrDBEdit,
  mrSubListPanel, uMRSQLParam, uNTUpdateControl;

type
  TPctColorFch = class(TParentButtonFch)
    edtCode: TmrDBEdit;
    slpColorSpecies: TmrSubListPanel;
    procedure ConfigFchAfterStart(Sender: TObject);
    procedure slpColorSpeciesGetFilter(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpColorSpeciesGetForeignKeyValue(Sender: TObject;
      var Filter: TMRSQLParam);
    procedure slpColorSpeciesGetTransaction(Sender: TObject;
      var ATransaction: TmrTransaction);
    procedure slpColorSpeciesStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConfigFchAfterAppend(Sender: TObject);
    procedure ConfigFchAfterNavigation(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDMPetCenter, uDMPet, uDMMaintenance, uParentCustomFch;

{$R *.dfm}

procedure TPctColorFch.ConfigFchAfterStart(Sender: TObject);
begin
  slpColorSpecies.CreateSubList(TraceControl, DataSetControl, UpdateControl, Session, DMPet.SystemUser, 'MenuDisplay=Color;');
  inherited;
end;

procedure TPctColorFch.slpColorSpeciesGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('PC.IDColor').AsInteger := DataSet.FieldByName('IDColor').AsInteger;
    KeyByName('PC.IDColor').Condition := tcEquals;
  end;

end;

procedure TPctColorFch.slpColorSpeciesGetForeignKeyValue(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;

  with Filter do
  begin
    AddKey('IDColor').AsInteger := DataSet.FieldByName('IDColor').AsInteger;
    KeyByName('IDColor').Condition := tcEquals;
  end;

end;

procedure TPctColorFch.slpColorSpeciesGetTransaction(Sender: TObject;
  var ATransaction: TmrTransaction);
begin
  inherited;
  ATransaction := Transaction;
end;

procedure TPctColorFch.slpColorSpeciesStateChange(Sender: TObject);
begin
  inherited;
  DataSet.Edit;
end;

procedure TPctColorFch.FormShow(Sender: TObject);
begin
  inherited;
  slpColorSpecies.RefreshSubList;
end;

procedure TPctColorFch.ConfigFchAfterAppend(Sender: TObject);
begin
  inherited;
  slpColorSpecies.RefreshSubList;
end;

procedure TPctColorFch.ConfigFchAfterNavigation(Sender: TObject);
begin
  inherited;
  slpColorSpecies.RefreshSubList;
end;

procedure TPctColorFch.FormDestroy(Sender: TObject);
begin
  slpColorSpecies.FreeSubList;
  inherited;
end;

initialization
  RegisterClass(TPctColorFch);

end.
