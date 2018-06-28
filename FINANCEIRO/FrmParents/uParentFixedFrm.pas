unit uParentFixedFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentAllFrm, Buttons, ExtCtrls, StdCtrls, dxBar, ImgList, siComp,
  siLangRT;

type
  TParentFixedFrm = class(TParentAllFrm)
    lblModuloSadow: TLabel;
    lblModulo: TLabel;
    imgOn: TImage;
    imgOff: TImage;
    bmMDI: TdxBarManager;
    ilSmallButtons: TImageList;
    procedure btParentCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure Start(Parametro: String; UserRights: String; Suggestion : TStringList); virtual;
    procedure SetUserRights(IDMenuItem, IDUsuario: Integer); virtual;

  protected
    MyParametro: String;

    OriginalTitleFontColor, OriginalTitleColor: Integer;

    procedure Ativar;
    procedure Desativar;

    procedure OnBeforeStart; virtual;
    procedure OnStart; virtual;
    procedure OnAfterStart; virtual;

  end;

var
  ParentFixedFrm: TParentFixedFrm;

implementation


{$R *.DFM}

uses uSisMain;

procedure TParentFixedFrm.SetUserRights(IDMenuItem, IDUsuario: Integer);
begin
  // Para ser implentado nos filhos
end;

procedure TParentFixedFrm.OnBeforeStart;
begin
  inherited;
  //
end;

procedure TParentFixedFrm.OnStart;
begin
  inherited;
  //
end;

procedure TParentFixedFrm.OnAfterStart;
begin
  inherited;
  //
end;

procedure TParentFixedFrm.btParentCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TParentFixedFrm.Start(Parametro: String; UserRights: String; Suggestion : TStringList);
begin
  OnBeforeStart;

  MyParametro := Parametro;
  WindowState := wsMaximized;

  lblModulo.Caption := self.Caption;
  lblModuloSadow.Caption := self.Caption;

  OnStart;

  Show;

  OnAfterStart;
end;

procedure TParentFixedFrm.Ativar;
begin
  EspacamentoSuperior.Color := OriginalTitleColor;
  lblModulo.Font.Color := OriginalTitleFontColor;
  imgOn.Visible := True;
  imgOff.Visible := False;
  imgOn.SendToBack;

end;

procedure TParentFixedFrm.Desativar;
begin
  imgOn.Visible := False;
  imgOff.Visible := True;
  imgOff.SendToBack;

end;

procedure TParentFixedFrm.FormCreate(Sender: TObject);
begin
  inherited;
  OriginalTitleFontColor := lblModulo.Font.Color;
  OriginalTitleColor := EspacamentoSuperior.Color;

end;

procedure TParentFixedFrm.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized;

end;


procedure TParentFixedFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
