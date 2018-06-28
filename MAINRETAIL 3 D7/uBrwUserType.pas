unit uBrwUserType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids, DBGrids, StdCtrls,
  LblEffct, ExtCtrls, Mask, PanelRights, Menus, BrowseConfig, DateBox, ImgList,
  ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwUserType = class(TbrwParent)
    quBrowseIDUserType: TIntegerField;
    quBrowseName: TStringField;
    sbtnUser: TSpeedButton;
    grdBrowseDBIDUserType: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    Panel4: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure sbtnUserClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmUserType, uDM, ubrwUser, uDMGlobal;

procedure TbrwUserType.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TbrwFrmUserType.Create(Self);
end;

procedure TbrwUserType.sbtnUserClick(Sender: TObject);
begin
  inherited;
  with TBrwUser.Create(Self) do
    begin
     sParam := 'SubMenuCaption=Users;';
     aWhereBasicFilters[0] := 'SU.UserTypeID = ' + quBrowseIdUserType.AsString;
     quBrowse.AddFilter(['UserTypeID'], [quBrowseIdUserType.AsString]);
     Start;
    end;
end;

end.
