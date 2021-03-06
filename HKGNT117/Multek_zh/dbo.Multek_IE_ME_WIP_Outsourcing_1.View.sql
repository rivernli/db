USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Multek_IE_ME_WIP_Outsourcing_1]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[Multek_IE_ME_WIP_Outsourcing_1]
AS
SELECT CASE WHEN A.T$PLNT = 'P2' THEN 'B1' WHEN A.T$PLNT = '2F' THEN 'B2' ELSE A.T$PLNT END T$PLNT,

A.T$WONO,A.T$LRUN,A.T$MNWC,A.T$PJNO,CONVERT(CHAR(10),B.T$TRDT,120) AS DTAT,T$LOTQ
FROM TTIWIP091180 AS A,TTIWIP090180 AS B
WHERE A.T$PLNT = B.T$PLNT 
AND	  A.T$BTNO = B.T$BTNO
AND	  A.T$PLNT <> '' AND A.T$PLNT IS NOT NULL
AND	  A.T$PJNO <> '' AND A.T$PJNO IS NOT NULL
AND	  A.T$LOTQ <> 0									-- Quantity is not 0
AND	  B.T$STAT = 1									-- Confirm state is yes
AND	  B.T$TYPE = 2									-- Only get out data
AND	  LEN(LTRIM(RTRIM(B.T$PART))) = 6				-- Only get to suppliers orders



GO
