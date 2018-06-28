unit ubrwSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeBrowses, BrowseConfig, Menus, Db, 
  DBTables, PanelRights, LblEffct, ExtCtrls, StdCtrls, Buttons, Mask,
  DateBox, ImgList, ADODB, RCADOQuery, PowerADOQuery, siComp,
  siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl,
  dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwSize = class(TbrwParent)
    quBrowseIDSize: TIntegerField;
    quBrowseCodSize: TStringField;
    quBrowseSizeName: TStringField;
    grdBrowseDBIDSize: TcxGridDBColumn;
    grdBrowseDBCodSize: TcxGridDBColumn;
    grdBrowseDBSizeName: TcxGridDBColumn;
    btColorGroup: TSpeedButton;
    Panel4: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btColorGroupClick(Sender: TObject);
  private
    { Private declarations }
    fGroup : String;
  protected
    procedure LoadImages; override;
  public
    { Public declarations }
  end;

implementation

uses ubrwFrmSize, uDMGlobal, uDM, uBrwSizeColorGroup;

{$R *.DFM}

procedure TbrwSize.FormCreate(Sender: TObject);
begin
  inherited;
  BrwForm := TbrwFrmSize.Create(Self);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           fGroup := 'Group of ';
           end;

     LANG_PORTUGUESE :
           begin
           fGroup := 'Grupo de ';
           end;

     LANG_SPANISH :
           begin
           fGroup := 'Grupo de ';
           end;
   end;

end;

procedure TbrwSize.btColorGroupClick(Sender: TObject);
var
  sMenu : String;
begin
  inherited;

  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := fGroup + DM.fMainMenu.SubMenuName;
  try
     with TbrwSizeColorGroup.Create(Self) do
        begin
        sParam := 'IsColor=0;';
        Start;
        end;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;

end;

procedure TbrwSize.LoadImages;
begin
  inherited;
  DM.imgSubMenu.GetBitmap(39, btColorGroup.Glyph);
end;

end.
