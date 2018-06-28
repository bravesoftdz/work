unit uRepParentFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, siComp;

type
  TRepParentFilter = class(TForm)
    lblFilter: TLabel;
    siLangFilter: TsiLang;
  protected
    FMultValue: Boolean;
    FIDLanguage : Integer;
  public
    function GetFilterString: String; virtual; abstract;
    function GetValue: Variant; virtual; abstract;
    procedure SetFilterLabel(Value: String);

    property MultValue: Boolean read FMultValue write FMultValue default False;
    property IDLanguage: Integer read FIDLanguage write FIDLanguage;
  end;

implementation

uses uDMReport;

{$R *.dfm}

{ TRepParentFilter }

procedure TRepParentFilter.SetFilterLabel(Value: String);
begin
  lblFilter.Caption := Value;
end;

end.
