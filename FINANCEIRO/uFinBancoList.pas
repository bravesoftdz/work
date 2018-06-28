unit uFinBancoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables,  Grids, StdCtrls, ExtCtrls, Buttons, dxBar,
  uParentList, dxDBGridPrint, dxBarExtItems, dxCntner, dxTL, dxDBGrid,
  ImgList, dxDBCtrl, ADODB, PowerADOQuery, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TFinBancoList = class(TParentList)
    quBrowseIDBanco: TIntegerField;
    quBrowseCodigoBanco: TStringField;
    quBrowseBanco: TStringField;
    brwGridCodigoBanco: TdxDBGridMaskColumn;
    brwGridBanco: TdxDBGridMaskColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

Initialization
  RegisterClass(TFinBancoList);


end.
