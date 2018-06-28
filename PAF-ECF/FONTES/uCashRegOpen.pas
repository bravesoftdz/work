unit uCashRegOpen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiCashRegOpen, ExtCtrls, StdCtrls, Buttons, Mask, SuperComboADO,
  siComp, siLangRT, DBCtrls;

type
  TCashRegOpen = class(TFrmPaiCashRegOpen)
  private
    { Private declarations }
  protected
    function TestBeforeOpen:Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses uDM, uNumericFunctions, uMsgBox;

{$R *.dfm}

function TCashRegOpen.TestBeforeOpen:Boolean;
begin
  Result := True;

  begin
    if (DM.fCashRegister.GeneratePAFSintegra) and (not DM.EFiscal1.VerificaImpressoraLigada) then
    begin
      MsgBox('Impressora Desligada ou Desconectada',  vbCritical + vbOkOnly);
      Result := False;
      Exit;
    end;

    Result := DM.EFiscal1.AbreDiaFiscal(Date, TotCashGeral, lblUserName.Caption);
  end;
  
end;

end.

