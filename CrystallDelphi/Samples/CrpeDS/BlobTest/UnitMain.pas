unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Buttons, StdCtrls, UCrpeDS, UCrpe32, ComCtrls, ExtCtrls,
  UCrpeClasses, ADODB;

type
  TForm1 = class(TForm)
    Crpe1: TCrpe;
    btnRunReport: TButton;
    lbTableFields: TListBox;
    lbSelectedFields: TListBox;
    btnClear: TBitBtn;
    lblFields: TLabel;
    Label1: TLabel;
    btnAdd: TButton;
    btnRemove: TButton;
    CrpeDS1: TCrpeDS;
    btnLoadReport: TButton;
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    Image1: TImage;
    Memo1: TMemo;
    ADOQuery1: TADOQuery;
    Table1: TTable;
    procedure btnRunReportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure lbSelectedFieldsDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lbSelectedFieldsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure lbSelectedFieldsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lbTableFieldsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnLoadReportClick(Sender: TObject);
    procedure CrpeDS1GetFieldValue(Sender: TObject; DataSet: TDataSet;
      FieldIndex: Smallint; var FieldValue: OleVariant);
    procedure CrpeDS1GetBlobFieldValue(Sender: TObject; DataSet: TDataSet;
      FieldIndex: Smallint; var BlobFieldValue: TMemoryStream);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1   : TForm1;
  Report  : string;
  OpenDir : string;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  i : integer;
begin
  btnRunReport.Enabled := False;
  for i := 0 to Table1.FieldDefs.Count-1 do
    lbTableFields.Items.Add(Table1.FieldDefs[i].Name);
end;

procedure TForm1.btnLoadReportClick(Sender: TObject);
var
  prev : TCursor;
begin
  {Set the dialog default filename, filter and title}
  OpenDialog1.FileName := '*.rpt';
  OpenDialog1.Filter := 'Crystal Report (*.RPT)|*.rpt';
  OpenDialog1.Title := 'Load Report...';
  OpenDialog1.InitialDir := OpenDir;
  if OpenDialog1.Execute then
  begin
    Refresh;
    prev := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    Report := OpenDialog1.FileName;
    OpenDir := ExtractFilePath(Report);
    Crpe1.ReportName := Report;
    StatusBar1.Panels[0].Text := Report;
    btnRunReport.Enabled := True;
    Screen.Cursor := prev;
  end;
end;

procedure TForm1.btnRunReportClick(Sender: TObject);
var
  i  : integer;
  s1 : string;
begin
  if lbSelectedFields.Items.Count < 1 then
  begin
    ShowMessage('You must select at least one Field!');
    Exit;
  end;
  ADOQuery1.Active := False;
  ADOQuery1.SQL.Clear;
  s1 := 'SELECT ';
  for i := 0 to lbSelectedFields.Items.Count-1 do
  begin
    if i = lbSelectedFields.Items.Count-1 then
      s1 := s1 + lbSelectedFields.Items[i]
    else
      s1 := s1 + lbSelectedFields.Items[i] + ',';
  end;
  ADOQuery1.SQL.Add(s1);
  ADOQuery1.SQL.Add('FROM ' + Table1.TableName);
  ADOQuery1.Active := True;

  {Run Report}
  Crpe1.DiscardSavedData;
  Crpe1.Tables[0].DataPointer := CrpeDS1.DataPointer;
  Crpe1.Show;
end;

procedure TForm1.btnAddClick(Sender: TObject);
var
  i : integer;
begin
  if (lbTableFields.Items.Count > 0) and (lbTableFields.ItemIndex > -1) then
  begin
    for i := 0 to lbTableFields.Items.Count-1 do
    begin
      if lbTableFields.Selected[i] then
        lbSelectedFields.Items.Add('[' + lbTableFields.Items[i] +']');
    end;
  end;
end;

procedure TForm1.btnRemoveClick(Sender: TObject);
var
  i : integer;
begin
  if (lbSelectedFields.Items.Count > 0) and (lbSelectedFields.ItemIndex > -1) then
  begin
    for i := lbSelectedFields.Items.Count-1 downto 0 do
    begin
      if lbSelectedFields.Selected[i] then
        lbSelectedFields.Items.Delete(i);
    end;
  end;
end;


procedure TForm1.btnClearClick(Sender: TObject);
begin
  lbSelectedFields.Clear;
end;

procedure TForm1.lbSelectedFieldsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
  if Source is TListBox then
    Accept := True;
end;

procedure TForm1.lbSelectedFieldsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  pos : TPoint;
  i : integer;
begin
  pos.x := X;
  pos.y := Y;
  if TListBox(Source).Name = 'lbTableFields' then
  begin
    i := TListBox(Source).ItemAtPos(pos, True);
    if i > -1 then
      TListBox(Sender).Items.Insert(TListBox(Sender).ItemIndex,
        TListBox(Source).Items[TListBox(Source).ItemIndex]);
  end
  else
  begin
    i := TListBox(Source).ItemAtPos(pos, True);
    TListBox(Source).Items.Exchange(i, TListBox(Sender).ItemIndex);
  end;
end;

procedure TForm1.lbSelectedFieldsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pos : TPoint;
  i : integer;
begin
  pos.x := X;
  pos.y := Y;
  i := lbSelectedFields.ItemAtPos(pos, True);
  lbSelectedFields.ItemIndex := i;
  if Button = mbRight then
    lbSelectedFields.BeginDrag(True);
end;

procedure TForm1.lbTableFieldsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  pos : TPoint;
  i : integer;
begin
  pos.x := X;
  pos.y := Y;
  i := lbTableFields.ItemAtPos(pos, True);
  lbTableFields.ItemIndex := i;
  if Button = mbRight then
    lbTableFields.BeginDrag(True);
end;

procedure TForm1.CrpeDS1GetFieldValue(Sender: TObject; DataSet: TDataSet;
  FieldIndex: Smallint; var FieldValue: OleVariant);
//var
//  dt : TDateTime;
begin
(*  dt := Now;
  {The second field on the Report is a DateTime field}
  if FieldIndex = 1 then
    FieldValue := dt;
*)
end;

procedure TForm1.CrpeDS1GetBlobFieldValue(Sender: TObject;
  DataSet: TDataSet; FieldIndex: Smallint; var BlobFieldValue: TMemoryStream);
//var
//  bitmap: TBitmap;
begin
(*  {Only the first field that the Report is expecting is a blob}
  if FieldIndex = 0 then
  begin
    {For Record 1 we use an image on our Form}
    if DataSet.RecNo = 1 then
    begin
      Image1.Picture.Bitmap.SaveToStream(BlobFieldValue);
    end
    {For Record 2 we load a bitmap from a file}
    else if DataSet.RecNo = 2 then
    begin
      bitmap := TBitmap.Create;
      try
        if FileExists('f:\Images\Delphi\del_head.bmp') then
        begin
          bitmap.LoadFromFile('f:\Images\Delphi\del_head.bmp');
          bitmap.SaveToStream(BlobFieldValue);
        end;
      finally
        bitmap.free;
      end;
    end
    {For Record 3 we create a bitmap in memory}
    else if DataSet.RecNo = 3 then
    begin
      bitmap := TBitmap.Create;
      try
        bitmap.Width  := 50;
        bitmap.Height := 50;
        bitmap.Canvas.Font.Color := clBlack;
        bitmap.Canvas.Brush.Color := clRed;
        bitmap.Canvas.Rectangle(0, 0, bitmap.Width, bitmap.Height);
        bitmap.TransparentMode := tmFixed;
        bitmap.SaveToStream(BlobFieldValue);
      finally
        bitmap.free;
      end;
    end;
    {For all other records we read the database}
  end;
  *)
end;


end.
