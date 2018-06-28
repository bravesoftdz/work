unit uFinLancamentoTipoTreeFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentTreeFch, Db, DBTables, dxBar, ComCtrls, DBTreeView, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, Mask, dxtree, dxdbtree, Grids, DBGrids,
  ImgList, ADODB, siComp, siLangRT;

type
  TFinLancamentoTipoTreeFch = class(TParentTreeFch)
    DBEdit4: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    rgTipo: TDBRadioGroup;
    DBRadioGroup1: TDBRadioGroup;
    DBGrid1: TDBGrid;
    TblTreeViewsIDLancamentoTipo: TIntegerField;
    TblTreeViewsLancamentoTipo: TStringField;
    TblTreeViewsIDPessoa: TIntegerField;
    TblTreeViewsIDPessoaTipo: TIntegerField;
    TblTreeViewsPath: TStringField;
    TblTreeViewsPathName: TStringField;
    TblTreeViewsIDContaCorrenteDefault: TIntegerField;
    TblTreeViewsPagando: TBooleanField;
    TblTreeViewsSystem: TBooleanField;
    TblTreeViewsHidden: TBooleanField;
    TblTreeViewsDesativado: TBooleanField;
    TblTreeViewsPermitePessoaNula: TBooleanField;
    TblTreeViewsSugerePessoa: TBooleanField;
    TblTreeViewsPessoaFixa: TBooleanField;
    TblTreeViewsSugereContaCorrente: TBooleanField;
    TblTreeViewsContaCorrenteFixa: TBooleanField;
    TblTreeViewsCodigoContabil: TStringField;
    TblTreeViewsSintetico: TBooleanField;
    TblTreeViewsIDLancamentoTipoParent: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
