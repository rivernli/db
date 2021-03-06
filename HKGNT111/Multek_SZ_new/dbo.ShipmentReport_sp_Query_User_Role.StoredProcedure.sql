USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_User_Role]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_User_Role]
	@SearchString VARCHAR(300)=NULL
AS

SET NOCOUNT ON

SET @SearchString=ISNULL(@SearchString,'')
SET @SearchString='%'+RTRIM(LTRIM(@SearchString))+'%'

SELECT *,BDM+' ('+UserID+')' AS UserName ,'1' AS Sort
INTO #Temp1
FROM ShipmentReport_Users 
WHERE Region LIKE @SearchString
	OR Account LIKE @SearchString
	OR BDM LIKE @SearchString
	--OR Email LIKE @SearchString

SELECT *,BDM+' ('+UserID+')' AS UserName ,'2' AS Sort
INTO #Temp2
FROM ShipmentReport_Users 
WHERE UserID NOT IN (SELECT UserID FROM #Temp1)

SELECT a.*
FROM (
		SELECT * FROM #Temp1
		UNION
		SELECT * FROM #Temp2
	 ) a
ORDER BY a.Sort ,a.UserName
GO
