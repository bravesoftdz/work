unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, cxLookAndFeelPainters, cxButtons, cxMemo,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TForm1 = class(TForm)
    ADOConn: TADOConnection;
    qryColumns: TADOQuery;
    qryColumnsColumnName: TWideStringField;
    qryColumnsColumnType: TWideStringField;
    qryValues: TADOQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qryLuTable: TADOQuery;
    qryLuTableName: TWideStringField;
    qryLuTableid: TIntegerField;
    edtTable: TcxLookupComboBox;
    edtFilter: TcxTextEdit;
    mmInsert: TcxMemo;
    btnScript: TcxButton;
    dsLuTable: TDataSource;
    procedure btnScriptClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function GetInsertSQL(AColumns: String): String;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnScriptClick(Sender: TObject);
var
  sColumns: String;
begin
  with qryColumns do
  try
    if Active then
      Close;

    Parameters.ParamByName('TableName').Value := edtTable.Text;
    Open;

    while not Eof do
    begin
      if sColumns <> '' then
        sColumns := sColumns + ', ';
      sColumns := sColumns + FieldByName('ColumnName').AsString;
      Next;
    end;

    mmInsert.Text := 'ALTER TABLE ' + edtTable.Text + ' DISABLE TRIGGER ALL' + #13#13;
    mmInsert.Text := mmInsert.Text + GetInsertSQL(sColumns);
    mmInsert.Text := mmInsert.Text + 'ALTER TABLE ' + edtTable.Text + ' ENABLE TRIGGER ALL';
  finally
    Close;
  end;
end;

function TForm1.GetInsertSQL(AColumns: String): String;
var
  i: Integer;
  sValues, sColumns, sColumn: String;
  aSelectColumns: array of String;
begin
  sColumns := AColumns;
  AColumns := StringReplace(sColumns, ' ', '', [rfReplaceAll]);

  while AColumns <> '' do
  begin
    if Pos(',', AColumns) > 0 then
    begin
      sColumn := Copy(AColumns, 1, Pos(',', AColumns) - 1);
      AColumns := Copy(AColumns, Pos(',', AColumns) + 1, Length(AColumns));
    end
    else
    begin
      sColumn := AColumns;
      AColumns := '';
    end;

    SetLength(aSelectColumns, Length(aSelectColumns) + 1);
    aSelectColumns[Length(aSelectColumns) - 1] := sColumn;
  end;

  with qryValues do
  try
    if qryValues.Active then
      qryValues.Close;

    qryValues.SQL.Text := 'SELECT ' + sColumns + ' FROM ' + edtTable.Text + ' WHERE ' + edtFilter.Text;;
    qryValues.Open;
    while not qryValues.Eof do
    begin
      for i := 0 to Pred(Length(aSelectColumns)) do
      begin
        if sValues <> '' then
          sValues := sValues + ', ';

        if qryValues.FieldByName(aSelectColumns[i]).Value = NULL then
          sValues := sValues + 'NULL'
        else if qryValues.FieldByName(aSelectColumns[i]).DataType = ftBoolean then
          sValues := sValues + BoolToStr(qryValues.FieldByName(aSelectColumns[i]).AsBoolean)
        else if (qryValues.FieldByName(aSelectColumns[i]).DataType = ftDateTime) or (qryValues.FieldByName(aSelectColumns[i]).DataType = ftTimeStamp) then
          sValues := sValues + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', qryValues.FieldByName(aSelectColumns[i]).AsDateTime))
        else if (qryValues.FieldByName(aSelectColumns[i]).DataType = ftString) or (qryValues.FieldByName(aSelectColumns[i]).DataType = ftMemo) then
          sValues := sValues + QuotedStr(qryValues.FieldByName(aSelectColumns[i]).Value)
        else if (qryValues.FieldByName(aSelectColumns[i]).DataType = ftBCD) or (qryValues.FieldByName(aSelectColumns[i]).DataType = ftCurrency) or (qryValues.FieldByName(aSelectColumns[i]).DataType = ftFloat) then
          sValues := sValues + StringReplace(FormatFloat('0.00', qryValues.FieldByName(aSelectColumns[i]).Value), ',', '.', [rfReplaceAll])
        else
          sValues := sValues + VarToStr(qryValues.FieldByName(aSelectColumns[i]).Value);
      end;

      Result :=  Result + 'INSERT INTO ' + edtTable.Text + ' (' + sColumns + ') VALUES (' + sValues + ')' + #13#13;
      sValues := '';
      qryValues.Next;
    end;
  finally
    qryValues.Close;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ADOConn.Open;
  qryLuTable.Open;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryLuTable.Close;
  ADOConn.Close;
end;

end.
