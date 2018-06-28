unit uFrmConfiguration;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, siComp;

type
  TFrmConfig = class(TForm)
    btnScreen: TBitBtn;
    pnlButton: TPanel;
    btnClose: TBitBtn;
    btnAdvertising: TBitBtn;
    siLang: TsiLang;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnScreenClick(Sender: TObject);
    procedure btnAdvertisingClick(Sender: TObject);
  private
    FResult : Boolean;
  public
    function Start : Boolean;
  end;

implementation

uses uFrmScreenConf, uFrmAdvertisingConfig, uDMGlobal;

{$R *.dfm}

{ TFrmConfig }

function TFrmConfig.Start: Boolean;
begin
  FResult := False;
  ShowModal;
  Result := FResult;
end;

procedure TFrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmConfig.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmConfig.btnScreenClick(Sender: TObject);
begin
  with TFrmScreenConf.Create(Self) do
    FResult := Start;
end;

procedure TFrmConfig.btnAdvertisingClick(Sender: TObject);
begin
  with TFrmAdvertisingConfig.Create(Self) do
    FResult := Start;
end;

end.
