unit PaidePrinter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeForms, siComp, siLangRT, uFrmMemo;

type
  TFrmParentPrint = class(TFrmParentForms)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
     MyMemo : TFrmMemo;
     procedure ImpMemoDBInfo(Text:String);
     procedure ImpMemoNoEmptyLine(Text:String);
  public
    { Public declarations }
  end;

var
  FrmParentPrint: TFrmParentPrint;

implementation

uses uDM;

{$R *.DFM}

procedure TFrmParentPrint.ImpMemoNoEmptyLine(Text:String);
var
   i : Integer;
begin
   if Trim(Text) = '' then
      Exit;
   MyMemo.MemoClear;
   MyMemo.AddText(Text);
   for i:=0 to MyMemo.MemoLineCount-1 do
      if not MyMemo.MemoEmptyLine(i) then
         DM.PrintLine(MyMemo.MemoReadLine(i));
end;

procedure TFrmParentPrint.ImpMemoDBInfo(Text:String);
var
   i : Integer;
begin
   if Trim(Text) = '' then
      Exit;
   MyMemo.MemoClear;
   MyMemo.AddText(Text);
   for i:=0 to MyMemo.MemoLineCount-1 do
       DM.PrintLine(MyMemo.MemoReadLine(i));
end;


procedure TFrmParentPrint.FormCreate(Sender: TObject);
begin
  inherited;

  MyMemo := TFrmMemo.Create(Self);

end;

procedure TFrmParentPrint.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(MyMemo);

end;

end.
