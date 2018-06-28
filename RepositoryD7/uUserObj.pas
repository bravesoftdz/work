unit uUserObj;

interface

uses uParentClass;

type
  TUser = Class(TParentClass)
      private
        fID           : Integer;
        fIDUserType   : Integer;
        fUserName     : String;
        fPassword     : String;
      public
        property ID              : Integer read fID           write fID;
        property IDUserType      : Integer read fIDUserType   write fIDUserType;
        property UserName        : String  read fUserName     write fUserName;
        property Password        : String  read fPassword     write fPassword;
  end;

implementation

end.
