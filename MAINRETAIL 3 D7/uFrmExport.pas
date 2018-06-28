unit uFrmExport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PaideTodosGeral, siComp, siLangRT, StdCtrls, Buttons, ExtCtrls, dximctrl,
  cxGrid;

type
  TFrmExport = class(TFrmParentAll)
    btnSave: TButton;
    Label1: TLabel;
    cbxLanguage: TdxImageComboBox;
    SD: TSaveDialog;
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCloseClick(Sender: TObject);
  private
    { Private declarations }
    MyGrid  : TcxGrid;
    sSource : String;
  public
    { Public declarations }
    function Start(Grid: TcxGrid; Source: String):Boolean;
  end;

implementation

uses uDMGlobal, uMsgBox, uMsgConstant, cxExportGrid4Link;

{$R *.DFM}

function TFrmExport.Start(Grid: TcxGrid; Source: String):Boolean;
begin

   MyGrid  := Grid;
   sSource := Source;

   ShowModal;

end;

procedure TFrmExport.btnSaveClick(Sender: TObject);
var
  sFilter, sExt : String;
begin
  inherited;

  if cbxLanguage.ItemIndex = -1 then
     begin
     MsgBox(MSG_CRT_NO_VALID_SELECTION, vbInformation + vbOKOnly);
     cbxLanguage.SetFocus;
     Exit;
     end;

  Case cbxLanguage.ItemIndex of
     0 : begin
         sFilter := 'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls';
         sExt    := 'xls';
         end;
     1 : begin
         sFilter := 'HTML File (*.htm; *.html)|*.htm';
         sExt    := 'htm';
         end;
     2 : begin
         sFilter := 'XML File (*.xml)|*.xml';
         sExt    := 'xml';
         end;
     3 : begin
         sFilter := 'Text document (*.txt)|*.txt';
         sExt    := 'txt';
         end;
  end;

  with SD do
    begin
    DefaultExt := sExt;
    Filter     := sFilter;
    FileName   := sSource+' in '+FormatDateTime('dd-mm-yy', Date)+'.'+sExt;

    if Execute then
      begin
      Case cbxLanguage.ItemIndex of
        0 : ExportGrid4ToExcel(FileName, MyGrid, True, True, False);
        1 : ExportGrid4ToHTML(FileName, MyGrid, True, True);
        2 : ExportGrid4ToXML(FileName, MyGrid, True, True);
        3 : ExportGrid4ToText(FileName, MyGrid, True, True, '','','');
        end;
      Close;
      end;
    end;

end;

procedure TFrmExport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmExport.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
