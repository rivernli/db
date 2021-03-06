USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B1Parts_Issue_Qty_By_User_Month]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[vw_B1Parts_Issue_Qty_By_User_Month]
as 
select ESUserName,PartNO,NewDescription,IssuedQty,
(CONVERT(varchar(4),[Date], 120 )+'/'+substring(CONVERT(varchar(10),[Date],120),6,2)) AS Date_YM 
 from vw_B1Parts_Daily_Issue_Detail 

GO
