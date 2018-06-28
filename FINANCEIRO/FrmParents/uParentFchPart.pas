unit uParentFchPart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFch, FormConfig, Db, DBTables, 
  StdCtrls, Buttons,  ExtCtrls, FormPartConfig, 
  ComCtrls, dxBar, ImgList, ADODB, PowerADOQuery;

type
  TParentFchPart = class(TParentFch)
    quFormPart: TPowerADOQuery;
    dsFormPart: TDataSource;
    FormPartConfig: TFormPartConfig;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure SetaCodigoAutoNum; override;
    function NextAppend:Boolean; override;
    procedure CancelUpdates; override;
    procedure FchUpdateRecord; override;
    procedure SetDefaultFields; override;
    procedure OpenDataSets; override;
    procedure CloseDataSets; override;
    procedure SetParamSpecial; override;
    procedure SetParamBrowse; override;
    function  SaveChange : boolean; override;
    function  TestOnEditModes  : boolean; override;
    procedure DoCancel(DeleteOnInc : Boolean); override;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uDM;

procedure TParentFchPart.SetaCodigoAutoNum;
begin
  // Iqual ao pai, so que usa a tabela particionada para gerar o Proximo Codigo
  SetaCodigoAutoNumSub(GetSQLFirstTableName(quFormPart.CommandText), GetSQLFirstTableName(quForm.CommandText), FormPartConfig.PrefixoCodigo);

end;

procedure TParentFchPart.SetParamSpecial;
begin
  inherited SetParamSpecial;

  with quFormPart do
   begin
     if MyPosID1 <> '' then
       begin
         Parameters[0].Value := ConvVariant(Parameters[0].DataType, MyPosID1);
         if MyPosID2 <> '' then
           Parameters[1].Value := ConvVariant(Parameters[1].DataType, MyPosID2);
       end;
   end;
end;

procedure TParentFchPart.SetParamBrowse;
var
  i : integer;
begin
  inherited SetParamBrowse;

  with quFormPart do
    begin
      if not (MybrwQuery.Eof and MybrwQuery.Bof) then
        begin
          for i := 0 to ParamCount-1 do
            begin
              if MybrwQuery.FindField(Parameters.Items[i].Name) <> nil then
                begin
                  Parameters[i].Value := MybrwQuery.FieldByName(Parameters.Items[i].Name).Value;
                  // Seta os parametros do quForm igual ao da particao
                  quForm.Parameters[i].Value := Parameters[i].Value;
                end;
            end;
        end;
    end;
end;

procedure TParentFchPart.SetDefaultFields;
begin
  inherited SetDefaultFields;
  // Seta os filtros da particao
  SetFilterFields(quFormPart);
end;

function TParentFchPart.TestOnEditModes : boolean;
begin
  Result := inherited TestOnEditModes;
  Result := Result or (quFormPart.State in dsEditModes);
end;

procedure TParentFchPart.FormShow(Sender: TObject);
begin
  if not quFormPart.Active then quFormPart.Open;
  inherited;
end;

function TParentFchPart.NextAppend:Boolean;
var
  i       : integer;
  strLastKey : String;
begin
  inherited NextAppend;

  quFormPart.Append;
  if FormPartConfig.PostOnInsert and FormConfig.PostOnInsert then
    begin
     NotNullFields.Clear;

     with quFormPart do
      begin
        for i := 0 to FormPartConfig.RequiredFields.Count - 1 do
          begin
            if FieldByName(FormPartConfig.RequiredFields.Strings[i]).IsNull then
               case FieldByName(FormPartConfig.RequiredFields.Strings[i]).DataType of

                    ftString,
                    ftMemo      : FieldByName(FormPartConfig.RequiredFields.Strings[i]).AsString   := strLastKey;

                    ftDateTime,
                    ftDate      : FieldByName(FormPartConfig.RequiredFields.Strings[i]).AsDateTime := Now;

                    ftInteger   : FieldByName(FormPartConfig.RequiredFields.Strings[i]).AsInteger  := 0;

                    ftFloat     : FieldByName(FormPartConfig.RequiredFields.Strings[i]).AsFloat    := 0;

                    ftBoolean   : FieldByName(FormPartConfig.RequiredFields.Strings[i]).AsBoolean  := False;
               end
            else
               begin
                 NotNullFields.Add(FormPartConfig.RequiredFields.Strings[i]);
               end;
          end;

        FieldByName(Parameters[0].Name).Value     := quForm.Parameters[0].Value;
        Post;

        Close;
        Parameters[0].Value := quForm.Parameters[0].Value;
        Open;
        Edit;

        // Reseta os campos que sao required
        if FormPartConfig.RequiredFields.Count > 0 then
          begin
           for i := 0 to FormPartConfig.RequiredFields.Count - 1 do
               if NotNullFields.IndexOf(FormPartConfig.RequiredFields.Strings[i]) = -1 then
                  FieldByName(FormPartConfig.RequiredFields.Strings[i]).Clear;
          end;
      end;
    end;
end;

procedure TParentFchPart.CancelUpdates;
begin
  inherited CancelUpdates;
  if quFormPart.State in dsEditModes then
     quFormPart.Cancel;
end;

procedure TParentFchPart.FchUpdateRecord;
begin
  inherited FchUpdateRecord;
  if quFormPart.State in dsEditModes then
     quFormPart.UpdateRecord; // Force pending updates
end;

function TParentFchPart.SaveChange : boolean;
var
  i : integer;
begin
  Result := inherited SaveChange;

  // Salva os valores da chave para identity
  if (frmCommand = btInc) then
    begin
      // Inclusao
      if FormConfig.IsAutoIncKey then
        begin
          if FormConfig.PostOnInsert then
            quFormPart.FieldByName(quFormPart.Parameters[0].Name).Value := quForm.Parameters[0].Value
          else
            quFormPart.FieldByName(quFormPart.Parameters[0].Name).Value := DM.GetLastKey;
        end;

      if quForm.Parameters.Count > 1 then
        quFormPart.FieldByName(quFormPart.Parameters[1].Name).Value := quForm.FieldByName(quForm.Parameters[1].Name).Value;
    end;

  if quFormPart.State in dsEditModes then
     quFormPart.Post;
end;

procedure TParentFchPart.OpenDataSets;
begin
  inherited OpenDataSets;
  quFormPart.Open;
end;

procedure TParentFchPart.CloseDataSets;
begin
  inherited CloseDataSets;
  with quFormPart do
    if Active then Close;
end;

procedure TParentFchPart.DoCancel(DeleteOnInc : Boolean);
var
  i : integer;
begin
  CancelUpdates;

  // Deleta o incluido e que nao foi aceito
  if (frmCommand = btInc) and DeleteOnInc and
     (FormConfig.IsAutoIncKey) and (FormPartConfig.PostOnInsert) then
    begin
      try
        DM.DBADOConnection.BeginTrans;
        for i := 0 to FormPartConfig.DependentTables.Count -1 do
          with DM.quFreeSQL do
            begin
               SQl.Text := 'DELETE FROM ' + FormPartConfig.DependentTables.Strings[i] +
                           ' WHERE ' + FormPartConfig.DependentTableKeys.Strings[i] + ' = ' + quForm.Parameters[0].Value;
               ExecSQL;
            end;
        quFormPart.Delete;
        DM.DBADOConnection.CommitTrans;
      except
        DM.DBADOConnection.RollBackTrans;
      end;
    end;

  inherited DoCancel(DeleteOnInc);
end;


end.
