unit uFrmModelStateTax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Mask, SuperComboADO, ADODB, DB;

type
  TFrmModelStateTax = class(TFrmParent)
    btOk: TButton;
    lbState: TLabel;
    scEstado: TSuperComboADO;
    lbSaleTax: TLabel;
    scSaleTax: TSuperComboADO;
    lblDepartmentRequired: TLabel;
    Label1: TLabel;
    cmdInsertStateTax: TADOCommand;
    quConsultStateTax: TADODataSet;
    quConsultStateTaxIDModel: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    iIDModel : Integer;

    function Validate : Boolean;
    procedure SaveStateTax;
  public
    function Start(IDModel : Integer) : Boolean;
  end;

implementation

uses uDM, Math, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmModelStateTax }

function TFrmModelStateTax.Start(IDModel: Integer): Boolean;
begin
  iIDModel := IDModel;
  ShowModal;
  Result := True;
end;

procedure TFrmModelStateTax.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TFrmModelStateTax.Validate: Boolean;
begin

  Result := False;

  if scEstado.LookUpValue = '' then
  begin
    MsgBox(MSG_INF_SELECT_FIELD + '._' + Copy(lbState.Caption, 1, Length(lbState.Caption)-2), vbOKOnly + vbInformation);
    scEstado.SetFocus;
    Exit;
  end;

  if scSaleTax.LookUpValue = '' then
  begin
    MsgBox(MSG_INF_SELECT_FIELD + '._' + Copy(lbSaleTax.Caption, 1, Length(lbSaleTax.Caption)-2), vbOKOnly + vbInformation);
    Exit;
  end;

  with quConsultStateTax do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDModel').Value       := iIDModel;
    Parameters.ParamByName('IDEstado').Value      := scEstado.LookUpValue;
    Open;
    if not IsEmpty then
    begin
      MsgBox(MSG_EXC_MODEL_EXISTE, vbOKOnly + vbInformation);
      Exit;
    end;

  finally
    Close;
  end;

  Result := True;

end;

procedure TFrmModelStateTax.btOkClick(Sender: TObject);
begin
  inherited;

  if Validate then
  begin
    SaveStateTax;
    Close;
  end;

end;

procedure TFrmModelStateTax.SaveStateTax;
begin
  with cmdInsertStateTax do
  begin
    Parameters.ParamByName('IDModel').Value       := iIDModel;
    Parameters.ParamByName('IDEstado').Value      := scEstado.LookUpValue;
    Parameters.ParamByName('IDTaxCategory').Value := StrToInt(scSaleTax.LookUpValue);
    Execute;
  end;
end;

procedure TFrmModelStateTax.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
