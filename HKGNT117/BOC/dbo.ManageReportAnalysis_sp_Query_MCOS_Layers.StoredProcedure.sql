USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_MCOS_Layers]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_MCOS_Layers]
	@Plant nvarchar(50)
	,@OEM  nvarchar(50)
	,@Technology nvarchar(50)
AS
BEGIN
	IF @Plant = 'ALL'
	BEGIN
		SELECT     Layers
		FROM       [CostDetail]
		WHERE     OEMName = @OEM 
			AND Technology=@Technology
		GROUP BY    Layers
		ORDER BY Layers 
	END
	ELSE
	BEGIN
		SELECT     Layers
		FROM       [CostDetail]
		WHERE     Plant = @plant
			AND OEMName = @OEM
			AND Technology=@Technology
		GROUP BY    Layers
		ORDER BY Layers 
	END
	
END


GO
