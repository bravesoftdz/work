unit uFrmExportScaleItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, Provider, ADODB, PowerADOQuery;

type
  TFrmExportScaleItem = class(TFrmParentAll)
    Panel2: TPanel;
    pnlError: TPanel;
    Panel5: TPanel;
    btMarked: TSpeedButton;
    btUnMarked: TSpeedButton;
    btPOColumn: TSpeedButton;
    Panel9: TPanel;
    Panel6: TPanel;
    grdScaleItem: TcxGrid;
    grdScaleItemDB: TcxGridDBTableView;
    grdScaleItemLevel1: TcxGridLevel;
    quScaleItem: TPowerADOQuery;
    dspScaleItem: TDataSetProvider;
    cdsScaleItem: TClientDataSet;
    dsScaleItem: TDataSource;
    btExport: TButton;
    SaveDialog: TSaveDialog;
    quScaleItemMarked: TBooleanField;
    quScaleItemIDModel: TIntegerField;
    quScaleItemIDBarcode: TStringField;
    quScaleItemModel: TStringField;
    quScaleItemDescription: TStringField;
    quScaleItemModelPrice: TBCDField;
    quScaleItemStoreSellingPrice: TBCDField;
    quScaleItemQtyOnHand: TBCDField;
    quScaleItemManufacture: TStringField;
    quScaleItemCategory: TStringField;
    quScaleItemVendor: TStringField;
    quScaleItemIDVendor: TIntegerField;
    cdsScaleItemMarked: TBooleanField;
    cdsScaleItemIDModel: TIntegerField;
    cdsScaleItemIDBarcode: TStringField;
    cdsScaleItemIDVendor: TIntegerField;
    cdsScaleItemModel: TStringField;
    cdsScaleItemDescription: TStringField;
    cdsScaleItemModelPrice: TBCDField;
    cdsScaleItemStoreSellingPrice: TBCDField;
    cdsScaleItemQtyOnHand: TBCDField;
    cdsScaleItemManufacture: TStringField;
    cdsScaleItemCategory: TStringField;
    cdsScaleItemVendor: TStringField;
    grdScaleItemDBMarked: TcxGridDBColumn;
    grdScaleItemDBIDBarcode: TcxGridDBColumn;
    grdScaleItemDBModel: TcxGridDBColumn;
    grdScaleItemDBDescription: TcxGridDBColumn;
    grdScaleItemDBModelPrice: TcxGridDBColumn;
    grdScaleItemDBQtyOnHand: TcxGridDBColumn;
    grdScaleItemDBCategory: TcxGridDBColumn;
    grdScaleItemDBManufacture: TcxGridDBColumn;
    grdScaleItemDBVendor: TcxGridDBColumn;
    Panel7: TPanel;
    cxgridError: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cdsBarcodeErro: TClientDataSet;
    dsBarcodeErro: TDataSource;
    btViewModel: TSpeedButton;
    cdsBarcodeErroIDBarcode: TStringField;
    cdsBarcodeErroIDModel: TIntegerField;
    cdsBarcodeErroDescription: TStringField;
    cdsBarcodeErroModel: TStringField;
    cdsBarcodeErroCategory: TStringField;
    cdsBarcodeErroMsgError: TStringField;
    cxGridDBTableView1IDBarcode: TcxGridDBColumn;
    cxGridDBTableView1Model: TcxGridDBColumn;
    cxGridDBTableView1Description: TcxGridDBColumn;
    cxGridDBTableView1Category: TcxGridDBColumn;
    cxGridDBTableView1MsgError: TcxGridDBColumn;
    quValidateBarcode: TADODataSet;
    quValidateBarcodeIDBarcode: TStringField;
    quValidateBarcodeIDModel: TIntegerField;
    quValidateBarcodeModel: TStringField;
    quValidateBarcodeDescription: TStringField;
    quValidateBarcodeCategory: TStringField;
    quScaleItemPromotionPrice: TBCDField;
    cdsScaleItemPromotionPrice: TBCDField;
    quScaleItemFinalPrice: TCurrencyField;
    cdsScaleItemFinalPrice: TCurrencyField;
    Panel4: TPanel;
    Label1: TLabel;
    rbModel: TRadioButton;
    rbDescription: TRadioButton;
    quScaleItemScaleValidDay: TIntegerField;
    cdsScaleItemScaleValidDay: TIntegerField;
    quScaleNutriItem: TADODataSet;
    quScaleItemPortion: TStringField;
    cdsScaleItemPortion: TStringField;
    quScaleNutriItemIDModel: TIntegerField;
    quScaleNutriItemIDBarcode: TStringField;
    quScaleNutriItemPortion: TStringField;
    quScaleNutriItemDescription: TStringField;
    quScaleNutriItemFieldLength: TIntegerField;
    quScaleNutriItemQtyPortion: TBCDField;
    quScaleNutriItemVDPortion: TBCDField;
    procedure btMarkedClick(Sender: TObject);
    procedure btUnMarkedClick(Sender: TObject);
    procedure btPOColumnClick(Sender: TObject);
    procedure btExportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure cdsScaleItemAfterOpen(DataSet: TDataSet);
    procedure btViewModelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure quScaleItemCalcFields(DataSet: TDataSet);
  private
    sGreater6,
    sLetter,
    sEmpty,
    sBarcode2_13  : String;

    procedure CheckAll(Value: Boolean);
    procedure ConfigColumns(AView: TcxCustomGridTableView);
    function  ItemTxt: String;
    function  ItemNutritionTxt(AIDModel : Integer): String;

    procedure OpenScaleItem;
    procedure CloseScaleItem;
    procedure RefreshScaleItem;

    function CreateScaleItemFile(sFileName : String) : Boolean;
    function VerifyBarcodeError : Boolean;
    function VerifyNumber       : Boolean;
  public
    function Start : Boolean;

  end;


implementation

uses MaskUtils, uStringFunctions, uSystemTypes, uFchModel, PaiDeBrowses,
  uWaitForm, uSqlFunctions, uDMGlobal, uDM;


{$R *.dfm}

procedure TFrmExportScaleItem.btMarkedClick(Sender: TObject);
begin
  inherited;
  CheckAll(True);
end;

procedure TFrmExportScaleItem.btUnMarkedClick(Sender: TObject);
begin
  inherited;
  CheckAll(False);
end;

procedure TFrmExportScaleItem.btPOColumnClick(Sender: TObject);
begin
  inherited;
  ConfigColumns(grdScaleItemDB);
end;

procedure TFrmExportScaleItem.CheckAll(Value: Boolean);
begin
  with cdsScaleItem do
  begin
    First;
    while not Eof DO
     begin
       Edit;
       FieldByName('Marked').Value := Value;
       Post;
       Next;
     end;
  end;
end;

procedure TFrmExportScaleItem.ConfigColumns(AView: TcxCustomGridTableView);
begin
  if not TcxGridDBTableView(AView).Controller.Customization then
    TcxGridDBTableView(AView).Controller.Customization := True
  else
    TcxGridDBTableView(AView).Controller.Customization := False;
end;

function  TFrmExportScaleItem.ItemNutritionTxt(AIDModel : Integer): String;
var
  sAux : String;
  i : Integer;
begin

  Result := '';

  with quScaleNutriItem do
  try
    if not Active then
      Parameters.ParamByName('IDModel').Value := AIDModel;
      Open;
      if not IsEmpty then
      begin
        //Codido = 6
        Result := FormatFloat('000000', StrToFloat(Copy(quScaleNutriItemIDBarcode.Value, 1, 6)));
        //Descricao = 35
        Result := Result + Copy(quScaleNutriItemPortion.AsString + StringReplace(SPC(35), ' ', '.', [rfReplaceAll]) , 1, 35);
        First;
        while not EOF do
        begin
          if quScaleNutriItemQtyPortion.AsInteger > 0 then
          begin
            sAux := '';
            for i := 1 to quScaleNutriItemFieldLength.AsInteger do
              sAux := sAux + '0';
            //Qty
            Result := Result + FormatFloat(sAux, quScaleNutriItemQtyPortion.AsFloat);
            //VD
            Result := Result + '0000';
          end
          else
          begin
            sAux := '';
            for i := 1 to quScaleNutriItemFieldLength.AsInteger do
              sAux := sAux + '*';
            //Qty
            Result := Result + sAux;
            //VD
            Result := Result + '****';
          end;

          Next;
        end;
      end;

  finally
    Close;
  end;

end;

function TFrmExportScaleItem.ItemTxt : String;
var
  sBarcode, sDepartamento, sTipoProduto, sDescricao, sValor, sText, sResult,
  sTemp, sValidade, sCodInfExtra, sCodImagem, sOpCabecalho, sCodImgCabecalho,
  sOpRodape, sCodImgRodape: string;
  iVar: integer;
begin
  sTemp := Copy(cdsScaleItemIDBarcode.Value, 1, 6);
  sBarcode := FormatFloat('000000', StrToFloat(sTemp));

  if rbModel.Checked then
  begin
    if (DM.fCashRegister.ScaleType = 0) then
      sText := Copy(cdsScaleItemModel.Value, 1, 22)
    else
      sText := Copy(cdsScaleItemModel.Value, 1, 25);
  end else if rbDescription.Checked then
  begin
    if (DM.fCashRegister.ScaleType = 0) then
      sText := Copy(cdsScaleItemDescription.Value, 1, 22)
    else
      sText := Copy(cdsScaleItemDescription.Value, 1, 25);
  end;

  if (DM.fCashRegister.ScaleType = 0) then
  begin
    iVar := 0;

    if Length(sText) < 22 then
      iVar := 22 - Length(sText);

    sDescricao := sText + SPC(iVar);
    sValor     := FormatFloat(StringOfChar('0', 7), cdsScaleItemFinalPrice.Value * 100);
    sValidade  := Copy(FormatFloat('000', cdsScaleItemScaleValidDay.AsInteger), 1, 3);

    sResult    := sBarcode + 'a' + sDescricao + sValor + sValidade;
  end
  else if (DM.fCashRegister.ScaleType = 1) then
  begin
    iVar := 0;

    if Length(sText) < 50 then
      iVar := 50 - Length(sText);

    sDepartamento    := '01';
    sTipoProduto     := '0';
    sValor           := FormatFloat(StringOfChar('0', 6), cdsScaleItemFinalPrice.Value * 100);
    sValidade        := Copy(FormatFloat('000', cdsScaleItemScaleValidDay.AsInteger), 1, 3);
    sDescricao       := sText + SPC(iVar);
    sCodInfExtra     := '000000';
    sCodImagem       := '000';
    sOpCabecalho     := '0';
    sCodImgCabecalho := '00';
    sOpRodape        := '0';
    sCodImgRodape    := '00';

    sResult    := sDepartamento + sTipoProduto + sBarcode + sValor + sValidade +
                  sDescricao + sCodInfExtra + sCodImagem + sOpCabecalho +
                  sCodImgCabecalho + sOpRodape + sCodImgRodape;
  end;

  Result := sResult;
end;

procedure TFrmExportScaleItem.btExportClick(Sender: TObject);
begin
  inherited;

  if not VerifyBarcodeError then
    if SaveDialog.Execute then
      CreateScaleItemFile(SaveDialog.FileName);

end;

procedure TFrmExportScaleItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  CloseScaleItem;
  Action := caFree;
end;

function TFrmExportScaleItem.Start: Boolean;
begin
  RefreshScaleItem;
  ShowModal;
  Result := True;
end;

procedure TFrmExportScaleItem.CloseScaleItem;
begin
  with cdsScaleItem do
    if Active then
      Close;
end;

procedure TFrmExportScaleItem.OpenScaleItem;
begin
  with cdsScaleItem do
  begin
    if not Active then
    begin
      Params.ParamByName('IDStore').Value := DM.fStore.ID;
      Open;
    end;
  end;
end;

procedure TFrmExportScaleItem.RefreshScaleItem;
begin
  CloseScaleItem;
  OpenScaleItem;
end;

procedure TFrmExportScaleItem.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmExportScaleItem.cdsScaleItemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btMarked.Enabled := not cdsScaleItem.IsEmpty;
  btUnMarked.Enabled := btMarked.Enabled;
  btExport.Enabled := btMarked.Enabled;
end;

function TFrmExportScaleItem.CreateScaleItemFile(
  sFileName: String): Boolean;
var
  sLine : String;
  FScaleItemList : TStringList;
  FScaleItemNutritionList : TStringList;
begin
  FScaleItemList := TStringList.Create;
  FScaleItemNutritionList := TStringList.Create;
  try
    cdsScaleItem.DisableControls;
    cdsScaleItem.First;
    while not cdsScaleItem.Eof do
    begin
      if cdsScaleItem.FieldByName('Marked').AsBoolean then
      begin
        FScaleItemList.Add(ItemTxt);

        sLine := ItemNutritionTxt(cdsScaleItem.FieldByName('IDModel').AsInteger);
        if sLine <> '' then
          FScaleItemNutritionList.Add(sLine);
      end;

      cdsScaleItem.Next;
    end;

    if FScaleItemList.Count > 0 then
      FScaleItemList.SaveToFile(sFileName);

    if FScaleItemNutritionList.Count > 0 then
      FScaleItemNutritionList.SaveToFile(ExtractFileDir(sFileName) + '\NUTRI.TXT');

  finally
    FreeAndNil(FScaleItemList);
    FreeAndNil(FScaleItemNutritionList);
    cdsScaleItem.EnableControls;
  end;
end;

procedure TFrmExportScaleItem.btViewModelClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;

  if cdsBarcodeErro.Active and (not cdsBarcodeErro.IsEmpty) then
  begin
    PosID1 := cdsBarcodeErroIDModel.AsString;
    PosID2 := '';

    with TFchModel.Create(Self) do
    try
      Start(btAlt, nil, False, PosID1, PosID2, nil);
      RefreshScaleItem;
      VerifyBarcodeError;
    finally
      Free;
    end;
  end;
end;

function TFrmExportScaleItem.VerifyBarcodeError : Boolean;
var
  sError : String;
begin

  if cdsBarcodeErro.Active then
    cdsBarcodeErro.Close;

  cdsBarcodeErro.CreateDataSet;

  try
    cdsScaleItem.DisableControls;
    cdsScaleItem.First;
    while not cdsScaleItem.Eof do
    begin
      sError := '';

      //Error > 6
      if Length(Trim(cdsScaleItemIDBarcode.AsString)) <> 6 then
        sError := sGreater6;

      //Error se nao for inteiro

      if (Trim(cdsScaleItemIDBarcode.AsString) <> '') and (not VerifyNumber) then
        sError := sError + sLetter;


      //Barcode 00000
      if (Trim(cdsScaleItemIDBarcode.AsString) = '000000') or (Trim(cdsScaleItemIDBarcode.AsString) = '') then
        sError := sError + sEmpty;

      if (sError <> '') then
      begin
        cdsBarcodeErro.Append;
        cdsBarcodeErro.FieldByName('IDModel').Value     := cdsScaleItemIDModel.Value;
        cdsBarcodeErro.FieldByName('IDBarcode').Value   := cdsScaleItemIDBarcode.Value;
        cdsBarcodeErro.FieldByName('Model').Value       := cdsScaleItemModel.Value;
        cdsBarcodeErro.FieldByName('Description').Value := cdsScaleItemDescription.Value;
        cdsBarcodeErro.FieldByName('Category').Value    := cdsScaleItemCategory.Value;
        cdsBarcodeErro.FieldByName('MsgError').Value    := sError;
        cdsBarcodeErro.Post;
      end;

      cdsScaleItem.Next;
    end;

    //Verificar produdos sem balanca que comecam com 2 e tem 13 char
    with quValidateBarcode do
    begin
      if Active then
         Close;

        Open;
        First;
        while not Eof do
        begin
          cdsBarcodeErro.Append;
          cdsBarcodeErro.FieldByName('IDModel').Value     := quValidateBarcodeIDModel.Value;
          cdsBarcodeErro.FieldByName('IDBarcode').Value   := quValidateBarcodeIDBarcode.Value;
          cdsBarcodeErro.FieldByName('Model').Value       := quValidateBarcodeModel.Value;
          cdsBarcodeErro.FieldByName('Description').Value := quValidateBarcodeDescription.Value;
          cdsBarcodeErro.FieldByName('Category').Value    := quValidateBarcodeCategory.Value;
          cdsBarcodeErro.FieldByName('MsgError').Value    := sBarcode2_13;
          cdsBarcodeErro.Post;
          Next;
        end;
        Close;
    end;

  finally
    cdsScaleItem.EnableControls;
  end;

  Result := not cdsBarcodeErro.IsEmpty;
  pnlError.Visible := Result;

end;

procedure TFrmExportScaleItem.FormCreate(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sGreater6 := 'Barcode has to be same 6 characters.';
      sLetter   := 'There are letters in the barcode.';
      sEmpty    := 'Barcode is empty.';
      sBarcode2_13 := 'This barcode is not a product that use scale,' +
      'so it cannot begin with 2 and have 13 characters.';
    end;

    LANG_PORTUGUESE:
    begin
      sGreater6 := 'Código de barras tem que ser igual a 6 caracteres.';
      sLetter   := 'Existem letras no código de barras.';
      sEmpty    := 'Código de barras está vazio.';
      sBarcode2_13 := 'Este código de barras não é de um produto que usa balança, '+
      'portanto não pode começar com 2 e ter 13 caracteres.';
    end;

    LANG_SPANISH:
    begin
      sGreater6 := 'Código de barras tiene que ser el mismo a 6 carácteres.';
      sLetter   := 'Hay cartas en el código de barras.';
      sEmpty    := 'El código de barras es vacío.';
      sBarcode2_13 := 'Este código de barras no es un producto lo que usa la balanza,' +
       'entonces no puede comenzar con 2 y tener 13 carácteres.';
    end;
  end;

end;

function TFrmExportScaleItem.VerifyNumber : Boolean;
begin
  Result := true;
  try
    StrToInt(Trim(cdsScaleItemIDBarcode.AsString));
  except
    Result := false;
  end;
end;

procedure TFrmExportScaleItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    vk_Return:
      begin
        if btExport.Enabled then
          btExportClick(Sender);
        end;
    VK_ESCAPE:
      begin
        btCloseClick(Sender);
      end;
    VK_F1:
      begin
     //   sbHelpClick(Sender);
      end;
  end;      
end;

procedure TFrmExportScaleItem.quScaleItemCalcFields(DataSet: TDataSet);
begin
  inherited;

  if quScaleItemStoreSellingPrice.AsCurrency > 0 then
    quScaleItemFinalPrice.AsCurrency := quScaleItemStoreSellingPrice.AsCurrency
  else if quScaleItemPromotionPrice.AsCurrency > 0 then
    quScaleItemFinalPrice.AsCurrency := quScaleItemPromotionPrice.AsCurrency
  else
    quScaleItemFinalPrice.AsCurrency := quScaleItemModelPrice.AsCurrency;

end;

end.

