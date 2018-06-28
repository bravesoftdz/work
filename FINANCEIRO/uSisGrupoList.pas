unit uSisGrupoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables, Grids, ExtCtrls, Buttons, dxBar,
  uParentList, dxDBGrid, dxDBGridPrint, dxBarExtItems, dxCntner, dxTL,
  StdCtrls, ImgList, dxDBCtrl, ADODB, PowerADOQuery, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TSisGrupoList = class(TParentList)
    quBrowseIDGrupo: TIntegerField;
    quBrowseGrupo: TStringField;
    brwGridGrupo: TdxDBGridMaskColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


Initialization
  RegisterClass(TSisGrupoList);

end.
