USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [dbo].[Check_Data_Synchronous_Successful]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Check_Data_Synchronous_Successful]
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE	@Baan_Count INT
	DECLARE	@SQL_Count	INT

    -- Insert statements for procedure here
	SET	@Baan_Count = 0
	SET @SQL_Count  = 0
	SELECT @Baan_Count = Temp_Count FROM OPENQUERY(AS1P1,'SELECT COUNT(*) AS Temp_Count FROM BAAN.TFSBOC100180')
	SELECT @SQL_Count  = COUNT(*) FROM	BOC.dbo.TFSBOC100180
	IF @Baan_Count <> @SQL_Count
		BEGIN
			PRINT @Baan_Count
		END
END

GO
