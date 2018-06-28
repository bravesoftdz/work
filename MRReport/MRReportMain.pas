unit MRReportMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dxBar, ExtCtrls, uReportExplorerFrm, siComp, Midas;

type
  TMainFrm = class(TForm)
    BarManager: TdxBarManager;
    bsiFile: TdxBarSubItem;
    mExit: TdxBarButton;
    btnConfiguration: TdxBarButton;
    dxConnection: TdxBarButton;
    bbReport: TdxBarButton;
    lbPowered: TLabel;
    Label4: TLabel;
    lblVersion: TLabel;
    Shape5: TShape;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    imgConfiguration: TImage;
    imgConnection: TImage;
    imgReport: TImage;
    bsiTools: TdxBarSubItem;
    btnUpdate: TdxBarButton;
    siLang: TsiLang;
    procedure btnConfigurationClick(Sender: TObject);
    procedure dxConnectionClick(Sender: TObject);
    procedure bbReportClick(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    bAutoLogin : Boolean;
    FReportExplorerFrm : TReportExplorerFrm;

    procedure LoadParams;
    function CallAutoLogin(PW: String): Boolean;

    function ValidateLogin: Boolean;
  end;

var
  MainFrm: TMainFrm;

implementation

uses uRepConfigFrm, uRepConnectionFrm, uRepLogin, MRUpdate, uDMReport, uParamFunctions;

{$R *.dfm}

procedure TMainFrm.btnConfigurationClick(Sender: TObject);
begin
  with TRepConfigFrm.Create(Self) do
    Start;
end;

procedure TMainFrm.dxConnectionClick(Sender: TObject);
begin
  with TRepConnectionFrm.Create(Self) do
    Start;
end;

procedure TMainFrm.bbReportClick(Sender: TObject);
begin
  if DMReport.GetAppProperty('Default', 'ReportPath') = '' then
    MessageDlg('Report folder is not configured!', mtWarning, [mbOK], 0)
  else if ValidateLogin then
  begin
    if not Assigned(FReportExplorerFrm) then
      FReportExplorerFrm := TReportExplorerFrm.Create(Self);
    FReportExplorerFrm.Start;
  end;
 
end;

procedure TMainFrm.mExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainFrm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FReportExplorerFrm);
end;

function TMainFrm.ValidateLogin: Boolean;
begin
  Result := False;

  if bAutoLogin then
    Result := True
  else
    with TRepLoginFrm.Create(Self) do
    try
      Result := Start;
    finally
      Free;
    end;
end;

procedure TMainFrm.btnUpdateClick(Sender: TObject);
begin
  with TUpdateFrm.Create(Self) do
  try
    Start; 
  finally
    Free;
    end;
end;

procedure TMainFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMainFrm.FormShow(Sender: TObject);
begin
  LoadParams;
end;

procedure TMainFrm.LoadParams;
var
  sParam : String;
begin

  bAutoLogin := False;

  if ParamCount > 0 then
  begin
    sParam := ParamStr(1);
    if (sParam <> '') then
      CallAutoLogin(sParam);
  end;
      
end;

function TMainFrm.CallAutoLogin(PW: String): Boolean;
begin

  if (PW <> '') then
  begin
    PW := ParseParam(PW, 'PW');
    with TRepLoginFrm.Create(Self) do
    try
      Result := AutoLogin(PW);
      bAutoLogin := Result;
    finally
      Free;
    end;
  end else
    Result := True;

end;


end.
