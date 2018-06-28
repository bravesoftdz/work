unit uFinLancamentoTipoListTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentTreeView, Db, ADODB, ImgList, dxBar, siComp, siLangRT, ComCtrls,
  dxtree, dxdbtree, StdCtrls, ExtCtrls;

type
  TFinLancamentoTipoListTree = class(TParentTreeView)
    quTreeViewIDLancamentoTipo: TIntegerField;
    quTreeViewIDLancamentoTipoParent: TIntegerField;
    quTreeViewLancamentoTipo: TStringField;
    quTreeViewCodigoContabil: TStringField;
    procedure DBTreeViewGetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function CanDeleteNode: Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses uFinLancamentoTipoFch;

{$R *.DFM}

function TFinLancamentoTipoListTree.CanDeleteNode: Boolean;
begin
  if quTreeViewIDLancamentoTipo.AsInteger in [0,1] then
    Result := False
  else
    Result := True;
end;

procedure TFinLancamentoTipoListTree.DBTreeViewGetImageIndex(
  Sender: TObject; Node: TTreeNode);
begin

  with Node do
  begin
    if Level = 0 then
      ImageIndex := 34
    else if HasChildren then
      ImageIndex := 35
    else
      ImageIndex := 0;
  end;
  
end;

procedure TFinLancamentoTipoListTree.FormCreate(Sender: TObject);
begin
  inherited;
  TreeViewForm := TFinLancamentoTipoFch.Create(Self);
end;

Initialization
  RegisterClass(TFinLancamentoTipoListTree);


end.
