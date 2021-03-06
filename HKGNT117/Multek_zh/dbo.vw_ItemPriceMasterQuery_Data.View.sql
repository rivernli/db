USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_ItemPriceMasterQuery_Data]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE view [dbo].[vw_ItemPriceMasterQuery_Data]
as
select 
T$PLNT as Plant,
T$CUNO as CustomerCode,
rtrim(T$ITEM) as Project,
rtrim(T$DSCA) as customerpartNumber,
rtrim(OEM) as OEM,
T$VERS as PriceVersion,
T$TYPE as T_type,
T$PRIC as Unit,
T$CCUR as CCUR,
T$GNPR as GrossNet,
T$STAT as Active 

 from ItemPriceMasterQuery_Data WHERE T$TYPE<>'Special Price'


GO
