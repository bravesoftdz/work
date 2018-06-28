unit uFchPet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, DBCtrls, Mask,
  SuperComboADO, DateBox;

type
  TFchPet = class(TbrwFrmParent)
    quFormIDPet: TIntegerField;
    quFormName: TStringField;
    quFormSex: TStringField;
    quFormIDSpecies: TIntegerField;
    quFormIDPorte: TIntegerField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Sex: TDBRadioGroup;
    Label35: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    scRace: TDBSuperComboADO;
    scSpecies: TDBSuperComboADO;
    scPorte: TDBSuperComboADO;
    quFormIDBreed: TIntegerField;
    quFormWhelpDate: TDateTimeField;
    dxDBDateEdit3: TDBDateBox;
    lbDOB: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uSystemConst;

{$R *.dfm}

procedure TFchPet.FormCreate(Sender: TObject);
begin
  inherited;

  if (DM.fSystem.SrvParam[PARAM_PUPPY_TRACKER_INTEGRATION] <> '') or
     (DM.fSystem.SrvParam[PARAM_PETCENTER_INTEGRATION] <> '') then
  begin
    scSpecies.ShowBtnAddNew := False;
    scSpecies.ShowBtnUpdate := False;
    scRace.ShowBtnAddNew    := False;
    scRace.ShowBtnUpdate    := False;
    scPorte.ShowBtnAddNew   := False;
    scPorte.ShowBtnUpdate   := False;
  end
  else
  begin
    scSpecies.ShowBtnAddNew := True;
    scSpecies.ShowBtnUpdate := True;
    scRace.ShowBtnUpdate    := True;
    scRace.ShowBtnAddNew    := True;
    scPorte.ShowBtnAddNew   := True;
    scPorte.ShowBtnUpdate   := True;
  end;
  
end;

end.
