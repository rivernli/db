USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[sp_Get_Date_Nearest]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Get_Date_Nearest]
	-- Add the parameters for the stored procedure here
	@Date DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.*
	FROM TFSBOM400180 a,
				(
					SELECT LEFT(ProjectSERN,CHARINDEX(',',ProjectSERN)-1) AS T$PJNO,RIGHT(ProjectSERN,LEN(ProjectSERN)-CHARINDEX(',',ProjectSERN)) AS T$SERN
					FROM (
							SELECT dbo.fun_Get_Nearest_Record(LEFT(T$PJNO,9),@Date) AS ProjectSERN
							FROM TFSBOM400180
							GROUP BY LEFT(T$PJNO,9)
						 ) c
				) b
	WHERE a.T$PJNO=b.T$PJNO
		AND a.T$SERN=b.T$SERN

END

GO
