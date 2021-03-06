USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[vote_sp_Query_vote_expired]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[vote_sp_Query_vote_expired]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE	@Return_Value NVARCHAR(1)
	DECLARE	@ENDATE	DATETIME;

    -- Insert statements for procedure here
	SELECT TOP 1 @ENDATE = endDate from dbo.vote_General ORDER BY vote_ID DESC
	
	SET @Return_Value = 'A'  --AVAIABLE
	
	IF CONVERT(VARCHAR(10),@ENDATE,120) < CONVERT(VARCHAR(10),GETDATE(),120)
		BEGIN
			SET @Return_Value = 'E'  --EXPIRED
		END

	SELECT @Return_Value as Val
END

GO
