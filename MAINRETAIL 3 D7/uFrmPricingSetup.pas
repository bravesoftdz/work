(*
-----------------------------------------------------------------------------------------------------

Version : (288 - 283)
Date    : 02.23.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Users don't uses 'Adjust Price' option.
Solution: Hide it. It's only design time change.
Version : (288 - 284)
-----------------------------------------------------------------------------------------------------
*)



unit uFrmPricingSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  Buttons;

type
  TFrmPricingSetup = class(TFrmParent)
    btnMargin: TSpeedButton;
    btnRounding: TSpeedButton;
    btnAdjustPrice: TSpeedButton;
    btnMarginTable: TSpeedButton;
    btnClassABC: TSpeedButton;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarginClick(Sender: TObject);
    procedure btnRoundingClick(Sender: TObject);
    procedure btnAdjustPriceClick(Sender: TObject);
    procedure btnMarginTableClick(Sender: TObject);
    procedure btnClassABCClick(Sender: TObject);
  private
    sMenu: String;
  public
    function Start:Boolean;
  end;

implementation

uses uDMGlobal, uDM, ubrwRound, ubrwMargem, uFrmModelPriceAdj, uSystemConst,
     uFrmMarginTable, uFrmInventoryConfig, PaiDeBrowses;

{$R *.dfm}

{ TFrmPricingSetup }

function TFrmPricingSetup.Start: Boolean;
begin

  btnMargin.Enabled      := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
  btnMarginTable.Enabled := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
  btnRounding.Enabled    := DM.fSystem.SrvParam[PARAM_CALC_ROUNDING];

  ShowModal;
  Result := (ModalResult = mrOK);
end;

procedure TFrmPricingSetup.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmPricingSetup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmPricingSetup.btnMarginClick(Sender: TObject);
begin
  inherited;
  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := btnMargin.Caption;
  try
    with TbrwMargem.Create(Self) do
     Start;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;
end;

procedure TFrmPricingSetup.btnRoundingClick(Sender: TObject);
begin
  inherited;
  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := btnRounding.Caption;
  try
    with TbrwRound.Create(Self) do
     Start;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;
end;

procedure TFrmPricingSetup.btnAdjustPriceClick(Sender: TObject);
begin
  inherited;
  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := btnAdjustPrice.Caption;
  try
    with TFrmModelPriceAdj.Create(Self) do
       Start('');
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;
end;

procedure TFrmPricingSetup.btnMarginTableClick(Sender: TObject);
begin
  inherited;
  sMenu := DM.fMainMenu.SubMenuName;
  DM.fMainMenu.SubMenuName := btnMarginTable.Caption;
  try
    with TFrmMarginTable.Create(Self) do
      Start;
      //amfsouza 01.28.2011
      BringToFront;
  finally
    DM.fMainMenu.SubMenuName := sMenu;
    end;
end;

procedure TFrmPricingSetup.btnClassABCClick(Sender: TObject);
begin
  inherited;
  with TFrmInventoryConfig.Create(Self) do
  try
    Start;
  finally
    Free;
  end;
end;

end.
