unit uFrmSelectRebateCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  Mask, SuperComboADO;

type
  TFrmSelectRebateCalendar = class(TFrmParentAll)
    lblCalendar: TLabel;
    scRebateCalendar: TSuperComboADO;
    btOk: TButton;
    procedure btOkClick(Sender: TObject);
  private
    FIDRebateCalendar: Integer;
    FDescription: String;
    FDiscountPerc: Double;
    FStartDate: TDateTime;
    FEndDate: TDateTime;
  public
    function Start: Boolean;

    property IDRebateCalendar: Integer read FIDRebateCalendar write FIDRebateCalendar;
    property Description: String read FDescription write FDescription;
    property DiscountPerc: Double read FDiscountPerc write FDiscountPerc;
    property StartDate: TDateTime read FStartDate write FStartDate;
    property EndDate: TDateTime read FEndDate write FEndDate;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmSelectRebateCalendar }

function TFrmSelectRebateCalendar.Start: Boolean;
begin
  FIDRebateCalendar := -1;
  ShowModal;

  with scRebateCalendar do
    if ModalResult = mrOk then
    begin
      FIDRebateCalendar := StrToInt(LookUpValue);
      FDescription := GetFieldByName('Description');
      FDiscountPerc := GetFieldByName('DiscountPerc');
      FStartDate := GetFieldByName('StartDate');
      FEndDate := GetFieldByName('EndDate');
    end;
end;

procedure TFrmSelectRebateCalendar.btOkClick(Sender: TObject);
begin
  inherited;
  if scRebateCalendar.LookUpValue = '' then
  begin
    MsgBox(MSG_CRT_NO_VALID_SELECTION, vbInformation + vbOKOnly);
    ModalResult := mrNone;
  end;
end;

end.
