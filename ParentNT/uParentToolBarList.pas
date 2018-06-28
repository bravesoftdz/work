unit uParentToolBarList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentList, DB, Buttons, ExtCtrls, uParentCustomList, uMRSQLParam,
  mrConfigList, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  XiButton, ImgList, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxImageComboBox, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, Menus;

type
  TParentToolBarList = class(TParentCustomList)
    imgScreen: TImage;
    Image1: TImage;
    Image2: TImage;
    Shape1: TShape;
    btnNew: TXiButton;
    btnOpen: TXiButton;
    btnDelete: TXiButton;
    btnGroup: TXiButton;
    btnColumn: TXiButton;
    btnPrint: TXiButton;
    cmbListData: TcxImageComboBox;
    btnRestore: TXiButton;
    imgFilterList: TImageList;
    btnExport: TXiButton;
    popExport: TPopupMenu;
    memExcel: TMenuItem;
    memTextFile: TMenuItem;
    memHTML: TMenuItem;
    memXML: TMenuItem;
    procedure ConfigListAfterStart(Sender: TObject);
    procedure ConfigListGetFilter(Sender: TObject; var Filter: TMRSQLParam);
    procedure btnExportClick(Sender: TObject);
    procedure grdListDBTableViewDblClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure SetCommandOptionsVisibility; override;
    procedure DoShowList; override;
    procedure CreateCommandControls; override;
    procedure LoadImages; override;
    procedure AfterClassicationChange; override;
    procedure RestrictForm; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TParentToolBarList }

procedure TParentToolBarList.LoadImages;
begin
  inherited;
  imgBrowser.GetBitmap(BTN_LIST_COLUMN, btnColumn.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_DELETE, btnDelete.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_GROUP, btnGroup.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_OPEN, btnOpen.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_PRINT, btnPrint.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_RESTORE, btnRestore.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_NEW, btnNew.Glyph);
  imgBrowser.GetBitmap(BTN_LIST_EXPORT, btnExport.Glyph);
end;


procedure TParentToolBarList.DoShowList;
begin
  inherited;
  Show;
end;

procedure TParentToolBarList.CreateCommandControls;
begin
  inherited;
end;

procedure TParentToolBarList.SetCommandOptionsVisibility;
var
 mrCommandOption : TmrCommandOption;
begin
  inherited;
  
  mrCommandOption := TmrCommandOption(btnNew.Tag);
  btnNew.Enabled := (mrCommandOption in ConfigList.CommandOptions);

  mrCommandOption := TmrCommandOption(btnOpen.Tag);
  btnOpen.Enabled := (mrCommandOption in ConfigList.CommandOptions);

  mrCommandOption := TmrCommandOption(btnDelete.Tag);
  btnDelete.Enabled := (mrCommandOption in ConfigList.CommandOptions);

  mrCommandOption := TmrCommandOption(btnRestore.Tag);
  btnRestore.Enabled := (mrCommandOption in ConfigList.CommandOptions);

end;

procedure TParentToolBarList.ConfigListGetFilter(Sender: TObject;
  var Filter: TMRSQLParam);
begin
  inherited;
  Filter.AddKey('Desativado').AsInteger := cmbListData.ItemIndex;
  Filter.KeyByName('Desativado').Condition := tcEquals;
end;

procedure TParentToolBarList.ConfigListAfterStart(Sender: TObject);
begin
  inherited;
  cmbListData.ItemIndex := 0;
end;

procedure TParentToolBarList.btnExportClick(Sender: TObject);
var
  p : tpoint;
begin
  inherited;
  GetCursorPos(p);
  popExport.Popup(p.X, p.Y);
end;

procedure TParentToolBarList.AfterClassicationChange;
begin
  inherited;
  
  case cmbListData.ItemIndex of
   -1 : Exit;
    0 : begin
          btnNew.Visible := True;
          btnRestore.Visible := False;
        end;
    1 : begin
          btnNew.Visible := False;
          btnRestore.Visible := True;
        end;
  end;

  RefreshDataSet;

end;

procedure TParentToolBarList.RestrictForm;
begin
  inherited;
  btnNew.Enabled    := False;
  btnDelete.Enabled := False;
end;

procedure TParentToolBarList.grdListDBTableViewDblClick(Sender: TObject);
begin

  if btnOpen.Enabled then
    inherited;

end;

end.
