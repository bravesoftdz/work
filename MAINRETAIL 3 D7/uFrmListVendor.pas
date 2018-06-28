unit uFrmListVendor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient;

type
  TFrmListVendor = class(TFrmParentAll)
    dsVendorList: TDataSource;
    grdVendorList: TcxGrid;
    grdVendorListDB: TcxGridDBTableView;
    grdVendorListLevel: TcxGridLevel;
    grdVendorListDBVendor: TcxGridDBColumn;
    grdVendorListDBVendorCode: TcxGridDBColumn;
    grdVendorListDBMinQtyPO: TcxGridDBColumn;
    grdVendorListDBCaseQty: TcxGridDBColumn;
    grdVendorListDBVendorCost: TcxGridDBColumn;
    btSelect: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btSelectClick(Sender: TObject);
  private
    FSelected : Boolean;
  public
    function Start(cdsVendor : TClientDataSet) : Integer;
  end;


implementation

{$R *.dfm}

{ TFrmListVendor }

function TFrmListVendor.Start(cdsVendor: TClientDataSet): Integer;
begin
  FSelected := False;
  dsVendorList.DataSet := cdsVendor;
  ShowModal;
  Result := -1;
  if FSelected then
    Result := cdsVendor.FieldByName('IDVendor').asInteger
end;

procedure TFrmListVendor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmListVendor.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmListVendor.btSelectClick(Sender: TObject);
begin
  inherited;
  FSelected := True;
  Close;
end;

end.
