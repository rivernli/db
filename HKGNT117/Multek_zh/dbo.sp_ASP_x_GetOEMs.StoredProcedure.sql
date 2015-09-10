USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_ASP_x_GetOEMs]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ASP_x_GetOEMs] 
	@oem VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT T$CSGS FROM TFSOLP112180 WHERE T$CSGS LIKE ''+@oem+'%'
    GROUP BY T$CSGS
    ORDER BY T$CSGS
END

GO
