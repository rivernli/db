USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[AMD_sp_Insert_Log]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*============================================ AMD_sp_Insert_Log ======================================================================*/

CREATE PROCEDURE [dbo].[AMD_sp_Insert_Log] 
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50),
	@Operation VARCHAR(50),
	@Remark	VARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF CHARINDEX(@UserID,'asia\mcnrivli;asia\hkgpetxu;asia\mcndeniu;asia\mcnwkuan;asia\MCNSUNZH')=0
		BEGIN
			INSERT INTO AMD_Log (UserID,Operation,Remark)
				VALUES(@UserID,@Operation,@Remark)
		END
END



GO
