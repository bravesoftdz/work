unit uFrmAddKitItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls, uSaleItem,
  DB, ADODB, DBClient, Provider, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, SubListPanel;

type
  TFrmAddKitItems = class(TFrmParent)
    quKitItem: TADODataSet;
    dsKitItem: TDataSource;
    dspKitModel: TDataSetProvider;
    cdsKitModel: TClientDataSet;
    btnSave: TButton;
    pgKitOption: TPageControl;
    tsKit: TTabSheet;
    tsKitPet: TTabSheet;
    grdBrowseKitItem: TcxGrid;
    grdBrowseKitItemDB: TcxGridDBTableView;
    grdBrowseKitItemDBMarked: TcxGridDBColumn;
    grdBrowseKitItemDBModel: TcxGridDBColumn;
    grdBrowseKitItemDBDescription: TcxGridDBColumn;
    grdBrowseKitItemDBQty: TcxGridDBColumn;
    grdBrowseKitItemDBSellingPrice: TcxGridDBColumn;
    grdBrowseKitItemLevel: TcxGridLevel;
    pnlCustomerInfo: TPanel;
    Panel4: TPanel;
    lbCustomer: TLabel;
    SubCustomer: TSubListPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    quPetMicrochip: TADODataSet;
    quPetMicrochipIDMicrochip: TIntegerField;
    quPetMicrochipMicrochip: TStringField;
    quPetMicrochipAmount: TBCDField;
    quPetMicrochipIDModel: TIntegerField;
    dspPetMicrochip: TDataSetProvider;
    cdsPetMicrochip: TClientDataSet;
    cdsPetMicrochipIDMicrochip: TIntegerField;
    cdsPetMicrochipMicrochip: TStringField;
    cdsPetMicrochipAmount: TBCDField;
    cdsPetMicrochipIDModel: TIntegerField;
    dsPetMicrochip: TDataSource;
    quPetMicrochipMarked: TBooleanField;
    cdsPetMicrochipMarked: TBooleanField;
    quPetMicrochipMicrochipNum: TStringField;
    cdsPetMicrochipMicrochipNum: TStringField;
    gridOptionalService: TcxGrid;
    cxGridDBTableMicro: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableMicroMicrochip: TcxGridDBColumn;
    cxGridDBTableMicroAmount: TcxGridDBColumn;
    cxGridDBTableMicroMarked: TcxGridDBColumn;
    cxGridDBTableMicroMicrochipNum: TcxGridDBColumn;
    quSearchMicrochip: TADODataSet;
    quSearchMicrochipIDPet: TIntegerField;
    quSearchMicrochipSKU: TStringField;
    quSearchMicrochipVendorCost: TBCDField;
    quSearchMicrochipSalePrice: TBCDField;
    quSearchMicrochipPromoPrice: TBCDField;
    quSearchMicrochipIDStatus: TIntegerField;
    Panel9: TPanel;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    Panel8: TPanel;
    Panel10: TPanel;
    gridRequireService: TcxGrid;
    cxGridDBTableViewPet: TcxGridDBTableView;
    cxGridDBTableViewPetMarked: TcxGridDBColumn;
    cxGridDBTableViewPetModel: TcxGridDBColumn;
    cxGridDBTableViewPetDescription: TcxGridDBColumn;
    cxGridLevelPet: TcxGridLevel;
    dsServiceRequire: TDataSource;
    cdsServiceRequire: TClientDataSet;
    cxGridDBTableViewPetDBColumn1: TcxGridDBColumn;
    dsServiceOptional: TDataSource;
    cdsServiceOptional: TClientDataSet;
    quKitItemIDModel: TIntegerField;
    quKitItemModel: TStringField;
    quKitItemDescription: TStringField;
    quKitItemQty: TBCDField;
    quKitItemPuppyTracker: TIntegerField;
    quKitItemSellingPrice: TBCDField;
    quKitItemVendorCost: TBCDField;
    quKitItemIDCustomer: TIntegerField;
    quKitItemIDMicrochip: TIntegerField;
    quKitItemPetSalePrice: TBCDField;
    quKitItemPetPromoPrice: TBCDField;
    quKitItemPetCostPrice: TBCDField;
    quKitItemIDPet: TIntegerField;
    quKitItemIDStatus: TIntegerField;
    quKitItemSKU: TStringField;
    cdsKitModelIDModel: TIntegerField;
    cdsKitModelModel: TStringField;
    cdsKitModelDescription: TStringField;
    cdsKitModelQty: TBCDField;
    cdsKitModelPuppyTracker: TIntegerField;
    cdsKitModelSellingPrice: TBCDField;
    cdsKitModelVendorCost: TBCDField;
    cdsKitModelIDCustomer: TIntegerField;
    cdsKitModelIDMicrochip: TIntegerField;
    cdsKitModelPetSalePrice: TBCDField;
    cdsKitModelPetPromoPrice: TBCDField;
    cdsKitModelPetCostPrice: TBCDField;
    cdsKitModelIDPet: TIntegerField;
    cdsKitModelIDStatus: TIntegerField;
    cdsKitModelSKU: TStringField;
    quKitItemPackModel: TIntegerField;
    quKitItemservice: TIntegerField;
    cdsKitModelPackModel: TIntegerField;
    cdsKitModelservice: TIntegerField;
    quKitItemMarked: TIntegerField;
    cdsKitModelMarked: TIntegerField;
    quKitItemRequireOnSale: TIntegerField;
    cdsKitModelRequireOnSale: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure SubCustomerAfterParamChanged(Changes: String);
    procedure cxGridDBTableViewPetPetPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridDBColumn1PropertiesChange(Sender: TObject);
    procedure cxGridDBTableMicroMarkedPropertiesEditValueChanged(
      Sender: TObject);
    procedure cxGridDBColumn1PropertiesEditValueChanged(Sender: TObject);
    procedure cdsKitModelSellingPriceChange(Sender: TField);
  private
    bResult : Boolean;
    FPuppyTracker : Boolean;
    FQty : Double;
    FSaleItem : TSaleItem;
    FIDCustomer : Integer;
    procedure InsertItems;
    procedure InsertPuppyItems;
    procedure CreatePetMicrochip(AIDPetSale, AIDPet : Integer);
    procedure OpenMicrochip(AIDPet : Integer);
    function ValidatePet : Boolean;
    procedure SearchPet;
    procedure FindMicrochip(sBarcode : String);
    procedure OpenKitItem;
  public
    // amfsouza 10.06.2011 - Sale needs to count Puppies
    function IsDog: boolean;

    // amfsouza May 18, 2012
    function Start(SaleItem : TSaleItem; arg_countPuppy: Integer = 0) : Boolean;
  end;

implementation

uses uDM, uParamFunctions, uMsgBox, uMsgConstant, uFrmPetSearch;

{$R *.dfm}

{ TFrmAddKitItems }

procedure TFrmAddKitItems.OpenKitItem;
begin
  with cdsKitModel do
    if not Active then
    begin
      Params.ParamByName('IDModel').Value := FSaleItem.IDModel;
      Params.ParamByName('IDStore').Value := FSaleItem.IDStore;
      Open;
    end;

  cdsKitModel.Filter   := 'marked = 1 and PuppyTracker = 1 and packmodel = 0 and service = 0';
  cdsKitModel.Filtered := true;
//  showmessage(format('records found %d', [cdsKitModel.RecordCount]));


  cdsKitModel.first;
  if ( not cdsKitModel.eof ) then begin
     FPuppyTracker := true;
//     showmessage('pet kit');
  end;

  cdsServiceRequire.Data      := cdsKitModel.Data;
  cdsServiceRequire.Filter    := 'marked = 1 and Puppytracker = 1 and service = 1 and RequireOnSale = 1';
  cdsServiceRequire.Filtered  := true;
//  cdsServiceRequire.FieldByName('Marked').ReadOnly := true;

  cdsServiceOptional.Data     := cdsKitModel.Data;
  cdsServiceOptional.Filter   := 'Puppytracker = 1 and service = 1 and RequireOnSale = 0';
  cdsServiceOptional.Filtered := true;

  cxGridDBTableMicro.Focused := false;

end;

function TFrmAddKitItems.Start(SaleItem: TSaleItem; arg_countPuppy: Integer = 0): Boolean;
var
   countPuppy: Integer;
begin
  FSaleItem := SaleItem;
  FQty := SaleItem.Qty;
  FIDCustomer := FSaleItem.IDCustomer;

  cdsKitModel.Close;
  OpenKitItem;

  countPuppy := 0;

  if FPuppyTracker then
  begin

    inc(countPuppy);

    countPuppy := countPuppy + arg_countPuppy;

    // Antonio June 06, 2013
    if ( countPuppy > 1 ) then begin
        Application.MessageBox('Only one pet may be sold at a time when PuppyTracker integration is enabled.', 'Sale Limited', mb_OK+mb_IconStop );
        result := false;
        exit;
    end;

    tsKitPet.TabVisible := True;
    tsKit.TabVisible := False;
    SubCustomer.CreateSubList;
    SubCustomer.Param := Format('IDCUSTOMER=%S;ChangeCustomer=1;', [IntToStr(FIDCustomer)]);
    cdsKitModelQty.ReadOnly := True;
    FindMicrochip(FSaleItem.Barcode);
  //  showmessage(format('customer selected = %d', [fidCustomer]));
  end
  else
  begin
    // amfsouza May 18, 2012
    cdsKitModel.filtered := false;
    tsKitPet.TabVisible := False;
    tsKit.TabVisible := True;
  end;

  bResult := False;

  ShowModal;

  Result := bResult;
end;

procedure TFrmAddKitItems.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsKitModel.Close;
  cdsPetMicrochip.Close;
  Action := caFree;
end;

procedure TFrmAddKitItems.btCloseClick(Sender: TObject);
begin
  inherited;
  bResult := False;
  Close;
end;

procedure TFrmAddKitItems.btnSaveClick(Sender: TObject);
begin
  inherited;
  if not FPuppyTracker then
    InsertItems
  else
    if ValidatePet then
      InsertPuppyItems
    else
      Exit;
      
  bResult := True;
  Close;
end;

procedure TFrmAddKitItems.InsertItems;
var
  bEmpty : Boolean;
  FIDPetSale : Integer;
begin
  with cdsKitModel do
    if Active then
    begin
      First;
      While not EOF do
      begin
        //# original dataset is like integer field instead boolean
        if ( FieldByName('Marked').Value = 1 ) then
        begin
          FSaleItem.IDModel              := FieldByName('IDModel').AsInteger;
          FSaleItem.CostPrice            := FieldByName('VendorCost').AsCurrency;
          FSaleItem.SellingPrice         := FieldByName('SellingPrice').AsCurrency;
          FSaleItem.Qty                  := FieldByName('Qty').AsCurrency * FQty;
          FSaleItem.KitSellingPrice      := DM.fPOS.GetKitPrice(FSaleItem.IDModel, FSaleItem.Qty, FSaleItem.SellingPrice, bEmpty);
          FSaleItem.CustomerSellingPrice := DM.FDMCalcPrice.FormatPrice((FSaleItem.SellingPrice - (DM.fPOS.CalcCustomerDiscount(FSaleItem.IDCustomer, FSaleItem.IDModel, FSaleItem.Qty, FSaleItem.SellingPrice)/FSaleItem.Qty)));
          FSaleItem.Add;
        end;
      Next;
      end;
    end;
end;

procedure TFrmAddKitItems.InsertPuppyItems;
var
  bEmpty : Boolean;
  FIDPetSale : Integer;
begin
  try
      dm.ADODBConnect.BeginTrans;

      // move pets to cash register
      cdsKitModel.First;
      while ( not cdsKitmodel.Eof ) do begin
            FSaleItem.IDModel              := cdsKitModel.FieldByName('IDModel').AsInteger;
            FSaleItem.CostPrice            := cdsKitModel.FieldByName('VendorCost').AsCurrency;
            FSaleItem.SellingPrice         := cdsKitModel.FieldByName('SellingPrice').AsCurrency;
            FSaleItem.Qty                  := 1;
            FSaleItem.Discount             := 0;
            FSaleItem.IDCustomer           := FIDCustomer;

            FSaleItem.KitSellingPrice      := 0;
            FSaleItem.CustomerSellingPrice := 0;

            if ( FSaleItem.IsManualPrice ) then begin
                 FSaleItem.ManualPrice := FSaleItem.SellingPrice;
            end;

//  showmessage(format('item inside kit (Pet) -> Idmodel = %d, Sale Price = %2.f, ManualPrice = %2.f', [cdsKitModel.fieldByName('IdModel').asInteger, cdsKitModel.fieldByName('SellingPrice').AsFloat, FSaleItem.ManualPrice]));
            FSaleItem.Add;
          cdsKitModel.Next;
      end;

      cdsServiceRequire.First;
      while ( not cdsServiceRequire.Eof ) do begin
//              showmessage(format('item inside kit (Service) -> Idmodel = %d, Sale Price = %2.f', [cdsServiceRequire.fieldByName('IdModel').asInteger, cdsServiceRequire.fieldByName('SellingPrice').asFloat]));

              FSaleItem.IDModel              := cdsServiceRequire.FieldByName('IDModel').AsInteger;
              FSaleItem.CostPrice            := cdsServiceRequire.FieldByName('VendorCost').AsCurrency;
              FSaleItem.SellingPrice         := cdsServiceRequire.FieldByName('SellingPrice').AsCurrency;
              FSaleItem.Qty                  := 1;
              FSaleItem.Discount             := 0;
              FSaleItem.IDCustomer           := FIDCustomer;
              FSaleItem.KitSellingPrice      := 0;
              FSaleItem.CustomerSellingPrice := 0;
              FSaleItem.IsManualPrice := false;
              FSaleItem.Add;
          cdsServiceRequire.Next;
      end;

      // move optional services to cash register ( if true )
      cdsServiceOptional.First;
      while ( not cdsServiceOptional.Eof ) do begin
          if ( cdsServiceOptional.FieldByName('Marked').Value = 1 ) then begin
             FSaleItem.IDModel              := cdsServiceOptional.FieldByName('IDModel').AsInteger;
             FSaleItem.CostPrice            := cdsServiceOptional.FieldByName('VendorCost').AsCurrency;
             FSaleItem.SellingPrice         := cdsServiceOptional.FieldByName('SellingPrice').AsCurrency;

//              showmessage(format('item inside kit (Optional Service) -> Idmodel = %d, Sale Price = %2.f', [cdsServiceOptional.fieldByName('IdModel').asInteger, cdsServiceOptional.fieldByName('SellingPrice').asFloat]));

             FSaleItem.Qty                  := 1;
             FSaleItem.Discount             := 0;
             FSaleItem.IDCustomer           := FIDCustomer;
             FSaleItem.KitSellingPrice      := 0;
             FSaleItem.CustomerSellingPrice := 0;
             FSaleItem.IsManualPrice := false;
             FSaleItem.Add;
          end;

          cdsServiceOptional.Next;

      end;


      dm.ADODBConnect.CommitTrans;
  except
      dm.ADODBConnect.RollbackTrans;
  end;
end;

procedure TFrmAddKitItems.OpenMicrochip(AIDPet: Integer);
begin
  with cdsPetMicrochip do
    if not Active then
    begin
      Params.ParamByName('IDPet').AsInteger := AIDPet;
      Open;
    end;
end;

procedure TFrmAddKitItems.CreatePetMicrochip(AIDPetSale, AIDPet: Integer);
var
  FCommand : TADOCommand;
begin
  with cdsPetMicrochip do
    if Active then
    begin
      First;
      While not EOF do
      begin
        if FieldByName('Marked').AsBoolean then
        begin
            FSaleItem.IDModel              := FieldByName('IDModel').AsInteger;
            FSaleItem.SellingPrice         := FieldByName('Amount').AsCurrency;
            FSaleItem.CostPrice            := 0;
            FSaleItem.Discount             := 0;
            FSaleItem.IDCustomer           := FIDCustomer;
            FSaleItem.Qty                  := 1;
            FSaleItem.KitSellingPrice      := 0;
            FSaleItem.CustomerSellingPrice := 0;
            FSaleItem.Add;

            FCommand := TADOCommand.Create(Self);
            try
              FCommand.Connection := DM.ADODBConnect;
              FCommand.CommandText := 'INSERT Pet_MicrochipSale (IDPreInventoryMov, IDMicrochip, IDPetSale, MicrochipNum) ' +
                                      'VALUES (:IDPreInventoryMov, :IDMicrochip, :IDPetSale, :MicrochipNum) ';

              FCommand.Parameters.ParamByName('IDPreInventoryMov').Value := FSaleItem.IDPreInventoryMov;
              FCommand.Parameters.ParamByName('IDMicrochip').Value       := FieldByName('IDMicrochip').Value;
              FCommand.Parameters.ParamByName('IDPetSale').Value         := AIDPetSale;
              FCommand.Parameters.ParamByName('MicrochipNum').Value      := FieldByName('MicrochipNum').Value;
              FCommand.Execute();
            finally
              FreeAndNil(FCommand);
              end;
        end;
        Next;
      end;
    end;

end;

function TFrmAddKitItems.ValidatePet: Boolean;
begin
  Result := False;

  if FIDCustomer in [0,1] then
  begin
    FIDCustomer := 0;
    MsgBox(MSG_CRT_NO_CUSTUMER, vbOKOnly + vbInformation);
    SubCustomer.Param := Format('IDCUSTOMER=%S;ChangeCustomer=1;SelectCustomer=Y;', [IntToStr(FIDCustomer)]);
    Exit;
  end;

  with cdsKitModel do
  try
    DisableControls;
    First;
    while not EOF do
    begin
(*
      if (FieldByName('PuppyTracker').AsInteger = 1) and (FieldByName('IDPet').AsInteger = 0) then
      begin
        MsgBox(Format(MSG_INF_SELECT_PET_SKU, [FieldByName('Model').AsString]), vbOKOnly + vbInformation);
        SearchPet;
        Exit;
      end;
 *)
      if (FieldByName('PuppyTracker').AsInteger = 1) and (FieldByName('IDStatus').AsInteger <> 1) then
        if MsgBox(Format('%S is not available._Continue ?', [FieldByName('Model').AsString]), vbYesNo + vbSuperCritical) = vbNo then
        Exit;

      Next;
    end;
    First;
  finally
    EnableControls;
  end;

  Result := True;
end;

procedure TFrmAddKitItems.SubCustomerAfterParamChanged(Changes: String);
var
  sResult : String;
begin
  inherited;
  sResult := SubCustomer.GetSubListInfo('');
  FIDCustomer := StrToIntDef(Trim(ParseParam(sResult, 'IDCUSTOMER')), 0);
  FSaleItem.IDCustomer := FIDCustomer;
 // showmessage(format('customer selected %d', [FIDCustomer]));
end;

procedure TFrmAddKitItems.cxGridDBTableViewPetPetPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  SearchPet;
end;

procedure TFrmAddKitItems.SearchPet;
var
  AIDPet, AIDStatus : Integer;
  ACost, ASale : Currency;
  ASKU : String;
begin
  inherited;

  with cdsKitModel do
  if FieldByName('PuppyTracker').AsInteger = 1 then
  begin
    with TFrmPetSearch.Create(Self) do
    try
      if Start(cdsKitModelIDModel.AsInteger, AIDPet, AIDStatus, ACost, ASale, ASKU) then
      begin
        Edit;
        FieldByName('IDPet').AsInteger := AIDPet;
        FieldByName('SKU').AsString := ASKU;
        FieldByName('VendorCost').AsCurrency := ACost;
        FieldByName('IDStatus').AsInteger := AIDStatus;
        if ASale <> 0 then
          FieldByName('SellingPrice').AsCurrency := ASale;
        Post;

        cdsPetMicrochip.Close;
        OpenMicrochip(AIDPet);
      end;
    finally
      Free;
    end;
  end;

end;

procedure TFrmAddKitItems.FindMicrochip(sBarcode: String);
begin
  if sBarcode <> '' then
  try
    quSearchMicrochip.Parameters.ParamByName('MicrochipNum').Value := sBarcode;
    quSearchMicrochip.Open;
    if not quSearchMicrochip.IsEmpty then
    begin

      with cdsKitModel do
      try
        DisableControls;
        First;
        while not EOF do
        begin
          if (FieldByName('PuppyTracker').AsInteger = 1) then
          begin
            Edit;
            FieldByName('IDPet').AsInteger := quSearchMicrochipIDPet.AsInteger;
            FieldByName('IDStatus').AsInteger := quSearchMicrochipIDStatus.AsInteger;
            FieldByName('SKU').AsString := quSearchMicrochipSKU.AsString;
            FieldByName('VendorCost').AsCurrency := quSearchMicrochipVendorCost.AsCurrency;
            if (quSearchMicrochipSalePrice.AsCurrency <> 0) or (quSearchMicrochipPromoPrice.AsCurrency <> 0) then
            begin
              if quSearchMicrochipPromoPrice.AsCurrency <> 0 then
                FieldByName('SellingPrice').AsCurrency := quSearchMicrochipPromoPrice.AsCurrency
              else
                FieldByName('SellingPrice').AsCurrency := quSearchMicrochipSalePrice.AsCurrency;
            end;
            Post;

            cdsPetMicrochip.Close;
            OpenMicrochip(quSearchMicrochipIDPet.AsInteger);
          end;
          Next;
        end;
        First;
      finally
        EnableControls;
      end;

    end;
  finally
    quSearchMicrochip.Close;
  end;
end;

procedure TFrmAddKitItems.cxGridDBColumn1PropertiesChange(Sender: TObject);
begin
  inherited;
//  cxgriddbcolumn1.Properties.
end;

procedure TFrmAddKitItems.cxGridDBTableMicroMarkedPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
(*
  cxGridDBTableMicro.Focused := false;
  if ( cxGridDBTableMicroMarked.EditValue = False ) then begin
     cdsServiceOptional.Edit;
     cdsServiceOptional.FieldByName('Marked').Value := 0;
     cdsServiceOptional.Post;
  end;
 *) 
end;

procedure TFrmAddKitItems.cxGridDBColumn1PropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
(*
  if ( cxGridDBColumn1.EditValue = False ) then begin
     cxGridDBColumn1.EditValue := True;
  end;
*)
end;

function TFrmAddKitItems.IsDog: boolean;
begin
   result := FPuppyTracker;
end;

procedure TFrmAddKitItems.cdsKitModelSellingPriceChange(Sender: TField);
begin
  inherited;
  FSaleItem.IsManualPrice := true;
end;

end.
