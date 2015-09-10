USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminSelectByName]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:45
-- Description:	获取指定名称的管理员
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminSelectByName]
	@name nvarchar(50)
AS
BEGIN
	   Select * from admin where admin=@name
END

GO
