USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcSuggestionSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-29 18:12
-- Description:	获取指定编号的建议
-- =============================================
create PROCEDURE [dbo].[ProcSuggestionSelect]
@id int

AS
BEGIN

Select * from SuggestionTable where [ID]=@id 

END

GO
