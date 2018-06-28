unit uSisQuickRepFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentModal, ExtCtrls, ppModule, daDataModule, Db, ADODB, ppDB,
  ppDBPipe, ppCtrls, ppBands, ppClass, ppVar, ppPrnabl, ppCache, ppComm,
  ppRelatv, ppProd, ppReport, ppStrtch, ppSubRpt, siComp, siLangRT;

type
  TSisQuickRepFch = class(TParentModalFrm)
    rpQuickInfo: TppReport;
    ppDetailBand2: TppDetailBand;
    ppQuickInfo: TppDBPipeline;
    dsQuickInfo: TDataSource;
    quQuickInfo: TADODataSet;
    daDataModule1: TdaDataModule;
    SubRepSalesTotal: TppSubReport;
    ppChildReport1: TppChildReport;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppLabel18: TppLabel;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppHeaderBand2: TppHeaderBand;
    ppTitleBand2: TppTitleBand;
    ppSystemVariable1: TppSystemVariable;
    ppLine1: TppLine;
    SubRepHeaderSalesTotal: TppSubReport;
    ppChildReport2: TppChildReport;
    ppDetailBand3: TppDetailBand;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    lb1: TppLabel;
    ppLabel23: TppLabel;
    ppLabel22: TppLabel;
    lb2: TppLabel;
    lb3: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    lb4: TppLabel;
    lb5: TppLabel;
    lb6: TppLabel;
    lb7: TppLabel;
    lb8: TppLabel;
    lb9: TppLabel;
    lb10: TppLabel;
    ppSystemVariable3: TppSystemVariable;
    ppFooterBand2: TppFooterBand;
    ppSystemVariable2: TppSystemVariable;
    SubRepItemOnHold: TppSubReport;
    ppChildReport3: TppChildReport;
    ppDetailBand4: TppDetailBand;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppDBText18: TppDBText;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppDBText26: TppDBText;
    ppDBText27: TppDBText;
    ppDBText28: TppDBText;
    ppDBText29: TppDBText;
    ppDBText30: TppDBText;
    ppLabel1: TppLabel;
    ppDBCalc4: TppDBCalc;
    ppLine2: TppLine;
    ppDBText33: TppDBText;
    ppDBText34: TppDBText;
    SubRepHeaderPO: TppSubReport;
    ppChildReport4: TppChildReport;
    ppDetailBand5: TppDetailBand;
    ppLabel14: TppLabel;
    ppLabel11: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel4: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    SubRepItemOnPO: TppSubReport;
    ppChildReport5: TppChildReport;
    ppDetailBand6: TppDetailBand;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppDBText31: TppDBText;
    ppLabel5: TppLabel;
    ppDBCalc9: TppDBCalc;
    ppDBCalc11: TppDBCalc;
    ppDBCalc15: TppDBCalc;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppDBText32: TppDBText;
    ppDBText35: TppDBText;
    ppDBText36: TppDBText;
    ppLabel21: TppLabel;
    ppDBCalc8: TppDBCalc;
    ppDBCalc10: TppDBCalc;
    ppDBCalc13: TppDBCalc;
    ppDBText37: TppDBText;
    ppDBText38: TppDBText;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppDBText41: TppDBText;
    ppDBText42: TppDBText;
    ppDBText43: TppDBText;
    ppShape3: TppShape;
    ppDBText44: TppDBText;
    ppLabel6: TppLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rpQuickInfoPreviewFormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    iQuickRep : Integer;
    sParam    : String;

    procedure QuickInfoClose;

    function PrepareReport:Boolean;


    //Build the Report's Query
    function BuildSalesTotalQuery:Boolean;
    function BuildItemsOnHoldQuery:Boolean;
    function BuildItemsOnPO:Boolean;

  public
    { Public declarations }
    procedure Start(iReport:Integer; sParam:String);
  end;

implementation

{$R *.DFM}

uses uDM;

procedure TSisQuickRepFch.QuickInfoClose;
begin

  with quQuickInfo do
     if Active then
        Close;

end;

function TSisQuickRepFch.PrepareReport:Boolean;
begin

 try

    Result := True;

      case iQuickRep of
         1 : begin //Total Sales
             if BuildSalesTotalQuery then
                begin
                SubRepItemOnHold.Free;
                SubRepHeaderPO.Free;
                SubRepItemOnPO.Free;

                SubRepSalesTotal.Top := 0.0208;

                rpQuickInfo.PrinterSetup.DocumentName := 'Total Sales';
                end;

             end;

         2 : begin //Items on Hold
             if BuildItemsOnHoldQuery then
                begin
                SubRepSalesTotal.Free;
                SubRepHeaderPO.Free;
                SubRepItemOnPO.Free;

                SubRepItemOnHold.Top := 0.0208;

                lb9.Visible := False;
                lb10.Visible := False;

                rpQuickInfo.PrinterSetup.DocumentName := 'Item(s) OnHold/Layaway';
                end;
             end;

         3 : begin //Items on Hold
             if BuildItemsOnPO then
                begin
                SubRepItemOnHold.Free;
                SubRepSalesTotal.Free;
                SubRepHeaderSalesTotal.Free;

                SubRepHeaderPO.Top := 0.0208;
                SubRepItemOnPO.Top := 0.0208;

                rpQuickInfo.PrinterSetup.DocumentName := 'Item(s) On Purchase Order';
                end;
             end;
      end;

 except
    ShowMessage('Load report error!');
 end;

end;

function TSisQuickRepFch.BuildSalesTotalQuery:Boolean;
var
  sWhere : String;
begin

   try

   Result := True;

   if sParam = '' then
      sWhere := ' AND IMV.MovDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now))+
                ' AND IMV.MovDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now+1))
   else
      sWhere := ' AND ' + sParam;
      
   with quQuickInfo do
      begin
      if Active then
         Close;

      CommandText :=
                ' SELECT ' +
                ' IMV.MovDate, IMV.IDDocument as Invoice, IMV.Qty, IMV.CostPrice, '+
                ' IMV.SalePrice, (IMV.Discount * -1) as Discount, '+
                ' ((IMV.SalePrice * IMV.Qty) - IMV.Discount) as ExtSubTotal, '+
                ' ((IMV.SalePrice * IMV.Qty) - IMV.Discount) + (CASE WHEN TaxIsent = 0 THEN ROUND((((IMV.SalePrice * IMV.Qty) - IMV.Discount) * IMV.SalesTax),2) ELSE 0 END) as ExtGrandTotal, ' +
                ' (CASE WHEN I.TaxIsent = 0 THEN IMV.SalesTax ELSE 0 END) as SalesTax, '+
                ' I.LastName as CustomerLastName, I.FirstName as CustomerFirstName, ' +
                ' I.ZIP as CustomerZip, M.Model, M.Description, C.Category, ME.Media, ' +
                ' S.Store, COM.FullName as SalesPersonFullName ' +
                ' FROM ' +
                ' vw_Rep_InventoryMov IMV ' +
                ' JOIN vw_Rep_Entity COM ON (COM.IDPerson = IMV.IDComission) ' +
                ' JOIN vw_Rep_Store S ON (S.IDStore = IMV.IDStore) ' +
                ' JOIN vw_Rep_Model M ON (IMV.IDModel = M.IDModel) ' +
                ' JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory) ' +
                ' JOIN vw_Rep_Invoice I ON (I.IDInvoice = IMV.IDDocument) ' +
                ' JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia) ' +
                ' WHERE IMV.IDInventMovType = 1 ' + sWhere +
                //Data Filter
                //' AND IMV.MovDate >= ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now)) +
                //' AND IMV.MovDate < ' + QuotedStr(FormatDateTime('mm/dd/yyyy',now+1)) +
                ' ORDER BY IMV.MovDate ';
        Open;

      end;
   except
      ShowMessage('Building query of report Failed!');
      Result := False;
   end;

end;


function TSisQuickRepFch.BuildItemsOnHoldQuery:Boolean;
begin

   try

   Result := True;

   with quQuickInfo do
      begin
      if Active then
         Close;

      CommandText :=
              ' SELECT ' +
              ' PIMV.MovDate, PIMV.IDDocument as HoldLayaway, PIMV.Qty, ' +
              ' PIMV.CostPrice, PIMV.SalePrice, (PIMV.Discount * -1) as Discount, ' +
              ' ((PIMV.SalePrice * PIMV.Qty) - PIMV.Discount) as ExtSubTotal, ' +
              ' I.LastName as CustomerLastName, I.FirstName as CustomerFirstName, ' +
              ' I.ZIP as CustomerZip, M.Model, M.Description, C.Category, ' +
              ' ME.Media, S.Store, COM.FullName as SalesPersonFullName ' +
              ' FROM ' +
              ' vw_Rep_PreInventoryMov PIMV ' +
              ' JOIN vw_Rep_Entity COM ON (COM.IDPerson = PIMV.IDComission) ' +
              ' JOIN vw_Rep_Store S ON (S.IDStore = PIMV.IDStore) ' +
              ' JOIN vw_Rep_Model M ON (PIMV.IDModel = M.IDModel) ' +
              ' JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory) ' +
              ' JOIN vw_Rep_Invoice I ON (I.IDPreSale = PIMV.IDDocument) ' +
              ' JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia) ' +
              ' WHERE PIMV.IDInventMovType = 1 ' +
              ' ORDER BY PIMV.IDDocument,PIMV.MovDate ';

        Open;

      end;
   except
      ShowMessage('Building query of report Failed!');
      Result := False;
   end;
end;

function TSisQuickRepFch.BuildItemsOnPO:Boolean;
begin

   try

   Result := True;

   with quQuickInfo do
      begin
      if Active then
         Close;

      CommandText :=

          ' SELECT ' +
          ' PO.IDPO, PO.OrderDate, V.FullName as Vendor, S.Store, ' +
          ' SU.SystemUser, PIM.Qty, (PIM.Qty * PIM.CostPrice) as ExtCostPrice, '+
          ' (PIM.Qty * PIM.SalePrice) as ExtSalePrice, ' +
          ' (PIM.Qty * PIM.SuggRetail) as ExtSuggRetail, ' +
          ' M.Model, M.Description, C.Category ' +
          ' FROM ' +
          ' vw_Rep_PurchaseOrder PO ' +
          ' JOIN vw_Rep_Entity V ON (PO.IDVendor = V.IDPerson) ' +
          ' JOIN vw_Rep_Store S ON (S.IDStore = PO.IDStore) ' +
          ' JOIN vw_Rep_PreInventoryMov PIM ON (PO.IDPO = PIM.IDDocument AND PIM.IDInventMovType = 2) ' +
          ' LEFT OUTER JOIN vw_Rep_SystemUser SU ON ( PIM.IDUser = SU.IDUser ) ' +
          ' JOIN vw_Rep_Model M ON (M.IDModel = PIM.IDModel) ' +
          ' JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory) ' +
          ' ORDER BY Vendor, PO.IDPO ';

      Open;

      end;
   except
      ShowMessage('Building query of report Failed!');
      Result := False;
   end;

end;

procedure TSisQuickRepFch.Start(iReport:Integer; sParam:String);
begin

   iQuickRep := iReport;
   Self.sParam := sParam;

   Self.Show;

end;

procedure TSisQuickRepFch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  QuickInfoClose;

  Action := caFree;

end;

procedure TSisQuickRepFch.rpQuickInfoPreviewFormCreate(Sender: TObject);
begin
  inherited;

  rpQuickInfo.PreviewForm.WindowState := WSMAXIMIZED;

end;

procedure TSisQuickRepFch.FormShow(Sender: TObject);
begin
  inherited;


  PrepareReport;

  rpQuickInfo.ModalPreview := True;

  rpQuickInfo.Print;

  Close;

end;

end.
