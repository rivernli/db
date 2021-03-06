USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Update_Technics]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Update_Technics]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE TFSOLP104180
	SET Technics=ISNULL((CASE WHEN LEN(T$ITEM)>8 THEN SUBSTRING(T$ITEM,CHARINDEX('-',T$ITEM)+1,1) ELSE LEFT(T$ITEM,1) END),'')
	CREATE NONCLUSTERED INDEX [Technics] ON [TFSOLP104180] 
	(
		[Technics] ASC
	)
	CREATE NONCLUSTERED INDEX [SitePlantTechnicsSHDate] ON [TFSOLP104180] 
	(
		[T$LOCA] ASC,[T$PLNT] ASC,[Technics] ASC,[T$DATE] ASC
	)
		
	UPDATE TFSOLP105180
	SET Technics=ISNULL((CASE WHEN LEN(T$ITEM)>8 THEN SUBSTRING(T$ITEM,CHARINDEX('-',T$ITEM)+1,1) ELSE LEFT(T$ITEM,1) END),'')
	CREATE NONCLUSTERED INDEX [Technics] ON [TFSOLP105180] 
	(
		[Technics] ASC
	)
	CREATE NONCLUSTERED INDEX [SitePlantTechnicsSHDate] ON [TFSOLP105180] 
	(
		[T$LOCA] ASC,[T$PLNT] ASC,[Technics] ASC,[T$DATE] ASC
	)

	UPDATE TFSOLP106180
	SET Technics=ISNULL((CASE WHEN LEN(T$ITEM)>8 THEN SUBSTRING(T$ITEM,CHARINDEX('-',T$ITEM)+1,1) ELSE LEFT(T$ITEM,1) END),'')
	CREATE NONCLUSTERED INDEX [Technics] ON [TFSOLP106180] 
	(
		[Technics] ASC
	)
	CREATE NONCLUSTERED INDEX [SitePlantTechnicsSHDate] ON [TFSOLP106180] 
	(
		[T$LOCA] ASC,[T$PLNT] ASC,[Technics] ASC,[T$DATE] ASC
	)

	UPDATE TFSOLP107180
	SET Technics=ISNULL((CASE WHEN LEN(T$ITEM)>8 THEN SUBSTRING(T$ITEM,CHARINDEX('-',T$ITEM)+1,1) ELSE LEFT(T$ITEM,1) END),'')
	CREATE NONCLUSTERED INDEX [Technics] ON [TFSOLP107180] 
	(
		[Technics] ASC
	)
	CREATE NONCLUSTERED INDEX [SitePlantTechnicsSHDate] ON [TFSOLP107180] 
	(
		[T$LOCA] ASC,[T$PLNT] ASC,[Technics] ASC,[T$DATE] ASC
	)

END
GO
