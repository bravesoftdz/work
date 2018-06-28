unit uSisMoedaCotacaoFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, Mask, StdCtrls, DBCtrls, Db, FormConfig, DBTables,
  Buttons, ExtCtrls, dxBar,
  dxDateEdit, dxDBDateEdit, ImgList, ADODB, PowerADOQuery, dxCntner,
  dxEditor, dxExEdtr, dxEdLib, dxDBELib, siComp, siLangRT;

type
  TSisMoedaCotacaoFch = class(TParentFch)
    Label1: TLabel;
    lblValorMoedaPadrao: TLabel;
    DBEdit2: TDBEdit;
    DBDateBox1: TdxDBDateEdit;
    Label25: TLabel;
    Label2: TLabel;
    quFormIDMoedaCotacao: TIntegerField;
    quFormIDMoeda: TIntegerField;
    quFormDataCotacao: TDateTimeField;
    quFormValorMoedaPadrao: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uDM;

procedure TSisMoedaCotacaoFch.FormShow(Sender: TObject);
begin
  inherited;
  // Pega no DM a moeda padrão e coloca na tela
  lblValorMoedaPadrao.Caption := 'Valor em ' + DM.MoedaPadrao;

end;

procedure TSisMoedaCotacaoFch.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormDataCotacao.AsDateTime := Now;
end;



end.
