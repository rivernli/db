USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Revenue_by_OEM_SetKeyOEM_Delete]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[KOI_sp_Revenue_by_OEM_SetKeyOEM_Delete]
(
	-- Add the parameters for the function here
	@Plant NVARCHAR(4),
	@CreateUser NVARCHAR(50) 
)

AS
BEGIN
	--Delete
	DELETE FROM KOI_Revenue_by_OEM_SetKey WHERE Plant=@Plant AND CreateUser=@CreateUser 

END

GO
