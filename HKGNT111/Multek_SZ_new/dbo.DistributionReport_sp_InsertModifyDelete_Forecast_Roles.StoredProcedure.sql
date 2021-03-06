USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_InsertModifyDelete_Forecast_Roles]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_InsertModifyDelete_Forecast_Roles]
	-- Add the parameters for the stored procedure here
	@UserID varchar(50),
	@Option VARCHAR(50),
	@CanSee CHAR(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    
    EXECUTE DistributionReport_sp_Initial_Forecast_Roles

    DECLARE @SQLString VARCHAR(MAX)
    SET @SQLString='UPDATE DistributionReport_Forecast_Authority SET '
    SET @SQLString=@SQLString+@Option+'='+''''+@CanSee+''''
    SET @SQLString=@SQLString+' WHERE UserID='+''''+@UserID+''''
        
    EXECUTE (@SQLString)
             
END
GO
