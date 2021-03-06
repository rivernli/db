USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Insert_Log]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE PROCEDURE [dbo].[Monthly_Cu_Tensile_Strength_sp_Insert_Log] 
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
	IF CHARINDEX(@UserID,'asia\hkgpetxu;asia\mcnrivli;asia\mcnwkuan;asia\HKGJOCHE')=0
		BEGIN
			INSERT INTO Monthly_Cu_Tensile_Strength_Log (UserID,Operation,Remark)
				VALUES(@UserID,@Operation,@Remark)
		END
END




GO
