USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_Have_OpenCase_Owner]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Query_Have_OpenCase_Owner]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.OwnerID,
			(
				SELECT b.BDM FROM Users b WHERE b.UserID=a.OwnerID
			) AS UserName,
			(
				SELECT b.Email FROM Users b WHERE b.UserID=a.OwnerID
			) AS UserEmail
	FROM GPA a
	WHERE a.Closed=0
	GROUP BY a.OwnerID
END
GO
