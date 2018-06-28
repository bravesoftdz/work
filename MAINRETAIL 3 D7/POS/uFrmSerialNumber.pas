unit uFrmSerialNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,
  Buttons, Grids, DBGrids, SMDBGrid, DB, ADODB, PowerADOQuery, CheckLst,
  uParentAll, siComp, siLangRT;

Const
  SERIAL_HOLD         = 2;
  SERIAL_INVOICE      = 3;
  SERIAL_PURCHASE     = 4;
  SERIAL_REFOUND      = 5;

type
  TFrmSerialNumber = class(TFrmParentAll)
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
    StringField1: TStringField;
    quSerialMov: TADOQuery;
    quSerialMovInventoryMovID: TIntegerField;
    quSerialMovSerialNumber: TStringField;
    dsSerial: TDataSource;
    Panel3: TPanel;
    gridSerial: TSMDBGrid;
    Label1: TLabel;
    EditSerial: TEdit;
    btnInvSerial: TSpeedButton;
    btAdd: TSpeedButton;
    btRemove: TSpeedButton;
    quInventorySerial: TADOQuery;
    quInventorySerialName: TStringField;
    quInventorySerialSerial: TStringField;
    quInventorySerialStoreID: TIntegerField;
    dsInvSerial: TDataSource;
    grdSerial: TSMDBGrid;
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
    Panel1: TPanel;
    Bevel1: TBevel;
    Panel2: TPanel;
    spHelp: TSpeedButton;
    Cancelar: TButton;
    Aplicar: TButton;
    procedure EditSerialChange(Sender: TObject);
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
  private
    { Private declarations }
    fIDModel     : Integer;
    fIDStore     : Integer;
    fIDItem      : Integer;
    fStartType   : Integer;

    //PreSale, Sale
    fMaxQty      : Integer;
    fquSerial    : TADOQuery;
    fSerialNum   : String;
    fSNExist     : String;

    //Purchase
    fIDPurchase  : Integer;

    //Transfer
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


  public
    { Public declarations }
    function StartOnPurchase(IDItem,
                             IDPurchase,
                             IDModel,
                             IDStore,
                             MaxQty: Integer):Boolean;
    function StartInventory(IDModel,IDStore : Integer):String;
    function StartOnSales(StartType  : Integer;
                          IDModel    : Integer;
                          IDStore    : Integer;
	                        MaxQty     : Integer;
                          IDItem     : Integer) : Boolean;
    function StartOnTransfer(IDModel,
                             IDStoreOri,
                             IDStoreDest,
                             MaxQty:Integer):Boolean;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uPassword, uSystemConst;

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
        if quSNStoreOrigem.Locate('Serial', Items[i], []) then
           begin
           quSNStoreOrigem.Edit;
           quSNStoreOrigemStoreID.AsInteger := fIDStoreDest;
           quSNStoreOrigem.Post;
           end;

end;


function TFrmSerialNumber.StartOnTransfer(IDModel, IDStoreOri, IDStoreDest, MaxQty:Integer):Boolean;
begin
     fIDStoreDest := IDStoreDest;
     fIDModel     := IDModel;
     fIDStore     := IDStoreOri;
     fMaxQty      := MaxQty;
     fCountCheck  := 0;

     tsOnSale.TabVisible     := False;
     pnlQty.Visible          := True;
     tsInventory.TabVisible  := False;
     tsTransfer.TabVisible   := True;

     EditMaxQty.Text := IntToStr(fMaxQty);

     TransferOpen;

     Result := (ShowModal = mrOK);

     if Result then
        SetSerialRights;

     TransferClose; 

end;

function TFrmSerialNumber.StartOnPurchase(IDItem, IDPurchase, IDModel, IDStore, MaxQty: Integer):Boolean;
begin
     fIDPurchase := IDPurchase;
     fIDItem     := IDItem;
     fIDModel    := IDModel;
     fIDStore    := IDStore;
     fMaxQty     := MaxQty;
     fStartType  := SERIAL_PURCHASE;

     fquSerial   := quSNPurchase;

     dsSerial.DataSet := fquSerial;
     gridSerial.Columns[0].FieldName := quSNPurchaseIDPurchaseItemSerial.FieldName;

     tsOnSale.TabVisible     := True;
     pnlQty.Visible          := True;
     tsInventory.TabVisible  := False;
     tsTransfer.TabVisible   := False;
     btnInvSerial.Visible    := False;

     EditMaxQty.Text := IntToStr(fMaxQty);

     PurchaseSerialOpen;

     Result := (ShowModal = mrOK);

     SerialMovClose;
     PurchaseSerialClose;

end;

function TFrmSerialNumber.StartInventory(IDModel,IDStore : Integer):String;
begin
  fIDModel   := IDModel;
  fIDStore   := IDStore;

  InventorySerialOpen;

  tsInventory.TabVisible  := True;
  tsOnSale.TabVisible     := False;
  tsTransfer.TabVisible   := False;
  pnlQty.Visible          := False;

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
                                       IDStore   : Integer; MaxQty  : Integer;
                                       IDItem    : Integer) : Boolean;
begin

  fIDModel   := IDModel;
  fIDStore   := IDStore;
  fIDItem    := IDItem;
  fMaxQty    := MaxQty;
  fStartType := StartType;

  btnInvSerial.Visible := Password.HasFuncRight(43);

  case fStartType of
    SERIAL_HOLD:        begin
                        fquSerial := quSerialPreMov;
                        gridSerial.Columns[0].FieldName := quSerialPreMovPreInventoryMovID.FieldName;
                        end;
    SERIAL_INVOICE:     begin
                        fquSerial := quSerialMov;
                        gridSerial.Columns[0].FieldName := quSerialMovInventoryMovID.FieldName;
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

  EditSerialChange(nil);

  EditMaxQty.Text := IntToStr(fMaxQty);

  tsOnSale.TabVisible     := True;
  pnlQty.Visible          := True;
  tsInventory.TabVisible  := False;
  tsTransfer.TabVisible   := False;

  Result := (ShowModal = mrOK);

  SerialMovClose;

end;

procedure TFrmSerialNumber.EditSerialChange(Sender: TObject);
begin
  inherited;
  btAdd.Enabled := (EditSerial.Text <> '') AND (fStartType <> SERIAL_INVOICE);
end;

procedure TFrmSerialNumber.btnInvSerialClick(Sender: TObject);
var
  sSN : String;
  fInvSerial : TFrmSerialNumber;
begin
  inherited;

  try
    fInvSerial := TFrmSerialNumber.Create(nil);
    with fInvSerial do
        sSN := StartInventory(Self.fIDModel, Self.fIDStore);
  finally
     //FreeAndNil(fInvSerial);
     end;

  EditSerial.Clear;
  EditSerial.Text := sSN;
  if EditSerial.Text <> '' then
     btAdd.Click;

end;

procedure TFrmSerialNumber.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmSerialNumber.btAddClick(Sender: TObject);

   function TestInventorySerial:Boolean;
   begin
     with DM.quFreeSQL do
       begin
       if Active then
          Close;
       SQL.Text := 'SELECT Serial FROM InventorySerial WHERE ModelID = ' + IntToStr(fIDModel) +
                   ' AND Serial = ' + Chr(39) + Trim(editSerial.Text) + Chr(39) +
                   ' AND StoreID = ' + IntToStr(fIDStore);
       Open;
       Result := IsEmpty;
       Close;
       end;
   end;

   function TestPurchaseSerial:Boolean;
   begin
   with DM.quFreeSQL do
        begin
        if Active then
           Close;
         SQL.Clear;
         SQL.Add('SELECT SerialNumber FROM Pur_PurchaseItemSerial WHERE IDPurchaseItem = ' + IntToStr(fIDItem));
         SQL.Add(' AND IDPurchase = ' + IntToStr(fIDPurchase));
         SQL.Add(' AND SerialNumber = ' + Chr(39) + Trim(editSerial.Text) + Chr(39));
         Open;
         Result := IsEmpty;
         Close;
         end;
   end;

begin
  inherited;

  if EditSerial.Text = '' then
    begin
     EditSerial.SetFocus;
     MsgBox(MSG_CRT_NO_SERIALNUMBER, vbCritical + vbOkOnly);
     Exit;
    end;

  if fquSerial.RecordCount = fMaxQty then
     begin
     MsgBox(MSG_EXC_PART1_NO_MORE_SERIAL + IntToStr(fMaxQty) + MSG_EXC_PART2_NO_MORE_SERIAL, vbCritical + vbOkOnly);
     Exit;
     end;
                            
  Case fStartType of

      SERIAL_HOLD,
      SERIAL_INVOICE,
      SERIAL_REFOUND   : begin
                         // Se estou colocando um serial no InventoryMov devo verificar se
                         // o serial existe no InventorySerial
                         if (fStartType = SERIAL_HOLD) then
                            if DM.fSystem.SrvParam[PARAM_CHECKSERIALNUMBER] = True then
                               if TestInventorySerial then
                                  begin
                                  MsgBox(MSG_CRT_NO_SERIALNUMBER_INV, vbCritical + vbOkOnly);
                                  Exit;
                                  end;

                         //Serial nao pode existir no inventario         
                         if fStartType = SERIAL_REFOUND then
                            if not TestInventorySerial then
                               begin
                               MsgBox(MSG_CRT_EXIST_SERIALNUMBER, vbCritical + vbOkOnly);
                               Exit;
                               end;

                         //Insert novo serial
                         with fquSerial do
                           begin
                            Append;
                            FieldByName('SerialNumber').AsString := EditSerial.Text;
                            try
                              Post;
                            except
                              on exception do
                               begin
                                 Cancel;
                                 EditSerial.SetFocus;
                                 raise exception.create(fSNExist);
                               end;
                            end;
                            Locate('SerialNumber', EditSerial.Text, [loPartialKey]);
                           end;

                         end;

      SERIAL_PURCHASE : begin
                         if not TestInventorySerial then
                            begin
                            MsgBox(MSG_CRT_EXIST_SERIALNUMBER, vbCritical + vbOkOnly);
                            Exit;
                            end;

                         if not TestPurchaseSerial then
                            begin
                            MsgBox(MSG_CRT_EXIST_SERIALNUMBER, vbCritical + vbOkOnly);
                            Exit;
                            end;

                        with fquSerial do
                          begin
                            Append;
                            FieldByName('IDPurchaseItemSerial').AsInteger := DM.GetNextID(MR_PURCHASE_ITEM_SN_ID);
                            FieldByName('IDPurchaseItem').AsInteger       := fIDItem;
                            FieldByName('IDPurchase').AsInteger           := fIDPurchase;
                            FieldByName('SerialNumber').AsString          := EditSerial.Text;
                            try
                              Post;
                            except
                              on exception do
                               begin
                                 Cancel;
                                 EditSerial.SetFocus;
                                 raise exception.create(fSNExist);
                               end;
                            end;
                            Locate('SerialNumber', EditSerial.Text, [loPartialKey]);
                          end;
                        end;

  end;


   EditSerial.Text := '';
   EditSerial.SetFocus;

end;

procedure TFrmSerialNumber.FormCreate(Sender: TObject);
begin
  inherited;

  fquSerial := quSerialMov;

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           fSerialNum := 'Serial Numbers for Model ';
           fSNExist   := 'Serial Number can not be duplicated';
           end;

     LANG_PORTUGUESE :
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

  if (not (fquSerial.Eof and fquSerial.Bof)) and (fStartType <> SERIAL_INVOICE) then
     begin
     fquSerial.Delete;
     editSerial.SetFocus;
     end;
     
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
  editQty.Text := IntToStr(fquSerial.RecordCount);
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
        MsgBox(MSG_EXC_PART1_NO_MORE_SERIAL + IntToStr(fMaxQty) + MSG_EXC_PART2_NO_MORE_SERIAL, vbCritical + vbOkOnly);
        end
      else
        Inc(fCountCheck);
     end
  else
     Dec(fCountCheck);

 editQty.Text := IntToStr(fCountCheck);
 
end;

end.
