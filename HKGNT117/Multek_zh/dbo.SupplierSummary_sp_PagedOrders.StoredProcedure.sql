USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SupplierSummary_sp_PagedOrders]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[SupplierSummary_sp_PagedOrders]
( 
 @TableName varchar(50),        --表名
 @Fields varchar(5000) = '*',    --字段名(全部字段为*)
 @OrderField varchar(5000),        --排序字段(必须!支持多字段)
 @sqlWhere varchar(5000) = Null,--条件语句(不用加where)
 @pageSize int,                    --每页多少条记录
 @pageIndex int = 1 ,            --指定当前为第几页
 @totalRecord int output            --返回总页数 
) 
AS  
BEGIN         
Begin Tran --开始事务

    Declare @sql nvarchar(4000);  

    --计算总记录数
         
    if (@SqlWhere='' or @sqlWhere=NULL)
        set @sql = 'select @totalRecord = count(*) from ' + @TableName
    else
        set @sql = 'select @totalRecord = count(*) from ' + @TableName + ' where ' + @sqlWhere

    EXEC sp_executesql @sql,N'@totalRecord int OUTPUT',@totalRecord OUTPUT--计算总记录数        

    if (@SqlWhere='' or @sqlWhere=NULL)
        set @sql = 'Select * FROM (select ROW_NUMBER() Over(order by ' + @OrderField + ') as rowId,' + @Fields + ' from ' + @TableName 
    else
        set @sql = 'Select * FROM (select ROW_NUMBER() Over(order by ' + @OrderField + ') as rowId,' + @Fields + ' from ' + @TableName + ' where ' + @SqlWhere    
        


     --处理开始点和结束点
    Declare @StartRecord int
    Declare @EndRecord int    

	 set @StartRecord = (@pageIndex-1)*@PageSize + 1
    set @EndRecord = @StartRecord + @pageSize - 1

    --继续合成sql语句
    set @Sql = @Sql + ') as ' + @TableName + ' where rowId between ' + Convert(varchar(50),@StartRecord) + ' and ' +  Convert(varchar(50),@EndRecord)
    
    Exec(@Sql)
    ---------------------------------------------------
    If @@Error <> 0
      Begin
        RollBack Tran
        Return -1
      End
     Else
      Begin
        Commit Tran
        Return @totalRecord ---返回记录总数
      End    
end



GO
