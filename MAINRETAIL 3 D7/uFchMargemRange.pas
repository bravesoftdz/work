unit uFchMargemRange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchMargemRange = class(TbrwFrmParent)
    quFormIDMargemTableRange: TIntegerField;
    quFormIDMargemTable: TIntegerField;
    quFormMinValue: TBCDField;
    quFormMaxValue: TBCDField;
    quFormPercentage: TFloatField;
    Label1: TLabel;
    dbMinValue: TDBEdit;
    Label2: TLabel;
    dbMaxValue: TDBEdit;
    Label3: TLabel;
    dbPercentage: TDBEdit;
    procedure btCloseClick(Sender: TObject);
    procedure dbMaxValueExit(Sender: TObject);
    procedure dbMinValueExit(Sender: TObject);
    procedure dbPercentageExit(Sender: TObject);
  private
    procedure VerifyValues(Value: TDBEdit) ;
  public
    { Public declarations }
  end;

var
  FchMargemRange: TFchMargemRange;

implementation

uses uNumericFunctions, uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TFchMargemRange.btCloseClick(Sender: TObject);
begin
  inherited;
  //refresh o Browse anterior
  MybrwQuery.Close;
  MybrwQuery.Open;
end;

procedure TFchMargemRange.dbMaxValueExit(Sender: TObject);
begin
  VerifyValues(dbMaxValue);
end;

procedure TFchMargemRange.dbMinValueExit(Sender: TObject);
begin
  VerifyValues(dbMinValue);
end;

procedure TFchMargemRange.VerifyValues(Value: TDBEdit) ;
begin
  if (dbMinValue.Text <> '') and (dbMaxValue.Text <> '') then
  begin
    if (MyStrToMoney(dbMinValue.Text) > MyStrToMoney(dbMaxValue.Text)) then
    begin
      MsgBox(MSG_INF_NOT_MIN_GREATER_MAX, vbOKOnly + vbInformation);
      Value.SetFocus;
      Exit;
    end;
  end;
end;

procedure TFchMargemRange.dbPercentageExit(Sender: TObject);
begin
  if (dbPercentage.Text <> '') and (MyStrToFloat(dbPercentage.Text) > 99) then
  begin
    MsgBox(MSG_INF_PERCENT_LESSER_100, vbOKOnly + vbInformation);
    dbPercentage.SetFocus;
    Exit
  end;
end;

end.
