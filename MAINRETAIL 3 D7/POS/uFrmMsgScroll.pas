unit uFrmMsgScroll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentAll, siComp, siLangRT, StdCtrls, Buttons;

type
  TFrmMsgScroll = class(TFrmParentAll)
    btnClose: TBitBtn;
    memMessage: TMemo;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    function Start(msg : String) : Boolean;
  end;

implementation

{$R *.dfm}

{ TFrmMsgScroll }

function TFrmMsgScroll.Start(msg : String): Boolean;
begin
  memMessage.Clear;
  memMessage.Lines.Text := msg;
  memMessage.SelStart := 0;
  memMessage.SelLength := 0;
  ShowModal;
end;

procedure TFrmMsgScroll.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmMsgScroll.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
