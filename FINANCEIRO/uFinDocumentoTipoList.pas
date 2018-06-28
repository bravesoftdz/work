unit uFinDocumentoTipoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables, Grids, StdCtrls, ExtCtrls, Buttons, dxBar,
  uParentList, dxDBGrid, dxDBGridPrint, dxBarExtItems, dxCntner, dxTL,
  ImgList, dxDBCtrl, ADODB, PowerADOQuery, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TFinDocumentoTipoList = class(TParentList)
    quBrowseIDDocumentoTipo: TIntegerField;
    quBrowseCodigoDocumentoTipo: TStringField;
    quBrowseDocumentoTipo: TStringField;
    brwGridCodigoDocumentoTipo: TdxDBGridMaskColumn;
    brwGridDocumentoTipo: TdxDBGridMaskColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

Initialization
  RegisterClass(TFinDocumentoTipoList);


end.
