unit uFrmSpecialPrice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Grids, Buttons, ADODB, RCADOQuery,
  PowerADOQuery, siComp, siLangRT, DBGrids, SMDBGrid;

type
  TbrwFrmSpecialPrice = class(TbrwFrmParent)
    quSpecialPriceToGroup: TADOQuery;
    dsSpecialPriceToGroup: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    quFormIDSpecialPrice: TIntegerField;
    quFormSpecialPrice: TStringField;
    quSaleHistory: TADOQuery;
    dsSaleHistroy: TDataSource;
    quSaleHistoryYear: TIntegerField;
    quSaleHistoryMonth: TIntegerField;
    quSaleHistoryMonthName: TStringField;
    quSaleHistoryTotCost: TFloatField;
    quSaleHistoryTotSale: TFloatField;
    quSaleHistoryMarkUp: TFloatField;
    quMarkUp: TPowerADOQuery;
    dsMarkup: TDataSource;
    Panel6: TPanel;
    Panel7: TPanel;
    Label4: TLabel;
    DBText1: TDBText;
    Label5: TLabel;
    DBText2: TDBText;
    Label6: TLabel;
    DBText3: TDBText;
    quSpecialPriceToGroupIDSpecialPrice: TIntegerField;
    quSpecialPriceToGroupSpecialMarkUp: TBCDField;
    quSpecialPriceToGroupIDGroup: TAutoIncField;
    quMarkUpMaxMarkUp: TBCDField;
    quMarkUpMinMarkUp: TBCDField;
    quMarkUpAvgMarkUp: TBCDField;
    Label21: TLabel;
    quSpecialPriceToGroupCategory: TStringField;
    grdSpecialPrice: TSMDBGrid;
    grdSaleHistory: TSMDBGrid;
    procedure FormShow(Sender: TObject);
    procedure quSaleHistoryCalcFields(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure quSpecialPriceToGroupAfterEdit(DataSet: TDataSet);
    procedure quFormBeforeClose(DataSet: TDataSet);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quSpecialPriceToGroupAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }

    //pecialPriceToGroup
    procedure SpecialPriceOpen;
    procedure SpecialPriceClose;
    procedure SpecialPricePost;

    //SaleHistory
    procedure SaleHistoryOpen;
    procedure SaleHistoryClose;

    //MarkUp
    procedure MarkUpOpen;
    procedure MarkUpClose;

  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}


procedure TbrwFrmSpecialPrice.MarkUpOpen;
begin
    with quMarkUp do
       if not Active then
          begin
          Parameters.ParamByName('IDGroup').Value := quSpecialPriceToGroupIDGroup.AsInteger;
          Open;
          end;

end;

procedure TbrwFrmSpecialPrice.MarkUpClose;
begin

   with quMarkUp do
      if Active then
         Close;

end;

procedure TbrwFrmSpecialPrice.SaleHistoryOpen;
begin

  with quSaleHistory do
     if not Active then
        begin
        Parameters.ParamByName('Date1').Value   := Now;
        Parameters.ParamByName('Date2').Value   := Now;
        Parameters.ParamByName('StoreID').Value := DM.fStore.ID;
        Parameters.ParamByName('IDGroup').Value := quSpecialPriceToGroupIDGroup.AsInteger;
        Open;
        end;

end;


procedure TbrwFrmSpecialPrice.SaleHistoryClose;
begin

  with quSaleHistory do
     if Active then
        Close;

end;

procedure TbrwFrmSpecialPrice.SpecialPriceOpen;
begin

  with quSpecialPriceToGroup do
      if not Active then
         begin
         Parameters.ParamByName('SpecialPriceID').Value := quFormIDSpecialPrice.AsInteger;
         Open;
         end;

end;

procedure TbrwFrmSpecialPrice.SpecialPriceClose;
begin

  SpecialPricePost;

  with quSpecialPriceToGroup do
     if Active then
        Close;

end;


procedure TbrwFrmSpecialPrice.SpecialPricePost;
begin

  with quSpecialPriceToGroup do
     if Active then
        if State in dsEditModes then
           Post;

end;


procedure TbrwFrmSpecialPrice.FormShow(Sender: TObject);
var
   IsShowGrid : Boolean;
begin
  inherited;

end;

procedure TbrwFrmSpecialPrice.quSaleHistoryCalcFields(DataSet: TDataSet);
begin
  inherited;
  quSaleHistoryMonthName.AsString := LongMonthNames[quSaleHistoryMonth.AsInteger];

  if (((quSaleHistoryTotSale.AsFloat - quSaleHistoryTotCost.AsFloat) <> 0) and
      (quSaleHistoryTotCost.AsFloat <> 0)) then
     quSaleHistoryMarkUp.AsFloat := (quSaleHistoryTotSale.AsFloat-quSaleHistoryTotCost.AsFloat)/(quSaleHistoryTotCost.AsFloat)*100
  else
     quSaleHistoryMarkUp.AsFloat := 0;
end;

procedure TbrwFrmSpecialPrice.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1980);
end;

procedure TbrwFrmSpecialPrice.quSpecialPriceToGroupAfterEdit(
  DataSet: TDataSet);
begin
  inherited;

  quForm.Edit;

end;

procedure TbrwFrmSpecialPrice.quFormBeforeClose(DataSet: TDataSet);
begin
  inherited;

  SpecialPriceClose;

  SaleHistoryClose;

  MarkUpClose;


end;

procedure TbrwFrmSpecialPrice.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  SpecialPriceOpen;

  SaleHistoryOpen;

  MarkUpOpen;

end;

procedure TbrwFrmSpecialPrice.quSpecialPriceToGroupAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  DataSet.Cancel;
end;

end.
