unit uFrmCatalogSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParent, siComp, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, StdCtrls, ExtCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView, uMsgBox, 
  cxGridDBTableView, cxGrid, DBClient, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, Buttons;

type
  TFrmCatalogSearch = class(TFrmParent)
    grdCatalogDBTableView: TcxGridDBTableView;
    grdCatalogLevel: TcxGridLevel;
    grdCatalog: TcxGrid;
    pnlFilter: TPanel;
    pnlBottom: TPanel;
    btnClose: TButton;
    dtsCatalog: TDataSource;
    cdsCatalog: TClientDataSet;
    grdCatalogDBTableViewSkuProduct: TcxGridDBColumn;
    grdCatalogDBTableViewUpc: TcxGridDBColumn;
    grdCatalogDBTableViewTitle: TcxGridDBColumn;
    grdCatalogDBTableViewCategory: TcxGridDBColumn;
    grdCatalogDBTableViewSubCategory: TcxGridDBColumn;
    grdCatalogDBTableViewGroup: TcxGridDBColumn;
    grdCatalogDBTableViewMSRP: TcxGridDBColumn;
    grdCatalogDBTableViewSkuVendor: TcxGridDBColumn;
    grdCatalogDBTableViewVendorCost: TcxGridDBColumn;
    grdCatalogDBTableViewVendor: TcxGridDBColumn;
    grdCatalogDBTableViewVendorCompany: TcxGridDBColumn;
    lblVendor: TLabel;
    cbxVendor: TcxLookupComboBox;
    lblCategory: TLabel;
    cbxCategory: TcxLookupComboBox;
    lblSubCategory: TLabel;
    lblDepartment: TLabel;
    cbxDepartment: TcxLookupComboBox;
    cbxSubCategory: TcxLookupComboBox;
    cbxMethod: TComboBox;
    cbxType: TComboBox;
    edtSearch: TEdit;
    btnSearch: TBitBtn;
    btnAllVendor: TButton;
    btnAllDepartment: TButton;
    btnAllCategory: TButton;
    btnAllSubCategory: TButton;
    btnColumns: TButton;
    btnGroup: TButton;
    procedure btnSearchClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cdsCatalogBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure btnAllVendorClick(Sender: TObject);
    procedure btnAllDepartmentClick(Sender: TObject);
    procedure btnAllCategoryClick(Sender: TObject);
    procedure btnAllSubCategoryClick(Sender: TObject);
    procedure btnColumnsClick(Sender: TObject);
    procedure btnGroupClick(Sender: TObject);
  private
    AOptions: TcxGridStorageOptions;
    FRegistryPath : String;
    AView : TcxCustomGridTableView;
  public
    procedure Start;
  end;

implementation

uses uDMImportExport, uMRSQLParam, uSystemConst;

{$R *.dfm}

procedure TFrmCatalogSearch.Start;
begin

  FRegistryPath := MR_IMP_EXP_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];
  AView := TcxCustomGridTableView(grdCatalog.FocusedView);
  TcxGridDBTableView(AView).RestoreFromRegistry(FRegistryPath, False, False, AOptions);

  try
    DMImportExport.OpenCatalogVendor;
    DMImportExport.OpenCatalogDepartment;
    DMImportExport.OpenCatalogCategory;
    DMImportExport.OpenCatalogSubCategory;

    ShowModal;
  finally
    DMImportExport.CloseCatalogVendor;
    DMImportExport.CloseCatalogDepartment;
    DMImportExport.CloseCatalogCategory;
    DMImportExport.CloseCatalogSubCategory;
    end;

  TcxGridDBTableView(AView).StoreToRegistry(FRegistryPath, True, AOptions);

end;

procedure TFrmCatalogSearch.btnSearchClick(Sender: TObject);
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;
    with cdsCatalog do
    begin
      if Active then
        Close;
      Open;
      { Alex - 04/19/2011 }
      If ( RecordCount >= 250 ) Then MsgBox('Result set is limited to 250 records.', vbInformation + vbOKOnly);

    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmCatalogSearch.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCatalogSearch.cdsCatalogBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
  sSearchField, sField: String;
  Param: TMRSQLParam;
begin
  inherited;
  try
    Param := TMRSQLParam.Create;

    if cbxVendor.EditValue > 0 then
    begin
      Param.AddKey('IDVendor');
      Param.KeyByName('IDVendor').AsInteger := cbxVendor.EditValue;
      Param.KeyByName('IDVendor').Condition := tcEquals;
      Param.KeyByName('IDVendor').Field     := 'V.IDVendor';
    end;


    if cbxDepartment.Text <> '' then
    begin
      Param.AddKey('Department');
      Param.KeyByName('Department').AsString  := cbxDepartment.Text;
      Param.KeyByName('Department').Condition := tcEquals;
      Param.KeyByName('Department').Field     := 'P.Department';
    end;


    if cbxCategory.Text <> '' then
    begin
      Param.AddKey('Category');
      Param.KeyByName('Category').AsString  := cbxCategory.Text;
      Param.KeyByName('Category').Condition := tcEquals;
      Param.KeyByName('Category').Field     := 'P.Category';
    end;

    if cbxSubCategory.Text <> '' then
    begin
      Param.AddKey('SubCategory');
      Param.KeyByName('SubCategory').AsString := cbxSubCategory.Text;
      Param.KeyByName('SubCategory').Condition := tcEquals;
      Param.KeyByName('SubCategory').Field     := 'P.SubCategory';
    end;

    if edtSearch.Text <> '' then
    begin
      case cbxType.ItemIndex of
        0: begin
           sSearchField := 'UPC';
           sField       := 'P.Upc';
           end;
        1: begin
           { Alex - 04/19/2011 }
           sSearchField := 'Sku';
           sField       := 'P.Sku';
           //sSearchField := 'SkuProduct';
           //sField       := 'SkuProduct';
           end;
        2: begin
           { Alex - 04/19/2011 }
           sSearchField := 'vSku';
           sField       := 'vSku';
           // sSearchField := 'SkuVendor';  
           // sField       := 'SkuVendor';
           end;
        3: begin
           sSearchField := 'Title';
           sField       := 'P.Title';
           end;
      end;

      Param.AddKey(sSearchField);
      Param.KeyByName(sSearchField).Condition := tcLike;
      Param.KeyByName(sSearchField).Field := sField;

      case cbxMethod.ItemIndex of
        0: Param.KeyByName(sSearchField).AsString := edtSearch.Text + '%';
        1: Param.KeyByName(sSearchField).AsString := '%' + edtSearch.Text;
        2: Param.KeyByName(sSearchField).AsString := '%' + edtSearch.Text + '%';
      end;
    end;

    OwnerData := Param.ParamString;
  finally
    FreeAndNil(Param);
  end;
end;

procedure TFrmCatalogSearch.btnAllVendorClick(Sender: TObject);
begin
  inherited;
  cbxVendor.Clear;
end;

procedure TFrmCatalogSearch.btnAllDepartmentClick(Sender: TObject);
begin
  inherited;
  cbxDepartment.Clear;
end;

procedure TFrmCatalogSearch.btnAllCategoryClick(Sender: TObject);
begin
  inherited;
  cbxCategory.Clear;
end;

procedure TFrmCatalogSearch.btnAllSubCategoryClick(Sender: TObject);
begin
  inherited;
  cbxSubCategory.Clear;
end;

procedure TFrmCatalogSearch.btnColumnsClick(Sender: TObject);
begin
  inherited;

  TcxGridDBTableView(AView).Controller.Customization := True;
  
end;

procedure TFrmCatalogSearch.btnGroupClick(Sender: TObject);
begin
  inherited;

  TcxGridDBTableView(AView).OptionsView.GroupByBox := not TcxGridDBTableView(AView).OptionsView.GroupByBox;
  
end;

end.
