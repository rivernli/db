USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Revenue_by_Technology_SetKeyTechnology_Insert]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create proc [dbo].[KOI_sp_Revenue_by_Technology_SetKeyTechnology_Insert]
(
	-- Add the parameters for the function here
	@Plant NVARCHAR(4),
	@Technology NVARCHAR(200),
	@CreateUser NVARCHAR(50) 
)

AS
BEGIN
	--Insert
	INSERT INTO KOI_Revenue_by_Technology_SetKey(Plant,Technology,CreateUser)VALUES(@Plant,@Technology,@CreateUser) 	

END


GO
