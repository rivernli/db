USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcFormTypeGet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 20:00
-- Description:	获取所有的分类类型
-- =============================================
CREATE PROCEDURE  [dbo].[ProcFormTypeGet]

AS
BEGIN
	SELECT * FROM  FormTypeTable
END

GO
