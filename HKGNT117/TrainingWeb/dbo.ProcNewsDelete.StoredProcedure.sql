USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 12:52
-- Description:	删除新闻
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsDelete]
@id int

AS
BEGIN
	Delete NewsTable where id=@id
	select @@rowcount
END

GO
