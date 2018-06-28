unit uFrmPCCSwipeCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmPCCSwipeCard = class(TForm)
    edtTrack: TEdit;
    Animate1: TAnimate;
    Label1: TLabel;
    btnDefault: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
  private
    FIDMeioPag : Integer;
    FTrack: WideString;
  public
    { Public declarations }
    function Start(var ATrack: WideString;  var AIDMeioPag : Integer): Boolean;
  end;


implementation

uses uDM;

{$R *.dfm}

{ TfrmPCCSwipeCard }

function TfrmPCCSwipeCard.Start(var ATrack: WideString; var AIDMeioPag : Integer): Boolean;
begin
  FTrack := '';
  AIDMeioPag := -1;
  ShowModal;
  //Result := ModalResult = mrOK;
  Result     := True;
  ATrack     := FTrack;
  AIDMeioPag := FIDMeioPag;
end;

procedure TfrmPCCSwipeCard.FormShow(Sender: TObject);
var
  appDir: string;
begin
  appDir := ExtractFilePath(Application.ExeName);
  if FileExists(appDir + 'swipe.avi') then
  begin
    Animate1.FileName := appDir + 'swipe.avi';
    Animate1.Active := True;
  end;
end;

procedure TfrmPCCSwipeCard.btnDefaultClick(Sender: TObject);
begin
  FTrack := edtTrack.Text;
  FIDMeioPag := DM.fPCCharge.IdentifySwipedCard(FTrack);
  ModalResult := mrOk;
  Close;
end;

end.
