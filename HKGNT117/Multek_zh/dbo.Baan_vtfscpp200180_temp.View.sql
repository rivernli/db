USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Baan_vtfscpp200180_temp]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Baan_vtfscpp200180_temp]
as
SELECT *  FROM OPENQUERY(AS1P1,'SELECT * FROM BAAN.TFSCPP200180')
GO
