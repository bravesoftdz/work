unit uFrmMemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeForms, siComp, siLangRT, StdCtrls;

type
  TFrmMemo = class(TFrmParentForms)
    Memo: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MemoClear;
    procedure AddText(Text:String);
    function MemoEmptyLine(Line:Integer):Boolean;
    function MemoReadLine(Line:Integer):String;
    function MemoLineCount:Integer;
  end;

implementation

{$R *.DFM}

function TFrmMemo.MemoEmptyLine(Line:Integer):Boolean;
begin
  Result := Trim(Memo.Lines[Line])='';
end;

function TFrmMemo.MemoLineCount:Integer;
begin
 Result := Memo.Lines.Count;
end;

function TFrmMemo.MemoReadLine(Line:Integer):String;
begin
 Result := Memo.Lines[Line];
end;

procedure TFrmMemo.MemoClear;
begin
 Memo.Clear;
end;

procedure TFrmMemo.AddText(Text:String);
begin
  Memo.Lines.Add(Text);
end;


end.
