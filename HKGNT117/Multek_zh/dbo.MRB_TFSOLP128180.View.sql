USE [Multek_ZH]
GO
/****** Object:  View [dbo].[MRB_TFSOLP128180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE View [dbo].[MRB_TFSOLP128180] as

SELECT
		REPLACE(RTRIM([T$PLNT]),'2F','B2F') AS [T$PLNT]
      ,[T$PJNO]
      ,[T$LCNT]
      ,[T$ITEM]
      ,[T$UCOS]
      ,[T$USQF]
      ,RTRIM([T$CUST]) AS [T$CUST]
      ,RTRIM([T$OEMN]) AS [T$OEMN]
      ,RTRIM([T$TECH]) AS [T$TECH]
      ,[T$MDSC]
      ,[T$SDSC]
      ,[T$PROC]
      ,[T$SURF]
      ,[T$CWOC]
      ,[T$DATE]
      ,[T$QTYI]
      ,[T$QSQF]
      ,[T$MRBQ]
      ,[T$MSQF]
      ,[T$MCOS]
      ,[T$ICOS]
      ,[T$OUTE]
      ,[T$TYPE]
      ,[T$JDAT]
      ,[T$REFCNTD]
      ,[T$REFCNTU]
FROM TFSOLP128180





GO
