unit uFrmBuildGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst;

type
  TFrmBuildGrid = class(TForm)
    pnlBotton: TPanel;
    imgBotton: TImage;
    btnClose: TBitBtn;
    btnApply: TBitBtn;
    clbSize: TCheckListBox;
    clbColor: TCheckListBox;
    btnAddSize: TSpeedButton;
    btnAddColor: TSpeedButton;
    edtColor: TEdit;
    edtSize: TEdit;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnAddSizeClick(Sender: TObject);
    procedure btnAddColorClick(Sender: TObject);
  private
    FModel, FFilter : String;
    procedure RefreshSize;
    procedure RefreshColor;
    procedure ReCreateGrid;
    function Validate : Boolean;
  public
    function Start(Model : String) : Boolean;
  end;

implementation

uses uDMExport, DB, uMsgBox;

{$R *.dfm}

{ TFrmBuildGrid }

function TFrmBuildGrid.Start(Model : String): Boolean;
begin
  FModel := Model;
  RefreshColor;
  RefreshSize;

  FFilter := DMExport.cdsGrid.Filter;
  DMExport.cdsGrid.Filtered := False;
  DMExport.cdsGrid.Filter   := 'Model = ' + QuotedStr(FModel);
  DMExport.cdsGrid.Filtered := True;

  ShowModal;

  DMExport.cdsGrid.Filtered := False;
  DMExport.cdsGrid.Filter   := FFilter;
  DMExport.cdsGrid.Filtered := True;

  Result := (ModalResult = mrOk);
end;

procedure TFrmBuildGrid.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmBuildGrid.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmBuildGrid.btnApplyClick(Sender: TObject);
begin

 ModalResult := mrNone;

 if Validate then
   if MsgBox('Recriar Grade?_Os valores atuais serão perdidos.', vbYesNo + vbQuestion) = vbYes then
   begin
     ReCreateGrid;
     ModalResult := mrOk;
   end;
   
end;

procedure TFrmBuildGrid.RefreshColor;
begin
  with DMExport.cdsColor do
  begin
    First;
    clbColor.Clear;
    while not EOF do
    begin
      if DMExport.cdsGrid.Locate('MColor', DMExport.cdsColor.FieldByName('MColor').AsString, []) then
      begin
        clbColor.AddItem(DMExport.cdsColor.FieldByName('MColor').AsString, nil);
        clbColor.Checked[clbColor.Items.IndexOf(DMExport.cdsColor.FieldByName('MColor').AsString)] := True;
      end
      else
        clbColor.AddItem(DMExport.cdsColor.FieldByName('MColor').AsString, nil);
      Next;
    end;
    First;
  end;
end;

procedure TFrmBuildGrid.RefreshSize;
begin
  with DMExport.cdsSize do
  begin
    First;
    clbSize.Clear;
    while not EOF do
    begin
      if DMExport.cdsGrid.Locate('MSize', DMExport.cdsSize.FieldByName('MSize').AsString, []) then
      begin
        clbSize.AddItem(DMExport.cdsSize.FieldByName('MSize').AsString, nil);
        clbSize.Checked[clbSize.Items.IndexOf(DMExport.cdsSize.FieldByName('MSize').AsString)] := True;
      end
      else
        clbSize.AddItem(DMExport.cdsSize.FieldByName('MSize').AsString, nil);
      Next;
    end;
    First;
  end;
end;

procedure TFrmBuildGrid.btnAddSizeClick(Sender: TObject);
begin

  if Trim(edtSize.Text) <> '' then
  begin
    if not DMExport.cdsSize.Locate('MSize', edtSize.Text,  []) then
    begin
      DMExport.cdsSize.Append;
      DMExport.cdsSize.FieldByName('MSize').Value := edtSize.Text;
      DMExport.cdsSize.Post;
      RefreshSize;
    end;

    edtSize.Clear;
    edtSize.SetFocus;
  end;

end;

procedure TFrmBuildGrid.btnAddColorClick(Sender: TObject);
begin

  if Trim(edtColor.Text) <> '' then
  begin
    if not DMExport.cdsColor.Locate('MColor', edtColor.Text,  []) then
    begin
      DMExport.cdsColor.Append;
      DMExport.cdsColor.FieldByName('MColor').Value := edtColor.Text;
      DMExport.cdsColor.Post;
      RefreshColor;
    end;

    edtColor.Clear;
    edtColor.SetFocus;
  end;

end;

procedure TFrmBuildGrid.ReCreateGrid;
var
  i, j : Integer;
  Qty : Double;
  Sale : Currency;
begin


  DMExport.RemoveGridModel(FModel);

  Qty  := 1;
  Sale := 1;

  with DMExport.cdsModel do
    if Locate('Model', FModel, []) then
    begin
      Qty  := FieldByName('Qty').AsFloat;
      Sale := FieldByName('SalePrice').AsCurrency;
    end;

  for i := 0 to clbSize.Count-1 do
    if clbSize.Checked[i] then
      for j := 0 to clbColor.Count-1 do
        if clbColor.Checked[j] then
        begin
          with DMExport.cdsGrid do
          begin
            Append;
            FieldByName('Model').Value     := FModel;
            FieldByName('MSize').Value     := clbSize.Items.Strings[i];
            FieldByName('MColor').Value    := clbColor.Items.Strings[j];
            FieldByName('Qty').Value       := Qty;
            FieldByName('SalePrice').Value := Sale;
            Post;
          end;
        end;
end;

function TFrmBuildGrid.Validate: Boolean;
var
  i : Integer;
begin

  Result := False;

  for i := 0 to clbSize.Count-1 do
    if clbSize.Checked[i] then
    begin
      Result := True;
      Break;
    end;

  if not Result then
  begin
    MsgBox('Selecione um item de Horizontal', vbOkOnly + vbInformation);
    Exit;
  end;

  Result := False;

  for i := 0 to clbColor.Count-1 do
    if clbColor.Checked[i] then
    begin
      Result := True;
      Break;
    end;

  if not Result then
  begin
    MsgBox('Selecione um item de Vertical', vbOkOnly + vbInformation);
    Exit;
  end;

end;

end.
