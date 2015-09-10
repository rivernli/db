USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormGet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 16:19
-- Description:	得到所有分类
-- =============================================
CREATE   PROCEDURE [dbo].[ProcOneFormGet]

AS
BEGIN
     Select oid,oname, fid, parentendid, isleaf, pic, saveurl, gotourl, bid
     from OneFormTable order by bid desc
END

GO
