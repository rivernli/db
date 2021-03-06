USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminLogInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 20:30
-- Description:	增加日志记录(用户登陆)
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminLogInsert]
	@aid int,
	@name nvarchar(50),
	@logintime datetime,
	@loginip nvarchar(50),
	@flag int
AS
BEGIN
	INSERT INTO adminLogTable
                      (aid, name, logintime,loginip, flag)
           VALUES     (@aid,@name,@logintime,@loginip,@flag)
    select @@rowcount 
END

GO
