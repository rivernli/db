USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsUpNotAudit]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 19:22
-- Description:	取消审核
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsUpNotAudit]
	@id int
AS
BEGIN
	update NewsTable  set flag=0 where id=@id
	select @@rowcount
END

GO
