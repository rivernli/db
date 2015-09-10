USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 16:19
-- Description:	/获取指定编号的分类
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormSelect]
@oid int
AS
BEGIN
     Select * from OneFormTable  where oid=@oid
END

GO
