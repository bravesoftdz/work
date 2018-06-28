unit uFrmNewMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, uFrmUserMessager;

type
  TFrmNewMessage = class(TForm)
    imgMessage: TImage;
    pnlTop: TPanel;
    imgClose: TImage;
    lbNumMessage: TLabel;
    procedure imgCloseClick(Sender: TObject);
    procedure imgMessageClick(Sender: TObject);
    procedure pnlTopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    sMessage,
    sInbox : String;
  public
    function Start(Num:Integer):Boolean;
    procedure MessageHide;
  end;

implementation

uses uDMGlobal, uDM, uPassword;

{$R *.dfm}

{ TFrmNewMessage }

function TFrmNewMessage.Start(Num : Integer): Boolean;
begin
   pnlTop.Caption       := sMessage;
   lbNumMessage.Caption := Format(sInbox, [Num]);
   Show;
   Result := True;
end;

procedure TFrmNewMessage.imgCloseClick(Sender: TObject);
begin
   Hide;
end;

procedure TFrmNewMessage.imgMessageClick(Sender: TObject);
begin

  Hide;

  if not DM.fUser.CheckMessage then
    Exit;

  with TFrmUserMessager.Create(Self) do
     Start;

end;

procedure TFrmNewMessage.pnlTopMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
   SC_DragMove = $F012;
begin
   ReleaseCapture;
   Perform(WM_SysCommand, SC_DragMove, 0);
end;


procedure TFrmNewMessage.FormCreate(Sender: TObject);
begin

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sMessage := 'Message';
           sInbox   := '%D new message(s)';
           end;

     LANG_PORTUGUESE :
           begin
           sMessage := 'Mensagem';
           sInbox   := '%D mensagem não lidas';
           end;

     LANG_SPANISH :
           begin
           sMessage := 'Mesaje';
           sInbox   := '%D Mesaje(s)';
           end;
   end;

end;


procedure TFrmNewMessage.MessageHide;
begin
  Hide;
end;

end.
