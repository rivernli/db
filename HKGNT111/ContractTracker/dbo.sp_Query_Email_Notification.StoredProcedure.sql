USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_Email_Notification]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Query_Email_Notification]
	@EmailNotification VARCHAR(8000) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @Email VARCHAR(50)
	DECLARE User_C CURSOR FOR
	SELECT Email
	FROM Users
	WHERE EmailNotification=1
			AND Enable=1
	OPEN User_C
	FETCH NEXT FROM User_C INTO @Email

	SET @EmailNotification=''
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @EmailNotification=@EmailNotification+@Email+';'
			FETCH NEXT FROM User_C INTO @Email
		END

	IF @EmailNotification>''
		BEGIN
			SET @EmailNotification=LEFT(@EmailNotification,LEN(@EmailNotification)-1)
		END

	CLOSE User_C
	DEALLOCATE User_C
END
GO
