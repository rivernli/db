USE [FactoryLoading]
GO
/****** Object:  View [dbo].[dif_tfsbom421180]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[dif_tfsbom421180]
as
select * from tfsbom421180 where t$pjno + cast(t$sern as varchar(4)) in
(
select t$pjno + cast(t$sern as varchar(4)) from tfsbom400180 where t$crdt > convert(nvarchar(10),getdate()-60,120)
)
GO
