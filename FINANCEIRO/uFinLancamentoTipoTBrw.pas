unit uFinLancamentoTipoTBrw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentTreeBrw, Db, DBTables, dxBar, ComCtrls, DBTreeView,
  StdCtrls, ExtCtrls, Grids;

type
  TFinLancamentoTipoTBrw = class(TParentTreeBrw)
    quTreeViewIDLancamentoTipo: TIntegerField;
    quTreeViewPath: TStringField;
    quTreeViewDesativado: TBooleanField;
    quTreeViewHidden: TBooleanField;
    quTreeViewLancamentoTipo: TStringField;
    quTreeViewCodigoContabil: TStringField;
    quTreeViewSintetico: TBooleanField;
    quTreeViewDescricao: TStringField;
    PrintDialog: TPrintDialog;
    dsTree: TDataSource;
    btPrint: TdxBarButton;
    procedure quTreeViewCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FinLancamentoTipoTBrw: TFinLancamentoTipoTBrw;

implementation

{$R *.DFM}

uses uFinLancamentoTipoFch, uSisSenha;

procedure TFinLancamentoTipoTBrw.quTreeViewCalcFields(DataSet: TDataSet);
begin
  inherited;
  // Calculo quais as imagens de cada node

  if quTreeViewSintetico.AsBoolean then
    begin
      quTreeViewImageIndex.AsInteger := 0;
      quTreeViewSelectedIndex.AsInteger := 1;
    end
  else
    begin
      quTreeViewImageIndex.AsInteger := 3;
      quTreeViewSelectedIndex.AsInteger := 3;
    end;

end;

procedure TFinLancamentoTipoTBrw.FormCreate(Sender: TObject);
begin
  inherited;
  brwTreeForm := TFinLancamentoTipoFch.Create(Self);

end;

procedure TFinLancamentoTipoTBrw.btPrintClick(Sender: TObject);
begin
  inherited;

end;

end.
