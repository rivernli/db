USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcSystemSetSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:22
-- Description: 获取系统类
-- =============================================
CREATE PROCEDURE  [dbo].[ProcSystemSetSelect]

AS
BEGIN
	select * from SystemSet
END

GO
