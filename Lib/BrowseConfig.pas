unit BrowseConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uSystemTypes;

type
  TOnLoadFicha = procedure (Sender : TObject; var FchFicha : TObject) of object;

  TBrowseConfig = class(TComponent)
  private
    { Private declarations }
    FRefreshInterval : integer;
    FCor1, FCor2, FCorHighLight : TColor;
    FAutoOpen, FMultiPage,
    FMultiplasCores       : Boolean;
    FViewIndexFieldKey1,
    FViewIndexFieldKey2   : integer;
    FnOrderByInicial  : integer;
    FViewDeleteTable, FDefaultButton, FFchClassName : String;
    FOrderByStateInicial : TOrderByState;
    FMostraDesativado : TDesativadoState;
    FMostraHidden     : THiddenState;
    FRealDeletion, FCheckSystemOnDelete : Boolean;
    FOnLoadFicha : TOnLoadFicha;

  protected
    { Protected declarations }
    constructor Create(AOwner: TComponent); override;
  public
    { Public declarations }
  published
    { Published declarations }
    property nOrderByInicial  : integer read FnOrderByInicial  write FnOrderByInicial  default 0;
    property OrderByStateInicial : TOrderByState read FOrderByStateInicial  write FOrderByStateInicial  default STD_ORDER_ASC;
    property MostraDesativado : TDesativadoState read FMostraDesativado write FMostraDesativado default STD_NAODESATIVADO;
    property MostraHidden     : THiddenState read FMostraHidden write FMostraHidden default STD_NAOHIDDEN;
    property AutoOpen         : Boolean read FAutoOpen write FAutoOpen default True;
    property MultiplasCores   : Boolean read FMultiplasCores write FMultiplasCores default True;
    property Cor1             : TColor  read FCor1 write FCor1;
    property Cor2             : TColor  read FCor2 write FCor2;
    property CorHighLight     : TColor  read FCorHighLight write FCorHighLight;
    property ViewIndexFieldKey1 : integer read FViewIndexFieldKey1 write FViewIndexFieldKey1 default 0;
    property ViewIndexFieldKey2 : integer read FViewIndexFieldKey2 write FViewIndexFieldKey2 default 1;
    property ViewDeleteTable  : String  read FViewDeleteTable  write FViewDeleteTable;
    property CheckSystemOnDelete : Boolean read FCheckSystemOnDelete write FCheckSystemOnDelete default True;
    property RealDeletion     : Boolean read FRealDeletion write FRealDeletion default False;
    property MultiPage        : Boolean read FMultiPage write FMultiPage default False;
    property DefaultButton    : String  read FDefaultButton write FDefaultButton;
    property FchClassName     : String read FFchClassName write FFchClassName;
    property RefreshInterval  : Integer read FRefreshInterval write FRefreshInterval default 10;
    property OnLoadFicha      : TOnLoadFicha read FOnLoadFicha write FOnLoadFicha;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NewPower', [TBrowseConfig]);
end;

constructor TBrowseConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoOpen         := True;
  FMultiplasCores   := True;
  FnOrderByInicial  := 0;
  FViewIndexFieldKey1   := 0;
  FViewIndexFieldKey2   := 1;
  FOrderByStateInicial := STD_ORDER_ASC;
  FMostraDesativado := STD_NAODESATIVADO;
  FMostraHidden     := STD_NAOHIDDEN;
  FCheckSystemOnDelete := True;
  FRealDeletion     := False;
  FMultiPage        := False;
  FViewDeleteTable  := '';
  FchClassName      := '';
  FDefaultButton    := 'btDetail';
  FRefreshInterval  := 10;
end;

end.
