USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_MCOS_Technology]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_MCOS_Technology]
	@Plant nvarchar(50)
	,@OEM  nvarchar(50)
AS
BEGIN
	IF @Plant = 'ALL'
	BEGIN
		SELECT     Technology
		FROM         [CostDetail]
		WHERE     (OEMName = @OEM)
		GROUP BY    Technology
		ORDER BY Technology DESC
	END
	ELSE
	BEGIN
		SELECT     Technology
		FROM         [CostDetail]
		WHERE Plant = @plant
			AND OEMName = @OEM
		GROUP BY    Technology
		ORDER BY Technology DESC
	END
	
END


GO
