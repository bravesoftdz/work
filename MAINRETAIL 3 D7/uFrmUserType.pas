unit uFrmUserType;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDEFICHAS, StdCtrls, Mask, DBCtrls, DBTables, DB,
  LblEffct, ExtCtrls, Grids, Buttons, ADODB, RCADOQuery,
  PowerADOQuery, FormConfig, siComp, siLangRT, DBGrids, SMDBGrid, ComCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, SuperComboADO;

type
  TbrwFrmUserType = class(TbrwFrmParent)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    dsMenuRigths: TDataSource;
    quMenuRight: TADOQuery;
    quMenuRightModuleName: TStringField;
    quMenuRightCanAccess: TBooleanField;
    quMenuRightCanInsert: TBooleanField;
    quMenuRightCanDelete: TBooleanField;
    quMenuRightCanPrint: TBooleanField;
    quMenuRightCanUpdate: TBooleanField;
    quMenuRightParentMenu: TStringField;
    quFuncRight: TADOQuery;
    dsFuncRight: TDataSource;
    quMenuRightUserTypeID: TIntegerField;
    quMenuRightIDMenu: TIntegerField;
    quMenuRightIDSubMenu: TIntegerField;
    quFormIDUserType: TIntegerField;
    quFuncRightIDUserType: TIntegerField;
    quFuncRightSysFunction: TStringField;
    quFuncRightAcesso: TBooleanField;
    quFuncRightIDMenu: TIntegerField;
    quFuncRightIDSubMenu: TIntegerField;
    Label3: TLabel;
    Label9: TLabel;
    quFormName: TStringField;
    quMenuRightIDMenuName: TStringField;
    PageControl1: TPageControl;
    tsModules: TTabSheet;
    tsReport: TTabSheet;
    Label5: TLabel;
    cbxMenu: TComboBox;
    quReportRight: TADOQuery;
    dsReportRight: TDataSource;
    quReportRightIDUserType: TIntegerField;
    quReportRightAccess: TBooleanField;
    quReportRightRepName: TStringField;
    quReportRightFolderName: TStringField;
    SMDBGrid1: TSMDBGrid;
    quReportRightEdit: TBooleanField;
    quMenuRightCanExport: TBooleanField;
    quFuncRightIDSysFunction: TIntegerField;
    grdRights: TcxGrid;
    grdRightsDB: TcxGridDBTableView;
    grdRightsLevel1: TcxGridLevel;
    grdRightsDBIDSysFunction: TcxGridDBColumn;
    grdRightsDBSysFunction: TcxGridDBColumn;
    grdRightsDBAcesso: TcxGridDBColumn;
    gridMenu: TcxGrid;
    grdMenuDB: TcxGridDBTableView;
    grdMenuLevel1: TcxGridLevel;
    grdMenuDBModuleName: TcxGridDBColumn;
    grdMenuDBCanAccess: TcxGridDBColumn;
    grdMenuDBCanInsert: TcxGridDBColumn;
    grdMenuDBCanDelete: TcxGridDBColumn;
    grdMenuDBCanPrint: TcxGridDBColumn;
    grdMenuDBCanUpdate: TcxGridDBColumn;
    grdMenuDBCanExport: TcxGridDBColumn;
    btnImportar: TBitBtn;
    pnlImportUserType: TPanel;
    lbUsertType: TLabel;
    scUserType: TSuperComboADO;
    btnImportType: TBitBtn;
    cmdUpdateMenu: TADOCommand;
    cmdUpdateFunction: TADOCommand;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spHelpClick(Sender: TObject);
    procedure quFormAfterOpen(DataSet: TDataSet);
    procedure quMenuRightCalcFields(DataSet: TDataSet);
    procedure quMenuRightAfterEdit(DataSet: TDataSet);
    procedure cbxMenuChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure quFuncRightAfterInsert(DataSet: TDataSet);
    procedure btnImportarClick(Sender: TObject);
    procedure btnImportTypeClick(Sender: TObject);
  private
    { Private declarations }

    procedure MenuRightClose;
    procedure MenuRightOpen;
    procedure MenuRightPost;

    procedure FuncRightClose;
    procedure FuncRightOpen;
    procedure FuncRightPost;

    procedure RepRightClose;
    procedure RepRightOpen;
    procedure RepRightPost;

    procedure GetMenu;

  public
    { Public declarations }
  end;

implementation

uses uDM, uMsgBox, uMsgConstant, uSystemTypes, uDMGlobal;

{$R *.DFM}

procedure TbrwFrmUserType.GetMenu;
begin

  cbxMenu.Items.Clear;

  with DM.quFreeSQL do
      begin
      if Active then
         Close;
      SQL.Clear;
      SQL.Add('SELECT MI.IDMenu, MIL.MenuName');
      SQL.Add('FROM MenuMain MI (NOLOCK)');
      SQL.Add('JOIN MenuMainLanguage MIL (NOLOCK) ON (MI.IDMenu = MIL.IDMenu)');
      SQL.Add('WHERE MIL.IDLanguage = ' + IntToStr(DMGlobal.IDLanguage));
      Open;
      First;
      While not EOF do
         begin
         cbxMenu.Items.Add(FieldByName('MenuName').AsString);
         Next;
         end;
      Close;
      end;

  cbxMenu.ItemIndex := 0;
end;

procedure TbrwFrmUserType.FuncRightClose;
begin

    FuncRightPost;

    with quFuncRight do
       if Active then
          Close;

end;

procedure TbrwFrmUserType.FuncRightOpen;
begin

   with quFuncRight do
      if not Active then
         begin
         Parameters.ParamByName('UserTypeID').Value := quMenuRightUserTypeID.AsInteger;
         Parameters.ParamByName('IDMenu').Value     := quMenuRightIDSubMenu.AsInteger;
         Parameters.ParamByName('IDSubMenu').Value  := quFormIDUserType.AsInteger;
         Parameters.ParamByName('IDLanguage').Value := DMGlobal.IDLanguage;
         Open;
         end;

end;


procedure TbrwFrmUserType.FuncRightPost;
begin

   with quFuncRight do
      if Active then
         if State in dsEditModes then
            Post;

end;


procedure TbrwFrmUserType.MenuRightClose;
begin

    MenuRightPost;

    with quMenuRight do
       if Active then
          Close;

end;


procedure TbrwFrmUserType.MenuRightOpen;
begin

    with quMenuRight do
       if not Active then
          begin
          Parameters.ParamByName('UserTypeID').Value := quFormIDUserType.AsInteger;
          Parameters.ParamByName('IDLanguage').Value := DMGlobal.IDLanguage;
          Parameters.ParamByName('IDMenu').Value     := cbxMenu.ItemIndex+1;
          Open;
          end;

end;

procedure TbrwFrmUserType.MenuRightPost;
begin

   with quMenuRight do
      if Active then
         if State in dsEditModes then
            Post;

end;


procedure TbrwFrmUserType.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  MenuRightClose;
  FuncRightClose;
  RepRightClose; 

end;

procedure TbrwFrmUserType.spHelpClick(Sender: TObject);
begin
  inherited;

  Application.HelpContext(2030);
  
end;

procedure TbrwFrmUserType.quFormAfterOpen(DataSet: TDataSet);
begin
  inherited;

  MenuRightClose;
  MenuRightOpen;
  FuncRightClose;
  FuncRightOpen;
  RepRightClose;
  RepRightOpen;
  btnImportar.Visible := (frmCommand = btInc); 

end;

procedure TbrwFrmUserType.quMenuRightCalcFields(DataSet: TDataSet);
begin
  inherited;

  quMenuRightIDMenuName.AsString := quMenuRightIDMenu.AsString + ' - ' +
                                    quMenuRightParentMenu.AsString;

end;

procedure TbrwFrmUserType.quMenuRightAfterEdit(DataSet: TDataSet);
begin
  inherited;

  quForm.Edit;

end;

procedure TbrwFrmUserType.cbxMenuChange(Sender: TObject);
begin
  inherited;
  MenuRightClose;
  MenuRightOpen;
end;

procedure TbrwFrmUserType.FormCreate(Sender: TObject);
begin
  inherited;
  GetMenu;
end;

procedure TbrwFrmUserType.quFuncRightAfterInsert(DataSet: TDataSet);
begin
  inherited;
  DataSet.Cancel;
end;

procedure TbrwFrmUserType.RepRightClose;
begin

    RepRightPost;

    with quReportRight do
       if Active then
          Close;

end;

procedure TbrwFrmUserType.RepRightOpen;
begin

    with quReportRight do
       if not Active then
          begin
          Parameters.ParamByName('UserTypeID').Value := quFormIDUserType.AsInteger;
          Open;
          end;

end;

procedure TbrwFrmUserType.RepRightPost;
begin
    with quReportRight do
      if Active then
         if State in dsEditModes then
            Post;

end;

procedure TbrwFrmUserType.btnImportarClick(Sender: TObject);
begin
  inherited;
  pnlImportUserType.Visible := True;
  btnImportar.Visible := False;
  scUserType.SpcWhereClause := 'IDUserType <> ' + quFormIDUserType.AsString;
end;

procedure TbrwFrmUserType.btnImportTypeClick(Sender: TObject);
begin
  inherited;

  if (scUserType.LookUpValue <> '') then
    if MsgBox(MSG_QST_CONFIRM, vbYesNo + vbQuestion) = vbYes then
    begin
      pnlImportUserType.Visible := False;
      btnImportar.Visible := True;

      with cmdUpdateMenu do
      begin
        Parameters.ParamByName('IDSelected').Value := StrToInt(scUserType.LookUpValue);
        Parameters.ParamByName('IDActual').Value := quFormIDUserType.AsInteger;
        Execute;
      end;

      with cmdUpdateFunction do
      begin
        Parameters.ParamByName('IDSelected').Value := StrToInt(scUserType.LookUpValue);
        Parameters.ParamByName('IDActual').Value := quFormIDUserType.AsInteger;
        Execute;
      end;

      MenuRightClose;
      MenuRightOpen;

    end;
end;

end.
