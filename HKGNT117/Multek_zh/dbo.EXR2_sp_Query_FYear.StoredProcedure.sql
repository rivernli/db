USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_FYear]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[EXR2_sp_Query_FYear]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT FYear 
	FROM dbo.EXR2_Details 
	GROUP BY FYear
	ORDER BY FYear DESC
END


GO
