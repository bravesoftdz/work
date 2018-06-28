unit uSaleFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, StdCtrls, cxLookAndFeelPainters, cxButtons;

type
  TSintegraSaleFrm = class(TForm)
    grdSaleDBTableView: TcxGridDBTableView;
    grdSaleLevel: TcxGridLevel;
    grdSale: TcxGrid;
    pnlBottom: TPanel;
    dsSale: TDataSource;
    pnlFilter: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtFirstSaleDate: TcxDateEdit;
    edtLastSaleDate: TcxDateEdit;
    btnGo: TcxButton;
    btnOk: TcxButton;
    grdSaleDBTableViewCodigoFornecedor: TcxGridDBColumn;
    grdSaleDBTableViewCodigoProduto: TcxGridDBColumn;
    grdSaleDBTableViewQuantidade: TcxGridDBColumn;
    grdSaleDBTableViewValorTotal: TcxGridDBColumn;
    grdSaleDBTableViewValorImposto: TcxGridDBColumn;
    grdSaleDBTableViewPercImposto: TcxGridDBColumn;
    grdSaleDBTableViewFrete: TcxGridDBColumn;
    grdSaleDBTableViewOutrosCustos: TcxGridDBColumn;
    grdSaleDBTableViewNovoCusto: TcxGridDBColumn;
    grdSaleDBTableViewNF: TcxGridDBColumn;
    grdSaleDBTableViewDataRegistro: TcxGridDBColumn;
    grdSaleDBTableViewDataFatura: TcxGridDBColumn;
    grdSaleDBTableViewCPF: TcxGridDBColumn;
    grdSaleDBTableViewInscEstadual: TcxGridDBColumn;
    grdSaleDBTableViewGrupoFornecido: TcxGridDBColumn;
    grdSaleDBTableViewEstado: TcxGridDBColumn;
    grdSaleDBTableViewNomeCliente: TcxGridDBColumn;
    grdSaleDBTableViewProduto: TcxGridDBColumn;
    grdSaleDBTableViewCF: TcxGridDBColumn;
    procedure btnGoClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Start;
  end;

implementation

uses uDMSintegra;

{$R *.dfm}

{ TSintegraSaleFrm }

procedure TSintegraSaleFrm.Start;
begin
  edtFirstSaleDate.Date := Now;
  edtLastSaleDate.Date := Now;
  ShowModal;
end;

procedure TSintegraSaleFrm.btnGoClick(Sender: TObject);
begin
  with DMSintegra.quSale do
  begin
    if Active then
      Close;

    //FetchParams;
    Parameters.ParamByName('FirstDate').Value := edtFirstSaleDate.Date;
    Parameters.ParamByName('LastDate').Value := edtLastSaleDate.Date;
    Open;
  end;
end;

end.
