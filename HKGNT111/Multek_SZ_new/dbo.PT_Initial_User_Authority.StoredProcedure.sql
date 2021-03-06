USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_Initial_User_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_Initial_User_Authority]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 INSERT INTO PT_Authority (UserID,MenuID)
	SELECT b.UserID,a.ID
	FROM PT_Menu a,PT_Users b
	WHERE a.ID+b.UserID NOT IN (
						SELECT MenuID+UserID
						FROM  PT_Authority
						   )

	DELETE PT_Authority
	WHERE MenuID NOT IN (
					SELECT ID
					FROM PT_Menu
				 )

	--Initial Administrator's authority
	UPDATE PT_Authority
	SET CanSee=1
	WHERE UserID IN
		(SELECT UserID FROM PT_Users WHERE Administrator=1)

	UPDATE PT_Authority
	SET CanSee=1
	WHERE UserID IN
		(SELECT UserID FROM PT_Users WHERE SiteOwner=1)
		AND MenuID <>'000080000200001'

	UPDATE PT_Authority
	SET CanSee=1
	WHERE MenuID IN ('00001','00006','00009','00010')
	UPDATE PT_Authority
	SET CanSee=0
	FROM PT_Authority a,PT_Users b
	WHERE a.UserID=b.UserID
		AND a.MenuID='000080000200001'
		AND ISNULL(b.Administrator,0)<>1



END
GO
