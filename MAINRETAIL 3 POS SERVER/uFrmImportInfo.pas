unit uFrmImportInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, siComp;

type
  TFrmImportInfo = class(TForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    btnClose: TBitBtn;
    sgridInfo: TStringGrid;
    siLang: TsiLang;
    Splitter1: TSplitter;
    pnlHistory: TPanel;
    lbCashRegister: TLabel;
    lboxCashOpen: TListBox;
    Panel2: TPanel;
    shpOK: TShape;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Shape2: TShape;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure sgridInfoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgridInfoSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    sItems,
    sDate,
    sFile,
    sCashOpen : String;
    function GetStatus(fDate : TDateTime):String;
    procedure LoadSystemInfo;
    procedure LoadOpenLog(fCashRegister, fFileName : String);
  public
    procedure Start;
  end;

implementation

uses uMainConf, uDMGlobal, uPOSServerConsts;

{$R *.dfm}

procedure TFrmImportInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmImportInfo.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmImportInfo.Start;
begin

    case DMGlobal.IDLanguage of
      LANG_ENGLISH :
             begin
             sItems := 'Items';
             sDate  := 'Last import date';
             sFile  := 'Last import file';
             sCashOpen := 'Open CashRegister (%S)';
             end;
      LANG_PORTUGUESE :
             begin
             sItems := 'Arquivos';
             sDate  := 'Última importação';
             sFile  := 'Último arquivo';
             sCashOpen := 'Arquivo(s) de caixa aberto (%S)';
             end;
      LANG_SPANISH :
             begin
             sItems := 'Items';
             sDate  := 'Last import date';
             sFile  := 'Last import file';
             sCashOpen := 'Open CashRegister (%S)';
             end;
    end;

   LoadSystemInfo;
   pnlHistory.Visible := (FrmMain.fServerConnection.ConnectType = CON_TYPE_SERVER);
   ShowModal;
end;

procedure TFrmImportInfo.LoadSystemInfo;
var
  sPDVList   : TStringList;
  sPDV       : TStringList;
  i,
  iIDCashReg : integer;
begin

  sPDVList := TStringList.Create;
  try
    sPDV := TStringList.Create;
    try
      FrmMain.fIniConfig.ReadSection(POS_PDV_KEY, sPDVList);

      sgridInfo.CellRect(0,1);

      sgridInfo.RowCount := sPDVList.Count + 2;
      sgridInfo.Cells[0,0] := '';
      sgridInfo.Cells[1,0] := sItems;
      sgridInfo.Cells[2,0] := sDate;
      sgridInfo.Cells[3,0] := sFile;

      sgridInfo.Cells[0,1] := GetStatus(FrmMain.fIniConfig.ReadDateTime('ServerSchedule','SuccedDate', Now-7));
      sgridInfo.Cells[1,1] := 'Global Files';
      sgridInfo.Cells[2,1] := FrmMain.fIniConfig.ReadString('ServerSchedule','SuccedDate', '');
      sgridInfo.Cells[3,1] := ' --- no file ---';

      for i:=0 to sPDVList.Count-1 do
      begin
      iIDCashReg := LongInt(FrmMain.fIniConfig.ReadInteger(POS_PDV_KEY, sPDVList[i], 0));
      sgridInfo.Cells[0,i+2] := GetStatus(FrmMain.fIniConfig.ReadDateTime(IntToStr(iIDCashReg), POS_LAST_IMPORT_DATE, Now-7));
      sgridInfo.Cells[1,i+2] := sPDVList[i];
      sgridInfo.Cells[2,i+2] := FrmMain.fIniConfig.ReadString(IntToStr(iIDCashReg), POS_LAST_IMPORT_DATE, '');
      sgridInfo.Cells[3,i+2] := FrmMain.fIniConfig.ReadString(IntToStr(iIDCashReg), POS_PDV_KEY_LAST_FILE, '');
      end;
    finally
      FreeAndNil(sPDV);
    end;
  finally
    FreeAndNil(sPDVList);
  end;

end;

procedure TFrmImportInfo.sgridInfoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Text : String;
begin
  if ACol = 0 then
  begin
    Text := sgridInfo.Cells[ACol, ARow];
    if Text = '1' then
    begin
      sgridInfo.Canvas.Brush.Color := clGreen;
      sgridInfo.Canvas.FillRect(Rect);
    end else if Text = '2' then
    begin
      sgridInfo.Canvas.Brush.Color := $004080FF;
      sgridInfo.Canvas.FillRect(Rect);
    end else if Text = '3' then
    begin
      sgridInfo.Canvas.Brush.Color := clRed;
      sgridInfo.Canvas.FillRect(Rect);
    end;
  end;
end;

function TFrmImportInfo.GetStatus(fDate: TDateTime): String;
begin
  if (Trunc(Now) - Trunc(fDate)) <= 3 then
    Result := '1'
  else if (Trunc(Now) - Trunc(fDate)) <= 5 then
    Result := '2'
  else
    Result := '3';
end;

procedure TFrmImportInfo.LoadOpenLog(fCashRegister, fFileName : String);
var
  sFile : String;
  i : Integer;
begin

  lboxCashOpen.Items.Clear;
  lbCashRegister.Caption := '';

  if fFileName <> '' then
  begin
    sFile := Copy(fFileName, 0, 4);
    lbCashRegister.Caption := Format(sCashOpen, [fCashRegister]);
    if FrmMain.fPOSConfig.SectionExists(sFile) then
    begin

      FrmMain.fPOSConfig.ReadSection(sFile, lboxCashOpen.Items);
      for i := 0 to (lboxCashOpen.Count-1) do
        lboxCashOpen.Items.Strings[i] := sFile+'-'+lboxCashOpen.Items.Strings[i]+'.ven';
    end;
  end;
  
end;

procedure TFrmImportInfo.sgridInfoSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ARow <> 1 then
    LoadOpenLog(sgridInfo.Cells[1, ARow], sgridInfo.Cells[3, ARow]);
end;

end.
