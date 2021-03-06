USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 13:57
-- Description:	增加管理员
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminInsert]
	@r_id int,
	@admin nvarchar(50),
	@pwd nvarchar(50),
	@flag int,
	@logintimes int,
	@explain nvarchar(50),
	@aaa nchar(10)
AS
BEGIN
	INSERT INTO admin
                      (r_id, admin, pwd, flag, logintimes, explain, aaa)
                      VALUES     (@r_id,@admin,@pwd,@flag,@logintimes,@explain,@aaa)
    select @@rowcount                
END

GO
