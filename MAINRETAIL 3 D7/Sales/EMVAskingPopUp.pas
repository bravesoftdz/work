unit EMVAskingPopUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TviewEMVAsking = class(TForm)
    labelTimeOut: TLabel;
    buttonClose: TBitBtn;
    buttonManual: TBitBtn;
    buttonSwipe: TBitBtn;
    procedure buttonCloseClick(Sender: TObject);
  private
    { Private declarations }
    actionSelected: Integer;
  public
    { Public declarations }
    function Start(): Integer;
  end;

var
  viewEMVAsking: TviewEMVAsking;

implementation

{$R *.dfm}

{ TviewEMVAsking }

function TviewEMVAsking.Start: Integer;
begin
  showModal();

  result := actionSelected;


end;

procedure TviewEMVAsking.buttonCloseClick(Sender: TObject);
begin
   actionSelected := (sender as TButton).Tag;
end;

end.
