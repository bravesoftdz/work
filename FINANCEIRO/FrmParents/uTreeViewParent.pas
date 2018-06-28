unit uTreeViewParent;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PAIDETODOS, ComCtrls, LblEffct, ExtCtrls, StdCtrls, Grids, DBGrids, Db,
  DBTables;

type
  TTreeBrwParent = class(TFrmParent)
    Panel4: TPanel;
    Panel5: TPanel;
    Splitter1: TSplitter;
    Panel6: TPanel;
    Panel8: TPanel;
    TreeView: TTreeView;
    DBGrid1: TDBGrid;
    Panel10: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel11: TPanel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    LabelEffect1: TLabelEffect;
    LabelEffect2: TLabelEffect;
    quTree: TQuery;
    quTreePath: TStringField;
    quTreeNoConta: TStringField;
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TreeBrwParent: TTreeBrwParent;

implementation

{$R *.DFM}





procedure TTreeBrwParent.btCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TTreeBrwParent.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TTreeBrwParent.FormShow(Sender: TObject);
var
  Index : Integer;
begin
  // Carrega o TreeView vindo do Query
  {
     with TreeView do
       begin
         quTree.Open;
         while not quTree.Eof do
           begin
             // descobre o no pai
             if not PathList.Find(LeftStr(quTreePath.AsString, Length(quTreePath.AsString)-3), Index) then
               begin
                // e o primeiro
                MyNode := Items.Add(Items.GetFirstNode, quTreeNoConta.AsString);
               end
             else
               begin
                MyNode := Items.AddChild(Items.Item[Index], quTreeNoConta.AsString);
               end;

             // Inclue na Lista de nós
             PathList.Add(quTreePath.AsString);

             MyNode.Data := Pointer(PathList.Strings[PathList.Count-1]);

             quTree.Next;
           end;

         quTree.Close;

       end;
}       
end;


procedure TTreeBrwParent.FormCreate(Sender: TObject);
begin
  inherited;
//  PathList := TStringList.Create;
end;

procedure TTreeBrwParent.FormDestroy(Sender: TObject);
begin
  inherited;
//  PathList.Free;
end;

end.
