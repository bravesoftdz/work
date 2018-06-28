unit uFrmStorePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  DBClient, ADODB, Provider, Buttons, PanelRights, uFrmDescriptionPrice;

type
  TFrmStorePrice = class(TFrmParent)
    Panel4: TPanel;
    pnlButton: TPanelRights;
    btRemove: TSpeedButton;
    btAdd: TSpeedButton;
    dsStorePrice: TDataSource;
    dspStorePrice: TDataSetProvider;
    qryStorePrice: TADOQuery;
    qryStorePriceIDModel: TIntegerField;
    qryStorePriceIDDescriptionPrice: TIntegerField;
    qryStorePriceIDVendor: TIntegerField;
    qryStorePriceCostPrice: TBCDField;
    qryStorePriceSuggPrice: TBCDField;
    qryStorePriceSalePrice: TBCDField;
    cdsStorePrice: TClientDataSet;
    cdsStorePriceIDModel: TIntegerField;
    cdsStorePriceIDDescriptionPrice: TIntegerField;
    cdsStorePriceIDVendor: TIntegerField;
    cdsStorePriceCostPrice: TBCDField;
    cdsStorePriceSuggPrice: TBCDField;
    cdsStorePriceSalePrice: TBCDField;
    qryLUVendor: TADOQuery;
    qryLUVendorIDVendor: TIntegerField;
    qryLUVendorVendor: TStringField;
    dsLUVendor: TDataSource;
    dsLUDescriptionPrice: TDataSource;
    qryLUDescriptionPrice: TADOQuery;
    qryLUDescriptionPriceIDDescriptionPrice: TIntegerField;
    qryLUDescriptionPriceDescriptionPrice: TStringField;
    grdStorePrice: TcxGrid;
    grdStorePriceDBTableView: TcxGridDBTableView;
    grdStorePriceDBTableViewIDVendor: TcxGridDBColumn;
    grdStorePriceDBTableViewIDDescriptionPrice: TcxGridDBColumn;
    grdStorePriceDBTableViewCostPrice: TcxGridDBColumn;
    grdStorePriceDBTableViewSuggPrice: TcxGridDBColumn;
    grdStorePriceDBTableViewSalePrice: TcxGridDBColumn;
    grdStorePriceLevel: TcxGridLevel;
    btSave: TButton;
    qryStorePriceIDStore: TIntegerField;
    cdsStorePriceIDStore: TIntegerField;
    Panel5: TPanel;
    btDescription: TSpeedButton;
    btAddAllDesc: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure cdsStorePriceNewRecord(DataSet: TDataSet);
    procedure btDescriptionClick(Sender: TObject);
    procedure cdsStorePriceBeforePost(DataSet: TDataSet);
    procedure btAddAllDescClick(Sender: TObject);
  private
    FFrmDescriptionPrice: TFrmDescriptionPrice;
    FIDStore: Integer;
    FIDModel: Integer;

    procedure CloseLookUpDS;
    procedure OpenLookUpDS;
    procedure OpenStorePriceDS;
  public
    function Start(AIDStore, AIDModel: Integer; AParams: String = ''): Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

{ TFrmStorePrice }

procedure TFrmStorePrice.CloseLookUpDS;
begin
  qryLUDescriptionPrice.Close;
  qryLUVendor.Close;
end;

procedure TFrmStorePrice.OpenLookUpDS;
begin
  qryLUDescriptionPrice.Open;
  qryLUVendor.Open;
end;

procedure TFrmStorePrice.OpenStorePriceDS;
begin
  with cdsStorePrice do
  begin
    if Active then
      Close;

    FetchParams;
    Params.ParamByName('IDStore').Value := FIDStore;
    Params.ParamByName('IDModel').Value := FIDModel;
    Open;
  end;
end;

function TFrmStorePrice.Start(AIDStore, AIDModel: Integer;
  AParams: String): Boolean;
begin
  FIDStore := AIDStore;
  FIDModel := AIDModel;
  OpenStorePriceDS;

  ShowModal;
  Result := ModalResult = mrOk;
end;

procedure TFrmStorePrice.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemove.Glyph);
  DM.imgSmall.GetBitmap(BTM18_BACKUP, btDescription.Glyph);
  DM.imgBTN.GetBitmap(BTN_ADDALL, btAddAllDesc.Glyph);
  
  OpenLookUpDS;
end;

procedure TFrmStorePrice.FormDestroy(Sender: TObject);
begin
  inherited;
  CloseLookUpDS;

  if Assigned(FFrmDescriptionPrice) then
    FreeAndNil(FFrmDescriptionPrice);
end;

procedure TFrmStorePrice.btSaveClick(Sender: TObject);
begin
  inherited;
  if cdsStorePrice.ApplyUpdates(-1) > 0 then
  begin
    MsgBox(MSG_INF_NOT_DESCRIPTION_EMPTY, vbCritical + vbOKOnly);
    ModalResult := mrNone;
  end;
end;

procedure TFrmStorePrice.btAddClick(Sender: TObject);
begin
  inherited;
  cdsStorePrice.Append;
end;

procedure TFrmStorePrice.btRemoveClick(Sender: TObject);
begin
  inherited;
  cdsStorePrice.Delete;
end;

procedure TFrmStorePrice.cdsStorePriceNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsStorePriceIDStore.AsInteger := FIDStore;
  cdsStorePriceIDModel.AsInteger := FIDModel;
end;

procedure TFrmStorePrice.btDescriptionClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FFrmDescriptionPrice) then
    FFrmDescriptionPrice := TFrmDescriptionPrice.Create(Self);

  if FFrmDescriptionPrice.Start then
  begin
    CloseLookUpDS;
    OpenLookUpDS;
  end;
end;

procedure TFrmStorePrice.cdsStorePriceBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('IDDescriptionPrice').IsNull then
    MsgBox(MSG_INF_NOT_DESCRIPTION_EMPTY, vbInformation + vbOKOnly)
  else
    inherited;
end;

procedure TFrmStorePrice.btAddAllDescClick(Sender: TObject);
var
  sIDDescs: String;
begin
  inherited;
  with cdsStorePrice do
  try
    Screen.Cursor := crHourGlass;
    DisableControls;
    First;
    sIDDescs := '';

    while not Eof do
    begin
      if sIDDescs <> '' then
        sIDDescs := sIDDescs + ',';
      sIDDescs := sIDDescs + FieldByName('IDDescriptionPrice').AsString;
      Next;
    end;
  finally
    First;
    EnableControls;
    Screen.Cursor := crDefault;
  end;

  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Clear;
    SQL.Add('SELECT IDDescriptionPrice');
    SQL.Add('FROM Inv_DescriptionPrice (NOLOCK)');
    if sIDDescs <> '' then
      SQL.Add('WHERE IDDescriptionPrice NOT IN (' + sIDDescs + ')');
    Open;

    while not Eof do
    begin
      cdsStorePrice.Append;
      cdsStorePrice.FieldByName('IDStore').AsInteger := FIDStore;
      cdsStorePrice.FieldByName('IDModel').AsInteger := FIDModel;
      cdsStorePrice.FieldByName('IDDescriptionPrice').AsInteger := FieldByName('IDDescriptionPrice').AsInteger;
      cdsStorePrice.FieldByName('CostPrice').AsFloat := 0;
      cdsStorePrice.FieldByName('SuggPrice').AsFloat := 0;
      cdsStorePrice.FieldByName('SalePrice').AsFloat := 0;
      cdsStorePrice.Post;
      Next;
    end;
  finally
    Close;
  end;
end;

end.
