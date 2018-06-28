unit uECFList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls, dxBar, uECFFch,
  DBClient, Provider, ADODB;

type
  TECFList = class(TForm)
    grdECF: TcxGrid;
    grdECFTableView: TcxGridDBTableView;
    grdECFLevel: TcxGridLevel;
    dsECF: TDataSource;
    pnlBottom: TPanel;
    btnClose: TcxButton;
    grdECFTableViewIDECF: TcxGridDBColumn;
    grdECFTableViewNumeroECF: TcxGridDBColumn;
    grdECFTableViewNumeroSerie: TcxGridDBColumn;
    grdECFTableViewCashRegister: TcxGridDBColumn;
    grdECFTableViewStore: TcxGridDBColumn;
    bmList: TdxBarManager;
    bbNew: TdxBarButton;
    bbEdit: TdxBarButton;
    bbDelete: TdxBarButton;
    quECF: TADOQuery;
    quECFIDECF: TIntegerField;
    quECFIDStore: TIntegerField;
    quECFIDCashRegister: TIntegerField;
    quECFNumeroECF: TIntegerField;
    quECFNumeroSerie: TStringField;
    quECFCashRegister: TStringField;
    quECFStore: TStringField;
    dspECF: TDataSetProvider;
    cdsECF: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbNewClick(Sender: TObject);
    procedure bbEditClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure dsECFDataChange(Sender: TObject; Field: TField);
  private
    FFch: TECFFch;
  public
    function Start: boolean;
  end;

implementation

uses uDMSintegra;

{$R *.dfm}

procedure TECFList.bbNewClick(Sender: TObject);
begin
  with FFch do
  try
    if not Assigned(FFch) then
      FFch := TECFFch.Create(Self);

    FFch.Start(cdsECF);
    FFch.NewRecord;
  except
    on E: Exception do
      ShowMessage('Erro ao criar novo ECF. Erro: ' + E.Message);
  end;

  cdsECF.Refresh;
end;

procedure TECFList.bbEditClick(Sender: TObject);
begin
  with FFch do
  try
    if not Assigned(FFch) then
      FFch := TECFFch.Create(Self);

    FFch.Start(cdsECF);
    FFch.EditRecord;
    cdsECF.ApplyUpdates(-1);
  except
    on E: Exception do
      ShowMessage('Erro ao editar ECF. Erro: ' + E.Message);
  end;

  cdsECF.Refresh;
end;

procedure TECFList.FormDestroy(Sender: TObject);
begin
  with DMSintegra do
  begin
    quStore.Close;
    quCashRegister.Close;
  end;
  
  FreeAndNil(FFch);
end;

procedure TECFList.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TECFList.bbDeleteClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente excluir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    cdsECF.Delete;
    cdsECF.ApplyUpdates(-1);
    cdsECF.Refresh;
  end;
end;

procedure TECFList.dsECFDataChange(Sender: TObject; Field: TField);
begin
  bbEdit.Enabled := cdsECF.RecordCount > 0;
  bbDelete.Enabled := bbEdit.Enabled;
end;

function TECFList.Start: boolean;
begin
  ShowModal;
  Result := True;
end;

procedure TECFList.FormCreate(Sender: TObject);
begin
  cdsECF.Open;
end;

end.
