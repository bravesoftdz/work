unit InvPwd;

{ $Log: }

interface

uses
{$IFDEF WIN32}
  Windows,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
  SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons;

type
  TInvalidPwdDlg = class(TForm)
    Label1: TLabel;
    PasswordEdit: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    Filename: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InvalidPwdDlg: TInvalidPwdDlg;

implementation

{$R *.DFM}


end.
 
