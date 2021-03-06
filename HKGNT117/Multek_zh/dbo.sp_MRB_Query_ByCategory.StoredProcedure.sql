USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRB_Query_ByCategory]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_MRB_Query_ByCategory] 
	@cat	VARCHAR(10),
	@key	VARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @cat='cust'
	BEGIN
		SELECT TOP 10 RTRIM(T$CUST) FROM MRB_Customers--tfsolp128180
		WHERE T$CUST LIKE @key+'%'
		GROUP BY T$CUST
		ORDER BY T$CUST
	END
	
	ELSE IF @cat='oem'
	BEGIN
		SELECT TOP 10 RTRIM(T$OEMN) FROM MRB_OEMs
		WHERE T$OEMN LIKE @key+'%'
		GROUP BY T$OEMN
		ORDER BY T$OEMN
	END
	
	ELSE IF @cat='tech'
	BEGIN
		SELECT TOP 10 RTRIM(T$TECH) FROM MRB_TECHs
		WHERE T$TECH LIKE @key+'%'
		GROUP BY T$TECH
		ORDER BY T$TECH
	END
END


GO
