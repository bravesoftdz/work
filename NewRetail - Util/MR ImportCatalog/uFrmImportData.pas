unit uFrmImportData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Db, ADODB, jpeg, FileCtrl, Grids,
  uDataBaseOperation, siComp, Mask, SuperComboADO, PowerADOQuery,
  LookUpADOQuery, DBCtrls, ComCtrls, RCADOQuery, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DateBox, cxContainer, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
   //Delete Row and Col in a StringGrid
   TAdvStringGrid = Class(TStringGrid)
      Public
         Procedure DeleteRow(ARow:LongInt); Override;
         Procedure DeleteColumn(AColumn:LongInt); Override;
   End;


const
  BACKUP  = 0;
  RESTORE = 1;

  KEY_TRIAL = 0;
  KEY_FULL  = 1;

  NUMBER_MR_COLUMNS = 14;

  PO_IMPORT      = 0;
  CATALOG_IMPORT = 1;

type
  TFrmImportDB = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    btnBack: TButton;
    btnNext: TButton;
    btnClose: TButton;
    Notebook: TNotebook;
    ImgIntro: TImage;
    Label28: TLabel;
    Label36: TLabel;
    ImgSummary: TImage;
    Label29: TLabel;
    Label37: TLabel;
    memSummary: TMemo;
    Panel4: TPanel;
    Label57: TLabel;
    Label58: TLabel;
    ImgChooser: TImage;
    Panel3: TPanel;
    Label8: TLabel;
    lbDBInfo: TLabel;
    imgDB: TImage;
    OD: TOpenDialog;
    lbStatus: TLabel;
    cbxBKPDevice: TGroupBox;
    sbOpenBKP: TSpeedButton;
    rbFile: TRadioButton;
    edtFilePath: TEdit;
    sgFile: TStringGrid;
    lbRecords: TLabel;
    btnDelete: TSpeedButton;
    pnlStatus: TPanel;
    Panel5: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    Image1: TImage;
    Label10: TLabel;
    edtKey: TEdit;
    sgColumns: TStringGrid;
    cbColumns: TComboBox;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1IDModelCatalog: TcxGridDBColumn;
    cxGrid1DBTableView1IDModel: TcxGridDBColumn;
    cxGrid1DBTableView1IDVendor: TcxGridDBColumn;
    cxGrid1DBTableView1IDSize: TcxGridDBColumn;
    cxGrid1DBTableView1IDColor: TcxGridDBColumn;
    cxGrid1DBTableView1IDManufect: TcxGridDBColumn;
    cxGrid1DBTableView1IDTabGroup: TcxGridDBColumn;
    cxGrid1DBTableView1IDSubGroup: TcxGridDBColumn;
    cxGrid1DBTableView1IDBarcode: TcxGridDBColumn;
    cxGrid1DBTableView1Model: TcxGridDBColumn;
    cxGrid1DBTableView1InvSize: TcxGridDBColumn;
    cxGrid1DBTableView1InvColor: TcxGridDBColumn;
    cxGrid1DBTableView1Description: TcxGridDBColumn;
    cxGrid1DBTableView1Manufacture: TcxGridDBColumn;
    cxGrid1DBTableView1TabGroup: TcxGridDBColumn;
    cxGrid1DBTableView1CustoPrice: TcxGridDBColumn;
    cxGrid1DBTableView1SalePrice: TcxGridDBColumn;
    cxGrid1DBTableView1VendorCode: TcxGridDBColumn;
    cxGrid1DBTableView1Qty: TcxGridDBColumn;
    cxGrid1DBTableView1SubGroup: TcxGridDBColumn;
    cxGrid1DBTableView1QtyMin: TcxGridDBColumn;
    cxGrid1DBTableView1QtyMax: TcxGridDBColumn;
    lbProgress: TLabel;
    pb: TProgressBar;
    GroupBox3: TGroupBox;
    cbArchiveType: TComboBox;
    pnlCatalog: TPanel;
    gbVendorCatalogue: TGroupBox;
    cbCatalogVendorList: TComboBox;
    pnlPO: TPanel;
    gbSupplier: TGroupBox;
    cbPOVendorList: TComboBox;
    edtDelimiter: TEdit;
    Label1: TLabel;
    edPONumber: TEdit;
    Label3: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edPurchaseNumber: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    dbRecordDate: TDateBox;
    dbDueDate: TDateBox;
    edFreight: TEdit;
    edOtherCost: TEdit;
    Freight: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    cbxStore: TcxLookupComboBox;
    cbxUser: TcxLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NotebookPageChanged(Sender: TObject);

    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);

    procedure sbOpenFileClick(Sender: TObject);

    procedure sgColumnsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cbColumnsChange(Sender: TObject);
    procedure cbColumnsExit(Sender: TObject);
    procedure cbArchiveTypeChange(Sender: TObject);
  private
    DBOperation : TDataBaseOperation;
    FFile       : TStringList;
    FComboList  : TStringList;
    FOrder      : TStringList;
    FFileCabecalho : TStringList;
    KeyType        : Integer;
    iVendor        : Integer;
    fDelimiter     : Char;
    fImportType    : Integer;

    //Translation
    sNext,
    sConnect,
    sFinish  : String;

    //PO
    iStore          : Integer;
    iUser           : Integer;
    fPONumber       : String;
    fPurchaseNumber : String;
    fFreight        : String;
    fOtherCost      : String;
    fRecordDate     : TDate;
    fDueDate        : TDate;

    procedure PageWelcome;
    procedure PageReadme;
    procedure PageSetting;
    procedure PageDatabase;
    procedure PageLast;

    procedure ValidateKey(Key:String);
    procedure RefreshGridInfo;

    procedure SetNextPage;
    procedure SetPriorPage;

    procedure BuildResume;
    procedure BuildGrid;
    function DuplicatedFields(sField:String):String;

    procedure SetCaptions;
    procedure DoFinal;
    procedure MountFileonGrid;
    procedure FillColumnsGrid;
    procedure AddColumnsToImport;
    procedure AddColumnToGrid(Field :String; Row:Integer);
    procedure AddComboColumnsToImport;
    procedure AddComboVendorList;
    function ReturnVendorID(Vendor :String):Integer;
    procedure SaveModelCatalog;
    procedure GetColumnOrder;
    function MRNumberColumn(Number :Integer): String;
    procedure UpdateModelCatalog;
    procedure ConfigScreen;

    { Max }
    procedure PrepareCatalogDB;

    procedure OpenStore;
    procedure OpenVendor;
    procedure OpenUser;
    procedure CloseStore;
    procedure CloseVendor;
    procedure CloseUser;
  public
    { Public declarations }
  end;

var
  FrmImportDB: TFrmImportDB;

implementation

uses uParamFunctions, uMsgBox, uSystemConst, uFrmServerInfo,
     Registry, uNumericFunctions, uSistemInfo, uDM, uDMImport;

{$R *.DFM}

procedure TFrmImportDB.FormCreate(Sender: TObject);
begin
  SetCaptions;
end;

procedure TFrmImportDB.FormShow(Sender: TObject);
begin
  Notebook.PageIndex := 0;
  ImgSummary.Picture.Assign(ImgIntro.Picture);
end;

procedure TFrmImportDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseStore;
  CloseUser;
  CloseVendor;
  DMImport.CloseConnection;

  FreeAndNil(FFile);
  FreeAndNil(FComboList);
  Action := caFree;
end;

procedure TFrmImportDB.NotebookPageChanged(Sender: TObject);
begin
  if Notebook.ActivePage = 'pgIntro' then
    PageWelcome
  else if Notebook.ActivePage = 'pgReadme' then
    PageReadme
  else if Notebook.ActivePage = 'pgSelection' then
    PageSetting
  else if Notebook.ActivePage = 'pgDatabase' then
    PageDatabase
  else if Notebook.ActivePage = 'pgSummary' then
    PageLast;
end;

procedure TFrmImportDB.btnBackClick(Sender: TObject);
begin
  SetPriorPage;
end;

procedure TFrmImportDB.btnNextClick(Sender: TObject);
begin
  SetNextPage;
end;

procedure TFrmImportDB.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmImportDB.btnDeleteClick(Sender: TObject);
begin
  TAdvStringGrid(sgFile).DeleteRow(sgFile.Row);
  RefreshGridInfo;
end;

procedure TFrmImportDB.ValidateKey(Key:String);
var
  val : Integer;
begin

   KeyType := KEY_TRIAL;

   if (Trim(Key) = '') and (Length(Key)<10) then
      Exit;

   val := MyStrToInt(Copy(Key,2,1));
   val := val + MyStrToInt(Copy(Key,3,1));
   val := val + MyStrToInt(Copy(Key,9,1));

   if val = 10 then
      KeyType := KEY_FULL;

end;

function TFrmImportDB.DuplicatedFields(sField:String):String;
begin
   Screen.Cursor:= crHourGlass;
   Result := '';
   with DM.quCkeckModel do
      begin
      Close;
      CommandText := 'SELECT  I1.'+sField+' as Model ' +
                     'FROM  InvTemp I1 JOIN InvTemp I2 ON (I1.'+sField+' = I2.'+sField+') ' +
                     'GROUP BY I1.'+sField+' '+
                     'HAVING  Count(I1.'+sField+') > 1';
      Open;
      If RecordCount > 0 then
         begin
         Result := 'Error: ' + IntToStr(RecordCount) + ' duplicated item(s) in the data file.'+ #13#10;
         Result := Result + 'Solution: Delete the duplicated item(s) from the data file and start the wizard again.' + #13#10 +
                   'Duplicated ('+sField+')(s) :' + #13#10;
         First;
         While not EOF do
             begin
             Result := Result + '(' + DM.quCkeckModelModel.AsString + ') ';
             Next;
             end;
         end;
      Close;
      Screen.Cursor:= crDefault;
      end;
end;

procedure TFrmImportDB.DoFinal;
var
   Error  : Boolean;
   sError : String;
   iIDI   : Integer;
   sSQL   : String;
   iCode  : Integer;
   sValue : String;

begin
   {

    DROP TABLE MODEL_IMPORT


   function InsertSize:Boolean;
   begin
     Try
       Result := True;
       lbProgress.Caption := 'Creating size. Please wait...';
       Application.ProcessMessages;

       with quSize do
       begin
       if not Active then
          Open;
       First;
       pnlStatus.Visible := True;
       pb.Position       := 0;
       pb.Max            := quSize.RecordCount;
       while not EOF do
         begin
         pb.Position := pb.Position + 1;
         Application.ProcessMessages;
         sValue := Trim(Copy(quSizeInvSize.AsString,1,10));
         iIDI := GetNextID('InvSize.IDSize');
         RunSQL('INSERT InvSize (IDSize, SizeName, CodSize) VALUES '+
                '('+IntToStr(iIDI)+','+QuotedStr(sValue)+','+QuotedStr(sValue)+')');
         Next;
         end;
       if Active then
          Close;
       RunSQL('UPDATE MP SET MP.IDSize = S.IDSize FROM InvSize S, '+
              'MODEL_IMPORT MP WHERE MP.InvSize = S.SizeName');
       end;
     Except
       on E: Exception do
          begin
          Result := False;
          with TFrmError.Create(Self) do
               Start(E.Message);
          end;
       End;
   end;

   function InsertColor:Boolean;
   begin
     Try
       Result := True;
       lbProgress.Caption := 'Creating color. Please wait...';
       Application.ProcessMessages;

       with quColor do
       begin
       if not Active then
          Open;
       First;
       pnlStatus.Visible := True;
       pb.Position       := 0;
       pb.Max            := quColor.RecordCount;
       while not EOF do
         begin
         pb.Position := pb.Position + 1;
         Application.ProcessMessages;
         sValue := Trim(Copy(quColorInvColor.AsString,1,10));
         iIDI := GetNextID('InvColor.IDColor');
         RunSQL('INSERT InvColor (IDColor, Color, CodColor) VALUES '+
                '('+IntToStr(iIDI)+','+QuotedStr(sValue)+','+QuotedStr(sValue)+')');
         Next;
         end;
       if Active then
          Close;
       RunSQL('UPDATE MP SET MP.IDColor = C.IDColor FROM InvColor C, '+
              'MODEL_IMPORT MP WHERE MP.InvColor = C.Color');
       end;
     Except
       on E: Exception do
          begin
          Result := False;
          with TFrmError.Create(Self) do
               Start(E.Message);
          end;
       End;
   end;

   function InsertFabricante:Boolean;
   begin
     Try
       Result := True;
       lbProgress.Caption := 'Creating vendor. Please wait...';
       Application.ProcessMessages;

       with quFabricante do
       begin
       if not Active then
          Open;
       First;
       pnlStatus.Visible := True;
       pb.Position       := 0;
       pb.Max            := quFabricante.RecordCount;
       iCode             := 0;
       while not EOF do
         begin
         pb.Position := pb.Position + 1;
         Application.ProcessMessages;
         inc(iCode);
         iIDI := GetNextID('Pessoa.IDPessoa');
         RunSQL('INSERT Pessoa (IDPessoa, IDTipoPessoa, IDTipoPessoaRoot, Pessoa, Juridico, code) VALUES '+
                '('+IntToStr(iIDI)+',7,7,'+QuotedStr(quFabricanteManufacture.AsString)+',1,'+IntToStr(iCode)+')');
         Next;
         end;

       if Active then
          Close;
          
       RunSQL('UPDATE MP SET MP.IDManufect = P.IDPessoa FROM Pessoa P, '+
              'MODEL_IMPORT MP WHERE MP.Manufacture = P.Pessoa');

       RunSQL('UPDATE TipoPessoa SET LastCode = (Select Max(Code) From Pessoa WHERE IDTipoPessoa = 7) '+
              'WHERE IDTipoPessoa = 7');
              
       end;
     Except
       on E: Exception do
          begin
          Result := False;
          with TFrmError.Create(Self) do
               Start(E.Message);
          end;
       End;
   end;

   function InsertTabGroup:Boolean;
   begin
     Try
       Result := True;
       lbProgress.Caption := 'Creating category. Please wait...';
       Application.ProcessMessages;

       with quTabGroup do
       begin
       if not Active then
          Open;
       First;
       pnlStatus.Visible := True;
       pb.Position       := 0;
       pb.Max            := quTabGroup.RecordCount;
       while not EOF do
         begin
         pb.Position := pb.Position + 1;
         Application.ProcessMessages;
         iIDI := GetNextID('TabGroup.IDGroup');
         RunSQL('INSERT TabGroup (IDGroup, Name) VALUES '+
                '('+IntToStr(iIDI)+','+QuotedStr(quTabGroupTabGroup.AsString)+')');
         Next;
         end;
       if Active then
          Close;
       RunSQL('UPDATE MP SET MP.IDTabGroup = G.IDGroup FROM TabGroup G, '+
              'MODEL_IMPORT MP WHERE MP.tabGroup = G.Name');
       end;
     Except
       on E: Exception do
          begin
          Result := False;
          with TFrmError.Create(Self) do
               Start(E.Message);
          end;
       End;
   end;

   function InsertSubGroup:Boolean;
   begin
     Try
       Result := True;
       lbProgress.Caption := 'Creating SubGroup. Please wait...';
       Application.ProcessMessages;

       with quSubGroup do
       begin
       if not Active then
          Open;
       First;
       pnlStatus.Visible := True;
       pb.Position       := 0;
       pb.Max            := quSubGroup.RecordCount;
       while not EOF do
         begin
         pb.Position := pb.Position + 1;
         Application.ProcessMessages;
         iIDI := GetNextID('SubGroup.IDSubGroup');
         RunSQL('INSERT SubGroup (IDSubGroup, SubGroup) VALUES '+
                '('+IntToStr(iIDI)+','+QuotedStr(quSubGroupSubGroup.AsString)+')');
         Next;
         end;
       if Active then
          Close;
       RunSQL('UPDATE MP SET MP.IDSubGroup = S.IDSubGroup FROM SubGroup S, '+
              'MODEL_IMPORT MP WHERE MP.SubGroup = S.SubGroup');
       end;
     Except
       on E: Exception do
          begin
          Result := False;
          with TFrmError.Create(Self) do
               Start(E.Message);
          end;
       End;
   end;


   function InsertModel:Boolean;
   var
     sSQL,
     IDPessoa,
     IDSize,
     IDColor,
     IDSubGroup : String;
     sModel : String;
   begin
     Try
       Result := True;
       lbProgress.Caption := 'Creating Model. Please wait...';
       Application.ProcessMessages;

       with quModel do
       begin
       if not Active then
          Open;
       First;
       pnlStatus.Visible := True;
       pb.Position       := 0;
       pb.Max            := quModel.RecordCount;
       while not EOF do
         begin
         pb.Position := pb.Position + 1;
         Application.ProcessMessages;
         iIDI := GetNextID('Model.IDModel');

         if quModelIDManufect.AsString = '' then
            IDPessoa := 'NULL'
         else
            IDPessoa := quModelIDManufect.AsString;

         if quModelIDSize.AsString = '' then
            IDSize := 'Null'
         else
            IDSize := quModelIDSize.AsString;

         if quModelIDColor.AsString = '' then
            IDColor := 'Null'
         else
            IDColor := quModelIDColor.AsString;

         if quModelIDSubGroup.AsString = '' then
            IDSubGroup := 'Null'
         else
            IDsubGroup := quModelIDSubGroup.AsString;

         sModel := quModelModel.AsString;

         sSQL := 'INSERT Model (IDModel, GroupID, IDFabricante, IDSize, IDColor, IDSubGroup, Model, Description, VendorCost, SellingPrice) VALUES '+
                '('+IntToStr(iIDI)+','+quModelIDTabGroup.AsString+','+
                IDPessoa+','+IDSize+','+IDColor+','+IDSubGroup+','+
                QuotedStr(quModelModel.AsString)+','+
                QuotedStr(quModelDescription.AsString)+','+
                FormatFloat('0.00',quModelCustoPrice.AsCurrency)+','+
                FormatFloat('0.00',quModelSalePrice.AsCurrency)+')';

         RunSQL(sSQL);

         if Trim(quModelIDBarcode.AsString) <> '' then
            begin
            sSQL := 'INSERT Barcode (IDBarcode, IDModel, Data) VALUES ('+
                    QuotedStr(Trim(quModelIDBarcode.AsString))+','+IntToStr(iIDI)+',GetDate())';
            RunSQL(sSQL);
            end;

         Next;
         end;
       if Active then
          Close;

       RunSQL('UPDATE MP SET MP.IDModel = M.IDModel FROM Model M, '+
              'MODEL_IMPORT MP WHERE MP.Model = M.Model');

       end;
     Except
       on E: Exception do
          begin
          Result := False;
          with TFrmError.Create(Self) do
               Start(E.Message + ' ' + sModel);
          end;
       End;
   end;

   function InsertVendorCode:Boolean;
   begin
     Try
       Result := True;
       lbProgress.Caption := 'Creating Vendor Code. Please wait...';
       Application.ProcessMessages;

       with quVendorCode do
       begin
       if not Active then
          Open;
       First;
       pnlStatus.Visible := True;
       pb.Position       := 0;
       pb.Max            := quVendorCode.RecordCount;
       while not EOF do
         begin
         pb.Position := pb.Position + 1;
         Application.ProcessMessages;
         iIDI := GetNextID('VendorModelCode.IDVendorModelCode');

         sSQL := 'INSERT VendorModelCode (IDVendorModelCode, IDModel, IDPessoa, VendorCode) VALUES '+
                '('+IntToStr(iIDI)+','+quVendorCodeIDModel.AsString+','
                +quVendorCodeIDManufect.AsString+','+QuotedStr(quVendorCodeVendorCode.AsString)+')';

         RunSQL(sSQL);
         Next;
         end;
       if Active then
          Close;
       end;
     Except
       on E: Exception do
          begin
          Result := False;
          with TFrmError.Create(Self) do
               Start(E.Message);
          end;
       End;
   end;


   function InsertInvMov:Boolean;
   begin
     Try
       Result := True;
       lbProgress.Caption := 'Creating store quantities. Please wait...';
       Application.ProcessMessages;

       with quInventory do
       begin
       if not Active then
          Open;
       First;
       pnlStatus.Visible := True;
       pb.Position       := 0;
       pb.Max            := quInventory.RecordCount;

       while not EOF do
         begin
         pb.Position := pb.Position + 1;
         Application.ProcessMessages;

         iIDI := GetNextID('InventoryMov.IDInventoryMov');
         sSQL := 'INSERT InventoryMov (IDInventoryMov, InventMovTypeID, DocumentID, StoreID, ModelID, IDPessoa, MovDate, Qty, CostPrice, SalePrice, IDUser) '+
                 'VALUES ('+IntToStr(iIDI)+',5,'+QuotedStr('0')+', 1, '+quInventoryIDModel.AsString+', Null, GetDate(), '+quInventoryQty.AsString+
                 ', 0.00,'+', 0.00, 0 )';

         RunSQL(sSQL);
         Next;
         end;
       if Active then
          Close;
       end;
     Except
       on E: Exception do
          begin
          Result := False;
          with TFrmError.Create(Self) do
               Start(E.Message);
          end;
       End;
   end;


begin

   Screen.Cursor:= crHourGlass;
   pnlStatus.Visible := True;

   {
   CreatInv;
   if not FillTempTable then
      Exit;
   }

   try
      Error := True;

      //DBConnection.BeginTrans;

      {Error := not InsertSize;

      if not Error then
         Error := not InsertColor;
      if not Error then
         Error := not InsertFabricante;
      if not Error then
         Error := not InsertTabGroup;
      if not Error then
         Error := not InsertSubGroup;
      if not Error then
         Error := not InsertModel;
      if not Error then
         Error := not InsertVendorCode;
      //if not Error then
      //   Error := not InsertInvMov; }
   finally
     if Error then
        //DBConnection.RollbackTrans
     else
        begin
        //DBConnection.CommitTrans;
        MsgBox('Data imported.', vbInformation + vbOKOnly);
        end;
     //DropInv;
     Screen.Cursor:= crDefault;
     end;
end;

Procedure TAdvStringGrid.DeleteRow(ARow:LongInt);
Begin
 Inherited DeleteRow(ARow)
End;

Procedure TAdvStringGrid.DeleteColumn(AColumn:LongInt);
Begin
 Inherited DeleteColumn(AColumn)
End;

procedure TFrmImportDB.RefreshGridInfo;
begin
   lbRecords.Caption := IntToStr(sgFile.RowCount-1) + ' line(s)';
end;

procedure TFrmImportDB.BuildGrid;
var
  tFile : TextFile;
  sLine : String;
begin

  Screen.Cursor:= crHourGlass;

  try
    sgFile.Visible := False;
    AssignFile(tFile, edtFilePath.Text);
    Reset(tFile);

    //Row fixed Header
    sgFile.FixedRows := 1;
    sgFile.Rows[0].Text := 'Barcode'+#13+'Model'+#13+'Description'+#13+'Cost'+#13+'Sale'+#13+'Qty'+#13+'Category';

    While not eof(tFile) do
       begin
       readln(tFile, sLine);
       if Trim(sLine) <> '' then
          begin
          sLine := StringReplace(sLine, '"', '', [rfReplaceAll]);
          sLine := StringReplace(sLine, #13, '', [rfReplaceAll]);
          sgFile.Rows[sgFile.RowCount-1].Text := StringReplace(sLine, ',', #13, [rfReplaceAll]);
          sgFile.RowCount:= sgFile.RowCount+1;
          end;
       end;

    RefreshGridInfo;

  finally
     Screen.Cursor:= crDefault;
     CloseFile(tFile);
     sgFile.Visible := True;
     end;

end;

procedure TFrmImportDB.BuildResume;
begin
  memSummary.Clear;

  with memSummary.Lines do
  begin
    Add('Importing data');
    Add('===========================');
    if KeyType = KEY_TRIAL then
      Add('Trial version: The system will import 50 items only');

    Add('From file : ' + edtFilePath.Text);
    //Add('To Store : ' + scStore.Text);
    //Add('Tax Category : ' + scTaxCategory.Text);
    Add('Total lines : ' + IntToStr(sgFile.RowCount-1));
    Add('');
  end;
end;

procedure TFrmImportDB.SetNextPage;
var
  i, iStep: Integer;
  sColumn: String;
begin
  iStep := 1;

  case btnNext.Tag of
    0: begin
         if (Notebook.ActivePage = 'pgIntro') then
         begin
           //ValidateKey(edtKey.Text);
           if (DM.DBConnection.Connected) then
             iStep := 2;
           AddComboVendorList;
         end;

         if (Notebook.ActivePage = 'pgReadme') then
         begin
         end;

         if (Notebook.ActivePage = 'pgSelection') then
         begin
           if edtFilePath.Text = '' then
           begin
             MsgBox('Select a file!', vbInformation + vbOKOnly);
             edtFilePath.SetFocus;
             Exit;
           end;

           case fImportType of
             CATALOG_IMPORT: begin
                               if cbCatalogVendorList.Text = '' then
                               begin
                                 MsgBox('Inform a vendor!', vbInformation + vbOKOnly);
                                 cbCatalogVendorList.SetFocus;
                                 Exit;
                               end;
                               iVendor := ReturnVendorID(cbCatalogVendorList.Text);
                             end;

             PO_IMPORT: begin
                          if edPONumber.Text = '' then
                          begin
                            MsgBox('Inform a PO Number!', vbInformation + vbOKOnly);
                            edPONumber.SetFocus;
                            Exit;
                          end;

                          iStore          := cbxStore.EditValue;
                          iUser           := cbxUser.EditValue;
                          iVendor         := ReturnVendorID(cbPOVendorList.Text);
                          fPONumber       := edPONumber.Text;
                          fPurchaseNumber := edPurchaseNumber.Text;
                          fFreight        := edFreight.Text;
                          fOtherCost      := edOtherCost.Text;
                          fRecordDate     := dbRecordDate.Date;
                          fDueDate        := dbDueDate.Date;
                        end;

           end;

           if edtDelimiter.Text = '' then
             fDelimiter := #9
           else
             fDelimiter := edtDelimiter.Text[1];

           MountFileonGrid;

         end;

         if (Notebook.ActivePage = 'pgDatabase') then
         begin
           cbColumns.Visible := False;
           FillColumnsGrid;
         end;

         if (Notebook.ActivePage = 'pgCrossColumn') then
         begin
           GetColumnOrder;
           SaveModelCatalog;
           DM.quModelCatalogList.Open;
         end;
       end;

    1: begin
         DoFinal;
         Close;
       end;
  end;

  Notebook.PageIndex := Notebook.PageIndex + iStep;
end;

procedure TFrmImportDB.SetPriorPage;
var
  iStep : Integer;
begin

  iStep := 1; 

  Case btnBack.Tag of
      0 : begin
          if (Notebook.ActivePage = 'pgSelection') and (DM.DBConnection.Connected) then
              iStep := 2;

          if (Notebook.ActivePage = 'pgSummary') then
              iStep := 1;

          end;
  end;

  Notebook.PageIndex := Notebook.PageIndex - iStep;

end;

procedure TFrmImportDB.PageWelcome;
begin
  btnBack.Visible := False;
  btnNext.Tag     := 0;
  Notebook.Color  := clWhite;
end;

procedure TFrmImportDB.PageReadme;
begin
  btnBack.Visible := True;
  btnNext.Tag     := 0;
  Notebook.Color  := clBtnFace;
end;

procedure TFrmImportDB.PageSetting;
begin
  btnBack.Visible := True;
  btnNext.Tag     := 0;
  Notebook.Color  := clBtnFace;

  DMImport.OpenConnection;
  OpenStore;
  OpenUser;
  OpenVendor;
  AddComboVendorList;

end;

procedure TFrmImportDB.PageDatabase;
begin
  btnNext.Tag     := 0;
  Notebook.Color  := clBtnFace;
end;

procedure TFrmImportDB.PageLast;
begin
  btnNext.Tag    := 1;
  Notebook.Color := clWhite;
  BuildResume;
end;

procedure TFrmImportDB.sbOpenFileClick(Sender: TObject);
begin
  if OD.Execute then
     edtFilePath.Text := OD.FileName;
end;

procedure TFrmImportDB.SetCaptions;
begin

end;

procedure TFrmImportDB.MountFileonGrid;
var i,z,maxCol :Integer;
    FFileApoio  : TStringList;
    teste : String;
begin
  maxCol := 0;

  FFile          := TStringList.Create;
  FFileApoio     := TStringList.Create;
  FFileCabecalho := TStringList.Create;
  FComboList     := TStringList.Create;
  FOrder         := TStringList.Create;

  //Set o delimitador
  FFileApoio.Delimiter := fDelimiter;
  FFile.LoadFromFile(OD.FileName);

  sgFile.RowCount := FFile.Count;

  for i:=0 to sgFile.RowCount-1 do
    begin
    //FFileApoio.CommaText := FFile[i];
    FFileApoio.DelimitedText := FFile[i];

    if FFileApoio.Count > maxCol then
      maxCol := FFileApoio.Count;

    sgFile.ColCount := maxCol;

    for z:=0 to FFileApoio.Count-1 do
     begin
      sgFile.Cells[z,i] := FFileApoio[z];
      if i=0 then
       begin
        FComboList.Add(FFileApoio[z]);
        FFileCabecalho.Add(FFileApoio[z]);
       end;
     end;
    end;

    {
    DM.DCOMConn.Open;
    DM.DCOMConn.AppServer.ImportCatalogFile(FFile.Text, '');
    DM.DCOMConn.Close;
    }
    
    FreeAndNil(FFileApoio);
    lbRecords.Caption := IntTostr(i) + ' line(s)';

end;

procedure TFrmImportDB.FillColumnsGrid;
begin
  sgColumns.Cells[0,0] := 'Main Retail';
  sgColumns.Cells[1,0] := 'File';

  AddColumnsToImport;
  AddComboColumnsToImport;
end;

procedure TFrmImportDB.AddColumnsToImport;
var i: Integer;
begin

 // -AddColumnToGrid
 case fImportType of
   PO_IMPORT      : begin
                     AddColumnToGrid('BarCode',1);
                     AddColumnToGrid('Qty',2);
                     AddColumnToGrid('NewCostPrice',3);
                     AddColumnToGrid('NewSalePrice',4);
                     AddColumnToGrid('NewSuggRetail',5);
                     AddColumnToGrid('CostPrice',6);
                     AddColumnToGrid('FreightCost',7);
                     AddColumnToGrid('OtherCost',8);
                     AddColumnToGrid('QtyRet',9);
                     AddColumnToGrid('CostPriceRet',10);
                     AddColumnToGrid('FreightCostRet',11);
                     AddColumnToGrid('OtherCostRet',12);
                     AddColumnToGrid('NewCostPriceRet',13);
                     AddColumnToGrid('NewCostPriceResult',14);
                    end;

   CATALOG_IMPORT : begin
                     AddColumnToGrid('IDBarcode',1);
                     AddColumnToGrid('Model',2);
                     AddColumnToGrid('InvSize',3);
                     AddColumnToGrid('InvColor',4);
                     AddColumnToGrid('Description',5);
                     AddColumnToGrid('Manufacture',6);
                     AddColumnToGrid('TabGroup',7);
                     AddColumnToGrid('CustoPrice',8);
                     AddColumnToGrid('SalePrice',9);
                     AddColumnToGrid('VendorCode',10);
                     AddColumnToGrid('Qty',11);
                     AddColumnToGrid('SubGroup',12);
                     AddColumnToGrid('QtyMin',13);
                     AddColumnToGrid('QtyMax',14);
                    end;
  end;

end;

procedure TFrmImportDB.AddColumnToGrid(Field :String; Row:Integer);
begin
  sgColumns.Cells[0,Row] := Field;
end;

procedure TFrmImportDB.AddComboColumnsToImport;
var i: Integer;
begin
 for i:=0 to FComboList.Count-1 do
  cbColumns.Items.Add(FComboList[i]);
end;

procedure TFrmImportDB.sgColumnsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin

  //Somente na Coluna desejada
  if ((ACol = 1) AND (ARow <> 0)) then
  begin
   {Size and position the combo box to fit the cell}
    R := sgColumns.CellRect(ACol, ARow);
    R.Left := R.Left + sgColumns.Left;
    R.Right := R.Right + sgColumns.Left;
    R.Top := R.Top + sgColumns.Top;
    R.Bottom := R.Bottom + sgColumns.Top;
    cbColumns.Left := R.Left + 1;
    cbColumns.Top := R.Top + 1;
    cbColumns.Width := (R.Right + 1) - R.Left;
    cbColumns.Height := (R.Bottom + 1) - R.Top;
   {Show the combobox}
    cbColumns.Text := sgColumns.Cells[ACol, ARow];
    cbColumns.Visible := True;
    cbColumns.SetFocus;
  end;
  CanSelect := True;
end;

procedure TFrmImportDB.cbColumnsChange(Sender: TObject);
begin
 sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];

 cbColumns.Visible := False;
 sgColumns.SetFocus;
end;

procedure TFrmImportDB.cbColumnsExit(Sender: TObject);
begin
 sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];
 cbColumns.Visible := False;
 sgColumns.SetFocus;
end;

procedure TFrmImportDB.AddComboVendorList;
begin
  if cbPOVendorList.Items.Count = 0 then
    with DMImport.cdsLookupVendor do
      while not Eof do
      begin
        cbPOVendorList.Items.Add(FieldByName('Vendor').AsString);
        Next;
      end;
end;

function TFrmImportDB.ReturnVendorID(Vendor :String):Integer;
var sSQL : String;
begin
 DM.VendorFilteredID(Vendor);

 //Caso não existir o Vendor é criado um.
 if DM.quVendorFiltered.RecordCount=0 then
  begin
   sSQL := 'Insert into MRCatalogDB..Vendor (Vendor) Values ('+#39+Vendor+#39+')';
   DM.RunSQL(sSQL);
   DM.VendorFilteredID(Vendor);
  end;

 Result := DM.quVendorFilteredIDVendor.AsInteger;
end;

procedure TFrmImportDB.SaveModelCatalog;
var sSQL, FieldValue, MRField, FileField : String;
    i,x,z,IDModelCatalog, IDModel : Integer;
    IDSize,IDColor,IDManufect,IDTabGroup,IDSubGroup : String;
    IDBarcode,Model,InvSize,InvColor,Description,Manufacture,TabGroup,
    CustoPrice,SalePrice,VendorCode,Qty,SubGroup,QtyMin,QtyMax: String;
    FTeste : TStringList;

    procedure ClearVar;
     begin
     IDSize      := '';
     IDColor     := '';
     IDManufect  := '';
     IDTabGroup  := '';
     IDSubGroup  := '';
     IDBarcode   := '';
     Model       := '';
     InvSize     := '';
     InvColor    := '';
     Description := '';
     Manufacture := '';
     TabGroup    := '';
     CustoPrice  := '';
     SalePrice   := '';
     VendorCode  := '';
     Qty         := '';
     SubGroup    := '';
     QtyMin      := '';
     QtyMax      := '';
     IDSize     := 'NULL';
     IDColor    := 'NULL';
     IDManufect := 'NULL';
     IDTabGroup := 'NULL';
     IDSubGroup := 'NULL';
     end;
begin
  //FTeste := TStringList.Create;
  ClearVar;
  i := 1;
  while i<=sgFile.RowCount-1 do
   begin
    for x:=1 to NUMBER_MR_COLUMNS  do
     begin
      FieldValue := '';
      MRField   := MRNumberColumn(x);
      FileField := FOrder.Values[MRField];


      for z:=0 to sgFile.ColCount-1 do
       if sgFile.Cells[z,0] = FileField then
         FieldValue := sgFile.Cells[z,i];

      if FieldValue = '' then
       FieldValue := 'NULL';

      if MRField = 'IDBarcode' then
       IDBarcode := FieldValue
      else if MRField = 'Model' then
       Model := FieldValue
      else if MRField = 'InvSize' then
       InvSize := FieldValue
      else if MRField = 'InvColor' then
       InvColor := FieldValue
      else if MRField = 'Description' then
       Description := FieldValue
      else if MRField = 'Manufacture' then
       Manufacture := FieldValue
      else if MRField = 'TabGroup' then
       TabGroup := FieldValue
      else if MRField = 'CustoPrice' then
       begin
        if FieldValue = 'NULL' then
         FieldValue := '0.00';
        CustoPrice := FieldValue;
       end
      else if MRField = 'SalePrice' then
       begin
        if FieldValue = 'NULL' then
         FieldValue := '0.00';
        SalePrice := FieldValue;
       end
      else if MRField = 'VendorCode' then
       VendorCode := FieldValue
      else if MRField = 'Qty' then
        Qty := FieldValue
      else if MRField = 'SubGroup' then
       SubGroup := FieldValue
      else if MRField = 'QtyMin' then
        QtyMin := FieldValue
      else if MRField = 'QtyMax' then
        QtyMax := FieldValue;
     end;

     IDModel := DM.SelectIDModel(Description);
     IDModelCatalog := DM.SelectModelCatalog(IDModel,iVendor);

     if IDModelCatalog=0 then
      begin
      sSQL := 'insert into MRCatalogDB..Model_Catalog (IDModelCatalog,IDModel,IDVendor,IDSize,IDColor,IDManufect,'+
              'IDTabGroup,IDSubGroup,IDBarcode,Model,InvSize,InvColor,Description,Manufacture,TabGroup,CustoPrice,'+
              'SalePrice,VendorCode,Qty,SubGroup,QtyMin,QtyMax) '+

              'Values ('+InttoStr(DM.GetNextID('MRCatalogDB..MRCatalog'))+','+InttoStr(IDModel)+','+InttoStr(iVendor)+','+IDSize+','+IDColor+','+
              IDManufect+','+IDTabGroup+','+IDSubGroup+','+IDBarcode+','+QuotedStr(Model)+','+QuotedStr(InvSize)+','+QuotedStr(InvColor)+','+QuotedStr(Description)+','+QuotedStr(Manufacture)+','+
              QuotedStr(TabGroup)+','+CustoPrice+','+SalePrice+','+QuotedStr(VendorCode)+','+Qty+','+QuotedStr(SubGroup)+','+QtyMin+','+QtyMax+')';
      end
     else
      begin
      sSQL := 'update MRCatalogDB..Model_Catalog '+
              'set IDModel ='+InttoStr(IDModel)+' , IDVendor ='+InttoStr(iVendor)+' , IDSize ='+IDSize+' , IDColor ='+IDColor+' , IDManufect ='+IDManufect+
              ' , IDTabGroup ='+IDTabGroup+' , IDSubGroup ='+IDSubGroup+' , IDBarcode ='+IDBarcode+' , Model ='+QuotedStr(Model)+' , InvSize ='+QuotedStr(InvSize)+
              ' , InvColor ='+QuotedStr(InvColor)+' , Description ='+QuotedStr(Description)+' , Manufacture ='+QuotedStr(Manufacture)+' , TabGroup ='+QuotedStr(TabGroup)+' , CustoPrice ='+CustoPrice+
              ' , SalePrice ='+SalePrice+' , VendorCode ='+QuotedStr(VendorCode)+' , Qty ='+Qty+' , SubGroup ='+QuotedStr(SubGroup)+' , QtyMin ='+QtyMin+' , QtyMax ='+QtyMax+
              ' Where IDModelCatalog =' +InttoStr(IDModelCatalog);
      end;
     //FTeste.Add(sSQL);
     //FTeste.SaveToFile('C:\Teste.txt');
     DM.RunSQL(sSQL);

     ClearVar;
     inc(i);
   end;
   UpdateModelCatalog;
end;

procedure TFrmImportDB.GetColumnOrder;
var i: Integer;
    sColumn :String;
begin
 FOrder := TStringList.Create;
 for i:=1 to sgColumns.RowCount-1 do
 if Trim(sgColumns.Cells[1,i]) <> '' then
  if Pos(Trim(sgColumns.Cells[0,i]), sColumn) = 0 then
   begin
    sColumn := sgColumns.Cells[0,i]+'='+ sgColumns.Cells[1,i];
    FOrder.Add(sColumn);
   end;
end;

function TFrmImportDB.MRNumberColumn(Number :Integer):String;
var Column: String;
begin

 case Number of
   1  : Column := 'IDBarcode';
   2  : Column := 'Model';
   3  : Column := 'InvSize';
   4  : Column := 'InvColor';
   5  : Column := 'Description';
   6  : Column := 'Manufacture';
   7  : Column := 'TabGroup';
   8  : Column := 'CustoPrice';
   9  : Column := 'SalePrice';
   10 : Column := 'VendorCode';
   11 : Column := 'Qty';
   12 : Column := 'SubGroup';
   13 : Column := 'QtyMin';
   14 : Column := 'QtyMax';
  end;

 Result := Column;
end;

procedure TFrmImportDB.UpdateModelCatalog;
begin
  try
    DM.RunSQL('UPDATE Model_Catalog SET Model_Catalog.IDSize = S.IDSize FROM InvSize S, '+
             'MRCatalogDB..Model_Catalog Model_Catalog WHERE Model_Catalog.InvSize = S.SizeName');

    DM.RunSQL('UPDATE Model_Catalog SET Model_Catalog.IDColor = C.IDColor FROM InvColor C, '+
             'MRCatalogDB..Model_Catalog Model_Catalog WHERE Model_Catalog.InvColor = C.Color');

    DM.RunSQL('UPDATE Model_Catalog SET Model_Catalog.IDTabGroup = G.IDGroup FROM TabGroup G, '+
             'MRCatalogDB..Model_Catalog Model_Catalog WHERE Model_Catalog.TabGroup = G.Name');

    DM.RunSQL('UPDATE Model_Catalog SET Model_Catalog.IDSubGroup = S.IDSubGroup FROM SubGroup S, '+
             'MRCatalogDB..Model_Catalog Model_Catalog WHERE Model_Catalog.SubGroup = S.SubGroup');
  except
  end;
end;

procedure TFrmImportDB.cbArchiveTypeChange(Sender: TObject);
begin
 fImportType := cbArchiveType.ItemIndex;
 ConfigScreen;
end;

procedure TFrmImportDB.ConfigScreen;
begin
 case fImportType of
  PO_IMPORT      : begin
                    pnlCatalog.Visible := False;
                    pnlPO.Visible := True;
                    end;

   CATALOG_IMPORT : begin
                    pnlCatalog.Visible := True;
                    pnlPO.Visible := False;
                    end;
  end;
end;

procedure TFrmImportDB.OpenStore;
begin
  with DMImport.cdsLookupStore do
    if not Active then
      Open;
end;

procedure TFrmImportDB.CloseStore;
begin
  with DMImport.cdsLookupStore do
    if Active then
      Close;
end;

procedure TFrmImportDB.CloseUser;
begin
  with DMImport.cdsLookupUser do
    if Active then
      Close;
end;

procedure TFrmImportDB.OpenUser;
begin
  with DMImport.cdsLookupUser do
    if not Active then
      Open;
end;

procedure TFrmImportDB.CloseVendor;
begin
  with DMImport.cdsLookupVendor do
    if Active then
      Close;
end;

procedure TFrmImportDB.OpenVendor;
begin
  with DMImport.cdsLookupVendor do
    if not Active then
      Open;
end;

procedure TFrmImportDB.PrepareCatalogDB;
var
  LogError: String;
begin
  if DMImport.ImportConn.AppServer.PrepareCatalogDB(LogError) then
    ShowMessage(LogError);
end;

end.
