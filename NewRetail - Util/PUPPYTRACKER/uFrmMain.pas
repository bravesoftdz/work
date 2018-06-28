unit uFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  dxExEdtr, dxDBCtrl, dxDBGrid, dxDBTLCl, dxGrClms, dxTL, dxCntner,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, IniFiles,
  ImgList;

const
  EXE_REP_VER_2006 = 1;
  EXE_REP_VER_2005 = 2;

type

  TParamsConfig = class
     private
      fWaitJob      : Integer;
      fWaitJobStart : Integer;
      fNextSchedule : TDateTime;
      fDisableTime  : Boolean;
     public
      property WaitJob      : Integer   read fWaitJob      write fWaitJob;
      property WaitJobStart : Integer   read fWaitJobStart write fWaitJobStart;
      property NextSchedule : TDateTime read fNextSchedule write fNextSchedule;
      property DisableTime  : Boolean   read fDisableTime  write fDisableTime;
  end;

  TFrmMain = class(TForm)
    MainMenu: TMainMenu;
    Setup1: TMenuItem;
    munPetDatabase: TMenuItem;
    StatusBar: TStatusBar;
    menMRDatabase: TMenuItem;
    pnlLeft: TPanel;
    pnlTop: TPanel;
    pnlList: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image3: TImage;
    menOperation: TMenuItem;
    menPetinventory: TMenuItem;
    Splitter1: TSplitter;
    pnlInfo: TPanel;
    Label3: TLabel;
    menSale: TMenuItem;
    lbInfo: TLabel;
    pb: TProgressBar;
    memSchedule: TMenuItem;
    grdPuppyListDBTableView1: TcxGridDBTableView;
    grdPuppyListLevel1: TcxGridLevel;
    grdPuppyList: TcxGrid;
    grdPuppyHistoryDBTableView1: TcxGridDBTableView;
    grdPuppyHistoryLevel1: TcxGridLevel;
    grdPuppyHistory: TcxGrid;
    grdPuppyListDBTableView1PuppyModel: TcxGridDBColumn;
    grdPuppyListDBTableView1PuppyDescription: TcxGridDBColumn;
    grdPuppyListDBTableView1CostPrice: TcxGridDBColumn;
    grdPuppyListDBTableView1SalePrice: TcxGridDBColumn;
    grdPuppyListDBTableView1Status: TcxGridDBColumn;
    grdPuppyHistoryDBTableView1DateExport: TcxGridDBColumn;
    TimerJob: TTimer;
    Defaults1: TMenuItem;
    img: TImageList;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Close1: TMenuItem;
    Label4: TLabel;
    MainRetailServerDatabase1: TMenuItem;
    procedure munPetDatabaseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure menPetinventoryClick(Sender: TObject);
    procedure memScheduleClick(Sender: TObject);
    procedure menSaleClick(Sender: TObject);
    procedure TimerJobTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Defaults1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure menMRDatabaseClick(Sender: TObject);
    procedure MainRetailServerDatabase1Click(Sender: TObject);
  private
    function FindIDCustomer(Id:string):Boolean;
    function FindCustomer(LastName,FirstName,Zip:string):Boolean;
    procedure CreateHistoryExport;
    function  MaxPuppyHistory(): Integer;
    procedure CreateHistoryPuppyModel(IdPuppyExport,Status: integer; Model,Description:string; Cost,Sale:Currency);
    procedure RefreshGrid;
    procedure ExecuteSchedule;
    procedure ClearHistory;
    procedure SetTime(iTime: Integer);
    function FindModelCateg(Categ:string): Boolean;
    procedure ProcessSale(Invoice : String);
    procedure DebugMessages(Msg :String);
  public
    ParamInvoice: string;
    fJobParam : TParamsConfig;
    procedure SaveNextSchedule;
    procedure LoadParamTask;
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses uDM, uFrmPetFilePath, uFrmSchedule, uNumericFunctions, ADODB,
     uDateTimeFunctions, DateUtils, uFrmDefaultValues, uFrmMRConnection, uFileFunctions;

{$R *.dfm}

procedure TFrmMain.munPetDatabaseClick(Sender: TObject);
begin
  with TFrmPetFilePath.Create(Self) do
      if Start then
         StatusBar.Panels.Items[0].Text := DM.PetFile;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  StatusBar.Panels.Items[0].Text := 'File : ' + DM.PetFile;

  ParamInvoice := '';
  if ParamCount <> 0 then
   begin
    ParamInvoice := ParamStr(1);
    DebugMessages('Invoice : ' + ParamInvoice);
    if Trim(ParamInvoice) <> '' then
      ProcessSale(ParamInvoice);
   end;
end;

procedure TFrmMain.menPetinventoryClick(Sender: TObject);
var
  sSQL : String;
  iIDModel, IdPuppy, Status, iIDInvMov, iIDInvFeatures : Integer;
begin
   try
     pnlInfo.Visible := True;
     menPetinventory.Enabled := False;
     Screen.Cursor           := crHourGlass;
     DM.PetConnectionOpen;
     DM.MRInventoryConnectionOpen;
     lbInfo.Visible          := True;
     lbInfo.Caption          := 'Pets :';
     pb.Visible              := True;
     pb.Position             := 0;
     Application.ProcessMessages;
     DM.quModel.Open;


     If FindModelCateg(IntToStr(DM.DefaultCateg)) then //Verifica se existe a categoria no MR.
      begin
       with DM.quPuppy do
         try
           if Active then
              Close;
           Open;
         pb.Max      := RecordCount;
         pb.Position := 0;

         CreateHistoryExport;
         IdPuppy := MaxPuppyHistory;

         While not EOF do
            begin
            if not DM.quModel.Locate('Model', DM.quPuppyReference_No.AsString, []) then
               begin
               DebugMessages('New Puppy');
               //Novo
               iIDModel := DM.GetNextID('Model.IDModel');
               sSQL := 'INSERT Model (IDModel, GroupID, Model, Description, VendorCost, SellingPrice, SuggRetail) VALUES '+
                       '('+IntToStr(iIDModel)+','+IntToStr(DM.DefaultCateg)+','+
                       QuotedStr(DM.quPuppyReference_No.AsString)+','+
                       QuotedStr(DM.quPuppyBreed_Name.AsString + ' ' + DM.quPuppyColor.AsString)+','+
                       MyFormatCur(DM.quPuppyPur_Price.AsCurrency,'.')+','+
                       MyFormatCur(DM.quPuppySale_Price.AsCurrency,'.')+','+
                       MyFormatCur(DM.quPuppyRegular_Price.AsCurrency,'.')+')';
               DM.RunSQL(sSQL);

               Status := 1;

               //Insere a quantidade.
               iIDInvMov := DM.GetNextID('InventoryMov.IDInventoryMov');

               DM.cmdInsertQty.Parameters.ParamByName('IDInventoryMov').Value := iIDInvMov;
               DM.cmdInsertQty.Parameters.ParamByName('IDModel').Value := iIDModel;
               DM.cmdInsertQty.Parameters.ParamByName('IDStore').Value := DM.DefaultStore;

               DM.cmdInsertQty.Execute;

               //Insere features do Model.
               // Raça
               iIDInvFeatures := DM.GetNextID('InvFeatures.IDInvFeatures');
               sSQL := 'INSERT InvFeatures (IDInvFeatures, IDModel, Feature) VALUES ' +
                       '(' + IntToStr(iIDInvFeatures) + ',' + IntToStr(iIDModel) + ',' + QuotedStr('Breed - ' + DM.quPuppyBreed_Code.AsString) + ')';
               DM.RunSQL(sSQL);

               // Sexo
               iIDInvFeatures := DM.GetNextID('InvFeatures.IDInvFeatures');
               sSQL := 'INSERT InvFeatures (IDInvFeatures, IDModel, Feature) VALUES ' +
                       '(' + IntToStr(iIDInvFeatures) + ',' + IntToStr(iIDModel) + ',' + QuotedStr('Sex - ' + DM.quPuppySex.AsString) + ')';
               DM.RunSQL(sSQL);

               //DebugMessages('Barcode = ' + DM.quPuppyChip_No.AsString + ', Model = ' + IntToStr(iIDModel));
               
               //Insere barcode.
               if (DM.quPuppyChip_No.AsString <> 'NO CHIP') and (DM.quPuppyChip_No.AsString <> '') then
                 begin
                   sSQL := 'INSERT Barcode (IDBarcode, IDModel, Data, BarcodeOrder) VALUES '+
                         '(' + QuotedStr(DM.quPuppyChip_No.AsString) + ',' + IntToStr(iIDModel) + ' , GetDate(), 1 )' ;
                   DM.RunSQL(sSQL);
                 end;

               if DM.SaveSerialNum then
               begin
                 //Insere SerialNumber.
                 if (DM.quPuppyChip_No.AsString <> 'NO CHIP') and (DM.quPuppyChip_No.AsString <> '') then
                   begin
                     sSQL := 'INSERT InventorySerial (StoreID, ModelID, Serial) VALUES '+
                           '(' + InttoStr(DM.DefaultStore) + ',' + IntToStr(iIDModel) + ',' + QuotedStr(DM.quPuppyChip_No.AsString) + ' )' ;
                     DM.RunSQL(sSQL);
                   end;
               end;

               end
            else
               begin
               DebugMessages('Update Puppy');
               //Atualizar
               sSQL := 'UPDATE Model SET VendorCost = ' + MyFormatCur(DM.quPuppyPur_Price.AsCurrency,'.')+
                       ', SellingPrice = ' + MyFormatCur(DM.quPuppySale_Price.AsCurrency,'.')+
                       ', SuggRetail  = ' + MyFormatCur(DM.quPuppyRegular_Price.AsCurrency,'.')+
                       ' WHERE IDModel = ' + DM.quModelIDModel.AsString;
               DM.RunSQL(sSQL);

               Status := 2;
               end;

            CreateHistoryPuppyModel(IdPuppy,Status,DM.quPuppyReference_No.AsString,DM.quPuppyBreed_Name.AsString + ' ' +
                                    DM.quPuppyColor.AsString,DM.quPuppyPur_Price.AsCurrency,
                                    DM.quPuppySale_Price.AsCurrency);

            pb.Position := pb.Position + 1;
            Application.ProcessMessages;
            Next;
            end;
         finally
           Close;
           end;
      end
     else
      Application.MessageBox('Category is not existy.','Erro');

   finally
     DM.quModel.Close;
     DM.PetConnectionClose;
     DM.MRInventoryConnectionClose;
     Screen.Cursor           := crDefault;
     menPetinventory.Enabled := True;
     lbInfo.Visible          := False;
     pb.Visible              := False;
     pnlInfo.Visible         := False;
     ClearHistory;
     RefreshGrid;
     end;
end;

procedure TFrmMain.memScheduleClick(Sender: TObject);
begin
  with TFrmSchedule.Create(Self) do
     Start;
end;

procedure TFrmMain.menSaleClick(Sender: TObject);
var
  number : string;
begin

  number := InputBox('Invoice','number','');

  if Trim(number) <> '' then
    ProcessSale(number);

end;

function TFrmMain.FindIDCustomer(Id: string): Boolean;
var friend:boolean;
begin
 with DM.quIDCustomers do
   try
    if Active then
       Close;
    Parameters.ParamByName('Customer').Value:=Id;
    Open;

    if DM.quIDCustomers.RecordCount=0 then
     friend:=False
    else
     friend:=True;

   finally
    Close;
    end;

   Result:=friend;
end;

procedure TFrmMain.CreateHistoryExport;
var sSQL:string;
begin
  sSQL := 'INSERT INTO PuppyExport (DateExport) VALUES ((Date()+Time()));';
  DM.RunSQL_History(sSQL);
end;

function TFrmMain.MaxPuppyHistory: Integer;
var friend:integer;
begin
  with DM.quMaxPuppyExport do
   try
    if Active then
       Close;
    Open;

    friend := DM.quMaxPuppyExport.FieldbyName('Expr1000').AsInteger;

    finally
    Close;
    end;

  Result := friend;
end;

procedure TFrmMain.CreateHistoryPuppyModel(IdPuppyExport,Status: integer; Model,Description:string;
Cost,Sale:Currency);
var sSQL:string;
begin
 sSQL := 'INSERT INTO PuppyModel (IdPuppyExport, PuppyModel, PuppyDescription, CostPrice, SalePrice, Status) VALUES ( ' +InttoStr(IdPuppyExport)+',' +
         QuotedStr(Model)+','+QuotedStr(Description)+',' +
         MyFormatCur(Cost,'.')+','+MyFormatCur(Sale,'.')+','+InttoStr(Status)+');';
 DM.RunSQL_History(sSQL);
end;

procedure TFrmMain.RefreshGrid;
begin
 if DM.quListPuppyExport.Active then
    DM.quListPuppyExport.Close;

 if DM.quListPuppyModel.Active then
    DM.quListPuppyModel.Close;
    
 DM.quListPuppyExport.Open;
 DM.quListPuppyModel.Open;
end;

procedure TFrmMain.TimerJobTimer(Sender: TObject);
begin
 TimerJob.Enabled  := False;
 ExecuteSchedule;
 SaveNextSchedule;
 TimerJob.Enabled  := True;
end;

procedure TFrmMain.ExecuteSchedule;
begin
 if not (fJobParam.NextSchedule < Now) then
  Exit
 else
  menPetinventory.Click;
end;

procedure TFrmMain.SaveNextSchedule;
var
  MyTime : TDateTime;
begin

  MyTime := fJobParam.NextSchedule;

  Case DM.fPetInfo.ReadInteger('Tasks','Every',0) of
    0: MyTime := (AddHours(MyTime, DM.fPetInfo.ReadInteger('Tasks','Interval',1)));
    1: MyTime := (AddMinutes(MyTime, DM.fPetInfo.ReadInteger('Tasks','Interval',1)));
  end;

  Case DM.fPetInfo.ReadInteger('Tasks','Occurs',0) of
    0: MyTime := IncDay(MyTime, 0);
    1: MyTime := IncDay(MyTime, 7);
    2: MyTime := IncMonth(MyTime, 1);
  end;

  if MyTime < Now then
     MyTime := Now;

  DM.fPetInfo.WriteDateTime('Tasks','NextSchedule', MyTime);
  fJobParam.NextSchedule := MyTime;
  StatusBar.Panels.Items[1].Text := FormatDateTime('"The schedule is on " dddd, mmmm d, yyyy, " at " hh:mm AM/PM''', fJobParam.NextSchedule);
end;

{ TParamsConfig }

procedure TFrmMain.SetTime(iTime: Integer);
begin
  TimerJob.Enabled   := False;
  TimerJob.Interval  := iTime * 60000;
  TimerJob.Enabled   := not fJobParam.DisableTime;
end;

procedure TFrmMain.LoadParamTask;
begin
  fJobParam.NextSchedule := DM.fPetInfo.ReadDateTime('Tasks','NextSchedule',Now);
  fJobParam.DisableTime  := DM.fPetInfo.ReadBool('Schedule','DisableSchedule', True);
  SetTime(DM.fPetInfo.ReadInteger('Timer','CallJob',10));
  StatusBar.Panels.Items[1].Text := FormatDateTime('"The schedule is on " dddd, mmmm d, yyyy, " at " hh:mm AM/PM''', fJobParam.NextSchedule);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  fJobParam := TParamsConfig.Create;
  LoadParamTask;
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fJobParam);
end;

procedure TFrmMain.Defaults1Click(Sender: TObject);
begin
   TimerJob.Enabled := False;

   with TFrmDefaultValues.Create(Self) do
        Start;

   TimerJob.Enabled := not fJobParam.DisableTime;
end;

procedure TFrmMain.Close1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmMain.menMRDatabaseClick(Sender: TObject);
begin
   TimerJob.Enabled := False;

   with TFrmMRConnection.Create(Self) do
      Start(1);

   TimerJob.Enabled := not fJobParam.DisableTime;
end;

function TFrmMain.FindModelCateg(Categ: string): Boolean;
var friend:Boolean;
begin

 with DM.quFindCategory do
   try
    if Active then
       Close;
    Parameters.ParamByName('IDGroup').Value := Categ;
    Open;

    if DM.quFindCategory.RecordCount=0 then
     friend := False
    else
     friend := True

    finally
    Close;
    end;

  Result := friend;
end;

function TFrmMain.FindCustomer(LastName, FirstName, Zip: string): Boolean;
var friend:boolean;
begin
 with DM.quCustomers do
   try
    if Active then
       Close;
    Parameters.ParamByName('Name').Value:=LastName;
    Parameters.ParamByName('FirstName').Value:=FirstName;
    Parameters.ParamByName('Zip').Value:=Zip;
    Open;

    if DM.quCustomers.RecordCount=0 then
     friend:=False
    else
     friend:=True;

   finally
    Close;
    end;

   Result:=friend;
end;

procedure TFrmMain.ClearHistory;
var sSQL:String;
begin
  with DM.quDelHistoryDate  do
   try
    if Active then
       Close;
    Parameters.ParamByName('Data').Value:=DM.DelHistory;
    Open;

    DM.quDelHistoryDate.First;
    while not DM.quDelHistoryDate.Eof do
     begin
       sSQL := 'DELETE FROM PuppyModel ' +
               'WHERE IDPuppyExport = ' + InttoStr(DM.quDelHistoryDate.FieldByName('IDPuppyExport').AsInteger);
       DM.RunSQL_History(sSQL);

       sSQL := 'DELETE FROM PuppyExport ' +
               'WHERE IDPuppyExport = ' + InttoStr(DM.quDelHistoryDate.FieldByName('IDPuppyExport').AsInteger);
       DM.RunSQL_History(sSQL);

       DM.quDelHistoryDate.Next;
     end;
     
   finally
    Close;
    end;
end;

procedure TFrmMain.ProcessSale(Invoice: String);
var
  IdCustomer, sSQL, sSQL2, CustAddress, CustName,
  CustFirstName, CustCity, CustComments, CustEmail,
  CustCountry, CustZip, CustPhone, CustFax, CustState, SalesPerson :string;
  i: integer;
  CostumerExisty: Boolean;
begin

 try

  DM.PetConnectionOpen;
  DM.MRSalesConnectionOpen;

  i := 1;

  if DM.quInvoiceItem.Active then
     DM.quInvoiceItem.Close;
  DM.quInvoiceItem.Parameters.ParamByName('IDInvoice').Value := Invoice;
  DM.quInvoiceItem.Open;

  if not(DM.quInvoiceItem.IsEmpty) Then
    DebugMessages('MRInvoice item is NOT empty!! ')
  else
    DebugMessages('MRInvoice item is empty!! ');

  if not(DM.quInvoiceItem.IsEmpty) Then
   begin
    with DM.quInvoice do
      try
       if Active then
          Close;
       Parameters.ParamByName('IDInvoice').Value := Invoice;
       Open;

       if not(DM.quInvoice.IsEmpty) Then
         DebugMessages('MRInvoice is NOT empty!! ')
       else
         DebugMessages('MRInvoice is empty!! ');


       CostumerExisty := FindCustomer(Dm.quInvoice.FieldByName('PessoaLastName').AsString,Dm.quInvoice.FieldByName('PessoaFirstName').AsString,Trim(Dm.quInvoice.FieldByName('CEP').AsString));
       IdCustomer  := copy(Dm.quInvoice.FieldByName('PessoaLastName').AsString,1,4) + copy(Dm.quInvoice.FieldByName('PessoaFirstName').AsString,1,3);

       CustAddress   := copy(Trim(Dm.quInvoice.FieldByName('Endereco').AsString),1,40);
       CustName      := copy(Trim(Dm.quInvoice.FieldByName('PessoaLastName').AsString),1,100);
       CustFirstName := copy(Trim(Dm.quInvoice.FieldByName('PessoaFirstName').AsString),1,100);
       CustCity      := copy(Trim(Dm.quInvoice.FieldByName('Cidade').AsString),1,20);
       CustComments  := copy(Trim(Dm.quInvoice.FieldByName('OBS').AsString),1,250);
       CustEmail     := copy(Trim(Dm.quInvoice.FieldByName('Email').AsString),1,100);
       CustCountry   := copy(Trim(Dm.quInvoice.FieldByName('Pais').AsString),1,15);
       CustZip       := copy(Trim(Dm.quInvoice.FieldByName('CEP').AsString),1,10);
       CustPhone     := copy(Trim(Dm.quInvoice.FieldByName('Telefone').AsString),1,14);
       CustFax       := copy(Trim(Dm.quInvoice.FieldByName('Fax').AsString),1,14);
       CustState     := copy(Trim(Dm.quInvoice.FieldByName('IDEstado').AsString),1,2);

       while FindIDCustomer(IdCustomer) and not(CostumerExisty) do
        begin
        IdCustomer := copy(Dm.quInvoice.FieldByName('PessoaLastName').AsString,1,4) + copy(Dm.quInvoice.FieldByName('PessoaFirstName').AsString,1,3) +InttoStr(i);
        inc(i);
        end;

       if not(CostumerExisty) then
        begin
        sSQL := 'INSERT INTO Customers (Customer_Id, Name, FirstName, Address, City, State, Zip, Phone, Fax, '+
                         ' Comments, Email, Country, Date_Added ) VALUES ' +
                          '('+QuotedStr(IdCustomer)+','+QuotedStr(CustName)+','+
                          QuotedStr(CustFirstName)+','+QuotedStr(CustAddress)+','+
                          QuotedStr(CustCity)+','+QuotedStr(CustState)+','+
                          QuotedStr(CustZip)+','+QuotedStr(CustPhone)+','+
                          QuotedStr(CustFax)+','+QuotedStr(CustComments)+','+
                          QuotedStr(CustEmail)+','+QuotedStr(CustCountry)+', Date());';
        DM.RunSQL_PET(sSQL);
        end
       else
        begin // Atualizar.
        sSQL := 'UPDATE Customers SET Address = ' + QuotedStr(Dm.quInvoice.FieldByName('Endereco').AsString) +
               ', City = ' + QuotedStr(Dm.quInvoice.FieldByName('Cidade').AsString) +
               ', State  = ' + QuotedStr(Dm.quInvoice.FieldByName('IDEstado').AsString) +
               ', Phone  = ' + QuotedStr(Dm.quInvoice.FieldByName('Telefone').AsString) +
               ', Fax    = ' + QuotedStr(Dm.quInvoice.FieldByName('Fax').AsString) +
               ', Comments  = ' + QuotedStr(Dm.quInvoice.FieldByName('OBS').AsString) +
               ', Email  = ' + QuotedStr(Dm.quInvoice.FieldByName('Email').AsString) +
               ', Country  = ' + QuotedStr(Dm.quInvoice.FieldByName('Pais').AsString) +
               ' WHERE Name = ' + QuotedStr(Dm.quInvoice.FieldByName('PessoaLastName').AsString) +
               ' and FirstName = ' + QuotedStr(Dm.quInvoice.FieldByName('PessoaFirstName').AsString) +
               ' and Zip = ' + QuotedStr(Trim(Dm.quInvoice.FieldByName('CEP').AsString));
        DM.RunSQL_PET(sSQL);
        end;

        SalesPerson := DM.GetSalesPerson(Invoice);

        DM.quInvoiceItem.First;
        while not DM.quInvoiceItem.Eof do
         begin
          if DM.quInvoiceItemQty.AsInteger > 0 then
          begin
            sSQL := ' UPDATE Pups SET Sales_Price = ' + QuotedStr(DM.quInvoiceItem.FieldByName('SalePrice').AsString) +
                    ' , Date_Sold  = ' + QuotedStr(DM.quInvoiceItem.FieldByName('InvoiceDate').AsString) +
                    ' , Sales_Person  = ' + QuotedStr(SalesPerson) +
                    ' , Customer_ID  = ' + QuotedStr(IdCustomer) +
                    '  WHERE Reference_No = ' + DM.quInvoiceItem.FieldByName('Model').AsString+ ';';

            sSQL2 := 'Update Model SET Hidden = 1 Where IDModel = ' + DM.quInvoiceItemModelID.AsString;
          end
          else
          begin
            sSQL := ' UPDATE Pups SET ' +
                    ' Sales_Price = 0 , Date_Sold  = null , Customer_ID  = null, Sales_Person = null ' +
                    ' WHERE Reference_No = ' + DM.quInvoiceItem.FieldByName('Model').AsString+ ';';

            sSQL2 := 'Update Model SET Hidden = 0 Where IDModel = ' + DM.quInvoiceItemModelID.AsString;
          end;

          DM.RunSQL_PET(sSQL);
          DM.RunSQL(sSQL2);

          if DM.PetRepExeVer = EXE_REP_VER_2006 then
          begin
            DebugMessages('Report Version 2006!! ');
            ExecuteFile(DM.PetExeRepFile, 'salesreportspuppy' + ' ' + DM.quInvoiceItem.FieldByName('Model').AsString,'',SW_HIDE);
          end
          else if DM.PetRepExeVer = EXE_REP_VER_2005 then
          begin
            DebugMessages('Report Version 2005!! ');
            ExecuteFile(DM.PetExeRepFile, 'salesreportspuppy'+' '+DM.quInvoiceItem.FieldByName('Model').AsString+' '+DM.PetNumCop,'',SW_HIDE);
          end;

          DebugMessages('End Report!! ');

          DM.quInvoiceItem.Next;
         end;

      finally
       DM.quInvoice.Close;
      end;
    end;

   finally
     DM.quInvoice.Close;
     DM.quInvoiceItem.Close;
     DM.PetConnectionClose;
     DM.MRSalesConnectionClose;
     end;

   if ParamCount <> 0 then
    Self.Close;

end;

procedure TFrmMain.DebugMessages(Msg: String);
begin
  if DM.UseDebug then
    ShowMessage(Msg);
end;

procedure TFrmMain.MainRetailServerDatabase1Click(Sender: TObject);
begin
  TimerJob.Enabled := False;

   with TFrmMRConnection.Create(Self) do
      Start(2);

   TimerJob.Enabled := not fJobParam.DisableTime;
end;

end.
