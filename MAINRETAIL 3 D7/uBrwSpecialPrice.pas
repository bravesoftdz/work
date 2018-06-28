unit uBrwSpecialPrice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, dxBar, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwSpecialPrice = class(TbrwParent)
    quBrowseIDSpecialPrice: TIntegerField;
    quBrowseSpecialPrice: TStringField;
    grdBrowseDBIDSpecialPrice: TcxGridDBColumn;
    grdBrowseDBSpecialPrice: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmSpecialPrice, uDM, uDMGlobal;

procedure TbrwSpecialPrice.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TbrwFrmSpecialPrice.Create(Self);
end;

procedure TbrwSpecialPrice.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1970);
end;

end.
