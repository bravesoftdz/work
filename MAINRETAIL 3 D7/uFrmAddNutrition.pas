unit uFrmAddNutrition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, ADODB;

type
  TFrmAddNutrition = class(TFrmParentAll)
    cmbNutrition: TSuperComboADO;
    Label1: TLabel;
    btnOK: TButton;
    cmdInsertNutriItem: TADOCommand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    bResult : Boolean;
    FIDModel : Integer;
    procedure InsertModelNutrition;
  public
    function Start(IDModel : Integer) : Boolean;
  end;

implementation

uses uDM, uDMParent;

{$R *.dfm}

procedure TFrmAddNutrition.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmAddNutrition.btCloseClick(Sender: TObject);
begin
  inherited;
  bResult := False;
  Close;
end;

function TFrmAddNutrition.Start(IDModel : Integer): Boolean;
begin
  FIDModel := IDModel;
  ShowModal;
  Result := bResult;
end;

procedure TFrmAddNutrition.InsertModelNutrition;
begin

  with cmdInsertNutriItem do
  begin
    Parameters.ParamByName('IDModel').Value     := FIDModel;
    Parameters.ParamByName('IDNutrition').Value := StrToInt(cmbNutrition.LookUpValue);
    Execute;
  end;
  
end;

procedure TFrmAddNutrition.btnOKClick(Sender: TObject);
begin
  inherited;
  if (cmbNutrition.LookUpValue <> '') then
  begin
    InsertModelNutrition;
    bResult := True;
    Close;
  end;
end;

end.
