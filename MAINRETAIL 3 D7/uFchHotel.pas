unit uFchHotel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, 
  LblEffct, ExtCtrls, FormConfig, Buttons,
  ComCtrls, ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TFchHotel = class(TbrwFrmParent)
    quFormIDHotel: TIntegerField;
    quFormHotel: TStringField;
    quFormEndereco: TStringField;
    quFormCidade: TStringField;
    quFormCEP: TStringField;
    quFormTelefone: TStringField;
    quFormFax: TStringField;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    quFormOBS: TStringField;
    Panel5: TPanel;
    Label19: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Label1: TLabel;
    DBMemo1: TDBMemo;
    Label43: TLabel;
    procedure spHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}


procedure TFchHotel.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(4071);
end;

end.
