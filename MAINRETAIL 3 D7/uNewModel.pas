unit uNewModel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, StdCtrls, Mask, ExtCtrls, Buttons,
  SuperComboADO, siComp, siLangRT;

type
  TNewModel = class(TFrmParentAll)
    btOK: TButton;
    cmbModel: TSuperComboADO;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cmbModelChange(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(var IDModel : Integer) : Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal;

{$R *.DFM}

function TNewModel.Start(var IDModel : Integer) : Boolean;
begin
  Result := (ShowModal = mrOK);
  if Result then
     IDModel := StrToInt(cmbModel.LookUpValue)
  else
     IDModel := 0;
end;

procedure TNewModel.FormShow(Sender: TObject);
begin
  inherited;
  cmbModel.LookUpValue := '';
  cmbModel.SetFocus;
  btOK.Enabled := False;
end;

procedure TNewModel.cmbModelChange(Sender: TObject);
begin
  inherited;
  if cmbModel.Text <> '' then
     btOK.Enabled := True;
end;

procedure TNewModel.btOKClick(Sender: TObject);
begin
  inherited;
  if cmbModel.LookUpValue = '' then
    begin
     MsgBox(MSG_CRT_NO_MODEL, vbOkOnly + vbInformation);
     Exit;
    end;

  ModalResult := mrOK;
end;

procedure TNewModel.btCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TNewModel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
