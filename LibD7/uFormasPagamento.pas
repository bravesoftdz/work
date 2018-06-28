unit uFormasPagamento;

interface

uses
  SysUtils, Classes;

type
  TTipoPagamento = class;

  TMeioPagamento = class
    public
      IDMeioPag: Integer;
      TipoPagamento : TTipoPagamento;
      Imagem: Integer;
      CodFiscal,
      DescFiscal,
      MeioPag : String;
      RequireCustomer : Boolean;
      ValidateNonpayer : Boolean;
      constructor Create(ATipoPagamento : TTipoPagamento);
      destructor Destroy;override;
  end;


  TTipoPagamento = class
    private
      function GetMeiosPagamento(Index: Integer): TMeioPagamento;
      procedure Remove(Index: Integer);
      procedure SetMeiosPagamento(Index: Integer;
        const Value: TMeioPagamento);
      function GetCount: Integer;
    public
      Tipo: Integer;
      Descricao: String;

      FItems: TList;

      property Count: Integer read GetCount;
      property MeiosPagamento[Index: Integer]: TMeioPagamento read GetMeiosPagamento write SetMeiosPagamento;

      constructor Create;
      destructor Destroy;override;
      procedure Clear;


      function Add(AIDMeioPag, AImagem: Integer; ACodFiscal, ADescFiscal, AMeioPag : String;
        ARequireCustomer: Boolean; AValidateNonpayer: Boolean): TMeioPagamento;
  end;


  TFormasPagamento = class(TComponent)
    private
      FItems: TList;
      function GetTiposPagamento(Index: Integer): TTipoPagamento;
      procedure SetTiposPagamento(Index: Integer;
        const Value: TTipoPagamento);
      procedure Remove(Index: Integer);
      function GetCount: Integer;
    public

      property TiposPagamento[Index: Integer]: TTipoPagamento read GetTiposPagamento write SetTiposPagamento;
      property Count: Integer read GetCount;

      constructor Create(AOwner: TComponent);override;
      destructor Destroy;override;

      procedure Clear;

      function Add(ATipo: Integer; ADescricao: String): TTipoPagamento;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TFormasPagamento]);
end;

{ TTipoPagamento }

constructor TTipoPagamento.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

destructor TTipoPagamento.Destroy;
begin

  inherited Destroy;
end;

function TTipoPagamento.GetMeiosPagamento(Index: Integer): TMeioPagamento;
begin
  result := FItems[Index];
end;

procedure TTipoPagamento.Remove(Index: Integer);
var
  MeioPagamento: TMeioPagamento;
begin
  MeioPagamento := FItems[Index];
  FreeAndNil(MeioPagamento);
  FItems.Delete(Index);
end;

procedure TTipoPagamento.Clear;
begin
  while FItems.Count > 0 do
    Remove(0);
end;

procedure TTipoPagamento.SetMeiosPagamento(Index: Integer;
  const Value: TMeioPagamento);
begin
  FItems[Index] := Value;
end;

function TTipoPagamento.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TTipoPagamento.Add(AIDMeioPag, AImagem: Integer; ACodFiscal,
  ADescFiscal, AMeioPag: String; ARequireCustomer: Boolean; AValidateNonpayer: Boolean): TMeioPagamento;
var
  MeioPagamento : TMeioPagamento;
begin
  MeioPagamento := TMeioPagamento.Create(Self);
  with MeioPagamento do
  begin
    IDMeioPag       := AIDMeioPag;
    Imagem          := AImagem;
    CodFiscal       := ACodFiscal;
    DescFiscal      := ADescFiscal;
    MeioPag         := AMeioPag;
    RequireCustomer := ARequireCustomer;
    ValidateNonpayer:= AValidateNonpayer;
  end;
  FItems.Add(MeioPagamento);
  Result := MeioPagamento;
end;

{ TFormasPagamento }

constructor TFormasPagamento.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList.Create;
end;

procedure TFormasPagamento.Remove(Index: Integer);
var
  TipoPagamento: TTipoPagamento;
begin
  TipoPagamento := FItems[Index];
  FreeAndNil(TipoPagamento);
  FItems.Delete(Index);
end;

destructor TFormasPagamento.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TFormasPagamento.GetTiposPagamento(
  Index: Integer): TTipoPagamento;
begin
  Result := FItems[Index];
end;

procedure TFormasPagamento.SetTiposPagamento(Index: Integer;
  const Value: TTipoPagamento);
begin
  FItems[Index] := Value;
end;

procedure TFormasPagamento.Clear;
begin
  while FItems.Count > 0 do
    Remove(0);
end;

function TFormasPagamento.Add(ATipo: Integer; ADescricao: String): TTipoPagamento;
var
  TipoPagamento : TTipoPagamento;
begin
  TipoPagamento := TTipoPagamento.Create;
  with TipoPagamento do
  begin
    Tipo      := ATipo;
    Descricao := ADescricao;
  end;
  FItems.Add(TipoPagamento);
  Result := TipoPagamento;
end;

function TFormasPagamento.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ TMeioPagamento }

constructor TMeioPagamento.Create(ATipoPagamento: TTipoPagamento);
begin
  inherited Create;
  TipoPagamento := ATipoPagamento;
end;

destructor TMeioPagamento.Destroy;
begin
  inherited Destroy;
end;

end.
