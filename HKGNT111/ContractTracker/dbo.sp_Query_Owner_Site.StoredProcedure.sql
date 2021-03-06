USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_Owner_Site]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_Query_Owner_Site]
	@OwnerID VARCHAR(50),
	@Closed BIT=NULL
AS

SET NOCOUNT ON

SET @Closed=ISNULL(@Closed,1)

IF (EXISTS(SELECT * FROM Users WHERE UserID=@OwnerID AND Administrator=1)OR EXISTS(SELECT * FROM Users WHERE UserID=@OwnerID AND ViewAll=1))
	BEGIN
		SELECT * 
		FROM Site
		WHERE Name IN (
					SELECT SiteName FROM uvwGPA WHERE Closed=@Closed AND Deleted=0 GROUP BY SiteName HAVING COUNT(*)>0
				   ) 
		ORDER BY AutoID DESC
	END
ELSE
	BEGIN
		SELECT * 
		FROM Site
		WHERE Name IN (
					SELECT SiteName FROM uvwGPA WHERE Closed=@Closed AND Deleted=0 AND OwnerID=@OwnerID GROUP BY SiteName HAVING COUNT(*)>0
				   ) 
		ORDER BY AutoID DESC
	END
GO
