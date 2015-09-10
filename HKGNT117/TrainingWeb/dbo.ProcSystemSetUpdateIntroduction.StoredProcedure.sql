USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcSystemSetUpdateIntroduction]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-6-20 14:22
-- Description: 更新介绍
-- =============================================
CREATE PROCEDURE  [dbo].[ProcSystemSetUpdateIntroduction]
@Introduction nvarchar(max)
AS
BEGIN
	UPDATE    SystemSet SET 
	introduction = @Introduction
    
    select @@rowcount
END

GO
