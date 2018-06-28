unit uFinContaCorrenteList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables, Grids, StdCtrls, ExtCtrls, Buttons, dxBar,
  uParentList, dxDBGrid, dxDBGridPrint, dxBarExtItems, dxCntner, dxTL,
  ImgList, dxDBCtrl, ADODB, PowerADOQuery, dxPSCore, dxPSdxTLLnk,
  dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TFinContaCorrenteList = class(TParentList)
    quBrowseIDContaCorrente: TIntegerField;
    quBrowseCodigoContaCorrente: TStringField;
    quBrowseEmpresa: TStringField;
    quBrowseNumero: TStringField;
    quBrowseSaldoAtual: TFloatField;
    brwGridCodigoContaCorrente: TdxDBGridMaskColumn;
    brwGridContaCorrenteTipo: TdxDBGridMaskColumn;
    brwGridEmpresa: TdxDBGridMaskColumn;
    brwGridNumero: TdxDBGridMaskColumn;
    brwGridSaldoAtual: TdxDBGridMaskColumn;
    bbMostraSaldo: TdxBarButton;
    quBrowseTipo: TStringField;
    procedure bbMostraSaldoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uFinContaCorrenteFch;

procedure TFinContaCorrenteList.bbMostraSaldoClick(Sender: TObject);
begin
  inherited;
  brwGridSaldoAtual.Visible := bbMostraSaldo.Down;
end;

Initialization
  RegisterClass(TFinContaCorrenteList);


end.
