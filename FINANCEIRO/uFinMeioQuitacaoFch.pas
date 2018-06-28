unit uFinMeioQuitacaoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, FormConfig, Db, DBTables, 
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, dxBar, ImgList, ADODB,
  PowerADOQuery, siComp, siLangRT;

type
  TFinMeioQuitacaoFch = class(TParentFch)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    quFormIDQuitacaoMeio: TIntegerField;
    quFormCodigoQuitacaoMeio: TStringField;
    quFormQuitacaoMeio: TStringField;
    quFormDiasRetencao: TIntegerField;
    quFormTaxaDesconto: TFloatField;
    quFormVenda: TBooleanField;
    quFormDesativado: TBooleanField;
    quFormHidden: TBooleanField;
    quFormSystem: TBooleanField;
    Panel1: TPanel;
    TaxaDesconto: TDBEdit;
    Label4: TLabel;
    Label3: TLabel;
    DiasRetencao: TDBEdit;
    rbVenda: TDBCheckBox;
    procedure rbVendaClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}




procedure TFinMeioQuitacaoFch.rbVendaClick(Sender: TObject);
begin
  inherited;
  DiasRetencao.Enabled := rbVenda.Checked;
  TaxaDesconto.Enabled := rbVenda.Checked;

  if not rbVenda.Checked then
    begin
      quFormDiasRetencao.AsFloat := 0;
      quFormTaxaDesconto.AsFloat := 0;
    end;
end;

procedure TFinMeioQuitacaoFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  rbVendaClick(nil);
end;

end.
