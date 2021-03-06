USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormInsert]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 15:59
-- Description:	增加分类
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormInsert]
	@oname nvarchar(50) ,
	@fid int,
	@parentendid int,
	@isleaf nvarchar(50),
	@pic nvarchar(50),
	@saveurl nvarchar(50),
	@gotourl nvarchar(50),
	@template ntext,
	@bid int
AS
BEGIN
        INSERT INTO OneFormTable
                      (oname, fid, parentendid, isleaf, pic, saveurl, gotourl, template, bid)
           VALUES     (@oname,@fid,@parentendid,@isleaf,@pic,@saveurl,@gotourl,@template,@bid)   
        select @@rowcount
END

GO
