USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vw_TFSOLP101180_tp1]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_TFSOLP101180_tp1]
as
select * from TFSOLP101180 where T$INVD >= '2005-01-01' AND T$RQDT <> '1901-01-01'

GO
