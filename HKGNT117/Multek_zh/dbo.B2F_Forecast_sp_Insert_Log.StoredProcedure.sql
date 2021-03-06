USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B2F_Forecast_sp_Insert_Log]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[B2F_Forecast_sp_Insert_Log] 
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
	
	INSERT INTO B2F_Forecast_log (UserID,Operation,Remark)
				VALUES(@UserID,@Operation,@Remark)
	
END
 
GO
