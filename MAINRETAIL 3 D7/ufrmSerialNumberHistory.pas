unit ufrmSerialNumberHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB, cxDBData,
  Buttons, CheckLst, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  ComCtrls, ADODB;

type
  TviewSerialNumberHistory = class(TDialogParent)
    Panel3: TPanel;
    pgSerial: TPageControl;
    tsOnSale: TTabSheet;
    Panel4: TPanel;
    tsInventory: TTabSheet;
    grdInvSerial: TcxGrid;
    grdInvSerialDBTableView: TcxGridDBTableView;
    grdInvSerialDBTableViewName: TcxGridDBColumn;
    grdInvSerialDBTableViewSerial: TcxGridDBColumn;
    grdInvSerialLevel: TcxGridLevel;
    tsTransfer: TTabSheet;
    Label4: TLabel;
    clbSerial: TCheckListBox;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    btRemove: TSpeedButton;
    gridSerialOnSale: TcxGrid;
    gridSerialOnSaleDBTableView: TcxGridDBTableView;
    gridSerialOnSaleDBTableViewSerialNumber: TcxGridDBColumn;
    gridSerialOnSaleDBTableViewIdentificationNumber: TcxGridDBColumn;
    gridSerialOnSaleLevel: TcxGridLevel;
    gridSerialNumber: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dsSerialCurrent: TDataSource;
    dsSerialNumber: TDataSource;
    procedure dsSerialCurrentDataChange(Sender: TObject; Field: TField);
    procedure AplicarClick(Sender: TObject);
    procedure dsSerialNumberDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    function start(id_preinventory: Integer): Boolean;
  end;

implementation
uses uDm, uDMParent, SerialNumberCls;

{$R *.dfm}

{ TviewSerialNumberHistory }

function TviewSerialNumberHistory.start(id_preinventory: Integer): Boolean;
var
  objSerialNumber: TSerialNumberFromPreSale;
begin
  objSerialNumber := TSerialNumberFromPreSale.Create(-1, dm.fStore.ID, id_preinventory, 1);
  objSerialNumber.Connection := dm.ADODBConnect;
  dsSerialCurrent.DataSet := objSerialNumber.getSerial(id_preinventory);
  dsSerialNumber.DataSet  := objSerialNumber.getserialRecorded;
  result := ( showModal = mrOK );
end;

procedure TviewSerialNumberHistory.dsSerialCurrentDataChange(
  Sender: TObject; Field: TField);
begin
  inherited;
  btRemove.Enabled := true;
end;

procedure TviewSerialNumberHistory.AplicarClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TviewSerialNumberHistory.dsSerialNumberDataChange(
  Sender: TObject; Field: TField);
begin
  inherited;
  btRemove.Enabled := false;
end;

end.
