unit uFrmUserMessageUserList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  DBClient, ADODB, ImgList, Mask, SuperComboADO;

type
  TFrmUserMessageUserList = class(TFrmParentAll)
    imgList: TImageList;
    dsUsers: TDataSource;
    quUsers: TADODataSet;
    quUsersIDUser: TIntegerField;
    quUsersSystemUser: TStringField;
    quUsersUserType: TStringField;
    quUsersImage: TIntegerField;
    dsReceivers: TDataSource;
    cdsReceivers: TClientDataSet;
    cdsReceiversIDUser: TIntegerField;
    cdsReceiversSystemUser: TStringField;
    pnlUserList: TPanel;
    gridUsers: TcxGrid;
    gridUsersDBTableView1: TcxGridDBTableView;
    gridUsersDBTableView1Image: TcxGridDBColumn;
    gridUsersDBTableView1SystemUser: TcxGridDBColumn;
    gridUsersDBTableView1UserType: TcxGridDBColumn;
    gridUsersLevel1: TcxGridLevel;
    Panel2: TPanel;
    btnAdd: TSpeedButton;
    btnRemove: TSpeedButton;
    btnRemoveAll: TSpeedButton;
    btnAddAll: TSpeedButton;
    Panel4: TPanel;
    gridReceivers: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1User: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    btnSave: TButton;
    lbStore: TLabel;
    cmbStore: TSuperComboADO;
    btAreaTodas: TButton;
    lbUserType: TLabel;
    scUserType: TSuperComboADO;
    btnUserType: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnAddAllClick(Sender: TObject);
    procedure btnRemoveAllClick(Sender: TObject);
    procedure btAreaTodasClick(Sender: TObject);
    procedure cmbStoreSelectItem(Sender: TObject);
    procedure quUsersAfterOpen(DataSet: TDataSet);
    procedure btnUserTypeClick(Sender: TObject);
  private
    fIDs, fUsers : String;
    procedure OpenUsers;
    procedure CloseUsers;
    procedure RefreshUsers;

    procedure BuildUserList;
  public
    function Start(var sIDs, sUsers : String):Boolean;
  end;

implementation

uses uDM, uSqlFunctions;

{$R *.dfm}

{ TFrmUserMessageUserList }

procedure TFrmUserMessageUserList.BuildUserList;
begin

   with cdsReceivers do
     begin
     First;
     Try
       DisableControls;
       fIDs   := '';
       fUsers := '';
       while not EOF do
         begin
         fIDs   := fIDs   + cdsReceiversIDUser.AsString;
         fUsers := fUsers + cdsReceiversSystemUser.AsString +'; ';
         Next;
         if not EOF then
            fIDs   := fIDs   + ',';
         end;
     finally
      EnableControls;
      end;
     end;

end;

procedure TFrmUserMessageUserList.CloseUsers;
begin
  with quUsers do
    if Active then
       Close;
end;

procedure TFrmUserMessageUserList.OpenUsers;
var
  sWhere : String;
begin
  with quUsers do
    if not Active then
       begin
       sWhere := ' SU.Desativado = 0 AND	SU.Hidden = 0	AND	SU.System = 0 ';
       if cmbStore.LookUpValue <> '' then
          sWhere := sWhere + ' AND (SU.StoresAccess like '+QuotedStr('%'+cmbStore.LookUpValue+',%')+' OR SU.StoresAccess like ' + QuotedStr('%'+cmbStore.LookUpValue+'%') + ') ';
       if scUserType.LookUpValue <> '' then
          sWhere := sWhere + ' AND UT.IDUserType = ' + scUserType.LookUpValue;
       CommandText := ChangeWhereClause(CommandText, sWhere, True);
       Open;
       end;
end;

function TFrmUserMessageUserList.Start(var sIDs, sUsers: String): Boolean;
begin

  OpenUsers;

  ShowModal;

  Result := (ModalResult = mrOK);

  if Result then
     begin
     sIDs   := fIDs;
     sUsers := fUsers;
     end;

  CloseUsers;

end;

procedure TFrmUserMessageUserList.btnAddClick(Sender: TObject);
begin
  inherited;

   with cdsReceivers do
      begin
      if not Active then
         Open;
      if not Locate('IDUser', quUsersIDUser.AsInteger, []) then
         begin
         Append;
         cdsReceiversIDUser.AsInteger    := quUsersIDUser.AsInteger;
         cdsReceiversSystemUser.AsString := quUsersSystemUser.AsString;
         Post;
         BuildUserList;
         end;
      end;

end;

procedure TFrmUserMessageUserList.FormDestroy(Sender: TObject);
begin
  inherited;
  cdsReceivers.Close;
end;

procedure TFrmUserMessageUserList.btnRemoveClick(Sender: TObject);
begin
  inherited;

   with cdsReceivers do
      begin
      if not Active then
         Exit;
         
      if IsEmpty then
         Exit;

      Edit;
      Delete;
      BuildUserList;
      end;
  
end;

procedure TFrmUserMessageUserList.btnAddAllClick(Sender: TObject);
begin
  inherited;

   with cdsReceivers do
      begin
      if not Active then
         Open;

      quUsers.First;    
      while not quUsers.EOF do
         begin
         if not Locate('IDUser', quUsersIDUser.AsInteger, []) then
            begin
            Append;
            cdsReceiversIDUser.AsInteger    := quUsersIDUser.AsInteger;
            cdsReceiversSystemUser.AsString := quUsersSystemUser.AsString;
            Post;
            end;
         quUsers.Next;
         end;
      BuildUserList;   
      end;
  
end;

procedure TFrmUserMessageUserList.btnRemoveAllClick(Sender: TObject);
begin
  inherited;

   with cdsReceivers do
      begin
      if not Active then
         Exit;
      if IsEmpty then
         Exit;

      First;   
      while not EOF do
         begin
         Edit;
         Delete;
         end;

      BuildUserList;
      end;
  
end;

procedure TFrmUserMessageUserList.btAreaTodasClick(Sender: TObject);
begin
  inherited;
  cmbStore.LookUpValue := '';
  cmbStore.Text        := '<'+btAreaTodas.Caption+'>';
  RefreshUsers;
end;

procedure TFrmUserMessageUserList.RefreshUsers;
begin
  CloseUsers;
  OpenUsers;
end;

procedure TFrmUserMessageUserList.cmbStoreSelectItem(Sender: TObject);
begin
  inherited;
  RefreshUsers;
end;

procedure TFrmUserMessageUserList.quUsersAfterOpen(DataSet: TDataSet);
begin
  inherited;
  gridUsersDBTableView1.ViewData.Expand(True);
end;

procedure TFrmUserMessageUserList.btnUserTypeClick(Sender: TObject);
begin
  inherited;
  scUserType.LookUpValue := '';
  scUserType.Text        := '<'+btnUserType.Caption+'>';
  RefreshUsers;
end;

end.
