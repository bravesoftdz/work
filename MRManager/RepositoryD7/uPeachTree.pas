unit uPeachTree;

{*

   PEACHTREE FUNCTION TO EXPORT DATA
   APPLICATION NETWORK INC.

   LOG ----------------------------
   Created by Rodrigo Costa
   05/31/02.

*}

interface

uses Sysutils, classes, grids;

type

   TPeachTreeEntityColumns = array[0..34] of String;

   TPeachTreeFileType      = (PT_FILE_TYPE_CUSTOMER,
                              PT_FILE_TYPE_VENDOR,
                              PT_FILE_TYPE_SALES_PERSON);


const

 CHART_OF_ACCOUNT_CASH       = 0;  //Cash
 CHART_OF_ACCOUNT_RECEIVABLE = 1;  //Receivable (Accounts Receivable)
 CHART_OF_ACCOUNT_INVENTORY  = 2;  //Inventory
 CHART_OF_ACCOUNT_INCOME     = 21; //Income
 CHART_OF_ACCOUNT_EXPENSES   = 24; //Expense

  {
  0 => Cash
  1 => Receivable (Accounts Receivable)
  2 => Inventory
  3 => Unused1 (Do not select)
  4 =>OthCurAsset (Other Current Assets)
  5 => FixedAsset (Fixed Assets)
  6 => AccumDepr (Accumulated Depreciation)
  7 => Unused2 (Do not select)
  8 => OtherAssets (Other Assets)
  9 => Unused4 (Do not select)
  10 => Payable (Accounts Payable)
  11 => OthCurLiability (Other Current Liabilities)
  12 => Unused6 (Do not select)
  13 => OthLiability (Long Term Liabilities)
  14 => Unused7 (Do not select)
  15 => EquityNoClose (Equity - Doesn't Close)),
  16 => Unused8 (Do not select)
  17 => RetEarn (Equity - Retained Earnings
  18 => EquityClose (Equity - Gets Closed))
  19 => Unused9 (Do not select)
  20 => Income
  21 => Unused10 (Do not select)
  22 => CostSales (Cost of Sales)
  23 => Expense
  }

   APeachTreeEntityColumns : TPeachTreeEntityColumns = ('Employee ID',
                                                        'Employee Name',
                                                        'Address-Line One',
                                                        'Address-Line Two',
                                                        'City',
                                                        'State',
                                                        'Zip',
                                                        'Country',
                                                        'Employee Social Security #',
                                                        'Telephone',
                                                        'Employee E-mail',
                                                        'Birthday',
                                                        'Special Note',

                                                        'Customer ID',
                                                        'Customer Name',
                                                        'Contact',
                                                        'Bill to Address-Line One',
                                                        'Bill to Address-Line Two',
                                                        'Bill to City',
                                                        'Bill to State',
                                                        'Bill to Zip',
                                                        'Bill to Country',
                                                        'Telephone 1',
                                                        'Telephone 2',
                                                        'Fax Number',
                                                        'Customer E-mail',
                                                        'G/L Sales Account',
                                                        'Customer Web Site',

                                                        'Vendor ID',
                                                        'Vendor Name',
                                                        'Vendor E-mail',
                                                        'Vendor Web Site',
                                                        'G/L Purchase Account',
                                                        'Inactive',
                                                        'Employee');

   PT_COL_ENTITY_EMPLOYEE_ID             = 0;
   PT_COL_ENTITY_EMPLOYEE_NAME           = 1;
   PT_COL_ENTITY_ADDRESS_1               = 2;
   PT_COL_ENTITY_ADDRESS_2               = 3;
   PT_COL_ENTITY_CITY                    = 4;
   PT_COL_ENTITY_STATE                   = 5;
   PT_COL_ENTITY_ZIP                     = 6;
   PT_COL_ENTITY_COUNTRY                 = 7;
   PT_COL_ENTITY_EMPLOYEE_SS             = 8;
   PT_COL_ENTITY_EMPLOYEE_PHONE          = 9;
   PT_COL_ENTITY_EMPLOYEE_EMAIL          = 10;
   PT_COL_ENTITY_EMPLOYEE_BIRTHDAY       = 11;
   PT_COL_ENTITY_EMPLOYEE_NOTES          = 12;

   PT_COL_ENTITY_CUSTOMER_ID             = 13;
   PT_COL_ENTITY_CUSTOMER_NAME           = 14;
   PT_COL_ENTITY_CONTACT                 = 15;
   PT_COL_ENTITY_CUSTOMER_BILL_ADDRESS_1 = 16;
   PT_COL_ENTITY_CUSTOMER_BILL_ADDRESS_2 = 17;
   PT_COL_ENTITY_CUSTOMER_BILL_CITY      = 18;
   PT_COL_ENTITY_CUSTOMER_BILL_STATE     = 19;
   PT_COL_ENTITY_CUSTOMER_BILL_ZIP       = 20;
   PT_COL_ENTITY_CUSTOMER_BILL_COUNTRY   = 21;
   PT_COL_ENTITY_PHONE_1                 = 22;
   PT_COL_ENTITY_PHONE_2                 = 23;
   PT_COL_ENTITY_FAX                     = 24;
   PT_COL_ENTITY_CUSTOMER_EMAIL          = 25;
   PT_COL_ENTITY_CUSTOMER_GENERAL_LED_ID = 26;
   PT_COL_ENTITY_CUSTOMER_WEBSITE        = 27;

   PT_COL_ENTITY_VENDOR_ID               = 28;
   PT_COL_ENTITY_VENDOR_NAME             = 29;
   PT_COL_ENTITY_VENDOR_EMAIL            = 30;
   PT_COL_ENTITY_VENDOR_WEBSITE          = 31;
   PT_COL_ENTITY_VENDOR_GENERAL_LED_ID   = 32;
   PT_COL_ENTITY_INACTIVE                = 33;
   PT_COL_ENTITY_EMPLOYEE_EMPLOYEE       = 34;



Type

   //Delete Row and Col in a StringGrid
   TAdvStringGrid = Class(TStringGrid)
      Public
         Procedure DeleteRow(ARow:LongInt); Override;
         Procedure DeleteColumn(AColumn:LongInt); Override;
   End;


   TDefaultClass = Class
       public
          function Print:String; virtual; abstract;
   end;

   TChartOfAccount = class(TDefaultClass)
      private
        FDesc     : String;
        FID       : String;
        FType     : String;
        FInactive : String;
        procedure SetAccID(sID : String);
      public
          property AccDescription : String read FDesc     write FDesc;
          property AccountID      : String read FID       write SetAccID;
          property AccType        : String read FType     write FType;
          property Inactive       : String read FInactive write FInactive;
          function Print:String; override;
   end;

   TParentEntity = class(TDefaultClass)
      private
         FName       : String;
         FID         : String;
         FAddress1   : String;
         FAddress2   : String;
         FCity       : String;
         FState      : String;
         FZip        : String;
         FCountry    : String;
         FPhone1     : String;
         FEmail      : String;
         FInactive   : String;
      public
          property Name     : String read FName     write FName;
          property ID       : String read FID       write FID;
          property Address1 : String read FAddress1 write FAddress1;
          property Address2 : String read FAddress2 write FAddress2;
          property City     : String read FCity     write FCity;
          property State    : String read FState    write FState;
          property Zip      : String read FZip      write FZip;
          property Country  : String read FCountry  write FCountry;
          property Phone1   : String read FPhone1   write FPhone1;
          property Email    : String read FEmail    write FEmail;
          property Inactive : String read FInactive write FInactive;
          function Print:String; override; abstract;
   end;

   TEntityEmployee = class(TParentEntity)
      private
        FSocialSec : String;
        FBirthday  : String;
        FNotes     : String;
        FEmployee  : String;
      public
        property SocialSec : String read FSocialSec write FSocialSec;
        property Birthday  : String read FBirthday  write FBirthday;
        property Notes     : String read FNotes     write FNotes;
        property Employee  : String read FEmployee  write FEmployee;
        function Print:String; override;
   end;

   TEntityCustomer = class(TParentEntity)
      private
         FIDChartAcc : String;
         FContact    : String;
         FPhone2     : String;
         FFax        : String;
         FWebSite    : String;
      public
         property IDChartAcc : String read FIDChartAcc write FIDChartAcc;
         property Contact    : String read FContact    write FContact;
         property Phone2     : String read FPhone2     write FPhone2;
         property Fax        : String read FFax        write FFax;
         property WebSite    : String read FWebSite    write FWebSite;
         function Print:String; override;
   end;

   TEntityVendor = class(TParentEntity)
      private
         FIDChartAcc : String;
         FContact    : String;
         FPhone2     : String;
         FFax        : String;
         FWebSite    : String;
      public
         property IDChartAcc : String read FIDChartAcc write FIDChartAcc;
         property Contact    : String read FContact    write FContact;
         property Phone2     : String read FPhone2     write FPhone2;
         property Fax        : String read FFax        write FFax;
         property WebSite    : String read FWebSite    write FWebSite;
         function Print:String; override;
   end;

   TPeachTree =  class
       private
           FBankAccount       : TChartOfAccount;
           FChartAccountCateg : TChartOfAccount;
           FDefaultEntity     : TParentEntity;
           FChartAccountList  : TStringList;
           FPeachTreeColumns  : TStringList;             //List of Columns to be imported to the System
           FEntityList        : TStringList;             //Entity (Vendor, Customer, etc.)List

           procedure FreeAllEntityListObj;
           procedure FreeAllChartAccountListObj;
           function PrintChartOfAccount:String;
           function PrintEntities:String;
       public
           procedure SetBank(sID, sDesc, sType, sInactive : String);
           procedure AddColumnToImport(PeachTreeColumn:Integer);
           procedure GetColumnsToImport(ColumnGrid, ListGrid:TStringGrid);
           procedure ClearColumnsToImport;
           procedure OpenPeachTreeFile(sPath:String; Grid : TStringGrid);

           function SaveDataToFile(sPath:String):Boolean;
           function AddChartOfAccount(sID, sDesc, sType, sInactive : String):Integer;
           function AddEntity(FileType:TPeachTreeFileType; ID, Name, IDChartAcc,
                              Addre1, Addre2, City, State, Zip, Contact1, Phone1,
                              Phone2, Fax, Email, WebSite, Country, SocialSec,
                              BirthDay, Notes : String):Integer;


           Constructor Create;
           Destructor Destroy; override;
   end;


implementation

uses uSaveToFile, uStringFunctions;

const

   FIELD_SEPARATOR                   = ',';         //comma
   BEGIN_NEW_LINE                    = '' + #13#10; //start a new line

   CHART_OF_ACCOUNT_HEADER           = 'Account ID'           +FIELD_SEPARATOR+
                                       'Account Description'  +FIELD_SEPARATOR+
                                       'Account Type'         +FIELD_SEPARATOR+
                                       'Inactive';

   VENDOR_HEADER                     = 'Vendor ID'            +FIELD_SEPARATOR+
                                       'Vendor Name'          +FIELD_SEPARATOR+
                                       'G/L Purchase Account' +FIELD_SEPARATOR+
                                       'Address-Line One'     +FIELD_SEPARATOR+
                                       'Address-Line Two'     +FIELD_SEPARATOR+
                                       'City'                 +FIELD_SEPARATOR+
                                       'State'                +FIELD_SEPARATOR+
                                       'Zip'                  +FIELD_SEPARATOR+
                                       'Country'              +FIELD_SEPARATOR+
                                       'Contact'              +FIELD_SEPARATOR+
                                       'Telephone 1'          +FIELD_SEPARATOR+
                                       'Telephone 2'          +FIELD_SEPARATOR+
                                       'Fax Number'           +FIELD_SEPARATOR+
                                       'Vendor E-mail'        +FIELD_SEPARATOR+
                                       'Vendor Web Site'      +FIELD_SEPARATOR+
                                       'Inactive';


   CUSTOMER_HEADER                   = 'Customer ID'              +FIELD_SEPARATOR+
                                       'Customer Name'            +FIELD_SEPARATOR+
                                       'G/L Sales Account'        +FIELD_SEPARATOR+
                                       'Bill to Address-Line One' +FIELD_SEPARATOR+
                                       'Bill to Address-Line Two' +FIELD_SEPARATOR+
                                       'Bill to City'             +FIELD_SEPARATOR+
                                       'Bill to State'            +FIELD_SEPARATOR+
                                       'Bill to Zip'              +FIELD_SEPARATOR+
                                       'Bill to Country'          +FIELD_SEPARATOR+
                                       'Contact'                  +FIELD_SEPARATOR+
                                       'Telephone 1'              +FIELD_SEPARATOR+
                                       'Telephone 2'              +FIELD_SEPARATOR+
                                       'Fax Number'               +FIELD_SEPARATOR+
                                       'Customer E-mail'          +FIELD_SEPARATOR+
                                       'Customer Web Site'        +FIELD_SEPARATOR+
                                       'Inactive';

   EMPLOYEE_HEADER                   = 'Employee ID'                +FIELD_SEPARATOR+
                                       'Employee Name'              +FIELD_SEPARATOR+
                                       'Address-Line One'           +FIELD_SEPARATOR+
                                       'Address-Line Two'           +FIELD_SEPARATOR+
                                       'City'                       +FIELD_SEPARATOR+
                                       'State'                      +FIELD_SEPARATOR+
                                       'Zip'                        +FIELD_SEPARATOR+
                                       'Country'                    +FIELD_SEPARATOR+
                                       'Telephone'                  +FIELD_SEPARATOR+
                                       'Employee E-mail'            +FIELD_SEPARATOR+
                                       'Employee Social Security #' +FIELD_SEPARATOR+
                                       'Employee'                   +FIELD_SEPARATOR+
                                       'Inactive';

{--------- Items on a String Grid -----------}

Procedure TAdvStringGrid.DeleteRow(ARow:LongInt);
Begin
 Inherited DeleteRow(ARow)
End;

Procedure TAdvStringGrid.DeleteColumn(AColumn:LongInt);
Begin
 Inherited DeleteColumn(AColumn)
End;


{ ---------- TPeachTree -----------}

function TPeachTree.AddEntity(FileType:TPeachTreeFileType; ID, Name, IDChartAcc,
                              Addre1, Addre2, City, State, Zip, Contact1, Phone1,
                              Phone2, Fax, Email, WebSite, Country, SocialSec,
                              BirthDay, Notes : String):Integer;
begin

    Case FileType of
       PT_FILE_TYPE_CUSTOMER     :
                 begin
                 FDefaultEntity := TEntityCustomer.Create;
                 TEntityCustomer(FDefaultEntity).IDChartAcc := IDChartAcc;
                 TEntityCustomer(FDefaultEntity).Contact    := Contact1;
                 TEntityCustomer(FDefaultEntity).Phone2     := Phone2;
                 TEntityCustomer(FDefaultEntity).Fax        := Fax;
                 TEntityCustomer(FDefaultEntity).WebSite    := WebSite;
                 end;
       PT_FILE_TYPE_VENDOR       :
                 begin
                 FDefaultEntity := TEntityVendor.Create;
                 TEntityVendor(FDefaultEntity).IDChartAcc := IDChartAcc;
                 TEntityVendor(FDefaultEntity).Contact    := Contact1;
                 TEntityVendor(FDefaultEntity).Phone2     := Phone2;
                 TEntityVendor(FDefaultEntity).Fax        := Fax;
                 TEntityVendor(FDefaultEntity).WebSite    := WebSite;
                 end;
       PT_FILE_TYPE_SALES_PERSON :
                 begin
                 FDefaultEntity := TEntityEmployee.Create;
                 TEntityEmployee(FDefaultEntity).SocialSec  := SocialSec;
                 TEntityEmployee(FDefaultEntity).Birthday   := Birthday;
                 TEntityEmployee(FDefaultEntity).Notes      := Notes;
                 TEntityEmployee(FDefaultEntity).Employee   := 'TRUE';
                 end;
    end;

    //Commun Fields
    FDefaultEntity.ID       := ID;
    FDefaultEntity.Name     := Name;
    FDefaultEntity.Address1 := Addre1;
    FDefaultEntity.Address2 := Addre2;
    FDefaultEntity.City     := City;
    FDefaultEntity.State    := State;
    FDefaultEntity.Zip      := Zip;
    FDefaultEntity.Country  := Country;
    FDefaultEntity.Phone1   := Phone1;
    FDefaultEntity.Email    := Email;
    FDefaultEntity.Inactive := 'FALSE';

    Result := FEntityList.AddObject('', FDefaultEntity);

end;


procedure TPeachTree.GetColumnsToImport(ColumnGrid, ListGrid:TStringGrid);
var
  i : integer;

  function SearchColumn(sColumn:String):String;
  var
  j : integer;
  begin
  Result  := '';
  sColumn := Trim(sColumn);
     for j:=0 to ListGrid.ColCount-1 do
        if Trim(ListGrid.Cells[j,0]) = sColumn then
           begin
           Result := IntToStr(j);
           Break;
           end;
  end;

begin

   if not Assigned(FPeachTreeColumns) then
      Exit;

   ColumnGrid.RowCount := FPeachTreeColumns.Count+1;
   ColumnGrid.ColCount := 3;

   for i:=0 to FPeachTreeColumns.Count-1 do
      begin
      if ListGrid <> nil then
         ColumnGrid.Cells[0,i+1] := SearchColumn(FPeachTreeColumns.Strings[i]);

      ColumnGrid.Cells[1,i+1] := FPeachTreeColumns.Strings[i];
      end;
end;


procedure TPeachTree.OpenPeachTreeFile(sPath:String; Grid : TStringGrid);

   procedure ClearList;
   var j : integer;
   begin
   with Grid do
       begin
       for j:= 0 to RowCount-1 do
           TAdvStringGrid(Grid).DeleteRow(j);
       end;
   end;

var
  i : integer;

begin

    //Clear garbage
    FEntityList.Clear;
    ClearList;

    //Open the file
    FEntityList.LoadFromFile(sPath);

    //How many valid rows
    Grid.RowCount := FEntityList.Count;
    //How many valid cols
    if FEntityList.Count > 0 then
       Grid.ColCount := CountChar(FIELD_SEPARATOR, FEntityList.Strings[0]);
    //Row fixed Header
    Grid.FixedRows := 1;

    for i := 0 to FEntityList.Count-1 do
        Grid.Rows[i].Text :=  StringReplace(FEntityList.Strings[i], FIELD_SEPARATOR, #13, [rfReplaceAll]);

end;


procedure TPeachTree.ClearColumnsToImport;
begin
  if Assigned(FPeachTreeColumns) then
     FPeachTreeColumns.Clear;
end;

procedure TPeachTree.AddColumnToImport(PeachTreeColumn:Integer);
var
    Column : String;
begin
   if not Assigned(FPeachTreeColumns) then
      FPeachTreeColumns := TStringList.Create;

   Column := APeachTreeEntityColumns[PeachTreeColumn];

   if ValueLocatedInList(FPeachTreeColumns, Column) = -1 then
      FPeachTreeColumns.Add(Column);

end;

function TPeachTree.AddChartOfAccount(sID, sDesc, sType, sInactive : String):Integer;
begin

  FChartAccountCateg           := TChartOfAccount.Create;
  FChartAccountCateg.FID       := sID;
  FChartAccountCateg.FDesc     := sDesc;
  FChartAccountCateg.FType     := sType;
  FChartAccountCateg.FInactive := sInactive;

  Result := FChartAccountList.AddObject('', FChartAccountCateg);

end;


procedure TPeachTree.SetBank(sID, sDesc, sType, sInactive : String);
begin

   if not Assigned(FBankAccount) then
      FBankAccount := TChartOfAccount.Create;

   FBankAccount.FID       := sID;
   FBankAccount.FDesc     := sDesc;
   FBankAccount.FType     := sType;
   FBankAccount.FInactive := sInactive;

end;


function TPeachTree.SaveDataToFile(sPath:String):Boolean;
var
   aFile : TSaveFile;
begin

   Result := False;

   try
     aFile := TSaveFile.Create;
     aFile.FilePath := sPath;
     aFile.AddText(PrintChartOfAccount);
     aFile.AddText(PrintEntities);
     Result := (aFile.CreateFile = -1);
   finally
     aFile.Free;
   end;

end;


function TPeachTree.PrintEntities:String;
var
  i : Integer;
begin
  Result := '';

  for i:=0 to FEntityList.Count-1 do
      if Assigned(FEntityList.Objects[i]) then
         Result := Result + TDefaultClass(FEntityList.Objects[i]).Print;

  if Result = '' then
     Exit;

  if Assigned(FEntityList.Objects[0]) then
    if (FEntityList.Objects[0] is TEntityVendor) then
        Result := VENDOR_HEADER + Result
    else if (FEntityList.Objects[0] is TEntityCustomer) then
        Result := CUSTOMER_HEADER + Result
    else if (FEntityList.Objects[0] is TEntityEmployee) then
        Result := EMPLOYEE_HEADER + Result;
    
end;


function TPeachTree.PrintChartOfAccount:String;
var
  i : Integer;
begin

  Result := '';

  if Assigned(FBankAccount) then
     Result := Result + FBankAccount.Print;

  for i:=0 to FChartAccountList.Count-1 do
      if Assigned(FChartAccountList.Objects[i]) then
         Result := Result + TDefaultClass(FChartAccountList.Objects[i]).Print;

  if Result = '' then
     Exit;

  Result := CHART_OF_ACCOUNT_HEADER + Result;

end;


procedure TPeachTree.FreeAllChartAccountListObj;
var
  i : integer;
begin
    //release all objects in the List
    with FChartAccountList do
      for i:=0 to Count-1 do
         if Assigned(Objects[i]) then
            begin
            Objects[i].Free;
            Objects[i] := nil;
            end;
end;

procedure TPeachTree.FreeAllEntityListObj;
var
  i : integer;
begin
    //release all objects in the List
    with FEntityList do
      for i:=0 to Count-1 do
         if Assigned(Objects[i]) then
            begin
            Objects[i].Free;
            Objects[i] := nil;
            end;
end;


Constructor TPeachTree.Create;
begin
   inherited Create;

   FChartAccountList := TStringList.Create;
   FEntityList       := TStringList.Create;

end;

Destructor TPeachTree.Destroy;
begin


  FreeAllChartAccountListObj;
  FreeAndNil(FChartAccountList);

  FreeAllEntityListObj;
  FreeAndNil(FEntityList);

  if Assigned(FDefaultEntity) then
     begin
     FEntityList := Nil;
     FEntityList.Free;
     end;

  if Assigned(FPeachTreeColumns) then
     begin
     FPeachTreeColumns := Nil;
     FPeachTreeColumns.Free;
     end;


  if Assigned(FBankAccount) then
     begin
     FBankAccount := Nil;
     FBankAccount.Free;
     end;

  if Assigned(FChartAccountCateg) then
     begin
     FChartAccountCateg := Nil;
     FChartAccountCateg.Free;
     end;

  inherited Destroy;
end;


{ ---------- TChartOfAccount -----------}

procedure TChartOfAccount.SetAccID(sID : String);
begin
   FID := sID[15];
end;

function TChartOfAccount.Print:String;
begin

  Result :=             BEGIN_NEW_LINE  +
            FID       + FIELD_SEPARATOR +
            FDesc     + FIELD_SEPARATOR +
            FType     + FIELD_SEPARATOR +
            FInactive;

end;


{ ---------- TEntityEmployee -----------}
function TEntityEmployee.Print:String;
begin

  Result :=               BEGIN_NEW_LINE  +
            FID         + FIELD_SEPARATOR +
            FName       + FIELD_SEPARATOR +
            FAddress1   + FIELD_SEPARATOR +
            FAddress2   + FIELD_SEPARATOR +
            FCity       + FIELD_SEPARATOR +
            FState      + FIELD_SEPARATOR +
            FZip        + FIELD_SEPARATOR +
            FCountry    + FIELD_SEPARATOR +
            FPhone1     + FIELD_SEPARATOR +
            FEmail      + FIELD_SEPARATOR +
            FSocialSec  + FIELD_SEPARATOR +
            FEmployee   + FIELD_SEPARATOR +
            FInactive;
end;


{ ---------- TEntityCustomer -----------}
function TEntityCustomer.Print:String;
begin

  Result :=               BEGIN_NEW_LINE  +
            FID         + FIELD_SEPARATOR +
            FName       + FIELD_SEPARATOR +
            FIDChartAcc + FIELD_SEPARATOR +
            FAddress1   + FIELD_SEPARATOR +
            FAddress2   + FIELD_SEPARATOR +
            FCity       + FIELD_SEPARATOR +
            FState      + FIELD_SEPARATOR +
            FZip        + FIELD_SEPARATOR +
            FCountry    + FIELD_SEPARATOR +
            FContact    + FIELD_SEPARATOR +
            FPhone1     + FIELD_SEPARATOR +
            FPhone2     + FIELD_SEPARATOR +
            FFax        + FIELD_SEPARATOR +
            FEmail      + FIELD_SEPARATOR +
            FWebSite    + FIELD_SEPARATOR +
            FInactive;
end;

{ ---------- TEntityVendor -----------}
function TEntityVendor.Print:String;
begin

  Result :=               BEGIN_NEW_LINE  +
            FID         + FIELD_SEPARATOR +
            FName       + FIELD_SEPARATOR +
            FIDChartAcc + FIELD_SEPARATOR +
            FAddress1   + FIELD_SEPARATOR +
            FAddress2   + FIELD_SEPARATOR +
            FCity       + FIELD_SEPARATOR +
            FState      + FIELD_SEPARATOR +
            FZip        + FIELD_SEPARATOR +
            FCountry    + FIELD_SEPARATOR +
            FContact    + FIELD_SEPARATOR +
            FPhone1     + FIELD_SEPARATOR +
            FPhone2     + FIELD_SEPARATOR +
            FFax        + FIELD_SEPARATOR +
            FEmail      + FIELD_SEPARATOR +
            FWebSite    + FIELD_SEPARATOR +
            FInactive;
end;



end.
