USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_Equipment]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_Equipment] 	
		@ID INT=NULL,
		@EqAr NVARCHAR(50),
		@EqNo NVARCHAR(50),
		@EqDe NVARCHAR(50),		
		@Remarks ntext,
		@hnEqNo NVARCHAR(50),		
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_Equipment_List (EqAr, EqNo, EqDe, Remarks)
					VALUES(@EqAr, @EqNo, @EqDe, @Remarks) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_Equipment_List
		SET EqAr=@EqAr, EqNo=@EqNo, EqDe=@EqDe, Remarks=@Remarks 
		WHERE ID=@ID 	
		
		update B1Parts_Daily_Issue_List set WorkCenter=@EqNo where WorkCenter=@hnEqNo

	return @ID 
	END













GO
