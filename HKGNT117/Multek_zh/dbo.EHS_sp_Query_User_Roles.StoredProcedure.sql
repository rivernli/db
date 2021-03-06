USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_Query_User_Roles]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 


CREATE proc [dbo].[EHS_sp_Query_User_Roles]
@UserID VARCHAR(50),
@menuid VARCHAR(50)
as 
begin
	DECLARE @UserRight VARCHAR(50)
	select @UserRight=Administrator from EHS_Users WHERE UserID=@UserID 
	IF(@UserRight='1')
		begin
			RETURN '3'
		end
	ELSE 
		begin
			select @UserRight=User_Right from EHS_Authority WHERE UserID=@UserID AND MenuID=@menuid 
			RETURN @UserRight
		end
end



GO
