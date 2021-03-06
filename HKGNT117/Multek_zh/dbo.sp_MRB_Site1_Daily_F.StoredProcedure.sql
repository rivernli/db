USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_Site1_Daily_F]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Abill
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_Site1_Daily_F]
	@dt		DATETIME,
	@st		VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		T$PLNT AS A
		,SUM(T$MCOS) AS Z
	FROM MRB_TFSOLP128180_New
	WHERE
		DATEDIFF(DAY,T$DATE,@dt)=0
	AND
		CHARINDEX(T$PLNT,@st)>0
	GROUP BY T$PLNT
END





GO
