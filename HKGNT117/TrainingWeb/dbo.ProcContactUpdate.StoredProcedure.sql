USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcContactUpdate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-9 21:06
-- Description:	更新联系我们
-- =============================================
CREATE PROCEDURE  [dbo].[ProcContactUpdate]
@Contact  ntext
AS
BEGIN
	update contact set  Contact=@Contact
	select @@rowcount
END

GO
