USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_InsertUpdateDelete_Exchange_Rate]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[B1Parts_sp_InsertUpdateDelete_Exchange_Rate] 	
		@ID INT=NULL,
		@CC NVARCHAR(50),
		@Cur NVARCHAR(50),
		@FC1TOUSD float,
		@Date datetime,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO B1Parts_Exchange_Rate_List (CC, Cur, FC1TOUSD, Date)
					VALUES(@CC, @Cur, @FC1TOUSD, @Date) 	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE B1Parts_Exchange_Rate_List
		SET CC=@CC, Cur=@Cur, FC1TOUSD=@FC1TOUSD, Date=@Date 
		WHERE ID=@ID 	
	return @ID 
	END













GO
