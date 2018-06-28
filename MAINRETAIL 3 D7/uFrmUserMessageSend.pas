unit uFrmUserMessageSend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  uFrmUserMessageUserList;

const
  TYPE_NEW     = 0;
  TYPE_REPLAY  = 1;
  TYPE_FORWARD = 2;

type
  TFrmUserMessageSend = class(TFrmParentAll)
    pnlUsers: TPanel;
    btnSendTo: TSpeedButton;
    Label1: TLabel;
    edtSubject: TEdit;
    mmReceivers: TMemo;
    pnlBody: TPanel;
    memBody: TMemo;
    btnSend: TButton;
    lbChar: TLabel;
    memoHistory: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSendToClick(Sender: TObject);
    procedure memBodyChange(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    fIDs, fUsers : String;
    fType : Integer;
    fFrmUsers: TFrmUserMessageUserList;
    function ValidadeFields:Boolean;
    procedure BuildHistory(Subject, Body : String);
  public
    function Start(iType:Integer; var sSubject, sMsg, sIDUser : String;
                    sHistory : String):Boolean;
  end;

implementation


{$R *.dfm}

procedure TFrmUserMessageSend.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  FreeAndNil(fFrmUsers);
end;

function TFrmUserMessageSend.Start(iType: Integer; var sSubject, sMsg,
  sIDUser : String; sHistory: String): Boolean;
begin

 fType := iType;

 memoHistory.Visible := False;

 case fType of

   TYPE_REPLAY : begin
                 mmReceivers.Text    := sIDUser;
                 edtSubject.Text     := 'Re: ' + sSubject;
                 btnSendTo.Enabled   := False;
                 BuildHistory(edtSubject.Text, sHistory);
                 end;
   TYPE_FORWARD : begin
                  edtSubject.Text     := 'Fw: ' + sSubject;
                  btnSendTo.Enabled   := True;
                  BuildHistory(edtSubject.Text, sHistory);
                  end;
   else
      begin
      btnSendTo.Enabled := True;
      end;

 end;

 ShowModal;

 Result := (ModalResult = mrOK);

 sIDUser  := fIDs;
 sSubject := edtSubject.Text;
 sMsg     := memBody.Text;

end;

procedure TFrmUserMessageSend.FormCreate(Sender: TObject);
begin
  inherited;
   fFrmUsers := TFrmUserMessageUserList.Create(Self);
end;

procedure TFrmUserMessageSend.btnSendToClick(Sender: TObject);
begin
  inherited;

  if fFrmUsers.Start(fIDs, fUsers) then
     begin
     mmReceivers.Clear;
     mmReceivers.Text := fUsers;
     end;

end;

procedure TFrmUserMessageSend.memBodyChange(Sender: TObject);
begin
  inherited;
  lbChar.Caption :=  IntToStr(225-Length(memBody.Lines.Text)) + ' character(s)';
end;

function TFrmUserMessageSend.ValidadeFields: Boolean;
begin
  Result := False;

  if Trim(edtSubject.Text) = '' then
     Exit;

  if Trim(memBody.Text) = '' then
     Exit;

  Result := True;
end;

procedure TFrmUserMessageSend.btnSendClick(Sender: TObject);
begin
  inherited;

  if not ValidadeFields then
     ModalResult := mrNone;

end;

procedure TFrmUserMessageSend.BuildHistory(Subject, Body: String);
begin
    memoHistory.Visible := True;
    memoHistory.Clear;
    memoHistory.Lines.Add(Subject);
    memoHistory.Lines.Add('======================');
    memoHistory.Lines.Add(Body);
end;

end.

