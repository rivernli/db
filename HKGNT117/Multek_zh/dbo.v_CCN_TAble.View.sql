USE [Multek_ZH]
GO
/****** Object:  View [dbo].[v_CCN_TAble]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_CCN_TAble]
AS
SELECT *,
ISNULL(
CASE 
	WHEN APPClose=1 THEN 'Closed' 
	WHEN ISNULL(APPClose,0)=0 THEN 
		CASE 
			WHEN DATEDIFF(day,ISNULL(EDDate,TCDate),getdate()) > 1 THEN 'Past Due'
			WHEN OpenOrClosed = 'Closed' THEN 'Pending Approval'
		END
END,
'Open') AS Status

FROM CCN_Table


GO
