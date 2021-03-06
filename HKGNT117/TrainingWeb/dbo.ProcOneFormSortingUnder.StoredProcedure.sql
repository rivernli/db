USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormSortingUnder]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 17:05
-- Description:	下移排序
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormSortingUnder]
    @oid int ,
	@parentendid int
AS
BEGIN

    declare @getbid  int
	select  @getbid=bid  from OneFormTable where  oid=@oid  and parentendid=@parentendid --得到选中分类的排序编号
    
    declare @prebid  int 
    set @prebid=0
    Select   top 1 @prebid=bid   from OneFormTable  where  bid<@getbid  and parentendid=@parentendid  order by bid desc  --/得到选中下一个的排序编号
    
    IF @prebid=0
    BEGIN
             select 0;--温馨提示:已经是最下面了.
    END
    ELSE
    BEGIN
            --执行操作
            DECLARE	@return_value int
            
            EXEC	@return_value = ProcOneFormSortingExeceut
            @prebid = @prebid,
            @getoid = @oid,
            @getbid = @getbid
            select  @return_value
    END        
END

GO
