unit uFrmMarginTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, Buttons, ADODB, PowerADOQuery, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, dxExEdtr, dxTL, dxCntner, DBClient;

type
  TFrmMarginTable = class(TFrmParent)
    dsBrowse: TDataSource;
    quMargemTable: TADODataSet;
    quMargemTableMargemTable: TStringField;
    pnPanel: TPanel;
    btGroup: TSpeedButton;
    TreeList: TdxTreeList;
    clTreeText: TdxTreeListColumn;
    clTreeValue: TdxTreeListColumn;
    quBrowse: TADODataSet;
    quBrowseIDGroup: TIntegerField;
    quBrowseCategory: TStringField;
    quBrowseIDSalePriceMargemTable: TIntegerField;
    quBrowseSalePriceMargemPercent: TFloatField;
    quBrowseUseSalePricePercent: TBooleanField;
    quBrowseIDMSRPMargemTable: TIntegerField;
    quBrowseMSRPMargemPercent: TFloatField;
    quBrowseUseMSRPPercent: TBooleanField;
    quBrowseIDModelGroup: TIntegerField;
    quBrowseModelGroup: TStringField;
    quBrowseMGSalePriceMargemPercent: TFloatField;
    quBrowseMGUseSalePricePercent: TBooleanField;
    quBrowseMGIDSalePriceMargemTable: TIntegerField;
    quBrowseMGIDMSRPMargemTable: TIntegerField;
    quBrowseMGMSRPMargemPercent: TFloatField;
    quBrowseMGUseMSRPPercent: TBooleanField;
    quBrowseIDModelSubGroup: TIntegerField;
    quBrowseModelSubGroup: TStringField;
    quBrowseMSGSalePriceMargemPercent: TFloatField;
    quBrowseMSGUseSalePricePercent: TBooleanField;
    quBrowseMSGIDSalePriceMargemTable: TIntegerField;
    quBrowseMSGIDMSRPMargemTable: TIntegerField;
    quBrowseMSGMSRPMargemPercent: TFloatField;
    quBrowseMSGUseMSRPPercent: TBooleanField;
    clTreeMSRP: TdxTreeListColumn;
    TreeListID: TdxTreeListColumn;
    TreeListType: TdxTreeListColumn;
    btRecalcAllGroup: TSpeedButton;
    cdsMarginRecalcAll: TClientDataSet;
    cdsMarginRecalcAllIsUpdate: TBooleanField;
    cdsMarginRecalcAllModel: TStringField;
    cdsMarginRecalcAllDescription: TStringField;
    cdsMarginRecalcAllIDModel: TIntegerField;
    cdsMarginRecalcAllCostPrice: TBCDField;
    cdsMarginRecalcAllNewSellingPrice: TBCDField;
    cdsMarginRecalcAllNewMSRPPrice: TBCDField;
    cdsMarginRecalcAllSalePrice: TBCDField;
    cdsMarginRecalcAllMSRP: TBCDField;
    cdsMarginRecalcAllRealMarkUpValue: TBCDField;
    cdsMarginRecalcAllRealMarkUpPercent: TBCDField;
    cdsMarginRecalcAllMarginPercent: TBCDField;
    cdsMarginRecalcAllMarginValue: TBCDField;
    cdsMarginRecalcAllCategory: TStringField;
    cdsMarginRecalcAllSubCategory: TStringField;
    cdsMarginRecalcAllModelGroup: TStringField;
    cdsMarginRecalcAllMarkUp: TBCDField;
    cmdUpdateModel: TADOCommand;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btGroupClick(Sender: TObject);
    procedure quBrowseAfterOpen(DataSet: TDataSet);
    procedure btRecalcAllGroupClick(Sender: TObject);
  private
    AView    : TcxCustomGridTableView;
    procedure CallShortCut(IDMenu, IDSubMenu : Integer);

    procedure GetGroupValue(var SaleCatValue, SaleGroValue, SaleSubValue,
                                MSRPCatValue, MSRPGroValue, MSRPSubValue : String);
    function GetMargemTableName(ID: Integer): String;
    procedure DisplayMarginTable;
    procedure AddListItems(IDC, IDG, IDS : Integer; Category, CValue, Group, GValue, Sub, SValue,
                           MSRPCValue, MSRPGValue, MSRPSValue : String);

    procedure OpenBrowser;
    procedure CloseBrowser;
    procedure RefreshBrowser;
    procedure UpdateNewPrices;
    procedure RecalcAllInventory;
    
  public
    procedure Start;
  end;

implementation

uses uStringFunctions, uDM, uFrmMarginTableApply, MenuPrincipal,
     uDMCalcPrice, uContentClasses, uObjectServices, uHandleError,
     uMsgBox, uMsgConstant;

{$R *.dfm}

procedure TFrmMarginTable.Start;
begin

 OpenBrowser;

 DM.imgSubMenu.GetBitmap(29, btGroup.Glyph);

 ShowModal;
 
end;

procedure TFrmMarginTable.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TFrmMarginTable.GetMargemTableName(ID: Integer): String;
var Friend : String;
begin
 with quMargemTable do
  begin
   if Active then
    Close;
   Parameters.ParamByName('IDMargemTable').Value := ID;
   Open;
  Result := quMargemTableMargemTable.AsString;
  Close;
  end;
end;

procedure TFrmMarginTable.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  CloseBrowser;

end;

procedure TFrmMarginTable.DisplayMarginTable;
var
  CValue,
  GValue,
  SValue,
  MSRPCValue,
  MSRPGValue,
  MSRPSValue : String;
begin

  TreeList.ClearNodes;

  with quBrowse do
    begin
    DisableControls;
    First;
    while not EOF do
    begin
      if quBrowseCategory.AsString <> '' then
      begin
        GetGroupValue(CValue, GValue, SValue, MSRPCValue, MSRPGValue, MSRPSValue);
        AddListItems(quBrowseIDGroup.AsInteger,
                     quBrowseIDModelGroup.AsInteger,
                     quBrowseIDModelSubGroup.AsInteger,
                     quBrowseCategory.AsString,
                     CValue,
                     quBrowseModelGroup.AsString,
                     GValue,
                     quBrowseModelSubGroup.AsString,
                     SValue,
                     MSRPCValue,
                     MSRPGValue,
                     MSRPSValue);
      end;
      Next;
    end;
    EnableControls;
    end;
  TreeList.FullExpand;

end;

procedure TFrmMarginTable.AddListItems(IDC, IDG, IDS : Integer; Category, CValue,
             Group, GValue, Sub, SValue, MSRPCValue, MSRPGValue, MSRPSValue : String);
var
 fParent,
 fGroup,
 fSub    : TdxTreeListNode;
 i : integer;
begin

  fParent := nil;
  fGroup  := nil;
  fSub    := nil;

  if CValue = '' then
     CValue := '0%';
  if (GValue = '0%') or (GValue = '') then
     GValue := CValue;
  if (SValue = '0%') or (SValue = '') then
     SValue := GValue;

  if MSRPCValue = '' then
     MSRPCValue := '0%';
  if (MSRPGValue = '0%') or (MSRPGValue = '') then
     MSRPGValue := MSRPCValue;
  if (MSRPSValue = '0%') or (MSRPSValue = '') then
     MSRPSValue := MSRPGValue;


  //Parent
  for i := 0 to TreeList.Count-1 do
    begin
    fParent := TreeList.Items[i];
    if Category = fParent.Strings[0] then
       Break;
    fParent := nil;
    end;

  if (Category <> '') and (fParent = nil) then
     begin
     fParent := TreeList.Add;
     fParent.Strings[0] := Category;
     fParent.Strings[1] := CValue;
     fParent.Strings[2] := MSRPCValue;
     fParent.Strings[3] := IntToStr(IDC);
     fParent.Strings[4] := IntToStr(1);
     end;


  //Group
  for i := 0 to fParent.Count-1 do
    begin
    fGroup := fParent.Items[i];
    if Group = fParent.Items[i].Strings[0] then
       Break;
    fGroup := nil;
    end;

  if (Group <> '') and (fGroup = nil) then
     begin
     fGroup := fParent.AddChild;
     fGroup.Strings[0] := Group;
     fGroup.Strings[1] := GValue;
     fGroup.Strings[2] := MSRPGValue;
     fGroup.Strings[3] := IntToStr(IDG);
     fGroup.Strings[4] := IntToStr(2);
     end;

  //Sub
  if fGroup = nil then
     Exit;

  for i := 0 to fGroup.Count-1 do
    begin
    fSub := fGroup.Items[i];
    if Sub = fGroup.Items[i].Strings[0] then
       Break;
    fSub := nil;
    end;

  if (Sub <> '') and (fSub = nil) then
     begin
     fSub := fGroup.AddChild;
     fSub.Strings[0] := Sub;
     fSub.Strings[1] := SValue;
     fSub.Strings[2] := MSRPSValue;
     fSub.Strings[3] := IntToStr(IDS);
     fSub.Strings[4] := IntToStr(3);
     end;
end;

procedure TFrmMarginTable.CloseBrowser;
begin

  with quBrowse do
    if Active then
       Close;

end;

procedure TFrmMarginTable.OpenBrowser;
begin

  with quBrowse do
    if not Active then
       Open;

end;

procedure TFrmMarginTable.RefreshBrowser;
begin
   CloseBrowser;
   OpenBrowser;

end;

procedure TFrmMarginTable.CallShortCut(IDMenu, IDSubMenu: Integer);
var
  fImgOld : Integer;
  fsMenu,
  fsSubMenu : String;
begin
  try
    fImgOld   := DM.fMainMenu.Image;
    fsMenu    := DM.fMainMenu.MenuName;
    fsSubMenu := DM.fMainMenu.SubMenuName;

    MainMenu.IDMenu    := IDMenu;
    MainMenu.IDSubMenu := IDSubMenu;
    MainMenu.SubMenuClick(nil);
    RefreshBrowser;
  finally
    MainMenu.IDMenu         := 8;
    MainMenu.IDSubMenu      := 8;
    DM.fMainMenu.Image      := fImgOld;
    DM.fMainMenu.MenuName   := fsMenu;
    DM.fMainMenu.SubMenuName:= fsSubMenu;
    end;

end;

procedure TFrmMarginTable.btGroupClick(Sender: TObject);
var
 iID : Integer;
 fType : TModelGroupingType;
begin
  inherited;

  //iNodeIndex := TreeList.FocusedNode.AbsoluteIndex;

  iID := StrToIntDef(TreeList.FocusedNode.Strings[3], -1);
  Case StrToIntDef(TreeList.FocusedNode.Strings[4], -1) of
    CATEGORY : fType := mgtCategory;
    SUBCATEG : fType := mgtGroup;
    GROUP    : fType := mgtSubGroup;
  0, -1: Exit;
  end;

  with TFrmMarginTableApply.Create(Self) do
     if Start(iID, fType) then
        RefreshBrowser;

end;

procedure TFrmMarginTable.GetGroupValue(var SaleCatValue, SaleGroValue, SaleSubValue,
    MSRPCatValue, MSRPGroValue, MSRPSubValue : String);
begin

  //Sale
  if quBrowseUseSalePricePercent.Value then
   SaleCatValue := quBrowseSalePriceMargemPercent.AsString + '%'
  else
   SaleCatValue := GetMargemTableName(quBrowseIDSalePriceMargemTable.AsInteger);

  if quBrowseMGUseSalePricePercent.Value then
   SaleGroValue := quBrowseMGSalePriceMargemPercent.AsString + '%'
  else
   SaleGroValue := GetMargemTableName(quBrowseMGIDSalePriceMargemTable.AsInteger);

  if quBrowseMSGUseSalePricePercent.Value then
   SaleSubValue := quBrowseMSGSalePriceMargemPercent.AsString + '%'
  else
   SaleSubValue := GetMargemTableName(quBrowseMSGIDSalePriceMargemTable.AsInteger);

  //MSRP
  if quBrowseUseMSRPPercent.Value then
   MSRPCatValue := quBrowseMSRPMargemPercent.AsString + '%'
  else
   MSRPCatValue := GetMargemTableName(quBrowseIDMSRPMargemTable.AsInteger);

  if quBrowseMGUseMSRPPercent.Value then
   MSRPGroValue := quBrowseMGMSRPMargemPercent.AsString + '%'
  else
   MSRPGroValue := GetMargemTableName(quBrowseMGIDMSRPMargemTable.AsInteger);

  if quBrowseMSGUseMSRPPercent.Value then
   MSRPSubValue := quBrowseMSGMSRPMargemPercent.AsString + '%'
  else
   MSRPSubValue := GetMargemTableName(quBrowseMSGIDMSRPMargemTable.AsInteger);

end;

procedure TFrmMarginTable.quBrowseAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DisplayMarginTable;
end;

procedure TFrmMarginTable.RecalcAllInventory;
var
  ID: Integer;
begin
  with quBrowse do
  try
    Screen.Cursor := crHourGlass;
    DisableControls;
    Application.ProcessMessages;

    ID := -1;
    First;
    while not Eof do
    begin
      if (quBrowseIDModelSubGroup.AsInteger <> 0) and (ID <> quBrowseIDModelSubGroup.AsInteger) then
      begin
        ID := quBrowseIDModelSubGroup.AsInteger;

        try
          cdsMarginRecalcAll.CreateDataSet;
          cdsMarginRecalcAll.Data := DM.FDMCalcPrice.GetNewSaleMSRPPrices(quBrowseIDModelSubGroup.AsInteger,cptBoth,mgtSubGroup);
          UpdateNewPrices;
          cdsMarginRecalcAll.Close;
        except
          on E: Exception do
          begin
            DM.SetError(CRITICAL_ERROR, Self.Name, 'FrmMarginTable.RecalcAllGroup.Exception' + #13#10 + E.Message);
            MsgBox(E.Message, vbCritical + vbOkOnly);
          end;
        end;

      end;
      Next;
    end;

    ID := -1;
    First;
    while not Eof do
    begin
      if (quBrowseIDModelGroup.AsInteger <> 0) and (ID <> quBrowseIDModelGroup.AsInteger) then
      begin
        ID := quBrowseIDModelGroup.AsInteger;

        try
          cdsMarginRecalcAll.CreateDataSet;
          cdsMarginRecalcAll.Data := DM.FDMCalcPrice.GetNewSaleMSRPPrices(quBrowseIDModelGroup.AsInteger,cptBoth,mgtGroup);
          UpdateNewPrices;
          cdsMarginRecalcAll.Close;
        except
          on E: Exception do
          begin
            DM.SetError(CRITICAL_ERROR, Self.Name, 'FrmMarginTable.RecalcAllGroup.Exception' + #13#10 + E.Message);
            MsgBox(E.Message, vbCritical + vbOkOnly);
          end;
        end;

      end;
      Next;
    end;

    ID := -1;
    First;
    while not Eof do
    begin
      if (ID <> quBrowseIDGroup.AsInteger) then
      begin
        ID := quBrowseIDGroup.AsInteger;

        try
          cdsMarginRecalcAll.CreateDataSet;
          cdsMarginRecalcAll.Data := DM.FDMCalcPrice.GetNewSaleMSRPPrices(quBrowseIDGroup.AsInteger,cptBoth,mgtCategory);
          UpdateNewPrices;
          cdsMarginRecalcAll.Close;
        except
          on E: Exception do
          begin
            DM.SetError(CRITICAL_ERROR, Self.Name, 'FrmMarginTable.RecalcAllGroup.Exception' + #13#10 + E.Message);
            MsgBox(E.Message, vbCritical + vbOkOnly);
          end;
        end;
      end;
      Next;
    end;
  finally
    Screen.Cursor := crDefault;
    MsgBox(MSG_INF_ADJUSTMENT, vbOkOnly);
    EnableControls;
  end;
end;

procedure TFrmMarginTable.btRecalcAllGroupClick(Sender: TObject);
begin

  if MsgBox(MSG_QST_CONFIRM, vbYesNo + vbSuperCritical) = vbYes then
    RecalcAllInventory;
    
end;

procedure TFrmMarginTable.UpdateNewPrices;
var
  ModelService: TMRModelService;
  Model: TModel;
begin
  try
    ModelService                  := TMRModelService.Create();
    Model                         := TModel.Create();

    ModelService.SQLConnection := DM.ADODBConnect;

    with cdsMarginRecalcAll do
    if not IsEmpty then
    try
      Filter := 'IsUpdate = 1';
      Filtered := True;
      First;
      while not Eof do
      begin
        //Model
        Model.IDModel                      := FieldByName('IDModel').AsInteger;
        Model.Model                        := FieldByName('Model').AsString;
        Model.SellingPrice                 := FieldByName('NewSellingPrice').AsCurrency;
        Model.SuggRetail                   := FieldByName('NewMSRPPrice').AsCurrency;
        Model.VendorCost                   := FieldByName('CostPrice').AsCurrency;
        Model.Markup                       := FieldByName('MarkUp').AsFloat;
        Model.IDUserLastSellingPrice       := DM.fUser.ID;
        Model.DateLastCost                 := Now;
        Model.DateLastSellingPrice         := Now;
        //Update
        ModelService.UpdatePrices(Model);

        Next;
      end;
    finally
      Filter := '';
      Filtered := False;
    end;

  finally
    FreeAndNil(Model);
    FreeAndNil(ModelService);
    Close;
   end;
end;

end.
