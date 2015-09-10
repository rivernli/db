USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[CostPriceTrend_sp_Check_UserID]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[CostPriceTrend_sp_Check_UserID]   
		@Account VARCHAR(50)
AS

SET NOCOUNT ON

SET @Account=LTRIM(RTRIM(@Account))

IF NOT EXISTS(SELECT * FROM dbo.CostPriceTrend_Users WHERE Account=@Account)
	BEGIN
		RAISERROR('Sorry, you have not authority to access the system!',16,1)
		RETURN
	END




GO
