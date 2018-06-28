unit uQuicken;

{*

   QUICKEN FUNCTION TO EXPORT DATA
   APPLICATION NETWORK INC.

   LOG ----------------------------
   Created by Rodrigo Costa
   05/07/02.

*}

interface

uses classes, Sysutils;

type
   TQuickenBankType     = array[0..5] of String;
   TQuickenBankTypeDesc = array[0..5] of String;

const
    AQuickenBankType : TQuickenBankType = ('Bank',
                                           'Cash',
                                           'CCard',
                                           'Invst',
                                           'Oth A',
                                           'Oth L');


    AQuickenBankTypeList : TQuickenBankTypeDesc = ('Bank account transactions',
                                                   'Cash account transactions',
                                                   'Credit card account transactions',
                                                   'Investment account transactions',
                                                   'Asset account transactions',
                                                   'Liability account transactions');

    //Quicken Bank Types
    BANK_TYPE_BANKACC = 0;  //Bank account transactions
    BANK_TYPE_CASHACC = 1;  //Cash account transactions
    BANK_TYPE_CREDIT  = 2;  //Credit card account transactions
    BANK_TYPE_INVEST  = 3;  //Investment account transactions
    BANK_TYPE_ASSET   = 4;  //Asset account transactions
    BANK_TYPE_LIABIL  = 5;  //Liability account transactions

    //Quick category Types
    CATEGORY_TYPE_INCOME   = 'I'; //Income   - Credit
    CATEGORY_TYPE_EXPENSES = 'E'; //Expenses - Debit

    //Headers
    BANK_HEADER        = '!Account';
    TRANSACTION_HEADER = '!Type:';
    CATEGORY_HEADER    = '!Type:Cat';

    //Quicken Initiais
    INIT_BANK_NAME            = 'N';
    INIT_BANK_TYPE            = 'T';

    INIT_CATEGORY_NAME        = 'N';
    INIT_CATEGORY_DESCRIPTION = 'D';

    INIT_TRANS_SPLIT_CATEGORY = 'S';
    INIT_TRANS_SPLIT_AMOUNT   = '$';
    INIT_TRANS_SPLIT_MEMO     = 'E';

    INIT_TRANSACTION_DATE     = 'D';
    INIT_TRANSACTION_AMOUNT   = 'T';
    INIT_TRANSACTION_CATEGORY = 'L';
    INIT_TRANSACTION_CHECKNUM = 'N';
    INIT_TRANSACTION_PAYEE    = 'P';
    INIT_TRANSACTION_MEMO     = 'M';
    INIT_TRANSACTION_CLEARED  = 'C';

    END_OF_RECORD  = '^' + #13#10; //end of record
    BEGIN_NEW_LINE = ''  + #13#10; //start a new line

Type
   TDefaultClass = Class
       public
          function Print:String; virtual; abstract;
   end;

   TBank = Class(TDefaultClass)
      private
          FName      : String; //Bank Name
          FType      : String; //Banck Type
          FTransType : String; //Transaction Type is the same as bank type.
      public
         function Print:String; override;
   end;

   TCategory = Class(TDefaultClass)
      private
          FName        : String; //Category Name
          FDescription : String; //Category Description
          FType        : String; //Category Type
      public
         function Print:String; override;
   end;

   TTransactionSplit = Class(TDefaultClass)
      private
          FSplitCategory : String; //Category
          FSplitAmount   : String; //Amount
          FSplitMemo     : String; //Memo
      public
          function Print:String; override;
   end;

   TTransaction = Class(TDefaultClass)
      FDate        : String;
      FAmount      : String;
      FCategory    : String;
      FCheckNumber : String; //if needed
      FPayee       : String;
      FMemo        : String;
      FCleared     : String;
      FSplitList   : TStringList; //Split List
      FTransSplit  : TTransactionSplit; //New Split
      private
         procedure FreeAllSplitListObj;       //Delete all references and objs in the List
         procedure DeleteAllSplitList;        //Delete all list
         procedure FreeDeleteAllSplitListObj; //Delete all obj and list.
      public
         Constructor Create;
         Destructor Destroy; override;
         function AddSplit(sCategory, sAmount, sMemo : String):Integer; //Add a new split to theb list
         function Print:String; override;
   end;


   TQuicken = class
   private
      FBank        : TBank;
      FCategory    : TCategory;
      FTransaction : TTransaction;

      FTransList   : TStringList; //List of Transactions
      FCategList   : TStringList; //List of Categories

      procedure FreeAllTransListObj; //Free all references and Obj in the List
      procedure FreeAllCategListObj; //Free all references and Obj in the List

      function PrintBank:String;        //Return Bank in Quicken format
      function PrintCategories:String;  //Return Categories in Quicken format
      function PrintTransaction:String; //Return Transaction and Split in Quicken format
   public
      Constructor Create;
      Destructor Destroy; override;
      procedure SetBank(sName : String; iType, iTransType : integer);
      function AddCategory(sName, sDescription, sType : String):Integer;
      function AddTransaction(sDate, sAmount, sCateg, sChNum, sPayee, sMemo, sCleared : String):Integer;
      function AddTransSplit(iTrans:integer; sCateg, sAmount, sMemo : String) : Integer;
      function SaveDataToFile(sPath:String):Boolean;
   end;

implementation

uses uSaveToFile;

{-------------------- Quicken ----------------------}

function TQuicken.SaveDataToFile(sPath:String):Boolean;
var
   aFile : TSaveFile;
begin

   Result := False;

   try
     aFile := TSaveFile.Create;
     aFile.FilePath := sPath;
     aFile.AddText(PrintBank);
     aFile.AddText(PrintCategories);
     aFile.AddText(PrintTransaction);
     Result := (aFile.CreateFile = -1);
   finally
     aFile.Free;
   end;

end;

function TQuicken.PrintTransaction:String;
var
  i : integer;
begin

  Result := '';

  with FTransList do
     for i:=0 to Count-1 do
         if Assigned(Objects[i]) then
            Result := Result + TDefaultClass(Objects[i]).Print;

   if  Result <> '' then
       Result := TRANSACTION_HEADER + FBank.FTransType + Result;

end;

function TQuicken.PrintCategories:String;
var
  i : Integer;
begin

   Result := '';

   with FCategList do
      for i:=0 to count-1 do
         if Assigned(Objects[i]) then
            Result := Result + TDefaultClass(Objects[i]).Print;

   if  Result <> '' then
       Result := CATEGORY_HEADER + BEGIN_NEW_LINE + Result;

end;

function TQuicken.PrintBank:String;
begin

  if Assigned(FBank) then
     Result := BANK_HEADER + BEGIN_NEW_LINE + TDefaultClass(FBank).Print;

end;

procedure TQuicken.SetBank(sName : String; iType, iTransType : integer);
begin

    if not Assigned(FBank) then
       FBank := TBank.Create;

    with FBank do
       begin
       FName      := sName;
       FType      := AQuickenBankType[iType];
       FTransType := AQuickenBankType[iTRansType];
       end;

end;

function TQuicken.AddTransSplit(iTrans:integer; sCateg, sAmount, sMemo : String) : Integer;
begin
   if Assigned(FTransList.Objects[iTrans]) then
      Result := TTransaction(FTransList.Objects[iTrans]).AddSplit(sCateg, sAmount, sMemo);
end;

function TQuicken.AddTransaction(sDate, sAmount, sCateg, sChNum, sPayee, sMemo, sCleared : String):Integer;
begin
  FTransaction := TTransaction.Create;

  with FTransaction do
     begin
     FDate        := sDate;
     FAmount      := sAmount;
     FCategory    := sCateg;
     FCheckNumber := sChNum;
     FPayee       := sPayee;
     FMemo        := sMemo;
     FCleared     := sCleared;
     end;

  Result := FTransList.AddObject('', FTransaction);


end;

function TQuicken.AddCategory(sName, sDescription, sType : String):Integer;
begin

  FCategory := TCategory.Create;

  with FCategory do
    begin
    FName        := sName;
    FDescription := sDescription;
    FType        := sType;
    end;

  Result := FCategList.AddObject('', FCategory); 

end;

procedure TQuicken.FreeAllTransListObj;
var
  i : integer;
begin

    //release all objects in the List
    with FTransList do
      for i:=0 to Count-1 do
         if Assigned(Objects[i]) then
            begin
            Objects[i].Free;
            Objects[i] := nil;
            end;

    FTransList.Clear;
    
end;

procedure TQuicken.FreeAllCategListObj;
var
  i : integer;
begin
    //release all objects in the List
    with FCategList do
      for i:=0 to Count-1 do
         if Assigned(Objects[i]) then
            begin
            Objects[i].Free;
            Objects[i] := nil;
            end;

    FCategList.Clear;

end;

Constructor TQuicken.Create;
begin
   FTransList := TStringList.Create;
   FCategList := TStringList.Create;
   inherited Create;
end;


Destructor TQuicken.Destroy;
begin

  FreeAllTransListObj;
  FreeAndNil(FTransList);

  FreeAllCategListObj;
  FreeAndNil(FCategList);

  if Assigned(FBank) then
     begin
     FBank := nil;
     FBank.Free;
     end;

  if Assigned(FCategory) then
     begin
     FCategory := nil;
     FCategory.Free;
     end;

  if Assigned(FTransaction) then
     begin
     FTransaction := nil;
     FTransaction.Free;
     end;

  inherited Destroy;

end;


{----------- Transaction -----------------------}
Constructor TTransaction.Create;
begin
   inherited Create;
   FSplitList := TStringList.Create;
end;

Destructor TTransaction.Destroy;
begin
  FreeDeleteAllSplitListObj;
  FSplitList.Free;

  if Assigned(FTransSplit) then
     begin
     FTransSplit := nil;
     FTransSplit.Free;
     end;

  inherited Destroy;
end;

procedure TTransaction.DeleteAllSplitList;
begin
  FSplitList.Clear;
end;

procedure TTransaction.FreeDeleteAllSplitListObj;
begin
   FreeAllSplitListObj;
   DeleteAllSplitList;
end;

procedure TTransaction.FreeAllSplitListObj;
var
  i : integer;
begin

  //release all objects in the List
  with FSplitList do
      for i:=0 to Count-1 do
         if Assigned(Objects[i]) then
            begin
            Objects[i].Free;
            Objects[i] := nil;
            end;

end;

function TTransaction.AddSplit(sCategory, sAmount, sMemo : String):Integer;
begin

   FTransSplit := TTransactionSplit.Create;

   with FTransSplit do
      begin
      FSplitCategory := sCategory;
      FSplitAmount   := sAmount;
      FSplitMemo     := sMemo;
      end;

   Result := FSplitList.AddObject('', FTransSplit);

end;

function TTransaction.Print:String;
var
  s : String;
  i : Integer;
begin

    s := '';

    if FCheckNumber <> '' then
       s := INIT_TRANSACTION_CHECKNUM + FCheckNumber + BEGIN_NEW_LINE;

    if FPayee <> '' then
       s := s + INIT_TRANSACTION_PAYEE + FPayee + BEGIN_NEW_LINE;

    if FMemo <> '' then
       s := s + INIT_TRANSACTION_MEMO + FMemo + BEGIN_NEW_LINE;

    if FCleared <> '' then
       s := s + INIT_TRANSACTION_CLEARED + FCleared + BEGIN_NEW_LINE;

    Result := BEGIN_NEW_LINE +
              INIT_TRANSACTION_DATE     + FDate     + BEGIN_NEW_LINE +
              INIT_TRANSACTION_AMOUNT   + FAmount   + BEGIN_NEW_LINE +
              INIT_TRANSACTION_CATEGORY + FCategory + BEGIN_NEW_LINE +
              s;

    //Prin Split
    for i:=0 to FSplitList.Count-1 do
        if Assigned(FSplitList.Objects[i]) then
           Result := Result + TDefaultClass(FSplitList.Objects[i]).Print;

    Result := Result + END_OF_RECORD;

end;


{----------------- Bank ---------------------}

function TBank.Print:String;
begin

     Result :=  INIT_BANK_NAME + FName + BEGIN_NEW_LINE +
                INIT_BANK_TYPE + FType + BEGIN_NEW_LINE + END_OF_RECORD;

end;

{--------------- Category -------------------}

function TCategory.Print:String;
begin

   Result := INIT_CATEGORY_NAME        + FName        + BEGIN_NEW_LINE +
             INIT_CATEGORY_DESCRIPTION + FDescription + BEGIN_NEW_LINE +
                                         FType        + BEGIN_NEW_LINE + END_OF_RECORD;

end;

{-----------------Trans Split -----------------}

function TTransactionSplit.Print:String;
var
  s:String;
begin

   s := '';

   if FSplitMemo <> '' then
      s := INIT_TRANS_SPLIT_MEMO + FSplitMemo + BEGIN_NEW_LINE;

   Result := BEGIN_NEW_LINE +
             INIT_TRANS_SPLIT_CATEGORY + FSplitCategory + BEGIN_NEW_LINE +
             INIT_TRANS_SPLIT_AMOUNT   + FSplitAmount   + BEGIN_NEW_LINE +
             s;

end;

end.
