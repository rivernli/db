USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Product_Cost_Analysis_sp_Insert_Log]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Product_Cost_Analysis_sp_Insert_Log] 
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
	IF CHARINDEX(@UserID,'asia\lgzjzhan;asia\hkg10369;asia\MCN00318;asia\admin_hkg10369')=0
		BEGIN
			INSERT INTO Product_Cost_Analysis_Log (UserID,Operation,Remark)
				VALUES(@UserID,@Operation,@Remark)
		END
END



GO
