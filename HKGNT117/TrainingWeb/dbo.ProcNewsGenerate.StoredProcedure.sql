USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsGenerate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:46
-- Description:	生成HTML
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsGenerate]
	@id int ,
	@htmlurl nvarchar(255)
AS
BEGIN
    Update NewsTable set  htmlurl=@htmlurl,htmls=1 where id=@id    
    select @@rowcount
END

GO
