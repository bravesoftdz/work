unit TagQtyPriceBreakViewEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, ADODB, db, DbClient;

type
  TfrmTagQtyPriceBreak = class(TFrmParentAll)
    Label1: TLabel;
    Label2: TLabel;
    cedPrice: TcxCurrencyEdit;
    cedQty: TcxCurrencyEdit;
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    fOper: String;
    fIdTag: Integer;
    procedure cleanUpScreen();
  public
    { Public declarations }
    function start(arg_idTag: Integer; arg_oper: String = 'I'): Boolean;
  end;

implementation
uses uDM;

{$R *.dfm}

{ TfrmTagQtyPriceBreak }

function TfrmTagQtyPriceBreak.start(arg_idTag: Integer; arg_oper: String = 'I'): Boolean;
begin
  fOper := arg_oper;
  if ( arg_oper = 'I' ) then begin
     cleanUpScreen;

  end;

  fIdTag := arg_idTag;
  showModal;
  result := true;
end;

procedure TfrmTagQtyPriceBreak.btCloseClick(Sender: TObject);
begin
  dm.callSpTagQtyPriceBreakUpSert((cedPrice.EditValue/100), fIdTag, cedQty.EditValue);
  inherited;
  close;
end;

procedure TfrmTagQtyPriceBreak.cleanUpScreen;
begin
  cedQty.Value := 0;
  cedPrice.Value := 0.00;
end;


end.
