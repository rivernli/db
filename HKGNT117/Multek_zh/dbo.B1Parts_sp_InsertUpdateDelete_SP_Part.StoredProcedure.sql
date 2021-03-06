USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_SP_Part]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_SP_Part] 	
		@ID INT=NULL,
		@NewPN NVARCHAR(50),
		@NewDescription NVARCHAR(100),
		@Type NVARCHAR(500),
		@OldPN NVARCHAR(255),
		@Unit NVARCHAR(50),
		@Baanrice money,
		@ABC NVARCHAR(50),
		@Location NVARCHAR(50),
		@Max INT=NULL,
		@Min INT=NULL,
		@Belongto NVARCHAR(50),
		@PhotoType varchar(10),
		@Remark NVARCHAR(max),
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_SP_Part_List (NewPN, NewDescription, [Type], OldPN, Unit, Baanrice, ABC, Location, [Max], [Min], Belongto, PhotoType, Remark)
					VALUES(@NewPN, @NewDescription, @Type, @OldPN, @Unit, @Baanrice, @ABC, @Location, @Max, @Min, @Belongto, @PhotoType, @Remark) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_SP_Part_List
		SET NewPN=@NewPN, NewDescription=@NewDescription, [Type]=@Type, OldPN=@OldPN, Unit=@Unit, Baanrice=@Baanrice, ABC=@ABC,
			Location=@Location, [Max]=@Max, [Min]=@Min, Belongto=@Belongto, PhotoType=@PhotoType, Remark=@Remark  
		WHERE ID=@ID 	
	return @ID 
	END















GO
