USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_Period]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXR2_sp_Query_Period]
AS
BEGIN

	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Period FROM dbo.EXR2_Fixed_Period ORDER BY ID ASC
END


GO
