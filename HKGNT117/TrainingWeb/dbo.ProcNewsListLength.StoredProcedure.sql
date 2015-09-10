USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsListLength]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 18:12
-- Description:	获取分类的条数
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsListLength] 
	@oid int
AS
BEGIN
	Select count(*) from NewsTable where classid=@oid
END

GO
