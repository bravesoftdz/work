unit uFrmCatalogSyncData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParent, siComp, StdCtrls, ExtCtrls, ComCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, ADODB, Provider;

type
  TFrmCatalogSyncData = class(TFrmParent)
    Panel2: TPanel;
    btnClose: TButton;
    pgOption: TPageControl;
    tsVendor: TTabSheet;
    cdsListVendor: TClientDataSet;
    dsListVendor: TDataSource;
    cdsListVendorIDVendorMR: TIntegerField;
    cdsListVendorIDVendor: TIntegerField;
    cdsListVendorVendor: TStringField;
    grdCatalogVendor: TcxGrid;
    grdCatalogVendorDBTableView: TcxGridDBTableView;
    grdCatalogVendorLevel: TcxGridLevel;
    grdCatalogVendorDBTableViewIDVendorMR: TcxGridDBColumn;
    grdCatalogVendorDBTableViewVendor: TcxGridDBColumn;
    btnApply: TButton;
    grdCatalogVendorDBTableViewIDVendor: TcxGridDBColumn;
    procedure btnCloseClick(Sender: TObject);
    procedure dsListVendorDataChange(Sender: TObject; Field: TField);
    procedure btnApplyClick(Sender: TObject);
  private
    procedure OpenVendor;
    procedure CloseVendor;
    procedure RefreshVendor;
    procedure PostVendor;
  public
    function Start : Boolean;
  end;

implementation

uses uDMImportExport;

{$R *.dfm}

{ TFrmCatalogSyncData }

function TFrmCatalogSyncData.Start: Boolean;
begin
  DMImportExport.ImportConn.Connected := True;
  DMImportExport.OpenVendor;
  RefreshVendor;
  ShowModal;
end;

procedure TFrmCatalogSyncData.btnCloseClick(Sender: TObject);
begin
  inherited;
  DMImportExport.CloseVendor;
  CloseVendor;
  Close;
end;

procedure TFrmCatalogSyncData.CloseVendor;
begin
  with cdsListVendor do
    if Active then
      Close;
end;

procedure TFrmCatalogSyncData.OpenVendor;
begin
  with cdsListVendor do
    if not Active then
      Open;
end;

procedure TFrmCatalogSyncData.RefreshVendor;
begin
   CloseVendor;
   OpenVendor;
end;

procedure TFrmCatalogSyncData.dsListVendorDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btnApply.Enabled := True;
end;

procedure TFrmCatalogSyncData.btnApplyClick(Sender: TObject);
begin
  inherited;

  if pgOption.ActivePage = tsVendor then
    PostVendor;

  btnApply.Enabled := False;
    
end;

procedure TFrmCatalogSyncData.PostVendor;
begin

  with cdsListVendor do
    if Active then
      if (ChangeCount > 0) then
        ApplyUpdates(-1);

end;

end.
