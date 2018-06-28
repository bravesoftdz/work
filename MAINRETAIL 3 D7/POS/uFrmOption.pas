unit uFrmOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TOption = class
    ID : String;
    Texto : String;
  end;


  TFrmOption = class(TForm)
    Selecionar: TButton;
    lbxOption: TListBox;
    btnClose: TButton;
    btnVoltar: TButton;
    procedure SelecionarClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    FResult : String;
    FOptions : String;
    procedure BuildOptions;
    procedure UnBuildOptions;
  public
    function Start(Header, Options:String):String;
  end;

implementation

{$R *.dfm}

{ TFrmOption }

procedure TFrmOption.BuildOptions;
var
  OP : TOption;
  sTemp, sAux : String;
begin
  sTemp := FOptions;
  while Length(sTemp) <> 0 do
  begin
    sAux := Copy(sTemp, 1, Pos(';',sTemp));
    sTemp := Copy(sTemp, Pos(';',sTemp)+1, Length(sTemp));
    OP := TOption.Create;
    OP.ID    := Copy(sAux, 1, Pos(':',sAux)-1);
    OP.Texto := Copy(sAux, Pos(':',sAux)+1, Pos(';',sAux)-1);
    lbxOption.Items.AddObject(OP.ID + ' - ' + OP.Texto, OP);
  end;
end;

function TFrmOption.Start(Header, Options: String): String;
begin
  Caption := Header;
  FOptions := Options;
  BuildOptions;
  ShowModal;
  Result := FResult;
  UnBuildOptions;
end;

procedure TFrmOption.UnBuildOptions;
var
  OP : TOption;
begin
  while lbxOption.Items.Count > 0 do
  begin
    OP := TOption(lbxOption.Items.Objects[0]);
    FreeAndNil(OP);
    lbxOption.Items.Objects[0] := nil;
    lbxOption.Items.Delete(0);
  end;
end;

procedure TFrmOption.SelecionarClick(Sender: TObject);
begin
  if lbxOption.ItemIndex <> -1 then
    FResult := TOption(lbxOption.Items.Objects[lbxOption.ItemIndex]).ID;
  Close;
end;

procedure TFrmOption.btnCloseClick(Sender: TObject);
begin
  FResult := '-1';
  Close;
end;

procedure TFrmOption.btnVoltarClick(Sender: TObject);
begin
  FResult := '-2';
  Close;
end;

end.
