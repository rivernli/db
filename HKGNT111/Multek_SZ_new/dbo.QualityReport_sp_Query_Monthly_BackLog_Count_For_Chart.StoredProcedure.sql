USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_Monthly_BackLog_Count_For_Chart]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_Monthly_BackLog_Count_For_Chart] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4)=NULL,
	@Project VARCHAR(50)=NULL,
	@PartNo VARCHAR(200)=NULL,
	@Product VARCHAR(200)=NULL,
	@OEM VARCHAR(200)=NULL,
	@Plant VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set ansi_nulls off;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	DECLARE @YearMonth VARCHAR(7)

	SET @Year=(CASE WHEN @Year IS NULL THEN CONVERT(VARCHAR(4),GETDATE(),120) ELSE @Year END)
	SET @Project=LTRIM(RTRIM(ISNULL(@Project,'')))+'%'
	SET @PartNo=LTRIM(RTRIM(ISNULL(@PartNo,'')))+'%'
	SET @Product=LTRIM(RTRIM(ISNULL(@Product,'')))+'%'
	SET @OEM=LTRIM(RTRIM(ISNULL(@OEM,'')))+'%'
	--Resolve speed slowly from resource data view
	SELECT * INTO #Temp FROM QualityReport_uvw_VPT_MKT_BackLog
	/*
	CREATE INDEX Index1 ON #Temp (Committed_Date)
	CREATE INDEX Index2 ON #Temp (Prj_No)
	CREATE INDEX Index3 ON #Temp (Part_No)
	CREATE INDEX Index4 ON #Temp (Product_Name)
	CREATE INDEX Index5 ON #Temp (OEM_Name)
	*/
	SELECT (
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-01-01' 
					  AND Committed_Date<@Year+'-02-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			) AS M1,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-02-01' 
					  AND Committed_Date<@Year+'-03-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M2,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-03-01' 
					  AND Committed_Date<@Year+'-04-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M3,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-04-01' 
					  AND Committed_Date<@Year+'-05-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M4,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-05-01' 
					  AND Committed_Date<@Year+'-06-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M5,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-06-01' 
					  AND Committed_Date<@Year+'-07-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M6,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-07-01' 
					  AND Committed_Date<@Year+'-08-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M7,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-08-01' 
					  AND Committed_Date<@Year+'-09-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M8,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-09-01' 
					  AND Committed_Date<@Year+'-10-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M9,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-10-01' 
					  AND Committed_Date<@Year+'-11-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M10,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-11-01' 
					  AND Committed_Date<@Year+'-12-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			)AS M11,
			(
				SELECT COUNT(*)
				FROM #Temp --QualityReport_uvw_VPT_MKT_BackLog
				WHERE Committed_Date>=@Year+'-12-01' 
					  AND Committed_Date<CONVERT(CHAR(4),CONVERT(INT,@Year)+1)+'-01-01' 
					  AND Prj_No LIKE @Project
					  AND Part_No LIKE @PartNo
					  AND Product_Name LIKE @Product
					  AND OEM_Name LIKE @OEM
					  AND CHARINDEX(Plant,@Plant)>0 
			) AS M12
END
GO
