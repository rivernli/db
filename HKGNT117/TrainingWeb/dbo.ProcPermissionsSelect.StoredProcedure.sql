USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPermissionsSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:05
-- Description:	获取指定权限编号和角色编号的权限类
-- =============================================
CREATE PROCEDURE [dbo].[ProcPermissionsSelect]
@r_id int,
@oid int
AS
BEGIN
	Select * from PermissionsTable where oid=@oid and r_id=@r_id  order by p_bid desc
END

GO
