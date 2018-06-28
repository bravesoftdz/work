unit PaiDeFichas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, StdCtrls, LblEffct, ExtCtrls, DB, DBTables,
  DbCtrls, DateBox, FormConfig, Mask, Buttons, dbGrids, uSystemTypes,
  ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT, Variants, cxGrid,
  cxGridCustomTableView, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSCore, dbClient;

type
  TOnValidadeFieldEvent = function(Sender: TObject): boolean of object;

type
  TbrwFrmParent = class(TFrmParent)
    btCancel: TButton;
    pnlKey: TPanel;
    Panel4: TPanel;
    pnlDetail: TPanel;
    pnlAutoInc: TPanel;
    btLoopInc: TSpeedButton;
    lblModified: TLabel;
    pnlNavigation: TPanel;
    btFirstRec: TSpeedButton;
    btPriorRec: TSpeedButton;
    btNextRec: TSpeedButton;
    btLastRec: TSpeedButton;
    dsForm: TDataSource;
    quForm: TPowerADOQuery;
    FormConfig: TFormConfig;
    spHelp: TSpeedButton;
    Image2: TImage;
    btnVideo: TSpeedButton;
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
    procedure btLastRecClick(Sender: TObject);
    procedure btNextRecClick(Sender: TObject);
    procedure btPriorRecClick(Sender: TObject);
    procedure btFirstRecClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure btnVideoClick(Sender: TObject);
  private
    { Private declarations }
    //Translation
    bAnyPost: Boolean;
    sCloseButton,
    sCancelButton,
    sSaveButton,
    sFields,
    sCannot : String;

    FOpenError : String;

    InitCaption : String;
    //MyquFormParams : TParameters;
    fldSystem : TBooleanField;
    MaxLastKey : integer;
    NotNullFields : TStringList;
    function SaveHighChange : Boolean;
    function  GetEditIni(MyPanel : TPanel) : TCustomEdit;
    procedure ClearParam;
    procedure ControlaEdits(MyPanel : TPanel; ChangeColor, MyReadOnly : Boolean);
    procedure ControlaFormEdits(ChangeColor, MyReadOnly : Boolean);
    procedure SetaFocoInicial;
    procedure ControlaPanels;
    procedure UpdateNavigation;
    procedure SyncFichaToBrowse;
    procedure TestBeforeNavigate;
  protected
    { protected }
    IsPost:   Boolean;
    FieldKey1, FieldKey2 : String;
    frmCommand : TBtnCommandType;
    MybrwQuery : TPowerADOQuery;
    myGrid     : TcxGrid;
    sUrlHelp, sUrlVideo : String;
    FOnValidadeFieldEvent: TOnValidadeFieldEvent;

    procedure PushError(ErrorType: Integer; sError: String);

    function TestFieldFill: boolean;
    function TestFieldUnique: boolean;
    function OnValidadeField: boolean; virtual;
    function SaveChange: boolean; virtual;
    function DoPost: boolean; virtual;
    function BeforeChange: boolean; virtual;
    function TestOnEditModes: boolean; virtual;
    function OnSyncFichaToBrowseError:String; virtual;

    procedure NextAppend; virtual;
    procedure CancelUpdates; virtual;

    function OnAfterSaveChange(var iError:Integer):Boolean; virtual;

    procedure RefreshBrowse; virtual;
    procedure DoCancel(DeleteOnInc : Boolean);
    procedure OnBeforeDoCancel; virtual;
    procedure OnAfterDoCancel; virtual;
    procedure OnBeforePrepare;
    procedure OnAfterCommit; virtual;
    procedure OnAfterRollBack; virtual;

    procedure OnBeforeStart; virtual;
    procedure OnBeforeShow; virtual;
    procedure OnAfterStart; virtual;
    procedure OnAfterUpdateNavegator; virtual;

    procedure SetParamBrowse; virtual;

  public
    { Public declarations }
    FchBrowse : TObject;  // Aponta para o browse da ficha
    sParam :  string;
    function  Start(pCommand  : TBtnCommandType;
                    brwQuery  : TPowerADOQuery;
                    IsLoopInc : Boolean;
                    var PosID1, PosID2 : String;
                    BrwGrid: TcxGrid) : Boolean;
  published
    property OnValidateFields: TOnValidadeFieldEvent read FOnValidadeFieldEvent write FOnValidadeFieldEvent;

  end;

implementation

{$R *.DFM}

uses xBase, uDM, PaideBrowses, uMsgBox, SuperComboADO, uParamFunctions,
     uSqlFunctions, uMsgConstant, uVarianteFunctions, uDataBaseFunctions,
     uHandleError, uDMGlobal, cxGridDBTableView, uWebFunctions;


procedure TbrwFrmParent.PushError(ErrorType: Integer; sError: String);
begin

   DM.SetError(ErrorType, Self.Name, sError);

end;

function  TbrwFrmParent.Start(pCommand  : TBtnCommandType;
                              brwQuery  : TPowerADOQuery;
                              IsLoopInc : Boolean;
                              var PosID1, PosID2 : String;
                              BrwGrid: TcxGrid) : Boolean;
var
  i     : integer;
begin
  inherited;

  Screen.Cursor := crHourGlass;

  // Seta variaveis globais
  frmCommand  := pCommand;
  IsPost      := False;
  bAnyPost    := False;
  MybrwQuery  := brwQuery;
  myGrid      := BrwGrid;
  InitCaption := DM.fMainMenu.SubMenuName;

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
        // Testa se brwQuery nao e nil, se nao for é sinal que o filtro veio dos parametros
        if (brwQuery <> nil) or (BrwGrid <> nil) then
          begin

           // Antonio 2014 Aug 25 ... testing this work around
           FieldKey1 := brwQuery.Fields[0].Value;
// just to debug           showmessage(format('key value in ancestor = %s', [fieldKey1]));
           SyncFichaToBrowse;
          end
        else
          begin
           if PosID1 <> '' then
             begin
              Parameters.Items[0].Value := ConvVariant(Parameters.Items[0].DataType, PosID1);
              if PosID2 <> '' then
                 Parameters.Items[1].Value := ConvVariant(Parameters.Items[1].DataType, PosID2);
              Open;
             end;
          end;
      end
  else
    begin
      ClearParam;
    end;

  btLoopInc.Down := IsLoopInc;
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


procedure TbrwFrmParent.OnBeforeStart;
begin
  // Para se hedado
end;

procedure TbrwFrmParent.OnAfterStart;
begin
  // Para se hedado
end;

procedure TbrwFrmParent.OnAfterUpdateNavegator;
begin
  // Para se hedado
end;
procedure TbrwFrmParent.OnBeforeShow;
begin
  // Para se hedado
end;

procedure TbrwFrmParent.dsFormStateChange(Sender: TObject);
begin
  inherited;

  lblModified.Visible := TestOnEditModes;
  //btClose.Enabled := TestOnEditModes;

  if TestOnEditModes then
     begin
     btCancel.Font.Style := [fsBold];
     btCancel.Caption    := sCancelButton;
     end;

end;

procedure TbrwFrmParent.FormShow(Sender: TObject);
begin
  inherited;

  ControlaPanels;

  case frmCommand of
     btInc    : begin
                  lblSubMenu.Caption := InitCaption;
                  NextAppend;
                end;
     btAlt    : begin
                  lblSubMenu.Caption := InitCaption;
                  SetaFocoInicial;
                end;
  end;

  // Teste de registro system e readonly
  if FormConfig.SystemReadOnly then
     if quForm.Active then
        if quForm.FieldByName('System').AsBoolean then
           lblSubMenu.Caption := lblSubMenu.Caption + '(R)';


  UpdateNavigation;

  btClose.Caption  := sSaveButton;

  Screen.Cursor := crDefault;

  if pnlNavigation.Visible then
     lblUserName.Left := pnlNavigation.Left + pnlNavigation.Width + 3;
end;

procedure TbrwFrmParent.NextAppend;
var
  MyField : TField;
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

  SetaFocoInicial;
end;

procedure TbrwFrmParent.ControlaPanels;
begin
  ControlaEdits(pnlKey, True, (frmCommand <> btInc) or FormConfig.IsAutoIncKey);
  if ((frmCommand <> btInc) and fIsRestricForm) then
     ControlaFormEdits(True, True);
end;

procedure TbrwFrmParent.ControlaFormEdits(ChangeColor, MyReadOnly : Boolean);
var
  i           : Integer;
  MyColor     : TColor;
begin
  if MyReadOnly then
     MyColor := clBtnFace
  else
     MyColor := clWindow;


  with quForm do
    for i:=0 to FieldCount-1 do
       Fields.Fields[i].ReadOnly := True;

  for i := 0 to (ComponentCount -1) do
      begin
      if Components[I] is TDBDateBox then
        begin
         if ChangeColor then
            TDateBox(Components[I]).Color := MyColor;
         TDateBox(Components[I]).ReadOnly := MyReadOnly;
        end
      else if Components[I] is TDbEdit then
        begin
         if ChangeColor then
            TDbEdit(Components[I]).Color := MyColor;
         TDbEdit(Components[I]).ReadOnly := MyReadOnly;
        end
      else if Components[I] is TDBGrid then
        begin
         TDBGrid(Components[I]).ReadOnly := MyReadOnly;
        end
      else if Components[I] is TButton then
        begin
         TButton(Components[I]).Enabled := MyReadOnly;
        end
      else if Components[I] is TSpeedButton then
        begin
         TSpeedButton(Components[I]).Enabled := MyReadOnly;
        end
      else if Components[I] is TDBCheckBox then
        begin
         TDBCheckBox(Components[I]).ReadOnly := MyReadOnly;
        end
      else if Components[I] is TCheckBox then
        begin
         TCheckBox(Components[I]).Enabled := MyReadOnly;
        end
      else if Components[I] is TDBRadioGroup then
        begin
         TDBRadioGroup(Components[I]).ReadOnly := MyReadOnly;
        end
      else if Components[I] is TRadioGroup then
        begin
         TRadioGroup(Components[I]).Enabled := MyReadOnly;
        end
      else if Components[I] is TDBListBox then
        begin
         TDBListBox(Components[I]).ReadOnly := MyReadOnly;
        end
      else if Components[I] is TDBRichEdit then
        begin
         if ChangeColor then
            TDBRichEdit(Components[I]).Color := MyColor;
         TDBRichEdit(Components[I]).ReadOnly  := MyReadOnly;
        end
      else if Components[I] is TSuperComboADO then
        begin
         if ChangeColor then
            TSuperComboADO(Components[I]).Color := MyColor;
         TSuperComboADO(Components[I]).ReadOnly := MyReadOnly;
        end
      else if Components[I] is TDBSuperComboADO then
        begin
         if ChangeColor then
            TDBSuperComboADO(Components[I]).Color := MyColor;
         TDBSuperComboADO(Components[I]).ReadOnly  := MyReadOnly;
         TDBSuperComboADO(Components[I]).TabStop   := MyReadOnly;
        end
     end;

  btClose.Enabled := False;
end;

procedure TbrwFrmParent.ControlaEdits(MyPanel : TPanel; ChangeColor, MyReadOnly : Boolean);
var
  i           : Integer;
  MyColor     : TColor;
begin
  if MyReadOnly then
     MyColor := clBtnFace
  else
     MyColor := clWindow;

  with MyPanel do
   begin
    for i := 0 to (ControlCount -1) do
     begin
      if Controls[I].Tag = 0 then
        begin
          if Controls[I] is TDBDateBox then
            begin
             if ChangeColor then
                TDateBox(Controls[I]).Color    := MyColor;
             TDateBox(Controls[I]).ReadOnly := MyReadOnly;
            end
          else if Controls[I] is TDbEdit then
            begin
             if ChangeColor then
                TDbEdit(Controls[I]).Color     := MyColor;
             TDbEdit(Controls[I]).ReadOnly  := MyReadOnly;
            end
{
          else if Controls[I] is TDBSuperComboADO then
            begin
             if ChangeColor then
                TDBSuperComboADO(Controls[I]).Color     := MyColor;
             TDBSuperComboADO(Controls[I]).ReadOnly  := MyReadOnly;
            end
}
          else if Controls[I] is TDBGrid then
            begin
             TDBGrid(Controls[I]).ReadOnly  := MyReadOnly;
            end
          else if Controls[I] is TDBCheckBox then
            begin
             TDBCheckBox(Controls[I]).ReadOnly  := MyReadOnly;
            end
          else if Controls[I] is TDBRadioGroup then
            begin
             TDBRadioGroup(Controls[I]).ReadOnly  := MyReadOnly;
            end
          else if Controls[I] is TDBListBox then
            begin
             TDBListBox(Controls[I]).ReadOnly  := MyReadOnly;
            end
          else if Controls[I] is TDBRichEdit then
            begin
             if ChangeColor then
                TDBRichEdit(Controls[I]).Color    := MyColor;
             TDBRichEdit(Controls[I]).ReadOnly  := MyReadOnly;
            end
          else if Controls[I] is TSuperComboADO then
            begin
             if ChangeColor then
                TSuperComboADO(Controls[I]).Color     := MyColor;
             TSuperComboADO(Controls[I]).ReadOnly  := MyReadOnly;
            end
        end;
     end;
   end;

end;

procedure TbrwFrmParent.SetaFocoInicial;
var
  i : Integer;
begin
 { Percorre o master Box e verifica se FormConfig.IsAutoIncKey,
   para poder setar o foco, seta o Edit com TabOrder = 0 e Tag = 0}

 if (frmCommand = btInc) and not FormConfig.IsAutoIncKey then
    ActiveControl := TWinControl(GetEditIni(pnlKey))
 else
    with pnlDetail do
     for i := 0 to (ControlCount - 1) do
       if (Controls[i] is TCustomEdit) and
          (TCustomEdit(Controls[i]).TabOrder = 0) and TCustomEdit(Controls[i]).Enabled then
         begin
          if TWinControl(Controls[i]).Visible then
             ActiveControl := TWinControl(Controls[i]);
          Break;
         end;

end;

function TbrwFrmParent.GetEditIni(MyPanel : TPanel) : TCustomEdit;
var
  i : Integer;
begin
  with MyPanel do
    for i := 0 to (ControlCount -1) do
      if (Controls[I] is TCustomEdit) and
         ((Controls[I] as TCustomEdit).Tag = 0) then
        begin
          Result := (Controls[I] as TCustomEdit);
          Break;
        end;
end;

procedure TbrwFrmParent.btCloseClick(Sender: TObject);
begin
  inherited;

  ModalResult := mrNone;

  with quForm do

   if TestOnEditModes then
     begin
       if quForm.State in dsEditModes then
          quForm.UpdateRecord; // Force pending updates

       if not (OnValidadeField and TestFieldFill and TestFieldUnique) then
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

       RefreshBrowse;
     end;

  if (frmCommand <> btInc) then
     ModalResult := mrOK
  else
     if btLoopInc.Down then
        NextAppend
     else
        ModalResult := mrOK;
end;

function TbrwFrmParent.SaveHighChange: Boolean;
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


function TbrwFrmParent.BeforeChange : boolean;
begin
  // funcao para ser herdada
  Result := True;
end;

function TbrwFrmParent.TestOnEditModes : boolean;
begin
  Result := quForm.State in dsEditModes;
end;

function TbrwFrmParent.DoPost: boolean;
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

function TbrwFrmParent.SaveChange : boolean;
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

procedure TbrwFrmParent.btCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TbrwFrmParent.FormCreate(Sender: TObject);
var
  MySqlStatement : TSQlStatement;
  MyFieldDef     : TFieldDef;
  //MyDateType     : Array  [1..5] of TDataType;
  i : integer;
  IsSystem : Boolean;
begin
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

  //Right Menu display
  flbMenuIniPos := 50;

end;

procedure TbrwFrmParent.FormDestroy(Sender: TObject);
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

procedure TbrwFrmParent.quFormPostError(DataSet: TDataSet;
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
    MsgBox(SetFieldFocus(strField) + ' ' + RetMessage, vbOKOnly + vbInformation);
  end
  else
    { erro desconhecido }
    Action  := daFail;
end;

procedure TbrwFrmParent.RefreshBrowse;
begin
  if FchBrowse <> nil then
  begin
    if FieldKey2 = '' then
      TbrwParent(FchBrowse).RefreshOnUpdate(FieldKey1, FieldKey2, quForm.Parameters.Items[0].Name, '')
    else
      TbrwParent(FchBrowse).RefreshOnUpdate(FieldKey1, FieldKey2, quForm.Parameters.Items[0].Name, quForm.Parameters.Items[1].Name);
  end;
end;

procedure TbrwFrmParent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DoCancel((ModalResult = mrCancel));
end;

procedure TbrwFrmParent.FormCloseQuery(Sender: TObject;
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

procedure TbrwFrmParent.DoCancel(DeleteOnInc : Boolean);
var
  i: Integer;
  sValue: String;

  NomeTabela, ValorCampo: String;
begin
  try
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

      OnBeforeDoCancel;

      for i := 0 to FormConfig.DependentTables.Count -1 do
        with DM.quFreeSQL do
        begin
          if Active then
            Close;

          if ( quform.parameters.Items[0].Value <> null ) then begin
              svalue := quForm.Parameters.Items[0].Value;
              sValue :=  quForm.Parameters.Items[0].Value;
              SQl.Text := 'DELETE FROM ' + FormConfig.DependentTables.Strings[i] +
              ' WHERE ' + FormConfig.DependentTableKeys.Strings[i] + ' = ' + sValue;
              ExecSQL;
          end else begin
                   sValue := '';
              end;

 //         sValue :=  quForm.Parameters.Items[0].Value;
 //         SQl.Text := 'DELETE FROM ' + FormConfig.DependentTables.Strings[i] +
 //                     ' WHERE ' + FormConfig.DependentTableKeys.Strings[i] + ' = ' + sValue;
 //         ExecSQL;
        end;

        (*  Carlos Lima - 20/06/2006 - Inicio *)
        with TADOQuery.Create(nil) do
        try
          Connection := DM.quFreeSQL.Connection;
          if Active then
            Close;

//          sValue := quForm.Parameters.Items[0].Value;

          if ( sValue <> '' ) then begin
              SQl.Text := 'DELETE FROM ' + GetSQLFirstTableName(quForm.CommandText) +
                          ' WHERE ' + quForm.Parameters.Items[0].Name + ' = ' + sValue;
              ExecSQL;
          end;
        finally
          Free;
        end;

      //if not quForm.IsEmpty then
      //  quForm.Delete;

      (*  Carlos Lima - 20/06/2006 - Fim *)

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

procedure TbrwFrmParent.CancelUpdates;
begin
  quForm.Cancel;
end;

procedure TbrwFrmParent.UpdateNavigation;
begin
  // Testes para ver se esta no primeiro ou ultimo registro
  if ((MybrwQuery = nil) and (MyGrid = nil)) or (frmCommand = btInc) then
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
       btPriorRec.Enabled := not Bof;
       btFirstRec.Enabled := btPriorRec.Enabled;

       btNextRec.Enabled := not Eof;
       btLastRec.Enabled := btNextRec.Enabled;
       end;
    end
 else
    begin
      if TcxCustomGridTableView(myGrid.FocusedView).Controller.FocusedRecord <> nil then
        begin
          btPriorRec.Enabled := (TcxCustomGridTableView(myGrid.FocusedView).Controller.FocusedRecord.Index <> 0);
          btFirstRec.Enabled := btPriorRec.Enabled;

          btNextRec.Enabled := not TcxCustomGridTableView(myGrid.FocusedView).Controller.FocusedRecord.IsLast;
          btLastRec.Enabled := btNextRec.Enabled;
        end;
    end;

  OnAfterUpdateNavegator;
    
end;


procedure TbrwFrmParent.btLastRecClick(Sender: TObject);
var
 iPos : Integer;
begin
  inherited;
  // Testa edicao, e depois muda a ficha
  TestBeforeNavigate;

  if Assigned(myGrid) then
    begin
    iPos := (TcxCustomGridTableView(myGrid.FocusedView).ViewData.RecordCount-1);
    TcxCustomGridTableView(myGrid.FocusedView).ViewData.Records[iPos].Focused := True;
    end
  else
    MyBrwQuery.Last;

  SyncFichaToBrowse;
end;

procedure TbrwFrmParent.TestBeforeNavigate;
begin
  with quForm do
    begin
      if (state in dsEditModes) or (frmCommand = btInc) then
        begin
          if (not FormConfig.ConfirmPost) or (MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbYesNo + vbQuestion) = vbYes) then
            begin
             UpdateRecord; // Force pending updates
             SaveHighChange;
            end
          else
            DoCancel(True);

          frmCommand := btAlt;
        end;
    end;
end;

procedure TbrwFrmParent.SetParamBrowse;
var
  i, index : integer;
begin
  //navego sempre pelo quBrowser
  if not MybrwQuery.IsEmpty then
     with quForm do
        if not (MybrwQuery.Eof and MybrwQuery.Bof) then
           for i := 0 to Parameters.Count-1 do begin
//              myBrwQuery.Parameters[i].Value := myBrwQuery.Fields[i].Value;

               // Antonio Marcos, July 31, 2013 - work around parameter
               if ( trim(parameters[0].Name) <> myBrwQuery.fields[i].fieldName ) then begin
                  if ( (trim(parameters[0].Name) = 'IDModel') and (myBrwQuery.fields[i].fieldName = 'Model') ) then begin
                     parameters[0].value := myBrwQuery.fields[1].Value;
                  end;
               end
               else begin
               	Parameters[0].Value := MybrwQuery.Fields[i].Value;
               end;
           end;

  // Se foi passado o grid, navego pelo grid, senão pela query
{  if Assigned(myGrid) AND
     (TcxCustomGridTableView(myGrid.FocusedView).Controller.SelectedRecordCount>0) AND
     (quForm.Parameters.Count = 1) then
    with myGrid do
      begin
        //ShowMessage(IntToStr(TcxCustomGridTableView(myGrid.FocusedView).Controller.FocusedRecord.Values[0]));
        quForm.Parameters.Items[0].Value :=
           TcxCustomGridTableView(myGrid.FocusedView).Controller.FocusedRecord.Values[0]
      end
  else if not MybrwQuery.IsEmpty then
     with quForm do
        begin
        if not (MybrwQuery.Eof and MybrwQuery.Bof) then
           for i := 0 to Parameters.Count-1 do
               Parameters[i].Value := MybrwQuery.FieldByName(Parameters[i].Name).Value;
        end;}

end;

procedure TbrwFrmParent.SyncFichaToBrowse;
begin

  try
    quForm.Close;
    SetParamBrowse;
    quForm.Open;
    UpdateNavigation;
  except
    on E: Exception do
      begin
        PushError(CRITICAL_ERROR, 'TbrwFrmParent.SyncFichaToBrowse' + #13#10 + E.Message);
        MsgBox( 'Error:' + E.Message, vbCritical + vbOkOnly);
        FOpenError := E.Message;
        OnSyncFichaToBrowseError;
      end;
  end;

end;

procedure TbrwFrmParent.btNextRecClick(Sender: TObject);
Var
  iPos : Integer;
begin
  inherited;
  TestBeforeNavigate;
  
  if Assigned(myGrid) then
    begin
    iPos := TcxCustomGridTableView(myGrid.FocusedView).Controller.FocusedRecord.Index+1;
    TcxCustomGridTableView(myGrid.FocusedView).ViewData.Records[iPos].Focused := True;
    end
  else
    MyBrwQuery.Next;

  SyncFichaToBrowse;
end;

procedure TbrwFrmParent.btPriorRecClick(Sender: TObject);
var
  iPos : Integer;
begin
  inherited;
  TestBeforeNavigate;

  if Assigned(myGrid) then
    begin
    iPos := TcxCustomGridTableView(myGrid.FocusedView).Controller.FocusedRecord.Index-1;
    TcxCustomGridTableView(myGrid.FocusedView).ViewData.Records[iPos].Focused := True;
    end
  else
    MyBrwQuery.Prior;

  SyncFichaToBrowse;
end;

procedure TbrwFrmParent.btFirstRecClick(Sender: TObject);
begin
  inherited;
  TestBeforeNavigate;
  if Assigned(myGrid) then
    begin
    TcxCustomGridTableView(myGrid.FocusedView).ViewData.Records[0].Focused := True;
    end
  else
    MyBrwQuery.First;

  SyncFichaToBrowse;
end;


function TbrwFrmParent.OnAfterSaveChange(var iError:Integer):Boolean;
begin
  // Somente para ser herdado
  Result := True;

end;

procedure TbrwFrmParent.OnBeforePrepare;
begin
  // Somente para ser herdado
end;

function TbrwFrmParent.OnValidadeField: boolean;
begin
  // Somente para ser herdado
  Result := True;
end;

procedure TbrwFrmParent.OnAfterCommit;
begin
  // Somente para ser herdado
end;

procedure TbrwFrmParent.OnAfterRollBack;
begin
  // Somente para ser herdado
end;

procedure TbrwFrmParent.OnBeforeDoCancel;
begin
  // Somente para ser herdado
end;

procedure TbrwFrmParent.OnAfterDoCancel;
begin
  // Somente para ser herdado
end;

function TbrwFrmParent.TestFieldFill: boolean;
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
        if Fields[i].Required and (Trim(Fields[i].AsString) = '') and Result then
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

procedure TbrwFrmParent.ClearParam;
var
  i: integer;
begin
  with quForm do
    begin
    for i := 0 to ParamCount-1 do
      Parameters.Items[i].Value := Null;
    end;
end;


procedure TbrwFrmParent.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  btCancel.Caption := sCloseButton;
  btCancel.Font.Style := [];

end;

function TbrwFrmParent.TestFieldUnique: boolean;
var
  sTableName: String;
  slFields: TStringList;
  i, j: integer;
  sMsgBox, sSQL, sWhere: String;
  fCurrentField: TField;
begin

  slFields := TStringList.Create;

  try

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

  Finally
    slFields.Free;
    end;

end;

procedure TbrwFrmParent.spHelpClick(Sender: TObject);
begin
  inherited;

  if sUrlHelp <> '' then
    OpenURL(sUrlHelp);
    
end;

procedure TbrwFrmParent.btnVideoClick(Sender: TObject);
begin
  inherited;

  if sUrlVideo <> '' then
    OpenURL(sUrlVideo);

end;

function TbrwFrmParent.OnSyncFichaToBrowseError:String;
begin
  Result := FOpenError;
end;

end.
