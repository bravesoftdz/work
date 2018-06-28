unit uFrameSendContact;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Db, ADODB, ppDB, ppDBPipe, ppDBBDE, ppCtrls, ppBands, ppVar,
  ppStrtch, ppMemo, ppPrnabl, ppClass, ppCache, ppComm, ppRelatv, ppProd,
  ppReport, StdCtrls, ppModule, daDataModule, daDataView,
  daQueryDataView, daADO, ppViewr, Email, siComp, siLangRT, raCodMod;

const
  PO_EMAIL_FILE_BOTH = 0;
  PO_EMAIL_FILE_TXT = 1;
  PO_EMAIL_FILE_PDF = 2;

type
  TFrameSendContact = class(TFrame)
    sbEmailFile: TSpeedButton;
    btPreviewVendorFax: TSpeedButton;
    sbSendFax: TSpeedButton;
    quModel: TADODataSet;
    dsModel: TDataSource;
    ppPipeline: TppBDEPipeline;
    SD: TSaveDialog;
    quVendor: TADODataSet;
    quVendorIDPessoa: TAutoIncField;
    quVendorFax: TStringField;
    quVendorEmail: TStringField;
    lbFormType: TLabel;
    quVendorVendor: TStringField;
    ppModel: TppReport;
    ppHeaderBand: TppHeaderBand;
    ppDetailBand: TppDetailBand;
    ppFooterBand: TppFooterBand;
    ppTitleBand: TppTitleBand;
    ppLabel6: TppLabel;
    ppMemo2: TppMemo;
    ppMemo3: TppMemo;
    ppLabel1: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    ppLabel4: TppLabel;
    ppLabel2: TppLabel;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    quModelModel: TStringField;
    quModelDescription: TStringField;
    ppShape1: TppShape;
    Emails: TEmail;
    siLangFrameCont: TsiLangRT;
    ppDBText: TppDBText;
    quModelCostPrice: TCurrencyField;
    quModelQtyCotada: TFloatField;
    quModelFabricante: TStringField;
    ppLabel3: TppLabel;
    ppDBText4: TppDBText;
    quVendorContato: TStringField;
    quVendorTelefone: TStringField;
    qPO: TADOQuery;
    qPOIDPO: TIntegerField;
    qPOIDFornecedor: TIntegerField;
    qPOFornecedor: TStringField;
    qPODataPedido: TDateTimeField;
    qPOAberto: TBooleanField;
    qPOSubTotal: TBCDField;
    qPOFreight: TBCDField;
    qPOCharges: TBCDField;
    qPOOBS: TStringField;
    qPOTotal: TCurrencyField;
    qPOEstArrival: TDateTimeField;
    procedure sbEmailFileClick(Sender: TObject);
    procedure btPreviewVendorFaxClick(Sender: TObject);
    procedure ppModelBeforePrint(Sender: TObject);
    procedure qPOCalcFields(DataSet: TDataSet);
  private
    FIDStore  :Integer;
    FIDVendor :Integer;
    FIDPO     :Integer;
    FIDPayDay :Integer;
    FVendorName: String;

    //1 - Quote, 2 - PO
    iFormType : Integer;

    sStoreInfo: String;
    sFrase    : String;

    //Translation
    sFraseLang1,
    sFraseLang2,
    sFrom,
    sTo,
    sContact,
    sPONum,
    sAddress,
    sPhone,
    sFax,
    sModel,
    sDesc,
    sCost,
    sCostQty,
    sThankyou,
    sDate,
    sDueDate,
    sTotal,
    sObs,
    sCompany,
    sPriceQuote,
    sPurchase,
    sPayDays: String;

    //Criate for email e fax
    sCreateModelList : TStringList;

    procedure VendorClose;
    procedure VendorOpen;

    procedure ModelOpen;
    procedure ModelClose;
    procedure ModelRefresh;

    procedure BuildModelList(var sModelList: TStringList; TipoTransf: String);
    function  SaveModelListToFile(sModelList: TStringList; TipoTransf, Vendor: String): String;

    procedure SetStoreInf(Value:Integer);
    procedure SetIDVendor(Value:Integer);

    function PutCaracter(x:integer; texto:string; Caracter:Char):String;
    procedure POOpen;
    procedure POClose;
  public
    procedure Init(Form:Integer);
    procedure UnInit;

    procedure SetModelDataSet(dsModelList:TDataSet);
    procedure SetModelSQL(sSQL:String);
    //somente no Price Quote
    procedure SetVendorDataSet(dsVendor:TDataSet);
  published
    property IDStore    : Integer read FIDStore    write SetStoreInf;
    property IDVendor   : Integer read FIDVendor   write SetIDVendor;
    property IDPO       : Integer read FIDPO       write FIDPO;
    property IDPayDay   : Integer read FIDPayDay   write FIDPayDay;
    property VendorName : String  read FVendorName write FVendorName;
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal, uFrmPrintPO, uSystemConst, uStringFunctions,
  uDMParent;

{$R *.DFM}

procedure TFrameSendContact.Init(Form:Integer);
begin
  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sFraseLang1 := 'Please quote ONLY the items you have in stock, and get back to me as soon as possible.';
      sFraseLang2 := 'Please ship me this order as soon as possible. E-mail or fax me back which items you will be shipping.';
      sFrom       := 'FROM        : ';
      sTo         := 'TO          : ';
      sPONum      := 'PLEASE INFORM THE PO NUMBER ON PURCHASE INVOICE: ';
      sContact    := 'Contact     : ';
      sAddress    := 'Address     : ';
      sPhone      := 'Phone       : ';
      sFax        := 'Fax         : ';
      sPayDays    := 'Pay in %S day(s)';
      sModel      := 'Model';
      sDesc       := 'Description';
      sCost       := '|Cost Price|';
      sCostQty    := '|Qty |Cost Price|';
      sThankyou   := 'Thank you.';
      sDate       := 'Date        :';
      sCompany    := 'Company Name:';
      sPriceQuote := 'Price Quote';
      sPurchase   := 'Purchase Order';
      sDueDate    := 'Due Date    :';
      sTotal      := 'Total:   ';
      sObs        := 'Obs         :';
    end;

    LANG_PORTUGUESE:
    begin
      sFraseLang1 := '';
      sFraseLang2 := '';
      sFrom       := 'DE          : ';
      sTo         := 'PARA        : ';
      sContact    := 'Contato     : ';
      sPhone      := 'Tel.        : ';
      sFax        := 'Fax         : ';
      sAddress    := 'Endereco    : ';
      sPayDays    := 'Pagar em %S dia(s)';
      sPONum      := 'FAVOR CONSTAR NA NF O NÚMERO DO NOSSO PEDIDO: ';
      sModel      := 'Modelo';
      sDesc       := 'Descrição';
      sCost       := '|Prç Custo |';
      sCostQty    := '|Qtd |Cost Price|';
      sThankyou   := '';
      sDate       := 'Data        :';
      sCompany    := 'Empresa     :';
      sPriceQuote := 'Cotação de Preço';
      sPurchase   := 'Ordem de Compra';
      sDueDate    := 'Entrega     :';
      sTotal      := 'Total:   ';
      sObs        := 'Obs         :';
    end;

    LANG_SPANISH:
    begin
      sFraseLang1 := '';
      sFraseLang2 := '';
      sFrom       := 'DE          : ';
      sTo         := 'PARA        : ';
      sContact    := 'Contacto    : ';
      sPhone      := 'Tel.        : ';
      sFax        := 'Fax         : ';
      sAddress    := 'Dirección   : ';
      sPayDays    := 'Pagar em $S dai(s)';
      sPONum      := 'INFORME POR FAVOR EL NUMERO OC EN LA FACTURA DE COMPRA: ';
      sModel      := 'Modelo';
      sDesc       := 'Descripción';
      sCost       := '|Prc Custo |';
      sCostQty    := '|Ctd |Prc Custo |';
      sThankyou   := '';
      sDate       := 'Fetcha      :';
      sCompany    := 'Compañía    :';
      sPriceQuote := 'Valore la Cita';
      sPurchase   := 'Orden de compra';
      sDueDate    := 'Entrega     :';
      sTotal      := 'Total:   ';
      sObs        := 'Obs         :';
    end;
  end;

  //1 - Quote, 2 - PO
  iFormType := Form;

  case iFormType of
    1: sFrase := sFraseLang1;
    2: sFrase := sFraseLang2;
  end;

  //Setup Language
  if (DMGlobal.IDLanguage <> LANG_ENGLISH) and (siLangFrameCont.StorageFile <> '') then
    if FileExists(DMGlobal.LangFilesPath + siLangFrameCont.StorageFile) then
      siLangFrameCont.LoadAllFromFile(DMGlobal.LangFilesPath + siLangFrameCont.StorageFile, True);
end;

procedure TFrameSendContact.UnInit;
begin
  ModelClose;
  VendorClose;
  POClose;
  Free;
end;

procedure TFrameSendContact.SetModelSQL(sSQL:String);
begin
  ModelClose;
  quModel.CommandText := sSQl;
  ModelOpen;
end;

procedure TFrameSendContact.SetModelDataSet(dsModelList:TDataSet);
begin
  ModelClose;
  TDataSet(quModel) := dsModelList;
  ModelOpen;
end;

procedure TFrameSendContact.SetVendorDataSet(dsVendor:TDataSet);
begin
 VendorClose;
 //somente no Price Quote
 TDataSet(quVendor) := dsVendor;
 VendorOpen;
end;

procedure TFrameSendContact.VendorClose;
begin
  with quVendor do
    if Active then
      Close;
end;

procedure TFrameSendContact.VendorOpen;
begin
  with quVendor do
    if not Active then
      Open;
end;

procedure TFrameSendContact.ModelRefresh;
begin
  ModelClose;
  ModelOpen;
end;

procedure TFrameSendContact.ModelOpen;
begin
  with quModel do
    if not Active then
      Open;
end;

procedure TFrameSendContact.ModelClose;
begin
  with quModel do
    if Active then
      Close;
end;

function TFrameSendContact.PutCaracter(x:integer; texto:string; Caracter:Char):String;
begin
  while length(texto) < x do
    texto := texto + Caracter;
  PutCaracter := texto;
end;

procedure TFrameSendContact.SetIDVendor(Value:Integer);
begin
  if (Value = FIDVendor) OR (Value = 0) then
     Exit;

  FIDVendor := Value;
  VendorClose;
  quVendor.Parameters.ParamByName('IDVendor').Value := FIDVendor;
  VendorOpen;
end;

procedure TFrameSendContact.SetStoreInf(Value:Integer);
begin
  if (Value = 0) then
    Exit;

  FIDStore := Value;

  with DM.quFreeSQL do
  begin
    if Active then
      Close;
    SQL.Clear;
    SQL.Add('Select S.Name Store, S.Address, S.Telephone Phone,');
    SQL.Add('E.Estado State, S.City, S.Zip, S.Fax, S.Contato, EM.Empresa');
    SQL.Add('From Store S');
    SQL.Add('Left Join Estado E on (S.IDEstado = E.IDEstado)');
    SQL.Add('Left Join Sis_Empresa EM on (S.IDEmpresa = EM.IDEmpresa)');
    SQL.Add('Where S.IDStore = '+IntToStr(FIDStore)+'');
    Open;

    if RecordCount <> 0 then
    begin
      if VendorName <> '' then
      begin
        sStoreInfo := sFrom +
                      DM.quFreeSQL.FieldByName('Empresa').AsString   + #13#10 +
                      sTo +
                      VendorName + #13#10;
      end
      else
      begin
      sStoreInfo := sFrom +
                    DM.quFreeSQL.FieldByName('Empresa').AsString   + #13#10;
      end;

      sStoreInfo := sStoreInfo +
                    sContact +
                    DM.quFreeSQL.FieldByName('Contato').AsString + #13#10 +
                    sAddress +
                    DM.quFreeSQL.FieldByName('Address').AsString + #13#10 +
                    '              ' +
                    DM.quFreeSQL.FieldByName('City').AsString    + ', '   +
                    DM.quFreeSQL.FieldByName('State').AsString   + ' - '  +
                    DM.quFreeSQL.FieldByName('Zip').AsString     + #13#10 +
                    sPhone +
                    DM.quFreeSQL.FieldByName('Phone').AsString   + #13#10 +
                    sFax +
                    DM.quFreeSQL.FieldByName('Fax').AsString;

      if FIDPayDay <> -1 then
      begin
        sStoreInfo := sStoreInfo + #13#10 +
                       Format(sPayDays, [IntToStr(FIDPayDay)]);
      end;
    end;

    Close;
  end;
end;

function TFrameSendContact.SaveModelListToFile(sModelList: TStringList;
  TipoTransf, Vendor: string): String;
var
  F: TextFile;
  sTexto, sFileName, sFileDate, sDir: String;
begin
  //Verifica se o memo esta vazio
  Result := '';

  if Trim(sModelList.Text) = '' then
  begin
    MsgBox(MSG_CRT_NO_ITEM, vbCritical + vbOkOnly);
    Exit;
  end;

  //Open Dialog para Salvar
  sFileDate := FormatDateTime('mmyyyy', Now);
  sDir      := DM.LocalPath + PO_FILE_DIR;

  if not DirectoryExists(sDir) then
    ForceDirectories(sDir);

  sFileName := sDir + ReplaceInvalidChars(Vendor) + ' ' + sFileDate + '.txt';
  Result := sFileName;

  //Sempre Salva p/ Text no arquivo
  AssignFile(F, sFileName);
  sTexto := sModelList.Text;
  Rewrite(F);
  Append(F);
  Write(F, sTexto);
  CloseFile(F);
end;

procedure TFrameSendContact.BuildModelList(var sModelList:TStringList;TipoTransf:string);

  function GetHeader(iType:Integer):String;
  begin
    Case iType of
      //Quote
      1 : Result := PutCaracter(17, sModel, ' ')+'|'+PutCaracter(50, sDesc, ' ') + sCost;
      //PO
      2 : Result := PutCaracter(30, sModel, ' ')+'|'+PutCaracter(50, sDesc, ' ') + sCostQty;
    end;
  end;

  function GetDetail(iType:Integer; cTipoTransfer:String):String;
  begin
    Case iType of
      //Quote
      1 : begin
          If cTipoTransfer = 'E' then
              Result := '->'+
                       PutCaracter(15, quModel.FieldByName('Model').AsString, ' ')+'|'+
                       PutCaracter(50, quModel.FieldByName('Description').AsString, ' ')+'|'+
                       PutCaracter(10, '0'+ DecimalSeparator +'00', ' ')+'|';

          If cTipoTransfer = 'F' then
             Result := PutCaracter(17, quModel.FieldByName('Model').AsString, ' ')+'|'+
                       PutCaracter(50, quModel.FieldByName('Description').AsString, ' ')+'|'+
                       PutCaracter(10, '    ', ' ')+'|';

          end;
      //PO
      2 : begin
             Result := PutCaracter(30, quModel.FieldByName('Model').AsString, ' ')+'|'+
                       PutCaracter(50, quModel.FieldByName('Description').AsString, ' ')+'|'+
                       PutCaracter(4, quModel.FieldByName('Qty').AsString, ' ')+'|'+
                       PutCaracter(10, quModel.FieldByName('CostPrice').AsString, ' ')+'|';
          end;
    end;
  end;

var
  x: integer;
  sTest: String;
begin

  //File Head **********************************
  with sModelList do
  begin
    Add(sStoreInfo);
    Add('');
    Add(sFrase);
    Add('');
    Add(PutCaracter(98,'', '='));
    Add('');
    Add(GetHeader(iFormType));
    Add(PutCaracter(98,'', '-'));
  end;

  //File Detail ********************************
  quModel.DisableControls;
  quModel.First;

  x := 0;
  while x < quModel.RecordCount do
  begin
    sModelList.Add(GetDetail(iFormType, TipoTransf));
    sModelList.Add(PutCaracter(98,'', '-'));
    inc(x);
    quModel.Next;
  end;

  qPO.DisableControls;
  POOpen;

  sModelList.Add(PutCaracter(81,'',' ') + sTotal + FloatToStr(qPOTotal.AsFloat));
  sModelList.Add(PutCaracter(98,'', '-'));

  quModel.EnableControls;

  //File Footer *********************************
  with sModelList do
  begin
    //PO INFO
    if (iFormType = 2) and (FIDPO<>-1) then
      Add(sPONum + IntToStr(FIDPO));
    Add(PutCaracter(98,'', '='));
    Add('');
    Add(sThankyou);
    Add('');
    Add('');
    Add(sDate    + DateToStr(qPODataPedido.AsDateTime));
    Add(sDueDate + DateToStr(qPOEstArrival.AsDateTime));
    Add(sContact + quVendor.FieldByName('Contato').AsString);
    Add(sCompany + quVendor.FieldByName('Vendor').AsString);
    Add(sPhone   + quVendor.FieldByName('Telefone').AsString);
    Add(sFax     + quVendor.FieldByName('Fax').AsString);
    Add(sObs     + qPOOBS.AsString );
    Add('');
  end;

  qPO.EnableControls;
  POClose;
end;

procedure TFrameSendContact.sbEmailFileClick(Sender: TObject);

  function GetVendorsEmail:String;
  var
    i: Integer;
  begin
    with quVendor do
    begin
      if not Active then
         Open;
      try
        if RecordCount = 0 then
          Exit;
        i := 1;
        DisableControls;
        First;
        while i <= RecordCount do
        begin
          if Trim(quVendor.FieldbyName('Email').AsString) <> '' then
            if i = RecordCount then
              Result := Result + FieldbyName('Email').AsString
            else
              Result := Result + FieldbyName('Email').AsString +', ';
          Next;
          Inc(i);
        end;
      finally
        EnableControls;
      end;
    end;
  end;

var
  sSubject, sTXTFile, sPDFFile: String;
  FFrmPrintPO: TFrmPrintPO;
begin
  //Validar o Email
  if quModel.RecordCount = 0 then
  begin
    MsgBox(MSG_CRT_NO_ITEM, vbCritical + vbOkOnly);
    Exit;
  end;

  sPDFFile := '';
  if DM.fPrintReceipt.POEmailFile in [PO_EMAIL_FILE_BOTH, PO_EMAIL_FILE_PDF] then
  begin
    FFrmPrintPO := TFrmPrintPO.Create(Self);
    try
      FFrmPrintPO.Start(IntToStr(IDPO), True);
      sPDFFile := FFrmPrintPO.FileName;
    finally
      FreeAndNil(FFrmPrintPO);
    end;
  end;

  sTXTFile := '';
  if DM.fPrintReceipt.POEmailFile in [PO_EMAIL_FILE_BOTH, PO_EMAIL_FILE_TXT] then
    try
      ModelOpen;
      //Crio o StrList
      sCreateModelList := TStringList.Create;
      //Crio a List de Models
      BuildModelList(sCreateModelList, 'E');
      //Salvo Para Arquivo
      sTXTFile := SaveModelListToFile(sCreateModelList, 'E', FVendorName);
    finally
      sCreateModelList.Free;
    end;

  //SendEmail
  case iFormType of
   1 : sSubject := sPriceQuote;
   2 : sSubject := sPurchase;
  end;

  with Emails do
  begin
    AttachedFiles.Clear;
    Recipients.Text    := GetVendorsEmail;

    FromName           := DM.fUser.UserName;
    Subject            := sSubject;
    Body               := sFrase;

    if sTXTFile <> '' then
      AttachedFiles.Add(sTXTFile);

    if sPDFFile <> '' then
      AttachedFiles.Add(sPDFFile);

    //Mostra o Email
    ShowDialog := True;
    SendMail;
  end;
end;

procedure TFrameSendContact.btPreviewVendorFaxClick(Sender: TObject);

  procedure SetRepTitle;
  var
    i: Integer;
    sTitle: String;
  begin
    case iFormType of
      1: sTitle := sPriceQuote;
      2: sTitle := sPurchase;
    end;

    with ppModel do
    begin
      if Title <> nil then
        with Title do
          for i := 0 to ObjectCount-1 do
            if Objects[i].UserName = 'lblTitulo' then
              Objects[i].Caption := sTitle
            else if Objects[i].UserName = 'mmStoreInfo' then
              Objects[i].Text := sStoreInfo
            else if Objects[i].UserName = 'mmFrase' then
              Objects[i].Text := sFrase;

          if Footer <> nil then
            with Footer do
              for i := 0 to ObjectCount-1 do
                if Objects[i].UserName = 'lblUsuarioData' then
                  Objects[i].Caption := DM.fUser.UserName;
    end;
  end;

begin
  SetRepTitle;
  ppModel.Print;
end;

procedure TFrameSendContact.ppModelBeforePrint(Sender: TObject);
begin
  ppModel.PreviewForm.WindowState:= wsMaximized;
end;

procedure TFrameSendContact.POOpen;
begin
  with qPO do
  begin
    Parameters.ParamByName('IDPo').Value := FIDPO;

    if not Active then
      Open;
  end;
end;

procedure TFrameSendContact.POClose;
begin
 with qPO do
    if Active then
      Close;
end;

procedure TFrameSendContact.qPOCalcFields(DataSet: TDataSet);
begin
  qPOTotal.AsCurrency := qPOSubTotal.AsCurrency +
                          qPOFreight.AsCurrency +
                          qPOCharges.AsCurrency;
end;

end.
