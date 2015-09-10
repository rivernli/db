USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcSystemSetReadSet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:40
-- Description: 获取系统的设置参数
-- =============================================
CREATE PROCEDURE  [dbo].[ProcSystemSetReadSet]
@cmdText varchar(255)
AS
BEGIN
	declare @SQLString nvarchar(200)

    set @SQLString = N'Select  ' + @cmdText  +N' from  SystemSet'

    EXECUTE  sp_executesql @SQLString
END

GO
