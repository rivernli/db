USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_Query_WIP_status]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[Cancellation_Charge_sp_Query_WIP_status] 
@SO	NVARCHAR(6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM dbo.Cancellation_Charge_PPC_WIP WHERE SO = @SO
END



GO
