unit uSisMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentAllFrm, ExtCtrls, StdCtrls, LblEffct, ComCtrls, Buttons, Menus,
  Db, DBTables, Mask, Grids, uSisMenuFxd, ShellAPI, uSystemConst, uWelcome,
  uSisSegurancaFrm, ImgList, DBCtrls, ADODB, OleCtrls, SHDocVw, dxBar,
  dxBarExtItems, dxdbtrel, dxTL, dxCntner, uStringFunctions, uClasseFunctions,
  uBuildMenu, uPopUpMenuHistory, siComp, siLangRT;

Const
  LOADER_TYPE_BROWSER    = 1;
  LOADER_TYPE_FCH_ADD    = 2;
  LOADER_TYPE_FCH_UPDATE = 3;
  LOADER_TYPE_MODAL_FORM = 4;
  LOADER_TYPE_NO_FORM    = 5;
  LOADER_TYPE_SHELL_API  = 6;

type
  TSisMain = class(TParentAllFrm)
    tmrTime: TTimer;
    StatusBar: TStatusBar;
    pnlAtalho: TPanel;
    pnlControleAcesso: TPanel;
    pnlDate: TPanel;
    lblDia: TLabel;
    lblMes: TLabel;
    tmrExpira: TTimer;
    trmAviso: TTimer;
    pnlShow: TPanel;
    quPreencheEmpresa: TADOQuery;
    quPreencheMainMenu: TADOQuery;
    XPanel: TPanel;
    PrinterSetupDialog: TPrinterSetupDialog;
    spUserRights: TADOStoredProc;
    pnlItemToBuy: TPanel;
    Label4: TLabel;
    edtItemsBuy: TLabel;
    pnlPassDue: TPanel;
    Label6: TLabel;
    edtPastDue: TLabel;
    pnlBreakEven: TPanel;
    Label14: TLabel;
    edtBKEven: TLabel;
    quQuickInfo: TADOQuery;
    tmrQuickInfo: TTimer;
    dsQuickInfo: TDataSource;
    pnlItemOnHold: TPanel;
    Label2: TLabel;
    edtItemsHold: TLabel;
    pnlTotalSales: TPanel;
    Label9: TLabel;
    edtTotalSales: TLabel;
    pnlAccPayApprove: TPanel;
    Label1: TLabel;
    edtPayApp: TLabel;
    pnlAccRecApprove: TPanel;
    Label3: TLabel;
    edtRecAppr: TLabel;
    imgQuickInfo: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    dxMainBar: TdxBarManager;
    btnInternet: TdxBarLargeButton;
    btnBack: TdxBarLargeButton;
    btnNext: TdxBarLargeButton;
    imgLarge: TImageList;
    btnClose: TdxBarLargeButton;
    btnQuick: TdxBarLargeButton;
    btnHelp: TdxBarLargeButton;
    Image: TImage;
    btnHistory: TdxBarButton;
    btnEmail: TdxBarLargeButton;
    quQuickInfoTotalSale: TBCDField;
    quQuickInfoItemOnPO: TIntegerField;
    quQuickInfoItemOnHand: TIntegerField;
    quQuickInfoAccountReceivableToAprove: TIntegerField;
    quQuickInfoAccountPayableToAprove: TIntegerField;
    quQuickInfoPastDuePayments: TIntegerField;
    quQuickInfoBreakEven: TBCDField;
    quQuickInfoItemOnRequest: TIntegerField;
    quQuickInfoItemOnHold: TIntegerField;
    btnRefresh: TdxBarLargeButton;
    btnEditor: TdxBarLargeButton;
    btnMenu: TdxBarLargeButton;
    dxBarSubItem1: TdxBarSubItem;
    btLogOff: TdxBarButton;
    btExit: TdxBarButton;
    btCloseWindows: TdxBarButton;
    imgMenu: TImageList;
    popBack: TdxBarPopupMenu;
    popForward: TdxBarPopupMenu;
    procedure FormShow(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmrExpiraTimer(Sender: TObject);
    procedure btNovaMensagemClick(Sender: TObject);
    procedure grdMensagemDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMensagemCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure quMensagemAfterOpen(DataSet: TDataSet);
    procedure trmAvisoTimer(Sender: TObject);
    procedure NovaMensagem1Click(Sender: TObject);
    procedure ConfigurarImpresso1Click(Sender: TObject);
    procedure Testerotina1Click(Sender: TObject);
    procedure tmrQuickInfoTimer(Sender: TObject);
    procedure quQuickInfoCalcFields(DataSet: TDataSet);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure quQuickInfoAfterOpen(DataSet: TDataSet);
    procedure imgQuickInfoClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnQuickClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInternetClick(Sender: TObject);
    procedure btnHistoryClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnEditorClick(Sender: TObject);
    procedure btnMenuClick(Sender: TObject);
    procedure btLogOffClick(Sender: TObject);
    procedure btExitClick(Sender: TObject);
    procedure btCloseWindowsClick(Sender: TObject);
    procedure popBackPopup(Sender: TObject);
    procedure popForwardPopup(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    MouseNoMenu: Boolean;

    UltimaQtdeMensagem: Integer;

    FOldClientProc, FNewClientProc: TFarProc;
    FDrawDC: hDC;

    SisSegurancaFrm: TSisSegurancaFrm;

    SisMenuFxd: TSisMenuFxd;

    FWelcome     : TFrmWelcome;
    FBuildMenu   : TBuildMenu;
    FHistoryList : THistoryList;

    MenuParent: TPanel;

    Suggested: TStringList;

    ActiveFormHelp: Integer;

    sScreenHelp,
    sHowToHelp : String;

    procedure LoadMenu;
    procedure ContadorRefresh;
    procedure RefreshQuickInfo;

    procedure SetMenuControl(IDMenu:Integer; title:String); //Add History
    procedure EnableButton(CanEnable : Boolean);

    //Novas functons
    function CreateModulo(IDMenu: Integer):TMyBarButton;
    procedure OnClickBarButton(Sender: TObject);

    procedure SetNavigatorControl;
    procedure SetHistoryMenu;


  public
    { Public declarations }
    procedure InitSeguranca(Reinit: Boolean);
    procedure MenuBringToFront;
    //Show Browse control
    procedure ShowBrowse(iIDMenu : Integer; Sugg : TStringList); //Chama um browser demtro de outro browser
    procedure CloseAllWindow;
    //Form Controls
    procedure GetMenuControl(Action:Integer); //Next and Prior
    procedure SetActiveForm;
  end;

var
  SisMain: TSisMain;

implementation

{$R *.DFM}

uses // Misc
     uDM,
     uDMGlobal,
     uSystemTypes,
     uMsgBox,
     uMsgConstant,
     uParentFixedFrm,
     uParentFch,
     uParentList,
     uCriarForm,
     // Sistema
     uSisSenha,
     uSisQuickRepFch,
     uSisMenuEditorFch,
     uNumericFunctions;
{
 ---------------------------------------------------------
 LOADER
 ---------------------------------------------------------
}


procedure TSisMain.SetHistoryMenu;
begin

  if not Assigned(FHistoryList.PopUpBackward) then
     FHistoryList.PopUpBackward := popBack;

  if not Assigned(FHistoryList.PopUpForward) then
     FHistoryList.PopUpForward  := popForward;

  if not Assigned(FHistoryList.Button) then
     FHistoryList.Button        := btnHistory;

end;


procedure TSisMain.SetNavigatorControl;
begin
     btnBack.Enabled := FHistoryList.HasPrior;
     btnNext.Enabled := FHistoryList.HasNext;
end;


procedure TSisMain.OnClickBarButton(Sender: TObject);
var
  AMyBarButton: TmyBarButton;

begin


  // Em MDI o Show acontece incondicionalmente no create
  LockWindowUpdate(Handle);

  try
    AMyBarButton := Sender as TMyBarButton;

    with CreateModulo(AMyBarButton.IDMenuItem) do
       begin
       Case LoaderType of

           LOADER_TYPE_BROWSER :
                  begin
                  //Coloca o Menu no history
                  SetMenuControl(IDMenuItem, Title);
                  //Start Module
                  if Loaded then
                     begin
                     with TParentFixedFrm(Form) do
                          Start(Parametro, UserRights, Suggested);
                     Suggested := nil;
                     ActiveFormHelp := Form.HelpContext;
                     end;

                  end;


           LOADER_TYPE_MODAL_FORM :
                  begin
                  //Dialog Form. After display, Free.
                  Form.ShowModal;
                  FreeAndNil(Form);
                  Loaded := False;
                  end;

           LOADER_TYPE_NO_FORM :
                  begin
                  case FormID of
                    10001: begin // Rebuild Identity
                           DM.DBCC_Rebuildidentity;
                           MsgBox(MSG_INF_REBUILD_IDT, vbOkOnly + vbInformation);
                           end;
                  end;
                  end;

          LOADER_TYPE_SHELL_API:
                  begin
                  ShellExecute(0, nil, PChar(ExtractFilePath(Application.ExeName)+FormClassName),  nil, nil, sw_shownormal);
                  end;

      end;//case
      end;//with
  finally
    LockWindowUpdate(0);
  end;
end;


function TSisMain.CreateModulo(IDMenu: Integer):TMyBarButton;
begin

  Result := FBuildMenu.GetButton(IDMenu);

  with Result do
  Try
    Screen.Cursor := crHourglass;
    if not Loaded then
       begin
       Form   := CriaForm(Self,FormClassName);
       Loaded := Form <> nil;
       if Loaded then
          begin
          Form.Tag := IDMenuItem;
          TParentFixedFrm(Form).Caption := Title;
          end;

       //Verifico o User Rights
       with spUserRights do
            begin
            Parameters.ParamByName('@IDUsuario').Value  := SisSenha.IDUsuario;
            Parameters.ParamByName('@IDMenuItem').Value := IDMenuItem;
            ExecProc;
            UserRights := Parameters.ParamByName('@Rights').Value;
            end;
       end;
  Finally
    Screen.Cursor := crDefault;
  end;

end;


procedure TSisMain.EnableButton(CanEnable : Boolean);
begin

  btnClose.Enabled   := CanEnable;
  btnRefresh.Enabled := CanEnable;
  btnBack.Enabled    := CanEnable;
  btnNext.Enabled    := CanEnable;


  if not CanEnable then
     begin
     FWelcome.Start('');
     ActiveFormHelp := 2;
     end;

end;

procedure TSisMain.SetActiveForm;
begin

  with FBuildMenu.GetButton(FHistoryList.ActualIDMenu) do
     begin
     if Loaded then
        begin
        with TParentFixedFrm(Form) do
             Start(Parametro, UserRights, Suggested);
        ActiveFormHelp := Form.HelpContext;
        end;
        
     Suggested := nil;
     end;

  //Enable next and Prior buttons
  SetNavigatorControl;

end;

procedure TSisMain.GetMenuControl(Action:Integer);
begin

    FHistoryList.NavigateControl(Action);
    SetActiveForm;

end;

procedure TSisMain.SetMenuControl(IDMenu:Integer; title:String);
begin

   FHistoryList.SetItemHistory(IDMenu, Title);

   //Update next and prior button
   EnableButton(FHistoryList.GetHistoryTotal>0);
   SetNavigatorControl;

end;

procedure TSisMain.RefreshQuickInfo;
begin

 with quQuickInfo do
     begin
      Open;
      Close;
     end;

end;



{
 ---------------------------------------------------------
 SHOW, TIMER e CLOSE
 ---------------------------------------------------------
}


procedure TSisMain.FormShow(Sender: TObject);
var
   IDMenuItemStart: Integer;

begin
  inherited;
  tmrTimeTimer(nil);
  DM.RunSQL('UPDATE Sis_Constante SET Valor = Valor + 1 WHERE Constante = ' + chr(39) + 'ContadorExecucao' + chr(39));

  if tmrExpira.Enabled then
    begin
      if DM.GetConst('ContadorExecucao') > 15 then
        begin
          tmrExpira.Enabled := False;

          //MsgBox('Você excedeu o número máximo de execuções._Entre em contato com Eduardo Costa para uma atualização de versão. Tel.: 295-5976, Email: elcosta@mandic.com.br, Teletrim: 460-1010 cod: 5306180.', vbCritical + vbOkOnly);

          Application.Terminate;
        end;

      {MsgBox( 'Bem vindo a versão de demonstração do Fast Retail.' +
              '_Esta versão esta limitada a 30 minutos de uso contínuo. ' +
              'Após este período será necessário reinicia-la.', vbInformation + vbOkOnly);}

      SisSenha.IDUsuario   := DM.GetConst('Usuario_Demo');
      SisSenha.CodUsuario  := 'Demo';
      SisSenha.Usuario     := 'Demo User';
    end
  else
    begin
      if not SisSenha.Start then
        begin
          Application.Terminate;
          Exit;
        end;
    end;

    Caption := Application.Title;
    StatusBar.Panels[2].Text := SisSenha.Usuario;
    StatusBar.Panels[1].Text := FormatDateTime('ddddd', now);

    InitSeguranca(not (MenuParent = nil));

    //Administrator
    if (SisSenha.IDGrupo = 1) then
       btnMenu.Visible := ivAlways
    else
       btnMenu.Visible := ivNever;

    //Refresh os contadores
    ContadorRefresh;

    //Create Welcome form
    if not Assigned(FWelcome) then
       FWelcome := TFrmWelcome.Create(Self);

    //Disbale buttons and call Welcom form
    EnableButton(False);

end;

procedure TSisMain.InitSeguranca(Reinit: Boolean);
begin
  try
    SisSegurancaFrm := TSisSegurancaFrm.Create(Self);
    SisSegurancaFrm.Show;

    Application.ProcessMessages;

    // Se e reinit limpa o menu e drop as tabelas temporarias
    if Reinit then
      begin
        DM.RunSQL('DROP TABLE #Sis_EmpresaP');

        DM.RunSQL('DROP TABLE #Sis_MainMenuP');

      end;

    // Criara as tablelas temporarias que conterao
    //   -- Os itens do menu que o usuario podera utilizar
    //   -- As empresas que o usuario pode acessar
    //   -- Os espacos que ele pode ver e movimentar


    // Crio as tabelas temporarias que guardam os acessos
    DM.RunSQL('CREATE TABLE #Sis_MainMenuP (IDMenuItemP int NOT NULL)');

    DM.RunSQL('CREATE TABLE #Sis_EmpresaP (IDEmpresaP int NOT NULL)');

    with quPreencheMainMenu do
      begin
        Parameters.ParamByName('IDUsuario').Value := SisSenha.IDUsuario;
        ExecSQL;
      end;

    with quPreencheEmpresa do
      begin
        Parameters.ParamByName('IDUsuario').Value := SisSenha.IDUsuario;
        ExecSQL;
      end;

    //MenuRefresh;
    LoadMenu;

    //Inicializa the Menu History
    SetHistoryMenu;

  finally
    SisSegurancaFrm.Free;
  end;
end;

procedure TSisMain.tmrTimeTimer(Sender: TObject);
begin
  inherited;
  lblMes.Caption  := FormatDateTime('mmm', Now);
  lblDia.Caption  := FormatDateTime('d', Now);
end;

procedure TSisMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  if MsgBox(MSG_QST_EXIT, vbQuestion + vbYesNo) = vbYes then
    CanClose := True
  else
    CanClose := False;

end;


procedure TSisMain.tmrExpiraTimer(Sender: TObject);
begin
  inherited;
  //MsgBox('Esgotou-se o tempo de teste._Por favor reinicie o Sistema.', vbCritical + vbOkOnly);

  Application.Terminate;

end;

procedure TSisMain.btNovaMensagemClick(Sender: TObject);
var
  ID1, ID2: String;

begin
  inherited;

{  // Abre a ficha de mesnagem em inclusao
  if SisMensagemFch = Nil then
    SisMensagemFch := TSisMensagemFch.Create(self);

  if SisMensagemFch.Start(btInc, nil, false, ID1, ID2, '', '', Nil) then
    quMensagem.Requery;
}
end;

procedure TSisMain.grdMensagemDblClick(Sender: TObject);
var
   ID1, ID2: String;

begin
  inherited;
{  // Testa se a query esta vazia
  with quMensagem do
    if EOF and BOF then
      Exit;

  // Abre a ficha de mensagem em alteracao
  if SisMensagemFch = Nil then
    SisMensagemFch := TSisMensagemFch.Create(self);

  ID1 := quMensagemIDMensagem.AsString;
  ID2 := '';

  if SisMensagemFch.Start(btAlt, nil, false, ID1, ID2, '', '', nil) then
    quMensagem.Requery;
}
end;

procedure TSisMain.FormCreate(Sender: TObject);
begin
  inherited;

  if Application.Terminated then
    Close;

  UltimaQtdeMensagem := 0;
  MenuParent         := nil;
  Suggested          := TStringList.Create;
  Suggested          := nil;
  FHistoryList       := THistoryList.Create;

  //Translate
  case DMGlobal.IDLanguage of
    LANG_ENGLISH :
           begin
           sScreenHelp := 'OM_SCREEN_ES.HLP';
           sHowToHelp  := 'OM_HOWTO_ES.HLP';
           end;
    LANG_PORTUGUESE :
           begin
           sScreenHelp := 'OM_SCREEN_BR.HLP';
           sHowToHelp  := 'OM_HOWTO_BR.HLP';
           end;

    LANG_SPANISH :
           begin
           sScreenHelp := 'OM_SCREEN_SP.HLP';
           sHowToHelp  := 'OM_HOWTO_SP.HLP';
           end;
  end;

  Application.HelpFile := extractfilepath(application.exename) + sScreenHelp;

end;

procedure TSisMain.grdMensagemCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
{  if Highlight then
    begin
      ABrush.Color := grdMensagem.Color;
      AFont.Color := grdMensagem.Font.Color;
    end;}
end;


procedure TSisMain.quMensagemAfterOpen(DataSet: TDataSet);
begin
  inherited;
{
  pnlMensagem.Visible := (quMensagem.RecordCount > 0);
  trmAviso.Enabled := pnlMensagem.Visible;
  grdMensagem.ShowVertScrollBar := (quMensagem.RecordCount > 3);

  lblNumMsg.Caption := IntToStr(quMensagem.RecordCount) + '  não lida{s)';
}

end;

procedure TSisMain.trmAvisoTimer(Sender: TObject);
begin
  inherited;
  {
  imgAvisoOff.Visible := imgAvisoOn.Visible;
  imgAvisoOn.Visible  := not imgAvisoOn.Visible;

  if imgAvisoOff.Visible then
    pnlMensagem.Color := clInfobk
  else
    pnlMensagem.Color := clWhite;
  }
end;

procedure TSisMain.NovaMensagem1Click(Sender: TObject);
begin
  inherited;
  btNovaMensagemClick(nil);
end;


procedure TSisMain.ShowBrowse(iIDMenu : Integer; Sugg : TStringList);
begin

  Suggested := Sugg;

  //Chama o on click que tem todo o codigo p/ colocar
  //o form em memoria (esse codigo ta uma merda - melhorar depois)
  (FBuildMenu.GetButton(iIDMenu)).Click;


end;

procedure TSisMain.LoadMenu;
begin

  // Monta o Novo
  if FBuildMenu = Nil then
     FBuildMenu := TBuildMenu.Create;

  with FBuildMenu do
  begin
    ClearModules;
    OnClick       := OnClickBarButton;
    Connection    := DM.DBADOConnection;
    BarManager    := dxMainBar;
    MenuOwner     := Self;
    ConstructMenu(1, DMGlobal.IDLanguage);
  end;

end;

procedure TSisMain.CloseAllWindow;
var
  i: integer;
begin

  // Fecha todas os Modulos abertos
  FBuildMenu.ClearModules;

  //Clear all menu item of the list
  FHistoryList.DeleteAllMenuItems;

  //Disbale buttons and call Welcom form
  EnableButton(False);

end;

procedure TSisMain.ConfigurarImpresso1Click(Sender: TObject);
begin
  inherited;
  PrinterSetupDialog.Execute;
end;

procedure TSisMain.Testerotina1Click(Sender: TObject);
begin
  inherited;
  ShowMessage(Extenso(MyStrToFloat(InputBox('Parametros', 'Parametros', ''))));

end;

procedure TSisMain.MenuBringToFront;
begin
  SisMenuFxd.Show;

end;

procedure TSisMain.ContadorRefresh;
begin

  imgQuickInfo.Visible := False;

  if not (SisSenha.ContadorClasse > 0) then
     Exit;

  //quQuickInfo.Active   := True;
  //tmrQuickinfo.Enabled := True;

  pnlTotalSales.Visible := ClasseTem(CONTADOR_OCORRENCIA_SALES_TODAY, SisSenha.ContadorClasse);
  pnlItemOnHold.Visible := ClasseTem(CONTADOR_OCORRENCIA_ITEM_ON_HOLD, SisSenha.ContadorClasse);
  pnlItemToBuy.Visible  := ClasseTem(CONTADOR_OCORRENCIA_ITEM_ON_PO, SisSenha.ContadorClasse);

  pnlBreakEven.Visible  := ClasseTem(CONTADOR_OCORRENCIA_BREAK_EVEN, SisSenha.ContadorClasse);

  pnlAccPayApprove.Visible := ClasseTem(CONTADOR_CONTAPAGAR_APROVAR, SisSenha.ContadorClasse);
  pnlAccRecApprove.Visible := ClasseTem(CONTADOR_CONTARECEVER_APROVAR, SisSenha.ContadorClasse);
  pnlPassDue.Visible       := ClasseTem(CONTADOR_PAYABLE_DUE_DATE_PAST, SisSenha.ContadorClasse);

  imgQuickInfo.Visible := (SisSenha.ContadorClasse > 0);

end;


procedure TSisMain.tmrQuickInfoTimer(Sender: TObject);
begin
  inherited;
{  with quQuickInfo do
    begin
      Close;
      Open;
      Screen.Cursor := crArrow;
    end;}
end;

procedure TSisMain.quQuickInfoCalcFields(DataSet: TDataSet);
begin
  inherited;
{  quQuickInfoAlerta1.AsString :=
    quQuickInfoCampoAlerta1.AsString + '/' + quQuickInfoLaboratorioAlerta1.AsString;

  quQuickInfoAlerta2.AsString :=
    quQuickInfoCampoAlerta2.AsString + '/' + quQuickInfoLaboratorioAlerta2.AsString;

  quQuickInfoAlerta3.AsString :=
    quQuickInfoCampoAlerta3.AsString + '/' + quQuickInfoLaboratorioAlerta3.AsString;

  quQuickInfoDeadLine.AsString :=
    quQuickInfoCampoDeadLine.AsString + '/' + quQuickInfoLaboratorioDeadLine.AsString;
 }
end;

procedure TSisMain.Image1Click(Sender: TObject);
begin
  inherited;

  RefreshQuickInfo;

  if MyStrToFloat(edtTotalSales.Caption) <> 0 then
     TSisQuickRepFch.Create(Self).Start(QUICK_REP_TOTALSALES, '');

end;

procedure TSisMain.Image2Click(Sender: TObject);
begin
  inherited;

  RefreshQuickInfo;

  if MyStrToInt(edtItemsHold.Caption) <> 0 then
     TSisQuickRepFch.Create(Self).Start(QUICK_REP_ITEMSHOLD, '');

end;

procedure TSisMain.quQuickInfoAfterOpen(DataSet: TDataSet);
begin
  inherited;

  edtTotalSales.Caption := FormatFloat('#,##0.00', quQuickInfoTotalSale.AsCurrency);
  edtItemsHold.Caption  := quQuickInfoItemOnHold.AsString;
  edtItemsBuy.Caption   := quQuickInfoItemOnPO.AsString;
  edtBKEven.Caption     := FormatFloat('#,##0.00', quQuickInfoBreakEven.AsCurrency);
  edtRecAppr.Caption    := quQuickInfoAccountReceivableToAprove.AsString;
  edtPayApp.Caption     := quQuickInfoAccountPayableToAprove.AsString;
  edtPastDue.Caption    := quQuickInfoPastDuePayments.AsString;

  if quQuickInfoBreakEven.AsCurrency < 0 then
     edtBKEven.Font.Color := clRed
  else
     edtBKEven.Font.Color := clBlue;

end;

procedure TSisMain.imgQuickInfoClick(Sender: TObject);
begin
  inherited;

  RefreshQuickInfo;

end;

procedure TSisMain.btnBackClick(Sender: TObject);
begin
  inherited;

  GetMenuControl(WEB_PRIOR);

end;

procedure TSisMain.btnNextClick(Sender: TObject);
begin
  inherited;

  GetMenuControl(WEB_NEXT);

end;

procedure TSisMain.btnCloseClick(Sender: TObject);
begin
  inherited;

 if FHistoryList.ActualIDMenu <> 0 then
    begin
    FBuildMenu.ClearModule(FHistoryList.ActualIDMenu);
    FHistoryList.DeleteActualItem;
    if FHistoryList.ActualIDMenu <> 0 then
       SetActiveForm;
    EnableButton(FHistoryList.GetHistoryTotal>0);
    SetNavigatorControl;
    end;

end;

procedure TSisMain.btnQuickClick(Sender: TObject);
begin
  inherited;

  //btnQuick.Down := not btnQuick.Down;

  if (SisSenha.ContadorClasse <= 0) then
     begin
     MsgBox(MSG_INF_NO_QUICKTIME_AVAILABLE, vbInformation + vbOkOnly);
     btnQuick.Down := False;
     Exit;
     end;

  if pnlAtalho.Visible then
     pnlAtalho.Visible := False
  else
     begin
     pnlAtalho.Visible := True;
     RefreshQuickInfo;
     end;

  btnQuick.Down := pnlAtalho.Visible;

end;

procedure TSisMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  Suggested.Free;

  FHistoryList.Free;

  if Assigned(FBuildMenu) then
     FBuildMenu.Free;
  
end;

procedure TSisMain.btnInternetClick(Sender: TObject);
begin
  inherited;

  CloseAllWindow;
  
end;

procedure TSisMain.btnHistoryClick(Sender: TObject);
begin
  inherited;

  if TdxBarButton(Sender).ClickItemLink <> nil then
     begin
     FHistoryList.SetItemHistory(TdxBarButton(Sender).ClickItemLink.Data, TdxBarButton(Sender).ClickItemLink.UserCaption);
     SetActiveForm;
     end


end;

procedure TSisMain.btnEmailClick(Sender: TObject);
begin
  inherited;

  ShellExecute(0, 'OPEN', 'mailto:asouza@pinogy.com',  nil, nil, sw_shownormal);

end;

procedure TSisMain.Image3Click(Sender: TObject);
begin
  inherited;

  RefreshQuickInfo;

  if MyStrToInt(edtItemsBuy.Caption) <> 0 then
     TSisQuickRepFch.Create(Self).Start(QUICK_REP_ITEMSPO, '');


end;

procedure TSisMain.btnRefreshClick(Sender: TObject);
begin
  inherited;

  with FBuildMenu.GetButton(FHistoryList.ActualIDMenu) do
     begin
      if (Form.ClassParent.ClassName = 'TParentList') then
         with TParentList(Form) do
            if BrowseConfig.AutoOpen then
               ListRefresh
            else
               ListParamRefresh;
     end;

end;

procedure TSisMain.btnEditorClick(Sender: TObject);
begin
  inherited;

  {with TsisTextEditorFrm.Create(Self) do
     begin
     Init;
     end;}


end;

procedure TSisMain.btnMenuClick(Sender: TObject);
begin
  inherited;

  TSisMenuEditorFch.Create(Self).ShowModal;
  
end;

procedure TSisMain.btLogOffClick(Sender: TObject);
var
  i: integer;

begin
  inherited;

  // Fecha o menu interativo
  if SisMenuFxd <> nil then
     SisMenuFxd.Close;

  CloseAllWindow;

  FormShow(nil);
end;

procedure TSisMain.btExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TSisMain.btCloseWindowsClick(Sender: TObject);
begin
  inherited;

  CloseAllWindow;
  
end;

procedure TSisMain.popBackPopup(Sender: TObject);
begin
  inherited;

  if FHistoryList.IsNewBackwardHistory then
     FHistoryList.GetBackHistory;

end;

procedure TSisMain.popForwardPopup(Sender: TObject);
begin
  inherited;

  if FHistoryList.IsNewForwardHistory then
     FHistoryList.GetForwardHistory;

end;

procedure TSisMain.btnHelpClick(Sender: TObject);
begin
  inherited;
  Application.HelpContext(ActiveFormHelp); 
end;

end.
