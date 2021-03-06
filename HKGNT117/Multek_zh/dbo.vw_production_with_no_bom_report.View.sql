USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_production_with_no_bom_report]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[vw_production_with_no_bom_report]
AS
SELECT     T$PLNT AS factory, T$CWOC AS department, T$SWOC AS sub_work_center, T$CITG AS item_group, T$ITEM AS item, T$IQUA AS qty, T$PRIC AS price, 
                      T$AMNT AS amount, T$YEAR AS Year, T$PRNO AS period, T$FIWK AS weekly, T$TRDT AS issue_date
FROM         dbo.TFSOLP110180
WHERE     (T$TYPE = 'production with no bom')

GO
