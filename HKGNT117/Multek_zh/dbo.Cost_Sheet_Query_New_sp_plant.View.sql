USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Cost_Sheet_Query_New_sp_plant]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[Cost_Sheet_Query_New_sp_plant]
AS
SELECT     T$PLNT,
	Case t$plnt when 'P2' then 'B1' else t$plnt end as Plnt
FROM         dbo.Cost_Sheet_Query_TFSBOM400180
GROUP BY T$PLNT

GO
