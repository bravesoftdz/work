unit uFrmPromoItemList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, ADODB, Mask, SuperComboADO, Buttons, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Provider, DBClient;

type
  TFrmPromoItemList = class(TFrmParent)
    btnSave: TButton;
    lbManufect: TLabel;
    lbVerti: TLabel;
    lbHoriz: TLabel;
    lbCategory: TLabel;
    lbGroup: TLabel;
    lbStore: TLabel;
    lbSubGroup: TLabel;
    lbVendor: TLabel;
    edBarcode: TEdit;
    btSearch: TBitBtn;
    cbxMethod: TComboBox;
    cbxType: TComboBox;
    scFabricante: TSuperComboADO;
    btFabricanteAll: TButton;
    scColor: TSuperComboADO;
    scSize: TSuperComboADO;
    btnSizeClear: TButton;
    btnColorClear: TButton;
    scCategory: TSuperComboADO;
    btnCategClear: TButton;
    scGroup: TSuperComboADO;
    btnGroupClear: TButton;
    scStore: TSuperComboADO;
    btnStoreAll: TButton;
    scSubGroup: TSuperComboADO;
    btnSubGroupClear: TButton;
    scVendor: TSuperComboADO;
    btnVendorAll: TButton;
    quModel: TADOQuery;
    dsModel: TDataSource;
    quModelIDModel: TIntegerField;
    quModelModel: TStringField;
    quModelDescription: TStringField;
    quModelModelPrice: TBCDField;
    quModelStoreSellingPrice: TBCDField;
    quModelQtyOnHand: TFloatField;
    quModelManufacture: TStringField;
    quModelCategory: TStringField;
    quModelVendor: TStringField;
    quPromoItem: TADODataSet;
    dsPromoItem: TDataSource;
    quPromoItemIDPromoItem: TIntegerField;
    quPromoItemIDModel: TIntegerField;
    cdsModel: TClientDataSet;
    dspModel: TDataSetProvider;
    quModelMarked: TBooleanField;
    Panel4: TPanel;
    pnlButtons: TPanel;
    btSelectAll: TSpeedButton;
    btUnSelectAll: TSpeedButton;
    Panel9: TPanel;
    grdPromoPrizeItem: TcxGrid;
    grdPromoPrizeItemDB: TcxGridDBTableView;
    grdPromoPrizeItemDBMarked: TcxGridDBColumn;
    grdPromoPrizeItemDBModel: TcxGridDBColumn;
    grdPromoPrizeItemDBDescription: TcxGridDBColumn;
    grdPromoPrizeItemDBCategory: TcxGridDBColumn;
    grdPromoPrizeItemDBManufacture: TcxGridDBColumn;
    grdPromoPrizeItemDBVendor: TcxGridDBColumn;
    grdPromoPrizeItemLevel: TcxGridLevel;
    cbxPrimaryBarcode: TCheckBox;
    cbxPrimVendor: TCheckBox;
    procedure btSearchClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnStoreAllClick(Sender: TObject);
    procedure btnCategClearClick(Sender: TObject);
    procedure btnGroupClearClick(Sender: TObject);
    procedure btnSubGroupClearClick(Sender: TObject);
    procedure btnVendorAllClick(Sender: TObject);
    procedure btFabricanteAllClick(Sender: TObject);
    procedure btnSizeClearClick(Sender: TObject);
    procedure btnColorClearClick(Sender: TObject);
    procedure btSelectAllClick(Sender: TObject);
    procedure btUnSelectAllClick(Sender: TObject);
  private
    FIDPromo : Integer;
    procedure CreatePromoItem;

    procedure OpenPromoItem;
    procedure ClosePromoItem;

    procedure CheckAll(AValue: Boolean);
  public
    function Start(IDPromo:Integer):Boolean;
  end;


implementation

uses uDM, uDMGlobal, uMsgBox, uMsgConstant, uSystemConst;

{$R *.dfm}

procedure TFrmPromoItemList.btSearchClick(Sender: TObject);
var
 sSQL, sWhere, sCampo, sVendorJoin, sVendorOrder : String;
begin
  inherited;

  sVendorJoin  := '';
  sWhere       := ' M.Desativado = 0 ';
  sVendorOrder := '';

  if cbxPrimaryBarcode.Checked then
    sVendorJoin := ' LEFT JOIN Barcode B ON (M.IDModel = B.IDModel and B.BarcodeOrder = 1) '
  else
    sVendorJoin := ' LEFT OUTER JOIN Barcode B ON (B.IDModel = M.IDModel) ';

  If Trim(edBarcode.Text) <> '' then
     begin
     Case cbxType.ItemIndex of
       0 : sCampo := 'B.IDBarcode %S ';
       1 : sCampo := 'M.Model %S ';
       2 : sCampo := 'M.Description %S ';
       3 : begin
           sVendorJoin := sVendorJoin + ' LEFT OUTER JOIN VendorModelCode VMC (NOLOCK) ON (M.IDModel = VMC.IDModel) ';
           sCampo      := ' M.IDModel IN (SELECT IDModel FROM VendorModelCode WHERE VendorCode %S )';
           end;
     end;

     Case cbxMethod.ItemIndex of
       0 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr(edBarcode.Text+'%')]);
       1 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text)]);
       2 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edBarcode.Text+'%')]);
     end;
     end;

     if scFabricante.LookUpValue <> '' then
        sWhere := sWhere + ' AND M.IDFabricante = ' + scFabricante.LookUpValue;

     if scSize.LookUpValue <> '' then
        sWhere := sWhere + ' AND M.IDSize = ' + scSize.LookUpValue;

     if scColor.LookUpValue <> '' then
        sWhere := sWhere + ' AND M.IDColor = ' + scColor.LookUpValue;

     if scCategory.LookUpValue <> '' then
        sWhere := sWhere + ' AND M.GroupID = ' + scCategory.LookUpValue;

     if scGroup.LookUpValue <> '' then
        sWhere := sWhere + ' AND M.IDModelGroup = ' + scGroup.LookUpValue;

     if scSubGroup.LookUpValue <> '' then
        sWhere := sWhere + ' AND M.IDModelSubGroup = ' + scSubGroup.LookUpValue;

     if scStore.LookUpValue <> '' then
        sWhere := sWhere + ' AND I.StoreID = ' + scStore.LookUpValue;

     if scVendor.LookUpValue <> '' then
        sWhere := sWhere + ' AND V.IDPessoa = ' + scVendor.LookUpValue;

     if cbxPrimVendor.Checked then
        sVendorOrder := ' AND (VendorOrder = 1) ';


     sSQL := 'SELECT M.IDModel, B.IDBarcode, M.Model, M.Description, M.SellingPrice as ModelPrice, ' +
             'I.SellingPrice as StoreSellingPrice, TG.Name as Category, ' +
             'P.Pessoa as Manufacture, I.QtyOnHand, V.Pessoa as Vendor, Cast(1as Bit) as Marked ' +
             'FROM Model M (NOLOCK) ' +
             'JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) ' +
             'LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = M.IDFabricante) ' +
             'LEFT OUTER JOIN Inventory I (NOLOCK) ON (M.IDModel = I.ModelID) ' +
             'LEFT JOIN Inv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.IDModel ' + sVendorOrder + ') ' +
             'LEFT JOIN Pessoa V (NOLOCK) ON (V.IDPessoa = MV.IDPessoa) ' +
             ' ' + sVendorJoin +
             'WHERE M.ModelType in ('+QuotedStr('R')+', '+QuotedStr('S')+', '+QuotedStr('K')+', '+QuotedStr('V')+', '+QuotedStr('C')+', '+QuotedStr('G')+') ' +
             'AND ' + sWhere +
             ' ORDER BY M.Model, B.IDBarcode';

     With quModel do
        begin
        cdsModel.Close;
        SQL.Text := sSQL;
        cdsModel.Open;
        if cdsModel.RecordCount > 0 then
           begin
           btSearch.Default := False;
           btnSave.Default  := True;
           end;
        end;
end;

procedure TFrmPromoItemList.ClosePromoItem;
begin
   with quPromoItem do
     if Active then
        Close;
end;

procedure TFrmPromoItemList.CreatePromoItem;
var
  NewIDPromoItem : Integer;
begin

  with cdsModel do
    if Active and (RecordCount > 0) then
    try
      DisableControls;
      First;
      while not EOF do
      begin
        if (FieldByName('Marked').AsBoolean) and (not quPromoItem.Locate('IDModel', FieldByName('IDModel').AsInteger, [])) then
        begin
          NewIDPromoItem := DM.GetNextID('Sal_PromoItem.IDPromoItem');
          DM.RunSQL('INSERT INTO Sal_PromoItem (IDPromoItem, IDPromo, IDModel) VALUES ( ' + InttoStr(NewIDPromoItem) + ' , ' + InttoStr(FIDPromo) + ' , ' + FieldByName('IDModel').AsString + ')');
        end;
        Next;
      end;
    finally
      EnableControls;
      ClosePromoItem;
      end;
      
end;

procedure TFrmPromoItemList.OpenPromoItem;
begin

  with quPromoItem do
    if not Active then
    begin
      Parameters.ParamByName('IDPromo').Value := FIDPromo;
      Open;
    end;

end;

function TFrmPromoItemList.Start(IDPromo: Integer): Boolean;
begin

   FIDPromo := IDPromo;
   OpenPromoItem;

   scStore.LookUpValue := IntToStr(DM.fStore.ID);

   ShowModal;

   Result := (ModalResult = mrOK);

   if Result then
      CreatePromoItem;

end;

procedure TFrmPromoItemList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  
  Action := caFree;
end;

procedure TFrmPromoItemList.btnStoreAllClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text := '<' + btnStoreAll.Caption + '>';
end;

procedure TFrmPromoItemList.btnCategClearClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text := '<' + btnCategClear.Caption + '>';
end;

procedure TFrmPromoItemList.btnGroupClearClick(Sender: TObject);
begin
  inherited;
  scGroup.LookUpValue := '';
  scGroup.Text := '<' + btnGroupClear.Caption + '>';
end;

procedure TFrmPromoItemList.btnSubGroupClearClick(Sender: TObject);
begin
  inherited;
  scSubGroup.LookUpValue := '';
  scSubGroup.Text := '<' + btnSubGroupClear.Caption + '>';
end;

procedure TFrmPromoItemList.btnVendorAllClick(Sender: TObject);
begin
  inherited;
  scVendor.LookUpValue := '';
  scVendor.Text := '<'+btnVendorAll.Caption+'>';
end;

procedure TFrmPromoItemList.btFabricanteAllClick(Sender: TObject);
begin
  inherited;
  scFabricante.LookUpValue := '';
  scFabricante.Text := '<'+btFabricanteAll.Caption+'>';
end;

procedure TFrmPromoItemList.btnSizeClearClick(Sender: TObject);
begin
  inherited;
  scSize.LookUpValue := '';
  scSize.Text := '<'+btnSizeClear.Caption+'>';
end;

procedure TFrmPromoItemList.btnColorClearClick(Sender: TObject);
begin
  inherited;
  scColor.LookUpValue := '';
  scColor.Text := '<'+btnColorClear.Caption+'>';
end;

procedure TFrmPromoItemList.CheckAll(AValue: Boolean);
begin
  with cdsModel do
   try
     Screen.Cursor := crHourGlass;
     DisableControls;
     First;
     while not Eof DO
     begin
       Edit;
       FieldByName('Marked').Value := AValue;
       Post;
       Next;
     end;
   finally
    Screen.Cursor := crDefault;
    EnableControls;
   end;
end;

procedure TFrmPromoItemList.btSelectAllClick(Sender: TObject);
begin
  inherited;
  CheckAll(True);
end;

procedure TFrmPromoItemList.btUnSelectAllClick(Sender: TObject);
begin
  inherited;
  CheckAll(False);
end;

end.
