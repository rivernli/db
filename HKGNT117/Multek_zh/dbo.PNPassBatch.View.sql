USE [Multek_ZH]
GO
/****** Object:  View [dbo].[PNPassBatch]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[PNPassBatch]
as 
select PN,COUNT(*) as Qty,MIN(Start_date) as FirstDate,MAX(Start_date) as LastDate from SQM_tblCheckPN  group by PN 


GO
