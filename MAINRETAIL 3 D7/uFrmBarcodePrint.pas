(*
**********************************************************************************************
Author: Antonio Marcos Souza
Date: Feb, 2017

** Code Cleaned **

"if you don't believe see the previous code in the same folder. The files were renamed like "-old"..."

That screen allows the user print barcodes after some searches. Also, others places from MR can call it.
Following bellow some menus:

- Purchase: Can be called by Receiving / Final Receiving / Purchase History

- Inventory: Can be called through a model/product

- Transfer: Can be called through of one identifier related to a transfer ( "IdTransfer" ).

*** about de logic inside the code ***

- All search are got through cdsBarcode. This one fills the grid on the top ( just to List and LastUpdate Pages )
- Always cdsBarcodeList starts empty because this structure will be used to get records from cdsBarcode
- CdsBarcodeList stays alive as soon as created and dies just on the end ( form close )
- CdsBarcode feeds cdsBarcodeList record by record after some search.
- Use the GetBarcodeSearchSQL according to search conditions

Notes:
I hope have helped someone with the comments above and have done a good clean work to make my life and the life
the other people easier.

****************************************************************************************************************
Version : (297 - 314)
Date    : 10.31.2011
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Print barcode from Inventory Maintenance
Version : (297 - 315)
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
  ppParameter, ppStrtch, ppMemo;

type
  TSearchBarCode = (sbBarcode, sbModel, sbVendor);

  TFrmBarcodePrint = class(TFrmParentAll)
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
    lbReport2: TLabel;
    edtReportFile2: TEdit;
    btnOpenFile2: TSpeedButton;
    btRemove2: TSpeedButton;
    quBarcodePrint: TADODataSet;
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
    pgFilter: TPageControl;
    tsMultiple: TTabSheet;
    lbListTab: TLabel;
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
    lbLastUpdateTab: TLabel;
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
    lbPrinQueue: TLabel;
    Panel4: TPanel;
    Panel14: TPanel;
    btadd: TBitBtn;
    btAddAll: TBitBtn;
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
    btAddLast: TBitBtn;
    btAddAllLast: TBitBtn;
    btClearLastUpdate: TBitBtn;
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
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    btColumn: TSpeedButton;
    btColumn2: TSpeedButton;
    Bevel9: TBevel;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    RBDBEan: TRBDBEan;
    ppDBText4: TppDBText;
    ppDBText1: TppDBText;
    ppDBImage1: TppDBImage;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBPipelineppField28: TppField;
    ppDBPipelineppField29: TppField;
    ppDBText8: TppDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
//    procedure btnClearListClick(Sender: TObject);
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
    procedure cdsBarcodeAfterScroll(Dataset: TDataset);
    procedure chkInventoryCopyClick(Sender: TObject);
    procedure btnClearListClick(Sender: TObject);
    procedure quBarcodePrintAfterOpen(DataSet: TDataSet);
    procedure cdsBarcodeListAfterInsert(DataSet: TDataSet);
    procedure cdsBarcodeAfterOpen(DataSet: TDataSet);
    procedure cdsBarcodeListAfterOpen(DataSet: TDataSet);
    
  private
    FIsOutFromPrint: Boolean;
    FBarcode: String;
    FIDPurchaseStr: String;
    AView: TCxCustomGridTableView;
    fIDModel : Integer;
    fReportFile,
    fReportFile2,
    fBarcodePrinter,
    fNCopiesField : String;

    bSavePrinter : Boolean;

    // Antonio 02/22/2017
    dsBarcode: TDataSource;
    dsBarcodeList: TDataSource;
    cdsBarcode: TClientDataset;           // dataset related to records from search, after press "go" button
    cdsBarcodeList: TClientDataset;       // An empty dataset to load after press "add barcode" or "add all barcode" buttons
    cdsQueueFromDatabase: TClientDataset; // Get queue saved on database to load according settings.

    procedure CreateEmptyBarcodeList();
    procedure EnableAliasFielsToBarcodeList();
    procedure SavePrintQueue();
    procedure MoveBarcodeListToSavePrint();
    procedure DisplayRecordsAtQueue(argCount: Integer = 0);
    procedure DisplayRecordsFromSearch(argCount: Integer = 0);
    procedure MovePurchaseBarcodesToQueue(argIdPurchase: String; argNumberCopies: Integer= 1);
    procedure MoveTransferBarcodesToQueue(argIdTransfer: String);
    procedure EnableBarcodeButtons(argDataset: TDataset);
    procedure EnableBarcodeQueueButtons(argDataset: TDataset);

    function ValidateSearch: boolean;
    function hasSearch(idUser: integer): boolean;
// Antonio 03/08/2017    function fillBarcode: boolean;
    //amfsouza 04.07.2011
    function deleteSavePrintQueue(IdBarcode: String; IdUser: integer): boolean;

    //amfsouza 04.04.2011 - due new implementation.
    function ValidatePrintQueue(Iduser: integer; IdBarcode: String): boolean;
    function DirectToPrint(bScreen: boolean; argBarcodesToPrint: TClientDataset): boolean;

    procedure ShowColumn(AView : TcxCustomGridTableView; pCustomize : Boolean);
    procedure BarcodeOpen;
    procedure BarcodeClose;
    procedure BarcodeRefresh;

    // AmfSouza November 12, 2012: addition of new parameters due images and others.
    procedure AddBarcode(Barcode, Description, Model: String; Qty: Integer;
      SellingPrice: Currency; IdModel: Integer = 0; QtyOnHand: double = 0.0;
      StorePrice: Currency = 0.0; pLargeImage: String = '';
      pLargeImage2: String = ''; pManufacturer: String = '';
      pVendorNum: String = ''; pVendor: String = ''; pSizeName: String = '';
      pColorName: String = ''; pColorCode: String = ''; pModelToScan: String = '';
      pBarcodeToScan: String = '');

    procedure AddAllBarcode;

    procedure PrintReport(Report : Integer; bScreen : Boolean);

    procedure CreateTempTable;
    procedure DropTempTaple;
    procedure DeleteTempTable;
    procedure InsertTempTable(Report:Integer);

    procedure SaveReportFile(Report:String);
    procedure SaveReportFile2(Report:String);
    procedure SortReportOrder(var sort_indexname: String; gridReport: TcxGridDBTableView);
    //amfsouza 05.02.2012 - fill new structure to print
    procedure fillCdsReport(var cds: TClientDataSet);

    //amfsouza 05.03.2012 - get specif fields to print.
    function getCdsToPrint: TClientDataSet;
    function sendStraightToPrinter(var qtyVerified: boolean; argBarcodesToPrint: TClientDataset; toPrinter, printLabel: boolean;
    qtyFormula: extended = 0): boolean;

    //procedure InsertBarcodeList();
    //procedure UpdateBarcodeList();
    procedure MoveSavedQueueFromDatabaseToScreen();

    procedure InsertBarcodesInTemporaryTable(argBarcodesToPrint: TClientDataset);
    procedure PrintBarcodes();

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
  (* Goal: move all records from the search to the queue list *)
  {
  if ( pgFilter.ActivePageIndex = 2 ) then begin
      exit;
  end;
  }
  
  if ( not cdsBarcode.IsEmpty ) then begin

     grdBarcodeDb.DataController.DataSource := dsBarcodeList;

     if ( not sendStraightToPrinter(qtyVerified, cdsBarcode, chkSendToPrinter.Checked, chkInventoryCopy.Checked) ) then begin

         if ( cdsBarcode.RecordCount > 100 ) then begin
             msgWarning := 'You are about to add ' + intToStr(cdsBarcode.RecordCount) + ' models. Do you wish to continue ?';
             if ( Application.MessageBox(Pchar(msgWarning), 'Warning', mb_YESNO + mb_IconWarning) = idYes ) then
             else begin
                exit;
             end;
         end;

     end;

     // add each barcode from barcode to  barcode list
     cdsBarcodeList.DisableControls;
     cdsBarcode.DisableControls;

     while ( not cdsBarcode.Eof ) do begin
          AddBarcode(cdsBarcode.FieldByName('IDBarcode').AsString,
                     cdsBarcode.FieldByName('Description').AsString,
                     cdsBarcode.FieldByName('Model').AsString,
                     cdsBarcode.FieldByName(fNCopiesField).AsInteger,
                     cdsBarcode.FieldByName('SellingPrice').AsCurrency,
                     cdsBarcode.FieldByName('IdModel').AsInteger,
                     cdsBarcode.FieldByName('QtyOnHand').asFloat,
                     cdsBarcode.FieldByName('StoreAvgPrice').asCurrency,
                     cdsBarcode.FieldByName('LargeImage').asString,          // new
                     cdsBarcode.FieldByName('LargeImage2').asString,         // new
                     cdsBarcode.FieldByName('Manufacturer').asString,        // new
                     cdsBarcode.FieldByName('VendorNum').asString,           // new
                     cdsBarcode.FieldByname('Vendor').asString,              // new

                     // AmfSouza November 08, 2012: new fields to get size and color
                     cdsBarcode.FieldByName('SizeName').asString,
                     cdsBarcode.FieldByName('Color').AsString,
                     cdsBarcode.FieldByName('CodColor').AsString,

                     // AmfSouza November 12, 2012: new fields to allow use scan
                     cdsBarcode.FieldByName('ModelToScan').asString,
                     cdsBarcode.FieldByName('BarcodeToScan').asString
                   );

          cdsBarcode.Next();
     end;

     cdsBarcode.EnableControls;
     cdsBarcodeList.EnableControls;

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
  if ( cdsBarcode <> nil ) then begin
      with cdsBarcode do
        if Active then
           Close;
  end;
end;

procedure TFrmBarcodePrint.BarcodeRefresh;
var
  _onlyItem: String;
  _numberBarcodeCopies: extended;
  _verifyQuantity: Boolean;
  _isEmptyTrue: Boolean;   // It will be used to get an empty tuple ( empty record ) to the same SQL triggered.
  _isEmptyFalse: Boolean;
begin
  Screen.Cursor := crHourGlass;

  if ( Assigned(cdsBarcode) ) then begin
     FreeAndNil(cdsBarcode);

  end;

  _isEmptyTrue := true;
  _isEmptyFalse := false;

  case ( pgFilter.ActivePageIndex ) of
      0 : begin

          // search from dynamic type selected
          if ( cbxType.ItemIndex <> -1 ) then begin
             cdsBarcode := dm.GetBarcodeSearch(dm.GetBarcodeSearchSQL
                (cbxType.ItemIndex, cbxMethod.ItemIndex, edModel.Text, chkInventoryCopy.Checked, chkPrimaryUpc.Checked,
                _isEmptyFalse));

          end else begin
                  cdsBarcode := dm.GetBarcodeSearch(dm.GetBarcodeSearchSQL(cmbCategory.LookUpValue,
                  scModelGroup.LookUpValue, scModelSubGroup.LookUpValue ,
                  chkInventoryCopy.Checked, chkPrimaryUpc.Checked, _isEmptyFalse));
              end;

          BarcodeOpen();
          EnableBarcodeButtons(cdsBarcode);

          dsBarcode.DataSet := cdsBarcode;
          CreateEmptyBarcodeList();

          DisplayRecordsFromSearch(cdsBarcode.RecordCount);
          DisplayRecordsAtQueue(cdsBarcodeList.RecordCount);

          grdBarcodeByListDB.DataController.DataSource := dsBarcode;
          grdBarcodeDB.DataController.DataSource := dsBarcodeList;
      end;

      1: begin
         cdsBarcode := dm.GetBarcodeSearch(dm.GetBarcodeSearchSQL(dtStart.Date, dtEnd.Date, chkInventoryCopy.Checked,
                      chkPrimaryUpc.Checked, _isEmptyFalse));

         BarcodeOpen();
         CreateEmptyBarcodeList();

         DisplayRecordsFromSearch(cdsBarcode.RecordCount);
         DisplayRecordsAtQueue(cdsBarcodeList.RecordCount);

         dsBarcode.DataSet := cdsBarcode;
         grdBarcodeLastUpdateDB.DataController.DataSource := dsBarcode;
         grdBarcodeDB.DataController.DataSource := dsBarcodeList;

      end;

      2: begin
         _numberBarcodeCopies := 1;

         if ( pos('*', edtSearch.Text) > 0 ) then begin
            _numberBarcodeCopies := strToFloat(copy(edtSearch.Text, 1, (pos('*', edtSearch.Text) -1)));
         end;

         //amfsouza 03.03.2011 - get only relevant part to search.
         _onlyItem := copy(edtSearch.Text, ( pos('*', edtSearch.Text) + 1 ), length(edtSearch.Text) );

         if ( FIsOutFromPrint ) then begin
             if ( _onlyItem = '' ) then begin
                _onlyItem := FBarcode;
                cbxSearchType.ItemIndex := 0;
             end;
         end;

         cdsBarcode := dm.GetBarcodeSearch(dm.GetBarcodeSearchSQL
             (cbxSearchType.ItemIndex, _onlyItem, scVendor.LookUpValue,
             chkInventoryCopy.Checked, chkPrimaryUpc.Checked, FloatToStr(_numberBarcodeCopies), _isEmptyFalse));


         BarcodeOpen();
         CreateEmptyBarcodeList();
         dsBarcode.DataSet := cdsBarcode;
         grdBarcodeDB.DataController.DataSource := dsBarcodeList;

         DisplayRecordsFromSearch(cdsBarcode.RecordCount);
         DisplayRecordsAtQueue(cdsBarcodeList.RecordCount);

         if ( chkSendToPrinter.Checked ) then begin
             _verifyQuantity := true;
             sendStraightToPrinter(_verifyQuantity, cdsBarcode, chkSendToPrinter.Checked, chkInventoryCopy.Checked, _numberBarcodeCopies );
         end else begin
                 AddAllBarcode();
             end;

      end;
  end;

  Screen.Cursor := crDefault;
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
  _numberCopies: Integer;
begin
  FIDPurchaseStr := IdPurchase;
  if IDPurchase <> ''then begin
     fNCopiesField := 'NumCopy';

     _numberCopies := 1;
     cdsBarcode := dm.GetBarcodeSearch(dm.GetBarcodeSearchSQL
                                   (FIDPurchaseStr, chkInventoryCopy.Checked, chkPrimaryUpc.Checked, _numberCopies));
     BarcodeOpen;
     try
         purchaseBarcodeMessage := TfrmPurchaseBarcodeMessage.Create(nil);
         toMerge := ( purchaseBarcodeMessage.start = 0 );

         if ( not toMerge ) then begin
             CreateEmptyBarcodeList();
         end;

         MovePurchaseBarcodesToQueue(FIDPurchaseStr, _numberCopies);

     finally
         freeAndNil(purchaseBarcodeMessage);
     end;

  end;

  ShowModal;

end;

function TFrmBarcodePrint.Start(IDModel, Barcode: String): Boolean;
begin

    if IDModel <> '' then
       fIDModel := StrToInt(IDModel)
    else
       fIDModel := 0;

    fNCopiesField := 'NumCopy';
    if ( chkInventoryCopy.Checked ) then begin
        fNCopiesField := 'QtyOnHand';

    end;

    fIsOutFromPrint := false;

    if fIDModel <> 0 then begin
      pgFilter.ActivePageIndex := 2;
      cbxSearchType.ItemIndex := 0; // Barcode type selected
      FBarcode := Barcode;
      FIsOutFromPrint := true;
      BarcodeRefresh();
    end else begin
            cdsBarcode := dm.GetBarcodeSearch(dm.GetBarcodeSearchSQL(fIdModel, chkInventoryCopy.Checked, chkPrimaryUpc.Checked));
            CreateEmptyBarcodeList();
            grdBarcodeByListDB.DataController.DataSource := dsBarcode;
        end;

    ShowModal;

end;

procedure TFrmBarcodePrint.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  BarcodeClose;
  DropTempTaple;

  if ( assigned(cdsBarcode) ) then begin
     FreeAndNil(cdsBarcode);
  end;

  if ( assigned(cdsBarcodeList) ) then begin
      // amfsouza 03.02.2011 - clear queue after close screen.
      if ( cdsBarcodeList.Active ) then begin
         cdsBarcodeList.EmptyDataSet;
      end;

      FreeAndNil(cdsBarcodeList);

  end;

  Action := caFree;
end;

procedure TFrmBarcodePrint.AddBarcode(Barcode, Description, Model: String;
  Qty: Integer; SellingPrice: Currency; IdModel: Integer = 0;
  QtyOnHand: double = 0.0; StorePrice: Currency = 0.0; pLargeImage: String = '';
  pLargeImage2: String = ''; pManufacturer: String = '';
  pVendorNum: String = ''; pVendor: String = ''; pSizeName: String = '';
  pColorName: String = ''; pColorCode: String = ''; pModelToScan: String = '';
  pBarcodeToScan: String = '');
begin
  Barcode := Trim(Barcode);

  EnableAliasFielsToBarcodeList();

  dsBarcodeList.DataSet := cdsBarcodeList;
  grdBarcodeDB.DataController.DataSource := dsBarcodeList;

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

    // AmfSouza November 07, 2012
    cdsBarcodeList.FieldByName('LargeImage').Value := pLargeImage;
    cdsBarcodeList.FieldByName('LargeImage2').Value := pLargeImage2;
    cdsBarcodeList.FieldByName('Manufacturer').Value := pManufacturer;
    cdsBarcodeList.FieldByName('VendorNum').Value := pVendorNum;
    cdsBarcodeList.FieldByName('Vendor').Value := pVendor;

    // AmfSouza November 08, 2012: added to get size and color
    cdsBarcodeList.FieldByName('SizeName').value := pSizeName;
    cdsBarcodeList.FieldByName('Color').value := pColorName;
    cdsBarcodeList.FieldByName('CodColor').value := pColorCode;

    // AmfSouza November 12, 2012: added to allow to use scan
    cdsBarcodeList.fieldByname('ModelToScan').Value := pModelToScan;
    cdsBarcodeList.fieldByname('BarcodeToScan').value := pBarcodeToScan;


    cdsBarcodeList.Post;

    DisplayRecordsAtQueue(cdsBarcodeList.RecordCount);
  end;


end;

procedure TFrmBarcodePrint.btAddClick(Sender: TObject);
begin
  inherited;

  if ( cdsBarcode.Active and ( not cdsBarcode.IsEmpty ) ) then begin
      AddBarcode(cdsBarcode.FieldByName('IDBarcode').AsString,
                 cdsBarcode.FieldByName('Description').AsString,
                 cdsBarcode.FieldByName('Model').AsString,
                 cdsBarcode.FieldByName(fNCopiesField).AsInteger,
                 cdsBarcode.FieldByName('SellingPrice').AsCurrency,
                 cdsBarcode.FieldByName('IdModel').AsInteger,
                 cdsBarcode.FieldByName('QtyOnHand').AsInteger,
                 cdsBarcode.FieldByname('StoreAVGPrice').AsCurrency,
                 cdsBarcode.FieldByName('LargeImage').asString,         // new
                 cdsBarcode.FieldByName('LargeImage2').asString,        // new
                 cdsBarcode.FieldByName('Manufacturer').asString,       // new
                 cdsBarcode.FieldByName('VendorNum').asString,          // new
                 cdsBarcode.FieldByName('Vendor').asString,

                 // AmfSouza November 08, 2012: to get size and color
                 cdsBarcode.FieldByName('SizeName').AsString,
                 cdsBarcode.FieldByName('Color').AsString,
                 cdsBarcode.FieldByName('CodColor').AsString,

                 // AmfSouza November 12, 2012: to allow to use of scan
                 cdsBarcode.FieldByname('ModelToScan').asString,
                 cdsBarcode.FieldByName('BarcodeToScan').asString
                 );
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
        DisplayRecordsAtQueue(cdsBarcodeList.RecordCount);
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

  if ( not cdsBarcodeList.Active ) then begin
      cdsBarcodeList.Open();
  end;


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

  // Antonio 02/27/2017
  dsBarcode := TDataSource.Create(self);
  dsBarcodeList := TDataSource.Create(self);

  CreateEmptyBarcodeList();
  EnableAliasFielsToBarcodeList();

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
  if ( hasSearch(dm.fUser.ID) ) then begin
      MoveSavedQueueFromDatabaseToScreen();
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
        DisplayRecordsAtQueue(cdsBarcodeList.RecordCount);
      end;
      cdsBarcodeList.EnableControls;
    end;
end;

function TFrmBarcodePrint.StartTransfer(IDTransfer: String): Boolean;
var
  sOldSql, sWhere, sModels: String;
begin
  if IDTransfer <> ''then begin
     fNCopiesField := 'NumCopy';
     cdsBarcode := dm.GetBarcodeSearch(dm.GetBarcodeSearchSQL(IDTransfer));
     BarcodeOpen;

     MoveTransferBarcodesToQueue(IDTransfer);

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

procedure TFrmBarcodePrint.PrintReport(Report: Integer; bScreen : Boolean);
var
  sPrintReport : String;
  i, iEnd : Integer;
  msgWarning: String;
  filterBarcodeToPrint: String;
  fCdsReport: TClientDataSet;
  sortIndexName: String;
begin
  fCdsReport := getCdsToPrint;
  fillCdsReport(fCdsReport);
  cdsBarcodePrint.Data := fCdsReport.Data;

  sortIndexName := '';
  SortReportOrder(sortIndexName, grdBarcodeDB);

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

    // amfsouza 05.03.2012
    if ( sortIndexName <> '' ) then
       cdsBarcodePrint.DeleteIndex(sortIndexName);

  end;

  cdsBarcodePrint.EmptyDataSet;
  freeAndNil(fCdsReport);

end;

procedure TFrmBarcodePrint.btAddAllClick(Sender: TObject);
begin
  inherited;
  AddAllBarcode;
end;

procedure TFrmBarcodePrint.pgFilterChange(Sender: TObject);
begin
  inherited;
  // change page clean the records.
  if ( cdsBarcode <> nil ) then begin
      if ( cdsBarcode.Active ) then begin
         cdsBarcode.EmptyDataSet;
         DisplayRecordsFromSearch(cdsBarcode.RecordCount);
      end;

      FreeAndNil(cdsBarcode);
  end;

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

procedure TFrmBarcodePrint.SortReportOrder(var sort_indexname: String; gridReport: TcxGridDBTableView);
var
  i, iType: Integer;
  sSortOrder : String;
  cxOrder : TcxGridSortOrder;
  indexOptions: TIndexOptions;
begin
  (*** YAA April 26, 2012 - For clarification purposes. Note that ***)
  (*** TcxDataSortOrder = (soNone, soAscending, soDescending);    ***)

  sSortOrder := '';
  for i := 0 to gridReport.ColumnCount -1 do begin
    cxOrder := gridReport.Columns[i].SortOrder;
    sSortOrder := gridReport.Columns[i].DataBinding.FieldName;

    //amfsouza 05.03.2012 - work around names to avoid field name conflict between structures.
    if ( sSortOrder <> '' ) then begin
        if ( sSortOrder = 'SellingPrice' ) then
           sSortOrder := 'Price';

        if ( sSortOrder = 'idbarcode' ) then
           sSortOrder := 'Barcode';

    end;

    if cxOrder = TCxDataSortOrder(0) then
      begin
      end
    else if cxOrder = TCxDataSortOrder(1) then begin
            cdsBarcodePrint.IndexFieldNames := sSortOrder;
            indexOptions := [];
            cdsBarcodePrint.AddIndex('orderAsc', sSortOrder, indexOptions);
            cdsBarcodePrint.IndexName := 'orderAsc';
            sort_indexname := cdsBarcodePrint.IndexName;
            //iType := ORDER_ASC;
            Break;
      end
    else if cxOrder = TCxDataSortOrder(2) then begin
            cdsBarcodePrint.IndexFieldNames := sSortOrder;
            indexOptions := [ixDescending];
            cdsBarcodePrint.AddIndex('orderDesc', sSortOrder, indexOptions);
            cdsBarcodePrint.IndexName := 'orderDesc';
            sort_indexname := cdsBarcodePrint.IndexName;
            //iType := ORDER_DESC;
            Break;
      end;
  end;
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
//  TNumericField(dataset.FieldByName('NumCopy')).DisplayFormat := '######0';
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


procedure TFrmBarcodePrint.pgFilterChanging(Sender: TObject;
  var AllowChange: Boolean);
var
  listHasItems: boolean;
begin
  inherited;
end;

(*
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
*)

function TFrmBarcodePrint.hasSearch(idUser: integer): boolean;
var
   _sql: String;
begin
   try
     _sql := 'select * from Inv_BarcodePrintSearch where idUser = :prm_iduser';
     cdsQueueFromDatabase := dm.GetBarcodeSearch(_sql);
     cdsQueueFromDatabase.Params.ParamByName('prm_idUser').Value := idUser;
     cdsQueueFromDatabase.Open;
     result := not cdsQueueFromDatabase.IsEmpty;
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

function TFrmBarcodePrint.sendStraightToPrinter(var qtyVerified: boolean; argBarcodesToPrint: TClientDataset; toPrinter, printLabel: boolean; qtyFormula: extended = 0): boolean;
var
   straightToPrinter: boolean;
   msgWarning: String;
begin  
   straightToPrinter := toPrinter;
   if ( straightToPrinter ) then begin
      argBarcodesToPrint.Last;
      argBarcodesToPrint.Filter := 'IdBarcode = ' + quotedStr(argBarcodesToPrint.fieldByname('IdBarcode').Value);
      argBarcodesToPrint.Filtered := true;
      if ( printLabel ) then begin
          if ( argBarcodesToPrint.FieldByName('qtyOnHand').Value > 20 ) then begin
             qtyVerified := true;
             msgWarning := IntToStr(argBarcodesToPrint.RecordCount) + ' will be printed. Continue ?';
             if ( Application.MessageBox(Pchar(msgWarning), 'Greather than 20 labels', mb_YESNO + mb_IconWarning) = idYes ) then begin
                DirectToPrint(false, argBarcodesToPrint);
                result := true;
                edtSearch.Clear;
             end;
          end;
          if ( qtyFormula > 20 ) then begin
             qtyVerified := true;
             msgWarning := FloatToStr(qtyFormula) + ' will be printed. Continue ?';
             if ( Application.MessageBox(Pchar(msgWarning), 'Greather than 20 labels', mb_YESNO + mb_IconWarning) = idYes ) then begin
                DirectToPrint(false, argBarcodesToPrint);
                edtSearch.Clear;
                result := true;
             end;
          end
          else begin
              DirectToPrint(false, argBarcodesToPrint);
              edtSearch.Clear;
              result := true;

          end;
      end
      else begin
          DirectToPrint(false, argBarcodesToPrint);
          edtSearch.Clear;
          result := true;
      end;

      argBarcodesToPrint.Filter := '';
      argBarcodesToPrint.Filtered := false;
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
begin

  FIDPurchaseStr := '';

  //*** YAA --> Added ***
  if ( not chkSaveQueue.Checked ) then
  begin
    btDelAllClick(Sender);
    Exit;
  end;
  //*********************

  SavePrintQueue();

  inherited;
end;

procedure TFrmBarcodePrint.cdsBarcodeAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if ( FIDPurchaseStr = '' ) then
     TFloatField(dataset.FieldByName('qtyOnHand')).DisplayFormat := '#,##0.00';

  TNumericField(dataset.fieldByName('NumCopy')).DisplayFormat := '######0';
  EnableBarcodeButtons(dataset);
end;

function TFrmBarcodePrint.DirectToPrint(bScreen: boolean; argBarcodesToPrint: TClientDataset): boolean;
var
   i, J, iEnd: integer;
   SQL: String;
   msgWarning, sPrintReport: String;
   FieldToSwitch: string; //YAA April 26, 2012 --> Added
begin
  // delete records from Temp_Barcode ( temporary table )
  DeleteTempTable;

   // insert barcode in Temp_Barcode ( temporary table ) according to Number of copies or Quantity On Hand from Inventory
   InsertBarcodesInTemporaryTable(argBarcodesToPrint);

   // print barcode
   PrintBarcodes();
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
        cdsBarcode.Open;
        if ( not cdsBarcode.Eof ) then begin
            while ( not cdsBarcodeList.Eof ) do begin
               if ( cdsBarcode.Locate('IDBarcode', cdsBarcodeList.fieldByName('IdBarcode').value, []) ) then begin
                  cdsBarcodeList.Edit;
                  //YAA (Removed) --> cdsBarcodeList.FieldByName('NumCopy').asInteger := trunc(quBarcode.FieldByName('QtyOnHand').Value);
                  if ( chkInventoryCopy.Checked ) then
                    cdsBarcodeList.FieldByName('NumCopy').asInteger := RemoveNegativeValuesAndTrunc(cdsBarcode.FieldByName('QtyOnHand').Value) //YAA RemoveNegativeValuesAndTrunc Added.
                  else
                    cdsBarcodeList.FieldByName('NumCopy').asInteger := cdsBarcodeList.FieldByName('NumCopy').asInteger + 1; //YAA Added  
                  cdsBarcodeList.Post;
               end;
               cdsBarcodeList.Next;
            end;
        end;
  end;
end;

procedure TFrmBarcodePrint.cdsBarcodeListAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TNumericField(dataset.FieldByName('NumCopy')).DisplayFormat := '######0';
  EnableBarcodeQueueButtons(Dataset);
end;

procedure TFrmBarcodePrint.cdsBarcodeListAfterInsert(DataSet: TDataSet);
begin
  inherited;
  TNumericField(dataset.FieldByName('NumCopy')).DisplayFormat := '######0';
end;

function TFrmBarcodePrint.getCdsToPrint: TClientDataSet;
var
   cds: TClientDataSet;
begin
   //amfsouza 05.03.2012 - create dataset
   result := nil;
   cds     := TClientDataSet.Create(nil);
   cds.FieldDefs.add('IdModel', ftInteger, 0, false);
   cds.FieldDefs.Add('Model', ftString, 20, false);
   cds.FieldDefs.Add('Description', ftString, 50, false);
   cds.FieldDefs.add('Barcode', ftString, 20, false);
   cds.FieldDefs.Add('Price', ftCurrency);
   cds.FieldDefs.Add('QtyOnHand', ftInteger, 0, false);
   cds.FieldDefs.Add('Report', ftString, 7, false);
   cds.FieldDefs.Add('NumCopy', ftInteger, 0, false);

   // AmfSouza November 06, 2012: added new fields
   cds.FieldDefs.Add('LargeImage', ftString, 255, false);
   cds.FieldDefs.Add('LargeImage2', ftString, 255, false);
   cds.FieldDefs.Add('Manufacturer', ftString, 50, false);
   cds.FieldDefs.Add('Vendor', ftString, 50, false);
   cds.FieldDefs.Add('VendorNum', ftString, 06, false);
   cds.FieldDefs.Add('Category', ftString, 30, false);

   // AmfSouza November 08, 2012: added to get size and color
   cds.FieldDefs.Add('SizeName', ftString, 20, false);
   cds.FieldDefs.Add('Color', ftString, 20, false);
   cds.FieldDefs.Add('CodColor', ftString, 10, false);

   // AmfSouza November 12, 2012: added to allow to use to scan
   cds.FieldDefs.Add('ModelToScan', ftString, 22, false);
   cds.FieldDefs.Add('BarcodeToScan', ftString, 22, false);


//AmfSouza November 06, 2012 future add promotion price and price breaks

   cds.CreateDataSet;
   result := cds;
end;

procedure TFrmBarcodePrint.fillCdsReport(var cds: TClientDataSet);
var
  bmk: TBookmark;
  i: Integer;
begin
  bmk := cdsBarcodeList.GetBookmark();

  cdsBarcodeList.Last;
  while ( not cdsBarcodeList.Bof ) do begin
     for i:= 1 to cdsBarcodeList.fieldByName('NumCopy').AsInteger do begin
        cds.Insert();
        cds.FieldByName('Description').Value := cdsBarcodeList.fieldByname('Description').Value;
        cds.FieldByName('Model').Value       := cdsBarcodeList.fieldByname('Model').Value;
        cds.FieldByName('Barcode').Value     := cdsBarcodeList.fieldByName('IdBarcode').Value;
        cds.FieldByName('Price').Value       := cdsBarcodeList.fieldByName('SellingPrice').Value;
        cds.FieldByName('QtyOnHand').Value   := cdsBarcodeList.fieldByName('QtyOnHand').Value;
        cds.FieldByName('Report').Value      := cdsBarcodeList.fieldByName('Report').Value;
        cds.FieldByName('NumCopy').Value     := cdsBarcodeList.fieldByName('NumCopy').Value;
        cds.FieldByName('LargeImage').Value  := cdsBarcodeList.fieldByName('LargeImage').Value;
        cds.FieldByName('LargeImage2').Value  := cdsBarcodeList.fieldByName('LargeImage2').Value;

        // AmfSouza November 08, 2012: added new fields to get size an color
        cds.FieldByName('SizeName').Value     := cdsBarcodeList.fieldByName('SizeName').Value;
        cds.FieldByName('Color').Value  := cdsBarcodeList.fieldByName('Color').Value;
        cds.FieldByName('CodColor').Value  := cdsBarcodeList.fieldByName('CodColor').Value;

        // AmfSouza November 12, 2012: added to allow to use of scan
        cds.FieldByName('ModelToScan').Value  := cdsBarcodeList.fieldByName('ModelToScan').Value;
        cds.FieldByName('BarcodeToScan').Value  := cdsBarcodeList.fieldByName('BarcodeToScan').Value;

        cds.Post;
     end;

     cdsBarcodeList.Prior;
  end;

  cdsBarcodeList.GotoBookmark(bmk);
  //freeAndNil(bmk);

end;

procedure TFrmBarcodePrint.SavePrintQueue();
begin
  // setting to save the queue in the database to a future print
  if ( chkSaveQueue.Checked ) then begin

     //  move records from barcode list ( cdsBarcodeList ) to save on the database
     if ( not cdsBarcodeList.IsEmpty ) then begin
        MoveBarcodeListToSavePrint();
      end;
  end;    

end;

procedure TFrmBarcodePrint.MoveBarcodeListToSavePrint();
var
   _straightToPrinter: Integer;
   _saveQueue: Integer;
   _makeLabelEqualQtyOnHand: Integer;
   _primaryUPC: Integer;
begin
   try
     _straightToPrinter := 0;
     _saveQueue := 0;
     _makeLabelEqualQtyOnHand := 0;
     _primaryUPC := 0;

     cdsBarcodeList.First;
     while ( not cdsBarcodeList.Eof ) do begin
       //*** YAA April 27, 2012: From above ***
       if ( ValidatePrintQueue(dm.fUser.ID, cdsBarcodeList.FieldByName('IdBarcode').Value) ) then begin

          if ( chkSendToPrinter.Checked ) then begin
             _straightToPrinter := 1;
          end;

          if ( chkSaveQueue.Checked ) then begin
             _saveQueue := 1;
          end;

          if ( chkInventoryCopy.Checked ) then begin
             _makeLabelEqualQtyOnHand := 1;
          end;

          if (chkPrimaryUpc.Checked ) then begin
             _primaryUPC := 1;
          end;

          dm.InsertBarcodePrintQueue(dm.fUser.ID
                ,cdsBarcodeList.fieldByName('idmodel').value
                ,cdsBarcodeList.fieldByName('model').AsString
                ,cdsBarcodeList.fieldByName('description').AsString
                ,cdsBarcodeList.fieldByName('idbarcode').Value
                ,cdsBarcodeList.fieldByName('qtyonhand').AsFloat
                ,cdsBarcodeList.fieldByName('sellingprice').asCurrency
                ,cdsBarcodeList.fieldByName('numcopy').asFloat
                ,cdsBarcodeList.FieldByName('report').asString
                ,cbxSearchType.ItemIndex
                ,_straightToPrinter
                ,_saveQueue
                ,_makeLabelEqualQtyOnHand
                ,_primaryUPC
                ,cdsBarcodeList.fieldByName('largeimage').AsString
                ,cdsBarcodeList.fieldByName('largeimage2').asString
                ,cdsBarcodeList.fieldByName('manufacturer').AsString
                ,cdsBarcodeList.fieldByName('vendornum').asstring
                ,cdsBarcodeList.fieldByName('vendor').AsString
                ,cdsBarcodeList.FieldByName('sizename').AsString
                ,cdsBarcodeList.fieldByName('color').AsString
                ,cdsBarcodeList.fieldByName('codcolor').AsString
                ,cdsBarcodeList.fieldByName('modeltoscan').asstring
                ,cdsBarcodeList.fieldByName('barcodetoscan').asstring);

       end else begin
                dm.UpdateBarcodePrintQueue(cdsBarcodeList.fieldByName('numcopy').AsFloat
                   ,cdsBarcodeList.FieldByName('report').AsString
                   ,cbxSearchType.ItemIndex
                   ,_straightToPrinter
                   ,_saveQueue
                   ,_makeLabelEqualQtyOnHand
                   ,_primaryUPC
                   ,cdsBarcodeList.fieldByName('idmodel').value
                   ,cdsBarcodeList.fieldByName('model').AsString
                   ,cdsBarcodeList.fieldByName('description').AsString
                   ,cdsBarcodeList.fieldByName('qtyonhand').AsFloat
                   ,cdsBarcodeList.fieldByName('sellingprice').asCurrency
                   ,cdsBarcodeList.fieldByName('largeimage').AsString
                   ,cdsBarcodeList.fieldByName('largeimage2').asString
                   ,cdsBarcodeList.fieldByName('manufacturer').AsString
                   ,cdsBarcodeList.fieldByName('vendornum').asstring
                   ,cdsBarcodeList.fieldByName('vendor').AsString
                   ,cdsBarcodeList.FieldByName('sizename').AsString
                   ,cdsBarcodeList.fieldByName('color').AsString
                   ,cdsBarcodeList.fieldByName('codcolor').AsString
                   ,cdsBarcodeList.fieldByName('modeltoscan').asstring
                   ,cdsBarcodeList.fieldByName('barcodetoscan').asstring
                   ,cdsBarcodeList.FieldByName('iduser').value
                   ,cdsBarcodeList.fieldByName('idbarcode').Value);
           end;
         cdsBarcodeList.Next;
     end;
   except
     on e: Exception do begin
        raise Exception.Create('failed to save print queue: ' + e.Message);
     end;
   end;
end;


procedure TFrmBarcodePrint.InsertBarcodesInTemporaryTable(argBarcodesToPrint: TClientDataset);
var
   i: Integer;
   j: integer;
  _fieldToSwitch: String;
  _sql: String;
begin
   try
       try

         j := 1;

         argBarcodesToPrint.DisableControls;
         argBarcodesToPrint.First;

         while ( not argBarcodesToPrint.Eof ) do begin
              _fieldToSwitch := 'NumCopy';

              if ( chkInventoryCopy.Checked ) then begin
                 _fieldToSwitch := 'QtyOnHand';
              end;

               //*** YAA April 26, 2012  --> Use var FieldToSwitch, not 'NumCopy'
              for i := 1 to argBarcodesToPrint.FieldByName(_fieldToSwitch).asInteger do begin
                  _sql := 'insert #Temp_Barcode values ('+ IntToStr(j)+ ', '+ QuotedStr(argBarcodesToPrint.FieldByName('idbarcode').asString)+')';
                  dm.RunSQL(_sql);
              end;

              inc(j);
              argBarcodesToPrint.Next;
         end;

       except
         on e: Exception do begin
             raise e.Create('Fail to Insert Barcodes in Temporary Table ' + e.Message);
         end;
       end;
   finally
       argBarcodesToPrint.filter := '';
       argBarcodesToPrint.Filtered := false;
       argBarcodesToPrint.DisableControls;
   end;

end;

procedure TFrmBarcodePrint.PrintBarcodes();
var
   _msgWarning: String;
   _iEnd: Integer;
   _i: Integer;
begin
   cdsBarcodePrint.Open;

   //amfsouza 04.03.2011
   if ( cdsBarcodePrint.RecordCount > 100 ) then begin
     _msgWarning := 'You are about to print ' + intToStr(cdsBarcodePrint.RecordCount) + ' labels. Do you wish to continue ?';
     if ( Application.MessageBox(Pchar(_msgWarning), ' Greater than 100 models to printer', mb_YESNO + mb_IconWarning) = idNo ) then
        exit;
   end;

   if cdsBarcodePrint.RecordCount > 0 then
   begin
    _iEnd := 0;

    _iEnd := StrToIntDef(edtSkipRep1.Text, 0);

    if _iEnd > 0 then
    begin
      cdsBarcodePrint.First;
//amfsouza 10.24.2011      for i := 1 to (iEnd-1) do
      for _i := 1 to (_iEnd) do
      begin
        cdsBarcodePrint.Insert;
        cdsBarcodePrint.Post;
      end;
    end;

    ReportFile := edtReportFile.Text;

    ppReport.Template.LoadFromFile;

    if fBarcodePrinter <> '' then
      ppReport.PrinterSetup.PrinterName := fBarcodePrinter;

    cdsBarcodePrint.First;

    ppReport.ShowCancelDialog := False;

    ppReport.Print;
  end;
end;

procedure TFrmBarcodePrint.MoveSavedQueueFromDatabaseToScreen;
begin
   try
       // Get search saved on database to screen in queue grid-section.
       while ( not cdsQueueFromDatabase.Eof ) do begin
          cdsBarcodeList.Append;
          cdsBarcodeList.FieldByName('IdModel').Value      := cdsQueueFromDatabase.fieldByname('IdModel').Value;
          cdsBarcodeList.FieldByName('model').Value        := cdsQueueFromDatabase.fieldByname('Model').Value;
          cdsBarcodeList.FieldByName('description').Value  := cdsQueueFromDatabase.fieldByname('description').Value;
          cdsBarcodeList.FieldByName('IdBarcode').Value    := cdsQueueFromDatabase.fieldByname('IdBarcode').Value;
          cdsBarcodeList.FieldByName('qtyOnHand').Value    := cdsQueueFromDatabase.fieldByName('qtyOnHand').Value;
          cdsBarcodeList.FieldByName('SellingPrice').Value := cdsQueueFromDatabase.fieldByname('SellingPrice').Value;

          // AmfSouza November 07, 2012
          cdsBarcodeList.FieldByName('LargeImage').Value := cdsQueueFromDatabase.fieldByname('LargeImage').Value;
          cdsBarcodeList.FieldByName('LargeImage2').Value := cdsQueueFromDatabase.fieldByname('LargeImage2').Value;
          cdsBarcodeList.FieldByName('Manufacturer').Value := cdsQueueFromDatabase.fieldByname('Manufacturer').Value;
          cdsBarcodeList.FieldByName('VendorNum').Value := cdsQueueFromDatabase.fieldByname('VendorNum').Value;
          cdsBarcodeList.FieldByName('Vendor').Value := cdsQueueFromDatabase.fieldByname('Vendor').Value;

          // AmfSouza November 08, 2012
          cdsBarcodeList.FieldByName('SizeName').value := cdsQueueFromDatabase.fieldByName('SizeName').Value;
          cdsBarcodeList.FieldByName('Color').value := cdsQueueFromDatabase.fieldByName('Color').Value;
          cdsBarcodeList.FieldByName('CodColor').value := cdsQueueFromDatabase.fieldByName('CodColor').Value;

          // AmfSouza November 12, 2012
          cdsBarcodeList.fieldByname('ModelToScan').value := cdsQueueFromDatabase.fieldByName('ModelToScan').value;
          cdsBarcodeList.fieldByname('BarcodeToScan').value := cdsQueueFromDatabase.fieldByName('BarcodeToScan').value;


          //YAA April 26, 2012 : Test
          cdsBarcodeList.FieldByName('NumCopy').asInteger  := {YAA --> trunc}RemoveNegativeValuesAndTrunc(cdsQueueFromDatabase.fieldByname('NumCopy').Value);

          cdsBarcodeList.FieldByName('report').Value       := cdsQueueFromDatabase.fieldbyName('report').Value;
          cbxSearchType.ItemIndex                          := cdsQueueFromDatabase.fieldByName('IdSearchType').Value;
          chkSendToPrinter.Checked                         := cdsQueueFromDatabase.FieldByName('StraightToPrinter').asString = '1';
          chkPrimaryUpc.Checked                            := cdsQueueFromDatabase.fieldbyname('PrimaryBarcode').AsString = '1';
          chkInventoryCopy.Checked                         := cdsQueueFromDatabase.FieldByName('LabelQtyOnHand').asString = '1';
          chkSaveQueue.Checked                             := cdsQueueFromDatabase.FieldByName('PrintQueue').asString = '1';
          cdsBarcodeList.post;
          cdsQueueFromDatabase.Next;
       end;
       dsBarcodeList.DataSet := cdsBarcodeList;
       grdBarcodeDb.DataController.DataSource := dsBarcodeList;
       DisplayRecordsAtQueue(cdsBarcodeList.RecordCount);
      except
         on e: Exception do begin
             raise e.Create('Cannot get saved queue. ' + e.Message);
         end;

      end;
end;

procedure TFrmBarcodePrint.DisplayRecordsAtQueue(argCount: Integer);
begin
   lbPrinQueue.Caption := 'Items added to the Queue = ' + IntToStr(argCount);
   btnPrint.Enabled := ( argCount > 0 );
   EnableBarcodeQueueButtons(cdsBarcodeList);
end;

procedure TFrmBarcodePrint.DisplayRecordsFromSearch(argCount: Integer);
begin
   lbLastUpdateTab.Caption := 'Search Results = '+ intToStr(argCount);
   lbListTab.Caption := 'Search Results = '+ intToStr(argCount);
   EnableBarcodeButtons(cdsBarcode);
end;

procedure TFrmBarcodePrint.btnClearListClick(Sender: TObject);
begin
  inherited;
  if ( cdsBarcode.Active ) then begin
     cdsBarcode.EmptyDataSet();
  end;

end;

procedure TFrmBarcodePrint.CreateEmptyBarcodeList();
begin
  // This datatase will not closed or destroyed until close this screen.
  if ( cdsBarcodeList = nil ) then begin
     cdsBarcodeList := dm.GetBarcodeSearch(dm.GetBarcodeSearchSQL(-1, chkInventoryCopy.Checked, chkPrimaryUpc.Checked ))
  end;

  cdsBarcodeList.Open();
  dsBarcodeList.DataSet := cdsBarcodeList;
end;

procedure TFrmBarcodePrint.EnableAliasFielsToBarcodeList;
begin
  // Alias fields ( calculated fields ) should be enable to write.
  cdsBarcodeList.FieldByName('Report').ReadOnly := false;
  cdsBarcodeList.FieldByName('NumCopy').ReadOnly := false;
  cdsBarcodeList.FieldByName('QtyOnHand').ReadOnly := false;
  cdsBarcodeList.FieldByName('SellingPrice').ReadOnly := false;
  cdsBarcodeList.FieldByName('ModelToScan').ReadOnly := false;
  cdsBarcodeList.FieldByName('BarcodeToScan').ReadOnly := false;
  cdsBarcodeList.FieldByName('StoreAVGPrice').ReadOnly := false;

end;

procedure TFrmBarcodePrint.MovePurchaseBarcodesToQueue(argIdPurchase: String; argNumberCopies: Integer);
var
  _cdsPurchaseBarcodes: TClientDataset;
  sModels, sIdPurItem: String;
begin
  try
      try
          _cdsPurchaseBarcodes := dm.GetBarcodeFromPurchase(argIdPurchase, chkInventoryCopy.Checked,
                                  chkPrimaryUpc.Checked, argNumberCopies);

          while ( not _cdsPurchaseBarcodes.eof ) do begin
                if (Pos('#'+_cdsPurchaseBarcodes.FieldByName('IDModel').AsString+'#', sModels) = 0) or
                   ( (Pos('#'+_cdsPurchaseBarcodes.FieldByName('IDModel').AsString+'#', sModels) > 0) and
                   (Pos('#'+_cdsPurchaseBarcodes.FieldByName('IDPurchaseItem').AsString+'#', sIDPurItem) = 0)) then begin

                   if ( _cdsPurchaseBarcodes.FieldByName('IdBarcode').AsString <> '' ) then begin
                      AddBarcode(_cdsPurchaseBarcodes.FieldByName('IdBarcode').AsString,
                                 _cdsPurchaseBarcodes.FieldByName('Description').AsString,
                                 _cdsPurchaseBarcodes.FieldByName('Model').AsString,
                                 Trunc(_cdsPurchaseBarcodes.FieldByName('Qty').AsFloat),
                                 _cdsPurchaseBarcodes.FieldByName('SellingPrice').AsCurrency,
                                 _cdsPurchaseBarcodes.FieldByName('IdModel').AsInteger,
                                 _cdsPurchaseBarcodes.FieldByName('QtyOnHand').AsFloat,
                                 _cdsPurchaseBarcodes.FieldByname('StoreAVGPrice').AsCurrency,
                                 _cdsPurchaseBarcodes.FieldByName('LargeImage').asString,
                                 _cdsPurchaseBarcodes.FieldByName('LargeImage2').asString,
                                 _cdsPurchaseBarcodes.FieldByName('Manufacturer').asString,
                                 _cdsPurchaseBarcodes.FieldByName('VendorNum').asString,
                                 _cdsPurchaseBarcodes.FieldByName('Vendor').asString);
                   end;

                   sModels    := sModels+'#'+_cdsPurchaseBarcodes.FieldByName('IDModel').AsString+'#';
                   sIDPurItem := sIDPurItem+'#'+_cdsPurchaseBarcodes.FieldByName('IDPurchaseItem').AsString+'#';

                end;

                _cdsPurchaseBarcodes.Next();

          end;

          pgFilter.ActivePageIndex := 2;
          grdBarcodeDb.DataController.DataSource := dsbarcodeList;

      except
          on e: Exception do begin
             raise e.Create('Cannot add barcode to queue from purchase');
          end;
      end;
  finally
      FreeAndNil(_cdsPurchaseBarcodes);
  end;

end;

procedure TFrmBarcodePrint.MoveTransferBarcodesToQueue(
  argIdTransfer: String);
var
  _cdsTransfer: TClientDataset;
  sModels: String;
begin
   try
       try
          _cdsTransfer := dm.GetBarcodeFromTransfer(argIdTransfer);

          while ( not _cdsTransfer.Eof ) do begin
               if Pos('#'+_cdsTransfer.FieldByName('IDModel').AsString+'#', sModels )=0 then begin
                     if _cdsTransfer.FieldByName('IDBarcode').AsString <> '' then
                        // AmfSouza November 07, 2012: New fields added
                        AddBarcode(_cdsTransfer.FieldByName('IDBarcode').AsString,
                                   _cdsTransfer.FieldByName('Description').AsString,
                                   _cdsTransfer.FieldByName('Model').AsString,
                                   Trunc(_cdsTransfer.FieldByName('Qty').AsFloat),
                                   _cdsTransfer.FieldByName('SellingPrice').AsCurrency,
                                   _cdsTransfer.FieldByName('IdModel').AsInteger,
                                   _cdsTransfer.FieldByName('QtyOnHand').AsFloat,
                                   _cdsTransfer.FieldByname('StoreAVGPrice').AsCurrency,
                                   _cdsTransfer.FieldByName('LargeImage').asString,           // new
                                   _cdsTransfer.FieldByName('LargeImage2').asString,          // new
                                   _cdsTransfer.FieldByName('Manufacturer').asString,         // new
                                   _cdsTransfer.FieldByName('VendorNum').asString,            // new
                                   _cdsTransfer.FieldByName('Vendor').asString,               // new

                                   // AmfSouza November 08, 2012
                                   _cdsTransfer.FieldByName('SizeName').asString,
                                   _cdsTransfer.FieldByName('Color').AsString,
                                   _cdsTransfer.FieldByName('CodColor').AsString,
                                   _cdsTransfer.FieldByName('ModelToScan').asString,
                                   _cdsTransfer.FieldByName('BarcodeToScan').asString
                                   );

                         sModels := sModels+'#'+_cdsTransfer.FieldByName('IDModel').AsString+'#';
             end;
               _cdsTransfer.Next();
          end;

       except
          on e: Exception do begin
            raise e.Create('Cannot add barcode queue from transfer.' + e.Message);
          end;
       end;

   finally
       FreeAndNil(_cdsTransfer);
   end;
end;

procedure TFrmBarcodePrint.EnableBarcodeButtons(argDataset: TDataset);
begin
  btAdd.Enabled := ( argDataset.RecordCount > 0 );
  btAddAll.Enabled := btAdd.Enabled;
  btnClearList.Enabled := btAdd.Enabled;

  btAddLast.Enabled :=( argDataset.RecordCount > 0 );
  btAddAllLast.Enabled := btAddLast.Enabled;
  btClearLastUpdate.Enabled := btAddLast.Enabled;
end;

procedure TFrmBarcodePrint.EnableBarcodeQueueButtons(argDataset: TDataSet);
begin
  btDel.Enabled := ( argDataset.RecordCount > 0 );
  btDelAll.Enabled := btDel.Enabled;
end;

procedure TFrmBarcodePrint.cdsBarcodeAfterScroll(Dataset: TDataset);
begin
   EnableBarcodeButtons(dataset);
end;

procedure TFrmBarcodePrint.quBarcodePrintAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TNumericField(dataset.FieldByName('NumCopy')).DisplayFormat := '######0';
end;

end.

