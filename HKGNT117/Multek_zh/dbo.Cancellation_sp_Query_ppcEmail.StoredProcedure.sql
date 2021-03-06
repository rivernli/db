USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_sp_Query_ppcEmail]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_sp_Query_ppcEmail]
	-- Add the parameters for the stored procedure here
@Plant nvarchar(5),
@Email nvarchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Plant = ISNULL(@Plant,'')
	SET @Email = ISNULL(@Email,'')
	IF @PLANT = 'ALL'
		SET @Plant = ''
	
	SELECT * FROM dbo.Cancellation_ppc_Email WHERE PLANT LIKE '%'+@Plant+'%' AND EMAIL LIKE '%'+@Email+'%'
END

GO
