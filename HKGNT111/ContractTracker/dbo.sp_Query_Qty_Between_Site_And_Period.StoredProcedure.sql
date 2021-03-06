USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_Qty_Between_Site_And_Period]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_Query_Qty_Between_Site_And_Period]
	@NowDate DATETIME,
	@OwnerID VARCHAR(50),
	@Closed BIT=NULL,
	@Site VARCHAR(500)
AS

SET NOCOUNT ON

SET @Closed=ISNULL(@Closed,1)

DECLARE @SQLString VARCHAR(2000), @i AS INT,@Period VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME,@SQLOwner VARCHAR(100)

SELECT *
INTO #Temp  
FROM Site
WHERE Name = @Site

IF (EXISTS(SELECT Administrator FROM Users WHERE UserID=@OwnerID AND Administrator=1)OR EXISTS(SELECT * FROM Users WHERE UserID=@OwnerID AND ViewAll=1))
	BEGIN
		SET @SQLOWner=' 1=1'
		DELETE #Temp WHERE Name NOT IN (SELECT SiteName FROM uvwGPA WHERE Closed=@Closed AND Deleted=0 GROUP BY SiteName HAVING COUNT(*)>0 )
	END
ELSE
	BEGIN
		SET @SQLOwner=' b.OwnerID='+''''+@OwnerID+''''
		DELETE #Temp WHERE Name NOT IN (SELECT SiteName FROM uvwGPA WHERE Closed=@Closed AND Deleted=0 AND OwnerID=@OwnerID GROUP BY SiteName HAVING COUNT(*)>0 )
	END		

--Winthin 2 Weeks
SET @i=0
SET @DateFrom=DATEADD(WEEK,-2,@NowDate)+1
SET @DateTo=@NowDate
SET @SQLString='ALTER TABLE #Temp ADD column_'+CONVERT(VARCHAR(10),@i)+'  INT NULL'
EXECUTE (@SQLString)
SET @SQLString='UPDATE #Temp SET column_'+CONVERT(VARCHAR(10),@i)+'=(SELECT COUNT(*) FROM uvwGPA b WHERE '+@SQLOwner+' AND b.Closed='+CONVERT(CHAR(1),@Closed)+' AND Deleted=0   AND b.SiteName=#Temp.Name AND b.ContractInDate BETWEEN '+''''+CONVERT(VARCHAR(10),@DateFrom,120)+''''+' AND '+''''+CONVERT(VARCHAR(10),@DateTo,120)+''''+')'
EXECUTE (@SQLString)
--Over 1 Month
SET @i=1
SET @DateTo=@DateFrom-1
SET @DateFrom=DATEADD(MONTH,-1,@DateTo)
SET @SQLString='ALTER TABLE #Temp ADD column_'+CONVERT(VARCHAR(10),@i)+'  INT NULL'
EXECUTE (@SQLString)
SET @SQLString='UPDATE #Temp SET column_'+CONVERT(VARCHAR(10),@i)+'=(SELECT COUNT(*) FROM uvwGPA b WHERE '+@SQLOwner+' AND  b.Closed='+CONVERT(CHAR(1),@Closed)+' AND Deleted=0   AND b.SiteName=#Temp.Name AND b.ContractInDate BETWEEN '+''''+CONVERT(VARCHAR(10),@DateFrom,120)+''''+' AND '+''''+CONVERT(VARCHAR(10),@DateTo,120)+''''+')'
EXECUTE (@SQLString)
--Over 3 Months
SET @i=2
SET @DateTo=@DateFrom-1
SET @DateFrom=DATEADD(MONTH,-3,@DateTo)
SET @SQLString='ALTER TABLE #Temp ADD column_'+CONVERT(VARCHAR(10),@i)+'  INT NULL'
EXECUTE (@SQLString)
SET @SQLString='UPDATE #Temp SET column_'+CONVERT(VARCHAR(10),@i)+'=(SELECT COUNT(*) FROM uvwGPA b WHERE '+@SQLOwner+' AND  b.Closed='+CONVERT(CHAR(1),@Closed)+' AND Deleted=0   AND b.SiteName=#Temp.Name AND b.ContractInDate BETWEEN '+''''+CONVERT(VARCHAR(10),@DateFrom,120)+''''+' AND '+''''+CONVERT(VARCHAR(10),@DateTo,120)+''''+')'
EXECUTE (@SQLString)
--Over 6 Month
SET @i=3
SET @DateTo=@DateFrom-1
SET @DateFrom=DATEADD(MONTH,-6,@DateTo)
SET @SQLString='ALTER TABLE #Temp ADD column_'+CONVERT(VARCHAR(10),@i)+'  INT NULL'
EXECUTE (@SQLString)
SET @SQLString='UPDATE #Temp SET column_'+CONVERT(VARCHAR(10),@i)+'=(SELECT COUNT(*) FROM uvwGPA b WHERE  '+@SQLOwner+' AND b.Closed='+CONVERT(CHAR(1),@Closed)+' AND Deleted=0   AND b.SiteName=#Temp.Name AND b.ContractInDate BETWEEN '+''''+CONVERT(VARCHAR(10),@DateFrom,120)+''''+' AND '+''''+CONVERT(VARCHAR(10),@DateTo,120)+''''+')'
EXECUTE (@SQLString)
--Over 9 Month
SET @i=4
SET @DateTo=@DateFrom-1
SET @DateFrom=DATEADD(MONTH,-9,@DateTo)
SET @SQLString='ALTER TABLE #Temp ADD column_'+CONVERT(VARCHAR(10),@i)+'  INT NULL'
EXECUTE (@SQLString)
SET @SQLString='UPDATE #Temp SET column_'+CONVERT(VARCHAR(10),@i)+'=(SELECT COUNT(*) FROM uvwGPA b WHERE  '+@SQLOwner+' AND b.Closed='+CONVERT(CHAR(1),@Closed)+' AND Deleted=0   AND b.SiteName=#Temp.Name AND b.ContractInDate BETWEEN '+''''+CONVERT(VARCHAR(10),@DateFrom,120)+''''+' AND '+''''+CONVERT(VARCHAR(10),@DateTo,120)+''''+')'
EXECUTE (@SQLString)
--Over 1Year
SET @i=5
SET @DateTo=@DateFrom-1
SET @DateFrom=DATEADD(YEAR,-1,@DateTo)
SET @DateFrom='01/01/1900'
SET @SQLString='ALTER TABLE #Temp ADD column_'+CONVERT(VARCHAR(10),@i)+'  INT NULL'
EXECUTE (@SQLString)
SET @SQLString='UPDATE #Temp SET column_'+CONVERT(VARCHAR(10),@i)+'=(SELECT COUNT(*) FROM uvwGPA b WHERE '+@SQLOwner+' AND  b.Closed='+CONVERT(CHAR(1),@Closed)+' AND Deleted=0   AND b.SiteName=#Temp.Name AND b.ContractInDate BETWEEN '+''''+CONVERT(VARCHAR(10),@DateFrom,120)+''''+' AND '+''''+CONVERT(VARCHAR(10),@DateTo,120)+''''+')'
--SET @SQLString='UPDATE #Temp SET column_'+CONVERT(VARCHAR(10),@i)+'=(SELECT COUNT(*) FROM uvwGPA b WHERE '+@SQLOwner+' AND  b.Closed='+CONVERT(CHAR(1),@Closed)+' AND Deleted=0   AND b.SiteName=#Temp.Name AND b.ContractInDate >= '+''''+CONVERT(VARCHAR(10),@DateFrom,120)+''''+')'
EXECUTE (@SQLString)

SELECT * FROM #Temp ORDER BY AutoID DESC
GO
