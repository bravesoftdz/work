unit uTefDedicadoInterface;

interface

uses classes, uTEFTypes;

type
  TTefDedicadoInterface = class(TComponent)
  private
    FOnExecutaComando11: TExecutaComando;
    FOnExecutaComando13: TExecutaComando;
    FOnExecutaComando12: TExecutaComando;
    FOnExecutaComando1: TExecutaComandoMsg;
    FOnExecutaComando3: TExecutaComandoMsg;
    FOnExecutaComando2: TExecutaComandoMsg;
    FOnExecutaComando22: TExecutaComandoMsg;
    FOnLimpaMsg: TNotifyEvent;
  public
  published
    property OnExecutaComando1: TExecutaComandoMsg read FOnExecutaComando1 write FOnExecutaComando1;
    property OnExecutaComando2: TExecutaComandoMsg read FOnExecutaComando2 write FOnExecutaComando2;
    property OnExecutaComando3: TExecutaComandoMsg read FOnExecutaComando3 write FOnExecutaComando3;
    property OnExecutaComando22: TExecutaComandoMsg read FOnExecutaComando22 write FOnExecutaComando22;

    property OnExecutaComando11: TExecutaComando read FOnExecutaComando11 write FOnExecutaComando11;
    property OnExecutaComando12: TExecutaComando read FOnExecutaComando12 write FOnExecutaComando12;
    property OnExecutaComando13: TExecutaComando read FOnExecutaComando13 write FOnExecutaComando13;

    property OnLimpaMsg:         TNotifyEvent    read FOnLimpaMsg         write FOnLimpaMsg;

    procedure DoExecutaComando11(Sender: TObject);
    procedure DoExecutaComando13(Sender: TObject);
    procedure DoExecutaComando12(Sender: TObject);
    procedure DoExecutaComando1(Sender: TObject; Msg: String);
    procedure DoExecutaComando3(Sender: TObject; Msg: String);
    procedure DoExecutaComando2(Sender: TObject; Msg: String);
    procedure DoExecutaComando22(Sender: TObject; Msg: String);

    procedure DoLimpaMsg(Sender: TObject);
  end;

  procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MainRetail', [TTefDedicadoInterface]);
end;


{ TTefDedicadoInterface }

procedure TTefDedicadoInterface.DoExecutaComando1(Sender: TObject; Msg: String);
begin
  if Assigned(FOnExecutaComando1) then
    FOnExecutaComando1(Sender, Msg);
end;

procedure TTefDedicadoInterface.DoExecutaComando11(Sender: TObject);
begin
  if Assigned(FOnExecutaComando11) then
    FOnExecutaComando11(Sender);
end;

procedure TTefDedicadoInterface.DoExecutaComando12(Sender: TObject);
begin
  if Assigned(FOnExecutaComando12) then
    FOnExecutaComando12(Sender);
end;

procedure TTefDedicadoInterface.DoExecutaComando13(Sender: TObject);
begin
  if Assigned(FOnExecutaComando13) then
    FOnExecutaComando13(Sender);
end;

procedure TTefDedicadoInterface.DoExecutaComando2(Sender: TObject; Msg: String);
begin
  if Assigned(FOnExecutaComando2) then
    FOnExecutaComando2(Sender, Msg);
end;

procedure TTefDedicadoInterface.DoExecutaComando22(Sender: TObject; Msg: String);
begin
  if Assigned(FOnExecutaComando22) then
    FOnExecutaComando22(Sender, Msg);
end;

procedure TTefDedicadoInterface.DoExecutaComando3(Sender: TObject; Msg: String);
begin
  if Assigned(FOnExecutaComando3) then
    FOnExecutaComando3(Sender, Msg);
end;

procedure TTefDedicadoInterface.DoLimpaMsg(Sender: TObject);
begin
  if Assigned(FOnLimpaMsg) then
    FOnLimpaMsg(Sender);
end;

end.
