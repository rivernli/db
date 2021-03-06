USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_auto_analysis_every_Number_Percentage]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	< Every number,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_auto_analysis_every_Number_Percentage]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@LOOP INT

    -- Insert statements for procedure here
	SET @LOOP = 1

	WHILE @LOOP < 50
		BEGIN
			INSERT INTO dbo.M6_every_Number_Percentage(Number,[Count],Total,Percentage)
			SELECT @LOOP,COUNT(*),(SELECT COUNT(*) FROM M6 WHERE ISSP = 1) AS T,
			COUNT(*)*1.0*100/
			(
				SELECT COUNT(*) FROM M6 WHERE ISSP = 1
			) AS PER
			FROM M6 WHERE NUMBER = @LOOP AND ISSP = 0

			SET @LOOP = @LOOP + 1
		END
END

GO
