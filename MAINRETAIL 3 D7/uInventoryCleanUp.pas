unit uInventoryCleanUp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, RadioButtonAll, Mask, LblEffct,
  ExtCtrls, Buttons, SuperComboADO, Db, ADODB, siComp, siLangRT, Grids, DBGrids,
  SMDBGrid;

type
  TInventoryCleanUp = class(TFrmParent)
    btCancel: TButton;
    spHelp: TSpeedButton;
    pnlModel: TPanel;
    Label6: TLabel;
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
    scStore: TSuperComboADO;
    btClearCatego: TButton;
    btAllModel: TButton;
    btnRefresh: TSpeedButton;
    cmCleanInv: TADOCommand;
    quModelInvType: TIntegerField;
    quModelStoreID: TIntegerField;
    grdBarcode: TSMDBGrid;
    quModelQtyOnHand: TFloatField;
    quModelQtyABS: TFloatField;
    lbQtyType: TLabel;
    cbxQtyType: TComboBox;
    lbSubCategory: TLabel;
    scSubCategory: TSuperComboADO;
    btnSubCategClear: TButton;
    lbModelGroup: TLabel;
    scModelGroup: TSuperComboADO;
    btnMGroupClear: TButton;
    scCategory: TSuperComboADO;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btClearStoreClick(Sender: TObject);
    procedure btClearCategoClick(Sender: TObject);
    procedure btAllModelClick(Sender: TObject);
    procedure scStoreSelectItem(Sender: TObject);
    procedure scCategorySelectItem(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSubCategClearClick(Sender: TObject);
    procedure btnMGroupClearClick(Sender: TObject);
    procedure scSubCategorySelectItem(Sender: TObject);
    procedure scModelGroupSelectItem(Sender: TObject);
  private
    sAsk : String;
    sWhere : string;

    procedure ModelClose;
    procedure RefreshModel;
    function AdjustInventoryToZero(sWhereClause:string):Boolean;
  end;

implementation

uses uDM, uMsgBox, uAskManager, uMsgConstant, uSqlFunctions, uDMGlobal,
     uSystemConst, uNumericFunctions;

{$R *.DFM}

function TInventoryCleanUp.AdjustInventoryToZero(sWhereClause:string):Boolean;
var
  iID : Integer;
begin

  Screen.Cursor := crHourGlass;

  Try
    //Abro a Transacao
    DM.ADODBConnect.BeginTrans;

    with cmCleanInv do
    begin
      CommandText :=
      'INSERT InvResetHistory ( ResetDate, IDStore, IDModel, Qty )          ' +
      'SELECT :ResetDate, I.StoreID, I.ModelID, I.QtyOnHand                 ' +
      'FROM  Inventory I  (NOLOCK)                                          ' +
      'INNER JOIN Model M (NOLOCK) ON (I.ModelID = M.IDModel)               ' +
      'WHERE ' + sWhereClause;

      Parameters.ParamByName('ResetDate').Value:= Now;
      Execute;
    end;



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
                    quModelStoreID.AsString +', '+
                    quModelIDModel.AsString +', '+
                    QuotedStr(FormatDateTime('mm/dd/yyyy hh:mm:ss AM/PM',(Now)))+', '+
                    MyFormatDouble(quModelQtyABS.AsFloat, '.')  +', '+
                    IntToStr(DM.fUser.ID)+')');
          Next;
          end;
       end;



{
      'INSERT InventoryMov ( InventMovTypeID, DocumentID, StoreID, ModelID, ' +
      '                      MovDate, Qty, IDUser )                         ' +
      'SELECT                                                               ' +
      '( CASE  WHEN I.QtyOnHand > 0 THEN 12 ELSE 11 END ), 0, I.StoreID,    ' +
      ' I.ModelID, :Date, ABS(I.QtyOnHand), :IDUser                         ' +
      'FROM  Inventory I                                                    ' +
      'INNER JOIN Model M ON (I.ModelID = M.IDModel)                        ' +
      'WHERE I.QtyOnHand <> 0                                               ' +
      'AND M.ModelType IN (''R'',''S'',''K'')                                     ' +
      'AND ' + sWhereClause
}
    //Gravo os resultados
    DM.ADODBConnect.CommitTrans;
    Result := True;
  Except
    on E: Exception do
      begin
      Result := False;
      DM.ADODBConnect.RollbackTrans;
      ShowMessage(E.Message);
      end;
  end;

  Screen.Cursor := crDefault;

end;

procedure TInventoryCleanUp.ModelClose;
begin
    with quModel do
       if Active then
          Close;
end;

procedure TInventoryCleanUp.RefreshModel;
var
  sOldSql, sLike: String;
begin
  Screen.Cursor := crHourGlass;

  ModelClose;

  with quModel do
  begin
    sOldSql := CommandText;
    sWhere  := ' M.Desativado = 0 AND M.ModelType IN (''R'',''S'',''K'') ';
    sLike   := 'None';

    case cbxMethod.ItemIndex of
      0: sLike := edModel.Text + '%';
      1: sLike := '%' + edModel.Text;
      2: sLike := '%' + edModel.Text + '%';

      else
        sLike := 'None';
    end;

    //Add Model
    if sLike <> 'None' then
      sWhere := sWhere + ' AND M.Model Like ' + QuotedStr(sLike);
    //Add a Store
    if scStore.LookUpValue <> '' then
      sWhere := sWhere + ' AND I.StoreID = ' + scStore.LookUpValue;
    //Add Categ
    if scCategory.LookUpValue <> '' then
      sWhere := sWhere + ' AND M.GroupID = ' + scCategory.LookUpValue;
    //Sub Categ
    if scSubCategory.LookUpValue <> '' then
      sWhere := sWhere + ' AND M.IDModelGroup = ' + scSubCategory.LookUpValue;
    //Group
    if scModelGroup.LookUpValue <> '' then
      sWhere := sWhere + ' AND M.IDModelSubGroup = ' + scModelGroup.LookUpValue;

    case cbxQtyType.ItemIndex of
      0: sWhere := sWhere + ' AND I.QtyOnHand > 0';
      1: sWhere := sWhere + ' AND I.QtyOnHand < 0';
      2: sWhere := sWhere + ' ';
    end;

    CommandText := ChangeWhereClause(sOldSQL, sWhere, True);
    Open;
  end;

  Screen.Cursor := crDefault;
end;

procedure TInventoryCleanUp.FormShow(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := IntToStr(DM.fStore.IDDefault);
  //scCategory.SetAll;
  btClose.SetFocus;
  RefreshModel;
end;

procedure TInventoryCleanUp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ModelClose;
  Action := caFree;
end;

procedure TInventoryCleanUp.btCloseClick(Sender: TObject);
var
  bClose : Boolean;
begin
  inherited;
  bClose := False;

  if MsgBox(MSG_QST_CLEAN_UP_INVENTORY, vbYesNo + vbSuperCritical) = vbYes then
    with TFrmAskManager.Create(self) do
      if Start(sAsk) then
        if AdjustInventoryToZero(sWhere) then
        begin
          MsgBox(MSG_INF_INV_CLEANED, vbOKOnly + vbInformation);
          bClose := True;
        end;

  if bClose then
    Close;
end;

procedure TInventoryCleanUp.btCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TInventoryCleanUp.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1830);
end;

procedure TInventoryCleanUp.btClearStoreClick(Sender: TObject);
begin
  inherited;
  scStore.LookUpValue := '';
  scStore.Text := '<' + btClearStore.Caption + '>';
  RefreshModel;
end;

procedure TInventoryCleanUp.btClearCategoClick(Sender: TObject);
begin
  inherited;
  scCategory.LookUpValue := '';
  scCategory.Text := '<' + btClearCatego.Caption + '>';
  RefreshModel;
end;

procedure TInventoryCleanUp.btAllModelClick(Sender: TObject);
begin
  inherited;
  cbxMethod.ItemIndex := -1;
  edModel.Clear;
  RefreshModel;
end;

procedure TInventoryCleanUp.scStoreSelectItem(Sender: TObject);
begin
  inherited;
  if scStore.LookUpValue <> '' then
    RefreshModel;
end;

procedure TInventoryCleanUp.scCategorySelectItem(Sender: TObject);
begin
  inherited;
  if scCategory.LookUpValue <> '' then
    RefreshModel;
end;

procedure TInventoryCleanUp.btnRefreshClick(Sender: TObject);
begin
  inherited;
  RefreshModel;
end;

procedure TInventoryCleanUp.FormCreate(Sender: TObject);
begin
  inherited;
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:    sAsk := 'The Operation requires an Administrator''s authorization.';
    LANG_PORTUGUESE: sAsk := 'A Operação Requere Autorização do Gerente.';
    LANG_SPANISH:    sAsk := 'La Operación Requiere Autorización del Gerente.';
  end;
end;

procedure TInventoryCleanUp.btnSubCategClearClick(Sender: TObject);
begin
  inherited;
  scSubCategory.LookUpValue := '';
  scSubCategory.Text := '<' + btnSubCategClear.Caption + '>';
  RefreshModel;
end;

procedure TInventoryCleanUp.btnMGroupClearClick(Sender: TObject);
begin
  inherited;
  scModelGroup.LookUpValue := '';
  scModelGroup.Text := '<' + btnMGroupClear.Caption + '>';
  RefreshModel;
end;

procedure TInventoryCleanUp.scSubCategorySelectItem(Sender: TObject);
begin
  inherited;
  if scSubCategory.LookUpValue <> '' then
    RefreshModel;
end;

procedure TInventoryCleanUp.scModelGroupSelectItem(Sender: TObject);
begin
  inherited;
  if scModelGroup.LookUpValue <> '' then
    RefreshModel;
end;

end.
