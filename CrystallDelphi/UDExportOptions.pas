unit UDExportOptions;

interface

uses
  SysUtils, Classes, Controls, Forms, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Graphics,  Dialogs,
  UCrpe32;

type
  TCrpeExportOptionsDlg = class(TForm)
    pnlExport: TPanel;
    pnlDestination: TPanel;
    cbKeepOpen: TCheckBox;
    btnExport: TBitBtn;
    SaveDialog1: TSaveDialog;
    pnlDestinations: TPanel;
    pcDestination: TPageControl;
    tsToFile: TTabSheet;
    tsToEmailViaMapi: TTabSheet;
    tsToEmailViaVim: TTabSheet;
    tsToMsExchange: TTabSheet;
    tsToLotusNotes: TTabSheet;
    tsToApplication: TTabSheet;
    pnlFile: TPanel;
    lblFileName: TLabel;
    editFileName: TEdit;
    btnEdit: TButton;
    pnlApplication: TPanel;
    lblAFileName: TLabel;
    lblAppName: TLabel;
    editAFileName: TEdit;
    btnAFileName: TButton;
    editAppName: TEdit;
    btnApplication: TButton;
    pnlExchange: TPanel;
    lblProfile: TLabel;
    lblExchangePassword: TLabel;
    lblFolder: TLabel;
    editProfile: TEdit;
    editFolder: TEdit;
    editExchangePassword: TEdit;
    pnlMapi: TPanel;
    lblSubject: TLabel;
    lblMessage: TLabel;
    lblCCList: TLabel;
    lblToList: TLabel;
    editToList: TEdit;
    editCCList: TEdit;
    editSubject: TEdit;
    memoMessage: TMemo;
    pnlEmailVim: TPanel;
    lblVimSubject: TLabel;
    lblVimMessage: TLabel;
    lblVimTo: TLabel;
    lblVimCC: TLabel;
    lblVimBcc: TLabel;
    editVimTo: TEdit;
    editVimCC: TEdit;
    editVimSubject: TEdit;
    memoVimMessage: TMemo;
    editVimBcc: TEdit;
    pnlLotusNotes: TPanel;
    lblDBName: TLabel;
    lblComments: TLabel;
    lblFormName: TLabel;
    editDBName: TEdit;
    editFormName: TEdit;
    editComments: TEdit;
    btnClear: TButton;
    btnCancel: TButton;
    btnOk: TButton;
    rgDestination: TRadioGroup;
    rgFileType: TRadioGroup;
    btnOptions: TButton;
    cbPromptForOptions: TCheckBox;
    cbPromptOnOverwrite: TCheckBox;
    cbProgressDialog: TCheckBox;
    editUserName: TEdit;
    lblUserName: TLabel;
    editPassword: TEdit;
    lblPassword: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportClick(Sender: TObject);
    procedure editFileNameDblClick(Sender: TObject);
    procedure cbPromptForOptionsClick(Sender: TObject);
    procedure rgDestinationClick(Sender: TObject);
    procedure cbKeepOpenClick(Sender: TObject);
    procedure cbProgressDialogClick(Sender: TObject);
    procedure editFileNameChange(Sender: TObject);
    procedure editProfileChange(Sender: TObject);
    procedure editFolderChange(Sender: TObject);
    procedure editExchangePasswordChange(Sender: TObject);
    procedure editToListChange(Sender: TObject);
    procedure editCCListChange(Sender: TObject);
    procedure editSubjectChange(Sender: TObject);
    procedure memoMessageChange(Sender: TObject);
    procedure editToListVChange(Sender: TObject);
    procedure editCCListVChange(Sender: TObject);
    procedure editBCCListVChange(Sender: TObject);
    procedure editSubjectVChange(Sender: TObject);
    procedure memoMessageVChange(Sender: TObject);
    procedure cbPromptOnOverwriteClick(Sender: TObject);
    procedure editAFileNameChange(Sender: TObject);
    procedure editAFileNameDblClick(Sender: TObject);
    procedure editAppNameChange(Sender: TObject);
    procedure editAppNameDblClick(Sender: TObject);
    procedure pcDestinationChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgFileTypeClick(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure editUserNameChange(Sender: TObject);
    procedure editPasswordChange(Sender: TObject);
  private
    { Private declarations }
    ExportPath         : string;
    {Export variables}
    rAppName           : string;
    rFileName          : string;
    rFileType          : integer;
    rDestination       : integer;
    rPromptForOptions  : boolean;
    rPromptOnOverwrite : boolean;
    {Email}
    rToList,
    rCCList,
    rMessage,
    rSubject,
    rPassword,
    rUserName,
    rBCCList           : string;
    {Excel}
    rArea               : string;
    rChopPageHeader     : boolean;
    rColumnWidth        : integer;
    rConstant           : double;
    rConvertDatesToStrings : boolean;
    rCreatePageBreaks   : boolean;
    rExportHeaderFooter : boolean;
    rExcelFirstPage     : word;
    rExcelLastPage      : word;
    rExcelUsePageRange  : boolean;
    rWorksheetFunctions : boolean;
    rXLSType            : integer;
    {Exchange}
    rFolder,
    rExchPassword,
    rProfile           : string;
    {HTML}
    rHTMLFirstPage     : word;
    rHTMLLastPage      : word;
    rPageNavigator     : boolean;
    rSeparatePages     : boolean;
    rHTMLUsePageRange  : boolean;
    {LotusNotes}
    rDBName            : string;
    rFormName          : string;
    rComments          : string;
    {ODBC}
    rODBCPrompt        : boolean;
    rODBCPassword,
    rODBCSource,
    rODBCTable,
    rODBCUser          : string;
    {PDF}
    rPDFUsePageRange   : Boolean;
    rPDFFirstPage      : Word;
    rPDFLastPage       : Word;
    rPDFPrompt         : boolean;
    {RTF}
    rRTFUsePageRange   : Boolean;
    rRTFFirstPage      : Word;
    rRTFLastPage       : Word;
    rRTFPrompt         : boolean;
    {Text Options}
    rUseRptNumberFmt   : boolean;
    rUseRptDateFmt     : boolean;
    rStringDelimiter   : char;
    rFieldSeparator    : string;
    rLinesPerPage      : word;
    rCharPerInch       : word;
    rRecordsType       : integer;
    {MSWord}
    rWordFirstPage     : word;
    rWordLastPage      : word;
    rWordPrompt        : boolean;
    rWordUsePageRange  : boolean;
    {XML}
    rXMLPrompt         : boolean;
    rXMLSeparatePages  : Boolean;
  public
    { Public declarations }
    Cr : TCrpe;
  end;

var
  CrpeExportOptionsDlg: TCrpeExportOptionsDlg;
  bExportOptions      : boolean;

implementation

{$R *.DFM}

uses UDExportSepVal, UDExportOdbc, UDExportPagText, UDExportExcel,
  UDExportHTML4, UDExportRTF, UDExportPDF, UDExportXML, UDExportRecords,
  UDExportWord, UCrpeUtl;

{------------------------------------------------------------------------------}
{ FormCreate procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.FormCreate(Sender: TObject);
begin
  bExportOptions := True;
  LoadFormPos(Self);
  btnOk.Tag := 1;
  btnCancel.Tag := 1;
  btnClear.Tag := 1;
end;
{------------------------------------------------------------------------------}
{ FormShow procedure                                                           }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.FormShow(Sender: TObject);
begin
  {Store original settings}
  rAppName           := Cr.ExportOptions.AppName;
  rFileName          := Cr.ExportOptions.FileName;
  rFileType          := Ord(Cr.ExportOptions.FileType);
  rDestination       := Ord(Cr.ExportOptions.Destination);
  rPromptForOptions  := Cr.ExportOptions.PromptForOptions;
  rPromptOnOverwrite := Cr.ExportOptions.PromptOnOverwrite;
  {Email}
  rCCList            := Cr.ExportOptions.Email.CCList;
  rMessage           := Cr.ExportOptions.Email.Message;
  rSubject           := Cr.ExportOptions.Email.Subject;
  rToList            := Cr.ExportOptions.Email.ToList;
  rBCCList           := Cr.ExportOptions.Email.BCCList;
  rPassword          := Cr.ExportOptions.Email.Password;
  rUserName          := Cr.ExportOptions.Email.UserName;
  {Exchange}
  rFolder            := Cr.ExportOptions.Exchange.Folder;
  rExchPassword      := Cr.ExportOptions.Exchange.Password;
  rProfile           := Cr.ExportOptions.Exchange.Profile;
  {LotusNotes}
  rDBName            := Cr.ExportOptions.LotusNotes.DBName;
  rFormName          := Cr.ExportOptions.LotusNotes.FormName;
  rComments          := Cr.ExportOptions.LotusNotes.Comments;
  {Excel}
  rArea                  := Cr.ExportOptions.Excel.Area;
  rColumnWidth           := Ord(Cr.ExportOptions.Excel.ColumnWidth);
  rConstant              := Cr.ExportOptions.Excel.Constant;
  rWorksheetFunctions    := Cr.ExportOptions.Excel.WorksheetFunctions;
  rXLSType               := Ord(Cr.ExportOptions.Excel.XLSType);
  rChopPageHeader        := Cr.ExportOptions.Excel.ChopPageHeader;
  rConvertDatesToStrings := Cr.ExportOptions.Excel.ConvertDatesToStrings;
  rCreatePageBreaks      := Cr.ExportOptions.Excel.CreatePageBreaks;
  rExportHeaderFooter    := Cr.ExportOptions.Excel.ExportHeaderFooter;
  rExcelFirstPage        := Cr.ExportOptions.Excel.FirstPage;
  rExcelLastPage         := Cr.ExportOptions.Excel.LastPage;
  rExcelUsePageRange     := Cr.ExportOptions.Excel.UsePageRange;
  {HTML}
  rHTMLFirstPage     := Cr.ExportOptions.HTML.FirstPage;
  rHTMLLastPage      := Cr.ExportOptions.HTML.LastPage;
  rPageNavigator     := Cr.ExportOptions.HTML.PageNavigator;
  rSeparatePages     := Cr.ExportOptions.HTML.SeparatePages;
  rHTMLUsePageRange  := Cr.ExportOptions.HTML.UsePageRange;
  {ODBC}
  rODBCPassword      := Cr.ExportOptions.ODBC.Password;
  rODBCSource        := Cr.ExportOptions.ODBC.Source;
  rODBCTable         := Cr.ExportOptions.ODBC.Table;
  rODBCUser          := Cr.ExportOptions.ODBC.User;
  rODBCPrompt        := Cr.ExportOptions.ODBC.Prompt;
  {PDF}
  rPDFUsePageRange   := Cr.ExportOptions.PDF.UsePageRange;
  rPDFFirstPage      := Cr.ExportOptions.PDF.FirstPage;
  rPDFLastPage       := Cr.ExportOptions.PDF.LastPage;
  rPDFPrompt         := Cr.ExportOptions.PDF.Prompt;
  {RTF}
  rRTFUsePageRange   := Cr.ExportOptions.RTF.UsePageRange;
  rRTFFirstPage      := Cr.ExportOptions.RTF.FirstPage;
  rRTFLastPage       := Cr.ExportOptions.RTF.LastPage;
  rRTFPrompt         := Cr.ExportOptions.RTF.Prompt;
  {Text Options}
  rUseRptNumberFmt   := Cr.ExportOptions.Text.UseRptNumberFmt;
  rUseRptDateFmt     := Cr.ExportOptions.Text.UseRptDateFmt;
  rStringDelimiter   := Cr.ExportOptions.Text.StringDelimiter;
  rFieldSeparator    := Cr.ExportOptions.Text.FieldSeparator;
  rLinesPerPage      := Cr.ExportOptions.Text.LinesPerPage;
  rCharPerInch       := Cr.ExportOptions.Text.CharPerInch;
  rRecordsType       := Ord(Cr.ExportOptions.Text.RecordsType);
  {MSWord}
  rWordFirstPage     := Cr.ExportOptions.Word.FirstPage;
  rWordLastPage      := Cr.ExportOptions.Word.LastPage;
  rWordPrompt        := Cr.ExportOptions.Word.Prompt;
  rWordUsePageRange  := Cr.ExportOptions.Word.UsePageRange;
  {XML}
  rXMLPrompt         := Cr.ExportOptions.XML.Prompt;
  rXMLSeparatePages  := Cr.ExportOptions.XML.SeparatePages;

  {Set the Active FileType}
  rgFileType.ItemIndex := Ord(Cr.ExportOptions.FileType);
  case rgFileType.ItemIndex of
    1,8,11 : btnOptions.Enabled := False;
    0,2,3,4,5,6,7,9,10,12,13 : btnOptions.Enabled := True;
  end;
  {FileName}
  editFileName.Text := Cr.ExportOptions.FileName;
  {Set Destination, Form Height, Panels}
  rgDestination.ItemIndex := Ord(Cr.ExportOptions.Destination);
  rgDestinationClick(Self);
  {Check Boxes}
  cbPromptForOptions.Checked := Cr.ExportOptions.PromptForOptions;
  cbPromptOnOverwrite.Checked := Cr.ExportOptions.PromptOnOverwrite;
  cbProgressDialog.Checked := Cr.ProgressDialog;
end;
{------------------------------------------------------------------------------}
{ btnOptionsClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.btnOptionsClick(Sender: TObject);
begin
  case rgFileType.ItemIndex of
    0 : begin
          CrpeAdobeAcrobatPDFDlg := TCrpeAdobeAcrobatPDFDlg.Create(Application);
          CrpeAdobeAcrobatPDFDlg.Cr := Cr;
          CrpeAdobeAcrobatPDFDlg.ShowModal;
        end;
    1 : {CrystalReportRPT, no options};
    2 : begin
          CrpeHTML4Dlg := TCrpeHTML4Dlg.Create(Application);
          CrpeHTML4Dlg.Cr := Cr;
          CrpeHTML4Dlg.ShowModal;
        end;
    3 : begin
          CrpeHTML4Dlg := TCrpeHTML4Dlg.Create(Application);
          CrpeHTML4Dlg.Cr := Cr;
          CrpeHTML4Dlg.ShowModal;
        end;
    4 : begin
          CrpeExcelDlg := TCrpeExcelDlg.Create(Application);
          CrpeExcelDlg.Cr := Cr;
          CrpeExcelDlg.ShowModal;
        end;
    5 : begin
          CrpeWordDlg := TCrpeWordDlg.Create(Application);
          CrpeWordDlg.Cr := Cr;
          CrpeWordDlg.ShowModal;
        end;
    6 : begin
          CrpeOdbcDlg := TCrpeOdbcDlg.Create(Application);
          CrpeOdbcDlg.Cr := Cr;
          CrpeOdbcDlg.ShowModal;
        end;
    7 : begin
          CrpeExportRecordsDlg := TCrpeExportRecordsDlg.Create(Application);
          CrpeExportRecordsDlg.Cr := Cr;
          CrpeExportRecordsDlg.ShowModal;
        end;
    8 : {ReportDefinition, no options};
    9 : begin
          CrpeRichTextFormatDlg := TCrpeRichTextFormatDlg.Create(Application);
          CrpeRichTextFormatDlg.Cr := Cr;
          CrpeRichTextFormatDlg.ShowModal;
        end;
   10 : begin
          CrpeSepValDlg := TCrpeSepValDlg.Create(Application);
          CrpeSepValDlg.Cr := Cr;
          CrpeSepValDlg.ShowModal;
        end;
   11 : {TabSeparatedText, no options};
   12 : begin
          CrpePagTextDlg := TCrpePagTextDlg.Create(Application);
          CrpePagTextDlg.Cr := Cr;
          CrpePagTextDlg.ShowModal;
        end;
   13 : begin
          CrpeXML1Dlg := TCrpeXML1Dlg.Create(Application);
          CrpeXML1Dlg.Cr := Cr;
          CrpeXML1Dlg.ShowModal;
        end;
  end;
end;
{------------------------------------------------------------------------------}
{ rgFileTypeClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.rgFileTypeClick(Sender: TObject);
var
  OnOff : boolean;
begin
  case rgFileType.ItemIndex of
    0 : Cr.ExportOptions.FileType := AdobeAcrobatPDF;
    1 : Cr.ExportOptions.FileType := CrystalReportRPT;
    2 : Cr.ExportOptions.FileType := HTML32;
    3 : Cr.ExportOptions.FileType := HTML40;
    4 : Cr.ExportOptions.FileType := MSExcel;
    5 : Cr.ExportOptions.FileType := MSWord;
    6 : Cr.ExportOptions.FileType := ODBCTable;
    7 : Cr.ExportOptions.FileType := Records;
    8 : Cr.ExportOptions.FileType := ReportDefinition;
    9 : Cr.ExportOptions.FileType := RichText;
    10: Cr.ExportOptions.FileType := SeparatedValues;
    11: Cr.ExportOptions.FileType := TabSeparatedText;
    12: Cr.ExportOptions.FileType := TextFormat;
    13: Cr.ExportOptions.FileType := XML1;
  end;
  OnOff := (rgFileType.ItemIndex <> 6);
  {Set Colors}
  editFileName.Color := ColorState(OnOff);
  editFileName.Enabled := OnOff;
  {Email}
  editUserName.Color := ColorState(OnOff);
  editPassword.Color := ColorState(OnOff);
  editToList.Color := ColorState(OnOff);
  editCCList.Color := ColorState(OnOff);
  editSubject.Color := ColorState(OnOff);
  memoMessage.Color := ColorState(OnOff);
  {VIM}
  editVimTo.Color := ColorState(OnOff);
  editVimCC.Color := ColorState(OnOff);
  editVimBCC.Color := ColorState(OnOff);
  editVimSubject.Color := ColorState(OnOff);
  memoVimMessage.Color := ColorState(OnOff);
  {Exchange}
  editProfile.Color := ColorState(OnOff);
  editFolder.Color := ColorState(OnOff);
  editExchangePassword.Color := ColorState(OnOff);
  {LotusNotes}
  editDBName.Color := ColorState(OnOff);
  editFormName.Color := ColorState(OnOff);
  editComments.Color := ColorState(OnOff);
  {Application}
  editAFileName.Color := ColorState(OnOff);
  editAFileName.Enabled := OnOff;
  editAppName.Color := ColorState(OnOff);
  editAppName.Enabled := OnOff;
  {Enable/Disable applicable controls}
  pcDestination.Enabled := OnOff;
  case rgFileType.ItemIndex of
    1,8,11 : btnOptions.Enabled := False;
    0,2,3,4,5,6,7,9,10,12,13 : btnOptions.Enabled := True;
  end;
end;
{------------------------------------------------------------------------------}
{ cbPromptForOptionsClick procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.cbPromptForOptionsClick(Sender: TObject);
var
  OnOff : Boolean;
begin
  Cr.ExportOptions.PromptForOptions := cbPromptForOptions.Checked;
  OnOff := not cbPromptForOptions.Checked;
  if OnOff = True then
    OnOff := not (rgFileType.ItemIndex = 6);
  {Set Colors}
  editFileName.Color := ColorState(OnOff);
  editFileName.Enabled := OnOff;
  {Email}
  editUserName.Color := ColorState(OnOff);
  editPassword.Color := ColorState(OnOff);
  editToList.Color := ColorState(OnOff);
  editCCList.Color := ColorState(OnOff);
  editSubject.Color := ColorState(OnOff);
  memoMessage.Color := ColorState(OnOff);
  {VIM}
  editVimTo.Color := ColorState(OnOff);
  editVimCC.Color := ColorState(OnOff);
  editVimBCC.Color := ColorState(OnOff);
  editVimSubject.Color := ColorState(OnOff);
  memoVimMessage.Color := ColorState(OnOff);
  {Exchange}
  editProfile.Color := ColorState(OnOff);
  editFolder.Color := ColorState(OnOff);
  editExchangePassword.Color := ColorState(OnOff);
  {LotusNotes}
  editDBName.Color := ColorState(OnOff);
  editFormName.Color := ColorState(OnOff);
  editComments.Color := ColorState(OnOff);
  {Application}
  editAFileName.Color := ColorState(OnOff);
  editAFileName.Enabled := OnOff;
  editAppName.Color := ColorState(OnOff);
  editAppName.Enabled := OnOff;
  {Enable/Disable applicable controls}
  pcDestination.Enabled := OnOff;
end;
{------------------------------------------------------------------------------}
{ cbPromptOnOverwriteClick procedure                                           }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.cbPromptOnOverwriteClick(Sender: TObject);
begin
  Cr.ExportOptions.PromptOnOverwrite := cbPromptOnOverwrite.Checked;
end;
{------------------------------------------------------------------------------}
{ rgExportToClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.rgDestinationClick(Sender: TObject);
begin
  case rgDestination.ItemIndex of
    {toFile}
    0: begin
         pcDestination.ActivePage := tsToFile;
         Cr.ExportOptions.Destination := toFile;
         editFileName.Text := Cr.ExportOptions.FileName;
       end;
    {toEmailViaMapi}
    1: begin
         pcDestination.ActivePage := tsToEmailViaMapi;
         Cr.ExportOptions.Destination := toEmailViaMapi;
         editUserName.Text := Cr.ExportOptions.Email.UserName;
         editPassword.Text := Cr.ExportOptions.Email.Password;
         editToList.Text := Cr.ExportOptions.Email.ToList;
         editCCList.Text := Cr.ExportOptions.Email.CCList;
         editSubject.Text := Cr.ExportOptions.Email.Subject;
         memoMessage.Text := Cr.ExportOptions.Email.Message;
       end;
    {toEmailViaVIM}
    2: begin
         pcDestination.ActivePage := tsToEmailViaVim;
         Cr.ExportOptions.Destination := toEmailViaVIM;
         editVimTo.Text := Cr.ExportOptions.Email.ToList;
         editVimCC.Text := Cr.ExportOptions.Email.CCList;
         editVimBCC.Text := Cr.ExportOptions.Email.BCCList;
         editVimSubject.Text := Cr.ExportOptions.Email.Subject;
         memoVimMessage.Text := Cr.ExportOptions.Email.Message;
       end;
    {toExchangeFolder}
    3: begin
         pcDestination.ActivePage := tsToMsExchange;
         Cr.ExportOptions.Destination := toMSExchange;
         editProfile.Text := Cr.ExportOptions.Exchange.Profile;
         editFolder.Text := Cr.ExportOptions.Exchange.Folder;
         editExchangePassword.Text := Cr.ExportOptions.Exchange.Password;
       end;
    {toLotusNotes}
    4: begin
         pcDestination.ActivePage := tsToLotusNotes;
         Cr.ExportOptions.Destination := toLotusNotes;
         editDBName.Text := Cr.ExportOptions.LotusNotes.DBName;
         editFormName.Text := Cr.ExportOptions.LotusNotes.FormName;
         editComments.Text := Cr.ExportOptions.LotusNotes.Comments;
       end;
    {toApplication}
    5: begin
         pcDestination.ActivePage := tsToApplication;
         Cr.ExportOptions.Destination := toApplication;
         editAFileName.Text := Cr.ExportOptions.FileName;
         editAppName.Text := Cr.ExportOptions.AppName;
       end;
  end;
end;
{------------------------------------------------------------------------------}
{ editFileNameChange procedure                                                 }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editFileNameChange(Sender: TObject);
begin
  Cr.ExportOptions.FileName := editFileName.Text;
  ExportPath := ExtractFilePath(editFileName.Text);
end;
{------------------------------------------------------------------------------}
{ editFileNameDblClick procedure                                               }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editFileNameDblClick(Sender: TObject);
const
  FileExtensions : array[TCrExportType] of string = ('.pdf',
    '.rpt', '.html', '.html', '.xls', '.doc', '.doc', '', '.rec',
    '.txt', '.rtf', '.csv', '.ttx', '.txt', '.xml');

  FileTypes : array [TCrExportType] of string = ('Portable Document Format',
    'Crystal Report', 'HTML 3.2 (Standard)', 'HTML 4.0 (dHTML)',
    'MS Excel 97-2000 Workbook', 'MS Word', 'MS Word - Editable', 'Not applicable to ODBC',
    'Record Style', 'Report Definition', 'Rich Text Format',
    'Separated Values', 'Tab-separated', 'Paginated Text',
    'Extensible Markup Language');
var
  ext : string;
begin
  {Set the Save Dialog Options}
  SaveDialog1.Title := 'Set Export Path & Filename...';
  SaveDialog1.InitialDir := ExportPath;
  SaveDialog1.FileName := editFileName.Text;
  ext := FileExtensions[Cr.ExportOptions.FileType];
  SaveDialog1.Filter := FileTypes[Cr.ExportOptions.FileType] +
    ' (' + ext + ')|' + ext + '|All files (*.*) | *.*';
  SaveDialog1.Options := [ofPathMustExist, ofHideReadOnly, ofNoReadOnlyReturn];
  if SaveDialog1.Execute then
  begin
    editFileName.Text := SaveDialog1.Filename;
    {Store the Export Path for next time}
    ExportPath := ExtractFilePath(SaveDialog1.Filename);
  end;
end;
{------------------------------------------------------------------------------}
{ Exchange: editProfileChange procedure                                        }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editProfileChange(Sender: TObject);
begin
  Cr.ExportOptions.Exchange.Profile := editProfile.Text;
end;
{------------------------------------------------------------------------------}
{ Exchange: editFolderChange procedure                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editFolderChange(Sender: TObject);
begin
  Cr.ExportOptions.Exchange.Folder := editFolder.Text;
end;
{------------------------------------------------------------------------------}
{ Exchange: editPasswordChange procedure                                       }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editExchangePasswordChange(Sender: TObject);
begin
  Cr.ExportOptions.Exchange.Password := editExchangePassword.Text;
end;
{------------------------------------------------------------------------------}
{ Mapi: editUserNameChange procedure                                           }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editUserNameChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.UserName := editUserName.Text;
end;
{------------------------------------------------------------------------------}
{ Mapi: editPasswordChange procedure                                           }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editPasswordChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.Password := editPassword.Text;
end;
{------------------------------------------------------------------------------}
{ Mapi: editToListChange procedure                                             }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editToListChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.ToList := editToList.Text;
end;
{------------------------------------------------------------------------------}
{ Mapi: editCCListChange procedure                                             }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editCCListChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.CCList := editCCList.Text;
end;
{------------------------------------------------------------------------------}
{ Mapi: editSubjectChange procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editSubjectChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.Subject := editSubject.Text;
end;
{------------------------------------------------------------------------------}
{ Mapi: memoMessageChange procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.memoMessageChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.Message := memoMessage.Text;
end;
{------------------------------------------------------------------------------}
{ VIM: editToListVChange procedure                                             }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editToListVChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.ToList := editVimTo.Text;
end;
{------------------------------------------------------------------------------}
{ VIM: editCCListVChange procedure                                             }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editCCListVChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.CCList := editVimCC.Text;
end;
{------------------------------------------------------------------------------}
{ VIM: editBCCListVChange procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editBCCListVChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.BCCList := editVimBCC.Text;
end;
{------------------------------------------------------------------------------}
{ VIM: editSubjectVChange procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editSubjectVChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.Subject := editVimSubject.Text;
end;
{------------------------------------------------------------------------------}
{ VIM: memoMessageVChange procedure                                            }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.memoMessageVChange(Sender: TObject);
begin
  Cr.ExportOptions.Email.Message := memoVimMessage.Text;
end;
{------------------------------------------------------------------------------}
{ Application: editAFileNameChange procedure                                   }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editAFileNameChange(Sender: TObject);
begin
  Cr.ExportOptions.FileName := editAFileName.Text;
  ExportPath := ExtractFilePath(editAFileName.Text);
end;
{------------------------------------------------------------------------------}
{ Application: editAFileNameDblClick procedure                                 }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editAFileNameDblClick(Sender: TObject);
const
  FileExtensions : array[TCrExportType] of string = ('.pdf',
    '.rpt', '.html', '.html', '.xls', '.doc', '.doc', '', '.rec',
    '.txt', '.rtf', '.csv', '.ttx', '.txt', '.xml');

  FileTypes : array [TCrExportType] of string = ('Portable Document Format',
    'Crystal Report', 'HTML 3.2 (Standard)', 'HTML 4.0 (dHTML)',
    'MS Excel 97-2000 Workbook', 'MS Word', 'MS Word - Editable', 'Not applicable to ODBC',
    'Record Style', 'Report Definition', 'Rich Text Format',
    'Separated Values', 'Tab-separated', 'Paginated Text',
    'Extensible Markup Language');
var
  ext : string;
begin
  {Set the Save Dialog Options}
  SaveDialog1.Title := 'Set Export Path & Filename...';
  SaveDialog1.InitialDir := ExportPath;
  SaveDialog1.FileName := editAFileName.Text;
  ext := FileExtensions[Cr.ExportOptions.FileType];
  SaveDialog1.Filter := FileTypes[Cr.ExportOptions.FileType] +
    ' (' + ext + ')|' + ext + '|All files (*.*) | *.*';
  SaveDialog1.Options := [ofPathMustExist, ofHideReadOnly, ofNoReadOnlyReturn];
  if SaveDialog1.Execute then
  begin
    editAFileName.Text := SaveDialog1.Filename;
    {Store the Export Path for next time}
    ExportPath := ExtractFilePath(SaveDialog1.Filename);
  end;
end;
{------------------------------------------------------------------------------}
{ Application: editAppNameChange procedure                                     }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editAppNameChange(Sender: TObject);
begin
  Cr.ExportOptions.AppName := editAppName.Text;
end;
{------------------------------------------------------------------------------}
{ Application: editAppNameDblClick procedure                                   }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.editAppNameDblClick(Sender: TObject);
begin
  {Set the Save Dialog Options}
  SaveDialog1.Title := 'Select Application...';
  SaveDialog1.InitialDir := ExportPath;
  SaveDialog1.FileName := editAppName.Text;
  SaveDialog1.Filter := 'Application Files (*.exe) | *.exe|All files (*.*) | *.*';
  SaveDialog1.Options := [ofPathMustExist, ofFileMustExist, ofHideReadOnly];
  if SaveDialog1.Execute then
    editAppName.Text := SaveDialog1.Filename;
end;
{------------------------------------------------------------------------------}
{ pcDestinationChange procedure                                                }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.pcDestinationChange(Sender: TObject);
var
  i: integer;
begin
  {Update the Export Destination radio button with the Active Destination Page}
  for i := 0 to pcDestination.PageCount - 1 do
  begin
    if pcDestination.Pages[i] = pcDestination.ActivePage then
       Break;
  end;
  rgDestination.ItemIndex := i;
end;
{------------------------------------------------------------------------------}
{ cbProgressDialogClick procedure                                              }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.cbProgressDialogClick(Sender: TObject);
begin
  Cr.ProgressDialog := cbProgressDialog.Checked;
end;
{------------------------------------------------------------------------------}
{ cbKeepOpenClick procedure                                                    }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.cbKeepOpenClick(Sender: TObject);
begin
  if cbKeepOpen.Checked = True then
    btnExport.ModalResult := mrNone
  else
    btnExport.ModalResult := mrOk;
end;
{------------------------------------------------------------------------------}
{ btnExportClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.btnExportClick(Sender: TObject);
var
  stop    : boolean;
  prevOut : TCrOutput;
begin
  {Initialize stop variable}
  stop := False;
  if not cbPromptForOptions.Checked then
  begin
    {Check to make sure output file is specified}
    case rgDestination.ItemIndex of
      0: {toFile}
      begin
        if Cr.ExportOptions.FileType <> ODBCTable then
        begin
          if editFileName.Text = '' then
          begin
            if MessageDlg('No Export FileName entered!' + Chr(10) +
              'Continue anyway?', mtWarning, [mbYes, mbNo], 0) = mrNo then
              stop := True;
          end
        end;
      end;
      1: {toEmailViaMapi}
      begin
        if editToList.Text = '' then
        begin
          if MessageDlg('No "To:" address entered!' + Chr(10) +
            'Continue anyway?', mtWarning, [mbYes, mbNo], 0) = mrNo then
            stop := True;
        end;
      end;
      2: {toEmailViaVIM}
      begin
        if editVimTo.Text = '' then
        begin
          if MessageDlg('No "To:" address entered!' + Chr(10) +
            'Continue anyway?', mtWarning, [mbYes, mbNo], 0) = mrNo then
            stop := True;
        end;
      end;
      3: {toMSExchange}
      begin
        if editProfile.Text = '' then
        begin
          if MessageDlg('No Exchange Profile entered!' + Chr(10) +
            'Continue anyway?', mtWarning, [mbYes, mbNo], 0) = mrNo then
            stop := True;
        end;
      end;
      4: {toLotusNotes}
      begin
        if editDBName.Text = '' then
        begin
          if MessageDlg('No Lotus Notes DBName entered!' + Chr(10) +
            'Continue anyway?', mtWarning, [mbYes, mbNo], 0) = mrNo then
            stop := True;
        end;
      end;
      5: {toApplication}
      begin
        if Cr.ExportOptions.FileType <> ODBCTable then
        begin
          if editAFileName.Text = '' then
          begin
            if MessageDlg('No Export FileName entered!' + Chr(10) +
              'Continue anyway?', mtWarning, [mbYes, mbNo], 0) = mrNo then
              stop := True;
          end;
        end;
      end;
    end;
  end;
  if stop = False then
  begin
    prevOut := Cr.Output;
    Cr.Export;
    Cr.Output := prevOut;
    if not cbKeepOpen.Checked then Close;
  end
  else
    ModalResult := mrNone;
end;
{------------------------------------------------------------------------------}
{ btnOkClick procedure                                                         }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.btnOkClick(Sender: TObject);
begin
  SaveFormPos(Self);
  Close;
end;
{------------------------------------------------------------------------------}
{ btnCancelClick procedure                                                     }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.btnCancelClick(Sender: TObject);
begin
  {Restore Original Settings}
  Cr.ExportOptions.AppName  := rAppName;
  Cr.ExportOptions.FileName := rFileName;
  Cr.ExportOptions.FileType := TCrExportType(rFileType);
  Cr.ExportOptions.Destination := TCrExportDestination(rDestination);
  Cr.ExportOptions.PromptForOptions := rPromptForOptions;
  Cr.ExportOptions.PromptOnOverwrite := rPromptOnOverwrite;
  {Email}
  Cr.ExportOptions.Email.CCList := rCCList;
  Cr.ExportOptions.Email.Message := rMessage;
  Cr.ExportOptions.Email.Subject := rSubject;
  Cr.ExportOptions.Email.ToList := rToList;
  Cr.ExportOptions.Email.BCCList := rBCCList;
  Cr.ExportOptions.Email.UserName := rUserName;
  Cr.ExportOptions.Email.Password := rPassword;
  {Exchange}
  Cr.ExportOptions.Exchange.Folder := rFolder;
  Cr.ExportOptions.Exchange.Password := rPassword;
  Cr.ExportOptions.Exchange.Profile := rProfile;
  {LotusNotes}
  Cr.ExportOptions.LotusNotes.DBName := rDBName;
  Cr.ExportOptions.LotusNotes.FormName := rFormName;
  Cr.ExportOptions.LotusNotes.Comments := rComments;
  {Excel}
  Cr.ExportOptions.Excel.Area := rArea;
  Cr.ExportOptions.Excel.ColumnWidth := TCrColumnWidth(rColumnWidth);
  Cr.ExportOptions.Excel.Constant := rConstant;
  Cr.ExportOptions.Excel.WorksheetFunctions := rWorksheetFunctions;
  Cr.ExportOptions.Excel.XLSType := TCrExportExcelType(rXLSType);
  Cr.ExportOptions.Excel.ChopPageHeader := rChopPageHeader;
  Cr.ExportOptions.Excel.ConvertDatesToStrings := rConvertDatesToStrings;
  Cr.ExportOptions.Excel.CreatePageBreaks := rCreatePageBreaks;
  Cr.ExportOptions.Excel.ExportHeaderFooter := rExportHeaderFooter;
  Cr.ExportOptions.Excel.FirstPage := rExcelFirstPage;
  Cr.ExportOptions.Excel.LastPage := rExcelLastPage;
  Cr.ExportOptions.Excel.UsePageRange := rExcelUsePageRange;
  {HTML}
  Cr.ExportOptions.HTML.PageNavigator := rPageNavigator;
  Cr.ExportOptions.HTML.SeparatePages := rSeparatePages;
  Cr.ExportOptions.HTML.FirstPage := rHTMLFirstPage;
  Cr.ExportOptions.HTML.LastPage := rHTMLLastPage;
  Cr.ExportOptions.HTML.UsePageRange := rHTMLUsePageRange;
  {ODBC}
  Cr.ExportOptions.ODBC.Password := rODBCPassword;
  Cr.ExportOptions.ODBC.Source := rODBCSource;
  Cr.ExportOptions.ODBC.Table := rODBCTable;
  Cr.ExportOptions.ODBC.User := rODBCUser;
  Cr.ExportOptions.ODBC.Prompt := rODBCPrompt;
  {PDF}
  Cr.ExportOptions.PDF.Prompt := rPDFPrompt;
  Cr.ExportOptions.PDF.UsePageRange := rPDFUsePageRange;
  Cr.ExportOptions.PDF.FirstPage := rPDFFirstPage;
  Cr.ExportOptions.PDF.LastPage := rPDFLastPage;
  {RTF}
  Cr.ExportOptions.RTF.Prompt := rRTFPrompt;
  Cr.ExportOptions.RTF.UsePageRange := rRTFUsePageRange;
  Cr.ExportOptions.RTF.FirstPage := rRTFFirstPage;
  Cr.ExportOptions.RTF.LastPage := rRTFLastPage;
  {Text}
  Cr.ExportOptions.Text.UseRptNumberFmt := rUseRptNumberFmt;
  Cr.ExportOptions.Text.UseRptDateFmt := rUseRptDateFmt;
  Cr.ExportOptions.Text.StringDelimiter := rStringDelimiter;
  Cr.ExportOptions.Text.FieldSeparator := rFieldSeparator;
  Cr.ExportOptions.Text.LinesPerPage := rLinesPerPage;
  Cr.ExportOptions.Text.CharPerInch := rCharPerInch;
  Cr.ExportOptions.Text.RecordsType := TCrRecordsType(rRecordsType);
  {MSWord}
  Cr.ExportOptions.Word.Prompt := rWordPrompt;
  Cr.ExportOptions.Word.UsePageRange := rWordUsePageRange;
  Cr.ExportOptions.Word.FirstPage := rWordFirstPage;
  Cr.ExportOptions.Word.LastPage := rWordLastPage;
  {XML}
  Cr.ExportOptions.XML.SeparatePages := rXMLSeparatePages;
  Cr.ExportOptions.XML.Prompt := rXMLPrompt;
  Close;
end;
{------------------------------------------------------------------------------}
{ FormClose procedure                                                          }
{------------------------------------------------------------------------------}
procedure TCrpeExportOptionsDlg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bExportOptions := False;
  Release;
end;



end.
