unit uFrmTransporter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, StdCtrls, ExtCtrls, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient, ADODB;

type
  TFrmTransporter = class(TForm)
    pnlBottom: TPanel;
    btnOk: TButton;
    dsTransp: TDataSource;
    qryTransp: TADODataSet;
    qryTranspPessoa: TStringField;
    qryTranspEndereco: TStringField;
    qryTranspBairro: TStringField;
    qryTranspCidade: TStringField;
    qryTranspIDEstado: TStringField;
    qryTranspCEP: TStringField;
    qryTranspCGC: TStringField;
    qryTranspInscEstadual: TStringField;
    strepSaleItem: TcxStyleRepository;
    cxStyle: TcxStyle;
    cxStyleContent: TcxStyle;
    cxStyleContentEven: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyleHeader: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyleSelection: TcxStyle;
    cxStyleContent2: TcxStyle;
    cxStyleSelection2: TcxStyle;
    cxStyleHeader2: TcxStyle;
    GridTableViewStyleSheetDevExpress: TcxGridTableViewStyleSheet;
    grdItems: TcxGrid;
    grdItemsDB: TcxGridDBTableView;
    grdItemsLevel: TcxGridLevel;
    grdItemsDBPessoa: TcxGridDBColumn;
    grdItemsDBEndereco: TcxGridDBColumn;
    grdItemsDBBairro: TcxGridDBColumn;
    grdItemsDBCidade: TcxGridDBColumn;
    grdItemsDBIDEstado: TcxGridDBColumn;
    grdItemsDBCEP: TcxGridDBColumn;
    grdItemsDBCGC: TcxGridDBColumn;
    grdItemsDBInscEstadual: TcxGridDBColumn;
    qryTranspIDPessoa: TIntegerField;
  private
    { Private declarations }
  public
    procedure Start;
  end;

implementation

uses uFrmMain;

{$R *.dfm}

{ TFrmTransporter }

procedure TFrmTransporter.Start;
begin
  qryTransp.Open;
  ShowModal;
  qryTransp.Close;
end;

end.
