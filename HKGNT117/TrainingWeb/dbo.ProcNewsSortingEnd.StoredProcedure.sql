USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsSortingEnd]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 14:30
-- Description:	置底
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsSortingEnd]
	@id int ,
	@oid int
AS
BEGIN
    declare @getbid  int
	select  @getbid=bid   from NewsTable  where  id=@id  and ClassId=@oid --得到选中新闻的排序编号

    
    declare @prebid  int
    select top 1 @prebid=bid  from  NewsTable where  ClassId=@oid  order by bid asc --得到最下面一个的排序编号
    
    IF @getbid=@prebid
    BEGIN
             select 0;--温馨提示:已经是最下面了.
    END
    ELSE
    BEGIN
            --执行操作
            DECLARE	@return_value int
            
            EXEC	@return_value = ProcNewsSortingExeceut
            @prebid = @prebid,
            @getid = @id,
            @getbid = @getbid
            select  @return_value
    END      
END

GO
