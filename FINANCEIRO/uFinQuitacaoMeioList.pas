unit uFinQuitacaoMeioList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables,
  Grids,StdCtrls, ExtCtrls, Buttons, dxBar,
  uParentList, dxDBGridPrint, dxBarExtItems, dxCntner, dxTL, dxDBGrid,
  ImgList, dxDBCtrl, ADODB, PowerADOQuery, jpeg, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TFinQuitacaoMeioList = class(TParentList)
    quBrowseIDMeioPag: TIntegerField;
    quBrowseCodigoMeioPag: TStringField;
    quBrowseMeioPag: TStringField;
    quBrowseType: TStringField;
    brwGridCodigoMeioPag: TdxDBGridMaskColumn;
    brwGridMeioPag: TdxDBGridMaskColumn;
    brwGridType: TdxDBGridMaskColumn;
    quBrowseParent: TStringField;
    brwGridParent: TdxDBGridMaskColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.DFM}

Initialization
  RegisterClass(TFinQuitacaoMeioList);


end.
