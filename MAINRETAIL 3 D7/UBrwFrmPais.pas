unit UBrwFrmPais;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, FormConfig, Db, DBTables, 
  LblEffct, ExtCtrls, Buttons, StdCtrls, Mask, DBCtrls, ADODB,
  RCADOQuery, PowerADOQuery, siComp, siLangRT;

type
  TbrwFrmPais = class(TbrwFrmParent)
    quFormIDPais: TIntegerField;
    quFormCodPais: TStringField;
    quFormPais: TStringField;
    quFormDesativado: TBooleanField;
    quFormhidden: TBooleanField;
    quFormsystem: TBooleanField;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label6: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}


end.
 