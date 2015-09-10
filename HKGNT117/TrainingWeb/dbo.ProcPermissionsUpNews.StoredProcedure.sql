USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPermissionsUpNews]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:17
-- Description:	更新新闻类权限
-- =============================================
CREATE PROCEDURE [dbo].[ProcPermissionsUpNews]
@p_id int,
@p_add bit,
@p_up bit,
@p_del bit

AS
BEGIN
	update PermissionsTable set  [p_add]=@p_add,[p_up]=@p_up,[p_del]=@p_del  where p_id=@p_id
	
	select @@rowcount
END

GO
