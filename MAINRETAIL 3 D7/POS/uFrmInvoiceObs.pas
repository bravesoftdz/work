unit uFrmInvoiceObs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPai, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TFrmInvoiceObs = class(TFrmPai)
    memOBS: TMemo;
    Label1: TLabel;
    btnOK: TButton;
  private
    { Private declarations }
  public
    function Start(OBS:String):String;
  end;

implementation

{$R *.dfm}

{ TFrmInvoiceObs }

function TFrmInvoiceObs.Start(OBS: String): String;
begin
   memOBS.Clear;
   memOBS.Lines.Text := Trim(OBS);
   ShowModal;
   Result := Trim(memOBS.Lines.Text);      
end;

end.
