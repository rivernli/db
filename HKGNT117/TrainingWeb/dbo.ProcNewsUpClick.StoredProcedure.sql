USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcNewsUpClick]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2010-11-8 12:55
-- Description:	更新点击数
-- =============================================
CREATE PROCEDURE [dbo].[ProcNewsUpClick]
@id int,
@ClickNum int output

AS
BEGIN

	Update NewsTable set  [click]=[click]+1    where id=@id
	select @ClickNum=click from NewsTable  where id=@id

END

GO
