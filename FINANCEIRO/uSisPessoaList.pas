unit uSisPessoaList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BrowseConfig, Db, Menus, DBTables, Buttons, dxBar,
  StdCtrls, ExtCtrls, Grids,
  uParentList, dxGrClms, dxDBGrid, dxDBGridPrint, dxBarExtItems,
  dxBarExtDBItems, dxCntner, dxTL, ComCtrls, dxtree, dxdbtree,
  DBTreeView, ImgList, uSisPessoaFch, dxDBCtrl, ADODB, PowerADOQuery,
  dxPSCore, dxPSdxTLLnk, dxPSdxDBCtrlLnk, dxPSdxDBGrLnk, siComp, siLangRT;

type
  TSisPessoaList = class(TParentList)
    Splitter: TSplitter;
    DBTreeView: TDBTreeView;
    quTreeView: TADOQuery;
    quTreeViewIDTipoPessoa: TIntegerField;
    quTreeViewPath: TStringField;
    quTreeViewTipoPessoa: TStringField;
    quTreeViewPathName: TStringField;
    quBrowseIDPessoa: TIntegerField;
    quBrowseCode: TIntegerField;
    quBrowsePessoa: TStringField;
    brwGridCode: TdxDBGridMaskColumn;
    brwGridPessoa: TdxDBGridMaskColumn;
    quBrowseAddress: TStringField;
    quBrowseCity: TStringField;
    quBrowseZipCode: TStringField;
    quBrowseCountry: TStringField;
    quBrowsePhone: TStringField;
    quBrowseCell: TStringField;
    quBrowseFax: TStringField;
    quBrowseBeeper: TStringField;
    quBrowseEmail: TStringField;
    quBrowseIDState: TStringField;
    quBrowseFederalID: TStringField;
    quBrowseSalesTax: TStringField;
    quBrowseSocialSecurity: TStringField;
    quBrowseDriverLicense: TStringField;
    quBrowseFirstName: TStringField;
    quBrowseLastName: TStringField;
    brwGridAddress: TdxDBGridMaskColumn;
    brwGridCity: TdxDBGridMaskColumn;
    brwGridZipCode: TdxDBGridMaskColumn;
    brwGridCountry: TdxDBGridMaskColumn;
    brwGridPhone: TdxDBGridMaskColumn;
    brwGridCell: TdxDBGridMaskColumn;
    brwGridFax: TdxDBGridMaskColumn;
    brwGridBeeper: TdxDBGridMaskColumn;
    brwGridEmail: TdxDBGridMaskColumn;
    brwGridIDState: TdxDBGridMaskColumn;
    brwGridFederalID: TdxDBGridMaskColumn;
    brwGridSalesTax: TdxDBGridMaskColumn;
    brwGridSocialSecurity: TdxDBGridMaskColumn;
    brwGridDriverLicense: TdxDBGridMaskColumn;
    brwGridFirstName: TdxDBGridMaskColumn;
    brwGridLastName: TdxDBGridMaskColumn;
    bbExportProgram: TdxBarButton;
    Label2: TLabel;
    Label1: TLabel;
    cmbName: TComboBox;
    Label3: TLabel;
    edtName: TEdit;
    Label4: TLabel;
    cmbDocs: TComboBox;
    edtDocs: TEdit;
    quBrowseEmployeeID: TStringField;
    brwGridEmployeeID: TdxDBGridColumn;
    procedure FormCreate(Sender: TObject);
    procedure DBTreeViewDblClick(Sender: TObject);
    procedure bbListaNovoClick(Sender: TObject);
    procedure bbListaOpenClick(Sender: TObject);
    procedure brwGridDblClick(Sender: TObject);
    procedure DBTreeViewGetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure bbExportProgramClick(Sender: TObject);
    procedure cmbNameChange(Sender: TObject);
  private
    { Private declarations }
    MyPathID: String;
    MyIDPessoaTipo: Integer;
    SisPessoaFch: TSisPessoaFch;

    procedure OnBeforeStart; override;
    procedure OnAfterStart; override;
  public
    { Public declarations }
    function  ListParamRefresh : integer; override;
  end;

implementation

{$R *.DFM}

uses uDM, uSystemTypes, uParamFunctions, uSisEntityWiz;

function TSisPessoaList.ListParamRefresh : integer;
var
 sField, sField1 : String;
begin

   Case cmbName.ItemIndex of
      0 : sField := '';
      1 : sField := 'P.PessoaFirstName';
      2 : sField := 'P.PessoaLastName';
      3 : sField := 'P.NomeJuridico';
   end;


   Case cmbDocs.ItemIndex of
      0 : sField1 := '';
      1 : sField1 := 'P.OrgaoEmissor';
      2 : sField1 := 'P.CartTrabalho';
      3 : sField1 := 'P.CustomerCard';
      4 : sField1 := 'P.CPF';
   end;

  case cmbName.ItemIndex of
    -1,0: //Todos
      WhereBasicFilter[2] := '';
    else //Add like
      WhereBasicFilter[2] := sField+ ' Like ' + QuotedStr(trim(edtName.Text) + '%');
  end;

  case cmbDocs.ItemIndex of
    -1,0: //Todos
      WhereBasicFilter[3] := '';
    else //Add like
      WhereBasicFilter[3] := sField1+ ' Like ' + QuotedStr(trim(edtDocs.Text) + '%');
  end;

  ListRefresh;

  DesligaAviso;
 

end;

procedure TSisPessoaList.FormCreate(Sender: TObject);
begin
  inherited;
  SisPessoaFch := TSisPessoaFch.Create(Self);
end;

procedure TSisPessoaList.OnBeforeStart;
begin
  // Filtro as pessoas pelo tipo selecionado
  if MyParametro <> '' then
    begin
      // O Tree View com os tipos de pessoas deverá abrir filtrado
      with quTreeView do
        begin
          if Active then
            Close;

          Parameters.ParamByName('Path').Value := ParseParam(MyParametro, 'Path') + '%';

          Open;

          Splitter.Visible   := False;
          DBTreeView.Visible := (RecordCount > 1);
          Splitter.Visible   := (RecordCount > 1);

          if not IsEmpty then
            DBTreeView.LoadTreeView;

          Close;
        end;

    if Trim(MyParametro) = 'Path=.001' then
       HelpContext := 6
    else if Trim(MyParametro) = 'Path=.002' then
       HelpContext := 8
    else if Trim(MyParametro) = 'Path=.003' then
       HelpContext := 10
    else if Trim(MyParametro) = 'Path=.004' then
       HelpContext := 12
    end;


  if quTreeView.Parameters.ParambyName('Path').Value = '.001%' then
     begin
     quBrowse.MaxRecords    := 1000;
     pnlBasicFilter.Visible := True;
     pnlExecuta.Visible     := True;
     LigaAviso;
     end;

end;

procedure TSisPessoaList.OnAfterStart;
begin
  with DBTreeView do
    if Items.Count > 0 then
      begin
        Selected := Items[0];
        DBTreeViewDblClick(Selected);
      end;
end;


procedure TSisPessoaList.DBTreeViewDblClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  // Aplico o novo filtro no browse
  WhereBasicFilter[1] := 'P.IDTipoPessoa = ' + IntTostr(DBTreeView.ActualIDItem);

  for i := 0 to DBTreeView.Items.Count-1 do
    DBTreeView.Items[i].ImageIndex := 35;

  DBTreeView.Selected.ImageIndex := 34;

  brwGridPessoa.Caption := DBTreeView.ActualName;

  ListRefresh;

  // Preencho os field de sugestão
  with quBrowse do
    begin
      FilterFields.Clear;
      FilterValues.Clear;
      FilterFields.Add('IDTipoPessoa');
      FilterValues.Add(IntTostr(DBTreeView.ActualIDItem));
    end;

  SisPessoaFch.Param := 'IDTipoPessoa=' + IntTostr(DBTreeView.ActualIDItem);


end;

procedure TSisPessoaList.bbListaNovoClick(Sender: TObject);
var
  ID1, ID2: String;

begin
  //inherited;

  if SisPessoaFch.Start(btInc, quBrowse, False, ID1, ID2, '', '', brwGrid) then
    begin
      // Teoricamente a ficha faz tudo
    end;

end;

procedure TSisPessoaList.bbListaOpenClick(Sender: TObject);
var
  ID1, ID2: String;

begin
  //inherited;

  ID1 := quBrowseIDPessoa.AsString;
  ID2 := '';

  if SisPessoaFch.Start(btAlt, quBrowse, False, ID1, ID2, '', '', brwGrid) then
    begin
      // Teoricamente a ficha faz tudo
    end;

end;

procedure TSisPessoaList.brwGridDblClick(Sender: TObject);
begin
  //inherited;
  if bbListaOpen.Enabled then
    bbListaOpenClick(nil);


end;

procedure TSisPessoaList.DBTreeViewGetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  Node.SelectedIndex := Node.ImageIndex;
end;

procedure TSisPessoaList.FormDestroy(Sender: TObject);
begin
  inherited;

  SisPessoaFch.Free;


end;

procedure TSisPessoaList.bbExportProgramClick(Sender: TObject);
var
  SisEntityWzd: TSisEntityWiz;
begin
  inherited;

  SisEntityWzd := nil;

  Try
     SisEntityWzd := TSisEntityWiz.Create(Self);
     if SisEntityWzd.Start then
        ListRefresh;
  finally
     FreeAndNil(SisEntityWzd);
  end;

end;

procedure TSisPessoaList.cmbNameChange(Sender: TObject);
begin
  inherited;

    If TComboBox(Sender).ItemIndex = 0 then
     if TComboBox(Sender).Name = 'cmbName' then
        edtName.Text := ''
     else
        edtDocs.Text  := '';

  LigaAviso;

end;

Initialization
  RegisterClass(TSisPessoaList);


end.
