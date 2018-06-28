unit uQueryInventory;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, Grids, DBGrids, DBCtrls, StdCtrls, Mask,
  LblEffct, ExtCtrls, DBTables, DB, Buttons, ComCtrls, ADODB, SuperComboADO, siComp,
  siLangRT, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  SubListPanel, mrBarCodeEdit, uFrmBarcodeSearch;

type
  TQueryInventory = class(TFrmParent)
    dsModel: TDataSource;
    btDetail: TButton;
    Label6: TLabel;
    spHelp: TSpeedButton;
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
    quShowBarcodesData: TDateTimeField;
    dxDBGrid1: TDBGrid;
    SubQty: TSubListPanel;
    tsPO: TTabSheet;
    SubPO: TSubListPanel;
    btnPicture: TSpeedButton;
    quModel: TADODataSet;
    quModelName: TStringField;
    quModelPeso: TBCDField;
    quModelDescription: TStringField;
    quModelCurrentCost: TBCDField;
    quModelVendorCost: TBCDField;
    quModelOtherCost: TBCDField;
    quModelFreightCost: TBCDField;
    quModelLastCost: TBCDField;
    quModelReplacementCost: TBCDField;
    quModelStoreSellingPrice: TBCDField;
    quModelInventoryPrice: TBCDField;
    quModelSellingPrice: TCurrencyField;
    edtBarcode: TmrBarCodeEdit;
    btnSearchDesc: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure scModelSelectItem(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btShowCostClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnPictureClick(Sender: TObject);
    procedure quModelCalcFields(DataSet: TDataSet);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure btnSearchDescClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fFrmBarcodeSearch : TFrmBarcodeSearch;
  public
    { Public declarations }
    IsDetail : Boolean;
  end;

implementation

uses uPassword, uMsgBox, uDM, uMsgConstant, uDMGlobal, uFrmModelPicture,
     uSystemConst;

{$R *.DFM}

procedure TQueryInventory.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  quModel.Close;
  quShowBarcodes.Close; 
  Action := caFree;
end;

procedure TQueryInventory.FormShow(Sender: TObject);
begin
  inherited;

  btDetail.Visible := IsDetail;

  btShowCostClick(nil);

  pnlCostPrice.Visible := Password.HasFuncRight(2);

  //scModel.SetFocus;
  edtBarcode.SetFocus;

end;

procedure TQueryInventory.scModelSelectItem(Sender: TObject);
begin
  inherited;

  if scModel.LookUpValue <> '' then
   begin

     if not(DM.ModelRestored(StrToInt(scModel.LookUpValue))) then
      begin
        edtBarcode.Text := '';
        scModel.LookUpValue := '';
        exit;
      end;

     with quModel do
      begin
        if Active then Close;
        Parameters.ParambyName('IDModel').Value := StrToInt(scModel.LookUpValue);
        Parameters.ParambyName('IDStore').Value := DM.fStore.ID;
        Open;
      end;

     SubQty.Param := 'IDModel='+scModel.LookUpValue+';';

     SubPO.Param := 'IDModel='+scModel.LookUpValue+';ViewType=1;';

     with quShowBarcodes do
        begin
        If Active then Close;
        Parameters.ParambyName('IDModel').Value := StrToInt(scModel.LookUpValue);
        Open;
        end;
   end;

end;

procedure TQueryInventory.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
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
  SubQty.CreateSubList;
  SubPO.CreateSubList;

  DM.imgSmall.GetBitmap(BTN18_CAMERA, btnPicture.Glyph);
  DM.imgSmall.GetBitmap(BTN18_LAMP, btShowCost.Glyph);
  DM.imgSmall.GetBitmap(BTN18_SEARCH, btnSearchDesc.Glyph);

  edtBarcode.CheckBarcodeDigit := DM.fSystem.SrvParam[PARAM_REMOVE_BARCODE_DIGIT];
  edtBarcode.MinimalDigits     := DM.fSystem.SrvParam[PARAM_MIN_BARCODE_LENGTH];
  edtBarcode.RunSecondSQL      := DM.fSystem.SrvParam[PARAM_SEARCH_MODEL_AFTER_BARCODE];

  fFrmBarcodeSearch := TFrmBarcodeSearch.Create(Self);
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
  Application.HelpContext(1190);
end;

procedure TQueryInventory.btnPictureClick(Sender: TObject);
begin
  inherited;

  if scModel.LookUpValue <> '' then
     with TFrmModelPicture.Create(Self) do
          Start(scModel.LookUpValue);

end;

procedure TQueryInventory.quModelCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quModelStoreSellingPrice.AsCurrency <> 0 then
     quModelSellingPrice.AsCurrency := quModelStoreSellingPrice.AsCurrency
  else
     quModelSellingPrice.AsCurrency := quModelInventoryPrice.AsCurrency;
end;

procedure TQueryInventory.edtBarcodeAfterSearchBarcode(Sender: TObject);
var
  IDModel : Integer;
begin
  inherited;

  with edtBarcode do
  begin
    if SearchResult then
    begin
      IDModel := GetFieldValue('IDModel');
      scModel.LookUpValue := IntToStr(IDModel);
      scModelSelectItem(nil);
    end
    else
      MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOkOnly);
  end;

  edtBarcode.Clear;

end;

procedure TQueryInventory.btnSearchDescClick(Sender: TObject);
var
  R: integer;
begin
  inherited;

  with fFrmBarcodeSearch do
    begin
      R := Start;
      if R <> -1 then
        begin
          scModel.LookUpValue := IntToStr(R);
          scModelSelectItem(nil);
        end;
    end;

end;

procedure TQueryInventory.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(fFrmBarcodeSearch);
end;

end.
