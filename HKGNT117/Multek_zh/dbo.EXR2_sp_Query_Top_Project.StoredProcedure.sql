USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_Top_Project]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/01/22>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[EXR2_sp_Query_Top_Project]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TopProject FROM EXR2_Top_Project ORDER BY TopProject
END


GO
