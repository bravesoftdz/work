unit uFchInventoryReason;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchInventoryReason = class(TbrwFrmParent)
    quFormIDMovReason: TIntegerField;
    quFormReason: TStringField;
    quFormSystem: TBooleanField;
    quFormHidden: TBooleanField;
    quFormDesativado: TBooleanField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label35: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses uDM;

{$R *.dfm}

end.
