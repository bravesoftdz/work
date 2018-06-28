unit uReducaoZList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, DBClient, Provider, ADODB, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, dxBar, cxLookAndFeelPainters,
  StdCtrls, cxButtons, ExtCtrls, uReducaoZFch, cxDropDownEdit, cxCalendar,
  cxContainer, cxTextEdit, cxMaskEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox;

type
  TReducaoZList = class(TForm)
    bmList: TdxBarManager;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    grdECF: TcxGrid;
    grdECFTableView: TcxGridDBTableView;
    grdECFTableViewIDECF: TcxGridDBColumn;
    grdECFTableViewNumeroECF: TcxGridDBColumn;
    grdECFTableViewNumeroSerie: TcxGridDBColumn;
    grdECFTableViewCashRegister: TcxGridDBColumn;
    grdECFTableViewStore: TcxGridDBColumn;
    grdECFLevel: TcxGridLevel;
    grdReducaoZ: TcxGrid;
    grdReducaoZTableView: TcxGridDBTableView;
    grdReducaoZLevel: TcxGridLevel;
    dsReducaoZ: TDataSource;
    quReducaoZ: TADOQuery;
    dspReducaoZ: TDataSetProvider;
    cdsReducaoZ: TClientDataSet;
    pnlBottom: TPanel;
    btnClose: TcxButton;
    pnlFilter: TPanel;
    deInicial: TcxDateEdit;
    deFinal: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    btGO: TcxButton;
    quReducaoZIDReducaoZ: TIntegerField;
    quReducaoZMovDate: TDateTimeField;
    quReducaoZNumeroSerie: TStringField;
    quReducaoZNumeroLoja: TIntegerField;
    quReducaoZNumeroECF: TIntegerField;
    quReducaoZNumReducaoZ: TIntegerField;
    quReducaoZCOOInicial: TIntegerField;
    quReducaoZCOOFinal: TIntegerField;
    quReducaoZNumCancelamentos: TIntegerField;
    quReducaoZValCancelamentos: TBCDField;
    quReducaoZValDescontos: TBCDField;
    quReducaoZGTInicial: TBCDField;
    quReducaoZGTFinal: TBCDField;
    quReducaoZSubstituicaoTrib: TBCDField;
    quReducaoZIsencao: TBCDField;
    grdReducaoZTableViewIDReducaoZ: TcxGridDBColumn;
    grdReducaoZTableViewMovDate: TcxGridDBColumn;
    grdReducaoZTableViewNumeroSerie: TcxGridDBColumn;
    grdReducaoZTableViewNumeroLoja: TcxGridDBColumn;
    grdReducaoZTableViewNumeroECF: TcxGridDBColumn;
    grdReducaoZTableViewNumReducaoZ: TcxGridDBColumn;
    grdReducaoZTableViewCOOInicial: TcxGridDBColumn;
    grdReducaoZTableViewCOOFinal: TcxGridDBColumn;
    grdReducaoZTableViewNumCancelamentos: TcxGridDBColumn;
    grdReducaoZTableViewValCancelamentos: TcxGridDBColumn;
    grdReducaoZTableViewValDescontos: TcxGridDBColumn;
    grdReducaoZTableViewGTInicial: TcxGridDBColumn;
    grdReducaoZTableViewGTFinal: TcxGridDBColumn;
    grdReducaoZTableViewSubstituicaoTrib: TcxGridDBColumn;
    grdReducaoZTableViewIsencao: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure dsReducaoZDataChange(Sender: TObject; Field: TField);
    procedure btGOClick(Sender: TObject);
  private
    FFch: TReducaoZFch;
  end;

implementation

uses uDMSintegra;

{$R *.dfm}

procedure TReducaoZList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TReducaoZList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FFch);
end;

procedure TReducaoZList.dsReducaoZDataChange(Sender: TObject;
  Field: TField);
begin
  bbEdit.Enabled := cdsReducaoZ.RecordCount > 0;
  bbDelete.Enabled := bbEdit.Enabled;
end;

procedure TReducaoZList.bbNewClick(Sender: TObject);
begin
  with FFch do
  try
    if not Assigned(FFch) then
      FFch := TReducaoZFch.Create(Self);

    FFch.Start(cdsReducaoZ);
    FFch.NewRecord;
  except
    on E: Exception do
      ShowMessage('Erro ao criar nova Redução Z. Erro: ' + E.Message);
  end;

  cdsReducaoZ.Refresh;
end;

procedure TReducaoZList.btGOClick(Sender: TObject);
begin
  with cdsReducaoZ do
  begin
    if Active then
      Close;

    FetchParams;
    Params.ParamByName('FirstDate').Value := deInicial.Date;
    Params.ParamByName('LastDate').Value := deFinal.Date;
    Open;
  end
end;

procedure TReducaoZList.FormCreate(Sender: TObject);
begin                 
  deInicial.Date := Now;
  deFinal.Date := Now;
end;

procedure TReducaoZList.bbEditClick(Sender: TObject);
begin
  with FFch do
  try
    if not Assigned(FFch) then
      FFch := TReducaoZFch.Create(Self);

    FFch.Start(cdsReducaoZ);
    FFch.EditRecord;
    cdsReducaoZ.ApplyUpdates(-1);
  except
    on E: Exception do
      ShowMessage('Erro ao editar ECF. Erro: ' + E.Message);
  end;

  cdsReducaoZ.Refresh;
end;

procedure TReducaoZList.bbDeleteClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente excluir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    cdsReducaoZ.Delete;
    cdsReducaoZ.ApplyUpdates(-1);
    cdsReducaoZ.Refresh;
  end;
end;

end.
