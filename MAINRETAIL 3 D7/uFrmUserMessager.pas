unit uFrmUserMessager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PAIDETODOS, siComp, siLangRT, StdCtrls, LblEffct, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, ADODB, ComCtrls, ImgList, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls,
  cxGridCustomView, cxGrid, DBCtrls, Buttons;

const
   MSG_INBOX   = 0;
   MSG_READ    = 1;
   MSG_SENT    = 2;
   MSG_DELETED = 3;

type
  TFrmUserMessager = class(TFrmParent)
    Panel4: TPanel;
    btnNew: TSpeedButton;
    btnMarkMsg: TSpeedButton;
    btnReplay: TSpeedButton;
    btnForward: TSpeedButton;
    btnSendReceive: TSpeedButton;
    Panel5: TPanel;
    Splitter2: TSplitter;
    msgBody: TDBMemo;
    pnlDetalhes: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    DBText1: TDBText;
    DBText2: TDBText;
    mmReceivers: TMemo;
    gridMessage: TcxGrid;
    gridMessageDBTableView1: TcxGridDBTableView;
    gridMessageDBTableView1CreationDate: TcxGridDBColumn;
    gridMessageDBTableView1ReadDate: TcxGridDBColumn;
    gridMessageDBTableView1SystemUser: TcxGridDBColumn;
    gridMessageDBTableView1Subject: TcxGridDBColumn;
    gridMessageDBTableView1Body: TcxGridDBColumn;
    gridMessageLevel1: TcxGridLevel;
    imgList: TImageList;
    Splitter1: TSplitter;
    treMessage: TTreeView;
    quMessage: TADODataSet;
    quMessageIDMessage: TIntegerField;
    quMessageCreationDate: TDateTimeField;
    quMessageSubject: TStringField;
    quMessageBody: TStringField;
    quMessageIDUserSender: TIntegerField;
    quMessageSystemUser: TStringField;
    dsMessage: TDataSource;
    btnRemove: TSpeedButton;
    btnRestore: TSpeedButton;
    btnEmptyBin: TSpeedButton;
    procedure treMessageClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dsMessageDataChange(Sender: TObject; Field: TField);
    procedure treMessageCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure btnReplayClick(Sender: TObject);
    procedure btnMarkMsgClick(Sender: TObject);
    procedure quMessageAfterOpen(DataSet: TDataSet);
    procedure btnSendReceiveClick(Sender: TObject);
    procedure btnForwardClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnEmptyBinClick(Sender: TObject);
  private
    sInBox,
    sRead,
    sSendItem,
    sDeletedItems,
    sSystem,
    sMsg,
    sMarkRead,
    sMarkUnRead: String;

    iTotalMsg : Integer;

    function GetSQLInBox: String;
    function GetSQLRead: String;
    function GetSQLSend: String;
    function GetSQLDeleted: String;

    procedure OpenMessage;
    procedure CloseMessage;
    procedure RefreshMessage;

    function GetReceivers:String;

  public
    function Start:Boolean;
  end;

implementation

uses uDM, uDMGlobal, uFrmUserMessageSend;

{$R *.dfm}

{ TFrmUserMessager }

procedure TFrmUserMessager.CloseMessage;
begin
  with quMessage do
    if Active then
       Close;
end;

function TFrmUserMessager.GetReceivers: String;
begin
  if quMessageIDMessage.AsString <> '' then
    with DM.quFreeSQL do
      begin
        if Active then
           Close;

        SQL.Text := 'SELECT SU.SystemUser ' +
                    'FROM Sis_MessageUser MU (NOLOCK) ' +
                    'JOIN SystemUser SU (NOLOCK) ON (MU.IDUserReceiver = SU.IDUser) ' +
                    'WHERE MU.IDMessage = ' + quMessageIDMessage.AsString;

        Open;

        while not Eof do
          begin
            if Result <> '' then
              Result := Result + '; ';
            Result := Result + FieldByName('SystemUser').AsString;

            Next;
          end;

        Close;
      end;
end;

function TFrmUserMessager.GetSQLInBox: String;
begin
  Result := 'SELECT ' +
            '  M.IDMessage, ' +
            '  M.CreationDate, ' +
            '  M.Subject, ' +
            '  M.Body, ' +
            '  M.IDUserSender, ' +
            '  SU.SystemUser ' +
            'FROM  ' +
            '  Sis_Message M (NOLOCK) ' +
            '  JOIN Sis_MessageUser MU (NOLOCK) ON (M.IDMessage = MU.IDMessage) ' +
            '  JOIN SystemUser SU (NOLOCK) ON (M.IDUserSender = SU.IDUser) ' +
            'WHERE ' +
            '  MU.IDUserReceiver = ' + IntToStr(DM.fUser.ID) +
            '  AND MU.ReadDate IS NULL ' +
            '  AND MU.Desativado = 0';
end;

function TFrmUserMessager.GetSQLRead: String;
begin
  Result := 'SELECT ' +
            '  M.IDMessage, ' +
            '  M.CreationDate, ' +
            '  M.Subject, ' +
            '  M.Body, ' +
            '  M.IDUserSender, ' +
            '  SU.SystemUser ' +
            'FROM  ' +
            '  Sis_Message M (NOLOCK) ' +
            '  JOIN Sis_MessageUser MU (NOLOCK) ON (M.IDMessage = MU.IDMessage) ' +
            '  JOIN SystemUser SU (NOLOCK) ON (M.IDUserSender = SU.IDUser) ' +
            'WHERE ' +
            '  MU.IDUserReceiver = ' + IntToStr(DM.fUser.ID) +
            '  AND MU.ReadDate IS NOT NULL ' +
            '  AND MU.Desativado = 0';
end;

function TFrmUserMessager.GetSQLSend: String;
begin
  Result := 'SELECT ' +
            '  M.IDMessage, ' +
            '  M.CreationDate, ' +
            '  M.Subject, ' +
            '  M.Body, ' +
            '  M.IDUserSender, ' +
            '  SU.SystemUser ' +
            'FROM  ' +
            '  Sis_Message M (NOLOCK) ' +
            '  JOIN SystemUser SU (NOLOCK) ON (M.IDUserSender = SU.IDUser) ' +
            'WHERE ' +
            '  M.IDUserSender = ' + IntToStr(DM.fUser.ID) +
            '  AND M.Desativado = 0';
end;

procedure TFrmUserMessager.OpenMessage;
begin
  with quMessage do
    if not Active then
       Open;
end;

procedure TFrmUserMessager.RefreshMessage;
begin
   CloseMessage;
   OpenMessage;
end;

function TFrmUserMessager.Start: Boolean;
begin
  ShowModal;
end;

procedure TFrmUserMessager.treMessageClick(Sender: TObject);
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;
    CloseMessage;

    case treMessage.Selected.Index of
      MSG_INBOX:
      begin
        quMessage.CommandText :=  GetSQLInBox;
      end;

      MSG_READ:
      begin
        quMessage.CommandText := GetSQLRead;
      end;

      MSG_SENT:
      begin
        quMessage.CommandText := GetSQLSend;
      end;

      MSG_DELETED:
      begin
        quMessage.CommandText := GetSQLDeleted;
      end;
    end;
   finally
     OpenMessage;
     Screen.Cursor := crDefault;
   end;
end;

procedure TFrmUserMessager.btnNewClick(Sender: TObject);
var
  IDMessage : Integer;
  sSubject, sMsg, sIDUsers : String;
  bResult : Boolean;
  fUserList : TStringList;
  i : Integer;
begin
  inherited;

  with TFrmUserMessageSend.Create(Self) do
  begin
    bResult := Start(TYPE_NEW, sSubject, sMsg, sIDUsers, '');
    Free;
  end;

  if not bResult then
     Exit;

  IDMessage := DM.GetNextID('Sis_Message.IDMessage');

  DM.RunSQL('INSERT INTO Sis_Message (IDMessage, CreationDate, Subject, Body, IDUserSender) ' +
            ' VALUES (' + IntToStr(IDMessage) + ', GetDate(), ' + QuotedStr(sSubject) +
            ', ' + QuotedStr(sMsg) + ', '+IntToStr(DM.fUser.ID)+')');

  fUserList := TStringList.Create;
  try
    fUserList.CommaText := sIDUsers;

    for i := 0 to fUserList.Count-1 do
    begin
      DM.RunSQL('INSERT INTO Sis_MessageUser (IDMessage, IDUserReceiver) ' +
                'VALUES (' + IntToStr(IDMessage) + ', '+fUserList.Strings[i]+')');
    end;
  finally
    FreeAndNil(fUserList);
  end;

  RefreshMessage;
end;

procedure TFrmUserMessager.FormShow(Sender: TObject);
begin
  inherited;
  treMessage.Select(treMessage.Items.GetFirstNode);
  treMessageClick(Self);

  //Get image
  DM.imgBTN.GetBitmap(BTN_DELETE, btnRemove.Glyph);
  DM.imgBTN.GetBitmap(BTN_RESTORE, btnRestore.Glyph);
  DM.imgSubMenu.GetBitmap(59,imgMenu.Picture.Bitmap);

  treMessage.Items.Item[0].Text := sInBox;
  treMessage.Items.Item[1].Text := sRead;
  treMessage.Items.Item[2].Text := sSendItem;
  treMessage.Items.Item[3].Text := sDeletedItems;

  //Set os Captions
  lblMenu.Caption    := sSystem;
  lblSubMenu.Caption := sMsg;

  lblSubMenu.Width := 190;
  imgTopIni.Width  := lblSubMenu.Width;
end;

procedure TFrmUserMessager.dsMessageDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  with mmReceivers do
    begin
      Text := GetReceivers;

      if Lines.Count > 2 then
        ScrollBars := ssVertical
      else
        ScrollBars := ssNone;
    end;

end;

procedure TFrmUserMessager.treMessageCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  inherited;
  if (iTotalMsg > 0) and (Node.Index = MSG_INBOX) then
  begin
    Node.Text := sInBox + ' ('+IntToStr(iTotalMsg) + ')';
    Sender.Canvas.Font.Style := [fsBold];
  end
  else if (Node.Index = MSG_INBOX) then
  begin
    Node.Text := sInBox;
    Sender.Canvas.Font.Style := [];
  end;
end;

procedure TFrmUserMessager.btnReplayClick(Sender: TObject);
var
  IDMessage : Integer;
  sSubject, sMsg, sIDUsers : String;
  bResult : Boolean;
begin
  inherited;

  sIDUsers := quMessageSystemUser.AsString;
  sSubject := quMessageSubject.AsString;

  with TFrmUserMessageSend.Create(Self) do
  begin
    bResult := Start(TYPE_REPLAY, sSubject, sMsg, sIDUsers, quMessageBody.AsString);
    Free;
  end;

  if not bResult then
    Exit;

  IDMessage := DM.GetNextID('Sis_Message.IDMessage');

  DM.RunSQL('INSERT INTO Sis_Message (IDMessage, CreationDate, Subject, Body, IDUserSender) ' +
            ' VALUES (' + IntToStr(IDMessage) + ', GetDate(), ' + QuotedStr(sSubject) +
            ', ' + QuotedStr(sMsg) + ', '+IntToStr(DM.fUser.ID)+')');

  DM.RunSQL('INSERT INTO Sis_MessageUser (IDMessage, IDUserReceiver) ' +
            'VALUES (' + IntToStr(IDMessage) + ', '+quMessageIDUserSender.AsString+')');

  DM.RunSQL('UPDATE Sis_MessageUser SET ReadDate = GetDate() ' +
            'WHERE IDMessage = ' + quMessageIDMessage.AsString  +
            ' AND IDUserReceiver = ' + IntToStr(DM.fUser.ID));

  RefreshMessage;
end;

procedure TFrmUserMessager.btnMarkMsgClick(Sender: TObject);
begin
  inherited;
  case treMessage.Selected.Index of
    MSG_INBOX:
      DM.RunSQL('UPDATE Sis_MessageUser SET ReadDate = GetDate() WHERE IDMessage = ' + quMessageIDMessage.AsString +
                ' AND IDUserReceiver = ' + IntToStr(DM.fUser.ID));

    MSG_READ:
      DM.RunSQL('UPDATE Sis_MessageUser SET ReadDate = NULL WHERE IDMessage = ' + quMessageIDMessage.AsString +
                ' AND IDUserReceiver = ' + IntToStr(DM.fUser.ID));
  end;

  RefreshMessage;
end;

procedure TFrmUserMessager.quMessageAfterOpen(DataSet: TDataSet);
begin
  inherited;
  case treMessage.Selected.Index of
    MSG_INBOX:
    begin
      btnRemove.Visible  := True;
      btnRemove.Enabled  := (quMessage.RecordCount>0);
      btnRestore.Visible := False;
      iTotalMsg          := quMessage.RecordCount;
      btnMarkMsg.Enabled := (quMessage.RecordCount>0);
      btnReplay.Enabled  := (quMessage.RecordCount>0);
      btnForward.Enabled := (quMessage.RecordCount>0);
      btnMarkMsg.Caption := sMarkRead;
      btnEmptyBin.Visible := False;
    end;

    MSG_READ:
    begin
      btnRemove.Visible   := True;
      btnRemove.Enabled   := (quMessage.RecordCount>0);
      btnRestore.Visible  := False;
      btnMarkMsg.Enabled  := (quMessage.RecordCount>0);
      btnReplay.Enabled   := (quMessage.RecordCount>0);
      btnForward.Enabled  := (quMessage.RecordCount>0);
      btnMarkMsg.Caption  := sMarkUnRead;
      btnEmptyBin.Visible := False;
    end;

    MSG_SENT:
    begin
      btnRemove.Visible   := True;
      btnRemove.Enabled   := (quMessage.RecordCount>0);
      btnRestore.Visible  := False;
      btnMarkMsg.Enabled  := False;
      btnReplay.Enabled   := False;
      btnForward.Enabled  := False;
      btnEmptyBin.Visible := False;
    end;

    MSG_DELETED:
    begin
      btnRestore.Visible  := True;
      btnRestore.Enabled  := (quMessage.RecordCount>0);
      btnRemove.Visible   := False;
      btnMarkMsg.Enabled  := False;
      btnReplay.Enabled   := False;
      btnForward.Enabled  := False;
      btnEmptyBin.Visible := True;
    end;
  end;
end;

procedure TFrmUserMessager.btnSendReceiveClick(Sender: TObject);
begin
  inherited;

  RefreshMessage;
  
end;

procedure TFrmUserMessager.btnForwardClick(Sender: TObject);
var
  IDMessage : Integer;
  sSubject, sMsg, sIDUsers : String;
  bResult : Boolean;
  fUserList : TStringList;
  i : Integer;
begin
  inherited;
  sSubject := quMessageSubject.AsString;

  with TFrmUserMessageSend.Create(Self) do
  begin
    bResult := Start(TYPE_FORWARD, sSubject, sMsg, sIDUsers, quMessageBody.AsString);
    Free;
  end;

  if not bResult then
    Exit;

  IDMessage := DM.GetNextID('Sis_Message.IDMessage');

  DM.RunSQL('INSERT INTO Sis_Message (IDMessage, CreationDate, Subject, Body, IDUserSender) ' +
            ' VALUES (' + IntToStr(IDMessage) + ', GetDate(), ' + QuotedStr(sSubject) +
            ', ' + QuotedStr(sMsg) + ', '+IntToStr(DM.fUser.ID)+')');

  fUserList := TStringList.Create;
  try
    fUserList.CommaText := sIDUsers;

    for i := 0 to fUserList.Count-1 do
      begin
      DM.RunSQL('INSERT INTO Sis_MessageUser (IDMessage, IDUserReceiver) ' +
                'VALUES (' + IntToStr(IDMessage) + ', '+fUserList.Strings[i]+')');
      end;
  finally
    FreeAndNil(fUserList);
  end;

  RefreshMessage;
end;

procedure TFrmUserMessager.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmUserMessager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DM.VerifyMessage;
  Action := caFree;
end;

procedure TFrmUserMessager.FormCreate(Sender: TObject);
begin
  inherited;

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sInBox        := 'InBox';
      sMarkRead     := 'Mark as Read';
      sMarkUnRead   := 'Mark as Unread';
      sRead         := 'Read';
      sSendItem     := 'Sent Items';
      sDeletedItems := 'Deleted items';
      sSystem       := 'Main Retail System';
      sMsg          := 'Message'
    end;

    LANG_PORTUGUESE:
    begin
      sInBox        := 'Novas';
      sMarkRead     := 'Marcar como lidas';
      sMarkUnRead   := 'Marcar como não lidas';
      sRead         := 'Lidas';
      sSendItem     := 'Enviadas';
      sDeletedItems := 'Itens excluídos';
      sSystem       := 'Sistema';
      sMsg          := 'Mensagem'
    end;

    LANG_SPANISH:
    begin
      sInBox        := 'en Caja';
      sMarkRead     := 'Marque lea como';
      sMarkUnRead   := 'Desmarque lea como';
      sRead         := 'Lea';
      sSendItem     := 'Mandados';
      sDeletedItems := 'Itens excluídos';
      sSystem       := 'Sistema';
      sMsg          := 'Mensaje'
    end;
  end;
end;

procedure TFrmUserMessager.btnRemoveClick(Sender: TObject);
begin
  inherited;
  case treMessage.Selected.Index of
    MSG_INBOX, MSG_READ:
      DM.RunSQL('UPDATE Sis_MessageUser SET Desativado = 1 WHERE IDMessage = ' + quMessageIDMessage.AsString +
                ' AND IDUserReceiver = ' + IntToStr(DM.fUser.ID));

    MSG_SENT:
      DM.RunSQL('UPDATE Sis_Message SET Desativado = 1 WHERE IDMessage = ' + quMessageIDMessage.AsString);
  end;

  RefreshMessage;
end;

function TFrmUserMessager.GetSQLDeleted: String;
begin
  Result := 'SELECT ' +
            '  M.IDMessage, ' +
            '  M.CreationDate, ' +
            '  M.Subject, ' +
            '  M.Body, ' +
            '  M.IDUserSender, ' +
            '  SU.SystemUser ' +
            'FROM  ' +
            '  Sis_Message M (NOLOCK) ' +
            '  JOIN Sis_MessageUser MU (NOLOCK) ON (M.IDMessage = MU.IDMessage) ' +
            '  JOIN SystemUser SU (NOLOCK) ON (M.IDUserSender = SU.IDUser) ' +
            'WHERE ' +
            '  MU.IDUserReceiver = ' + IntToStr(DM.fUser.ID) +
            '  AND MU.Desativado = 1 ' +
            'UNION ' +
            'SELECT ' +
            '  M.IDMessage, ' +
            '  M.CreationDate, ' +
            '  M.Subject, ' +
            '  M.Body, ' +
            '  M.IDUserSender, ' +
            '  SU.SystemUser ' +
            'FROM  ' +
            '  Sis_Message M (NOLOCK) ' +
            '  JOIN SystemUser SU (NOLOCK) ON (M.IDUserSender = SU.IDUser) ' +
            'WHERE ' +
            '  M.IDUserSender = ' + IntToStr(DM.fUser.ID) +
            '  AND M.Desativado = 1';
end;

procedure TFrmUserMessager.btnRestoreClick(Sender: TObject);
begin
  inherited;
  if quMessageIDUserSender.AsInteger = DM.fUser.ID then
    DM.RunSQL('UPDATE Sis_Message SET Desativado = 0 WHERE IDMessage = ' + quMessageIDMessage.AsString)
  else
    DM.RunSQL('UPDATE Sis_MessageUser SET Desativado = 0 WHERE IDMessage = ' + quMessageIDMessage.AsString +
              ' AND IDUserReceiver = ' + IntToStr(DM.fUser.ID));

  RefreshMessage;
end;

procedure TFrmUserMessager.btnEmptyBinClick(Sender: TObject);
begin
  inherited;
  
  DM.RunSQL('DELETE Sis_MessageUser WHERE Desativado = 1 ' +
            ' AND IDUserReceiver = ' + IntToStr(DM.fUser.ID));

  DM.RunSQL('DELETE Sis_Message WHERE IDMessage NOT IN (SELECT IDMessage FROM Sis_MessageUser)');

  RefreshMessage;
end;

end.
