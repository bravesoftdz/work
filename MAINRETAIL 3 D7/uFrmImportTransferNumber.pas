unit uFrmImportTransferNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, ADODB, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TFrmImportTransferNumber = class(TFrmParentAll)
    Label1: TLabel;
    edtTransferNum: TEdit;
    btnSave: TButton;
    quTransfer: TADODataSet;
    quTransferIDModelTransf: TIntegerField;
    quTransferImported: TBooleanField;
    grdTransfers: TcxGrid;
    grdTransfersDB: TcxGridDBTableView;
    grdTransfersLevel: TcxGridLevel;
    dsTransfer: TDataSource;
    quTransferData: TDateTimeField;
    quTransferSystemUser: TStringField;
    quTransferStoreOrigem: TStringField;
    quTransferStoreDestino: TStringField;
    quTransferNumber: TStringField;
    grdTransfersDBData: TcxGridDBColumn;
    grdTransfersDBStoreOrigem: TcxGridDBColumn;
    grdTransfersDBStoreDestino: TcxGridDBColumn;
    grdTransfersDBNumber: TcxGridDBColumn;
    btnSearch: TBitBtn;
    procedure btnSaveClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure edtTransferNumChange(Sender: TObject);
  private
    FIDTranfer : Integer;
    function ValidateTransfer:Boolean;
    procedure RefreshTransfers;
  public
    function Start(var IDTransfer : Integer):Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmImportTransferNumber }

function TFrmImportTransferNumber.Start(var IDTransfer: Integer): Boolean;
begin
  FIDTranfer := -1;
  ShowModal;
  IDTransfer := FIDTranfer;
  Result := (FIDTranfer<>-1);
end;

function TFrmImportTransferNumber.ValidateTransfer: Boolean;
begin
  Result := True;

  if Trim(edtTransferNum.Text) = '' then
  begin
    MsgBox(MSG_INF_NOT_VALID_TRANFER_NUM, vbOKOnly + vbCritical);
    Result := False;
    Exit;
  end;

  with quTransfer do
  begin
    Try
      if IsEmpty then
        FIDTranfer := -1
      else
        FIDTranfer := quTransferIDModelTransf.AsInteger;

      if FIDTranfer = -1 then
      begin
        MsgBox(MSG_INF_NOT_FOUND_TRANFER_NUM, vbOKOnly + vbCritical);
        edtTransferNum.SelectAll;
        FIDTranfer := -1;
        Result := False;
      end
      else if (FieldByName('Imported').AsBoolean) then
      begin
        MsgBox(MSG_INF_TRANF_ALREADY_IMPORTED, vbOKOnly + vbCritical);
        edtTransferNum.SelectAll;
        FIDTranfer := -1;
        Result := False;
      end;
    finally
      if Result then
        Close;
    end;
  end;

end;

procedure TFrmImportTransferNumber.btnSaveClick(Sender: TObject);
begin
  inherited;
  if ValidateTransfer then
    Close;
end;

procedure TFrmImportTransferNumber.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmImportTransferNumber.RefreshTransfers;
begin

  with quTransfer do
  begin
    if Active then
      Close;
    Parameters.ParamByName('Number').Value := edtTransferNum.Text;
    Open;
  end;

end;

procedure TFrmImportTransferNumber.btnSearchClick(Sender: TObject);
begin
  inherited;
  RefreshTransfers;
  btnSearch.Default := False;
  btnSave.Default := True;
end;

procedure TFrmImportTransferNumber.edtTransferNumChange(Sender: TObject);
begin
  inherited;
  btnSearch.Default := True;
  btnSave.Default := False;
end;

end.
