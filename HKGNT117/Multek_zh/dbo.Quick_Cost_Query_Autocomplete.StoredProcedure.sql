USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Quick_Cost_Query_Autocomplete]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Quick_Cost_Query_Autocomplete]
@prefixText		NVARCHAR(13),
@count			INT,
@Account		varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Account = ISNULL(@Account,'')

	SELECT  TOP(@count) T$PJNO 
	FROM	dbo.vc_Quick_Cost_Project_List
	WHERE	T$PJNO LIKE N'%'+@prefixText+'%' 
	ORDER BY T$PJNO
END



GO
