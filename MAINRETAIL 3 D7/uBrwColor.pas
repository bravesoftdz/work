unit uBrwColor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeBrowses, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, ImgList, ExtCtrls, BrowseConfig, Menus, ADODB,
  PowerADOQuery, siComp, siLangRT, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, PanelRights, LblEffct, StdCtrls, Buttons,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSCore,
  dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwColor = class(TbrwParent)
    quBrowseIDColor: TIntegerField;
    quBrowseCodColor: TStringField;
    quBrowseColor: TStringField;
    grdBrowseDBIDColor: TcxGridDBColumn;
    grdBrowseDBCodColor: TcxGridDBColumn;
    grdBrowseDBColor: TcxGridDBColumn;
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

uses ubrwFrmColor, uDMGlobal, uDM, uBrwSizeColorGroup;

{$R *.dfm}

procedure TbrwColor.FormCreate(Sender: TObject);
begin
  inherited;
  BrwForm := TbrwFrmColor.Create(Self);

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

procedure TbrwColor.btColorGroupClick(Sender: TObject);
var
  sMenu : String;
begin
  inherited;

  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := fGroup + DM.fMainMenu.SubMenuName;
  try
     with TbrwSizeColorGroup.Create(Self) do
        begin
        sParam := 'IsColor=1;';
        Start;
        end;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;

end;

procedure TbrwColor.LoadImages;
begin
  inherited;
  DM.imgSubMenu.GetBitmap(38, btColorGroup.Glyph);
end;

end.
