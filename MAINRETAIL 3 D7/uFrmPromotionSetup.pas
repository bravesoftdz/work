unit uFrmPromotionSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Buttons;

type
  TFrmPromotionSetup = class(TFrmParent)
    btnPromo: TSpeedButton;
    btnCalendar: TSpeedButton;
    btnBonusBucks: TSpeedButton;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPromoClick(Sender: TObject);
    procedure btnCalendarClick(Sender: TObject);
    procedure btnBonusBucksClick(Sender: TObject);
  private
    sMenu: String;
  public
    function Start: Boolean;
  end;

implementation

uses uDM, uFrmBonusBucks, uBrwRebateCalendar, uBrwPromo, uSystemConst;

{$R *.dfm}

procedure TFrmPromotionSetup.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPromotionSetup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPromotionSetup.btnPromoClick(Sender: TObject);
begin
  inherited;
  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := btnPromo.Caption;
  try
    with TbrwPromo.Create(Self) do
      Start;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;
end;

procedure TFrmPromotionSetup.btnCalendarClick(Sender: TObject);
begin
  inherited;
  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := btnCalendar.Caption;
  try
    with TbrwRebateCalendar.Create(Self) do
      Start;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
  end;
end;

procedure TFrmPromotionSetup.btnBonusBucksClick(Sender: TObject);
begin
  inherited;
  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := btnBonusBucks.Caption;
  try
    with TFrmBonusBucks.Create(Self) do
      Start;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
  end;
end;

function TFrmPromotionSetup.Start: Boolean;
begin
  btnPromo.Enabled      := DM.fSystem.SrvParam[PARAM_APPLY_PROMO_ON_SALE];
  btnCalendar.Enabled   := DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE];
  btnBonusBucks.Enabled := DM.fSystem.SrvParam[PARAM_APPLY_BONUS_ON_SALE];

  ShowModal;
  Result := (ModalResult = mrOK);
end;

end.
