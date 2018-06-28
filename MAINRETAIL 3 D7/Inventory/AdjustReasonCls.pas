unit AdjustReasonCls;

interface
uses SysUtils;

type
    TAdjustReason = class
       private
           Fid: Integer;
           Freason: String;
           Fhidden: Integer;
           Fsystem: Integer;
           Factivated: Integer;
       protected
           procedure SetReason(argValue: String);
           function GetReason(): String;

           procedure SetHidden(argValue: Integer);
           function GetHidden(): Integer;

           procedure SetSystem(argValue: Integer);
           function GetSystem(): Integer;

           procedure SetActivated(argValue: Integer);
           function GetActivated(): Integer;

       public
           property Id: Integer read Fid write Fid;
           property Reason: String read GetReason write SetReason;
           property Hidden: Integer read GetHidden write SetHidden;
           property System: Integer read GetSystem write SetSystem;
           property Activated: Integer read GetActivated write SetActivated;

    end;


implementation

{ TAdjustReason }

function TAdjustReason.GetActivated: Integer;
begin
   result := self.Factivated;
end;

function TAdjustReason.GetHidden: Integer;
begin
  result := self.Fhidden;
end;

function TAdjustReason.GetReason(): String;
begin
   result := self.FReason;
end;

function TAdjustReason.GetSystem: Integer;
begin
  result := self.Fsystem;
end;

procedure TAdjustReason.SetActivated(argValue: Integer);
begin
   self.Factivated := argValue;

   if ( argValue = -1 ) then begin
      self.Factivated := 1;
   end;
end;

procedure TAdjustReason.SetHidden(argValue: Integer);
begin
   self.Fhidden := argValue;

   if ( argValue = -1 ) then begin
      self.Fhidden := 1;
   end;

end;

procedure TAdjustReason.SetReason(argValue: String);
begin
   if ( length(argValue) = 0 ) then begin
      raise Exception.Create('Reason cannot be empty');
   end else begin
               self.Freason := argValue;
            end;
end;

procedure TAdjustReason.SetSystem(argValue: Integer);
begin
   self.Fsystem := argValue;

   if ( argValue = -1 ) then begin
      self.Fsystem := 1;
   end;
end;

end.
