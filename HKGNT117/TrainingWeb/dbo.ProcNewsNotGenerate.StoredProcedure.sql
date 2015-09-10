USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsNotGenerate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:52
-- Description:	取消生成HTML
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsNotGenerate]
	@id int 
AS
BEGIN
    Update NewsTable set  htmlurl='',htmls=0 where id=@id    
    select @@rowcount
END

GO
