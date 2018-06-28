unit uWizImportCatalog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uParentWizImp, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, DB, cxDBData, Provider, DBClient, ImgList, StdCtrls,
  ExtCtrls, Grids, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Buttons, ComCtrls, cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TWizImportCatalog = class(TParentWizImp)
    gbVendorCatalogue: TGroupBox;
    Panel2: TPanel;
    cbVendor: TComboBox;
  private
    procedure AddComboVendor;
  protected
    procedure AddColumnsToImport; override;
    procedure FillColumnsGrid; override;
    function TestBeforeNavigate:Boolean; override;
    function OnAfterChangePage:Boolean; override;
    function VerifyFieldsRequired: Boolean;
    function DoFinish:Integer; override;
    procedure AddSpecificFriendFieldsToCDS(Position : Integer); override;
  public
    { Public declarations }
  end;

implementation

uses uMsgBox, uDMGlobalNTier, uDMImportExport;

{$R *.dfm}

{ TWizImportCatalog }

procedure TWizImportCatalog.AddColumnsToImport;
begin
  sgColumns.Cells[0,1]  := 'IDBarcode';
  sgColumns.Cells[0,2]  := 'Model';
  sgColumns.Cells[0,3]  := 'InvSize';
  sgColumns.Cells[0,4]  := 'InvColor';
  sgColumns.Cells[0,5]  := 'Description';
  sgColumns.Cells[0,6]  := 'Manufacture';
  sgColumns.Cells[0,7]  := 'TabGroup';
  sgColumns.Cells[0,8]  := 'CustoPrice';
  sgColumns.Cells[0,9]  := 'SalePrice';
  sgColumns.Cells[0,10] := 'VendorCode';
  sgColumns.Cells[0,11] := 'Qty';
  sgColumns.Cells[0,12] := 'QtyMin';
  sgColumns.Cells[0,13] := 'QtyMax';
end;

procedure TWizImportCatalog.AddComboVendor;
begin
  cbVendor.Clear;
  DMImportExport.cdsLUCatalogVendor.First;
  while not DMImportExport.cdsLUCatalogVendor.Eof do
    begin
      cbVendor.Items.Add(DMImportExport.cdsLUCatalogVendor.FieldByName('Vendor').AsString);
      DMImportExport.cdsLUCatalogVendor.Next;
    end;
end;

procedure TWizImportCatalog.AddSpecificFriendFieldsToCDS(
  Position: Integer);
begin
  inherited;

end;

function TWizImportCatalog.DoFinish: Integer;
begin
  ScreenStatusWait;
  if not (DMImportExport.ImportConn.AppServer.ImportCatalogTextFile(cdsFile.Data,
     LinkedColumns.Text,SpecificConfig.Text,LogError.Text)) then
     begin
      Result := MsgBox(LogError.Strings[1], vbInformation + vbOKOnly);
      ScreenStatusOK;
      Exit;
    end;
  ScreenStatusOK;

  Result := inherited DoFinish;
end;

procedure TWizImportCatalog.FillColumnsGrid;
begin
  sgColumns.Cells[0,0] := 'Main Retail';
  sgColumns.Cells[1,0] := 'File Catalog';

  AddColumnsToImport;
  AddComboColumnsToImport;
end;

function TWizImportCatalog.OnAfterChangePage: Boolean;
begin
  Result := inherited OnAfterChangePage;

  if pgOption.ActivePage.Name = 'tsCrossColumn' then
  begin
    cbColumns.Visible := False;
    FillColumnsGrid;
  end
  else if pgOption.ActivePage.Name = 'tsSpecificConfig' then
  begin
    DMImportExport.ImportConn.Connected := True;
    DMImportExport.OpenCatalogVendor;
    AddComboVendor;
  end
end;

function TWizImportCatalog.TestBeforeNavigate: Boolean;
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
       AddSpecificConfigList('IDUser', IntToStr(DMImportExport.FUser.ID));
   end;

     SpecificConfig.Add('Vendor' + '=' + cbVendor.Text);
end;

function TWizImportCatalog.VerifyFieldsRequired: Boolean;
begin
  Result := True;

  if cbVendor.Text = '' then
     Result := False;
end;

end.
