unit uFchDepartment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PaiDeFichas, FormConfig, DB, ADODB, PowerADOQuery, siComp,
  siLangRT, StdCtrls, Buttons, LblEffct, ExtCtrls, Mask, DBCtrls;

type
  TFchDepartment = class(TbrwFrmParent)
    quFormIDDepartment: TIntegerField;
    quFormDepartment: TStringField;
    lblDepartment: TLabel;
    edtDepartment: TDBEdit;
    lblDepartmentRequired: TLabel;
  end;

implementation

uses uDM;

{$R *.dfm}

end.
