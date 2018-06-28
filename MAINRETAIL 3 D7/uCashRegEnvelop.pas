unit uCashRegEnvelop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, StdCtrls, Mask, ExtCtrls, Buttons, siComp, siLangRT;

type
  TCashRegEnvelop = class(TFrmParentAll)
    Panel5: TPanel;
    Image5: TImage;
    Image8: TImage;
    lblSubTip: TLabel;
    Label1: TLabel;
    EditEnvelop: TEdit;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure EditEnvelopChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(var Envelop : String) : Boolean;
  end;

implementation

uses uDMGlobal;

{$R *.DFM}

function TCashRegEnvelop.Start(var Envelop : String) : Boolean;
begin
  Result := (ShowModal = mrOk);

  if Result then
    Envelop := EditEnvelop.Text;
end;

procedure TCashRegEnvelop.FormShow(Sender: TObject);
begin
  inherited;
  EditEnvelop.Text := '';
  EditEnvelopChange(nil);
  EditEnvelop.SetFocus;
end;

procedure TCashRegEnvelop.EditEnvelopChange(Sender: TObject);
begin
  inherited;
  btClose.Enabled := trim(EditEnvelop.Text) <> '';
end;

procedure TCashRegEnvelop.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
