unit uSisFeriadoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, BrowseConfig, Db, Menus, DBTables, dxBar,
  Grids, StdCtrls, Buttons, uParentList,
  dxDBGrid, dxGrClms, dxDBGridPrint, dxBarExtItems, dxCntner, dxTL, ImgList,
  dxDBCtrl, dxDBTLCl, ADODB, PowerADOQuery, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TSisFeriadoList = class(TParentList)
    quBrowseIDFeriado: TIntegerField;
    quBrowseData: TDateTimeField;
    quBrowseFeriado: TStringField;
    brwGridData: TdxDBGridDateColumn;
    brwGridFeriado: TdxDBGridMaskColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}


Initialization
  RegisterClass(TSisFeriadoList);


end.
