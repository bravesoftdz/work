unit uParentTreeFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFixedFrm, Db, DBTables, ComCtrls, DBTreeView, Buttons,
  ExtCtrls, uParentFch, StdCtrls, dxBar, Grids, dxtree, dxdbtree, ImgList,
  ADODB, siComp, siLangRT;

type
  TParentTreeFch = class(TParentFixedFrm)
    quTreeView: TADOQuery;
    bbNovoItem: TdxBarButton;
    bbRemoveItem: TdxBarButton;
    ilTreeSmall: TImageList;
    quTreeViewImageIndex: TIntegerField;
    quTreeViewSelectedIndex: TIntegerField;
    PrintDialog: TPrintDialog;
    dsTreeView: TDataSource;
    btPrint: TdxBarButton;
    pnlFicha: TPanel;
    spliterFicha: TSplitter;
    tvMain: TdxDBTreeView;
    bbNovoSubItem: TdxBarButton;
    TblTreeViews: TADOTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbNovoItemClick(Sender: TObject);
    procedure bbRemoveItemClick(Sender: TObject);
    procedure bbNovoSubItemClick(Sender: TObject);
    procedure quTreeViewAfterInsert(DataSet: TDataSet);
    procedure TblTreeViewsAfterInsert(DataSet: TDataSet);
    procedure TblTreeViewsAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure OnStart; override;
  protected
    brwTreeForm : TParentFch;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uMsgBox, uSisSenha, uDM;

procedure TParentTreeFch.OnStart;
begin
  tblTreeViews.Open;

end;
procedure TParentTreeFch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  tblTreeViews.Close;
  Action := caFree;
end;

procedure TParentTreeFch.bbNovoItemClick(Sender: TObject);
begin
  inherited;
  tvMain.Items.Add(tvMain.Selected, 'New Item');

end;

procedure TParentTreeFch.bbNovoSubItemClick(Sender: TObject);
begin
  if (tvMain.Selected <> Nil) then
    tvMain.Items.AddChild(tvMain.Selected,'Child of ' + tvMain.Selected.Text);
end;

procedure TParentTreeFch.bbRemoveItemClick(Sender: TObject);
begin
  inherited;
  tblTreeViews.Delete;
end;

procedure TParentTreeFch.quTreeViewAfterInsert(DataSet: TDataSet);
//var
//  KeyField, ParentField: TIntegerField;

begin
  inherited;
  {
  KeyField := tblTreeViews.FieldByName(tvMain.KeyField) as TIntegerField;

  if (KeyField.AsString <> '') then
    begin
      if VarIsNull(tvMain.DBTreeNodes.MaxKeyFieldValue) then
        KeyField.AsInteger := 1000
    else KeyField.AsInteger := tvMain.DBTreeNodes.MaxKeyFieldValue + 1;
  end;
   }
end;

procedure TParentTreeFch.TblTreeViewsAfterInsert(DataSet: TDataSet);
var
  KeyField, ParentField: TIntegerField;

begin
  inherited;

  KeyField := tblTreeViews.FieldByName(tvMain.KeyField) as TIntegerField;

  if (KeyField.AsString <> '') then
    begin
      if VarIsNull(tvMain.DBTreeNodes.MaxKeyFieldValue) then
        KeyField.AsInteger := 1000
    else KeyField.AsInteger := tvMain.DBTreeNodes.MaxKeyFieldValue + 1;
  end;

end;

procedure TParentTreeFch.TblTreeViewsAfterPost(DataSet: TDataSet);
var
  sDisplay: String;

begin
  inherited;
  tvMain.Repaint;

end;

end.
