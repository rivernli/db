USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-6 20:28
-- Description:	增加新闻
-- =============================================
CREATE PROCEDURE  [dbo].[ProcNewsInsert]

@ClassId int,
@img nvarchar(255),
@title nvarchar(255),
@content ntext,
@purview bit,
@user nvarchar(255),
@from nvarchar(255),
@flag bit,
@htmlurl nvarchar(50),
@htmls bit,
@ID int output
AS
BEGIN
	INSERT INTO NewsTable  ( bid,ClassId, img, title, [content],  purview, [user], [from], flag, htmlurl, htmls, click,pub_date)
    select isnull(max([bid]),0)+1,@ClassId,@img,@title,@content,@purview,@user,@from,@flag,@htmlurl,@htmls,0,getdate()From NewsTable
    select @@IDENTITY
       
    SET @ID= IDENT_CURRENT('NewsTable')  ---返回自动编号的id 



END

GO
