USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPermissionsGetByr_id]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 20:52
-- Description:	获取指定角色编号的所有权限类
-- =============================================
CREATE PROCEDURE [dbo].[ProcPermissionsGetByr_id]
@r_id int
AS
BEGIN
	select * from PermissionsTable  where  r_id=@r_id 
END

GO
