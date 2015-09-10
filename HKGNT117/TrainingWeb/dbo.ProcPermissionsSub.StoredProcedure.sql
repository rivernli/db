USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPermissionsSub]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:05
-- Description:	获取指定角色编号的所有子类
-- =============================================
CREATE PROCEDURE [dbo].[ProcPermissionsSub]
@r_id int,
@parentendid int
AS
BEGIN
	Select * from PermissionsTable where parentendid=@parentendid  and r_id=@r_id  order by p_bid desc
END

GO
