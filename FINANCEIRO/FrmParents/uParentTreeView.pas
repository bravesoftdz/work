unit uParentTreeView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFixedFrm, Db, DBTables, ComCtrls, DBTreeView, Buttons,
  PanelRights, ExtCtrls, uParentFch, StdCtrls, dxBar, Grids,
  dxtree, dxdbtree, ImgList, ADODB, siComp, siLangRT;

type
  TParentTreeView = class(TParentFixedFrm)
    quTreeView: TADOQuery;
    bbNovoItem: TdxBarButton;
    bbAbreItem: TdxBarButton;
    bbRemoveItem: TdxBarButton;
    PrintDialog: TPrintDialog;
    btPrint: TdxBarButton;
    DBTreeView: TdxDBTreeView;
    quRefresh: TADOQuery;
    bbNovoSubItem: TdxBarButton;
    bbItemRestore: TdxBarButton;
    dsTreeView: TDataSource;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbNovoItemClick(Sender: TObject);
    procedure bbAbreItemClick(Sender: TObject);
    procedure bbRemoveItemClick(Sender: TObject);
    procedure DBTreeViewDblClick(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
    procedure quTreeViewBeforePost(DataSet: TDataSet);
    procedure bbNovoSubItemClick(Sender: TObject);
    procedure DBTreeViewGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure DBTreeViewGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure DBTreeViewCreateNewKeyValue(Sender: TObject;
      var NewKeyValue: Variant);
  private
    { Private declarations }
  protected
    TreeViewForm : TParentFch;
    procedure OnBeforeDeleteNode; virtual;
    function CanDeleteNode: Boolean; virtual;
  public
    { Public declarations }
    procedure Start(Parametro: String; UserRights: String; Suggestion : TStringList); Override;
  end;

implementation

{$R *.DFM}

uses uMsgBox, uSisSenha, uDM, uSQLFunctions, uSystemTypes, uMsgConstant;

procedure TParentTreeView.Start(Parametro: String; UserRights: String; Suggestion : TStringList);
begin
  OnBeforeStart;

  MyParametro := Parametro;
  WindowState := wsMaximized;

  lblModulo.Caption := self.Caption;
  lblModuloSadow.Caption := self.Caption;

  quTreeView.Open;

  // Monto a partir do TreeView a query que dará refresh no tree
  with quRefresh do
    begin
      SQL.Text := 'SELECT ' + DBTreeView.GetListField.FieldName +
                  ' FROM ' + GetSQLFirstTableName(quTreeView.SQL.Text) +
                  ' WHERE ' + DBTreeView.GetKeyField.FieldName +
                  ' = :ID';
      //Prepare;
    end;

  Show;

  OnAfterStart;
end;

procedure TParentTreeView.FormDestroy(Sender: TObject);
begin
  inherited;
  if TreeViewForm <> nil then TreeViewForm.Free;
  //quRefresh.Unprepare;
end;

procedure TParentTreeView.FormCreate(Sender: TObject);
begin
  inherited;
  TreeViewForm := nil;

end;

procedure TParentTreeView.bbNovoItemClick(Sender: TObject);
begin
  inherited;

  with DBTreeView do
    begin
      Selected := Items.Add(nil , 'Novo Item');

      if Selected <> nil then
        if TreeViewForm = nil then
           Selected.EditText
        else
           bbAbreItemClick(nil);
    end;

end;

procedure TParentTreeView.bbAbreItemClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;
  // trata a alteração
  if (TreeViewForm <> nil) then
    begin
      PosID1 := DBTreeView.GetKeyField.AsString;
      PosID2 := '';

      if TreeViewForm.Start(btAlt, nil, False, PosID1, PosID2, '', '', nil) then
        begin
          // Altero o list field para bater com a ficha
          quTreeView.Close;
          quTreeView.Open;
          quTreeView.Locate(DBTreeView.KeyField, PosID1, []);
        end;
    end
  else
    begin
      DBTreeView.Selected.EditText;
    end;
end;

procedure TParentTreeView.bbRemoveItemClick(Sender: TObject);
begin
  inherited;

  if CanDeleteNode then
    if MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes then
      begin
        // Como pode haver mais comandos incluidos no OnBeforeDeleteNode,
        // Abro uma transação por segurança
        try
          DM.DBADOConnection.BeginTrans;
          OnBeforeDeleteNode;
          DBTreeView.Selected.Delete;
          DM.DBADOCOnnection.CommitTrans;
        except
          DM.DBADOConnection.RollBackTrans;
          MsgBox(MSG_CRT_NOT_DEL_PURCHASE, vbCritical + vbOkOnly);
        end;
      end;
end;

procedure TParentTreeView.DBTreeViewDblClick(Sender: TObject);
begin
  inherited;
  bbAbreItemClick(nil);
end;



procedure TParentTreeView.btPrintClick(Sender: TObject);
begin
  inherited;
{  with quTreeView do
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

procedure TParentTreeView.quTreeViewBeforePost(DataSet: TDataSet);
begin
  inherited;
  // Garante que a parent vai ser Null
  with DBTreeView do
    begin
      if GetKeyField.AsVariant = GetParentField.AsVariant then
        GetParentField.Clear;
    end;

end;

procedure TParentTreeView.bbNovoSubItemClick(Sender: TObject);
begin
  inherited;

  with DBTreeView do
    begin
      Selected := Items.AddChild(DBTreeView.Selected  , 'Novo SubItem de ' + Selected.Text);

      if Selected <> nil then
        if TreeViewForm = nil then
           Selected.EditText
        else
           bbAbreItemClick(nil);

    end;


end;

procedure TParentTreeView.DBTreeViewGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  // Força ao selected index ser igual a imageindex
  Node.SelectedIndex := Node.ImageIndex;



end;

procedure TParentTreeView.DBTreeViewGetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  // Conforme o node, descobre qual a imagem
  with Node do
    if Level = 0 then
      ImageIndex := 35
    else
      ImageIndex := 36;

end;

procedure TParentTreeView.DBTreeViewCreateNewKeyValue(Sender: TObject;
  var NewKeyValue: Variant);
begin
  inherited;
  // Como estou em ambiente multi usuário, não posso confiar no dataset
  // tenho que ir ao servidor e buscar a maior key.

  NewKeyValue := DM.GetNextID(GetSQLFirstTableName(quTreeView.SQL.Text) + '.' +
                              DBTreeView.KeyField);
end;


procedure TParentTreeView.OnBeforeDeleteNode;
begin
  // Para ser modificado nos filhos

end;

function TParentTreeView.CanDeleteNode: Boolean;
begin
  Result := True;
end;

end.
