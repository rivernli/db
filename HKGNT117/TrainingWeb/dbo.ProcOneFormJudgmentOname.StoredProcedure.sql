USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormJudgmentOname]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 16:19
-- Description:	获取类别名称是否已存在
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormJudgmentOname]
@oname nvarchar(50)
AS
BEGIN
     Select count(*) from OneFormTable where oname=@oname
END

GO
