unit PaiDeFichas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, DBTables, DbCtrls, DateBox, FormConfig, Mask, Buttons,
  dbGrids, uSystemTypes, ADODB, RCADOQuery, PowerADOQuery, Variants, siComp,
  siLangRT;

type
  TOnValidadeFieldEvent = function(Sender: TObject): boolean of object;

type
  TFrmPaiDeFch = class(TForm)
    dsForm: TDataSource;
    quForm: TPowerADOQuery;
    FormConfig: TFormConfig;
    Panel5: TPanel;
    lblUserName: TLabel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    sbHelp: TSpeedButton;
    btCancel: TButton;
    btClose: TButton;
    siLang: TsiLangRT;
    procedure dsFormStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure quFormPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure quFormAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    //Translation
    IsPost:   Boolean;
    bAnyPost: Boolean;
    sCloseButton,
    sCancelButton,
    sSaveButton,
    sFields,
    sCannot : String;

    fldSystem : TBooleanField;
    MaxLastKey : integer;
    NotNullFields : TStringList;
    function SaveHighChange : Boolean;
    procedure ClearParam;
    procedure SyncFichaToBrowse;
  protected
    { protected }
    FieldKey1, FieldKey2 : String;
    frmCommand : TBtnCommandType;
    MybrwQuery : TPowerADOQuery;
    FOnValidadeFieldEvent: TOnValidadeFieldEvent;
    fLangLoaded : Boolean;

    procedure PushError(ErrorType: Integer; sError: String);

    function TestFieldFill: boolean;
    function OnValidadeField: boolean; virtual;
    function SaveChange: boolean; virtual;
    function DoPost: boolean; virtual;
    function BeforeChange: boolean; virtual;
    function TestOnEditModes: boolean; virtual;

    procedure NextAppend; virtual;
    procedure CancelUpdates; virtual;

    function OnAfterSaveChange(var iError:Integer):Boolean; virtual;

    procedure DoCancel(DeleteOnInc : Boolean);
    procedure OnAfterDoCancel; virtual;
    procedure OnBeforePrepare;
    procedure OnAfterCommit; virtual;
    procedure OnAfterRollBack; virtual;

    procedure OnBeforeStart; virtual;
    procedure OnBeforeShow; virtual;
    procedure OnAfterStart; virtual;

  public
    { Public declarations }
    FchBrowse : TObject;  // Aponta para o browse da ficha
    sParam :  string;
    function  Start(pCommand  : TBtnCommandType;
                    brwQuery  : TPowerADOQuery;
                    IsLoopInc : Boolean;
                    var PosID1, PosID2 : String) : Boolean;
  published
    property OnValidateFields: TOnValidadeFieldEvent read FOnValidadeFieldEvent write FOnValidadeFieldEvent;

  end;

implementation

{$R *.DFM}

uses xBase, uDM, uMsgBox, SuperComboADO, uParamFunctions,
     uSqlFunctions, uMsgConstant, uVarianteFunctions, uDataBaseFunctions,
     uHandleError, uDMGlobal;


procedure TFrmPaiDeFch.SyncFichaToBrowse;
var
  i : Integer;
begin

  quForm.Close;

  if not MybrwQuery.IsEmpty then
     with quForm do
        if not (MybrwQuery.Eof and MybrwQuery.Bof) then
           for i := 0 to Parameters.Count-1 do
               Parameters[i].Value := MybrwQuery.FieldByName(Parameters[i].Name).Value;

  quForm.Open;

end;


procedure TFrmPaiDeFch.PushError(ErrorType: Integer; sError: String);
begin

   DM.SetError(ErrorType, Self.Name, sError);

end;

function  TFrmPaiDeFch.Start(pCommand  : TBtnCommandType;
                              brwQuery  : TPowerADOQuery;
                              IsLoopInc : Boolean;
                              var PosID1, PosID2 : String) : Boolean;
begin
  inherited;

  Screen.Cursor := crHourGlass;

  // Seta variáveis globais
  frmCommand  := pCommand;
  IsPost      := False;
  bAnyPost    := False;
  MybrwQuery  := brwQuery;

  OnBeforeStart;

  // Seta os FilterFields
  if brwQuery <> nil then
     if (frmCommand = btInc) and (brwQuery is TPowerADOQuery) then
       with quForm do
         begin
           FilterFields.Assign(TPowerADOQuery(brwQuery).FilterFields);
           FilterValues.Assign(TPowerADOQuery(brwQuery).FilterValues);
         end;

  // Seta o filtro do registro a ser mostrado
  if frmCommand = btAlt then
    with quForm do
        begin
        Close;
        if (brwQuery <> nil) then
          begin
           SyncFichaToBrowse;
          end
        else
          if PosID1 <> '' then
             begin
             Parameters.Items[0].Value := ConvVariant(Parameters.Items[0].DataType, PosID1);
             if PosID2 <> '' then
                Parameters.Items[1].Value := ConvVariant(Parameters.Items[1].DataType, PosID2);
             Open;
             end;
        end
  else
    begin
    ClearParam;
    end;

  Screen.Cursor := crDefault;

  OnBeforeShow;

  ShowModal;

  with quForm do
    if Active then Close;

  if IsPost then
    begin
     PosID1 := FieldKey1;
     PosID2 := FieldKey2;
    end;

  OnAfterStart;

  Result := bAnyPost;
end;


procedure TFrmPaiDeFch.OnBeforeStart;
begin
  // Para se herdado
end;

procedure TFrmPaiDeFch.OnAfterStart;
begin
  // Para se herdado
end;

procedure TFrmPaiDeFch.OnBeforeShow;
begin
  // Para se herdado
end;

procedure TFrmPaiDeFch.dsFormStateChange(Sender: TObject);
begin
  inherited;

  if TestOnEditModes then
     begin
     btCancel.Font.Style := [fsBold];
     btCancel.Caption    := sCancelButton;
     end;

end;

procedure TFrmPaiDeFch.FormShow(Sender: TObject);
begin
  inherited;

  case frmCommand of
     btInc    : begin
                  NextAppend;
                end;
     btAlt    : begin
                end;
  end;

  btClose.Caption  := sSaveButton;

  Screen.Cursor := crDefault;

end;

procedure TFrmPaiDeFch.NextAppend;
var
  i       : integer;
  slRequired: TStringList;

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


begin

  // Faz o post automatico
  if not quForm.Active then
      quForm.Open; // ** Ivanil

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
     NotNullFields.Clear;

     UnMarkRequiredFields;

     with quForm do
      begin
        MaxLastKey := DM.GetNextID(GetSQLFirstTableName(quForm.CommandText)+'.'+Parameters.Items[0].Name);

        quForm.FieldbyName(quForm.Parameters.Items[0].Name).AsInteger := MaxLastKey;
        for i := 0 to FormConfig.RequiredFields.Count - 1 do
          begin
            if FieldByName(FormConfig.RequiredFields.Strings[i]).IsNull then
               case FieldByName(FormConfig.RequiredFields.Strings[i]).DataType of

                    ftString,
                    ftMemo      : FieldByName(FormConfig.RequiredFields.Strings[i]).AsString   := IntToStr(MaxLastKey);

                    ftDateTime,
                    ftDate      : FieldByName(FormConfig.RequiredFields.Strings[i]).AsDateTime := Now;

                    ftInteger   : FieldByName(FormConfig.RequiredFields.Strings[i]).AsInteger  := 0;

                    ftFloat     : FieldByName(FormConfig.RequiredFields.Strings[i]).AsFloat    := 0;

                    ftBoolean   : FieldByName(FormConfig.RequiredFields.Strings[i]).AsBoolean  := False;
               end
            else
               begin
                 NotNullFields.Add(FormConfig.RequiredFields.Strings[i]);
               end;
          end;

        try
          // Inicia uma transação no Servidor
          DM.ADODBConnect.BeginTrans;
          //quForm.UpdateBatch;
          quForm.Post;

          // Marca a gravacao
          FieldKey1  := IntToStr(MaxLastKey);
          IsPost     := True;

          // Confirma as alterações para o servidor
          DM.ADODBConnect.CommitTrans;
        except
          on E: Exception do
             begin
             // Cancela as alterações feitas
             DM.ADODBConnect.RollbackTrans;
             PushError(CRITICAL_ERROR, 'ParentFch.NextAppend.GetLastKey.Exception' + #13#10 + E.Message);
             Exit;
             end;

        end;

        Close;
        Parameters.Items[0].Value := MaxLastKey;

        Try
          Open;
          Edit;
        except
          on E: Exception do
              begin
              PushError(CRITICAL_ERROR, 'ParentFch.NextAppend.quForm.Open.Exception' + #13#10 + E.Message);
              Exit;
              end;
        end;

        MarkRequiredFields;

        // Reseta os campos que sao required
        if FormConfig.RequiredFields.Count > 0 then
          begin
           for i := 0 to FormConfig.RequiredFields.Count - 1 do
               if NotNullFields.IndexOf(FormConfig.RequiredFields.Strings[i]) = -1 then
                  FieldByName(FormConfig.RequiredFields.Strings[i]).Clear;
          end;
      end;
    end;

end;

procedure TFrmPaiDeFch.btCloseClick(Sender: TObject);
begin
  inherited;

  ModalResult := mrNone;

  with quForm do

   if TestOnEditModes then
     begin
       if quForm.State in dsEditModes then
          quForm.UpdateRecord; // Force pending updates

       if not (OnValidadeField and TestFieldFill) then
         Exit;

       if not BeforeChange then
         Exit;

       // Testa se deve confirmar a alteracao
       if (not FormConfig.ConfirmPost) or
          (MsgBox(MSG_QST_CONFIRM, vbYesNo + vbQuestion) = vbYes) then
          begin

           if not SaveHighChange then
              Exit;

           // Deixa a inclusão dar o refresh
           IsPost := True;
           bAnyPost := True;

          end
       else
          begin
          Screen.Cursor := crdefault;
          Exit;  // Caso cancele a operação
          end;

     end;

  if (frmCommand <> btInc) then
     ModalResult := mrOK
  else
     //if btLoopInc.Down then
     //   NextAppend
     //else
        ModalResult := mrOK;

end;

function TFrmPaiDeFch.SaveHighChange: Boolean;
var
  iSPError : integer;
begin
  with DM.ADODBConnect do
   begin

     try
      // Abre uma transction no serve
      BeginTrans;

      Result := SaveChange;

      if Result = True then
         Result := OnAfterSaveChange(iSPError);

     Finally
      if Result then
        begin
          CommitTrans;
          Try
             OnAfterCommit;
          Except
             on E : Exception do
                PushError(CRITICAL_ERROR, 'ParentFch.OnAfterCommit.Exception' + #13#10 + E.Message);
          end;
        end
      else
        begin
          RollbackTrans;
          OnAfterRollBack;
          PushError(CRITICAL_ERROR, 'ParentFch.SaveChange.Exception' + #13#10 + 'Result False');
          ShowMessage('Stored Proc error:'+ IntToStr(iSPError));
        end;
     end;
   end;
end;


function TFrmPaiDeFch.BeforeChange : boolean;
begin
  // funcao para ser herdada
  Result := True;
end;

function TFrmPaiDeFch.TestOnEditModes : boolean;
begin
  Result := quForm.State in dsEditModes;
end;

function TFrmPaiDeFch.DoPost: boolean;
begin
  try
     if quForm.State in dsEditModes then
        quForm.Post;
     Result := True;
  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'ParentFch.FormPost.quFormPost.Exception' + #13#10 + E.Message);
        Result := False;
      end;
  end;
end;

function TFrmPaiDeFch.SaveChange : boolean;
begin

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


  //Da o Post
  if not DoPost then
     Exit;

  Try
     // Salva os valores da chave para identity
     if (frmCommand = btInc) then
       begin
        // Inclusao
        if FormConfig.IsAutoIncKey then
          begin
          if FormConfig.PostOnInsert then
              FieldKey1 := quForm.Parameters.Items[0].Value
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
        Exit;
      end;
  end;

  Result := True;
  
end;

procedure TFrmPaiDeFch.btCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TFrmPaiDeFch.FormCreate(Sender: TObject);
var
  MySqlStatement : TSQlStatement;
  //MyDateType     : Array  [1..5] of TDataType;
  i : integer;
  IsSystem : Boolean;
begin

  fLangLoaded := (DMGlobal.IDLanguage = LANG_ENGLISH);

  //Load Translation
  if (not fLangLoaded) and (siLang.StorageFile <> '') then
      begin
      if FileExists(DMGlobal.LangFilesPath + siLang.StorageFile) then
         siLang.LoadAllFromFile(DMGlobal.LangFilesPath + siLang.StorageFile, True)
      else
         MsgBox(MSG_INF_DICTIONARI_NOT_FOUND ,vbOKOnly + vbInformation);

      fLangLoaded := True;
      end;

  bAnyPost := False;

  OnBeforePrepare;

  // ** herda a procedure FormCreate do Pai (frmParent)
  inherited;

  // ** instancia estes objetos
  NotNullFields  := TStringList.Create;
  //MyquFormParams := TParameters.Create(nil, nil);

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
              //MyquFormParams.Assign(Parameters);
              //for i := 0 to Parameters.Count - 1 do
                  //MyDateType[i] := Parameters.Items[i].DataType;

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
              //for i := 0 to Parameters.Count - 1 do
               //Parameters.Items[i].DataType := MyquFormParams.Items[i].DataType;
              //for i := 0 to Parameters.Count - 1 do
                  //Parameters.Items[i].DataType := MyDateType[i];

            end;
        end;
    end;

  Case DMGlobal.IDLanguage of
      LANG_ENGLISH :
          begin
          sCloseButton  := 'Close';
          sCancelButton := 'Cancel';
          sSaveButton   := 'Save';
          sFields       := 'Field [';
          sCannot       := '] can not be empty !';
          end;
      LANG_PORTUGUESE :
          begin
          sCloseButton  := 'Fechar';
          sCancelButton := 'Cancelar';
          sSaveButton   := 'Salvar';
          sFields       := 'Campos [';
          sCannot       := '] não podem ser nulos !';
          end;
      LANG_SPANISH :
          begin
          sCloseButton  := 'Cerrar';
          sCancelButton := 'Cancelar';
          sSaveButton   := 'Guardar';
          sFields       := 'Campos [';
          sCannot       := '] no pueden estar vacios !';
          end;
  end;



end;

procedure TFrmPaiDeFch.FormDestroy(Sender: TObject);
begin
  inherited;
  // ** Destrói estes componentes
  //MyquFormParams.Free;
  NotNullFields.Free;

  with quForm do
   begin
     if Active then
        Close;
     //UnPrepare;
   end;
end;

procedure TFrmPaiDeFch.quFormPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
  function SetFieldFocus(strField : String) : String;
  begin
    { Seta o foco para o campo com erro }
    try
      DataSet.FieldByName(strField).FocusControl;
      Result  := DataSet.FieldByName(strField).DisplayName;
    except
      on exception do
        raise exception.create('The index ' + strField + ' is not compatibel with the field.');
    end;
  end;

{ Funcao principal }
var
  strField, RetMessage : String;
begin
  inherited;

  strField := HandleDataBaseError(E.Message, RetMessage);

  if strField <> '' then
    begin
     Action  := daAbort; { erros conhecidos }
     MsgBox(SetFieldFocus(strField) + ' ' + RetMessage,
                vbOKOnly + vbInformation);
    end
  else
    { erro desconhecido }
    Action  := daFail;
end;

procedure TFrmPaiDeFch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DoCancel((ModalResult = mrCancel));
end;

procedure TFrmPaiDeFch.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := True;
  if (frmCommand <> btInc) and TestOnEditModes then
    begin
      if (not FormConfig.ConfirmCancel) or
         (MsgBox(MSG_QST_UNSAVE_CHANGES, vbYesNo + vbQuestion) = vbYes) then
         begin
         CanClose := True;
         CancelUpdates;
         end
      else
         CanClose := False;
    end;

end;

procedure TFrmPaiDeFch.DoCancel(DeleteOnInc : Boolean);
var
  i : integer;
  sValue : String;
begin

  Try
      if quForm.State in dsEditModes then
         quForm.Cancel;
  except
    on E: Exception do
      begin
      PushError(CRITICAL_ERROR, 'ParentFch.DoCancel.CancelUpdates.Exception' + #13#10 + E.Message);
      end;
  end;


  // Deleta o incluido e que nao foi aceito
  if (frmCommand = btInc) and DeleteOnInc and
     (FormConfig.IsAutoIncKey) and (FormConfig.PostOnInsert) then
    begin
      try
        DM.ADODBConnect.BeginTrans;
        for i := 0 to FormConfig.DependentTables.Count -1 do
          with DM.quFreeSQL do
            begin
               if Active then
                  Close;

               sValue := quForm.Parameters.Items[0].Value;

               SQl.Text := 'DELETE FROM ' + FormConfig.DependentTables.Strings[i] +
                           ' WHERE ' + FormConfig.DependentTableKeys.Strings[i] + ' = ' + sValue;
               ExecSQL;
            end;
        quForm.Delete;
        DM.ADODBConnect.CommitTrans;
      except
        on E: Exception do
            begin
            DM.ADODBConnect.RollbackTrans;
            PushError(CRITICAL_ERROR, 'ParentFch.DoCancel.DependentTables.Exception' + #13#10 + E.Message);
            end;
      end;
    end;

   OnAfterDoCancel;
    
end;

procedure TFrmPaiDeFch.CancelUpdates;
begin
  quForm.Cancel;
end;

function TFrmPaiDeFch.OnAfterSaveChange(var iError:Integer):Boolean;
begin
  // Somente para ser herdado
  Result := True;

end;

procedure TFrmPaiDeFch.OnBeforePrepare;
begin
  // Somente para ser herdado
end;

function TFrmPaiDeFch.OnValidadeField: boolean;
begin
  // Somente para ser herdado
  Result := True;
end;

procedure TFrmPaiDeFch.OnAfterCommit;
begin
  // Somente para ser herdado
end;

procedure TFrmPaiDeFch.OnAfterRollBack;
begin
  // Somente para ser herdado
end;

procedure TFrmPaiDeFch.OnAfterDoCancel;
begin
  // Somente para ser herdado
end;

function TFrmPaiDeFch.TestFieldFill: boolean;
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
            Msg1 := sFields + Fields[i].DisplayLabel + sCannot;

            Fields[i].FocusControl;
          end;

        if Fields[i].Required and (Fields[i].AsString = '') then
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

procedure TFrmPaiDeFch.ClearParam;
var
  i: integer;
begin
  with quForm do
    begin
    for i := 0 to ParamCount-1 do
      Parameters.Items[i].Value := Null;
    end;
end;


procedure TFrmPaiDeFch.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  btCancel.Caption := sCloseButton;
  btCancel.Font.Style := [];

end;

end.
