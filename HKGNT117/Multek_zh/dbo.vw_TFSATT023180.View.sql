USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_TFSATT023180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_TFSATT023180]
AS
SELECT * FROM OPENQUERY(as1p1,'select * from baan.TFSATT023180')
GO
