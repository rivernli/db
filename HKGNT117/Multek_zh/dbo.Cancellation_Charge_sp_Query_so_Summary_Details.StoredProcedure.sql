USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_Query_so_Summary_Details]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_Query_so_Summary_Details]
@SO nvarchar(6)
AS
BEGIN
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from dbo.Cancellation_Charge_Summary where so = @so
END

GO
