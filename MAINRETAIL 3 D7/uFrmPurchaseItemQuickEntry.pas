unit uFrmPurchaseItemQuickEntry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  ADODB, DB, Buttons, DBCtrls, uFrmModelQuickEntry, uFrmBarcodeSearch,
  mrBarCodeEdit;

type
  TFrmPurchaseItemQuickEntry = class(TFrmParent)
    Panel4: TPanel;
    lblVendor: TLabel;
    lblSearchType: TLabel;
    lblQty: TLabel;
    gbxModelProperties: TGroupBox;
    lblModel: TLabel;
    lblDescription: TLabel;
    lblCost: TLabel;
    lblManufacturer: TLabel;
    lblOurPrice: TLabel;
    DBText: TDBText;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    cbxSearchType: TComboBox;
    edtSearchNumber: TEdit;
    pnlButtons: TPanel;
    btNewItem: TSpeedButton;
    btSearch: TSpeedButton;
    edtVendor: TEdit;
    edtQty: TEdit;
    qryModel: TADODataSet;
    qryModelIDModel: TIntegerField;
    qryModelModel: TStringField;
    qryModelDescription: TStringField;
    qryModelSellingPrice: TBCDField;
    qryModelFinalCost: TBCDField;
    qryModelSuggRetail: TBCDField;
    qryModelManufacturer: TStringField;
    dtsModel: TDataSource;
    cmdInsPurchaseItem: TADOCommand;
    btAdd: TButton;
    qryModelGroupID: TIntegerField;
    lblQtyType: TLabel;
    cbxQtyType: TComboBox;
    lblCaseQty: TLabel;
    DBText5: TDBText;
    qryModelCaseQty: TFloatField;
    edtBarcode: TmrBarCodeEdit;
    procedure btNewItemClick(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure edtSearchNumberKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure edtQtyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbxQtyTypeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSearchNumberExit(Sender: TObject);
    procedure cbxSearchTypeChange(Sender: TObject);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
  private
    FModelSQL: String;
    FIDPurchase: Integer;
    FIDVendor: Integer;
    FFrmModelQuickEntry: TFrmModelQuickEntry;
    FFrmBarcodeSearch: TFrmBarcodeSearch;

    procedure LoadImages;
    procedure SearchModel(AIDModel: Integer);
    procedure InsertPurchaseItem;
    procedure RefreshControls;
  public
    procedure Start(AIDPurchase, AIDVendor: Integer; AVendorName: String);
  end;

implementation

uses uDM, uSystemConst, uCharFunctions, uMsgBox, uMsgConstant, uContentClasses;

{$R *.dfm}

procedure TFrmPurchaseItemQuickEntry.btNewItemClick(Sender: TObject);
var
  ABarcode: TBarcode;
begin
  inherited;
  ABarcode := FFrmModelQuickEntry.Start(False, True, False, '');
  if ABarcode.Model.IDModel <> -1 then
    SearchModel(ABarcode.Model.IDModel);
end;

procedure TFrmPurchaseItemQuickEntry.btSearchClick(Sender: TObject);
var
  iIDModel: Integer;
begin
  inherited;
  iIDModel := FFrmBarcodeSearch.Start;
  if iIDModel <> -1 then
    SearchModel(iIDModel);
end;

procedure TFrmPurchaseItemQuickEntry.edtSearchNumberKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = 13) then
    SearchModel(0);
end;

procedure TFrmPurchaseItemQuickEntry.edtQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TFrmPurchaseItemQuickEntry.InsertPurchaseItem;
begin
  with cmdInsPurchaseItem do
  begin
    Parameters.ParamByName('IDPurchase').Value := FIDPurchase;
    Parameters.ParamByName('IDPurchaseItem').Value := DM.GetNextID('Pur_PurchaseItem.IDPurchaseItem');
    Parameters.ParamByName('IDModel').Value := qryModel.FieldByName('IDModel').AsInteger;
    Parameters.ParamByName('IDGroup').Value := qryModel.FieldByName('GroupID').AsInteger;
    Parameters.ParamByName('IDFornecedor').Value := FIDVendor;

    if cbxQtyType.ItemIndex = 0 then
    begin
      Parameters.ParamByName('CaseQty').Value := StrToInt(edtQty.Text);
      Parameters.ParamByName('CaseCost').Value := qryModel.FieldByName('CaseQty').AsFloat * qryModel.FieldByName('FinalCost').AsFloat;
      Parameters.ParamByName('Qty').Value := StrToInt(edtQty.Text) * qryModel.FieldByName('CaseQty').AsFloat;
    end
    else
    begin
      Parameters.ParamByName('CaseQty').Value := NULL;
      Parameters.ParamByName('CaseCost').Value := NULL;
      Parameters.ParamByName('Qty').Value := StrToInt(edtQty.Text);
    end;

    Parameters.ParamByName('NewCostPrice').Value := qryModel.FieldByName('FinalCost').AsFloat;
    Parameters.ParamByName('NewSalePrice').Value := qryModel.FieldByName('SellingPrice').AsFloat;
    Parameters.ParamByName('NewSuggRetail').Value := qryModel.FieldByName('SuggRetail').AsFloat;
    Parameters.ParamByName('CostPrice').Value := qryModel.FieldByName('FinalCost').AsFloat * StrToInt(edtQty.Text);
    Execute;
  end;
end;

procedure TFrmPurchaseItemQuickEntry.LoadImages;
begin
  DM.imgSmall.GetBitmap(BTN18_NEW, btNewItem.Glyph);
  DM.imgSmall.GetBitmap(BTN18_SEARCH, btSearch.Glyph);
end;

procedure TFrmPurchaseItemQuickEntry.SearchModel(AIDModel: Integer);
begin
  with qryModel do
  begin
    Close;
    CommandText := FModelSQL;

    if AIDModel <> 0 then
      CommandText := CommandText + ' WHERE M.IDModel = ' + IntToStr(AIDModel)
    else
    begin
      case cbxSearchType.ItemIndex of
        0: CommandText := CommandText + ' WHERE B.IDBarcode = ' + QuotedStr(edtBarcode.Text);
        1: CommandText := CommandText + ' WHERE M.Model = ' + QuotedStr(edtSearchNumber.Text);
        2: CommandText := CommandText + ' WHERE VMC.VendorCode = ' + QuotedStr(edtSearchNumber.Text);
      end;
    end;

    Parameters.ParamByName('IDVendor').Value := FIDVendor;
    Open;

    if RecordCount = 0 then
    begin
      edtSearchNumber.Clear;
      edtBarcode.Clear;  
      case cbxSearchType.ItemIndex of
        0: MsgBox(MSG_INF_BARCODE_NOT_FOUND, vbInformation + vbOKOnly);
        1: MsgBox(MSG_INF_MODEL_NOT_FOUND, vbInformation + vbOKOnly);
        2: MsgBox(MSG_INF_VENDOR_NUMBER_NOT_FOUND, vbInformation + vbOKOnly);
      end;
    end
    else
    begin
      RefreshControls;
      edtSearchNumber.Clear;
      edtBarcode.Clear;
    end; 
  end;
end;

procedure TFrmPurchaseItemQuickEntry.Start(AIDPurchase, AIDVendor: Integer;
  AVendorName: String);
begin
  FIDPurchase := AIDPurchase;
  FIDVendor := AIDVendor;
  edtVendor.Text := AVendorName;
  ShowModal;
end;

procedure TFrmPurchaseItemQuickEntry.FormCreate(Sender: TObject);
begin
  inherited;
  LoadImages;
  FModelSQL := qryModel.CommandText;

  FFrmModelQuickEntry := TFrmModelQuickEntry.Create(Self);
  FFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);

  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];
  
end;

procedure TFrmPurchaseItemQuickEntry.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FFrmModelQuickEntry);
  FreeAndNil(FFrmBarcodeSearch);
end;

procedure TFrmPurchaseItemQuickEntry.FormShow(Sender: TObject);
begin
  inherited;
  edtBarcode.SetFocus;
end;

procedure TFrmPurchaseItemQuickEntry.btAddClick(Sender: TObject);
begin
  inherited;
  if (not qryModel.Active) or (qryModel.RecordCount = 0) then
  begin
    MsgBox(MSG_EXC_SELECT_A_MODEL, vbInformation + vbOKOnly);
    Exit;
  end;

  if (edtQty.Text = '') or (StrToInt(edtQty.Text) = 0) then
  begin
    MsgBox(MSG_CRT_QTY_NO_ZERO, vbInformation + vbOKOnly);
  end
  else
  begin
    InsertPurchaseItem;
    edtQty.Clear;
    edtSearchNumber.Clear;
    edtBarcode.Clear;
    if edtSearchNumber.CanFocus then
      edtSearchNumber.SetFocus;
    if edtBarcode.CanFocus then
      edtBarcode.SetFocus;
    cbxQtyType.Visible := False;
    lblQtyType.Visible := False;
    qryModel.Close;
  end;
end;

procedure TFrmPurchaseItemQuickEntry.edtQtyKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = 13) then
    btAddClick(Sender);
end;

procedure TFrmPurchaseItemQuickEntry.cbxQtyTypeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = 13) then
    edtQty.SetFocus;
end;

procedure TFrmPurchaseItemQuickEntry.RefreshControls;
begin
  with qryModel do
  begin
    if FieldByName('CaseQty').AsFloat > 0 then
    begin
      cbxQtyType.Enabled := True;
      cbxQtyType.TabStop := False;
      cbxQtyType.ItemIndex := 0;
      cbxQtyType.Visible := True;
      lblQtyType.Visible := True;
      edtQty.SetFocus;
    end
    else
    begin
      cbxQtyType.Enabled := False;
      cbxQtyType.TabStop := True;
      cbxQtyType.ItemIndex := 1;
      cbxQtyType.Visible := False;
      lblQtyType.Visible := False;
      edtQty.SetFocus;
    end;
  end;
end;

procedure TFrmPurchaseItemQuickEntry.edtSearchNumberExit(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).Text <> '' then
    SearchModel(0);
end;

procedure TFrmPurchaseItemQuickEntry.cbxSearchTypeChange(Sender: TObject);
begin
  inherited;
  if cbxSearchType.ItemIndex = 0 then
    edtBarcode.BringToFront
  else
    edtSearchNumber.BringToFront;
end;

procedure TFrmPurchaseItemQuickEntry.edtBarcodeAfterSearchBarcode(
  Sender: TObject);
begin
  inherited;
  with edtBarcode do
    if SearchResult then
      SearchModel(GetFieldValue('IDModel'))
    else
      begin
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
      Clear;
      end;
end;

end.
