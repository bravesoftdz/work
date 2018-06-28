unit uBrwMeioPag;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables,  Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, ADODB, RCADOQuery,
  PowerADOQuery, siComp, siLangRT, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TBrwMeioPag = class(TbrwParent)
    quBrowseIDMeioPag: TIntegerField;
    quBrowseMeioPag: TStringField;
    quBrowseParentType: TStringField;
    grdBrowseDBIDMeioPag: TcxGridDBColumn;
    grdBrowseDBMeioPag: TcxGridDBColumn;
    grdBrowseDBParentType: TcxGridDBColumn;
    quBrowseImageIndex: TIntegerField;
    grdBrowseDBImageIndex: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    procedure SetHelpContext;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFchMeioPag, uDM, uDMGlobal;

procedure TBrwMeioPag.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm  := TFchMeioPag.Create(Self);

end;

procedure TBrwMeioPag.SetHelpContext;
begin

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_PORTUGUESE:
    begin
      sUrlHelp  := 'http://www.mainretail.com.br/treinamento/Cadastro/Cad_Pagamentos.htm';
      if quBrowseParentType.AsString = 'Sale' then
        sUrlVideo := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Tipo_de_Pagamento_Sale/Adicionar_Tipo_de_Pagamento_Sale.html'
      else
        sUrlVideo := 'http://www.mainretail.com.br/treinamento/video/Adicionar_Tipo_de_Pagamento_Batch/Adicionar_Tipo_de_Pagamento_Batch.html';
    end;

    LANG_SPANISH :
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;
  end;

end;

procedure TBrwMeioPag.spHelpClick(Sender: TObject);
begin
  SetHelpContext;
  inherited;
end;

procedure TBrwMeioPag.btnVideoClick(Sender: TObject);
begin
  SetHelpContext;
  inherited;
end;

end.
