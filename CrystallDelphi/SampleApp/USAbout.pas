unit USAbout;

interface

uses
  Windows, Classes, Graphics, Forms, Controls, StdCtrls, Buttons,
  ExtCtrls, ComCtrls;

type
  TCrpeAboutBoxSA = class(TForm)
    pnlAbout: TPanel;
    lblProductName: TLabel;
    lblVersion: TLabel;
    lblAuthor: TLabel;
    lblCompany: TLabel;
    lblAddress: TLabel;
    pnlCrystalIcon: TPanel;
    bmpCrystalIcon: TImage;
    lblProductName2: TLabel;
    Animate1: TAnimate;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlAboutClick(Sender: TObject);
    procedure bmpCrystalIconMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure bmpCrystalIconMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CrpeAboutBoxSA: TCrpeAboutBoxSA;

implementation

{$R *.DFM}
{$R AviCol1.RES}

procedure TCrpeAboutBoxSA.FormShow(Sender: TObject);
begin
  Animate1.ResName := 'IDS_AVI_HWORLD';
  Animate1.ResHandle := hInstance;
  Animate1.Active := False;
  Animate1.AutoSize := False;
  Animate1.StartFrame := 2;
  Animate1.StopFrame := 13;
  Animate1.Timers := True;
  Animate1.Transparent := True;
end;

procedure TCrpeAboutBoxSA.bmpCrystalIconMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  bmpCrystalIcon.SendToBack;
  bmpCrystalIcon.Visible := False;
  Animate1.Visible := True;
  Animate1.BringToFront;
  Animate1.Active := True;
end;

procedure TCrpeAboutBoxSA.bmpCrystalIconMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Animate1.Active := False;
  Animate1.SendToBack;
  Animate1.Visible := False;
  bmpCrystalIcon.Visible := True;
  bmpCrystalIcon.BringToFront;
end;

procedure TCrpeAboutBoxSA.pnlAboutClick(Sender: TObject);
begin
  Close;
end;

procedure TCrpeAboutBoxSA.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;

end.

