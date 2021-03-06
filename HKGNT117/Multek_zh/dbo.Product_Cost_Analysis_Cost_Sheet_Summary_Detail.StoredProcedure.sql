USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Product_Cost_Analysis_Cost_Sheet_Summary_Detail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Product_Cost_Analysis_Cost_Sheet_Summary_Detail]
@Project NVARCHAR(MAX),
@Pnl_sqftValue NVARCHAR(10)

AS 
BEGIN 
	DECLARE	@SQL_STRING	NVARCHAR(MAX) 

--By Panel
	IF @Pnl_sqftValue='Panel'
		BEGIN 
		SET @SQL_STRING = 'select T$PJNO as [Project No], CONVERT(varchar(12),T$MVER,112) as [Cost Sheet Version],T$SERN as [Cost Version],
						  T$VERS as [BOM version], CONVERT(varchar(100),T$crdt,103) as [Creation Date], T$crid as [Creation User],
						  CONVERT(varchar(100),T$lcdt,103) as [Last calculate date], T$stat as [Cost Sheet Status], T$UNST as [Unit/Set], T$AREA as [Set/PNL],
						  T$TQTY as [Total Output], T$OU13 as [13 Weeks Output], T$MR13 as [13 Week MRB rate], T$MASP as [ME Input Yield],
						  T$BUSP as [Yield Used], 
						  T$CESP as [Total Material Cost], T$CISP as [Total Material Cost incl Yield],
						  T$DLIP as [Direct Labor incl Yield], T$ILIP as [Indirect Labor incl Yield], T$MDSP as [MOH Cost incl Yield],
						  T$ldip as [Laser Depreciation incl Yield], T$ldmp as [Laser Maintainance incl Yield],
						 T$tciP as [Total Cost], T$gsrP as [SGA Cost], T$tcup as [Total + SGA] 
						from vc_Standard_Cost_TFSBOM400180 '+@Project 
		EXECUTE(@SQL_STRING)	
	END 

--By Sqft
	IF @Pnl_sqftValue='Sqft'
		BEGIN
		SET @SQL_STRING = 'select T$PJNO as [Project No], CONVERT(varchar(12),T$MVER,112) as [Cost Sheet Version],T$SERN as [Cost Version],
						  T$VERS as [BOM version], CONVERT(varchar(100),T$crdt,103) as [Creation Date], T$crid as [Creation User],
						  CONVERT(varchar(100),T$lcdt,103) as [Last calculate date], T$stat as [Cost Sheet Status], T$UNST as [Unit/Set], T$AREA as [Set/PNL],
						  T$TQTY as [Total Output], T$OU13 as [13 Weeks Output], T$MR13 as [13 Week MRB rate], T$MASP as [ME Input Yield],
						  T$BUSP as [Yield Used], 
						  T$CESS as [Total Material Cost], T$CISS as [Total Material Cost incl Yield],
						  T$DLIS as [Direct Labor incl Yield], T$ILIS as [Indirect Labor incl Yield], T$MDSS as [MOH Cost incl Yield],
						  T$LDIS as [Laser Depreciation incl Yield], T$ldms as [Laser Maintainance incl Yield],
						 T$tcis as [Total Cost], T$gsrs as [SGA Cost], T$tcus as [Total + SGA] 
						from vc_Standard_Cost_TFSBOM400180 '+@Project 
		EXECUTE(@SQL_STRING)	
	END 
END




GO
