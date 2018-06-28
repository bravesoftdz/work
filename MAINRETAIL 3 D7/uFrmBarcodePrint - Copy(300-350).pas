(*
-----------------------------------------------------------------------------------------------------
Version : (297 - 314)
Date    : 10.31.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Print barcode from Inventory Maintenance
Version : (297 - 315)
-----------------------------------------------------------------------------------------------------
Version : (296 - 307)
Date    : 09.13.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : mult-part issues from purchase screen
Solution: specific SQL changes related to Inventory Table.
Version : (296 - 308)
-----------------------------------------------------------------------------------------------------
Version : (291 - 289)
Date    : 02.23.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : To fix bugs about new implementation.
Solution: Implemented according to list of issues reviewed.
Version : (292 - 290)
-----------------------------------------------------------------------------------------------------

Version : (288 - 282)
Date    : 02.23.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Is not a issue. It's a new implementation.
Solution: - Customized columns
Version : (288 - 283)
-----------------------------------------------------------------------------------------------------

Version : (288 - 282)
Date    : 02.22.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Improvements on search to tab print quewe ( same to promotions )
Solution: Implemented according to requests.
Version : (288 - 283)
-----------------------------------------------------------------------------------------------------

Version : (288 - 279)
Date    : 01.17.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : ( implementation ) Put barcode search interface like purchase
Solution: Implemented according to requests.
Version : (288 - 280)
-----------------------------------------------------------------------------------------------------
*)


unit uFrmBarcodePrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, Db, ADODB, Mask,
  SuperComboADO, ppComm, ppRelatv, ppProd, ppClass, ppReport, ppDB,
  ppDBPipe, ppBands, ppPrnabl, ppCtrls, ppBarCod, ppCache, ppEndUsr, ppViewr,
  daDataView, daQueryDataView, daADO, ppModule, daDataModule, ComCtrls,
  Grids, DBGrids, SMDBGrid, EanRB, EanRBDB, raCodMod, DBClient, Provider,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  DateBox, mrBarCodeEdit, uOperationSystem, PowerADOQuery, LookUpADOQuery,
  ppParameter;

type
  TSearchBarCode = (sbBarcode, sbModel, sbVendor);

  TFrmBarcodePrint = class(TFrmParentAll)
    dsBarcCode: TDataSource;
    ppReport: TppReport;
    ppDBPipeline: TppDBPipeline;
    dsBarcodePrint: TDataSource;
    ppDesigner: TppDesigner;
    btnPrint: TBitBtn;
    btnEdit: TBitBtn;
    OD: TOpenDialog;
    pnlSetup: TPanel;
    lbReport1: TLabel;
    edtReportFile: TEdit;
    btnOpenFile: TSpeedButton;
    btRemove: TSpeedButton;
    lbSetup: TLabel;
    Bevel1: TBevel;
    dspBarcode: TDataSetProvider;
    cdsBarcode: TClientDataSet;
    cdsBarcodeList: TClientDataSet;
    dsBarcodeList: TDataSource;
    lbReport2: TLabel;
    edtReportFile2: TEdit;
    btnOpenFile2: TSpeedButton;
    btRemove2: TSpeedButton;
    quQueue: TADODataSet;
    quBarcodePrint: TADODataSet;
    quBarCode: TADODataSet;
    edtSkipRep1: TEdit;
    dspBarcodePrint: TDataSetProvider;
    cdsBarcodePrint: TClientDataSet;
    lbSkipRep1: TLabel;
    lbSkipRep2: TLabel;
    edtSkipRep2: TEdit;
    UpDownRep1: TUpDown;
    UpDown1: TUpDown;
    lbBarcodePrinter: TLabel;
    cbxBarcodePrinter: TComboBox;
    ScaleValidDay: TppField;
    ValidDate: TppField;
    quModelFeature: TADODataSet;
    dsModelFeature: TDataSource;
    quModelFeatureIDInvFeatures: TIntegerField;
    quModelFeatureFeature: TStringField;
    ppModelFeature: TppDBPipeline;
    dspBarcodeList: TDataSetProvider;
    quBarcodeList: TADODataSet;
    pgFilter: TPageControl;
    tsMultiple: TTabSheet;
    Label5: TLabel;
    Panel18: TPanel;
    Label4: TLabel;
    lbModelGroup: TLabel;
    lbModelSubGroup: TLabel;
    cmbCategory: TSuperComboADO;
    btClearCatego: TButton;
    cbxMethod: TComboBox;
    edModel: TEdit;
    btAllModel: TButton;
    btClearSubCatego: TButton;
    btClearGroup: TButton;
    scModelGroup: TSuperComboADO;
    scModelSubGroup: TSuperComboADO;
    cbxType: TComboBox;
    Panel27: TPanel;
    btnRefresh: TSpeedButton;
    tsDate: TTabSheet;
    Label2: TLabel;
    Panel10: TPanel;
    lbFrom: TLabel;
    lbTo: TLabel;
    dtStart: TDateBox;
    dtEnd: TDateBox;
    Panel28: TPanel;
    btnRefreshLastUpdate: TSpeedButton;
    tsBarcodeQueue: TTabSheet;
    Panel7: TPanel;
    lblSearchType: TLabel;
    lblVendor: TLabel;
    cbxSearchType: TComboBox;
    scVendor: TSuperComboADO;
    edtSearch: TEdit;
    Panel2: TPanel;
    Label6: TLabel;
    Panel4: TPanel;
    Panel14: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    btnClearList: TBitBtn;
    grdBarcodeByList: TcxGrid;
    grdBarcodeByListDB: TcxGridDBTableView;
    cxGridDBColumn21: TcxGridDBColumn;
    cxGridDBColumn22: TcxGridDBColumn;
    cxGridDBColumn23: TcxGridDBColumn;
    cxGridDBColumn24: TcxGridDBColumn;
    cxGridDBColumn25: TcxGridDBColumn;
    cxGridDBColumn26: TcxGridDBColumn;
    cxGridDBColumn27: TcxGridDBColumn;
    cxGridDBColumn28: TcxGridDBColumn;
    cxGridDBColumn29: TcxGridDBColumn;
    cxGridDBColumn30: TcxGridDBColumn;
    grdBarcodeByListGridLevel: TcxGridLevel;
    Panel8: TPanel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    btDel: TBitBtn;
    btDelAll: TBitBtn;
    grdBarcode: TcxGrid;
    grdBarcodeDB: TcxGridDBTableView;
    grdBarcodeDBData: TcxGridDBColumn;
    grdBarcodeDBIDBarcode: TcxGridDBColumn;
    grdBarcodeDBModel: TcxGridDBColumn;
    grdBarcodeDBCategory: TcxGridDBColumn;
    grdBarcodeDBDBQtyOnHand: TcxGridDBColumn;
    grdBarcodeDBDescription: TcxGridDBColumn;
    grdBarcodeDBSellingPrice: TcxGridDBColumn;
    grdBarcodeDBDBColumn1: TcxGridDBColumn;
    grdBarcodeDBNumCopy: TcxGridDBColumn;
    grdBarcodeDBDBSubcategory: TcxGridDBColumn;
    grdBarcodeDBDBGroup: TcxGridDBColumn;
    grdBarcodeLevel: TcxGridLevel;
    Panel6: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn8: TBitBtn;
    grdBarcodeLastUpdate: TcxGrid;
    grdBarcodeLastUpdateDB: TcxGridDBTableView;
    cxGridDBColumn11: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridDBColumn15: TcxGridDBColumn;
    cxGridDBColumn16: TcxGridDBColumn;
    cxGridDBColumn17: TcxGridDBColumn;
    cxGridDBColumn18: TcxGridDBColumn;
    cxGridDBColumn19: TcxGridDBColumn;
    cxGridDBColumn20: TcxGridDBColumn;
    grdBarcodeLastUpdateLevel: TcxGridLevel;
    grdBarcodeDBDBColumn2: TcxGridDBColumn;
    quLookUpGroup: TLookUpADOQuery;
    quLookUpGroupIDGroup: TIntegerField;
    quLookUpGroupName: TStringField;
    quLookUpGroupPathName: TStringField;
    quLookUpGroupUserCode: TStringField;
    dsLookUpGroup: TDataSource;
    Panel5: TPanel;
    chkSendToPrinter: TCheckBox;
    chkInventoryCopy: TCheckBox;
    chkSaveQueue: TCheckBox;
    chkPrimaryUpc: TCheckBox;
    grdBarcodeByListDBDBColumn1: TcxGridDBColumn;
    grdBarcodeDBDBColumn3: TcxGridDBColumn;
    ppParameterList1: TppParameterList;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    RBDBEan: TRBDBEan;
    ppDBText4: TppDBText;
    ppDBText1: TppDBText;
    ppColumnFooterBand1: TppColumnFooterBand;
    raCodeModule1: TraCodeModule;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    quBarcodePrintIDModel: TIntegerField;
    quBarcodePrintModel: TStringField;
    quBarcodePrintDescription: TStringField;
    quBarcodePrintSuggRetail: TBCDField;
    quBarcodePrintSizeName: TStringField;
    quBarcodePrintCodSize: TStringField;
    quBarcodePrintColor: TStringField;
    quBarcodePrintCodColor: TStringField;
    quBarcodePrintCategory: TStringField;
    quBarcodePrintSubCategory: TStringField;
    quBarcodePrintGroup: TStringField;
    quBarcodePrintBarcode: TStringField;
    quBarcodePrintPromotionPrice: TBCDField;
    quBarcodePrintDiscountPerc: TFloatField;
    quBarcodePrintVendorCost: TBCDField;
    quBarcodePrintAvgCost: TBCDField;
    quBarcodePrintSellingPrice: TBCDField;
    quBarcodePrintLargeImage: TStringField;
    quBarcodePrintLargeImage2: TStringField;
    quBarcodePrintScaleValidDay: TIntegerField;
    quBarcodePrintPrice: TBCDField;
    quBarcodePrintStoreSellPrice: TBCDField;
    quBarcodePrintStoreCostPrice: TBCDField;
    quBarcodePrintStoreAvgPrice: TBCDField;
    quBarcodePrintIDVendor: TIntegerField;
    quBarcodePrintVendorNum: TStringField;
    quBarcodePrintVendor: TStringField;
    quBarcodePrintManufacture: TStringField;
    quBarcodePrintValidDate: TDateTimeField;
    quBarcodePrintIdBarcode: TStringField;
    quBarcodeListIDModel: TIntegerField;
    quBarcodeListModel: TStringField;
    quBarcodeListCategory: TStringField;
    quBarcodeListSubcategory: TStringField;
    quBarcodeListmsgGroup: TStringField;
    quBarcodeListDescription: TStringField;
    quBarcodeListDateLastSellingPrice: TDateTimeField;
    quBarcodeListStoreAVGPrice: TBCDField;
    quBarcodeListSellingPrice: TBCDField;
    quBarcodeListQtyOnHand: TBCDField;
    quBarcodeListIdbarcode: TStringField;
    quBarcodeListdata: TDateTimeField;
    quBarcodeListNumCopy: TBCDField;
    quBarcodeListReport: TStringField;
    cdsBarcodeListIDModel: TIntegerField;
    cdsBarcodeListModel: TStringField;
    cdsBarcodeListCategory: TStringField;
    cdsBarcodeListSubcategory: TStringField;
    cdsBarcodeListmsgGroup: TStringField;
    cdsBarcodeListDescription: TStringField;
    cdsBarcodeListDateLastSellingPrice: TDateTimeField;
    cdsBarcodeListStoreAVGPrice: TBCDField;
    cdsBarcodeListSellingPrice: TBCDField;
    cdsBarcodeListQtyOnHand: TBCDField;
    cdsBarcodeListIdbarcode: TStringField;
    cdsBarcodeListdata: TDateTimeField;
    cdsBarcodeListNumCopy: TBCDField;
    cdsBarcodeListReport: TStringField;
    Bevel8: TBevel;
    btColumn: TSpeedButton;
    btColumn2: TSpeedButton;
    Bevel9: TBevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsBarcCodeDataChange(Sender: TObject; Field: TField);
    procedure btAddClick(Sender: TObject);
    procedure btDelClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure ppReportPreviewFormCreate(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btAllModelClick(Sender: TObject);
    procedure btClearCategoClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btDelAllClick(Sender: TObject);
    procedure btRemove2Click(Sender: TObject);
    procedure btnOpenFile2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btAddAllClick(Sender: TObject);
    procedure btnClearListClick(Sender: TObject);
    procedure pgFilterChange(Sender: TObject);
    procedure dsBarcodeListDataChange(Sender: TObject; Field: TField);
    procedure btClearSubCategoClick(Sender: TObject);
    procedure btClearGroupClick(Sender: TObject);
    procedure edtSkipRep1KeyPress(Sender: TObject; var Key: Char);
    procedure cbxBarcodePrinterChange(Sender: TObject);
    procedure grdBarcodeDBKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsBarcodePrintAfterOpen(DataSet: TDataSet);
    procedure cdsBarcodePrintBeforeClose(DataSet: TDataSet);
    procedure edtBarcodeAfterSearchBarcode(Sender: TObject);
    procedure edtBarcodeExit(Sender: TObject);
    procedure cbxSearchTypeCloseUp(Sender: TObject);
    procedure cbxSearchTypeChange(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edtSearchExit(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure btColumnClick(Sender: TObject);
    procedure pgFilterChanging(Sender: TObject; var AllowChange: Boolean);
    procedure grdBarcodeDBDBColumn1PropertiesCloseUp(Sender: TObject);
    procedure chkSendToPrinterClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure cdsBarcodeAfterOpen(DataSet: TDataSet);
    procedure chkInventoryCopyClick(Sender: TObject);
    procedure ppDetailBand1BeforePrint(Sender: TObject);
    procedure cdsBarcodeListAfterOpen(DataSet: TDataSet);
    procedure quBarcodePrintAfterOpen(DataSet: TDataSet);
    procedure cdsBarcodeListAfterInsert(DataSet: TDataSet);
    procedure cdsBarcodeListAfterEdit(DataSet: TDataSet);
    procedure grdBarcodeDBDblClick(Sender: TObject);
  private
    FIsOutFromPrint: Boolean;
    FBarcode: String;
    FIDPurchaseStr: String;
    AView: TCxCustomGridTableView;
    qrySearch: TADODataSet;
    fIDModel : Integer;
    fReportFile,
    fReportFile2,
    fBarcodePrinter,
    fNCopiesField : String;

    bSavePrinter : Boolean;


    function getSQL(HasPurchase: boolean): String;
    function ValidateSearch: boolean;
    function hasSearch(idUser: integer): boolean;
    function fillBarcode: boolean;
    function fillBarcodeQueue: boolean;
    //amfsouza 04.07.2011
    function deleteSavePrintQueue(IdBarcode: String; IdUser: integer): boolean;

    //amfsouza 04.04.2011 - due new implementation.
    function ValidatePrintQueue(Iduser: integer; IdBarcode: String): boolean;
    function DirectToPrint(bScreen: boolean): boolean;
    //amfsouza 01.17.2011 - putting same interface found in purchase to print barcode queue.
    function MountOpenQueue(searchBy: TSearchBarCode; emptyList: boolean = false; numberCopy: double = 1): String;

    //amfsouza 05.02.2012 - correct SQL to print queue.
    procedure setToPrintQueue;
    procedure ShowColumn(AView : TcxCustomGridTableView; pCustomize : Boolean);
    procedure BarcodeOpen;
    procedure BarcodeClose;
    procedure BarcodeRefresh;
    procedure AddBarcode(Barcode, Description, Model: String; Qty: Integer;
      SellingPrice: Currency; IdModel: Integer = 0; QtyOnHand: double = 0.0;
      StorePrice: Currency = 0.0);
    procedure AddAllBarcode;

    procedure PrintReport(Report : Integer; bScreen : Boolean);

    procedure BarcodeQueueOpen;
    procedure BarcodeQueueClose;
    procedure BarcodeQueueRefresh;

    procedure CreateTempTable;
    procedure DropTempTaple;
    procedure DeleteTempTable;
    procedure InsertTempTable(Report:Integer);

    procedure SaveReportFile(Report:String);
    procedure SaveReportFile2(Report:String);
    procedure SortReportOrder(gridReport: TcxGridDBTableView);

    function ReturnSQL(sSelect, sJoin, sWhere : String; emptyList:boolean = false; NumberCopy: extended = 1):String;
    function sendStraightToPrinter(var qtyVerified: boolean; queue: TADODataset; toPrinter, printLabel: boolean; qtyFormula: extended = 0): boolean;
  public
    property ReportFile : String  Read fReportFile  Write SaveReportFile;
    property ReportFile2 : String Read fReportFile2 Write SaveReportFile2;

    function Start(IDModel, Barcode : String):Boolean;
    function StartPurchase(IDPurchase:String):Boolean;
    function StartTransfer(IDTransfer:String):Boolean;
    function PrintBarcode(ABarcode : String; AQty: Integer):Boolean;


    function RemoveNegativeValuesAndTrunc(aValue: Variant): Integer; //YAA March, 2012 --> Added

  end;

implementation

uses uDM, uCharFunctions, uMsgBox, uMsgConstant, Registry, uSqlFunctions,
     uDMGlobal, uSystemConst, DateUtils, Variants, ppTypes, Printers, Math,
     UpdateNumCopyBarcode, cxGridDBDataDefinitions, ufrmPurchaseBarcodeMessage;

{$R *.DFM}

procedure TFrmBarcodePrint.AddAllBarcode;
var
   foundBarcode: boolean;
   qtyVerified:  boolean;
   msgWarning: String;
begin

  with dsBarcCode.DataSet do
     begin
     First;
     DisableControls;

     if ( pgFilter.ActivePageIndex < 2 ) then begin
        FoundBarcode := ( not cdsBarcode.IsEmpty );
        //amfsouza 04.03.2011: send straight to printer.
        if ( FoundBarcode ) then begin
          if ( not sendStraightToPrinter(qtyVerified, quBarcode, chkSendToPrinter.Checked, chkInventoryCopy.Checked) ) then begin
              if ( cdsBarcode.RecordCount > 100 ) then begin
                 msgWarning := 'You are about to add ' + intToStr(cdsBarcode.RecordCount) + ' models. Do you wish to continue ?';
                 if ( Application.MessageBox(Pchar(msgWarning), 'Warning', mb_YESNO + mb_IconWarning) = idYes ) then
                    grdBarcodeDb.DataController.DataSource := dsBarcodeList
                 else
                    exit;
              end
              else
                 grdBarcodeDb.DataController.DataSource := dsBarcodeList;
          end
          else
              exit;
        end;
     end
     else
        exit;

     dsBarcodeList.DataSet.DisableControls;
     While not EOF do
        begin
        AddBarcode(FieldByName('IDBarcode').AsString,
                   FieldByName('Description').AsString,
                   FieldByName('Model').AsString,
                   FieldByName(fNCopiesField).AsInteger,
                   FieldByName('SellingPrice').AsCurrency,
                   FieldByName('IdModel').AsInteger,
                   FieldByName('QtyOnHand').asFloat,
                   FieldByName('StoreAvgPrice').asCurrency);
        Next;
        end;
     EnableControls;
     dsBarcodeList.DataSet.EnableControls;
     end;
end;

procedure TFrmBarcodePrint.SaveReportFile(Report:String);
var
   buildInfo: String;
begin

  with TRegistry.Create do
  begin
    if ( getOs(buildInfo) = osW7 ) then
       rootkey := HKEY_CURRENT_USER
    else
       RootKey := HKEY_LOCAL_MACHINE;
       
    OpenKey(REGISTRY_PATH, True);
    WriteString('BarcodeReport', Report);
    Free;
  end;

  fReportFile        := Report;
  edtReportFile.Text := Report;
end;

procedure TFrmBarcodePrint.InsertTempTable(Report:Integer);
var
 Sql : String;
 i, j : Integer;
begin

  if (not cdsBarcodeList.Active) or
    (cdsBarcodeList.RecordCount = 0) then
     begin
       MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOKOnly);
       Exit;
     end;


//   with cdsBarcodeList do
   try
     cdsBarcodeList.DisableControls;
     cdsBarcodeList.Filtered := False;
     case Report of
       1 : cdsBarcodeList.Filter := 'Report = ' + QuotedStr('Label 1');
       2 : cdsBarcodeList.Filter := 'Report = ' + QuotedStr('Label 2');
     end;
     cdsBarcodeList.Filtered := True;
     cdsBarcodeList.First;
     j := 1;
     while not cdsBarcodeList.EOF do
       begin
         for i := 1 to grdBarcodeDBNumCopy.Databinding.Field.AsInteger do    //cdsBarcodeList.FieldByName('NumCopy').AsInteger do
         begin
           SQL := 'INSERT #Temp_Barcode VALUES ('+IntToStr(j)+','+QuotedStr(cdsBarcodeList.FieldByName('IdBarcode').AsString)+')';
           DM.RunSQL(SQL);
         end;
         inc(j);
         cdsBarcodeList.Next;
       end;
   finally
     cdsBarcodeList.Filter   := '';
     cdsBarcodeList.Filtered := False;
     cdsBarcodeList.EnableControls;
   end;

end;

procedure TFrmBarcodePrint.DeleteTempTable;
begin
  DM.RunSQL('DELETE #Temp_Barcode');
end;

procedure TFrmBarcodePrint.CreateTempTable;
begin
  DM.RunSQL('CREATE TABLE #Temp_Barcode (IDBarcode int NOT NULL, Barcode varchar (100)COLLATE SQL_Latin1_General_CP1_CI_AS)');
end;

procedure TFrmBarcodePrint.DropTempTaple;
begin
  DM.RunSQL('DROP TABLE #Temp_Barcode');
end;

procedure TFrmBarcodePrint.BarcodeClose;
begin
  with cdsBarcode do
    if Active then
       Close;
end;

procedure TFrmBarcodePrint.BarcodeRefresh;
var
  sSql, sLike, sSelect, sJoin, sWhere, sCampo: String;
  onlyItem: String;
  FoundBarcode: boolean;
  msgWarning: string;
  qtyFormula: extended;
  qtyVerified:  boolean;
begin
  Screen.Cursor := crHourGlass;

  BarcodeClose;
  BarcodeQueueClose;

  sJoin  := '';
  sWhere := '';
  sLike  := '';

  // amfsouza 03.15.2012 clean if purchase was called previously.
  FIDPurchaseStr := '';

  fNCopiesField := 'NumCopy';

  case pgFilter.ActivePageIndex of
      0 :
      begin
          dsBarcCode.DataSet := cdsBarcode;

          if fIDModel <> 0 then
            sWhere := 'WHERE M.IDModel = ' + IntToStr(fIDModel) + ' AND M.Desativado = 0'
          else
          begin
            sWhere := 'WHERE M.Desativado = 0';

            if cmbCategory.LookUpValue <> '' then
               sWhere := sWhere + ' AND M.GroupID = ' + cmbCategory.LookUpValue;

            if scModelGroup.LookUpValue <> '' then
               sWhere := sWhere + ' AND M.IDModelGroup = ' + scModelGroup.LookUpValue;

            if scModelSubGroup.LookUpValue <> '' then
               sWhere := sWhere + ' AND M.IDModelSubGroup = ' + scModelSubGroup.LookUpValue;

            if edModel.Text = '' then
              sLike := ''
            else
            begin

              sCampo := '';

              Case cbxType.ItemIndex of
                 0 : sCampo := 'M.Model %S ';
                 1 : sCampo := 'M.Description %S ';
                 2 : sCampo := 'BA.IDBarcode %S ';
               end;

              if sCampo <> '' then
                Case cbxMethod.ItemIndex of
                  0 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr(edModel.Text+'%')]);
                  1 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edModel.Text)]);
                  2 : sWhere := sWhere + ' AND ' + Format(sCampo, [' like ' + QuotedStr('%'+edModel.Text+'%')]);
                end;

            end;

          end;

          if chkPrimaryUpc.Checked then
            sWhere := sWhere + ' AND BA.BarcodeOrder = 1';

          (*if chkInventoryCopy.Checked then   //YAA
          begin
            fNCopiesField := 'QtyOnHand';
            //amfsouza 09.19.2011 - StoreAvgPrice
            sSelect := ' StoreAVGPrice, (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, I.QtyOnHand '; //YAA --> (c)sSelect := ', StoreAVGPrice, (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, I.QtyOnHand ';
            sJoin  := ' LEFT JOIN Inventory I ON (I.ModelID = BA.IDModel) ';
            sWhere := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';
          end
          else begin
           //amfsouza 09.19.2011 - StoreAvgPrice
           sSelect := ' StoreAvgPrice, M.SellingPrice, IsNull(I.QtyOnHand,0) as QtyOnHand '; //YAA --> sSelect := ', StoreAvgPrice, M.SellingPrice, IsNull(I.QtyOnHand,0) as QtyOnHand ';
           sJoin := ' LEFT JOIN Inventory I ON (M.Idmodel = I.ModelID) ';
           sWhere := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';
           end; *)

           //*** YAA --> Added ***
        if chkInventoryCopy.Checked then
        begin
          fNCopiesField := 'QtyOnHand';
          sSelect := '  (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, (select QtyOnHand from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as QtyOnHand,'+ //YAA !!!' as QtyOnHand,'+
                     '(select StoreAVGPrice from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as StoreAVGPrice'; //YAA !!!' as StoreAVGPrice';

          //sSelect := ', StoreAVGPrice, (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, I.QtyOnHand ';
          sJoin   := 'LEFT JOIN Inventory I ON (I.ModelID = BA.IDModel) '; //YAA This was removed. I put it back //sJoin   := 'LEFT JOIN Inventory I ON (I.ModelID = BA.IDModel) ';
          sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);//YAA This was removed. I put it back // + ' AND IsNull(I.QtyOnHand,0) > 0'; //sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';
        end
        else begin
          sSelect := '  (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, (select QtyOnHand from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as QtyOnHand,'+//YAA !!! ' as QtyOnHand,'+
                     '(select StoreAVGPrice from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as StoreAVGPrice ';//YAA !!!' as StoreAVGPrice';

          //sSelect := ', StoreAVGPrice , M.SellingPrice, IsNull(I.QtyOnHand,0) as QtyOnHand ';
          sJoin := ' LEFT JOIN Inventory I ON (M.Idmodel = I.ModelID) '; //YAA This was removed. I put it back //sJoin := ' LEFT JOIN Inventory I ON (M.Idmodel = I.ModelID) ';
          sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID); //YAA This was removed. I put it back // + ' AND IsNull(I.QtyOnHand,0) > 0' //YAA This was removed. I put it back //sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';
        end;
        //*********************

      end;

      1 :
      begin
          dsBarcCode.DataSet := cdsBarcode;
          sWhere := ' WHERE M.DateLastSellingPrice >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtStart.Date)) + ' AND ' +
                    ' M.DateLastSellingPrice <= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', dtEnd.Date+1))+
                    ' AND M.Desativado = 0 and BA.BarcodeOrder = 1';
//(* //*** YAA --> I removed this comment ***
          if chkPrimaryUpc.Checked then
            sWhere := sWhere + ' AND BA.BarcodeOrder = 1';
//*) //**************************************
          if chkInventoryCopy.Checked then
          begin
            fNCopiesField := 'QtyOnHand';
            sSelect := '  (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, (select QtyOnHand from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as QtyOnHand,'+ //YAA --> ' as QtyOnHand,'+
            '(select StoreAVGPrice from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as StoreAVGPrice'; //YAA --> ' as StoreAVGPrice';

            //sSelect := ', StoreAVGPrice, (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, I.QtyOnHand ';
            sJoin   := 'LEFT JOIN Inventory I ON (I.ModelID = BA.IDModel) ';  //YAA --> This was removed. I put it back //sJoin   := 'LEFT JOIN Inventory I ON (I.ModelID = BA.IDModel) ';
            sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID); //YAA --> This was removed. I put it back // + ' AND IsNull(I.QtyOnHand,0) > 0'; //sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';
          end
          else begin
            sSelect := '  (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, (select QtyOnHand from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as QtyOnHand,'+//YAA --> ' as QtyOnHand,'+
            '(select StoreAVGPrice from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as StoreAVGPrice ';//YAA --> ' as StoreAVGPrice';

           //sSelect := ', StoreAVGPrice , M.SellingPrice, IsNull(I.QtyOnHand,0) as QtyOnHand ';
           sJoin := ' LEFT JOIN Inventory I ON (M.Idmodel = I.ModelID) ';    //YAA --> This was removed. I put it back //sJoin := ' LEFT JOIN Inventory I ON (M.Idmodel = I.ModelID) ';
           sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID); //YAA --> This was removed. I put it back // + ' AND IsNull(I.QtyOnHand,0) > 0' //YAA --> This was removed. I put it back //sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';
          end;
      end;

      2 :
      begin
        //amfsouza 05.02.2012
        setToPrintQueue;

        //*** YAA --> Added ***
        if chkInventoryCopy.Checked then
        begin
          fNCopiesField := 'QtyOnHand';
          sSelect := '  M.SellingPrice, (select QtyOnHand from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as QtyOnHand,'+ //YAA !!!' as QtyOnHand,'+
                     '(select StoreAVGPrice from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as StoreAVGPrice'; //YAA !!!' as StoreAVGPrice';

          //sSelect := ', StoreAVGPrice, (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, I.QtyOnHand ';
          sJoin   := 'LEFT JOIN Inventory I ON (I.ModelID = BA.IDModel) '; //YAA This was removed. I put it back //sJoin   := 'LEFT JOIN Inventory I ON (I.ModelID = BA.IDModel) ';
          sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);//YAA This was removed. I put it back // + ' AND IsNull(I.QtyOnHand,0) > 0'; //sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';
        end
        else begin
          sSelect := '  M.SellingPrice, (select QtyOnHand from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as QtyOnHand,'+//YAA !!! ' as QtyOnHand,'+
                     '(select StoreAVGPrice from Inventory I where I.ModelID = M.IDModel and I.StoreID = '+InttoStr(DM.fStore.ID)+ ') as StoreAVGPrice ';//YAA !!!' as StoreAVGPrice';

          //sSelect := ', StoreAVGPrice , M.SellingPrice, IsNull(I.QtyOnHand,0) as QtyOnHand ';
          sJoin := ' LEFT JOIN Inventory I ON (M.Idmodel = I.ModelID) '; //YAA This was removed. I put it back //sJoin := ' LEFT JOIN Inventory I ON (M.Idmodel = I.ModelID) ';
          sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID); //YAA This was removed. I put it back // + ' AND IsNull(I.QtyOnHand,0) > 0' //YAA This was removed. I put it back //sWhere  := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';
        end;
        //*********************

        //YAA April 29, 2012: TODO: BarcodeOrder should not be used on QuickPrint tab ever, and
        // only on the other tabs if display primary barcode (chkPrimaryUpc) only is checked.
        sWhere := sWhere + ' AND BA.BarcodeOrder = 1';
      end;
    end; //end case

  if ( pgFilter.ActivePageIndex < 2 ) then begin
      if ( quBarCode.Active ) then
         quBarCode.Close;

      quBarcode.CommandText      := ReturnSQL(sSelect, sJoin, sWhere);
      cdsBarcodeList.CommandText := ReturnSQL(sSelect, sJoin, sWhere, true);
  end;

  case pgFilter.ActivePageIndex of
    0: begin
      BarcodeOpen;
      cdsBarcodeList.Open;
      grdBarcodeDb.DataController.DataSource := dsBarcodeList;
    end;
    1: begin
      //YAA ??? grdBarcodeDBNumCopy.DataBinding.FieldName := fNCopiesField;
      BarcodeOpen;
      cdsBarcodeList.Open;
      grdBarcodeDb.DataController.DataSource := dsBarcodeList;
    end;

    2:
    begin
      qtyFormula := 1;
      if ( pos('*', edtSearch.Text) > 0 ) then
         qtyFormula:= strToFloat(copy(edtSearch.Text, 1, (pos('*', edtSearch.Text) -1)));

      quQueue.CommandText := MountOpenQueue(TSearchBarcode(cbxSearchType.ItemIndex), false, qtyFormula );
      cdsBarcodeList.CommandText := MountOpenQueue(TSearchBarcode(cbxSearchType.ItemIndex), true);

      //amfsouza 03.03.2011 - get only relevant part to search.
      onlyItem := copy(edtSearch.Text, ( pos('*', edtSearch.Text) + 1 ), length(edtSearch.Text) );

      if ( FIsOutFromPrint ) then begin
         if ( onlyItem = '' ) then begin
            onlyItem := FBarcode;
            cbxSearchType.ItemIndex := 0;
         end;
      end;

      if ( TSearchBarCode(cbxSearchType.ItemIndex) = sbBarCode ) then begin
         quQueue.Parameters.ParamByName('idbarcode').Value := onlyItem;
         cdsBarcodeList.Params.ParamByName('IdBarcode').Value := onlyItem;
      end
      else if ( TSearchBarCode(cbxSearchType.ItemIndex) = sbModel ) then begin
         quQueue.Parameters.ParamByName('model').Value     := onlyItem;
         cdsBarcodeList.Params.ParamByName('model').value  := onlyItem;
      end
      else begin
         quQueue.Parameters.ParamByName('idpessoa').Value     := scVendor.LookUpValue;
         quQueue.Parameters.ParamByName('sku').Value          := onlyItem;
         cdsBarcodeList.Params.ParamByName('idpessoa').Value  := scVendor.LookUpValue;
         cdsBarcodeList.params.paramByName('sku').value       := onlyItem;
      end;


      if ( FIsOutFromPrint ) then begin
         if ( onlyItem = FBarcode ) then begin
            //cbxSearchType.Clear;  //YAA ??? Removed What was the purpose of this?
         end;
      end;

      //grdBarcodeDBNumCopy.DataBinding.FieldName := fNCopiesField; 
      BarcodeQueueOpen;
      cdsBarcodeList.Open;

      FoundBarcode := ( not quQueue.IsEmpty );

      if ( FoundBarcode ) then begin
          if ( not SendStraightToPrinter(qtyVerified, quQueue, chkSendToPrinter.Checked, chkInventoryCopy.Checked, qtyFormula) ) then begin
             if ( not qtyVerified ) then begin
                 if ( qtyFormula > 100 ) then begin
                   msgWarning := 'You are about to add ' + intToStr(cdsBarcodeList.RecordCount) + ' models. Do you wish to continue ?';
                   if ( Application.MessageBox(Pchar(msgWarning), 'Warning', mb_YESNO + mb_IconWarning) = idYes ) then begin
                      fillBarcodeQueue;
                      grdBarcodeDb.DataController.DataSource := dsBarcodeList;
                   end;
                 end;
                 grdBarcodeDb.DataController.DataSource := dsBarcodeList;
                 fillBarcodeQueue;
             end;
          end;
      end;


      if ( quQueue.IsEmpty ) then begin
         if (TSearchBarcode(cbxSearchType.ItemIndex) = sbBarcode ) then begin
            msgWarning := 'Barcode ' + edtSearch.Text + ' is not found';
            Application.MessageBox(PChar(msgWarning), 'Information', mb_OK + mb_IconStop)
         end
         else if ( TSearchBarcode(cbxSearchType.ItemIndex) = sbModel ) then begin
            msgWarning := 'Model ' + edtSearch.Text + ' is not found';
            Application.MessageBox(Pchar(msgWarning), 'Information', mb_OK + mb_IconStop)
         end
         else if ( TsearchBarcode(cbxSearchType.ItemIndex) = sbVendor ) then begin
            msgWarning := 'SKU ' + edtSearch.Text + ' is not found';
            Application.MessageBox(Pchar(msgWarning), 'Information', mb_OK + mb_IconStop);
         end;

         edtSearch.Clear;
         edtSearch.SetFocus;
         screen.Cursor := crDefault;
         exit;
      end;
    end;
  end;

  Screen.Cursor := crDefault;
end;

function TFrmBarcodePrint.ReturnSQL(sSelect, sJoin, sWhere : String; emptyList: boolean = false;
NumberCopy: extended = 1):String;
begin
  Result :=
'SELECT distinct ' +
'	M.IDModel, '+
'	M.Model,    ' +
'	TG.Name as Category, '+
' mg.modelGroup Subcategory, '+
'	msg.modelsubgroup msgGroup,               '+
'	M.Description,                            ' +
'	M.DateLastSellingPrice,                   ' +
'	BA.IDBarcode, '+
'	BA.Data ' ;

 //amfsouza 09.13.2011 - mult-part issues StoreAVGPrice
 if ( FIDPurchaseStr = '' ) then begin
     if ( chkInventoryCopy.Checked ) then
        //(select case sign(I.QtyOnHand) when -1 then 0 else I.QtyOnHand end)
        result := result + ', cast((select case sign(I.QtyOnHand) when -1 then 0 else I.QtyOnHand end) as Decimal) as  NumCopy, I.StoreAVGPrice,  ' //YAA --> Uncommenting this -->  result := result + ', cast(I.QtyOnHand as Decimal) as  NumCopy, I.StoreAVGPrice,  '
     else
        result := result + ',cast('+ FloatToStr(numberCopy) + ' as Decimal) NumCopy, cast ('''' as varchar) Report, '; //YAA (Added) --> cast ('' as varchar) Report, ';
 end
 else begin
     if ( chkInventoryCopy.Checked ) then
        result := result + ',PPI.Qty as  NumCopy, PPI.NewSalePrice, '
     else
        result := result + ',cast('+ FloatToStr(numberCopy) + ' as Decimal) NumCopy, PPI.newSalePrice,  ';
 end;

 result := result +

(* amfsouza 05.05.2011 - must be from sSelect dynamic clause
'	(CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, '+
'	CASE WHEN I.QtyOnHand < 0 THEN 1 ELSE I.QtyOnHand END as QtyOnHand,                                   ' +
*) 
    sSelect +
' FROM ' +//YAA --> 'FROM ' +
'Barcode BA (NOLOCK) ' +
'   LEFT JOIN Inv_BarcodePrint B (NOLOCK) ON (BA.IdBarcode = B.IdBarcode) ' +
'   LEFT JOIN Model M (NOLOCK) ON (M.IDModel = BA.IDModel)                ' +
'   LEFT JOIN TabGroup tg (NOLOCK) on m.groupId = tg.idGroup              ' +
'   LEFT JOIN VwModelGroup mg (NOLOCK) on m.IdModel = mg.IdModelGroup and mg.idgroup = tg.idgroup '+
'   LEFT JOIN VwModelSubGroup msg (NOLOCK) on mg.IdModelgroup = msg.IdModelGroup and mg.IdGroup = msg.IdGroup ' +
'   LEFT JOIN Inv_ModelVendor IMV (NOLOCK) ON (M.IDModel = IMV.IDModel) ' +
'   LEFT JOIN VendorModelCode vmc (NOLOCK) on M.idModel = vmc.idModel   ' +
'   LEFT JOIN Pessoa P (NOLOCK) ON vmc.IdPessoa = P.IDPessoa and M.IdModel = vmc.IdModel ';

    if ( FIDPurchaseStr = '' ) then
      result := result + sJoin + sWhere
    else
      result := result + sJoin + ' left join Pur_PurchaseItem ppi on ppi.IDModel = m.IDModel where PPI.IDPurchase = ' + FIDPurchaseStr;

    if ( emptyList ) then
      result := result + ' and m.Idmodel = -1 ';
end;

procedure TFrmBarcodePrint.BarcodeOpen;
begin
  with cdsBarcode do
    if not Active then
        Open;
end;

function TFrmBarcodePrint.StartPurchase(IDPurchase:String):Boolean;
var
  sWhere, sModels, sIDPurItem: String;
  purchaseBarcodeMessage: TfrmPurchaseBarcodeMessage;
  toMerge: Boolean;
begin
  FIDPurchaseStr := IdPurchase;
  if IDPurchase <> ''then
     begin
     fNCopiesField := 'NumCopy';

     sWhere  := 'WHERE M.IDModel IN (SELECT IDModel FROM Pur_PurchaseItem (NOLOCK) WHERE IDPurchase = '+IDPurchase+')';
     quBarCode.CommandText := ReturnSQL(' 1.0 as Qty ','', sWhere, false); //YAA --> ReturnSQL(', 1.0 as Qty ','', sWhere, false);
     BarcodeOpen;
     try
         purchaseBarcodeMessage := TfrmPurchaseBarcodeMessage.Create(nil);
         toMerge := ( purchaseBarcodeMessage.start = 0 ); 

         if ( not toMerge ) then
         begin
           //*** YAA --> Added ***
           if cdsBarcodeList.Active then
             cdsBarcodeList.Close;
           cdsBarcodeList.Open;
           //*********************
           cdsBarcodeList.EmptyDataSet;
         end;

     finally
         freeAndNil(purchaseBarcodeMessage);
     end;

     with DM.quFreeSQL do
        begin
        if Active then
           Close;

        SQL.Text := 'SELECT P.IDPurchaseItem, P.IDModel, P.Barcode, M.Model, B.IDBarCode, P.Qty, M.Description, P.qty as QtyOnHand, ' +
                    '(CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN P.NewSalePrice ELSE I.SellingPrice END) as SellingPrice, I.StoreAVGPrice '+
                    'FROM   Pur_PurchaseItem P (NOLOCK) LEFT JOIN Barcode B (NOLOCK) ON (B.IDModel = P.IDModel and B.BarcodeOrder = 1) ' +
                    ' LEFT OUTER JOIN Model M (NOLOCK) ON (M.IDModel = B.IDModel) ' +
                    ' Left Outer Join Inventory I on M.IdModel = I.ModelID ' +
                    'WHERE P.IDModel IS NOT NULL AND IDPurchase = ' + IDPurchase;

        Open;
        First;
        DisableControls;

//        cdsBarcodeList.Active := false;

        While not EOF do
          begin
          if (Pos('#'+FieldByName('IDModel').AsString+'#', sModels) = 0) or
             ( (Pos('#'+FieldByName('IDModel').AsString+'#', sModels) > 0) and
               (Pos('#'+FieldByName('IDPurchaseItem').AsString+'#', sIDPurItem) = 0)) then
          begin
             if FieldByName('IdBarcode').AsString <> '' then
                AddBarcode(FieldByName('IdBarcode').AsString,
                           FieldByName('Description').AsString,
                           FieldByName('Model').AsString,
                           Trunc(FieldByName('Qty').AsFloat),
                           FieldByName('SellingPrice').AsCurrency,
                           FieldByName('IdModel').AsInteger,
                           FieldByName('QtyOnHand').AsFloat,
                           FieldByname('StoreAVGPrice').AsCurrency)
             else if FieldByName('IDBarCode').AsString <> '' then
                AddBarcode(FieldByName('IDBarcode').AsString,
                           FieldByName('Description').AsString,
                           FieldByName('Model').AsString,
                           Trunc(FieldByName('Qty').AsFloat),
                           FieldByName('SellingPrice').AsCurrency,
                           FieldByName('IdModel').AsInteger,
                           FieldByName('QtyOnHand').AsFloat,
                           FieldByname('StoreAVGPrice').AsCurrency);

             sModels    := sModels+'#'+FieldByName('IDModel').AsString+'#';
             sIDPurItem := sIDPurItem+'#'+FieldByName('IDPurchaseItem').AsString+'#';
             end;
          Next;
          end; 

        EnableControls;
        end;
        pgFilter.ActivePageIndex := 2;
        grdBarcodeDb.DataController.DataSource := dsbarcodeList;
        //BarcodeRefresh;
     end;

    ShowModal;

end;

function TFrmBarcodePrint.Start(IDModel, Barcode: String): Boolean;
begin

    if IDModel <> '' then
       fIDModel := StrToInt(IDModel)
    else
       fIDModel := 0;

    //*** YAA ??? Removed ***
    //if Barcode <> '' then
    //   AddBarcode(Barcode, '', '' , 1, 0, 0, 0.0);
    //***********************

    if fIDModel <> 0 then begin
      pgFilter.ActivePageIndex := 2;
      cbxSearchType.ItemIndex := 0; // Barcode type selected
      FBarcode := Barcode;
      FIsOutFromPrint := true;

      //amfsouza 05.02.2012 - to get right list to printer.
      setToPrintQueue;
      //amfsouza 05.02.2012 - to get right list to printer.

      BarcodeRefresh;
      FIsOutFromPrint := false;
    end;

    ShowModal;

end;

procedure TFrmBarcodePrint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  BarcodeClose;
  DropTempTaple;

  // amfsouza 03.02.2011 - clear queue after close screen.
  if ( cdsBarcodeList.Active ) then
     cdsBarcodeList.EmptyDataSet;
  Action := caFree;
end;

procedure TFrmBarcodePrint.dsBarcCodeDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
//  btAdd.Enabled    := not (dsBarcCode.DataSet.Eof and dsBarcCode.DataSet.Bof);
//  btAddAll.Enabled := btAdd.Enabled;
end;

procedure TFrmBarcodePrint.AddBarcode(Barcode, Description, Model: String;
  Qty: Integer; SellingPrice: Currency; IdModel: Integer = 0; QtyOnHand: double = 0.0;
  StorePrice: Currency = 0.0);

begin

  Barcode := Trim(Barcode);

  if not cdsBarcodeList.Active then
    cdsBarcodeList.CreateDataSet;

  if cdsBarcodeList.Locate('IdBarcode', Barcode, []) then
  begin
    cdsBarcodeList.Edit;

    if ( chkInventoryCopy.Checked ) then
        cdsBarcodeList.FieldByName('NumCopy').AsInteger := {YAA --> trunc} RemoveNegativeValuesAndTrunc(QtyOnHand)
    else
        cdsBarcodeList.FieldByName('NumCopy').AsInteger := {YAA --> trunc}RemoveNegativeValuesAndTrunc(cdsBarcodeList.FieldByName('NumCopy').AsFloat + Qty); // 1 {YAA --> Qty});

    cdsBarcodeList.FieldByName('SellingPrice').AsCurrency := SellingPrice; //YAA --> Added

    cdsBarcodeList.Post;
  end
  else
  begin
    cdsBarcodeList.Append;
    cdsBarcodeList.FieldByName('IdBarcode').AsString      := Barcode;
    cdsBarcodeList.FieldByName('Description').AsString    := Description;
    cdsBarcodeList.FieldByName('Model').AsString          := Model;
    cdsBarcodeList.FieldByName('SellingPrice').AsCurrency := SellingPrice;
    cdsBarcodeList.FieldByName('Report').AsString         := 'Label 1';

    if ( chkInventoryCopy.Checked ) then begin
       if (trunc(qtyOnHand) > 0) then
          cdsBarcodeList.FieldByName('NumCopy').AsInteger         := {YAA --> trunc}RemoveNegativeValuesAndTrunc(QtyOnHand)
       else
          cdsBarcodeList.FieldByName('NumCopy').AsInteger         := 0;
    end
    else begin
         if ( qtyOnHand > 0 ) then
            cdsBarcodeList.FieldByName('NumCopy').AsInteger         := {YAA --> trunc} RemoveNegativeValuesAndTrunc(Qty)
         else
            cdsBarcodeList.FieldByName('NumCopy').AsInteger := 1;
    end;

    cdsBarcodeList.FieldByName('IdModel').Value           := IdModel;
    cdsBarcodeList.FieldByName('QtyOnHand').Value         := QtyOnHand;
    cdsBarcodeList.FieldByName('StoreAVGPrice').Value     := StorePrice;
    cdsBarcodeList.Post;
  end;


end;

procedure TFrmBarcodePrint.btAddClick(Sender: TObject);
begin
  inherited;


  with dsBarcCode.DataSet do
  begin
    if Active and (not IsEmpty) then
      AddBarcode(FieldByName('IDBarcode').AsString,
                 FieldByName('Description').AsString,
                 FieldByName('Model').AsString,
                 FieldByName(fNCopiesField).AsInteger,
                 FieldByName('SellingPrice').AsCurrency,
                 FieldByName('IdModel').AsInteger,
                 FieldByName('QtyOnHand').AsInteger,
                 FieldByname('StoreAVGPrice').AsCurrency);
  end;
end;

procedure TFrmBarcodePrint.btDelClick(Sender: TObject);
begin
  inherited;
  if ( cdsBarcodeList <> nil ) then begin
    with cdsBarcodeList do
      if (Active) and (RecordCount>0) then
      begin
        Edit;
        deleteSavePrintQueue(cdsBarcodeList.fieldByName('IdBarcode').Value, dm.fUser.ID);
        Delete;
      end;
  end;
end;

procedure TFrmBarcodePrint.btnPrintClick(Sender: TObject);
var
   hasLabel1, hasLabel2: boolean;
begin
  inherited;
  hasLabel1 := false;
  hasLabel2 := false;

  if ( cdsBarcodeList.Locate('Report', 'Label 1', []) ) then
     hasLabel1 := true;

  if ( cdsBarcodeList.Locate('Report', 'Label 2', []) ) then
     hasLabel2 := true;

  if ( hasLabel1 ) then begin
     PrintReport(1, True);
  end;

  if ( hasLabel2 ) then begin
     PrintReport(2, True);
  end;

  edtSearch.clear;
end;

procedure TFrmBarcodePrint.btnEditClick(Sender: TObject);
begin
  inherited;
  ppDesigner.Show;
end;

procedure TFrmBarcodePrint.ppReportPreviewFormCreate(Sender: TObject);
begin
  inherited;
  ppReport.PreviewForm.WindowState := wsMaximized;
end;

procedure TFrmBarcodePrint.btnOpenFileClick(Sender: TObject);
begin
  inherited;
  if OD.Execute then
    ReportFile := OD.FileName;
end;

procedure TFrmBarcodePrint.FormCreate(Sender: TObject);
var
   buildInfo: String;
begin
  inherited;

  bSavePrinter := False;
  cbxBarcodePrinter.Items   := Printer.Printers;

 with TRegistry.Create do
     begin
       if ( getOS(buildInfo) = osW7 ) then
           rootKey := HKEY_CURRENT_USER
       else
           RootKey := HKEY_LOCAL_MACHINE;

       OpenKey(REGISTRY_PATH, True);
       if not ValueExists('BarcodeReport') then
          WriteString('BarcodeReport', '');
       if not ValueExists('BarcodeReport2') then
          WriteString('BarcodeReport2', '');
       if not ValueExists('BarcodePrinter') then
         WriteString('BarcodePrinter', '');

       fReportFile     := ReadString('BarcodeReport');
       fReportFile2    := ReadString('BarcodeReport2');
       fBarcodePrinter := ReadString('BarcodePrinter');
       Free;
     end;

  btnPrint.Enabled         := False;
  edtReportFile.Text       := fReportFile;
  edtReportFile2.Text      := fReportFile2;
  cbxBarcodePrinter.Text   := fBarcodePrinter;
  chkPrimaryUpc.Enabled    := (pgFilter.ActivePage = tsMultiple) or (pgFilter.ActivePage = tsDate);
  chkPrimaryUPC.Checked    := true;
  chkPrimaryUpc.Enabled    := false;

//  DM.imgSmall.GetBitmap(BTN18_NEW, btAdd.Glyph);
  DM.imgSmall.GetBitmap(BTN18_DELETE, btDel.Glyph);

  CreateTempTable;

  bSavePrinter := True;
  Aview := TcxCustomGridTableView(grdBarcodeByList.FocusedView);

  //amfsouza 03.08.2011 verify if exists search ( in database to user )
  try
      if ( hasSearch(dm.fUser.ID) ) then begin
         cdsBarcodeList.CommandText := MountOpenQueue(sbModel, true);
         cdsBarcodeList.Params.ParamByName('model').Value := '-1';
         cdsBarcodeList.Open;
         while ( not qrySearch.Eof ) do begin
            cdsBarcodeList.Append;
            cdsBarcodeList.FieldByName('IdModel').Value      := qrySearch.fieldByname('IdModel').Value;
            cdsBarcodeList.FieldByName('model').Value        := qrySearch.fieldByname('Model').Value;
            cdsBarcodeList.FieldByName('description').Value  := qrySearch.fieldByname('description').Value;
            cdsBarcodeList.FieldByName('IdBarcode').Value    := qrySearch.fieldByname('IdBarcode').Value;
            cdsBarcodeList.FieldByName('qtyOnHand').Value    := qrySearch.fieldByName('qtyOnHand').Value;
            cdsBarcodeList.FieldByName('SellingPrice').Value := qrySearch.fieldByname('SellingPrice').Value;

            //YAA April 26, 2012 : Test
            cdsBarcodeList.FieldByName('NumCopy').asInteger  := {YAA --> trunc}RemoveNegativeValuesAndTrunc(qrySearch.fieldByname('NumCopy').Value);
            //if chkInventoryCopy.Checked then
      {YAA1}//  cdsBarcodeList.FieldByName('NumCopy').asInteger  := 1 //{YAA --> trunc}RemoveNegativeValuesAndTrunc(qrySearch.fieldByname('NumCopy').Value)
            //else
            //  cdsBarcodeList.FieldByName('NumCopy').asInteger  := {YAA --> trunc}RemoveNegativeValuesAndTrunc(qrySearch.fieldByname('NumCopy').Value);

            cdsBarcodeList.FieldByName('report').Value       := qrySearch.fieldbyName('report').Value;
            cbxSearchType.ItemIndex                          := qrySearch.fieldByName('IdSearchType').Value;
            chkSendToPrinter.Checked                         := qrySearch.FieldByName('StraightToPrinter').asString = '1';
            chkPrimaryUpc.Checked                            := qrySearch.fieldbyname('PrimaryBarcode').AsString = '1';
            chkInventoryCopy.Checked                         := qrySearch.FieldByName('LabelQtyOnHand').asString = '1';
            chkSaveQueue.Checked                             := qrySearch.FieldByName('PrintQueue').asString = '1';
            cdsBarcodeList.post;
            qrySearch.Next;
         end;
         grdBarcodeDb.DataController.DataSource := dsBarcodeList;
      end;
  except
      cdsBarcodeList.Close;
  end;
end;

procedure TFrmBarcodePrint.btRemoveClick(Sender: TObject);
begin
  inherited;
  ReportFile := '';
end;

procedure TFrmBarcodePrint.btAllModelClick(Sender: TObject);
begin
  inherited;
  cbxMethod.ItemIndex := -1;
  edModel.Clear;
  cbxType.ItemIndex := -1;
end;

procedure TFrmBarcodePrint.btClearCategoClick(Sender: TObject);
begin
  inherited;
  cmbCategory.LookUpValue := '';
  cmbCategory.Text        := '<'+btClearCatego.Caption+'>';
end;

procedure TFrmBarcodePrint.btnRefreshClick(Sender: TObject);
begin
  inherited;

  if ( not ValidateSearch ) then begin
     edtSearch.SetFocus;
     exit;
  end;

  fIDModel := 0;

  case pgFilter.ActivePageIndex of
      0, 1: BarcodeRefresh;
      2: begin
        if ( edtSearch.Text <> '' ) then
           BarcodeRefresh;
      end;
  end;

end;

procedure TFrmBarcodePrint.btDelAllClick(Sender: TObject);
begin
  inherited;
  with cdsBarcodeList do
    if (Active) and (RecordCount > 0) then begin
      cdsBarcodeList.DisableControls;
      while (RecordCount <> 0) do
      begin
        Edit;
        deleteSavePrintQueue(cdsBarcodeList.fieldByName('IdBarcode').Value, dm.fUser.ID);
        Delete;
      end;
      cdsBarcodeList.EnableControls;
    end;
end;

function TFrmBarcodePrint.StartTransfer(IDTransfer: String): Boolean;
var
  sOldSql, sWhere, sModels: String;
begin
  if IDTransfer <> ''then
     begin
     fNCopiesField := 'NumCopy';
     sWhere  := 'WHERE M.IDModel IN (SELECT IDModel FROM ModelTRansfDet (NOLOCK) WHERE IDModelTransf = '+IDTransfer+')';
     quBarCode.CommandText := ReturnSQL(', IsNull(I.QtyOnHand,0) as QtyOnHand ','', sWhere);
     BarcodeOpen;

     with DM.quFreeSQL do
        begin
        if Active then
           Close;
        SQL.Text := 'SELECT T.IDModel, B.IDBarCode, T.Qty, M.Description, M.Model, M.SellingPrice ' +
                    'FROM   ModelTRansfDet T (NOLOCK) LEFT JOIN Barcode B (NOLOCK) ON (B.IDModel = T.IDModel) ' +
                    ' LEFT OUTER JOIN Model M (NOLOCK) ON (M.IDModel = B.IDModel) ' +
                    'WHERE  IDModelTransf = '+IDTransfer;
        Open;
        First;
        DisableControls;
        While not EOF do
          begin
          if Pos('#'+FieldByName('IDModel').AsString+'#', sModels)=0 then
             begin
             if FieldByName('IDBarcode').AsString <> '' then
                AddBarcode(FieldByName('IDBarcode').AsString,
                           FieldByName('Description').AsString,
                           FieldByName('Model').AsString,
                           Trunc(FieldByName('Qty').AsFloat),
                           FieldByName('SellingPrice').AsCurrency,
                           FieldByName('IdModel').AsInteger,
                           FieldByName('QtyOnHand').AsFloat,
                           FieldByname('StoreAVGPrice').AsCurrency);

             sModels := sModels+'#'+FieldByName('IDModel').AsString+'#';
             end;
          Next;
          end;
        EnableControls;
        end;
     end;

    ShowModal;

end;

procedure TFrmBarcodePrint.SaveReportFile2(Report: String);
var
   buildInfo: String;
begin
 with TRegistry.Create do
     begin
       if ( getOs(buildInfo) = osW7 ) then
          rootKey := HKEY_CURRENT_USER
       else
          RootKey := HKEY_LOCAL_MACHINE;
          
       OpenKey(REGISTRY_PATH, True);
       WriteString('BarcodeReport2', Report);
       Free;
     end;
   fReportFile2        := Report;
   edtReportFile2.Text := Report;
end;

procedure TFrmBarcodePrint.btRemove2Click(Sender: TObject);
begin
  inherited;
  edtReportFile2.Text := '';
end;

procedure TFrmBarcodePrint.btnOpenFile2Click(Sender: TObject);
begin
  inherited;
  if OD.Execute then
     ReportFile2 := OD.FileName;
end;

procedure TFrmBarcodePrint.FormShow(Sender: TObject);
begin
  inherited;
  dtStart.Date        := Now;
  dtEnd.Date          := Now;

  //amfsouza 02.23.2011 - default page is print queue
  pgFilter.ActivePage := tsBarcodeQueue;
  pgFilter.Height     := 90;
end;

procedure TFrmBarcodePrint.BarcodeQueueClose;
begin
  with quQueue do
    if Active then
       Close;
end;

procedure TFrmBarcodePrint.BarcodeQueueOpen;
begin
  with quQueue do
    if not Active then
       Open;
end;

procedure TFrmBarcodePrint.BarcodeQueueRefresh;
begin
  BarcodeQueueClose;
  BarcodeQueueOpen;
end;

procedure TFrmBarcodePrint.PrintReport(Report: Integer; bScreen : Boolean);
var
  sPrintReport : String;
  i, iEnd : Integer;
  msgWarning: String;
  filterBarcodeToPrint: String;
begin
  DeleteTempTable;
  InsertTempTable(Report);

  cdsBarcodePrint.Close;
  cdsBarcodePrint.FetchParams;
  cdsBarcodePrint.Params.ParamByName('StoreID').Value := DM.fStore.ID;
  if  ( FIDPurchaseStr <> '' ) then
       cdsBarcodePrint.Params.ParamByName('IdPurchase').Value := strToInt(FIDPurchaseStr);

  SortReportOrder(grdBarcodeDB);

  cdsBarcodePrint.Open; 

  if ( cdsBarcodeList.Active ) then begin
     cdsBarcodeList.First;
     while ( not cdsBarcodeList.Eof ) do begin
          if ( filterBarcodeToPrint = '' ) then
             filterBarcodeToPrint := cdsBarcodeList.FieldByName('IdModel').AsString
          else
             filterBarcodeToPrint := filterBarcodeToPrint + ',' + cdsBarcodeList.FieldByName('IdModel').AsString;

          cdsBarcodeList.Next;
     end;

     // amfsouza 02.25.2011 filter to print
     cdsBarcodePrint.Filtered := false;
     cdsBarcodePrint.Filter := 'Idmodel in ('+filterBarcodeToPrint+')';
     cdsBarcodePrint.Filtered := true;
(*
    while ( not cdsBarcodeList.Eof ) do begin
          cdsBarcodePrint.Edit;
          cdsBarcodePrint.FieldByName('NumCopy').AsInteger := grdBarcodeDBNumCopy.dataBinding.Field.AsInteger;     //cdsBarcodeList.fieldByName('NumCopy').AsInteger;
          cdsBarcodePrint.Post;
          cdsBarcodeList.Next;
     end;
 *)    
  end;

  //amfsouza 04.03.2011
  if ( cdsBarcodePrint.RecordCount > 100 ) then begin
     msgWarning := 'You are about to print ' + intToStr(cdsBarcodePrint.RecordCount) + ' labels. Do you wish to continue ?';
     if ( Application.MessageBox(Pchar(msgWarning), ' Greater than 100 models to printer', mb_YESNO + mb_IconWarning) = idNo ) then
        exit;
  end;

  if cdsBarcodePrint.RecordCount > 0 then
  begin

    iEnd := 0;

    case Report of
     1 : begin
         if StrToIntDef(edtSkipRep1.Text,0) > 0 then
           iEnd := StrToIntDef(edtSkipRep1.Text,0);
         end;
     2 : begin
         if StrToIntDef(edtSkipRep2.Text,0) > 0 then
           iEnd := StrToIntDef(edtSkipRep2.Text,0);
         end;
    end;

    //under test amfsouza 09.27.2011
    if iEnd > 0 then
    begin
      cdsBarcodePrint.First;
//amfsouza 10.24.2011      for i := 1 to (iEnd-1) do
      for i := 1 to (iEnd) do
      begin
        cdsBarcodePrint.Insert;
        cdsBarcodePrint.Post;
      end;
    end;

    case Report of
      1 : sPrintReport := ReportFile;
      2 : sPrintReport := ReportFile2;
    end;

    if (sPrintReport <> '') and FileExists(sPrintReport) then
    begin
      ppReport.Template.FileName := sPrintReport;
      ppReport.Template.LoadFromFile;
    end;

    if fBarcodePrinter <> '' then
      ppReport.PrinterSetup.PrinterName := fBarcodePrinter;

    cdsBarcodePrint.First;

    if not bScreen then
    begin
      ppReport.DeviceType       := dtPrinter;
      ppReport.ShowPrintDialog  := False;
      ppReport.ShowCancelDialog := False;
    end;

    ppReport.Print;
//    cdsBarcodePrint.Close;
  end;

end;

procedure TFrmBarcodePrint.btAddAllClick(Sender: TObject);
begin
  inherited;
  AddAllBarcode;
end;

procedure TFrmBarcodePrint.btnClearListClick(Sender: TObject);
begin
  inherited;
  if quQueue.Active and (quQueue.RecordCount>0) then
  begin
    DM.RunSQL('DELETE Inv_BarcodePrint');
    BarcodeQueueRefresh;
  end;
end;

procedure TFrmBarcodePrint.pgFilterChange(Sender: TObject);
begin
  inherited;
  cdsBarcode.Close;
  quQueue.Close;
  if ( not hasSearch(dm.fUser.ID) ) then begin
    btnClearList.Visible     := (pgFilter.ActivePage = tsBarcodeQueue);
    chkSendToPrinter.Enabled := (pgFilter.ActivePage = tsBarcodeQueue);
    chkPrimaryUpc.Enabled    := (pgFilter.ActivePage = tsMultiple) or (pgFilter.ActivePage = tsDate);
  end;

  if ( pgFilter.ActivePage = tsBarcodeQueue ) then
     pgFilter.Height := 90
  else
     pgfilter.Height := 248;

end;

procedure TFrmBarcodePrint.dsBarcodeListDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btnPrint.Enabled := cdsBarcodeList.RecordCount > 0;
end;

procedure TFrmBarcodePrint.btClearSubCategoClick(Sender: TObject);
begin
  inherited;
  scModelGroup.LookUpValue := '';
  scModelGroup.Text        := '<'+btClearSubCatego.Caption+'>';
end;

procedure TFrmBarcodePrint.btClearGroupClick(Sender: TObject);
begin
  inherited;
  scModelSubGroup.LookUpValue := '';
  scModelSubGroup.Text        := '<'+btClearGroup.Caption+'>';
end;

procedure TFrmBarcodePrint.edtSkipRep1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  Key := ValidateNumbers(Key);
end;

procedure TFrmBarcodePrint.SortReportOrder(gridReport: TcxGridDBTableView);
var
  i, iType: Integer;
  sSortOrder : String;
  cxOrder : TcxGridSortOrder;
begin
  (*** YAA April 26, 2012 - For clarification purposes. Note that ***)
  (*** TcxDataSortOrder = (soNone, soAscending, soDescending);    ***)

  sSortOrder := '';
  for i := 0 to gridReport.ColumnCount -1 do
  begin
    cxOrder := gridReport.Columns[i].SortOrder;

    if (gridReport.Columns[i].DataBinding.FieldName <> 'report') and
       (gridReport.Columns[i].DataBinding.FieldName <> 'NumCopy') then
      if cxOrder = TCxDataSortOrder(0) then
      begin
      end
      else if cxOrder = TCxDataSortOrder(1) then
      begin
        sSortOrder := gridReport.Columns[i].DataBinding.FieldName;
        iType := ORDER_ASC;
        Break;
      end
      else if cxOrder = TCxDataSortOrder(2) then
      begin
        sSortOrder := gridReport.Columns[i].DataBinding.FieldName;
        iType := ORDER_DESC;
        Break;
      end;
    end;

  //amfsouza 05.02.2012
  setToPrintQueue;

  if ( cxOrder <> TCxDataSortOrder(2) ) then begin
      if sSortOrder <> '' then
        quBarcodePrint.CommandText := ChangeSQLOrder(quBarcodePrint.CommandText, sSortOrder, iType);
  end
  else if ( sSortOrder <> '' ) then
         quBarcodePrint.CommandText := quBarcodePrint.CommandText + ' order by 11'; //barcode

end;

function TFrmBarcodePrint.PrintBarcode(ABarcode : String; AQty: Integer): Boolean;
begin

  Result := False;

  try
    AddBarcode(ABarcode, '', '', AQty, 0, 0, 0.0);
    PrintReport(1, False);
    Result := True;
  finally
    //to be removed DeleteTempTable;
  end;

end;

procedure TFrmBarcodePrint.cbxBarcodePrinterChange(Sender: TObject);
var
   buildInfo: String;
begin
  inherited;

  fBarcodePrinter := cbxBarcodePrinter.Text;

  if bSavePrinter then
    with TRegistry.Create do
    begin
      if ( getOS(buildInfo) = osW7 ) then
         rootKey := HKEY_CURRENT_USER
      else
          RootKey := HKEY_LOCAL_MACHINE;
          
      OpenKey(REGISTRY_PATH, True);
      WriteString('BarcodePrinter', fBarcodePrinter);
      Free;
    end;

end;

procedure TFrmBarcodePrint.grdBarcodeDBKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_Return) and (cdsBarcode.Active) then
    btAddClick(Self);

end;

procedure TFrmBarcodePrint.cdsBarcodePrintAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TNumericField(dataset.FieldByName('NumCopy')).DisplayFormat := '######0';
  quModelFeature.Open;
end;

procedure TFrmBarcodePrint.cdsBarcodePrintBeforeClose(DataSet: TDataSet);
begin
  inherited;
  quModelFeature.Close;
end;

procedure TFrmBarcodePrint.edtBarcodeAfterSearchBarcode(Sender: TObject);
begin
  inherited;
  BarcodeRefresh;
end;

procedure TFrmBarcodePrint.edtBarcodeExit(Sender: TObject);
begin
  inherited;
  BarcodeRefresh;

end;

function TFrmBarcodePrint.MountOpenQueue(searchBy: TSearchBarCode; emptyList: boolean = false; numberCopy: double = 1): String;
var
   sql: String;
   sSQL, sWhere, sJoin : String;
begin

    //amfsouza 02.22.2011
    sSQL := 'SELECT distinct M.IDModel '+
                    ',M.Model '+
                    ',tg.name Category ' +
                    ',mg.modelGroup Subcategory ' +
                    ',msg.modelsubgroup msgGroup' +
                    ',M.Description '+
                    ',m.DateLastSellingPrice ' ;

                    if ( chkInventoryCopy.Checked ) then begin
                       fNCopiesField := 'QtyOnHand'; 
                       sSQL := sSQL + ', (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, I.QtyOnHand ';
                    end
                    else
                     sSQL := sSQL +
                     ', (CASE IsNull(I.SellingPrice, 0) WHEN 0 THEN M.SellingPrice ELSE I.SellingPrice END) as SellingPrice, IsNull(I.QtyOnHand,0) QtyOnHand ';

              sSQL := sSQL +
                    ',BA.Idbarcode ' +
                    ',BA.data ' +
                    ',cast('+ FloatToStr(numberCopy) + ' as Decimal) NumCopy  ' +
                    ',cast (''Label 1'' as varchar) Report ' +
                    ',I.StoreAVGPrice '+

              'FROM Barcode BA (NOLOCK) ' +
                    'LEFT JOIN Inv_BarcodePrint B (NOLOCK) ON (BA.IdBarcode = B.IdBarcode) '+
                    'LEFT JOIN Model M (NOLOCK) ON (M.IDModel = BA.IDModel) '+
                    'LEFT JOIN TabGroup tg (NOLOCK) on m.groupId = tg.idGroup '+
                    'LEFT JOIN VwModelGroup mg (NOLOCK) on m.IdModel = mg.IdModelGroup and mg.idgroup = tg.idgroup '+
                    'LEFT JOIN VwModelSubGroup msg (NOLOCK) on mg.IdModelgroup = msg.IdModelGroup and mg.IdGroup = msg.IdGroup '+
                    'LEFT JOIN Inv_ModelVendor IMV (NOLOCK) ON (M.IDModel = IMV.IDModel) ' +
                    'LEFT JOIN VendorModelCode vmc (NOLOCK) on M.idModel = vmc.idModel ' ;

                     if ( chkInventoryCopy.Checked ) then
                       sSQL := sSQL + ' LEFT JOIN Inventory I ON (I.ModelID = BA.IDModel) '
                    else
                       sSQL := ssQL + ' LEFT JOIN Inventory I ON (M.Idmodel = I.ModelID) ';

                     sSQL := ssQL + ' LEFT JOIN Pessoa P (NOLOCK) ON vmc.IdPessoa = P.IDPessoa and M.Idmodel = vmc.IdModel ';

    //YAA April 29, 2012: TODO If item is found but is inactive (desativado = 1), then we need to prompt
    //on if to reactivate item like what happens in register.
    //We should copy the process in the register... Let's try to reuse the same
    //process.
    if ( searchBy = sbModel ) then
        sWhere := 'WHERE M.Model = :model and m.desativado = 0'
     else if ( searchBy = sbBarCode ) then
     begin
        sWhere := 'WHERE BA.IDBarcode = :idbarcode and m.desativado = 0';
    end
    else if ( searchBy = sbVendor ) then
    begin
        sWhere := 'WHERE vmc.vendorCode = :sku ' +
                    ' AND IMV.IDPessoa = :idpessoa and m.desativado = 0 ' ;
    end;

    if ( pgFilter.ActivePageIndex = 2 ) then
          sWhere := sWhere + ' AND BA.BarcodeOrder = 1 '
    else begin
        //amfsouza 06.09.2011
        if ( chkPrimaryUpc.Enabled ) then begin
            if ( chkPrimaryUpc.Checked ) then
              sWhere := sWhere + ' AND BA.BarcodeOrder = 1 '
            else
              sWhere := sWhere + ' AND BA.IdBarcode is not null';
        end
        else
          sWhere := sWhere + ' AND BA.IdBarcode is not null';
    end;

    sWhere := sWhere + ' AND I.StoreID = ' + InttoStr(DM.fStore.ID);// + ' AND IsNull(I.QtyOnHand,0) > 0';

    //amfsouza 03.01.2011 - to create an empty list.
    if ( emptyList ) then
       sWhere := sWhere + ' and m.Idmodel = -1';

    result := sSQL + sJoin + sWhere;

end;

procedure TFrmBarcodePrint.cbxSearchTypeCloseUp(Sender: TObject);
begin
  inherited;
  scVendor.Enabled := cbxSearchType.ItemIndex = 2;
  //02.18.2011-  to do -oamfsouza -cscreen :to monday - edtSearch.Visible := ( not scVendor.Enabled );
end;

procedure TFrmBarcodePrint.cbxSearchTypeChange(Sender: TObject);
begin
  inherited;
  edtSearch.Clear;
  edtSearch.SetFocus;
  if ( cbxSearchType.ItemIndex <> 2 ) then
  begin
    scVendor.Enabled := False;
    scVendor.Text := '';
  end
  else
    scVendor.Enabled := True;
end;

procedure TFrmBarcodePrint.edtSearchKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  //hold this solution to test change method.
  if ( key = #13 ) then begin
     if ( not ValidateSearch ) then begin
        edtSearch.SetFocus;
        exit;
     end;

     //amfsouza 02.23.2011 - starts search.
     btnRefreshClick(sender);
  end
end;

procedure TFrmBarcodePrint.edtSearchExit(Sender: TObject);
begin
  inherited;
  if ( not ValidateSearch ) then begin
     edtSearch.SetFocus;
     exit;
  end;
end;

function TFrmBarcodePrint.ValidateSearch: boolean;
begin
  result := true;
  if ( pgFilter.ActivePageIndex = 2 ) then begin
    if ( (TSearchBarcode(cbxSearchType.ItemIndex) = sbVendor) and
          (scVendor.Text = '') ) then begin
          MsgBox(MSG_EXC_SELECT_A_VENDOR, vbOkOnly + vbExclamation);
          result := false;
    end;
  end;
end;

procedure TFrmBarcodePrint.edtSearchChange(Sender: TObject);
var
  typed: String;
  i: Integer;
begin
  inherited;

  //amfsouza 02.23.2011 - starts search.
//  btnRefreshClick(sender);

end;


procedure TFrmBarcodePrint.btColumnClick(Sender: TObject);
begin
  inherited;
  //amfsouza 03.01.2011

  //YAA Removed --> TcxGridDBTableView(AView).Controller.Customization := not (TcxGridDBTableView(AView).Controller.Customization);
  // ShowColumn(TcxCustomGridTableView(grdBarcodeByList.FocusedView), btColumn.Down);

  //*** YAA Added ***
  case pgFilter.ActivePageIndex of
  0: begin
       Aview := TcxCustomGridTableView(grdBarcodeByList.FocusedView);
       ShowColumn(TcxCustomGridTableView(grdBarcodeByList.FocusedView), True);
     end;
  1: begin
       Aview := TcxCustomGridTableView(grdBarcodeLastUpdate.FocusedView);
       ShowColumn(TcxCustomGridTableView(grdBarcodeLastUpdate.FocusedView), True);
     end;
  end;
  //*****************
end;


procedure TFrmBarcodePrint.ShowColumn(AView: TcxCustomGridTableView;
  pCustomize: Boolean);
begin
   TcxGridDBTableView(AView).Controller.Customization := pCustomize;
end;

function TFrmBarcodePrint.fillBarcodeQueue: boolean;
var
   i: integer;
   newQty: extended;
   foundRecord: boolean;
   hasFormula: boolean;
   signalFormula:String;
   selectedRecord: TBookMark;
   saveIdModel: Integer;
   searchKey : Integer;
   searchKeyStr: String;
   otherField: boolean;
   ModelOutFromPrint, ModelDescriptionOutFromPrint: String;

begin
   hasFormula := pos('*', edtSearch.Text) > 0;
   if (hasFormula ) then
      newQty := strToFloat(copy(edtSearch.Text, 1, (pos('*', edtSearch.Text) -1)))
   else
      newQty := 1.0;

   quQueue.Locate('IdBarcode', quQueue.fieldByName('IdBarcode').Value, []);

   case TSearchBarCode(cbxSearchType.ItemIndex) of
        sbBarcode: foundRecord := cdsBarcodeList.Locate('Idbarcode', quQueue.fields[9].Value, []);
        sbModel:   foundRecord := cdsBarcodeList.Locate('Model', quQueue.fields[1].Value, []);
        sbVendor:  foundRecord := cdsBarcodeList.Locate('IdBarcode', quQueue.fields[7].Value, []);
   end;

   if ( foundRecord ) then begin
      // amfsouza 10.31.2011 - called from inventory maintenance print barcode.
      if ( FIsOutFromPrint ) then begin
          searchKeyStr := quQueue.fieldByname('IdBarcode').Value;
          ModelOutFromPrint := quQueue.fieldByName('model').AsString;
          ModelDescriptionOutFromPrint := quQueue.fieldByName('description').AsString;
          cdsBarcodeList.Filter := 'IdBarcode = ' + quotedStr(searchKeyStr);
          cdsBarcodeList.Filtered := true;
      end
      else begin
          searchKey := cdsBarcodeList.fieldByname('IdModel').Value;
          cdsBarcodeList.Filter := 'IdModel = ' + IntToStr(searchKey);
          cdsBarcodeList.Filtered := true;
      end;

      //***  YAA ??? Added ***
      //if not cdsBarcodeList.Active then
      //  cdsBarcodeList.Open;
      //******************

      while ( not quQueue.Eof ) do begin
         cdsBarcodeList.Edit;
         cdsBarcodeList.FieldByName('description').AsString := quQueue.fieldByname('description').Value;
         cdsBarcodeList.fieldByName('sellingprice').Value   := quQueue.fieldbyname('sellingprice').Value;

         {YAA2: I didn't modify this at the end}
         if ( not chkInventoryCopy.Checked ) then
             cdsBarcodeList.FieldByName('NumCopy').Value   := RemoveNegativeValuesAndTrunc( cdsBarcodeList.FieldByName('NumCopy').Value + 1 ) {YAA ??? quQueue.fieldByName('NumCopy').Value) } //YAA ???
         else
             cdsBarcodeList.FieldByName('NumCopy').Value := RemoveNegativeValuesAndTrunc( quQueue.fieldByName('qtyOnHand').Value); //YAA ???

         cdsBarcodeList.Post;
         quQueue.Next;
      end;

      cdsBarcodeList.Filter := '';
      cdsBarcodeList.Filtered := false;
   end
   else begin
      while ( not quQueue.Eof ) do begin
             cdsBarcodeList.Append;
         for i:= 0 to quQueue.Fields.Count -1 do begin
             //amfsouza 04.26.2012 - to fix qtyOnhand (see screen)
             if (quQueue.Fields[i].fieldName = 'QtyOnHand') then begin
                   cdsBarcodeList.FieldByName('qtyOnHand').Value := quQueue.fieldByName('qtyOnHand').Value;
             end;

             //amfsouza 04.26.2012 - to fix NumberCopies (see screen)
             if ( quQueue.Fields[i].fieldName = 'NumCopy' ) then begin
                if ( chkInventoryCopy.Checked ) then begin
                    if ( quQueue.FieldByName('QtyOnHand').Value > 0 ) then
                       cdsBarcodeList.FieldByName(quQueue.Fields[i].fieldName).Value := trunc(quQueue.fieldByName('qtyOnHand').Value)
                    else
                       cdsBarcodeList.FieldByName(quQueue.Fields[i].fieldName).Value := 0;
                end
                else begin
                    if ( quQueue.FieldByName('QtyOnHand').Value > 0 ) then
                       cdsBarcodeList.FieldByName(quQueue.Fields[i].fieldName).Value := 1;
                end;

               //*** YAA April 26, 2012: Added ***
               if VarIsNull(cdsBarcodeList.FieldByName(quQueue.Fields[i].fieldName).Value) then
               begin
                 if chkInventoryCopy.Checked then
                   cdsBarcodeList.FieldByName(quQueue.Fields[i].fieldName).Value:= 0
                 else
                   cdsBarcodeList.FieldByName(quQueue.Fields[i].fieldName).Value:= 1;
               end;

               //*********************************
             end;

             otherField := ( (quQueue.Fields[i].fieldName <> 'QtyOnHand') and (quQueue.Fields[i].fieldName <> 'NumCopy') );

             if ( otherField ) then
                cdsBarcodeList.fieldByName(quQueue.Fields[i].fieldName).Value := quQueue.Fields[i].Value;
         end;

         cdsBarcodeList.Post;
         quQueue.Next;
       end;
   end;

   edtSearch.Clear;

end;

procedure TFrmBarcodePrint.pgFilterChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  listHasItems: boolean;
begin
  inherited;
end;

function TFrmBarcodePrint.fillBarcode: boolean;
var
   foundRecord: boolean;
   newQty: extended;
   i: integer;
begin
   cdsBarcode.First;
   while ( not cdsBarcode.Eof ) do begin
       foundRecord := cdsBarcodeList.Locate('IdModel', cdsBarcode.fields[0].Value, []);

       if ( not foundRecord ) then
          cdsBarcodeList.Append
       else begin
          if ( newQty >= 0 ) then begin
              cdsBarcodeList.Edit;
          end
          else begin
              cdsBarcodeList.Delete;
              break;
          end;
       end;

       for i:= 0 to cdsBarcode.Fields.Count -1 do begin
           if ( cdsBarcodeList.State = dsInsert ) then begin
               if ( i = 8 ) then begin //quantity on hand column
                   if ( not chkInventoryCopy.Checked ) then
                      cdsBarcodeList.Fields[i].Value := newQty
                   else
                      cdsBarcodeList.fields[i].Value := cdsBarcode.Fields[i].Value;
                end
                else
                  cdsBarcodeList.fields[i].Value := cdsBarcode.Fields[i].Value;
           end
           else begin
               if ( newQty >= 0 ) then begin //to edit.
                    if ( i = 8 ) then begin //quantity on hand column
                       if ( not chkInventoryCopy.Checked ) then
                          cdsBarcodeList.Fields[i].Value := cdsBarcodeList.Fields[i].Value + newQty
                       else
                          cdsBarcodeList.fields[i].Value := cdsBarcodeList.fields[i].Value + cdsBarcode.Fields[i].Value;
                    end
                    else
                      cdsBarcodeList.fields[i].Value := cdsBarcode.Fields[i].Value;
               end;
           end;
       end;

       cdsBarcodeList.Post;
       cdsBarcode.Next;
   end;
end;

function TFrmBarcodePrint.hasSearch(idUser: integer): boolean;
var
   sql: String;
begin
   try
     sql := 'select * from Inv_BarcodePrintSearch where idUser = :iduser';
     qrySearch := TADODataSet.Create(self);
     qrySearch.Connection := dm.ADODBConnect;
     qrySearch.CommandText := sql;
     qrySearch.Parameters.ParamByName('iduser').Value := idUser;
     qrySearch.Open;
     result := not qrySearch.IsEmpty;
   except
      on e: Exception do
         raise Exception.Create('Fail to get last user search');
   end;
end;

procedure TFrmBarcodePrint.grdBarcodeDBDBColumn1PropertiesCloseUp(
  Sender: TObject);
begin
  inherited;
  if grdBarcodeDBDBColumn1.DataBinding.Field.Value = 'Label 1' then
     grdBarcodeDBDBColumn1.EditValue := 'Label 2'
  else
     grdBarcodeDBDBColumn1.EditValue := 'Label 1';

end;

function TFrmBarcodePrint.sendStraightToPrinter(var qtyVerified: boolean; queue: TADODataset; toPrinter, printLabel: boolean; qtyFormula: extended = 0): boolean;
var
   straightToPrinter: boolean;
   msgWarning: String;
begin  
   straightToPrinter := toPrinter;
   if ( straightToPrinter ) then begin
      queue.Last;
      queue.Filter := 'IdBarcode = ' + quotedStr(queue.fieldByname('IdBarcode').Value);
      queue.Filtered := true;
      if ( printLabel ) then begin
          if ( queue.FieldByName('qtyOnHand').Value > 20 ) then begin
             qtyVerified := true;
             msgWarning := IntToStr(queue.RecordCount) + ' will be printed. Continue ?';
             if ( Application.MessageBox(Pchar(msgWarning), 'Greather than 20 labels', mb_YESNO + mb_IconWarning) = idYes ) then begin
                //btnPrintClick(self);
                DirectToPrint(false);
                result := true;
                edtSearch.Clear;
             end;
          end;
          if ( qtyFormula > 20 ) then begin
             qtyVerified := true;
             msgWarning := FloatToStr(qtyFormula) + ' will be printed. Continue ?';
             if ( Application.MessageBox(Pchar(msgWarning), 'Greather than 20 labels', mb_YESNO + mb_IconWarning) = idYes ) then begin
                DirectToPrint(false);
                edtSearch.Clear;
                result := true;
             end;
          end
          else begin
              DirectToPrint(false);
              edtSearch.Clear;
              result := true;

          end;
      end
      else begin
          DirectToPrint(false);
          edtSearch.Clear;
          result := true;
      end;

      quQueue.Filter := '';
      quQueue.Filtered := false;
   end
   else
     result := false;
end;

procedure TFrmBarcodePrint.chkSendToPrinterClick(Sender: TObject);
begin
  inherited;
  grdBarcodeByList.Enabled     := ( (not chkSendToPrinter.Checked) );
  grdBarcodeLastUpdate.Enabled := grdBarcodeByList.Enabled;
  grdBarcode.Enabled           := grdBarcodeByList.Enabled;

end;

procedure TFrmBarcodePrint.btCloseClick(Sender: TObject);
var
  qrySavePrint: TADOQuery;
  sqlInsert: String;
  sqlUpdate: String;
begin

  FIDPurchaseStr := '';

  //*** YAA --> Added ***
  if ( not chkSaveQueue.Checked ) then
  begin
    btDelAllClick(Sender);
    Exit;
  end;
  //*********************

  if ( chkSaveQueue.Checked ) then begin
      // amfsouza 04.03.2011 - save print queue.
      if ( not cdsBarcodeList.IsEmpty ) then begin
           try
               qrySavePrint := TADOQuery.Create(nil);
               qrySavePrint.Connection := dm.ADODBConnect;

               sqlInsert := 'insert into Inv_BarcodePrintSearch (IdUser, IdModel, Model, Description, IdBarcode, QtyOnHand, SellingPrice, NumCopy, Report, IdSearchType, StraightToPrinter, PrintQueue, LabelQtyOnHand, PrimaryBarcode) ' +
                'values (:iduser, :idmodel, :model, :description, :idbarcode, :qtyOnHand, :sellingPrice, :numcopy, :report, :searchWith, :straight, :queue, :label, :primary)';

               sqlUpdate := 'Update Inv_BarcodeprintSearch set NumCopy = :numcopy, ' +
                'report = :report, IdSearchType = :searchWith, StraightToPrinter = :straight, ' +
                'PrintQueue = :queue, LabelQtyOnHand = :label, PrimaryBarcode = :primary, ' +
                'IdModel = :idmodel, model = :model, description = :description, qtyOnHand = :qtyOnHand, SellingPrice = :sellingprice ' +
                'where IdUser = :iduser and IdBarcode = :idbarcode';

               //YAA April 27, 2012: Moved inside the while loop
               //if ( ValidatePrintQueue(dm.fUser.ID, cdsBarcodeList.FieldByName('IdBarcode').Value) ) then
               //   qrySavePrint.SQL.Text := sqlInsert
               //else
               //   qrySavePrint.SQL.Text := sqlUpdate;

             try
               cdsBarcodeList.First;
               while ( not cdsBarcodeList.Eof ) do begin
                 //*** YAA April 27, 2012: From above ***
                 if ( ValidatePrintQueue(dm.fUser.ID, cdsBarcodeList.FieldByName('IdBarcode').Value) ) then
                   qrySavePrint.SQL.Text := sqlInsert
                 else
                   qrySavePrint.SQL.Text := sqlUpdate;
                 //**************************************

                   qrySavePrint.Parameters.ParamByName('iduser').Value    := dm.fUser.ID;

                   if ( not cdsBarcodeList.FieldByName('IdModel').IsNull ) then
                      qrySavePrint.Parameters.ParamByName('idmodel').Value   := cdsBarcodeList.fieldByName('idmodel').value;

                   if ( not cdsBarcodeList.FieldByName('Model').IsNull ) then
                      qrySavePrint.Parameters.ParamByName('model').Value     := cdsBarcodeList.fieldByName('model').AsString;

                   if ( not cdsBarcodeList.FieldByName('Description').IsNull ) then
                      qrySavePrint.Parameters.ParamByName('description').Value  := cdsBarcodeList.fieldByName('description').asString;

                   if ( not cdsBarcodeList.FieldByName('IdBarcode').IsNull ) then
                      qrySavePrint.Parameters.ParamByName('idbarcode').Value := cdsBarcodeList.fieldByname('IdBarcode').Value;

                   if ( not cdsBarcodeList.FieldByName('QtyOnHand').IsNull ) then
                      qrySavePrint.Parameters.ParamByName('qtyOnHand').Value := cdsBarcodeList.fieldByName('qtyOnHand').AsFloat;

                   if ( not cdsBarcodeList.FieldByName('SellingPrice').IsNull ) then
                      qrySavePrint.Parameters.ParamByName('sellingPrice').Value := cdsBarcodeList.fieldByName('sellingPrice').AsCurrency;

                   if ( not cdsBarcodeList.FieldByName('NumCopy').IsNull ) then
                      qrySavePrint.Parameters.ParamByName('numCopy').value := trunc(cdsBarcodeList.fieldByName('numCopy').asInteger);

                   if ( not cdsBarcodeList.FieldByName('report').IsNull ) then
                      qrySavePrint.Parameters.ParamByName('report').Value := cdsBarcodeList.fieldByName('report').asString;

                   qrySavePrint.Parameters.ParamByName('searchWith').Value := cbxSearchType.ItemIndex;

                   if ( chkSendToPrinter.Checked ) then
                      qrySavePrint.Parameters.ParamByName('straight').Value := 1
                   else
                      qrySavePrint.Parameters.ParamByName('straight').Value := 0;

                   if ( chkSaveQueue.Checked ) then
                      qrySavePrint.Parameters.ParamByName('queue').Value := 1
                   else
                      qrySavePrint.Parameters.ParamByName('queue').Value := 0;

                   if ( chkInventoryCopy.Checked ) then
                      qrySavePrint.Parameters.ParamByName('label').Value := 1
                   else
                      qrySavePrint.Parameters.ParamByName('label').Value := 0;

                   if ( chkPrimaryUpc.Checked ) then
                      qrySavePrint.Parameters.ParamByName('primary').Value := 1
                   else
                      qrySavePrint.Parameters.ParamByName('primary').Value := 0;

                   qrySavePrint.ExecSQL;

                   cdsBarcodeList.Next;
               end;
             except
               on e: Exception do begin
                  raise Exception.Create('failed to save print queue: ' + e.Message);
               end;
             end;

           finally
               freeAndNil(qrySavePrint);
           end;
      end;
  end;

  inherited;

end;

procedure TFrmBarcodePrint.cdsBarcodeAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if ( FIDPurchaseStr = '' ) then
     TFloatField(dataset.FieldByName('qtyOnHand')).DisplayFormat := '#,##0.00';

  TNumericField(dataset.fieldByName('NumCopy')).DisplayFormat := '######0';
end;

function TFrmBarcodePrint.DirectToPrint(bScreen: boolean): boolean;
var
   i, J, iEnd: integer;
   SQL: String;
   msgWarning, sPrintReport: String;
   FieldToSwitch: string; //YAA April 26, 2012 --> Added
begin
  DeleteTempTable;

  if (not quQueue.Active) or
    (quQueue.RecordCount = 0) then
     begin
       MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOKOnly);
       Exit;
     end;


   with quQueue do
   try
     DisableControls;
     First;
     j := 1;
     while not EOF do
       begin
         //*** YAA April 26, 2012  --> Added ***
         FieldToSwitch:= 'NumCopy';
         if chkInventoryCopy.Checked then
           FieldToSwitch:= 'qtyOnHand';
         //**************************************

         //*** YAA April 26, 2012  --> Use var FieldToSwitch, not 'NumCopy'
         for i := 1 to FieldByName({'NumCopy'}FieldToSwitch).AsInteger do
         begin
           SQL := 'INSERT #Temp_Barcode VALUES ('+IntToStr(j)+','+QuotedStr(FieldByName('IdBarcode').AsString)+')';
           DM.RunSQL(SQL);
         end;
         inc(j);
         Next;
       end;
   finally
     Filter   := '';
     Filtered := False;
     EnableControls;
     end;

  (* amfsouza 05.02.2012
  cdsBarcodePrint.close;
  quBarcodePrint.CommandText := getSQL((FIDPurchaseStr <> ''));
  cdsBarcodePrint.FetchParams;
  cdsBarcodePrint.Params.ParamByName('StoreID').Value := DM.fStore.ID;
  *)
  cdsBarcodePrint.Open;

  //amfsouza 04.03.2011
  if ( cdsBarcodePrint.RecordCount > 100 ) then begin
     msgWarning := 'You are about to print ' + intToStr(cdsBarcodePrint.RecordCount) + ' labels. Do you wish to continue ?';
     if ( Application.MessageBox(Pchar(msgWarning), ' Greater than 100 models to printer', mb_YESNO + mb_IconWarning) = idNo ) then
        exit;
  end;

  if cdsBarcodePrint.RecordCount > 0 then
  begin
    iEnd := 0;

 (*
    case Report of
     1 : begin
         if StrToIntDef(edtSkipRep1.Text,0) > 0 then
           iEnd := StrToIntDef(edtSkipRep1.Text,0);
         end;
     2 : begin
         if StrToIntDef(edtSkipRep2.Text,0) > 0 then
           iEnd := StrToIntDef(edtSkipRep2.Text,0);
         end;
    end;
 *)

    iEnd := StrToIntDef(edtSkipRep1.Text, 0);

    if iEnd > 0 then
    begin
      cdsBarcodePrint.First;
//amfsouza 10.24.2011      for i := 1 to (iEnd-1) do
      for i := 1 to (iEnd) do
      begin
        cdsBarcodePrint.Insert;
        cdsBarcodePrint.Post;
      end;
    end;

  (*
    case Report of
      1 : sPrintReport := ReportFile;
      2 : sPrintReport := ReportFile2;
    end;
   *)

    ReportFile := edtReportFile.Text;
    sPrintReport := ReportFile;

    if (sPrintReport <> '') and FileExists(sPrintReport) then
    begin
      ppReport.Template.FileName := sPrintReport;
      ppReport.Template.LoadFromFile;
    end;

    if fBarcodePrinter <> '' then
      ppReport.PrinterSetup.PrinterName := fBarcodePrinter;

    cdsBarcodePrint.First;

    if not bScreen then
    begin
      ppReport.DeviceType       := dtPrinter;
      ppReport.ShowPrintDialog  := False;
      ppReport.ShowCancelDialog := False;
    end;

    ppReport.Print;
  end;
end;

function TFrmBarcodePrint.ValidatePrintQueue(Iduser: integer;
  IdBarcode: String): boolean;
var
  sql: String;
  qryValidate: TADOQuery;
begin
  qryValidate := TAdoQuery.Create(nil);
  qryValidate.Connection := dm.ADODBConnect;
  qryValidate.SQL.Text := 'select count(*) record from Inv_BarcodePrintSearch where IdUser = :iduser and IdBarcode = :idbarcode';
  qryValidate.Parameters.ParamByName('iduser').Value := IdUser;
  qryValidate.Parameters.ParamByName('idbarcode').Value := IdBarcode;
  qryValidate.Open;
  result := qryValidate.fieldByname('record').Value  = 0;
end;

function TFrmBarcodePrint.deleteSavePrintQueue(IdBarcode: String; IdUser:integer): boolean;
var
   sql: String;
   qryDelSavePrint: TADOQuery;
begin
   try
       qryDelSavePrint := TADOquery.Create(nil);
       qryDelSavePrint.Connection := dm.ADODBConnect;

       sql := 'delete from Inv_BarcodePrintSearch where IdBarcode = :barcode and IdUser = :iduser';
       qryDelSaveprint.SQL.Text := sql;
       qryDelSavePrint.Parameters.ParamByName('barcode').Value := IdBarcode;
       qryDelSavePrint.Parameters.ParamByName('iduser').Value  := IdUser;
       qryDelSavePrint.ExecSQL;
   finally
       freeAndNil(qryDelSavePrint);
   end;
end;

function TFrmBarcodePrint.getSQL(HasPurchase: boolean): String;
begin
     if ( hasPurchase ) then
        result :=
            'SELECT '+
            '	M.IDModel, '+
            '	M.Model,   '+
            '	M.Description, '+
            '	M.SuggRetail, '+
            '	S.SizeName,   ' +
            '	S.CodSize,    '+
            '	C.Color,	'+
            '	C.CodColor, '+
            '	CT.Name as Category, '+
            '	MG.ModelGroup as SubCategory, '+
            '	MSG.ModelSubGroup as [Group], '+
            '	LTRIM(RTRIM(B.IDBarcode)) IdBarcode, '+
            '	LTRIM(RTRIM(B.IDBarcode)) Barcode, '+
            '	M.PromotionPrice, '+
            '	M.DiscountPerc, ' +
            '	M.VendorCost,   '+
            '	M.AvgCost,      '+
            '	M.SellingPrice, '+
            '	M.LargeImage,   '+
            '	M.LargeImage2,  '+
            '	M.ScaleValidDay, '+
            '	(CASE IsNull(INV.SellingPrice,0) WHEN 0 THEN P.NewSalePrice ELSE INV.SellingPrice END) as Price, '+
            '	(CASE IsNull(INV.SellingPrice,0) WHEN 0 THEN P.NewSalePrice ELSE INV.SellingPrice END) as StoreSellPrice, '+
            '	(CASE IsNull(INV.StoreCostPrice,0) WHEN 0 THEN M.VendorCost ELSE INV.StoreCostPrice END) as StoreCostPrice, '+
            '	(CASE IsNull(INV.StoreAvgPrice,0) WHEN 0 THEN M.AvgCost ELSE INV.StoreAvgPrice END) as StoreAvgPrice,       '+
            '	V.IDPessoa as IDVendor, '+
            '	V.UserCode as VendorNum, '+
            '	V.Pessoa as Vendor,      '+
            '	F.Pessoa as Manufacture, '+
            '	CAST(1 as int) as NumCopy, '+
            '	CAST(DATEADD(day, M.ScaleValidDay, GetDate()) as DateTime) ValidDate '+
            'FROM '+
            '	Barcode B (NOLOCK) '+
            '	JOIN Model M (NOLOCK) ON (B.IDModel = M.IDModel) '+
            '	JOIN TabGroup CT (NOLOCK) ON (M.GroupID = CT.IDGroup) '+
            '	LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) '+
            '	LEFT OUTER JOIN ModelSubGroup MSG (NOLOCK) ON (M.IDModelSubGroup = MSG.IDModelSubGroup) '+
            '	LEFT OUTER JOIN InvSize S (NOLOCK) ON (S.IDSize = M.IDSize) '+
            '	LEFT OUTER JOIN InvColor C (NOLOCK) ON (C.IDColor = M.IDColor) '+
            '	LEFT JOIN Inventory INV (NOLOCK) ON (INV.ModelID = M.IDModel AND INV.StoreID = :StoreID) '+
            ' LEFT OUTER JOIN Pur_PurchaseItem P (NOLOCK) on (B.IDModel = P.IDModel and B.BarcodeOrder = 1 and ct.IDGroup = p.IDGroup)  '+
            '	JOIN #Temp_Barcode TB ON (TB.Barcode = B.IDBarcode) '+
            '	LEFT OUTER JOIN Inv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.IDModel AND MV.VendorOrder = 1) '+
            '	LEFT OUTER JOIN Pessoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa) '+
            '	LEFT OUTER JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa) '+
            'WHERE '+
            '	M.Desativado = 0 '+
            '             and  ( ( :IdPurchase is null ) or ( ( :IdPurchase IS not NULL ) and ( :IdPurchase = P.IdPurchase) ) ) '
     else result :=
            'SELECT  '+
            '	M.IDModel, '+
            '	M.Model,   '+
            '	M.Description, '+
            '	M.SuggRetail, '+
            '	S.SizeName,   ' +
            '	S.CodSize,    '+
            '	C.Color,	'+
            '	C.CodColor, '+
            '	CT.Name as Category, '+
            '	MG.ModelGroup as SubCategory, '+
            '	MSG.ModelSubGroup as [Group], '+
            '	LTRIM(RTRIM(B.IDBarcode)) IdBarcode, '+
            '	LTRIM(RTRIM(B.IDBarcode)) Barcode, '+
            '	M.PromotionPrice, '+
            '	M.DiscountPerc, ' +
            '	M.VendorCost,   '+
            '	M.AvgCost,      '+
            '	M.SellingPrice, '+
            '	M.LargeImage,   '+
            '	M.LargeImage2,  '+
            '	M.ScaleValidDay, '+
            '	(CASE IsNull(INV.SellingPrice,0) WHEN 0 THEN M.SellingPrice ELSE INV.SellingPrice END) as Price, '+
            '	(CASE IsNull(INV.SellingPrice,0) WHEN 0 THEN M.SellingPrice ELSE INV.SellingPrice END) as StoreSellPrice, '+
            '	(CASE IsNull(INV.StoreCostPrice,0) WHEN 0 THEN M.VendorCost ELSE INV.StoreCostPrice END) as StoreCostPrice, '+
            '	(CASE IsNull(INV.StoreAvgPrice,0) WHEN 0 THEN M.AvgCost ELSE INV.StoreAvgPrice END) as StoreAvgPrice,       '+
            '	V.IDPessoa as IDVendor, '+
            '	V.UserCode as VendorNum, '+
            '	V.Pessoa as Vendor,      '+
            '	F.Pessoa as Manufacture, '+
            '	CAST(1 as int) as NumCopy, '+
            '	CAST(DATEADD(day, M.ScaleValidDay, GetDate()) as DateTime) ValidDate '+
            'FROM '+
            '	Barcode B (NOLOCK) '+
            '	JOIN Model M (NOLOCK) ON (B.IDModel = M.IDModel) '+
            '	JOIN TabGroup CT (NOLOCK) ON (M.GroupID = CT.IDGroup) '+
            '	LEFT OUTER JOIN ModelGroup MG (NOLOCK) ON (M.IDModelGroup = MG.IDModelGroup) '+
            '	LEFT OUTER JOIN ModelSubGroup MSG (NOLOCK) ON (M.IDModelSubGroup = MSG.IDModelSubGroup) '+
            '	LEFT OUTER JOIN InvSize S (NOLOCK) ON (S.IDSize = M.IDSize) '+
            '	LEFT OUTER JOIN InvColor C (NOLOCK) ON (C.IDColor = M.IDColor) '+
            '	LEFT JOIN Inventory INV (NOLOCK) ON (INV.ModelID = M.IDModel AND INV.StoreID = :StoreID) '+
            '	JOIN #Temp_Barcode TB ON (TB.Barcode = B.IDBarcode) '+
            '	LEFT OUTER JOIN Inv_ModelVendor MV (NOLOCK) ON (M.IDModel = MV.IDModel AND MV.VendorOrder = 1) '+
            '	LEFT OUTER JOIN Pessoa V (NOLOCK) ON (MV.IDPessoa = V.IDPessoa) '+
            '	LEFT OUTER JOIN Pessoa F (NOLOCK) ON (M.IDFabricante = F.IDPessoa) '+
            'WHERE M.Desativado = 0 ';
end;

//YAA March, 2012 --> Added
function TFrmBarcodePrint.RemoveNegativeValuesAndTrunc(aValue: Variant): Integer;
begin
  Result:= 0;
  if VarIsEmpty(aValue) or VarIsNull(aValue) then Exit;
  
  Result:= Trunc(aValue);
  if Result < 0 then
    Result:= 0;
end;

procedure TFrmBarcodePrint.chkInventoryCopyClick(Sender: TObject);
begin
  inherited;

  //if (cdsBarcodeList.Active) then
  if ( cdsBarcodeList.State = dsBrowse ) then //begin
     //(cdsBarcodeList.RecordCount = 0) then
     begin
       btnRefreshClick(Sender);
       //MsgBox(MSG_CRT_NO_BARCODE, vbCritical + vbOKOnly);
       //Exit;
     end;


  Exit; //YAA --> This method should have not been touched to begin with

  if ( cdsBarcodeList.State = dsBrowse ) then begin
     //YAA Removed --> if ( chkInventoryCopy.Checked ) then begin
        quBarcode.Open;
        if ( not quBarcode.Eof ) then begin
            while ( not cdsBarcodeList.Eof ) do begin
               if ( quBarcode.Locate('IDBarcode', cdsBarcodeList.fieldByName('IdBarcode').value, []) ) then begin
                  cdsBarcodeList.Edit;
                  //YAA (Removed) --> cdsBarcodeList.FieldByName('NumCopy').asInteger := trunc(quBarcode.FieldByName('QtyOnHand').Value);
                  if ( chkInventoryCopy.Checked ) then
                    cdsBarcodeList.FieldByName('NumCopy').asInteger := RemoveNegativeValuesAndTrunc(quBarcode.FieldByName('QtyOnHand').Value) //YAA RemoveNegativeValuesAndTrunc Added.
                  else
                    cdsBarcodeList.FieldByName('NumCopy').asInteger := cdsBarcodeList.FieldByName('NumCopy').asInteger + 1; //YAA Added  
                  cdsBarcodeList.Post;
               end;
               cdsBarcodeList.Next;
            end;
        end;
     //end;
  end;
end;

procedure TFrmBarcodePrint.ppDetailBand1BeforePrint(Sender: TObject);
begin
  inherited;
(*
  if ( edtSkipRep2.Text <> '0' ) then begin
     ppDBText1.Visible := false;
     ppDBText2.Visible := false;
     ppDBText3.Visible := False;
     ppDBText4.Visible := false;
     RBDBEan.Visible   := false;
  end;

  if ( edtSkipRep1.Text <> '0' ) then begin
     ppDBText1.Visible := false;
     ppDBText2.Visible := false;
     ppDBText3.Visible := False;
     ppDBText4.Visible := false;
     RBDBEan.Visible   := false;
  end;
  *)
end;

procedure TFrmBarcodePrint.cdsBarcodeListAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TNumericField(dataset.FieldByName('NumCopy')).DisplayFormat := '######0'
end;

procedure TFrmBarcodePrint.quBarcodePrintAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TNumericField(dataset.FieldByName('NumCopy')).DisplayFormat := '######0';

end;

procedure TFrmBarcodePrint.cdsBarcodeListAfterInsert(DataSet: TDataSet);
begin
  inherited;
  TNumericField(dataset.FieldByName('NumCopy')).DisplayFormat := '######0';
end;

procedure TFrmBarcodePrint.cdsBarcodeListAfterEdit(DataSet: TDataSet);
begin
  inherited;
  //amfsouza 02.24.2012
//  dataset.Post;
end;

procedure TFrmBarcodePrint.grdBarcodeDBDblClick(Sender: TObject);
{
var
  frmUpdateNumCopyBarcode: TfrmUpdateNumCopyBarcode;
  numCopy: Integer; }
begin
  inherited;
{  frmUpdateNumCopyBarcode := TfrmUpdateNumCopyBarcode.Create(Self);
  frmUpdateNumCopyBarcode.Start(cdsBarcodeList);
  cdsBarcodeList := TClientDataSet(frmUpdateNumCopyBarcode.BarcodeList);
}
end;

procedure TFrmBarcodePrint.setToPrintQueue;
begin
   cdsBarcodePrint.close;
   quBarcodePrint.CommandText := getSQL((FIDPurchaseStr <> ''));
   cdsBarcodePrint.FetchParams;
   cdsBarcodePrint.Params.ParamByName('StoreID').Value := DM.fStore.ID;
end;

end.

