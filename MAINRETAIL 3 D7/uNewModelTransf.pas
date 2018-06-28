unit uNewModelTransf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, ExtCtrls, StdCtrls, Mask, Db, DBTables,
  Buttons, ADODB, SuperComboADO, siComp, siLangRT;

type
  TFrmNewModelTransf = class(TFrmParentAll)
    Label1: TLabel;
    Label2: TLabel;
    btnCancel: TButton;
    quNewTransf: TADOQuery;
    cmbLojaOrigem: TSuperComboADO;
    cmbLojaDestino: TSuperComboADO;
    edtTranferNumber: TEdit;
    Label3: TLabel;
    rgTranferType: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    MyIDModelTransf : integer;

    function ValidateTransf:Boolean;
  public
    { Public declarations }
     function Start : integer;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal;

{$R *.DFM}

function TFrmNewModelTransf.ValidateTransf:Boolean;
begin

   Result := True;

  if cmbLojaOrigem.LookUpValue = '' then
     begin
     cmbLojaOrigem.SetFocus;
     MsgBox(MSG_CRT_NO_ORG_STORE, vbOKOnly + vbCritical);
     Result := False;
     Exit;
     end;

  if cmbLojaDestino.LookUpValue = '' then
     begin
     cmbLojaDestino.SetFocus;
     MsgBox(MSG_CRT_NO_DES_STORE, vbOKOnly + vbCritical);
     Result := False;
     Exit;
     end;

  if cmbLojaDestino.LookUpValue = cmbLojaOrigem.LookUpValue then
     begin
     cmbLojaDestino.SetFocus;
     MsgBox(MSG_INF_DIFER_STORE, vbOKOnly + vbInformation);
     Result := False;
     end;

end;

function TFrmNewModelTransf.Start : integer;
begin
  if ShowModal = mrOk then
     Result := MyIDModelTransf
  else
     Result := 0;
end;

procedure TFrmNewModelTransf.FormShow(Sender: TObject);
begin
  inherited;
  cmbLojaOrigem.LookUpValue  := IntToStr(DM.fStore.ID);
  cmbLojaDestino.LookUpValue := '';
  rgTranferType.SetFocus;
end;

procedure TFrmNewModelTransf.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TFrmNewModelTransf.btCloseClick(Sender: TObject);
begin
  inherited;

  if not ValidateTransf then
     Exit;

  MyIDModelTransf := DM.GetNextID('ModelTransf.IDModelTransf');

  with quNewTransf do
     begin
     Parameters.ParambyName('IDModelTransf').Value := MyIDModelTransf;
     Parameters.ParambyName('IDLojaOrigem').Value  := StrToInt(cmbLojaOrigem.LookUpValue);
     Parameters.ParambyName('IDLojaDestino').Value := StrToInt(cmbLojaDestino.LookUpValue);
     Parameters.ParambyName('IDUser').Value        := DM.fUser.ID;
     Parameters.ParambyName('Data').Value          := Now;
     Parameters.ParambyName('Number').Value        := edtTranferNumber.Text;
     Parameters.ParambyName('TransferType').Value  := rgTranferType.ItemIndex;
     ExecSQL;
     end;

  ModalResult := mrOK;
  
end;


procedure TFrmNewModelTransf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
