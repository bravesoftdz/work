unit uFinCentroCustoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentList, Menus, ExtCtrls, dxDBGridPrint, dxBar, BrowseConfig, Db,
  DBTables, ImgList, dxBarExtItems, StdCtrls,
  dxCntner, dxTL, dxDBCtrl, dxDBGrid, Buttons, ADODB, PowerADOQuery,
  dxPSCore, dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TFinCentroCustoList = class(TParentList)
    quBrowseIDCentroCusto: TIntegerField;
    quBrowseCodigoCentroCusto: TStringField;
    quBrowseCentroCusto: TStringField;
    brwGridCodigoCentroCusto: TdxDBGridMaskColumn;
    brwGridCentroCusto: TdxDBGridMaskColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


Initialization
  RegisterClass(TFinCentroCustoList);


end.
