unit uQuickBooks;

{*

   QUICKBOOKS FUNCTION TO EXPORT DATA
   APPLICATION NETWORK INC.

   LOG ----------------------------
   Created by Rodrigo Costa
   05/01/02.

   --------------------------------
   TAdvStringGrid
   TQuickBooks
   TRelativeColumn

                            TDefaultClass
                                   |
               -------------------------------------------------------------------
               |                   |                                              |
          TChartOfAccount   TParentTransaction                               TParentEntity
                                   |                                              |
                            TParentTransactionBank                   ----------------------------
                                   |                                 |            |             |
             --------------------------------------------    TEntityVendor   TEntityCustomer TEntityEmployee
             |                                          |
        TTransactionBankAccSplit            TTransactionBankAccount
*}

interface

uses Sysutils, classes, grids;

Type
   TQuickBooksBankAccType   = array[0..7] of String;

   TQuickBooksBankAccDesc   = array[0..7] of String;

   TQuickBooksEntityColumns = array[0..23] of String;

   TQuickBooksTransColumns  = array[0..5] of String;

   TQuickBooksFileType      = (QB_FILE_TYPE_CUSTOMER,
                               QB_FILE_TYPE_VENDOR,
                               QB_FILE_TYPE_SALES_PERSON,
                               QB_FILE_TYPE_TRANSACTION);


Const
    AQuickBooksBankAccType : TQuickBooksBankAccType = ('BANK',      //Checking or Saving
                                                       'CCARD',     //Credit Card
                                                       'FIXASSET',  //Fixed asset
                                                       'LTLIAB',    //Long term liability
                                                       'NONPOSTING',//Non-posting account
                                                       'OASSET',    //Other asset
                                                       'OCASSET',   //Other current asset
                                                       'OCLIAB');   //Other current liability

    AQuickBooksBankAccList : TQuickBooksBankAccDesc = ('Checking or Saving',
                                                       'Credit Card',
                                                       'Fixed asset',
                                                       'Long term liability',
                                                       'Non-posting account',
                                                       'Other asset',
                                                       'Other current asset',
                                                       'Other current liability');

   AQuickBooksEntityColumns : TQuickBooksEntityColumns = ('NAME',
                                                          'ADDR1',
                                                          'ADDR2',
                                                          'ADDR3',
                                                          'ADDR4',
                                                          'ADDR5',
                                                          'PHONE1',
                                                          'PHONE2',
                                                          'FAXNUM',
                                                          'EMAIL',
                                                          'CONT1',
                                                          'CONT2',
                                                          'CTYPE',
                                                          'NOTEPAD',
                                                          'SALUTATION',
                                                          'COMPANYNAME',
                                                          'FIRSTNAME',
                                                          'MIDINIT',
                                                          'LASTNAME',
                                                          'BADDR1',
                                                          'BADDR2',
                                                          'BADDR3',
                                                          'BADDR4',
                                                          'BADDR5');


    AQuickBooksTransColumns : TQuickBooksTransColumns = ('TRNSTYPE',  //Transaction Type
                                                         'DATE',      //Trans Date
                                                         'ACCNT',     //Account Name
                                                         'NAME',      //Payee
                                                         'AMOUNT',    //Total Amount
                                                         'CLEAR');    //Reconciled


   (*  All entities available COLUMNS *)
   
   QB_COL_ENTITY_NAME                   = 0;
   QB_COL_ENTITY_ADDRESS_1              = 1;
   QB_COL_ENTITY_ADDRESS_2              = 2;
   QB_COL_ENTITY_ADDRESS_3              = 3;
   QB_COL_ENTITY_ADDRESS_4              = 4;
   QB_COL_ENTITY_ADDRESS_5              = 5;
   QB_COL_ENTITY_PHONE_1                = 6;
   QB_COL_ENTITY_PHONE_2                = 7;
   QB_COL_ENTITY_FAX                    = 8;
   QB_COL_ENTITY_EMAIL                  = 9;
   QB_COL_ENTITY_CONTACT_1              = 10;
   QB_COL_ENTITY_CONTACT_2              = 11;
   QB_COL_ENTITY_TYPE                   = 12;
   QB_COL_ENTITY_NOTEPAD                = 13;
   QB_COL_ENTITY_SALUTION               = 14;
   QB_COL_ENTITY_COMPANY                = 15;
   QB_COL_ENTITY_FIRSTNAME              = 16;
   QB_COL_ENTITY_MID_INIT               = 17;
   QB_COL_ENTITY_LASTNAME               = 18;
   QB_COL_ENTITY_CUSTOMER_ADDRESS_1     = 19;
   QB_COL_ENTITY_CUSTOMER_ADDRESS_2     = 20;
   QB_COL_ENTITY_CUSTOMER_ADDRESS_3     = 21;
   QB_COL_ENTITY_CUSTOMER_ADDRESS_4     = 22;
   QB_COL_ENTITY_CUSTOMER_ADDRESS_5     = 23;


   (*  Chart of account  *)

   BANK_ACCOUNT_TYPE_CHECK_SAVE      = 0;
   BANK_ACCOUNT_TYPE_CREDIT_CARD     = 1;
   BANK_ACCOUNT_TYPE_FIXED_ASSET     = 2;
   BANK_ACCOUNT_TYPE_LONG_TERM_LIAB  = 3;
   BANK_ACCOUNT_TYPE_NON_POST_ACC    = 4;
   BANK_ACCOUNT_TYPE_OTHER_ASSET     = 5;
   BANK_ACCOUNT_TYPE_OTHER_CUR_ASSET = 6;
   BANK_ACCOUNT_TYPE_OTHER_CUR_LIAB  = 7;

   { Transaction Type }
   CHECK_TRANSACTION                 = 'CHECK';
   TRANSFERENCE_TRANSACTION          = 'TRANSFER';
   DEPOSIT_TRANSACTION               = 'DEPOSIT';

   (* Transaction COLUMNS*)
   QB_COL_TRANS_TRANS_TYPE       = 0;
   QB_COL_TRANS_TRANS_DATE       = 1;
   QB_COL_TRANS_TRANS_BANK_ACC   = 3;
   QB_COL_TRANS_TRANS_PAYEE      = 4;
   QB_COL_TRANS_TRANS_AMOUNT     = 5;
   QB_COL_TRANS_TRANS_RECONCILED = 6;


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
        FName : String;
        FType : String;
        FDesc : String;
      public
          property AccName        : String read FName write FName;
          property AccType        : String read FType write FType;
          property AccDescription : String read FDesc write FDesc;
          function Print:String; override;
   end;

   TParentTransaction = class(TDefaultClass)
       private
          FType    : String;
          FAccount : String;
          FAmount  : String;
       public
         property TransType : String read FType    write FType;
         property Account   : String read FAccount write FAccount;
         property Amount    : String read FAmount  write FAmount;
         function Print:String; override; abstract;
   end;

   TParentTransactionBank = class(TParentTransaction)
      private
         FDate   : String;
         FDoc    : String;
         FPayee  : String;
         FMemo   : String;
         FReconc : String;
      public
         property Date      : String read FDate   write FDate;
         property DocNum    : String read FDoc    write FDoc;
         property Payee     : String read FPayee  write FPayee;
         property Memo      : String read FMemo   write FMemo;
         property Reconcile : String   read FReconc write FReconc;
         function Print:String; override; abstract;
   end;

   TTransactionBankAccSplit = class(TParentTransactionBank)
      public
         function Print:String; override;
   end;

   TTransactionBankAccount = class(TParentTransactionBank)
      private
         FBankAccSplit     : TTransactionBankAccSplit;
         FBankAccSplitList : TStringList;
         procedure FreeDeleteSplitList;
      public
         function AddSplit(sType, sAccount, sAmount, sDate, sDocNum,
                           sPayee, sMemo, Reconc : String):Integer;
         function Print:String; override;
         Constructor Create;
         Destructor Destroy; override;
   end;


   TParentEntity = class(TDefaultClass)
      private
         FName       : String;
         FRefNum     : String;
         FTimeStamp  : String;
         FAddress1   : String;
         FAddress2   : String;
         FAddress3   : String;
         FAddress4   : String;
         FAddress5   : String;
         FPhone1     : String;
         FPhone2     : String;
         FFax        : String;
         FEmail      : String;
         FContact1   : String;
         FContact2   : String;
         FType       : String;
         FNote       : String;
         FNotePad    : String;
         FSalutation : String;
         FCompany    : String;
         FFirstName  : String;
         FMidInit    : String;
         FLastName   : String;
         FHidden     : String;
         FDelCount   : String;
      public
        property Name       : String read FName       write FName;
        property RefNum     : String read FRefNum     write FRefNum;
        property TimeStamp  : String read FTimeStamp  write FTimeStamp;
        property Address1   : String read FAddress1   write FAddress1;
        property Address2   : String read FAddress2   write FAddress2;
        property Address3   : String read FAddress3   write FAddress3;
        property Address4   : String read FAddress4   write FAddress4;
        property Address5   : String read FAddress5   write FAddress5;
        property Phone1     : String read FPhone1     write FPhone1;
        property Phone2     : String read FPhone2     write FPhone2;
        property Fax        : String read FFax        write FFax;
        property Email      : String read FEmail      write FEmail;
        property Contact1   : String read FContact1   write FContact1;
        property Contact2   : String read FContact2   write FContact2;
        property EntType    : String read FType       write FType;
        property Note       : String read FNote       write FNote;
        property NotePad    : String read FNotePad    write FNotePad;
        property Salutation : String read FSalutation write FSalutation;
        property Company    : String read FCompany    write FCompany;
        property FirstName  : String read FFirstName  write FFirstName;
        property MidInit    : String read FMidInit    write FMidInit;
        property LastName   : String read FLastName   write FLastName;
        property Hidden     : String read FHidden     write FHidden;
        property DelCount   : String read FDelCount   write FDelCount;
        function Print:String; override; abstract;
   end;

   TEntityVendor = class(TParentEntity)
      public
         function Print:String; override;
   end;

   TEntityCustomer = class(TParentEntity)
      public
         function Print:String; override;
   end;

   TEntityEmployee = class(TParentEntity)
      public
         function Print:String; override;
   end;

   TQuickBooks = class
      private
         FChartAccountBank  : TChartOfAccount;         //One Bank Account
         FChartAccountCateg : TChartOfAccount;         //One Chart of Account List
         FBankTransaction   : TTransactionBankAccount; //One Bank Account Transactions
         FDefaultEntity     : TParentEntity;           //One Entity

         FBankTransList     : TStringList;             //Bank Transactions List
         FChartAccountList  : TStringList;             //Chart of Account and Bank List
         FEntityList        : TStringList;             //Entity (Vendor, Customer, etc.)List
         FQuickBooksColumns : TStringList;             //List of Columns to be imported to the System

         procedure FreeAllChartAccountListObj;
         procedure FreeAllBankAccountListObj;
         procedure FreeAllEntityListObj;
         function PrintChartOfAccount:String;
         function PrintBankAccTransaction:String;
         function PrintEntities:String;
      public
         procedure SetBank(sName, sDesc : String; iType : Integer);
         procedure AddChartOfAccount(sName, sDesc, sType : String);
         procedure OpenQuickBooksFile(sPath:String; Grid : TStringGrid;
                                      FileType:TQuickBooksFileType);
         procedure AddColumnToImport(QuickBooksColumn:Integer);
         procedure GetColumnsToImport(ColumnGrid, ListGrid:TStringGrid);
         procedure ClearColumnsToImport;

         function AddEntity(FileType:TQuickBooksFileType; Name, Addre1, Addre2,
                             Addre3, Addre4, Addre5, Phone1, phone2, Fax, Email,
                             Contact1, Contact2, Notes, Company, FName, MName,
                             LName : String):Integer;
         function AddTransaction(sType, sAccount, sAmount, sDate, sDocNum,
                                 sPayee, sMemo : String; IsReconc : Char):Integer;
         function AddTransSplit(iTrans : Integer; sType, sAccount, sAmount,
                                sDate, sDocNum, sPayee, sMemo, Reconc : String):Integer;
         function SaveDataToFile(sPath : String):Boolean;


         Constructor Create;
         Destructor Destroy; override;
   end;

implementation

uses uSaveToFile, uStringFunctions;

Const


   FIELD_SEPARATOR                   = #9;          //Tab Key
   BEGIN_NEW_LINE                    = '' + #13#10; //start a new line

   (*  Customer COLUMNS *)
   CUSTOMER_BEGIN_LINE_HEADER        = '!CUST';
   CUSTOMER_BEGIN_LINE               = 'CUST';

   CUSTOMER_HEADER                   = '!CUST'      +FIELD_SEPARATOR+
                                       'NAME'       +FIELD_SEPARATOR+
                                       'BADDR1'     +FIELD_SEPARATOR+
                                       'BADDR2'     +FIELD_SEPARATOR+
                                       'BADDR3'     +FIELD_SEPARATOR+
                                       'BADDR4'     +FIELD_SEPARATOR+
                                       'BADDR5'     +FIELD_SEPARATOR+
                                       'PHONE1'     +FIELD_SEPARATOR+
                                       'PHONE2'     +FIELD_SEPARATOR+
                                       'FAXNUM'     +FIELD_SEPARATOR+
                                       'EMAIL'      +FIELD_SEPARATOR+
                                       'CONT1'      +FIELD_SEPARATOR+
                                       'CONT2'      +FIELD_SEPARATOR+
                                       'NOTEPAD'    +FIELD_SEPARATOR+
                                       'SALUTATION' +FIELD_SEPARATOR+
                                       'COMPANYNAME'+FIELD_SEPARATOR+
                                       'FIRSTNAME'  +FIELD_SEPARATOR+
                                       'MIDINIT'    +FIELD_SEPARATOR+
                                       'LASTNAME';


   (*  Selas Person COLUMNS *)
   SALES_PERSON_BEGIN_LINE_HEADER    = '!EMP';
   SALES_PERSON_BEGIN_LINE           = 'EMP';

   SALES_PERSON_HEADER               = '!EMP'       +FIELD_SEPARATOR+
                                       'NAME'       +FIELD_SEPARATOR+
                                       'ADDR1'      +FIELD_SEPARATOR+
                                       'ADDR2'      +FIELD_SEPARATOR+
                                       'ADDR3'      +FIELD_SEPARATOR+
                                       'ADDR4'      +FIELD_SEPARATOR+
                                       'ADDR5'      +FIELD_SEPARATOR+
                                       'PHONE1'     +FIELD_SEPARATOR+
                                       'PHONE2'     +FIELD_SEPARATOR+
                                       'FAXNUM'     +FIELD_SEPARATOR+
                                       'EMAIL'      +FIELD_SEPARATOR+
                                       'CONT1'      +FIELD_SEPARATOR+
                                       'CONT2'      +FIELD_SEPARATOR+
                                       'NOTEPAD'    +FIELD_SEPARATOR+
                                       'COMPANYNAME'+FIELD_SEPARATOR+
                                       'FIRSTNAME'  +FIELD_SEPARATOR+
                                       'MIDINIT'    +FIELD_SEPARATOR+
                                       'LASTNAME';


   (*  Vendor COLUMNS *)
   VENDOR_BEGIN_LINE_HEADER          = '!VEND';
   VENDOR_BEGIN_LINE                 = 'VEND';

   VENDOR_HEADER                     = '!VEND'      +FIELD_SEPARATOR+
                                       'NAME'       +FIELD_SEPARATOR+
                                       'ADDR1'      +FIELD_SEPARATOR+
                                       'ADDR2'      +FIELD_SEPARATOR+
                                       'ADDR3'      +FIELD_SEPARATOR+
                                       'ADDR4'      +FIELD_SEPARATOR+
                                       'ADDR5'      +FIELD_SEPARATOR+
                                       'PHONE1'     +FIELD_SEPARATOR+
                                       'PHONE2'     +FIELD_SEPARATOR+
                                       'FAXNUM'     +FIELD_SEPARATOR+
                                       'EMAIL'      +FIELD_SEPARATOR+
                                       'CONT1'      +FIELD_SEPARATOR+
                                       'CONT2'      +FIELD_SEPARATOR+
                                       'NOTEPAD'    +FIELD_SEPARATOR+
                                       'SALUTATION' +FIELD_SEPARATOR+
                                       'COMPANYNAME'+FIELD_SEPARATOR+
                                       'FIRSTNAME'  +FIELD_SEPARATOR+
                                       'MIDINIT'    +FIELD_SEPARATOR+
                                       'LASTNAME';

   (* Chartof Account *)
   CHART_OF_ACCOUNT_HEADER           = '!ACCNT'   +FIELD_SEPARATOR+
                                       'NAME'     +FIELD_SEPARATOR+
                                       'ACCNTTYPE'+FIELD_SEPARATOR+
                                       'DESC';

   CHART_OF_ACCOUNT_LINE             = 'ACCNT';

   CHART_ACCOUNT_TYPE_INCOME         = 'INC';    //Income
   CHART_ACCOUNT_TYPE_EXPENSE        = 'EXP';    //Expenses
   CHART_ACCOUNT_TYPE_OTHER_INCOME   = 'EXINC';  //Other Income
   CHART_ACCOUNT_TYPE_OTHER_EXPENSE  = 'EXEXP';  //Other Expenses

   OTHER_ACCONT_TYPE_ACC_PAYABLE     = 'AP';     //Accounts payable
   OTHER_ACCONT_TYPE_ACC_RECEIVE     = 'AR';     //Accounts receivable
   OTHER_ACCONT_TYPE_COST_OF_GOOD    = 'COGS';   //Cost of goods sold
   OTHER_ACCONT_TYPE_EQUATY          = 'EQUITY'; //Capital/Equity


   (* Transaction Bank*)
   TRANSACTION_LINE_TRANS_HEADER     = '!TRNS';
   TRANSACTION_BANK_ACCOUNT_HEADER   = '!TRNS'   +FIELD_SEPARATOR+ //Initializa Trans
                                       'TRNSTYPE'+FIELD_SEPARATOR+ //Type of Transsaction
                                       'DOCNUM'  +FIELD_SEPARATOR+ //Check Num or Doc Mum
                                       'DATE'    +FIELD_SEPARATOR+ //Date
                                       'ACCNT'   +FIELD_SEPARATOR+ //Bank Account Name
                                       'NAME'    +FIELD_SEPARATOR+ //Payee
                                       'AMOUNT'  +FIELD_SEPARATOR+ //Total Amount
                                       'MEMO'    +FIELD_SEPARATOR+ //Memo
                                       'CLEAR';                    //Reconciled

   TRANSACTION_BANK_SPLIT_HEADER     = '!SPL'    +FIELD_SEPARATOR+ //Initialize Split
                                       'TRNSTYPE'+FIELD_SEPARATOR+ //Type of transaction
                                       'DOCNUM'  +FIELD_SEPARATOR+ //Number of the Document
                                       'DATE'    +FIELD_SEPARATOR+ //Date
                                       'ACCNT'   +FIELD_SEPARATOR+ //Category to include Split
                                       'NAME'    +FIELD_SEPARATOR+ //Payee
                                       'AMOUNT'  +FIELD_SEPARATOR+ //Total Amount
                                       'MEMO'    +FIELD_SEPARATOR+ //Memo
                                       'CLEAR';                    //Reconciled

   TRANSACTION_END_LINE_HEADER       = '!ENDTRNS';

   TRANSACTION_BEGIN_LINE_TRANS      = 'TRNS';
   TRANSACTION_BEGIN_LINE_SPLIT      = 'SPL';
   TRANSACTION_END_LINE_TRANS        = 'ENDTRNS';

{--------- Items on a String Grid -----------}

Procedure TAdvStringGrid.DeleteRow(ARow:LongInt);
Begin
 Inherited DeleteRow(ARow)
End;

Procedure TAdvStringGrid.DeleteColumn(AColumn:LongInt);
Begin
 Inherited DeleteColumn(AColumn)
End;


{---------- TQuickBooks ----------------}

procedure TQuickBooks.ClearColumnsToImport;
begin
  if Assigned(FQuickBooksColumns) then
     FQuickBooksColumns.Clear;
end;


function TQuickBooks.AddEntity(FileType:TQuickBooksFileType; Name, Addre1, Addre2,
                               Addre3, Addre4, Addre5, Phone1, phone2, Fax, Email,
                               Contact1, Contact2, Notes, Company, FName, MName,
                               LName : String):Integer;
begin

    Case FileType of
       QB_FILE_TYPE_CUSTOMER     : FDefaultEntity := TEntityCustomer.Create;
       QB_FILE_TYPE_VENDOR       : FDefaultEntity := TEntityVendor.Create;
       QB_FILE_TYPE_SALES_PERSON : FDefaultEntity := TEntityEmployee.Create;
    end;

    FDefaultEntity.Name      := Name;
    FDefaultEntity.Address1  := Addre1;
    FDefaultEntity.Address2  := Addre2;
    FDefaultEntity.Address3  := Addre3;
    FDefaultEntity.Address4  := Addre4;
    FDefaultEntity.Address5  := Addre5;
    FDefaultEntity.Phone1    := Phone1;
    FDefaultEntity.Phone2    := Phone2;
    FDefaultEntity.Fax       := Fax;
    FDefaultEntity.Email     := Email;
    FDefaultEntity.Contact1  := Contact1;
    FDefaultEntity.Contact2  := Contact2;
    FDefaultEntity.NotePad   := Notes;
    FDefaultEntity.Company   := Company;
    FDefaultEntity.FirstName := FName;
    FDefaultEntity.MidInit   := MName;
    FDefaultEntity.LastName  := LName;

    Result := FEntityList.AddObject('', FDefaultEntity);
    
end;                                


procedure TQuickBooks.GetColumnsToImport(ColumnGrid, ListGrid:TStringGrid);
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

   if not Assigned(FQuickBooksColumns) then
      Exit;

   ColumnGrid.RowCount := FQuickBooksColumns.Count+1;
   ColumnGrid.ColCount := 3;

   for i:=0 to FQuickBooksColumns.Count-1 do
      begin
      if ListGrid <> nil then
         ColumnGrid.Cells[0,i+1] := SearchColumn(FQuickBooksColumns.Strings[i]);

      ColumnGrid.Cells[1,i+1] := FQuickBooksColumns.Strings[i];
      end;
      
end;

procedure TQuickBooks.AddColumnToImport(QuickBooksColumn:Integer);
var
    Column : String;
begin
   if not Assigned(FQuickBooksColumns) then
      FQuickBooksColumns := TStringList.Create;

   Column := AQuickBooksEntityColumns[QuickBooksColumn];

   if ValueLocatedInList(FQuickBooksColumns, Column) = -1 then
      FQuickBooksColumns.Add(Column);

end;

procedure TQuickBooks.OpenQuickBooksFile(sPath:String; Grid : TStringGrid;
                                         FileType:TQuickBooksFileType);
   procedure BuildEntity(Header, HeaderLine : String);
   var
      i, iHeader, total: integer;
   begin

   total := FEntityList.Count;
   i := 0;

   //Delete Invalid rows
   while (i <= total) do
      begin

      if (Pos(Header+FIELD_SEPARATOR, FEntityList.Strings[i]) = 1) or
         (Pos(HeaderLine+FIELD_SEPARATOR, FEntityList.Strings[i]) = 1) then
         inc(i)
      else
         FEntityList.Delete(i);

      if i >= FEntityList.Count then
         break;
      end;

  if FEntityList.Count = 0 then
     Exit;

  //Retiro " se existir
  FEntityList.Text := StringReplace(FEntityList.Text, '"', '', [rfReplaceAll]);

  //Search for header
  for i:=0 to FEntityList.Count-1 do
       if (Pos(Header+FIELD_SEPARATOR, FEntityList.Strings[i]) = 1) then
          begin
          iHeader := i;
          Break;
          end;

   //How many valid rows
   Grid.RowCount := FEntityList.Count;
   //How many valid cols
   Grid.ColCount := CountChar(FIELD_SEPARATOR, FEntityList.Strings[iHeader]);

   //Set header
   Grid.Rows[0].Text := StringReplace(FEntityList.Strings[iHeader], FIELD_SEPARATOR, #13, [rfReplaceAll]);
   Grid.FixedRows := 1;

   //Replace all Field_separator for enter Key, so the StringGrid will add correct.
   for i:=iHeader to FEntityList.Count-1 do
       Grid.Rows[i].Text := StringReplace(FEntityList.Strings[i], FIELD_SEPARATOR, #13, [rfReplaceAll]);

   end;

   procedure ClearList;
   var j : integer;
   begin
   with Grid do
       begin
       for j:= 0 to RowCount-1 do
           TAdvStringGrid(Grid).DeleteRow(j);
       end;
   end;

begin

    //Clear garbage
    FEntityList.Clear;
    ClearList;

    //Open the file
    FEntityList.LoadFromFile(sPath);

    //Biuld StringGrid
    Case FileType of
       QB_FILE_TYPE_CUSTOMER     : BuildEntity(CUSTOMER_BEGIN_LINE_HEADER, CUSTOMER_BEGIN_LINE);
       QB_FILE_TYPE_VENDOR       : BuildEntity(VENDOR_BEGIN_LINE_HEADER, VENDOR_BEGIN_LINE);
       QB_FILE_TYPE_SALES_PERSON : BuildEntity(SALES_PERSON_BEGIN_LINE_HEADER, SALES_PERSON_BEGIN_LINE);
       QB_FILE_TYPE_TRANSACTION  : BuildEntity(TRANSACTION_LINE_TRANS_HEADER, TRANSACTION_BEGIN_LINE_TRANS);
    end;


end;

function TQuickBooks.PrintEntities:String;
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
    if (FEntityList.Objects[0] is TEntityCustomer) then
        Result := CUSTOMER_HEADER + Result
    else if (FEntityList.Objects[0] is TEntityVendor) then
        Result := VENDOR_HEADER + Result
    else if (FEntityList.Objects[0] is TEntityEmployee) then
        Result := SALES_PERSON_HEADER + Result;
    
end;

function TQuickBooks.PrintBankAccTransaction:String;
var
  i : Integer;
begin
  Result := '';


  for i:=0 to FBankTransList.Count-1 do
      if Assigned(FBankTransList.Objects[i]) then
         Result := Result + TDefaultClass(FBankTransList.Objects[i]).Print +
                   TRANSACTION_END_LINE_TRANS + BEGIN_NEW_LINE;

   if Result = '' then
      Exit;

   Result := TRANSACTION_BANK_ACCOUNT_HEADER + BEGIN_NEW_LINE +
             TRANSACTION_BANK_SPLIT_HEADER   + BEGIN_NEW_LINE +
             TRANSACTION_END_LINE_HEADER     + BEGIN_NEW_LINE + Result;

end;

function TQuickBooks.PrintChartOfAccount:String;
var
  i : Integer;
begin

  Result := '';

  if Assigned(FChartAccountBank) then
     Result := Result + FChartAccountBank.Print;

  for i:=0 to FChartAccountList.Count-1 do
      if Assigned(FChartAccountList.Objects[i]) then
         Result := Result + TDefaultClass(FChartAccountList.Objects[i]).Print;

   if Result = '' then
      Exit;

  Result := CHART_OF_ACCOUNT_HEADER + BEGIN_NEW_LINE + Result;

end;

function TQuickBooks.SaveDataToFile(sPath:String):Boolean;
var
   aFile : TSaveFile;
begin

   Result := False;

   aFile := nil;
   
   try
     aFile := TSaveFile.Create;
     aFile.FilePath := sPath;
     aFile.AddText(PrintChartOfAccount);
     aFile.AddText(PrintBankAccTransaction);
     aFile.AddText(PrintEntities);
     Result := (aFile.CreateFile = -1);
   finally
     aFile.Free;
   end;

end;

function TQuickBooks.AddTransSplit(iTrans : Integer; sType, sAccount, sAmount,
sDate, sDocNum, sPayee, sMemo, Reconc : String):Integer;
begin
 if Assigned(FBankTransList.Objects[iTrans]) then
    Result := TTransactionBankAccount(FBankTransList.Objects[iTrans]).AddSplit(sType,
                                                                               sAccount,
                                                                               sAmount,
                                                                               sDate,
                                                                               sDocNum,
                                                                               sPayee,
                                                                               sMemo,
                                                                               Reconc);
end;


function TQuickBooks.AddTransaction(sType, sAccount, sAmount, sDate, sDocNum,
sPayee, sMemo : String; IsReconc : Char):Integer;
begin

   FBankTransaction := TTransactionBankAccount.Create;

   with FBankTransaction do
       begin
       TransType := sType;
       Account   := sAccount;
       Amount    := sAmount;
       Date      := sDate;
       DocNum    := sDocNum;
       Payee     := sPayee;
       Memo      := sMemo;
       Reconcile := IsReconc;   
       end;

   Result := FBankTransList.AddObject('', FBankTransaction);

end;


procedure TQuickBooks.AddChartOfAccount(sName, sDesc, sType : String);
begin

  FChartAccountCateg                := TChartOfAccount.Create;
  FChartAccountCateg.AccName        := sName;
  FChartAccountCateg.AccType        := sType;
  FChartAccountCateg.AccDescription := sDesc;

  FChartAccountList.AddObject('', FChartAccountCateg);

end;

procedure TQuickBooks.SetBank(sName, sDesc : String; iType : Integer);
begin

   if not Assigned(FChartAccountBank) then
      FChartAccountBank := TChartOfAccount.Create;

   FChartAccountBank.AccName        := sName;
   FChartAccountBank.AccType        := AQuickBooksBankAccType[iType];
   FChartAccountBank.AccDescription := sDesc;

end;

procedure TQuickBooks.FreeAllEntityListObj;
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

procedure TQuickBooks.FreeAllBankAccountListObj;
var
  i : integer;
begin
    //release all objects in the List
    with FBankTransList do
      for i:=0 to Count-1 do
         if Assigned(Objects[i]) then
            begin
            Objects[i].Free;
            Objects[i] := nil;
            end;
end;


procedure TQuickBooks.FreeAllChartAccountListObj;
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


Constructor TQuickBooks.Create;
begin
   inherited Create;
   FChartAccountList := TStringList.Create;
   FBankTransList    := TStringList.Create;
   FEntityList       := TStringList.Create;

end;

Destructor TQuickBooks.Destroy;
begin

  FreeAllChartAccountListObj;
  FreeAndNil(FChartAccountList);

  FreeAllBankAccountListObj;
  FreeAndNil(FBankTransList);

  FreeAllEntityListObj;
  FreeAndNil(FEntityList);

  if Assigned(FQuickBooksColumns) then
     begin
     FQuickBooksColumns := Nil;
     FQuickBooksColumns.Free;
     end;

  if Assigned(FDefaultEntity) then
     begin
     FEntityList := Nil;
     FEntityList.Free;
     end;

  if Assigned(FChartAccountBank) then
     begin
     FChartAccountBank := Nil;
     FChartAccountBank.Free; 
     end;

  if Assigned(FChartAccountCateg) then
     begin
     FChartAccountCateg := Nil;
     FChartAccountCateg.Free;
     end;

  if Assigned(FBankTransaction) then
     begin
     FBankTransaction := Nil;
     FBankTransaction.Free;
     end;

  inherited Destroy;

end;

{---------- TEntityVendor --------------}
function TEntityVendor.Print:String;
begin
  Result := '';

  Result :=                           BEGIN_NEW_LINE  +
            VENDOR_BEGIN_LINE       + FIELD_SEPARATOR +
            FName                   + FIELD_SEPARATOR +
            FAddress1               + FIELD_SEPARATOR +
            FAddress2               + FIELD_SEPARATOR +
            FAddress3               + FIELD_SEPARATOR +
            FAddress4               + FIELD_SEPARATOR +
            FAddress5               + FIELD_SEPARATOR +
            FPhone1                 + FIELD_SEPARATOR +
            FPhone2                 + FIELD_SEPARATOR +
            FFax                    + FIELD_SEPARATOR +
            FEmail                  + FIELD_SEPARATOR +
            FContact1               + FIELD_SEPARATOR +
            FContact2               + FIELD_SEPARATOR +
            FNotePad                + FIELD_SEPARATOR +
            FSalutation             + FIELD_SEPARATOR +
            FCompany                + FIELD_SEPARATOR +
            FFirstName              + FIELD_SEPARATOR +
            FMidInit                + FIELD_SEPARATOR +
            FLastName               + FIELD_SEPARATOR;

end;

{---------- TEntityCustomer --------------}
function TEntityCustomer.Print:String;
begin
  Result := '';

  Result :=                           BEGIN_NEW_LINE  +
            CUSTOMER_BEGIN_LINE     + FIELD_SEPARATOR +
            FName                   + FIELD_SEPARATOR +
            FAddress1               + FIELD_SEPARATOR +
            FAddress2               + FIELD_SEPARATOR +
            FAddress3               + FIELD_SEPARATOR +
            FAddress4               + FIELD_SEPARATOR +
            FAddress5               + FIELD_SEPARATOR +
            FPhone1                 + FIELD_SEPARATOR +
            FPhone2                 + FIELD_SEPARATOR +
            FFax                    + FIELD_SEPARATOR +
            FEmail                  + FIELD_SEPARATOR +
            FContact1               + FIELD_SEPARATOR +
            FContact2               + FIELD_SEPARATOR +
            FNotePad                + FIELD_SEPARATOR +
            FSalutation             + FIELD_SEPARATOR +
            FCompany                + FIELD_SEPARATOR +
            FFirstName              + FIELD_SEPARATOR +
            FMidInit                + FIELD_SEPARATOR +
            FLastName               + FIELD_SEPARATOR;

end;

{---------- TFEntityEmployee --------------}
function TEntityEmployee.Print:String;
begin
  Result := '';

  Result :=                           BEGIN_NEW_LINE  +
            SALES_PERSON_BEGIN_LINE + FIELD_SEPARATOR +
            FName                   + FIELD_SEPARATOR +
            FAddress1               + FIELD_SEPARATOR +
            FAddress2               + FIELD_SEPARATOR +
            FAddress3               + FIELD_SEPARATOR +
            FAddress4               + FIELD_SEPARATOR +
            FAddress5               + FIELD_SEPARATOR +
            FPhone1                 + FIELD_SEPARATOR +
            FPhone2                 + FIELD_SEPARATOR +
            FFax                    + FIELD_SEPARATOR +
            FEmail                  + FIELD_SEPARATOR +
            FContact1               + FIELD_SEPARATOR +
            FContact2               + FIELD_SEPARATOR +
            FNotePad                + FIELD_SEPARATOR +
            FCompany                + FIELD_SEPARATOR +
            FFirstName              + FIELD_SEPARATOR +
            FMidInit                + FIELD_SEPARATOR +
            FLastName               + FIELD_SEPARATOR;
end;


{---------- TChartOfAccount --------------}

function TChartOfAccount.Print:String;
begin
  Result := CHART_OF_ACCOUNT_LINE   + FIELD_SEPARATOR +
            FName                   + FIELD_SEPARATOR +
            FType                   + FIELD_SEPARATOR +
            FDesc                   + FIELD_SEPARATOR + BEGIN_NEW_LINE;
end;

{---------- TTransactionBankAccSplit --------------}
function TTransactionBankAccSplit.Print:String;
begin
     Result := '';

     Result := TRANSACTION_BEGIN_LINE_SPLIT + FIELD_SEPARATOR +
               FType                        + FIELD_SEPARATOR +
               FDoc                         + FIELD_SEPARATOR +
               FDate                        + FIELD_SEPARATOR +
               FAccount                     + FIELD_SEPARATOR +
               FPayee                       + FIELD_SEPARATOR +
               FAmount                      + FIELD_SEPARATOR +
               FMemo                        + FIELD_SEPARATOR +
               FReconc                      + FIELD_SEPARATOR + BEGIN_NEW_LINE;
end;

{---------- TTransactionBankAccount --------------}
function TTransactionBankAccount.Print:String;
var
  i : Integer;
begin
     Result := '';

     Result := TRANSACTION_BEGIN_LINE_TRANS + FIELD_SEPARATOR +
               FType                        + FIELD_SEPARATOR +
               FDoc                         + FIELD_SEPARATOR +
               FDate                        + FIELD_SEPARATOR +
               FAccount                     + FIELD_SEPARATOR +
               FPayee                       + FIELD_SEPARATOR +
               FAmount                      + FIELD_SEPARATOR +
               FMemo                        + FIELD_SEPARATOR +
               FReconc                      + FIELD_SEPARATOR + BEGIN_NEW_LINE; //ToPrint

    //Prin Split
    for i:=0 to FBankAccSplitList.Count-1 do
        if Assigned(FBankAccSplitList.Objects[i]) then
           Result := Result + TDefaultClass(FBankAccSplitList.Objects[i]).Print;


end;

function TTransactionBankAccount.AddSplit(sType, sAccount, sAmount, sDate, sDocNum,
sPayee, sMemo, Reconc : String):Integer;
begin

  FBankAccSplit := TTransactionBankAccSplit.Create;

  FBankAccSplit.TransType := sType;
  FBankAccSplit.Account   := sAccount;
  FBankAccSplit.Amount    := sAmount;
  FBankAccSplit.Date      := sDate;
  FBankAccSplit.DocNum    := sDocNum;
  FBankAccSplit.Payee     := sPayee;
  FBankAccSplit.Memo      := sMemo;
  FBankAccSplit.Reconcile := Reconc;

  FBankAccSplitList.AddObject('', FBankAccSplit);

end;

procedure TTransactionBankAccount.FreeDeleteSplitList;
var
  i : integer;
begin
    //release all objects in the List
    with FBankAccSplitList do
        for i:=0 to Count-1 do
            if Assigned(Objects[i]) then
               begin
               Objects[i].Free;
               Objects[i] := nil;
               end;
end;

Constructor TTransactionBankAccount.Create;
begin
   inherited Create;
   FBankAccSplitList := TStringList.Create;
end;

Destructor TTransactionBankAccount.Destroy;
begin

  FreeDeleteSplitList;
  FreeAndNil(FBankAccSplitList);

  if Assigned(FBankAccSplit) then
     begin
     FBankAccSplit := Nil;
     FBankAccSplit.Free;
     end;

  inherited Destroy;
end;

end.

