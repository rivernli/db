USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminGet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:12
-- Description:	获取所有管理员
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminGet]

AS
BEGIN
	   SELECT     id, r_id, admin, flag, logintimes, explain, aaa
	   FROM         admin
END

GO
