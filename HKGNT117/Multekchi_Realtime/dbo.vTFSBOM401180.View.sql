USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vTFSBOM401180]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE View [dbo].[vTFSBOM401180]
AS

SELECT * FROM OPENQUERY(AS1P1,'SELECT baan.tfsbom401180.* FROM baan.tfsbom401180, baan.tfsbom400180
where 
baan.tfsbom401180.t$pjno = baan.tfsbom400180.t$pjno and baan.tfsbom401180.t$sern = baan.tfsbom400180.t$sern
and to_char(baan.tfsbom400180.t$lcdt,''yyyy-mm-dd'') = (SELECT to_char(MAX(t$lcdt),''yyyy-mm-dd'') FROM baan.tfsbom400180) AND SUBSTR(baan.tfsbom400180.t$pjno,1,1)=''$''')



GO
