USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitToTable]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[SplitToTable]
 (
     @SplitString nvarchar(max),
     @Separator nvarchar(10)=' '
 )
 RETURNS @SplitStringsTable TABLE
 (
 [id] int identity(1,1),
 [value] nvarchar(max)
 )
 AS
 BEGIN
     DECLARE @CurrentIndex int;
     DECLARE @NextIndex int;
     DECLARE @ReturnText nvarchar(max);
     SELECT @CurrentIndex=1;
     WHILE(@CurrentIndex<=len(@SplitString))
         BEGIN
             SELECT @NextIndex=charindex(@Separator,@SplitString,@CurrentIndex);
             IF(@NextIndex=0 OR @NextIndex IS NULL)
                 SELECT @NextIndex=len(@SplitString)+1;
                 SELECT @ReturnText=substring(@SplitString,@CurrentIndex,@NextIndex-@CurrentIndex);
                 INSERT INTO @SplitStringsTable([value]) VALUES(@ReturnText);
                 SELECT @CurrentIndex=@NextIndex+1;
             END
     RETURN;
 END 
GO
