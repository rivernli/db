USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcRoleDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 15:05
-- Description:	删除角色
-- =============================================
CREATE PROCEDURE [dbo].[ProcRoleDelete]
	@r_id int
AS
BEGIN
	   Delete Role where r_id=@r_id
       select @@rowcount
END

GO
