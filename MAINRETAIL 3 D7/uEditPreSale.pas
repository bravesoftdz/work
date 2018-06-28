unit uEditPreSale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, ExtCtrls, DB, DBTables, Grids, DBGrids, StdCtrls, LblEffct,
  Buttons, uInvoice, uNewPreSales, ADODB, siComp, siLangRT, SMDBGrid, uFrmHistory,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TFrmEditPreSale = class(TFrmParent)
    quPreSale: TADOQuery;
    dsPreSale: TDataSource;
    quTestRefresh: TADOQuery;
    quTestRefreshInvoiceCount: TIntegerField;
    tmrRefresh: TTimer;
    quUnLockPreSale: TADOQuery;
    quPreSaleUn: TADOQuery;
    rgFaixa: TRadioGroup;
    btOK: TSpeedButton;
    quPreSaleUnIDPreSale: TIntegerField;
    quPreSaleUnPreSaleDate: TDateTimeField;
    btRemove: TSpeedButton;
    spPreSaleRemove: TADOStoredProc;
    btAdd: TSpeedButton;
    btViewInvent: TSpeedButton;
    quTestDelete: TADOQuery;
    quTestDeleteComissionID: TIntegerField;
    btUnlock: TSpeedButton;
    quPreSaleUnFirstName: TStringField;
    quPreSaleUnLastName: TStringField;
    spHelp: TSpeedButton;
    quTestOpenUser: TADOQuery;
    quTestOpenUsernOpenUser: TIntegerField;
    quTestOpenUsernOpenHoldCaixa: TIntegerField;
    pnInfo: TPanel;
    quTestLayaway: TADOQuery;
    quTestLayawayLayaway: TBooleanField;
    panel8: TPanel;
    btCancel: TSpeedButton;
    rbUndoHold: TRadioGroup;
    quHoldSplited: TADOQuery;
    quHoldSplitedIDPreSale: TIntegerField;
    quHoldSplitedPreSaleDate: TDateTimeField;
    quHoldSplitedSaleCode: TStringField;
    quHoldSplitedFirstName: TStringField;
    quHoldSplitedLastName: TStringField;
    quHoldSplitedIDCustomer: TIntegerField;
    btUndoHold: TSpeedButton;
    quHoldSplitedIDPreSaleParent: TIntegerField;
    quTestHoldSplited: TADODataSet;
    quTestHoldSplitedIDPreSale: TIntegerField;
    quTestHoldSplitedSaleCode: TStringField;
    quTestHoldSplitedIDInvoice: TIntegerField;
    spUndoDelivery: TADOStoredProc;
    btnJoinHold: TSpeedButton;
    btnViewRequest: TSpeedButton;
    quPreSaleIDPreSale: TIntegerField;
    quPreSalePreSaleDate: TDateTimeField;
    quPreSaleSaleCode: TStringField;
    quPreSalePessoa: TStringField;
    quPreSaleIDCustomer: TIntegerField;
    grdPreSalesDB: TcxGridDBTableView;
    grdPreSalesLevel1: TcxGridLevel;
    grdPreSales: TcxGrid;
    grdPreSalesDBIDPreSale: TcxGridDBColumn;
    grdPreSalesDBPreSaleDate: TcxGridDBColumn;
    grdPreSalesDBSaleCode: TcxGridDBColumn;
    grdPreSalesDBPessoa: TcxGridDBColumn;
    grdPreSalesDBIDCustomer: TcxGridDBColumn;
    quPreSaleCustomer: TStringField;
    quPreSaleFirstName: TStringField;
    quPreSaleLastName: TStringField;
    btBudget: TSpeedButton;
    procedure tmrRefreshTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure dsPreSaleDataChange(Sender: TObject; Field: TField);
    procedure rgFaixaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btRemoveClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btViewInventClick(Sender: TObject);
    procedure btUnlockClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure quPreSaleAfterOpen(DataSet: TDataSet);
    procedure rbUndoHoldClick(Sender: TObject);
    procedure quHoldSplitedAfterOpen(DataSet: TDataSet);
    procedure btUndoHoldClick(Sender: TObject);
    procedure btnJoinHoldClick(Sender: TObject);
    procedure btnViewRequestClick(Sender: TObject);
    procedure grdPreSalesDBDblClick(Sender: TObject);
    procedure quPreSaleAfterScroll(DataSet: TDataSet);
    procedure quPreSaleCalcFields(DataSet: TDataSet);
    procedure btBudgetClick(Sender: TObject);
  private
    //TRanslation
    sInvHold,
    sOpenHold,
    sChooseHold,
    sUnlockHold,
    sUnlockHolds,
    sHoldDiv,
    sSplitHold,
    sSplitHolds,
    sMovHold,
    sMovBHolds,
    sMovHolds : String;

    OldCountInvoice,
    iHelp           : Integer;
    MyPreSaleType   : Integer;
    FrmNewPreSales  : TFrmNewPreSales;
    FrmInvoice      : TFrmInvoice;
    procedure SelectHold;
    procedure UnSelectHold;
    procedure LoadImages;
  public
    procedure Start(PreSaleType : integer);
  end;

implementation

uses uDM, uSplitPreSale, uMovePreSale, uQueryInventory, uPassword, uMsgBox,
     uMsgConstant, uDMGlobal, uSystemConst, uSQLFunctions, uFrmJoinHold,
     uBrwSaleRequest, uFrmEstimated;

{$R *.DFM}

procedure TFrmEditPreSale.LoadImages;
begin
  DM.imgBTN.GetBitmap(BTN_ADD, btAdd.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btOK.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemove.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btCancel.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btUndoHold.Glyph);
  DM.imgBTN.GetBitmap(BTN_REFRESH, btnJoinHold.Glyph);

  DM.imgBTN.GetBitmap(BTN_LOCK, btUnlock.Glyph);
  DM.imgBTN.GetBitmap(BTN_INVENTORY, btViewInvent.Glyph);
  DM.imgBTN.GetBitmap(BTN_REQUEST, btnViewRequest.Glyph);
  DM.imgBTN.GetBitmap(BTN_BUDGET, btBudget.Glyph);  
end;

procedure TFrmEditPreSale.Start(PreSaleType : integer);
begin
  MyPreSaleType := PreSaleType;

  // Muda caracteristicas para pagamento do PreSale ou edicao
  case PreSaleType of
    SALE_PRESALE:
    begin
      dsPreSale.DataSet      := quPreSale;
      pnInfo.Caption         := sInvHold;
      lblSubMenu.Caption     := sInvHold;
      btOk.Caption           := sOpenHold;
      btRemove.Visible       := True;
      btUnlock.Visible       := True;
      btViewInvent.Visible   := True;
      rbUndoHold.Visible     := False;
      btnJoinHold.Visible    := True;
      btnViewRequest.Visible := True;
      if (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = CASHREG_TYPE_OFFICE) then
      begin
        MyPreSaleType       := SALE_CANCELED;
        btAdd.Visible       := False;
        btOK.Visible        := False;
        btRemove.Visible    := False;
        btCancel.Visible    := True;
        btUndoHold.Visible  := False;
        btBudget.Visible    := False;        
        rgFaixa.ItemIndex   := 2;
        rgFaixa.Visible     := False;
        rbUndoHold.Visible  := True;
      end;
    end;

    SALE_UNLOCK_PRESALE:
    begin
      dsPreSale.DataSet      := quPreSaleUn;
      pnInfo.Caption         := sChooseHold;
      lblSubMenu.Caption     := sUnlockHold;
      btOk.Top               := btAdd.Top;
      btOk.Caption           := sUnlockHolds;
      rgFaixa.ItemIndex      := 0;
      btAdd.Visible          := False;
      btRemove.Visible       := False;
      btUnlock.Visible       := False;
      btBudget.Visible       := False;      
      btViewInvent.Visible   := False;
      btCancel.Visible       := False;
      btUndoHold.Visible     := False;
      btnViewRequest.Visible := False;
      iHelp                := 1;
      if (DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] = CASHREG_TYPE_OFFICE) then
      begin
        rgFaixa.ItemIndex := 2;
        rgFaixa.Visible   := False;
      end;
    end;

    SALE_SPLIT_PRESALE:
    begin
      dsPreSale.DataSet      := quPreSale;
      pnInfo.Caption         := sHoldDiv;
      lblSubMenu.Caption     := sSplitHold;
      btOk.Top               := btAdd.Top;
      btOk.Caption           := sSplitHolds;
      rgFaixa.ItemIndex      := 0;
      btAdd.Visible          := False;
      btRemove.Visible       := False;
      btViewInvent.Visible   := False;
      btUnlock.Visible       := False;
      btBudget.Visible       := False;      
      btCancel.Visible       := False;
      btUndoHold.Visible     := False;
      btnViewRequest.Visible := False;
    end;

    SALE_MOVE_PRESALE:
    begin
      dsPreSale.DataSet      := quPreSale;
      pnInfo.Caption         := sMovHold;
      lblSubMenu.Caption     := sMovBHolds;
      btOk.Top               := btAdd.Top;
      btOk.Caption           := sMovHolds;
      rgFaixa.ItemIndex      := 0;
      btAdd.Visible          := False;
      btRemove.Visible       := False;
      btViewInvent.Visible   := False;
      btUnlock.Visible       := False;
      btBudget.Visible       := False;      
      btCancel.Visible       := False;
      btUndoHold.Visible     := False;
      btnViewRequest.Visible := False;
    end;
  end;

  ShowModal;
end;

procedure TFrmEditPreSale.rgFaixaClick(Sender: TObject);
var
  MyFaixa, OldID: integer;
  sWhere: String;
begin
  inherited;
  OldID := 0;

  with TADOQuery(dsPreSale.DataSet) do
  begin
    if Active then
      OldID := FieldByName('IDPreSale').AsInteger;

    Close;

    sWhere := 'I.IDInvoice Is Null ' +
              ' AND I.IDStore =  ' + IntToStr(DM.fStore.ID);

    if DM.fSystem.SrvParam[PARAM_SALE_SCREEN_TYPE] <> CASHREG_TYPE_OFFICE then
      case rgFaixa.ItemIndex of
        0 : sWhere := sWhere + ' AND I.PreSaleDate > ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Now)); //Today
        1 : sWhere := sWhere + ' AND I.Layaway = 0'; //All Holds
        2 : sWhere := sWhere + ' AND I.Layaway = 1'; //Layaway
      end;

    case MyPreSaleType of
      SALE_UNLOCK_PRESALE : sWhere := sWhere + ' AND (( I.nOpenUser <> 0) OR ( I.nOpenHoldCaixa <> 0))';
      SALE_CANCELED : sWhere := sWhere + ' AND I.Canceled = 0 AND I.IDPreSaleParent IS NULL ';
      else sWhere := sWhere + ' AND I.Canceled = 0';
    end;

    SQL.Text := ChangeWhereClause(SQL.Text,sWhere,True);
    Open;

    //sql.SaveToFile('c:\MRbackup\openholds.sql');

    try
      Locate('IDPreSale', OldID, []);
    except
    end;
  end;
end;

procedure TFrmEditPreSale.dsPreSaleDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (TADOQuery(dsPreSale.DataSet).Eof and
      TADOQuery(dsPreSale.DataSet).Bof) then
  begin
    grdPreSales.Brush.Color := clBtnFace;
    grdPreSales.Enabled := False;
    btOk.Enabled := False;
    btRemove.Enabled := btOk.Enabled;
  end
  else
  begin
    grdPreSales.Brush.Color := clWindow;
    grdPreSales.Enabled := True;
  end;
end;

procedure TFrmEditPreSale.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmEditPreSale.FormShow(Sender: TObject);
begin
  inherited;
  quTestRefresh.Open;
  OldCountInvoice := quTestRefreshInvoiceCount.asInteger;
  quTestRefresh.Close;

  tmrRefresh.Enabled := True;

  rgFaixaClick(Nil);

  // ** Isto é porque não estamos pedindo mais a senha na entrada
  PassWord.MyMenuItem    := 2;
  PassWord.MySubMenuItem := 1;

  Screen.Cursor := crDefault;
end;

procedure TFrmEditPreSale.btOkClick(Sender: TObject);
begin
  inherited;
  tmrRefresh.Enabled := False;

  try
    Screen.Cursor := crHourGlass;

    case MyPreSaleType of
      SALE_PRESALE:
      begin
        if not (btOK.Visible) or not (btOK.Enabled) then
          Exit;
        if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
          FrmInvoice.Start(quPreSaleIDPreSale.AsInteger, MyPreSaleType, 0, False);
      end;

      SALE_UNLOCK_PRESALE:
      begin
        with quUnLockPreSale do
        begin
          if (MsgBox(MSG_QST_CONFIRM_UNLOCK_PRESALE, vbYesNo + vbQuestion) = vbYes) then
            Parameters.ParambyName('IDPreSale').Value := quPreSaleUnIDPreSale.AsInteger;
          ExecSQL;
        end;
      end;

      SALE_SPLIT_PRESALE:
      begin
        with TSplitPreSale.Create(Self) do
          Start(quPreSaleIDPreSale.AsInteger,
                quPreSaleIDCustomer.AsInteger,
                quPreSalePessoa.AsString, '');
      end;

      SALE_MOVE_PRESALE:
      begin
        with TMovePreSale.Create(Self) do
         Start(quPreSaleIDPreSale.AsInteger,
               quPreSalePessoa.AsString);
      end;
    end;
  finally
    FormShow(Nil);
  end;
end;

procedure TFrmEditPreSale.FormCreate(Sender: TObject);
begin
  inherited;
  LoadImages;
  tmrRefresh.Enabled := False;
  FrmInvoice     := TFrmInvoice.Create(Self);
  FrmNewPreSales := TFrmNewPreSales.Create(Self);
  FrmNewPreSales.FrmInvoice := FrmInvoice;
  //Help default
  iHelp := 0;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sInvHold     := 'Invoices on Hold.';
      sOpenHold    := 'F3   &Open Hold';
      sChooseHold  := 'Choose a hold to UnLock.';
      sUnlockHold  := 'UnLock Hold';
      sUnlockHolds := 'F10    &UnLock Hold';
      sHoldDiv     := 'Choose a hold and divide by half.';
      sSplitHold   := 'Split Hold';
      sSplitHolds  := 'F3   &Split Hold';
      sMovHold     := 'Choose a hold and move the items to another hold.';
      sMovBHolds   := 'Move between Hold';
      sMovHolds    := 'F3   &Move Hold';
    end;

    LANG_PORTUGUESE:
    begin
      sInvHold     := 'Pedidos abertos';
      sOpenHold    := 'F3 Destravar';
      sChooseHold  := 'Escolha um pedido para desbloquear';
      sUnlockHold  := 'Destravar Nota';
      sUnlockHolds := 'F10 &Destravar Pedido';
      sHoldDiv     := 'Escolha uma Nota e divida à metade.';
      sSplitHold   := 'Separar Nota';
      sSplitHolds  := 'F3 &Separar Nota';
      sMovHold     := 'Escolha uma Nota e mexa os itens para outra Nota.';
      sMovBHolds   := 'Mexa entre Notas';
      sMovHold     := 'F3 &Mexa Nota';
    end;

    LANG_SPANISH:
    begin
      sInvHold     := 'Boletas Pendientes.';
      sOpenHold    := 'F3 Abrir B&oleta';
      sChooseHold  := 'Escoja una Boleta para Desbloquear.';
      sUnlockHold  := 'Desbloquear Boleta';
      sUnlockHolds := 'F10  Desbloq&uear Boleta';
      sHoldDiv     := 'Escoja una Boleta y divídala a la mitad.';
      sSplitHold   := 'Separar Boleta';
      sSplitHolds  := 'F3 &Separar Boleta';
      sMovHold     := 'Escoja una Boleta y mueva los items a otra Boleta.';
      sMovBHolds   := 'Mover entre Boletas';
      sMovHold     := 'F3 &Mover Boleta';
    end;
  end;
end;

procedure TFrmEditPreSale.FormDestroy(Sender: TObject);
begin
  inherited;
  TADOQuery(dsPreSale.DataSet).Close;
  quHoldSplited.Close;  
  FrmInvoice.Free;
  FrmNewPreSales.Free;
end;

procedure TFrmEditPreSale.SelectHold;
begin

end;

procedure TFrmEditPreSale.UnSelectHold;
begin
  btOK.Enabled     := False;
  btRemove.Enabled := btOk.Enabled;
end;

procedure TFrmEditPreSale.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  tmrRefresh.Enabled := False;

  Screen.Cursor := crDefault;
  Action := caFree;
end;

procedure TFrmEditPreSale.tmrRefreshTimer(Sender: TObject);
begin
  inherited;
  with quTestRefresh do
  begin
    Close;
    Open;
    if quTestRefreshInvoiceCount.AsInteger <> OldCountInvoice then
    begin
      MessageBeep(0);
      OldCountInvoice := FieldByName('InvoiceCount').AsInteger;
      rgFaixaClick(nil);
    end;
    Close;
  end;
end;

procedure TFrmEditPreSale.btRemoveClick(Sender: TObject);
var
  IDCOmission, nUser : integer;
begin
  inherited;

  if (Password.Start(Password.MyMenuItem, Password.MySubMenuItem)) and
     (not Password.HasFuncRight(88)) then
  begin
    MsgBox (MSG_INF_MANAGER_CAN_REMOV_HOLD, vbOkOnly);
    Exit;
  end;

  if (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
  begin
    //Rodrigo Verifica se o Hold esta sendo pago antes de Deletar
    with quTestOpenUser do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale').Value := quPreSaleIDPreSale.AsInteger;
      Open;

      if quTestOpenUsernOpenHoldCaixa.AsInteger > 0 then
      begin
        MsgBox(MSG_INF_HOLD_PAYING_NO_DELETE, vbOKOnly + vbInformation);
        Close;
        Exit;
      end;

      if quTestOpenUsernOpenUser.AsInteger > 0 then
      begin
        MsgBox(MSG_INF_HOLD_CANNOT_DELETE, vbOKOnly + vbInformation);
        Close;
        Exit;
      end;

      Close;
    end;

    with quTestLayaway do
    begin
      if Active then
        Close;
      Parameters.ParambyName('IDPreSale').Value := quPreSaleIDPreSale.AsInteger;
      Open;

      if (not IsEmpty) and quTestLayawayLayaway.Value then
      begin
        MsgBox(MSG_INF_LAYAWAY_HAS_HIST, vbOKOnly + vbInformation);
        Close;
        exit;
      end;

      Close;
    end;

    if not Password.HasFuncRight(15) then
    begin
      // Testa se so existe itens do mesmo vendedor
      with quTestDelete do
      begin
        Close;
        Parameters.ParambyName('IDPreSale').Value := quPreSaleIDPreSale.AsInteger;
        Open;
        nUser       := RecordCount;
        IDCOmission := quTestDeleteComissionID.AsInteger;
        Close;
      end;
      if (nUser <= 1) and (IDComission <> DM.fUser.IDCommission) then
      begin
        MsgBox(MSG_INF_NOT_DELETE_ITEMS, vbOKOnly + vbInformation);
        Exit;
      end
      else if nUser > 1 then
      begin
        MsgBox(MSG_INF_NOT_DELETE_ITEMS, vbOKOnly + vbInformation);
        Exit;
      end
    end;

    DM.fPOS.DeleteHold(quPreSaleIDPreSale.AsInteger, DM.fUser.ID);
    
    {
    with spPreSaleRemove do
    begin
      Parameters.ParambyName('@PreSaleID').Value := quPreSaleIDPreSale.AsInteger;
      ExecProc;
    end;}

    rgFaixaClick(nil);
  end;
end;

procedure TFrmEditPreSale.btAddClick(Sender: TObject);
begin
  inherited;
  //Desabilitar o timer Para nao ficar lento
  tmrRefresh.Enabled := False;

  //Adiciona um novo Hold
  Screen.Cursor := crHourGlass;
  
  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    FrmNewPreSales.Start(0, INVOICE_ALL, False);
    rgFaixaClick(nil);
  end;

  Screen.Cursor := crDefault;

  //Habilitar o timer Para nao ficar lento
  tmrRefresh.Enabled := True;
end;

procedure TFrmEditPreSale.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of
    vk_Return:
    begin
      if btOK.Enabled then
        btOkClick(nil);
      end;

    VK_F2:
    begin //Add New
      if btAdd.Enabled then
        btAddClick(nil);
    end;

    VK_F3:
    begin //Detail
      if btOk.Enabled then
        btOkClick(nil);
    end;

    VK_F4:
    begin //Remove
      if btRemove.Enabled then
        btRemoveClick(nil);
    end;

    VK_F5:
    begin //Orçamento
      if btBudget.Enabled then
        btBudgetClick(nil);
    end;

    VK_F9:
    begin
      btnViewRequestClick(Self);
    end;

    VK_F10:
    begin //Un Lock
      case MyPreSaleType of
        SALE_PRESALE:
        begin
          if btUnlock.Enabled then
            btUnlockClick(nil);
        end;

        SALE_UNLOCK_PRESALE:
        begin
          if btOk.Enabled then
            with quUnLockPreSale do
            begin
              if (MsgBox(MSG_QST_CONFIRM_UNLOCK_PRESALE, vbYesNo + vbQuestion) = vbYes) then
                Parameters.ParambyName('IDPreSale').Value := quPreSaleUnIDPreSale.AsInteger;
              ExecSQL;
            end;
        end;
      end;//and Case
    end;

    VK_F11:
    begin //View Inventory
      if btViewInvent.Enabled then
        btViewInventClick(nil);
      end;

    VK_F12:
    begin
      btnJoinHoldClick(Self);
    end;
  end;
end;

procedure TFrmEditPreSale.btViewInventClick(Sender: TObject);
begin
  inherited;
  if Password.Start(Password.MyMenuItem, Password.MySubMenuItem) then
  begin
    Screen.Cursor := crHourGlass;

    with TQueryInventory.Create(Self) do
      ShowModal;

    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmEditPreSale.btUnlockClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;

  // chama unlock
  with TFrmEditPreSale.Create(Self) do
    Start(SALE_UNLOCK_PRESALE);

  Screen.Cursor := crDefault;
end;

procedure TFrmEditPreSale.spHelpClick(Sender: TObject);
begin
  inherited;
  case iHelp of
    0: Application.HelpContext(1170); //Hold
    1: Application.HelpContext(1230); //Unlock
  end;
end;

procedure TFrmEditPreSale.btCancelClick(Sender: TObject);
var
  sHistParam: String;
  dDate: TDateTime;
begin
  inherited;
  if quPreSale.IsEmpty then
    Exit;

  with TFrmHistory.Create(Self) do
    if Start(2, quPreSaleIDPreSale.AsInteger, DM.fUser.ID, Date, quPreSaleSaleCode.AsString, sHistParam, dDate) then
    begin
      DM.fPOS.CancelHold(quPreSaleIDPreSale.AsInteger, DM.fUser.ID);
      rgFaixaClick(Nil);
    end;
end;

procedure TFrmEditPreSale.quPreSaleAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if btCancel.Visible then
    btCancel.Enabled := not DataSet.IsEmpty;
end;

procedure TFrmEditPreSale.rbUndoHoldClick(Sender: TObject);
begin
  inherited;
  case rbUndoHold.ItemIndex of
    0:
    begin
      btUndoHold.Visible := False;
      btCancel.Visible   := True;
      dsPreSale.DataSet  := quPreSale;
      rgFaixaClick(Sender);
    end;
    1:
    begin
      btUndoHold.Visible := True;
      btCancel.Visible   := False;
      dsPreSale.DataSet := quHoldSplited;
      with quHoldSplited do
      begin
        if Active then
          Close;
        quHoldSplited.Parameters.ParamByName('IDStore').Value := DM.fStore.ID;
        Open;
      end;
    end;
  end;
end;

procedure TFrmEditPreSale.quHoldSplitedAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if btUndoHold.Visible then
    btUndoHold.Enabled := not DataSet.IsEmpty;
end;

procedure TFrmEditPreSale.btUndoHoldClick(Sender: TObject);
var
  sSQL: String;
begin
  inherited;
  if quHoldSplited.Active and (quHoldSplited.RecordCount>=1) then
  begin
    with quTestHoldSplited do
    begin
      Parameters.ParamByName('IDPreSaleParent').Value := quHoldSplitedIDPreSaleParent.AsInteger;
      try
        Open;
        if quTestHoldSplitedIDInvoice.AsInteger <> 0 then
        begin
          MsgBox(MSG_CRT_HOLD_PAID, vbOKOnly + vbInformation);
          Exit;
        end;
      finally
        Close;
      end;
    end;

    with spUndoDelivery do
    begin
      Parameters.ParamByName('@IDPreSaleNew').Value := quHoldSplitedIDPreSaleParent.AsInteger;
      Parameters.ParamByName('@IDPreSaleOld').Value := quHoldSplitedIDPreSale.AsInteger;
      Parameters.ParamByName('@IDUser').Value       := DM.fUser.ID;
      ExecProc;
    end;
    
    MsgBox(MSG_INF_DATA_SUCESSFULY, vbOKOnly + vbInformation);
  end;
end;

procedure TFrmEditPreSale.btnJoinHoldClick(Sender: TObject);
var
 IDPreSale, IDUser: Integer;
begin
  inherited;
  if Password.AquireAccess(57, MSG_CRT_NO_ACCESS, IDUser, True) then
    if (rgFaixa.ItemIndex <> 2) and (quPreSale.Active and (not quPreSale.IsEmpty)) then
    begin
      IDPreSale := quPreSaleIDPreSale.AsInteger;
      with TFrmJoinHold.Create(Self) do
        if StartJoinAll(IDPreSale) then
        begin
          quPreSale.Close;
          quPreSale.Open;
        end;
    end;
end;

procedure TFrmEditPreSale.btnViewRequestClick(Sender: TObject);
begin
  inherited;
  if Password.Start(2, 3) then
  begin
    Screen.Cursor := crHourGlass;
    with TBrwSaleRequest.Create(Self) do
      Start;
    Screen.Cursor := crDefault;
  end;
end;

procedure TFrmEditPreSale.grdPreSalesDBDblClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  btOkClick(nil);
end;

procedure TFrmEditPreSale.quPreSaleAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btOK.Enabled := not dsPreSale.DataSet.IsEmpty;
  btRemove.Enabled := btOk.Enabled;
end;

procedure TFrmEditPreSale.quPreSaleCalcFields(DataSet: TDataSet);
begin
  inherited;
  if (quPreSaleFirstName.AsString <> '') or (quPreSaleLastName.AsString <> '') then
  begin
    if DMGlobal.IDLanguage = LANG_ENGLISH then
      quPreSalePessoa.AsString := quPreSaleLastName.AsString + ', ' + quPreSaleFirstName.AsString
    else
      quPreSalePessoa.AsString := quPreSaleFirstName.AsString + ' ' + quPreSaleLastName.AsString;
  end
  else
    quPreSalePessoa.AsString := quPreSaleCustomer.AsString;
end;

procedure TFrmEditPreSale.btBudgetClick(Sender: TObject);
begin
  inherited;
  if Password.Start(2, 1) then
    with TFrmEstimated.Create(Self) do
      Start;
end;

end.
