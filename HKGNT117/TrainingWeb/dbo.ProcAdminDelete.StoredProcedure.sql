USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:00
-- Description:	删除管理员
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminDelete]
	@id int
AS
BEGIN
	Delete admin where id=@id
    select @@rowcount                
END

GO
