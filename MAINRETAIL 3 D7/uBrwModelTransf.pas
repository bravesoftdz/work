(*
-----------------------------------------------------------------------------------------------------
Version : (28? - 279)
Date    : 12.22.2010
Author  : Antonio Marcos Fernandes de Souza (amfsouza)
Issue   : Remove needs about press correct error.
Solution: Call automatic function to correct error.
Issue   : Column Imported not working ( nothing is have been done )
Solution: To set propertie was enough to work.
Version : (288 - 278)
-----------------------------------------------------------------------------------------------------
*)

unit uBrwModelTransf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEBROWSES, DB, DBTables, Buttons, Grids,
  DBGrids, StdCtrls, LblEffct, ExtCtrls, Mask,
  PanelRights, Menus, BrowseConfig, DateBox, ImgList, ADODB,
  RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu;

type
  TbrwModelTransf = class(TbrwParent)
    quBrowseIDModelTransf: TIntegerField;
    quBrowseSystemUser: TStringField;
    quBrowseStoreOrigem: TStringField;
    quBrowseStoreDestino: TStringField;
    quBrowseData: TDateTimeField;
    quBrowseStoreOrigPhone: TStringField;
    quBrowseStoreDestPhone: TStringField;
    quBrowseStoreOrigFax: TStringField;
    quBrowseStoreDestFax: TStringField;
    quBrowseStoreOrigContact: TStringField;
    quBrowseStoreDestContact: TStringField;
    Label3: TLabel;
    cmbStore: TSuperComboADO;
    btAreaTodas: TButton;
    lbFrom: TLabel;
    DateInicio: TDateBox;
    lbTo: TLabel;
    DateFim: TDateBox;
    grdBrowseDBIDModelTransf: TcxGridDBColumn;
    grdBrowseDBData: TcxGridDBColumn;
    grdBrowseDBStoreOrigem: TcxGridDBColumn;
    grdBrowseDBStoreDestino: TcxGridDBColumn;
    grdBrowseDBSystemUser: TcxGridDBColumn;
    grdBrowseDBStoreOrigPhone: TcxGridDBColumn;
    grdBrowseDBStoreDestPhone: TcxGridDBColumn;
    grdBrowseDBStoreOrigFax: TcxGridDBColumn;
    grdBrowseDBStoreDestFax: TcxGridDBColumn;
    grdBrowseDBStoreOrigContact: TcxGridDBColumn;
    grdBrowseDBStoreDestContact: TcxGridDBColumn;
    quBrowseTransferType: TBooleanField;
    quBrowseNumber: TStringField;
    quBrowseType: TStringField;
    grdBrowseDBNumber: TcxGridDBColumn;
    grdBrowseDBType: TcxGridDBColumn;
    btnPrintTransfer: TSpeedButton;
    Panel4: TPanel;
    quBrowseImported: TBooleanField;
    grdBrowseDBImported: TcxGridDBColumn;
    lbToStore: TLabel;
    scToStore: TSuperComboADO;
    btnToStore: TButton;
    btnImport: TSpeedButton;
    cmbType: TComboBox;
    lbType: TLabel;
    quBrowsePrintDate: TDateTimeField;
    quBrowseIDLojaOrigem: TIntegerField;
    quBrowseIDLojaDestino: TIntegerField;
    grdBrowseDBIDLojaOrigem: TcxGridDBColumn;
    grdBrowseDBIDLojaDestino: TcxGridDBColumn;
    quBrowseNotSaved: TIntegerField;
    grdBrowseDBNotSaved: TcxGridDBColumn;
    btnChangeNumber: TSpeedButton;
    quBrowseCFOPNum: TStringField;
    quBrowseCFOP: TStringField;
    grdBrowseDBCFOP: TcxGridDBColumn;
    grdBrowseDBCFOPNum: TcxGridDBColumn;
    quTransfModel: TADODataSet;
    grdBrowseDBPrintDate: TcxGridDBColumn;
    quBrowseMsgStatus: TStringField;
    grdBrowseDBMsgStatus: TcxGridDBColumn;
    btnCorrectError: TSpeedButton;
    spTranferOUT: TADOStoredProc;
    spTranferIN: TADOStoredProc;
    quBrowseOBS: TStringField;
    grdBrowseDBOBS: TcxGridDBColumn;
    procedure btRemoveClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DateInicioChange(Sender: TObject);
    procedure cmbStoreSelectItem(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure btnPrintTransferClick(Sender: TObject);
    procedure btnToStoreClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbTypeSelect(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure grdBrowseDBCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnChangeNumberClick(Sender: TObject);
    procedure dsBrowseDataChange(Sender: TObject; Field: TField);
    procedure btnCorrectErrorClick(Sender: TObject);
  private
    sIN, sOUT : String;
    sErroIncomplet, sErroLoja : String;
    sTransfHeader,
    sTransfNum : String;
    procedure PrintTransfer;
    function CanDeleteTransf: Boolean;
    procedure AdjustLot;
  protected
     procedure LoadImages; override;
  end;

implementation

{$R *.DFM}

uses uDM, uNewModelTransf, uFchTransferModel, uMsgBox, uMsgConstant,
     uSystemTypes, uDateTimeFunctions, uDMGlobal, uFrmPrintTranfer,
     uFrmImportTransferNumber, uPassword, uSystemConst;

function TbrwModelTransf.CanDeleteTransf : Boolean;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('SELECT Imported');
    SQL.Add('FROM ModelTransf (NOLOCK)');
    SQL.Add('WHERE IDModelTransf = ' + quBrowseIDModelTransf.AsString );
    SQL.Add('AND Imported = 1 AND TransferType = 0');
    Open;

    Result := not (RecordCount <> 0);

    Close;
  end;
end;

procedure TbrwModelTransf.btRemoveClick(Sender: TObject);
var
  iTransType : Boolean;
  sNum : String;
begin
  inherited;

  iTransType := quBrowseTransferType.AsBoolean;
  sNum       := quBrowseNumber.AsString;

  if not CanDeleteTransf then
  begin
    MsgBox(MSG_CRT_NO_DEL_TRASNFER, vbCritical + vbOkOnly);
    exit;
  end;

  // remove todo o Transfer
  if MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes then
  begin
    with DM.quFreeSQL do
    begin
      if Active then
        Close;

      try
        DM.ADODBConnect.BeginTrans;

        AdjustLot;

        if (iTransType) and (sNum <> '') then
        begin
          SQL.Text := 'UPDATE ModelTransf SET Imported = 0 WHERE Number = ' + QuotedStr(sNum);
          ExecSQL;
        end;

        SQL.Text := 'DELETE FROM ModelTransfDet WHERE IDModelTransf = ' + quBrowseIDModelTransf.AsString;
        ExecSQL;
        SQL.Text := 'DELETE FROM ModelTransf WHERE IDModelTransf = ' + quBrowseIDModelTransf.AsString;
        ExecSQL;
        SQL.Text := 'DELETE InventoryMov FROM ModelTransfDet MTD WHERE InventoryMov.DocumentID = ' + quBrowseIDModelTransf.AsString +
                    ' AND InventoryMov.InventMovTypeID in (7,8)';
        ExecSQL;
        DM.ADODBConnect.CommitTrans;
      except
        DM.ADODBConnect.RollbackTrans;
      end;
      ExecBrowseSQL(True);
    end;
  end;
end;

procedure TbrwModelTransf.btnExecClick(Sender: TObject);
begin
  inherited;
  if TestDate(DateInicio.Text) and TestDate(DateFim.Text) then
  begin
    aWhereBasicFilters[0] := ' MT.Data >= ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateInicio.Date))) + Chr(39) + ' AND ' +
                             ' MT.Data < ' + Chr(39) + FormatDateTime('mm/dd/yyyy',(Trunc(DateFim.Date)+1)) + Chr(39);

    if cmbStore.LookUpValue <> '' then
      aWhereBasicFilters[1] := 'MT.IDLojaOrigem = ' + cmbStore.LookUpValue
    else
      aWhereBasicFilters[1] := 'MT.IDLojaOrigem IN ('+ DM.fStore.StoreList +', 0)';

    if scToStore.LookUpValue <> '' then
      aWhereBasicFilters[2] := 'MT.IDLojaDestino = ' + scToStore.LookUpValue
    else
      aWhereBasicFilters[2] := 'MT.IDLojaDestino IN ('+ DM.fStore.StoreList +', 0)';

    if cmbType.ItemIndex = -1 then
      cmbType.ItemIndex := 2;

    case cmbType.ItemIndex of
         0: aWhereBasicFilters[3] := 'IsNull(MT.Imported, 0) = 0 AND MT.TransferType = 0';
         1: aWhereBasicFilters[3] := 'IsNull(MT.Imported, 0) = 1 AND MT.TransferType = 0';
         2: aWhereBasicFilters[3] := '';
    end;

    ExecBrowseSQL(True);
    DesativaAviso;
  end;
end;

procedure TbrwModelTransf.FormCreate(Sender: TObject);
begin
  inherited;
  brwForm := TFchTransferModel.Create(Self);

  DateInicio.Date := FirstDateMonth;
  DateFim.Date    := LastDateMonth;

  cmbStore.LookUpValue := intToStr(DM.fStore.ID);

  btnChangeNumber.Visible := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR);

  grdBrowseDBCFOP.Hidden    := not (DM.fSystem.SrvParam[PARAM_TAX_IN_COSTPRICE] and (DMGlobal.IDLanguage = LANG_PORTUGUESE));
  grdBrowseDBCFOPNum.Hidden := grdBrowseDBCFOP.Hidden;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sIN            := 'IN';
      sOUT           := 'OUT';
      sErroIncomplet := 'Transfer could not completed';
      sErroLoja      := 'No store selected';
      sTransfHeader  := 'Replace Transfer # ';
      sTransfNum     := 'New Transfer # :';
    end;

    LANG_PORTUGUESE:
    begin
      sIN            := 'Entrada';
      sOUT           := 'Saída';
      sErroIncomplet := 'Transferência incompleta';
      sErroLoja      := 'Não existe loja selecionada';
      sTransfHeader  := 'Trocar Nº Transf. ';
      sTransfNum     := 'Novo Nº Transf :';
    end;

    LANG_SPANISH:
    begin
      sIN            := 'Entrada';
      sOUT           := 'Salida';
      sErroIncomplet := 'Transferência incompleta';
      sErroLoja      := 'Não existe loja selecionada';
      sTransfHeader  := 'Trocar Nº Transf. ';
      sTransfNum     := 'Novo Nº Transf :';
    end;
  end;


end;

procedure TbrwModelTransf.DateInicioChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwModelTransf.cmbStoreSelectItem(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwModelTransf.btAreaTodasClick(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text        := '<'+btAreaTodas.Caption+'>';

  AtivaAviso;
end;

procedure TbrwModelTransf.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;
  if not quBrowseTransferType.AsBoolean then
    quBrowseType.AsString := sOUT
  else
    quBrowseType.AsString := sIN;


  if (quBrowseIDLojaOrigem.AsInteger = 0) or (quBrowseIDLojaDestino.AsInteger = 0) then
    quBrowseMsgStatus.AsString := sErroLoja
  else if quBrowseNotSaved.AsInteger <> 0 then
    quBrowseMsgStatus.AsString := sErroIncomplet
  else
    quBrowseMsgStatus.AsString := 'Ok';
    
end;

procedure TbrwModelTransf.LoadImages;
begin
  inherited;
  DM.imgBTN.GetBitmap(BTN_PRINT, btnPrintTransfer.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btnChangeNumber.Glyph);
  DM.imgBTN.GetBitmap(BTN_RESTORE, btnCorrectError.Glyph);
end;

procedure TbrwModelTransf.btnPrintTransferClick(Sender: TObject);
var
  bCanPrint: Boolean;
begin
  inherited;
  if (not quBrowse.Active) or (quBrowseIDModelTransf.AsInteger = 0) then
    Exit;

  bCanPrint := quBrowsePrintDate.IsNull;

  if bCanPrint or ((not bCanPrint) and Password.HasFuncRight(71)) then
  begin
    PrintTransfer;
    btnExecClick(Sender);
  end
  else
    MsgBox(MSG_CRT_NO_ACCESS, vbCritical + vbOKOnly);
end;

procedure TbrwModelTransf.btnToStoreClick(Sender: TObject);
begin
  inherited;
  scToStore.LookUpValue := '';
  scToStore.Text        := '<'+btAreaTodas.Caption+'>';

  AtivaAviso;
end;

procedure TbrwModelTransf.btnImportClick(Sender: TObject);
var
  IDTransfer : Integer;
begin
  inherited;
  IDTransfer := -1;
  with TFrmImportTransferNumber.Create(Self) do
  try
    if Start(IDTransfer) then
    begin
      brwForm.sParam := 'IDTransfer=' + IntToStr(IDTransfer) + ';';
      CommandClick(Self);
      brwForm.sParam := '';
    end;
  finally
    Free;
  end;
end;

procedure TbrwModelTransf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //Shor Cuts
  if Key = VK_F4 then
  begin //Del
    if (btRemove.Enabled) and (btRemove.Visible) then
      btRemoveClick(Self);
  end
  else
    inherited;
end;

procedure TbrwModelTransf.cmbTypeSelect(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TbrwModelTransf.PrintTransfer;
begin
  with TFrmPrintTransfer.Create(Self) do
    Start(quBrowseIDModelTransf.AsString);

  with DM.quFreeSQL do
  try
    if Active then
      Close;

    SQL.Text := 'UPDATE ModelTransf SET PrintDate = GetDate() WHERE IDModelTransf = ' + quBrowseIDModelTransf.AsString;
    ExecSQL;
  finally;
    Close;
  end;
end;

procedure TbrwModelTransf.CommandClick(Sender: TObject);
var
  bCanEdit: Boolean;
begin
  if TSpeedButton(Sender).Tag = 1 then
  begin
     bCanEdit := quBrowsePrintDate.IsNull;

    if bCanEdit or ((not bCanEdit) and Password.HasFuncRight(73)) then
      inherited
    else
      MsgBox(MSG_INF_NOT_MODI_PRINTED_TRANFER, vbCritical + vbOKOnly);
  end
  else
    inherited;
end;

procedure TbrwModelTransf.grdBrowseDBCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if (AViewInfo.GridRecord.Values[grdBrowseDBIDLojaOrigem.Index] = '0') or
     (AViewInfo.GridRecord.Values[grdBrowseDBIDLojaDestino.Index] = '0') or
     (AViewInfo.GridRecord.Values[grdBrowseDBNotSaved.Index] <> '0') then
    ACanvas.Font.Color := clRed;

end;

procedure TbrwModelTransf.btnChangeNumberClick(Sender: TObject);
var
  sSQL, sNewNumber : String;
begin
  inherited;

  if quBrowse.Active and (not quBrowse.IsEmpty) then
  begin
    sNewNumber := InputBox(sTransfHeader + '('+quBrowseNumber.AsString+')', sTransfNum, '');

    if sNewNumber <> '' then
    begin
      sSQL := 'UPDATE ModelTransf SET Number = ' + QuotedStr(sNewNumber) + ' WHERE IDModelTransf = ' + quBrowseIDModelTransf.AsString;
      DM.RunSQL(sSQL);
      ExecBrowseSQL(True);
      DesativaAviso;
    end;
  end;

end;

procedure TbrwModelTransf.AdjustLot;
begin

  with quTransfModel do
  try
    if Active then
      Close;
    Parameters.ParamByName('IDModelTransf').Value := quBrowseIDModelTransf.Value;
    Open;
    First;

    while not EOF do
    begin

      if FieldByName('IDLote').AsInteger <> 0 then
        if not FieldByName('TransferType').AsBoolean then //Saida = 7
        begin
          DM.FDMInventory.LotAdjust(FieldByName('IDModel').AsInteger,
                                 FieldByName('IDLojaOrigem').AsInteger,
                                 FieldByName('IDLote').AsInteger,
                                 FieldByName('Qty').AsFloat,
                                 2);
        end
        else
        begin
          DM.FDMInventory.LotAdjust(FieldByName('IDModel').AsInteger,
                                 FieldByName('IDLojaDestino').AsInteger,
                                 FieldByName('IDLote').AsInteger,
                                 FieldByName('Qty').AsFloat,
                                 3);
        end;

      Next;
    end;
  finally
    Close;
  end;
end;

procedure TbrwModelTransf.dsBrowseDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  //amfsouza 12.22.2010 - start automatic function to correct errors.
  if ( quBrowseMsgStatus.asString = sErroIncomplet ) then
      btnCorrectErrorClick(self);
 //  btnCorrectError.Visible := (quBrowseMsgStatus.AsString = sErroIncomplet);
end;

procedure TbrwModelTransf.btnCorrectErrorClick(Sender: TObject);
var
  iIDTransfer : Integer;
begin
  inherited;

  iIDTransfer := quBrowseIDModelTransf.AsInteger;
  try
    if not quBrowseTransferType.AsBoolean then
       begin
       with spTranferOUT do
          begin
          Parameters.ParamByName('@IDModelTransf').Value := iIDTransfer;
          ExecProc;
          end;
       end
    else
       begin
       with spTranferIN do
          begin
          Parameters.ParamByName('@IDModelTransf').Value := iIDTransfer;
          ExecProc;
          end;
       end;
  except
    raise;
    end;

  ExecBrowseSQL(True);
  DesativaAviso;
  quBrowse.Locate('IDModelTransf', iIDTransfer, []);

end;

end.
