unit TagAvailableView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dbClient;

type
  TtagsAvailableView = class(TForm)
    listAvailableTags: TListBox;
    buttonSelect: TButton;
    buttonClose: TButton;
    procedure buttonSelectClick(Sender: TObject);
  private
    { Private declarations }
    pvtIdModel: Integer;
    tags: TClientDataset;
    procedure loadAvailableTags();
  public
    { Public declarations }
    function start(arg_idmodel: Integer): Boolean;
  end;

var
  tagsAvailableView: TtagsAvailableView;

implementation
uses uDm;

{$R *.dfm}

{ TtagsAvailableView }

procedure TtagsAvailableView.loadAvailableTags;
begin
   listAvailableTags.Clear();
   tags := dm.getTagsAvailableByModel(pvtIdModel);
   while ( not tags.Eof ) do begin
      listAvailableTags.items.Add(tags.fieldByName('TagName').value);
      tags.next();
   end;
end;

function TtagsAvailableView.start(arg_idmodel: Integer): Boolean;
begin
  pvtIdModel := arg_idmodel;
  loadAvailableTags();
  buttonSelect.Enabled := ( listAvailableTags.items.count > 0 );
  result := ( showModal = mrOK );
end;

procedure TtagsAvailableView.buttonSelectClick(Sender: TObject);
var
  tag: TClientDataset;
  i: Integer;
begin
  for i:= listAvailableTags.Items.count - 1 downto 0 do begin
     if ( listAvailableTags.selected[i] ) then begin
        tag := dm.getTagByTagName(listAvailableTags.items[i]);

        // assign tag to tag to Tagmodel
        dm.callSpTagModelUpSert(tag.fieldByName('IdTag').value, pvtIdModel);
        freeAndNil(tag);
        listAvailableTags.Items.Delete(i);
     end;
  end;
end;

end.
