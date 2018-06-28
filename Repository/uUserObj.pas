unit uUserObj;

interface

type
  TUser = Class
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
