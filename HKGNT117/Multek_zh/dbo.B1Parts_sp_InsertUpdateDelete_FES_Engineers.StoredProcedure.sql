USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_FES_Engineers]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_FES_Engineers] 	
		@ID INT=NULL,
		@Group NVARCHAR(50),
		@ESUserNo NVARCHAR(3),
		@ESUserName NVARCHAR(50),
		@PhoneNo NVARCHAR(50),
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_FES_Engineers ([Group], ESUserNo, ESUserName, PhoneNo)
					VALUES(@Group, @ESUserNo, @ESUserName, @PhoneNo) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_FES_Engineers
		SET [Group]=@Group, ESUserNo=@ESUserNo, ESUserName=@ESUserName, PhoneNo=@PhoneNo 
		WHERE ID=@ID 	
	return @ID 
	END















GO
