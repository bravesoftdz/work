(*
-----------------------------------------------------------------------------------------------------

Version    : (289 - 285)
Date       : 03.14.2011
Author     : Antonio Marcos Fernandes de Souza (amfsouza)
Issue      : Remove button is available to delete system folder (root of tree ) and subfolders.
Solution   : Disable remove button if system folder and subfolders.
To Version : (289 - 286)
-----------------------------------------------------------------------------------------------------

Version    : (288 - 279)
Date       : 01.25.2011
Author     : Antonio Marcos Fernandes de Souza (amfsouza)
Issue      : Remove button is available to delete system folder (root of tree ).
Solution   : Disable remove button if system folder.
To Version : (288 - 280)
-----------------------------------------------------------------------------------------------------
*)

unit uBrwPessoa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, DBTables, ComCtrls, Grids, Buttons, PanelRights,
  LblEffct, ExtCtrls, StdCtrls, ResizePanel, PaideTreeItemBrowse,
  DBTreeView, BrowseConfig, ImgList, Mask, DateBox,
  ADODB, RCADOQuery, PowerADOQuery, siComp, siLangRT, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSCore, dxPScxGridLnk,
  cxGridCustomPopupMenu, cxGridPopupMenu, uSystemTypes;

type
  TBrwPessoa = class(TbrwTreeItemParent)
    quTreeViewIDTipoPessoa: TIntegerField;
    quTreeViewPath: TStringField;
    quTreeViewTipoPessoa: TStringField;
    quBrowseIDPessoa: TIntegerField;
    quBrowseIDTipoPessoa: TIntegerField;
    quBrowsePath: TStringField;
    quBrowsePessoa: TStringField;
    quBrowseTelefone: TStringField;
    quBrowseFax: TStringField;
    quBrowseCode: TIntegerField;
    quBrowseCountry: TStringField;
    quBrowseStateName: TStringField;
    quBrowseState: TStringField;
    quBrowseAddress: TStringField;
    quBrowseCity: TStringField;
    quBrowseZIP: TStringField;
    quBrowseEmail: TStringField;
    quBrowseContact: TStringField;
    quBrowseFederalID: TStringField;
    quBrowseSalesTax: TStringField;
    quBrowseSocialSecurity: TStringField;
    quBrowseDriverLicense: TStringField;
    quBrowseFirstName: TStringField;
    grdBrowseDBIDPessoa: TcxGridDBColumn;
    grdBrowseDBIDTipoPessoa: TcxGridDBColumn;
    grdBrowseDBPath: TcxGridDBColumn;
    grdBrowseDBPessoa: TcxGridDBColumn;
    grdBrowseDBTelefone: TcxGridDBColumn;
    grdBrowseDBFax: TcxGridDBColumn;
    grdBrowseDBCode: TcxGridDBColumn;
    grdBrowseDBCountry: TcxGridDBColumn;
    grdBrowseDBStateName: TcxGridDBColumn;
    grdBrowseDBState: TcxGridDBColumn;
    grdBrowseDBAddress: TcxGridDBColumn;
    grdBrowseDBCity: TcxGridDBColumn;
    grdBrowseDBZIP: TcxGridDBColumn;
    grdBrowseDBEmail: TcxGridDBColumn;
    grdBrowseDBContact: TcxGridDBColumn;
    grdBrowseDBFederalID: TcxGridDBColumn;
    grdBrowseDBSalesTax: TcxGridDBColumn;
    grdBrowseDBSocialSecurity: TcxGridDBColumn;
    grdBrowseDBDriverLicense: TcxGridDBColumn;
    grdBrowseDBFirstName: TcxGridDBColumn;
    grdBrowseDBLastName: TcxGridDBColumn;
    cbmName: TComboBox;
    edtNames: TEdit;
    Label2: TLabel;
    grdBrowseDBUserCode: TcxGridDBColumn;
    quBrowseUserCode: TStringField;
    quBrowseSCDate: TDateTimeField;
    quBrowseSCGov: TStringField;
    grdBrowseDBSCDate: TcxGridDBColumn;
    grdBrowseDBSCGov: TcxGridDBColumn;
    grdBrowseDBNeighborwood: TcxGridDBColumn;
    quBrowseNeighborwood: TStringField;
    quBrowseCellular: TStringField;
    grdBrowseDBCellular: TcxGridDBColumn;
    quBrowseCPF: TStringField;
    grdBrowseDBCPF: TcxGridDBColumn;
    quBrowsePhoneAreaCode: TStringField;
    quBrowseCellAreaCode: TStringField;
    grdBrowseDBCellAreaCode: TcxGridDBColumn;
    grdBrowseDBPhoneAreaCode: TcxGridDBColumn;
    quBrowseNascimento: TDateTimeField;
    grdBrowseDBNascimento: TcxGridDBColumn;
    quBrowseLastName: TStringField;
    btnConfig: TSpeedButton;
    quBrowseSystemUser: TStringField;
    grdBrowseDBSystemUser: TcxGridDBColumn;
    quBrowseStore: TStringField;
    quBrowseProfession: TStringField;
    quBrowseGender: TBooleanField;
    quBrowseSex: TStringField;
    grdBrowseDBStore: TcxGridDBColumn;
    grdBrowseDBProfession: TcxGridDBColumn;
    grdBrowseDBSex: TcxGridDBColumn;
    quBrowseDelinquent: TBooleanField;
    grdBrowseDBDelinquent: TcxGridDBColumn;
    quBrowseCreationDate: TDateTimeField;
    grdBrowseDBCreationDate: TcxGridDBColumn;
    quTreeViewsystem: TBooleanField;
    grdBrowseDBDBColumn1: TcxGridDBColumn;
    quBrowseCustomerCard: TStringField;
    pnContainerAddress: TPanel;
    lblCidade: TLabel;
    lbList: TLabel;
    cbxRecord: TComboBox;
    cmbAddress: TComboBox;
    edtAddress: TEdit;
    pnContainerDoc: TPanel;
    Label1: TLabel;
    cbmDocs: TComboBox;
    edtDocs: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure CommandClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btnExecClick(Sender: TObject);
    procedure edtNamesChange(Sender: TObject);
    procedure cbmNameChange(Sender: TObject);
    procedure quBrowseBeforeOpen(DataSet: TDataSet);
    procedure btnConfigClick(Sender: TObject);
    procedure quBrowseCalcFields(DataSet: TDataSet);
    procedure btnVideoClick(Sender: TObject);
    procedure DBTreeViewChange(Sender: TObject; Node: TTreeNode);
  private
    procedure SetHelpContext;
    function isSystemFolder(id: Integer): boolean;
  protected
    procedure OnBeforeExecSQL; Override;
    procedure OnBeforeDeleteItem; override;
    procedure OnBeforeCommandClick(pCommand : TBtnCommandType); override;
  public
    { Public declarations }
  end;

implementation

uses uWaitForm, uFchPessoa, uFchTipoComissionado, uDM, uDMGlobal,
  uFchCustomerType, ufrmEntityValidation, uSystemConst, PaiDeBrowses;

{$R *.DFM}

procedure TBrwPessoa.OnBeforeExecSQL;
begin

 if (quTreeView.Parameters.ParambyName('Path').Value = '.001%') then begin
       pnlBasicFilter.Visible := True;
       AtivaAviso;
 end else begin
         pnlBasicFilter.Visible := true;
         cbmName.ItemIndex := cbmName.Items.IndexOf('Full Name');
         pnContainerDoc.Visible := false;
         pnContainerAddress.Visible := pnContainerDoc.Visible;
     end;
end;

procedure TBrwPessoa.FormCreate(Sender: TObject);
begin
  inherited;
  //Rodrigo Mudanca
  BrwForm := TFchPessoa.Create(Self);
  btnConfig.Enabled := (DM.fUser.IDUserType = USER_TYPE_ADMINISTRATOR) and
                       (DM.fSystem.VersionType <> SYSTEM_CLIENT_TYPE);
end;

procedure TBrwPessoa.CommandClick(Sender: TObject);
begin

  Screen.Cursor := crHourGlass;

  inherited;

  Screen.Cursor := crDefault;

end;

procedure TBrwPessoa.FormShow(Sender: TObject);
begin
  inherited;
  if quTreeView.Parameters.ParamByName('Path').Value = '.001%' then
  begin
    BrwTreeForm := TFchCustomerType.Create(Self);

    if DMGlobal.IDLanguage = LANG_ENGLISH then
      grdBrowseDBSocialSecurity.Hidden := True;

  end
  else if ((quTreeView.Parameters.ParamByName('Path').Value = '.003.003%') or
     (quTreeView.Parameters.ParamByName('Path').Value = '.003.002%')) or
     (quTreeView.Parameters.ParamByName('Path').Value ='.003%') then
  begin
    BrwTreeForm := TFchTipoComissionado.Create(Self);
  end
  else if quTreeView.Parameters.ParamByName('Path').Value = '.002%' then
  begin
    if DM.fSystem.VersionType = SYSTEM_CLIENT_TYPE then
    begin
      btAdd.Enabled := False;
      btRemove.Enabled := False;
    end;
  end;

  cbxRecord.ItemIndex := 0;

end;

procedure TBrwPessoa.spHelpClick(Sender: TObject);
begin

  SetHelpContext;
  inherited;

end;

procedure TBrwPessoa.btnExecClick(Sender: TObject);
var
  sField, sField1, sField2: String;
begin
  inherited;

  case cbmName.ItemIndex of
    0: sField := '';
    1: sField := 'FirstName';
    2: sField := 'LastName';
    3: sField := 'Pessoa';
  end;

  case cbmDocs.ItemIndex of
    0: sField1 := '';
    1: sField1 := 'DriverLicense';
    2: sField1 := 'SocialSecurity';
    3: sField1 := 'CustomerCard';
    4: sField1 := 'CPF';
    5: sField1 := 'FederalID';
  end;

  case cmbAddress.ItemIndex of
    0: sField2 := '';
    1: sField2 := 'Neighborhood';
    2: sField2 := 'City';
    3: sField2 := 'State';
    4: sField2 := 'Country';
  end;

  case cbmName.ItemIndex of
    -1,0: //Todos
      aWhereBasicFilters[0] := '';
    else //Add like
      aWhereBasicFilters[0] := sField + ' Like ' + QuotedStr(trim(edtNames.Text) + '%');
  end;

  case cbmDocs.ItemIndex of
    -1,0: //Todos
      aWhereBasicFilters[1] := '';
    else //Add like
      aWhereBasicFilters[1] := sField1 + ' Like ' + QuotedStr(trim(edtDocs.Text) + '%');
  end;

  case cmbAddress.ItemIndex of
    -1,0: //Todos
      aWhereBasicFilters[2] := '';
    else //Add like
      aWhereBasicFilters[2] := sField2 + ' Like ' + QuotedStr(trim(edtAddress.Text) + '%');
  end;

  ExecBrowseSQL(True);

  DesativaAviso;

end;

procedure TBrwPessoa.edtNamesChange(Sender: TObject);
begin
  inherited;
  AtivaAviso;
end;

procedure TBrwPessoa.cbmNameChange(Sender: TObject);
begin
  inherited;

  If TComboBox(Sender).ItemIndex = 0 then
     if TComboBox(Sender).Name = 'cbmName' then
        edtNames.Text := ''
     else
        edtDocs.Text  := '';

  AtivaAviso;

end;

procedure TBrwPessoa.quBrowseBeforeOpen(DataSet: TDataSet);
begin
  inherited;

  if quTreeView.Parameters.ParambyName('Path').Value = '.001%' then
    case cbxRecord.ItemIndex of
      0 : quBrowse.MaxRecords := 10;
      1 : quBrowse.MaxRecords := 50;
      2 : quBrowse.MaxRecords := 100;
      3 : quBrowse.MaxRecords := 1000;
      4 : quBrowse.MaxRecords := 3000;
      5 : quBrowse.MaxRecords := 100000;
    end;

end;

procedure TBrwPessoa.btnConfigClick(Sender: TObject);
begin
  inherited;

  if DBTreeView.ActualIDItem <> 0 then
    with TfrmEntityValidation.Create(Self) do
      Start(DBTreeView.ActualIDItem);

end;

procedure TBrwPessoa.OnBeforeDeleteItem;
var
  iIDItem : Integer;
  sSQL : String;
begin
  inherited;
  if (DBTreeView.ActualIDItem <> 0) then
  begin
    iIDItem := DBTreeView.ActualIDItem;
    sSQL := 'Update Pessoa set Desativado = 1 where IDTipoPessoa = ' + IntToStr(iIDItem);
    DM.RunSQL(sSQL);
  end;
end;

procedure TBrwPessoa.OnBeforeCommandClick(pCommand : TBtnCommandType);
begin
  BrwForm.sParam := 'IDTipoPessoa='+IntToStr(DBTreeView.ActualIDItem)+';';
end;

procedure TBrwPessoa.quBrowseCalcFields(DataSet: TDataSet);
begin
  inherited;

  if quBrowseGender.IsNull then
    quBrowseSex.AsString := ''
  else if quBrowseGender.AsBoolean then
    quBrowseSex.AsString := 'M'
  else
    quBrowseSex.AsString := 'F';

end;

procedure TBrwPessoa.SetHelpContext;
begin

  sUrlHelp  := '';
  sUrlVideo := '';

  case DMGlobal.IDLanguage of
    LANG_ENGLISH:
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;

    LANG_PORTUGUESE:
    begin
      //Outside Agent
      If quTreeView.Parameters.ParamByName('Path').Value = '.003.002%' then
      begin
        sUrlHelp  := '';
        sUrlVideo := '';
      end else //Agency
      If quTreeView.Parameters.ParamByName('Path').Value = '.003.003%' then
      begin
        sUrlHelp  := '';
        sUrlVideo := '';
      end else //Vendor file
      If quTreeView.Parameters.ParamByName('Path').Value = '.002%' then
      begin
        (*sUrlHelp  := 'http://www.mainretail.com/treinamento/Cadastro/Cad_Fornecedor.htm';
        sUrlVideo := 'http://www.mainretail.com/treinamento/video/Adicionar_Fornecedor/Adicionar_Fornecedor.html';*)
      end else //Manufacturers Maintenance
      If quTreeView.Parameters.ParamByName('Path').Value = '.004%' then
      begin
        (*sUrlHelp  := 'http://www.mainretail.com/treinamento/Cadastro/Cad_Fabricante.htm';
        sUrlVideo := 'http://www.mainretail.com/treinamento/video/Adicionar_Fabricante/Adicionar_Fabricante.html';*)
      end else //Commissions Maintenance
      If quTreeView.Parameters.ParamByName('Path').Value = '.003%' then
      begin
        sUrlHelp  := '';
        sUrlVideo := '';
      end else //Customer File
      If quTreeView.Parameters.ParamByName('Path').Value = '.001%' then
      begin
        sUrlHelp  := '';
        sUrlVideo := '';
      end;

    end;

    LANG_SPANISH :
    begin
      sUrlHelp  := '';
      sUrlVideo := '';
    end;
  end;

end;

procedure TBrwPessoa.btnVideoClick(Sender: TObject);
begin

  SetHelpContext;
  inherited;

end;

procedure TBrwPessoa.DBTreeViewChange(Sender: TObject; Node: TTreeNode);
var
   nodeResult : TTreeNode;
begin
  inherited;

  // to avoid call root node
  btAdd.Enabled := ( not Node.IsFirstNode );

  if ( Node.IsFirstNode ) then begin
     exit;
  end;

  if ( dbTreeview.Selected <> nil ) then begin
    //amfsouza 03.16.2011 - test if node is a system folder.
    btRemoveType.Enabled := ( not isSystemFolder(dBTreeView.ActualIDItem) );
  end;

end;

function TBrwPessoa.isSystemFolder(id: Integer): boolean;
var
  quFolder: TADOQuery;
  sql: String;
begin
  result := false;

  try
    quFolder := TADOQuery.Create(nil);
    sql      := 'select System from TipoPessoa where IdTipoPessoa = :idtipopessoa';
    quFolder.Connection := dm.ADODBConnect;
    quFolder.SQL.Text := sql;
    quFolder.Parameters.ParamByName('idtipopessoa').Value := id;
    quFolder.Open;
    result := ( quFolder.FieldByName('System').Value );
  finally
    freeAndNil(quFolder);
  end;

end;

end.

