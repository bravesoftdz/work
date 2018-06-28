unit uFchAcertaTourGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaiDeFichas, DBCtrls, StdCtrls, ComCtrls, Db, Mask, 
  FormConfig, DBTables, Buttons, LblEffct, ExtCtrls,
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT;

type
  TFchAcertaTourGroup = class(TbrwFrmParent)
    scGuide: TDBSuperComboADO;
    scAgency: TDBSuperComboADO;
    Label1: TLabel;
    Label2: TLabel;
    DBRichEdit1: TDBRichEdit;
    Label3: TLabel;
    cbDesconta: TDBCheckBox;
    editCoordenacao: TDBEdit;
    Label4: TLabel;
    Label18: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    quFormIDTouristGroup: TIntegerField;
    quFormTipTouristGroup: TStringField;
    quFormIDGuide: TIntegerField;
    quFormIDAgency: TIntegerField;
    quFormDescontaCoordenacao: TBooleanField;
    quFormComissaoSobreGuia: TFloatField;
    quFormIDUser: TIntegerField;
    DBSuperCombo3: TDBSuperComboADO;
    Label7: TLabel;
    procedure scGuideSelectItem(Sender: TObject);
    procedure scAgencySelectItem(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal;

{$R *.DFM}


procedure TFchAcertaTourGroup.scGuideSelectItem(Sender: TObject);
begin
  inherited;
  if scGuide.LookUpValue <> '' then
    quFormDescontaCoordenacao.AsString := DM.DescCodigo( ['IDComissionado'], [scGuide.LookUpValue], 'vwComissionado', 'DescontaCoordenacao');

end;

procedure TFchAcertaTourGroup.scAgencySelectItem(Sender: TObject);
begin
  inherited;
  if scAgency.LookUpValue <> '' then
    quFormComissaoSobreGuia.AsString := DM.DescCodigo( ['IDComissionado'], [scAgency.LookUpValue], 'vwComissionado', 'ComissaoSobreGuia');
end;

procedure TFchAcertaTourGroup.FormCreate(Sender: TObject);
begin
  inherited;
  sUrlHelp  := '';
  sUrlVideo := '';
end;

end.
