USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_Cost_Sheet_for_gp_Autoupdata_data]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Cost_Sheet_for_gp_Autoupdata_data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#Temp') AND TYPE = 'U')
		DROP TABLE #Temp

	SELECT * INTO #Temp FROM 
	(
		SELECT * FROM OPENQUERY(AS1P1,'SELECT * FROM BAAN.TFSOLP150180')
		EXCEPT 
		SELECT * FROM TFSOLP150180
	) A

	IF EXISTS(SELECT TOP 1 * FROM  #Temp)
		BEGIN
			DELETE TFSOLP150180 FROM TFSOLP150180 AS A,#Temp AS B WHERE A.T$PJNO = B.T$PJNO AND A.T$SERN = B.T$SERN
			INSERT INTO TFSOLP150180
			SELECT * FROM #Temp
		END
END

GO
