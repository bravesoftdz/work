unit uFrmInvResetView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, RadioButtonAll, Mask, LblEffct,
  ExtCtrls, Buttons, SuperComboADO, Db, ADODB, Variants,
  DBCtrls, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass,
  ppReport, ppBands, ppCache, ppCtrls, ppPrnabl, ppVar, ppViewr, siComp,
  siLangRT, Grids, DBGrids, SMDBGrid, ppParameter, ppModule, raCodMod;

type
  TFrmInvResetView = class(TFrmParent)
    btCancel: TButton;
    spHelp: TSpeedButton;
    pnlModel: TPanel;
    Label6: TLabel;
    cmbCategory: TSuperComboADO;
    Label1: TLabel;
    Label2: TLabel;
    cbxMethod: TComboBox;
    edModel: TEdit;
    quModel: TADODataSet;
    dsModel: TDataSource;
    quModelIDModel: TAutoIncField;
    quModelModel: TStringField;
    quModelDescription: TStringField;
    quModelCategory: TStringField;
    quModelStore: TStringField;
    btClearStore: TButton;
    Label3: TLabel;
    cmbStore: TSuperComboADO;
    btClearCatego: TButton;
    btAllModel: TButton;
    btnRefresh: TSpeedButton;
    Label4: TLabel;
    cmbResetDate: TDBLookupComboBox;
    dsResetDate: TDataSource;
    quResetDate: TADODataSet;
    btnPreview: TBitBtn;
    ppReport: TppReport;
    ppPipeline: TppDBPipeline;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDBText1: TppDBText;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    quModelResetDate: TDateTimeField;
    lblUsuarioData: TppLabel;
    ppLine3: TppLine;
    ppSystemVariable1: TppSystemVariable;
    cmRestore: TADOCommand;
    btnRestore: TBitBtn;
    ppLine1: TppLine;
    quModelIDStore: TIntegerField;
    quModelInvType: TIntegerField;
    grdModels: TSMDBGrid;
    quModelQtyOnHand: TFloatField;
    quModelPrevQty: TFloatField;
    quModelQtyAbs: TFloatField;
    ppSummaryBand: TppSummaryBand;
    ppVariable1: TppVariable;
    raCodeModule1: TraCodeModule;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppVariable2: TppVariable;
    ppParameterList1: TppParameterList;
    ppLabel5: TppLabel;
    ppVariable3: TppVariable;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCancelClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btClearStoreClick(Sender: TObject);
    procedure btClearCategoClick(Sender: TObject);
    procedure btAllModelClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure ppReportBeforePrint(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
  private
    { Private declarations }
    sWhere : string;

    procedure ResetDateClose;
    procedure ModelClose;
    procedure RefreshModel;
  public
    { Public declarations }
    procedure Start(aIdStore: integer);
  end;

implementation

uses uMsgBox, uDM, uAskManager, uMsgConstant, uSqlFunctions,
     uDMGlobal, uSystemConst;

{$R *.DFM}

procedure TFrmInvResetView.Start(aIdStore: integer);
begin
  if aIdStore <> 0 then
    cmbStore.LookUpValue:= IntToStr(aIdStore);
  ShowModal;
end;

procedure TFrmInvResetView.ResetDateClose;
begin
  with quResetDate do
    if Active then
      Close;
end;

procedure TFrmInvResetView.ModelClose;
begin
  with quModel do
    if Active then
      Close;
end;

procedure TFrmInvResetView.RefreshModel;
var
  sOldSql, sLike : String;
begin
  Screen.Cursor := crHourGlass;

  ModelClose;

  with quModel do
  begin
    sOldSql := CommandText;
    sWhere  := ' M.Desativado = 0 AND I.QtyOnHand <> RH.Qty AND M.ModelType IN (''R'',''S'',''K'') ';
    sLike   := 'None';

    case cbxMethod.ItemIndex of
      0 : sLike := edModel.Text + '%';
      1 : sLike := '%' + edModel.Text;
      2 : sLike := '%' + edModel.Text + '%';
    else
      sLike := 'None';
    end;

    //Add Model
    if sLike <> 'None' then
      sWhere := sWhere + ' AND M.Model Like ' + QuotedStr(sLike);

    //Add a Store
    if cmbStore.LookUpValue <> '' then
      sWhere := sWhere + ' AND I.StoreID = ' + cmbStore.LookUpValue;

    //Add Group
    if cmbCategory.LookUpValue <> '' then
      sWhere := sWhere + ' AND M.GroupID = ' + cmbCategory.LookUpValue;

    sWhere := sWhere + 'AND RH.ResetDate = '+QuotedStr(FormatDateTime('mm/dd/yyyy hh:mm:ss AM/PM',cmbResetDate.KeyValue))+' ';

    //cmbResetDate.Text;

    CommandText := ChangeWhereClause(sOldSQL, sWhere, True);

    //Parameters.ParamByName('ResetDate').Value:= cmbResetDate.KeyValue;
    Open;
    
    btnRestore.Enabled:= (not IsEmpty);
  end;

  Screen.Cursor := crDefault;
end;

procedure TFrmInvResetView.FormShow(Sender: TObject);
begin
  inherited;
  quResetDate.open;
  cmbCategory.SetAll;
  cmbResetDate.SetFocus;
end;

procedure TFrmInvResetView.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ResetDateClose;
  ModelClose;

  Action := caFree;
end;

procedure TFrmInvResetView.btCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmInvResetView.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(519);
end;

procedure TFrmInvResetView.btClearStoreClick(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text        := '<'+btClearStore.Caption+'>';
end;

procedure TFrmInvResetView.btClearCategoClick(Sender: TObject);
begin
  inherited;
  cmbCategory.LookUpValue := '';
  cmbCategory.Text        := '<'+btClearCatego.Caption+'>';
end;

procedure TFrmInvResetView.btAllModelClick(Sender: TObject);
begin
  inherited;
  cbxMethod.ItemIndex := -1;
  edModel.Clear;
end;

procedure TFrmInvResetView.btnRefreshClick(Sender: TObject);
begin
  inherited;
  if cmbResetDate.KeyValue = null then
  begin
    MsgBox(MSG_CRT_NO_DATE, vbOKOnly + vbCritical);
    cmbResetDate.SetFocus;
    exit;
  end;

  RefreshModel;

end;

procedure TFrmInvResetView.btnPreviewClick(Sender: TObject);

  procedure SetAutoText;
  var
    sUsuarioData: String;
    i: integer;
  begin
    sUsuarioData := 'Printed by ' + DM.fUser.UserName + ' on ' + FormatDateTime('ddddd hh:mm', Now());

    with ppReport do
    begin
      if Footer <> nil then
        with Footer do
          for i := 0 to ObjectCount-1 do
            if Objects[i].UserName = 'lblUsuarioData' then
              Objects[i].Caption := sUsuarioData;
    end;
  end;

begin
  inherited;
  if not quModel.Active then
    quModel.Open;
    
  SetAutoText;
  ppReport.Print;
end;

procedure TFrmInvResetView.ppReportBeforePrint(Sender: TObject);
begin
  inherited;
  ppReport.PreviewForm.WindowState:= wsMaximized;
  //TppViewer(ppReport.PreviewForm.Viewer).ZoomSetting:= zsPageWidth;
end;

procedure TFrmInvResetView.btnRestoreClick(Sender: TObject);
var
  iID : integer;
begin
  inherited;

  if MsgBox(MSG_QST_RESTORE_INVENTORY, vbYesNo + vbSuperCritical) = vbNo then
    exit;

  Screen.Cursor:= crHourGlass;
  Application.ProcessMessages;

  DM.ADODBConnect.BeginTrans;

  Try
    with quModel do
       begin
       First;
       While not EOF do
          begin
          iID := DM.GetNextID(MR_INVENTORY_MOV_ID);
          DM.RunSQL('INSERT InventoryMov ( IDInventoryMov, InventMovTypeID, DocumentID, StoreID, ModelID, MovDate, Qty, IDUser) '+
                    'VALUES ('+IntToStr(iID)+', '+
                    quModelInvType.AsString +', '+
                    '0, '+
                    quModelIDStore.AsString +', '+
                    quModelIDModel.AsString +', '+
                    QuotedStr(FormatDateTime('mm/dd/yyyy hh:mm:ss AM/PM',Now))+', '+
                    quModelQtyABS.AsString  +', '+
                    IntToStr(DM.fUser.ID)+')');
          Next;
          end;
       end;

    with cmRestore do
      begin
  {
        'INSERT InventoryMov ( IDInventoryMov, InventMovTypeID, DocumentID, StoreID, ModelID, ' +
        '                      MovDate, Qty, IDUser )                         ' +
        'SELECT                                                               ' +
        '( CASE  WHEN RH.Qty > 0 THEN 24 ELSE 23 END ), 0, RH.IDStore,        ' +
        ' RH.IDModel, :Date, ABS(RH.Qty), :IDUser                             ' +
        'FROM  InvResetHistory RH                                             ' +
        'INNER JOIN Model M ON (RH.IDModel = M.IDModel)                       ' +
        'INNER JOIN Inventory I ON (RH.IDModel = I.ModelID                    ' +
        '                           AND RH.IDStore = I.StoreID)               ' +
  }
      CommandText:=
        'DELETE RH                                                            ' +
        'FROM  InvResetHistory RH                                             ' +
        'INNER JOIN Model M ON (RH.IDModel = M.IDModel)                       ' +
        'INNER JOIN Inventory I ON (RH.IDModel = I.ModelID                    ' +
        '                           AND RH.IDStore = I.StoreID)               ' +
        'WHERE RH.Qty <> 0                                                    ' +
        'AND '+ sWhere;                                                 
      Execute;
      end;

    DM.ADODBConnect.CommitTrans;
    except
      DM.ADODBConnect.RollbackTrans;
    end;

  RefreshModel;

  Screen.Cursor:= crDefault;
  Application.ProcessMessages;
end;

end.
