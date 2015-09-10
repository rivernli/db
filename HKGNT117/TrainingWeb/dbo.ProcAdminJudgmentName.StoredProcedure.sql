USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminJudgmentName]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:02
-- Description:	获取该管理员名是否已存在
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminJudgmentName]
	@name nvarchar(50)
AS
BEGIN
	select count(*) from admin where admin=@name      
END

GO
