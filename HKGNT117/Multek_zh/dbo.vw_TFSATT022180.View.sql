USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_TFSATT022180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_TFSATT022180]
AS
SELECT * FROM OPENQUERY(as1p1,'select * from baan.TFSATT022180')
GO
