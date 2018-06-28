unit uSisSegurancaFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TSisSegurancaFrm = class(TForm)
    avi: TAnimate;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


procedure TSisSegurancaFrm.FormShow(Sender: TObject);
begin
     Caption := Application.Title;
     avi.Active := True;
end;

procedure TSisSegurancaFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     avi.Active := False;
end;

end.
