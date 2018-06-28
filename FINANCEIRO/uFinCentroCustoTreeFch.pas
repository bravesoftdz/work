unit uFinCentroCustoTreeFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentTreeFch, StdCtrls, Mask, DBCtrls, Db, DBTables, dxBar, ComCtrls,
  dxtree, dxdbtree, Buttons, ExtCtrls, ImgList, ADODB, siComp, siLangRT;

type
  TFinCentroCustoTreeFch = class(TParentTreeFch)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    TblTreeViewsIDCentroCusto: TIntegerField;
    TblTreeViewsCentroCusto: TStringField;
    TblTreeViewsCodigoCentroCusto: TStringField;
    TblTreeViewsIDCentroCustoParent: TIntegerField;
    TblTreeViewsDesativado: TBooleanField;
    TblTreeViewsHidden: TBooleanField;
    TblTreeViewsSystem: TBooleanField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
