USE [TrainingWeb]
GO
/****** Object:  StoredProcedure [dbo].[ProcCalendarUpdate]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张志阳
-- Create date: 2011-7-26 17:28
-- Description:	修改日历
-- =============================================
CREATE PROCEDURE  [dbo].[ProcCalendarUpdate]

@Title nvarchar(255),
@Start datetime,
@End datetime,
@ID int 
AS
BEGIN
	UPDATE    CalendarTable
	SET              Title = @Title, Start = @Start, [End] = @End
	WHERE     (ID = @ID)

    SET @ID= IDENT_CURRENT('CalendarTable')  ---返回自动编号的id 



END

GO
