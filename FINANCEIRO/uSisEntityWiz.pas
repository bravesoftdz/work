unit uSisEntityWiz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentWizard, StdCtrls, ExtCtrls, ComCtrls, dxtree, ImgList, Buttons,
  uQuickBooks, Grids, Db, ADODB, uRegistry, dxDBTLCl, dxGrClms, dxTL,
  dxDBCtrl, dxDBGrid, dxCntner, dxDBCGrid, uPeachTRee, Mask, SuperComboADO,
  siComp, siLangRT;

const
   SOFTWARE_QUICKEN    = 0;
   SOFTWARE_QUICKBOOKS = 1;
   SOFTWARE_PEACHTREE  = 2;

   ENTITY_VENDOR       = 0;
   ENTITY_CUSTOMER     = 1;
   ENTITY_EMPLOYEE     = 2;

   COLUMN_ID           = 0;
   COLUMN_OTHER_ACC    = 1;
   COLUMN_OFFICEM      = 2;


type
  TSisEntityWiz = class(TParentWizard)
    tsOption: TTabSheet;
    tsSoftwareList: TTabSheet;
    tsFileType: TTabSheet;
    Label20: TLabel;
    treeSoftware: TdxTreeView;
    lbSoftware: TLabel;
    rgOperation: TRadioGroup;
    Label1: TLabel;
    cbxFileType: TComboBox;
    Label2: TLabel;
    lbDirOption: TLabel;
    edtPath: TEdit;
    sbOpenFile: TSpeedButton;
    SD: TSaveDialog;
    Label3: TLabel;
    tsImport: TTabSheet;
    tsExport: TTabSheet;
    tsColumns: TTabSheet;
    tsFinish: TTabSheet;
    gridImport: TStringGrid;
    lbGridInfo: TLabel;
    sgColumns: TStringGrid;
    cbColumns: TComboBox;
    lbTotalColumns: TLabel;
    lbColumnInfo: TLabel;
    cbxNonDublicated: TCheckBox;
    quTestEntity: TADOQuery;
    Label37: TLabel;
    Label29: TLabel;
    memSummary: TMemo;
    pnlImport: TPanel;
    Label4: TLabel;
    pb: TProgressBar;
    dsPessoa: TDataSource;
    dxDBCGrid1: TdxDBCGrid;
    dxDBCGrid1EntityFullName: TdxDBGridMaskColumn;
    dxDBCGrid1Address: TdxDBGridMaskColumn;
    dxDBCGrid1DBA: TdxDBGridMaskColumn;
    dxDBCGrid1City: TdxDBGridMaskColumn;
    dxDBCGrid1Zip: TdxDBGridMaskColumn;
    dxDBCGrid1Country: TdxDBGridMaskColumn;
    dxDBCGrid1Phone: TdxDBGridMaskColumn;
    dxDBCGrid1CellPhone: TdxDBGridMaskColumn;
    dxDBCGrid1Fax: TdxDBGridMaskColumn;
    dxDBCGrid1Contact: TdxDBGridMaskColumn;
    dxDBCGrid1BirthDay: TdxDBGridDateColumn;
    dxDBCGrid1SocialSecurity: TdxDBGridMaskColumn;
    dxDBCGrid1FederalID: TdxDBGridMaskColumn;
    dxDBCGrid1SalesTax: TdxDBGridMaskColumn;
    dxDBCGrid1CompanyContact: TdxDBGridMaskColumn;
    dxDBCGrid1DriveLicence: TdxDBGridMaskColumn;
    dxDBCGrid1LastName: TdxDBGridMaskColumn;
    dxDBCGrid1FirstName: TdxDBGridMaskColumn;
    dxDBCGrid1HorsPerWeek: TdxDBGridMaskColumn;
    dxDBCGrid1HourValue: TdxDBGridCurrencyColumn;
    dxDBCGrid1OverHourValue: TdxDBGridCurrencyColumn;
    dxDBCGrid1DoubleHourValue: TdxDBGridCurrencyColumn;
    dxDBCGrid1CustomerCard: TdxDBGridMaskColumn;
    dxDBCGrid1Code: TdxDBGridMaskColumn;
    dxDBCGrid1HomePage: TdxDBGridMaskColumn;
    dxDBCGrid1Email: TdxDBGridMaskColumn;
    dxDBCGrid1OBS: TdxDBGridMaskColumn;
    dxDBCGrid1IDTipoPessoa: TdxDBGridMaskColumn;
    dxDBCGrid1IDStore: TdxDBGridMaskColumn;
    dxDBCGrid1IDTipoPessoaRoot: TdxDBGridMaskColumn;
    dxDBCGrid1IDUser: TdxDBGridMaskColumn;
    dxDBCGrid1IDPessoa: TdxDBGridMaskColumn;
    quPessoa: TADODataSet;
    quPessoaIDPessoa: TAutoIncField;
    quPessoaIDTipoPessoa: TIntegerField;
    quPessoaIDStore: TIntegerField;
    quPessoaIDTipoPessoaRoot: TIntegerField;
    quPessoaIDUser: TIntegerField;
    quPessoaEntityFullName: TStringField;
    quPessoaAddress: TStringField;
    quPessoaDBA: TStringField;
    quPessoaCity: TStringField;
    quPessoaZip: TStringField;
    quPessoaCountry: TStringField;
    quPessoaPhone: TStringField;
    quPessoaCellPhone: TStringField;
    quPessoaFax: TStringField;
    quPessoaContact: TStringField;
    quPessoaType: TBooleanField;
    quPessoaBirthDay: TDateTimeField;
    quPessoaSocialSecurity: TStringField;
    quPessoaFederalID: TStringField;
    quPessoaSalesTax: TStringField;
    quPessoaCompanyContact: TStringField;
    quPessoaDriveLicence: TStringField;
    quPessoaLastName: TStringField;
    quPessoaFirstName: TStringField;
    quPessoaHorsPerWeek: TIntegerField;
    quPessoaHourValue: TBCDField;
    quPessoaOverHourValue: TBCDField;
    quPessoaDoubleHourValue: TBCDField;
    quPessoaCustomerCard: TStringField;
    quPessoaCode: TIntegerField;
    quPessoaHomePage: TStringField;
    quPessoaEmail: TStringField;
    quPessoaOBS: TStringField;
    lbTip: TLabel;
    pnlExpOpt: TPanel;
    Label5: TLabel;
    pnlSummary: TPanel;
    lbExportLines: TLabel;
    scChartAcc: TSuperComboADO;
    Label6: TLabel;
    procedure rgOperationClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure treeSoftwareClick(Sender: TObject);
    procedure sbOpenFileClick(Sender: TObject);
    procedure sgColumnsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cbColumnsChange(Sender: TObject);
    procedure cbColumnsExit(Sender: TObject);
    procedure quPessoaNewRecord(DataSet: TDataSet);
    procedure cbxFileTypeChange(Sender: TObject);
    procedure dxDBCGrid1RefreshNodeData(Sender: TObject;
      Node: TdxTreeListNode);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    //Translation
    sImporting,
    sExporting,
    sDelDuplic,
    sNoDelDuplic,
    sFileType,
    sFilePath,
    sTotalRows,
    sColVailable,
    sLines,
    sCol,
    sQuickBooks,
    sPeachTree1,
    sPeachTree2,
    sRecords : String;


    iTotalRowsImported : Integer;
    iSoftware          : integer;
    iEntityType        : integer;
    sIDChartAcc        : String;
    FQuickBooks        : TQuickBooks;
    FPeachTree         : TPeachTree;
    FRegistry          : TWinRegistry;

    procedure OpenPessoa;
    procedure ClosePessoa;

    procedure ImportSelected;
    procedure ExportSelected;
    procedure SetupSoftwareInfo;

    procedure AddQuickBooksColumnsToImportExport;
    procedure ImportQuickBooksFile;
    procedure FillQuickBooksColumnsGrid;

    procedure ImportPeachTreeFile;
    procedure AddPeachTreeColumnsToImportExport;
    procedure FillPeachTreeColumnsGrid;

    function BuildSQLImport:Integer;
    function BuildQuickBooksExportFile:Integer;
    function BuildPeachTreeExportFile:Integer;

    procedure FillImportGrid;
    procedure FillExportGrid;
    procedure FillColumnGrid;
    procedure FillIDChartAcc;
    procedure SaveGridColumn;
    procedure GetGridColumn;

    procedure SaveToRegistry(sValue:String);
    function GetFromRegistry:String;

    procedure BuildSummary;
    procedure SetStatusPanel(Max:Integer);
    function EntityExist(sEntity:String):Boolean;
    function HasValidHeader:Boolean;
  protected
    procedure OnAfterDoFinish; override;
    procedure OnBeforeBackClick; override;
    function TestBeforeNavigate:Boolean; override;
    function DoFinish:Integer; override;
    function OnAfterChangePage:Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses uMsgBox, uDM, uSisSenha, uNumericFunctions, uParamFunctions, uMsgConstant,
     uDMGlobal, uOperationSystem;

{$R *.DFM}

procedure TSisEntityWiz.FillIDChartAcc;
begin

  //Must have a Chart of Account Cod for peach Tree
  if (scChartAcc.LookUpValue = '') then
     exit;

  with DM.quFreeSQL do
     begin
     if Active then
        Close;
     SQL.Clear;
     SQL.Add('Select CodigoContabil From Fin_LancamentoTipo Where IDLancamentoTipo = ' + scChartAcc.LookUpValue);
     Open;
     sIDChartAcc := FieldByName('CodigoContabil').AsString;
     Close;
     end;

end;

procedure TSisEntityWiz.OnAfterDoFinish;
begin

  Case rgOperation.ItemIndex of
     0 : MsgBox(IntToStr(iTotalRowsImported) + MSG_INF_PART_ROWS_IMPORTED, vbInformation + vbOKOnly);
     1 : MsgBox(MSG_INF_PART_FILE_CREATED_AT + edtPath.Text, vbInformation + vbOKOnly);
     end;

end;

procedure TSisEntityWiz.BuildSummary;
var
  sType, sSoftware, Duplicate : String;
  iTotal : Integer;
begin

  Case rgOperation.ItemIndex of
     0 : begin
         sType  := sImporting;
         iTotal := gridImport.RowCount-1;
         end;
     1 : begin
         sType  := sExporting;
         iTotal := quPessoa.RecordCount;
         end;
     end;


  case iSoftware of
     SOFTWARE_QUICKEN    : sSoftware := ' Quicken Interchange Format (QIF)';
     SOFTWARE_QUICKBOOKS : sSoftware := ' QuickBooks Format (IIF)';
     SOFTWARE_PEACHTREE  : sSoftware := ' PeachTree Format (CSV)';
     end;

  if cbxNonDublicated.Visible then
     if cbxNonDublicated.Checked then
        Duplicate := sDelDuplic
     else
        Duplicate := sNoDelDuplic;

  memSummary.Clear;
  memSummary.Lines.Add(sType + sSoftware);
  memSummary.Lines.Add('=================================');
  memSummary.Lines.Add(sFileType  + cbxFileType.Text);
  memSummary.Lines.Add(sFilePath  + edtPath.Text);
  memSummary.Lines.Add(sTotalRows + IntToStr(iTotal));
  memSummary.Lines.Add(Duplicate);


end;

procedure TSisEntityWiz.SaveGridColumn;
var
  sColumn : String;
  i : integer;
begin

  sColumn := GetFromRegistry;

  for i:=1 to sgColumns.RowCount-1 do
      if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then
         if Pos(Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]), sColumn) = 0 then
            sColumn := sColumn + sgColumns.Cells[COLUMN_OTHER_ACC,i]+'='+
                                 sgColumns.Cells[COLUMN_OFFICEM,i]+';';

  if sColumn = '' then
     Exit;

  SaveToRegistry(sColumn);

end;

procedure TSisEntityWiz.GetGridColumn;
var
  sColumn : String;
  sResult : String;
  i : integer;
begin
   sColumn := GetFromRegistry;

  if sColumn = '' then
     Exit;

  for i:=1 to sgColumns.RowCount-1 do
      begin
      sResult := ParseParam(sColumn, Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]));
      if sResult <> '' then
         sgColumns.Cells[COLUMN_OFFICEM,i] := sResult;
      end;
end;

function TSisEntityWiz.GetFromRegistry:String;
var
  buildInfo: String;
begin
  if not Assigned(FRegistry) then
     FRegistry := TWinRegistry.Create;


  with FRegistry.StringRegistry do
      begin

        if ( getOS(buildInfo) = osW7 ) then
           Rookkey := HKEY_CURRENT_USER
        else
           RookKey := HKEY_LOCAL_MACHINE;

      OpenKey := 'SOFTWARE\AppleNet\OfficeManager';
      Key     := 'ImportColumn'+ IntToStr(iSoftware);
      Result  := GetStringRegistry; 
      end;

end;

procedure TSisEntityWiz.SaveToRegistry(sValue:String);
var
  buildInfo: String;
begin

  if not Assigned(FRegistry) then
     FRegistry := TWinRegistry.Create;

  with FRegistry.StringRegistry do
      begin

      if ( getOS(buildInfo) = osW7 ) then
         RookKey:= HKEY_CURRENT_USER
      else
         RookKey := HKEY_LOCAL_MACHINE;

      OpenKey := 'SOFTWARE\AppleNet\OfficeManager';
      Key     := 'ImportColumn'+ IntToStr(iSoftware);
      SaveStringRegistry(sValue);
      end;

end;

procedure TSisEntityWiz.OpenPessoa;
begin

  with quPessoa do
    if not Active then
       Open;

end;

procedure TSisEntityWiz.ClosePessoa;
begin

  with quPessoa do
    if Active then
       Close;

end;

procedure TSisEntityWiz.SetStatusPanel(Max:Integer);
begin


  iTotalRowsImported := 0;
  pb.Position        := 0;
  pb.Max             := Max;
  pnlImport.Visible  := True;

  Application.ProcessMessages; 

end;

function TSisEntityWiz.BuildPeachTreeExportFile:Integer;
var
  myField : TField;
  MyType  : TPeachTreeFileType;
  i       : integer;
  ID, Name, IDChartAcc, Addre1, Addre2, City, State, Zip, Contact1, Phone1,
  Phone2, Fax, Email, WebSite, Country, SocialSec, BirthDay, Notes : String;
  sValue : String;

  procedure ClearFields;
  begin
    ID         := '';
    Name       := '';
    IDChartAcc := '';
    Addre1     := '';
    Addre2     := '';
    City       := '';
    State      := '';
    Zip        := '';
    Contact1   := '';
    Phone1     := '';
    phone2     := '';
    Fax        := '';
    Email      := '';
    WebSite    := '';
    Country    := '';
    SocialSec  := '';
    BirthDay   := '';
    Notes      := '';
  end;

begin

  Result := -1;

  if not Assigned(FPeachTree) then
     FPeachTree := FPeachTree.Create;

  Case iEntityType of
     0 : MyType := PT_FILE_TYPE_VENDOR;
     1 : MyType := PT_FILE_TYPE_CUSTOMER;
     2 : MyType := PT_FILE_TYPE_SALES_PERSON;
  end;

  SetStatusPanel(quPessoa.RecordCount-1);

  quPessoa.First;
   
  While not quPessoa.Eof do
     begin

     //Vejo todas as colunas marcadas
     for i:=1 to sgColumns.RowCount-1 do
        if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then //Office Manager columns for selecionado
           begin

           //Localize field
           myField := quPessoa.FindField(Trim(sgColumns.Cells[COLUMN_OFFICEM,i]));

           if myField <> nil then
              begin
              sValue := Trim(myField.AsString);

              sValue := StringReplace(sValue, ',', ' ', [rfReplaceAll]);

              if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_EMPLOYEE_NAME]) or
                 (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_NAME]) or
                 (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_VENDOR_NAME]) then
                  Name := Name + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_ADDRESS_1]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_BILL_ADDRESS_1]) then
                      Addre1 := Addre1 + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_ADDRESS_2]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_BILL_ADDRESS_2]) then
                      Addre2 := Addre2 + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CITY]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_BILL_CITY]) then
                      City := City + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_STATE]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_BILL_STATE]) then
                      State := State + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_ZIP]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_BILL_ZIP]) then
                      Zip := Zip + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CONTACT]) then
                      Contact1 := Contact1 + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_EMPLOYEE_PHONE]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_PHONE_1]) then
                      Phone1 := Phone1 + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_PHONE_2]) then
                      phone2 := phone2 + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_FAX]) then
                      Fax := Fax + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_EMPLOYEE_EMAIL]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_EMAIL]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_VENDOR_EMAIL]) then
                      Email := Email + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_VENDOR_WEBSITE]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_WEBSITE]) then
                      WebSite := WebSite + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_COUNTRY]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_CUSTOMER_BILL_COUNTRY]) then
                      Country := Country + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_EMPLOYEE_SS]) then
                      SocialSec := SocialSec + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_EMPLOYEE_BIRTHDAY]) then
                      BirthDay := BirthDay + sValue
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = APeachTreeEntityColumns[PT_COL_ENTITY_EMPLOYEE_NOTES]) then
                      Notes := Notes + sValue;
              end;
           end;

     ID := quPessoaCode.AsString;
     IDChartAcc := sIDChartAcc;
     
     FPeachTree.AddEntity(MyType, ID, Name, IDChartAcc, Addre1, Addre2, City, State,
                          Zip, Contact1, Phone1, Phone2, Fax, Email, WebSite, Country,
                          SocialSec, Birthday, Notes);
     ClearFields;
     Inc(iTotalRowsImported);
     quPessoa.Next;
     end;

     pnlImport.Visible  := False;

     //SaveData to File
     FPeachTree.SaveDataToFile(edtPath.Text);

end;


function TSisEntityWiz.BuildQuickBooksExportFile:Integer;
var
  myField : TField;
  MyType  : TQuickBooksFileType;
  i       : integer;
  Name, Addre1, Addre2, Addre3, Addre4, Addre5, Phone1, phone2, Fax, Email,
  Contact1, Contact2, Notes, Company, FName, MName, LName : String;


  procedure ClearFields;
  begin
    Name     := '';
    Addre1   := '';
    Addre2   := '';
    Addre3   := '';
    Addre4   := '';
    Addre5   := '';
    Phone1   := '';
    phone2   := '';
    Fax      := '';
    Email    := '';
    Contact1 := '';
    Contact2 := '';
    Notes    := '';
    Company  := '';
    FName    := '';
    MName    := '';
    LName    := '';
  end;

begin

  Result := -1;

  if not Assigned(FQuickBooks) then
     FQuickBooks := TQuickBooks.Create;

  Case iEntityType of
     0 : MyType := QB_FILE_TYPE_VENDOR;
     1 : MyType := QB_FILE_TYPE_CUSTOMER;
     2 : MyType := QB_FILE_TYPE_SALES_PERSON;
  end;

  SetStatusPanel(quPessoa.RecordCount-1);

  quPessoa.First;
   
  While not quPessoa.Eof do
     begin

     //Vejo todas as colunas marcadas
     for i:=1 to sgColumns.RowCount-1 do
        if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then //Office Manager columns for selecionado
           begin

           //Localize field
           myField := quPessoa.FindField(Trim(sgColumns.Cells[COLUMN_OFFICEM,i]));
           
           if myField <> nil then
              begin
              if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_NAME]) then
                 Name := Name + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_ADDRESS_1]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_CUSTOMER_ADDRESS_1]) then
                 Addre1 := Addre1 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_ADDRESS_2]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_CUSTOMER_ADDRESS_2]) then
                 Addre2 := Addre2 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_ADDRESS_3]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_CUSTOMER_ADDRESS_3]) then
                 Addre3 := Addre3 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_ADDRESS_4]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_CUSTOMER_ADDRESS_4]) then
                 Addre4 := Addre4 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_ADDRESS_5]) or
                      (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_CUSTOMER_ADDRESS_5]) then
                 Addre5 := Addre5 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_PHONE_1]) then
                 Phone1 := Phone1 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_PHONE_2]) then
                 Phone2 := Phone2 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_FAX]) then
                 Fax := Fax + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_EMAIL]) then
                 Email := Email + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_CONTACT_1]) then
                 Contact1 := Contact1 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_CONTACT_2]) then
                 Contact2 := Contact2 + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_NOTEPAD]) then
                 Notes := Notes + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_COMPANY]) then
                 Company := Company + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_FIRSTNAME]) then
                 FName := FName + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_MID_INIT]) then
                 MName := MName + Trim(myField.AsString)
              else if (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = AQuickBooksEntityColumns[QB_COL_ENTITY_LASTNAME]) then
                 LName := LName + Trim(myField.AsString);
              end;
           end;

     FQuickBooks.AddEntity(MyType, Name, Addre1, Addre2, Addre3, Addre4, Addre5,
                           Phone1, phone2, Fax, Email, Contact1, Contact2, Notes,
                           Company, FName, MName, LName);
     ClearFields;
     Inc(iTotalRowsImported);
     quPessoa.Next;
     end;

     pnlImport.Visible  := False;

     //SaveData to File
     FQuickBooks.SaveDataToFile(edtPath.Text);

end;

function TSisEntityWiz.BuildSQLImport:Integer;
var
  i,j, col : integer;
  myField : TField;
  HadBreak : Boolean;
begin

  Result := -1;

  SetStatusPanel(gridImport.RowCount-1);

  OpenPessoa;

  for j:=1 to gridImport.RowCount-1 do
     begin

     pb.Position := j;

     quPessoa.Append;

     //Vejo todas as colunas marcadas
     for i:=1 to sgColumns.RowCount-1 do
        if Trim(sgColumns.Cells[COLUMN_OFFICEM,i]) <> '' then //Office Manager columns for selecionado
            begin
            HadBreak := False;

            //Coluna do grid Import
            col := MyStrToInt(sgColumns.Cells[COLUMN_ID,i]);

            //Se for para incluir no duplicado
            if (cbxNonDublicated.Checked) and (Trim(sgColumns.Cells[COLUMN_OTHER_ACC,i]) = 'NAME') then
               if EntityExist(gridImport.Cells[col, j]) then
                  begin
                  HadBreak := True;
                  Break;
                  end;

            myField := quPessoa.FindField(Trim(sgColumns.Cells[COLUMN_OFFICEM,i]));

            if myField <> nil then
               myField.AsString := myField.AsString + gridImport.Cells[col, j];
            end;
           
     try
       if not HadBreak then
          begin
          quPessoa.Post;
          Inc(iTotalRowsImported);
          end
       else
          quPessoa.Cancel;
     except
       pnlImport.Visible := False;
       Result := 1;
       MsgBox(MSG_CRT_PART_INSERT_REC_NUM + intToStr(j), vbCritical + vbOKOnly);
       end;
     end;
     
   pnlImport.Visible := False;

end;


function TSisEntityWiz.HasValidHeader:Boolean;
var
  i : integer;
begin

  //Verify if the column to import has an valida header
  Result := False;
  for i:=1 to sgColumns.RowCount-1 do
      if MyStrToInt(sgColumns.Cells[COLUMN_ID,i]) <> 0 then
         begin
         Result := True;
         Break;
         end;
end;

function TSisEntityWiz.EntityExist(sEntity:String):Boolean;
var
  iTipoPessoa : Integer;
begin

  Case iEntityType of
   ENTITY_VENDOR   : iTipoPessoa := 2;
   ENTITY_CUSTOMER : iTipoPessoa := 1;
   ENTITY_EMPLOYEE : iTipoPessoa := 4;
  end;


  with quTestEntity do
     begin
     if Active then
        Close;
     Parameters.ParamByName('PessoaName').Value := sEntity;
     Parameters.ParamByName('IDTipoPessoa').Value := iTipoPessoa;
     Open;
     Result := not IsEmpty;
     Close;
     end;

end;

procedure TSisEntityWiz.OnBeforeBackClick;
begin
  if pgOption.ActivePage.Name = 'tsColumns' then
     begin
     SaveGridColumn;
     end

end;

function TSisEntityWiz.OnAfterChangePage:Boolean;
begin
  if pgOption.ActivePage.Name = 'tsFileType' then
     begin
     SetupSoftwareInfo;
     end
  else if pgOption.ActivePage.Name = 'tsImport' then
     begin
     FillImportGrid;
     end
  else if pgOption.ActivePage.Name = 'tsExport' then
     begin
     FillExportGrid;
     end
  else if pgOption.ActivePage.Name = 'tsColumns' then
     begin
     FillColumnGrid;
     //Fill system columns from Registry
     GetGridColumn;
     cbxNonDublicated.Visible := (rgOperation.ItemIndex=0);
     //Peach Tree Only
     FillIDChartAcc;
     end
  else if pgOption.ActivePage.Name = 'tsFinish' then
     begin
     BuildSummary;
     end;

end;

procedure TSisEntityWiz.FillPeachTreeColumnsGrid;
begin

  if not Assigned(FPeachTree) then
     FPeachTree := TPeachTree.Create;

  AddPeachTreeColumnsToImportExport;

  Case rgOperation.ItemIndex of
       0 : FPeachTree.GetColumnsToImport(sgColumns, gridImport);
       1 : FPeachTree.GetColumnsToImport(sgColumns, nil);
  end;

  sgColumns.Cells[COLUMN_ID,0]        := 'Col';
  sgColumns.Cells[COLUMN_OTHER_ACC,0] := 'PeachTree';
  sgColumns.Cells[COLUMN_OFFICEM,0]   := 'Office Manager';

  lbTotalColumns.Caption := IntToStr(sgColumns.RowCount-1) + sColVailable;

end;

procedure TSisEntityWiz.FillQuickBooksColumnsGrid;
begin

  if not Assigned(FQuickBooks) then
     FQuickBooks := TQuickBooks.Create;

  AddQuickBooksColumnsToImportExport;

  Case rgOperation.ItemIndex of
       0 : FQuickBooks.GetColumnsToImport(sgColumns, gridImport);
       1 : FQuickBooks.GetColumnsToImport(sgColumns, nil);
  end;

  sgColumns.Cells[COLUMN_ID,0]        := 'Col';
  sgColumns.Cells[COLUMN_OTHER_ACC,0] := 'QuickBooks';
  sgColumns.Cells[COLUMN_OFFICEM,0]   := 'Office Manager';

  lbTotalColumns.Caption := IntToStr(sgColumns.RowCount-1) + sColVailable;

end;

procedure TSisEntityWiz.FillColumnGrid;
var
  i : integer;
begin

     //System Columns
     if cbColumns.Items.Count <> quPessoa.FieldCount then
        begin
        cbColumns.Clear;
        cbColumns.Items.Add('');

        for i:=0 to quPessoa.FieldCount-1 do
           if quPessoa.Fields.Fields[i].Visible then
              cbColumns.Items.Add(quPessoa.Fields.Fields[i].FieldName);
        end;

     case iSoftware of
        SOFTWARE_QUICKBOOKS: FillQuickBooksColumnsGrid;
        SOFTWARE_PEACHTREE: FillPeachTreeColumnsGrid;
        end;

end;

procedure TSisEntityWiz.FillExportGrid;
begin

  ClosePessoa;

  Case iEntityType of

   ENTITY_VENDOR   : quPessoa.Parameters.ParamByName('IDPessoaTipo').Value := 2;
   ENTITY_CUSTOMER : quPessoa.Parameters.ParamByName('IDPessoaTipo').Value := 1;
   ENTITY_EMPLOYEE : quPessoa.Parameters.ParamByName('IDPessoaTipo').Value := 4;
  end;

  OpenPessoa;

  //Peach Tree only
  pnlExpOpt.Visible := (rgOperation.ItemIndex=1) and
                       (iSoftware = SOFTWARE_PEACHTREE) and
                       (iEntityType in [ENTITY_VENDOR, ENTITY_CUSTOMER]);

  if pnlExpOpt.Visible then
     Case iEntityType of
          ENTITY_VENDOR   : scChartAcc.SpcWhereClause := 'Pagando=1';
          ENTITY_CUSTOMER : scChartAcc.SpcWhereClause := 'Pagando=0';
     end;

end;

procedure TSisEntityWiz.FillImportGrid;
begin

     case iSoftware of
        SOFTWARE_QUICKBOOKS:ImportQuickBooksFile;
        SOFTWARE_PEACHTREE:ImportPeachTreeFile;
        end;

end;

procedure TSisEntityWiz.SetupSoftwareInfo;
begin
  case iSoftware of
       SOFTWARE_QUICKEN :
           begin
           SD.Filter := 'Quicken Interchange Format|*.QIF|All file|*.*';
           end;

       SOFTWARE_QUICKBOOKS :
           begin
           SD.Filter := 'QuickBooks Format|*.IIF|All file|*.*';
           end;

       SOFTWARE_PEACHTREE :
           begin
           SD.Filter := 'PeachTree Format|*.CSV|All file|*.*';
           end;
  end;

end;

procedure TSisEntityWiz.AddPeachTreeColumnsToImportExport;
begin
  if not Assigned(FPeachTree) then
     FPeachTree := TPeachTree.Create;

  with FPeachTree do
     begin

     ClearColumnsToImport;
      
      case iEntityType of

       ENTITY_VENDOR :
              begin
              //AddColumnToImport(PT_COL_ENTITY_VENDOR_ID);
              AddColumnToImport(PT_COL_ENTITY_VENDOR_NAME);
              AddColumnToImport(PT_COL_ENTITY_VENDOR_EMAIL);
              AddColumnToImport(PT_COL_ENTITY_VENDOR_WEBSITE);
              AddColumnToImport(PT_COL_ENTITY_ADDRESS_1);
              AddColumnToImport(PT_COL_ENTITY_ADDRESS_2);
              //AddColumnToImport(PT_COL_ENTITY_VENDOR_GENERAL_LED_ID);
              AddColumnToImport(PT_COL_ENTITY_CITY);
              AddColumnToImport(PT_COL_ENTITY_STATE);
              AddColumnToImport(PT_COL_ENTITY_ZIP);
              AddColumnToImport(PT_COL_ENTITY_COUNTRY);
              AddColumnToImport(PT_COL_ENTITY_PHONE_1);
              AddColumnToImport(PT_COL_ENTITY_PHONE_2);
              AddColumnToImport(PT_COL_ENTITY_FAX);
              AddColumnToImport(PT_COL_ENTITY_CONTACT);
              end;

       ENTITY_EMPLOYEE :
              begin
              //AddColumnToImport(PT_COL_ENTITY_EMPLOYEE_ID);
              AddColumnToImport(PT_COL_ENTITY_EMPLOYEE_NAME);
              AddColumnToImport(PT_COL_ENTITY_ADDRESS_1);
              AddColumnToImport(PT_COL_ENTITY_ADDRESS_2);
              AddColumnToImport(PT_COL_ENTITY_CITY);
              AddColumnToImport(PT_COL_ENTITY_STATE);
              AddColumnToImport(PT_COL_ENTITY_ZIP);
              AddColumnToImport(PT_COL_ENTITY_COUNTRY);
              AddColumnToImport(PT_COL_ENTITY_EMPLOYEE_SS);
              AddColumnToImport(PT_COL_ENTITY_EMPLOYEE_PHONE);
              AddColumnToImport(PT_COL_ENTITY_EMPLOYEE_EMAIL);
              //AddColumnToImport(PT_COL_ENTITY_EMPLOYEE_BIRTHDAY);
              //AddColumnToImport(PT_COL_ENTITY_EMPLOYEE_NOTES);
              end;

       ENTITY_CUSTOMER :
              begin
              //AddColumnToImport(PT_COL_ENTITY_CUSTOMER_ID);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_NAME);
              AddColumnToImport(PT_COL_ENTITY_CONTACT);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_BILL_ADDRESS_1);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_BILL_ADDRESS_2);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_BILL_CITY);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_BILL_STATE);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_BILL_ZIP);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_BILL_COUNTRY);
              AddColumnToImport(PT_COL_ENTITY_PHONE_1);
              AddColumnToImport(PT_COL_ENTITY_PHONE_2);
              AddColumnToImport(PT_COL_ENTITY_FAX);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_EMAIL);
              //AddColumnToImport(PT_COL_ENTITY_CUSTOMER_GENERAL_LED_ID);
              AddColumnToImport(PT_COL_ENTITY_CUSTOMER_WEBSITE);
              end;

       end;


     end;

end;

procedure TSisEntityWiz.AddQuickBooksColumnsToImportExport;
begin

  if not Assigned(FQuickBooks) then
     FQuickBooks := TQuickBooks.Create;

  FQuickBooks.ClearColumnsToImport;

  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_NAME);

  case iEntityType of

   ENTITY_VENDOR,
   ENTITY_EMPLOYEE :
          begin
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_ADDRESS_1);
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_ADDRESS_2);
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_ADDRESS_3);
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_ADDRESS_4);
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_ADDRESS_5);
          end;

   ENTITY_CUSTOMER :
          begin
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_CUSTOMER_ADDRESS_1);
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_CUSTOMER_ADDRESS_2);
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_CUSTOMER_ADDRESS_3);
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_CUSTOMER_ADDRESS_4);
          FQuickBooks.AddColumnToImport(QB_COL_ENTITY_CUSTOMER_ADDRESS_5);
          end;

   end;

  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_PHONE_1);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_PHONE_2);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_FAX);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_EMAIL);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_CONTACT_1);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_CONTACT_2);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_NOTEPAD);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_SALUTION);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_COMPANY);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_FIRSTNAME);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_MID_INIT);
  FQuickBooks.AddColumnToImport(QB_COL_ENTITY_LASTNAME);

end;

procedure TSisEntityWiz.ImportPeachTreeFile;
begin
  if not Assigned(FPeachTree) then
     FPeachTree := TPeachTree.Create;

  AddPeachTreeColumnsToImportExport;

  FPeachTree.OpenPeachTreeFile(edtPath.Text, gridImport);

  lbGridInfo.Caption := IntToStr(gridImport.RowCount-1) + sLines + IntToStr(gridImport.ColCount) + sCol;

end;

procedure TSisEntityWiz.ImportQuickBooksFile;
var
  MyType : TQuickBooksFileType;
begin

  if not Assigned(FQuickBooks) then
     FQuickBooks := TQuickBooks.Create;

  Case iEntityType of
     0 : MyType := QB_FILE_TYPE_VENDOR;
     1 : MyType := QB_FILE_TYPE_CUSTOMER;
     2 : MyType := QB_FILE_TYPE_SALES_PERSON;
  end;

  AddQuickBooksColumnsToImportExport;

  FQuickBooks.OpenQuickBooksFile(edtPath.Text, gridImport, MyType);

  lbGridInfo.Caption := IntToStr(gridImport.RowCount-1) + sLines + IntToStr(gridImport.ColCount) + sCol;

end;

function TSisEntityWiz.TestBeforeNavigate:Boolean;
begin
  Result := True;

  if pgOption.ActivePage.Name = 'tsOption' then
     begin
     if rgOperation.ItemIndex = -1 then
        begin
        MsgBox(MSG_INF_SELECT_OPP_TYPE, vbInformation + vbOKOnly);
        Result := False;
        Exit;
        end;
     end
  else if pgOption.ActivePage.Name = 'tsSoftwareList' then
     begin
     if treeSoftware.Selected.Index = -1 then
        begin
        MsgBox(MSG_INF_SELECT_SOFTWARE, vbInformation + vbOKOnly);
        Result := False;
        Exit;
        end;
     end
  else if pgOption.ActivePage.Name = 'tsFileType' then
     begin
     if cbxFileType.Text = '' then
        begin
        MsgBox(MSG_INF_SELECT_FILE_TYPE, vbInformation + vbOKOnly);
        cbxFileType.SetFocus;
        Result := False;
        Exit;
        end;

     if (Trim(edtPath.Text) = '') or (Pos('.', edtPath.Text) = 0) then
        begin
        MsgBox(MSG_INF_PART1_INVALID_FILE_NAME + #13#10 +
               MSG_INF_PART2_INVALID_FILE_NAME + #13#10, vbInformation + vbOKOnly);
        edtPath.SetFocus;
        Result := False;
        Exit;
        end;
     end
  else if pgOption.ActivePage.Name = 'tsImport' then
     begin
     if gridImport.Row < 1 then
        begin
        MsgBox(MSG_INF_NO_INFO_TO_IMPORT, vbInformation + vbOKOnly);
        Result := False;
        Exit;
        end;
     end
  else if pgOption.ActivePage.Name = 'tsExport' then
     begin
     if not (quPessoa.Active) or (quPessoa.RecordCount=0) then
        begin
        MsgBox(MSG_INF_NO_DATA_TO_EXPORT, vbInformation + vbOKOnly);
        Result := False;
        Exit;
        end;

     if (rgOperation.ItemIndex=1) and (iSoftware = SOFTWARE_PEACHTREE) and
        (iEntityType in [ENTITY_VENDOR, ENTITY_CUSTOMER]) then
        if scChartAcc.LookUpValue = '' then
           begin
           MsgBox(MSG_INF_PART1_SELECT_GL +#13#10+
                  MSG_INF_PART2_SELECT_GL +#13#10 ,vbInformation + vbOKOnly);
           scChartAcc.SetFocus; 
           Result := False;
           Exit;
           end;
     end
  else if pgOption.ActivePage.Name = 'tsColumns' then
     begin
     //Save the column to the registry
     SaveGridColumn;

     if (rgOperation.ItemIndex = 0) and (not HasValidHeader) then
        begin
        MsgBox( MSG_CRT_PART1_NO_FILE_HEADER + #13#10 +
                MSG_CRT_PART2_NO_FILE_HEADER + #13#10, vbCritical + vbOKOnly);
        Result := False;
        Exit;
        end;
     end;

end;

procedure TSisEntityWiz.ImportSelected;
begin
   FTabList.Clear;
   FTabList.Add(IntToStr(tsOption.PageIndex));
   FTabList.Add(IntToStr(tsSoftwareList.PageIndex));
   FTabList.Add(IntToStr(tsFileType.PageIndex));
   FTabList.Add(IntToStr(tsImport.PageIndex));
   FTabList.Add(IntToStr(tsColumns.PageIndex));
   FTabList.Add(IntToStr(tsFinish.PageIndex));

end;

procedure TSisEntityWiz.ExportSelected;
begin
   FTabList.Clear;
   FTabList.Add(IntToStr(tsOption.PageIndex));
   FTabList.Add(IntToStr(tsSoftwareList.PageIndex));
   FTabList.Add(IntToStr(tsFileType.PageIndex));
   FTabList.Add(IntToStr(tsExport.PageIndex));
   FTabList.Add(IntToStr(tsColumns.PageIndex));
   FTabList.Add(IntToStr(tsFinish.PageIndex));

end;

function TSisEntityWiz.DoFinish:Integer;
begin
   //Finalized
   if rgOperation.ItemIndex = 0 then //Impor data from the Grid
      Result := BuildSQLImport
   else if rgOperation.ItemIndex = 1 then // Export data
     case iSoftware of
        SOFTWARE_QUICKBOOKS : Result := BuildQuickBooksExportFile;
        SOFTWARE_PEACHTREE  : Result := BuildPeachTreeExportFile;
     end;

   NoError := (Result=-1);
   
end;

procedure TSisEntityWiz.rgOperationClick(Sender: TObject);
begin
  inherited;
  case rgOperation.ItemIndex of
     0 : ImportSelected;
     1 : ExportSelected;
  end;

end;

procedure TSisEntityWiz.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  ClosePessoa;

  if Assigned(FQuickBooks) then
     FreeAndNil(FQuickBooks);

  if Assigned(FRegistry) then
     FreeAndNil(FRegistry);

  if Assigned(FPeachTree) then
     FreeAndNil(FPeachTree);

end;

procedure TSisEntityWiz.treeSoftwareClick(Sender: TObject);
begin
  inherited;

  lbSoftware.Visible := True;

  case treeSoftware.Selected.Index of
       0 : begin
           iSoftware := SOFTWARE_QUICKBOOKS;
           lbSoftware.Caption := sQuickBooks;
           lbTip.Caption := '';
           end;

       1 : begin
           iSoftware := SOFTWARE_PEACHTREE;
           lbSoftware.Caption := sPeachTree1;
           if rgOperation.ItemIndex = 1 then
              lbTip.Caption := sPeachTree2
           else
             lbTip.Caption := '';
           end;

       {0 : begin
           iSoftware := SOFTWARE_QUICKEN;
           lbSoftware.Caption := 'The data will be exported to ''Quicken File.''' + #13#10 +
           'The data file can be importate from Quicken 2001. ' +
           'See help file to learn how to import a QIF file using Quiken.';
           end;}

  end;

end;

procedure TSisEntityWiz.sbOpenFileClick(Sender: TObject);
var
  sFile : String;
  sExt  : String;
begin
  inherited;

  if SD.Execute then
     begin
     sFile := LowerCase(SD.FileName);

     case iSoftware of
        SOFTWARE_QUICKEN    : sExt := '.qif';
        SOFTWARE_QUICKBOOKS : sExt := '.iif';
        SOFTWARE_PEACHTREE  : sExt := '.csv';
     end;

     if Pos(sExt, sFile) = 0 then
        sFile := sFile + sExt;

     edtPath.Text := sFile;
     end;
end;

procedure TSisEntityWiz.sgColumnsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin

  //Somente na Coluna desejada
  if ((ACol = COLUMN_OFFICEM) AND (ARow <> 0)) then begin
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

procedure TSisEntityWiz.cbColumnsChange(Sender: TObject);
begin
  inherited;

  {Get the ComboBox selection and place in the grid}
  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];

  cbColumns.Visible := False;
  sgColumns.SetFocus;

end;

procedure TSisEntityWiz.cbColumnsExit(Sender: TObject);
begin
  inherited;

  {Get the ComboBox selection and place in the grid}
  sgColumns.Cells[sgColumns.Col, sgColumns.Row] := cbColumns.Items[cbColumns.ItemIndex];
  cbColumns.Visible := False;
  sgColumns.SetFocus;

end;

procedure TSisEntityWiz.quPessoaNewRecord(DataSet: TDataSet);
begin
  inherited;
  quPessoaIDUser.AsInteger := SisSenha.IDUsuario;

  Case iEntityType of

   ENTITY_VENDOR :   begin
                     quPessoaIDTipoPessoa.AsInteger := 2;
                     quPessoaType.AsBoolean         := True;
                     end;

   ENTITY_CUSTOMER : begin
                     quPessoaIDTipoPessoa.AsInteger := 1;
                     quPessoaType.AsBoolean         := False;
                     end;

   ENTITY_EMPLOYEE : begin
                     quPessoaIDTipoPessoa.AsInteger := 4;
                     quPessoaType.AsBoolean         := False;
                     end;
  end;

end;

procedure TSisEntityWiz.cbxFileTypeChange(Sender: TObject);
begin
  inherited;
  iEntityType := cbxFileType.ItemIndex;
end;

procedure TSisEntityWiz.dxDBCGrid1RefreshNodeData(Sender: TObject;
  Node: TdxTreeListNode);
begin
  inherited;
  lbExportLines.Caption := IntToStr(dxDBCGrid1.Count) + sRecords;
end;

procedure TSisEntityWiz.FormCreate(Sender: TObject);
begin
  inherited;

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sImporting   := 'Importing data from ';
           sExporting   := 'Exporting data to ';
           sDelDuplic   := 'Eliminate duplicated records.';
           sNoDelDuplic := 'NOT eliminate duplicated records.';
           sFileType    := 'File Type  : ';
           sFilePath    := 'File Path  : ';
           sTotalRows   := 'Total Rows : ';
           sColVailable := ' columns available to import/export.';
           sLines       := ' lines and ';
           sCol         := ' columns.';
           sQuickBooks  := 'The data will be (exported to) or (imported from) ''QuickBooks File.'' Pro 2001/2002.' +
                           'See help file to learn how to import/export data using QuickBooks.';
           sPeachTree1  := 'The data will be (exported to) or (imported from) ''Peach Tree File.'' PeachTree Accounting 2002. ' + #13#10 +
                           'See help file to learn how to import/export data using PeachTree.';
           sPeachTree2  := 'IMPORTANT : Before import Vendor, Customer, or Employee list from PeachTree, you ' +
                           'MUST import all Office Manager Chart of account. To export the Char of Accounts from Office ' +
                           'Manager, go to Account Statement, export.';
           sRecords     := ' record(s).';
           end;
    LANG_PORTUGUESE :
           begin
           sImporting   := 'Importar dados de ';
           sExporting   := 'Exportar dados para ';
           sDelDuplic   := 'Eliminar campos duplicados.';
           sNoDelDuplic := 'NÃO eliminar campos duplicados.';
           sFileType    := 'Tipo de Arquivo : ';
           sFilePath    := 'Caminho         : ';
           sTotalRows   := 'Total de linhas : ';
           sColVailable := ' colunas disponíveis para importar/exportar.';
           sLines       := ' linhas e ';
           sCol         := ' colunas.';
           sQuickBooks  := 'Os dados serão (exportado para) ou (importado do) ''QuickBooks File.'' Pro 2001/2002.' +
                           'Veja a ajuda para aprender como importar/exportar dados usando QuickBooks.';
           sPeachTree1  := 'Os dados serão (exportado para) ou (importado do) ''Peach Tree File.'' PeachTree Accounting 2002. ' + #13#10 +
                           'Veja a ajuda para aprender como importar/exportar dados usando PeachTree.';
           sPeachTree2  := 'IMPORTANTE : Antes de importar os Fornecedores, Clientes, ou Empregados do PeachTree, voçê ' +
                           'DEVE exportar todos as categorías de despesas para o PeachTree. Para exportar as categorías do Office Maanger, ' +
                           'Clique na Conta Bacária Histórico, exportar, Programas de Contabilidade.';
           sRecords     := ' registro(s).';
           end;

    LANG_SPANISH :
           begin
           sImporting   := 'Importar datos de ';
           sExporting   := 'Exportar datos para ';
           sDelDuplic   := 'Eliminar campos duplicados.';
           sNoDelDuplic := 'No eliminar campos duplicados.';
           sFileType    := 'Tipo de Archivo : ';
           sFilePath    := 'Vía         : ';
           sTotalRows   := 'Total de líneas : ';
           sColVailable := ' Columnas disponibles para importar/exportar.';
           sLines       := ' Líneas y ';
           sCol         := ' columnas.';
           sQuickBooks  := 'Los datos serán (exportado para) o (importado de) ''QuickBooks File.'' Pro 2001/2002.' +
                           'Vea la ayuda para aprender como importar/exportar datos usando QuickBooks.';
           sPeachTree1  := 'Los datos serán (exportado para) o (importado de) ''Peach Tree File.'' PeachTree Accounting 2002. ' + #13#10 +
                           'Vea la ayuda para aprender como importar/exportar datos usando PeachTree.';
           sPeachTree2  := 'IMPORTANTE : Antes de importar Proveedor, Clientes, o Empleados del PeachTree, ' +
                           'Debe exportar todos las categorías de gastos para el PeachTree. Para exportar las categorías do Office Maanger, ' +
                           'Haga clic en el histórico de la Cuenta Bancária , exportar, Programas de Contabilidad.';
           sRecords     := ' registro(s).';
           end;
  end;

end;

end.
