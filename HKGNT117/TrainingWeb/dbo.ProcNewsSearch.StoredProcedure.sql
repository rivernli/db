USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsSearch]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 19:22
-- Description:	搜索
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsSearch]
	@keytext nvarchar(255)
AS
BEGIN
	Select * from  NewsTable where title like '%'+@keytext+'%' order by bid desc 
	select @@rowcount
END

GO
