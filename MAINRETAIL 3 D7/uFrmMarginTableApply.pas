unit uFrmMarginTableApply;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls, DB,
  DBCtrls, Mask, SuperComboADO, ADODB, uDMCalcPrice;

const
  CATEGORY = 1;
  SUBCATEG = 2;
  GROUP    = 3;

type
  TFrmMarginTableApply = class(TDialogParent)
    Panel13: TPanel;
    lbQuestion2: TLabel;
    pnMSRP: TPanel;
    scMSRPMargemType: TDBSuperComboADO;
    dbMSRPPercent: TDBEdit;
    cbMSRP: TComboBox;
    Panel9: TPanel;
    lbQuestion: TLabel;
    pnSalePrice: TPanel;
    scSalePriceMargemType: TDBSuperComboADO;
    dbSalePricePercent: TDBEdit;
    cbSalePrice: TComboBox;
    dsApplyMargin: TDataSource;
    quApplyMargin: TADODataSet;
    DBText1: TDBText;
    quApplyMarginID: TIntegerField;
    quApplyMarginName: TStringField;
    quApplyMarginIDSalePriceMargemTable: TIntegerField;
    quApplyMarginSalePriceMargemPercent: TFloatField;
    quApplyMarginUseSalePricePercent: TBooleanField;
    quApplyMarginIDMSRPMargemTable: TIntegerField;
    quApplyMarginMSRPMargemPercent: TFloatField;
    quApplyMarginUseMSRPPercent: TBooleanField;
    procedure quApplyMarginAfterOpen(DataSet: TDataSet);
    procedure quApplyMarginBeforePost(DataSet: TDataSet);
    procedure quApplyMarginAfterPost(DataSet: TDataSet);
    procedure CancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AplicarClick(Sender: TObject);
    procedure cbSalePriceChange(Sender: TObject);
    procedure cbMSRPChange(Sender: TObject);
    procedure dbSalePricePercentExit(Sender: TObject);
    procedure dbMSRPPercentExit(Sender: TObject);
  private
    fID : Integer;
    fType: TModelGroupingType;
    FRecalcChanged: Boolean;
    FCalcPriceType : TCalcPriceType;
    procedure ApplyOpen;
    procedure ApplyClose;
    procedure ApplyPost;
    function GetSQLByType(iType : TModelGroupingType):String;
  public
    function Start(iID : Integer; iType : TModelGroupingType):Boolean;
  end;

implementation

uses uDM, uFrmMarginTableUpdate, uNumericFunctions, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmMarginTableApply }

function TFrmMarginTableApply.Start(iID : Integer; iType: TModelGroupingType): Boolean;
begin
  fID   := iID;
  fType := iType;
  ApplyOpen;
  Result := (ShowModal = mrOK);
end;

procedure TFrmMarginTableApply.quApplyMarginAfterOpen(DataSet: TDataSet);
begin
  inherited;

  if quApplyMarginUseMSRPPercent.AsBoolean = True then
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

  if quApplyMarginUseSalePricePercent.AsBoolean = True then
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

procedure TFrmMarginTableApply.quApplyMarginBeforePost(DataSet: TDataSet);
begin
  inherited;

  with quApplyMargin do
  begin
    FRecalcChanged := True;

    if ((FieldByName('SalePriceMargemPercent').NewValue <> NULL) or
        (FieldByName('IDSalePriceMargemTable').NewValue <> NULL)) and
       ((FieldByName('MSRPMargemPercent').NewValue <> NULL) or
        (FieldByName('IDMSRPMargemTable').NewValue <> NULL)) then
       FCalcPriceType := cptBoth

    else if (FieldByName('SalePriceMargemPercent').NewValue <> NULL) or
            (FieldByName('IDSalePriceMargemTable').NewValue <> NULL) then
             FCalcPriceType := cptSalePrice

    else if (FieldByName('MSRPMargemPercent').NewValue <> NULL) or
            (FieldByName('IDMSRPMargemTable').NewValue <> NULL) then
             FCalcPriceType := cptMSRPPrice
    else
      FRecalcChanged := False;
  end;


  if cbSalePrice.ItemIndex = 0 then
  begin
    quApplyMarginUseSalePricePercent.AsBoolean   := True;
    quApplyMarginIDSalePriceMargemTable.AsString := '';
  end
  else
  begin
    quApplyMarginUseSalePricePercent.AsBoolean     := False;
    quApplyMarginSalePriceMargemPercent.AsCurrency := 0;
  end;

  if cbMSRP.ItemIndex = 0 then
  begin
    quApplyMarginUseMSRPPercent.AsBoolean   := True;
    quApplyMarginIDMSRPMargemTable.AsString := '';
  end
  else
  begin
    quApplyMarginUseMSRPPercent.AsBoolean     := False;
    quApplyMarginMSRPMargemPercent.AsCurrency := 0;
  end;
  
end;

procedure TFrmMarginTableApply.ApplyClose;
begin
 with quApplyMargin do
   if Active then
      Close;
end;

procedure TFrmMarginTableApply.ApplyOpen;
begin
 with quApplyMargin do
   if not Active then
      begin
      CommandText := GetSQLByType(fType);
      Open;
      end;

end;

function TFrmMarginTableApply.GetSQLByType(iType: TModelGroupingType): String;
begin
  case iType of
  mgtCategory : begin
             Result := 'SELECT TG.IDGroup as ID, ' +
                       'TG.Name, ' +
                       'TG.IDSalePriceMargemTable, ' +
                       'TG.SalePriceMargemPercent, ' +
                       'TG.UseSalePricePercent, ' +
                       'TG.IDMSRPMargemTable, ' +
                       'TG.MSRPMargemPercent, ' +
                       'TG.UseMSRPPercent ' +
                       'FROM ' +
                       'TabGroup TG ' +
                       'WHERE ' +
                       'TG.IDGroup = ' + IntToStr(fID);
             end;
  mgtGroup : begin
             Result := 'SELECT MG.IDModelGroup as ID, ' +
                       'MG.ModelGroup as Name, ' +
                       'MG.IDSalePriceMargemTable, ' +
                       'MG.SalePriceMargemPercent, ' +
                       'MG.UseSalePricePercent, ' +
                       'MG.IDMSRPMargemTable, ' +
                       'MG.MSRPMargemPercent, ' +
                       'MG.UseMSRPPercent ' +
                       'FROM ' +
                       'ModelGroup MG ' +
                       'WHERE ' +
                       'MG.IDModelGroup = ' + IntToStr(fID);
             end;
  mgtSubGroup : begin
             Result := 'SELECT MSG.IDModelSubGroup as ID, ' +
                       'MSG.ModelSubGroup as Name, ' +
                       'MSG.IDSalePriceMargemTable, ' +
                       'MSG.SalePriceMargemPercent, ' +
                       'MSG.UseSalePricePercent, ' +
                       'MSG.IDMSRPMargemTable, ' +
                       'MSG.MSRPMargemPercent, ' +
                       'MSG.UseMSRPPercent ' +
                       'FROM ' +
                       'ModelSubGroup MSG ' +
                       'WHERE ' +
                       'MSG.IDModelSubGroup = ' + IntToStr(fID);
             end;
  end;

end;

procedure TFrmMarginTableApply.quApplyMarginAfterPost(DataSet: TDataSet);
begin
  inherited;

  if FRecalcChanged then
  begin
    with TFrmMarginTableUpdate.Create(self) do
      Start(quApplyMarginID.AsInteger, FCalcPriceType, fType);
  end;

end;

procedure TFrmMarginTableApply.CancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmMarginTableApply.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmMarginTableApply.ApplyPost;
begin
  with quApplyMargin do
    if Active then
       if State in dsEditModes then
          Post;
end;

procedure TFrmMarginTableApply.AplicarClick(Sender: TObject);
begin
  ApplyPost;
  inherited;
end;

procedure TFrmMarginTableApply.cbSalePriceChange(Sender: TObject);
begin
  inherited;
  if cbSalePrice.ItemIndex = 0 then
  begin
    dbSalePricePercent.Visible    := True;
    scSalePriceMargemType.Visible := False;
  end
  else
  begin
    dbSalePricePercent.Visible    := False;
    scSalePriceMargemType.Visible := True;
  end;

end;

procedure TFrmMarginTableApply.cbMSRPChange(Sender: TObject);
begin
  inherited;

  if cbMSRP.ItemIndex = 0 then
  begin
    dbMSRPPercent.Visible    := True;
    scMSRPMargemType.Visible := False;
  end
  else
  begin
    dbMSRPPercent.Visible    := False;
    scMSRPMargemType.Visible := True;
  end;

end;

procedure TFrmMarginTableApply.dbSalePricePercentExit(Sender: TObject);
begin
  if (dbSalePricePercent.Text <> '') and (MyStrToFloat(dbSalePricePercent.Text) > 99) then
  begin
    MsgBox(MSG_INF_PERCENT_LESSER_100, vbOKOnly + vbInformation);
    dbSalePricePercent.SetFocus;
    Exit
  end;
end;

procedure TFrmMarginTableApply.dbMSRPPercentExit(Sender: TObject);
begin
  if (dbMSRPPercent.Text <> '') and (MyStrToFloat(dbMSRPPercent.Text) > 99) then
  begin
    MsgBox(MSG_INF_PERCENT_LESSER_100, vbOKOnly + vbInformation);
    dbMSRPPercent.SetFocus;
    Exit
  end;
end;

end.
