USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ldSurvey_init]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ldSurvey_init]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	TRUNCATE TABLE dbo.vote_Answer
	UPDATE dbo.vote_Details  SET voteNum = 0
	UPDATE dbo.vote_Questoin SET voteSum = 0
END

GO
