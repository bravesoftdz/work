(*
Version : (292 - 293)
Date    : 06.06.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : avoid decrease when parameter ( new parameter ) is set to true.
Solution: set up correct mask to display format properfield object.
Version : (293 - 294)
-----------------------------------------------------------------------------------------------------
*)

unit uFrmMarginTableUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, Buttons, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DBClient, ADODB, uDMCalcPrice;

type
  TFrmMarginTableUpdate = class(TFrmParent)
    dsMarginTableUpdate: TDataSource;
    grdMarginTableUpDBTableView1: TcxGridDBTableView;
    grdMarginTableUpLevel1: TcxGridLevel;
    grdMarginTableUp: TcxGrid;
    btSave: TButton;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cmdUpdateModel: TADOCommand;
    pnlDivisoria2: TPanel;
    btnColumns: TBitBtn;
    cdsMarginTableUpdate: TClientDataSet;
    cdsMarginTableUpdateIsUpdate: TBooleanField;
    cdsMarginTableUpdateModel: TStringField;
    cdsMarginTableUpdateDescription: TStringField;
    cdsMarginTableUpdateIDModel: TIntegerField;
    cdsMarginTableUpdateCostPrice: TBCDField;
    cdsMarginTableUpdateNewSellingPrice: TBCDField;
    cdsMarginTableUpdateNewMSRPPrice: TBCDField;
    cdsMarginTableUpdateSalePrice: TBCDField;
    cdsMarginTableUpdateMSRP: TBCDField;
    cdsMarginTableUpdateRealMarkUpValue: TBCDField;
    cdsMarginTableUpdateRealMarkUpPercent: TBCDField;
    cdsMarginTableUpdateMarginPercent: TBCDField;
    cdsMarginTableUpdateMarginValue: TBCDField;
    cdsMarginTableUpdateCategory: TStringField;
    cdsMarginTableUpdateSubCategory: TStringField;
    cdsMarginTableUpdateModelGroup: TStringField;
    grdMarginTableUpDBTableView1IsUpdate: TcxGridDBColumn;
    grdMarginTableUpDBTableView1Model: TcxGridDBColumn;
    grdMarginTableUpDBTableView1Description: TcxGridDBColumn;
    grdMarginTableUpDBTableView1CostPrice: TcxGridDBColumn;
    grdMarginTableUpDBTableView1NewSellingPrice: TcxGridDBColumn;
    grdMarginTableUpDBTableView1NewMSRPPrice: TcxGridDBColumn;
    grdMarginTableUpDBTableView1SalePrice: TcxGridDBColumn;
    grdMarginTableUpDBTableView1MSRP: TcxGridDBColumn;
    grdMarginTableUpDBTableView1RealMarkUpValue: TcxGridDBColumn;
    grdMarginTableUpDBTableView1RealMarkUpPercent: TcxGridDBColumn;
    grdMarginTableUpDBTableView1MarginPercent: TcxGridDBColumn;
    grdMarginTableUpDBTableView1MarginValue: TcxGridDBColumn;
    grdMarginTableUpDBTableView1Category: TcxGridDBColumn;
    grdMarginTableUpDBTableView1SubCategory: TcxGridDBColumn;
    grdMarginTableUpDBTableView1ModelGroup: TcxGridDBColumn;
    cdsMarginTableUpdateMarkUp: TBCDField;
    grdMarginTableUpDBTableView1MarkUp: TcxGridDBColumn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnColumnsClick(Sender: TObject);
  private
    AView  : TcxCustomGridTableView;
    procedure UpdateNewPrices;
    procedure CheckAll(Value :Boolean);
  public
    function Start(ID: Integer; FCalcPriceType : TCalcPriceType; fType: TModelGroupingType):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uSystemConst; 

{$R *.dfm}

{ TFrmMarginTableUpdate }

procedure TFrmMarginTableUpdate.CheckAll(Value: Boolean);
begin
  with cdsMarginTableUpdate do
   try
     DisableControls;
     dsMarginTableUpdate.DataSet := nil;
     First;
     while not Eof DO
     begin
       Edit;
       FieldByName('IsUpdate').Value := Value;
       Post;
       Next;
     end;
   finally
    EnableControls;
    dsMarginTableUpdate.DataSet := cdsMarginTableUpdate;
   end;
end;

function TFrmMarginTableUpdate.Start(ID: Integer;
  FCalcPriceType: TCalcPriceType; fType: TModelGroupingType): Boolean;
var
  AOptions : TcxGridStorageOptions;
  ASaveViewName : String;
  fRegistryPath : String;
begin
  self.Cursor := crHourGlass;
  cdsMarginTableUpdate.Data := DM.FDMCalcPrice.GetNewSaleMSRPPrices(ID,FCalcPriceType,fType);
  self.Cursor := crDefault;
  fRegistryPath := MR_BRW_REG_PATH + Self.Caption;
  AOptions := [gsoUseFilter, gsoUseSummary];

  DM.LoadGridFromRegistry(TcxGridDBTableView(AView), fRegistryPath, AOptions);

  ShowModal;

  if ModalResult = mrOk then
    UpdateNewPrices;

  DM.SaveGridToRegistry(TcxGridDBTableView(AView), fRegistryPath, True, AOptions);
end;

procedure TFrmMarginTableUpdate.UpdateNewPrices;
var
   saveSellingPrice: currency;
begin
   with cdsMarginTableUpdate do
   try
     DisableControls;
     First;
     while not Eof do
     begin
       if cdsMarginTableUpdate.FieldByName('IsUpdate').AsBoolean then
       begin
         cmdUpdateModel.Parameters.ParamByName('IDModel').Value := FieldByName('IDModel').AsInteger;
         cmdUpdateModel.Parameters.ParamByName('DateLastSellingPrice').Value   := Null;
         cmdUpdateModel.Parameters.ParamByName('IDUserLastSellingPrice').Value := Null;

         (*
         if FieldByName('NewSellingPrice').AsCurrency <> FieldByName('SalePrice').AsCurrency then
         begin
           cmdUpdateModel.Parameters.ParamByName('DateLastSellingPrice').Value := Now;
           cmdUpdateModel.Parameters.ParamByName('IDUserLastSellingPrice').Value := DM.fUser.ID;
         end;
          *)
         //amfsouza 02.04.2011
         if ( FieldByName('NewSellingPrice').AsCurrency < FieldByName('SalePrice').AsCurrency ) then begin
              if ( Dm.FDMCalcPrice.IncreasePriceOnly ) then begin
                 if  ( FieldByName('NewSellingPrice').AsCurrency < FieldByName('SalePrice').AsCurrency ) then begin
                     Next;
                     Continue;
                 end;
              end;
         end;

         cmdUpdateModel.Parameters.ParamByName('NewSellingPrice').Value := FieldByName('NewSellingPrice').AsCurrency;
         cmdUpdateModel.Parameters.ParamByName('NewMSRPPrice').Value := FieldByName('NewMSRPPrice').AsCurrency;
         cmdUpdateModel.Execute;
       end;
       Next;
     end;
   finally
    EnableControls;
   end;
end;

procedure TFrmMarginTableUpdate.BitBtn1Click(Sender: TObject);
begin
  CheckAll(True);
end;

procedure TFrmMarginTableUpdate.BitBtn2Click(Sender: TObject);
begin
  CheckAll(False);
end;

procedure TFrmMarginTableUpdate.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmMarginTableUpdate.FormCreate(Sender: TObject);
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_COLUMN, btnColumns.Glyph);
  AView := TcxCustomGridTableView(grdMarginTableUp.FocusedView);
end;

procedure TFrmMarginTableUpdate.btnColumnsClick(Sender: TObject);
begin
  inherited;
  TcxGridDBTableView(AView).Controller.Customization := not (TcxGridDBTableView(AView).Controller.Customization);
end;

end.
