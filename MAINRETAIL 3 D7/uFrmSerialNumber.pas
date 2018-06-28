unit uFrmSerialNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uDialogParent, siComp, siLangRT, StdCtrls, ExtCtrls, ComCtrls,
  Buttons, Grids, DBGrids, SMDBGrid, DB, ADODB, PowerADOQuery, CheckLst,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid;

Const
  SERIAL_HOLD         = 2;
  SERIAL_INVOICE      = 3;
  SERIAL_PURCHASE     = 4;
  SERIAL_REFOUND      = 5;

type
  TFrmSerialNumber = class(TDialogParent)
    pgSerial: TPageControl;
    tsOnSale: TTabSheet;
    tsInventory: TTabSheet;
    tsTransfer: TTabSheet;
    pnlQty: TPanel;
    Label3: TLabel;
    editQty: TEdit;
    Label2: TLabel;
    EditMaxQty: TEdit;
    quSerialPreMov: TADOQuery;
    quSerialPreMovPreInventoryMovID: TIntegerField;
    quSerialPreMovSerialNumber: TStringField;
    quSerialMov: TADOQuery;
    quSerialMovInventoryMovID: TIntegerField;
    quSerialMovSerialNumber: TStringField;
    dsSerial: TDataSource;
    Panel3: TPanel;
    Label1: TLabel;
    edtSerial: TEdit;
    btnInvSerial: TSpeedButton;
    btAdd: TSpeedButton;
    btRemove: TSpeedButton;
    quInventorySerial: TADOQuery;
    quInventorySerialName: TStringField;
    quInventorySerialSerial: TStringField;
    quInventorySerialStoreID: TIntegerField;
    dsInvSerial: TDataSource;
    spHelp: TSpeedButton;
    Bevel2: TBevel;
    quSNPurchase: TADOQuery;
    quSNPurchaseIDPurchaseItemSerial: TIntegerField;
    quSNPurchaseIDPurchaseItem: TIntegerField;
    quSNPurchaseIDPurchase: TIntegerField;
    quSNPurchaseSerialNumber: TStringField;
    quSNStoreOrigem: TADOQuery;
    quSNStoreOrigemModelID: TIntegerField;
    quSNStoreOrigemStoreID: TIntegerField;
    quSNStoreOrigemSerial: TStringField;
    clbSerial: TCheckListBox;
    Label4: TLabel;
    cmdAddAccount: TADOCommand;
    grdInvSerialDBTableView: TcxGridDBTableView;
    grdInvSerialLevel: TcxGridLevel;
    grdInvSerial: TcxGrid;
    grdInvSerialDBTableViewName: TcxGridDBColumn;
    grdInvSerialDBTableViewSerial: TcxGridDBColumn;
    quSerialMovIdentificationNumber: TStringField;
    quSerialPreMovIdentificationNumber: TStringField;
    grdSerial: TcxGrid;
    grdSerialDBTableView: TcxGridDBTableView;
    grdSerialLevel: TcxGridLevel;
    lblIdent: TLabel;
    edtIdent: TEdit;
    grdSerialDBTableViewSerialNumber: TcxGridDBColumn;
    grdSerialDBTableViewIdentificationNumber: TcxGridDBColumn;
    cmdAddTransfSerial: TADOCommand;
    dsGrid: TDataSource;
    edtRest: TEdit;
    Label5: TLabel;
    procedure edtSerialChange(Sender: TObject);
    procedure btnInvSerialClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quSerialPreMovNewRecord(DataSet: TDataSet);
    procedure CancelarClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure quSerialMovAfterPost(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure dsSerialDataChange(Sender: TObject; Field: TField);
    procedure quSNPurchaseAfterPost(DataSet: TDataSet);
    procedure quSNStoreOrigemAfterOpen(DataSet: TDataSet);
    procedure clbSerialClickCheck(Sender: TObject);
    procedure edtSerialEnter(Sender: TObject);
    procedure edtSerialExit(Sender: TObject);
    procedure edtSerialKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure quSerialPreMovAfterScroll(DataSet: TDataSet);
    procedure dsGridDataChange(Sender: TObject; Field: TField);
    procedure AplicarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    canCloseForm: Boolean;
    FListFromPreInventoryOnSameSale: TStringList;
    FListSerialNumber: TStringList;
    fIDModel     : Integer;
    fIDStore     : Integer;
    fIDItem      : Integer;
    fStartType   : Integer;

    //PreSale, Sale
    FquSerialMovGrid: TADOQuery;
    FquSerialPreMovGrid: TADOQuery;

    FDocument    : String;
    fMaxQty      : Double;
    fRestSerialsPerSale: Double;
    fquSerial    : TADOQuery;
    fSerialNum   : String;
    fSNExist     : String;
    fGiftCard    : Boolean;

    //Purchase
    fIDPurchase  : Integer;

    //Transfer
    fIDModelTransfDet: Integer;
    fIDStoreDest : Integer;
    fCountCheck  : Integer;

    procedure InventorySerialOpen;
    procedure InventorySerialClose;

    procedure SerialMovOpen;
    procedure SerialMovClose;
    procedure SerialMovRefresh;

    procedure PurchaseSerialOpen;
    procedure PurchaseSerialClose;

    procedure TransferOpen;
    procedure TransferClose;
    procedure GetSerialRights;
    procedure SetSerialRights;

    //amfsouza 12.20.2011
    function getCountSerialNumbers(idPreInv: Integer): Integer;

    //amfsouza 12.01.2011
    function getFirstIDPreInvOnSale(document: Integer): Integer;

    function TestAccountNumber(Number:String):Boolean;
    function InsertAccountNumber(IDPreInvMov : Integer; Number:String):Boolean;
    function DeleteAccountNumber(Number:String):Boolean;
    function TestInventorySerial:Boolean;
    function TestPurchaseSerial:Boolean;
    function TestPurchaseItemSerial: Boolean;
    function DeleteSNTranf(Number: String): Boolean;
  public
    { Public declarations }

    procedure setListFromPreInventoryMovOnSameSale(list: TStringList);

    function StartOnPurchase(IDItem,
                             IDPurchase,
                             IDModel,
                             IDStore : Integer;
                             MaxQty: Double):Boolean;
    function StartInventory(IDModel,IDStore : Integer):String;
    function StartOnSales(StartType  : Integer;
                          IDModel    : Integer;
                          IDStore    : Integer;
	                        MaxQty     : Double;
                          IDItem     : Integer;
                          Document   : Integer = 0) : Boolean;
    function StartOnTransfer(IDModel,
                             IDStoreOri,
                             IDStoreDest,
                             IDModelTranfDet : Integer;
                             MaxQty : Double):Boolean;
    function getListSerialNumbers: TStringList;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uPassword, uSystemConst,
  DateUtils, uDMParent;

{$R *.dfm}

procedure TFrmSerialNumber.PurchaseSerialOpen;
begin
  with quSNPurchase do
    if not Active then
    begin
      Parameters.ParamByName('IDPurchaseItem').Value := fIDItem;
      Parameters.ParamByName('IDPurchase').Value     := fIDPurchase;
      Open;
    end;
end;

procedure TFrmSerialNumber.PurchaseSerialClose;
begin
  with quSNPurchase do
    if Active then
      Close;
end;

procedure TFrmSerialNumber.InventorySerialOpen;
begin
  with quInventorySerial do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := fIDModel;
      Parameters.ParamByName('IDStore').Value := fIDStore;
      Open;
    end;
end;

procedure TFrmSerialNumber.InventorySerialClose;
begin
  with quInventorySerial do
    if Active then
      Close;
end;

procedure TFrmSerialNumber.TransferOpen;
begin
  with quSNStoreOrigem do
    if not Active then
    begin
      Parameters.ParamByName('IDModel').Value := fIDModel;
      Parameters.ParamByName('IDStore').Value := fIDStore;
      Open;
    end;
end;

procedure TFrmSerialNumber.TransferClose;
begin
  with quSNStoreOrigem do
    if Active then
      Close;
end;

procedure TFrmSerialNumber.GetSerialRights;
var
  slSelectStore: TStringList;
begin
  try
    slSelectStore := TStringList.Create;
    clbSerial.Items.Clear;
    with quSNStoreOrigem do
      while not EOF do
      begin
        clbSerial.Items.Add(quSNStoreOrigemSerial.AsString);
        Next;
      end;
  finally
    slSelectStore.Free;
  end;
end;

procedure TFrmSerialNumber.SetSerialRights;
var
  sNewIn: String;
  i: integer;
begin
  sNewIn := '';

  with clbSerial do
    for i := 0 to Items.Count-1 do
      if Checked[i] then
      begin
        DeleteSNTranf(clbSerial.Items.Strings[i]);
        with cmdAddTransfSerial do
        begin
          Parameters.ParamByName('IDModelTransfSerial').Value := DM.GetNextID(MR_MODEL_TRANSF_SERIAL_ID);
          Parameters.ParamByName('IDModelTransfDet').Value    := fIDModelTransfDet;
          Parameters.ParamByName('SerialNum').Value           := clbSerial.Items.Strings[i];
          Execute;
        end;
      end;

end;


function TFrmSerialNumber.StartOnTransfer(IDModel, IDStoreOri, IDStoreDest, IDModelTranfDet: Integer;
  MaxQty: Double): Boolean;
begin
  fIDStoreDest := IDStoreDest;
  fIDModel     := IDModel;
  fIDStore     := IDStoreOri;
  fMaxQty      := MaxQty;
  fCountCheck  := 0;
  fIDModelTransfDet := IDModelTranfDet;

  tsOnSale.TabVisible     := False;
  pnlQty.Visible          := True;
  tsInventory.TabVisible  := False;
  tsTransfer.TabVisible   := True;

  EditMaxQty.Text := FormatFloat('0.#####',fMaxQty);

  TransferOpen;

  Result := (ShowModal = mrOK);

  if Result then
    SetSerialRights;

  TransferClose;
end;

function TFrmSerialNumber.StartOnPurchase(IDItem, IDPurchase, IDModel,
  IDStore: Integer; MaxQty: Double): Boolean;
begin
  fIDPurchase := IDPurchase;
  fIDItem     := IDItem;
  fIDModel    := IDModel;
  fIDStore    := IDStore;
  fMaxQty     := MaxQty;
  fStartType  := SERIAL_PURCHASE;

  fquSerial   := quSNPurchase;

  dsSerial.DataSet := fquSerial;
  //TODO
  //gridSerial.Columns[0].FieldName := quSNPurchaseIDPurchaseItemSerial.FieldName;

  tsOnSale.TabVisible     := True;
  pnlQty.Visible          := True;
  tsInventory.TabVisible  := False;
  tsTransfer.TabVisible   := False;
  btnInvSerial.Visible    := False;

  EditMaxQty.Text := FormatFloat('0.#####', fMaxQty);

  PurchaseSerialOpen;

  Result := (ShowModal = mrOK);

  SerialMovClose;
  PurchaseSerialClose;
end;

function TFrmSerialNumber.StartInventory(IDModel,IDStore : Integer):String;
begin
  fIDModel := IDModel;
  fIDStore := IDStore;

  InventorySerialOpen;

  tsInventory.TabVisible := True;
  tsOnSale.TabVisible    := False;
  tsTransfer.TabVisible  := False;
  pnlQty.Visible         := False;

  if (ShowModal = mrOK) then
    Result := quInventorySerialSerial.AsString;

  InventorySerialClose;
end;

procedure TFrmSerialNumber.SerialMovRefresh;
begin
  SerialMovClose;
  SerialMovOpen;
end;

procedure TFrmSerialNumber.SerialMovOpen;
begin
  with fquSerial do
    if not Active then
    begin
      Parameters.Items[0].Value := fIDItem;
      Open;
    end;
end;

procedure TFrmSerialNumber.SerialMovClose;
begin
  with fquSerial do
    if Active then
      Close;
end;

function TFrmSerialNumber.StartOnSales(StartType : Integer; IDModel : Integer;
                                       IDStore   : Integer; MaxQty  : Double;
                                       IDItem    : Integer;
                                       Document  : Integer) : Boolean;
var
   FirstIDPreInventoryOnSameSale: Integer;
begin
  fIDModel   := IDModel;
  fIDStore   := IDStore;
  fIDItem    := IDItem;
  fMaxQty    := MaxQty;
  fRestSerialsPerSale := fMaxQty;
  fStartType := StartType;
  fGiftCard  := False;

  canCloseForm := true;

  //amfsouza 12.01.2011
  FirstIDPreInventoryOnSameSale := getFirstIDPreInvOnSale(Document);

  if ( FirstIDPreInventoryOnSameSale = 0 ) then
     FirstIdPreInventoryOnSameSale := IDItem;

  btnInvSerial.Visible := Password.HasFuncRight(43);

  //amfsouza
  FquSerialMovGrid := TADOQuery.Create(Self);
  FquSerialMovGrid.Connection := dm.ADODBConnect;

  //select
  FquSerialMovGrid.SQL.Add('select');
  FquSerialMovGrid.SQL.Add(' CardNumber as SerialNumber');
  FquSerialMovGrid.SQL.Add(',cast('''' as varchar(30)) as IdentificationNumber');
  FquSerialMovGrid.SQL.Add(' from ');
  FquSerialMovGrid.SQL.Add('Sal_AccountCard');
  FquSerialMovGrid.SQL.Add(' where IDPreInventoryMov in (select IDPreInventoryMov from InventoryMov where DocumentID =:document)');

  FquSerialPreMovGrid := TADOQuery.Create(Self);
  FquSerialPreMovGrid.Connection := dm.ADODBConnect;

  // amfsouza 12.01.2011
  FquSerialPreMovGrid.SQL.Add('select');
  FquSerialPreMovGrid.SQL.Add('  ps.PreInventoryMovID');
  FquSerialPreMovGrid.SQL.Add(' ,ps.SerialNumber');
  FquSerialPreMovGrid.SQL.Add(' ,ps.IdentificationNumber');
  FquSerialPreMovGrid.SQL.Add(' from PreSerialMov ps');
  FquSerialPreMovGrid.SQL.Add(' where ps.PreInventoryMovID between :idPreInv1 and :idPreInv2');
  FquSerialPreMovGrid.SQL.Add(' union');
  FquSerialPreMovGrid.SQL.Add(' select');
  FquSerialPreMovGrid.SQL.Add(' ac.IDPreInventoryMov');
  FquSerialPreMovGrid.SQL.Add(' ,ac.CardNumber');
  FquSerialPreMovGrid.SQL.Add(' ,CAST('''' as varchar(30)) IdentificationNumber');
  FquSerialPreMovGrid.SQL.Add(' from Sal_AccountCard ac');
  FquSerialPreMovGrid.SQL.Add(' where ac.IDPreInventoryMov between :idPreInv3 and :idPreInv4');

  case fStartType of
    SERIAL_HOLD:
    begin
      fquSerial := quSerialPreMov;
      dsGrid.DataSet := FquSerialPreMovGrid;
      //TODO
      //gridSerial.Columns[0].FieldName := quSerialPreMovPreInventoryMovID.FieldName;
      fGiftCard := (DM.DescCodigo(['IDModel'], [IntToStr(fIDModel)], 'Model', 'ModelType') = 'G');

      //amfsouza 12.01.2011 - to bring previous serials numbers to grid.
      if ( dsGrid.DataSet.Active ) then
           dsGrid.DataSet.close;

      ( dsGrid.DataSet as TADOQuery ).Parameters.ParamByName('idPreInv1').Value := FirstIdPreInventoryOnSameSale;
      ( dsGrid.DataSet as TADOQuery ).Parameters.ParamByName('idPreInv2').Value := IDItem;
      ( dsGrid.DataSet as TADOQuery ).Parameters.ParamByName('idPreInv3').Value := FirstIdPreInventoryOnSameSale;
      ( dsGrid.DataSet as TADOQuery ).Parameters.ParamByName('idPreInv4').Value := IDItem;

      dsGrid.DataSet.Open;

    end;
    SERIAL_INVOICE:
    begin
      fquSerial := quSerialMov;
      dsGrid.DataSet := FquSerialMovGrid;

      //amfsouza 12.01.2011 - to bring previous serials numbers to grid.
      if ( dsGrid.DataSet.Active ) then
           dsGrid.DataSet.close;

      ( dsGrid.DataSet as TADOQuery ).Parameters.Items[0].Value := IDItem;

      dsGrid.DataSet.Open;
    end;
  end;

  //Refound
  if fMaxQty < 0 then
  begin
    fStartType := SERIAL_REFOUND;
    fMaxQty    := Abs(fMaxQty);
  end;

  dsSerial.DataSet := fquSerial;

  SerialMovRefresh;

  edtSerialChange(nil);

  EditMaxQty.Text := FormatFloat('0.#####', fMaxQty);
  edtRest.Text    := FormatFloat('0.#####', fMaxQty);

  tsOnSale.TabVisible     := True;
  pnlQty.Visible          := True;
  tsInventory.TabVisible  := False;
  tsTransfer.TabVisible   := False;

  FListSerialNumber := TStringList.Create;

    //amfsouza 12.01.2011
  Result := ((ShowModal = mrOK) or (dsGrid.DataSet.RecordCount > 0) );

  SerialMovClose;
  freeAndNil(FquSerialMovGrid);
  freeAndNil(FquSerial);

end;

procedure TFrmSerialNumber.edtSerialChange(Sender: TObject);
begin
  inherited;
  btAdd.Enabled := (edtSerial.Text <> '') AND (fStartType <> SERIAL_INVOICE);
end;

procedure TFrmSerialNumber.btnInvSerialClick(Sender: TObject);
var
  sSN: String;
  fInvSerial: TFrmSerialNumber;
begin
  inherited;

  try
    fInvSerial := TFrmSerialNumber.Create(nil);
    with fInvSerial do
      sSN := StartInventory(Self.fIDModel, Self.fIDStore);
  finally
    //FreeAndNil(fInvSerial);
  end;

  edtSerial.Clear;
  edtSerial.Text := sSN;
  if (edtSerial.Text <> '') and (not edtIdent.Visible) then
    btAdd.Click;
end;

procedure TFrmSerialNumber.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmSerialNumber.btAddClick(Sender: TObject);
begin
  inherited;

  if Length(edtSerial.Text) > 30 then
  begin
    MsgBox(MSG_CRT_SERIAL_GREATER_THEN_30, vbOKOnly + vbCritical);
    Exit;
  end;

  if edtSerial.Text = '' then
  begin
//    edtSerial.SetFocus;
    MsgBox(MSG_CRT_NO_SERIALNUMBER, vbCritical + vbOkOnly);
    Exit;
  end;


//  if fquSerial.RecordCount >= fMaxQty then
  if ( getCountSerialNumbers(fIDItem) >= Int(fMaxQty) ) then 
  begin
    MsgBox('Can not enter more than ' + FloatToStr(FMaxQty )+ ' ' + MSG_EXC_PART2_NO_MORE_SERIAL, vbCritical + vbOkOnly);
    Exit;
  end;

  case fStartType of
    SERIAL_HOLD,
    SERIAL_INVOICE,
    SERIAL_REFOUND:
    begin
      // Se estou colocando um serial no InventoryMov devo verificar se
      // o serial existe no InventorySerial
      if (fStartType = SERIAL_HOLD) then
      begin
        if fGiftCard then
          if not TestAccountNumber(edtSerial.Text) then
          begin
            MsgBox(Format(MSG_CRT_GIFT_ACCOUNT_EXIST, [edtSerial.Text]), vbCritical + vbOkOnly);
            Exit;
          end;

        if DM.fSystem.SrvParam[PARAM_CHECKSERIALNUMBER] = True then
          if TestInventorySerial then
          begin
            MsgBox(MSG_CRT_NO_SERIALNUMBER_INV, vbCritical + vbOkOnly);
            Exit;
          end;
      end;

      //Serial nao pode existir no inventario
      if fStartType = SERIAL_REFOUND then
        if not TestInventorySerial then
        begin
          MsgBox(MSG_CRT_EXIST_SERIALNUMBER, vbCritical + vbOkOnly);
          Exit;
        end;

      if (fStartType = SERIAL_HOLD) then
        if fGiftCard then
          if not InsertAccountNumber(fIDItem, edtSerial.Text) then
          begin
            MsgBox(MSG_CRT_ERROR_GIFT_CREATE, vbCritical + vbOkOnly);
            Exit;
          end;

      //Insert novo serial
      with fquSerial do
      begin
        Append;
        FieldByName('SerialNumber').AsString := edtSerial.Text;
        FieldByName('IdentificationNumber').AsString := edtIdent.Text;
        try
          Post;
          //amfsouza 06.08.2011 - save list serial numbers added.
          dsGrid.dataset.close();
          dsGrid.dataset.Open();

        except
          on exception do
          begin
            Cancel;
//            edtSerial.SetFocus;
            raise exception.create(fSNExist);
          end;
        end;

        Locate('SerialNumber', edtSerial.Text, [loPartialKey]);
      end;
    end;

    SERIAL_PURCHASE:
    begin
      if not TestInventorySerial then
      begin
        MsgBox(MSG_CRT_EXIST_SERIALNUMBER_INV, vbCritical + vbOkOnly);
        Exit;
      end;

      if not TestPurchaseItemSerial then
      begin
        MsgBox(MSG_CRT_EXIST_SERIALNUMBER_RECEI, vbOKOnly + vbCritical);
        Exit;
      end;

      if not TestPurchaseSerial then
      begin
        MsgBox(MSG_CRT_EXIST_SERIALNUMBER_PUR, vbCritical + vbOkOnly);
        Exit;
      end;

      with fquSerial do
      begin
        Append;
        FieldByName('IDPurchaseItemSerial').AsInteger := DM.GetNextID(MR_PURCHASE_ITEM_SN_ID);
        FieldByName('IDPurchaseItem').AsInteger       := fIDItem;
        FieldByName('IDPurchase').AsInteger           := fIDPurchase;
        FieldByName('SerialNumber').AsString          := edtSerial.Text;
        try
          Post;
        except
          on exception do
          begin
            Cancel;
//            edtSerial.SetFocus;
            raise exception.create(fSNExist);
          end;
        end;

        Locate('SerialNumber', edtSerial.Text, [loPartialKey]);
      end;
    end;
  end;

  edtSerial.Text := '';
  edtIdent.Text := '';
//  edtSerial.SetFocus;
end;

procedure TFrmSerialNumber.FormCreate(Sender: TObject);
begin
  inherited;
  fquSerial := quSerialMov;

  edtIdent.Visible := DM.fSystem.SrvParam[PARAM_USE_IDENT_NUMBER_SERIAL];
  lblIdent.Visible := edtIdent.Visible;
  grdSerialDBTableViewIdentificationNumber.Visible := edtIdent.Visible;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      fSerialNum := 'Serial Numbers for Model ';
      fSNExist   := 'Serial Number can not be duplicated';
    end;

    LANG_PORTUGUESE:
    begin
      fSerialNum := 'N. Série para o modelo ';
      fSNExist   := 'N. Série não pode ser duplicado';
    end;

    LANG_SPANISH :
    begin
      fSerialNum := 'Número de Série para este Modelo ';
      fSNExist   := 'El Número de serie no se puede duplicar';
    end;
  end;
end;

procedure TFrmSerialNumber.quSerialPreMovNewRecord(DataSet: TDataSet);
begin
  inherited;
  fquSerial.Fields[0].AsInteger := fIDItem;
end;

procedure TFrmSerialNumber.CancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmSerialNumber.btRemoveClick(Sender: TObject);
begin
  inherited;
//  if (not (fquSerial.Eof and fquSerial.Bof)) and (fStartType <> SERIAL_INVOICE) then
//  begin
    if (fStartType = SERIAL_HOLD) then
      if fGiftCard then begin
        if not DeleteAccountNumber(Trim(dsGrid.dataset.fieldByName('SerialNumber').AsString)) then
        begin
          MsgBox(MSG_CRT_ERROR_DEL_GIFT, vbCritical + vbOkOnly);
          Exit;
        end;

        dm.RunSQL('delete from PreSerialMov where SerialNumber = ' + quotedStr(dsGrid.dataset.fieldByName('SerialNumber').Value));

        dsGrid.DataSet.close;
        dsGrid.DataSet.Open;
//        edtSerial.SetFocus;

        fMaxQty := fRestSerialsPerSale;

      end;


//    edtSerial.SetFocus;
end;

procedure TFrmSerialNumber.quSerialMovAfterPost(DataSet: TDataSet);
begin
  inherited;
  SerialMovRefresh;
end;

procedure TFrmSerialNumber.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(2140);
end;

procedure TFrmSerialNumber.dsSerialDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
//  editQty.Text := IntToStr(fquSerial.RecordCount);
end;

procedure TFrmSerialNumber.quSNPurchaseAfterPost(DataSet: TDataSet);
begin
  inherited;
  PurchaseSerialClose;
  PurchaseSerialOpen;
end;

procedure TFrmSerialNumber.quSNStoreOrigemAfterOpen(DataSet: TDataSet);
begin
  inherited;
  GetSerialRights;
end;

procedure TFrmSerialNumber.clbSerialClickCheck(Sender: TObject);
begin
  inherited;
  if clbSerial.Checked[clbSerial.ItemIndex] then
  begin
    if fCountCheck = fMaxQty then
    begin
      clbSerial.Checked[clbSerial.ItemIndex] := False;
      MsgBox(MSG_EXC_PART1_NO_MORE_SERIAL + FormatFloat('0.#####', fMaxQty) + MSG_EXC_PART2_NO_MORE_SERIAL, vbCritical + vbOkOnly);
    end
    else
      Inc(fCountCheck);
  end
  else
    Dec(fCountCheck);

  editQty.Text := IntToStr(fCountCheck);
end;

function TFrmSerialNumber.InsertAccountNumber(IDPreInvMov: Integer;
  Number: String): Boolean;
var
  dExpDate: TDateTime;
  iMonth: Integer;
begin
  iMonth := DM.fSystem.SrvParam[PARAM_GIFT_EXP_DATE];
  if iMonth > 0 then
    dExpDate := IncMonth(Now, iMonth);

  with cmdAddAccount do
  begin
    Parameters.ParamByName('IDAccountCard').Value     := DM.GetNextID('Sal_AccountCard.IDAccountCard');
    Parameters.ParamByName('CardNumber').Value        := Number;
    Parameters.ParamByName('CardDate').Value          := Now;
    Parameters.ParamByName('IDPreInventoryMov').Value := IDPreInvMov;
    Parameters.ParamByName('IDUser').Value            := DM.fUser.ID;
    if iMonth > 0 then
      Parameters.ParamByName('ExpirationDate').Value  := dExpDate
    else
      Parameters.ParamByName('ExpirationDate').Value  := NULL;
    try
      Execute;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

function TFrmSerialNumber.TestAccountNumber(Number: String): Boolean;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT CardNumber FROM Sal_AccountCard (NOLOCK) WHERE CardNumber = ' + QuotedStr(Trim(edtSerial.Text));
    try
      Open;
      Result := IsEmpty;
    finally
      Close;
    end;
  end;
end;

function TFrmSerialNumber.DeleteAccountNumber(Number: String): Boolean;
begin
  Result := DM.RunSQL('DELETE Sal_AccountCard WHERE CardNumber = ' + QuotedStr(Number));
end;

procedure TFrmSerialNumber.edtSerialEnter(Sender: TObject);
begin
  inherited;
  Aplicar.Default := False;
end;

procedure TFrmSerialNumber.edtSerialExit(Sender: TObject);
begin
  inherited;
  Aplicar.Default := True;
end;

procedure TFrmSerialNumber.edtSerialKeyPress(Sender: TObject; var Key: Char);
var
  i: integer;
begin
  inherited;
  if Key = #13 then
    btAddClick(Self);
end;

function TFrmSerialNumber.TestInventorySerial: Boolean;
begin
  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Text := 'SELECT Serial FROM InventorySerial (NOLOCK) WHERE ModelID = ' + IntToStr(fIDModel) +
                ' AND Serial = ' + QuotedStr(Trim(edtSerial.Text)) +
                ' AND StoreID = ' + IntToStr(fIDStore);
    Open;
    Result := IsEmpty;
    Close;
  end;
end;
function TFrmSerialNumber.TestPurchaseSerial: Boolean;
begin
  with DM.quFreeSQL do
  begin
    if Active then
       Close;
     SQL.Clear;
     SQL.Add('SELECT SerialNumber FROM Pur_PurchaseItemSerial (NOLOCK) WHERE IDPurchaseItem = ' + IntToStr(fIDItem));
     SQL.Add(' AND IDPurchase = ' + IntToStr(fIDPurchase));
     SQL.Add(' AND SerialNumber = ' + QuotedStr(Trim(edtSerial.Text)));
     Open;
     Result := IsEmpty;
     Close;
  end;
end;

function TFrmSerialNumber.TestPurchaseItemSerial: Boolean;
begin
  with DM.quFreeSQL do
  begin
    if Active then
       Close;
     SQL.Clear;
     SQL.Text :=  'SELECT '+
                  'PUI.IDModel, '+
                  'PIS.SerialNumber '+
                  'FROM '+
	                  'Pur_PurchaseItemSerial PIS (NOLOCK) '+
	                  'JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PIS.IDPurchaseItem = PUI.IDPurchaseItem) '+
                  'WHERE '+
	                  'PUI.IDModel = ' + IntToStr(fIDModel) +
	                  'AND '+
	                  'PIS.SerialNumber = ' + QuotedStr(Trim(edtSerial.Text));
     Open;
     Result := IsEmpty;
     Close;
  end;
end;

function TFrmSerialNumber.DeleteSNTranf(Number: String): Boolean;
begin
with DM.quFreeSQL do
  begin
    if Active then
       Close;
     SQL.Clear;
     SQL.Text :=  'SELECT '+
                    'MTS.IDModelTransfSerial,'+
                    'MTS.IDModelTransfDet, '+
                    'MTS.SerialNum '+
                  'FROM '+
	                  'ModelTransfSerial MTS (NOLOCK)'+
                  'WHERE '+
	                  'MTS.IDModelTransfDet = ' + IntToStr(fIDModelTransfDet) +
	                  'AND '+
	                  'MTS.SerialNum = ' + QuotedStr(Trim(Number));
     Open;
     if IsEmpty then
     begin
       Result := IsEmpty;
       Close;
     end
     else
       Result := DM.RunSQL('DELETE ModelTransfSerial WHERE IDModelTransfDet ='+ IntToStr(fIDModelTransfDet) +
  'AND SerialNum ='+ Number);
  end;

end;

procedure TFrmSerialNumber.FormShow(Sender: TObject);
begin
  inherited;
{
  case fStartType of
    SERIAL_HOLD,
    SERIAL_INVOICE,
    SERIAL_REFOUND: edtSerial.SetFocus;
  end;
  }
end;

procedure TFrmSerialNumber.quSerialPreMovAfterScroll(DataSet: TDataSet);
begin
  inherited;
  Aplicar.Enabled := ( quSerialPreMov.RecordCount > 0 );
end;

function TFrmSerialNumber.getListSerialNumbers: TStringList;
begin
   result := FListSerialNumber;
end;

function TFrmSerialNumber.getFirstIDPreInvOnSale(
  document: Integer): Integer;
var
  qry: TADOQuery;
  i: Integer;
  idPreInvList: String;
  docInsideList: String;
begin
  try
     result := 0;
     qry := TADOQuery.Create(nil);
     qry.Connection := dm.ADODBConnect;

     for i:= 0 to FListFromPreInventoryOnSameSale.Count - 2 do begin   
         docInsideList := copy(FListFromPreInventoryOnSameSale[i], 1, (pos('/', FListFromPreInventoryOnSameSale[i]) - 1) );

         if ( intToStr(document) <> docInsideList ) then
            continue;

         if ( idPreInvList = '' ) then
            idPreInvList := copy(FListFromPreInventoryOnSameSale[i], (pos('/', FListFromPreInventoryOnSameSale[i])+1), 20)
         else
            idPreInvList := idPreInvList + ',' + copy(FListFromPreInventoryOnSameSale[i], (pos('/', FListFromPreInventoryOnSameSale[i])+1), 20);
     end;

     if ( trim(idPreInvList) <> '' ) then begin
         qry.SQL.Add('select IsNull(Min(IdPreInventoryMov),0) FirstIdPreInvOnSale from Sal_AccountCard where IdPreInventoryMov in ( ' + idPreInvList + ')');
         qry.Open;
         result := qry.fieldByName('FirstIdPreInvOnSale').Value;
     end;
  finally
     freeAndNil(qry);
  end;
end;

procedure TFrmSerialNumber.setListFromPreInventoryMovOnSameSale(
  list: TStringList);
begin
     FListFromPreInventoryOnSameSale := list;
end;

procedure TFrmSerialNumber.dsGridDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  editQty.Text := intToStr(dsGrid.DataSet.RecordCount);
end;

procedure TFrmSerialNumber.AplicarClick(Sender: TObject);
var
 msg: String;
 restStr: String;
 maxSerialStr: String;
begin
(*
  canCloseForm := ( Trunc(fRestSerialsPerSale) = 0 );
  if ( fRestSerialsPerSale <> 0 ) then begin
     restStr := FloatToStr(fRestSerialsPerSale);
     maxSerialStr := FloatToStr(fMaxQty);
     msg := 'Is lacking serial numbers to this sale. Number of serial numbers expected per sale: ' + maxSerialStr +
            ', rest ' + restStr;
     MsgBox(msg, vbOKOnly + vbCritical);
     edtSerial.SetFocus;
     exit;
  end;
*)

  inherited;
end;

procedure TFrmSerialNumber.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  canClose := true;
end;

function TFrmSerialNumber.getCountSerialNumbers(
  idPreInv: Integer): Integer;
var
   qry: TADOQuery;
begin
   try
      result := 0;
      qry := TADOQuery.Create(nil);
      qry.Connection := dm.ADODBConnect;
      qry.SQL.Add('select PreInventoryMovID, SerialNumber, IdentificationNumber');
      qry.sql.Add(' from PreSerialMov');
      qry.SQL.Add(' where PreInventoryMovID =:preinv');

      qry.Parameters.ParamByName('preinv').Value := idPreInv;
      qry.Open;

      if ( not qry.IsEmpty ) then
         result := qry.RecordCount;

   finally
      freeAndNil(qry);
   end;
end;

end.
