USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_sheet_Report_for_MKT_Query_Project_Autocomplete]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_sheet_Report_for_MKT_Query_Project_Autocomplete]
@prefixText		NVARCHAR(13),
@count			INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT  TOP(@count) T$PJNO 
	FROM	dbo.Cost_sheet_Report_for_MKT_autocomplete_Project
	WHERE	T$PJNO LIKE N'%'+@prefixText+'%' 
	ORDER BY T$PJNO
END



GO
