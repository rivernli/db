USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsGetId]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 19:17
-- Description:	通过排序数bid获取id
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsGetId]
	@bid int
AS
BEGIN
	Select id from NewsTable where bid=@bid
END

GO
