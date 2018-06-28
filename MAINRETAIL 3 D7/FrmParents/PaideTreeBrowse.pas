unit PaideTreeBrowse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, LblEffct, ExtCtrls, StdCtrls, PanelRights, ComCtrls, Db,
  DBTables, DBTreeView, PaideFichas, Buttons, ImgList, ADODB, siComp, siLangRT;

type
  TbrwTreeParent = class(TFrmParent)
    pnlButton: TPanelRights;
    btAdd: TSpeedButton;
    btDetail: TSpeedButton;
    btRemove: TSpeedButton;
    DBTreeView: TDBTreeView;
    quTreeView: TADOQuery;
    Small: TImageList;
    spHelp: TSpeedButton;
    dsTreeView: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBTreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure DBTreeViewDblClick(Sender: TObject);
    procedure DBTreeViewEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure btAddClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure LoadImages;
  protected
    brwTreeForm : TbrwFrmParent;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses uPassword, uDM, uMsgBox, uSystemTypes, uMsgConstant, uDMGlobal;

procedure TbrwTreeParent.LoadImages;
begin
  DM.imgBTN.GetBitmap(BTN_ADD, btAdd.Glyph);
  DM.imgBTN.GetBitmap(BTN_OPEN, btDetail.Glyph);
  DM.imgBTN.GetBitmap(BTN_DELETE, btRemove.Glyph);
end;

procedure TbrwTreeParent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TbrwTreeParent.FormCreate(Sender: TObject);
begin
  inherited;
  LoadImages;
  brwTreeForm := nil;
end;

procedure TbrwTreeParent.FormShow(Sender: TObject);
begin
  inherited;
  // Seta os direitos do browse
  pnlButton.Commands := Password.SetRights(pnlButton.Commands);
  pnlButton.UpdateButtons(True);

  // Deve carregar o TreeView antes de carregar o grid herdado
  DBTreeView.LoadTreeView;
  DBTreeView.SetFocus;
  DBTreeViewChange(nil, DBTreeView.Selected);
end;

procedure TbrwTreeParent.DBTreeViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  if DBTreeView.ActualIDItem = -1 then
    begin
      // Raiz Virtual
      btDetail.Enabled := False;
      btRemove.Enabled := False;
    end
  else
    begin
      pnlButton.UpdateButtons(True);
    end;
end;

procedure TbrwTreeParent.DBTreeViewDblClick(Sender: TObject);
var
  PosID1, PosID2 : String;
begin
  inherited;
  // trata a alteração
  if (brwTreeForm <> nil) then
    begin
      if DBTreeView.ActualIDItem <> -1 then
        begin
          PosID1 := IntTostr(DBTreeView.ActualIDItem); PosID2 := '';
          if brwTreeForm.Start(btAlt, nil, False, PosID1, PosID2, nil) then
            begin
             // Do o refresh do Grid
             DBTreeView.LoadTreeView;
             DBTreeView.SetFocus;
            end;
        end;
    end
  else
    begin
      DBTreeView.Selected.EditText;
    end;
end;

procedure TbrwTreeParent.DBTreeViewEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  inherited;
  DBTreeView.ActualName := S;
end;

procedure TbrwTreeParent.btAddClick(Sender: TObject);
var
  MyNode : TTreeNode;
  PosID1, PosID2: String;
  
begin
  inherited;
  MyNode := DBTreeView.AddSubItem(DBTreeView.Selected);

  if MyNode <> nil then
    begin
      if brwTreeForm = nil then
        MyNode.EditText
      else
        begin
          PosID1 := IntTostr(DBTreeView.ActualIDItem);
          PosID2 := '';
          if brwTreeForm.Start(btAlt, nil, False, PosID1, PosID2, nil) then
            begin
             // Do o refresh do Grid
             DBTreeView.LoadTreeView;
             DBTreeView.SetFocus;
            end
          else
            begin
              // devo deletar o item
              DBTreeView.DeleteActualItem
            end;
        end;
    end
  else
    begin
      DBTreeView.Selected.EditText;
    end;
end;

procedure TbrwTreeParent.btRemoveClick(Sender: TObject);
begin
  inherited;
  if (DBTreeView.Selected.Level > 0) and
     (MsgBox(MSG_QST_DELETE, vbYesNo + vbQuestion) = vbYes) then
     DBTreeView.DeleteActualItem;
end;

procedure TbrwTreeParent.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TbrwTreeParent.FormDestroy(Sender: TObject);
begin
  inherited;
  if brwTreeForm <> nil then brwTreeForm.Free;
end;

procedure TbrwTreeParent.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  // Short cuts
  case Key of
    VK_F2: btAdd.Click; // Add button click
    VK_F3: btDetail.Click; // Details button click
    VK_F4: btRemove.Click; // Remove button click
  end;
end;

end.
