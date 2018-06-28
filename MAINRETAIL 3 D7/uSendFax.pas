unit uSendFax;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OoMisc, AdFax, AdFStat, AdPort, ExtCtrls, DB,
  uSendFaxList, AdTapi, AdExcept, ADODb, Buttons, LblEffct, ComCtrls,
  siComp, siLangRT, PaiDeForms;

type
  PAddEntry = ^TAddEntry;
  TAddEntry = record
    FaxName     : String;
    CoverName   : String;
    PhoneNumber : String;
    NextEntry   : PAddEntry;
  end;

  TFrmSendFax = class(TFrmParentForms)
    ApdComPort1: TApdComPort;
    ApdFaxStatus1: TApdFaxStatus;
    ApdSendFax1: TApdSendFax;
    pnlDialConfig: TPanel;
    Label5: TLabel;
    edtDialAttempts: TEdit;
    Label6: TLabel;
    edtRetryWait: TEdit;
    ApdFaxLog1: TApdFaxLog;
    ApdTapiDevice1: TApdTapiDevice;
    FontDialog1: TFontDialog;
    Panel2: TPanel;
    EspacamentoInferior: TPanel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    pnlTitle3: TPanel;
    pnlFaxList: TPanel;
    Panel5: TPanel;
    sfFaxListBox: TListBox;
    btRemove: TSpeedButton;
    btDetail: TSpeedButton;
    btAdd: TSpeedButton;
    Panel3: TPanel;
    spHelp: TSpeedButton;
    sbSelectPort: TSpeedButton;
    sbSendFaxes: TSpeedButton;
    btClose: TButton;
    procedure sfAppendAddList(FName, CName, PNumber : String);
    procedure sfGetAddListEntry(var FName, CName, PNumber : String);
    procedure sfAddPrim;
    procedure sfAddFromCmdLine;
    procedure ApdSendFax1FaxNext(CP: TObject; var ANumber, AFileName,
      ACoverName: TPassString);
    procedure ApdSendFax1FaxFinish(CP: TObject; ErrorCode: Integer);
    procedure ApdSendFax1FaxLog(CP: TObject; LogCode: TFaxLogCode);
    procedure edtDialAttemptsChange(Sender: TObject);
    procedure edtRetryWaitChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApdTapiDevice1TapiPortOpen(Sender: TObject);
    procedure ApdTapiDevice1TapiPortClose(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
    procedure sbSendFaxesClick(Sender: TObject);
    procedure sbSelectPortClick(Sender: TObject);
    procedure spHelpClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btDetailClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
  private
    { Private declarations }
    FaxList     : TStringList;
    FaxIndex    : Word;
    InProgress  : Boolean;

    AddsInProgress    : Boolean;
    AddsPending       : Word;
    AddList           : PAddEntry;
    ProcessedCmdLine  : Boolean;
    QueryVendor       : TADOQuery;
    function LimitS(const S : String; Len : Word) : String;

  public
    { Public declarations }
    constructor Create(AComponent : TComponent); override;
    destructor Destroy; override;
    procedure sfAddFromPrinterDriver(var Message: TMessage);
      message APW_PRINTDRIVERJOBCREATED;
    procedure Start(SqlVendor:TDataSet; sFaxFilePath:string);

  end;

implementation

uses uMsgBox, Mask, uDMGlobal, uMsgConstant;

{$R *.DFM}

procedure TFrmSendFax.Start(SqlVendor:TDataSet; sFaxFilePath:string);

  function FormatPhone(FaxNum:String):String;
  var
     i : Integer;
  begin
     For i := 1 to Length(FaxNum) do
       if FaxNum[i] in ['(',')','-'] then
          Delete(FaxNum, i, 1);
     Result := FaxNum;
  end;

var
S, sFax, sPessoa : string;
begin
//
 TDataSet(QueryVendor) := SqlVendor;

With QueryVendor do
  begin
  try
    If not Active then
       Open;

    sPessoa := FieldByName('Vendor').AsString;

    DisableControls;

    First;
    While not EOF do
      begin
      sFax    := FormatPhone(FieldByName('Fax').AsString);

      //Add in the list
      S := sFax + '^' + sFaxFilePath;
      FaxList.Add(S);

      //add this fax entry to the list box
      S := Format('%-20S %-20S %-20S',
                  [LimitS(sFax, 20),
                   LimitS(sFaxFilePath, 30),
                   LimitS('', 20)]);

      sfFaxListBox.Items.Add(S);
      Next;
      end;
  Finally
     EnableControls;
     end;
  end;
end;


function TFrmSendFax.LimitS(const S : String; Len : Word) : String;
  {-Truncate S at Len}
begin
  if Length(S) > Len then
    Result := Copy(S, 1, Len) + '...'
  else
    Result := S;
end;

constructor TFrmSendFax.Create(AComponent : TComponent);
  {-Create the form}
begin
  inherited Create(AComponent);
  FaxList     := TStringList.Create;
  InProgress  := False;
  AddList     := nil;
  AddsPending := 0;
  AddsInProgress := False;
  ProcessedCmdLine := False;
end;

destructor TFrmSendFax.Destroy;
begin
  FaxList.Free;
  inherited Destroy;
end;

procedure TFrmSendFax.FormShow(Sender: TObject);
  {-Handle any command line arguments}
begin
  inherited;
  if not ProcessedCmdLine then begin
    sfAddFromCmdLine;
    ProcessedCmdLine := True;
  end;
end;

procedure TFrmSendFax.sfAppendAddList(FName, CName, PNumber : String);
  {-Append a job to the list waiting to be displayed in the Add dialog}
var
  NewEntry : PAddEntry;
begin
  if AddList = nil then begin
    {empty list}
    GetMem(AddList, sizeof(TAddEntry));
    NewEntry := AddList;
  end else begin
    {find end of list}
    NewEntry := AddList;
    while NewEntry^.NextEntry <> nil do
      NewEntry := NewEntry^.NextEntry;
    GetMem(NewEntry^.NextEntry, sizeof(TAddEntry));
    NewEntry := NewEntry^.NextEntry;
  end;
  FillChar(NewEntry^, SizeOf(TAddEntry), 0);

  with NewEntry^ do begin
    FaxName := FName;
    CoverName := CName;
    PhoneNumber := PNumber;
    NextEntry := nil;
  end;

  inc(AddsPending);
end;

procedure TFrmSendFax.sfGetAddListEntry(var FName, CName, PNumber : String);
  {-Return the values from the first entry in list}
var
  TempEntry : PAddEntry;
begin
  if AddList = nil then
    exit;

  TempEntry := AddList;
  AddList := AddList^.NextEntry;
  with TempEntry^ do begin
    FName := FaxName;
    CName := CoverName;
    PNumber := PhoneNumber;
  end;
  FreeMem(TempEntry, SizeOf(TAddEntry));
  dec(AddsPending);
end;

procedure TFrmSendFax.sfAddPrim;
  {-Display the Add dialog for all Add requests queued}
var
  S : String;
  FName, CName, PNumber : String;
begin
  {prevent multiple occurances of dialog from being displayed}
  AddsInProgress := True;

  {set the button text}
  FrmSendFaxList.flAction.Caption := '&Add';

  while AddsPending > 0 do begin
    {set the data}
    with FrmSendFaxList do begin
      sfGetAddListEntry(FName, CName, PNumber);
      FaxName := FName;
      CoverName := CName;
      PhoneNumber := PNumber;
    end;

    {show the dialog}
    if (FrmSendFaxList.ShowModal = mrOK) and
       (FrmSendFaxList.PhoneNumber <> '') and
       (FrmSendFaxList.FaxName <> '') then begin
      {add this fax entry to the list}
      S := FrmSendFaxList.PhoneNumber + '^' + FrmSendFaxList.FaxName;
      if FrmSendFaxList.CoverName <> '' then
        S := S + '^' + FrmSendFaxList.CoverName;
      FaxList.Add(S);

      {add this fax entry to the list box}
      S := Format('%-20S %-20S %-20S',
                  [LimitS(FrmSendFaxList.PhoneNumber, 20),
                   LimitS(FrmSendFaxList.FaxName, 30),
                   LimitS(FrmSendFaxList.CoverName, 20)]);
      sfFaxListBox.Items.Add(S);
    end;
  end;

  AddsInProgress := False;
end;

procedure TFrmSendFax.sfAddFromPrinterDriver(var Message: TMessage);
  {-Handle an Add request message send by APFSENDF.DRV printer driver}
var
  JobID  : Word;
  KeyBuf : array[0..8] of Char;
  zFName : array[0..255] of Char;
begin
  {The message received from the printer driver has a job identifier
   in the wParam field.  This job identifier points to an entry in the
   SendFax.Ini file which the printer driver has added.  As SendFax
   handles each message, it should delete that job entry from the Ini
   file and queue the job for display in the Add dialog.}
  with Message do begin
    JobID := wParam;
    StrCopy(KeyBuf, 'Job');
    KeyBuf[3] := Chr(Lo(JobID));
    KeyBuf[4] := #0;
    GetPrivateProfileString('FaxJobs', KeyBuf, '', zFName, sizeof(zFName),
                            'SENDFAX.INI');
    {now delete the entry so the ID can be re-used by the printer driver}
    WritePrivateProfileString('FaxJobs', KeyBuf, nil, 'SENDFAX.INI');
  end;

  sfAppendAddList(StrPas(zFName), '', '');

  if not AddsInProgress then
    sfAddPrim;
end;

procedure TFrmSendFax.sfAddFromCmdLine;
  {-Handle an Add request specified on the command line}
begin
  if ParamStr(1) = '/F' then begin
    sfAppendAddList(ParamStr(2), '', '');

    if not AddsInProgress then
      sfAddPrim;
  end;
end;

procedure TFrmSendFax.ApdSendFax1FaxNext(CP: TObject;
                                     var ANumber, AFileName,
                                     ACoverName: TPassString);
  {-Return the next fax to send}
var
  S : String;
  CaretPos : Byte;
begin
  if FaxList.Count = 0 then Exit;
  try
    S := FaxList[FaxIndex];
    CaretPos := Pos('^', S);
    ANumber := Copy(S, 1, CaretPos-1);
    S := Copy(S, CaretPos+1, 255);
    CaretPos := Pos('^', S);
    if CaretPos = 0 then begin
      AFileName := S;
      ACoverName := '';
    end else begin
      AFileName := Copy(S, 1, CaretPos-1);
      ACoverName := Copy(S, CaretPos+1, 255);
    end;
    Inc(FaxIndex);
  except
    ANumber := '';
    AFileName := '';
    ACoverName := '';
  end;
end;

procedure TFrmSendFax.ApdSendFax1FaxFinish(CP: TObject; ErrorCode: Integer);
  {-Display a finished message}
begin
  ShowMessage('Finished: ' + ErrorMsg(ErrorCode));
  if ApdComPort1.TapiMode = tmOn then
    if ApdTapiDevice1.CancelCall then
      {Call cancelled immediately, clear InProgress flag}
      InProgress := False
    else
      {CancelCall proceeding in background, waiting for OnTapiPortClose}
  else begin
    {Not using TAPI, just close the port and clear the InProgress flag}
    ApdComPort1.Open := False;
    InProgress := False;
  end;
end;

procedure TFrmSendFax.ApdSendFax1FaxLog(CP: TObject; LogCode: TFaxLogCode);
  {-Remote this fax entry from the lists, if finished okay}
begin
  if LogCode = lfaxTransmitOK then begin
    Dec(FaxIndex);
    sfFaxListBox.Items.Delete(FaxIndex);
    FaxList.Delete(FaxIndex);
  end;
end;

procedure TFrmSendFax.edtDialAttemptsChange(Sender: TObject);
  {-Set the new desired dial attempts}
begin
  try
    ApdSendFax1.DialAttempts := StrToInt(edtDialAttempts.Text);
  except
  end;
end;

procedure TFrmSendFax.edtRetryWaitChange(Sender: TObject);
  {-Set the new desired retry wait}
begin
  try
    ApdSendFax1.DialRetryWait := StrToInt(edtRetryWait.Text);
  except
  end;
end;

procedure TFrmSendFax.ApdTapiDevice1TapiPortOpen(Sender: TObject);
begin
  {TAPI port is configured and open, star the fax session}
  ApdSendFax1.StartTransmit;
end;

procedure TFrmSendFax.ApdTapiDevice1TapiPortClose(Sender: TObject);
begin
  InProgress := False;
end;

procedure TFrmSendFax.FormCreate(Sender: TObject);
begin
  inherited;

  Application.CreateForm(TFrmSendFaxList, FrmSendFaxList);

end;

procedure TFrmSendFax.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FrmSendFaxList.Free; 
end;

procedure TFrmSendFax.btCloseClick(Sender: TObject);
  {-Exit the application}
var
  TempEntry : PAddEntry;
begin
  while AddList <> nil do begin
    TempEntry := AddList;
    AddList := AddList^.NextEntry;
    FreeMem(TempEntry, SizeOf(TAddEntry));
  end;
  Close;
end;

procedure TFrmSendFax.sbSendFaxesClick(Sender: TObject);
  {-Send the faxes}
begin
  if not InProgress then begin
    InProgress := True;

    {Get user's values}
    FaxIndex := 0;
    ApdSendFax1.FaxClass := TFaxClass(1);
    try
      ApdSendFax1.DialAttempts := StrToInt(edtDialAttempts.Text);
      ApdSendFax1.DialRetryWait := StrToInt(edtRetryWait.Text);
    except
    end;

    if (ApdComPort1.TapiMode = tmOn) or
       ((ApdComPort1.TapiMode = tmAuto) and
        (ApdTapiDevice1.SelectedDevice <> '')) then begin
      {Tell TAPI to configure and open the port}
      ApdTapiDevice1.ConfigAndOpen;
    end else begin
      {Open the port and start sending}
      try
        ApdComPort1.Open := True;
      except
        InProgress := False;
        raise;
      end;
      ApdSendFax1.StartTransmit;
    end;
  end else
    MessageBeep(0);
end;

procedure TFrmSendFax.sbSelectPortClick(Sender: TObject);
begin
  ApdTapiDevice1.SelectDevice;
end;

procedure TFrmSendFax.spHelpClick(Sender: TObject);
begin
  Application.HelpContext(5002);
end;

procedure TFrmSendFax.btRemoveClick(Sender: TObject);
var
  Index : Word;
begin
  if InProgress then begin
    MessageBeep(0);
    Exit;
  end;

  if sfFaxListBox.ItemIndex <> -1 then begin
    Index := sfFaxListBox.ItemIndex;
    sfFaxListBox.Items.Delete(Index);
    FaxList.Delete(Index);
  end;
end;

procedure TFrmSendFax.btDetailClick(Sender: TObject);
var
  SaveIndex : Integer;
  CPos : Word;
  S : String;
begin
  if InProgress then begin
    MessageBeep(0);
    Exit;
  end;

  {Exit if nothing selected}
  if sfFaxListBox.ItemIndex = -1 then
    Exit;

  {Set the button text}
  FrmSendFaxList.flAction.Caption := '&Modify';

  {Note the listbox index, use it get data from FileList}
  SaveIndex := sfFaxListBox.ItemIndex;
  S := FaxList[SaveIndex];
  CPos := Pos('^', S);
  FrmSendFaxList.PhoneNumber := Copy(S, 1, CPos-1);
  S := Copy(S, CPos+1, 255);
  CPos := Pos('^', S);
  if CPos = 0 then
    FrmSendFaxList.FaxName := S
  else begin
    FrmSendFaxList.FaxName := Copy(S, 1, CPos-1);
    FrmSendFaxList.CoverName := Copy(S, CPos+1, 255);
  end;

  {Show the dialog}
  if FrmSendFaxList.ShowModal = mrOK then begin
    {Modify the FaxList entry}
    S := FrmSendFaxList.PhoneNumber + '^' + FrmSendFaxList.FaxName;
    if FrmSendFaxList.CoverName <> '' then
      S := S + '^' + FrmSendFaxList.CoverName;
    FaxList.Strings[SaveIndex] := S;

    {Add this fax entry to the list box}
    S := Format('%-20S %-20S %-20S',
                [LimitS(FrmSendFaxList.PhoneNumber, 20),
                 LimitS(FrmSendFaxList.FaxName, 30),
                 LimitS(FrmSendFaxList.CoverName, 20)]);
    sfFaxListBox.Items[SaveIndex] := S;
  end;
end;

procedure TFrmSendFax.btAddClick(Sender: TObject);
begin
  sfAppendAddList('', '', '');
  sfAddPrim;
end;

end.
