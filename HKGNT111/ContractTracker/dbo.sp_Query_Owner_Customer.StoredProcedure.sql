USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_Owner_Customer]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_Query_Owner_Customer]
	@OwnerID VARCHAR(50),
	@Closed BIT=NULL
AS

SET NOCOUNT ON

SET @Closed=ISNULL(@Closed,1)

IF (EXISTS(SELECT*  FROM Users WHERE UserID=@OwnerID AND Administrator=1) OR EXISTS(SELECT * FROM Users WHERE UserID=@OwnerID AND ViewAll=1))
	BEGIN
		SELECT CustomerName
		FROM GPA
		WHERE Closed=@Closed
			--AND OwnerID=@OwnerID
			AND Deleted=0
		GROUP BY CustomerName
		ORDER BY CustomerName
	END
ELSE
	BEGIN
		SELECT CustomerName
		FROM GPA
		WHERE Closed=@Closed
			AND Deleted=0
			AND OwnerID=@OwnerID
		GROUP BY CustomerName
		ORDER BY CustomerName
	END
GO
