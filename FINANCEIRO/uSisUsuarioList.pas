unit uSisUsuarioList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables, StdCtrls, Grids, ExtCtrls, Buttons, dxBar,
  uParentList, dxDBGrid, dxDBGridPrint, dxBarExtItems, dxCntner, dxTL,
  ImgList, dxDBCtrl, ADODB, PowerADOQuery, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TSisUsuarioList = class(TParentList)
    quBrowseCodigoUsuario: TStringField;
    quBrowseUsuario: TStringField;
    brwGridCodigoUsuario: TdxDBGridMaskColumn;
    brwGridUsuario: TdxDBGridMaskColumn;
    quBrowseIDUser: TAutoIncField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}



Initialization
  RegisterClass(TSisUsuarioList);


end.
