unit uFrmPromoItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, Buttons, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, Mask,
  SuperComboADO, ADODB, PowerADOQuery, uFrmBarcodeSearch, DBClient;

type
  TFrmPromoItem = class(TFrmParent)
    Panel4: TPanel;
    lbSearch: TLabel;
    grdPromoPrizeItem: TcxGrid;
    grdPromoPrizeItemDB: TcxGridDBTableView;
    grdPromoPrizeItemDBModel: TcxGridDBColumn;
    grdPromoPrizeItemDBDescription: TcxGridDBColumn;
    grdPromoPrizeItemLevel: TcxGridLevel;
    pnlComand: TPanel;
    btSearch: TSpeedButton;
    btRemove: TSpeedButton;
    Panel6: TPanel;
    btSave: TButton;
    quSearchItem: TADODataSet;
    quSearchItemIDModel: TIntegerField;
    quSearchItemModel: TStringField;
    quSearchItemDescription: TStringField;
    lbVendor: TLabel;
    cbTypeSearch: TComboBox;
    edSearch: TEdit;
    scVendor: TSuperComboADO;
    cdsPromoItems: TClientDataSet;
    cdsPromoItemsIDPRomo: TIntegerField;
    cdsPromoItemsIDPromoItem: TIntegerField;
    cdsPromoItemsModel: TStringField;
    cdsPromoItemsDescription: TStringField;
    cdsPromoItemsIDModel: TIntegerField;
    dsPromoItems: TDataSource;
    btNewItem: TSpeedButton;
    procedure btSearchClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure cbTypeSearchChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edSearchKeyPress(Sender: TObject; var Key: Char);
    procedure cdsPromoItemsAfterOpen(DataSet: TDataSet);
    procedure btNewItemClick(Sender: TObject);
  private
    IDPromo :Integer;
    IDPromoItem: Integer;

    procedure CreatePromoItem;
    function ExistPromoItem(pIDModel : String): Boolean;

    {
    Funções que serão utilizadas para não permitir que um produto que esteja
    cadastrado em Promo Items(X) seja cadastrado no Discount Items(Y) e Vice-Versa.
    }
    function ExistInDiscountItems(pIDModel : String): Boolean;
    function ExistInPromoItems(pIDModel : String): Boolean;

    function VerifyModelCondition(pIDModel : String): Boolean;

    procedure LoadImages;

    Procedure ChangedTypeSearch;
    Procedure PopulatePromoItems;
    Procedure InsertPromoItems(IDPromo, IDPromoItem, IDModel : Integer; Model, Description : String);
    Procedure SearchItem;
  public
    function Start(AID, AIDPromoItem, APromoType :Integer): Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, StrUtils, uSystemConst, uFrmPromoPrizeItem,
     uFrmModelQuickEntry, uContentClasses, ufrmModelAdd;

{$R *.dfm}

procedure TFrmPromoItem.btSearchClick(Sender: TObject);
var
  FFrmPromoProzeItem: TFrmPromoPrizeItem;
begin
  FFrmPromoProzeItem := TFrmPromoPrizeItem.Create(self);
  with FFrmPromoProzeItem do
    if Start(IDPromoItem) then
    begin
      FFrmPromoProzeItem.cdsResult.First;
      while not FFrmPromoProzeItem.cdsResult.Eof do
      begin
        if not ExistPromoItem(FFrmPromoProzeItem.cdsResult.FieldByName('IDModel').AsString) then
          InsertPromoItems(IDPromo, IDPromoItem,
                            FFrmPromoProzeItem.cdsResult.FieldByName('IDModel').Value,
                            FFrmPromoProzeItem.cdsResult.FieldByName('Model').Value,
                            FFrmPromoProzeItem.cdsResult.FieldByName('Description').Value);
        FFrmPromoProzeItem.cdsResult.Next;
      end;
    end;

  FreeAndNil(FFrmPromoProzeItem);
end;

procedure TFrmPromoItem.btRemoveClick(Sender: TObject);
begin
  if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
  try
    Screen.Cursor := crHourGlass;
    try
      cdsPromoItems.Delete;
    except
      MsgBox(MSG_CRT_NO_DEL_RECORD, vbCritical + vbOKOnly);
     end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmPromoItem.CreatePromoItem;
var
  NewID : Integer;
begin
  if not cdsPromoItems.IsEmpty then
  begin
    cdsPromoItems.DisableControls;
    cdsPromoItems.First;
    while not cdsPromoItems.Eof do
    begin
      if IDPromoItem = 0 then
      begin
        NewID := DM.GetNextID('Sal_PromoItem.IDPromoItem');
        DM.RunSQL('INSERT INTO Sal_PromoItem (IDPromoItem, IDPromo, IDModel) VALUES ( ' + InttoStr(NewID) + ' , ' + InttoStr(IDPromo) + ' , ' + cdsPromoItemsIDModel.AsString + ')');
      end
      else
      begin
        NewID := DM.GetNextID('Sal_PromoPrizeItem.IDPromoPrizeItem');
        DM.RunSQL('INSERT INTO Sal_PromoPrizeItem (IDPromoPrizeItem, IDPromoItem, IDModel) VALUES ( ' + InttoStr(NewID) + ' , ' + InttoStr(IDPromoItem) + ' , ' + cdsPromoItemsIDModel.AsString + ')');
      end;
      cdsPromoItems.Next;
    end;
  end;
end;

function TFrmPromoItem.Start(AID, AIDPromoItem, APromoType :Integer): Boolean;
begin
  IDPromo := AID;
  IDPromoItem := AIDPromoItem;
  {
  IDPromoItem = 0  -> PROMO ITEMS(X)
  IDPromoItem <> 0 -> DISCOUNT ITEMS(Y)
  }

  cdsPromoItems.CreateDataSet;
  
  ShowModal;

  if (ModalResult = mrOk) then
  begin
    CreatePromoItem;
    Result := True;
  end
  else
    Result := false;

  cdsPromoItems.Close;
end;

procedure TFrmPromoItem.btSaveClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmPromoItem.btCloseClick(Sender: TObject);
begin
  inherited;
  cdsPromoItems.Close;
  Close;
end;

function TFrmPromoItem.ExistPromoItem(pIDModel : String) : Boolean;
var
  sSelect : String;
  bInDiscountItems, bInPromoItems : Boolean;
begin
  bInDiscountItems := False;
  bInPromoItems := False;

  if IDPromoItem = 0 then
  begin
    sSelect := 'SELECT IDModel FROM Sal_PromoItem (NOLOCK) WHERE IDPromo = ' + InttoStr(IDPromo) + ' AND IDModel = ' + pIDModel;
    bInDiscountItems := ExistInDiscountItems(pIDModel);
  end
  else
  begin
    sSelect := 'SELECT IDModel FROM Sal_PromoPrizeItem (NOLOCK) WHERE IDPromoItem = ' + InttoStr(IDPromoItem) + ' AND IDModel = ' + pIDModel;
    bInPromoItems := ExistInPromoItems(pIDModel);
  end;

  if ((not bInDiscountItems) and (not bInPromoItems)) then
  begin
    with DM.quFreeSQL do
    try
      if Active then
        Close;
      SQL.Text := sSelect;
      Open;

      if ((DM.quFreeSQL.IsEmpty) and (not cdsPromoItems.Locate('IDModel', pIDModel, []))) then
        Result := False
      else
        Result := True;
    finally
      Close;
    end;
  end
  else
    Result := True;

end;

procedure TFrmPromoItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  quSearchItem.Close;
end;

procedure TFrmPromoItem.LoadImages;
begin
  DM.imgSmall.GetBitmap(BTN18_SEARCH, btSearch.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btRemove.Glyph);
  DM.imgSmall.GetBitmap(BTN18_NEW, btNewItem.Glyph);
end;

procedure TFrmPromoItem.FormCreate(Sender: TObject);
begin
  inherited;
  LoadImages;
end;

function TFrmPromoItem.VerifyModelCondition(pIDModel : String): Boolean;
begin
  if ExistPromoItem(pIDModel) then
  begin
    MsgBox(MSG_EXC_MODEL_EXISTE, vbOKOnly + vbInformation);
    ModalResult := mrNone;
    Result := False;
    Exit;
  end;

  Result := True;
end;

procedure TFrmPromoItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   
  case Key of
    VK_F4 : begin //Remove Button
              if (btRemove.Enabled) then
                btRemoveClick(nil);
            end;
   end;

end;

procedure TFrmPromoItem.FormDestroy(Sender: TObject);
begin
  inherited;
//  FreeAndNil(fFrmBarcodeSearch);
end;

procedure TFrmPromoItem.ChangedTypeSearch;
begin
  edSearch.Clear;
  edSearch.SetFocus;
  if cbTypeSearch.ItemIndex <> 2 then
  begin
    scVendor.Enabled := False;
    scVendor.Text := '';
  end
  else
    scVendor.Enabled := True;
end;

procedure TFrmPromoItem.cbTypeSearchChange(Sender: TObject);
begin
  inherited;
  ChangedTypeSearch;
end;

procedure TFrmPromoItem.PopulatePromoItems;
begin
{
  quPromoPrizeItem.First;
  while not quPromoPrizeItem.Eof do
  begin
    cdsPromoItems.Append;
    cdsPromoItemsIDPRomo.value := IDPromo;
    cdsPromoItemsIDPromoItem.Value := IDPromoItem;
    cdsPromoItemsIDModel.value := quPromoPrizeItemIDModel.value;
    cdsPromoItemsModel.value := quPromoPrizeItemModel.value;
    cdsPromoItemsDescription.value := quPromoPrizeItemDescription.value;

    quPromoPrizeItem.Next;
  end;
}
end;

procedure TFrmPromoItem.FormShow(Sender: TObject);
begin
  inherited;
  ChangedTypeSearch;
end;

procedure TFrmPromoItem.SearchItem;
var
 sSQL, sWhere, sJoin : String;
begin
  quSearchItem.Close;
  
  sSQL := 'SELECT '+
        	  'M.IDModel, '+
          	'M.Model, '+
          	'M.Description '+
          'FROM Model M (NOLOCK) ';

  if cbTypeSearch.ItemIndex = 0 then
    sWhere := 'WHERE M.Model = '+ QuotedStr(edSearch.Text)
  else if cbTypeSearch.ItemIndex = 1 then
  begin
    sJoin := 'JOIN Barcode B (NOLOCK) ON (B.IDModel = M.IDModel) ';
    sWhere := 'WHERE B.IDBarcode = '+ QuotedStr(edSearch.Text);
  end
  else if cbTypeSearch.ItemIndex = 2 then
  begin
    sJoin := 'INNER JOIN Inv_ModelVendor IMV (NOLOCK) '+
                'ON (M.IDModel = IMV.IDModel) ' +
                'AND IMV.IDPessoa = ' + scVendor.LookUpValue+
              ' INNER JOIN Pet P (NOLOCK) ON M.IDModel = P.IDModel ';

    sWhere := 'WHERE P.SKU = ' + QuotedStr(edSearch.Text);
  end;

  quSearchItem.CommandText := sSQL + sJoin + sWhere;
  quSearchItem.Open;
end;

procedure TFrmPromoItem.InsertPromoItems(IDPromo, IDPromoItem,
  IDModel: Integer; Model, Description: String);
begin
  cdsPromoItems.Append;
  cdsPromoItemsIDPRomo.value := IDPromo;
  cdsPromoItemsIDPromoItem.Value := IDPromoItem;
  cdsPromoItemsIDModel.value := IDModel;
  cdsPromoItemsModel.value := Model;
  cdsPromoItemsDescription.value := Description;
  cdsPromoItems.Post;
end;

procedure TFrmPromoItem.edSearchKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if ((cbTypeSearch.ItemIndex = 2) and (scVendor.LookUpValue = '')) then
        MsgBox(MSG_EXC_SELECT_A_VENDOR, vbOkOnly + vbExclamation)
    else
    begin
      SearchItem;
      If not quSearchItem.IsEmpty then
      begin
        if VerifyModelCondition(quSearchItemIDModel.AsString) then
          InsertPromoItems(IDPromo, IDPromoItem, quSearchItemIDModel.value,
                           quSearchItemModel.value, quSearchItemDescription.Value);
      end;
      edSearch.Clear;
    end;
  end;
end;

procedure TFrmPromoItem.cdsPromoItemsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btRemove.Enabled := cdsPromoItems.RecordCount > 0;
end;

procedure TFrmPromoItem.btNewItemClick(Sender: TObject);
var
  ABarcode: TBarcode;
  FFrmModelQuickEntry : TfrmModelAdd;
  key : Char;
begin
  inherited;
  try
    //FFrmModelQuickEntry := TFrmModelQuickEntry.Create(Self);
    //amfsouza 11.22.2011
    FFrmModelQuickEntry := TfrmModelAdd.Create(self);

    ABarcode := FFrmModelQuickEntry.Start(False, True, True, '');
    if ABarcode.Model.IDModel <> -1 then
    begin
      if not ExistPromoItem(ABarcode.Model.Model) then
        InsertPromoItems(IDPromo, IDPromoItem,
                          ABarcode.Model.IDModel,
                          ABarcode.Model.Model,
                          ABarcode.Model.Description);
    end;
  finally
    FreeAndNil(FFrmModelQuickEntry);
  end;
end;

function TFrmPromoItem.ExistInDiscountItems(pIDModel: String): Boolean;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Text := 'SELECT PP.IDModel'+
                '   FROM Sal_PromoPrizeItem PP (NOLOCK)'+
                '        JOIN Sal_PromoItem P (NOLOCK)'+
                '     	  ON PP.IDPromoItem = P.IDPromoItem'+
                '	        AND P.IDPromo = '+InttoStr(IDPromo)+
                '  WHERE PP.IDModel = '+pIDModel;
    Open;

    if (DM.quFreeSQL.IsEmpty) then
      Result := False
    else
      Result := True;
  finally
    Close;
  end;
end;

function TFrmPromoItem.ExistInPromoItems(pIDModel: String): Boolean;
begin
  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Text := 'SELECT P.IDModel'+
                '   FROM Sal_PromoItem P (NOLOCK)'+
                '  WHERE P.IDPromo = '+InttoStr(IDPromo)+
                '	AND P.IDModel = '+pIDModel;
    Open;

    if (DM.quFreeSQL.IsEmpty) then
      Result := False
    else
      Result := True;
  finally
    Close;
  end;
end;

end.
