unit uWelcome;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, SHDocVw, dxBar, dxBarExtItems, ExtCtrls,
  uParentAllFrm, siComp, siLangRT;

type
  TFrmWelcome = class(TParentAllFrm)
    dxMainBar: TdxBarManager;
    lbAddress: TdxBarStatic;
    cbxAddress: TdxBarCombo;
    lbLinks: TdxBarStatic;
    btnSupport: TdxBarButton;
    btnHistory: TdxBarButton;
    btnHome: TdxBarButton;
    btBack: TdxBarButton;
    btNext: TdxBarButton;
    btStop: TdxBarButton;
    WebBrowser: TWebBrowser;
    Image: TImage;
    popBack: TdxBarPopupMenu;
    popForward: TdxBarPopupMenu;
    btRefresh: TdxBarButton;
    btSearch: TdxBarButton;
    procedure cbxAddressChange(Sender: TObject);
    procedure cbxAddressDrawItem(Sender: TdxBarCustomCombo;
      AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
    procedure cbxAddressKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSupportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure WebBrowserBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btBackClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
    procedure btSearchClick(Sender: TObject);
    procedure popBackPopup(Sender: TObject);
    procedure popForwardPopup(Sender: TObject);
  private
    { Private declarations }
    WebAddress   : string;
    UpdateCombo  : Boolean;
    HistoryIndex : Integer;
    HistoryList  : TStringList;
    WebPage      : String;
    procedure FindAddress;
  public
    { Public declarations }
    procedure Start(sWebAddress:String);
  end;

implementation

{$R *.DFM}

uses uDMGlobal;

procedure TFrmWelcome.FindAddress;
var
   Flags, TargetFrameName, PostData, Headers: OleVariant;
begin
   WebBrowser.Navigate(WebAddress, Flags, TargetFrameName, PostData, Headers);
end;


procedure TFrmWelcome.Start(sWebAddress:String);
begin

    Show;

    if sWebAddress <> '' then
       begin
       WebAddress := sWebAddress;
       FindAddress;
       end;

end;

procedure TFrmWelcome.cbxAddressChange(Sender: TObject);
begin
  inherited;

  if UpdateCombo then
     begin
     WebAddress := cbxAddress.Text;
     FindAddress;
     end;
end;

procedure TFrmWelcome.cbxAddressDrawItem(Sender: TdxBarCustomCombo;
  AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
var RectText : TRect;
begin
  inherited;

  with Sender,Canvas,ARect do begin
   Brush.Color := clWindow;
   FillRect(ARect);
   RectText := ARect;
   inc(RectText.Left, 16);
   if AIndex >= 0 then RectText.Right := RectText.Left + TextWidth(Items[AIndex]) + 4;
   if odSelected in AState then begin
     Brush.Color := clHighlight;
     FillRect(RectText);
   end;

   if AIndex >= 0 then begin
    Draw(Left + 1, Top + 2, Image.Picture.Bitmap);
    TextOut(RectText.Left + 2, Top , Items[AIndex]);
   end else
     if Sender.Text <> '' then begin
       Draw(Left + 1, Top + 2, Image.Picture.Bitmap);
       TextOut(RectText.Left + 2, Top , Sender.Text);
     end;
   if odSelected in AState then
     DrawFocusRect(RectText);
  end;


end;

procedure TFrmWelcome.cbxAddressKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_RETURN then
     cbxAddress.Items.Insert(0, WebAddress);
  
end;

procedure TFrmWelcome.btnSupportClick(Sender: TObject);
begin
  inherited;

  WebAddress := TdxBarButton(Sender).Hint;
  FindAddress;

end;

procedure TFrmWelcome.FormCreate(Sender: TObject);
begin
  inherited;

  HistoryList  := TStringList.Create;
  UpdateCombo  := True;
  HistoryIndex := -1;


  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           WebPage := 'OfficeMain.htm';
           end;
    LANG_PORTUGUESE :
           begin
           WebPage := 'OfficeMainBR.htm';
           end;
    LANG_SPANISH :
           begin
           WebPage := 'OfficeMainES.htm';
           end;
  end;

  btnHome.Hint := (ExtractFilePath(ParamStr(0))+WebPage);
  WebAddress   := btnHome.Hint;
  FindAddress;
end;

procedure TFrmWelcome.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;
end;

procedure TFrmWelcome.WebBrowserBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  NewIndex: Integer;
  NAddress: string;
begin
  inherited;

  //NAddress := URL;

  //if NAddress = '' then
     NAddress := WebAddress;

  if NAddress = '' then
     exit;

  //find the page index
  NewIndex := HistoryList.IndexOf(NAddress);

  //Is New Web
  if NewIndex = -1 then
     begin
     HistoryList.Add(NAddress);
     NewIndex := HistoryList.IndexOf(NAddress);
     end;

  //Update with the selected address
  UpdateCombo := False;
  cbxAddress.Text := NAddress;
  UpdateCombo := True;

  //Set the Actual history index
  HistoryIndex := NewIndex;

  //Enable the buttons
  btBack.Enabled := not (HistoryIndex = 0);
  btNext.Enabled := not (HistoryIndex = HistoryList.Count - 1);

end;

procedure TFrmWelcome.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  Action := caFree;
  WebBrowser.Stop;
  HistoryList.Free;

end;

procedure TFrmWelcome.btBackClick(Sender: TObject);
begin
  inherited;

  WebAddress := HistoryList[HistoryIndex - 1];
  FindAddress;

end;

procedure TFrmWelcome.btNextClick(Sender: TObject);
begin
  inherited;

  WebAddress := HistoryList[HistoryIndex + 1];
  FindAddress;

end;

procedure TFrmWelcome.btStopClick(Sender: TObject);
begin
  inherited;

  if HistoryIndex <> -1 then
     WebBrowser.Stop;

end;

procedure TFrmWelcome.btRefreshClick(Sender: TObject);
begin
  inherited;

  if HistoryIndex <> -1 then
     WebBrowser.Refresh;

end;

procedure TFrmWelcome.btnHistoryClick(Sender: TObject);
begin
  inherited;

  if TdxBarButton(Sender).ClickItemLink <> nil then
     begin
     WebAddress := TdxBarButton(Sender).ClickItemLink.UserCaption;
     FindAddress;
     end;

end;

procedure TFrmWelcome.btSearchClick(Sender: TObject);
begin
  inherited;
  WebBrowser.GoSearch; 
end;

procedure TFrmWelcome.popBackPopup(Sender: TObject);
var
  i : integer;
begin
  inherited;

  //update Backward
  with popBack.ItemLinks do
     begin
     Clear;
     for i := 0 to HistoryIndex - 1 do
        with Add do
           begin
           Index := 0;
           Item := btnHistory;
           UserCaption := HistoryList[I];
           end;
     end;

end;

procedure TFrmWelcome.popForwardPopup(Sender: TObject);
var
  i : integer;
begin
  inherited;

  with popForward.ItemLinks do
     begin
     Clear;
     for I := HistoryList.Count - 1 downto HistoryIndex + 1 do
         with Add do
             begin
             Index := 0;
             Item := btnHistory;
             UserCaption := HistoryList[i];
             end;
     end;

end;

end.
