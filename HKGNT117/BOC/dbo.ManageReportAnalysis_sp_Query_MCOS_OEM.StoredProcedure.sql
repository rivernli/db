USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_MCOS_OEM]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_MCOS_OEM]
	@Plant NVARCHAR(50)
AS
BEGIN
	IF @Plant = 'ALL'
	BEGIN
		SELECT  OEMName
		FROM    [CostDetail]
		GROUP BY    OEMName
		ORDER BY OEMName 
	END
	ELSE
	BEGIN
		SELECT  OEMName
		FROM    [CostDetail]
		WHERE Plant = @plant
		GROUP BY    OEMName
		ORDER BY OEMName 
	END
END


GO
