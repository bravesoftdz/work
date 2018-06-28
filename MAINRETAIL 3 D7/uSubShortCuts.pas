unit uSubShortCuts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, Buttons, StdCtrls, ExtCtrls, siComp, siLangRT;

type
  TSubShortCuts = class(TParentSub)
    Panel11: TPanel;
    Panel12: TPanel;
    Shape6: TShape;
    Label12: TLabel;
    sbShowShotCuts: TSpeedButton;
    pnlShortCutInv: TPanel;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SubShortCuts: TSubShortCuts;

implementation

{$R *.dfm}

initialization
   RegisterClass(TSubShortCuts);


end.
