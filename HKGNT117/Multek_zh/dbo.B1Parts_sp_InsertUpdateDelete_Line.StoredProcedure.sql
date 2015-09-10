USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_Line]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_Line] 	
		@ID INT=NULL,
		@EqAr NVARCHAR(50),
		@EqAde NVARCHAR(50),		
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_Line_List (EqAr, EqAde)
					VALUES(@EqAr, @EqAde) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_Line_List
		SET EqAr=@EqAr, EqAde=@EqAde 
		WHERE ID=@ID 	
	return @ID 
	END














GO
