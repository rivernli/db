USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_MCOS_Project]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_MCOS_Project]
	@Plant nvarchar(50)
	,@OEM  nvarchar(50)
	,@Technology nvarchar(50)
	,@Layers nvarchar(50)
	
AS
BEGIN
	IF @Plant = 'ALL'
	BEGIN
		SELECT     Project
		FROM       [CostDetail]
		WHERE     OEMName = @OEM 
			AND Technology=@Technology 
			AND Layers=@Layers
		GROUP BY    Project
		ORDER BY Project 
	END
	ELSE
	BEGIN
		SELECT     Project
		FROM       [CostDetail]
		WHERE     Plant = @plant
			AND OEMName = @OEM 
			AND Technology=@Technology 
			AND Layers=@Layers
		GROUP BY    Project
		ORDER BY Project 
	END
	
END


GO
