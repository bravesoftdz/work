unit uFrmModelPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, Buttons, PanelRights, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient, ADODB, Provider, uFrmDescriptionPrice;

type
  TFrmModelPrice = class(TFrmParent)
    grdModelPriceDBTableView: TcxGridDBTableView;
    grdModelPriceLevel: TcxGridLevel;
    grdModelPrice: TcxGrid;
    pnlButton: TPanelRights;
    btRemove: TSpeedButton;
    btSave: TButton;
    dsModelPrice: TDataSource;
    dspModelPrice: TDataSetProvider;
    qryModelPrice: TADOQuery;
    cdsModelPrice: TClientDataSet;
    qryModelPriceIDModel: TIntegerField;
    qryModelPriceIDDescriptionPrice: TIntegerField;
    qryModelPriceIDVendor: TIntegerField;
    qryModelPriceCostPrice: TBCDField;
    qryModelPriceSuggPrice: TBCDField;
    qryModelPriceSalePrice: TBCDField;
    cdsModelPriceIDModel: TIntegerField;
    cdsModelPriceIDDescriptionPrice: TIntegerField;
    cdsModelPriceIDVendor: TIntegerField;
    cdsModelPriceCostPrice: TBCDField;
    cdsModelPriceSuggPrice: TBCDField;
    cdsModelPriceSalePrice: TBCDField;
    grdModelPriceDBTableViewIDDescriptionPrice: TcxGridDBColumn;
    grdModelPriceDBTableViewIDVendor: TcxGridDBColumn;
    grdModelPriceDBTableViewCostPrice: TcxGridDBColumn;
    grdModelPriceDBTableViewSuggPrice: TcxGridDBColumn;
    grdModelPriceDBTableViewSalePrice: TcxGridDBColumn;
    qryLUVendor: TADOQuery;
    qryLUVendorIDVendor: TIntegerField;
    qryLUVendorVendor: TStringField;
    dsLUVendor: TDataSource;
    dsLUDescriptionPrice: TDataSource;
    qryLUDescriptionPrice: TADOQuery;
    qryLUDescriptionPriceIDDescriptionPrice: TIntegerField;
    qryLUDescriptionPriceDescriptionPrice: TStringField;
    btAdd: TSpeedButton;
    btDescription: TSpeedButton;
    Panel4: TPanel;
    btAddAllDesc: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure cdsModelPriceNewRecord(DataSet: TDataSet);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btDescriptionClick(Sender: TObject);
    procedure cdsModelPriceBeforePost(DataSet: TDataSet);
    procedure btAddAllDescClick(Sender: TObject);
  private
    FFrmDescriptionPrice: TFrmDescriptionPrice;
    FIDModel: Integer;

    procedure CloseLookUpDS;
    procedure OpenLookUpDS;
    procedure OpenModelPriceDS;
  public
    function Start(AIDModel: Integer; AParams: String = ''): Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TFrmModelPrice.CloseLookUpDS;
begin
  qryLUDescriptionPrice.Close;
  qryLUVendor.Close;
end;

procedure TFrmModelPrice.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgSmall.GetBitmap(BTN18_NEW, btAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemove.Glyph);
  DM.imgSmall.GetBitmap(BTM18_BACKUP, btDescription.Glyph);
  DM.imgBTN.GetBitmap(BTN_ADDALL, btAddAllDesc.Glyph);

  OpenLookUpDS;
end;

procedure TFrmModelPrice.OpenLookUpDS;
begin
  qryLUDescriptionPrice.Open;
  qryLUVendor.Open;
end;

function TFrmModelPrice.Start(AIDModel: Integer; AParams: String): Boolean;
begin
  FIDModel := AIDModel;
  OpenModelPriceDS;

  ShowModal;
  Result := ModalResult = mrOk;
end;

procedure TFrmModelPrice.FormDestroy(Sender: TObject);
begin
  inherited;
  CloseLookUpDS;

  if Assigned(FFrmDescriptionPrice) then
    FreeAndNil(FFrmDescriptionPrice);
end;

procedure TFrmModelPrice.OpenModelPriceDS;
begin
  with cdsModelPrice do
  begin
    if Active then
      Close;

    FetchParams;
    Params.ParamByName('IDModel').Value := FIDModel;
    Open;
  end;
end;

procedure TFrmModelPrice.btSaveClick(Sender: TObject);
begin
  inherited;
  if cdsModelPrice.ApplyUpdates(-1) > 0 then
  begin
    MsgBox(MSG_INF_NOT_DESCRIPTION_EMPTY, vbCritical + vbOKOnly);
    ModalResult := mrNone;
  end;
end;

procedure TFrmModelPrice.cdsModelPriceNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsModelPriceIDModel.AsInteger := FIDModel;
end;

procedure TFrmModelPrice.btAddClick(Sender: TObject);
begin
  inherited;
  cdsModelPrice.Append;
end;

procedure TFrmModelPrice.btRemoveClick(Sender: TObject);
begin
  inherited;
  cdsModelPrice.Delete;
end;

procedure TFrmModelPrice.btDescriptionClick(Sender: TObject);
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

procedure TFrmModelPrice.cdsModelPriceBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('IDDescriptionPrice').IsNull then
    MsgBox(MSG_INF_NOT_DESCRIPTION_EMPTY, vbInformation + vbOKOnly)
  else
    inherited;
end;

procedure TFrmModelPrice.btAddAllDescClick(Sender: TObject);
var
  sIDDescs: String;
begin
  inherited;
  with cdsModelPrice do
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
      cdsModelPrice.Append;
      cdsModelPrice.FieldByName('IDModel').AsInteger := FIDModel;
      cdsModelPrice.FieldByName('IDDescriptionPrice').AsInteger := FieldByName('IDDescriptionPrice').AsInteger;
      cdsModelPrice.FieldByName('CostPrice').AsFloat := 0;
      cdsModelPrice.FieldByName('SuggPrice').AsFloat := 0;
      cdsModelPrice.FieldByName('SalePrice').AsFloat := 0;
      cdsModelPrice.Post;
      Next;
    end;
  finally
    Close;
  end;
end;

end.
