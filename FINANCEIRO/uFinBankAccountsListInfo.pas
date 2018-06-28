unit uFinBankAccountsListInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentListInfo, Db, ADODB, PowerADOQuery, ImgList, dxBar, dxCntner,
  dxTL, dxDBCtrl, dxDBGrid, StdCtrls, Buttons, ExtCtrls, jpeg, siComp,
  siLangRT;

type
  TFinBankAccountsListInfo = class(TParentListInfo)
    quBrowseSaldoAtual: TBCDField;
    quBrowseNumero: TStringField;
    quBrowseIDContaCorrente: TIntegerField;
    quBrowseBanco: TStringField;
    gridSaldoAtual: TdxDBGridMaskColumn;
    gridNumero: TdxDBGridMaskColumn;
    gridBanco: TdxDBGridMaskColumn;
    procedure gridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure gridClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses uSystemConst;

{$R *.DFM}

procedure TFinBankAccountsListInfo.gridCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  inherited;

  if AColumn.Name = 'gridSaldoAtual' then
    if ANode.Values[AColumn.Index] < 0 then
        AFont.Color := clRed
    else
        AFont.Color := clGray;


end;

procedure TFinBankAccountsListInfo.gridClick(Sender: TObject);
begin
  inherited;


  MySugg.Clear;
  MySugg.Add(SUGG_CLASS+'=TSuperComboADO;'+
             SUGG_NAME +'=scContaCorrente;'+
             SUGG_VALUE+'='+quBrowseIDContaCorrente.AsString);

  //Call another Browse  
  CallBrowse; 

end;

Initialization
  RegisterClass(TFinBankAccountsListInfo);


end.
