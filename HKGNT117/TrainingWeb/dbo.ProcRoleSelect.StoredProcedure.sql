USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcRoleSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 15:15
-- Description:	获取指定编号的角色类
-- =============================================
CREATE PROCEDURE [dbo].[ProcRoleSelect]
	@r_id int
AS
BEGIN
	   Select * from Role where r_id=@r_id
END

GO
