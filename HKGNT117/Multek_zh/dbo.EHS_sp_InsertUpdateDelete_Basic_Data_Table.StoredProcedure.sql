USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_InsertUpdateDelete_Basic_Data_Table]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[EHS_sp_InsertUpdateDelete_Basic_Data_Table] 	
		@ID INT=NULL,
		@Medical_type NVARCHAR(50),
		@Post_End int=null,		
		@Posting int=null,
		@Medical_cycle int=null,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO EHS_Basic_Data_Table (Medical_type,Post_End,Posting,Medical_cycle) VALUES (@Medical_type,@Post_End,@Posting,@Medical_cycle) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE EHS_Basic_Data_Table SET Medical_type=@Medical_type,Post_End=@Post_End,Posting=@Posting,Medical_cycle=@Medical_cycle WHERE ID=@ID 	
	return @ID 
	END

















GO
