USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_ProcessByPlant]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_ProcessByPlant] 	
		@ID INT=NULL,
		@Building VARCHAR(10)=NULL,
		@Process VARCHAR(20)=NULL,
		@KeyMachine VARCHAR(50)=NULL,
		@TotalQty FLOAT=NULL,
		@EquivalentModel NVARCHAR(50)=NULL,
		@EquivalentQty FLOAT=NULL, 
		@PlannedDT FLOAT=NULL,
		@AveChangeOverDT FLOAT=NULL,
		@SampleTime FLOAT=NULL,
		@CapacityTotal FLOAT=NULL,
		@CapacityHours FLOAT=NULL,
		@BaanWorkCenter VARCHAR(50)=NULL,
		@GroupName VARCHAR(50)=NULL,
		@Remark NVARCHAR(1000)=NULL,
		@Operation VARCHAR(10)=NULL
AS

IF @Operation='Insert' 
	BEGIN
		DECLARE @SortNum INT
		SELECT @SortNum = MAX(SortNum) + 1 FROM IES_ProcessByPlant
		INSERT INTO IES_ProcessByPlant(Building, Process, KeyMachine, TotalQty, EquivalentModel, EquivalentQty, PlannedDT, AveChangeOverDT, CapacityHours, BaanWorkCenter, GroupName, Remark, SortNum, SampleTime, CapacityTotal)
		VALUES(@Building, @Process, @KeyMachine, @TotalQty, @EquivalentModel, @EquivalentQty, @PlannedDT, @AveChangeOverDT, @CapacityHours, @BaanWorkCenter, @GroupName, @Remark, ISNULL(@SortNum, 1), @SampleTime, @CapacityTotal)
		RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE IES_ProcessByPlant
		SET Building=@Building, Process=@Process, KeyMachine=@KeyMachine, TotalQty=@TotalQty, EquivalentModel=@EquivalentModel, EquivalentQty=@EquivalentQty, PlannedDT=@PlannedDT, AveChangeOverDT=@AveChangeOverDT, CapacityHours=@CapacityHours, BaanWorkCenter=@BaanWorkCenter, GroupName=@GroupName, Remark=@Remark, SampleTime=@SampleTime, CapacityTotal=@CapacityTotal
		WHERE ID=@ID
		RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_ProcessByPlant WHERE ID=@ID
		DELETE FROM IES_PJDatabase_CycleTime WHERE PBPID=@ID
		DELETE FROM IES_PJDatabase_SubCycleTime WHERE PBPID=@ID
		RETURN @ID
	END


GO
