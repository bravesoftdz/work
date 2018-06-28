unit uBrwCashRegister;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, ImgList, dxPSGlbl, dxPSUtl, dxPSEngn,
  dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu,
  cxGridPopupMenu;

type
  TbrwCashRegister = class(TbrwParent)
    quBrowseIDCashRegister: TIntegerField;
    quBrowseName: TStringField;
    quBrowseIsAssociated: TBooleanField;
    grdBrowseDBIDCashRegister: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    grdBrowseDBIsAssociated: TcxGridDBColumn;
    btDrawerKickLog: TSpeedButton;
    btCountConfig: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btDrawerKickLogClick(Sender: TObject);
    procedure btCountConfigClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmCashRegister, uDM, uDMGlobal, uFrmDrawerKickLog,
  uFrmCountInventoryConfig;

procedure TbrwCashRegister.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TbrwFrmCashRegister.Create(Self);
end;

procedure TbrwCashRegister.btDrawerKickLogClick(Sender: TObject);
begin
  inherited;
  if (quBrowse.Active) and (quBrowseIDCashRegister.AsInteger <> 0) then
    with TFrmDrawerKickLog.Create(Self) do
      Start(quBrowseIDCashRegister.AsInteger);

  btDrawerKickLog.Down := False;
end;

procedure TbrwCashRegister.btCountConfigClick(Sender: TObject);
begin
  inherited;
  with TFrmCountInventoryConfig.Create(Self) do
    Start;
  btCountConfig.Down := False;
end;

end.
