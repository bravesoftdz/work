unit uPrinting;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, siComp, siLangRT, PaiDeForms;

type
  TFrmPrinting = class(TFrmParentForms)
    Label1: TLabel;
    Panel1: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrinting: TFrmPrinting;

implementation

uses uDMGlobal, uMsgBox, uMsgConstant;

{$R *.DFM}

procedure TFrmPrinting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
