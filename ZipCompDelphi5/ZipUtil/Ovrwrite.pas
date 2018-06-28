unit Ovrwrite;

{ $Log: }

interface

uses
{$IFDEF WIN32}
  Windows,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
	OverwriteAction = (oaOverwrite, oaSkip, oaRename);
	TOverwriteDlg = class(TForm)
    YesBtn: TButton;
    NoBtn: TButton;
    RenameBtn: TButton;
    Label1: TLabel;
    FName: TLabel;
    Label3: TLabel;
    procedure OnBtnClick(Sender: TObject);
	private
	  { Private declarations }
	public
    { Public declarations }
	  Action: OverwriteAction;
  end;

var
	OverwriteDlg: TOverwriteDlg;

implementation

{$R *.DFM}

procedure TOverwriteDlg.OnBtnClick(Sender: TObject);
begin
	Case (Sender as TButton).Tag of
		1:	Action := oaOverwrite;
		2:	Action := oaSkip;
		3: Action := oaRename;
	end;
	Close;
end;

end.
