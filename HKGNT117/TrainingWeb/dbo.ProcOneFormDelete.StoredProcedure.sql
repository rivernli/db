USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 16:03
-- Description:	册除分类
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormDelete]
	@oid int
AS
BEGIN
        Delete OneFormTable where oid=@oid   
        select @@rowcount
END

GO
