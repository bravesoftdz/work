unit CardTranMsgStatus;

interface

type

   TCardTranMsgStatus = class
   private
      FcmdStatus: String;
	  FtextResponse: String;
   public 
      procedure SetCmdStatus(arg_status: String);
	  function GetCmdStatus(): String;
	  
	  procedure SetTextResponse(arg_txtResponse: String);
	  function GetTextResponse(): String;
   end;

implementation

procedure TCardTranMsgStatus.SetCmdStatus(arg_status: String);
begin
   FcmdStatus := arg_status;
end;

procedure TcardTranMsgStatus.SetTestResponse(arg_txtResponse: String);
   FtextResponse := arg_txtResponse;
end;

function TCardTranMsgStatus.GetCmdStatus(): String;
begin
   result := FcmdStatus;
end

function TCardTranMsgStatus.GetTextResponse(): String;
begin
   result := FtextResponse;
end;


end.


