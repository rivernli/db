USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Log_Level3]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Log_Level3]
	-- Add the parameters for the stored procedure here
	@Date DATETIME,
	@UserName VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.OperatedDate AS OperatedDate ,
		   a.Remark
	FROM ShipmentReport_Log a
	WHERE a.OperatedDate >@Date
		AND a.OperatedDate<ISNULL((SELECT TOP 1 b.OperatedDate FROM ShipmentReport_Log b WHERE CHARINDEX(b.UserID,@UserName)>0 AND b.Operation='Login' AND b.OperatedDate >@Date ORDER BY b.OperatedDate ASC),'9999-01-01')
		AND a.Operation<>'Login'
		AND CHARINDEX(UserID,@UserName)>0
	ORDER BY a.OperatedDate ,a.Remark
END
GO
