unit uBrwStore;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids, DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwStore = class(TbrwParent)
    quBrowseIDStore: TIntegerField;
    quBrowseName: TStringField;
    quBrowseAddress: TStringField;
    quBrowseIDEstado: TStringField;
    quBrowseCity: TStringField;
    quBrowseZip: TStringField;
    quBrowseTelephone: TStringField;
    quBrowseIDEmpresa: TIntegerField;
    quBrowseFax: TStringField;
    quBrowseBeeper: TStringField;
    quBrowseCellular: TStringField;
    quBrowseContato: TStringField;
    grdBrowseDBIDStore: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    grdBrowseDBAddress: TcxGridDBColumn;
    grdBrowseDBIDEstado: TcxGridDBColumn;
    grdBrowseDBCity: TcxGridDBColumn;
    grdBrowseDBZip: TcxGridDBColumn;
    grdBrowseDBTelephone: TcxGridDBColumn;
    grdBrowseDBFax: TcxGridDBColumn;
    grdBrowseDBBeeper: TcxGridDBColumn;
    grdBrowseDBCellular: TcxGridDBColumn;
    grdBrowseDBContato: TcxGridDBColumn;
    quBrowseEmail: TStringField;
    quBrowseWebPage: TStringField;
    grdBrowseDBEmail: TcxGridDBColumn;
    grdBrowseDBWebPage: TcxGridDBColumn;
    quBrowseFranchise: TBooleanField;
    grdBrowseDBFranchise: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmStore, uDM, uDMGlobal;

procedure TbrwStore.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TbrwFrmStore.Create(Self);
end;

end.
