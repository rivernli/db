USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vTFSBOM499180]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vTFSBOM499180]
AS
--SELECT * FROM OPENQUERY(AS1P1,'select * from baan.tfsbom499180 where t$usrn IN(
--								select t$usrn from baan.tfsbom472180 where to_char(t$budt,''yyyy-mm-dd'') = to_char(sysdate,''yyyy-mm-dd''))')

SELECT * FROM OPENQUERY(AS1P1,'select * from baan.tfsbom499180 where t$usrn in(
								select t$usrn from baan.tfsbom472180 where to_char(t$budt,''yyyy-mm-dd'') = (select to_char(max(t$budt),''yyyy-mm-dd'')  from baan.tfsbom472180))')



GO
