unit uBrwInventMovType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask, PanelRights, Menus, BrowseConfig,
  DateBox, ImgList, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridBandedTableView, cxGridDBBandedTableView,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwInventMovType = class(TbrwParent)
    quBrowseIDInventMovType: TIntegerField;
    quBrowseName: TStringField;
    quBrowseOnHand: TStringField;
    quBrowseOnPreSale: TStringField;
    quBrowseOnOrder: TStringField;
    quBrowseOnRepair: TStringField;
    quBrowseOnPrePurchase: TStringField;
    quBrowsePreOnHand: TStringField;
    quBrowsePreOnPreSale: TStringField;
    quBrowsePreOnOrder: TStringField;
    quBrowsePreOnRepair: TStringField;
    quBrowsePreOnPrePurchase: TStringField;
    grdBrowseDBIDInventMovType: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    grdBrowseDBOnHand: TcxGridDBColumn;
    grdBrowseDBOnPreSale: TcxGridDBColumn;
    grdBrowseDBOnOrder: TcxGridDBColumn;
    grdBrowseDBOnRepair: TcxGridDBColumn;
    grdBrowseDBOnPrePurchase: TcxGridDBColumn;
    grdBrowseDBPreOnHand: TcxGridDBColumn;
    grdBrowseDBPreOnPreSale: TcxGridDBColumn;
    grdBrowseDBPreOnOrder: TcxGridDBColumn;
    grdBrowseDBPreOnRepair: TcxGridDBColumn;
    grdBrowseDBPreOnPrePurchase: TcxGridDBColumn;
    grdBrowseDBBanded: TcxGridDBBandedTableView;
    grdBrowseDBBandedIDInventMovType: TcxGridDBBandedColumn;
    grdBrowseDBBandedName: TcxGridDBBandedColumn;
    grdBrowseDBBandedOnHand: TcxGridDBBandedColumn;
    grdBrowseDBBandedOnPreSale: TcxGridDBBandedColumn;
    grdBrowseDBBandedOnOrder: TcxGridDBBandedColumn;
    grdBrowseDBBandedOnRepair: TcxGridDBBandedColumn;
    grdBrowseDBBandedOnPrePurchase: TcxGridDBBandedColumn;
    grdBrowseDBBandedPreOnHand: TcxGridDBBandedColumn;
    grdBrowseDBBandedPreOnPreSale: TcxGridDBBandedColumn;
    grdBrowseDBBandedPreOnOrder: TcxGridDBBandedColumn;
    grdBrowseDBBandedPreOnRepair: TcxGridDBBandedColumn;
    grdBrowseDBBandedPreOnPrePurchase: TcxGridDBBandedColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmInventMovType, uDM, uDMGlobal;

procedure TbrwInventMovType.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TbrwFrmInventMovType.Create(Self);
end;

end.
