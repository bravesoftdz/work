unit uFrmMeno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmMemo = class(TForm)
    memInfo: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(sText:String):Boolean;
  end;

implementation

{$R *.dfm}

function TFrmMemo.Start(sText:String):Boolean;
begin
  memInfo.Clear;
  memInfo.Lines.Add(sText);
  memInfo.SelStart := 0;

  ShowModal;

end;

procedure TFrmMemo.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmMemo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
