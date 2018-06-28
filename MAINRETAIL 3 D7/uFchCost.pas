unit uFchCost;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, DBCtrls, DateBox, StdCtrls, Mask, SuperComboADO, FormConfig,
  Db, ADODB, RCADOQuery, PowerADOQuery, LblEffct, ExtCtrls, Buttons,
  siComp, siLangRT;

type
  TFchCost = class(TbrwFrmParent)
    scCostType: TDBSuperComboADO;
    Label5: TLabel;
    editData: TDBDateBox;
    Label1: TLabel;
    editCustoUnitario: TDBEdit;
    Label2: TLabel;
    Label4: TLabel;
    editQTY: TDBEdit;
    editCustoTotal: TDBEdit;
    Label3: TLabel;
    Label6: TLabel;
    quFormIDCost: TIntegerField;
    quFormIDTouristGroup: TIntegerField;
    quFormIDCostType: TIntegerField;
    quFormCostDate: TDateTimeField;
    quFormUnitCost: TFloatField;
    quFormCustoTotal: TCurrencyField;
    Label21: TLabel;
    Label7: TLabel;
    quFormQuantity: TFloatField;
    procedure quFormCalcFields(DataSet: TDataSet);
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure scCostTypeSelectItem(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IDTouristGroup: Integer;
  end;

var
  FchCost: TFchCost;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}

procedure TFchCost.quFormCalcFields(DataSet: TDataSet);
begin
  inherited;
  quFormCustoTotal.AsCurrency := quFormUnitCost.AsCurrency *
                                 quFormQuantity.AsFloat;
end;

procedure TFchCost.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormIDTouristGroup.AsInteger := IDTouristGroup;
  quFormCostDate.AsDateTime      := Date;
  quFormQuantity.AsFloat         := 1
end;

procedure TFchCost.scCostTypeSelectItem(Sender: TObject);
begin
  inherited;
  // pega o custo unitario default
  quFormUnitCost.AsString := DM.DescCodigo(['IDCostType'], [scCostType.LookUpValue],
                                           'CostType', 'DefaultValue');
end;

procedure TFchCost.FormShow(Sender: TObject);
begin
  inherited;
  scCostType.SetFocus;
end;

procedure TFchCost.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(307);
end;

end.
