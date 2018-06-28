unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, jpeg, cxLookAndFeelPainters,
  cxButtons;

type
  TFrmMain = class(TForm)
    lbPowered: TLabel;
    Label4: TLabel;
    lblVersion: TLabel;
    Shape5: TShape;
    lbResult: TLabel;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    btnExportInventory: TcxButton;
    btnImportSale: TcxButton;
    btnConfig: TcxButton;
    imgLog: TImage;
    procedure btnExportInventoryClick(Sender: TObject);
    procedure btnImportSaleClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure imgLogClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uDM, uFrmConfig, uFrmExport, Math, ufrmImport, uFrmLog;

{$R *.dfm}

procedure TFrmMain.btnExportInventoryClick(Sender: TObject);
begin
  with TFrmExport.Create(Self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TFrmMain.btnImportSaleClick(Sender: TObject);
begin
  with TFrmImport.Create(Self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TFrmMain.btnConfigClick(Sender: TObject);
begin
  with TFrmConfig.Create(self) do
  try
    Start;
  finally
    Free;
  end;
end;

procedure TFrmMain.imgLogClick(Sender: TObject);
begin
  FrmLog.ShowModal;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  lblVersion.Hint := SYNC_VERSION;
end;

end.
