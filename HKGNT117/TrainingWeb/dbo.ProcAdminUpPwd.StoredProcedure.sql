USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminUpPwd]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:07
-- Description:	修改管理员密码
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminUpPwd]
	@id int,
	@newpwd nvarchar(50)
AS
BEGIN
	update admin set  pwd =@newpwd  where id=@id  
	select @@rowcount    
END

GO
