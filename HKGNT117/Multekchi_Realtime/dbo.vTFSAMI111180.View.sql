USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vTFSAMI111180]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[vTFSAMI111180]
AS
SELECT * FROM OPENQUERY(AS1P1,'select * from baan.tfsami111180')
GO
