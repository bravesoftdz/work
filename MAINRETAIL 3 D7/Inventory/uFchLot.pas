unit uFchLot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls, DateBox,
  SuperComboADO;

type
  TFchLot = class(TbrwFrmParent)
    quFormIDLote: TIntegerField;
    quFormIDModel: TIntegerField;
    quFormIDUser: TIntegerField;
    quFormLot: TStringField;
    quFormExpirationDate: TDateTimeField;
    quFormLotDate: TDateTimeField;
    quFormQty: TBCDField;
    Label2: TLabel;
    edtLot: TDBEdit;
    Label1: TLabel;
    dtExp: TDBDateBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dtLot: TDBDateBox;
    Label6: TLabel;
    edtQty: TDBEdit;
    Label7: TLabel;
    scModel: TDBSuperComboADO;
    Label8: TLabel;
    procedure quFormNewRecord(DataSet: TDataSet);
  private
    FQty : Double;
    FIDModel : Integer;
  protected
    procedure OnBeforeShow; override;
    function OnValidadeField: boolean; override;
    function OnAfterSaveChange(var iError:Integer):Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal, uParamFunctions, uNumericFunctions, uMsgBox, uMsgConstant,
     uSystemTypes;

{$R *.dfm}

{ TFchLot }

function TFchLot.OnAfterSaveChange(var iError: Integer): Boolean;
begin

  if (frmCommand = btInc) then
    Result := DM.FDMInventory.LotAdjust(FIDModel,
                                     DM.fStore.ID,
                                     quFormIDLote.AsInteger,
                                     quFormQty.AsFloat,
                                     1);
end;

procedure TFchLot.OnBeforeShow;
begin
  inherited;
  FQty     := MyStrToDouble(ParseParam(Self.sParam, 'Qty'));
  FIDModel := StrToIntDef(ParseParam(Self.sParam, 'IDModel'), -1);
end;

function TFchLot.OnValidadeField: boolean;
begin

  Result := inherited OnValidadeField;

  if quFormQty.AsFloat <= 0 then
  begin
    MsgBox(MSG_INF_QTY_MUST_BIGGER_ZERO, vbOKOnly + vbInformation);
    Result := False;
  end;

end;

procedure TFchLot.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  if FIDModel <> -1 then
    quFormIDModel.AsInteger := FIDModel;
  quFormIDUser.AsInteger := DM.fUser.ID;
  quFormQty.AsFloat      := FQty;
end;

end.
