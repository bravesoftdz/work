unit uParentListRefreshThread;

interface

uses
  Classes, uParentList;

type
  TParentListRefreshThread = class(TThread)
  private
    { Private declarations }
    MyParentList: TParentList;

  protected
    procedure Execute; override;
    procedure MakeRefresh;

  public
    procedure Start(ParentList: TParentList);

  end;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ParentListRefresh.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ ParentListRefresh }

procedure TParentListRefreshThread.Start(ParentList: TParentList);
begin
  MyParentList := ParentList;
  Execute;
end;

procedure TParentListRefreshThread.Execute;
begin
  Synchronize(MakeRefresh);
end;

procedure TParentListRefreshThread.MakeRefresh;
begin
  MyParentList.SubListRefresh;
end;

end.
