USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcOneFormMaxbid]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 16:12
-- Description:	获取最大的排序数
-- =============================================
CREATE PROCEDURE [dbo].[ProcOneFormMaxbid]

AS
BEGIN
        select max(bid) from OneFormTable
END

GO
