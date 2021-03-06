USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[vote_sp_Query_SurveyGeneralInformation]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[vote_sp_Query_SurveyGeneralInformation]
	-- Add the parameters for the stored procedure here
@SurveyID	INT,
@SurveyName	NVARCHAR(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @SurveyID	= ISNULL(@SurveyID,0)
	SET @SurveyName = ISNULL(@SurveyName,'')
	
	IF @SurveyID = 0  
		BEGIN
			SELECT	vote_id,
					vote_name,
					convert(nvarchar(10),endDate,120) as endDate,
					Remark,
					convert(nvarchar(10),AddDate,120) as AddDate
			FROM dbo.vote_General
			WHERE vote_Name LIKE '%'+ltrim(rtrim(@SurveyName))+'%'
		END
	ELSE
		BEGIN
			SELECT	vote_id,
					vote_name,
					convert(nvarchar(10),endDate,120) as endDate,
					Remark,
					convert(nvarchar(10),AddDate,120) as AddDate
			FROM dbo.vote_General
			WHERE vote_ID = @SurveyID
			AND vote_Name LIKE '%'+@SurveyName+'%'
		END
END

GO
