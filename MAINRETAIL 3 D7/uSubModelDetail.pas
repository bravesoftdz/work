unit uSubModelDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, DateBox, Buttons, StdCtrls, Mask,
  SuperComboADO, Grids, DBGrids, SMDBGrid, DBCtrls, ExtCtrls, ComCtrls, DB,
  ADODB, SubListPanel;

type
 TOnVendorDblClick = procedure (Sender : TObject; iIDFornecedor: integer) of object;
  
type
  TSubModelDetail = class(TParentSub)
    lblTitle: TLabel;
    quModel: TADOQuery;
    quModelRealMarkUpPercet: TFloatField;
    quModelRealMarkUpValue: TCurrencyField;
    quModelIDModel: TIntegerField;
    quModelFreightCost: TFloatField;
    quModelOtherCost: TFloatField;
    quModelVendorCost: TFloatField;
    quModelDateLastCost: TDateTimeField;
    quModelMarkUp: TFloatField;
    quModelSellingPrice: TFloatField;
    quModelDateLastSellingPrice: TDateTimeField;
    quModelLastCost: TFloatField;
    quModelSuggRetail: TFloatField;
    dsModel: TDataSource;
    pcModel: TPageControl;
    tsModel: TTabSheet;
    pnlQuantity: TPanel;
    pnlCost: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Shape1: TShape;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    editNetCost: TDBText;
    editOtherCost: TDBText;
    editFreightCost: TDBText;
    DBEdit4: TDBText;
    Label6: TLabel;
    DBText4: TDBText;
    pnlRetail: TPanel;
    Label21: TLabel;
    Label26: TLabel;
    Shape2: TShape;
    Label27: TLabel;
    DBEdit13: TDBText;
    DBEdit6: TDBText;
    Label1: TLabel;
    DBText1: TDBText;
    Label2: TLabel;
    Label5: TLabel;
    DBText3: TDBText;
    pnlFrameRequest_fdskjfhg: TPanel;
    pnlFrameRequest_fdjkswf: TPanel;
    tsPurchaseHistory: TTabSheet;
    tsSaleHistory: TTabSheet;
    tsInventoryMov: TTabSheet;
    tsInventoryMovTotal: TTabSheet;
    tsOrder: TTabSheet;
    tsVendorHistory: TTabSheet;
    SubListQty: TSubListPanel;
    SubListPurHistory: TSubListPanel;
    SubListSalesHistory: TSubListPanel;
    SubListMovHistory: TSubListPanel;
    SubListMovTotal: TSubListPanel;
    SubListOrderHistory: TSubListPanel;
    SubListVendor: TSubListPanel;
    quModelAvgCost: TBCDField;
    quModelReplacementCost: TBCDField;
    lbTotal: TLabel;
    lbReplacCost: TLabel;
    DBText5: TDBText;
    DBText6: TDBText;
    quModelFinalCost: TCurrencyField;
    quModelTotQtyOnHand: TFloatField;
    quModelCaseQty: TFloatField;
    lbCaseQty: TLabel;
    DBText2: TDBText;
    procedure pcModelChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure quModelCalcFields(DataSet: TDataSet);
    procedure quModelAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    fIDModel    : Integer;
    fIDStore    : Integer;
    fIDVendor   : Integer;
    fShowMinMax : Char;
    procedure TabRefresh;
    procedure EnableValues;
  protected
    procedure AfterSetParam; override;
  public
    { Public declarations }
    procedure DataSetRefresh;
    procedure DataSetOpen; override;
    procedure DataSetClose; override;
  end;

implementation

uses uDM, uParamFunctions, uDMGlobal, uSystemConst;

{$R *.dfm}

procedure TSubModelDetail.DataSetRefresh;
begin
  DataSetClose;
  DataSetOpen;
end;

procedure TSubModelDetail.DataSetOpen;
begin

 with quModel do
   if not Active then
      begin
      Parameters.ParambyName('IDModel').Value := fIDModel;
      Open;
      end;

end;

procedure TSubModelDetail.DataSetClose;
begin
 with quModel do
   if Active then
      Close;
end;

procedure TSubModelDetail.AfterSetParam;
begin

   fIDModel    := StrToIntDef(ParseParam(FParam, 'IDModel'),0);
   fIDStore    := StrToIntDef(ParseParam(FParam, 'IDStore'),0);
   fIDVendor   := StrToIntDef(ParseParam(FParam, 'IDVendor'),0);
   if (ParseParam(FParam, 'ShowMinMax')='Y') then
     fShowMinMax := 'Y'
   else
     fShowMinMax := 'N';
   TabRefresh;
   EnableValues;
end;

procedure TSubModelDetail.TabRefresh;
begin

  lblTitle.Caption := pcModel.ActivePage.Caption;

  if pcModel.ActivePage = tsModel then
    begin
    //DataSetOpen;
    DataSetRefresh;
    //Create Frm Model Detail
    SubListQty.CreateSubList;
    SubListQty.Param := 'IDModel='+IntToStr(fIDModel)+';IDStore='+IntToStr(fIDStore)+';'+'ShowMinMax='+fShowMinMax+';';
    end
  else if pcModel.ActivePage = tsInventoryMovTotal then
    begin
    SubListMovTotal.CreateSubList;
    SubListMovTotal.Param := 'IDModel='+IntToStr(fIDModel)+';IDStore='+IntToStr(fIDStore)+';';
    end
  else if pcModel.ActivePage = tsPurchaseHistory then
    begin
    //Create SubPruchase
    SubListPurHistory.CreateSubList;
    SubListPurHistory.Param := 'IDModel='+IntToStr(fIDModel)+';IDStore='+IntToStr(fIDStore)+';';
    end
  else if pcModel.ActivePage = tsSaleHistory then
    begin
    //Create SubSalesHistory
    SubListSalesHistory.CreateSubList;
    SubListSalesHistory.Param := 'IDModel='+IntToStr(fIDModel)+';IDStore='+IntToStr(fIDStore)+';';
    end
  else if pcModel.ActivePage = tsInventoryMov then
    begin   
    SubListMovHistory.CreateSubList;
    SubListMovHistory.Param := 'IDModel='+IntToStr(fIDModel)+';IDStore='+IntToStr(fIDStore)+';';
    end
  else if pcModel.ActivePage = tsOrder then
    begin
    SubListOrderHistory.CreateSubList;
    SubListOrderHistory.Param := 'IDModel='+IntToStr(fIDModel)+';';
    end
  else if pcModel.ActivePage = tsVendorHistory then
    begin
    SubListVendor.CreateSubList;
    SubListVendor.Param := 'IDVendor='+IntToStr(fIDVendor)+';IDStore='+IntToStr(fIDStore)+';';
    end;

end;

procedure TSubModelDetail.pcModelChange(Sender: TObject);
begin
  inherited;
  TabRefresh;
end;

procedure TSubModelDetail.FormDestroy(Sender: TObject);
begin
  DataSetClose;

  inherited;

end;

procedure TSubModelDetail.EnableValues;
var
  bEstimatedCost,
  bTaxIncludedInCost : Boolean;
begin
   bEstimatedCost       := DM.fSystem.SrvParam[PARAM_USE_ESTIMATED_COST];
   bTaxIncludedInCost   := DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE];

   lbReplacCost.Visible := bEstimatedCost;
   DBText6.Visible      := bEstimatedCost;

   //Somente para exibir se a taxa nao estiver no custo da merdacoria
   Label5.Visible   := not bTaxIncludedInCost;
   DBText3.Visible  := not bTaxIncludedInCost;
   Label1.Visible   := not bTaxIncludedInCost;
   DBText1.Visible  := not bTaxIncludedInCost;
   Label2.Visible   := not bTaxIncludedInCost;
   Label21.Visible  := not bTaxIncludedInCost;
   DBEdit13.Visible := not bTaxIncludedInCost;

   Label20.Visible  := (quModelAvgCost.AsCurrency > 0);
   DBText5.Visible  := Label20.Visible;

   Label6.Visible   := (quModelLastCost.AsCurrency>0);
   DBText4.Visible  := Label6.Visible;
end;

procedure TSubModelDetail.quModelCalcFields(DataSet: TDataSet);
begin
  inherited;
  quModelFinalCost.AsCurrency := quModelVendorCost.AsCurrency +
                                 quModelFreightCost.AsCurrency +
                                 quModelOtherCost.AsCurrency;

end;

procedure TSubModelDetail.quModelAfterOpen(DataSet: TDataSet);
begin
  inherited;
  lbCaseQty.Visible := (quModelCaseQty.AsFloat>1);
  DBText2.Visible   := lbCaseQty.Visible;
end;

initialization
   RegisterClass(TSubModelDetail);


end.
