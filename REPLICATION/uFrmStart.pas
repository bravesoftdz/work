unit uFrmStart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizard, ImgList, StdCtrls, ExtCtrls, ComCtrls, uSQLFileReader,
  IniFiles, jpeg, Buttons, ADODB, DB;

Const
  SQL_REP_SERVER  = '#SERVER#';
  SQL_REP_DIR     = '#REP_DIR#';
  SQL_REP_DB      = '#DATABASE#';
  SQL_REP_USER    = '#USER#';
  SQL_REP_PW      = '#PW#';
  SQL_REP_INI_NUM = '#START_NUMBER#';
  SQL_REP_END_NUM = '#END_NUMBER#';
  SQL_REP_SUB_SVR = '#SUBSC_SERVER#';
  SQL_REP_SUB_DB  = '#SUBSC_DB#';

type
  TFrmStart = class(TParentWizard)
    tsInfro: TTabSheet;
    tsPublisher: TTabSheet;
    Label1: TLabel;
    tsConnection: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtServer: TEdit;
    edtUserName: TEdit;
    edtPW: TEdit;
    cbxDB: TComboBox;
    Panel2: TPanel;
    ImgIntro: TImage;
    Panel12: TPanel;
    pnlTopic1: TPanel;
    lblTopic1: TLabel;
    Shape1: TShape;
    Label36: TLabel;
    Label28: TLabel;
    Label2: TLabel;
    edtRepliDirectory: TEdit;
    SpeedButton1: TSpeedButton;
    OP: TOpenDialog;
    tsFinish: TTabSheet;
    Panel3: TPanel;
    imgFinalize: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label11: TLabel;
    Shape4: TShape;
    ADOCommand: TADOCommand;
    pnlInfo: TPanel;
    lbInfo: TLabel;
    pbScript: TProgressBar;
    lbRepInfo: TLabel;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    edtIniInterval: TEdit;
    Label13: TLabel;
    edtEndInterval: TEdit;
    cbxStoreList: TComboBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    cbxStoreType: TComboBox;
    btnHelpStoreType: TSpeedButton;
    btnShowScript: TButton;
    btnShollAll: TButton;
    lbFileInfo: TLabel;
    Label17: TLabel;
    lbPServer: TLabel;
    lbPDataBase: TLabel;
    Label20: TLabel;
    lbSServer: TLabel;
    lbSDatabase: TLabel;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxStoreListChange(Sender: TObject);
    procedure btnHelpStoreTypeClick(Sender: TObject);
    procedure btnShowScriptClick(Sender: TObject);
    procedure btnShollAllClick(Sender: TObject);
  private
    { Private declarations }
    fIniConfig   : TIniFile;
    fSQLText,
    fSQLAllText  : String;
    fTotalStores : Integer;
    function SetConnection:boolean;
    function SetStoreIntervals:Boolean;
    procedure GetDBList;
    procedure GetStoresList;
    procedure GetConnectionValues;
    procedure Hidde(b:Boolean);
    function CreateRepliDir:Boolean;
    function GetRestricForms:String;
  protected
    function DoFinish:Integer; override;
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
  public
    { Public declarations }
  end;

var
  FrmStart: TFrmStart;

implementation

uses uDMParent, uMsgBox, uParamFunctions, ufrmServerInfo, uSystemConst, uFrmMeno;

{$R *.dfm}

function TFrmStart.GetRestricForms:String;
begin

  Case cbxStoreType.ItemIndex of
    0 : begin
        //SERVER
        Result := fIniConfig.ReadString('RestrictForms', 'SERVER', '');
        end;
    1 : begin
        //CLIENT
        Result := fIniConfig.ReadString('RestrictForms', 'CLIENT', '');
        end;
    end;

end;

procedure TFrmStart.GetConnectionValues;
var
   sResult : String;
   FrmServrInfo : TFrmServerInfo;
   bAbort : Boolean;
begin

 try
   FrmServrInfo := TFrmServerInfo.Create(self);
   FrmServrInfo.RegistryKey := 'Repli_LocalServer';
   sResult := FrmServrInfo.Start('4', False, '', bAbort);

   DMParent.fSQLConnectParam.Server    := ParseParam(sResult, SV_SERVER);
   DMParent.fSQLConnectParam.DBAlias   := ParseParam(sResult, SV_DATABASE);
   DMParent.fSQLConnectParam.UserName  := ParseParam(sResult, SV_USER);
   DMParent.fSQLConnectParam.PW        := ParseParam(sResult, SV_PASSWORD);
   DMParent.fSQLConnectParam.WinLogin  := (ParseParam(sResult, SV_WIN_LOGIN)[1] in ['Y']);
   DMParent.fSQLConnectParam.UseNetLib := (ParseParam(sResult, SV_USE_NETLIB)[1] = 'Y');


   edtServer.Text    := DMParent.fSQLConnectParam.Server;
   edtUserName.Text  := DMParent.fSQLConnectParam.UserName;
   edtPW.Text        := DMParent.fSQLConnectParam.PW;

 finally
   FreeAndNil(FrmServrInfo);
   end;

end;

procedure TFrmStart.GetDBList;
begin
  Try
    Screen.Cursor:= crHourGlass;
    with DMParent.quFreeSQL do
       begin
       if Active then
         Close;
       SQL.Text := 'exec sp_databases';
       Open;
       First;
       While not EOF do
          begin
          cbxDB.Items.Add(Fields.Fields[0].AsString);
          Next;
          end;
      Close;
      end;
  Finally
     Screen.Cursor:= crDefault;
     end;

end;

function TFrmStart.SetConnection:boolean;
var
  sResult : String;
begin
  Result := True;

  if DMParent.ADODBConnect.Connected then
     Exit;
     
  try
    Screen.Cursor:= crHourGlass;
      with DMParent do
        begin
        if not DMParent.fSQLConnectParam.WinLogin then
           if DMParent.fSQLConnectParam.UseNetLib then
              sResult := SetConnectionStr(edtUserName.Text,
                                          edtPW.Text,
                                          'Master',
                                          edtServer.Text)
           else
              sResult := SetConnectionStrNoNETLIB(edtUserName.Text,
                                                  edtPW.Text,
                                                  'Master',
                                                  edtServer.Text)
        else
           if DMParent.fSQLConnectParam.UseNetLib then
              sResult := SetWinConnectionStr('Master',
                                             edtServer.Text)
           else
              sResult := SetWinConnectionStrNoNETLIB('Master',
                                                     edtServer.Text);

        Try
          ADOConnectionString := sResult;
          ADODBConnect.Open;
        except
          Result := False;
          end;
        end;
  finally
    Screen.Cursor:= crDefault;
    end;
end;

procedure TFrmStart.GetStoresList;
var
  i : integer;
begin

  cbxStoreList.Items.Clear;

  for i:=1 to fTotalStores do
     cbxStoreList.Items.Add('Store '+IntToStr(i));
end;

function TFrmStart.OnAfterChangePage:Boolean;
begin
  Result := False;
  Hidde(False);

  lbRepInfo.Visible := (pgOption.ActivePageIndex=0) or (pgOption.ActivePageIndex=4);

    Case pgOption.ActivePageIndex of

      0 : Hidde(True);

      1 : if edtServer.Text = '' then
             GetConnectionValues;

      2  : begin
            if cbxStoreList.Items.Count=0 then
               begin
               GetStoresList;
               cbxStoreList.ItemIndex := 0;
               end;

            if cbxDB.Items.Count=0 then
               begin
               GetDBList;
               cbxDB.Text := DMParent.fSQLConnectParam.DBAlias;
               end;

             if cbxStoreType.ItemIndex = -1 then
                cbxStoreType.ItemIndex := 0;

           edtRepliDirectory.Text := DMParent.LocalPath;      
           end;
      3 : begin
          imgFinalize.Picture.Assign(ImgIntro.Picture);
          lbPServer.Caption   := '- Publish Server: ' + edtServer.Text;
          lbPDataBase.Caption := '- Publish Database: ' + cbxDB.Text;
          Hidde(True);
          end;
     end;

  Result := True;
end;

function TFrmStart.TestBeforeNavigate:Boolean;
begin
  Result := False;
    Case pgOption.ActivePageIndex of
      1 : begin
          if (not SetConnection) then
              begin
              MsgBox('Connection error', vbCritical + vbOkOnly);
              Exit;
              end;
          end;
      2 : begin
          if cbxDB.Text = '' then
             begin
             MsgBox('Select a database', vbCritical + vbOkOnly);
             Exit;
             end;
          end;
     end;
  Result := True;
end;

function TFrmStart.SetStoreIntervals:Boolean;
var
  s, f : String;
  iID : Integer;
begin
  Result := True;

  try
     with ADOCommand do
       begin
       CommandText := 'use '+cbxDB.Text;
       Execute;
       end;
  except
     raise;
     Result := False;
     end;

  //Add constraint
  try
     with ADOCommand do
       begin
       CommandText := 'ALTER TABLE Sis_CodigoIncremental ADD CONSTRAINT MaxValue_Check CHECK (UltimoCodigo <= '+edtEndInterval.Text+')';
       Execute;
       end;
  except
     raise;
     Result := False;
     end;

  //First store does not need to update
  if cbxStoreList.ItemIndex <> 0 then
  begin
    //Add Update Last Cod
    try
      with ADOCommand do
        begin
        CommandText := 'UPDATE Sis_CodigoIncremental SET UltimoCodigo = UltimoCodigo + ' + edtIniInterval.Text;
        Execute;
        end;
    except
      raise;
      Result := False;
      end;

    try
      iID := DMParent.GetNextID('InvoiceGen.IDInvoice');
      with ADOCommand do
      begin
        iID := iID + StrToInt(edtIniInterval.Text);
        CommandText := 'DBCC CHECKIDENT (' + QuotedStr('Key_IDInvoice') + ', reseed, '+ IntToStr(iID)+') ';
        Execute;
      end;

      iID := DMParent.GetNextID('Fin_Lancamento.IDLancamento');
      with ADOCommand do
      begin
        iID := iID + StrToInt(edtIniInterval.Text);
        CommandText := 'DBCC CHECKIDENT (' + QuotedStr('Key_IDLancamento') + ', reseed, '+ IntToStr(iID)+') ';
        Execute;
      end;

      iID := DMParent.GetNextID('SaleItemCommission.IDSaleItemCommission');
      with ADOCommand do
      begin
        iID := iID + StrToInt(edtIniInterval.Text);
        CommandText := 'DBCC CHECKIDENT (' + QuotedStr('Key_IDSaleItemCommission') + ', reseed, '+ IntToStr(iID)+') ';
        Execute;
      end;

      iID := DMParent.GetNextID('Invoice.IDPreSale');
      with ADOCommand do
      begin
        iID := iID + StrToInt(edtIniInterval.Text);
        CommandText := 'DBCC CHECKIDENT (' + QuotedStr('Key_IDPreSale') + ', reseed, '+ IntToStr(iID)+') ';
        Execute;
      end;

      iID := DMParent.GetNextID('PreInventoryMov.IDPreInventoryMov');
      with ADOCommand do
      begin
        iID := iID + StrToInt(edtIniInterval.Text);
        CommandText := 'DBCC CHECKIDENT (' + QuotedStr('Key_IDPreInventoryMov') + ', reseed, '+ IntToStr(iID)+') ';
        Execute;
      end;

      iID := DMParent.GetNextID('InventoryMov.IDInventoryMov');
      with ADOCommand do
      begin
        iID := iID + StrToInt(edtIniInterval.Text);
        CommandText := 'DBCC CHECKIDENT (' + QuotedStr('Key_IDInventoryMov') + ', reseed, '+ IntToStr(iID)+') ';
        Execute;
      end;

    except
      raise;
      Result := False;
      end;
  end;


  //Add restric form for mainretail
  Case cbxStoreType.ItemIndex of
    0 : begin
        s := QuotedStr(SYSTEM_SERVER_TYPE);
        f := GetRestricForms;
        end;
    1 : begin
        s := QuotedStr(SYSTEM_CLIENT_TYPE);
        f := GetRestricForms;
        end;
  end;

  try
     with ADOCommand do
       begin
       CommandText := 'UPDATE Sys_Module SET VersionType = ' + QuotedStr(s) +
                      ', RestricForms = ' + QuotedStr(f);
       Execute;
       end;
  except
     raise;
     Result := False;
     end;

end;

function TFrmStart.CreateRepliDir:Boolean;
begin
   try
     if not DirectoryExists(edtRepliDirectory.Text) then
        Result := CreateDir(edtRepliDirectory.Text);

     if not DirectoryExists(edtRepliDirectory.Text+'\out') then
        Result := CreateDir(edtRepliDirectory.Text+'\out');

     if not DirectoryExists(edtRepliDirectory.Text+'\global') then
        Result := CreateDir(edtRepliDirectory.Text+'\global');
   except
     raise;
     Result := False;
     end;
end;

function TFrmStart.DoFinish:Integer;
begin

  if not CreateRepliDir then
     begin
     MsgBox('Error creating directory', vbCritical + vbOkOnly);
     Exit;
     end;

  lbFileInfo.Caption := '';

  if not SetStoreIntervals then
     Exit;

  MsgBox('Wizard completed', vbInformation + vbOkOnly);

end;

procedure TFrmStart.FormCreate(Sender: TObject);
begin
  inherited;
   fIniConfig          := TIniFile.Create(DMParent.LocalPath+'replconfig.ini');
   fTotalStores        := fIniConfig.ReadInteger('Settings', 'TotalStores', 10);
end;

procedure TFrmStart.FormDestroy(Sender: TObject);
begin
  inherited;
   fIniConfig.Free;
end;

procedure TFrmStart.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if OP.Execute then
     edtRepliDirectory.Text := ExtractFileDir(OP.FileName);
end;

procedure TFrmStart.Hidde(b:Boolean);
begin
  inherited;
  b := not b;
  ShapeImage.Visible := b;
  ImageClass.Visible := b;
  lbEditName.Visible := b;
  lbEditDescription.Visible := b;
end;

procedure TFrmStart.FormShow(Sender: TObject);
begin
  inherited;
  Hidde(True);
end;

procedure TFrmStart.cbxStoreListChange(Sender: TObject);
var
  i : LongInt;
begin
  inherited;

  i := 100000000;

  if cbxStoreList.ItemIndex = 0 then
     begin
     edtIniInterval.Text := IntToStr(1);
     edtEndInterval.Text := IntToStr(i);
     end
  else
     begin
     edtIniInterval.Text := IntToStr(i*(cbxStoreList.ItemIndex));
     edtEndInterval.Text := IntToStr(i*(cbxStoreList.ItemIndex+1));
     end;
     
end;

procedure TFrmStart.btnHelpStoreTypeClick(Sender: TObject);
var
  Text : String;
begin
  inherited;

  case cbxStoreType.ItemIndex of
     0 : Text := 'Regular store'+#13#10+#13#10+'This option allows users to display models and barcodes.'+#13#10+' Users CANNOT add or updated model and barcode data. ';
     1 : Text := 'Master store'+#13#10+#13#10+'Users can update and add new models and barcode. '+#13#10+'You can also purchase items and distribute them to the other stores.';
  end;

  ShowMessage(Text);

end;

procedure TFrmStart.btnShowScriptClick(Sender: TObject);
begin
  inherited;
  with TFrmMemo.Create(Self) do
     Start(fSQLText);
end;

procedure TFrmStart.btnShollAllClick(Sender: TObject);
begin
  inherited;
  with TFrmMemo.Create(Self) do
     Start(fSQLAllText);
end;

end.

