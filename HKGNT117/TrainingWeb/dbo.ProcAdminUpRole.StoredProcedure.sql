USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminUpRole]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:05
-- Description:	修改管理员角色
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminUpRole]
	@id int,
	@r_id int
AS
BEGIN
	update admin set  r_id =@r_id where id=@id  
	select @@rowcount    
END

GO
