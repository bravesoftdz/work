unit uPurchaseFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ExtCtrls, cxLookAndFeelPainters, StdCtrls, cxButtons, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TSintegraPurchaseFrm = class(TForm)
    grdPurchaseDBTableView: TcxGridDBTableView;
    grdPurchaseLevel: TcxGridLevel;
    grdPurchase: TcxGrid;
    pnlBottom: TPanel;
    dsPurchase: TDataSource;
    btnOk: TcxButton;
    pnlFilter: TPanel;
    edtFirstPurchaseDate: TcxDateEdit;
    edtLastPurchaseDate: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnGo: TcxButton;
    grdPurchaseDBTableViewCodigoFornecedor: TcxGridDBColumn;
    grdPurchaseDBTableViewCFOP: TcxGridDBColumn;
    grdPurchaseDBTableViewCodigoProduto: TcxGridDBColumn;
    grdPurchaseDBTableViewQuantidade: TcxGridDBColumn;
    grdPurchaseDBTableViewValorTotal: TcxGridDBColumn;
    grdPurchaseDBTableViewValorImposto: TcxGridDBColumn;
    grdPurchaseDBTableViewPercImposto: TcxGridDBColumn;
    grdPurchaseDBTableViewFrete: TcxGridDBColumn;
    grdPurchaseDBTableViewOutrosCustos: TcxGridDBColumn;
    grdPurchaseDBTableViewNovoCusto: TcxGridDBColumn;
    grdPurchaseDBTableViewNF: TcxGridDBColumn;
    grdPurchaseDBTableViewDataRegistro: TcxGridDBColumn;
    grdPurchaseDBTableViewDataFatura: TcxGridDBColumn;
    grdPurchaseDBTableViewCNPJ: TcxGridDBColumn;
    grdPurchaseDBTableViewInscEstadual: TcxGridDBColumn;
    grdPurchaseDBTableViewGrupoFornecido: TcxGridDBColumn;
    grdPurchaseDBTableViewEstado: TcxGridDBColumn;
    grdPurchaseDBTableViewNomeFornecedor: TcxGridDBColumn;
    grdPurchaseDBTableViewProduto: TcxGridDBColumn;
    grdPurchaseDBTableViewCF: TcxGridDBColumn;
    procedure btnGoClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Start;
  end;

implementation

uses uDMSintegra;

{$R *.dfm}

{ TSintegraPurchaseFrm }

procedure TSintegraPurchaseFrm.Start;
begin
  edtFirstPurchaseDate.Date := Now;
  edtLastPurchaseDate.Date := Now;
  ShowModal;
end;

procedure TSintegraPurchaseFrm.btnGoClick(Sender: TObject);
begin
  with DMSintegra.quPurchase do
  begin
    if Active then
      Close;

    //FetchParams;
    Parameters.ParamByName('FirstDate').Value := edtFirstPurchaseDate.Date;
    Parameters.ParamByName('LastDate').Value := edtLastPurchaseDate.Date;
    Open;
  end;
end;

end.
