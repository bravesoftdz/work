unit USError2;

interface

uses
  SysUtils, Forms, Buttons, ExtCtrls, StdCtrls, Controls,
  Classes, Graphics;

type
  TCrpeErrorDlg = class(TForm)
    pnlError: TPanel;
    lblTitle: TLabel;
    lblErrorNumber: TLabel;
    btnContinue: TBitBtn;
    btnAbort: TBitBtn;
    btnHandle: TBitBtn;
    GreenOff: TSpeedButton;
    GreenOn: TSpeedButton;
    RedOff: TSpeedButton;
    RedOn: TSpeedButton;
    YellowOff: TSpeedButton;
    YellowOn: TSpeedButton;
    memoErrorString: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnContinueMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnAbortMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnHandleMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    LEDcnt : integer;
  end;

var
  CrpeErrorDlg: TCrpeErrorDlg;

implementation

{$R *.DFM}

procedure TCrpeErrorDlg.FormShow(Sender: TObject);
begin
  LEDcnt := -1;
end;

procedure TCrpeErrorDlg.btnContinueMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if LEDcnt <> 1 then
  begin
    btnContinue.Glyph := GreenOn.Glyph;
    btnAbort.Glyph := RedOff.Glyph;
    btnHandle.Glyph := YellowOff.Glyph;
    LEDcnt := 1;
  end;
end;

procedure TCrpeErrorDlg.btnAbortMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if LEDcnt <> 2 then
  begin
    btnContinue.Glyph := GreenOff.Glyph;
    btnAbort.Glyph := RedOn.Glyph;
    btnHandle.Glyph := YellowOff.Glyph;
    LEDcnt := 2;
  end;
end;

procedure TCrpeErrorDlg.btnHandleMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if LEDcnt <> 3 then
  begin
    btnContinue.Glyph := GreenOff.Glyph;
    btnAbort.Glyph := RedOff.Glyph;
    btnHandle.Glyph := YellowOn.Glyph;
    LEDcnt := 3;
  end;
end;

procedure TCrpeErrorDlg.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if LEDcnt <> -1 then
  begin
    btnContinue.Glyph := GreenOff.Glyph;
    btnAbort.Glyph := RedOff.Glyph;
    btnHandle.Glyph := YellowOff.Glyph;
    LEDcnt := -1;
  end;
end;

procedure TCrpeErrorDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;


end.
