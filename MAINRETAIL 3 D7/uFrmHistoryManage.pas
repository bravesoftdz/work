unit uFrmHistoryManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  DB, ADODB, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid, Email;

type
  TFrmHistoryManage = class(TFrmParentAll)
    quHistory: TADOQuery;
    quHistoryIDHistory: TIntegerField;
    quHistoryIDUser: TIntegerField;
    quHistoryMovDate: TDateTimeField;
    quHistoryOBS: TStringField;
    quHistoryIDHistoryType: TIntegerField;
    quHistoryIDPreSale: TIntegerField;
    quHistoryHistoryType: TStringField;
    dsHistory: TDataSource;
    Panel2: TPanel;
    Panel4: TPanel;
    grdHistory: TcxGrid;
    grdHistoryDB: TcxGridDBTableView;
    grdHistoryLevel: TcxGridLevel;
    quHistorySystemUser: TStringField;
    grdHistoryDBMovDate: TcxGridDBColumn;
    grdHistoryDBOBS: TcxGridDBColumn;
    grdHistoryDBHistoryType: TcxGridDBColumn;
    grdHistoryDBSystemUser: TcxGridDBColumn;
    btAdd: TSpeedButton;
    btnPrint: TSpeedButton;
    btnEmail: TSpeedButton;
    SD: TSaveDialog;
    Email: TEmail;
    quHistoryClientAddress: TStringField;
    quHistoryClientCity: TStringField;
    quHistoryClientNeighborhood: TStringField;
    quHistoryClientZip: TStringField;
    quHistoryClientPhone: TStringField;
    quHistoryClientCell: TStringField;
    quHistoryClientEmail: TStringField;
    quHistoryClientBirthDate: TDateTimeField;
    quHistoryClientEmployeeID: TStringField;
    quHistoryClientSocialSecurity: TStringField;
    quHistoryClientFederalID: TStringField;
    quHistoryClientSalesTax: TStringField;
    quHistoryClientDBA: TStringField;
    quHistoryPessoaFirstName: TStringField;
    quHistoryPessoaLastName: TStringField;
    grdHistoryDBSaleCode: TcxGridDBColumn;
    quHistorySaleCode: TStringField;
    quHistoryISaleCode: TStringField;
    quHistorySONumber: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure quHistoryAfterOpen(DataSet: TDataSet);
    procedure btnEmailClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure quHistoryCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    sHold,
    sUser,
    sDate,
    sHistType,
    sHistory,
    sCustomer,
    sAddress,
    sCity,
    sPhone : String;
    fIDPreSale : Integer;
    fIDServiceOrder : Integer;
    fHistoryList : TStringList;
    bSendEmail: Boolean;
    procedure HistoryOpen;
    procedure HistoryClose;
    procedure HistoryRefresh;
    procedure BuildHistory;
    function SaveToFile:String;
  public
    { Public declarations }
    function Start(IDPreSale:Integer):Boolean;
    function StartSO(IDServiceOrder:Integer):Boolean;
  end;

implementation

uses uDM, uDMGlobal, uFrmHistory;

{$R *.dfm}

{ TFrmHistoryManage }

procedure TFrmHistoryManage.HistoryClose;
begin
  with quHistory do
     if Active then
        Close;
end;

procedure TFrmHistoryManage.HistoryOpen;
begin
  with quHistory do
    if not Active then
    begin
      if fIDPreSale <> -1 then
      begin
        Parameters.ParamByName('IDPreSale').Value       := fIDPreSale;
        Parameters.ParamByName('IDPreSaleParent').Value := fIDPreSale;
      end
      else
      begin
        Parameters.ParamByName('IDPreSale').Value       := Null;
        Parameters.ParamByName('IDPreSaleParent').Value := Null;
      end;

      if fIDServiceOrder <> -1 then
        Parameters.ParamByName('IDServiceOrder').Value  := fIDServiceOrder
      else
        Parameters.ParamByName('IDServiceOrder').Value  := Null;
      Open;
    end;
end;

procedure TFrmHistoryManage.HistoryRefresh;
begin
   HistoryClose;
   HistoryOpen;
end;

function TFrmHistoryManage.StartSO(IDServiceOrder:Integer):Boolean;
begin
  fIDPreSale := -1;
  fIDServiceOrder := IDServiceOrder;
  HistoryRefresh;
  Self.Caption := sHold + IntToStr(fIDServiceOrder);
  ShowModal;
end;

function TFrmHistoryManage.Start(IDPreSale: Integer): Boolean;
begin
  fIDPreSale := IDPreSale;
  fIDServiceOrder := -1;
  HistoryRefresh;
  Self.Caption := sHold + IntToStr(fIDPreSale);
  ShowModal;
end;

procedure TFrmHistoryManage.FormCreate(Sender: TObject);
begin
  inherited;

  DM.imgBTN.GetBitmap(BTN_ADD, btAdd.Glyph);
  DM.imgBTN.GetBitmap(BTN_PRINT, btnPrint.Glyph);
  DM.imgBTN.GetBitmap(BTN_EMAIL, btnEmail.Glyph);

  Case DMGlobal.IDLanguage of
     LANG_ENGLISH :
           begin
           sHold     := 'Hold # ';
           sUser     := 'Vendor:';
           sDate     := 'Date:';
           sHistType := 'History Type:';
           sHistory  := 'History :';
           sCustomer := 'Customer: ';
           sAddress  := 'Address: ';
           sCity     := 'Complem: ';
           sPhone    := 'Phone: ';
           end;

     LANG_PORTUGUESE :
           begin
           sHold     := 'Nº Pedido ';
           sUser     := 'Vendedor :';
           sDate     := 'Data :';
           sHistType := 'Tipo de histórico :';
           sHistory  := 'Histórico :';
           sCustomer := 'Cliente: ';
           sAddress  := 'Endereço: ';
           sCity     := 'Compl: ';
           sPhone    := 'Tel: ';
           end;

     LANG_SPANISH :
           begin
           sHold     := 'Nº Factura ';
           sUser     := 'Vendedor:';
           sDate     := 'Fetcha:';
           sHistType := 'Tipo historico:';
           sHistory  := 'Historico :';
           sCustomer := 'Cliente: ';
           sAddress  := 'Dirección: ';
           sCity     := 'Compl: ';
           sPhone    := 'Tel: ';
           end;
   end;

  fHistoryList := TStringList.Create;

end;

procedure TFrmHistoryManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(fHistoryList);
  Action := caFree;
end;

procedure TFrmHistoryManage.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmHistoryManage.btAddClick(Sender: TObject);
var
  sHistParam : String;
  dDate : TDateTime;
  bResult : Boolean;
begin
  inherited;
  with TFrmHistory.Create(Self) do
  begin
    if fIDPreSale <> -1 then
      bResult := Start(-1, fIDPreSale, DM.fUser.ID, Now, quHistorySaleCode.AsString, sHistParam, dDate)
    else
      bResult := StartSO(-1, fIDServiceOrder, DM.fUser.ID, Now, IntToStr(fIDServiceOrder), sHistParam, dDate);

    if bResult then
      HistoryRefresh;
  end;
end;

procedure TFrmHistoryManage.quHistoryAfterOpen(DataSet: TDataSet);
begin
  inherited;

  grdHistoryDB.DataController.Groups.FullExpand;
  grdHistoryDB.DataController.GotoFirst;

end;

procedure TFrmHistoryManage.BuildHistory;
begin
  with fHistoryList do
    begin
    Clear;
    quHistory.DisableControls;
    quHistory.First;
    Add(sHold+quHistorySaleCode.AsString);
    Add(sCustomer+quHistoryPessoaFirstName.AsString + ' ' + quHistoryPessoaLastName.AsString);
    Add(sAddress+quHistoryClientAddress.AsString);
    Add(sCity+quHistoryClientCity.AsString + ', ' +quHistoryClientNeighborhood.AsString + ' - ' + quHistoryClientZip.AsString);
    Add(sPhone+quHistoryClientPhone.AsString);
    Add('');
    Try
      While not quHistory.Eof do
        begin
        Add(sUser + quHistorySystemUser.AsString);
        Add(sDate + quHistoryMovDate.AsString);
        Add(quHistoryHistoryType.AsString + ' : ' + quHistoryOBS.AsString);
        Add('-------------------------------------------------');
        quHistory.Next;
        end;
    finally
      quHistory.EnableControls;
      end;
    end;
end;

function TFrmHistoryManage.SaveToFile:String;
var
  F: TextFile;
  Texto, FileN: String;
begin

 BuildHistory;
 bSendEmail := false;

 With SD do
   begin
   If Execute then
      begin
      bSendEmail := true;
      If FileName <> '' then
         begin
         if Pos('.txt', LowerCase(FileName)) = 0 then
            FileName := FileName + '.txt';
         FileN  := FileName;
         end
      else
         exit;
      end
   else
      exit;
   end;

 Result := FileN;

 //Sempre Salva p/ Text no arquivo
 AssignFile(F, FileN);
 Texto := fHistoryList.Text;
 Rewrite(F);
 Append(F);
 Write(F, Texto);
 CloseFile(F);

end;

procedure TFrmHistoryManage.btnEmailClick(Sender: TObject);
begin
  inherited;
  //BuildHistory;
  with Email do
    begin
    Recipients.Text    := '';
    FromName           := DM.fUser.UserName;
    Subject            := '';
    AttachedFiles.Text := SaveToFile;
    Body               := fHistoryList.GetText;
    ShowDialog         := True;
      if bSendEmail then
      begin
          SendMail;
          bSendEmail := false;
      end;
    end;

end;

procedure TFrmHistoryManage.btnPrintClick(Sender: TObject);
const
  TAM_LINHA = 80;
var
  i : integer;
  sTextoInteiro,
  sLinhaPrint : String;
begin
  inherited;
  BuildHistory;
  try
     DM.PrinterStart;
     for i:= 0 to fHistoryList.Count-1 do
     begin
       sTextoInteiro := fHistoryList.Strings[i];
       while sTextoInteiro <> '' do
       begin
         sLinhaPrint := Copy(sTextoInteiro, 1, TAM_LINHA);
         Delete(sTextoInteiro, 1, TAM_LINHA);
         DM.PrintLine(sLinhaPrint);
       end;
     end;
  finally
     DM.PrinterStop;
  end;
end;

procedure TFrmHistoryManage.quHistoryCalcFields(DataSet: TDataSet);
begin
  inherited;
  if quHistoryISaleCode.AsString = '' then
    quHistorySaleCode.AsString := quHistorySONumber.AsString
  else
    quHistorySaleCode.AsString := quHistoryISaleCode.AsString;
end;

end.
