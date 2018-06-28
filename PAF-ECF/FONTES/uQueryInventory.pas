unit uQueryInventory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, DBCtrls, StdCtrls, Mask, LblEffct, ExtCtrls, DBTables, DB,
  Buttons, ComCtrls, ADODB, SuperComboADO, siComp, siLangRT, SubListPanel,
  uPai, DBClient, Provider;

type
  TQueryInventory = class(TFrmPai)
    dsModel: TDataSource;
    quBarCode: TADOQuery;
    edBarcode: TEdit;
    Label6: TLabel;
    pnlModel: TPanel;
    Label1: TLabel;
    scModel: TSuperComboADO;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    pnlCostPrice: TPanel;
    lblCost: TLabel;
    btShowCost: TSpeedButton;
    EditCost: TDBEdit;
    Label5: TLabel;
    pglModel: TPageControl;
    tbsQty: TTabSheet;
    tbsBarCodes: TTabSheet;
    Panel4: TPanel;
    quShowBarcodes: TADOQuery;
    dsShowBarcodes: TDataSource;
    quShowBarcodesIDBarcode: TStringField;
    quShowBarcodesIDModel: TIntegerField;
    dxDBGrid1: TDBGrid;
    gridQty: TDBGrid;
    dsQty: TDataSource;
    quModel: TADODataSet;
    quModelPeso: TBCDField;
    quModelDescription: TStringField;
    quModelVendorCost: TBCDField;
    quModelOtherCost: TBCDField;
    quModelFreightCost: TBCDField;
    quModelLastCost: TBCDField;
    quModelReplacementCost: TBCDField;
    quModelStoreSellingPrice: TBCDField;
    quModelInventoryPrice: TBCDField;
    quModelInvSellingPrice: TCurrencyField;
    quModelTabGroup: TStringField;
    quModelAvgCost: TBCDField;
    btnOK: TButton;
    quModelIDModel: TIntegerField;
    quModelModel: TStringField;
    cmbModel: TDBLookupComboBox;
    lbDescrip: TLabel;
    DBEdit4: TDBEdit;
    tsImages: TTabSheet;
    pgImages: TPageControl;
    tsImage1: TTabSheet;
    img1: TImage;
    tsImage2: TTabSheet;
    img2: TImage;
    quModelLargeImage: TStringField;
    quModelLargeImage2: TStringField;
    gridCaratc: TDBGrid;
    gridCaractTec: TDBGrid;
    dsInvFeature: TDataSource;
    dsInvTechFeature: TDataSource;
    rbDescription: TRadioButton;
    rbModel: TRadioButton;
    lbPromo: TLabel;
    DBEdit5: TDBEdit;
    quModelPromotionPrice: TBCDField;
    quModelIndicadorProducao: TStringField;
    quModelIndicadorAT: TStringField;
    quModelSituacaoTributaria: TIntegerField;
    quModelUnidade: TStringField;
    quModelSigla: TStringField;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    lbIndArr: TLabel;
    DBEdit7: TDBEdit;
    lnIndPro: TLabel;
    DBEdit8: TDBEdit;
    quModelDescSituTribut: TStringField;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure scModelSelectItem(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edBarcodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btShowCostClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure quModelCalcFields(DataSet: TDataSet);
    procedure cmbModelCloseUp(Sender: TObject);
    procedure edBarcodeEnter(Sender: TObject);
    procedure edBarcodeExit(Sender: TObject);
    procedure cmbModelDropDown(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure rbDescriptionClick(Sender: TObject);
    procedure rbModelClick(Sender: TObject);
    procedure cmbModelKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FModel : String;
    FFilterQty : String;
    procedure RefreshTXTInfo;
    procedure RefreshModel(IDModel:Integer);
    procedure SelectBarcode;
    procedure LoadImage(ImagePath:String; myImage: TImage);
    procedure QtyOption;
  public
    IsDetail : Boolean;
    function Start(var Model:String):Boolean;
  end;

implementation

uses uPassword, uMsgBox, uDM, uMsgConstant, uDMGlobal, uDMPDV, Variants;

{$R *.DFM}

procedure TQueryInventory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  quModel.Close;
  quShowBarcodes.Close;
  DMPDV.CloseQuantity;

  with DMPDV.cdsBarcodeSearch do
  begin
    Filtered := False;
    Filter   := '';
  end;

  with DMPDV.cdsModel do
  begin
    Filtered := False;
    Filter   := '';
  end;

  with DMPDV.cdsQty do
  begin
    Filtered := False;
    Filter   := '';
  end;

  Action := caFree;
end;

procedure TQueryInventory.FormShow(Sender: TObject);
begin
  inherited;

  QtyOption;

  btShowCostClick(nil);

  pnlCostPrice.Visible := Password.HasFuncRight(2);

  edBarcode.SetFocus;

end;

procedure TQueryInventory.scModelSelectItem(Sender: TObject);
begin
  inherited;
  if scModel.LookUpValue <> '' then
     RefreshModel(StrToInt(scModel.LookUpValue));
end;

procedure TQueryInventory.btDetailClick(Sender: TObject);
begin
  inherited;
  scModel.CallUpdate;
end;

procedure TQueryInventory.FormCreate(Sender: TObject);
begin
  inherited;
  IsDetail := False;
end;

procedure TQueryInventory.SelectBarCode;
var
  bAchou: Boolean;
  AIDModel: Integer;
begin
  if edBarcode.Text <> '' then
  begin
    case DM.PersistenceType of
      ptDB:
        with quBarcode do
          begin
            if quBarcode.Active then
              quBarcode.Close;
            quBarcode.Parameters.ParambyName('IDBarcode').Value := edBarcode.Text;
            quBarcode.Open;
            edBarcode.Clear;
            if quBarcode.RecordCount > 0 then
              begin
                //Verifica se o Model esta deletado e Restaura
                AIDModel := quBarcode.FieldByName('IDModel').AsInteger;
                bAchou := True;
                DM.ModelRestored(AIDModel);
              end
            else
              bAchou := False;
            Close;
          end;
      ptTXT:
      begin
        try
          DMPDV.cdsBarcodeSearch.Filtered := False;
          DMPDV.cdsBarcodeSearch.Filter   := Format('IDBarcode = %S', [QuotedStr(edBarcode.Text)]);
          DMPDV.cdsBarcodeSearch.Filtered := True;
          bAchou := not DMPDV.cdsBarcodeSearch.IsEmpty;
          if bAchou then
            AIDModel := DMPDV.cdsBarcodeSearch.FieldByName('IDModel').AsInteger;
        finally
          DMPDV.cdsBarcodeSearch.Filtered := True;
          DMPDV.cdsBarcodeSearch.Filter := '';
          DMPDV.cdsBarcodeSearch.Filtered := False;
        end;

      end;
    end;

    edBarcode.Clear;

    if bAchou then
      begin
        case DM.PersistenceType of
          ptDB:
            scModel.LookUpValue := IntToStr(AIDModel);
          ptTXT:
            cmbModel.KeyValue   := AIDModel;
        end;
        //scModelSelectItem(nil);
        RefreshModel(AIDModel);
      end
    else
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);

  end;
end;


procedure TQueryInventory.edBarcodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  
  if (key = 13) then
    SelectBarCode;

end;

procedure TQueryInventory.btShowCostClick(Sender: TObject);
begin
  inherited;

  editCost.Visible := btShowCost.Down;
  lblCost.Visible := btShowCost.Down;

end;

procedure TQueryInventory.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(260);
end;

procedure TQueryInventory.quModelCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quModelStoreSellingPrice.AsCurrency <> 0 then
     quModelInvSellingPrice.AsCurrency := quModelStoreSellingPrice.AsCurrency
  else
     quModelInvSellingPrice.AsCurrency := quModelInventoryPrice.AsCurrency;


  case quModelSituacaoTributaria.AsInteger of
    0,1 : quModelDescSituTribut.AsString := 'Tributável';
    2 : quModelDescSituTribut.AsString := 'Não Tributável';
    3 : quModelDescSituTribut.AsString := 'Substit. Tributária';
    4 : quModelDescSituTribut.AsString := 'Isento';
    5 : quModelDescSituTribut.AsString := 'ISS';
  end;

end;

procedure TQueryInventory.RefreshModel(IDModel:Integer);
begin

  if IDModel <> 0 then
   begin
     if DM.PersistenceType = ptDB then
        begin
        with quModel do
         begin
           if Active then Close;
           Parameters.ParambyName('IDModel').Value := IDModel;
           Parameters.ParambyName('IDStore').Value := DM.fStore.ID;
           Open;
           LoadImage(quModelLargeImage.AsString,img1);
           LoadImage(quModelLargeImage2.AsString,img2);
         end;

        with quShowBarcodes do
           begin
           If Active then Close;
           Parameters.ParambyName('IDModel').Value := IDModel;
           Open;
           end;

        with DMPDV.cdsInvFeatures do
          begin
          if Active then
             Close;
          Params.ParamByName('IDModel').Value := IDModel;
          Open;
          end;

        with DMPDV.cdsInvTechFeat do
          begin
          if Active then
             Close;
          Params.ParamByName('IDModel').Value := IDModel;
          Open;
          end;
        end;

     if DM.PersistenceType = ptTXT then
        begin
        with DMPDV.cdsBarcodeSearch do
          begin
          Filtered := False;
          Filter   := Format('IDModel = %D', [IDModel]);
          Filtered := True;
          end;

        with DMPDV.cdsModel do
          begin
          Filtered := False;
          Filter   := Format('IDModel = %D', [IDModel]);
          Filtered := True;
          LoadImage(DMPDV.cdsModel.FieldByName('LargeImage').AsString,img1);
          LoadImage(DMPDV.cdsModel.FieldByName('LargeImage2').AsString,img2);
          end;

        with DMPDV.cdsInvFeatures do
          begin
          if not Active then
             DM.PrepareCDS(DMPDV.cdsInvFeatures, 'InvFeatures', 'IDInvFeatures', True);
          Filtered := False;
          Filter   := Format('IDModel = %D', [IDModel]);
          Filtered := True;
          end;

        with DMPDV.cdsInvTechFeat do
          begin
          if not Active then
             DM.PrepareCDS(DMPDV.cdsInvTechFeat, 'InvTechFeatures', 'IDInvTechFeatures', True);
          Filtered := False;
          Filter   := Format('IDModel = %D', [IDModel]);
          Filtered := True;
          end;
        end;

     DMPDV.CloseQuantity;
     DMPDV.OpenQuantity(IDModel, FFilterQty);

   end;

end;

function TQueryInventory.Start(var Model: String): Boolean;
begin

  FModel := '';

  if DM.PersistenceType = ptTXT then
     begin
     dsModel.DataSet        := DMPDV.cdsMDescription;
     dsShowBarcodes.DataSet := DMPDV.cdsBarcodeSearch;
     cmbModel.Visible       := True;
     scModel.Visible        := False;
     rbDescription.Visible  := True;
     rbModel.Visible        := True;
     end
  else
     begin
     dsModel.DataSet        := quModel;
     dsShowBarcodes.DataSet := quShowBarcodes;
     scModel.Visible        := True;
     cmbModel.Visible       := False;
     rbDescription.Visible  := False;
     rbModel.Visible        := False;
     end;

  ShowModal;

  Model := FModel;

  Result := ((ModalResult = mrOK) and (Model <> ''));

end;

procedure TQueryInventory.cmbModelCloseUp(Sender: TObject);
begin
  inherited;
  btnOK.Default := True;
  RefreshTXTInfo;
end;

procedure TQueryInventory.RefreshTXTInfo;
begin
  if DM.PersistenceType = ptTXT then
     if VarToStr(cmbModel.KeyValue) <> '' then
        RefreshModel(StrToInt(cmbModel.KeyValue));
end;

procedure TQueryInventory.edBarcodeEnter(Sender: TObject);
begin
  inherited;
  btnOK.Default := False;
end;

procedure TQueryInventory.edBarcodeExit(Sender: TObject);
begin
  inherited;
  btnOK.Default := True;
end;

procedure TQueryInventory.cmbModelDropDown(Sender: TObject);
begin
  inherited;
  btnOK.Default := False;
end;

procedure TQueryInventory.LoadImage(ImagePath:String; myImage: TImage);
begin

 myImage.Picture := nil; 

 if (ImagePath <> '') and (FileExists(ImagePath)) then
    myImage.Picture.LoadFromFile(ImagePath);

end;

procedure TQueryInventory.btnOKClick(Sender: TObject);
begin
  inherited;

  if DM.PersistenceType = ptTXT then
  begin
    if cmbModel.KeyValue <> Null then
      with DMPDV.cdsModel do
      begin
        Filtered := False;
        Filter   := 'IDModel = ' + IntToStr(cmbModel.KeyValue);
        Filtered := True;
        FModel := DMPDV.cdsModel.FieldByName('Model').AsString;
      end;
  end
  else
     FModel := scModel.Text;

end;

procedure TQueryInventory.rbDescriptionClick(Sender: TObject);
begin
  inherited;
  if DM.PersistenceType = ptTXT then
    cmbModel.ListField := 'Description; Model';
end;

procedure TQueryInventory.rbModelClick(Sender: TObject);
begin
  inherited;
  if DM.PersistenceType = ptTXT then
    cmbModel.ListField := 'Model; Description';
end;

procedure TQueryInventory.QtyOption;
begin

  if DM.fCashRegister.HideOtherStoreQry then
    FFilterQty := 'StoreID IN (' + DM.fStore.StoreList + ')'
  else
    FFilterQty := '';

  gridQty.Columns[1].Visible := Password.HasFuncRight(45);
  gridQty.Columns[2].Visible := Password.HasFuncRight(47);

end;

procedure TQueryInventory.cmbModelKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  RefreshTXTInfo;
end;

end.
