USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcPhotoInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-26 10:00
-- Description:	增加相片
-- =============================================
create PROCEDURE  [dbo].[ProcPhotoInsert]

 @nid int,
 @Title nvarchar(50),
 @Description nvarchar(500),
 @LargeImg nvarchar(100), 
 @SmartImg nvarchar(100),
 @ID int output
AS
BEGIN
	
	INSERT INTO PhotoTable(nid, Title, [Description], LargeImg, SmartImg)
    VALUES     (@nid,@Title,@Description,@LargeImg,@SmartImg)
	
       
    SET @ID= IDENT_CURRENT('PhotoTable')  ---返回自动编号的id 



END

GO
