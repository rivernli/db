USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_MaintainTarget_InsertUpdateDeleteBind]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<sun zhang>
-- Create date: <4/26/2011>
-- Description:	<ManageReportAnalysis_MaintainTargett的增删和查操作>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_MaintainTarget_InsertUpdateDeleteBind]
	@ID INT=null,
	@Target  nvarchar(50)=null,
	@FiscalYear  nvarchar(50)=null,
	@Cyc  nvarchar(50)=null,
	@Type  nvarchar(50)=null,
	@Value  nvarchar(50)=null,
	
	@Operatation nvarchar(10)
AS
BEGIN


    -- Insert 
	IF @Operatation = 'Insert'
		BEGIN
            INSERT INTO ManageReportAnalysis_MaintainTarget
                       ([Target], [FiscalYear], [Cyc], [Type], [Value])
            VALUES     (@Target,@FiscalYear,@Cyc,@Type,@Value)
		END
	-- Update
	IF @Operatation = 'Update'
		BEGIN
			UPDATE    ManageReportAnalysis_MaintainTarget
			SET       [Type] = @Type, [Value] = @Value
			WHERE     ([ID] = @ID)
		END		
	-- Delete
	IF @Operatation = 'Delete'
		BEGIN
            DELETE FROM ManageReportAnalysis_MaintainTarget
            WHERE     ([ID] = @ID)
		END	
	-- Bind		
	IF @Operatation = 'Bind'
		BEGIN
			SELECT * FROM   ManageReportAnalysis_MaintainTarget 
			WHERE     ([Target] = @Target and [FiscalYear] = @FiscalYear and [Cyc] = @Cyc)
		END
	-- SELECT		
	IF @Operatation = 'SELECT'
		BEGIN
			SELECT * FROM   ManageReportAnalysis_MaintainTarget 
			WHERE     ([ID] = @ID)
		END
END



GO
