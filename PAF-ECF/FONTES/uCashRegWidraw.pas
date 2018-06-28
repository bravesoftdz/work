unit uCashRegWidraw;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiCashRegWidraw, StdCtrls, Buttons, ExtCtrls, siComp, siLangRT,
  DBCtrls;

type
  TCashRegWidraw = class(TFrmPaiCashRegWidraw)
  private
    { Private declarations }
  protected
    function TestBeforeDeposit:Boolean; override;
  public
    { Public declarations }
  end;

var
  CashRegWidraw: TCashRegWidraw;

implementation

uses uDM;

{$R *.dfm}

function TCashRegWidraw.TestBeforeDeposit:Boolean;
begin
    Result := DM.fModuloFiscal.ValidateSystemDate
end;

end.
