USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_sp_auto_analysis_Job - step 0]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_sp_auto_analysis_Job - step 0]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@STRING NVARCHAR(MAX)

    -- Insert statements for procedure here
    SET @STRING = '
	select getdate() as Start
	exec [dbo].[M6_auto_update_m6_to_analysis_table - step 2]
	select getdate() as Job2Finish
	exec [dbo].[M6_auto_analysis_Releation - step 3]
	select getdate() as Job3Finish
	exec [dbo].[M6_sp_auto_analysis_Relation_must_exists - step 4]
	select getdate() as Job4Finish
	exec [dbo].[M6_auto_update_m6_Missdata_table - step 5]
	select getdate() as Job5Finish
	exec [dbo].[M6_sp_auto_analysis_double - step 6]
	select getdate()  as Job6Finish'
	EXEC (@STRING)
	
END

GO
