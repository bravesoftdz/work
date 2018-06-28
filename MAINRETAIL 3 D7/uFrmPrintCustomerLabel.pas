unit uFrmPrintCustomerLabel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaidePrinter, siComp, siLangRT, StdCtrls, ExtCtrls, DB, DBClient,
  ADODB, ppPrnabl, ppClass, ppCtrls, ppBands, ppDB, ppDBPipe, ppParameter,
  ppCache, ppRelatv, ppProd, ppReport, ppComm, ppEndUsr, Buttons;

type
  TFrmPrintCustomerLabel = class(TFrmParentPrint)
    dsCustomer: TDataSource;
    Panel1: TPanel;
    EspacamentoInferior: TPanel;
    Panel3: TPanel;
    hhh: TPanel;
    btClose: TButton;
    ppDesigner: TppDesigner;
    ppReport: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppSummaryBand3: TppSummaryBand;
    ppParameterList1: TppParameterList;
    IDLanguage: TppParameter;
    ppCustomer: TppDBPipeline;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    cdsCustomerList: TClientDataSet;
    Label1: TLabel;
    edtPath: TEdit;
    SpeedButton1: TSpeedButton;
    btnEdit: TButton;
    OP: TOpenDialog;
    btnDelReport: TSpeedButton;
    procedure btnEditClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDelReportClick(Sender: TObject);
  private
    procedure LoadCustomerReport;
    procedure SaveCustomerReport;
  public
    procedure Start(Customer : TClientDataSet);
    procedure Print(Customer : TClientDataSet);
  end;

implementation

uses uDM, uSystemConst, Registry;

{$R *.dfm}

{ TFrmPrintCustomerLabel }

procedure TFrmPrintCustomerLabel.Start(Customer: TClientDataSet);
begin
  cdsCustomerList.Data := Customer.Data;
  LoadCustomerReport;
  ShowModal;
end;

procedure TFrmPrintCustomerLabel.btnEditClick(Sender: TObject);
begin
  inherited;

  ppDesigner.ShowModal;

end;

procedure TFrmPrintCustomerLabel.Print(Customer: TClientDataSet);
begin
  try
    cdsCustomerList.Data := Customer.Data;
    LoadCustomerReport;
    ppReport.DeviceType := 'Screen';
    if edtPath.Text <> '' then
      if FileExists(edtPath.Text) then
      begin
        ppReport.Template.FileName := edtPath.Text;
        ppReport.Template.LoadFromFile;
      end;
    ppReport.Print;
  finally
    Close;
    end;
end;

procedure TFrmPrintCustomerLabel.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if OP.Execute then
    edtPath.Text := OP.FileName;
end;

procedure TFrmPrintCustomerLabel.LoadCustomerReport;
begin

 with TRegistry.Create do
 try
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey(REGISTRY_PATH, True);
   if not ValueExists('CustomerLabelRep') then
     WriteString('CustomerLabelRep', '');
   edtPath.Text := ReadString('CustomerLabelRep');
 finally
   CloseKey;
   Free;
   end;

end;

procedure TFrmPrintCustomerLabel.SaveCustomerReport;
begin
 with TRegistry.Create do
 try
   RootKey := HKEY_LOCAL_MACHINE;
   OpenKey(REGISTRY_PATH, True);
   WriteString('CustomerLabelRep', edtPath.Text);
 finally
   CloseKey;
   Free;
   end;
end;

procedure TFrmPrintCustomerLabel.btCloseClick(Sender: TObject);
begin
  inherited;
  SaveCustomerReport;
  Close;
end;

procedure TFrmPrintCustomerLabel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPrintCustomerLabel.btnDelReportClick(Sender: TObject);
begin
  inherited;
  edtPath.Text := '';
end;

end.
