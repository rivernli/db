USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcSuggestionInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-29 16:28
-- Description:	增加建议
-- =============================================
create PROCEDURE  [dbo].[ProcSuggestionInsert]

@Subject nvarchar(50),
@Description nvarchar(500),
@IP nvarchar(50),
@ID int output
AS
BEGIN
    INSERT INTO SuggestionTable
                      ([Subject], [Description], SubjectTime, Viewed, IP)
    VALUES     (@Subject,@Description,getdate(),0,@IP)


    select @@IDENTITY
       
    SET @ID= IDENT_CURRENT('SuggestionTable')  ---返回自动编号的id 



END

GO
