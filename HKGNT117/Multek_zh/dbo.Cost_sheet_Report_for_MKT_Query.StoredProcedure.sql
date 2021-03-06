USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_sheet_Report_for_MKT_Query]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_sheet_Report_for_MKT_Query] 
	-- Add the parameters for the stored procedure here
@Plant				NVARCHAR(10),
@OEM				NVARCHAR(30),
@CustomerPartNum	NVARCHAR(100),
@Project			NVARCHAR(10),
@Account			VARCHAR(50),
@Domain				VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE	@sqlString	NVARCHAR(4000)
	
	SET @Plant			 = LTRIM(RTRIM(@Plant))
	SET @OEM			 = LTRIM(RTRIM(@OEM))
	SET @CustomerPartNum = LTRIM(RTRIM(@CustomerPartNum))
	SET @Project		 = LTRIM(RTRIM(@Project))

	SET @Plant			 = ISNULL(@Plant,'')
	SET @OEM			 = ISNULL(@OEM,'')
	SET @CustomerPartNum = ISNULL(@CustomerPartNum,'')
	SET @Project		 = ISNULL(@Project,'')

    -- Insert statements for procedure here

	--Get User OEM list
		DECLARE	@ID	INT
		SELECT TOP 1 @ID = sysuserid  FROM [MULTEK_BI].[DBO].[GAM_USERS] WHERE [UID] = @Account and [domain] = @Domain
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#OEMList') AND TYPE = 'U')
			DROP TABLE #OEMList
		SELECT [OEMNAME] INTO #OEMList FROM [MULTEK_BI].[DBO].[fx_getSalesForMKTRPT](@ID) GROUP BY [OEMNAME]

    -- Show result
		IF NOT EXISTS(SELECT TOP 1 * FROM #OEMList)
			BEGIN
				IF @Plant <> 'ALL'
					BEGIN
						SELECT 
						T$PLNT,
						T$PJNO, 
						OEM, 
						CUSPART, 
						T$SERN, 
						T$VERS, 
						T$MASP, 
						T$BUSP, 
						T$CESU, 
						T$CESP, 
						T$TCIU, 
						T$CISU, 
						T$TCUU, 
						T$CISS, 
						T$TCIS, 
						T$TCUS, 
						T$BOMC, 
						T$UNST, 
						T$CBPN, 
						T$QUTY, 
						T$UNIT, 
						T$CODA
						FROM dbo.Cost_sheet_Report_for_MKT
						WHERE	OEM		LIKE N'%'+@OEM+'%'
						AND		cuspart LIKE N'%'+@CustomerPartNum+'%'
						AND		T$PJNO	LIKE N'%'+@Project+'%'
						AND		T$PLNT = @Plant
					END
				ELSE
					BEGIN
						SELECT 
						T$PLNT,
						T$PJNO, 
						OEM, 
						CUSPART, 
						T$SERN, 
						T$VERS, 
						T$MASP, 
						T$BUSP, 
						T$CESU, 
						T$CESP, 
						T$TCIU, 
						T$CISU, 
						T$TCUU, 
						T$CISS, 
						T$TCIS, 
						T$TCUS, 
						T$BOMC, 
						T$UNST, 
						T$CBPN, 
						T$QUTY, 
						T$UNIT, 
						T$CODA
						FROM dbo.Cost_sheet_Report_for_MKT
						WHERE	OEM		LIKE N'%'+@OEM+'%'
						AND		cuspart LIKE N'%'+@CustomerPartNum+'%'
						AND		T$PJNO	LIKE N'%'+@Project+'%'
					END
			END
	ELSE
		BEGIN
				IF @Plant <> 'ALL'
					BEGIN
						SELECT 
						T$PLNT,
						T$PJNO, 
						OEM, 
						CUSPART, 
						T$SERN, 
						T$VERS, 
						T$MASP, 
						T$BUSP, 
						T$CESU, 
						T$CESP, 
						T$TCIU, 
						T$CISU, 
						T$TCUU, 
						T$CISS, 
						T$TCIS, 
						T$TCUS, 
						T$BOMC, 
						T$UNST, 
						T$CBPN, 
						T$QUTY, 
						T$UNIT, 
						T$CODA
						FROM dbo.Cost_sheet_Report_for_MKT
						WHERE	OEM		LIKE N'%'+@OEM+'%'
						AND		cuspart LIKE N'%'+@CustomerPartNum+'%'
						AND		T$PJNO	LIKE N'%'+@Project+'%'
						AND		T$PLNT = @Plant
						AND		OEM IN (SELECT [OEMNAME] FROM #OEMList)
					END
				ELSE
					BEGIN
						SELECT 
						T$PLNT,
						T$PJNO, 
						OEM, 
						CUSPART, 
						T$SERN, 
						T$VERS, 
						T$MASP, 
						T$BUSP, 
						T$CESU, 
						T$CESP, 
						T$TCIU, 
						T$CISU, 
						T$TCUU, 
						T$CISS, 
						T$TCIS, 
						T$TCUS, 
						T$BOMC, 
						T$UNST, 
						T$CBPN, 
						T$QUTY, 
						T$UNIT, 
						T$CODA
						FROM dbo.Cost_sheet_Report_for_MKT
						WHERE	OEM		LIKE N'%'+@OEM+'%'
						AND		cuspart LIKE N'%'+@CustomerPartNum+'%'
						AND		T$PJNO	LIKE N'%'+@Project+'%'
						AND		OEM IN (SELECT [OEMNAME] FROM #OEMList)
					END
		END
END


GO
