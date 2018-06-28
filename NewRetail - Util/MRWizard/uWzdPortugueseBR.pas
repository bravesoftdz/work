unit uWzdPortugueseBR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmParentWizard, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, jpeg;

type
  TWzdPortugueseBR = class(TFrmParentWizard)
    tsParameters: TTabSheet;
    pnlTax: TPanel;
    Label8: TLabel;
    rbTaxSimple: TRadioButton;
    rbTaxComplete: TRadioButton;
    Label10: TLabel;
    edtTaxValue: TEdit;
    Label11: TLabel;
    edtEncargo: TEdit;
    lbEncargosHelp: TLabel;
    lbSimplesHelp: TLabel;
    pnlPosDate: TPanel;
    Label12: TLabel;
    edtNumberPostDate: TEdit;
    pnlEntrega: TPanel;
    Label13: TLabel;
    rdEntregaSim: TRadioButton;
    rdEntregaNo: TRadioButton;
    pnlInfo: TPanel;
    Label9: TLabel;
    lbEntregaHint: TLabel;
    tsStore: TTabSheet;
    edtLoja: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEstado: TLabeledEdit;
    edtCEP: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtTel: TLabeledEdit;
    edtFax: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtWeb: TLabeledEdit;
    pnlImpostos: TPanel;
    edtIPI: TLabeledEdit;
    edtPIS: TLabeledEdit;
    edtCOFINS: TLabeledEdit;
    tsCategoria: TTabSheet;
    pnlCategoria: TPanel;
    Label14: TLabel;
    pnlCategoryList: TPanel;
    lbTipoNegocio: TLabel;
    cbxTipoNegocio: TComboBox;
    Label15: TLabel;
    gridCategoryListDBTableView: TcxGridDBTableView;
    gridCategoryListLevel1: TcxGridLevel;
    gridCategoryList: TcxGrid;
    gridCategoryListDBTableViewCategory: TcxGridDBColumn;
    gridCategoryListDBTableViewMarkup: TcxGridDBColumn;
    Label16: TLabel;
    Label17: TLabel;
    tsProdutos: TTabSheet;
    Panel1: TPanel;
    Label18: TLabel;
    gridModelList: TcxGrid;
    gridModelListDBTableView: TcxGridDBTableView;
    gridModelListDBTableViewCategory: TcxGridDBColumn;
    gridModelListDBTableViewBarcode: TcxGridDBColumn;
    gridModelListDBTableViewModel: TcxGridDBColumn;
    gridModelListDBTableViewDescription: TcxGridDBColumn;
    gridModelListDBTableViewCostPrice: TcxGridDBColumn;
    gridModelListDBTableViewSalePrice: TcxGridDBColumn;
    gridModelListDBTableViewQty: TcxGridDBColumn;
    gridModelListLevel1: TcxGridLevel;
    pnlLeft: TPanel;
    lbIntro: TLabel;
    pgIntro: TPageControl;
    tsInformation: TTabSheet;
    Label4: TLabel;
    pnlIntroTop: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    tsBenificios: TTabSheet;
    lbMRWeb: TLabel;
    lbBeneficios: TLabel;
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
    Shape2: TShape;
    Label5: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    tsUsuarios: TTabSheet;
    Label28: TLabel;
    cxgriUsuarios: TcxGrid;
    cxGridDBTableViewUsuarios: TcxGridDBTableView;
    cxGridLevelUsuarios: TcxGridLevel;
    cxGridDBTableViewUsuariosUserName: TcxGridDBColumn;
    cxGridDBTableViewUsuariosPassword: TcxGridDBColumn;
    cxGridDBTableViewUsuariosIDUserType: TcxGridDBColumn;
    Label29: TLabel;
    tsFornecedor: TTabSheet;
    Label30: TLabel;
    cxFornecedor: TcxGrid;
    cxGridDBForncedor: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridDBForncedorVendor: TcxGridDBColumn;
    Label38: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    pnlList: TPanel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label43: TLabel;
    Label2: TLabel;
    Image4: TImage;
    Label40: TLabel;
    Image5: TImage;
    Image6: TImage;
    Label39: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Grid: TButton;
    gridModelListDBTableViewSizeAndColor: TcxGridDBColumn;
    lbSizeColorInfo: TLabel;
    gridCategoryListDBTableViewGrade: TcxGridDBColumn;
    lbCategoryInfo: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    imgParam: TImage;
    imgStore: TImage;
    imgUser: TImage;
    imgCategory: TImage;
    imgItems: TImage;
    imgVendor: TImage;
    Label50: TLabel;
    lbRequerimento: TLabel;
    tsRequisitos: TTabSheet;
    Label51: TLabel;
    Shape3: TShape;
    lbTreinamento: TLabel;
    tsTreinamento: TTabSheet;
    Label52: TLabel;
    Shape4: TShape;
    lbManual: TLabel;
    tsManual: TTabSheet;
    Label53: TLabel;
    Shape5: TShape;
    cxGridDBForncedorPhone: TcxGridDBColumn;
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
    imgManual: TImage;
    Label7: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    imgTreinamento: TImage;
    Label97: TLabel;
    tsAbort: TTabSheet;
    Label56: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    edtUserName: TLabeledEdit;
    edtSenha: TLabeledEdit;
    Label101: TLabel;
    cbxUserType: TComboBox;
    btnAddUser: TSpeedButton;
    Shape6: TShape;
    Shape7: TShape;
    Label102: TLabel;
    edtCategory: TLabeledEdit;
    chkGrade: TCheckBox;
    Shape8: TShape;
    btnAddCategory: TSpeedButton;
    Shape9: TShape;
    btnAddModel: TSpeedButton;
    edtCodBarras: TLabeledEdit;
    edtModelo: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtCostPrice: TLabeledEdit;
    edtSalePrice: TLabeledEdit;
    edtQty: TLabeledEdit;
    Label103: TLabel;
    cbxCategory: TComboBox;
    Shape10: TShape;
    edtFornecedor: TLabeledEdit;
    edtForTel: TLabeledEdit;
    btnAddFornecedor: TSpeedButton;
    Label104: TLabel;
    procedure rbTaxCompleteClick(Sender: TObject);
    procedure cbxTipoNegocioChange(Sender: TObject);
    procedure lbIntroClick(Sender: TObject);
    procedure edtTaxValueKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumberPostDateKeyPress(Sender: TObject; var Key: Char);
    procedure GridClick(Sender: TObject);
    procedure gridModelListDBTableViewQtyCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure gridModelListDBTableViewCellClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure gridModelListDBTableViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure gridCategoryListDBTableViewGradePropertiesChange(
      Sender: TObject);
    procedure lbMRWebClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddUserClick(Sender: TObject);
    procedure cxGridDBTableViewUsuariosPasswordPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxGridDBTableViewUsuariosUserNamePropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnAddCategoryClick(Sender: TObject);
    procedure gridCategoryListDBTableViewCategoryPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnAddModelClick(Sender: TObject);
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
    procedure edtCostPriceKeyPress(Sender: TObject; var Key: Char);
    procedure edtSalePriceKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure edtCostPriceExit(Sender: TObject);
    procedure btnAddFornecedorClick(Sender: TObject);
    procedure gridModelListDBTableViewCategoryPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure edtTaxValueExit(Sender: TObject);
    procedure cxGridDBForncedorVendorPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private
    FKeyFieldValue : String;
    FBusinessType : String;
    procedure FillParams;
    procedure FillStore;
    procedure FillTaxes;

    procedure BuildCategories;
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
    procedure Start; override;
  end;

implementation

uses uDMExport, uMsgBox, uCharFunctions, uFrmSizeColorGrid, uWebFunctions,
     uNumericFunctions;

{$R *.dfm}

{ TWzdPortugueseBR }

procedure TWzdPortugueseBR.FillParams;
begin
  DMExport.FParams.MaxNumberForPostDate := StrToIntDef(edtNumberPostDate.Text, 0);
  DMExport.FParams.DeliveryFeature      := rdEntregaSim.Checked;
  DMExport.FParams.PostDateSale         := (StrToIntDef(edtNumberPostDate.Text, 0) > 1);
  DMExport.FParams.SimpleTax            := rbTaxSimple.Checked;
  DMExport.FParams.ExemptTaxOnSale      := True;
  DMExport.FParams.TaxOnCost            := True;
end;

procedure TWzdPortugueseBR.Start;
begin
  inherited;
end;

procedure TWzdPortugueseBR.FillStore;
begin
  with DMExport.FStore do
  begin
    StoreName    := edtLoja.Text;
    Address      := edtEndereco.Text;
    City         := edtCidade.Text;
    Neighborhood := edtBairro.Text;
    Zip          := edtCEP.Text;
    StoreState   := edtEstado.Text;
    Tel          := edtTel.Text;
    Fax          := edtFax.Text;
    Email        := edtEmail.Text;
    Web          := edtWeb.Text;
  end;
end;

procedure TWzdPortugueseBR.rbTaxCompleteClick(Sender: TObject);
begin
  inherited;
  pnlImpostos.Visible := rbTaxComplete.Checked;
end;

procedure TWzdPortugueseBR.FillTaxes;
begin
  DMExport.FTax.BrazilMode    := True;
  DMExport.FTax.SaleTaxName   := 'ICMS ' + edtTaxValue.Text;
  DMExport.FTax.SaleTax       := StrToFloatDef(edtTaxValue.Text, 0);
  DMExport.FTax.IPI           := StrToFloatDef(edtIPI.Text, 0);
  DMExport.FTax.PIS           := StrToFloatDef(edtPIS.Text, 0);
  DMExport.FTax.COFINS        := StrToFloatDef(edtCOFINS.Text, 0);
end;

procedure TWzdPortugueseBR.OnMoveNextPage;
begin
  inherited;

  if pgWizard.ActivePage = tsCategoria then
  begin
    if not DMExport.cdsCategory.Active then
    begin
      DMExport.OpenCategory;
      DMExport.LoadCategories(FBusinessType);
      DMExport.cdsCategory.First;
    end;
  end else if pgWizard.ActivePage = tsUsuarios then
  begin
     DMExport.OpenUser;
  end
  else if pgWizard.ActivePage = tsProdutos then
  begin
    if not DMExport.cdsModel.Active then
    begin
      DMExport.OpenModel;
      DMExport.LoadModels(FBusinessType);
      DMExport.OpenGrid;
      DMExport.cdsModel.First;
      BuildCategories;
    end;
  end
  else if pgWizard.ActivePage = tsFornecedor then
  begin
     DMExport.OpenVendor;
  end

  else if pgWizard.ActivePage = tsFinish then
    btnNext.Caption := 'Finalizar';

end;

procedure TWzdPortugueseBR.cbxTipoNegocioChange(Sender: TObject);
begin
  inherited;
  DMExport.CloseColor;
  DMExport.CloseSize;
  DMExport.CloseGrid;
  DMExport.CloseCategory;
  DMExport.CloseModel;
  FBusinessType := cbxTipoNegocio.Text;
end;

procedure TWzdPortugueseBR.lbIntroClick(Sender: TObject);
begin
  inherited;
  pgIntro.ActivePageIndex := TLabel(Sender).Tag;
end;

function TWzdPortugueseBR.ValidatePage: Boolean;
begin
  inherited ValidatePage;
  Result := False;

  if pgWizard.ActivePage = tsIntro then
  begin
    if not DMExport.IsEmptyDataBase then
    begin
      pgIntro.ActivePage := tsAbort;
      btnPrior.Visible   := False;
      btnNext.Visible    := False;
      Exit;
    end;
  end else if pgWizard.ActivePage = tsParameters then
  begin
    if (not rbTaxSimple.Checked) and (not rbTaxComplete.Checked) then
    begin
      MsgBox('Responder qual o tipo de imposto da empresa', vbOkOnly + vbInformation);
      rbTaxSimple.SetFocus;
      Exit;
    end
    else if (rbTaxSimple.Checked) and (edtTaxValue.Text = '') then
    begin
      MsgBox('Responder qual o valor do ICMS', vbOkOnly + vbInformation);
      edtTaxValue.SetFocus;
      Exit;
    end else if (rbTaxComplete.Checked) and ((edtTaxValue.Text = '') or (edtIPI.Text = '') or (edtPIS.Text = '') or (edtCOFINS.Text = '') )then
    begin
      MsgBox('Responder qual o valor dos outros impostos', vbOkOnly + vbInformation);
      edtTaxValue.SetFocus;
      Exit;
    end;

    if (not rdEntregaSim.Checked) and (not rdEntregaNo.Checked) then
    begin
      MsgBox('Responder se você trabalha com entrega', vbOkOnly + vbInformation);
      rdEntregaNo.SetFocus;
      Exit;
    end;
  end else if pgWizard.ActivePage = tsStore then
  begin
    if (cbxTipoNegocio.ItemIndex = -1) then
    begin
      MsgBox('Selecionar um tipo de negocio.', vbOkOnly + vbInformation);
      cbxTipoNegocio.SetFocus;
      Exit;
    end;

    if (edtLoja.Text = '') then
    begin
      MsgBox('Informar o nome da loja', vbOkOnly + vbInformation);
      edtLoja.SetFocus;
      Exit;
    end;
  end else if pgWizard.ActivePage = tsUsuarios then
  begin
    if (DMExport.cdsUser.RecordCount = 0) then
    begin
      MsgBox('E necessário cadastrar alguns usuários para utilizar o sistema', vbOkOnly + vbInformation);
      Exit;
    end;
  end else if pgWizard.ActivePage = tsCategoria then
  begin
    if (DMExport.cdsCategory.RecordCount = 0) then
    begin
      MsgBox('E necessário cadastrar algumas categorias para utilizar o sistema', vbOkOnly + vbInformation);
      Exit;
    end;
  end else if pgWizard.ActivePage = tsProdutos then
  begin
    if (DMExport.cdsModel.RecordCount = 0) then
    begin
      MsgBox('E necessário cadastrar alguns produtos para utilizar o sistema', vbOkOnly + vbInformation);
      Exit;
    end;
  end;

  Result := True;
  
end;

procedure TWzdPortugueseBR.edtTaxValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if Key = '.' then
    Key := #0;

  Key := ValidatePositiveCurrency(Key);
  
end;

procedure TWzdPortugueseBR.edtNumberPostDateKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TWzdPortugueseBR.OnMovePriorPage;
begin
  inherited;
  btnNext.Caption := 'Próximo >>';
end;

procedure TWzdPortugueseBR.Finish;
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;
    FillParams;
    FillStore;
    FillTaxes;
    if DMExport.CreateMainRetailData then
      Close;
  finally
    Screen.Cursor := crDefault;
    end;
end;

procedure TWzdPortugueseBR.GridClick(Sender: TObject);
begin
  inherited;
  with TFrmSizeColorGrid.Create(Self) do
    Start(DMExport.cdsModel.FieldByName('Model').AsString);

  
end;

procedure TWzdPortugueseBR.gridModelListDBTableViewQtyCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.GridRecord.Values[gridModelListDBTableViewSizeAndColor.Index] = True then
    ACanvas.Font.Color := clBlue
  else
    ACanvas.Font.Color := clBlack;
end;

procedure TWzdPortugueseBR.gridModelListDBTableViewCellClick(
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

procedure TWzdPortugueseBR.gridModelListDBTableViewEditing(
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

procedure TWzdPortugueseBR.gridCategoryListDBTableViewGradePropertiesChange(
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

procedure TWzdPortugueseBR.lbMRWebClick(Sender: TObject);
begin
  inherited;
  OpenURL(lbMRWeb.Caption);
end;

procedure TWzdPortugueseBR.FormShow(Sender: TObject);
begin
  inherited;
  pgIntro.ActivePage := tsBenificios;
end;

procedure TWzdPortugueseBR.btnAddUserClick(Sender: TObject);
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

function TWzdPortugueseBR.ValidadeUser: Boolean;
begin

  Result := False;

  if Trim(edtUserName.Text) = '' then
  begin
    MsgBox('Usuario não pode ficar em branco', vbOkOnly + vbInformation);
    edtUserName.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsUser, 'UserName', Trim(edtUserName.Text)) then
  begin
    MsgBox('Usuario já cadastrado', vbOkOnly + vbInformation);
    edtUserName.SetFocus;
    Exit;
  end;

  if Trim(edtSenha.Text) = '' then
  begin
    MsgBox('Senha não pode ficar em branco', vbOkOnly + vbInformation);
    edtSenha.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsUser, 'Password', Trim(edtSenha.Text)) then
  begin
    MsgBox('Senha já cadastrado', vbOkOnly + vbInformation);
    edtSenha.SetFocus;
    Exit;
  end;

  Result := True;
  
end;

procedure TWzdPortugueseBR.cxGridDBTableViewUsuariosPasswordPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if DisplayValue = '' then
  begin
    ErrorText := 'Senha não pode ficar em branco';
    Error := True;
  end else if DMExport.FieldExist(DMExport.cdsUser, 'Password', DisplayValue) then
  begin
    ErrorText := 'Senha já cadastrado';
    Error := True;
  end;

end;

procedure TWzdPortugueseBR.cxGridDBTableViewUsuariosUserNamePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if DisplayValue = '' then
  begin
    ErrorText := 'Usuário não pode ficar em branco';
    Error := True;
  end else if DMExport.FieldExist(DMExport.cdsUser, 'UserName', DisplayValue) then
  begin
    ErrorText := 'Usuário já cadastrado';
    Error := True;
  end;

end;

procedure TWzdPortugueseBR.btnAddCategoryClick(Sender: TObject);
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

function TWzdPortugueseBR.ValidadeCategory: Boolean;
begin

  Result := False;

  if Trim(edtCategory.Text) = '' then
  begin
    MsgBox('Categoria não pode ficar em branco', vbOkOnly + vbInformation);
    edtCategory.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsCategory, 'Category', Trim(edtCategory.Text)) then
  begin
    MsgBox('Categoria já cadastrada', vbOkOnly + vbInformation);
    edtCategory.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TWzdPortugueseBR.gridCategoryListDBTableViewCategoryPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if DisplayValue = '' then
  begin
    ErrorText := 'Categoria não pode ficar em branco';
    Error := True;
  end else if DMExport.FieldExist(DMExport.cdsCategory, 'Category', DisplayValue) then
  begin
    ErrorText := 'Categoria já cadastrada';
    Error := True;
  end;

end;

procedure TWzdPortugueseBR.btnAddModelClick(Sender: TObject);
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

function TWzdPortugueseBR.ValidadeModel: Boolean;
begin
  Result := False;

  if (cbxCategory.Text = '') then
  begin
    MsgBox('Categoria não pode ficar em branco', vbOkOnly + vbInformation);
    cbxCategory.SetFocus;
    Exit;
  end;

  if Trim(edtCodBarras.Text) = '' then
  begin
    MsgBox('Código de Barras não pode ficar em branco', vbOkOnly + vbInformation);
    edtCodBarras.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsModel, 'Barcode', Trim(edtCodBarras.Text)) then
  begin
    MsgBox('Código de Barras já cadastrado', vbOkOnly + vbInformation);
    edtCodBarras.SetFocus;
    Exit;
  end;

  if Trim(edtModelo.Text) = '' then
  begin
    MsgBox('Modelo não pode ficar em branco', vbOkOnly + vbInformation);
    edtModelo.SetFocus;
    Exit;
  end else if DMExport.FieldExist(DMExport.cdsModel, 'Model', Trim(edtModelo.Text)) then
  begin
    MsgBox('Modelo já cadastrado', vbOkOnly + vbInformation);
    edtModelo.SetFocus;
    Exit;
  end;

  if Trim(edtDescricao.Text) = '' then
  begin
    MsgBox('Descicao não pode ficar em branco', vbOkOnly + vbInformation);
    edtDescricao.SetFocus;
    Exit;
  end;

  if Trim(edtCostPrice.Text) = '' then
  begin
    MsgBox('Preco de Custo não pode ficar em branco', vbOkOnly + vbInformation);
    edtCostPrice.SetFocus;
    Exit;
  end else if StrToFloatDef(edtCostPrice.Text, 0) <= 0 then
  begin
    MsgBox('Preco de Custo não pode menor ou igual a 0', vbOkOnly + vbInformation);
    edtCostPrice.SetFocus;
    Exit;
  end;

  if Trim(edtSalePrice.Text) = '' then
  begin
    MsgBox('Preco de Venda não pode ficar em branco', vbOkOnly + vbInformation);
    edtSalePrice.SetFocus;
    Exit;
  end else if StrToFloatDef(edtSalePrice.Text, 0) <= 0 then
  begin
    MsgBox('Preco de Venda não pode menor ou igual a 0', vbOkOnly + vbInformation);
    edtSalePrice.SetFocus;
    Exit;
  end;

  if Trim(edtQty.Text) = '' then
  begin
    MsgBox('Quantidade não pode ficar em branco', vbOkOnly + vbInformation);
    edtQty.SetFocus;
    Exit;
  end else if StrToFloatDef(edtQty.Text, 0) <= 0 then
  begin
    MsgBox('Quantidade não pode menor ou igual a 0', vbOkOnly + vbInformation);
    edtQty.SetFocus;
    Exit;
  end;



  Result := True;
  
end;

procedure TWzdPortugueseBR.BuildCategories;
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

procedure TWzdPortugueseBR.gridModelListDBTableViewBarcodePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if DisplayValue <> '' then
    if DMExport.FieldExist(DMExport.cdsModel, 'Barcode', DisplayValue) then
    begin
      ErrorText := 'Código de Barras já cadastrado';
      Error := True;
    end;

end;

procedure TWzdPortugueseBR.gridModelListDBTableViewModelPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if (DisplayValue = '') then
  begin
    ErrorText := 'Modelo não pode ficar em branco';
    Error := True;
  end else if DMExport.FieldExist(DMExport.cdsModel, 'Model', DisplayValue) then
  begin
    ErrorText := 'Modelo já cadastrado';
    Error := True;
  end;

end;

procedure TWzdPortugueseBR.gridModelListDBTableViewDescriptionPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if (DisplayValue = '') then
  begin
    ErrorText := 'Descricao não pode ficar em branco';
    Error := True;
  end;

end;

procedure TWzdPortugueseBR.gridModelListDBTableViewCostPricePropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;

  if (DisplayValue = '') then
  begin
    ErrorText := 'Preco de Custo não pode ficar em branco';
    Error := True;
  end;

end;

procedure TWzdPortugueseBR.edtCostPriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TWzdPortugueseBR.edtSalePriceKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TWzdPortugueseBR.edtQtyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  Key := ValidatePositiveCurrency(Key);
end;

procedure TWzdPortugueseBR.edtCostPriceExit(Sender: TObject);
begin
  inherited;
  if edtCostPrice.Text <> '' then
  begin
    edtSalePrice.Text := FormatCurr('##0.00', MyStrToMoney(edtCostPrice.Text) * 2);
    edtCostPrice.Text := FormatCurr('##0.00', MyStrToMoney(edtCostPrice.Text));
  end;
end;

procedure TWzdPortugueseBR.btnAddFornecedorClick(Sender: TObject);
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

function TWzdPortugueseBR.ValidadeFornecedor: Boolean;
begin

  Result := False;

  if (edtFornecedor.Text = '') then
  begin
    MsgBox('Fornecedor não pode ficar em branco', vbOkOnly + vbInformation);
    edtFornecedor.SetFocus;
    Exit;
  end;

  Result := True;

end;

procedure TWzdPortugueseBR.gridModelListDBTableViewCategoryPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if (DisplayValue = '') then
  begin
    ErrorText := 'Categoria não pode ficar em branco';
    Error := True;
  end;
end;

procedure TWzdPortugueseBR.btnCloseClick(Sender: TObject);
begin

  if MsgBox('Deseja fechar o Assistente?', vbYesNo + vbQuestion) = mrYes then
    inherited;

end;

procedure TWzdPortugueseBR.edtTaxValueExit(Sender: TObject);
begin
  inherited;
  if TLabeledEdit(Sender).Text <> '' then
    try
      StrToFloat(TLabeledEdit(Sender).Text);
    except
      TLabeledEdit(Sender).Clear;
      TLabeledEdit(Sender).SetFocus;
      end;
end;

procedure TWzdPortugueseBR.cxGridDBForncedorVendorPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if (DisplayValue = '') then
  begin
    ErrorText := 'Fornecedor não pode ficar em branco';
    Error := True;
  end;
end;

end.
