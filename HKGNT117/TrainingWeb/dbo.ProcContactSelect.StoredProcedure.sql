USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcContactSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:08
-- Description:	获取联系我们
-- =============================================
CREATE PROCEDURE  [dbo].[ProcContactSelect]

AS
BEGIN
	Select * from contact
END

GO
