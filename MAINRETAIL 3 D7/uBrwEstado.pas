unit uBrwEstado;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask, PanelRights, Menus, BrowseConfig,
  ImgList, ADODB, RCADOQuery,
  PowerADOQuery, DateBox, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwEstado = class(TbrwParent)
    quBrowseIDEstado: TStringField;
    quBrowseEstado: TStringField;
    grdBrowseDBIDEstado: TcxGridDBColumn;
    grdBrowseDBEstado: TcxGridDBColumn;
    quBrowseTaxPerc: TBCDField;
    grdBrowseDBTaxPerc: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmEstado, uDM, uDMGlobal;

procedure TbrwEstado.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TbrwFrmEstado.Create(Self);
end;

end.
