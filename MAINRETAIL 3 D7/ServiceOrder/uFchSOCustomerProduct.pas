unit uFchSOCustomerProduct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, SuperComboADO,
  DBCtrls;

type
  TFchSOCustomerProduct = class(TbrwFrmParent)
    quFormIDSOCustomerProduct: TIntegerField;
    quFormModel: TStringField;
    quFormDescription: TStringField;
    quFormIDManufacture: TIntegerField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    scSubManufacture: TDBSuperComboADO;
    Label21: TLabel;
    Label37: TLabel;
    Label3: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.dfm}

end.
