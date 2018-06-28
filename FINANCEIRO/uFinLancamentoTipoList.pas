unit uFinLancamentoTipoList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentList, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl, dxDBGrid, Db, Menus,
  ExtCtrls, dxDBGridPrint, dxBar, BrowseConfig, DBTables,
  ImgList, dxBarExtItems, StdCtrls, dxCntner, Buttons, ADODB,
  PowerADOQuery, dxPSCore, dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk,
  siComp, siLangRT;

type
  TFinLancamentoTipoList = class(TParentList)
    quBrowseIDLancamentoTipo: TIntegerField;
    quBrowseCodigoContabil: TStringField;
    quBrowseLancamentoTipo: TStringField;
    brwGridCodigoContabil: TdxDBGridMaskColumn;
    brwGridLancamentoTipo: TdxDBGridMaskColumn;
    brwGridTipo: TdxDBGridMaskColumn;
    quBrowsePath: TStringField;
    quBrowsePagando: TBooleanField;
    quBrowseTipo2: TStringField;
    brwGridGroup: TdxDBGridColumn;
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    sPaying,
    sReceiving : String;
  public
    { Public declarations }
  end;

implementation

uses uDMGlobal;

{$R *.DFM}

procedure TFinLancamentoTipoList.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;

  if not quBrowsePagando.AsBoolean then
     quBrowseTipo2.AsString := sReceiving
  else
     quBrowseTipo2.AsString := sPaying;
     
  //CASE LT.Pagando WHEN 0 THEN 'Receivable' WHEN 1 THEN 'Payable' END as Tipo

end;

procedure TFinLancamentoTipoList.FormCreate(Sender: TObject);
begin
  inherited;
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sPaying    := 'Payable';
           sReceiving := 'Receivable';
           end;
    LANG_PORTUGUESE :
           begin
           sPaying    := 'A Pagar';
           sReceiving := 'A Receber';
           end;

    LANG_SPANISH :
           begin
           sPaying    := 'Pagadero';
           sReceiving := 'Por cobrar';
           end;
  end;

end;

Initialization
  RegisterClass(TFinLancamentoTipoList);


end.
