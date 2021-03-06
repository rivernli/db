USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ldSurvey_Insert_Answer]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ldSurvey_Insert_Answer]
	-- Add the parameters for the stored procedure here
@Num			NVARCHAR(50),
@HostName		NVARCHAR(50),
@LogonName		NVARCHAR(50),
@voteID			INT,
@vote_detailID	NVARCHAR(10),
@comment		NVARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	INSERT INTO dbo.vote_Answer(Num, Idate,HostName,LogonName,vote_ID,vote_detailID,comment)
	VALUES(@Num,GETDATE(),@HostName,@LogonName,@voteID,@vote_detailID,@comment)
	
	UPDATE vote_Questoin SET voteSum = ISNULL(voteSum,0)+1
	FROM vote_Questoin
	WHERE vote_ID = @voteID
	
	UPDATE dbo.vote_Details SET voteNum = ISNULL(voteNum,0)+1
	FROM  dbo.vote_Details 
	WHERE vote_ID = @voteID AND vote_detailID = @vote_detailID
END

GO
