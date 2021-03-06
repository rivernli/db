USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_Insert_Log]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*============================================ Cancellation_Charge_sp_Insert_Log ======================================================================*/

CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_Insert_Log] 
	-- Add the parameters for the stored procedure here
	@uid nvarchar(50),
	@action nvarchar(50),
	@description nvarchar(500),
	@url nvarchar(250),
	@sessId nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF CHARINDEX(@uid,'asia\lgzjzhan;asia\hkg10369;asia\mcnrivli;asia\admin_hkg10369')=0
		BEGIN
	INSERT INTO dbo.Cost_Sheet_Query_log (uid,actionTime,action,description,url,session_id)
	VALUES (@uid,getdate(),@action,@description,@url,@sessId)
		END
END


GO
