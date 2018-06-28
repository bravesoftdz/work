unit Comment;

{ $Log:  d:\proj\unzip\archives\COMMENT.UFV 
{
{   Rev 1.2    Wed 21 Jan 1998   21:30:38  Kevin Boylan    Version: 2.00 Beta 2
{ Begin logging change history
}

interface

uses
{$IFDEF WIN32}
	Windows,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}
	SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TCommentEditor = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    CommentMemo: TMemo;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CommentEditor: TCommentEditor;

implementation

{$R *.DFM}

procedure TCommentEditor.FormActivate(Sender: TObject);
begin
  CommentMemo.SetFocus;
end;

end.
