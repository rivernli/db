USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_Check_UserID]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*============================================ Cancellation_Charge_sp_Check_UserID ======================================================================*/

CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_Check_UserID]   
		@Domain VARCHAR(50),
		@Account VARCHAR(50)
AS

SET NOCOUNT ON

DECLARE @UserID VARCHAR(50)

SET @UserID=LTRIM(RTRIM(@Domain))+'\'+LTRIM(RTRIM(@Account))

IF NOT EXISTS(SELECT * FROM Cancellation_Charge_Users WHERE UserID=@UserID)
	BEGIN
		RAISERROR('Sorry, you have not authority to access the system!',16,1)
		RETURN
	END
IF EXISTS(SELECT * FROM Cancellation_Charge_Users WHERE UserID=@UserID AND Enable=0)
	BEGIN
		RAISERROR('Sorry, you have not authority to access the system!',16,1)
		RETURN
	END

GO
