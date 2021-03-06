USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Quarterly_RMA]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Quarterly_RMA]
	-- Add the parameters for the stored procedure here
	@Plant VARCHAR(50),
	@Year VARCHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SET @Plant=(CASE WHEN @Plant='ZhuHai' THEN '' ELSE @Plant END)
    SET @Plant='%'+RTRIM(LTRIM(@Plant))+'%'
    IF @Plant<>'%%'
		BEGIN
			SELECT *
			FROM DistributionReport_Quarterly_RMA
			WHERE Year=@Year
				AND Plant LIKE @Plant
		END
	ELSE
		BEGIN
			SELECT *
			FROM DistributionReport_Quarterly_RMA
			WHERE Year=@Year
				AND Plant LIKE @Plant
				AND Plant<>''
			--ORDER BY Year,Quarter,Plant
		END
	
END
GO
