unit uFrmSystemInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeForms, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls;

type
  TFrmSystemInfo = class(TFrmParentForms)
    btnOK: TBitBtn;
    Label2: TLabel;
    Label4: TLabel;
    lbVersion: TLabel;
    Bevel1: TBevel;
    memSystemInfo: TMemo;
    Label3: TLabel;
    imgSystemInfo: TImage;
    btnConnection: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label3Click(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
  private
  public
    procedure Start;
  end;

implementation

uses uMsgBox, uMsgConstant, uDM, uWebFunctions, ufrmServerInfo, ADODB,
     uSystemConst;

{$R *.DFM}

procedure TFrmSystemInfo.Start;
begin
   lbVersion.Caption := DM.fSystem.Module + ' ' +DM.fSystem.VerBuild;
   memSystemInfo.Lines.Clear;
   memSystemInfo.Lines.Add(DM.fSQLConnectParam.toString);
   ShowModal;
end;

procedure TFrmSystemInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
  sResult : String;
begin
  inherited;
  Action := caFree;
end;

procedure TFrmSystemInfo.Label3Click(Sender: TObject);
begin
  inherited;
  OpenURL('http://www.mainretail.com/');
end;

procedure TFrmSystemInfo.btnConnectionClick(Sender: TObject);
var
  FrmServrInfo : TFrmServerInfo;
  bAbort       : Boolean;
begin
  inherited;
  FrmServrInfo := nil;

  try
     FrmServrInfo := TFrmServerInfo.Create(self);
     FrmServrInfo.Start(DM.fSystem.StartMode, True, '', bAbort);
     if not bAbort then
        begin
        MsgBox(MSG_INF_CHANGES_SYS, vbOKOnly + vbInformation);
        Close;
        end;
  finally
     FreeAndNil(FrmServrInfo);
     end;
end;

end.

