unit ubrwPurchase;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeBrowses, ExtCtrls, BrowseConfig, Menus, Db,
  DBTables, PanelRights, StdCtrls, Mask, DateBox, LblEffct,
  Buttons, RadioButtonAll, ImgList, 
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu, uSystemTypes;

type
  TbrwPurchase = class(TbrwParent)
    Label1: TLabel;
    cbxDate: TComboBox;
    Label2: TLabel;
    scVendor: TSuperComboADO;
    spRemove: TADOStoredProc;
    scStore: TSuperComboADO;
    Label3: TLabel;
    quQuitacao: TADOQuery;
    btAreaTodas: TButton;
    Button1: TButton;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    grdBrowseDBIDPurchase: TcxGridDBColumn;
    grdBrowseDBDatePreReceiving: TcxGridDBColumn;
    grdBrowseDBVendorCode: TcxGridDBColumn;
    grdBrowseDBVendor: TcxGridDBColumn;
    grdBrowseDBSubTotal: TcxGridDBColumn;
    grdBrowseDBOtherCharges: TcxGridDBColumn;
    grdBrowseDBFreight: TcxGridDBColumn;
    grdBrowseDBStore: TcxGridDBColumn;
    grdBrowseDBTotal: TcxGridDBColumn;
    grdBrowseDBUserPreReceive: TcxGridDBColumn;
    grdBrowseDBUserFinalReceive: TcxGridDBColumn;
    grdBrowseDBDateFinalReceiving: TcxGridDBColumn;
    grdBrowseDBDocumentType: TcxGridDBColumn;
    grdBrowseDBDocumentNumber: TcxGridDBColumn;
    grdBrowseDBDocumentDate: TcxGridDBColumn;
    grdBrowseDBDocumentDueDate: TcxGridDBColumn;
    grdBrowseDBDocumentTotal: TcxGridDBColumn;
    grdBrowseDBIDPO: TcxGridDBColumn;
    btnPrintPurchase: TSpeedButton;
    Panel: TPanel;
    grdBrowseDBCFOP: TcxGridDBColumn;
    grdBrowseDBCFOPNum: TcxGridDBColumn;
    grdBrowseDBDiscount: TcxGridDBColumn;
    grdBrowseDBSubTotalCounted: TcxGridDBColumn;
    quBrowseIDPurchase: TIntegerField;
    quBrowseDatePreReceiving: TDateTimeField;
    quBrowseDateFinalReceiving: TDateTimeField;
    quBrowseVendorCode: TIntegerField;
    quBrowseVendor: TStringField;
    quBrowseSubTotal: TBCDField;
    quBrowseOtherCharges: TBCDField;
    quBrowseFreight: TBCDField;
    quBrowseIDPO: TIntegerField;
    quBrowseDiscount: TBCDField;
    quBrowseStore: TStringField;
    quBrowseTotal: TBCDField;
    quBrowseUserPreReceive: TStringField;
    quBrowseUserFinalReceive: TStringField;
    quBrowseDocumentType: TStringField;
    quBrowseDocumentNumber: TStringField;
    quBrowseDocumentDate: TDateTimeField;
    quBrowseDocumentDueDate: TDateTimeField;
    quBrowseDocumentTotal: TBCDField;
    quBrowseCFOPNum: TStringField;
    quBrowseCFOP: TStringField;
    quBrowseSubTotalCounted: TBCDField;
    procedure btnExecClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject); 
    procedure spHelpClick(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure scStoreSelectItem(Sender: TObject);
    procedure scVendorSelectItem(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure grdBrowseDBDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPrintPurchaseClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    bTemQuitacao: boolean;
  protected
    procedure OnBeforeCommandClick(pCommand : TBtnCommandType); override;
    procedure LoadImages; override;
  public
    iPurStatus : Integer;
  end;

implementation

uses uDM, uMsgBox, uFchPurchase, uMsgConstant, uDateTimeFunctions, uDMGlobal,
     uSystemConst, DateUtils, uFrmPrintReceiving;

{$R *.DFM}

procedure TbrwPurchase.btnExecClick(Sender: TObject);
var
  sDate : string;
begin
  inherited;

  quBrowse.ClearSuggest;

  (*
  if scVendor.LookUpValue = '' then
    aWhereBasicFilters[0] := ''
  else
    begin
      quBrowse.AddSuggest('IDFornecedor', scVendor.LookUpValue);
      aWhereBasicFilters[0] := 'PU.IDFornecedor = ' + scVendor.LookUpValue;
    end;

  if scStore.LookUpValue = '' then
    aWhereBasicFilters[1] := 'PU.IDStore IN ('+ DM.fStore.StoreList +')'
  else
    begin
      quBrowse.AddSuggest('IDStore', scStore.LookUpValue);
      aWhereBasicFilters[1] := 'PU.IDStore = ' + scStore.LookUpValue;
    end;

  Case cbxDate.ItemIndex of
    0 : sDate := 'PU.DatePreReceiving';
    1 : sDate := 'PU.DateFinalReceiving';
  end;

  Case iPurStatus of
    //Final e Pre Receive
    PURCHASE_PRE,
    PURCHASE_FINAL : aWhereBasicFilters[2] := 'PU.DateFinalReceiving IS NULL';
    //Complited
    PURCHASE_HISTORY : aWhereBasicFilters[2] := 'PU.DateFinalReceiving IS NOT NULL';
  end;

  aWhereBasicFilters[3] :=  sDate + ' >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                            sDate + ' < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);

  ExecBrowseSQL(True);
  *)
  // Antonio 05/01/2017
  quBrowse.Close();
  quBrowse.CommandText := dm.GetBrowseReceiving(scStore.LookUpValue, scVendor.LookUpValue,
                                 DateInicio.Date, DateFim.Date, (cbxDate.ItemIndex = 1));
  quBrowse.Open();

  DesativaAviso;

end;

procedure TbrwPurchase.FormShow(Sender: TObject);
begin
  inherited;

  //Type of Purchase 1 - Pre, 2 - Final, 3 - Complited
  brwForm.sParam := 'PurType='+IntToStr(iPurStatus)+';TemQuitacao=0;';

  Case iPurStatus of
     //PreReceive
     PURCHASE_PRE :
        begin
        cbxDate.ItemIndex := 0;
        cbxDate.Enabled   := False;
        end;
     //Final
     PURCHASE_FINAL :
        begin
        cbxDate.ItemIndex := 0;
        cbxDate.Enabled   := False;
        end;
     //Complited
     PURCHASE_HISTORY :
        begin
        cbxDate.ItemIndex := 1;
        cbxDate.Enabled   := True;
        end;
  end;

end;

procedure TbrwPurchase.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TFchPurchase.Create(self);

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  scStore.LookUpValue := intToStr(DM.fStore.ID);

  grdBrowseDBCFOP.Hidden    := not (DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] and (DMGlobal.IDLanguage = LANG_PORTUGUESE));
  grdBrowseDBCFOPNum.Hidden := grdBrowseDBCFOP.Hidden;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_PORTUGUESE:
    begin
      sUrlHelp  := 'http://www.mainretail.com.br/treinamento/Compras/Com_NovoRecebimento.htm';
      sUrlVideo := 'http://www.mainretail.com.br/treinamento/video/OC_Criando_Novo_Recebimento/Criando_um_Novo_Recebimento.htm';
    end;

    LANG_SPANISH :
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;
  end;


end;

procedure TbrwPurchase.spHelpClick(Sender: TObject);
begin
{
    Case iPurStatus of
      //Pre Receive
      PURCHASE_PRE : HelpContext := 1560;
      //Final Receive
      PURCHASE_FINAL : HelpContext :=1590;
      //Purchase History
      PURCHASE_HISTORY : HelpContext :=1620;
      end;
}
   inherited;

end;

procedure TbrwPurchase.btAreaTodasClick(Sender: TObject);
begin
  inherited;

  scStore.LookUpValue := '';
  scStore.Text        := '<'+btAreaTodas.Caption+'>';

  AtivaAviso;

end;

procedure TbrwPurchase.Button1Click(Sender: TObject);
begin
  inherited;

  scVendor.LookUpValue := '';
  scVendor.Text        := '<'+Button1.Caption+'>';

  AtivaAviso;

end;

procedure TbrwPurchase.DateInicioChange(Sender: TObject);
begin
  inherited;

  AtivaAviso;

end;

procedure TbrwPurchase.scStoreSelectItem(Sender: TObject);
begin
  inherited;

  AtivaAviso;

end;

procedure TbrwPurchase.scVendorSelectItem(Sender: TObject);
begin
  inherited;

  AtivaAviso;

end;

procedure TbrwPurchase.OnBeforeCommandClick(pCommand : TBtnCommandType);
begin
  inherited;

  // Primeiro testo se existe quitacao para o purchase
  if (pCommand in [btAlt, btExc]) then
     begin
     with quQuitacao do
        begin
          Close;
          Parameters.ParamByName('IDPurchase').Value := quBrowse.fieldByName('IDPurchase').Value;
          Open;
          bTemQuitacao := not IsEmpty;
          Close;
        end;
     end;

   brwForm.sParam := 'PurType='+IntToStr(iPurStatus)+';TemQuitacao='+IntToStr(Byte(bTemQuitacao))+';';

end;

procedure TbrwPurchase.btRemoveClick(Sender: TObject);
begin

  OnBeforeCommandClick(btExc);

  if bTemQuitacao then
  begin
    MsgBox(MSG_CRT_PURCHASE_HAS_PAYMENT, vbCritical + vbOkOnly);
    Exit;
  end;

  if iPurStatus = PURCHASE_HISTORY then
  begin
    if MsgBox(MSG_QST_CONFIRM_DELETE_PURCHASE, vbSuperCritical + vbYesNo) = vbNo then
      Exit;
  end
  else
  begin
    if MsgBox(MSG_QST_SURE, vbQuestion + vbYesNo) = vbNo then
      Exit;
  end;

  with spRemove do
    begin
      Parameters.ParamByName('@IDPurchase').Value := quBrowse.fieldByName('IDPurchase').Value;
      ExecProc;
    end;
  ExecBrowseSQL(True);

end;

procedure TbrwPurchase.CommandClick(Sender: TObject);
begin

  if ((not quBrowse.Active) and (quBrowse.IsEmpty)) and
     (TBtnCommandType(TComponent(Sender).Tag) <> btInc) then
     Exit;

  inherited;

end;

procedure TbrwPurchase.grdBrowseDBDblClick(Sender: TObject);
begin

  if (not quBrowse.Active) and (quBrowse.IsEmpty) then
     Exit;

  inherited;

end;

procedure TbrwPurchase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   case Key of
     VK_F4 : begin //Del
             if (btRemove.Enabled) and (btRemove.Visible) then
               btRemoveClick(Self);
             end;
     else
       inherited;
    end
end;

procedure TbrwPurchase.btnPrintPurchaseClick(Sender: TObject);
begin
  inherited;
  if (quBrowse.Active) and (not quBrowse.IsEmpty) then
    with TFrmPrintReceiving.Create(Self) do
      Start(quBrowse.FieldByName('IDPurchase').AsString);
end;

procedure TbrwPurchase.LoadImages;
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_PRINT, btnPrintPurchase.Glyph);
end;

procedure TbrwPurchase.btCloseClick(Sender: TObject);
begin
 inherited;
 quBrowse.close();
 close;

end;

end.
