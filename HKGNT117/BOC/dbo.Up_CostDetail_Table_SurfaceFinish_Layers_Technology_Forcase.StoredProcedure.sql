USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Up_CostDetail_Table_SurfaceFinish_Layers_Technology_Forcase]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<更新CostDetail表SurfaceFinish, Layers, Technology, Forcase值">
-- =============================================
CREATE PROCEDURE [dbo].[Up_CostDetail_Table_SurfaceFinish_Layers_Technology_Forcase] 
	
AS
BEGIN
	
	--Layers
	UPDATE CostDetail SET Layers =substring([Project],2,2)--从Project第二们取两位
	--Technology
	UPDATE CostDetail SET Technology  = (SELECT  [T$ASTR] FROM  [FactoryLoading].[dbo].[TFIATT006180]  where [TFIATT006180].[T$ITEM] = CostDetail.project and [TFIATT006180].[T$ATTR]='type')
	--SurfaceFinish
	UPDATE CostDetail SET [t$code] =( SELECT   dbo.ManageReportAnalysis_Cost(CostDetail.ID ))  
	
	
	
	--Forcase
	----ALTER TABLE #CostDetails ADD Forcase NVARCHAR(50)
	--UPDATE CostDetail SET [Forcase] = ManageReportAnalysis_MaintainTarget.[Value]
	--FROM  CostDetail,ManageReportAnalysis_MaintainTarget
	--WHERE ManageReportAnalysis_MaintainTarget.[Target]='Technology' AND ManageReportAnalysis_MaintainTarget.[FiscalYear]=CostDetail.[FYear] AND ManageReportAnalysis_MaintainTarget.[Cyc]=CostDetail.[Period] AND ManageReportAnalysis_MaintainTarget.[Type]=CostDetail.[t$type] 
	
	--UPDATE CostDetail SET [Forcase] = ManageReportAnalysis_MaintainTarget.[Value]
	--FROM  CostDetail,ManageReportAnalysis_MaintainTarget
	--WHERE CostDetail.[Forcase] IS NOT NULL  AND ManageReportAnalysis_MaintainTarget.[Target]='SurfaceFinish' AND ManageReportAnalysis_MaintainTarget.[FiscalYear]=CostDetail.[FYear] AND ManageReportAnalysis_MaintainTarget.[Cyc]=CostDetail.[Period] AND ManageReportAnalysis_MaintainTarget.[Type]=(SELECT  [T$ASTR] FROM [TFIATT006180] where [TFIATT006180].[T$ITEM] = CostDetail.project and [TFIATT006180].[T$ATTR]='surf') 
    
    
END

GO
