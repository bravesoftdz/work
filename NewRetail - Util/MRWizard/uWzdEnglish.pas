unit uWzdEnglish;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmParentWizard, StdCtrls, Buttons, ExtCtrls, ComCtrls, jpeg,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid;

type
  TWzdEnglish = class(TFrmParentWizard)
    pnlIntroTop: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    lbMRWeb: TLabel;
    pnlLeft: TPanel;
    lbIntro: TLabel;
    lbBeneficios: TLabel;
    lbRequerimento: TLabel;
    lbTreinamento: TLabel;
    lbManual: TLabel;
    pgIntro: TPageControl;
    tsInformation: TTabSheet;
    Label4: TLabel;
    Shape2: TShape;
    Label5: TLabel;
    Label43: TLabel;
    tsBenificios: TTabSheet;
    Image3: TImage;
    Label6: TLabel;
    Shape1: TShape;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label3: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label38: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Image4: TImage;
    Label40: TLabel;
    Image5: TImage;
    Image6: TImage;
    Label39: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    tsRequisitos: TTabSheet;
    Label51: TLabel;
    Shape3: TShape;
    Label54: TLabel;
    Label55: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    imgComputer: TImage;
    Image7: TImage;
    Image8: TImage;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Label91: TLabel;
    Label92: TLabel;
    tsTreinamento: TTabSheet;
    Label52: TLabel;
    Shape4: TShape;
    imgTreinamento: TImage;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    tsManual: TTabSheet;
    Label53: TLabel;
    Shape5: TShape;
    imgManual: TImage;
    Label7: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    tsAbort: TTabSheet;
    Label56: TLabel;
    tsStore: TTabSheet;
    lbTipoNegocio: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    imgStore: TImage;
    edtLoja: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEstado: TLabeledEdit;
    edtCEP: TLabeledEdit;
    edtTel: TLabeledEdit;
    edtFax: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtWeb: TLabeledEdit;
    cbxTipoNegocio: TComboBox;
    tsUser: TTabSheet;
    Shape6: TShape;
    Label28: TLabel;
    Label2: TLabel;
    imgUser: TImage;
    Label101: TLabel;
    btnAddUser: TSpeedButton;
    cxgriUsuarios: TcxGrid;
    cxGridDBTableViewUsuarios: TcxGridDBTableView;
    cxGridDBTableViewUsuariosUserName: TcxGridDBColumn;
    cxGridDBTableViewUsuariosPassword: TcxGridDBColumn;
    cxGridDBTableViewUsuariosIDUserType: TcxGridDBColumn;
    cxGridLevelUsuarios: TcxGridLevel;
    edtUserName: TLabeledEdit;
    edtSenha: TLabeledEdit;
    cbxUserType: TComboBox;
    tsParameter: TTabSheet;
    pnlInfo: TPanel;
    Label9: TLabel;
    imgParam: TImage;
    tsCategory: TTabSheet;
    pnlCategoria: TPanel;
    Label14: TLabel;
    lbCategoryInfo: TLabel;
    Label47: TLabel;
    imgCategory: TImage;
    pnlCategoryList: TPanel;
    Shape7: TShape;
    Label102: TLabel;
    Shape8: TShape;
    btnAddCategory: TSpeedButton;
    gridCategoryList: TcxGrid;
    gridCategoryListDBTableView: TcxGridDBTableView;
    gridCategoryListDBTableViewCategory: TcxGridDBColumn;
    gridCategoryListDBTableViewMarkup: TcxGridDBColumn;
    gridCategoryListDBTableViewGrade: TcxGridDBColumn;
    gridCategoryListLevel1: TcxGridLevel;
    edtCategory: TLabeledEdit;
    chkGrade: TCheckBox;
    tsProducts: TTabSheet;
    Panel1: TPanel;
    Label18: TLabel;
    lbSizeColorInfo: TLabel;
    Label49: TLabel;
    imgItems: TImage;
    Grid: TButton;
    Label103: TLabel;
    cbxCategory: TComboBox;
    edtCodBarras: TLabeledEdit;
    Shape9: TShape;
    edtModelo: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtCostPrice: TLabeledEdit;
    edtSalePrice: TLabeledEdit;
    edtQty: TLabeledEdit;
    btnAddModel: TSpeedButton;
    gridModelList: TcxGrid;
    gridModelListDBTableView: TcxGridDBTableView;
    gridModelListDBTableViewCategory: TcxGridDBColumn;
    gridModelListDBTableViewBarcode: TcxGridDBColumn;
    gridModelListDBTableViewModel: TcxGridDBColumn;
    gridModelListDBTableViewDescription: TcxGridDBColumn;
    gridModelListDBTableViewCostPrice: TcxGridDBColumn;
    gridModelListDBTableViewSalePrice: TcxGridDBColumn;
    gridModelListDBTableViewQty: TcxGridDBColumn;
    gridModelListDBTableViewSizeAndColor: TcxGridDBColumn;
    gridModelListLevel1: TcxGridLevel;
    tsVendor: TTabSheet;
    imgVendor: TImage;
    Label30: TLabel;
    Label48: TLabel;
    edtFornecedor: TLabeledEdit;
    edtForTel: TLabeledEdit;
    btnAddFornecedor: TSpeedButton;
    Shape10: TShape;
    cxFornecedor: TcxGrid;
    cxGridDBForncedor: TcxGridDBTableView;
    cxGridDBForncedorVendor: TcxGridDBColumn;
    cxGridDBForncedorPhone: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlList: TPanel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label50: TLabel;
    procedure lbBeneficiosClick(Sender: TObject);
    procedure btnAddUserClick(Sender: TObject);
    procedure cxGridDBTableViewUsuariosUserNamePropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxGridDBTableViewUsuariosPasswordPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbxTipoNegocioChange(Sender: TObject);
    procedure btnAddCategoryClick(Sender: TObject);
    procedure gridCategoryListDBTableViewCategoryPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure gridCategoryListDBTableViewGradePropertiesChange(
      Sender: TObject);
    procedure btnAddModelClick(Sender: TObject);
    procedure gridModelListDBTableViewCategoryPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure gridModelListDBTableViewBarcodePropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure gridModelListDBTableViewModelPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure gridModelListDBTableViewDescriptionPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure gridModelListDBTableViewCostPricePropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure gridModelListDBTableViewQtyCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure gridModelListDBTableViewSalePriceCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure GridClick(Sender: TObject);
    procedure gridModelListDBTableViewCellClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure gridModelListDBTableViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure lbMRWebClick(Sender: TObject);
    procedure edtCostPriceExit(Sender: TObject);
    procedure edtCostPriceKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddFornecedorClick(Sender: TObject);
    procedure cxGridDBForncedorVendorPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FKeyFieldValue : String;
    FBusinessType : String;

    procedure BuildCategories;

    procedure FillStore;
    function ValidadeUser: Boolean;
    function ValidadeCategory: Boolean;
    function ValidadeModel: Boolean;
    function ValidadeFornecedor: Boolean;
  protected
    procedure OnMovePriorPage; override;
    procedure OnMoveNextPage; override;
    function ValidatePage : Boolean; override;
    procedure Finish; override;
  public
    { Public declarations }
  end;

implementation

uses uDMExport, uMsgBox, uFrmSizeColorGrid, uWebFunctions, uNumericFunctions,
  uCharFunctions;

{$R *.dfm}

procedure TWzdEnglish.Finish;
begin
  inherited;

end;

procedure TWzdEnglish.lbBeneficiosClick(Sender: TObject);
begin
  inherited;
  pgIntro.ActivePageIndex := TLabel(Sender).Tag;
end;

procedure TWzdEnglish.OnMoveNextPage;
begin
  inherited;

  if pgWizard.ActivePage = tsCategory then
  begin
    if not DMExport.cdsCategory.Active then
    begin
      DMExport.OpenCategory;
      DMExport.LoadCategories(FBusinessType);
      DMExport.cdsCategory.First;
    end;
  end else if pgWizard.ActivePage = tsProducts then
  begin
    if not DMExport.cdsModel.Active then
    begin
      DMExport.OpenModel;
      DMExport.LoadModels(FBusinessType);
      DMExport.OpenGrid;
      DMExport.cdsModel.First;
      BuildCategories;
    end;
  end else if pgWizard.ActivePage = tsUser then
  begin
     DMExport.OpenUser;
  end
  else if pgWizard.ActivePage = tsVendor then
  begin
     DMExport.OpenVendor;
  end
  else if pgWizard.ActivePage = tsFinish then
    btnNext.Caption := 'Finish';


end;

procedure TWzdEnglish.OnMovePriorPage;
begin
  inherited;
  btnNext.Caption := 'Next >>';
end;

function TWzdEnglish.ValidatePage: Boolean;
begin
  inherited ValidatePage;
  Result := False;

  if pgWizard.ActivePage = tsIntro then
  begin
    {
    if not DMExport.IsEmptyDataBase then
    begin
      pgIntro.ActivePage := tsAbort;
      btnPrior.Visible   := False;
      btnNext.Visible    := False;
      Exit;
    end;
    }
  end else if pgWizard.ActivePage = tsParameter then
  begin
  end else if pgWizard.ActivePage = tsCategory then
  begin
    if (DMExport.cdsCategory.RecordCount = 0) then
    begin
      MsgBox('You need to create a category', vbOkOnly + vbInformation);
      Exit;
    end;
  end else if pgWizard.ActivePage = tsStore then
  begin
    if (cbxTipoNegocio.ItemIndex = -1) then
    begin
      MsgBox('Select a Business Type.', vbOkOnly + vbInformation);
      cbxTipoNegocio.SetFocus;
      Exit;
    end;

    if (edtLoja.Text = '') then
    begin
      MsgBox('Enter a store name', vbOkOnly + vbInformation);
      edtLoja.SetFocus;
      Exit;
    end;
  end
  else if pgWizard.ActivePage = tsProducts then
  begin
    if (DMExport.cdsModel.RecordCount = 0) then
    begin
      MsgBox('You need to create a product', vbOkOnly + vbInformation);
      Exit;
    end;
  end;


 Result := True;

end;

procedure TWzdEnglish.btnAddUserClick(Sender: TObject);
var
  IDUserType : Integer;
begin
  inherited;
  if ValidadeUser then
    with DMExport.cdsUser do
    begin
      case cbxUserType.ItemIndex of
       0 : IDUserType := 1;
       1 : IDUserType := 2;
       2 : IDUserType := 4;
      end;

      Append;
      FieldByName('UserName').AsString    := edtUserName.Text;
      FieldByName('Password').AsString    := edtSenha.Text;
      FieldByName('IDUserType').AsInteger := IDUserType;
      Post;

      edtUserName.Clear;
      edtSenha.Clear;
      cbxUserType.ItemIndex := 0;
      edtUserName.SetFocus;
    end;
end;

function TWzdEnglish.ValidadeUser: Boolean;
begin

  Result := False;

  if Trim(edtUserName.Text) = '' then
  begin
    MsgBox('User cannot be empty', vbOkOnly + vbInformation);
    edtUserName.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsUser, 'UserName', Trim(edtUserName.Text)) then
  begin
    MsgBox('User already exist', vbOkOnly + vbInformation);
    edtUserName.SetFocus;
    Exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    MsgBox('Password cannot be empty', vbOkOnly + vbInformation);
    edtSenha.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsUser, 'Password', Trim(edtSenha.Text)) then
  begin
    MsgBox('Password already exist', vbOkOnly + vbInformation);
    edtSenha.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TWzdEnglish.FillStore;
begin
  with DMExport.FStore do
  begin
    StoreName    := edtLoja.Text;
    Address      := edtEndereco.Text;
    City         := edtCidade.Text;
    Zip          := edtCEP.Text;
    StoreState   := edtEstado.Text;
    Tel          := edtTel.Text;
    Fax          := edtFax.Text;
    Email        := edtEmail.Text;
    Web          := edtWeb.Text;
  end;
end;

procedure TWzdEnglish.cxGridDBTableViewUsuariosUserNamePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if DisplayValue = '' then
  begin
    ErrorText := 'User cannot be empty';
    Error := True;
  end else if DMExport.FieldExist(DMExport.cdsUser, 'UserName', DisplayValue) then
  begin
    ErrorText := 'User already exist';
    Error := True;
  end;
  
end;

procedure TWzdEnglish.cxGridDBTableViewUsuariosPasswordPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if DisplayValue = '' then
  begin
    ErrorText := 'Password cannot be empty';
    Error := True;
  end else if DMExport.FieldExist(DMExport.cdsUser, 'Password', DisplayValue) then
  begin
    ErrorText := 'Password already exist';
    Error := True;
  end;
  
end;

procedure TWzdEnglish.cbxTipoNegocioChange(Sender: TObject);
begin
  inherited;
  DMExport.CloseColor;
  DMExport.CloseSize;
  DMExport.CloseGrid;
  DMExport.CloseCategory;
  DMExport.CloseModel;
  FBusinessType := cbxTipoNegocio.Text;
end;

procedure TWzdEnglish.btnAddCategoryClick(Sender: TObject);
begin
  inherited;
  if ValidadeCategory then
    with DMExport.cdsCategory do
    begin
      Append;
      FieldByName('Category').AsString  := edtCategory.Text;
      FieldByName('SizeAndColor').Value := chkGrade.Checked;
      Post;

      edtCategory.Clear;
      chkGrade.Checked := False;
      edtCategory.SetFocus;
    end;
end;

function TWzdEnglish.ValidadeCategory: Boolean;
begin

  Result := False;

  if Trim(edtCategory.Text) = '' then
  begin
    MsgBox('Category cannot be empty', vbOkOnly + vbInformation);
    edtCategory.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsCategory, 'Category', Trim(edtCategory.Text)) then
  begin
    MsgBox('Category already exist', vbOkOnly + vbInformation);
    edtCategory.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TWzdEnglish.gridCategoryListDBTableViewCategoryPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if DisplayValue = '' then
  begin
    ErrorText := 'Category cannot be empty';
    Error := True;
  end else if DMExport.FieldExist(DMExport.cdsCategory, 'Category', DisplayValue) then
  begin
    ErrorText := 'Category already exist';
    Error := True;
  end;

end;

procedure TWzdEnglish.gridCategoryListDBTableViewGradePropertiesChange(
  Sender: TObject);
begin
  inherited;

  if DMExport.cdsCategory.FieldByName('System').AsBoolean then
  begin
    if not (DMExport.cdsCategory.State = dsEdit) then
      DMExport.cdsCategory.Edit;

    DMExport.cdsCategory.FieldByName('SizeAndColor').AsBoolean :=
       DMExport.cdsCategory.FieldByName('SizeAndColor').OldValue;
    lbCategoryInfo.Visible := True;
  end else
    lbCategoryInfo.Visible := False;

end;

procedure TWzdEnglish.BuildCategories;
begin

  cbxCategory.Items.Clear;

  with DMExport.cdsCategory do
  begin
    First;
    while not EOF do
    begin
      cbxCategory.Items.Add(FieldByName('Category').AsString);
      Next;
    end;
    First;
    cbxCategory.Sorted := True;
  end;

end;

procedure TWzdEnglish.btnAddModelClick(Sender: TObject);
begin
  inherited;

  if ValidadeModel then
    with DMExport.cdsModel do
    begin
      DMExport.FCategoryOldValue := '123ABC';
      Append;
      FieldByName('Category').AsString    := cbxCategory.Text;
      FieldByName('Barcode').AsString     := edtCodBarras.Text;
      FieldByName('Model').AsString       := edtModelo.Text;
      FieldByName('Description').AsString := edtDescricao.Text;
      FieldByName('CostPrice').AsFloat    := StrToFloatDef(edtCostPrice.Text, 1);
      FieldByName('SalePrice').AsFloat    := StrToFloatDef(edtSalePrice.Text, 1);
      FieldByName('Qty').AsFloat          := StrToFloatDef(edtQty.Text, 1);
      Post;

      edtCodBarras.Clear;
      edtModelo.Clear;
      edtDescricao.Clear;
      edtCostPrice.Clear;
      edtSalePrice.Clear;
      edtQty.Text := '1';
      edtCodBarras.SetFocus;
    end;

end;

function TWzdEnglish.ValidadeModel: Boolean;
begin

  Result := False;

  if (cbxCategory.Text = '') then
  begin
    MsgBox('Category cannot be empty', vbOkOnly + vbInformation);
    cbxCategory.SetFocus;
    Exit;
  end;

  if Trim(edtCodBarras.Text) = '' then
  begin
    MsgBox('Barcode cannot be empty', vbOkOnly + vbInformation);
    edtCodBarras.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsModel, 'Barcode', Trim(edtCodBarras.Text)) then
  begin
    MsgBox('Barcode already exist', vbOkOnly + vbInformation);
    edtCodBarras.SetFocus;
    Exit;
  end;

  if Trim(edtModelo.Text) = '' then
  begin
    MsgBox('Model cannot be empty', vbOkOnly + vbInformation);
    edtModelo.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsModel, 'Model', Trim(edtModelo.Text)) then
  begin
    MsgBox('Model already exist', vbOkOnly + vbInformation);
    edtModelo.SetFocus;
    Exit;
  end;

  if Trim(edtDescricao.Text) = '' then
  begin
    MsgBox('Description cannot be empty', vbOkOnly + vbInformation);
    edtDescricao.SetFocus;
    Exit;
  end;

  if Trim(edtCostPrice.Text) = '' then
  begin
    MsgBox('Cost Price cannot be empty', vbOkOnly + vbInformation);
    edtCostPrice.SetFocus;
    Exit;
  end else if StrToFloatDef(edtCostPrice.Text, 0) <= 0 then
  begin
    MsgBox('Cost Price cannot lesser or equal the 0', vbOkOnly + vbInformation);
    edtCostPrice.SetFocus;
    Exit;
  end;

  if Trim(edtSalePrice.Text) = '' then
  begin
    MsgBox('Sale Price cannot be empty', vbOkOnly + vbInformation);
    edtSalePrice.SetFocus;
    Exit;
  end else if StrToFloatDef(edtSalePrice.Text, 0) <= 0 then
  begin
    MsgBox('Sale Price cannot lesser or equal the 0', vbOkOnly + vbInformation);
    edtSalePrice.SetFocus;
    Exit;
  end;

  if Trim(edtQty.Text) = '' then
  begin
    MsgBox('Qty cannot be empty', vbOkOnly + vbInformation);
    edtQty.SetFocus;
    Exit;
  end else if StrToFloatDef(edtQty.Text, 0) <= 0 then
  begin
    MsgBox('Qty cannot lesser or equal the 0', vbOkOnly + vbInformation);
    edtQty.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TWzdEnglish.gridModelListDBTableViewCategoryPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if (DisplayValue = '') then
  begin
    ErrorText := 'Category cannot be empty';
    Error := True;
  end;
  
end;

procedure TWzdEnglish.gridModelListDBTableViewBarcodePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if DisplayValue <> '' then
    if DMExport.FieldExist(DMExport.cdsModel, 'Barcode', DisplayValue) then
    begin
      ErrorText := 'Barcode already exist';
      Error := True;
    end;
  
end;

procedure TWzdEnglish.gridModelListDBTableViewModelPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if (DisplayValue = '') then
  begin
    ErrorText := 'Model cannot be empty';
    Error := True;
  end else if DMExport.FieldExist(DMExport.cdsModel, 'Model', DisplayValue) then
  begin
    ErrorText := 'Model already exist';
    Error := True;
  end;
  
end;

procedure TWzdEnglish.gridModelListDBTableViewDescriptionPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if (DisplayValue = '') then
  begin
    ErrorText := 'Description cannot be empty';
    Error := True;
  end;
  
end;

procedure TWzdEnglish.gridModelListDBTableViewCostPricePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if (DisplayValue = '') then
  begin
    ErrorText := 'Cost Price cannot be empty';
    Error := True;
  end;
  
end;

procedure TWzdEnglish.gridModelListDBTableViewQtyCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if AViewInfo.GridRecord.Values[gridModelListDBTableViewSizeAndColor.Index] = True then
    ACanvas.Font.Color := clBlue
  else
    ACanvas.Font.Color := clBlack;
  
end;

procedure TWzdEnglish.gridModelListDBTableViewSalePriceCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if AViewInfo.GridRecord.Values[gridModelListDBTableViewSizeAndColor.Index] = True then
    ACanvas.Font.Color := clBlue
  else
    ACanvas.Font.Color := clBlack;
  
end;

procedure TWzdEnglish.GridClick(Sender: TObject);
begin
  inherited;
  with TFrmSizeColorGrid.Create(Self) do
    Start(DMExport.cdsModel.FieldByName('Model').AsString);
end;

procedure TWzdEnglish.gridModelListDBTableViewCellClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  if ((ACellViewInfo.Item.Name = 'gridModelListDBTableViewSalePrice') or
     (ACellViewInfo.Item.Name = 'gridModelListDBTableViewQty')) and
     DMExport.cdsModel.FieldByName('SizeAndColor').AsBoolean then
  begin
    with TFrmSizeColorGrid.Create(Self) do
      Start(DMExport.cdsModel.FieldByName('Model').AsString);
  end
  else if (ACellViewInfo.Item.Name = 'gridModelListDBTableViewModel') or
     (ACellViewInfo.Item.Name = 'gridModelListDBTableViewCategory') then
    lbSizeColorInfo.Visible := DMExport.cdsModel.FieldByName('SizeAndColor').AsBoolean
  else
    lbSizeColorInfo.Visible := False;
  
end;

procedure TWzdEnglish.gridModelListDBTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;

  if VarToStr(AItem.EditValue) <> '' then
    if AItem.Name = 'gridModelListDBTableViewModel' then
      DMExport.FModelOldValue := VarToStr(AItem.EditValue)
    else if AItem.Name = 'gridModelListDBTableViewCategory' then
    begin
      DMExport.FCategoryOldValue := VarToStr(AItem.EditValue);
      DMExport.FModelOldValue := DMExport.cdsModel.FieldByName('Model').AsString;
    end;
  
end;

procedure TWzdEnglish.lbMRWebClick(Sender: TObject);
begin
  inherited;
  OpenURL(lbMRWeb.Caption);
end;

procedure TWzdEnglish.edtCostPriceExit(Sender: TObject);
begin
  inherited;

  if edtCostPrice.Text <> '' then
  begin
    edtSalePrice.Text := FormatCurr('##0.00', MyStrToMoney(edtCostPrice.Text) * 2);
    edtCostPrice.Text := FormatCurr('##0.00', MyStrToMoney(edtCostPrice.Text));
  end;
  
end;

procedure TWzdEnglish.edtCostPriceKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TWzdEnglish.btnAddFornecedorClick(Sender: TObject);
begin
  inherited;

  if ValidadeFornecedor then
    with DMExport.cdsVendor do
    begin
      Append;
      FieldByName('Vendor').AsString := edtFornecedor.Text;
      FieldByName('Phone').AsString  := edtForTel.Text;
      Post;

      edtFornecedor.Clear;
      edtForTel.Clear;
      edtFornecedor.SetFocus;
    end;

end;

function TWzdEnglish.ValidadeFornecedor: Boolean;
begin

  Result := False;

  if (edtFornecedor.Text = '') then
  begin
    MsgBox('Vendor cannot be empty', vbOkOnly + vbInformation);
    edtFornecedor.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TWzdEnglish.cxGridDBForncedorVendorPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if (DisplayValue = '') then
  begin
    ErrorText := 'Vendor cannot be empty';
    Error := True;
  end;

end;

end.
