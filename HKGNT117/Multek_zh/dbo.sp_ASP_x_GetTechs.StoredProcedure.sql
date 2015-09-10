USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ASP_x_GetTechs]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ASP_x_GetTechs] 
	@tech VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT T$PRDT FROM TFSOLP112180 WHERE T$PRDT LIKE ''+@tech+'%'
    GROUP BY T$PRDT
    ORDER BY T$PRDT
END

GO
