USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vTFSBOM421180]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE View [dbo].[vTFSBOM421180]
AS
--SELECT * FROM OPENQUERY(AS1P1,'SELECT baan.tfsbom421180.* FROM baan.tfsbom421180, baan.tfsbom400180
--where 
--baan.tfsbom421180.t$pjno = baan.tfsbom400180.t$pjno and baan.tfsbom421180.t$sern = baan.tfsbom400180.t$sern
--and to_char(baan.tfsbom400180.t$lcdt,''yyyy-mm-dd'') = to_char(sysdate,''yyyy-mm-dd'') AND SUBSTR(baan.tfsbom400180.t$pjno,1,1)=''$''')

SELECT * FROM OPENQUERY(AS1P1,'SELECT baan.tfsbom421180.* FROM baan.tfsbom421180, baan.tfsbom400180
where 
baan.tfsbom421180.t$pjno = baan.tfsbom400180.t$pjno and baan.tfsbom421180.t$sern = baan.tfsbom400180.t$sern
and to_char(baan.tfsbom400180.t$lcdt,''yyyy-mm-dd'') = (SELECT to_char(MAX(t$lcdt),''yyyy-mm-dd'') FROM baan.tfsbom400180) AND SUBSTR(baan.tfsbom400180.t$pjno,1,1)=''$''')


GO
