unit MRSintegraMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxBar, ExtCtrls, StdCtrls;

type
  TMainFrm = class(TForm)
    lbPowered: TLabel;
    Label4: TLabel;
    lblVersion: TLabel;
    Shape5: TShape;
    BarManager: TdxBarManager;
    bsiFile: TdxBarSubItem;
    mExit: TdxBarButton;
    bbSale: TdxBarButton;
    bbPurchase: TdxBarButton;
    bbGenerateFile: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    bbECF: TdxBarButton;
    bbReducaoZ: TdxBarButton;
    bbConfig: TdxBarButton;
    bbValidador: TdxBarButton;
    bbTED: TdxBarButton;
    Label3: TLabel;
    imgConfiguration: TImage;
    Label1: TLabel;
    imgReport: TImage;
    Image1: TImage;
    Label2: TLabel;
    procedure mExitClick(Sender: TObject);
    procedure bbPurchaseClick(Sender: TObject);
    procedure bbSaleClick(Sender: TObject);
    procedure bbGenerateFileClick(Sender: TObject);
    procedure bbECFClick(Sender: TObject);
    procedure bbReducaoZClick(Sender: TObject);
    procedure bbConfigClick(Sender: TObject);
    procedure bbValidadorClick(Sender: TObject);
    procedure bbTEDClick(Sender: TObject);
    procedure imgReportClick(Sender: TObject);
    procedure imgConfigurationClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFrm: TMainFrm;

implementation

uses uSintegraConfigFrm, uPurchaseFrm, uSaleFrm, uSintegraFrm, uECFList,
  uReducaoZList, uDMSintegra;

{$R *.dfm}

procedure TMainFrm.mExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMainFrm.bbPurchaseClick(Sender: TObject);
begin
  with TSintegraPurchaseFrm.Create(self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TMainFrm.bbSaleClick(Sender: TObject);
begin
  with TSintegraSaleFrm.Create(self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TMainFrm.bbGenerateFileClick(Sender: TObject);
begin
  with TSintegraFrm.Create(self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TMainFrm.bbECFClick(Sender: TObject);
begin
  with TECFList.Create(Self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TMainFrm.bbReducaoZClick(Sender: TObject);
begin
  with TReducaoZList.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainFrm.bbConfigClick(Sender: TObject);
begin
  with TSintegraConfigFrm.Create(self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TMainFrm.bbValidadorClick(Sender: TObject);
begin
  WinExec(PCHAR(DMSintegra.GetAppProperty('Settings', 'ValidadorPath')), SW_SHOWNORMAL);
end;

procedure TMainFrm.bbTEDClick(Sender: TObject);
begin
  WinExec(PCHAR(DMSintegra.GetAppProperty('Settings', 'TEDPath')), SW_SHOWNORMAL);
end;

procedure TMainFrm.imgReportClick(Sender: TObject);
begin
  bbGenerateFileClick(Sender);
end;

procedure TMainFrm.imgConfigurationClick(Sender: TObject);
begin
  bbConfigClick(Sender);
end;

procedure TMainFrm.Image1Click(Sender: TObject);
begin
  bbValidadorClick(Sender);
end;

end.
