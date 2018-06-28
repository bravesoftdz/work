unit uFrmApplyItemTax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO, ADODB, DB;

type
  TFrmApplyItemTax = class(TFrmParentAll)
    btnApply: TButton;
    Label29: TLabel;
    scSaleTax: TSuperComboADO;
    cmdApplyItemTax: TADOCommand;
    cmdApplyHoldTax: TADOCommand;
    spUpdateTotal: TADOStoredProc;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    FIDPreSale : Integer;
    FIDPreInvMov : Integer;
    FApplied : Boolean;
    procedure UpdateItemTax;
    procedure UpdateHoldTax;
    procedure CalcTotal;
  public
    function Start(IDPreSale, IDPreInvMov : Integer):Boolean;
  end;

implementation

uses uDM;

{$R *.dfm}

procedure TFrmApplyItemTax.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

function TFrmApplyItemTax.Start(IDPreSale, IDPreInvMov: Integer): Boolean;
begin
  FIDPreSale   := IDPreSale;
  FIDPreInvMov := IDPreInvMov;
  FApplied     := False;
  ShowModal;

  Result := FApplied;
end;

procedure TFrmApplyItemTax.btCloseClick(Sender: TObject);
begin
  inherited;
  FApplied := False;
  Close;
end;

procedure TFrmApplyItemTax.btnApplyClick(Sender: TObject);
begin
  inherited;
  if FIDPreInvMov <> -1 then
    UpdateItemTax
  else
    UpdateHoldTax;
  CalcTotal;
  FApplied := True;
  Close;
end;

procedure TFrmApplyItemTax.UpdateItemTax;
begin

  with cmdApplyItemTax do
  begin
    if scSaleTax.LookUpValue <> '' then
      Parameters.ParamByName('TaxID').Value := StrToInt(scSaleTax.LookUpValue)
    else
      Parameters.ParamByName('TaxID').Value := Null;
    Parameters.ParamByName('IDPreInventoryMov').Value := FIDPreInvMov;
    Execute;
  end;
  
end;

procedure TFrmApplyItemTax.UpdateHoldTax;
begin

  with cmdApplyHoldTax do
  begin
    if scSaleTax.LookUpValue <> '' then
      Parameters.ParamByName('IDTax').Value := StrToInt(scSaleTax.LookUpValue)
    else
      Parameters.ParamByName('IDTax').Value := Null;
    Parameters.ParamByName('IDPreSale').Value := FIDPreSale;
    Execute;
  end;

end;

procedure TFrmApplyItemTax.CalcTotal;
begin

  with spUpdateTotal do
  begin
    Parameters.ParamByName('@Date').Value := Now;
    Parameters.ParamByName('@PreSaleID').Value := FIDPreSale;
    ExecProc;
  end;

end;

end.
