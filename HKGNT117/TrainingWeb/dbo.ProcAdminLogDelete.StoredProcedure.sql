USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminLogDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 20:40
-- Description:	删除日志记录
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminLogDelete]
	@id int
AS
BEGIN
	Delete adminLogTable where id=@id
    select @@rowcount 
END

GO
