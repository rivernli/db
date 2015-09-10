USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPermissionsUpMan]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:20
-- Description:	更新管理类权限
-- =============================================
CREATE PROCEDURE [dbo].[ProcPermissionsUpMan]
@p_id int,
@p_Value bit
AS
BEGIN
	update PermissionsTable set  [p_Value]=@p_Value  where p_id=@p_id
	select @@rowcount
END

GO
