unit UCrpeDSAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TCrpeDSAboutDlg = class(TForm)
    btnOk: TButton;
    pnlSidebar: TPanel;
    imgSidebar: TImage;
    lblDescription: TLabel;
    lblSubDescription: TLabel;
    lblVersion: TLabel;
    lblCompany: TLabel;
    lblCopyright: TLabel;
    pnlTitle: TPanel;
    imgTitle: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblCompanyMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblCompanyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CrpeDSAboutDlg : TCrpeDSAboutDlg;
  prevCursor     : TCursor;

implementation

{$R *.DFM}

uses ShellApi;

procedure TCrpeDSAboutDlg.FormCreate(Sender: TObject);
begin
  prevCursor := Screen.Cursor;
end;

procedure TCrpeDSAboutDlg.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Screen.Cursor <> prevCursor then
    Screen.Cursor := prevCursor;
  if lblCompany.Font.Color <> clBlack then
  begin
    lblCompany.Font.Style := [fsBold];
    lblCompany.Font.Color := clBlack;
  end;
end;

procedure TCrpeDSAboutDlg.lblCompanyClick(Sender: TObject);
var
  sTmp: string;
begin
  sTmp := 'http://www.crystaldecisions.com';
  ShellExecute(0, 'open', PChar(sTmp), nil, nil, SW_SHOWNORMAL);
end;

procedure TCrpeDSAboutDlg.lblCompanyMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Screen.Cursor <> crHandPoint then
    prevCursor := Screen.Cursor;
  Screen.Cursor := crHandPoint;
  lblCompany.Font.Style := [fsUnderline, fsBold];
  lblCompany.Font.Color := clBlue;
end;

procedure TCrpeDSAboutDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Release;
end;


end.
