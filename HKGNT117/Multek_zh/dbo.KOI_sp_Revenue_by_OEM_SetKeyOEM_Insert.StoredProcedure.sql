USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Revenue_by_OEM_SetKeyOEM_Insert]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[KOI_sp_Revenue_by_OEM_SetKeyOEM_Insert]
(
	-- Add the parameters for the function here
	@Plant NVARCHAR(4),
	@OEM NVARCHAR(200),
	@CreateUser NVARCHAR(50) 
)

AS
BEGIN
	--Insert
	INSERT INTO KOI_Revenue_by_OEM_SetKey(Plant,OEM,CreateUser)VALUES(@Plant,@OEM,@CreateUser) 	

END

GO
