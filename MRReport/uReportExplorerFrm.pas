unit uReportExplorerFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxLookAndFeelPainters, cxButtons, dxExEdtr,
  dxCntner, dxTL, UCrpeClasses, UCrpe32, uRepParentFilter, siComp, ImgList,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo;


const
  IMG_FOLDER_OPEN  = 0;
  IMG_FOLDER_CLOSE = 1;
  IMG_REP_CLOSE    = 2;
  IMG_REP_OPEN     = 3;

type
  TRepFilterClass = class of TRepParentFilter;
  TArrayRepFilter = array of TRepParentFilter;

  TReportExplorerFrm = class(TForm)
    pnlButton: TPanel;
    Splitter: TSplitter;
    btPrint: TcxButton;
    btClose: TcxButton;
    crpeReport: TCrpe;
    pnlTitle: TPanel;
    imgTitle: TImage;
    lblTitle: TLabel;
    lblSubTitle: TLabel;
    shpTitle: TShape;
    lblDetailTitle: TLabel;
    pnlReportFilter: TPanel;
    Panel1: TPanel;
    Shape4: TShape;
    Label1: TLabel;
    Shape3: TShape;
    tlReport: TdxTreeList;
    tlReportColumn: TdxTreeListColumn;
    shpFilter: TShape;
    Image1: TImage;
    imgFilter: TImage;
    lblReportTitle: TLabel;
    pnlReportInfo: TPanel;
    Shape7: TShape;
    Shape6: TShape;
    imgReportPreview: TImage;
    lbPreview: TLabel;
    Label5: TLabel;
    lbVersionInfo: TLabel;
    lbVersion: TLabel;
    siLang: TsiLang;
    lbUser: TLabel;
    ImageList: TImageList;
    lbRepDescription: TcxMemo;
    pnlPrinter: TPanel;
    cmbPrinter: TComboBox;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure tlReportChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure btPrintClick(Sender: TObject);
    procedure tlReportExpanded(Sender: TObject; Node: TdxTreeListNode);
    procedure tlReportCollapsed(Sender: TObject; Node: TdxTreeListNode);
    procedure FormShow(Sender: TObject);
    procedure cmbPrinterChange(Sender: TObject);
  private
    sMain : String;
    FRepFilterList: TArrayRepFilter;
    FFiltersString : String;
    FFocusedNode: TdxTreeListNode;

    procedure LoadPrinterList;
    procedure LoadReportList;
    procedure LoadReportParams(AReportFileName: String);
    procedure CreateFilterPanel(AParamName,AParamPrompt: String);
    procedure SetReportConnection;
    procedure SetFilterValues;
    procedure SetSystemFilterValues;
    procedure SetFilterValue(AParamField: TCrpeParamFieldsItem);
    procedure ClearFilters;

    function GetFilterClassName(AParamName: String): String;
    function GetFilterPanel(AParamName: String): TRepParentFilter;
    function GetReportFileName(ANode: TdxTreeListNode): String;
    function ImportDir(ADir: String; var Node: TdxTreeListNode): Boolean;

    procedure LoadReportInfo(fReport:String);
    procedure ClearReportInfo;
    procedure ReFreshReports;

    procedure SetPrinterSetup;
  public
    function Start : Boolean; 
  end;

implementation

uses uDMReport, uDMGlobal;

{$R *.dfm}

procedure TReportExplorerFrm.LoadReportList;
var
  tnRootNode: TdxTreeListNode;
begin

  case DMReport.LanguageDispatcher.ActiveLanguage of
  LANG_ENGLISH    : begin
                      sMain := 'Main';
                    end;
  LANG_PORTUGUESE : begin
                      sMain := 'Principal';
                    end;
  LANG_SPANISH    : begin
                      sMain := 'Principal';
                    end;
  end;

  tnRootNode := tlReport.Add;
  tnRootNode.Strings[0]    := sMain;
  tnRootNode.ImageIndex    := IMG_FOLDER_CLOSE;
  tnRootNode.SelectedIndex := IMG_FOLDER_CLOSE;

  ImportDir(DMReport.GetAppProperty('Default', 'ReportPath'), tnRootNode);
end;

procedure TReportExplorerFrm.FormCreate(Sender: TObject);
begin

  LoadPrinterList;
  LoadReportList;
  
end;

procedure TReportExplorerFrm.LoadReportParams(AReportFileName: String);
var
  iParamIndex: Integer;
  iParamPrompt : String;
begin
  with crpeReport do
  begin
    ReportName := AReportFileName;
    SetPrinterSetup;
    for iParamIndex := Pred(ParamFields.Count) downto 0 do
    begin
      iParamPrompt := crpeReport.ParamFields.Items[iParamIndex].Prompt;
      CreateFilterPanel(ParamFields[iParamIndex].Name, iParamPrompt);
    end;
  end;
end;

procedure TReportExplorerFrm.tlReportChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  lblReportTitle.Caption := '';
  Application.ProcessMessages;
  ClearFilters;

  FFocusedNode := Node;

  if Node.Count = 0 then
  begin
    LoadReportParams(GetReportFileName(Node));
    lblReportTitle.Caption := Node.Strings[0];
    crpeReport.WindowStyle.Title := Node.Strings[0];
    LoadReportInfo(Node.Strings[0]);
  end;
end;

function TReportExplorerFrm.GetReportFileName(ANode: TdxTreeListNode): String;
var
  tnParentNode: TdxTreeListNode;
begin
  tnParentNode := ANode.Parent;
  Result := '\' + ANode.Strings[0];

  while Assigned(tnParentNode) do
  begin
    if Assigned(tnParentNode.Parent) then
      Result := '\' + tnParentNode.Strings[0] + Result;
    tnParentNode := tnParentNode.Parent;
  end;

  Result := DMReport.GetAppProperty('Default', 'ReportPath') + Result + '.rpt';
end;

procedure TReportExplorerFrm.CreateFilterPanel(AParamName,AParamPrompt: String);
var
  RepFilterClass: TRepFilterClass;
  RepFilter: TRepParentFilter;
begin
  RepFilterClass := TRepFilterClass(GetClass(GetFilterClassName(AParamName)));

  if Assigned(RepFilterClass) then
  begin
    RepFilter := GetFilterPanel(AParamName);

    if not Assigned(RepFilter) then
    begin
      RepFilter             := RepFilterClass.Create(Self);
      RepFilter.Name        := AParamName;
      RepFilter.Parent      := pnlReportFilter;
      RepFilter.BorderStyle := bsNone;
      RepFilter.BorderIcons := [];
      RepFilter.Align       := alTop;
      RepFilter.SetFilterLabel(AParamPrompt);
      RepFilter.Show;

      SetLength(FRepFilterList, Length(FRepFilterList)+1);
      FRepFilterList[Length(FRepFilterList)-1] := RepFilter;
    end
    else
    begin
      RepFilter.Show;
    end;
  end;
end;

function TReportExplorerFrm.GetFilterClassName(AParamName: String): String;
begin
  if Pos('_', AParamName) > 0 then
    AParamName := Copy(AParamName, 1, Pos('_', AParamName)-1);

  Result := 'TRep' + AParamName + 'Filter';
end;

procedure TReportExplorerFrm.btPrintClick(Sender: TObject);
var
  i: integer;
begin
  try
    Screen.Cursor := crHourGlass;
    SetFilterValues;
    SetReportConnection;
    crpeReport.Execute;
  finally
    ReFreshReports;
    Screen.Cursor := crDefault;
  end;
end;

procedure TReportExplorerFrm.SetFilterValues;
var
  iParamIndex: Integer;
begin

  FFiltersString := '';

  with crpeReport do
    for iParamIndex := 0 to Pred(ParamFields.Count) do
      SetFilterValue(ParamFields[iParamIndex]);

  SetSystemFilterValues;

end;

procedure TReportExplorerFrm.SetReportConnection;
var
  iTableIndex, iSubReportIndex: Integer;
begin
  with crpeReport do
  begin
    for iTableIndex := 0 to Pred(Tables.Count) do
      Tables[iTableIndex].ConnectBuffer := DMReport.FConnString;

    for iSubReportIndex := 0 to Pred(Subreports.Count) do
      for iTableIndex := 0 to Pred(Subreports[iSubReportIndex].Cr.Tables.Count) do
        Subreports[iSubReportIndex].Cr.Tables[iTableIndex].ConnectBuffer := DMReport.FConnString;
  end;
end;

function TReportExplorerFrm.ImportDir(ADir: String; var Node: TdxTreeListNode): Boolean;
var
  SR: TSearchRec;
  tnChildNode: TdxTreeListNode;
begin
  Result := True;
  try
    if FindFirst(ADir + '*.*', faAnyFile, SR) = 0 then
      try
        repeat
          if (SR.Attr and faDirectory) = 0 then
          begin
            if ExtractFileExt(SR.Name) = '.rpt' then
            begin
              tnChildNode := Node.AddChild;
              tnChildNode.Strings[0] := Copy(SR.Name, 1, Length(SR.Name)-4);
              tnChildNode.ImageIndex    := IMG_REP_CLOSE;
              tnChildNode.SelectedIndex := IMG_REP_OPEN;
            end;
          end
          else
          begin
            if (SR.Name <> '.') and (SR.Name <> '..') and (FileSearch('*.rpt', ADir + SR.Name) <> '') then
            begin
              tnChildNode := Node.AddChild;
              tnChildNode.Strings[0]    := SR.Name;
              tnChildNode.ImageIndex    := IMG_FOLDER_CLOSE;
              tnChildNode.SelectedIndex := IMG_FOLDER_CLOSE;
              ImportDir(ADir + '\' + SR.Name + '\', tnChildNode);
            end;
          end;
        until FindNext(SR) <> 0;
      finally
        FindClose(SR);
      end;
  except
    on E: Exception do
    begin
      // Frase de erro.
      Result := False;
    end;
  end;
end;

function TReportExplorerFrm.GetFilterPanel(AParamName: String): TRepParentFilter;
var
  iIndexList: Integer;
begin
  Result := nil;

  for iIndexList := 0 to Pred(Length(FRepFilterList)) do
    if FRepFilterList[iIndexList].Name = AParamName then
      Result := FRepFilterList[iIndexList];
end;

procedure TReportExplorerFrm.ClearFilters;
var
  iIndexList: Integer;
begin
  for iIndexList := 0 to Pred(Length(FRepFilterList)) do
    FRepFilterList[iIndexList].Close;
end;

procedure TReportExplorerFrm.SetFilterValue(AParamField: TCrpeParamFieldsItem);
var
  iIndexList: Integer;
  sFilterValue: String;
begin
  for iIndexList := 0 to Pred(Length(FRepFilterList)) do
    if FRepFilterList[iIndexList].Name = AParamField.Name then
    begin
      sFilterValue := FRepFilterList[iIndexList].GetValue;
      AParamField.Info.AllowMultipleValues := FRepFilterList[iIndexList].MultValue;

      if AParamField.Info.AllowMultipleValues then
      begin
        AParamField.CurrentValues.Clear;

        while sFilterValue <> '' do
        begin
          AParamField.CurrentValues.Add(Copy(sFilterValue, 1, Pos(';', sFilterValue)-1));
          sFilterValue := Copy(sFilterValue, Pos(';', sFilterValue)+1, Length(sFilterValue));
        end;
      end
      else
        AParamField.CurrentValue := sFilterValue;

      FFiltersString := FFiltersString + FRepFilterList[iIndexList].GetFilterString;
    end;
end;

procedure TReportExplorerFrm.ClearReportInfo;
begin
  lbRepDescription.Text := '';
  lbVersion.Caption        := '';
  imgReportPreview.Picture.Bitmap := nil;
end;

procedure TReportExplorerFrm.LoadReportInfo(fReport: String);
var
  sImage : String;
begin
  ClearReportInfo;

  lbRepDescription.Text    := DMReport.GetAppProperty(fReport, 'Description');
  lbVersion.Caption        := DMReport.GetAppProperty(fReport, 'Version');
  sImage                   := DMReport.GetAppProperty(fReport, 'Image');

  if (sImage <> '') then
  begin
    sImage := DMReport.FAppPath + DMReport.GetAppProperty('Settings', 'ImageDir') + sImage;
    if FileExists(sImage) then
      imgReportPreview.Picture.LoadFromFile(sImage);
  end;
end;

function TReportExplorerFrm.Start: Boolean;
begin
  lbUser.Caption := DMReport.FUser.UserName;
  DMReport.OpenConnection;
  ShowModal;
  DMReport.CloseConnection;
  Result := True;
end;

procedure TReportExplorerFrm.SetSystemFilterValues;
var
  i: Integer;
  sLogoPath: String;
begin
  with crpeReport do
  begin
    for i := 0 to Pred(ParamFields.Count) do
    begin
      if ParamFields[i].Name = 'Sys_User' then
        ParamFields[i].CurrentValue := DMReport.FUser.UserName
      else if ParamFields[i].Name = 'Sys_Filter' then
        ParamFields[i].CurrentValue := FFiltersString
      else if ParamFields[i].Name = 'Sys_Title' then
        ParamFields[i].CurrentValue := lblReportTitle.Caption
      else if ParamFields[i].Name = 'Sys_LogoPath' then
      begin
        sLogoPath := DMReport.GetAppProperty('Default', 'LogoPath');
        if FileExists(sLogoPath) then
          ParamFields[i].CurrentValue := sLogoPath;
      end;
    end;
  end;
end;

procedure TReportExplorerFrm.tlReportExpanded(Sender: TObject;
  Node: TdxTreeListNode);
begin
  if Node.Count > 0 then
  begin
    Node.ImageIndex := IMG_FOLDER_OPEN;
    Node.SelectedIndex := IMG_FOLDER_OPEN;
  end;
end;

procedure TReportExplorerFrm.tlReportCollapsed(Sender: TObject;
  Node: TdxTreeListNode);
begin
  if Node.Count > 0 then
  begin
    Node.ImageIndex := IMG_FOLDER_CLOSE;
    Node.SelectedIndex := IMG_FOLDER_CLOSE;
  end;
end;

procedure TReportExplorerFrm.ReFreshReports;
var
  iParamIndex: Integer;
begin
  crpeReport.ReportName := '';
  LoadReportParams(GetReportFileName(FFocusedNode));
end;
procedure TReportExplorerFrm.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TReportExplorerFrm.LoadPrinterList;
var
  sPrinterList, sPrint : String;
begin

  cmbPrinter.Text            := DMReport.GetAppProperty('Settings', 'Printer');
  sPrinterList               := DMReport.GetAppProperty('Settings', 'PrinterList');

  while (sPrinterList <> '') do
  begin
    sPrint := Copy(sPrinterList, 0, Pos(',', sPrinterList)-1);
    sPrint := StringReplace(sPrint, '"', '', [rfReplaceAll]);
    cmbPrinter.Items.Add(sPrint);
    sPrinterList := Copy(sPrinterList, Pos(',', sPrinterList)+1, Length(sPrinterList));
    if Pos(',', sPrinterList) = 0 then
      sPrinterList := '';
  end;

  SetPrinterSetup;

end;

procedure TReportExplorerFrm.cmbPrinterChange(Sender: TObject);
begin
  SetPrinterSetup;
end;

procedure TReportExplorerFrm.SetPrinterSetup;
begin

  if cmbPrinter.Text <> '' then
    crpeReport.Printer.Name := cmbPrinter.Text;

  crpeReport.Printer.PreserveRptSettings := [prOrientation, prPaperSize, prPaperSource];

end;

end.
