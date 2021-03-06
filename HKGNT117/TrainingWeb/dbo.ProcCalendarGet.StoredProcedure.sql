USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcCalendarGet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-26 11:28
-- Description:	获取所有的日历
-- =============================================
CREATE PROCEDURE [dbo].[ProcCalendarGet]
AS
BEGIN
    SELECT     ID, Title, [Start], [End]
    FROM         CalendarTable  order by ID desc
END

GO
