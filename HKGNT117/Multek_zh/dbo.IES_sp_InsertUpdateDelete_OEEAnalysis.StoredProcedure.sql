USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_OEEAnalysis]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_OEEAnalysis] 	
		@ID INT=NULL,
		@Building VARCHAR(10)=NULL,
		@PBPID INT=NULL,
		@Year INT=NULL,
		@Month INT=NULL,
		@WorkingDays INT=NULL,
		@D01 [decimal](18, 2)=NULL,
		@D02 [decimal](18, 2)=NULL,
		@D03 [decimal](18, 2)=NULL,
		@D04 [decimal](18, 2)=NULL,
		@D05 [decimal](18, 2)=NULL,
		@D06 [decimal](18, 2)=NULL,
		@YieldRate [decimal](18, 4)=NULL,
		@Remark VARCHAR(1000)=NULL,
		@Operation VARCHAR(10)=NULL
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO IES_OEEAnalysis(Building, PBPID, [Year], [Month], WorkingDays, D01, D02, D03, D04, D05, D06, YieldRate, Remark)
		VALUES(@Building, @PBPID, @Year, @Month, @WorkingDays, @D01, @D02, @D03, @D04, @D05, @D06, @YieldRate, @Remark)
		RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE IES_OEEAnalysis
		SET Building=@Building, PBPID=@PBPID, [Year]=@Year, [Month]=@Month, WorkingDays=@WorkingDays, D01=@D01, D02=@D02, D03=@D03, D04=@D04, D05=@D05, D06=@D06, YieldRate=@YieldRate, Remark=@Remark
		WHERE ID=@ID
		RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_OEEAnalysis WHERE ID=@ID
		RETURN @ID
	END

GO
