USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcAdminUploginNum]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:10
-- Description:	更新管理员登陆次数
-- =============================================
CREATE PROCEDURE [dbo].[ProcAdminUploginNum]
	@id int
AS
BEGIN
	update admin set logintimes=logintimes+1 where id=@id  
	select @@rowcount    
END

GO
