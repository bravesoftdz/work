unit uFrmImportPreSale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, StdCtrls, siComp, siLangRT, Buttons, ExtCtrls, DB, ADODB;

type
  TFrmImportPreSale = class(TFrmPai)
    btnOK: TButton;
    lbHoldNum: TLabel;
    edtHold: TEdit;
  private
  public
    function Start:String;
  end;

implementation

uses uDM;

{$R *.dfm}

{ TFrmImportPreSale }

function TFrmImportPreSale.Start: String;
begin
  edtHold.Clear;
  ShowModal;
  Result := edtHold.Text;
end;

end.
