USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormSortingEnd]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 17:00
-- Description:	置底
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormSortingEnd]
    @oid int ,
	@parentendid int
AS
BEGIN
    
           
--select top 1 bid   from  OneFormTable where  parentendid=" + parentendid + "  order by bid asc ";
       
    declare @getbid  int
	select  @getbid=bid   from OneFormTable  where  oid=@oid  and parentendid=@parentendid --得到选中分类的排序编号
 
    declare @prebid  int
    select top 1  @prebid=bid  from  OneFormTable where  parentendid=@parentendid  order by bid asc --得到最下面一个的排序编号
    
    IF @getbid=@prebid
    BEGIN
             select 0;--"温馨提示:已经是最下面了.
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
