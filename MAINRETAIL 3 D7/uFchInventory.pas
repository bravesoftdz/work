unit uFchInventory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, LblEffct, ExtCtrls,
  FormConfig, DateBox, Buttons, ADODB, RCADOQuery, PowerADOQuery,
  SuperComboADO, siComp, siLangRT, ComCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, uFrmStorePrice;

type
  TFchInventory = class(TbrwFrmParent)
    IDEstado: TLabel;
    DBSuperCombo1: TDBSuperComboADO;
    Label1: TLabel;
    DBSuperCombo2: TDBSuperComboADO;
    quFormModelID: TIntegerField;
    quFormLocation: TStringField;
    quFormDataContagem: TDateTimeField;
    quFormUltimaMovimentacao: TDateTimeField;
    quFormUltimaContagem: TDateTimeField;
    Label12: TLabel;
    DBEdit10: TDBEdit;
    Label13: TLabel;
    DBEdit11: TDBEdit;
    Panel5: TPanel;
    Panel7: TPanel;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    DBDateBox1: TDBDateBox;
    Label11: TLabel;
    DBEdit9: TDBEdit;
    QuMovHist: TADOQuery;
    DSMovHist: TDataSource;
    QuMovHistModelID: TIntegerField;
    QuMovHistMovDate: TDateTimeField;
    QuMovHistModelID_1: TIntegerField;
    Label35: TLabel;
    Label14: TLabel;
    quFormStoreID: TIntegerField;
    quFormIDInventory: TIntegerField;
    quFormSellingPrice: TBCDField;
    quFormStoreCostPrice: TBCDField;
    quFormStoreAvgPrice: TBCDField;
    pgDetail: TPageControl;
    tsInfo: TTabSheet;
    tsQty: TTabSheet;
    Panel10: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel11: TPanel;
    edtQtyOnHand: TDBEdit;
    edtQtyOnOrder: TDBEdit;
    edtQtyOnPreSale: TDBEdit;
    edtQtyOnRepair: TDBEdit;
    pnlEstoque: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Panel6: TPanel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit5: TDBEdit;
    pnlPrices: TPanel;
    pnlInfPrices: TPanel;
    lbSellingPrice: TLabel;
    DBEdit12: TDBEdit;
    lbCost: TLabel;
    DBEdit13: TDBEdit;
    lbAvgPrice: TLabel;
    DBEdit14: TDBEdit;
    quFormQtyOnPreSale: TFloatField;
    quFormQtyOnHand: TFloatField;
    quFormQtyOnOrder: TFloatField;
    quFormQtyOnRepair: TFloatField;
    quFormMaxQty: TFloatField;
    quFormMinQty: TFloatField;
    quFormQtyContada: TFloatField;
    quFormDifference: TFloatField;
    Panel8: TPanel;
    pnlInfDepartments: TPanel;
    grdDepartmentsTV: TcxGridDBTableView;
    grdDepartmentsLvl: TcxGridLevel;
    grdDepartments: TcxGrid;
    Panel12: TPanel;
    btAddDepartment: TSpeedButton;
    btRemoveDepartment: TSpeedButton;
    quModelDepartment: TADOQuery;
    dsModelDepartment: TDataSource;
    quModelDepartmentModelID: TIntegerField;
    quModelDepartmentStoreID: TIntegerField;
    quModelDepartmentIDDepartment: TIntegerField;
    quModelDepartmentDepartment: TStringField;
    grdDepartmentsTVIDDepartment: TcxGridDBColumn;
    grdDepartmentsTVDepartment: TcxGridDBColumn;
    tsRequest: TTabSheet;
    pnlTitleRequest: TPanel;
    lbClassABCDescription: TLabel;
    cmbClassABC: TDBComboBox;
    lbClassABC: TLabel;
    quFormClassABC: TStringField;
    lbLeadTime: TLabel;
    DBEdit15: TDBEdit;
    lbLeadTimeDescription: TLabel;
    lbSafetyMarginDescription: TLabel;
    DBEdit16: TDBEdit;
    lbSafetyMargin: TLabel;
    lbDailySales: TLabel;
    DBEdit17: TDBEdit;
    lbDailySalesDescription: TLabel;
    lbOrderPointDescription: TLabel;
    DBEdit18: TDBEdit;
    lbOrderPoint: TLabel;
    quFormDailySales: TFloatField;
    quFormLeadTime: TFloatField;
    quFormOrderPoint: TFloatField;
    quFormSafetyMargin: TFloatField;
    gbxInvPrices: TGroupBox;
    Label16: TLabel;
    DBEdit19: TDBEdit;
    Label17: TLabel;
    DBEdit20: TDBEdit;
    Label18: TLabel;
    DBEdit21: TDBEdit;
    quModelPrices: TADOQuery;
    dsModelPrices: TDataSource;
    quModelPricesCostPrice: TBCDField;
    quModelPricesSellingPrice: TBCDField;
    quModelPricesAvgCost: TBCDField;
    btPriceTable: TSpeedButton;
    Label19: TLabel;
    edtQtyFloating: TDBEdit;
    quFormFloatPercent: TIntegerField;
    quFormQtyFloating: TFloatField;
    procedure quFormCalcFields(DataSet: TDataSet);
    procedure quFormBeforePost(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btAddDepartmentClick(Sender: TObject);
    procedure btRemoveDepartmentClick(Sender: TObject);
    procedure dsModelDepartmentDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quFormAfterClose(DataSet: TDataSet);
    procedure btPriceTableClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
  private
    FFrmStorePrice: TFrmStorePrice;

    procedure ModelDepartmentOpen;
    procedure ModelDepartmentClose;
    procedure ModelDepartmentRefresh;
    procedure OpenModelPrice;
    procedure CloseModelPrice;

    function UsePriceTable: Boolean;
  protected
    procedure OnAfterUpdateNavegator; override;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uFrmModelDepartment,
  uSystemConst, uSystemTypes, PaiDeTodos;

{$R *.DFM}

procedure TFchInventory.quFormCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quFormQtyContada.AsFloat > 0 then
    quFormDifference.AsFloat := quFormQtyContada.AsFloat - quFormQtyOnHand.AsFloat
  else
    quFormDifference.AsFloat := 0;

  //Calcular a quantidade Flutuante do Modelo
  if quFormFloatPercent.AsFloat = 0 then
  begin
     quFormQtyFloating.AsFloat := (quFormQtyOnHand.AsFloat - quFormQtyOnPreSale.AsFloat);
     Exit;
  end;

  if DM.fSystem.SrvParam[PARAM_USE_FRACTIONARY_QTY] then
    quFormQtyFloating.AsFloat := (quFormQtyOnHand.AsFloat - quFormQtyOnPreSale.AsFloat) +
                                     ((quFormQtyOnPreSale.AsFloat * quFormFloatPercent.AsFloat)) / 100
  else
    quFormQtyFloating.AsFloat := Trunc((quFormQtyOnHand.AsFloat - quFormQtyOnPreSale.AsFloat) +
                                     ((quFormQtyOnPreSale.AsFloat * quFormFloatPercent.AsFloat)) / 100);
end;

procedure TFchInventory.quFormBeforePost(DataSet: TDataSet);
begin
  inherited;
  quFormUltimaMovimentacao.AsDateTime := Now;
  if (quFormQtyContada.AsFloat > 0) and
     (quFormDataContagem.AsString = '') then
    begin
     MsgBox(MSG_INF_SUPPLU_ADJ_DATE, vbOKOnly + vbInformation);
     Abort;
    end;
end;


procedure TFchInventory.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1670);
end;

procedure TFchInventory.OnAfterUpdateNavegator;
begin
  //quando tem 2 params nao da para navegar, alterar o FchParent
  //para poder navegar com chave composta
  pnlNavigation.Visible := False;
end;

procedure TFchInventory.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btAddDepartment.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemoveDepartment.Glyph);
end;

procedure TFchInventory.btAddDepartmentClick(Sender: TObject);
begin
  inherited;
  with TFrmModelDepartment.Create(Self) do
  try
    if Start(quFormModelID.AsInteger, quFormStoreID.AsInteger) then
      ModelDepartmentRefresh;
  finally
    Free;
  end;
end;

procedure TFchInventory.btRemoveDepartmentClick(Sender: TObject);
begin
  inherited;
  if (quModelDepartment.Active) and (quModelDepartmentIDDepartment.AsInteger <> 0) then
  begin
    DM.RunSQL('DELETE Inv_ModelDepartment ' +
              'WHERE ModelID = ' + quModelDepartmentModelID.AsString +
              'AND StoreID = ' + quModelDepartmentStoreID.AsString +
              'AND IDDepartment = ' + quModelDepartmentIDDepartment.AsString);
    ModelDepartmentRefresh;
  end;
end;

procedure TFchInventory.ModelDepartmentRefresh;
begin
  ModelDepartmentClose;
  ModelDepartmentOpen;
end;

procedure TFchInventory.ModelDepartmentClose;
begin
  with quModelDepartment do
    if Active then
      Close;
end;

procedure TFchInventory.ModelDepartmentOpen;
begin
  with quModelDepartment do
    if not Active then
    begin
      if ( quFormModelID.asString <> '' ) then begin
          Parameters.ParamByName('IDModel').Value := quFormModelID.AsInteger;
          Parameters.ParamByName('IDStore').Value := quFormStoreID.AsInteger;
      end
      else begin
          quForm := BrowserQuery;
          Parameters.ParamByName('IDModel').Value := BrowserQuery.fieldByName('ModelId').Value;
          Parameters.ParamByName('IDStore').Value := BrowserQuery.fieldByName('StoreId').Value;
      end;
      Open;
    end;
end;

procedure TFchInventory.dsModelDepartmentDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if quModelDepartment.Active then
    btRemoveDepartment.Enabled := quModelDepartment.RecordCount > 0;
end;

procedure TFchInventory.FormShow(Sender: TObject);
begin
  inherited;
  //amfsouza august 30, 2012 - quForm := BrowserQuery;
  if ( quForm.State <> dsEdit ) then
     quForm.Edit;

  btPriceTable.Visible := UsePriceTable;
  ModelDepartmentRefresh;
end;

procedure TFchInventory.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;
  OpenModelPrice;
end;

procedure TFchInventory.OpenModelPrice;
begin
  with quModelPrices do
    if not Active then
    begin
      if ( quForm.fieldByName('ModelId').AsString <> '' ) then
         Parameters.ParamByName('IDModel').Value := quFormModelID.AsInteger
      else begin
         quform.close;
         quform.Parameters.ParamByName('StoreID').value := BrowserQuery.fieldByName('StoreId').Value;
         quform.Parameters.ParamByName('ModelId').value := BrowserQuery.fieldByName('ModelId').Value;
         quForm.Open;
         dsform.DataSet := quForm;
         dbSupercombo1.LookUpValue := quForm.fieldByname('StoreId').Value;
         DBSuperCombo2.LookUpValue := quForm.fieldByName('ModelId').Value;

         Parameters.ParamByName('IDModel').Value := BrowserQuery.fieldByName('ModelId').Value;
      end;
      Open;
    end;
end;

procedure TFchInventory.CloseModelPrice;
begin
  with quModelPrices do
    if Active then
      Close;
end;

procedure TFchInventory.quFormAfterClose(DataSet: TDataSet);
begin
  inherited;
  CloseModelPrice;
end;

procedure TFchInventory.btPriceTableClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FFrmStorePrice) then
    FFrmStorePrice := TFrmStorePrice.Create(Self);

  //amfsouza June 28, 2012
  if ( quForm.fieldbyname('ModelId').AsString <> '' ) then
     FFrmStorePrice.Start(quFormStoreID.AsInteger, quFormModelID.AsInteger)
  else begin
     quForm := BrowserQuery;
     FFrmStorePrice.Start(BrowserQuery.fieldByName('StoreId').Value, BrowserQuery.fieldByName('ModelID').Value);
  end;
end;

function TFchInventory.UsePriceTable: Boolean;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    //amfsouza June 28, 2012 - begin
    if (quFormModelID.AsString <> '' ) then begin
        SQL.Clear;
        SQL.Add('SELECT UsePriceTable FROM Model M JOIN TabGroup TG ON (M.GroupID = TG.IDGroup) WHERE IDModel = ' + quFormModelID.AsString);
        Open;
    end
    else begin
         quForm := BrowserQuery;
        SQL.Clear;
        SQL.Add('SELECT UsePriceTable FROM Model M JOIN TabGroup TG ON (M.GroupID = TG.IDGroup) WHERE IDModel = ' + intToStr(BrowserQuery.fieldByName('ModelId').Value));
        Open;
    end;
    //amfsouza June 28, 2012 - end

    Result := FieldByName('UsePriceTable').AsBoolean;
  finally
    Close;
  end;
end;

procedure TFchInventory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  BrowserQuery := nil;
//    Action := caFree;
end;

procedure TFchInventory.btCloseClick(Sender: TObject);
begin
  inherited;
  // update selling price by hand to avoid "row cannot be located for updating
  //dm.UpdatePriceInInventory(quFormIDInventory.Value, quFormSellingPrice.Value);
  //frmCommand := btInc; // to force and avoid method close in ancestor method
  //close();




end;

end.
