USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcRoleGet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 15:13
-- Description:	获取所有角色类
-- =============================================
CREATE PROCEDURE [dbo].[ProcRoleGet]

AS
BEGIN
	   Select * from Role 
END

GO
