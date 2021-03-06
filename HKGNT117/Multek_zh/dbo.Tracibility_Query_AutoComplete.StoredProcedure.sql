USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Tracibility_Query_AutoComplete]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Tracibility_Query_AutoComplete]
	-- Add the parameters for the stored procedure here
	@Field	NVARCHAR(30),
	@Pfix	NVARCHAR(35),
	@Top	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @Field = ISNULL(LTRIM(RTRIM(@Field)),'')
	SET @Pfix  = ISNULL(ltrim(rtrim(@Pfix)),'')
	IF @Field  = ''
		BEGIN
			RAISERROR('Please enter condition!',16,1)
			RETURN
		END
    -- Insert statements for procedure here
	IF @Field = 'Project'
		BEGIN
			SELECT TOP(@Top) T$PJNO FROM dbo.Tracibility_project WHERE T$PJNO LIKE '%'+@Pfix+'%' ORDER BY T$PJNO
		END
END

GO
