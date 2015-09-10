USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Multek_IE_TIWIP401]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Multek_IE_TIWIP401]
AS
SELECT * FROM OPENQUERY(as1p1,'select T$PLNT,T$FODA,T$TODA,T$PITM,T$RYIE from baan.ttiwip401181 WHERE T$PITA = ''          ''')
UNION ALL
SELECT * FROM OPENQUERY(as1p1,'select T$PLNT,T$FODA,T$TODA,T$PITM,T$RYIE from baan.ttiwip401184 WHERE T$PITA = ''          ''')
UNION ALL
SELECT * FROM OPENQUERY(as1p1,'select T$PLNT,T$FODA,T$TODA,T$PITM,T$RYIE from baan.ttiwip401185 WHERE T$PITA = ''          ''')
UNION ALL
SELECT * FROM OPENQUERY(as1p1,'select T$PLNT,T$FODA,T$TODA,T$PITM,T$RYIE from baan.ttiwip401186 WHERE T$PITA = ''          ''')


GO
