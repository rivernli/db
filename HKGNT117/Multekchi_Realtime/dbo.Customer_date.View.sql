USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[Customer_date]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[Customer_date]
as
select * from TFSOLP101180_date
GO
