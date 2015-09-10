USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_calc_Ac]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_calc_Ac]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    INSERT M6_AC(DATE)
	SELECT DATE FROM M6 WHERE DATE NOT IN (SELECT DATE FROM M6_AC) GROUP BY DATE ORDER BY DATE
	
	
END

GO
