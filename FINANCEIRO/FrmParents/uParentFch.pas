unit uParentFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentModal, StdCtrls, ExtCtrls, Buttons,  Db, Dbctrls, DBTables,
  FormConfig, ComCtrls, dxBar, dxDBGrid, dbGrids, dxDBDateEdit,
  ImgList, ADODB, PowerADOQuery, RCADOQuery, uDataBaseFunctions, 
  uSystemTypes, uHandleError, siComp, siLangRT;

type
  TParentFch = class(TParentModalFrm)
    pnlPBarra: TPanel;
    pnlPBarraRightAlign: TPanel;
    btCancel: TBitBtn;
    pnlPLinha: TPanel;
    btOK: TBitBtn;
    pnlPTitulo: TPanel;
    lblPTitulo: TLabel;
    pnlAutoInc: TPanel;
    btLoopInc: TSpeedButton;
    lblModified: TLabel;
    dsForm: TDataSource;
    quForm: TPowerADOQuery;
    FormConfig: TFormConfig;
    pnlNavigation: TPanel;
    btPriorRec: TSpeedButton;
    btNextRec: TSpeedButton;
    btLastRec: TSpeedButton;
    btFirstRec: TSpeedButton;
    lblNavegacao: TLabel;
    imgOn: TImage;
    imgOff: TImage;
    lblPTituloShadow: TLabel;
    bmMDI: TdxBarManager;
    ilSmallButtons: TImageList;
    PrintFch: TPrintDialog;
    btPrintFch: TSpeedButton;
    btHelp: TBitBtn;
    procedure dsFormStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure quFormPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure btOKClick(Sender: TObject);
    procedure btLastRecClick(Sender: TObject);
    procedure btNextRecClick(Sender: TObject);
    procedure btPriorRecClick(Sender: TObject);
    procedure btFirstRecClick(Sender: TObject);
    procedure btPrintFchClick(Sender: TObject);
    procedure btHelpClick(Sender: TObject);
  private
    { Private declarations }

    MyquFormParams : TParams;
    fldSystem : TBooleanField;
    MaxLastKey : integer;

    FOperacaoNome        : String;
    FOperacaoBotao       : String;
    FOperacaoConfirmacao : String;
    FEntidadeNome        : String;
    FEntidadeModo        : String;
    FEntidadeMasculina   : Boolean;

    function  TestBeforeNavigate: integer;
    procedure SyncFichaToBrowse(Full: Boolean);
    procedure UpdateNavigation;
    procedure SetaFocoInicial;
  protected
    { protected }
    //Translation
    sAdding,
    sAdd,
    sUpdating,
    sUpdate,
    sField,
    sNoEmpty : String;

    IsPost : Boolean;
    MyPosID1, MyPosID2   : String;
    FieldKey1, FieldKey2 : String;
    frmCommand : TBtnCommandType;
    MybrwQuery : TPowerADOQuery;
    MyGrid: TdxDBGrid;

    MyUserRightsList: TStringList;
    MyUserRights: String;

    strLastKey : String;
    NotNullFields : TStringList;
    MyParametro: String;

    procedure PushError(ErrorType: Integer; sError: String);

    function HasRight(IDOperacao: Integer): Boolean;

    procedure CreateParams(var Params: TCreateParams); override;

    function OnBeforeTransaction: boolean; virtual; // fora transação de save


    procedure OnAfterNewRecord; Virtual;
    procedure OnBeforeStart; Virtual;
    procedure OnAfterStart; Virtual;
    function OnBeforeDoCancel:boolean; Virtual;
    function OnAfterDoCancel:Boolean; Virtual;

    procedure SaveData; Virtual;
    procedure OnAfterSaveData; virtual;  // fora da transação de save
    procedure OnSetDefaultFields; Virtual;
    function OnBeforeSaveChange:Boolean; virtual;
    function OnAfterSaveChange:Boolean; virtual;

    procedure SetOperacaoNome(Value: String);
    procedure SetOperacaoBotao(Value: String);

    procedure SetEntidadeNome(Value: String);
    procedure SetEntidadeModo(Value: String);
    procedure SetEntidadeMasculina(Value: Boolean);

    procedure ControlaEdits(ChangeColor, MyReadOnly : Boolean);

    function SetaCodigoAutoNumSub(TableName, TabelaParticao, PrefixoCodigo: String):Boolean;
    procedure SetFilterFields(MyQuery : TPowerADOQuery);
    function SetaCodigoAutoNum:Boolean; virtual;
    function NextAppend:Boolean; virtual;
    procedure CancelUpdates; virtual;
    function  SaveChange : boolean; virtual;
    function  OnSaveData : boolean; virtual;
    function  TestOnEditModes  : boolean; virtual;
    function  TestOnBeforeSave : boolean; virtual;
    function  TestFieldFill: boolean; virtual;
    function  TestFieldUnique: boolean;
    procedure RefreshBrowse(Full: Boolean); virtual;
    procedure SetDefaultFields; virtual;
    procedure FchUpdateRecord; virtual;
    procedure DoCancel(DeleteOnInc : Boolean); virtual;
    procedure CloseDataSets; virtual;
    procedure OpenDataSets; virtual;
    procedure SetParamBrowse; virtual;
    procedure SetParamSpecial; virtual;
    procedure SetPageControl(Pageindex: integer); virtual;
  published
    property EntidadeNome        : String   read FEntidadeNome write SetEntidadeNome;
    property EntidadeModo        : String   read FEntidadeModo write SetEntidadeModo;
    property EntidadeMasculina   : Boolean  read FEntidadeMasculina write SetEntidadeMasculina default True;

    property OperacaoNome        : String   read FOperacaoNome write SetOperacaoNome;
    property OperacaoBotao       : String   read FOperacaoBotao write SetOperacaoBotao;
    property OperacaoConfirmacao : String   read FOperacaoConfirmacao write FOperacaoConfirmacao;

  public
    { Public declarations }
    OpenModal: Boolean;
    FchBrowse : TObject;  // Aponta para o browse da ficha
    Param: String;
    procedure TocaFicha;
    function  Start(pCommand  : TBtnCommandType;
                    brwQuery  : TPowerADOQuery;
                    IsLoopInc : Boolean;
                    var PosID1, PosID2 : String;
                    Parametro: String;
                    UserRights: String;
                    Grid: TdxDBGrid) : Boolean;
  end;

implementation

uses xBase, uDM, SuperComboADO, uMsgBox, uSisSenha, uSQLFunctions,
     uVarianteFunctions, uParamFunctions, uMsgConstant, uDMGlobal;

{$R *.DFM}


function TParentFch.OnBeforeTransaction: boolean;
begin
  // Para ser herdado
  Result := True;
end;


procedure TParentFch.PushError(ErrorType: Integer; sError: String);
begin

   DM.SetError(ErrorType, Self.Name, sError);

end;

procedure TParentFch.OnAfterNewRecord;
begin
  // Para ser herdado
end;

function TParentFch.HasRight(IDOperacao: Integer): Boolean;
begin

  if Trim(MyUserRights) = '' then
    Result := True
  else
    Result := (MyUserRightsList.IndexOf(IntToStr(IDOperacao)) <> -1);

end;

procedure TParentFch.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  {Parent := nil;}
  {with Params do
  begin
    Style := Style or WS_EX_APPWINDOW;
    ExStyle := ExStyle or WS_EX_APPWINDOW;
  end;}

end;

function  TParentFch.Start(pCommand  : TBtnCommandType;
                           brwQuery  : TPowerADOQuery;
                           IsLoopInc : Boolean;
                           var PosID1, PosID2 : String;
                           Parametro: String;
                           UserRights: String;
                           Grid: TdxDBGrid) : Boolean;
var
  i     : integer;
begin

  // Seta variaveis globais
  if Self.Param <> '' then
     MyParametro := Param
  else
     MyParametro := Parametro;

  frmCommand  := pCommand;
  IsPost      := False;
  MyPosID1    := PosID1;
  MyPosID2    := PosID2;
  MybrwQuery  := brwQuery;
  myGrid      := Grid;

  MyUserRights := UserRights;
  // Le os direitos do usuario os carrega em um string list
  ParseUserRights(UserRights, MyUserRightsList);

  OnBeforeStart;

  inherited;

  if Visible AND (TestBeforeNavigate = 0) then
      Exit;

  CloseDataSets;

  // Seta os campos que foram setados no browse como default para ficha
  if ( MybrwQuery <> nil  ) and
     ( frmCommand = btInc )  and ( MybrwQuery is TPowerADOQuery ) then
     SetDefaultFields;

  // Seta o filtro do registro a ser mostrado
  if MybrwQuery <> nil then
    SetParamBrowse
  else
    SetParamSpecial;

  OpenDataSets;

  btLoopInc.Down := IsLoopInc;

  OnAfterStart;

  if OpenModal then
    begin
      FormStyle := fsNormal;

      ShowModal;
      CloseDataSets;

      if IsPost then
        begin
          PosID1 := FieldKey1;
          PosID2 := FieldKey2;
        end;

      Result := IsPost;
    end
  else
    begin
      FormStyle := fsNormal;
      WindowState := wsNormal;
      Show;
      Result := False;
    end;

end;

procedure TParentFch.OnBeforeStart;
begin
  // Para ser herdado
end;

procedure TParentFch.OnAfterStart;
begin
  // Para ser Herdado
end;

procedure TParentFch.SetEntidadeNome(Value: String);
begin
  FEntidadeNome := Value;
  lblPTitulo.Caption := FOperacaoNome + ' ' + FEntidadeNome + ' ' + FEntidadeModo;
  lblPTituloShadow.Caption := FOperacaoNome + ' ' + FEntidadeNome + ' ' + FEntidadeModo;
end;

procedure TParentFch.SetEntidadeModo(Value: String);
begin
  FEntidadeModo := Value;
  SetEntidadeNome(FEntidadeNome);
end;

procedure TParentFch.SetEntidadeMasculina(Value: Boolean);
begin
  FEntidadeMasculina := Value;
  SetEntidadeNome(FEntidadeNome);
end;

procedure TParentFch.SetOperacaoNome(Value: String);
begin
  FOperacaoNome := Value;
  SetEntidadeNome(FEntidadeNome);
end;

procedure TParentFch.SetOperacaoBotao(Value: String);
begin
  FOperacaoBotao := Value;
  btOk.Caption := Value;
end;


procedure TParentFch.SetParamSpecial;
begin
  with quForm do
   begin
     if MyPosID1 <> '' then
       begin
         Parameters[0].Value := ConvVariant(Parameters[0].DataType, MyPosID1);
         if MyPosID2 <> '' then
           Parameters[1].Value := ConvVariant(Parameters[1].DataType, MyPosID2);
       end;
   end;
end;

procedure TParentFch.SetParamBrowse;
var
  i : integer;
begin


  // Se foi passado o grid, navego pelo grid, senão pela query
  if Assigned(myGrid) AND
     (myGrid.Count>0) AND
     (quForm.Parameters.Count = 1) then
    with myGrid do
      begin
        //ShowMessage(TdxDBGridNode(FocusedNode).ID);
        quForm.Parameters.Items[0].Value := TdxDBGridNode(FocusedNode).ID;
      end
  else if not MybrwQuery.IsEmpty then
       with quForm do
            if not (MybrwQuery.Eof and MybrwQuery.Bof) then
               for i := 0 to Parameters.Count-1 do
                   begin
                   Parameters.Items[i].Value := Null;
                   if MybrwQuery.FindField(Parameters.Items[i].Name) <> nil then
                      Parameters.Items[i].Value := MybrwQuery.FieldByName(Parameters.Items[i].Name).Value;
                   end;
end;

procedure TParentFch.CloseDataSets;
var
  i: Integer;

begin
  with quForm do
    if Active then
      Close;

  // Percorro Todo o form, procurando por dataset, e os fechos
  for i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TQuery then
        TQuery(Components[i]).Close
      else if Components[i] is TRCADOQuery then
        TRCADOQuery(Components[i]).Close
      else if Components[i] is TPowerADOQuery then
        TPowerADOQuery(Components[i]).Close;
    end;



end;

procedure TParentFch.OpenDataSets;
begin
  quForm.Open;
end;

procedure TParentFch.SetDefaultFields;
begin
  SetFilterFields(quForm);

end;

procedure TParentFch.SetFilterFields(MyQuery : TPowerADOQuery);
var
  i : integer;
begin
  // Teste de matching de campos passados do browse com campos da ficha
  with MyQuery do
    begin
      quForm.ClearFilters;
      for i := 0 to TPowerADOQuery(MybrwQuery).FilterFields.Count - 1 do
        begin
          if MyQuery.FindField(TPowerADOQuery(MybrwQuery).FilterFields[i]) <> nil then
            begin
              MyQuery.FilterFields.Add(TPowerADOQuery(MybrwQuery).FilterFields[i]);
              MyQuery.FilterValues.Add(TPowerADOQuery(MybrwQuery).FilterValues[i]);
            end;
        end;
    end;
end;

procedure TParentFch.dsFormStateChange(Sender: TObject);
begin
  inherited;
  lblModified.Visible := TestOnEditModes;
  btOk.Enabled := TestOnEditModes;
end;

procedure TParentFch.FormShow(Sender: TObject);
begin
  inherited;
  ControlaEdits(True, (frmCommand <> btInc) and FormConfig.SystemReadOnly and
                      (quForm.FieldByName('System').AsBoolean));

  case frmCommand of
     btInc    : begin
                  if FormConfig.OperacaoDefault = True then
                    begin
                      OperacaoNome := sAdding;
                      OperacaoBotao := sAdd;
                      OperacaoConfirmacao := sAdding;
                    end;

                  if not NextAppend then
                     begin
                     PushError(CRITICAL_ERROR, 'ParentFch.Start.NextAppend' + #13#10 + 'Result false');
                     MsgBox(MSG_CRT_ERROR_ADDING, vbCritical + vbOkOnly);
                     end;
                end;
     btAlt    : begin
                  if FormConfig.OperacaoDefault = True then
                    begin
                      OperacaoNome := sUpdating;
                      OperacaoBotao := sUpdate;
                      OperacaoConfirmacao := sUpdating;
                    end;

                  SetaFocoInicial;
                end;
  end;

  // Teste de registro system e readonly
  if quForm.FindField('System') <> nil then
    if FormConfig.SystemReadOnly and quForm.FieldByName('System').AsBoolean then
      EntidadeModo := 'System';

  UpdateNavigation;
  Self.Caption := Application.title;
end;

function TParentFch.NextAppend:Boolean;
var
  ActualField, AutoNumberField : String;
  slRequired: TStringList;

  procedure FillRequiredFields;
  var
    i: integer;
  begin
     NotNullFields.Clear;

     with quForm do
      begin
        //strLastKey := IntToStr(DM.GetMaxKey(GetSQLFirstTableName(quForm.CommandText), Parameters.Items[0].Name)+1);
        strLastKey := IntToStr(DM.GetNextID(GetSQLFirstTableName(quForm.CommandText)+'.'+Parameters.Items[0].Name));
        quForm.FieldbyName(quForm.Parameters.Items[0].Name).AsInteger := StrToInt(strLastKey);

        AutoNumberField := '';

        for i := 0 to FormConfig.RequiredFields.Count - 1 do
          begin
            ActualField := FormConfig.RequiredFields.Strings[i];

            // Nunca deixo gravar o #Auto# no BD.
            if FieldByName(ActualField).AsString = '#Auto#' then
              begin
                // Gravo o valor da Chave depois do campo AutoNumber
                FieldByName(ActualField).AsString := '#Auto# ' + strLastKey;
                AutoNumberField := ActualField;
              end
            else
              begin
                if FieldByName(ActualField).IsNull then
                  case FieldByName(ActualField).DataType of

                    ftString,
                    ftMemo      : FieldByName(ActualField).AsString   := strLastKey;

                    ftDateTime,
                    ftDate      : FieldByName(ActualField).AsDateTime := Now;

                    ftInteger   : FieldByName(ActualField).AsInteger  := 0;

                    ftFloat     : FieldByName(ActualField).AsFloat    := 0;

                    ftBoolean   : FieldByName(ActualField).AsBoolean  := False;
                  end
                else
                  begin
                    NotNullFields.Add(ActualField);
                  end;
              end;
          end;
      end;
  end;

  procedure UnMarkRequiredFields;
  var
    i: integer;
  begin
  // Desmarco todos os fields que estao required, para marcar de novo,
  // depois do post
  slRequired := TStringList.Create;
  with quForm do
    for i := 0 to FieldCount-1 do
      begin
        if Fields[i].Required then
          begin
            slRequired.Add(Fields[i].FieldName);
            Fields[i].Required := False;
          end;
      end;
  end;

  procedure MarkRequiredFields;
  var
    i: integer;
  begin
        // Volto a marcar os campos como  required
        with slRequired do
          for i := 0 to Count-1 do
            quForm.FieldByName(slRequired[i]).Required := True;
        slRequired.Free;
  end;

  procedure ClearRequiredFields;
  var
    i: integer;
  begin
  // Reseta os campos que sao required
  if FormConfig.RequiredFields.Count > 0 then
    begin
     for i := 0 to FormConfig.RequiredFields.Count - 1 do
       begin
         if NotNullFields.IndexOf(FormConfig.RequiredFields.Strings[i]) = -1 then
           quForm.FieldByName(FormConfig.RequiredFields.Strings[i]).Clear;
       end;
    end;
  end;


begin

  // Faz o post automatico
  Result := False;
  try
    quForm.Append;
  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.NextAppend.quForm.Append.Exception' + #13#10 + E.Message);
        Exit;
      end;
  end;

  if FormConfig.IsAutoIncKey and FormConfig.PostOnInsert then
    begin

    FillRequiredFields;
    UnMarkRequiredFields;

      try
          DM.DBADOConnection.BeginTrans;

          quForm.Post;
          //MaxLastKey := DM.GetMaxKey(GetSQLFirstTableName(quForm.CommandText), quForm.Parameters.Items[0].Name);
          MaxLastKey := StrToInt(strLastKey);

          // Marca a gravacao
          FieldKey1  := IntToStr(MaxLastKey);
          IsPost     := True;
          DM.DBADOConnection.CommitTrans;
        except
          on E: Exception do
             begin
             DM.DBADOConnection.RollbackTrans;
             PushError(CRITICAL_ERROR, 'ParentFch.NextAppend.GetLastKey.Exception' + #13#10 + E.Message);
             Exit;
             end;
        end;

        quForm.Close;
        quForm.Parameters.Items[0].Value := MaxLastKey;

        try
          quForm.Open;
          quForm.Edit;
        except
          on E: Exception do
              begin
              PushError(CRITICAL_ERROR, 'ParentFch.NextAppend.quForm.Open.Exception' + #13#10 + E.Message);
              Exit;
              end;
        end;


        OnSetDefaultFields;

        MarkRequiredFields;
        ClearRequiredFields;


        // Reseta o campo AutoNumber
        if AutoNumberField <> '' then
           quForm.FieldByName(AutoNumberField).AsString := '#Auto#';

        try
           OnAfterNewRecord;
        except
            on E: Exception do
                begin
                DM.DBADOConnection.RollbackTrans;
                PushError(CRITICAL_ERROR, 'ParentFch.NextAppend.OnAfterNewRecord.Exception' + #13#10 + E.Message);
                Exit;
                end;
        end;
      IsPost     := False;
    end;
    
  Result := True;
  SetaFocoInicial;
end;

procedure TParentFch.ControlaEdits(ChangeColor, MyReadOnly : Boolean);
var
  i           : Integer;
  MyColor     : TColor;
begin
  if MyReadOnly then
     MyColor := clBtnFace
  else
     MyColor := clWindow;

   for i := 0 to (ComponentCount -1) do
     begin
      if Components[I].Tag = 0 then
        begin
          if (Components[I] is TControl) and
             (not TControl(Components[I]).Enabled) then
             Continue;

          if Components[I] is TdxDBDateEdit then
            begin
             if ChangeColor then
                TdxDBDateEdit(Components[I]).Color    := MyColor;
             TdxDBDateEdit(Components[I]).ReadOnly    := MyReadOnly;
            end
          else if Components[I] is TDbEdit then
            begin
             if ChangeColor then
                TDbEdit(Components[I]).Color     := MyColor;
             TDbEdit(Components[I]).ReadOnly  := MyReadOnly;
            end
{
          else if Components[I] is TDBSuperCombo then
            begin
             if ChangeColor then
                TDBSuperCombo(Components[I]).Color     := MyColor;
             TDBSuperCombo(Components[I]).ReadOnly  := MyReadOnly;
            end
}
          else if Components[I] is TDBGrid then
            begin
             TDBGrid(Components[I]).ReadOnly  := MyReadOnly;
            end
          else if Components[I] is TDBCheckBox then
            begin
             TDBCheckBox(Components[I]).ReadOnly  := MyReadOnly;
            end
          else if Components[I] is TDBRadioGroup then
            begin
             TDBRadioGroup(Components[I]).ReadOnly  := MyReadOnly;
            end
          else if Components[I] is TDBListBox then
            begin
             TDBListBox(Components[I]).ReadOnly  := MyReadOnly;
            end
          else if Components[I] is TDBRichEdit then
            begin
             if ChangeColor then
                TDBRichEdit(Components[I]).Color    := MyColor;
             TDBRichEdit(Components[I]).ReadOnly  := MyReadOnly;
            end
          else if Components[I] is TSuperComboADO then
            begin
             if ChangeColor then
                TSuperComboADO(Components[I]).Color     := MyColor;
             TSuperComboADO(Components[I]).ReadOnly  := MyReadOnly;
            end
        end;
     end;
end;



procedure TParentFch.SetaFocoInicial;
var
  i : Integer;
begin
  for i := 0 to (ControlCount - 1) do
    if (Controls[i] is TWinControl) and
       (TWinControl(Controls[i]).TabOrder = 0) and (TWinControl(Controls[i]).Enabled) then
      begin
        if TWinControl(Controls[i]).Visible then
           ActiveControl := TWinControl(Controls[i]);
        Break;
      end;
end;

function TParentFch.TestOnEditModes : boolean;
begin
  Result := quForm.State in dsEditModes;
end;

function TParentFch.SetaCodigoAutoNum:Boolean;
begin

  // Para ser Sobre escrito em descendentes
  Result := SetaCodigoAutoNumSub(GetSQLFirstTableName(quForm.CommandText), '', '');
  
end;

function TParentFch.SetaCodigoAutoNumSub(TableName, TabelaParticao, PrefixoCodigo: String):Boolean;
var
   i: integer;
   SQL: String;
begin

  Result := True;
  try
      // Procura por algum campo Auto Num e descobre o provavel codigo para ele
      for i := 0 to quForm.FieldCount - 1 do
        begin
          if quForm.Fields[i].AsString = '#Auto#' then
            begin
              // Monta o SQL que chamara o sp
              SQL := 'EXEC sp_Sis_IncCodigo @Tabela = ' + Chr(39) + TableName  + Chr(39) +
                     ', @Coluna = ' + Chr(39) + quForm.Fields[i].FieldName + Chr(39) +
                     ', @IDUsuario = '  + IntToStr(SisSenha.IDUsuario);

              // Parametros especiais de particao
              if TabelaParticao <> '' then
                begin
                  SQL := SQL + ', @TabelaParticao = ' + Chr(39) + TabelaParticao  + Chr(39) +
                               ', @PrefixoParticao = ' + Chr(39) + PrefixoCodigo + Chr(39);
                end;

              // Chama a store proc
              DM.RunSQL(SQL);

              // devido a um bug desconhecido do componente sp, recupero o valor gerado do BD
              with DM.quFreeSQL do
                begin
                  SQL.Text := 'SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = ' + Chr(39) + TableName + Chr(39);
                  Open;
                  quForm.Fields[i].AsString := PrefixoCodigo + FieldByName('UltimoCodigo').AsString;
                end;
              
              // Para o loop, so pode ter um campo Auto por tabela
              Break;
            end;
        end;
  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.SetaCodigoAutoNumSub.Exception' + #13#10 + E.Message);
        Result := False;
      end;
  end;

end;

function TParentFch.SaveChange : boolean;
begin

   Result := False;

  // Geração de codigo automático
  if FormConfig.AutoCodeGen then
    try
      if not SetaCodigoAutoNum then
        begin
          PushError(CRITICAL_ERROR, 'ParentFch.FormPost.SetaCodigoAutoNum' + #13#10 + 'Result false.');
          Exit
        end;
    except
      on E: Exception do
        begin
          PushError(CRITICAL_ERROR, 'ParentFch.FormPost.SetaCodigoAutoNum.Exception' + #13#10 + E.Message);
          Exit
        end;
    end;

    //Before SAve Changes
    try
      if not OnBeforeSaveChange then
        begin
          PushError(CRITICAL_ERROR, 'ParentFch.FormPost.OnBeforePost' + #13#10 + 'Result false.');
          Exit;
        end;
    except
      on E: Exception do
        begin
          PushError(CRITICAL_ERROR, 'ParentFch.FormPost.OnBeforePost.Exception' + #13#10 + E.Message);
          Exit
        end;
    end;

  // Se necessário pego o próximo ID
  if (frmCommand = btInc) and (FormConfig.AutoIncField <> '') then
    begin
        try
           if quForm.FieldByName(FormConfig.AutoIncField).AsString = '' then
              quForm.FieldByName(FormConfig.AutoIncField).Value :=
              DM.GetNextID(UpperCase(GetSQLFirstTableName(quForm.CommandText) + '.' + FormConfig.AutoIncField));
        except
            on E: Exception do
               begin
               PushError(CRITICAL_ERROR, 'ParentFch.SaveChange.AutoGenCode.Exception' + #13#10 + E.Message);
               Exit;
               end;
        end;
    end;


  // Da o Post
  try
    if quForm.State in dsEditModes then
       quForm.Post;
  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.FormPost.quFormPost.Exception' + #13#10 + E.Message);
        Exit
      end;
  end;

  // Salva os valores da chave para identity
  Try
   if (frmCommand = btInc) then
     begin
      // Inclusao
      if FormConfig.IsAutoIncKey then
        begin
         if FormConfig.PostOnInsert then
            FieldKey1  := quForm.Parameters.Items[0].Value
         else
            //FieldKey1 := IntToStr(DM.GetlastKey);
            FieldKey1 := quForm.FieldByName(FormConfig.AutoIncField).Value;
        end
      else
        begin
         // Salva os valores da chave para nao identity
         FieldKey1 := quForm.FieldByName(quForm.Parameters.Items[0].Name).AsString;
         if quForm.Parameters.Count > 1 then
            FieldKey2 := quForm.FieldByName(quForm.Parameters.Items[1].Name).AsString;
        end;
     end
   else
     begin
       // Alteracao
       FieldKey1 := quForm.Parameters.Items[0].Value;
       if quForm.Parameters.Count > 1 then
          FieldKey2 := quForm.Parameters.Items[1].Value;
     end;
  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.FormPost.GetChave.Exception' + #13#10 + E.Message);
        Exit
      end;
  end;

  // Execura qualque atualizacao extra que os descendentes necessitem
  try
    if not OnAfterSaveChange then
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.FormPost.OnAfterPost' + #13#10 + 'Result false');
        Exit;
      end;
  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.FormPost.OnAfterPost.Exception' + #13#10 + E.Message);
        Exit
      end;
  end;

  Result := True;
end;

function TParentFch.OnBeforeSaveChange:Boolean;
begin
  // Para ser herdado
  Result := True;
end;

function TParentFch.OnAfterSaveChange:Boolean;
begin
  // Para ser herdado
  Result := True;
end;

procedure TParentFch.btCancelClick(Sender: TObject);
begin
  inherited;
  if OpenModal then
    ModalResult := mrCancel
  else
    begin
      DoCancel(True);
      Close;
    end;
end;

procedure TParentFch.FormCreate(Sender: TObject);
var
  MySqlStatement : TSQlStatement;
  i : integer;
  IsSystem : Boolean;
begin
  inherited;

  OpenModal := True;

  // Compatibilidade passada
  if FormConfig.EntidadeNome = '' then
    FormConfig.EntidadeNome := lblPTitulo.Caption;

  // Passa os valores do FormConfig para a Ficha
  EntidadeNome := FormConfig.EntidadeNome;
  EntidadeMasculina := FormConfig.EntidadeMasculina;

  NotNullFields  := TStringList.Create;
  MyquFormParams := TParams.Create;
  MyUserRightsList := TStringList.Create;

  if FormConfig.SystemReadOnly then
    begin
      with quForm do
        begin
          // testa se ja exite campo system
          IsSystem := False;
          i := 0;
          while (i < FieldCount) and (not IsSystem) do
            begin
             IsSystem := ('SYSTEM' = Trim(UpperCase(Fields[i].FieldName)));
             Inc(i);
            end;

          if not IsSystem then
            begin
              // Salva os parametros do quForm
              MyquFormParams.Assign(Parameters);

              // Muda a string SQL para incluir o campo desativado
              MySqlStatement := UnMountSQL(CommandText);
              MySqlStatement[ST_SELECT] := MySqlStatement[ST_SELECT] + ' , ' +
                                           GetSQLFirstTableAlias(CommandText) + '.' +
                                           'SYSTEM';
              CommandText := MountSQL(MySqlStatement);

              // crio o novo field
              fldSystem := TBooleanField.Create(Self);
              fldSystem.FieldName := 'SYSTEM';
              fldSystem.Name := 'PaideFichasrt' + fldSystem.FieldName;
              fldSystem.Index := FieldCount;
              fldSystem.DataSet := quForm;
              FieldDefs.UpDate;

              // Restaura os tipos dos paramteros do browse
              for i := 0 to ParamCount - 1 do
                Parameters.Items[i].DataType := MyquFormParams[i].DataType;
            end;
        end;
    end;

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sAdding   := 'Adding';
           sAdd      := '&Add';
           sUpdating := 'Updating';
           sUpdate   := '&Update';
           sField    := 'Field [';
           sNoEmpty  := '] cannot be empty !';
           end;
    LANG_PORTUGUESE :
           begin
           sAdding   := 'Adicionar';
           sAdd      := '&Adicionar';
           sUpdating := 'Atualizar';
           sUpdate   := 'At&ualizar';
           sField    := 'Campos [';
           sNoEmpty  := '] não pode ser nulo !';
           end;
    LANG_SPANISH :
           begin
           sAdding   := 'Adicionando';
           sAdd      := '&Adicionar';
           sUpdating := 'Actualizando';
           sUpdate   := 'Act&ualizar';
           sField    := 'Campo [';
           sNoEmpty  := '] no puede quedar vacio !';
           end;
  end;


end;

procedure TParentFch.FormDestroy(Sender: TObject);
begin
  inherited;
  MyquFormParams.Free;
  NotNullFields.Free;

  MyUserRightsList.Free;

  with quForm do
   begin
     if Active then Close;
   end;
end;

procedure TParentFch.quFormPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
  function SetFieldFocus(strField : String) : String;
  begin
    { Seta o foco para o campo com erro }
    try
      DataSet.FieldByName(strField).FocusControl;
      Result  := DataSet.FieldByName(strField).DisplayName;
    except
      on exception do
        raise exception.create('The index ' + strField + ' is not compatible with the field');
    end;
  end;

{ Funcao principal }
var
  strField, RetMessage : String;
  MyControl: TControl;

begin
  inherited;

  strField := HandleDataBaseError(E.Message, RetMessage);

  if strField <> '' then
    begin
      Action  := daAbort; { erros conhecidos }
      MsgBox(SetFieldFocus(strField) + ' ' + RetMessage,
                 vbOKOnly + vbInformation);

{      // Primeiro devo checar se o controle esta em algum TTabSheet
      MyControl := Self.ActiveControl;
          ShowMessage(MyControl.Name);
      repeat
        begin
          MyControl := MyControl.Parent;
          ShowMessage(MyControl.Name);
        end;
      until (MyControl is TTabSheet) or (MyControl.Name = Self.Name);

      // Garante que a página que contém o controle esta visivel
      if MyControl is TTabSheet then
        TPageControl(MyControl.Parent).ActivePage := TTabSheet(MyControl);
}
    end
  else
    // erro desconhecido
    Action  := daFail;
end;

procedure TParentFch.RefreshBrowse(Full: Boolean);
begin
  // Da o refresh no browse
  if MybrwQuery <> nil then
    begin
      if (MybrwQuery is TPowerADOQuery) then
        begin
          with TPowerADOQuery(MyBrwQuery) do
            begin
              // se nao setou o keyfields
              // ou o dataset não está aberto
              // nao da o refresh automatico
              if (KeyFields = '')
                 OR
                 (not Active) then
                Exit;

              try
                DisableControls;
                if Full then
                  Requery;
                if frmCommand = btInc then
                  begin
                    // posiciona o cursor sobre a linha atual
                    if FieldKey2 = '' then
                      Locate(KeyFields, FieldKey1, [])
                    else
                      Locate(KeyFields, ConvVarArray(FieldKey1+';'+FieldKey2), []);
                  end
                else
                  begin
                    // posiciona o cursor sobre a linha atual
                    if FieldKey2 = '' then
                      Locate(KeyFields, quForm.Parameters.Items[0].Value, [])
                    else
                      Locate(KeyFields, ConvVarArray(quForm.Parameters.Items[0].Value + ';' + quForm.Parameters.Items[1].Value), []);
                  end;
              finally;
                EnableControls;
              end;

            end;
        end;
    end;
end;

procedure TParentFch.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  nMsg : integer;
begin
  inherited;

  CanClose := True;
  if TestOnEditModes then
    begin
      if FormConfig.ConfirmCancel then
        begin
          nMsg := MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES,
                         vbYesNoCancel + vbQuestion);
          case nMsg of
            vbYes    : SaveData;
            vbNo     : DoCancel(frmCommand=btInc);
            vbCancel : CanClose := False;
          end;
        end
      else
        begin
          DoCancel(frmCommand=btInc);
        end;
    end;
end;

procedure TParentFch.DoCancel(DeleteOnInc : Boolean);
var
  i : integer;
  bError : Boolean;
begin

  bError := False;

  // Codigo do usuario
  try
    if not OnBeforeDoCancel then
      begin
      PushError(CRITICAL_ERROR, 'ParentFch.DoCancel.OnBeforeDoCancel' + #13#10 + 'Result false');
      bError := True;
      end
  except
    on E: Exception do
      begin
      bError := True;
      PushError(CRITICAL_ERROR, 'ParentFch.DoCancel.OnBeforeDoCancel.Exception' + #13#10 + E.Message);
      end;
  end;

  // Cacela a edit da query
  try
    CancelUpdates;
  except
    on E: Exception do
      begin
      bError := True;
      PushError(CRITICAL_ERROR, 'ParentFch.DoCancel.CancelUpdates.Exception' + #13#10 + E.Message);
      end;
  end;

  // Deleta o incluido e que nao foi aceito
  if (frmCommand = btInc) and DeleteOnInc and
     (FormConfig.IsAutoIncKey) and (FormConfig.PostOnInsert) then
    begin
      try
        DM.DBADOConnection.BeginTrans;
        for i := 0 to FormConfig.DependentTables.Count -1 do
          with DM.quFreeSQL do
            begin
               if Active then
                  Close;
               SQl.Text := 'DELETE FROM ' + FormConfig.DependentTables.Strings[i] +
                           ' WHERE ' + FormConfig.DependentTableKeys.Strings[i] + ' = ' + VarToStr(quForm.Parameters.Items[0].Value);
               ExecSQL;
            end;
        quForm.Delete;
        DM.DBADOConnection.CommitTrans;
      except
        on E: Exception do
            begin
            bError := True;
            DM.DBADOConnection.RollBackTrans;
            PushError(CRITICAL_ERROR, 'ParentFch.DoCancel.DependentTables.Exception' + #13#10 + E.Message);
            end;
      end;
    end;

  try
    if not OnAfterDoCancel then
      begin
      bError := True;
      PushError(CRITICAL_ERROR, 'ParentFch.DoCancel.OnAfterDoCancel' + #13#10 + 'Result false');
      end;
  except
    on E: Exception do
      begin
      bError := True;
      PushError(CRITICAL_ERROR, 'ParentFch.DoCancel.OnAfterDoCancel.Exception' + #13#10 + E.Message);
      end;
  end;

  if bError then
     MsgBox(MSG_CRT_ERROR_DELETING, vbCritical + vbOkOnly);

end;

function TParentFch.OnBeforeDoCancel:Boolean;
begin

  Result := True;
end;

function TParentFch.OnAfterDoCancel:Boolean;
begin

  Result := True;
end;



procedure TParentFch.CancelUpdates;
begin
  if quForm.State in dsEditModes then
     quForm.Cancel;
end;

procedure TParentFch.btOKClick(Sender: TObject);
var
   Msg: String;
begin
  inherited;

  if TestOnEditModes then
    begin
      if not (TestFieldFill AND TestOnBeforeSave AND TestFieldUnique) then Exit;

      // Testa se deve confirmar a alteracao
      //Msg := MSG_QST_PART_CONFIRM + FOperacaoConfirmacao + ' ' + FEntidadeNome + '?';
      Msg := FOperacaoConfirmacao + ' ' + FEntidadeNome + '?';

      if (not FormConfig.ConfirmPost) or
         (MsgBox(Msg, vbYesNo + vbQuestion) = vbYes) then
         begin
         Screen.Cursor := crHourGlass;
         SaveData;
         Screen.Cursor := crDefault;
         end
      else
         Exit;  // Caso cancele a operação
    end;

  // Trata a inclusão em Loop
  if (frmCommand <> btInc) then
    begin
      if OpenModal then
        ModalResult := mrOK
      else
        Close;
    end
  else
     if btLoopInc.Down then
        begin
        if not NextAppend then
           begin
           PushError(CRITICAL_ERROR, 'ParentFch.btOkClick.NextAppend' + #13#10 + 'Result false');
           MsgBox(MSG_CRT_ERROR_ADDING, vbCritical + vbOkOnly);
           end;
        end   
     else
       begin
         if OpenModal then
           ModalResult := mrOK
         else
           Close;
       end;
end;

function TParentFch.OnSaveData: boolean;
begin
  // Para ser herdado
  Result := True;
end;

procedure TParentFch.SaveData;

  procedure RollBackError;
    begin
      if DM.DBADOConnection.InTransaction then
          DM.DBADOConnection.RollbackTrans;

      MsgBox(MSG_CRT_ERROR_SAVING, vbCritical + vbOkOnly);
      IsPost := False;
    end;

begin

  // Roda qualquer codigo antes da trasaçao de save
  try
    if not OnBeforeTransaction then
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.SaveData.OnBeforeTransaction' + 'Result false');
        RollBackError;
        Exit;
      end;
  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.SaveData.OnBeforeTransaction.Exception' + #13#10 + E.Message);
        RollBackError;
        Exit;
      end;
  end;

  with quForm do
   begin
     try
      // Grava modificacoes
      DM.DBADOConnection.BeginTrans;
      FchUpdateRecord;
      if SaveChange and OnSaveData then
        begin
         DM.DBADOConnection.CommitTrans;
         OnAfterSaveData;
         { Deixa a inclusão dar o refresh }
         IsPost := True;
         RefreshBrowse(True);
        end
      else
        begin
           RollBackError;
           Exit;
        end;
     except
            on E: Exception do
              begin
                PushError(CRITICAL_ERROR, 'ParentFch.SaveData.StartTransaction.Exception' + #13#10 + E.Message);
                RollBackError;
                Exit;
              end;
     end;
   end;

end;

function TParentFch.TestOnBeforeSave : boolean;
begin
  // para ser herdado
  Result := True;
end;

procedure TParentFch.FchUpdateRecord;
begin
  if quForm.State in dsEditModes then
     quForm.UpdateRecord; // Force pending updates
end;

procedure TParentFch.UpdateNavigation;
var
   RealBOF, RealEOF: Boolean;

begin

  // Testes para ver se esta no primeiro ou ultimo registro
  if (MybrwQuery = nil) or (frmCommand = btInc) then
    begin
      pnlNavigation.Visible := False;
      Exit;
    end
  else
    pnlNavigation.Visible := True;


 if not Assigned(MyGrid) then
    begin
    with MyBrwQuery do
        begin
        // DisableControls;
        // Testa o Inicio real
        if BOF then
           RealBOF := True
        else
          begin
            Prior;
            RealBOF := BOF;
            if not RealBOF then
              Next;
          end;

        // Testa o Fim real
        if EOF then
           RealEOF := True
        else
          begin
            Next;
            RealEOF := EOF;
            if not RealEOF then
              Prior;
          end;

        btPriorRec.Enabled := not RealBOF;
        btFirstRec.Enabled := btPriorRec.Enabled;

        btNextRec.Enabled := not RealEOF;
        btLastRec.Enabled := btNextRec.Enabled;

        // EnableControls;
        end; //end with MyBrwQuery
    end //end if
 else
    begin
      if myGrid.FocusedNode <> nil then
        begin
          btPriorRec.Enabled := (myGrid.FocusedNode.Index <> 0);
          btFirstRec.Enabled := btPriorRec.Enabled;

          btNextRec.Enabled := not myGrid.FocusedNode.IsLast;
          btLastRec.Enabled := btNextRec.Enabled;
        end;

    end; //end else
end;

function TParentFch.TestBeforeNavigate: Integer;
var
   Msg: Integer;
begin
  Result := 1;  // 0 Não pode navegar
                // 1 pode e não da requery
                // 2 pode e da requery

  if TestOnEditModes or (frmCommand = btInc) then
    begin
      Msg := MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbYesNoCancel + vbQuestion);
      if Msg = vbYes then
        begin
          SaveData;
          frmCommand := btAlt;
          Result := 2;
        end
      else if Msg = vbNo then
        begin
          DoCancel(True);
          frmCommand := btAlt;
          Result := 1;
        end
      else
        Result := 0;
    end;
end;

procedure TParentFch.SyncFichaToBrowse(Full: Boolean);
begin
  CloseDataSets;
  SetParamBrowse;
  OpenDataSets;
  RefreshBrowse(Full);
  FormShow(nil);
end;

procedure TParentFch.btLastRecClick(Sender: TObject);
var
   R: integer;
begin
  inherited;
  R := TestBeforeNavigate;
  // 0 não pode navegar
  // 1 navega sem requery
  // 2 navega com requery
  if  R <> 0 then
    begin
    if Assigned(myGrid) then
       with myGrid do
          begin
          FocusedNode.Selected := False;
          if FocusedNode.Level > 0 then
             FocusedNode.Parent.Items[FocusedNode.Parent.Count-1].Focused := True
          else
             Items[Count-1].Focused := True;
          FocusedNode.Selected := True;
          end
   else
      MyBrwQuery.Last;

   SyncFichaToBrowse(R = 2);
   UpdateNavigation;
   end;
end;

procedure TParentFch.btNextRecClick(Sender: TObject);
var
   R: integer;
begin
  inherited;
  R := TestBeforeNavigate;
  // 0 não pode navegar
  // 1 navega sem requery
  // 2 navega com requery
  if  R <> 0 then
    begin
    if Assigned(myGrid) then
       with myGrid do
           begin
           FocusedNode.Selected := False;
           FocusedNode.GetNextNode.Focused := True;
           FocusedNode.Selected := True;
           end
      else
        MyBrwQuery.Next;

    SyncFichaToBrowse(R = 2);
    UpdateNavigation;
    end;
end;

procedure TParentFch.btPriorRecClick(Sender: TObject);
var
   R: integer;
begin
  inherited;
  R := TestBeforeNavigate;
  // 0 não pode navegar
  // 1 navega sem requery
  // 2 navega com requery
  if R <> 0 then
     begin
     if Assigned(myGrid) then
        with myGrid do
          begin
            FocusedNode.Selected := False;
            FocusedNode.GetPriorNode.Focused := True;
            FocusedNode.Selected := True;
          end
      else
        MyBrwQuery.Prior;

    SyncFichaToBrowse(R = 2);
    UpdateNavigation;
    end;
end;

procedure TParentFch.btFirstRecClick(Sender: TObject);
var
   R: integer;
begin
  inherited;
  R := TestBeforeNavigate;
  // 0 não pode navegar
  // 1 navega sem requery
  // 2 navega com requery
  if  R <> 0 then
    begin
      if Assigned(myGrid) then
        with myGrid do
            begin
            FocusedNode.Selected := False;
            if FocusedNode.Level > 0 then
               FocusedNode.Parent.Items[0].Focused := True
            else
               Items[0].Focused := True;
           FocusedNode.Selected := True;
           end
      else
        MyBrwQuery.First;

    SyncFichaToBrowse(R = 2);
    UpdateNavigation;
    end;
end;

procedure TParentFch.TocaFicha;
begin
  with Self.quForm do
    if Active then
      Edit;
end;



function TParentFch.TestFieldFill: boolean;
var
  i: integer;
  Msg1, Msg2: String;
begin
  Result := True;

  Msg2 := '';
  
  with quForm do
    if State in dsEditModes then
      UpdateRecord;
      
  with quForm do
    for i := 0 to FieldCount-1 do
      begin
        if Fields[i].Required and (Fields[i].AsString = '') and Result then
          begin
            Result := False;
            Msg1 := sField + Fields[i].DisplayLabel + sNoEmpty;

            // Garanto que o tab correto está visivel
            // no field, o tag diz qual é o tabindex
            // Descendentes que tenham tabcontrols, escrevem o codigo de
            // mudar de pagina
            SetPageControl(Fields[i].Tag);

            Fields[i].FocusControl;
          end;

        if Fields[i].Required then
          begin
            if Msg2 <> '' then
              Msg2 := Msg2 + ', ';
            Msg2 := Msg2 + Fields[i].DisplayLabel;
          end;
      end;

  if not Result then
    begin
      MsgBox( Msg1 + MSG_CRT_PART_FIELDS_NO_EMPTY + Msg2,
              vbCritical + vbOkOnly);
    end;


end;

function TParentFch.TestFieldUnique: boolean;
var
  sTableName: String;
  slFields: TStringList;
  i, j: integer;
  sMsgBox, sSQL, sWhere: String;
  fCurrentField: TField;

begin
  slFields := TStringList.Create;

  Result := True;

  with quForm do
    if State in dsEditModes then
      UpdateRecord;

  sTableName := GetSQLFirstTableName(quForm.CommandText);

  with FormConfig.UniqueFields do
    for i := 0 to Count-1 do
      begin
        // Separa os fields da linha
        slFields.CommaText := Strings[i];

        // Monta o SQL
        sSQL   := 'SELECT Count(*) FROM ' + sTableName + ' WHERE ';

        if quForm.Fields[0].AsString <> '' then
          sSQL := sSQL + quForm.Fields[0].FieldName + '<>' + quForm.Fields[0].AsString + ' AND ';
          
        sWhere := '';

        for j := 0 to slFields.Count-1 do
          begin
            fCurrentField := quForm.FindField(slFields.Strings[j]);
            if fCurrentField <> nil then
              begin
                if sWhere <> '' then
                  sWhere := sWhere + ' AND ';

                case fCurrentField.DataType of
                  ftString:
                    sWhere := sWhere + slFields.Strings[j] + '=' + QuotedStr(quForm.FieldByName(slFields.Strings[j]).AsString);
                  ftBoolean:
                    sWhere := sWhere + slFields.Strings[j] + '=' + IntToStr(quForm.FieldByName(slFields.Strings[j]).AsInteger);
                  else
                    sWhere := sWhere + slFields.Strings[j] + '=' + quForm.FieldByName(slFields.Strings[j]).AsString;
                end;
              end;

          end;
        sSQL := sSQL + sWhere;

        // Teste se o registro já existe
        with DM.quFreeSQL do
          begin
            Close;
            SQL.Text := sSQL;
            Open;
            Result := (Fields[0].AsInteger = 0);
            Close;
          end;

        // Testa se tem que parar
        if not Result then
          Break;
      end;

  if not Result then
    begin
      sMsgBox := fCurrentField.DisplayLabel + MSG_INF_PART_NO_DUPLICATED;
      MsgBox(sMsgBox, vbInformation + vbOkOnly);
    end;


  slFields.Free;
end;


procedure TParentFch.btPrintFchClick(Sender: TObject);
begin
  inherited;
  if PrintFch.Execute then
    Print;

end;

procedure TParentFch.SetPageControl(Pageindex: integer); 
begin
  // Para ser herdado
end;

procedure TParentFch.OnAfterSaveData;
begin
  // Para ser herdado
end;

procedure TParentFch.OnSetDefaultFields;
begin
  // Para ser herdado
end;


procedure TParentFch.btHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(Self.HelpContext);
end;

end.
