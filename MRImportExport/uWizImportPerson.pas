unit uWizImportPerson;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizImp, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, DBClient, ImgList, StdCtrls, ExtCtrls,
  Grids, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, ComCtrls, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TWizImportPerson = class(TParentWizImp)
    gbVendorCatalogue: TGroupBox;
    Label19: TLabel;
    cbxStore: TcxLookupComboBox;
    Label13: TLabel;
    Label2: TLabel;
    Label18: TLabel;
    cbxUser: TcxLookupComboBox;
    Label14: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbPersonType: TComboBox;
    cbVerify: TComboBox;
    Label5: TLabel;
    procedure sgColumnsExit(Sender: TObject);
  private
    procedure SaveGridColumns;
    procedure GetGridColumn;
    function GetPortPersonType(Item : Integer): String;
    function GetImportType(Item : Integer): Integer;
  protected
    procedure AddColumnsToImport; override;
    procedure FillColumnsGrid; override;
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
    function VerifyFieldsRequired: Boolean;
    function DoFinish:Integer; override;
    function AddSpecificFieldsToCDS(Position : Integer): Integer; override;
    procedure AddSpecificFriendFieldsToCDS(Position : Integer); override;
    procedure OnBeforeBackClick; override;
  end;

implementation

uses uMsgBox, uDMGlobalNTier, uParamFunctions, uDMImportExport,
  uParentWizard, uSystemConst;

{$R *.dfm}

{ TWizImportPerson }

procedure TWizImportPerson.AddColumnsToImport;
begin
  sgColumns.Cells[0,1] := 'Name';  // Pessoa
  sgColumns.Cells[0,2] := 'FirstName'; // PessoaFirstName
  sgColumns.Cells[0,3] := 'LastName';  // PessoaLastName
  sgColumns.Cells[0,4] := 'ShortName';  // Pessoa
  sgColumns.Cells[0,5] := 'Legalname'; // NomeJuridico = Inscricao Estadual
  sgColumns.Cells[0,6] := 'Address';  // Endereco
  sgColumns.Cells[0,7] := 'Neighborhood';  // Bairro
  sgColumns.Cells[0,8] := 'City'; // Cidade
  sgColumns.Cells[0,9] := 'State'; // Estado
  sgColumns.Cells[0,10] := 'ZIP'; // CEP
  sgColumns.Cells[0,11] := 'Country'; // Pais    
  sgColumns.Cells[0,12] := 'PhoneAreaCode';  //código do telefone
  sgColumns.Cells[0,13] := 'Phone';  //telefone
  sgColumns.Cells[0,14] := 'CellAreaCode';  //código do celular
  sgColumns.Cells[0,15] := 'Cellular'; // celular
  sgColumns.Cells[0,16] := 'Fax'; // Fax
  sgColumns.Cells[0,17] := 'Contact'; // Contato
  sgColumns.Cells[0,18] := 'Email';
  sgColumns.Cells[0,19] := 'OBS';
  sgColumns.Cells[0,20] := 'BirthDate'; // nascimento
  sgColumns.Cells[0,21] := 'SocialSecurity#'; //Identidade
  sgColumns.Cells[0,22] := 'TaxNumber';  // CGC
  sgColumns.Cells[0,23] := 'EmployeeID'; // CPF
  sgColumns.Cells[0,24] := 'DriverLicence'; // CartMotorista
  sgColumns.Cells[0,25] := 'DBA'; // Inscricao Estadual
  sgColumns.Cells[0,26] := 'FederalID#'; //CNPJ
  sgColumns.Cells[0,27] := 'SalesTax#'; //Insc. Municipal
  sgColumns.Cells[0,28] := 'CreationDate'; //Data criacao

  sgColumns.RowCount := 29;
end;

function TWizImportPerson.DoFinish: Integer;
begin
  Result := inherited DoFinish;
end;

procedure TWizImportPerson.FillColumnsGrid;
begin
  sgColumns.Cells[0,0] := 'Main Retail';
  sgColumns.Cells[1,0] := 'Person File';

  AddColumnsToImport;
  AddComboColumnsToImport;
end;

procedure TWizImportPerson.GetGridColumn;
var
  sColumn, sError, sResult : String;
  sCaseCost : WordBool;
  i : integer;
begin

  sColumn := DMImportExport.GetAppProperty('ColumnImportPersonSetup', SpecificConfig.Values['PersonType']);
  {
  sError := DMImportExport.GetConfigImport(
    0,
    GetImportType(cbPersonType.ItemIndex),
    sColumn,
    sCaseCost);
    LogError.Text := sError;
  }
  if LogError.Text = '' then
  begin
    if sColumn = '' then
       Exit;

    for i:=1 to sgColumns.RowCount-1 do
    begin
      sResult := ParseParam(sColumn, Trim(sgColumns.Cells[0,i]));
      if sResult <> '' then
        sgColumns.Cells[1,i] := sResult;
      sColumn := DeleteParam(sColumn, Trim(sgColumns.Cells[0,i]));
    end;
  end;

end;

function TWizImportPerson.OnAfterChangePage: Boolean;
var
  sError: String;
begin
  Result := inherited OnAfterChangePage;

  if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin
    cbColumns.Visible := False;
    FillColumnsGrid;
    GetGridColumn;
  end
  else if pgOption.ActivePage.Name = 'tsSpecificConfig' then
  begin
    DMImportExport.ImportConn.Connected := True;
    DMImportExport.OpenStore;
    DMImportExport.OpenUser;
  end
  else if pgOption.ActivePage.Name = 'tsImport' then
  begin
    SaveGridColumns;
    
    ScreenStatusWait;
    DMImportExport.ImportConn.AppServer.ImportPersonTextFile(cdsFile.Data,
      LinkedColumns.Text,SpecificConfig.Text, sError);
    LogError.Text := sError;

    if sError <> '' then
      ShowError(sError)
    else
      MsgBox('Import Success!', vbInformation + vbOKOnly);

    ScreenStatusOk;
  end;
end;

procedure TWizImportPerson.SaveGridColumns;
var
  sColumn, sError : String;
  i       : integer;
begin

  for i:=1 to sgColumns.RowCount-1 do
      if Trim(sgColumns.Cells[0,i]) <> '' then
         //if Pos(Trim(sgColumns.Cells[1,i]), sColumn) = 0 then
            sColumn := sColumn + sgColumns.Cells[0,i] + '=' + sgColumns.Cells[1,i] + ';';

  if sColumn = '' then
     Exit;

  //DMImportExport.SetAppProperty('ColumnImportPersonSetup', SpecificConfig.Values['PersonType'], sColumn);
  sError := DMImportExport.InsertConfigImport(
  0,
  GetImportType(cbPersonType.ItemIndex),
  sColumn,
  False);
  LogError.Text := sError;

  if LogError.Text <> '' then
  begin
    MsgBox(LogError.Text, vbCritical + vbOkOnly);
  end;

end;

function TWizImportPerson.TestBeforeNavigate: Boolean;
begin
  Result := inherited TestBeforeNavigate;

  if pgOption.ActivePage.Name = 'tsSpecificConfig' then
   begin
     if not VerifyFieldsRequired then
     begin
       MsgBox('Field Required!', vbInformation + vbOKOnly);
       Result := False;
       Exit;
     end
     else
     begin
       AddSpecificConfigList('Store',cbxStore.EditValue);
       AddSpecificConfigList('PersonType',GetPortPersonType(cbPersonType.ItemIndex));
       AddSpecificConfigList('User',cbxUser.EditValue);
       AddSpecificConfigList('Verify',cbVerify.Text);
       AddSpecificConfigList('IDUser', IntToStr(DMImportExport.FUser.ID));
     end;
   end
end;

function TWizImportPerson.VerifyFieldsRequired: Boolean;
begin
  Result := True;

  if  (cbxStore.EditingText = '') or
      (cbPersonType.Text  = '') or
      (cbxUser.EditingText  = '')  then
      Result := False;
end;

procedure TWizImportPerson.sgColumnsExit(Sender: TObject);
begin
  inherited;
  //SaveGridColumns;
end;

function TWizImportPerson.GetPortPersonType(Item : Integer): String;
var
  PortPersonType: String;
begin

  {case Item of
   0 : PortPersonType := 'Clientes';
   1 : PortPersonType := 'Fornecedor';
   2 : PortPersonType := 'Comissionados';
   3 : PortPersonType := 'Vendedor';
   4 : PortPersonType := 'Guias';
   5 : PortPersonType := 'Agências';
   6 : PortPersonType := 'Fabricantes';
   7 : PortPersonType := 'Outros';
   8 : PortPersonType := 'Prospects';
  end;}

  case Item of
   0 : PortPersonType := '.001'; //Clientes
   1 : PortPersonType := '.002'; //Fornecedor
   2 : PortPersonType := '.003'; //Comissionados
   3 : PortPersonType := '.003.001'; //Vendedor
   4 : PortPersonType := '.003.002';  //Guias
   5 : PortPersonType := '.003.003'; //Agências
   6 : PortPersonType := '.004'; //Fabricantes
   7 : PortPersonType := '.003.004'; //Outros
   8 : PortPersonType := '.001.001'; //Prospects
  end;

  Result := PortPersonType;
end;

function TWizImportPerson.AddSpecificFieldsToCDS(
  Position: Integer): Integer;
begin
  Result := Position;
end;

procedure TWizImportPerson.AddSpecificFriendFieldsToCDS(Position: Integer);
begin
  inherited;

end;

function TWizImportPerson.GetImportType(Item: Integer): Integer;
begin
  case Item of
   0 : Result := IMPORT_TYPE_COSTUMER; //Clientes
   1 : Result := IMPORT_TYPE_VENDOR; //Fornecedor
   2 : Result := IMPORT_TYPE_COMMISSIONED; //Comissionados
   3 : Result := IMPORT_TYPE_SALESMAN; //Vendedor
   4 : Result := IMPORT_TYPE_GUIDES;  //Guias
   5 : Result := IMPORT_TYPE_AGENCY; //Agências
   6 : Result := IMPORT_TYPE_MANUFACTORER; //Fabricantes
   7 : Result := IMPORT_TYPE_ANOTHER; //Outros
   8 : Result := IMPORT_TYPE_PROSPECTS; //Prospects
  end;
end;

procedure TWizImportPerson.OnBeforeBackClick;
begin
  if pgOption.ActivePage.Name = 'tsCrossColumn' then
    SaveGridColumns;

  inherited;

end;

end.
