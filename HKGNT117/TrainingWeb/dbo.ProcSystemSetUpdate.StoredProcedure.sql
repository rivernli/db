USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcSystemSetUpdate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:22
-- Description: 更新系统类
-- =============================================
CREATE PROCEDURE  [dbo].[ProcSystemSetUpdate]
@Title ntext,
@Description ntext,
@Keywords ntext,
@VideoSize int,
@SourceSize int,
@PicSize int,
@NewsSet bit,
@ShoppingSet bit,
@LuyanSet bit,
@copyright ntext,
@myurl nvarchar
AS
BEGIN
	UPDATE    SystemSet SET 
	Title = @Title, Description = @Description, Keywords = @Keywords, VideoSize = @VideoSize, SourceSize = @SourceSize, PicSize = @PicSize, 
    NewsSet = @NewsSet, ShoppingSet = @ShoppingSet, LuyanSet = @LuyanSet, copyright = @copyright, myurl = @myurl
    
    select @@rowcount
END

GO
