unit uSistemInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFrmError = class(TForm)
    btnClose: TButton;
    memSummary: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(Value:string):Boolean;
  end;

implementation

{$R *.DFM}

function TFrmError.Start(Value:string):Boolean;
begin
    memSummary.Clear;
    memSummary.Lines.Add(Value);
    memSummary.SelLength := 0;
    memSummary.SelStart  := 0;
    ShowModal;

end;

procedure TFrmError.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
end;

end.


