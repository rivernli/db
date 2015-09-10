USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HUBINV_UpdateTerminatedUser]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_HUBINV_UpdateTerminatedUser] 
	@uid nvarchar(50),
	@domain nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	update HUBINV_nUser set isActive=0, isAdmin=0
	where uid=@uid and domain=@domain
END






GO
