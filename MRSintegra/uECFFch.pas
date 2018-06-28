unit uECFFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls, cxDBEdit,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, DB, DBClient;

type
  TECFFch = class(TForm)
    pnlBottom: TPanel;
    btCancel: TcxButton;
    btOk: TcxButton;
    luStore: TcxDBLookupComboBox;
    luCashRegister: TcxDBLookupComboBox;
    edECFNumber: TcxDBTextEdit;
    edSerialNumber: TcxDBTextEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dsFch: TDataSource;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
  private
    FDataSet: TClientDataSet;
    function ValidateECF: Boolean;
    function ValidateRequiredFields: Boolean;
  public
    procedure Start(ADataSet: TClientDataSet);
    procedure NewRecord;
    procedure EditRecord;
  end;

implementation

uses uDMSintegra, ADODB;

{$R *.dfm}

procedure TECFFch.FormCreate(Sender: TObject);
begin
  with DMSintegra do
  begin
    if quStore.Active then
      quStore.Close;
    quStore.Open;

    if quCashRegister.Active then
      quCashRegister.Close;
    quCashRegister.Open;
  end;
end;

procedure TECFFch.NewRecord;
begin
  FDataSet.Append;

  with DMSintegra.spGetNextCode do
  begin
    Parameters.ParamByName('@Tabela').Value := 'Sal_ECF.IDECF';
    ExecProc;
    FDataSet.FieldByName('IDECF').AsInteger := Parameters.ParamByName('@NovoCodigo').Value;
  end;

  ShowModal;
end;

procedure TECFFch.btOkClick(Sender: TObject);
begin
  if ValidateRequiredFields then
    if ValidateECF then
    begin
      if FDataSet.State in dsEditModes then
        FDataSet.Post;
      FDataSet.ApplyUpdates(-1);

      Close;
    end;
end;

procedure TECFFch.EditRecord;
begin
  FDataSet.Edit;
  ShowModal;
end;

procedure TECFFch.btCancelClick(Sender: TObject);
begin
  FDataSet.Cancel;
  Close;
end;

procedure TECFFch.Start(ADataSet: TClientDataSet);
begin
  FDataSet := ADataSet;
  dsFch.DataSet := FDataSet;  
end;

function TECFFch.ValidateECF: Boolean;
begin
  with DMSintegra.quFreeSQL do
  begin
    SQL.Text := 'SELECT * FROM Sal_ECF WHERE IDStore = :IDStore AND NumeroECF = :NumeroECF AND IDECF <> :IDECF';
    Parameters.ParamByName('IDECF').Value := FDataSet.FieldByName('IDECF').Value;
    Parameters.ParamByName('IDStore').Value := luStore.EditValue;
    Parameters.ParamByName('NumeroECF').Value := edECFNumber.Text;
    Open;
    Result := IsEmpty;

    Close;

    if Result then
    begin
      SQL.Text := 'SELECT * FROM Sal_ECF WHERE NumeroSerie = :NumeroSerie AND IDECF <> :IDECF';
    Parameters.ParamByName('IDECF').Value := FDataSet.FieldByName('IDECF').Value;
      Parameters.ParamByName('NumeroSerie').Value := edSerialNumber.Text;
      Open;
      Result := IsEmpty;

      if not Result then
        ShowMessage('Número de série já cadastrado.');
    end
    else
      ShowMessage('ECF já cadastrado para esta loja.');
  end;
end;

procedure TECFFch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FDataSet.State in dsEditModes then
    FDataSet.Cancel;
end;

function TECFFch.ValidateRequiredFields: Boolean;
begin
  Result := False;

  if luStore.EditValue = null then
  begin
    ShowMessage('Loja não preenchida.');
    Exit;
  end;

  if luCashRegister.EditValue = null then
  begin
    ShowMessage('Caixa não preenchida.');
    Exit;
  end;

  if edECFNumber.Text = '' then
  begin
    ShowMessage('ECF não preenchido.');
    Exit;
  end;

  if edSerialNumber.Text = '' then
  begin
    ShowMessage('Número de série não preenchido.');
    Exit;
  end;

  Result := True;
end;

end.
