USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcSuggestionGetSet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-29 16:35
-- Description:	分页，获取指开头行编和条数的建议列表
-- =============================================
create PROCEDURE [dbo].[ProcSuggestionGetSet]
@Pid int,
@num int

AS
BEGIN
    SELECT  TOP(@num) [ID], [Subject], [Viewed], [IP], [SubjectTime]
    FROM     SuggestionTable 
    where    ID<=(SELECT min(ID) FROM (SELECT Top(@Pid)ID FROM SuggestionTable order by ID desc)as   tblTmp)
    order by ID desc 
	
	
	  
	
END

GO
