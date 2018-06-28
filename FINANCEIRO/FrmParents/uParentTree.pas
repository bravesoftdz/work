unit uParentTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFixedFrm, Db, DBTables, ComCtrls, DBTreeView, Buttons,
  ExtCtrls, uParentFch, StdCtrls, dxBar, Grids, ImgList, ADODB, siComp,
  siLangRT;

type
  TParentTree = class(TParentFixedFrm)
    DBTreeView: TDBTreeView;
    quTreeView: TADOQuery;
    bbNovoItem: TdxBarButton;
    bbAbreItem: TdxBarButton;
    bbRemoveItem: TdxBarButton;
    ilTreeSmall: TImageList;
    quTreeViewImageIndex: TIntegerField;
    quTreeViewSelectedIndex: TIntegerField;
    PrintDialog: TPrintDialog;
    dsTreeView: TDataSource;
    btPrint: TdxBarButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure DBTreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure bbNovoItemClick(Sender: TObject);
    procedure bbAbreItemClick(Sender: TObject);
    procedure bbRemoveItemClick(Sender: TObject);
    procedure DBTreeViewDblClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    brwTreeForm : TParentFch;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uMsgBox, uSisSenha, uDM, uSystemTypes, uMsgConstant;

procedure TParentTree.FormDestroy(Sender: TObject);
begin
  inherited;
  if brwTreeForm <> nil then brwTreeForm.Free;

end;

procedure TParentTree.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;

end;

procedure TParentTree.FormShow(Sender: TObject);
begin
  inherited;
  // Deve carregar o TreeView antes de carregar o grid herdado
  DBTreeView.LoadTreeView;
  DBTreeView.SetFocus;
  DBTreeViewChange(nil, DBTreeView.Selected);

end;

procedure TParentTree.FormCreate(Sender: TObject);
begin
  inherited;
  brwTreeForm := nil;

end;

procedure TParentTree.DBTreeViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  if DBTreeView.ActualIDItem = -1 then
   begin
    // Raiz Virtual
    bbAbreItem.Enabled := False;
    bbRemoveItem.Enabled := False;
   end
  else
   begin
    bbAbreItem.Enabled := True;
    bbRemoveItem.Enabled := True;
   end;

end;

procedure TParentTree.DBTreeViewEdited(Sender: TObject;
  Node: TTreeNode; var S: String);
begin
  inherited;
  DBTreeView.ActualName := S;

end;

procedure TParentTree.bbNovoItemClick(Sender: TObject);
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

procedure TParentTree.bbAbreItemClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;
  // trata a alteração
  if (brwTreeForm <> nil) then
    begin
      if DBTreeView.ActualIDItem <> -1 then
        begin
          PosID1 := IntTostr(DBTreeView.ActualIDItem);
          PosID2 := '';
          if brwTreeForm.Start(btAlt, nil, False, PosID1, PosID2, '', '', nil) then
            begin
             // altera o nome do tree view

{             with quTreeView do
              begin
                Open;
                Locate(DBTreeView.FieldName, IntToStr(DBTreeView.ActualIDItem), []);
                DBTreeView.ActualName := FieldByName(DBTreeView.FieldName).AsString;
                Close;
              end;}
            end;
        end;
    end
  else
    begin
      DBTreeView.Selected.EditText;
    end;
end;

procedure TParentTree.bbRemoveItemClick(Sender: TObject);
begin
  inherited;
  if (DBTreeView.Selected.Level > 0) and
     (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
     DBTreeView.DeleteActualItem;

end;

procedure TParentTree.DBTreeViewDblClick(Sender: TObject);
begin
  inherited;
  bbAbreItemClick(nil);
end;



procedure TParentTree.btPrintClick(Sender: TObject);
begin
  inherited;
  {
  with quTreeView do
    begin
      Open;
      grdTreeView.Visible := True;
      if not IsEmpty then
        begin
          if PrintDialog.Execute then
            with DbImpGrid do
              begin
                Title := Self.Caption + lblModulo.Caption;
                UserName := SisSenha.Usuario;
                FilterText := '';
                Print;
              end;
        end;
      grdTreeView.Visible := False;
      Close;
    end;
   }
end;

end.
