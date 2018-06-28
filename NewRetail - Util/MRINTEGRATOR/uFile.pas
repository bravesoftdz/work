unit uFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, DB, uMas90, Grids, Mask, DateBox,
  ComCtrls;

type
  TFrmFile = class(TForm)
    SD: TSaveDialog;
    sgColumns: TStringGrid;
    Panel: TPanel;
    Label2: TLabel;
    edtPath: TEdit;
    sbOpenFile: TSpeedButton;
    PanelDate: TPanel;
    lbBeginDate: TLabel;
    lbEndDate: TLabel;
    Shape7: TShape;
    lbType: TLabel;
    sgColumnsClient: TStringGrid;
    PBar: TProgressBar;
    Panel1: TPanel;
    edtBeginDate: TDateBox;
    edtEndDate: TDateBox;
    lbPB: TLabel;
    BClose: TButton;
    btFile: TBitBtn;
    bvBottom: TBevel;
    procedure sbOpenFileClick(Sender: TObject);
    procedure btFileClick(Sender: TObject);
    procedure BCloseClick(Sender: TObject);
  private
    fMas90       : TMas90;
    FIDCustomer  : TStringList;
    procedure AddIdCustomer(IDCustomer :string);
    procedure SetupSoftwareInfo;
    procedure  BuildMas90ExpCustomerFile(SaleInvoice : Boolean);
    procedure  BuildMas90ExpPaymentFile(SaleInvoice : Boolean);
    procedure  BuildMas90ExpSaleInvoiceFile;
    procedure GetGridColumn;
    procedure AddMas90ColumnsToImportExport;
    procedure FillMas90ColumnsGrid;
    function SetPath(name: String): String;
    procedure ClearColumns;
    procedure MountGrid;
    procedure MountGridClient;
    procedure ShowPB(Texto :String; Maxpos: Integer);
    procedure HidePB;
    function GetMas90WareHouseCode(Store :String):String;
    function GetMas90CategoryCode(Category :String):String;
    function GetMas90TaxSchedule(Tax :String):String;
    procedure RefreshScreen;
  public
    function Start:Boolean;
  end;

implementation

uses uDM, uParamFunctions, uMsgBox, uSqlFunctions, cxDateUtils;

{$R *.dfm}

procedure TFrmFile.sbOpenFileClick(Sender: TObject);
var
  sFile : String;
  sExt  : String;
begin
  inherited;
  SetupSoftwareInfo;
  if SD.Execute then
     begin
     sFile := LowerCase(SD.FileName);

     sExt := '.csv';

     if Pos(sExt, sFile) = 0 then
        sFile := sFile + sExt;

     edtPath.Text := sFile;
     end;
end;

procedure TFrmFile.GetGridColumn;
var
  sColumn : String;
  sResult : String;
  i : integer;
begin
   sColumn := DM.GetIniFile('ColumnSetup', ACC_SOFTWARE_MAS90 + IntToStr(DM.iEntityType));

  if sColumn = '' then
     Exit;

  for i:=1 to sgColumns.RowCount-1 do
      begin
      sResult := ParseParam(sColumn, Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]));
      if sResult <> '' then
         sgColumns.Cells[COLUMN_OFFICEM,i] := sResult;
      end;
end;

procedure TFrmFile.AddMas90ColumnsToImportExport;
begin

  with fMas90 do
     begin

     ClearColumnsToImport;

      case DM.iEntityType of
       ENTITY_CUSTOMER :
              begin
              AddColumnToImport(Mas90_COL_ENTITY_Division_No);
              AddColumnToImport(Mas90_COL_ENTITY_Customer_No);
              AddColumnToImport(Mas90_COL_ENTITY_Name);
              AddColumnToImport(Mas90_COL_ENTITY_ADDRESS_1);
              AddColumnToImport(Mas90_COL_ENTITY_ADDRESS_2);
              AddColumnToImport(Mas90_COL_ENTITY_City);
              AddColumnToImport(Mas90_COL_ENTITY_State);
              AddColumnToImport(Mas90_COL_ENTITY_Zip_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Phone_No);
              AddColumnToImport(Mas90_COL_ENTITY_Terms_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Country_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Tax_Schedule);
              AddColumnToImport(Mas90_COL_ENTITY_Tax_Exempt_No);
              AddColumnToImport(Mas90_COL_ENTITY_Shipping_Method);
              AddColumnToImport(Mas90_COL_ENTITY_Fax_Number);
              AddColumnToImport(Mas90_COL_ENTITY_Email_Address);
              AddColumnToImport(Mas90_COL_ENTITY_Salesprsn_No);
              AddColumnToImport(Mas90_COL_ENTITY_Default_SLS_CD);
              AddColumnToImport(Mas90_COL_ENTITY_Cust_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Price_Level);
              end;

       ENTITY_PAYMENT :
              begin
              AddColumnToImport(Mas90_COL_ENTITY_Bank_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Deposit_Number);
              AddColumnToImport(Mas90_COL_ENTITY_Division_No);
              AddColumnToImport(Mas90_COL_ENTITY_Customer_No);
              AddColumnToImport(Mas90_COL_ENTITY_Customer_Name);
              AddColumnToImport(Mas90_COL_ENTITY_Batch_Number );
              AddColumnToImport(Mas90_COL_ENTITY_Invoice_No);
              AddColumnToImport(Mas90_COL_ENTITY_Amount_Posted);
              AddColumnToImport(Mas90_COL_ENTITY_Dep_Post_Date);
              AddColumnToImport(Mas90_COL_ENTITY_Document_No);
              AddColumnToImport(Mas90_COL_ENTITY_Deposit_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Payment_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Deposit_Balance);
              AddColumnToImport(Mas90_COL_ENTITY_Cust_Post_Amt);
              end;

      ENTITY_SALE_INVOICE :
              begin
              AddColumnToImport(Mas90_COL_ENTITY_Invoice_No);
              AddColumnToImport(Mas90_COL_ENTITY_Invoice_Date);
              AddColumnToImport(Mas90_COL_ENTITY_Division_No);
              AddColumnToImport(Mas90_COL_ENTITY_Customer_No);
              AddColumnToImport(Mas90_COL_ENTITY_Default_Whse);
              AddColumnToImport(Mas90_COL_ENTITY_Tax_Schedule);
              AddColumnToImport(Mas90_COL_ENTITY_Terms_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Salesprsn);
              AddColumnToImport(Mas90_COL_ENTITY_Line_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Item_Number);
              AddColumnToImport(Mas90_COL_ENTITY_Discount);
              AddColumnToImport(Mas90_COL_ENTITY_Subj_to_Exempt);
              AddColumnToImport(Mas90_COL_ENTITY_WareHouse_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Cost_Type);
              AddColumnToImport(Mas90_COL_ENTITY_Product_Line);
              AddColumnToImport(Mas90_COL_ENTITY_Unit_of_Measure);
              AddColumnToImport(Mas90_COL_ENTITY_Lot_Serno_Dist);
              AddColumnToImport(Mas90_COL_ENTITY_Cogs_Account);
              AddColumnToImport(Mas90_COL_ENTITY_Reg_Sales_Acnt);
              AddColumnToImport(Mas90_COL_ENTITY_Price_Ovrrddn);
              AddColumnToImport(Mas90_COL_ENTITY_Kit_Item);
              AddColumnToImport(Mas90_COL_ENTITY_Bkord_Comp_LN);
              AddColumnToImport(Mas90_COL_ENTITY_Skip_Comp);
              AddColumnToImport(Mas90_COL_ENTITY_Um_Conv_Factor);
              AddColumnToImport(Mas90_COL_ENTITY_GL_Sales_Accnt);
              AddColumnToImport(Mas90_COL_ENTITY_Misc_Item_Flag);
              AddColumnToImport(Mas90_COL_ENTITY_Misc_Item);
              AddColumnToImport(Mas90_COL_ENTITY_Stand_Kit_Bill);
              AddColumnToImport(Mas90_COL_ENTITY_Tax_Class);
              AddColumnToImport(Mas90_COL_ENTITY_Qty_Ordered);
              AddColumnToImport(Mas90_COL_ENTITY_Qty_Shipped);
              AddColumnToImport(Mas90_COL_ENTITY_Qty_Backordered);
              AddColumnToImport(Mas90_COL_ENTITY_Unit_Price);
              AddColumnToImport(Mas90_COL_ENTITY_Extension);
              AddColumnToImport(Mas90_COL_ENTITY_Taxable_Amt);
              AddColumnToImport(Mas90_COL_ENTITY_Non_Tax_Amt);
              AddColumnToImport(Mas90_COL_ENTITY_Sales_Tax);
              AddColumnToImport(Mas90_COL_ENTITY_Line_Disc_Perct);
              AddColumnToImport(Mas90_COL_ENTITY_Unit_Cost);
              AddColumnToImport(Mas90_COL_ENTITY_Item_Desc);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_Date);
              AddColumnToImport(Mas90_COL_ENTITY_Order_Date);
              AddColumnToImport(Mas90_COL_ENTITY_Invoice_due_dt);
              AddColumnToImport(Mas90_COL_ENTITY_Discount_Due_Dt);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_Name);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_Addrs1);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_Addrs2);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_City);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_State);
              AddColumnToImport(Mas90_COL_ENTITY_Bill_to_Zip_CD);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Name);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Addrs1);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Addrs2);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_City);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_State);
              AddColumnToImport(Mas90_COL_ENTITY_Ship_to_Zip_CD);
              AddColumnToImport(Mas90_COL_ENTITY_Comm_Desc_Line1);
              AddColumnToImport(Mas90_COL_ENTITY_Comm_Desc_Line2);
              AddColumnToImport(Mas90_COL_ENTITY_Charge_AMT);
              AddColumnToImport(Mas90_COL_ENTITY_Misc_Slash);
              AddColumnToImport(Mas90_COL_ENTITY_Misc_Code);
              AddColumnToImport(Mas90_COL_ENTITY_Description);
              AddColumnToImport(Mas90_COL_ENTITY_Freight);
              end;
      END;
     end;
end;

procedure TFrmFile.SetupSoftwareInfo;
begin
  SD.Filter := 'Mas90 Format|*.CSV|All file|*.*';
end;

procedure TFrmFile.BuildMas90ExpCustomerFile(SaleInvoice :Boolean);
var
  myField : TField;
  MyType  : TMAS90FileType;
  i       : integer;
  Division_No, Customer_No, Name, Address1, Address2,
  City, State, Zip_Code, Phone_No, Terms_Code, Open_Item, Country_Code, Tax_Schedule,
  Tax_Exempt_No, Shipping_Method, Fax_Number, Email_Address, Salesprsn_No, Default_SLS_CD,
  Cust_Type, Price_Level : String;
  sValue : String;

  procedure ClearFields;
  begin
    Division_No     := '';
    Customer_No     := '';
    Name            := '';
    Address1        := '';
    Address2        := '';
    City            := '';
    State           := '';
    Zip_Code        := '';
    Phone_No        := '';
    Terms_Code      := '';
    Open_Item       := '';
    Country_Code    := '';
    Tax_Schedule    := '';
    Tax_Exempt_No   := '';
    Shipping_Method := '';
    Fax_Number      := '';
    Email_Address   := '';
    Salesprsn_No    := '';
    Default_SLS_CD  := '';
    Cust_Type    := '';
    Price_Level  := '';
  end;

  procedure ModifyCustomerFields;
  begin
   Division_No  := '00';
   Salesprsn_No := '1';
   Terms_Code  := '00';
   Customer_No := fMas90.PrepareCustomerNoForMAS90(Customer_No);
  end;

begin

  if not Assigned(fMas90) then
     FMas90 := TMas90.Create;

  MyType := Mas90_FILE_TYPE_CUSTOMER;

  if SaleInvoice then
   begin
   DM.OpenSaleInvoiceCustomer(FIDCustomer.CommaText);
   DM.iEntityType := ENTITY_CUSTOMER;
   ClearColumns;
   fMas90.ClearEntityList;
   MountGrid;
   end
  else
   DM.OpenCustomer;

  ShowPB('Customer',DM.quCustomer.RecordCount);

  try
    DM.quCustomer.First;
    While not DM.quCustomer.Eof do
       begin

       //Vejo todas as colunas marcadas
       for i:=1 to sgColumns.RowCount-1 do
          if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then //Office Manager columns for selecionado
             begin

             //Localize field
             myField := DM.quCustomer.FindField(Trim(sgColumns.Cells[COLUMN_OFFICEM,i]));

             if myField <> nil then
                begin
                sValue := Trim(myField.AsString);

                sValue := StringReplace(sValue, ',', ' ', [rfReplaceAll]);

                //if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Division_No])  then
                //    Division_No := Division_No + sValue
                if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Customer_No])  then
                    Customer_No := Customer_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Name])  then
                    Name := Name + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Address_1]) then
                        Address1 := Address1 + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Address_2]) then
                        Address2 := Address2 + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_City]) then
                        City := City + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_State]) then
                        State := State + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Zip_Code]) then
                        Zip_Code := Zip_Code  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Phone_No]) then
                        Phone_No := Phone_No + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Terms_Code]) then
                //        Terms_Code := Terms_Code + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Open_Item]) then
                        Open_Item := Open_Item + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Country_Code]) then
                        Country_Code := Country_Code + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Tax_Schedule]) then
                        Tax_Schedule := Tax_Schedule + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Tax_Exempt_No]) then
                        Tax_Exempt_No := Tax_Exempt_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Shipping_Method]) then
                        Shipping_Method := Shipping_Method + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Fax_Number]) then
                        Fax_Number  := Fax_Number  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Email_Address]) then
                        Email_Address := Email_Address + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Salesprsn_No]) then
                //        Salesprsn_No := Salesprsn_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Default_SLS_CD]) then
                        Default_SLS_CD := Default_SLS_CD + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Cust_Type]) then
                        Cust_Type := Cust_Type + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Price_Level]) then
                        Price_Level := Price_Level + sValue;
                end;
             end;

       ModifyCustomerFields;

       fMas90.AddCustomerEntity(MyType, Division_No, Customer_No, Name, Address1, Address2,
                                City, State, Zip_Code, Phone_No,Terms_Code, Open_Item, Country_Code, Tax_Schedule,
                                Tax_Exempt_No, Shipping_Method, Fax_Number, Email_Address, Salesprsn_No, Default_SLS_CD,
                                Cust_Type, Price_Level);
       ClearFields;
       DM.quCustomer.Next;
       PBar.Position := PBar.Position + 1;
       end;

  finally
   if SaleInvoice then
    begin
    fMas90.SaveDataToFile(SetPath('CUST'));
    DM.CloseSaleInvoiceCustomer;
    end
   else
    begin
    fMas90.SaveDataToFile(edtPath.Text);
    DM.CloseCustomer;
    end;
    HidePB;
    FreeAndNil(FMas90);
    RefreshScreen;
  end;
end;

procedure TFrmFile.BuildMas90ExpPaymentFile(SaleInvoice :Boolean);
var
  myField : TField;
  MyType  : TMAS90FileType;
  i, cod  : integer;
  Bank_Code,Deposit_Number, Division_No, Customer_No, Customer_Name, Batch_Number,
  Invoice_No, Amount_Posted,Dep_Post_Date,Document_No,Deposit_Type,Payment_Type,
  Deposit_Balance,Cust_Post_Amt : String;
  sValue : String;

  procedure ClearFields;
  begin
    Bank_Code       := '';
    Deposit_Number  := '';
    Division_No     := '';
    Customer_No     := '';
    Customer_Name   := '';
    Batch_Number    := '';
    Invoice_No      := '';
    Amount_Posted   := '';
    Dep_Post_Date   := '';
    Document_No     := '';
    Deposit_Type    := '';
    Payment_Type    := '';
    Deposit_Balance := '';
    Cust_Post_Amt   := '';

  end;

  procedure ModifyPaymentFields;
  begin
   Division_No     := '00';
   Deposit_Type    := 'C';
   Cust_Post_Amt   := '0.00';
   Batch_Number    := '00001';
   Deposit_Balance := '0.00';
   Invoice_No  := fMas90.PrepareInvoiceNoForMAS90(Invoice_No);
   Customer_No := fMas90.PrepareCustomerNoForMAS90(Customer_No);
  end;
begin

  if not Assigned(fMas90) then
     FMas90 := TMas90.Create;

  MyType := Mas90_FILE_TYPE_PAYMENT;

  if SaleInvoice then
   begin
   DM.iEntityType := ENTITY_PAYMENT;
   ClearColumns;
   fMas90.ClearEntityList;
   MountGrid;
   end;

  //Monta o Cabeçalho
  Bank_Code     := 'D';
  Dep_Post_Date := '10/01/2005';
  fMas90.AddPaymentEntity(MyType,Bank_Code,Deposit_Number,Division_No, Customer_No, Customer_Name, Batch_Number,
                      Invoice_No, Amount_Posted,Dep_Post_Date,Document_No,Deposit_Type,Payment_Type,
                      Deposit_Balance,Cust_Post_Amt);

  DM.OpenPaymentTotal(edtBeginDate.Text,edtEndDate.Text);
  ShowPB('Payment',DM.quPaymentTotal.RecordCount);

  try
    DM.quPaymentTotal.First;
    While not DM.quPaymentTotal.Eof do
       begin

       //Vejo todas as colunas marcadas
       for i:=1 to sgColumns.RowCount-1 do
          if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then //Office Manager columns for selecionado
             begin

             //Localize field
             myField := DM.quPaymentTotal.FindField(Trim(sgColumns.Cells[COLUMN_OFFICEM,i]));

             if myField <> nil then
                begin
                sValue := Trim(myField.AsString);

                sValue := StringReplace(sValue, ',', ' ', [rfReplaceAll]);

                if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bank_Code ])  then
                    Bank_Code  := Bank_Code  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Deposit_Number])  then
                    Deposit_Number := Deposit_Number + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Division_No])  then
                //    Division_No := Division_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Customer_No]) then
                        Customer_No := Customer_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Customer_Name]) then
                        Customer_Name := Customer_Name + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Batch_Number]) then
                        Batch_Number:= Batch_Number + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Invoice_No]) then
                        Invoice_No := Invoice_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Amount_Posted]) then
                        Amount_Posted := Amount_Posted  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Dep_Post_Date]) then
                        Dep_Post_Date := Dep_Post_Date + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Document_No]) then
                        Document_No := Document_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Deposit_Type]) then
                        Deposit_Type := Deposit_Type + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Payment_Type]) then
                        Payment_Type := Payment_Type + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Deposit_Balance]) then
                        Deposit_Balance  := Deposit_Balance  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Cust_Post_Amt]) then
                        Cust_Post_Amt := Cust_Post_Amt + sValue
                end;
             end;
             
       ModifyPaymentFields;

       Bank_Code := 'H';
       fMas90.AddPaymentEntity(MyType,Bank_Code,Deposit_Number,Division_No, Customer_No, Customer_Name, Batch_Number,
                        Invoice_No, Amount_Posted,Dep_Post_Date,Document_No,Deposit_Type,Payment_Type,
                        Deposit_Balance,Cust_Post_Amt);

      DM.OpenPaymentDetail(DM.quPaymentTotalIDPaymentType.AsInteger,edtBeginDate.Text,edtEndDate.Text);
       ClearFields;

       DM.quPaymentDetail.First;
        While not DM.quPaymentDetail.Eof do
         begin

         //Vejo todas as colunas marcadas
         for i:=1 to sgColumns.RowCount-1 do
            if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then //Office Manager columns for selecionado
               begin

               //Localize field
               myField := DM.quPaymentDetail.FindField(Trim(sgColumns.Cells[COLUMN_OFFICEM,i]));

               if myField <> nil then
                  begin
                  sValue := Trim(myField.AsString);

                  sValue := StringReplace(sValue, ',', ' ', [rfReplaceAll]);

                  if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bank_Code ])  then
                      Bank_Code  := Bank_Code  + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Deposit_Number])  then
                      Deposit_Number := Deposit_Number + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Division_No])  then
                      Division_No := Division_No + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Customer_No]) then
                          Customer_No := Customer_No + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Customer_Name]) then
                          Customer_Name := Customer_Name + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Batch_Number]) then
                          Batch_Number:= Batch_Number + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Invoice_No]) then
                          Invoice_No := Invoice_No + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Amount_Posted]) then
                          Amount_Posted := Amount_Posted  + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Dep_Post_Date]) then
                          Dep_Post_Date := Dep_Post_Date + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Document_No]) then
                          Document_No := Document_No + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Deposit_Type]) then
                          Deposit_Type := Deposit_Type + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Payment_Type]) then
                          Payment_Type := Payment_Type + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Deposit_Balance]) then
                          Deposit_Balance  := Deposit_Balance  + sValue
                  else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Cust_Post_Amt]) then
                          Cust_Post_Amt := Cust_Post_Amt + sValue
                  end;
               end;

         Bank_Code := 'IN';
         fMas90.AddPaymentEntity(MyType,Bank_Code,Deposit_Number,Division_No, Customer_No, Customer_Name, Batch_Number,
                          Invoice_No, Amount_Posted,Dep_Post_Date,Document_No,Deposit_Type,Payment_Type,
                          Deposit_Balance,Cust_Post_Amt);
         ClearFields;
         DM.quPaymentDetail.Next;
         end;
       DM.quPaymentTotal.Next;
       PBar.Position := PBar.Position + 1;
       end;

       if SaleInvoice then
        fMas90.SaveDataToFile(SetPath('CR'))
       else
        fMas90.SaveDataToFile(edtPath.Text);

  finally
    HidePB;
    DM.ClosePaymentTotal;
    DM.ClosePaymentDetail;
    FreeAndNil(FMas90);
    RefreshScreen;
   end;
end;

procedure TFrmFile.BuildMas90ExpSaleInvoiceFile;
var
  myField : TField;
  MyType  : TMAS90FileType;
  i       : integer;
  Invoice_No,Invoice_Date,Division_No,Customer_No,Default_Whse,Tax_Schedule,Terms_Code,Salesprsn,
  Line_Type,Item_Number,Discount,Subj_to_Exempt,WareHouse_Code,Cost_Type,Product_Line,
  Unit_of_Measure,Lot_Serno_Dist,Cogs_Account,Reg_Sales_Acnt,Price_Ovrrddn,Kit_Item,Bkord_Comp_LN,
  Skip_Comp,Um_Conv_Factor,GL_Sales_Accnt,Misc_Item_Flag,Misc_Item,Stand_Kit_Bill,Tax_Class,
  Qty_Ordered,Qty_Shipped,Qty_Backordered,Unit_Price,Extension,Taxable_Amt,Non_Tax_Amt,Sales_Tax,
  Line_Disc_Perct,Unit_Cost,Item_Desc,Ship_Date,Order_Date,Invoice_due_dt,Discount_Due_Dt,
  Bill_to_Name,Bill_to_Addrs1,Bill_to_Addrs2,Bill_to_City,Bill_to_State,Bill_to_Zip_CD,Ship_to_Code,
  Ship_to_Name,Ship_to_Addrs1,Ship_to_Addrs2,Ship_to_City,Ship_to_State,Ship_to_Zip_CD,Comm_Desc_Line1,
  Comm_Desc_Line2,Charge_AMT,Misc_Slash,Misc_Code,Description,Freight : String;
  sValue : String;

  procedure ClearFields;
  begin
    Invoice_No      := '';
    Invoice_Date    := '';
    Division_No     := '';
    Customer_No     := '';
    Default_Whse    := '';
    Tax_Schedule    := '';
    Terms_Code      := '';
    Salesprsn       := '';
    Line_Type       := '';
    Item_Number     := '';
    Discount        := '';
    Subj_to_Exempt  := '';
    WareHouse_Code  := '';
    Cost_Type       := '';
    Product_Line    := '';
    Unit_of_Measure := '';
    Lot_Serno_Dist  := '';
    Cogs_Account    := '';
    Reg_Sales_Acnt  := '';
    Price_Ovrrddn   := '';
    Kit_Item        := '';
    Bkord_Comp_LN   := '';
    Skip_Comp       := '';
    Um_Conv_Factor  := '';
    GL_Sales_Accnt  := '';
    Misc_Item_Flag  := '';
    Misc_Item       := '';
    Stand_Kit_Bill  := '';
    Tax_Class       := '';
    Qty_Ordered     := '';
    Qty_Shipped     := '';
    Qty_Backordered := '';
    Unit_Price      := '';
    Extension       := '';
    Taxable_Amt     := '';
    Non_Tax_Amt     := '';
    Sales_Tax       := '';
    Line_Disc_Perct := '';
    Unit_Cost       := '';
    Item_Desc       := '';
    Ship_Date       := '';
    Order_Date      := '';
    Invoice_due_dt  := '';
    Discount_Due_Dt    := '';
    Bill_to_Name       := '';
    Bill_to_Addrs1     := '';
    Bill_to_Addrs2     := '';
    Bill_to_City       := '';
    Bill_to_State      := '';
    Bill_to_Zip_CD     := '';
    Ship_to_Code       := '';
    Ship_to_Name       := '';
    Ship_to_Addrs1     := '';
    Ship_to_Addrs2     := '';
    Ship_to_City       := '';
    Ship_to_State      := '';
    Ship_to_Zip_CD     := '';
    Comm_Desc_Line1    := '';
    Comm_Desc_Line2    := '';
    Charge_AMT         := '';
    Misc_Slash         := '';
    Misc_Code          := '';
    Description        := '';
    Freight            := '';
  end;

  procedure ModifySaleInvoiceFields;
  begin
    WareHouse_Code := GetMas90WareHouseCode(DM.quSaleInvoiceStoreName.AsString);
    Default_Whse   := GetMas90WareHouseCode(DM.quSaleInvoiceStoreName.AsString);
    Tax_Schedule   := GetMas90TaxSchedule(DM.quSaleInvoiceTaxCategory.AsString);
    Product_Line   := GetMas90CategoryCode(DM.quSaleInvoiceCategoryName.AsString);
    Cogs_Account   := DM.GetIniFile('ColumnMas90Setup', 'Cost_Account');
    Reg_Sales_Acnt := DM.GetIniFile('ColumnMas90Setup', 'Sales_Account');
    Lot_Serno_Dist := DM.quSaleInvoiceSerialNumber.AsString;
    GL_Sales_Accnt := DM.GetIniFile('ColumnMas90Setup', 'GLSales_Account');
    Division_No := '00';
    Terms_Code  := '00';
    Salesprsn := '1';
    Subj_to_Exempt := 'N';
    Cost_Type := '1';
    Unit_of_Measure := 'EACH';
    Price_Ovrrddn  := 'Y';
    Kit_Item := 'N';
    Bkord_Comp_LN := 'N';
    Skip_Comp := 'N';
    Um_Conv_Factor := '1';
    Misc_Item_Flag  := DM.quSaleInvoiceMiscItemFlag.AsString;
    Misc_Item       := DM.quSaleInvoiceMiscItemCode.AsString;
    Stand_Kit_Bill := 'N';
    Qty_Backordered := '0';
    Charge_AMT := '0';
    Invoice_No  := fMas90.PrepareInvoiceNoForMAS90(Invoice_No);
    Customer_No := '40000' + Customer_No;
    Customer_No := fMas90.PrepareCustomerNoForMAS90(Customer_No);

    if Invoice_Date <> '' then
     Invoice_Date := FormatDateTime('ddddd',StrtoDateTime(Invoice_Date));

    if Ship_Date <> '' then
     Ship_Date := FormatDateTime('ddddd',StrtoDateTime(Ship_Date));

    if Order_Date <> '' then
     Order_Date := FormatDateTime('ddddd',StrtoDateTime(Order_Date));

    if Invoice_due_dt <> '' then
     Invoice_due_dt := FormatDateTime('ddddd',StrtoDateTime(Invoice_due_dt));

    if Discount_Due_Dt <> '' then
     Discount_Due_Dt := FormatDateTime('ddddd',StrtoDateTime(Discount_Due_Dt));
  end;
begin

  if not Assigned(fMas90) then
     FMas90 := TMas90.Create;

  MyType := Mas90_FILE_TYPE_SALE_INVOICE;

  FIDCustomer := TStringList.Create;


  DM.OpenSaleInvoice(edtBeginDate.Text,edtEndDate.Text);

  if DM.quSaleinvoice.RecordCount = 0 then
       Exit;

  ShowPB('SaleInvoice',DM.quSaleinvoice.RecordCount);
  try

    DM.quSaleinvoice.First;

    While not DM.quSaleinvoice.Eof do
       begin

       //Vejo todas as colunas marcadas
       for i:=1 to sgColumns.RowCount-1 do
          if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then //Office Manager columns for selecionado
             begin

             //Localize field
             myField := DM.quSaleInvoice.FindField(Trim(sgColumns.Cells[COLUMN_OFFICEM,i]));

             if myField <> nil then
                begin
                sValue := Trim(myField.AsString);

                sValue := StringReplace(sValue, ',', ' ', [rfReplaceAll]);

                if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Invoice_No])  then
                    Invoice_No := Invoice_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Invoice_Date])  then
                    Invoice_Date := Invoice_Date + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Division_No])  then
                    Division_No := Division_No + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Customer_No]) then
                    begin
                    Customer_No := Customer_No + sValue;
                    AddIdCustomer(DM.quSaleInvoiceCustomer_No.AsString);
                    end
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Default_Whse]) then
                //        Default_Whse := Default_Whse + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Tax_Schedule]) then
                //        Tax_Schedule := Tax_Schedule + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Terms_Code]) then
                        Terms_Code := Terms_Code + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Salesprsn ]) then
                        Salesprsn  := Salesprsn   + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Line_Type]) then
                         Line_Type :=  Line_Type + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Item_Number]) then
                        Item_Number := Item_Number + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Discount]) then
                        Discount := Discount + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Subj_to_Exempt]) then
                        Subj_to_Exempt := Subj_to_Exempt + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_WareHouse_Code]) then
                //        WareHouse_Code := WareHouse_Code + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Cost_Type ]) then
                        Cost_Type  := Cost_Type  + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Product_Line]) then
                //        Product_Line  := Product_Line  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Unit_of_Measure]) then
                        Unit_of_Measure := Unit_of_Measure + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Lot_Serno_Dist]) then
                //        Lot_Serno_Dist := Lot_Serno_Dist + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Cogs_Account]) then
                //        Cogs_Account := Cogs_Account + sValue
                //else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Reg_Sales_Acnt]) then
                //        Reg_Sales_Acnt := Reg_Sales_Acnt + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Price_Ovrrddn]) then
                        Price_Ovrrddn := Price_Ovrrddn + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Kit_Item]) then
                        Kit_Item  := Kit_Item  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bkord_Comp_LN]) then
                        Bkord_Comp_LN := Bkord_Comp_LN + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Skip_Comp]) then
                        Skip_Comp := Skip_Comp + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Um_Conv_Factor]) then
                        Um_Conv_Factor := Um_Conv_Factor + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_GL_Sales_Accnt]) then
                        GL_Sales_Accnt := GL_Sales_Accnt + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Misc_Item_Flag]) then
                        Misc_Item_Flag := Misc_Item_Flag + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Misc_Item]) then
                        Misc_Item := Misc_Item + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Stand_Kit_Bill]) then
                        Stand_Kit_Bill := Stand_Kit_Bill + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Tax_Class]) then
                        Tax_Class := Tax_Class + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Qty_Ordered]) then
                        Qty_Ordered := Qty_Ordered + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Qty_Shipped]) then
                        Qty_Shipped := Qty_Shipped + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Qty_Backordered]) then
                        Qty_Backordered := Qty_Backordered + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Unit_Price ]) then
                        Unit_Price  := Unit_Price  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Extension]) then
                        Extension := Extension + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Taxable_Amt]) then
                        Taxable_Amt := Taxable_Amt + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Non_Tax_Amt]) then
                        Non_Tax_Amt := Non_Tax_Amt + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Sales_Tax]) then
                        Sales_Tax := Sales_Tax + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Line_Disc_Perct]) then
                        Line_Disc_Perct := Line_Disc_Perct + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Unit_Cost]) then
                        Unit_Cost := Unit_Cost + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Item_Desc ]) then
                        Item_Desc  := Item_Desc  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Ship_Date]) then
                        Ship_Date := Ship_Date + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Order_Date]) then
                        Order_Date := Order_Date + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Invoice_due_dt]) then
                        Invoice_due_dt := Invoice_due_dt + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Discount_Due_Dt]) then
                        Discount_Due_Dt := Discount_Due_Dt + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bill_to_Name]) then
                        Bill_to_Name:= Bill_to_Name + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bill_to_Addrs1]) then
                        Bill_to_Addrs1 := Bill_to_Addrs1 + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bill_to_Addrs2]) then
                        Bill_to_Addrs2 := Bill_to_Addrs2 + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bill_to_City]) then
                        Bill_to_City := Bill_to_City + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bill_to_State ]) then
                        Bill_to_State  := Bill_to_State  + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Bill_to_Zip_CD]) then
                        Bill_to_Zip_CD := Bill_to_Zip_CD + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Ship_to_Code]) then
                        Ship_to_Code := Ship_to_Code + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Ship_to_Name]) then
                        Ship_to_Name := Ship_to_Name + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Ship_to_Addrs1]) then
                        Ship_to_Addrs1 := Ship_to_Addrs1 + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Ship_to_Addrs2]) then
                        Ship_to_Addrs2 := Ship_to_Addrs2 + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Ship_to_City]) then
                        Ship_to_City := Ship_to_City + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Ship_to_State]) then
                        Ship_to_State := Ship_to_State + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Ship_to_Zip_CD]) then
                        Ship_to_Zip_CD := Ship_to_Zip_CD + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Comm_Desc_Line1]) then
                        Comm_Desc_Line1 := Comm_Desc_Line1 + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Comm_Desc_Line2]) then
                        Comm_Desc_Line2 := Comm_Desc_Line2 + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Charge_AMT]) then
                        Charge_AMT := Charge_AMT + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Misc_Slash]) then
                        Misc_Slash := Misc_Slash + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Misc_Code]) then
                        Misc_Code := Misc_Code + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Description]) then
                        Description := Description + sValue
                else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AMas90EntityColumns[Mas90_COL_ENTITY_Freight]) then
                        Freight := Freight + sValue;
                end;
             end;

       ModifySaleInvoiceFields;

       fMas90.AddSaleInvoiceEntity(MyType, Invoice_No,Invoice_Date,Division_No,Customer_No,Default_Whse,Tax_Schedule,Terms_Code,
                                   Salesprsn,Line_Type,Item_Number,Discount,Subj_to_Exempt,WareHouse_Code,Cost_Type,Product_Line,
                                   Unit_of_Measure,Lot_Serno_Dist,Cogs_Account,Reg_Sales_Acnt,Price_Ovrrddn,Kit_Item,Bkord_Comp_LN,
                                   Skip_Comp,Um_Conv_Factor,GL_Sales_Accnt,Misc_Item_Flag,Misc_Item,Stand_Kit_Bill,Tax_Class,
                                   Qty_Ordered,Qty_Shipped,Qty_Backordered,Unit_Price,Extension,Taxable_Amt,Non_Tax_Amt,Sales_Tax,
                                   Line_Disc_Perct,Unit_Cost,Item_Desc,Ship_Date,Order_Date,Invoice_due_dt,Discount_Due_Dt,
                                   Bill_to_Name,Bill_to_Addrs1,Bill_to_Addrs2,Bill_to_City,Bill_to_State,Bill_to_Zip_CD,Ship_to_Code,
                                   Ship_to_Name,Ship_to_Addrs1,Ship_to_Addrs2,Ship_to_City,Ship_to_State,Ship_to_Zip_CD,Comm_Desc_Line1,
                                   Comm_Desc_Line2,Charge_AMT,Misc_Slash,Misc_Code,Description,Freight);
       ClearFields;
       DM.quSaleinvoice.Next;
       PBar.Position := PBar.Position +1;
       end;

       fMas90.SaveDataToFile(edtPath.Text);
  finally
   DM.CloseSaleInvoice;
   HidePB
   end;

   BuildMas90ExpPaymentFile(True);
   BuildMas90ExpCustomerFile(True);
   FreeAndNil(FIDCustomer);
   FreeAndNil(FMas90);
   DM.iEntityType := ENTITY_SALE_INVOICE;
   RefreshScreen;
end;

function TFrmFile.Start: Boolean;
var name:String;
begin
   Case DM.iEntityType of
       ENTITY_CUSTOMER     : begin
                             lbType.Caption    := 'Customer';
                             PanelDate.Visible := False;
                             Name              := 'CUST';
                             end;
       ENTITY_PAYMENT      : begin
                             lbType.Caption := 'Payment';
                             Name           := 'CR';
                             end;
       ENTITY_SALE_INVOICE : begin
                             lbType.Caption := 'Sale Invoice';
                             Name           := 'SOInvoice';
                             end;
    end;

   HidePB;
   edtPath.Text := SetPath(name);
   edtBeginDate.Date := Now;
   edtEndDate.Date := Now;

   if not Assigned(fMas90) then
     FMas90 := TMas90.Create;

   MountGrid;
   MountGridClient;

   ShowModal;
end;

procedure TFrmFile.btFileClick(Sender: TObject);
begin
 if edtPath.Text = '' then
  MsgBox('Select a File located', vbInformation + vbOKOnly)
 else if ((edtBeginDate.Text='') or (edtEndDate.Text='')) and (DM.iEntityType<>ENTITY_CUSTOMER) then
  MsgBox('Select a Date to Filter', vbInformation + vbOKOnly)
 else
  begin
   HidePB;
   Screen.Cursor := crHourGlass;
   Case DM.iEntityType of
       ENTITY_CUSTOMER     : BuildMas90ExpCustomerFile(False);
       ENTITY_PAYMENT      : BuildMas90ExpPaymentFile(False);
       ENTITY_SALE_INVOICE : BuildMas90ExpSaleInvoiceFile;
    end;
   MsgBox('Operation successfully', vbInformation + vbOKOnly); 
   Screen.Cursor := crDefault;
  end;
end;

procedure TFrmFile.FillMas90ColumnsGrid;
begin

  AddMas90ColumnsToImportExport;

  FMas90.GetColumnsToImport(sgColumns, nil);

  sgColumns.Cells[COLUMN_ID,0]        := 'Col';
  sgColumns.Cells[COLUMN_OTHER_ACC,0] := 'Mas90';
  sgColumns.Cells[COLUMN_OFFICEM,0]   := 'Main Retail';

end;

procedure TFrmFile.AddIdCustomer(IDCustomer :string);
begin
 if FIDCustomer.IndexOf(IDCustomer) = -1 then
  FIDCustomer.Add(IDCustomer);
end;

function TFrmFile.SetPath(name: String): String;
begin
 Result:= DM.fLocalPath + FormatDateTime('yyyymmdd',Now) + '_' + name + '.csv';
end;

procedure TFrmFile.ClearColumns;
var i: integer;
begin
 for i:=1 to sgColumns.RowCount-1 do
  begin
  sgColumns.Cells[COLUMN_OTHER_ACC,i] := '';
  sgColumns.Cells[COLUMN_OFFICEM,i] := '';
  end;
end;

procedure TFrmFile.MountGrid;
begin
 FillMas90ColumnsGrid;
 GetGridColumn;
end;

procedure TFrmFile.MountGridClient;
var i,z: Integer;
begin
  sgColumnsClient.RowCount      := sgColumns.RowCount;
  for i:=0 to sgColumns.RowCount do
    for z:=0 to sgColumns.ColCount do
     sgColumnsClient.Cells[z,i] := sgColumns.Cells[z,i];
end;

procedure TFrmFile.HidePB;
begin
 lbPB.Caption  := '';
 PBar.Max      := 0;
 lbPB.Visible  := False;
 PBar.Visible  := False;
end;

procedure TFrmFile.ShowPB(Texto :String; Maxpos: Integer);
begin
 lbPB.Visible  := True;
 PBar.Visible  := True;
 lbPB.Caption  := Texto;
 PBar.Position := 0;
 PBar.Max      := MaxPos;
 Application.ProcessMessages;
end;

procedure TFrmFile.BCloseClick(Sender: TObject);
begin
 Close;
end;

function TFrmFile.GetMas90WareHouseCode(Store: String): String;
var sResult : String;
begin
 Result := ParseParam(DM.GetIniFile('ColumnMas90Setup', 'Store'), Store);
end;

function TFrmFile.GetMas90CategoryCode(Category: String): String;
var sResult : String;
begin
 Result := ParseParam(DM.GetIniFile('ColumnMas90Setup', 'Category'), Category);
end;

function TFrmFile.GetMas90TaxSchedule(Tax: String): String;
var sResult : String;
begin
 Result := ParseParam(DM.GetIniFile('ColumnMas90Setup', 'TaxSchedule'), Tax);
end;

procedure TFrmFile.RefreshScreen;
begin
 if not Assigned(fMas90) then
  FMas90 := TMas90.Create;

 MountGrid;
 MountGridClient;
end;

end.
