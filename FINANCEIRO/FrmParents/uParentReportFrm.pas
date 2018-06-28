unit uParentReportFrm;

interface

{ By removing the 'x' which begins each of these compiler directives,
  you can enable different functionality within the end-user reporting
  solution.

  DADE - the data tab where queries can be created by the end-user

  BDE  - BDE support for the Query Tools

  ADO  - ADO support for the Query Tools

  IBExpress - Interbase Express support for the Query Tools

  RAP -  the calc tab, where calculations can be coded at run-time
         (RAP is included with ReportBuilder Enterprise)

  CrossTab - adds the CrossTab component to the component palette in the
             report designer.

  CheckBox - adds a checkbox component to the component palette in the
         report designer.

  TeeChart - adds a teechart component to the report designer component
         palette. You must have TeeChart installed. More information
         is available in ..\RBuilder\TeeChart\ReadMe.doc

  UseDesignPath - determines whether the path used by the Database
         object on this form is replaced in the OnCreate event handler of
         this form with the current path.}

{$DEFINE DADE}            {remove the 'x' to enable DADE}
{x$DEFINE BDE}             {remove the 'x' to enable Borland Database Engine (BDE) }
{$DEFINE ADO}            {remove the 'x' to enable ADO}
{x$DEFINE IBExpress}      {remove the 'x' to enable Interbase Express}
{$DEFINE CrossTab}        {remove the 'x' to enable CrossTab}
{$DEFINE RAP}            {remove the 'x' to enable RAP}
{$DEFINE CheckBox}       {remove the 'x' to enable CheckBox}
{x$DEFINE TeeChart}       {remove the 'x' to enable standard TeeChart}
{x$DEFINE TeeChart402}    {remove the 'x' to enable TeeChart 4.02}
{x$DEFINE UseDesignPath}  {remove the 'x' to use the design-time settings of Database object on this form}


uses

{$IFDEF DADE}
  daIDE,
{$ENDIF}

{$IFDEF BDE}
  daDBBDE,
{$ENDIF}

{$IFDEF ADO}
  daADO,
{$ENDIF}

{$IFDEF IBExpress}
  daIBExpress,
{$ENDIF}

{$IFDEF CrossTab}
  ppCTDsgn,
{$ENDIF}

{$IFDEF RAP}
  raIDE,
{$ENDIF}

{$IFDEF CheckBox}
  myChkBox,
{$ENDIF}

{$IFDEF TeeChart}
  ppChrt, ppChrtDP,
{$ENDIF}

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  uParentFixedFrm, ImgList, dxBar, StdCtrls, Buttons, ExtCtrls, ppDB,
  ppCtrls, ppBands, ppModule, daDataModule, ppVar, ppStrtch, ppMemo,
  ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppDsgnDB, ppEndUsr, ppComm,
  ppRelatv, ppDBPipe, ppDBBDE, Db, ADODB, ppViewr, Mask, DBCtrls, dxDBCtrl,
  dxDBGrid, dxTL, dxDBTLCl, dxGrClms, dxCntner, SuperComboADO, siComp,
  siLangRT;

type
  TParentReportFrm = class(TParentFixedFrm)
    Panel4: TPanel;
    gridRep: TdxDBGrid;
    gridRepItemType: TdxDBGridImageColumn;
    dxDBGrid1Number: TdxDBGridColumn;
    dxDBGrid1Name: TdxDBGridMaskColumn;
    pnlFields: TPanel;
    Label1: TLabel;
    edtRepName: TDBEdit;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    trmAviso: TTimer;
    ppViewer: TppViewer;
    Splitter1: TSplitter;
    quReport: TADODataSet;
    quReportItemID: TAutoIncField;
    quReportFolderID: TIntegerField;
    quReportItemType: TIntegerField;
    quReportName: TStringField;
    dsReport: TDataSource;
    quSelectedReport: TADODataSet;
    quSelectedReportFolderID: TIntegerField;
    quSelectedReportTemplate: TBlobField;
    quSelectedReportName: TStringField;
    dsSelectedRep: TDataSource;
    ppPipeline: TppBDEPipeline;
    ppDesigner: TppDesigner;
    ppDataDictionary: TppDataDictionary;
    ppReport: TppReport;
    ppTitleBand2: TppTitleBand;
    ppLabel4: TppLabel;
    ppMemo1: TppMemo;
    ppLine1: TppLine;
    ppLabel11: TppLabel;
    ppHeaderBand2: TppHeaderBand;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppDBText12: TppDBText;
    ppDBText13: TppDBText;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppDBText16: TppDBText;
    ppFooterBand2: TppFooterBand;
    ppLabel22: TppLabel;
    ppLine4: TppLine;
    ppSystemVariable2: TppSystemVariable;
    daDataModule1: TdaDataModule;
    ppModelo: TppReport;
    ppTitleBand1: TppTitleBand;
    lblTitulo: TppLabel;
    mmFiltro: TppMemo;
    ppLine2: TppLine;
    lblNumero: TppLabel;
    ppHeaderBand1: TppHeaderBand;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppFooterBand1: TppFooterBand;
    lblUsuarioData: TppLabel;
    ppLine3: TppLine;
    ppSystemVariable1: TppSystemVariable;
    ppSummaryBand1: TppSummaryBand;
    ppLine5: TppLine;
    ppDBCalc1: TppDBCalc;
    ppDBCalc2: TppDBCalc;
    ppDBCalc3: TppDBCalc;
    ppDBCalc5: TppDBCalc;
    ppDBCalc4: TppDBCalc;
    ppDBCalc6: TppDBCalc;
    ppDBCalc7: TppDBCalc;
    quTable: TADODataSet;
    quTableTableName: TStringField;
    quTableTableAlias: TStringField;
    dsTable: TDataSource;
    plTable: TppDBPipeline;
    quField: TADODataSet;
    quFieldTableName: TStringField;
    quFieldFieldName: TStringField;
    quFieldFieldAlias: TStringField;
    quFieldSelectable: TStringField;
    quFieldSearchable: TStringField;
    quFieldSortable: TStringField;
    quFieldDataType: TStringField;
    quFieldAutoSearch: TStringField;
    quFieldMandatory: TStringField;
    dsField: TDataSource;
    plField: TppDBPipeline;
    quJoin: TADODataSet;
    quJoinTableName1: TStringField;
    quJoinTableName2: TStringField;
    quJoinJoinType: TStringField;
    quJoinFieldNames2: TStringField;
    quJoinFieldNames1: TStringField;
    quJoinOperators: TStringField;
    dsJoin: TDataSource;
    plJoin: TppDBPipeline;
    btnNew: TdxBarButton;
    btnEdit: TdxBarButton;
    btnRemove: TdxBarButton;
    btnOpen: TdxBarButton;
    btnSave: TdxBarButton;
    btnCopy: TdxBarButton;
    btnAll: TdxBarButton;
    btnWidth: TdxBarButton;
    btnFull: TdxBarButton;
    btnFirst: TdxBarButton;
    btnPrior: TdxBarButton;
    btnLast: TdxBarButton;
    btnNext: TdxBarButton;
    edtPagNum: TdxBarEdit;
    btnPrint: TdxBarButton;
    ppLine6: TppLine;
    ppLine7: TppLine;
    btnSaveFilters: TdxBarButton;
    barFilter: TdxBarSubItem;
    btnDelFilters: TdxBarButton;
    btnStopPrint: TdxBarButton;
    quReportFilters: TMemoField;
    btnAppendFilters: TdxBarButton;
    pnlBasicFilter: TPanel;
    pnlExecuta: TPanel;
    pnlAviso: TPanel;
    btExecuta: TSpeedButton;
    procedure btnFullClick(Sender: TObject);
    procedure btnWidthClick(Sender: TObject);
    procedure btnAllClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure trmAvisoTimer(Sender: TObject);
    procedure quReportAfterOpen(DataSet: TDataSet);
    procedure dsReportDataChange(Sender: TObject; Field: TField);
    procedure quSelectedReportAfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPagNumKeyPress(Sender: TObject; var Key: Char);
    procedure ppViewerPageChange(Sender: TObject);
    procedure btnStopPrintClick(Sender: TObject);
    procedure quReportNewRecord(DataSet: TDataSet);
  private
    { Private declarations }

  protected

    procedure EnableBtn;
    procedure DesableBtn;

    procedure OpenDictionary;
    procedure CloseDictionary;

    procedure BuildFilter(Sender : TObject);
    procedure SaveFilter(Sender : TObject);
    procedure AppendFilter(Sender : TObject);

  public
    { Public declarations }
    procedure AtivaAviso;
    procedure DesativaAviso;

  end;

implementation

uses uDM, uMsgBox, uNumericFunctions, uMsgConstant, uSystemConst;

{$R *.DFM}

procedure TParentReportFrm.BuildFilter(Sender : TObject);

        procedure GetValues(var sObj, sValue : String; sText:String);
        var
          i : integer;
        begin
           i := Pos('=',sText);
           sObj := Copy(sText,0,i-1);
           sValue := Copy(sText, i+1, length(sText));
        end;

var
  sFilters : TStringList;
  i,j : integer;
  sObj, sValue : String;
begin

   if quReportFilters.AsString = '' then
      Exit;

   try

     sFilters := TStringList.Create();

     sFilters.CommaText := quReportFilters.AsString;

     for i:=0 to sFilters.Count-1 do
       begin

       GetValues(sObj, sValue, sFilters.Strings[i]);

       if Sender.ClassParent.ClassName = 'TFrame' then
          with TFrame(Sender) do
            for j:=0 to ComponentCount-1 do
               begin
               if Components[j] is TSuperComboADO then
                  if TSuperComboADO(Components[j]).Name = sObj then
                     begin
                     TSuperComboADO(Components[j]).LookUpValue := sValue;
                     break;
                     end;


               if Components[j] is TComboBox then
                  if TComboBox(Components[j]).Name = sObj then
                     begin
                     TComboBox(Components[j]).ItemIndex := MyStrToInt(sValue);
                     break;
                     end;
               end;

       end;

   Finally
     sFilters.Free;
   end;

end;

procedure TParentReportFrm.AppendFilter(Sender : TObject);
var
  i : Integer;
  s, sTemp : String;
  saved, actual : String;
begin

   exit;

   s := '';

   actual := quReportFilters.AsString;

   if Sender.ClassParent.ClassName = 'TFrame' then
      with TFrame(Sender) do
        for i:=0 to ComponentCount-1 do
           begin
           //Super Combo
           if Components[i] is TSuperComboADO then
              if TSuperComboADO(Components[i]).LookUpValue <> '' then
                 begin
                 sTemp := '"'+ TSuperComboADO(Components[i]).Name +'='+
                               TSuperComboADO(Components[i]).LookUpValue+'",';
                 if Pos(sTemp, actual) = 0 then
                    begin
                    s := s + sTemp;
                    saved := saved + TSuperComboADO(Components[i]).Text + '. ';
                    end;
                 end;

           //Combo Box
           if Components[i] is TComboBox then
              begin
              sTemp := '"'+ TComboBox(Components[i]).Name + '=' +
                        IntToStr(TComboBox(Components[i]).ItemIndex)+'",';
              if Pos(sTemp, actual) = 0 then
                 begin
                 s := s + sTemp;
                 saved := saved + TComboBox(Components[i]).Text + '. ';
                 end;
              end;
           end;

   if trim(s) = '' then
      begin
      MsgBox(MSG_INF_NO_FILETER_APPENDED, vbInformation + vbOkOnly);
      Exit;
      end;

   with quReport do
      begin
      if not Active then
         Open;

      if not (State in dsEditModes) then
         Edit;
      end;

   quReportFilters.AsString := quReportFilters.AsString + s;
   quReport.Post;

   MsgBox(MSG_INF_PART_FILTER_APPENDED + saved, vbInformation + vbOkOnly);

end;

procedure TParentReportFrm.SaveFilter(Sender : TObject);
var
  i : Integer;
  s : String;
begin

   if Sender.ClassParent.ClassName = 'TFrame' then
      with TFrame(Sender) do
        for i:=0 to ComponentCount-1 do
           begin
           if Components[i] is TSuperComboADO then
              if TSuperComboADO(Components[i]).LookUpValue <> '' then
                 s := s + '"'+ TSuperComboADO(Components[i]).Name +'='+
                               TSuperComboADO(Components[i]).LookUpValue+'",';

           if Components[i] is TComboBox then
              s :=  s + '"'+ TComboBox(Components[i]).Name + '=' +
                        IntToStr(TComboBox(Components[i]).ItemIndex)+'",';

           end;

   with quReport do
      begin
      if not Active then
         Open;

      if not (State in dsEditModes) then
         Edit;
      end;

   quReportFilters.AsString := s;
   quReport.Post;

   MsgBox(MSG_INF_FILETER_SAVED, vbInformation + vbOkOnly);

end;


procedure TParentReportFrm.AtivaAviso;
begin
   trmAviso.Enabled := True;
end;

procedure TParentReportFrm.DesativaAviso;
begin
  pnlAviso.ParentColor := True;
  trmAviso.Enabled     := False;
end;


procedure TParentReportFrm.EnableBtn;
begin
   btnRemove.Enabled     := True;
   btnEdit.Enabled       := True;
   btnCopy.Enabled       := True;
   btnSave.Enabled       := True;
end;

procedure TParentReportFrm.DesableBtn;
begin
   btnRemove.Enabled     := False;
   btnEdit.Enabled       := False;
   btnCopy.Enabled       := False;
   btnSave.Enabled       := False;
end;

procedure TParentReportFrm.CloseDictionary;
begin

  quTable.Close;
  quField.Close;
  quJoin.Close;

end;

procedure TParentReportFrm.OpenDictionary;
begin

  quTable.Open;
  quField.Open;
  quJoin.Open;

end;


procedure TParentReportFrm.btnFullClick(Sender: TObject);
begin
  inherited;

  ppViewer.ZoomSetting := zs100Percent;
//  mskPreviewPercentage.Text := IntToStr(ppViewer.CalculatedZoom);

end;

procedure TParentReportFrm.btnWidthClick(Sender: TObject);
begin
  inherited;

    ppViewer.ZoomSetting := zsPageWidth;
//  mskPreviewPercentage.Text := IntToStr(ppViewer.CalculatedZoom);

end;

procedure TParentReportFrm.btnAllClick(Sender: TObject);
begin
  inherited;

  ppViewer.ZoomSetting := zsWholePage;
//  mskPreviewPercentage.Text := IntToStr(ppViewer.CalculatedZoom);
  
end;

procedure TParentReportFrm.btnFirstClick(Sender: TObject);
begin
  inherited;

  ppViewer.FirstPage;
  
end;

procedure TParentReportFrm.btnPriorClick(Sender: TObject);
begin
  inherited;

    ppViewer.PriorPage;

end;

procedure TParentReportFrm.btnNextClick(Sender: TObject);
begin
  inherited;

    ppViewer.NextPage;

end;

procedure TParentReportFrm.btnLastClick(Sender: TObject);
begin
  inherited;

    ppViewer.LastPage;

end;

procedure TParentReportFrm.btnPrintClick(Sender: TObject);
begin
  inherited;

    ppReport.Print;

end;

procedure TParentReportFrm.btnCopyClick(Sender: TObject);
begin
  inherited;

    //Copia Report
  With DM.quFreeSQL do
    begin
    if Active then
       Close;

    SQL.Clear;
    SQL.Add('INSERT Rep_Item (FolderID, Name, Filters, Template)');
    SQL.Add('SELECT FolderID, '+ QuotedStr('Copy of '+quReportName.AsString)+', Filters, Template ');
    SQL.Add('FROM Rep_Item WHERE ItemID = '+quReportItemID.AsString);

    ExecSQL;

    Close;
    end;

end;

procedure TParentReportFrm.trmAvisoTimer(Sender: TObject);
begin
  inherited;

    if pnlAviso.ParentColor = True then
     pnlAviso.Color := $00FFA851
  else
     pnlAviso.ParentColor := True;

end;

procedure TParentReportFrm.quReportAfterOpen(DataSet: TDataSet);
begin
  inherited;

   OpenDictionary;

end;

procedure TParentReportFrm.dsReportDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;

  DesableBtn;

end;

procedure TParentReportFrm.quSelectedReportAfterOpen(DataSet: TDataSet);
begin
  inherited;

    OpenDictionary;

end;

procedure TParentReportFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  CloseDictionary;

end;

procedure TParentReportFrm.edtPagNumKeyPress(Sender: TObject;
  var Key: Char);
var
  liPage: Longint;
begin
  inherited;

  if (Key = #13) then
    begin
      liPage := MyStrToInt(edtPagNum.Text);
      ppViewer.GotoPage(liPage);
    end;


end;

procedure TParentReportFrm.ppViewerPageChange(Sender: TObject);
begin
  inherited;

  edtPagNum.Text := IntToStr(ppViewer.AbsolutePageNo); 

end;

procedure TParentReportFrm.btnStopPrintClick(Sender: TObject);
begin
  inherited;

  ppReport.Cancel;

end;

procedure TParentReportFrm.quReportNewRecord(DataSet: TDataSet);
begin
  inherited;
  quReportItemID.AsInteger := DM.GetNextID(OM_REPORT_ID);
end;

end.
