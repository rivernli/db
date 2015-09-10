USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B2F_Forecast_List_sp_Insert_Update]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[B2F_Forecast_List_sp_Insert_Update]
	@ID INT=NULL,
	@UserName NVARCHAR(50),
	@Initiator VARCHAR(50),
	@InitiatorDate DATETIME=NULL,
	@Operation VARCHAR(10) 
AS

IF @Operation='Insert' 
	BEGIN		 
			INSERT INTO B2F_Forecast_List ([UserName],[Initiator],[InitiatorDate])
			VALUES(@UserName,@Initiator,@InitiatorDate) 
			RETURN @@IDENTITY 
	END 

IF @Operation='Update' 
	BEGIN
			UPDATE B2F_Forecast_List SET [Modif]=@Initiator,[ModifDate]=@InitiatorDate 
			WHERE ID=@ID 
			return @ID 	
	END


















GO
