USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[OrderAnalysis_sp_Initial_User_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[OrderAnalysis_sp_Initial_User_Authority] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--Initial user's menus
	INSERT INTO OrderAnalysis_Authority (UserID,MenuID)
	SELECT b.UserID,a.ID
	FROM OrderAnalysis_Menu a,OrderAnalysis_Users b
	WHERE a.ID+b.UserID NOT IN (
						SELECT MenuID+UserID
						FROM  OrderAnalysis_Authority
						   )

	DELETE OrderAnalysis_Authority
	WHERE MenuID NOT IN (
					SELECT ID
					FROM OrderAnalysis_Menu
				 )

	--Initial Administrator's authority
	UPDATE OrderAnalysis_Authority
	SET CanSee=1,CanAdd=1,CanModify=1,CanDelete=1
	WHERE UserID IN
		(SELECT UserID FROM OrderAnalysis_Users WHERE Administrator=1)

END
GO
