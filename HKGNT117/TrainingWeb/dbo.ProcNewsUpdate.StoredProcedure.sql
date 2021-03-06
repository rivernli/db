USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsUpdate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 12:55
-- Description:	更新新闻
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsUpdate]
@id int,
@ClassId int,
@img nvarchar(255),
@title nvarchar(255),
@content ntext,
@purview bit,
@user nvarchar(255),
@from nvarchar(255)

AS
BEGIN

	Update NewsTable set  [ClassId]=@ClassId,[img]=@img,[title]=@title,[content]=@content,[purview]=@purview,[user]=@user,[from]=@from, [pub_date]=getdate()  where id=@id
	select @@rowcount
END

GO
