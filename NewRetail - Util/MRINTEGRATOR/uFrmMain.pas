unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, dxBar;

type
  TMain = class(TForm)
    BarManager: TdxBarManager;
    dxBarSubItemFile: TdxBarSubItem;
    dxBarSubItemCustomize: TdxBarSubItem;
    dxBarSubItemHelp: TdxBarSubItem;
    mColumns: TdxBarButton;
    dxBarSubItemExport: TdxBarSubItem;
    mCustomer: TdxBarButton;
    mPaymentType: TdxBarButton;
    mInvoice: TdxBarButton;
    dxBarSubItemImport: TdxBarSubItem;
    mExit: TdxBarButton;
    pnlCustomize: TPanel;
    Shape1: TShape;
    Shape7: TShape;
    Image2: TImage;
    Label1: TLabel;
    Image4: TImage;
    lbColumns: TLabel;
    pnlExport: TPanel;
    Shape8: TShape;
    Shape9: TShape;
    Image3: TImage;
    Label2: TLabel;
    Image5: TImage;
    lbCustomer: TLabel;
    Image1: TImage;
    lbPayments: TLabel;
    Image6: TImage;
    lbInvoice: TLabel;
    Label3: TLabel;
    Image7: TImage;
    btnConnection: TdxBarButton;
    btProgramColumns: TdxBarButton;
    lbVersion: TLabel;
    procedure lbColumnsMouseLeave(Sender: TObject);
    procedure lbColumnsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbColumnsClick(Sender: TObject);
    procedure lbCustomerClick(Sender: TObject);
    procedure lbPaymentsClick(Sender: TObject);
    procedure lbInvoiceClick(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure btProgramColumnsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses uWizSetupColumns, uWizSetupProgramsColumns, uFile, uDM, uFrmMRConnection;

{$R *.dfm}

procedure TMain.lbColumnsMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := [];
  Screen.Cursor := crDefault;
end;

procedure TMain.lbColumnsMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  TLabel(Sender).Font.Style := [fsBold, fsUnderline];
  Screen.Cursor := crHandPoint;
end;

procedure TMain.lbColumnsClick(Sender: TObject);
begin
  with TWizSetupColumns.Create(Self) do
     Start;
end;

procedure TMain.lbCustomerClick(Sender: TObject);
begin
 DM.iEntityType := 0;
 with TFrmFile.Create(Self) do
     Start;
end;

procedure TMain.lbPaymentsClick(Sender: TObject);
begin
 DM.iEntityType := 1;
 with TFrmFile.Create(Self) do
     Start;
end;

procedure TMain.lbInvoiceClick(Sender: TObject);
begin
 DM.iEntityType := 2;
 with TFrmFile.Create(Self) do
     Start;
end;

procedure TMain.mExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMain.BitBtn1Click(Sender: TObject);
begin
 with TFrmMRConnection.Create(Self) do
     Start;
end;

procedure TMain.Label3Click(Sender: TObject);
begin
 with TWizSetupProgramsColumns.Create(Self) do
     Start;
end;

procedure TMain.btnConnectionClick(Sender: TObject);
begin
  with TFrmMRConnection.Create(Self) do
     Start;
end;

procedure TMain.btProgramColumnsClick(Sender: TObject);
begin
 with TWizSetupProgramsColumns.Create(Self) do
     Start;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 DM.CloseDatabase;
end;

end.
