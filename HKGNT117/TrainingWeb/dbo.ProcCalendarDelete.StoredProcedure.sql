USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcCalendarDelete]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-27 10:50
-- Description:	删除日历
-- =============================================
CREATE PROCEDURE [dbo].[ProcCalendarDelete]
@id int
AS
BEGIN

	Delete CalendarTable where id=@id
	select @@rowcount
END

GO
