unit uDMBonus;

interface

uses
  SysUtils, Classes;

type
  TDMBonus = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMBonus: TDMBonus;

uses uDM, uDMPDV;

implementation

{$R *.dfm}

procedure TDMBonus.DataModuleCreate(Sender: TObject);
begin
  //
end;

procedure TDMBonus.DataModuleDestroy(Sender: TObject);
begin
  //
end;

end.
