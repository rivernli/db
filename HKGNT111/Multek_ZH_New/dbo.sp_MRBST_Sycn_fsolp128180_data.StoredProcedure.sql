USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRBST_Sycn_fsolp128180_data]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRBST_Sycn_fsolp128180_data]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#Temp_fsolp128') AND TYPE = 'U')
		DROP TABLE #Temp_fsolp128

	SELECT * INTO #Temp_fsolp128 FROM [HKGNT117].[multekchi_realtime].[dbo].[vTFSOLP128180]

	IF NOT EXISTS(SELECT TOP 1 * FROM [dbo].[TFSOLP128180] WHERE [T$JDAT] = CONVERT(VARCHAR(10),GETDATE(),120))
		BEGIN
			INSERT INTO [dbo].[TFSOLP128180]
			SELECT * FROM #Temp_fsolp128 WHERE T$JDAT = CONVERT(VARCHAR(10),GETDATE(),120)
			--PRINT 'A'
		END
	--ELSE
	--	BEGIN
	--		PRINT 'B'
	--	END
END
GO
