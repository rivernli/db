USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsSortingExeceut]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 13:05
-- Description:	用于上移、下移、置顶和置底交换排序编号
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsSortingExeceut] 
	@prebid int ,
	@getid int,
	@getbid int
AS
BEGIN
	declare @preid int
	select @preid=id  from NewsTable  where  bid=@prebid  --得到选中下一个的新闻编号
	
	BEGIN TRANSACTION
    update NewsTable set bid=@prebid  where  id=@getid   --设置选中的排序编号为下一个的.
    update NewsTable set bid=@getbid  where  id=@preid --将下一个的排序编号设置成选中的
    IF @@ERROR<> 0
    BEGIN
           --温馨提示:交换失败
          ROLLBACK  TRANSACTION
          return 2
    END
    ELSE
    BEGIN
          --温馨提示:交换成功完成
          COMMIT TRANSACTION
          return 1
    END
END

GO
