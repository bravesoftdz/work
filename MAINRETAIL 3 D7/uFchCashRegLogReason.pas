unit uFchCashRegLogReason;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, DB, StdCtrls, Mask, DBCtrls, FormConfig, ADODB,
  PowerADOQuery, siComp, siLangRT, Buttons, LblEffct, ExtCtrls;

type
  TFchCashRegLogReason = class(TbrwFrmParent)
    lblReason: TLabel;
    edtReason: TDBEdit;
    quFormIDCashRegLogReason: TIntegerField;
    quFormReason: TStringField;
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
