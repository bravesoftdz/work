unit uFrmModelGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideFichaTab, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, ComCtrls, StdCtrls, Buttons, LblEffct, ExtCtrls, DBCtrls, Mask,
  SuperComboADO, uDMCalcPrice, uMsgBox;

type
  TbrwFrmModelGroup = class(TbrwFrmTabParent)
    tsPricing: TTabSheet;
    Panel9: TPanel;
    lbQuestion: TLabel;
    pnSalePrice: TPanel;
    scSalePriceMargemType: TDBSuperComboADO;
    dbSalePricePercent: TDBEdit;
    cbSalePrice: TComboBox;
    Panel13: TPanel;
    lbQuestion2: TLabel;
    pnMSRP: TPanel;
    scMSRPMargemType: TDBSuperComboADO;
    dbMSRPPercent: TDBEdit;
    cbMSRP: TComboBox;
    quFormIDModelGroup: TIntegerField;
    quFormModelGroup: TStringField;
    quFormIDGroup: TIntegerField;
    quFormSalePriceMargemPercent: TFloatField;
    quFormUseSalePricePercent: TBooleanField;
    quFormIDSalePriceMargemTable: TIntegerField;
    quFormIDMSRPMargemTable: TIntegerField;
    quFormMSRPMargemPercent: TFloatField;
    quFormUseMSRPPercent: TBooleanField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label20: TLabel;
    cmbGroup: TDBSuperComboADO;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    lbUserCode: TLabel;
    quFormUserCode: TStringField;
    chkRecalcPrices: TCheckBox;
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure cbSalePriceChange(Sender: TObject);
    procedure cbMSRPChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbSalePricePercentKeyPress(Sender: TObject; var Key: Char);
    procedure scSalePriceMargemTypeSelectItem(Sender: TObject);
    procedure chkRecalcPricesClick(Sender: TObject);
  private
    FRecalcChanged: Boolean;
    FCalcPriceType : TCalcPriceType;
    fIDGroup : Integer;
  protected
     procedure OnBeforeStart; override;
     procedure OnAfterCommit; override;
  end;

implementation

uses uParamFunctions, uDM, uSystemConst, uMsgConstant, uFrmMarginTableUpdate,
  PaiDeFichas;

{$R *.dfm}

procedure TbrwFrmModelGroup.OnBeforeStart;
begin
  inherited;
  fIDGroup             := StrToInt(ParseParam(Self.sParam, 'IDGroup'));
  PageControl.Visible  := DM.fSystem.SrvParam[PARAM_CALC_MARGIN];
end;

procedure TbrwFrmModelGroup.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if quFormUseMSRPPercent.AsBoolean = True then
  begin
    cbMSRP.ItemIndex         := 0;
    scMSRPMargemType.Visible := False;
    dbMSRPPercent.Visible    := True;
  end
  else
  begin
    cbMSRP.ItemIndex         := 1;
    dbMSRPPercent.Visible    := False;
    scMSRPMargemType.Visible := True;
  end;

  if quFormUseSalePricePercent.AsBoolean = True then
  begin
    cbSalePrice.ItemIndex         := 0;
    scSalePriceMargemType.Visible := False;
    dbSalePricePercent.Visible    := True;
  end
  else
  begin
    cbSalePrice.ItemIndex         := 1;
    dbSalePricePercent.Visible    := False;
    scSalePriceMargemType.Visible := True;
  end;
end;

procedure TbrwFrmModelGroup.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  with quForm do
  begin
    FRecalcChanged := True;

    if chkRecalcPrices.Checked then
       FCalcPriceType := cptBoth
    else
       FRecalcChanged := False;
  end;

  if cbSalePrice.ItemIndex = 0 then
  begin
    quFormUseSalePricePercent.AsBoolean   := True;
    quFormIDSalePriceMargemTable.AsString := '';
  end
  else
  begin
    quFormUseSalePricePercent.AsBoolean     := False;
    quFormSalePriceMargemPercent.AsCurrency := 0;
  end;

  if cbMSRP.ItemIndex = 0 then
  begin
    quFormUseMSRPPercent.AsBoolean   := True;
    quFormIDMSRPMargemTable.AsString := '';
  end
  else
  begin
    quFormUseMSRPPercent.AsBoolean     := False;
    quFormMSRPMargemPercent.AsCurrency := 0;
  end;
end;

procedure TbrwFrmModelGroup.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIDGroup.AsInteger             := fIDGroup;
  quFormUseSalePricePercent.AsBoolean := True;
  quFormUseMSRPPercent.AsBoolean      := True;
end;

procedure TbrwFrmModelGroup.cbSalePriceChange(Sender: TObject);
begin
  inherited;
  quForm.Edit;
  
  if cbSalePrice.ItemIndex = 0 then
  begin
    dbSalePricePercent.Visible    := True;
    scSalePriceMargemType.Text    := '';
    scSalePriceMargemType.Visible := False;
  end
  else
  begin
    scSalePriceMargemType.Visible := True;
    dbSalePricePercent.Text       := '';
    dbSalePricePercent.Visible    := False;
  end;
end;

procedure TbrwFrmModelGroup.cbMSRPChange(Sender: TObject);
begin
  inherited;
  quForm.Edit;
  
  if cbMSRP.ItemIndex = 0 then
  begin
    dbMSRPPercent.Visible    := True;
    scMSRPMargemType.Text    := '';
    scMSRPMargemType.Visible := False;
  end
  else
  begin
    scMSRPMargemType.Visible := True;
    dbMSRPPercent.Text       := '';
    dbMSRPPercent.Visible    := False;
  end;
end;

procedure TbrwFrmModelGroup.FormShow(Sender: TObject);
begin
  inherited;
  quFormUserCode.FocusControl;
end;

procedure TbrwFrmModelGroup.OnAfterCommit;
begin
  inherited;
  if FRecalcChanged then
    with TFrmMarginTableUpdate.Create(self) do
       Start(quFormIDModelGroup.AsInteger, FCalcPriceType, mgtGroup);
end;

procedure TbrwFrmModelGroup.dbSalePricePercentKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  chkRecalcPrices.Checked := True;
end;

procedure TbrwFrmModelGroup.scSalePriceMargemTypeSelectItem(
  Sender: TObject);
begin
  inherited;
  chkRecalcPrices.Checked := True;
end;

procedure TbrwFrmModelGroup.chkRecalcPricesClick(Sender: TObject);
begin
  inherited;
  quForm.Edit;
end;

end.
