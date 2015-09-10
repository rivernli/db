USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormReadSet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 16:15
-- Description:	获取指定参数的值
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormReadSet]
@oid int,
@cmdText varchar(255)
AS
BEGIN
     declare @SQLString nvarchar(200)
     declare @returnText nvarchar(255)

     set @SQLString = N'Select  ' + @cmdText  +N' from OneFormTable where oid=@oid'


     EXECUTE  sp_executesql @SQLString,N'@oid int',@oid
END

GO
