USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminLogUpdate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 20:40
-- Description:	更新日志记录(用户退出)
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminLogUpdate]
	@aid int
AS
BEGIN
	update  adminLogTable set  flag=0,outtime=(getdate()) where  id=(select top 1 id  from adminLogTable where  aid=@aid order by id desc)
    select @@rowcount 
END

GO
