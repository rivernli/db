USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminLogGet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 20:40
-- Description:	获取所有日志记录
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminLogGet]

AS
BEGIN
	select * , DATEDIFF(s, logintime,outtime) as onlinetime from adminLogTable order by id desc
END

GO
