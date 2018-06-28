unit uDM;

interface

{ By removing the 'x' which begins each of these compiler directives,
  you can enable different functionality within the end-user reporting
  solution.

  DADE - the data tab where queries can be created by the end-user

  BDE  - BDE support for the Query Tools

  ADO  - ADO support for the Query Tools

  IBExpress - Interbase Express support for the Query Tools

  RAP -  the calc tab, where calculations can be coded at run-time
         (RAP is included with ReportBuilder Enterprise)

  CrossTab - adds the CrossTab component to the component palette in the
             report designer.

  CheckBox - adds a checkbox component to the component palette in the
         report designer.

  TeeChart - adds a teechart component to the report designer component
         palette. You must have TeeChart installed. More information
         is available in ..\RBuilder\TeeChart\ReadMe.doc

  UseDesignPath - determines whether the path used by the Database
         object on this form is replaced in the OnCreate event handler of
         this form with the current path.}

{$DEFINE DADE}            {remove the 'x' to enable DADE}
{x$DEFINE BDE}             {remove the 'x' to enable Borland Database Engine (BDE) }
{$DEFINE ADO}            {remove the 'x' to enable ADO}
{x$DEFINE IBExpress}      {remove the 'x' to enable Interbase Express}
{$DEFINE CrossTab}        {remove the 'x' to enable CrossTab}
{$DEFINE RAP}            {remove the 'x' to enable RAP}
{$DEFINE CheckBox}       {remove the 'x' to enable CheckBox}
{x$DEFINE TeeChart}       {remove the 'x' to enable standard TeeChart}
{x$DEFINE UseDesignPath}  {remove the 'x' to use the design-time settings of Database object on this form}

uses

{$IFDEF DADE}
  daIDE,
{$ENDIF}

{$IFDEF BDE}
  daDBBDE,
{$ENDIF}

{$IFDEF ADO}
  daADO,
{$ENDIF}

{$IFDEF IBExpress}
  daIBExpress,
{$ENDIF}

{$IFDEF CrossTab}
  ppCTDsgn,
{$ENDIF}

{$IFDEF RAP}
  raIDE,
{$ENDIF}

{$IFDEF CheckBox}
  myChkBox,
{$ENDIF}

{$IFDEF TeeChart}
  ppChrtUI,
{$ENDIF}

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDMParent, ADODB, DB, ppBands, ppCache, ppClass, ppProd,
  ppReport, ppDsgnDB, ppEndUsr, ppFormWrapper, ppRptExp, ppDB, ppComm,
  ppRelatv, ppDBPipe, PowerADOQuery, LookUpADOQuery, uUserObj, ppTypes,
  PsRBExport_MasterControl, AbBase, AbBrowse, AbZBrows, AbUnzper;

type
  TDM = class(TDMParent)
    tblFolder: TADOTable;
    tblFolderFolderId: TAutoIncField;
    tblFolderName: TStringField;
    tblFolderParentId: TIntegerField;
    dsFolder: TDataSource;
    plFolder: TppDBPipeline;
    dsItem: TDataSource;
    plItem: TppDBPipeline;
    plItemppField1: TppField;
    plItemppField2: TppField;
    plItemppField3: TppField;
    plItemppField4: TppField;
    plItemppField5: TppField;
    plItemppField6: TppField;
    plItemppField7: TppField;
    plItemppField8: TppField;
    plItemppField9: TppField;
    ppReportExplorer1: TppReportExplorer;
    ppDesigner1: TppDesigner;
    ppDataDictionary1: TppDataDictionary;
    tblTable: TADOTable;
    tblTableTableName: TStringField;
    tblTableTableAlias: TStringField;
    dsTable: TDataSource;
    plTable: TppDBPipeline;
    tblField: TADOTable;
    tblFieldTableName: TStringField;
    tblFieldFieldName: TStringField;
    tblFieldFieldAlias: TStringField;
    tblFieldSelectable: TStringField;
    tblFieldSearchable: TStringField;
    tblFieldSortable: TStringField;
    tblFieldDataType: TStringField;
    tblFieldAutoSearch: TStringField;
    tblFieldMandatory: TStringField;
    dsField: TDataSource;
    plField: TppDBPipeline;
    tblJoin: TADOTable;
    tblJoinTableName1: TStringField;
    tblJoinTableName2: TStringField;
    tblJoinJoinType: TStringField;
    tblJoinFieldNames1: TStringField;
    tblJoinFieldNames2: TStringField;
    tblJoinOperators: TStringField;
    dsJoin: TDataSource;
    plJoin: TppDBPipeline;
    ppReport1: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    euDatabase: TADOConnection;
    tblFieldDataModule: TStringField;
    tblFieldDataSet: TStringField;
    tblFieldListField: TStringField;
    quLookUpStore: TLookUpADOQuery;
    quLookUpMedia: TLookUpADOQuery;
    quLookUpCashReg: TLookUpADOQuery;
    quLookUpCategory: TLookUpADOQuery;
    quLookUpFabricante: TLookUpADOQuery;
    quLookUpVendor: TLookUpADOQuery;
    quLookUpCustomer: TLookUpADOQuery;
    quLookUpAgenty: TLookUpADOQuery;
    quLookUpAgency: TLookUpADOQuery;
    quLookUpMeioPag: TLookUpADOQuery;
    quLookUpMeioPagIDMeioPag: TIntegerField;
    quLookUpMeioPagMeioPag: TStringField;
    quLookUpMeioPagIDPaymentTypePrediction: TIntegerField;
    quLookUpUser: TLookUpADOQuery;
    quLookUpBank: TLookUpADOQuery;
    quLookUpBankAccount: TLookUpADOQuery;
    quLookUpPessoaTipo: TLookUpADOQuery;
    quLookUpCompany: TLookUpADOQuery;
    quLookUpCostCenter: TLookUpADOQuery;
    quLookUpDesdobramentoTipo: TLookUpADOQuery;
    quLookUpDocumentoTipo: TLookUpADOQuery;
    quLookUpPessoa: TLookUpADOQuery;
    quLookUpRecordType: TLookUpADOQuery;
    quTaxCategory: TLookUpADOQuery;
    PsRBExport: TPsRBExportMasterControl;
    quLookUpModelGroup: TLookUpADOQuery;
    quMROpenReport: TADODataSet;
    quMROpenReportItemID: TIntegerField;
    quMROpenReportFolderID: TIntegerField;
    quMROpenReportName: TStringField;
    quMROpenReportItemType: TIntegerField;
    quMROpenReportDeleted: TDateTimeField;
    quMROpenReportSystem: TBooleanField;
    quMROpenReportHint: TStringField;
    quMROpenReportVersion: TIntegerField;
    quMROpenReportTemplate: TBlobField;
    quMROpenReportModified: TDateTimeField;
    quMROpenReportSize: TIntegerField;
    AbUnZipper: TAbUnZipper;
    quNewRepItem: TADODataSet;
    quNewRepItemDeleted: TBooleanField;
    quNewRepItemFolderID: TIntegerField;
    quNewRepItemItemID: TIntegerField;
    quNewRepItemTemplate: TBlobField;
    quNewRepItemVersion: TIntegerField;
    quNewRepItemHint: TWideStringField;
    quNewRepItemRepName: TWideStringField;
    quNewRepItemModified: TDateTimeField;
    quNewRepItemRepSize: TIntegerField;
    cntAccessReport: TADOConnection;
    quLookUpSize: TLookUpADOQuery;
    quLookUpColor: TLookUpADOQuery;
    quLookUpMeasure: TLookUpADOQuery;
    quLookUpStoreIDStore: TIntegerField;
    quLookUpStoreName: TStringField;
    quLookUpStoreStore: TStringField;
    quItem: TADODataSet;
    quItemItemid: TIntegerField;
    quItemFolderId: TIntegerField;
    quItemName: TStringField;
    quItemSize: TIntegerField;
    quItemItemType: TIntegerField;
    quItemModified: TDateTimeField;
    quItemDeleted: TDateTimeField;
    quItemTemplate: TBlobField;
    quItemFilters: TMemoField;
    quItemSystem: TBooleanField;
    quItemHint: TStringField;
    quItemEdit: TBooleanField;
    quLookUpModelSubGroup: TLookUpADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure tblFolderBeforePost(DataSet: TDataSet);
    procedure tblItemBeforePost(DataSet: TDataSet);
    procedure quItemBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FParams     : TStrings;
    fIDStore    : Integer;
    fIDLanguage : Integer;
    fStoreName  : String;
    fStoreList  : string;
  public
    { Public declarations }
    sdtPrinter : string;
    fUser : TUser;
    property IDStore    : Integer read fIDStore    write fIDStore;
    property IDLanguage : Integer read fIDLanguage write fIDLanguage;
    property StoreName  : String  read fStoreName  write fStoreName;
    property StoreList  : String  read fStoreList  write fStoreList;
    procedure PrintPreview(ReportStream: TMemoryStream;
      aParams: TStrings; aDeviceType: string = dtScreen);
    procedure Print(ReportStream: TMemoryStream; aParams: TStrings);
  end;

var
  DM: TDM;

implementation

uses uMsgConstant, uParamFunctions, uDMGlobal, uSystemConst, ufrmServerInfo,
     Registry;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  sResult : String;
  FrmServrInfo : TFrmServerInfo;
  bAbort,
  ExitConnection : Boolean;
begin
  inherited;

  //TFrmMsgConstant.Create(Self);
  DMGlobal.IDLanguage := LANG_ENGLISH;
  FrmServrInfo        := TFrmServerInfo.Create(self);
  fUser               := TUser.Create;
  sdtPrinter          := '';

  sResult := FrmServrInfo.Start('4', False, '', bAbort);
  ExitConnection := bAbort;

  While not ExitConnection do
     try
        fSQLConnectParam.Server    := ParseParam(sResult, SV_SERVER);
        fSQLConnectParam.DBAlias   := ParseParam(sResult, SV_DATABASE);
        fSQLConnectParam.UserName  := ParseParam(sResult, SV_USER);
        fSQLConnectParam.PW        := ParseParam(sResult, SV_PASSWORD);
        fSQLConnectParam.WinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
        fSQLConnectParam.UseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');
        fSQLConnectParam.Status    := SQL_STATUS_NO_CONNECTED;

        if not fSQLConnectParam.WinLogin then
           if fSQLConnectParam.UseNetLib then
              sResult := SetConnectionStr(fSQLConnectParam.UserName,
                                          fSQLConnectParam.PW,
                                          fSQLConnectParam.DBAlias,
                                          fSQLConnectParam.Server)
           else
              sResult := SetConnectionStrNoNETLIB(fSQLConnectParam.UserName,
                                                  fSQLConnectParam.PW,
                                                  fSQLConnectParam.DBAlias,
                                                  fSQLConnectParam.Server)
        else
           if fSQLConnectParam.UseNetLib then
              sResult := SetWinConnectionStr(fSQLConnectParam.DBAlias,
                                             fSQLConnectParam.Server)
           else
              sResult := SetWinConnectionStrNoNETLIB(fSQLConnectParam.DBAlias,
                                                     fSQLConnectParam.Server);

        //ADOConnectionString := sResult;
        //ADOConnectionOpen;
        //Depois tem que renomear pra usar o ADOConnection
        euDatabase.ConnectionString := sResult;
        euDatabase.Open;
        ExitConnection := True; 
      except
           on E: Exception do
              begin
              sResult := FrmServrInfo.Start('4', True, E.Message, bAbort);
              ExitConnection := bAbort;
              end;
           end;

           
  if bAbort then
     begin
     Application.Terminate;
     end;

 // Abre o registry
 with TRegistry.Create do
     begin
       RootKey := HKEY_LOCAL_MACHINE;
       OpenKey(REGISTRY_PATH, True);
       if not ValueExists('DefaultStoreID') then
          WriteInteger('DefaultStoreID', 1);
       fIDStore := ReadInteger('DefaultStoreID');
       if not ValueExists('DefaultLanguage') then
          WriteInteger('DefaultLanguage', LANG_ENGLISH);
       fIDLanguage := ReadInteger('DefaultLanguage');
       Free;
     end;

 DMGlobal.IDLanguage := fIDLanguage;
     
 case fIDLanguage of
   LANG_ENGLISH    :ppReport1.Language := lgEnglish;
   LANG_PORTUGUESE :ppReport1.Language := lgPortugueseBrazil;
   LANG_SPANISH    :ppReport1.Language := lgSpanish;
 end;

end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(fUser) then
     FreeAndNil(fUser);
end;

procedure TDM.tblFolderBeforePost(DataSet: TDataSet);
begin
  inherited;
  tblFolderFolderId.AsInteger := GetNextID(MR_REP_FOLDER_ID);
end;

procedure TDM.tblItemBeforePost(DataSet: TDataSet);
begin
  inherited;
  //tblItemItemId.AsInteger := GetNextID(MR_REP_ITEM_ID);
  quItemItemid.AsInteger := GetNextID(MR_REP_ITEM_ID);
end;

procedure TDM.PrintPreview(ReportStream: TMemoryStream;
  aParams: TStrings; aDeviceType: string);
begin

  with ppReport1 do
  begin
    FParams := TStringList.Create;
    FParams.Assign(AParams);
    try
      Reset;
      Template.LoadFromStream(ReportStream);
      Screen.Cursor := crHourGlass;
      ShowAutoSearchDialog := False;
      DeviceType := aDeviceType;
      if DeviceType = 'Printer' then
        ShowPrintDialog := False
      else
        ShowPrintDialog := True;
      Print;
    finally
      Screen.Cursor := crDefault;
      ShowAutoSearchDialog := True;
      FParams.Free;
    end;
  end;

end;

procedure TDM.Print(ReportStream: TMemoryStream; aParams: TStrings);
begin
  if sdtPrinter = '' then
    PrintPreview(ReportStream, aParams, dtPrinter)
  else
    PrintPreview(ReportStream, aParams, sdtPrinter);
end;


procedure TDM.quItemBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  quItem.Parameters.ParamByName('IDUserType').Value := fUser.IDUserType;
end;

end.
