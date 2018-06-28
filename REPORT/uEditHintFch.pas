unit uEditHintFch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Mask, DBCtrls, ADODB, Provider, DBClient,
  ExtCtrls;

type
  TEditHintFch = class(TForm)
    ADOQuery1: TADOQuery;
    ADOQuery1ItemId: TAutoIncField;
    ADOQuery1Name: TStringField;
    ADOQuery1Hint: TStringField;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1ItemId: TAutoIncField;
    ClientDataSet1Name: TStringField;
    ClientDataSet1Hint: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DataSource2: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function Start(ItemID : string) : Boolean;
  end;

var
  EditHintFch: TEditHintFch;

implementation

uses uDM;

{$R *.dfm}

procedure TEditHintFch.Button1Click(Sender: TObject);
begin
  ClientDataSet1.ApplyUpdates(-1);
end;

function TEditHintFch.Start(ItemID: string): Boolean;
begin
  ADOQuery1.Close;
  ADOQuery1.Parameters.ParamByName('ItemId').Value := ItemID;
  ADOQuery1.Open;
  Result := True;
end;

procedure TEditHintFch.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
   ClientDataSet1.Close;
   ClientDataSet1.Open;
end;

end.
