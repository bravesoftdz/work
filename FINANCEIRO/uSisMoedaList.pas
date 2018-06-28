unit uSisMoedaList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables, Grids, StdCtrls, ExtCtrls, Buttons, dxBar,
  uParentList, dxGrClms, dxDBGrid, dxDBGridPrint, dxBarExtItems, dxCntner,
  dxTL, ImgList, dxDBTLCl, dxDBCtrl, ADODB, PowerADOQuery, dxPSCore,
  dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TSisMoedaList = class(TParentList)
    quBrowseIDMoeda: TIntegerField;
    quBrowseCodigoMoeda: TStringField;
    quBrowseMoeda: TStringField;
    quBrowseSigla: TStringField;
    quBrowseValorMoedaPadrao: TFloatField;
    quBrowseDataCotacao: TDateTimeField;
    quBrowseMoedaPadrao: TBooleanField;
    brwGridMoeda: TdxDBGridMaskColumn;
    brwGridSigla: TdxDBGridMaskColumn;
    brwGridValorMoedaPadrao: TdxDBGridMaskColumn;
    brwGridDataCotacao: TdxDBGridDateColumn;
    brwGridMoedaPadrao: TdxDBGridCheckColumn;
    bbPadrao: TdxBarButton;
    spNovaPadrao: TADOStoredProc;
    procedure bbPadraoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uMsgBox, uMsgConstant;

procedure TSisMoedaList.bbPadraoClick(Sender: TObject);
begin
  inherited;
  if (quBrowseIDMoeda.AsString <> '')
     AND
     (MsgBox(MSG_INF_CHANGE_CURRENCY_RECALC,
             vbExclamation + vbYesNoCancel) = vbYes) then
      with spNovaPadrao do
        begin
          Parameters.ParamByName('@IDMoeda').Value := quBrowseIDMoeda.AsInteger;
          Parameters.ParamByName('@Data').Value := Now;
          ExecProc;
          Self.ListRefresh;
        end;

end;

Initialization
  RegisterClass(TSisMoedaList);


end.
