USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_GPA_Log]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Query_GPA_Log]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT a.* ,b.BDM+' ('+b.Account+')' AS OperatorName
	FROM GPAHistory a,Users b
	WHERE a.Operator=b.UserID
	ORDER BY a.AutoID DESC
END
GO
