USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsReadSet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 18:02
-- Description:	获取指定新闻的指定参数
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsReadSet]
@id int,
@cmdText varchar(255)
AS
BEGIN

declare @SQLString nvarchar(200)
declare @returnText nvarchar(255)

set @SQLString = N'Select  ' + @cmdText  +N' from NewsTable where id=@id'


EXECUTE  sp_executesql @SQLString,N'@id int',@id

END

GO
