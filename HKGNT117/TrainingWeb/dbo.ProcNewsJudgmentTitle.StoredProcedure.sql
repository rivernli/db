USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsJudgmentTitle]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 19:17
-- Description:	获取该标题是否已存在
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsJudgmentTitle]
	@title nvarchar(255)
AS
BEGIN
	Select count(*) from NewsTable where title=@title
END

GO
