(*
-----------------------------------------------------------------------------------------------------
Version    : (288 - 279)
Date       : 01.28.2011
Author     : Antonio Marcos Fernandes de Souza (amfsouza)
Issue      : Acces violation message when user get out ( close ) client form (Customer Files, for instance )
Solution   : I did a hook to treat this bug. I got it  like code to be reimplemented because
             I disliked that I saw. But, at this moment we have many other bugs to solve.
             On the local point in source code I did other comment about the reasons. 
To Version : (288 - 280)
-----------------------------------------------------------------------------------------------------
*)


unit DBTreeView;

// Novo DBTreeView, agora ele funciona com um DBGrid, ou seja anda com o controle
// anda com o DataSet

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Db, DBTables, DbCtrls, ADODb, uSystemTypes, uSqlFunctions,
  uDataBaseFunctions;

type
  TTreeItem = record
    IDItem  : Integer;
    Path    : string;
  end;

type
  PTreeItem = ^TTreeItem;

  TDBTreeView = class(TTreeView)
  private
    { Private declarations }
    FMostraDesativado : TDesativadoState;
    FMostraHidden     : THiddenState;
    PathList      : TStringList;
    FFieldName, FFieldPath, FFieldIDItem : String;
    FSystemReadOnly : Boolean;
    FquTreeView   : TADOQuery;
    quFreeSQL     : TADOQuery;
    FVirtualRoot  : String;
    FCanDelete    : Boolean;
    FPathLength   : integer;
    aItemData     : array[0..1000] of PTreeItem;
    FDataBase     : TADOConnection;
    fAutoIncField : String;
    function GetPathName(IDItem : integer) : String;
    function GetActualIDItem : integer;
    function GetActualName   : String;
    function GetActualPath   : String;
    function GetActualPathName : String;
    procedure SetActualName(Value : String);
  protected
    { Protected declarations }
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function  CanEdit(Node: TTreeNode): Boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  public
    { Public declarations }
    function  DeleteActualItem : integer;
    function  AddSubItem(Node: TTreeNode) : TTreeNode;
    procedure LoadTreeView;
    property  ActualIDItem : integer read GetActualIDItem;
    property  ActualName   : string  read GetActualName write SetActualName;
    property  ActualPath   : string  read GetActualPath;
    property  ActualPathName : string  read GetActualPathName;
  published
    { Published declarations }
    property MostraDesativado : TDesativadoState read FMostraDesativado write FMostraDesativado default STD_NAODESATIVADO;
    property MostraHidden     : THiddenState read FMostraHidden write FMostraHidden default STD_NAOHIDDEN;
    property SystemReadOnly   : Boolean read FSystemReadOnly write FSystemReadOnly default True;
    property ADOConnection    : TADOConnection read FDataBase  write FDataBase;
    property FieldIDItem  : string  read FFieldIDItem write FFieldIDItem;
    property FieldName    : string  read FFieldName   write FFieldName;
    property FieldPath    : string  read FFieldPath   write FFieldPath;
    property quTreeView   : TADOQuery  read FquTreeView  write FquTreeView;
    property VirtualRoot  : String  read FVirtualRoot write FVirtualRoot;
    property CanDelete    : Boolean read FCanDelete   write FCanDelete   default True;
    property PathLength   : Integer read FPathLength  write FPathLength  default 3;
    property AutoIncField : String read fAutoIncField write fAutoIncField;
  end;

procedure Register;

implementation

uses xBase;

procedure Register;
begin
  RegisterComponents('NewPower', [TDBTreeView]);
end;

constructor TDBTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PathList   := TStringList.Create;
  quFreeSQL  := TADOQuery.Create(Self);
  FPathLength := 3;
  FCanDelete  := True;
  HideSelection := False;
  FMostraDesativado := STD_NAODESATIVADO;
  FMostraHidden     := STD_NAOHIDDEN;
  FSystemReadOnly   := True;
end;

destructor TDBTreeView.Destroy;
var
 i : integer;
begin
  PathList.Free;
  quFreeSQL.Free;

  // Tira da memoria os Pointers
  for i := 0 to Items.Count -1 do
     Dispose(Items[i].Data);

  (*amfsouza 01.28.2011 - to be reimplemented on future.
    Exceptions is related to wrong IdItem and for that reason,
    undefined path too.
  *)

  for i := 0 to 1000 do begin
    try
      if ( aItemData[i] <> nil ) then begin
        if ( trim(aItemData[i].Path) = '' ) then
           break
        else
           Dispose(aItemData[i]);
      end;
    except
      on e: Exception do begin
        aItemData[i] := nil;
        break;
      end;
    end;
  end;

  inherited Destroy;
end;

procedure TDBTreeView.LoadTreeView;
var
  Index, i  : Integer;
  MyNode    : TTreeNode;
  MySQlStatement : TSQLStatement;
begin
  if not Assigned(quTreeView) then
     raise exception.create('quTreeView nao foi definido');

  if (FFieldIDItem = '') then
     raise exception.create('Nome do campo IDItem nao foi definido');

  if (FFieldPath = '') then
     raise exception.create('Nome do campo Path nao foi definido');

  if (FFieldName = '') then
     raise exception.create('Nome do campo Name nao foi definido');

  // Seta o dataBase do freeSQL
  quFreeSQL.Connection := FquTreeView.Connection;

  PathList.Clear;

  // Tira da memoria os Pointers
  for i := 0 to Items.Count -1 do
     Dispose(Items[i].Data);

  Items.Clear;

  // Carrega o Tree View com os dados do Query
  Screen.Cursor := crHourGlass;

  // Teste de Raiz Virtual
  if VirtualRoot <> '' then
    begin
      MyNode := Items.Add(Items.GetFirstNode, VirtualRoot);
      MyNode.ImageIndex    := 2;
      MyNode.SelectedIndex := 2;

      // Inclue na lista de Nós
      PathList.Add('');

      New(aItemData[0]);
      aItemData[0].IDItem := -1;
      aItemData[0].Path   := '';
      MyNode.Data := aItemData[0];
    end;

  FquTreeView.Close;

  // Troca a sentenca SQL do TreeView encima do estado do desativado
  FquTreeView.SQL.Text := ChangeSQLState(FquTreeView.SQL.Text, FMostraDesativado,
                                         FMostraHidden);

  FquTreeView.Open;
  FquTreeView.First;

  while not FquTreeView.Eof do
    begin
      // descobre o no pai
      if not PathList.Find(LeftStr(FquTreeView.FieldByName(FFieldPath).AsString,
                           Length(FquTreeView.FieldByName(FFieldPath).AsString)-(FPathLength+1)), Index) then
         // e o primeiro
          MyNode := Items.Add(Items.GetFirstNode, FquTreeView.FieldByName(FFieldName).AsString)
      else
          MyNode := Items.AddChild(Items.Item[Index], FquTreeView.FieldByName(FFieldName).AsString);

      if MyNode.Level = 0 then
        begin
         MyNode.ImageIndex    := 2;
         MyNode.SelectedIndex := 2;
        end
      else
        begin
         MyNode.ImageIndex    := 0;
         MyNode.SelectedIndex := 1;
        end;

      // Inclue na lista de Nós
      PathList.Add(FquTreeView.FieldByName(FFieldPath).AsString);

      New(aItemData[Items.Count-1]);

      aItemData[Items.Count-1].IDItem := FquTreeView.FieldByName(FFieldIDItem).AsInteger;
      aItemData[Items.Count-1].Path   := FquTreeView.FieldByName(FFieldPath).AsString;
      MyNode.Data := aItemData[Items.Count-1];

      FquTreeView.Next;
    end;

  FquTreeView.Close;
  AlphaSort;
  Items.GetFirstNode.Expand(False);

  Screen.Cursor := crDefault;
end;

function TDBTreeView.GetActualIDItem : integer;
begin
  Result := PTreeItem(Selected.Data)^.IDItem;
end;

function TDBTreeView.GetActualName : String;
begin
  Result := Selected.Text;
end;

procedure TDBTreeView.SetActualName(Value : String);
var
  PathName, NewPath : String;
  LenPath  : integer;
begin
  // Troca o nome atual
  // Trata a alteracao do nome do no
  try

    FDataBase.BeginTrans; 
    Screen.Cursor := crHourGlass;
    quFreeSQL.Close;
    // Troca o nome
    quFreeSQL.SQL.Text := 'UPDATE ' + GetSQLFirstTableName(FquTreeView.SQL.Text) +
                          ' SET '   + FFieldName + ' = ' +
                          Chr(39) + Value + Chr(39) + ' WHERE ' + FFieldIDItem +
                          ' = ' + IntToStr(ActualIDItem);
    quFreeSQL.ExecSQL;

    PathName   := ActualPathName;

    LenPath      := Length(PathName);
    NewPath      := LeftStr(PathName, LenPath-Length(Selected.Text)) + Value;

    // Troca o Path Anterior das descendentes
    quFreeSQL.SQL.Text := 'UPDATE ' + GetSQLFirstTableName(FquTreeView.SQL.Text) +
                          ' SET PathName = ' + Chr(39) + NewPath  + Chr(39) +
                          ' + RIGHT(PathName, DATALENGTH(PathName) - ' +
                          IntToStr(LenPath) + ') WHERE ' +
                          FFieldPath + ' LIKE ' +
                          Chr(39) + ActualPath + '%' + Chr(39);

    quFreeSQL.ExecSQL;
    FDataBase.CommitTrans; 
    Selected.Text := Value;
    Screen.Cursor := crDefault;
  except
    on E : EDataBaseError do
      begin
        FDataBase.RollbackTrans; 
        // Deve retornar o nome que esta no banco de dados
        MessageDlg('Names at the same level can not be duplicated',
                   mtInformation, [mbOK], 0);
        Screen.Cursor := crDefault;
        Abort;
      end;
  end;
end;

function TDBTreeView.GetActualPath : String;
begin
  Result := PTreeItem(Selected.Data)^.Path;
end;

function TDBTreeView.GetActualPathName : String;
begin
  // Descobre o Path Name do no selecionado
  Result := GetPathName(ActualIDItem);
end;

function TDBTreeView.GetPathName(IDItem : integer) : String;
begin
  // Descobre o Path Name do no selecionado
  with quFreeSQL do
    begin
      try
        SQL.Text := 'SELECT PathName FROM ' +
                    GetSQLFirstTableName(FquTreeView.SQL.Text) +
                    ' WHERE ' + FFieldIDItem + ' = ' + IntToStr(IDItem);
        Open;
        Result := Trim(Fields[0].AsString);
        Close;
      except
        on exception do
           raise exception.create('Can not return the path name form an invalid IDItem');
      end;
    end;
end;

function TDBTreeView.CanEdit(Node: TTreeNode): Boolean;
begin
  inherited CanEdit(Node);
  Result := not ( (VirtualRoot <> '') and (Node.Level = 0) );

  // teste se o dbtreeview e system
  if Result and FSystemReadOnly then
    with quFreeSQL do
     begin
       SQL.Text := 'SELECT SYSTEM FROM ' + GetSQLFirstTableName(FquTreeView.SQL.Text) + ' ' +
                   'WHERE ' + FFieldIDItem + ' = ' + IntToStr(ActualIDItem);
       Open;
       Result := not Fields[0].AsBoolean;
       Close;
     end;
end;

procedure TDBTreeView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (not IsEditing) then
   begin
     case Key of

          VK_DELETE : if FCanDelete and (MessageDlg('Are you sure you want to delete this branch.', mtConfirmation,
                                         [mbYes, mbNo], 0) = mrYes) then
                         DeleteActualItem;

          VK_F2     : Selected.EditText;
     end;
   end;
end;

function TDBTreeView.AddSubItem(Node: TTreeNode) : TTreeNode;
var
  MyNode       : TTreeNode;
  Level, NewID : integer;
  NewItem, Path, PathName, NewPath, sTableName : String;
begin
  SetFocus;
  Level  := Selected.Level + 1;

  Path   := ActualPath;

  // Inclue na base de dados o novo nó
  quFreeSQL.Close;
  quFreeSQL.SQL.Text := ChangeWhereClause(BuildMaxSQL('Path', FquTreeView.SQL.Text),
                                          ' Path like ' + Chr(39) + Trim(Path) + '.' +
                                          ReplicateStr('_', FPathLength) + Chr(39), False);
  if FquTreeView.Parameters.Count > 0 then
     quFreeSQL.Parameters.Assign(FquTreeView.Parameters);

  try
    FDataBase.BeginTrans; 
    quFreeSQL.Open;
    if quFreeSQL.Fields[0].AsString <> '' then
       NewPath := StrZero(StrToInt(RightStr(quFreeSQL.Fields[0].AsString, PathLength))+1, PathLength)
    else
       NewPath := StrZero(1, PathLength);
    quFreeSQL.Close;

    NewPath    := Path + '.' + NewPath;

    PathName   := GetPathName(PTreeItem(Selected.Data)^.IDItem);

    // Descobre o Proximo nome para NewItem ex : NewItem(2)
    quFreeSQL.SQL.Text := ChangeWhereClause(BuildMaxSQL(FFieldName, FquTreeView.SQL.Text),
                                            FFieldName + ' like ' + Chr(39) + 'NewItem%' + Chr(39) + ' and ' +
                                            ' Path like ' + Chr(39) + Trim(Path) + '.' +
                                            ReplicateStr('_', FPathLength) + Chr(39), False);
    if FquTreeView.Parameters.Count > 0 then
       quFreeSQL.Parameters.Assign(FquTreeView.Parameters);

    quFreeSQL.Open;
    if quFreeSQL.Fields[0].AsString <> '' then
       NewItem := quFreeSQL.Fields[0].AsString + '-New'
    else
       //Error - Quando era criado um Item novo, no raiz e depois era criado
       //um outro item novo sentro de um Sub Dir, dava um error pois o campo
       //nome nao pode ser duplicado!!!
       NewItem := 'NewItem' + NewPath;
    quFreeSQL.Close;

    MyNode := Items.AddChild(Selected, NewItem);

    MyNode.MakeVisible;

    // Monta a query de insercao
    sTableName := GetSQLFirstTableName(FquTreeView.SQL.Text);

    // Pega o novo ID
    quFreeSQL.SQL.Text := 'UPDATE	CI SET	UltimoCodigo = UltimoCodigo + 1 FROM Sis_CodigoIncremental CI WHERE Tabela = ' +QuotedStr(sTableName+'.'+fAutoIncField);
    quFreeSQL.ExecSQL;
    quFreeSQL.Close;
    quFreeSQL.SQL.Text := 'SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = ' +QuotedStr(sTableName+'.'+fAutoIncField);
    quFreeSQL.Open;
    NewID := (quFreeSQL.Fields[0].AsInteger);
    quFreeSQL.Close;

    // Insere no banco de dados o novo item
    quFreeSQL.SQL.Text := 'INSERT ' + sTableName +
                          ' (' + fAutoIncField + ', ' +
                          FFieldPath + ' , ' + FFieldName + ' , ' +
                          'PathName' + ' ) VALUES ( ' +  IntToStr(NewID) + ', ' +
                          Chr(39) + NewPath + Chr(39)   + ' , ' +
                          Chr(39) + MyNode.Text + Chr(39) + ' , ' +
                          Chr(39) + PathName + '\ ' + MyNode.Text + Chr(39) + ' )';

    quFreeSQL.ExecSQL;

    // Associa o Path ao Node
    New(aItemData[Items.Count-1]);
    aItemData[Items.Count-1].IDItem := NewID;
    aItemData[Items.Count-1].Path   := NewPath;
    MyNode.Data := aItemData[Items.Count-1];

    FDataBase.CommitTrans; 
    Selected := MyNode;

    Result := MyNode;
  except
    on exception do
      begin
        FDataBase.RollbackTrans;
        MyNode.Delete;
        Result := nil;
        raise exception.create('Error trying to create new item');
      end;
  end;
end;

function TDBTreeView.DeleteActualItem : integer;
var
  TableName : String;
  i : integer;
begin
  if (Selected.Level = 0) then
    begin
     Result := 2;
     Exit;
    end;

  TableName := GetSQLFirstTableName(FquTreeView.SQL.Text);

  if SystemDeleteBranch(quFreeSQL, TableName, FFieldPath, ActualPath, True, False) then
    begin
      for i := Selected.AbsoluteIndex to (Selected.AbsoluteIndex + Selected.Count) do
          Dispose(Items[i].Data);
      Items.Delete(Selected);
    end;
end;

end.
