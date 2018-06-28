unit uSisReports;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentReportFrm, ppCtrls, ppBands, ppModule, daDataModule, ppVar,
  ppStrtch, ppMemo, ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppDsgnDB,
  ppEndUsr, ppComm, ppRelatv, ppDB, ppDBPipe, ppDBBDE, Db, ADODB, ExtCtrls,
  ImgList, dxBar, ppViewr, StdCtrls, Mask, DBCtrls, dxDBCtrl, dxDBGrid, SuperComboADO,
  dxTL, dxDBTLCl, dxGrClms, dxCntner, Buttons, jpeg, uFrameFilterAcc,
  siComp, siLangRT;

type
  TSisReports = class(TParentReportFrm)
    FrameFilterAcc: TFrameFilterAcc;
    quSelectedReportItemID: TIntegerField;
    procedure btExecutaClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure gridRepDblClick(Sender: TObject);
    procedure quReportNewRecord(DataSet: TDataSet);
    procedure quSelectedReportNewRecord(DataSet: TDataSet);
    procedure dsReportDataChange(Sender: TObject; Field: TField);
    procedure ppDesignerCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveFilterClick(Sender: TObject);
    procedure btnDelFiltersClick(Sender: TObject);
    procedure barFilterClick(Sender: TObject);
    procedure btnAppendFiltersClick(Sender: TObject);
  private
    { Private declarations }
    iIDFolder : Integer;

    procedure OpenCurrentReport;
    procedure SetAutoText(ppReport: TppReport);

    procedure ReportClose;
    procedure ReportOpen;
    procedure ReportRequery;
    procedure ReportDelete;
    procedure ReportPost;

    procedure SelectedRepClose;
    procedure SelectedRepOpen;

  public
    { Public declarations }
    procedure Start(Parametro: String; UserRights: String; Suggestion : TStringList); override;

  end;

implementation

uses uDM, uMsgBox, uNumericFunctions, uParamFunctions, uMsgConstant, uSystemConst;

{$R *.DFM}

procedure TSisReports.Start(Parametro: String; UserRights: String; Suggestion : TStringList);
begin

  MyParametro := Trim(Parametro);

  iIdFolder := MyStrToInt(ParseParam(MyParametro, 'RepFolder'));

  FrameFilterAcc.Init;
  FrameFilterAcc.TempTableName := '#Ret_ReportSource';

  ReportOpen;

  ppDesigner.Icon    := Application.Icon;
  ppDesigner.Caption := Application.Title + ' - Dynamic Report.';

  Show;

end;


procedure TSisReports.SelectedRepClose;
begin

   with quSelectedReport do
      if Active then
         Close;

end;

procedure TSisReports.SelectedRepOpen;
begin

   with quSelectedReport do
      if not Active then
         Open;

end;


procedure TSisReports.ReportRequery;
var
  sName: String;
begin
  inherited;

  quReport.DisableControls;

  sName := quReportName.AsString;

  ReportClose;
  ReportOpen;

  quReport.Locate('Name', sName, []);

  quReport.EnableControls;

end;

procedure TSisReports.ReportDelete;
begin

   with quReport do
      if Active then
         Delete;

end;

procedure TSisReports.ReportPost;
begin

   with quReport do
      if Active then
         if State = dsEdit then
            Post;

end;

procedure TSisReports.ReportClose;
begin

  ReportPost;

  with quReport do
     if Active then
        Close;
end;


procedure TSisReports.ReportOpen;
begin

  with quReport do
     if not Active then
        begin
        Parameters.ParamByName('IDFolder').Value := iIDFolder;
        Open;
        end;

end;


procedure TSisReports.SetAutoText(ppReport: TppReport);
var
  sUsuarioData, sFilterText: String;
  iBandIndex, iComponentIndex: integer;
  i: integer;

begin

  sFilterText := FrameFilterAcc.GetFilterText;

  sUsuarioData := 'Printed by ' + DM.sSisUser + ' on ' + FormatDateTime('ddddd hh:mm', Now());

  with ppReport do
    begin
      if Title <> nil then
        with Title do
          for i := 0 to ObjectCount-1 do
            if Objects[i].UserName = 'lblTitulo' then
              Objects[i].Caption := quReportName.AsString
            else if Objects[i].UserName = 'mmFiltro' then
              Objects[i].Text := sFilterText
            else if Objects[i].UserName = 'lblNumero' then
              Objects[i].Caption := quReportItemID.AsString;

      if Footer <> nil then
        with Footer do
          for i := 0 to ObjectCount-1 do
            if Objects[i].UserName = 'lblUsuarioData' then
              Objects[i].Caption := sUsuarioData;
    end;

end;


procedure TSisReports.OpenCurrentReport;
begin

  Screen.Cursor := crHourGlass;

  DesativaAviso;

  if quReportName.AsString <> '' then
    begin
      SelectedRepOpen;

      ppReport.Template.DatabaseSettings.Name := quSelectedReportName.AsString;
      ppReport.Template.LoadFromDataBase;

      FrameFilterAcc.DropTempTable;
      FrameFilterAcc.CreateTempTable;

      btnStopPrint.Enabled := True;

      SetAutoText(ppReport);
      ppReport.PrintToDevices;

      btnStopPrint.Enabled := False;


      SelectedRepClose;
    end;

  Screen.Cursor := crDefault;

  EnableBtn;

end;


procedure TSisReports.btExecutaClick(Sender: TObject);
begin
  inherited;

  OpenCurrentReport;

end;

procedure TSisReports.btnNewClick(Sender: TObject);
var
  sReportName: String;
begin
  inherited;
  sReportName := 'New report';

  ppModelo.Template.DatabaseSettings.Name := sReportName;
  ppModelo.Template.SaveToDatabase;

  ppReport.Template.DatabaseSettings.Name := sReportName;
  ppReport.Template.LoadFromDatabase;

  if quReport.Locate('Name', sReportName, []) then
     ReportDelete;

  ppDesigner.ShowModal;

  ReportRequery;

end;

procedure TSisReports.btnEditClick(Sender: TObject);
begin
  inherited;

{    if quReportItemType.AsInteger = 1 then
     begin
     MsgBox(MSG_INF_NOT_EDIT_SYSREP, vbOKOnly + vbInformation);
     Exit;
     end;}



  Screen.Cursor := crHourGlass;

  if quReportName.AsString <> '' then
    begin
      SelectedRepOpen;

      ppReport.Template.DatabaseSettings.Name := quSelectedReportName.AsString;
      ppReport.Template.LoadFromDataBase;

      SelectedRepClose;
    end;

  Screen.Cursor := crDefault;

  ppDesigner.Show;

end;

procedure TSisReports.btnRemoveClick(Sender: TObject);
begin
  inherited;

  if quReportItemType.AsInteger = 1 then
     begin
     MsgBox(MSG_INF_NOT_DEL_SYSREP, vbOKOnly + vbInformation);
     Exit;
     end;

  if MsgBox(MSG_QST_PART_REMOVE_REPORT + quReportName.AsString + '?', vbQuestion + vbYesNo) = vbYes then
    if quReportName.AsString <> '' then
       ReportDelete;

  ReportRequery;

  OpenCurrentReport;

end;

procedure TSisReports.btnOpenClick(Sender: TObject);
var
  i: integer;
  sFile, sFilePath : String;

begin
  inherited;

  // Pego o arquivo
  with OpenDialog do
     if Execute then
        begin
        sFile     := ExtractFileName(FileName);
        sFilePath := FileName;
        end
     else
        Exit;

  // Sem dados para ser mais rápido
  FrameFilterAcc.DropTempTable;
  FrameFilterAcc.CreateTempTable;


   with ppReport.Template do
       begin
       try
         FileName := sFilePath;
         LoadFromFile;
       except
         end;

       try
         quReport.Append;
         quReportName.AsString := sFile;
         quReport.Post;

         DatabaseSettings.Name := sFile;
         SaveToDatabase;
         except
            On E:Exception do
               MsgBox(MSG_CRT_PART_ERROR_SAVE_REPORT + sFile + '._' +
                       E.message, vbOkOnly + vbCritical);
            end;

       end;
end;

procedure TSisReports.btnSaveClick(Sender: TObject);
var
  sReportName: String;
  sFilePath: String;
begin
  inherited;

  with quReport, ppReport.Template do
    if not IsEmpty then
      begin
      sReportName := quReportName.AsString;

      // Sem dados para ser mais rápido
      FrameFilterAcc.DropTempTable;
      FrameFilterAcc.CreateTempTable;

      // Pergunto o path
      SaveDialog.FileName := 'C:\Temp\Rep ' + quReportName.AsString;
      if SaveDialog.Execute then
         sFilePath := SaveDialog.FileName
      else
         Exit;


      try
         DatabaseSettings.Name := quReportName.AsString;
         LoadFromDatabase;
      except
         end;

      try
         FileName := sFilePath;
         SaveToFile;
      except
         MsgBox(MSG_CRT_PART_ERROR_SAVE_REPFILE + FileName , vbCritical + vbOkOnly);
         end;

      Locate('Name', sReportName, []);
      DatabaseSettings.Name := quReportName.AsString;
      LoadFromDatabase;
      end;
end;

procedure TSisReports.btnCopyClick(Sender: TObject);
begin

  if MsgBox(MSG_QST_PART_CRIATE_REP_COPY + quReportName.AsString + '?', vbQuestion + vbYesNo) = vbNo then
     Exit;

  inherited;

  ReportRequery;

  //Vai para o ultimo relatorio copiado
  quReport.Last;

end;

procedure TSisReports.gridRepDblClick(Sender: TObject);
begin
  inherited;

  OpenCurrentReport;

end;

procedure TSisReports.quReportNewRecord(DataSet: TDataSet);
begin
  inherited;

  quReportFolderID.AsInteger := iIDFolder;

end;

procedure TSisReports.quSelectedReportNewRecord(DataSet: TDataSet);
begin
  inherited;
    quSelectedReportItemID.AsInteger   := DM.GetNextID(OM_REPORT_ID);
    quSelectedReportFolderID.AsInteger := iIDFolder;
  
end;

procedure TSisReports.dsReportDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  AtivaAviso;
  FrameFilterAcc.ResetFilters;
  BuildFilter(FrameFilterAcc);


end;

procedure TSisReports.ppDesignerCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

     if ppReport.Modified then
      if MsgBox(MSG_QST_SAVE_REPORT, vbQuestion + vbYesNo) = vbYes then
        begin
        ppReport.Template.SaveToDatabase;

        SelectedRepOpen;

        FrameFilterAcc.DropTempTable;
        FrameFilterAcc.CreateTempTable;

        SetAutoText(ppReport);
        ppReport.PrintToDevices;

        SelectedRepClose;
        end;

end;

procedure TSisReports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  ReportClose;

  FrameFilterAcc.Uninit;

end;

procedure TSisReports.btnSaveFilterClick(Sender: TObject);
begin
  inherited;

  SaveFilter(FrameFilterAcc);

end;

procedure TSisReports.btnDelFiltersClick(Sender: TObject);
begin
  inherited;

  quReport.Edit;
  quReportFilters.AsString := '';
  FrameFilterAcc.ResetFilters;
  MsgBox(MSG_INF_FILETER_CLEARED, vbInformation + vbOkOnly);

end;

procedure TSisReports.barFilterClick(Sender: TObject);
begin
  inherited;

   if quReportFilters.AsString = '' then
      begin
      btnDelFilters.Enabled    := False;
      end
   else
      begin
      btnDelFilters.Enabled    := True;
      end;

end;

procedure TSisReports.btnAppendFiltersClick(Sender: TObject);
begin
  inherited;
  AppendFilter(FrameFilterAcc);
end;

Initialization
  RegisterClass(TSisReports);


end.
