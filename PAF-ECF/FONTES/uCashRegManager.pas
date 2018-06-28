unit uCashRegManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiCashRegManager, ExtCtrls, StdCtrls, Buttons, siComp, siLangRT;

type
  TCashRegManager = class(TFrmPaiCashRegManager)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CashRegManager: TCashRegManager;

implementation

{$R *.dfm}

end.
