unit uFrmPOSSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, ADODB;

type
  TFrmPOSSQL = class(TForm)
    quCrtTypes: TADOQuery;
    quCrtReg60Analitico: TADOQuery;
    quCrtReg60Item: TADOQuery;
    quCrtReg60Mestre: TADOQuery;
    quCrtReg60ResumoDiario: TADOQuery;
    Label1: TLabel;
    Shape1: TShape;
  private
    { Private declarations }
    function GenerateTables: Boolean;
    function GenerateTypes: Boolean;
    function CreateFieldCodFiscal: Boolean;
    function GenerateFields: Boolean;
    function CreateFieldECFTaxIndex: Boolean;
    function CreateFieldCupomFiscal: Boolean;
    function CreateFieldDescFiscal: Boolean;
  public
    { Public declarations }
    function GenerateAll: Boolean;
  end;

implementation

uses uDM, uHandleError;

{$R *.dfm}

function TFrmPOSSQL.GenerateTypes : Boolean;
begin
  Result := True;
  try
    quCrtTypes.ExecSQL;
  except
    on E: Exception do
    begin
      Result := False;
      DM.SetError(CRITICAL_ERROR, 'TFrmPOSSQL.GenerateTypes', E.Message);
    end;
  end;
end;


function TFrmPOSSQL.GenerateTables : Boolean;
begin
  Result := True;
  try
    quCrtReg60Analitico.ExecSQL;
    quCrtReg60Item.ExecSQL;
    quCrtReg60Mestre.ExecSQL;
    quCrtReg60ResumoDiario.ExecSQL;
  except
    on E: Exception do
    begin
      Result := False;
      DM.SetError(CRITICAL_ERROR, 'TFrmPOSSQL.GenerateTables', E.Message);
    end;
  end;
end;

function TFrmPOSSQL.CreateFieldCodFiscal: Boolean;
begin
  Result := DM.DynamicRunSQL(Self, 'ALTER TABLE MeioPag ADD CodFiscal varchar(2)');
end;


function TFrmPOSSQL.CreateFieldDescFiscal: Boolean;
begin
  Result := DM.DynamicRunSQL(Self, 'ALTER TABLE MeioPag ADD DescFiscal varchar(16)');
end;

function TFrmPOSSQL.CreateFieldECFTaxIndex: Boolean;
begin
  Result := DM.DynamicRunSQL(Self, 'ALTER TABLE TaxCategory ADD ECFTaxIndex varchar(2)');
end;

function TFrmPOSSQL.CreateFieldCupomFiscal: Boolean;
begin
  Result := DM.DynamicRunSQL(Self, 'ALTER TABLE Invoice ADD CupomFiscal varchar(8)');
end;



function TFrmPOSSQL.GenerateFields: Boolean;
begin
  Result := True;
  
  if Result and not DM.TableFieldExists('MeioPag', 'CodFiscal') then
    Result := CreateFieldCodFiscal;

  if Result and not DM.TableFieldExists('MeioPag', 'DescFiscal') then
    Result := CreateFieldDescFiscal;

  if Result and not DM.TableFieldExists('TaxCategory', 'ECFTaxIndex') then
    Result := CreateFieldECFTaxIndex;

  if Result and not DM.TableFieldExists('Invoice', 'CupomFiscal') then
    Result := CreateFieldCupomFiscal;
end;


function TFrmPOSSQL.GenerateAll: Boolean;
begin
  Result := GenerateTypes;
  if Result then
    Result := GenerateTables;
  if Result then
    Result := GenerateFields;
end;

end.
