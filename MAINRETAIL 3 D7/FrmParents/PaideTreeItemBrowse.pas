unit PaideTreeItemBrowse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeBrowses, ExtCtrls, ComCtrls, Menus, Db, DBTables,
  Grids, Buttons, PanelRights,
  LblEffct, StdCtrls, PaiDeFichas, ResizePanel, DBTreeView, BrowseConfig,
  ImgList, Mask, DateBox, dxBar, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dxPScxGridLnk, cxGridCustomPopupMenu, cxGridPopupMenu;

const
  INDBRW_IDTIPO = 1;
  INDBRW_PATH   = 2;

type
  TbrwTreeItemParent = class(TbrwParent)
    Panel4: TPanel;
    pnlTitleTree: TPanel;
    pnlTitleGrid: TPanel;
    Splitter: TSplitter;
    quTreeView: TADOQuery;
    Small: TImageList;
    pnlTreeCommand: TResizePanel;
    btAddSubType: TSpeedButton;
    DBTreeView: TDBTreeView;
    btDetailType: TSpeedButton;
    CheckSub: TCheckBox;
    pnlEspacamento857785: TPanel;
    pnlEspacamento48945614: TPanel;
    btRemoveType: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure btAddItemTreeClick(Sender: TObject);
    procedure DBTreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure btRemoveTypeClick(Sender: TObject);
    procedure DBTreeViewDblClick(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure CheckSubClick(Sender: TObject);
  private
    { Private declarations }
    GridTitle : String;
  protected
    brwTreeForm : TbrwFrmParent;
    procedure LoadImages; override;
    procedure OnBeforeDeleteItem; virtual;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uDM, uMsgBox, uSystemTypes, uMsgConstant, uDMGlobal;

procedure TbrwTreeItemParent.LoadImages;
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW,btAddSubType.Glyph);
  DM.imgSmall.GetBitmap(BTN18_OPEN,btDetailType.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE,btRemoveType.Glyph);
end;

procedure TbrwTreeItemParent.FormCreate(Sender: TObject);
begin
  inherited;
  brwTreeForm := nil;  // Indica que os tipos não tem ficha
  GridTitle   := pnlTitleGrid.Caption;
end;

procedure TbrwTreeItemParent.FormDestroy(Sender: TObject);
begin
  inherited;
  if brwTreeForm <> nil then
     brwTreeForm.Free;       // Tira a ficha da memoria
end;

procedure TbrwTreeItemParent.FormShow(Sender: TObject);
begin
  // Deve carregar o TreeView antes de carregar o grid herdado
  DBTreeView.LoadTreeView;

  inherited;

  DBTreeView.SetFocus;
end;

procedure TbrwTreeItemParent.DBTreeViewChange(Sender: TObject;
  Node: TTreeNode);
var
  Filtro : String;
  TextoTodos : String;
begin
  inherited;
  // Deve tratar dois tipos de filtro

  // Filtro so do branch
  Filtro := IntTostr(DBTreeView.ActualIDItem);

  btDetailType.Enabled := (Filtro <> '-1');
  btRemoveType.Enabled := btDetailType.Enabled;
  if pnlTitleGrid.Tag = 0 then
    // Masculino
    TextoTodos := 'All '
  else
    // Feminino
    TextoTodos := 'All ';

  if Filtro = '-1' then
    begin
     // Raiz Virtual
     if not CheckSub.Checked then
       begin
         pnlTitleGrid.Caption := TextoTodos + GridTitle;
         WhereTreeFilter := '(0=1)';
         pnlButton.DisableButtons;
       end
     else
       begin
         pnlTitleGrid.Caption := TextoTodos + GridTitle;
         WhereTreeFilter := '';
       end;
    end
  else
    begin
     if not CheckSub.Checked then
       begin
         pnlTitleGrid.Caption := GridTitle + DBTreeView.ActualName;
         WhereTreeFilter := DBTreeView.FieldIDItem + ' = ' + Trim(Filtro);
       end
     else
       begin
         pnlTitleGrid.Caption := GridTitle +  DBTreeView.ActualName;
         Filtro := DBTreeView.ActualPath;
         WhereTreeFilter := DBTreeView.FieldPath + ' like ' + Chr(39) +
                            Trim(Filtro) + '%%' + Chr(39);
       end;
    end;

   ExecBrowseSQL(True);

end;

procedure TbrwTreeItemParent.btAddItemTreeClick(Sender: TObject);
var
  MyNode : TTreeNode;
begin
  inherited;
  MyNode := DBTreeView.AddSubItem(DBTreeView.Selected);

  if MyNode <> nil then
    if brwTreeForm = nil then
       MyNode.EditText
    else
       DBTreeViewDblClick(nil);
end;

procedure TbrwTreeItemParent.DBTreeViewEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
begin
  inherited;
  DBTreeView.ActualName := S;
end;

procedure TbrwTreeItemParent.btRemoveTypeClick(Sender: TObject);
begin
  inherited;

  //replace this message to super critical message like this: Do you want to remove the "Dog Food" folder and all customers contained in that folder?
  if (DBTreeView.Selected.Level > 0) and
     (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
     begin
       OnBeforeDeleteItem;
       DBTreeView.DeleteActualItem;
     end;
end;

procedure TbrwTreeItemParent.DBTreeViewDblClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;
  // trata a alteração
  if (brwTreeForm <> nil) then
    begin
      if DBTreeView.ActualIDItem <> -1 then
        begin
          PosID1 := IntTostr(DBTreeView.ActualIDItem); PosID2 := '';
          if brwTreeForm.Start(btAlt, nil, False, PosID1, PosID2, nil) then
            begin
             // altera o nome do tree view
             with brwTreeForm.quForm do
              begin
                Open;
                if DBTreeView.ActualName <> Fields[1].AsString then
                   DBTreeView.ActualName := Fields[1].AsString;
                Close;
              end;
            end;
        end;
    end
  else
    begin
      DBTreeView.Selected.EditText;
    end;
end;

procedure TbrwTreeItemParent.CommandClick(Sender: TObject);
begin
  quBrowse.AddFilter([DBTreeView.FieldIDItem], [IntToStr(DBTreeView.ActualIDItem)]);
  inherited;
end;

procedure TbrwTreeItemParent.CheckSubClick(Sender: TObject);
begin
  inherited;
  DBTreeViewChange(nil, DBTreeView.Selected);
end;

procedure TbrwTreeItemParent.OnBeforeDeleteItem;
begin
  //para ser herdado
end;

end.
