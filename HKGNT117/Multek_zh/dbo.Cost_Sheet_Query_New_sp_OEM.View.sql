USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Cost_Sheet_Query_New_sp_OEM]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Cost_Sheet_Query_New_sp_OEM]
AS
SELECT T$PLNT,T$DSCA FROM dbo.Cost_Sheet_Query_TFSBOM400180 
GROUP BY T$PLNT,T$DSCA
GO
