unit uSubSendFax;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentSub, siComp, siLangRT, Email, DB,
  ppVar, ppBands, ppCtrls, ppStrtch, ppMemo, ppPrnabl, ppClass, ppCache,
  ppProd, ppReport, ppDB, ppComm, ppRelatv, ppDBPipe, ppDBBDE, ADODB,
  Buttons, StdCtrls, ExtCtrls;

type
  TSubSendFax = class(TParentSub)
    lbFormType: TLabel;
    quModel: TADODataSet;
    quModelModel: TStringField;
    quModelDescription: TStringField;
    ppPipeline: TppBDEPipeline;
    ppPipelineppField1: TppField;
    ppPipelineppField2: TppField;
    ppPipelineppField3: TppField;
    dsModel: TDataSource;
    ppModel: TppReport;
    ppTitleBand: TppTitleBand;
    ppLabel6: TppLabel;
    ppMemo2: TppMemo;
    ppMemo3: TppMemo;
    ppHeaderBand: TppHeaderBand;
    ppLabel1: TppLabel;
    ppLabel7: TppLabel;
    ppLabel4: TppLabel;
    ppLabel2: TppLabel;
    ppDetailBand: TppDetailBand;
    ppShape1: TppShape;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppFooterBand: TppFooterBand;
    ppLabel8: TppLabel;
    ppSystemVariable2: TppSystemVariable;
    quVendor: TADODataSet;
    quVendorIDPessoa: TAutoIncField;
    quVendorFax: TStringField;
    quVendorEmail: TStringField;
    quVendorVendor: TStringField;
    SD: TSaveDialog;
    Emails: TEmail;
    Panel1: TPanel;
    sbEmailFile: TSpeedButton;
    btPreviewVendorFax: TSpeedButton;
    sbSendFax: TSpeedButton;
    quModelQty: TFloatField;
    procedure sbEmailFileClick(Sender: TObject);
    procedure btPreviewVendorFaxClick(Sender: TObject);
    procedure ppModelBeforePrint(Sender: TObject);
  private
    { Private declarations }
    fIDStore  :Integer;
    fIDVendor :Integer;

    //1 - Quote, 2 - PO
    iFormType : Integer;

    sStoreInfo: String;
    sFrase    : String;

    //Criate for email e fax
    sCreateModelList : TStringList;

    procedure VendorClose;
    procedure VendorOpen;

    procedure ModelOpen;
    procedure ModelClose;
    procedure ModelRefresh;

    procedure BuildModelList(var sModelList:TStringList;TipoTransf:string);
    function  SaveModelListToFile(sModelList:TStringList;TipoTransf:string):String;

    procedure SetStoreInf(Value:Integer);
    procedure SetIDVendor(Value:Integer);

    function PutCaracter(x:integer; texto:string; Caracter:Char):String;

  public
    { Public declarations }
    procedure SetModelDataSet(dsModelList:TDataSet);
    procedure SetModelSQL(sSQL:String);
    //somente no Price Quote
    procedure SetVendorDataSet(dsVendor:TDataSet);
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uDMGlobal;

{$R *.dfm}

procedure TSubSendFax.SetVendorDataSet(dsVendor:TDataSet);
begin
  VendorClose;
  //somente no Price Quote
  TDataSet(quVendor) := dsVendor;
  VendorOpen;
end;


procedure TSubSendFax.SetModelSQL(sSQL:String);
begin
  ModelClose;
  quModel.CommandText := sSQl;
  ModelOpen;
end;


procedure TSubSendFax.SetModelDataSet(dsModelList:TDataSet);
begin
  ModelClose;
  TDataSet(quModel) := dsModelList;
  ModelOpen;
end;


function TSubSendFax.PutCaracter(x:integer; texto:string; Caracter:Char):String;
begin
   While length(texto) < x do
        texto := texto + Caracter;
   PutCaracter := texto;
end;


procedure TSubSendFax.SetIDVendor(Value:Integer);
begin

  if (Value = FIDVendor) OR (Value = 0) then
     Exit;

  FIDVendor := Value;

  VendorClose;

  quVendor.Parameters.ParamByName('IDVendor').Value := FIDVendor;

  VendorOpen;

end;


procedure TSubSendFax.SetStoreInf(Value:Integer);
begin

  if (Value = FIDStore) OR (Value = 0) then
     Exit;

  FIDStore := Value;

  With DM.quFreeSQL do
   begin
   If Active then
      Close;
   SQL.Clear;
   SQL.Add('Select S.Name Store, S.Address, S.Telephone Phone,');
   SQL.Add('E.Estado State, S.City, S.Zip, S.Fax, S.Contato');
   SQL.Add('From Store S (NOLOCK)');
   SQL.Add('Left Join Estado E (NOLOCK) on (S.IDEstado = E.IDEstado)');
   SQL.Add('Where S.IDStore = '+IntToStr(FIDStore)+'');
   Open;

   if RecordCount <> 0 then
      begin
      sStoreInfo := 'FROM        : ' +
                    DM.quFreeSQL.FieldByName('Store').AsString   + #13#10 +
                    'Contact     : ' +
                    DM.quFreeSQL.FieldByName('Contato').AsString + #13#10 +
                    'Address     : ' +
                    DM.quFreeSQL.FieldByName('Address').AsString + #13#10 +
                    '              ' +
                    DM.quFreeSQL.FieldByName('City').AsString    + ', '   +
                    DM.quFreeSQL.FieldByName('State').AsString   + ' - '  +
                    DM.quFreeSQL.FieldByName('Zip').AsString     + #13#10 +
                    'Phone       : ' +
                    DM.quFreeSQL.FieldByName('Phone').AsString   + #13#10 +
                    'Fax         : ' +
                    DM.quFreeSQL.FieldByName('Fax').AsString;

      end;

   Close;
   end;

end;


function TSubSendFax.SaveModelListToFile(sModelList:TStringList;TipoTransf:string):String;
var
  F: TextFile;
  Texto,  FileN: String;
begin
//Verifica se o memo esta vazio
  Result := '';

  If Trim(sModelList.Text) = '' then
     begin
     MsgBox(MSG_CRT_NO_ITEM, vbCritical + vbOkOnly);
     Exit;
     end;

 //Open Dialog para Salvar
 With SD do
   begin
   Case iFormType of
     1 : FileName := 'New Quote.txt';
     2 : FileName := 'New PO.txt';
   end;

   If Execute then
      begin
      If FileName <> '' then
         begin
         if Pos('.txt', LowerCase(FileName)) = 0 then
            FileName := FileName + '.txt';

         FileN  := FileName;
         Result := FileName;
         end
      else
         exit;
      end
     else
      exit;
   end;

 //Sempre Salva p/ Text no arquivo
 AssignFile(F, FileN);
 Texto := sModelList.Text;
 Rewrite(F);
 Append(F);
 Write(F, Texto);
 CloseFile(F);

end;


procedure TSubSendFax.BuildModelList(var sModelList:TStringList;TipoTransf:string);
    function GetHeader(iType:Integer):String;
    begin
      Case iType of
        //Quote
        1 : Result := PutCaracter(17, 'Model', ' ')+'|'+PutCaracter(50, 'Description', ' ')+
                      '|Cost Price|';
        //PO
        2 : Result := PutCaracter(17, 'Model', ' ')+'|'+PutCaracter(45, 'Description', ' ')+
                      '|Qty |Cost Price|';
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
                         PutCaracter(10, '0.00', ' ')+'|';

            If cTipoTransfer = 'F' then
               Result := PutCaracter(17, quModel.FieldByName('Model').AsString, ' ')+'|'+
                         PutCaracter(50, quModel.FieldByName('Description').AsString, ' ')+'|'+
                         PutCaracter(10, '    ', ' ')+'|';

            end;
        //PO
        2 : begin
               Result := PutCaracter(17, quModel.FieldByName('Model').AsString, ' ')+'|'+
                         PutCaracter(45, quModel.FieldByName('Description').AsString, ' ')+'|'+
                         PutCaracter(4, quModel.FieldByName('Qty').AsString, ' ')+'|'+
                         PutCaracter(10, '    ', ' ')+'|';

            end;
      end;
    end;

var
  x : integer;
  sTest : String;
begin

  //File Head **********************************
  With sModelList do
     begin
     Add(sStoreInfo);
     Add('');
     Add(sFrase);
     Add('');
     Add(PutCaracter(80,'', '='));
     Add('');
     Add(GetHeader(iFormType));
     Add(PutCaracter(80,'', '-'));
     end;


  //File Detail ********************************

  quModel.DisableControls;

  quModel.First;

  x := 0;
  While x < quModel.RecordCount do
    begin
    sModelList.Add(GetDetail(iFormType, TipoTransf));
    sModelList.Add(PutCaracter(80,'', '-'));
    inc(x);
    quModel.Next;
    end;

  quModel.EnableControls;


  //File Footer *********************************
  With sModelList do
    begin
    Add('');
    Add(PutCaracter(80,'', '='));
    Add('');
    Add('Thank you.');
    Add('');
    Add('');
    Add('Date        :');
    Add('Contact     :');
    Add('Company Name:');
    Add('Phone       :');
    Add('Fax         :');
    Add('');
    end;

end;


procedure TSubSendFax.ModelRefresh;
begin
  ModelClose;
  ModelOpen;
end;

procedure TSubSendFax.ModelOpen;
begin
   with quModel do
      if not Active then
         Open;
end;

procedure TSubSendFax.ModelClose;
begin
   with quModel do
      if Active then
         Close;
end;

procedure TSubSendFax.VendorClose;
begin
   with quVendor do
      if Active then
         Close;
end;

procedure TSubSendFax.VendorOpen;
begin
  with quVendor do
     if not Active then
        Open;
end;

procedure TSubSendFax.sbEmailFileClick(Sender: TObject);
  function GetVendorsEmail:String;
  var
  i:Integer;
  begin
    With quVendor do
      begin
      if not Active then
         Open;
      try
        If RecordCount = 0 then
           Exit;
        i := 1;
        DisableControls;
        First;
        While i <= RecordCount do
           begin
           If Trim(quVendor.FieldbyName('Email').AsString) <> '' then
              If i = RecordCount then
                 Result := Result + FieldbyName('Email').AsString
              else
                 Result := Result + FieldbyName('Email').AsString +', ';
           Next;
           Inc(i);
           end;
      Finally
        EnableControls;
        end;
      end;
  end;

var
  sSubject, sFile : String;
begin

  //Validar o Email
 If quModel.RecordCount = 0 then
    begin
    MsgBox(MSG_CRT_NO_ITEM, vbCritical + vbOkOnly);
    Exit;
    end;

 try
   ModelOpen;
   //Crio o StrList
   sCreateModelList := TStringList.Create;
   //Crio a List de Models
   BuildModelList(sCreateModelList, 'E');
   //Salvo Para Arquivo
   sFile := SaveModelListToFile(sCreateModelList, 'E');
   if sFile = '' then
      Exit;

 Finally
   sCreateModelList.Free;
   end;

 //SendEmail
 Case iFormType of
   1 : sSubject := 'Price Quote';
   2 : sSubject := 'Purchase Order';
 end;

 with Emails do
   begin
   Recipients.Text    := GetVendorsEmail;

   FromName           := DM.fUser.UserName;
   Subject            := sSubject;
   Body               := sFrase;
   AttachedFiles.Text := sFile;

   //Mostra o Email
   ShowDialog := True;
   SendMail;

   end;

end;

procedure TSubSendFax.btPreviewVendorFaxClick(Sender: TObject);
  procedure SetRepTitle;
  var
     sTitle : String;
     i : Integer;
  begin
       Case iFormType of
         1 : sTitle := 'Price Quote';
         2 : sTitle := 'Purchase Order';
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

          //Quote nao aparece QTY
          if iFormType = 1 then
             begin
             if Header <> nil then
                with Header do
                   For i := 0 to ObjectCount-1 do
                      if Objects[i].UserName = 'lbQty' then
                         Objects[i].Visible := False;


             if Detail <> nil then
                with Detail do
                   For i := 0 to ObjectCount-1 do
                      if Objects[i].UserName = 'dbQty' then
                         Objects[i].Visible := False;

             end;

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

procedure TSubSendFax.ppModelBeforePrint(Sender: TObject);
begin
  inherited;
  ppModel.PreviewForm.WindowState:= wsMaximized;
  //TppViewer(ppModel.PreviewForm.Viewer).ZoomSetting:= zsPageWidth;

end;

initialization
   RegisterClass(TSubSendFax);

end.
