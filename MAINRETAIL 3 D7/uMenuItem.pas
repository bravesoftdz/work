unit uMenuItem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, Db, DBTables, Grids, LblEffct, ExtCtrls, StdCtrls, ResizePanel,
  DBCtrls, MemoStr, Buttons, Mask, ADODB, siComp, siLangRT, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TFrmMenuItem = class(TFrmParent)
    quMenuItem: TADOQuery;
    quMenuItemParentMenu: TStringField;
    quMenuItemName: TStringField;
    quMenuItemCmdLine: TStringField;
    dsMenuItem: TDataSource;
    DbMemoStr1: TDbMemoStr;
    ResizePanel1: TResizePanel;
    quMenuItemTip: TStringField;
    quMenuItemVisible: TBooleanField;
    spHelp: TSpeedButton;
    quMenuItemEnabled: TBooleanField;
    quMenuItemIDMenu: TIntegerField;
    quMenuItemIDSubMenu: TIntegerField;
    quMenuItemIDMenuName: TStringField;
    quMenuItemShortcut: TIntegerField;
    quMenuItemImageIndex: TIntegerField;
    grdMenuItem: TcxGrid;
    grdMenuItemDB: TcxGridDBTableView;
    grdMenuItemLevel: TcxGridLevel;
    grdMenuItemDBParentMenu: TcxGridDBColumn;
    grdMenuItemDBEnabled: TcxGridDBColumn;
    grdMenuItemDBName: TcxGridDBColumn;
    grdMenuItemDBCmdLine: TcxGridDBColumn;
    grdMenuItemDBVisible: TcxGridDBColumn;
    grdMenuItemDBIDMenuName: TcxGridDBColumn;
    grdMenuItemDBShortcut: TcxGridDBColumn;
    grdMenuItemDBImageIndex: TcxGridDBColumn;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure quMenuItemCalcFields(DataSet: TDataSet);
    procedure quMenuItemBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }

    //MenuItem
    procedure MenuItemClose;
    procedure MenuItemOpen;
    procedure MenuItemPost;

  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, imglist;


procedure TFrmMenuItem.MenuItemClose;
begin

  MenuItemPost;

   with quMenuItem do
      if Active then
         Close;
end;

procedure TFrmMenuItem.MenuItemOpen;
begin

   with quMenuItem do
      if not Active then
         Open;

end;

procedure TFrmMenuItem.MenuItemPost;
begin

   with quMenuItem do
      if Active then
         if State in dsEditModes then
            begin
            Post;
            MsgBox(MSG_INF_CHANGES_SYS, vbOkOnly + vbInformation);
            end;

end;


procedure TFrmMenuItem.btCloseClick(Sender: TObject);
begin
  inherited;

  MenuItemClose;

  Close;

end;

procedure TFrmMenuItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DM.imgSubMenu.DrawingStyle := dsNormal;
  Action := caFree;

end;

procedure TFrmMenuItem.FormShow(Sender: TObject);
begin
  inherited;

  MenuItemOpen;

  DM.imgSubMenu.DrawingStyle := dsTransparent;
  
end;

procedure TFrmMenuItem.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(2060);
end;

procedure TFrmMenuItem.quMenuItemCalcFields(DataSet: TDataSet);
begin
  inherited;

  quMenuItemIDMenuName.AsString := quMenuItemIDMenu.AsString + ' - ' +
                                   quMenuItemParentMenu.AsString; 

end;

procedure TFrmMenuItem.quMenuItemBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  quMenuItem.Parameters.ParamByName('IDLanguage').Value := DMGlobal.IDLanguage;
end;

end.
