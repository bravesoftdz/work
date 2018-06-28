unit uSisMenuEditorFch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentDialogFrm, dxdbtrel, StdCtrls, DBCtrls, Mask, DBTables, Db,
  ComCtrls, dxtree, dxdbtree, ExtCtrls, Buttons, dxGrClms, dxDBGrid,
  dxCntner, dxTL, dxDBCtrl, dxDBTLCl, ADODB, dxEditor, dxExEdtr, dxEdLib,
  dxDBELib, dximctrl, siComp, siLangRT;

type
  TSisMenuEditorFch = class(TParentDialogFrm)
    Panel1: TPanel;
    imgOn: TImage;
    lblPTituloShadow: TLabel;
    lblPTitulo: TLabel;
    dxDBTreeView1: TdxDBTreeView;
    quMenuItem: TADOQuery;
    dsMenuItem: TDataSource;
    quMenuItemIDMenuItem: TIntegerField;
    quMenuItemMenuItem: TStringField;
    quMenuItemFormID: TIntegerField;
    quMenuItemIDMenuItemParent: TIntegerField;
    quMenuItemLoaderType: TIntegerField;
    quMenuItemMenuBarBefore: TBooleanField;
    quMenuItemPriority: TIntegerField;
    quMenuItemParent: TADOQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    BooleanField1: TBooleanField;
    IntegerField6: TIntegerField;
    dsMenuItemParent: TDataSource;
    quGrupo: TADOQuery;
    dsGrupo: TDataSource;
    quDel: TADOQuery;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    edMenuItem: TDBEdit;
    tsOperacao: TTabSheet;
    tsAcesso: TTabSheet;
    Splitter1: TSplitter;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1Acessa: TdxDBGridCheckColumn;
    dxDBGrid1Grupo: TdxDBGridMaskColumn;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    grdAcao: TdxDBGrid;
    Panel5: TPanel;
    dxDBGrid2: TdxDBGrid;
    dxDBGridCheckColumn1: TdxDBGridCheckColumn;
    dxDBGridMaskColumn1: TdxDBGridMaskColumn;
    btAcaoNova: TSpeedButton;
    btAcaoRemove: TSpeedButton;
    quOperacao: TADOQuery;
    dsOperacao: TDataSource;
    quOperacaoIDMenuItem: TIntegerField;
    quOperacaoIDOperacao: TIntegerField;
    quOperacaoOperacao: TStringField;
    grdAcaoIDOperacao: TdxDBGridMaskColumn;
    grdAcaoOperacao: TdxDBGridMaskColumn;
    btOperacaoPost: TSpeedButton;
    quOperacaoPermissao: TADOQuery;
    dsOperacaoPermissa: TDataSource;
    quOperacaoPermissaoIDMenuItem: TIntegerField;
    quOperacaoPermissaoIDGrupo: TIntegerField;
    quOperacaoPermissaoIDOperacao: TIntegerField;
    quOperacaoPermissaoPermissao: TBooleanField;
    quOperacaoPermissaoOperacao: TStringField;
    quGrupoIDMenuItem: TIntegerField;
    quGrupoGrupo: TStringField;
    quGrupoAcessa: TBooleanField;
    quGrupoIDGrupo: TIntegerField;
    quMenuItemObs: TStringField;
    quMenuItemImageIndex: TIntegerField;
    lvPreview: TListView;
    Label9: TLabel;
    quMenuItemParametro: TStringField;
    Label10: TLabel;
    edImageIndex: TDBEdit;
    ieImageIndex: TdxDBImageEdit;
    quMenuItemClassName: TStringField;
    imgShow: TImage;
    pnlAdv: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBEdit4: TDBEdit;
    LookTreeParente: TdxDBLookupTreeView;
    Button1: TButton;
    Button3: TButton;
    Button2: TButton;
    DBMemo1: TDBMemo;
    DBEdit6: TDBEdit;
    tsLanguage: TTabSheet;
    Label11: TLabel;
    cbxLanguage: TdxImageComboBox;
    btnPath: TSpeedButton;
    Label12: TLabel;
    edtDecimal: TEdit;
    Label13: TLabel;
    edtThousand: TEdit;
    Label14: TLabel;
    cbxDateFormat: TComboBox;
    lbEx1: TLabel;
    lbEx2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btAcaoNovaClick(Sender: TObject);
    procedure btAcaoRemoveClick(Sender: TObject);
    procedure btOperacaoPostClick(Sender: TObject);
    procedure quMenuItemAfterScroll(DataSet: TDataSet);
    procedure quOperacaoNewRecord(DataSet: TDataSet);
    procedure quOperacaoAfterPost(DataSet: TDataSet);
    procedure quGrupoAfterScroll(DataSet: TDataSet);
    procedure edImageIndexChange(Sender: TObject);
    procedure imgShowDblClick(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure quMenuItemBeforeOpen(DataSet: TDataSet);
    procedure quMenuItemParentBeforeOpen(DataSet: TDataSet);
    procedure edtDecimalChange(Sender: TObject);
  private
    { Private declarations }
    UserTime: Boolean;
    bEdit : Boolean;

    procedure OperacaoPost;
    procedure OperacaoOpen;
    procedure OperacaoClose;
    procedure OperacaoRefresh;

    procedure OperacaoPermissaoPost;
    procedure OperacaoPermissaoOpen;
    procedure OperacaoPermissaoClose;
    procedure OperacaoPermissaoRefresh;

    procedure RefreshExamples;
  public
    { Public declarations }
  end;

var
  SisMenuEditorFch: TSisMenuEditorFch;

implementation

{$R *.DFM}

uses uMsgBox, uDM, uNumericFunctions, uSisMain, uDMGlobal, Registry,
     uMsgConstant, ufrmLanguage, uOMTranslateScript, uOperationSystem;

procedure TSisMenuEditorFch.FormShow(Sender: TObject);
var
  buildInfo: String;
begin
  inherited;

{  if Application.Title = 'Editor de Menu' then
    begin
      quMenuItem.DatabaseName := 'db1';
      quGrupo.DatabaseName := 'db1';
      quMenuItemParent.DatabaseName := 'db1';
      quOperacao.DatabaseName := 'db1';
      quOperacaoPermissao.DatabaseName := 'db1';
    end
  else
    begin
      quMenuItem.DatabaseName := 'RetailDB';
      quGrupo.DatabaseName := 'RetailDB';
      quMenuItemParent.DatabaseName := 'RetailDB';
      quOperacao.DatabaseName := 'RetailDB';
      quOperacaoPermissao.DatabaseName := 'RetailDB';
    end;}

  UserTime := False;
  quMenuItem.Open;
  quGrupo.Open;
  quMenuItemParent.Open;
  OperacaoOpen;
  OperacaoPermissaoOpen;
  UserTime := True;

  // Seta os parametros locais da maquina
  with TRegistry.Create do
    begin
    if ( getOS(buildInfo) = osW7 ) then
       RootKey:= HKEY_CURRENT_USER
    else
       RootKey := HKEY_LOCAL_MACHINE;

    OpenKey('SOFTWARE\Applenet\OfficeManager', True);
      cbxLanguage.ItemIndex  := (ReadInteger('DefaultLanguage')-1);
      edtDecimal.Text        := ReadString('DefaultDecimalSeparator');
      edtThousand.Text       := ReadString('DefaultThousandSeparator');
      cbxDateFormat.Text     := ReadString('DefaultDateFormat');
      Free;
    end;

end;

procedure TSisMenuEditorFch.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
    bSave : Boolean;
    buildInfo: String;
begin
  inherited;

  if (quMenuItem.State in dsEditModes) or
     (quGrupo.State in dsEditModes) then
     bSave := (MsgBox(MSG_QST_SAVE_UNSAVE_CHANGES, vbQuestion + vbYesNo) = vbYes);

  with quMenuItem do
    begin
      if State in dsEditModes then
         if bSave then
            Post
         else
            Cancel;
      Close;
    end;

  with quGrupo do
    begin
      if State in dsEditModes then
         if bSave then
            Post
         else
            Cancel;
      Close;
    end;

  OperacaoClose;
  OperacaoPermissaoClose;

  quMenuItemParent.Close;

  if bEdit then
     begin
     // Seta os parametros locais da maquina
     with TRegistry.Create do
        begin

        if ( getOS(buildInfo) = osW7 ) then
             RootKey:= HKEY_CURRENT_USER
        else
             RootKey := HKEY_LOCAL_MACHINE;

        OpenKey('SOFTWARE\Applenet\OfficeManager', True);
        WriteInteger('DefaultLanguage', cbxLanguage.ItemIndex+1);
        WriteString('DefaultDecimalSeparator', edtDecimal.Text);
        WriteString('DefaultThousandSeparator', edtThousand.Text);
        WriteString('DefaultDateFormat', cbxDateFormat.Text);
        Free;
        end;

     //Update Database with Language Scrip
     If (DMGlobal.IDLanguage <> cbxLanguage.ItemIndex+1) then
        if (MsgBox(MSG_QST_CONFIRM_CHANGE_LANG, vbYesNo + vbSuperCritical) = vbYes) then
          TranslateDatabase(cbxLanguage.ItemIndex+1);
     end;


  Action := caFree;
end;

procedure TSisMenuEditorFch.Button1Click(Sender: TObject);
var
  IDMenuItem: String;
begin
  inherited;
  with quMenuItem do
    begin
      if State in dsEditModes then
        Post;
      IDMenuItem := FieldByName('IDMenuItem').AsString;
      Close;
      Open;
      if IDMenuItem <> '' then
        Locate('IDMenuItem', IDMenuItem, []);
    end;
end;

procedure TSisMenuEditorFch.Button3Click(Sender: TObject);
var
  IDMenuItem: Integer;

begin
  inherited;
  IDMenuItem := quMenuItemIDMenuItem.AsInteger;
  quMenuItem.Append;
  quMenuItemIDMenuItemParent.AsInteger := IDMenuItem;

end;

procedure TSisMenuEditorFch.FormCreate(Sender: TObject);
var
  i : integer;
begin
  inherited;
  Self.Caption := Application.Title;

  ieImageIndex.Values.Clear;
  ieImageIndex.Descriptions.Clear;

  for i:=0 to SisMain.imgMenu.Count-1 do
    begin
    ieImageIndex.Values.Add(IntToStr(i));
    ieImageIndex.Descriptions.Add(IntToStr(i));
    end;

  ieImageIndex.Values.Add('-1');
  ieImageIndex.Descriptions.Add('-1');

  bEdit := False;

end;

procedure TSisMenuEditorFch.Button2Click(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_SURE, vbQuestion + vbYesNoCancel) = vbYes then
    begin
      with quDel do
        begin
          Parameters.ParamByName('IDMenuItem').Value := quMenuItemIDMenuItem.AsInteger;
          ExecSQL;
        end;
      with quMenuItem do
        begin
          Delete;
        end;
    end;
end;



procedure TSisMenuEditorFch.btAcaoNovaClick(Sender: TObject);
begin
  inherited;
  OperacaoPost;
  quOperacao.Append;

end;

procedure TSisMenuEditorFch.btAcaoRemoveClick(Sender: TObject);
begin
  inherited;
  if MsgBox(MSG_QST_DELETE, vbQuestion + vbYesNo) = vbyes then
    quOperacao.Delete;
end;

procedure TSisMenuEditorFch.OperacaoPost;
begin
  with quOperacao do
    if Active then
      if State in dsEditModes then
        begin
          UpdateRecord;
          Post;
        end;
end;

procedure TSisMenuEditorFch.OperacaoOpen;
begin
  if UserTime then
    with quOperacao do
      if not Active then
        begin
          Parameters.ParamByName('IDMenuItem').Value := quMenuItemIDMenuItem.AsInteger;
          Open;
        end;

end;

procedure TSisMenuEditorFch.OperacaoClose;
begin
  if UserTime then
    begin
      OperacaoPost;
      quOperacao.Close;
    end;

end;

procedure TSisMenuEditorFch.OperacaoRefresh;
var
  ID: Integer;

begin
  if UserTime then
    begin
      if quOperacao.Active then
        begin
          ID := quOperacaoIDOperacao.AsInteger;
          OperacaoClose;
        end
      else
        ID := -1;

      OperacaoOpen;

      if ID <> -1 then
        quOperacao.Locate('IDOperacao', IntToStr(ID), []);
    end;

end;

procedure TSisMenuEditorFch.btOperacaoPostClick(Sender: TObject);
begin
  inherited;
  OperacaoPost;
end;



procedure TSisMenuEditorFch.quMenuItemAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if UserTime then
    begin
      OperacaoRefresh;
      OperacaoPermissaoRefresh;
    end;

end;

procedure TSisMenuEditorFch.quOperacaoNewRecord(DataSet: TDataSet);
begin
  inherited;
  quOperacaoIDMenuItem.AsInteger := quMenuItemIDMenuItem.AsInteger;
end;


procedure TSisMenuEditorFch.OperacaoPermissaoOpen;
begin
{
  if UserTime then
    with quOperacaoPermissao do
      if not Active then
        begin
          ParamByName('IDMenuItem').AsInteger := quMenuItemIDMenuItem.AsInteger;
          ParamByName('IDGrupo').AsInteger := quGrupoIDGrupo.AsInteger;
          Open;
        end;

        }
end;

procedure TSisMenuEditorFch.OperacaoPermissaoClose;
begin
  if UserTime then
    begin
      OperacaoPermissaoPost;
      quOperacaoPermissao.Close;
    end;

end;

procedure TSisMenuEditorFch.OperacaoPermissaoPost;
begin
  if UserTime then
    with quOperacaoPermissao do
      if Active then
        if State in dsEditModes then
          begin
            UpdateRecord;
            Post;
          end;
end;

procedure TSisMenuEditorFch.OperacaoPermissaoRefresh;
begin
  if UserTime then
    begin
      OperacaoPermissaoClose;
      OperacaoPermissaoOpen;
    end;

end;

procedure TSisMenuEditorFch.quOperacaoAfterPost(DataSet: TDataSet);
begin
  inherited;
  if UserTime then
    OperacaoPermissaoRefresh;
end;

procedure TSisMenuEditorFch.quGrupoAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if UserTime then
    OperacaoPermissaoRefresh;
end;

procedure TSisMenuEditorFch.edImageIndexChange(Sender: TObject);
begin
  inherited;
  lvPreview.Items[0].ImageIndex := myStrToInt(edImageIndex.Text);
  lvPreview.Items[0].Caption := edMenuItem.Text;
end;

procedure TSisMenuEditorFch.imgShowDblClick(Sender: TObject);
begin
  inherited;
  pnlAdv.Visible        := True;
  tsOperacao.TabVisible := True;
end;

procedure TSisMenuEditorFch.btnPathClick(Sender: TObject);
begin
  inherited;
   //Show
   with TfrmLanguage.Create(Self) do
      Start(OM); 
end;

procedure TSisMenuEditorFch.quMenuItemBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  quMenuItem.Parameters.ParamByName('IDLanguage').Value := DMGlobal.IDLanguage;
end;

procedure TSisMenuEditorFch.quMenuItemParentBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  quMenuItemParent.Parameters.ParamByName('IDLanguage').Value := DMGlobal.IDLanguage;
end;

procedure TSisMenuEditorFch.RefreshExamples;
begin
  lbEx1.Caption := '1'+edtThousand.Text+'000'+edtDecimal.Text+'00';
  lbEx2.Caption := FormatDateTime(cbxDateFormat.Text ,now);
end;

procedure TSisMenuEditorFch.edtDecimalChange(Sender: TObject);
begin
  inherited;
  RefreshExamples;
  bEdit := True;
end;

end.
