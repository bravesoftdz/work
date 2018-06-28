unit uMainWebFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentForm, ExtCtrls, OleCtrls, SHDocVw, XiButton;

type
  TMainWebFrm = class(TParentForm)
    pnlImage: TPanel;
    Image1: TImage;
    imgScreen: TImage;
    Image2: TImage;
    Shape1: TShape;
    WebBrowser: TWebBrowser;
    btnHome: TXiButton;
    procedure btnHomeClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DisplayWeb(Web : String);
  end;

implementation

{$R *.dfm}

{ TMainWebFrm }

procedure TMainWebFrm.DisplayWeb(Web: String);
begin
  if Web <> '' then
  begin
    WebBrowser.Navigate(Web);
  end
  else
    WebBrowser.Navigate('about:blank');

end;

procedure TMainWebFrm.btnHomeClick(Sender: TObject);
begin
  inherited;
  DisplayWeb('');
end;

initialization
  RegisterClass(TMainWebFrm);

end.
