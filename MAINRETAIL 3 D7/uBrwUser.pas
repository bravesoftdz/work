unit uBrwUser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, ADODB, RCADOQuery, PowerADOQuery,
  siComp, siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwUser = class(TbrwParent)
    quBrowseIDUser: TIntegerField;
    quBrowseSystemUser: TStringField;
    quBrowseName: TStringField;
    grdBrowseDBIDUser: TcxGridDBColumn;
    grdBrowseDBSystemUser: TcxGridDBColumn;
    grdBrowseDBName: TcxGridDBColumn;
    quBrowseCodSystemUser: TStringField;
    grdBrowseDBCodSystemUser: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFrmUser, uDM, uDMGlobal;

procedure TbrwUser.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TbrwFrmUser.Create(Self);

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_PORTUGUESE:
    begin
      sUrlHelp  := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Usuario.htm';
      sUrlVideo := 'http://www.mainretail.com.br/treinamento/Video/Adicionar_Usuario/Adicionar_Usuario.html';
    end;

    LANG_SPANISH :
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;
  end;
  
end;

end.
