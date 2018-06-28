unit SerialNumberCls;

interface
uses classes,SysUtils, DbClient, ADODB, DB, Variants, ShellAPI, Forms, Windows, Dialogs,
     Messages, StdCtrls, Buttons, ExtCtrls, ComCtrls;


type
    TSerialNumber = class
       FConnection: TADOConnection;
       FSerialNumber: String;
       FMaxQty: Integer;
       FIsValidated: Boolean;
       FIDModel   : Integer;
       FIDStore   : Integer;
       FIDItem    : Integer;
       FGiftCard  : Boolean;
       fIdInvoice: Integer;

       // Antonio, August 06, 2013
       fIsIssued: Byte;
    private
       function getSerialNumber: String;
       procedure setSerialNumber(const Value: String);
       procedure setMaxQty(const Value: Integer);
    procedure setIdInvoice(const Value: Integer);

    protected
       procedure setConnection(connection: TADOConnection);

    public
       property IdInvoice: Integer write setIdInvoice;
       property Connection: TADOConnection write setConnection;
       property SerialNumber: String read getSerialNumber write setSerialNumber;
       property MaxQty: Integer write setMaxQty;
       property IsValidated: Boolean read FIsValidated;
       property IsGiftCard: Boolean read FGiftCard write FGiftCard ;
       property IsIssued: Byte read fIsIssued write fIsIssued;

       constructor Create(idmodel, idstore, iditem, maxqty: Integer);
       function getIsValidated(idItem: Integer): Boolean;

       function addAccountNumber(serial_number: String): Boolean; virtual;
       function getSerial(iditem: Integer): TDataSet; virtual; abstract;
       function add(movId: Integer; serialNumber, identification, processor: String): Boolean; virtual; abstract;
       function remove(movId: Integer; serialNumber: String): Boolean; virtual; abstract;
       function getSerials(firstIdItem: Integer):TDataSet; virtual; abstract;
       function getCountSerialNumber(IdItem: Integer): Integer; virtual; abstract;
    end;

    TSerialNumberFromPurchase = class(TSerialNumber)



    end;


    TSerialNumberFromInventory = class(TSerialNumber)

    end;

    TSerialNumberFromTransfer = class(TSerialNumber)


    end;

  TSerialNumberFromSale = class(TSerialNumber)
  protected
       function getSerial(iditem: Integer): TDataSet; override;
//       function getSerial(serialNumber: String): TDataSet; override;
       function add(movId: Integer; serialNumber, identification, processor: String): Boolean; override;
       function remove(movId: Integer; serialNumber: String): Boolean;
       function getSerials(firstIdItem: Integer):TDataSet; override;
       function getCountSerialNumber(IdItem: Integer): Integer; override;
  end;

  TSerialNumberFromPreSale = class(TSerialNumber)
  private
    protected
       function getSerial(iditem: Integer): TDataSet; override;
       function add(movId: Integer; serialNumber, identification, processor: String): Boolean; override;
       function remove(movId: Integer; serialNumber: String): Boolean;
       function getSerials(firstIdItem: Integer):TDataSet; override;
       function getCountSerialNumber(IdItem: Integer): Integer; override;
    public
       function isDuplicateSerial(serial_number: String; id_preinventory: Integer = 0): Boolean;
       function getSerialCurrent(id_preinventory: Integer): TDataSet;
       function getSerialRecorded: TDataSet;
       procedure savePreserialToVerification(arg_cds: TClientDataset);
    end;



implementation

uses uMsgConstant, uSystemConst, uDm;
{ TSerialNumberFromSale }

function TSerialNumberFromSale.add(movId: Integer; serialNumber, identification,
  processor: String): Boolean;
var
   qry: TADOQuery;
begin
   result := false;
   try
      try
         qry := TADOQuery.Create(nil);
         qry.Connection := FConnection;
         qry.SQL.Add('insert into SerialMov(InventoryMovID, SerialNumber, IdentificationNumber, Processor) values(:movid, :serial, :identifier, :processor)');
         qry.Parameters.ParamByName('movid').Value := movId;
         qry.Parameters.ParamByName('serial').Value := serialNumber;
         qry.Parameters.ParamByName('identifier').Value := identification;
         qry.Parameters.ParamByName('processor').Value := processor;
         qry.ExecSQL;
         result := true;
      except
         on e: Exception do
           raise Exception.Create('Add Serial Number error: ' + e.Message);
      end;
   finally
         freeAndNil(qry);
   end;
end;

function TSerialNumberFromSale.getCountSerialNumber(
  IdItem: Integer): Integer;
begin
//
end;


function TSerialNumberFromSale.getSerial(iditem: Integer): TDataSet;
var
   qry: TADOQuery;
begin
   try
      result := nil;
      qry := TADOQuery.Create(nil);
      qry.Connection := FConnection;
      qry.SQL.Add('select PreInventoryMovID, SerialNumber, IdentificationNumber, Processor');
      qry.sql.Add(' from SerialMov');
      qry.SQL.Add(' where InventoryMovID =:iditem');

      qry.Parameters.ParamByName('iditem').Value := iditem;
      qry.Open;
      result := qry;
   finally
      freeAndNil(qry);
   end;
end;

function TSerialNumberFromSale.getSerials(firstIdItem: Integer): TDataSet;
begin
   //
end;


function TSerialNumberFromSale.remove(movId: Integer;
  serialNumber: String): Boolean;
begin
  //
end;

{ TSerialNumber }

function TSerialNumber.addAccountNumber(serial_number: String): Boolean;
var
  qryInsert: TADOQuery;
  dExpDate: TDateTime;
  iMonth: Integer;
begin
  iMonth := DM.fSystem.SrvParam[PARAM_GIFT_EXP_DATE];
  if iMonth > 0 then
    dExpDate := IncMonth(Now, iMonth);

   result := false; 
   try
      try
         qryInsert := TADOQuery.Create(nil);
         qryInsert.Connection := FConnection;
         qryInsert.Sql.add('INSERT into Sal_AccountCard (IDAccountCard, CardNumber, CardDate, ExpirationDate, Amount, IDPreInventoryMov, IDUser)');
         qryInsert.Sql.add(' VALUES (:IDAccountCard, :CardNumber, :CardDate, :ExpirationDate, :amount, :IDPreInventoryMov, :IDUser)');
         qryInsert.Parameters.ParamByName('IDAccountCard').Value     := DM.GetNextID('Sal_AccountCard.IDAccountCard');
         qryInsert.Parameters.ParamByName('CardNumber').Value        := serial_number;
         qryInsert.Parameters.ParamByName('CardDate').Value          := Now;

         if iMonth > 0 then
           qryInsert.Parameters.ParamByName('ExpirationDate').Value  := dExpDate
         else
           qryInsert.Parameters.ParamByName('ExpirationDate').Value  := NULL;
         qryInsert.parameters.parambyname('amount').Value            := 0;
         qryInsert.Parameters.ParamByName('IDPreInventoryMov').Value := FIDItem;
         qryInsert.Parameters.ParamByName('IDUser').Value            := DM.fUser.ID;
         qryInsert.ExecSQL;

         result := true;

      except
          on e: exception do
          raise exception.Create('Insert Sal_AccountCard error: ' + e.Message);
      end;
   finally
      freeAndNil(qryInsert);
   end;

end;

constructor TSerialNumber.Create(idmodel, idstore, iditem, maxqty: Integer);
begin
  FIDModel := idmodel;
  FIDStore := idstore;
  FIDItem  := iditem;
  FMaxQty  := maxqty;
end;

function TSerialNumber.getIsValidated(idItem: Integer): Boolean;
begin
   //verify max quantity
   result := ( getCountSerialNumber(idItem) < FMaxQty );

   if ( not result ) then begin
      raise Exception.Create('Can not enter more than ' + intToStr(FMaxQty )+ ' ' + MSG_EXC_PART2_NO_MORE_SERIAL);
      result := false;
   end;

   FIsValidated := result;
end;

function TSerialNumber.getSerialNumber: String;
begin
  result := FSerialNumber;
end;

procedure TSerialNumber.setConnection(connection: TADOConnection);
begin
  FConnection := connection;
end;

procedure TSerialNumber.setIdInvoice(const Value: Integer);
begin
  fIdInvoice := value;
end;

procedure TSerialNumber.setMaxQty(const Value: Integer);
begin
  FMaxQty := value;
end;

procedure TSerialNumber.setSerialNumber(const Value: String);
begin
  if ( Length(value) > 30 ) then begin
    FSerialNumber := '';
    raise Exception.Create(MSG_CRT_SERIAL_GREATER_THEN_30);
  end;

  if ( value = '' ) then begin
    FSerialNumber := '';
    raise Exception.Create(MSG_CRT_NO_SERIALNUMBER);
  end;

  FSerialNumber := value;

end;

{ TSerialNumberFromPreSale }

function TSerialNumberFromPreSale.add(movId: Integer; serialNumber, identification, processor: String): Boolean;
var
   qry: TADOQuery;
   cdsPreserialMov: TClientDataset;
begin
   result := false;
   try
      try
         qry := TADOQuery.Create(nil);
         qry.Connection := FConnection;
         qry.SQL.Add('insert into PreSerialMov (PreInventoryMovID, SerialNumber, IdentificationNumber, Processor, IsIssued) values(:movid, :serial, :identifier, :processor, :issued)');
         qry.Parameters.ParamByName('movid').Value := movId;
         qry.Parameters.ParamByName('serial').Value := serialNumber;
         qry.Parameters.ParamByName('identifier').Value := identification;
         qry.Parameters.ParamByName('processor').Value := processor;

         // Antonio, August 06, 2013
         if ( FGiftCard ) then
            qry.Parameters.ParamByName('issued').Value := fIsIssued
         else
            qry.Parameters.ParamByName('issued').Value := null;

         qry.ExecSQL;
         result := true;

         // save list to after compare serial numbers
         dm.cdsPreserialMov.Insert();
         dm.cdsPreserialMov.FieldByName('PreinventoryMovID').Value := movID;
         dm.cdsPreserialMov.fieldByName('SerialNumber').Value := serialNumber;
         dm.cdsPreserialMov.FieldByName('Invoice').value := intToStr(fIdInvoice);
         dm.cdsPreserialMov.Post;

      except
         on e: Exception do
           raise Exception.Create('Erro found when I tried add serial number: ' + e.Message);
      end;
   finally
         freeAndNil(qry);
   end;
end;

function TSerialNumberFromPreSale.getCountSerialNumber(
  IdItem: Integer): Integer;
var
   qry: TADOQuery;
begin
   try
      result := 0;
      qry := TADOQuery.Create(nil);
      qry.Connection := FConnection;
      qry.SQL.Add('select PreInventoryMovID, SerialNumber, IdentificationNumber');
      qry.sql.Add(' from PreSerialMov');
      qry.SQL.Add(' where PreInventoryMovID =:preinv');

      qry.Parameters.ParamByName('preinv').Value := idItem;
      qry.Open;

      if ( not qry.IsEmpty ) then
         result := qry.RecordCount;

   finally
      freeAndNil(qry);
   end;
end;


function TSerialNumberFromPreSale.getSerial(iditem: Integer): TDataSet;
var
   qry: TADOQuery;
begin
   try
      result := nil;
      qry := TADOQuery.Create(nil);
      qry.Connection := FConnection;
      qry.SQL.Add('select PreInventoryMovID, SerialNumber, IdentificationNumber, Processor');
      qry.sql.Add(' from PreSerialMov');
      qry.SQL.Add(' where PreInventoryMovID =:iditem');

      qry.Parameters.ParamByName('iditem').Value := iditem;
      qry.Open;
      result := qry;
   finally
//      freeAndNil(qry);
   end;
end;

function TSerialNumberFromPreSale.getSerialCurrent(
  id_preinventory: Integer): TDataSet;
begin
   result := getSerial(id_preinventory);
end;

function TSerialNumberFromPreSale.getSerialRecorded: TDataSet;
var
   qry: TADOQuery;
begin
   try
      result := nil;
      qry := TADOQuery.Create(nil);
      qry.Connection := FConnection;
      qry.SQL.Add('select InventoryMovID, SerialNumber, IdentificationNumber, Processor');
      qry.sql.Add(' from SerialMov');
      qry.Open;
      result := qry;
   finally
 //     freeAndNil(qry);
   end;
end;

function TSerialNumberFromPreSale.getSerials(firstIdItem: Integer): TDataSet;
var
   qry: TADOQuery;
begin
  qry := TADOQuery.create(nil);
  try
     try
       qry.Connection := FConnection;
       qry.SQL.Add(' select');
       qry.SQL.Add(' ac.IDPreInventoryMov');
       qry.SQL.Add(' ,ac.CardNumber');
       qry.SQL.Add(' ,CAST('''' as varchar(30)) IdentificationNumber');
       qry.SQL.Add(' from Sal_AccountCard ac');
       qry.SQL.Add(' where ac.IDPreInventoryMov between :idItemIni and :idItemEnd');
       qry.Parameters.ParamByName('idItemIni').Value := firstIdItem;
       qry.Parameters.ParamByName('idItemEnd').Value := FIDItem;
       qry.Open;
       result := qry;
     except
       on e: Exception do
          raise Exception.Create('Get Serials Error: ' + e.Message);
     end;

  finally
     freeAndNil(qry);
  end;

end;


function TSerialNumberFromPreSale.isDuplicateSerial(serial_number: String; id_preinventory: Integer = 0): Boolean;
var
   qry: TADOQuery;
begin
   try
      result := false;
      // first I try for Sal_AccountCard
      qry := TADOQuery.Create(nil);
      qry.Connection := FConnection;
      qry.SQL.Add('select CardNumber');
      qry.sql.Add(' from Sal_AccountCard');
      qry.SQL.Add(' where CardNumber =:serial');

      qry.Parameters.ParamByName('serial').Value := serial_number;
      qry.Open;
      result := ( not qry.IsEmpty );

      if ( result ) then
        raise Exception.Create('Can not duplicate serial number [Sal_AccountCard]');

      // finally I try
      qry.Close;
      qry.SQL.Add('select SerialNumber');
      qry.sql.Add(' from PreSerialMov');
      qry.SQL.Add(' where PreInventoryMovID =:idpreinv');

      qry.Parameters.ParamByName('idpreinv').Value := id_preinventory;
      qry.Open;
      result := ( not qry.IsEmpty );

      if ( result ) then
        raise Exception.Create('Can not duplicate serial number [PreSerialMov]');


      // finally I try
      qry.Close;
      qry.SQL.Add('SELECT Serial FROM InventorySerial WHERE ModelID=:modelId');
      qry.sql.Add(' AND Serial =:serialNumber');
      qry.SQL.Add(' AND StoreID =:idStore');

      qry.Parameters.ParamByName('modelId').Value := FIDModel;
      qry.Parameters.ParamByName('serialNumber').Value := serial_number;
      qry.Parameters.ParamByName('idStore').Value      := FIDStore;
      qry.Open;
      result := ( not qry.IsEmpty );

      if ( result ) then
        raise Exception.Create('Can not duplicate serial number [InventorySerial]');

   finally
      freeAndNil(qry);
   end;
end;

function TSerialNumberFromPreSale.remove(movId: Integer;
  serialNumber: String): Boolean;
begin
   //
end;

procedure TSerialNumberFromPreSale.savePreserialToVerification(arg_cds: TClientDataset);
begin
  try
     arg_cds.post();
  except
     on e: Exception do
       raise Exception.Create('fail to save PreserialMov list');
  end;
end;

end.
