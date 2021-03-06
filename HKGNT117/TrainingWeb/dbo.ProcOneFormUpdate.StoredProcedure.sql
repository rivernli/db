USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormUpdate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 16:03
-- Description:	更新分类
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormUpdate]
	@oid int,
	@oname nvarchar(50) ,
	@fid int,
	@pic nvarchar(50),
	@saveurl nvarchar(50),
	@gotourl nvarchar(50),
	@template ntext
AS
BEGIN
        Update OneFormTable set  oname=@oname,fid=@fid,pic=@pic,saveurl=@saveurl,gotourl=@gotourl,template=@template  where oid=@oid   
        select @@rowcount
END

GO
