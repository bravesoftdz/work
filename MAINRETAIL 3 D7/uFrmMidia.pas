unit uFrmMidia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, FormConfig, Buttons, 
  ADODB, RCADOQuery, PowerADOQuery, SuperComboADO, siComp, siLangRT;

type
  TbrwFrmMidia = class(TbrwFrmParent)
    IDMidia: TLabel;
    DBEdit1: TDBEdit;
    quFormIDMedia: TIntegerField;
    quFormMedia: TStringField;
    quFormTaxMode: TIntegerField;
    quFormPayComission: TIntegerField;
    quFormIDOtherCommission: TIntegerField;
    Panel5: TPanel;
    Label19: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBCheckBox1: TDBCheckBox;
    Label1: TLabel;
    DBSuperCombo1: TDBSuperComboADO;
    Label21: TLabel;
    procedure quFormNewRecord(DataSet: TDataSet);
    procedure spHelpClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uDM, uDMGlobal, uSystemConst, Variants;

{$R *.DFM}


procedure TbrwFrmMidia.quFormNewRecord(DataSet: TDataSet);
begin
  inherited;
  quFormTaxMode.AsInteger      := TAX_MODE_MANAGER;
  quFormPayComission.AsInteger := 1;
end;


procedure TbrwFrmMidia.spHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(1310);
end;

procedure TbrwFrmMidia.btCloseClick(Sender: TObject);
var
   cmd: TADOQuery;
begin
//  inherited;

   try
      try
          cmd := TADOQuery.Create(nil);
          cmd.Connection := dm.ADODBConnect;
          cmd.SQL.Add('insert into Media (IDMedia');
          cmd.SQL.add(',IDOtherCommission');
          cmd.sql.Add(',Media');
          cmd.sql.add(',System');
          cmd.sql.add(',Desativado');
          cmd.sql.add(',Hidden');
          cmd.SQL.Add(',TaxMode');
          cmd.sql.add(',PayComission)');
          cmd.SQL.add(' values ');
          cmd.SQL.add('(:prm_IdMedia');
          cmd.sql.add(',:prm_IdOtherComm');
          cmd.SQL.add(',:prm_media');
          cmd.SQL.add(',:prm_system');
          cmd.SQL.add(',:prm_desativado');
          cmd.SQL.add(',:prm_hidden');
          cmd.SQL.add(',:prm_taxModel');
          cmd.SQL.add(',:prm_payComm)');
          cmd.Parameters.ParamByName('prm_IdMedia').Value := dm.GetNextID('Media.IdMedia');
          cmd.Parameters.ParamByName('prm_IdOtherComm').Value := quFormIDOtherCommission.Value;
          cmd.Parameters.ParamByName('prm_media').Value := quFormMedia.Value;
          cmd.Parameters.ParamByName('prm_system').Value := 0;
          cmd.Parameters.ParamByName('prm_desativado').Value := 0;
          cmd.Parameters.ParamByName('prm_hidden').Value := 0;
          cmd.Parameters.ParamByName('prm_taxModel').Value := quFormTaxMode.Value;
          cmd.Parameters.ParamByName('prm_payComm').Value := quFormPayComission.Value;

          cmd.ExecSQL();
      except
         on e: Exception do begin
            raise e.Create('Error found when try to insert: ' +e.Message);
         end;
      end;

   finally
        FreeAndNil(cmd);

   end;

end;

end.
