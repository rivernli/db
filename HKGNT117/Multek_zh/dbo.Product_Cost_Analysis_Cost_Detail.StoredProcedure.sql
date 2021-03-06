USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Product_Cost_Analysis_Cost_Detail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Product_Cost_Analysis_Cost_Detail]
@Project NVARCHAR(MAX) 
AS 
BEGIN 

 EXEC('
		SELECT T$SERN as [Cost Version],(select top 1 T$PLNT from vc_Standard_Cost_TFSBOM400180 WHERE t$pjno=tfsolp143180.t$pjno) as Plant,
		T$PJNO as Project,T$ITEM AS [Project-Layer], T$CWOC as [Work Center], T$PSRN as [Steps], T$MNWC as [Main WC], T$MTRC as [Material cost],
		'''' as [EDM Cost], T$DLCT as [Direct Labour], T$ILCT as [Indirect Labor],'''' as [MOH],'''' as [Gold], 
		T$DRTI as [Drill time],T$ROTI as [Route time],T$LATI as [Laser time],T$PUTI as [PUN ATT time],T$SID as [Loading],T$BOMC as [BOM Part Cost] ,
		T$DPAM as [Depreciation & Amortization],T$EQEX as [Equipment Expenses],T$FAUT as [Facilities & Utilities] ,T$CMPT as [Computer Related],
		T$SUPP as [Supplies],T$TREN as [Travel & Entertainment],T$OTER as [Other Expenses] FROM tfsolp143180 '+@Project 
	 )

END 



GO
