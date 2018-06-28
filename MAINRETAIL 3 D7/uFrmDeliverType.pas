unit uFrmDeliverType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB, 
  LblEffct, ExtCtrls, FormConfig, Buttons,
  ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TbrwFrmDeliverType = class(TbrwFrmParent)
    quFormIDDeliverType: TIntegerField;
    quFormName: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Panel5: TPanel;
    Label19: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label43: TLabel;
    quFormCanConfirmDeliver: TBooleanField;
    chkConfirmDelivery: TDBCheckBox;
    quFormMaxDeliverDelay: TIntegerField;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    quFormCanExchangeItem: TBooleanField;
    chkCanExchange: TDBCheckBox;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    quFormWebsite: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}

end.
