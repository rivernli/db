USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcRoleJudgmentName]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 15:16
-- Description:	获取该角色名是否已存在
-- =============================================
CREATE PROCEDURE [dbo].[ProcRoleJudgmentName]
@r_name nvarchar(50)
AS
BEGIN
	   select count(*) from Role where r_name=@r_name
END

GO
