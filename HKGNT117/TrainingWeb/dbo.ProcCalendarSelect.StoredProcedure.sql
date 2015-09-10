USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcCalendarSelect]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-28 14:12
-- Description:	获取指定编号的日历
-- =============================================
CREATE PROCEDURE [dbo].[ProcCalendarSelect]
	@id int
AS
BEGIN
	   Select * from CalendarTable where id=@id
END

GO
