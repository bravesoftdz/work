unit DBLinkGrade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, SuperComboADO, dbtables, dbctrls, ADODb;

type
  TDBLinkGrade = class(TComponent)
  private
    { Private declarations }
    FquFreeSQL, FquConstante : TADOQuery;
    FDataLink: TFieldDataLink;
    FIDItemGrade, FIDMercadoria : integer;
    FcmbMercadoria, FcmbCor, FcmbTamanho : TSuperComboADO;
    IDCorUnica, IDTamanhoUnico, OldValue : integer;
    procedure ChangeIDItemGrade;
    procedure TestSelCombo;
    procedure OnSelectMrc(Sender : TObject);
    procedure OnSelectCor(Sender : TObject);
    procedure OnSelectTam(Sender : TObject);
    procedure SetCor(IDCor : Integer);
    procedure SetTamanho(IDTamanho : Integer);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function  GetDataField: string;
    function  GetDataSource: TDataSource;
    procedure SetDataField(const Value: string);
    procedure SetcmbMercadoria(Value: TSuperComboADO);
    procedure SetcmbCor(Value: TSuperComboADO);
    procedure SetcmbTamanho(Value: TSuperComboADO);
    procedure SetquConstante(Value: TADOQuery);
    procedure SetDataSource(Value: TDataSource);
    procedure SetIDMercadoria(Value: Integer);
    procedure SetIDItemGrade(Value: Integer);
    function  GetIDItemGrade : Integer;
  protected
    { Protected declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    { Public declarations }
    property IDItemGrade  : Integer read FIDItemGrade   write SetIDItemGrade;
    property IDMercadoria : Integer read FIDMercadoria  write SetIDMercadoria;
  published
    { Published declarations }
    property DataField     : string read GetDataField write SetDataField;
    property DataSource    : TDataSource read GetDataSource write SetDataSource;
    property cmbMercadoria : TSuperComboADO read FcmbMercadoria write SetcmbMercadoria;
    property cmbCor        : TSuperComboADO read FcmbCor write SetcmbCor;
    property cmbTamanho    : TSuperComboADO read FcmbTamanho write SetcmbTamanho;
    property quFreeSQL     : TADOQuery      read FquFreeSQL  write FquFreeSQL;
    property quConstante   : TADOQuery      read FquConstante write SetquConstante;
  end;

procedure Register;

implementation

uses uNumericFunctions;

procedure Register;
begin
  RegisterComponents('NewPower', [TDBLinkGrade]);
end;

constructor TDBLinkGrade.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;

  // Inicializa a grade zerada
  FIDItemGrade   := 0;
end;

destructor TDBLinkGrade.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TDBLinkGrade.SetquConstante(Value: TADOQuery);
begin
  FquConstante := Value;

  if not (csDesigning in ComponentState) then
    begin
      // Seta os eventos de troca de mrc, cor, tamanho
      if Assigned(quConstante) then
        begin
          with FquConstante do
            begin
              if not Active then Open;

              if Locate('Constante', 'Cor_CorUnica', []) then
                 IDCorUnica := FieldByName('Valor').AsInteger
              else
                 raise exception.create('Cor Unica nao foi encontrada');

              if Locate('Constante', 'Tamanho_TamanhoUnico', []) then
                 IDTamanhoUnico := FieldByName('Valor').AsInteger
              else
                 raise exception.create('Tamanho Unico nao foi encontrado');
            end;
        end
      else
        raise exception.Create('quConstante não foi selecionado');
    end;
end;

procedure TDBLinkGrade.SetcmbMercadoria(Value: TSuperComboADO);
begin
  FCmbMercadoria := Value;

  if not (csDesigning in ComponentState) then
    begin
      // Seta os eventos de troca de mrc, cor, tamanho
      if Assigned(cmbMercadoria) then
        begin
          cmbMercadoria.OnBeforeSelectItem := OnSelectMrc;
        end
      else
        raise exception.Create('Combo de Mercadoria não foi selecionado');
    end;
end;

procedure TDBLinkGrade.SetcmbCor(Value: TSuperComboADO);
begin
  FCmbCor := Value;

  if not (csDesigning in ComponentState) then
    begin
      // Seta os eventos de troca de mrc, cor, tamanho
      if Assigned(cmbCor) then
        begin
          cmbCor.OnBeforeSelectItem := OnSelectCor;
        end
      else
        raise exception.Create('Combo de Cor não foi selecionado');
    end;
end;

procedure TDBLinkGrade.SetcmbTamanho(Value: TSuperComboADO);
begin
  FCmbTamanho := Value;

  if not (csDesigning in ComponentState) then
    begin
      // Seta os eventos de troca de mrc, cor, tamanho
      if Assigned(cmbTamanho) then
        begin
          cmbTamanho.OnBeforeSelectItem := OnSelectTam;
        end
      else
        raise exception.Create('Combo de Tamanho não foi selecionado');
    end;
end;

function TDBLinkGrade.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBLinkGrade.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TDBLinkGrade.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TDBLinkGrade.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TDBLinkGrade.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
     (AComponent = DataSource) then DataSource := nil;
end;

procedure TDBLinkGrade.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
     IDItemGrade := FDataLink.Field.AsInteger;
end;

procedure TDBLinkGrade.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TDBLinkGrade.UpdateData(Sender: TObject);
begin
  // Associa o valor ao field
  if Assigned(DataSource) then
    begin
      FDataLink.Edit; // Forca o edit state;
      FDataLink.Field.AsInteger := IDItemGrade;
    end;
end;

procedure TDBLinkGrade.SetIDItemGrade(Value: Integer);
begin
  // Seta os valores da Cor e Tamanho respectivos a um determinado ItemGrade
  // Testa se valor esta zerado, grade vazia
  if Value = 0 then
    begin
      SetCor(0);
      SetTamanho(0);
    end
  else
    begin
      // Descobre o IDCor e IDTamanho do ItemGrade
      if Value <> OldValue then
        begin
          OldValue     := Value;
          FIDItemGrade := Value;
          with FquFreeSQL do
            begin
              SQL.Text := 'SELECT IDCor, IDTamanho FROM Est_GradeItem WHERE IDItemGrade = ' +
                          IntToStr(Value);
              Open;
              if not (Eof and Bof) then
                begin
                  SetCor(FieldByName('IDCor').AsInteger);
                  SetTamanho(FieldByName('IDTamanho').AsInteger);
                end;
              Close;
            end;
        end;
    end;
end;

procedure TDBLinkGrade.SetCor(IDCor : Integer);
begin
  TestSelCombo;

  if (IDCor = 0) or (IDCorUnica = IDCor) then
    begin
      if cmbCor.Visible then
        begin
          if IDCor = 0 then
            cmbCor.LookUpValue     := ''
          else
            cmbCor.LookUpValue     := IntToStr(IDCorUnica);
        end;

      cmbCor.Enabled         := False;
      cmbCor.Color           := clBtnFace;
    end
  else
    begin
      cmbCor.LookUpValue     := IntToStr(IDCor);
      cmbCor.Enabled         := True;
      cmbCor.Color           := clWindow;
    end;
end;

procedure TDBLinkGrade.SetTamanho(IDTamanho : Integer);
begin
  TestSelCombo;

  if (IDTamanho = 0) or (IDTamanhoUnico = IDTamanho) then
    begin
      if cmbTamanho.Visible then
        begin
          if IDTamanho = 0 then
            cmbTamanho.LookUpValue := ''
          else
            cmbTamanho.LookUpValue := IntToStr(IDTamanhoUnico);
        end;

      cmbTamanho.Enabled         := False;
      cmbTamanho.Color           := clBtnFace;
    end
  else
    begin
      cmbTamanho.LookUpValue     := IntToStr(IDTamanho);
      cmbTamanho.Enabled         := True;
      cmbTamanho.Color           := clWindow;
    end;
end;

procedure TDBLinkGrade.SetIDMercadoria(Value: Integer);
begin
  if Assigned(cmbMercadoria) then
    begin
      cmbMercadoria.LookUpValue := IntToStr(Value);
      FIDMercadoria := Value;
    end
  else
    begin
      FIDMercadoria := Value;
    end;

  // Filtra Cores e Tamanhos da Mercadoria

  if FIDMercadoria = 0 then
    begin
     SetCor(0);
     SetTamanho(0);
     Exit;
    end;

  with FquFreeSQL do
    begin
      SQL.Text := 'SELECT Est_Mercadoria.IDGrade , CorUnica , TamanhoUnico ' +
                  'FROM dbo.Est_Mercadoria, dbo.Est_Grade Est_Grade        ' +
                  'WHERE Est_Mercadoria.IDGrade = Est_Grade.IDGrade   AND  ' +
                  'Est_Mercadoria.IDMercadoria  = ' + IntToStr(FIDMercadoria);
      Open;

      // Filtra os combos de cor e tamanho pela grade da mercadoria
      cmbCor.LookUpValue := '';
      cmbCor.AddFilter(['IDGrade'], [FieldByName('IDGrade').AsString]);

      cmbTamanho.LookUpValue := '';
      cmbTamanho.AddFilter(['IDGrade'], [FieldByName('IDGrade').AsString]);

      // Controla o Aparecimento do combo de cor
      if FieldByName('CorUnica').AsBoolean then
        begin
          SetCor(IDCorUnica);
        end
      else
        begin
          cmbCor.Enabled := True;
          cmbCor.Color   := clWindow;
        end;

      // Controla o Aparecimento do combo de tamanho
      if FieldByName('TamanhoUnico').AsBoolean then
        begin
          SetTamanho(IDTamanhoUnico);
        end
      else
        begin
          cmbTamanho.Enabled := True;
          cmbTamanho.Color   := clWindow;
        end;

      ChangeIDItemGrade;

      Close;
    end;
end;

procedure TDBLinkGrade.OnSelectMrc(Sender : TObject);
begin
  TestSelCombo;

  if not Assigned(cmbMercadoria) then
     raise exception.Create('Combo de Mercadoria não foi selecionado');

  IDMercadoria := MyStrToInt(cmbMercadoria.LookUpValue);
end;

procedure TDBLinkGrade.OnSelectCor(Sender : TObject);
begin
  // Modifica o ItemGrade para a Nova Cor e Tamanho
  ChangeIDItemGrade;
end;

procedure TDBLinkGrade.OnSelectTam(Sender : TObject);
begin
  // Modifica o ItemGrade para a Nova Cor e Tamaho
  ChangeIDItemGrade;
end;

function TDBLinkGrade.GetIDItemGrade : Integer;
begin
  // Descobre o IDItemGrade, dado uma determinada Cor, Tamanho e Grade
  TestSelCombo;

  Result := 0;
  with FquFreeSQL do
    begin
      if (cmbCor.LookUpValue     <>  '') and
         (cmbTamanho.LookUpValue <>  '') then
        begin
          SQL.Text := 'SELECT IDItemGrade FROM Est_GradeItem    ' +
                      'WHERE IDCor = ' + cmbCor.LookUpValue   + ' AND ' +
                      'IDTamanho = ' + cmbTamanho.LookUpValue + ' AND ' +
                      'IDGrade   = ' + cmbCor.FilterValues[0];
          Open;
          if not (Eof and Bof) then
             Result := FieldByName('IDItemGrade').AsInteger;
          Close;
        end
    end;
end;

procedure TDBLinkGrade.ChangeIDItemGrade;
begin
  FIDItemGrade := GetIDItemGrade;
  UpdateData(nil);
end;

procedure TDBLinkGrade.TestSelCombo;
begin
  if not Assigned(cmbCor) then
     raise exception.Create('Combo de Cor não foi selecionado');

  if not Assigned(cmbTamanho) then
     raise exception.Create('Combo de Tamanho não foi selecionado');
end;


end.
