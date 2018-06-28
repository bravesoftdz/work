unit uWaitForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons;

type
  TWaitForm = class(TForm)
    Animate1: TAnimate;
    Label1: TLabel;
    BtnAbort: TSpeedButton;
    procedure BtnAbortMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(bShowCancel:Boolean):Boolean; 
  end;

var
  WaitForm: TWaitForm;

implementation

uses PaideBrowses, PaideFichas, uDMGlobal;

{$R *.DFM}

function TWaitForm.Start(bShowCancel:Boolean):Boolean;
begin

   BtnAbort.Visible := bShowCancel;

   Show;

end;

procedure TWaitForm.BtnAbortMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin

  Screen.Cursor := crDefault;
  Application.ProcessMessages;

end;

end.
