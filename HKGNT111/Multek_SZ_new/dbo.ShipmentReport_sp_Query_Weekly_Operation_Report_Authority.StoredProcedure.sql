USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Weekly_Operation_Report_Authority]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Weekly_Operation_Report_Authority]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM  ShipmentReport_Users WHERE UserID=@UserID AND Administrator=1) OR @UserID='asia\hkg10114'
		BEGIN
			SELECT '1' AS CanOperate
		END 
	ELSE
		BEGIN
			SELECT '0' AS CanOperate
		END 
		
END
GO
