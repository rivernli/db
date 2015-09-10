USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 18:12
-- Description:	获取指定编号的新闻
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsSelect]
@id int

AS
BEGIN

Select * from NewsTable where id=@id 

END

GO
