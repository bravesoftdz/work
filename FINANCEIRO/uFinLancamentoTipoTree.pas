unit uFinLancamentoTipoTree;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Uparenttree, Db, DBTables, dxBar, Grids,
  ComCtrls, DBTreeView, StdCtrls, ExtCtrls, Buttons, uParentTreeFch,
  dxtree, dxdbtree, ImgList, ADODB, siComp, siLangRT;

type
  TFinLancamentoTipoTree = class(TParentTreeFch)
    quTreeViewIDLancamentoTipo: TIntegerField;
    quTreeViewLancamentoTipo: TStringField;
    quTreeViewPath: TStringField;
    quTreeViewPathName: TStringField;
    quTreeViewCodigoContabil: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFinLancamentoTipoFch;


procedure TFinLancamentoTipoTree.FormCreate(Sender: TObject);
begin
  inherited;
  brwTreeForm := TFinLancamentoTipoFch.Create(Self);
end;

end.
