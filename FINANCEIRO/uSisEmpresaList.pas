unit uSisEmpresaList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables,  StdCtrls, ExtCtrls, Grids,
  Buttons, dxBar, uParentList, dxDBGrid, dxDBGridPrint, dxBarExtItems, dxCntner,
  dxTL, ImgList, dxDBCtrl, ADODB, PowerADOQuery, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TSisEmpresaList = class(TParentList)
    quBrowseIDEmpresa: TIntegerField;
    quBrowseCodigoEmpresa: TStringField;
    quBrowseEmpresa: TStringField;
    quBrowseRazaoSocial: TStringField;
    brwGridCodigoEmpresa: TdxDBGridMaskColumn;
    brwGridEmpresa: TdxDBGridMaskColumn;
    brwGridRazaoSocial: TdxDBGridMaskColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


Initialization
  RegisterClass(TSisEmpresaList);


end.
