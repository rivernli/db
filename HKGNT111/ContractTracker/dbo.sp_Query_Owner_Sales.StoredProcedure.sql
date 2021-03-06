USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_Owner_Sales]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_Query_Owner_Sales]
	@OwnerID VARCHAR(50),
	@Closed BIT=NULL
AS

SET NOCOUNT ON

SET @Closed=ISNULL(@Closed,1)

IF (EXISTS(SELECT * FROM Users WHERE UserID=@OwnerID AND Administrator=1) OR  EXISTS(SELECT * FROM Users WHERE UserID=@OwnerID AND ViewAll=1))
	BEGIN
		SELECT * ,BDM+' ('+Account+')' AS UserName
		FROM Users
		WHERE UserID IN (
					SELECT OwnerID FROM uvwGPA WHERE Closed=@Closed AND Deleted=0 GROUP BY OwnerID HAVING COUNT(*)>0
				   ) 
		ORDER BY UserID DESC
	END
ELSE
	BEGIN
		SELECT * ,BDM+' ('+Account+')' AS UserName
		FROM Users
		WHERE UserID IN (
					SELECT OwnerID FROM uvwGPA WHERE Closed=@Closed AND Deleted=0 AND OwnerID=@OwnerID GROUP BY OwnerID HAVING COUNT(*)>0
				   ) 
		ORDER BY UserID DESC
	END
GO
