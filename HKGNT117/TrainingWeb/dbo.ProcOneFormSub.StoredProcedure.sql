USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormSub]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 16:33
-- Description:	得到分类所有子类
-- =============================================
CREATE  PROCEDURE [dbo].[ProcOneFormSub]
@oid int
AS
BEGIN
     Select oid,oname, fid, parentendid, isleaf, pic, saveurl, gotourl, bid
     from OneFormTable  where parentendid=@oid order by bid desc 
END

GO
