unit uFrmNewPOTransfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, Buttons, DBCtrls, StdCtrls, Mask, SuperComboADO, DB,
  siComp, siLangRT, LblEffct, ExtCtrls, DBClient;

type
  TFrmNewPOTransfer = class(TFrmParent)
    dtsTransfer: TDataSource;
    lblModel: TLabel;
    lblSince: TLabel;
    lblTo: TLabel;
    lblQty: TLabel;
    lblDate: TLabel;
    lblUser: TLabel;
    cmbModel: TDBSuperComboADO;
    edtUser: TEdit;
    cmbTo: TDBSuperComboADO;
    cmbSince: TDBSuperComboADO;
    edtQty: TDBEdit;
    spHelp: TSpeedButton;
    btSave: TButton;
    edtDate: TDBEdit;
    procedure btSaveClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
     bResult: Boolean;
    function ValidateTransfer: Boolean;
  public
    { Public declarations }
      function Start(cds : TClientDataSet; IDModel : Integer): Boolean;
  end;

implementation

uses uFrmNewPO, uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmNewPOTransfer }

function TFrmNewPOTransfer.Start(cds : TClientDataSet; IDModel : Integer): Boolean;
begin
  bResult := False;
  dtsTransfer.DataSet := cds;
  cmbModel.LookUpValue := IntToStr(IDModel);
  ShowModal;
  if bResult then
    dtsTransfer.DataSet.Post
  else
    dtsTransfer.DataSet.Cancel;

  Result := bResult;
end;
    
procedure TFrmNewPOTransfer.btSaveClick(Sender: TObject);
begin
  if ValidateTransfer then
  begin
    dtsTransfer.DataSet.FieldByName('LojaOrigem').AsString  := cmbSince.Text;
    dtsTransfer.DataSet.FieldByName('LojaDestino').AsString := cmbTo.Text;
    dtsTransfer.DataSet.FieldByName('Model').AsString       := cmbModel.Text;
    dtsTransfer.DataSet.FieldByName('SystemUser').AsString  := edtUser.Text;
    bResult := True;
    Close;
    inherited;
  end;
end;

procedure TFrmNewPOTransfer.btCloseClick(Sender: TObject);
begin
  bResult := False;
  Close;
  inherited;
end;

function TFrmNewPOTransfer.ValidateTransfer: Boolean;
begin
  Result := False;
  if cmbSince.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_ORG_STORE, vbOkOnly + vbCritical);
    Exit;
  end;

  if cmbTo.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_DES_STORE, vbOkOnly + vbCritical);
    Exit;
  end;

  if cmbSince.LookUpValue = cmbTo.LookUpValue then
  begin
    MsgBox(MSG_INF_DIFER_STORE, vbOkOnly + vbCritical);
    Exit;
  end;

  if cmbModel.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_MODEL, vbOkOnly + vbCritical);
    Exit;
  end;

  if dtsTransfer.DataSet.FieldByName('qty').AsInteger <= 0 then
  begin
    MsgBox(MSG_CRT_QTY_BIGGER_0, vbOkOnly + vbCritical);
    Exit;
  end;

  Result := True;
end;

end.
