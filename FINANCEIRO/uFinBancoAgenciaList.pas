unit uFinBancoAgenciaList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables, Grids, StdCtrls, ExtCtrls, Buttons, dxBar,
  uParentList, dxDBGrid, dxDBGridPrint, dxBarExtItems, dxCntner, dxTL,
  ImgList, dxDBCtrl, ADODB, PowerADOQuery, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TFinBancoAgenciaList = class(TParentList)
    quBrowseIDBancoAgencia: TIntegerField;
    quBrowseCodigoBancoAgencia: TStringField;
    quBrowseBancoAgencia: TStringField;
    quBrowseCodigoBanco: TStringField;
    quBrowseBanco: TStringField;
    brwGridCodigoBancoAgencia: TdxDBGridMaskColumn;
    brwGridBancoAgencia: TdxDBGridMaskColumn;
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
  RegisterClass(TFinBancoAgenciaList);


end.
