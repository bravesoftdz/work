unit uFchPetSpecies;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchPetSpecies = class(TbrwFrmParent)
    quFormIDSpecies: TIntegerField;
    quFormSpecies: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label35: TLabel;
    quFormSystem: TBooleanField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM;

{$R *.dfm}

end.
