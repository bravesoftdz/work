unit uFrmNewInvoiceOBS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, StdCtrls, siComp, siLangRT, LblEffct, ExtCtrls, DB,
  ADODB;

type
  TFrmNewInvoiceOBS = class(TFrmParent)
    mmObs: TMemo;
    lblObs: TLabel;
    cbxType: TComboBox;
    lblType: TLabel;
    btSave: TButton;
    cmdInsertOBS: TADOCommand;
    Label37: TLabel;
    Label1: TLabel;
    procedure btSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    function Start: Boolean;
  end;

implementation

uses uDM, uSystemConst;

{$R *.dfm}

{ TFrmNewInvoiceOBS }

function TFrmNewInvoiceOBS.Start: Boolean;
begin
  mmObs.Clear;
  ShowModal;
  Result := ModalResult = mrOk;
end;

procedure TFrmNewInvoiceOBS.btSaveClick(Sender: TObject);
var
  iIDOBS: Integer;
begin
  inherited;
  if mmObs.Text = '' then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  iIDOBS := DM.GetNextID('Mnt_DefaultInvoiceOBS.IDDefaultInvoiceOBS');

  with cmdInsertOBS do
  begin
    Parameters.ParamByName('IDDefaultInvoiceOBS').Value := iIDOBS;
    Parameters.ParamByName('OBSType').Value := cbxType.ItemIndex + 1;
    Parameters.ParamByName('DefaultInvoiceOBS').Value := mmObs.Text;

    Execute;
  end;
end;

end.
