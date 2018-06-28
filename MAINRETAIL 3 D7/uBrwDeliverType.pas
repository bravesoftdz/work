unit uBrwDeliverType;

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
  TbrwDeliverType = class(TbrwParent)
    quBrowseIDDeliverType: TIntegerField;
    quBrowseName: TStringField;
    grdBrowseDBIDDeliverType: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    quBrowseWebsite: TStringField;
    grdBrowseDBWebsite: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmDeliverType, uDM, uDMGlobal;

procedure TbrwDeliverType.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TBrwFrmDeliverType.Create(Self);
end;

end.
